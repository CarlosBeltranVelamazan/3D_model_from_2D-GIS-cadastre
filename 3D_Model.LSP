(vl-load-com)

(defun sel_layers ()		;Creates a list with the name of all the layers
  (vlax-for layers (vla-get-Layers (vla-get-ActiveDocument (vlax-get-acad-object)))		
    (setq layerlist (cons (list (vla-get-name layers))layerlist)))						
  (setq longlist (length layerlist))
)

(defun extrusion ()		;Extrudes the polylines according to its layer height
  (setq counter 0)
  (setq selst ())
  (while (< counter longlist)
   	 (setq layer_a (car(car layerlist)))
         (setq selst (ssget "_x"(list '(0 . "LWPOLYLINE") (cons 8 layer_a))))   
   	 (setq layerlist (cdr layerlist))   
     	 (setq counter (+ counter 1))
    	 (if (/= layer_a "0")
         	(command "_EXTRUDE" selst "" layer_a)
	 )
  (setq selst nil)
  )
)


(defun c:3D_Model ()		;Main function
  (setq layerlist ())
  (setq longlist ())
  (sel_layers)
  (extrusion)
  (Alert (strcat "The 3D Model has been completed"))
)

