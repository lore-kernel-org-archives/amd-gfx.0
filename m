From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/doc: Add XGMI sysfs documentation
Date: Fri, 24 May 2019 14:53:58 +0000
Message-ID: <MWHPR12MB14220CD84D24757ABCB2D82DFE020@MWHPR12MB1422.namprd12.prod.outlook.com>
References: <20190524132326.7436-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0812945200=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190524132326.7436-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0812945200==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB14220CD84D24757ABCB2D82DFE020MWHPR12MB1422namp_"

--_000_MWHPR12MB14220CD84D24757ABCB2D82DFE020MWHPR12MB1422namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, May 24, 2019 9:23:49 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: [PATCH 1/2] drm/amd/doc: Add XGMI sysfs documentation

[CAUTION: External Email]

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 Documentation/gpu/amdgpu.rst             |  9 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index a740e491dfcc..cacfcfad2356 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -70,6 +70,15 @@ Interrupt Handling
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
    :internal:

+AMDGPU XGMI Support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+   :doc: AMDGPU XGMI Support
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+   :internal:
+
 GPU Power/Thermal Controls and Monitoring
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index e48e9394f1e4..d11eba09eadd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -40,6 +40,34 @@ void *amdgpu_xgmi_hive_try_lock(struct amdgpu_hive_info =
*hive)
        return &hive->device_list;
 }

+/**
+ * DOC: AMDGPU XGMI Support
+ *
+ * XGMI is a high speed interconnect that joins multiple GPU cards
+ * into a homogeneous memory space that is organized by a collective
+ * hive ID and individual node IDs, both of which are 64-bit numbers.
+ *
+ * The file xgmi_device_id contains the unique per GPU device ID and
+ * is stored in the /sys/class/drm/card${cardno}/device/ directory.
+ *
+ * Inside the device directory a sub-directory 'xgmi_hive_info' is
+ * created which contains the hive ID and the list of nodes.
+ *
+ * The hive ID is stored in:
+ *   /sys/class/drm/card${cardno}/device/xgmi_hive_info/xgmi_hive_id
+ *
+ * The node information is stored in numbered directories:
+ *   /sys/class/drm/card${cardno}/device/xgmi_hive_info/node${nodeno}/xgmi=
_device_id
+ *
+ * Each device has their own xgmi_hive_info direction with a mirror
+ * set of node sub-directories.
+ *
+ * The XGMI memory space is built by contiguously adding the power of
+ * two padded VRAM space from each node to each other.
+ *
+ */
+
+
 static ssize_t amdgpu_xgmi_show_hive_id(struct device *dev,
                struct device_attribute *attr, char *buf)
 {
--
2.21.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MWHPR12MB14220CD84D24757ABCB2D82DFE020MWHPR12MB1422namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 16px;">Acked-by: Slava Abramov =
&lt;slava.abramov-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDenis@=
amd.com&gt;<br>
<b>Sent:</b> Friday, May 24, 2019 9:23:49 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/doc: Add XGMI sysfs documentation</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[CAUTION: External Email]<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;Documentation/gpu/amdgpu.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 &#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 37 insertions(&#43;)<br>
<br>
diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst<br=
>
index a740e491dfcc..cacfcfad2356 100644<br>
--- a/Documentation/gpu/amdgpu.rst<br>
&#43;&#43;&#43; b/Documentation/gpu/amdgpu.rst<br>
@@ -70,6 &#43;70,15 @@ Interrupt Handling<br>
&nbsp;.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&nbsp;&nbsp;&nbsp; :internal:<br>
<br>
&#43;AMDGPU XGMI Support<br>
&#43;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&#43;<br>
&#43;.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&nbsp;&nbsp; :doc: AMDGPU XGMI Support<br>
&#43;<br>
&#43;.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&nbsp;&nbsp; :internal:<br>
&#43;<br>
&nbsp;GPU Power/Thermal Controls and Monitoring<br>
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index e48e9394f1e4..d11eba09eadd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -40,6 &#43;40,34 @@ void *amdgpu_xgmi_hive_try_lock(struct amdgpu_hive_i=
nfo *hive)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;hive-&gt;device_list=
;<br>
&nbsp;}<br>
<br>
&#43;/**<br>
&#43; * DOC: AMDGPU XGMI Support<br>
&#43; *<br>
&#43; * XGMI is a high speed interconnect that joins multiple GPU cards<br>
&#43; * into a homogeneous memory space that is organized by a collective<b=
r>
&#43; * hive ID and individual node IDs, both of which are 64-bit numbers.<=
br>
&#43; *<br>
&#43; * The file xgmi_device_id contains the unique per GPU device ID and<b=
r>
&#43; * is stored in the /sys/class/drm/card${cardno}/device/ directory.<br=
>
&#43; *<br>
&#43; * Inside the device directory a sub-directory 'xgmi_hive_info' is<br>
&#43; * created which contains the hive ID and the list of nodes.<br>
&#43; *<br>
&#43; * The hive ID is stored in:<br>
&#43; *&nbsp;&nbsp; /sys/class/drm/card${cardno}/device/xgmi_hive_info/xgmi=
_hive_id<br>
&#43; *<br>
&#43; * The node information is stored in numbered directories:<br>
&#43; *&nbsp;&nbsp; /sys/class/drm/card${cardno}/device/xgmi_hive_info/node=
${nodeno}/xgmi_device_id<br>
&#43; *<br>
&#43; * Each device has their own xgmi_hive_info direction with a mirror<br=
>
&#43; * set of node sub-directories.<br>
&#43; *<br>
&#43; * The XGMI memory space is built by contiguously adding the power of<=
br>
&#43; * two padded VRAM space from each node to each other.<br>
&#43; *<br>
&#43; */<br>
&#43;<br>
&#43;<br>
&nbsp;static ssize_t amdgpu_xgmi_show_hive_id(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<br>
&nbsp;{<br>
--<br>
2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MWHPR12MB14220CD84D24757ABCB2D82DFE020MWHPR12MB1422namp_--

--===============0812945200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0812945200==--
