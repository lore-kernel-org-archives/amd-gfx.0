From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix frame size of amdgpu_xgmi_add_devices
 excceed 1024 bytes
Date: Wed, 7 Nov 2018 03:51:04 +0000
Message-ID: <CY4PR12MB1639EBB0B71AE8BDC8A8B46089C40@CY4PR12MB1639.namprd12.prod.outlook.com>
References: <1541561360-6230-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1051836498=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1541561360-6230-1-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1051836498==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1639EBB0B71AE8BDC8A8B46089C40CY4PR12MB1639namp_"

--_000_CY4PR12MB1639EBB0B71AE8BDC8A8B46089C40CY4PR12MB1639namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Would be better to add a is-null check for 'tmp_topology' after kzalloc(). =
With that fixed, patch is

Reviewed-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>


Regards,

Xiaojie

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Hawking =
Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 7, 2018 11:29 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhang, Hawking
Subject: [PATCH] drm/amdgpu: fix frame size of amdgpu_xgmi_add_devices excc=
eed 1024 bytes

Instead of stack-allocated psp_xgmi_topology_info in function
amdgpu_xgmi_add_device, dynamically allocated this structure to
avoid the frame size of this function excceed 1024 bytes.

Signed-off-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index e92b454..1c0ed13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -63,7 +63,7 @@ static struct amdgpu_hive_info *amdgpu_get_xgmi_hive(stru=
ct amdgpu_device *adev)

 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 {
-       struct psp_xgmi_topology_info tmp_topology;
+       struct psp_xgmi_topology_info *tmp_topology;
         struct amdgpu_hive_info *hive;
         struct amdgpu_xgmi      *entry;
         struct amdgpu_device     *tmp_adev;
@@ -76,7 +76,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
         adev->gmc.xgmi.node_id =3D psp_xgmi_get_node_id(&adev->psp);
         adev->gmc.xgmi.hive_id =3D psp_xgmi_get_hive_id(&adev->psp);

-       memset(&tmp_topology, 0, sizeof(tmp_topology));
+       tmp_topology =3D kzalloc(sizeof(struct psp_xgmi_topology_info), GFP=
_KERNEL);
         mutex_lock(&xgmi_mutex);
         hive =3D amdgpu_get_xgmi_hive(adev);
         if (!hive)
@@ -84,9 +84,9 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)

         list_add_tail(&adev->gmc.xgmi.head, &hive->device_list);
         list_for_each_entry(entry, &hive->device_list, head)
-               tmp_topology.nodes[count++].node_id =3D entry->node_id;
+               tmp_topology->nodes[count++].node_id =3D entry->node_id;

-       ret =3D psp_xgmi_get_topology_info(&adev->psp, count, &tmp_topology=
);
+       ret =3D psp_xgmi_get_topology_info(&adev->psp, count, tmp_topology)=
;
         if (ret) {
                 dev_err(adev->dev,
                         "XGMI: Get topology failure on device %llx, hive %=
llx, ret %d",
@@ -96,7 +96,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
         }
         /* Each psp need to set the latest topology */
         list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
-               ret =3D psp_xgmi_set_topology_info(&tmp_adev->psp, count, &=
tmp_topology);
+               ret =3D psp_xgmi_set_topology_info(&tmp_adev->psp, count, t=
mp_topology);
                 if (ret) {
                         dev_err(tmp_adev->dev,
                                 "XGMI: Set topology failure on device %llx=
, hive %llx, ret %d",
@@ -113,5 +113,6 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)

 exit:
         mutex_unlock(&xgmi_mutex);
+       kfree(tmp_topology);
         return ret;
 }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1639EBB0B71AE8BDC8A8B46089C40CY4PR12MB1639namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Would be better to add a is-null =
check for 'tmp_topology' after kzalloc(). With that fixed, patch is</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Xiaojie Yuan &lt;xia=
ojie.yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Xiaojie<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Hawking Zhang &lt;Hawking.Z=
hang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, November 7, 2018 11:29 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhang, Hawking<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix frame size of amdgpu_xgmi_add_devic=
es excceed 1024 bytes</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Instead of stack-allocated psp_xgmi_topology_info =
in function<br>
amdgpu_xgmi_add_device, dynamically allocated this structure to<br>
avoid the frame size of this function excceed 1024 bytes.<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 11 &#43;&#43;&#43;&#43;&#4=
3;&#43;-----<br>
&nbsp;1 file changed, 6 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index e92b454..1c0ed13 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -63,7 &#43;63,7 @@ static struct amdgpu_hive_info *amdgpu_get_xgmi_hive(=
struct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;int amdgpu_xgmi_add_device(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_topology_info tmp_top=
ology;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_topology_info *tm=
p_topology;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *h=
ive;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_xgmi&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *entry;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device&nbsp;=
&nbsp;&nbsp;&nbsp; *tmp_adev;<br>
@@ -76,7 &#43;76,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.node_id =
=3D psp_xgmi_get_node_id(&amp;adev-&gt;psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.hive_id =
=3D psp_xgmi_get_hive_id(&amp;adev-&gt;psp);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;tmp_topology, 0, sizeof(t=
mp_topology));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_topology =3D kzalloc(sizeof(s=
truct psp_xgmi_topology_info), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;xgmi_mutex=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D amdgpu_get_xgmi_h=
ive(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive)<br>
@@ -84,9 &#43;84,9 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;adev-&g=
t;gmc.xgmi.head, &amp;hive-&gt;device_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(entry,=
 &amp;hive-&gt;device_list, head)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp_topology.nodes[count&#43;&#43;].node_id =3D entry-&gt;node_i=
d;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp_topology-&gt;nodes[count&#43;&#43;].node_id =3D entry-&g=
t;node_id;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_get_topology_info(&a=
mp;adev-&gt;psp, count, &amp;tmp_topology);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_get_topology_inf=
o(&amp;adev-&gt;psp, count, tmp_topology);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;XGMI: Get topology failure on device %llx, hive %llx, ret %d&quot;,<br>
@@ -96,7 &#43;96,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Each psp need to set th=
e latest topology */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, &amp;hive-&gt;device_list, gmc.xgmi.head) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_xgmi_set_topology_info(&amp;tmp_adev-&gt;psp, count,=
 &amp;tmp_topology);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D psp_xgmi_set_topology_info(&amp;tmp_adev-&gt;psp, co=
unt, tmp_topology);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(tmp_adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XGMI: Set topology failure=
 on device %llx, hive %llx, ret %d&quot;,<br>
@@ -113,5 &#43;113,6 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *ad=
ev)<br>
&nbsp;<br>
&nbsp;exit:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;xgmi_mut=
ex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(tmp_topology);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk690877" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1639EBB0B71AE8BDC8A8B46089C40CY4PR12MB1639namp_--

--===============1051836498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1051836498==--
