From: Aki Lemmetyinen <aki.lemmetyinen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/radeon: Add hotplug disconnected detection to
 radeon_dvi_detect
Date: Fri, 7 Jul 2017 19:28:28 +0300
Message-ID: <CAK+345KVUHc5q_RDWx-JS1W0XWB92HueQm=wTNH_RK1jwj7Jbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1821282565=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1821282565==
Content-Type: multipart/alternative; boundary="94eb2c0de47426ad100553bcb936"

--94eb2c0de47426ad100553bcb936
Content-Type: text/plain; charset="UTF-8"

I made a quick script for my HP Pavilion dv7 to automatically switch audio
to hdmi and back at hotplug event, when I noticed that the driver do not
react properly to plug/unplug. /sys/class/drm/card0-HDMI-A-1/status was
"connected" even after unplugging the cable.

After looking at the code it seemed that in case of cable disconnected
there is not point where hotplug state is polled.

Function radeon_connector_hotplug do not do much with hdmi and
radeon_hotplug_work_func cals drm_helper_hpd_irq_event which calls
radeon_dvi_detect where, in case of disconnected cable, it return with
connector_status_connected, just throwing an error for missing EDID.

It looks like there would maybe be a need for a bigger rewrite of hotplug
code, but just to get connector state working properly, I added these few
lines to radeon_connectors.c.

>From c7c97f746ce4402ae5857f63c640d691efdc5813 Mon Sep 17 00:00:00 2001
From: Aki Lemmetyinen <aki.lemmetyinen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Fri, 7 Jul 2017 17:32:21 +0300
Subject: [PATCH] drm/radeon: Add hotplug disconnected detection to
 radeon_dvi_detect

---
 drivers/gpu/drm/radeon/radeon_connectors.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c
b/drivers/gpu/drm/radeon/radeon_connectors.c
index 27affbd..c5a6635 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -1263,6 +1263,13 @@ radeon_dvi_detect(struct drm_connector *connector,
bool force)
         goto exit;
     }

+    if (rdev->family >= CHIP_R600 &&
+        connector->status == connector_status_connected &&
+        !radeon_check_hpd_status_unchanged(connector)) {
+        ret = connector_status_disconnected;
+        goto exit;
+    }
+
     if (radeon_connector->ddc_bus) {
         dret = radeon_ddc_probe(radeon_connector, false);

-- 
2.7.4

--94eb2c0de47426ad100553bcb936
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>I made a quick script for my HP Pavilion dv=
7 to automatically switch audio to hdmi and back at hotplug event, when I n=
oticed that the driver do not react properly to plug/unplug. /sys/class/drm=
/card0-HDMI-A-1/status was &quot;connected&quot; even after unplugging the =
cable. <br><br></div>After looking at the code it seemed that in case of ca=
ble disconnected there is not point where hotplug state is polled. <br><br>=
</div>Function radeon_connector_hotplug do not do much with hdmi and radeon=
_hotplug_work_func cals drm_helper_hpd_irq_event which calls radeon_dvi_det=
ect where, in case of disconnected cable, it return with connector_status_c=
onnected, just throwing an error for missing EDID. <br><br></div>It looks l=
ike there would maybe be a need for a bigger rewrite of hotplug code, but j=
ust to get connector state working properly, I added these few lines to rad=
eon_connectors.c.<br><br>From c7c97f746ce4402ae5857f63c640d691efdc5813 Mon =
Sep 17 00:00:00 2001<br>From: Aki Lemmetyinen &lt;<a href=3D"mailto:aki.lem=
metyinen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">aki.lemmetyinen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>Date: Fri, 7 Jul 2=
017 17:32:21 +0300<br>Subject: [PATCH] drm/radeon: Add hotplug disconnected=
 detection to<br>=C2=A0radeon_dvi_detect<br><br>---<br>=C2=A0drivers/gpu/dr=
m/radeon/radeon_connectors.c | 7 +++++++<br>=C2=A01 file changed, 7 inserti=
ons(+)<br><br>diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/dri=
vers/gpu/drm/radeon/radeon_connectors.c<br>index 27affbd..c5a6635 100644<br=
>--- a/drivers/gpu/drm/radeon/radeon_connectors.c<br>+++ b/drivers/gpu/drm/=
radeon/radeon_connectors.c<br>@@ -1263,6 +1263,13 @@ radeon_dvi_detect(stru=
ct drm_connector *connector, bool force)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 goto exit;<br>=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>+=C2=A0=
=C2=A0=C2=A0 if (rdev-&gt;family &gt;=3D CHIP_R600 &amp;&amp;<br>+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connector-&gt;status =3D=3D connector_sta=
tus_connected &amp;&amp;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !ra=
deon_check_hpd_status_unchanged(connector)) {<br>+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D connector_status_disconnected;<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;<br>+=C2=A0=C2=A0=C2=A0 }<br>+<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 if (radeon_connector-&gt;ddc_bus) {<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dret =3D radeon_ddc_probe(radeon_connect=
or, false);<br>=C2=A0<br>-- <br>2.7.4<br></div>

--94eb2c0de47426ad100553bcb936--

--===============1821282565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1821282565==--
