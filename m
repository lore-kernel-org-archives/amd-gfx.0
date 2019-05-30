From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/doc: add rough outline of tracepoint documentation
Date: Thu, 30 May 2019 15:45:33 +0000
Message-ID: <MWHPR12MB1422F8CD20776EFC9B4C8288FE180@MWHPR12MB1422.namprd12.prod.outlook.com>
References: <20190530145600.12241-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0523682061=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190530145600.12241-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

--===============0523682061==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1422F8CD20776EFC9B4C8288FE180MWHPR12MB1422namp_"

--_000_MWHPR12MB1422F8CD20776EFC9B4C8288FE180MWHPR12MB1422namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Comments inline (marked with [slava a]).


General comment - word capitalisation in the lists is inconsistent


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, May 30, 2019 10:56 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: [PATCH] drm/amd/doc: add rough outline of tracepoint documentation

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 Documentation/gpu/amdgpu.rst              |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 221 ++++++++++++++++++++++
 2 files changed, 231 insertions(+)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 86138798128f..3564765110e5 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -89,6 +89,16 @@ AMDGPU RAS debugfs control interface
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
    :internal:

+AMDGPU Tracing Support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+   :doc: AMDGPU Tracing Support
+
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+   :internal:
+

 GPU Power/Thermal Controls and Monitoring
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_trace.h
index d3ca2424b5fe..71febb90d3e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -37,6 +37,227 @@
 #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
          job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_f=
ence->finished)

+/**
+ * DOC: AMDGPU Tracing Support
+ *
+ * The AMDGPU driver provides numerous trace points that can aid
+ * in debugging.  They are globally enabled by the file:
+ *
+ * /sys/kernel/debug/tracing/events/amdgpu/enable
+ *
+ * or individually by the enable files in the sub-directories
+ * of that directory.
+ *
+ * amdgpu_mm_rreg, amdgpu_mm_wreg
+ * ------------------------------
+ *
+ * These trace points track reads and writes to MMIO registers by
+ * the kernel driver (activity inside ring/indirect buffers are not
+ * traced) which can be used to diagnose IP block activity and
+ * responses.

[slava a] Either 'activities are not traced' or 'activity is not traced'
[slava a] Double usage of word 'activity' sounds weird.

[snap]

--_000_MWHPR12MB1422F8CD20776EFC9B4C8288FE180MWHPR12MB1422namp_
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
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Comments inline (marked with [sla=
va a]).</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">General comment - word capitalisa=
tion in the lists is inconsistent</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDenis@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, May 30, 2019 10:56 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH] drm/amd/doc: add rough outline of tracepoint docume=
ntation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Tom St Denis &lt;tom.stdenis-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
---<br>
&nbsp;Documentation/gpu/amdgpu.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 10 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 221 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;<br>
&nbsp;2 files changed, 231 insertions(&#43;)<br>
<br>
diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst<br=
>
index 86138798128f..3564765110e5 100644<br>
--- a/Documentation/gpu/amdgpu.rst<br>
&#43;&#43;&#43; b/Documentation/gpu/amdgpu.rst<br>
@@ -89,6 &#43;89,16 @@ AMDGPU RAS debugfs control interface<br>
&nbsp;.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&nbsp;&nbsp;&nbsp; :internal:<br>
&nbsp;<br>
&#43;AMDGPU Tracing Support<br>
&#43;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&#43;<br>
&#43;.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&#43;&nbsp;&nbsp; :doc: AMDGPU Tracing Support<br>
&#43;<br>
&#43;<br>
&#43;.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&#43;&nbsp;&nbsp; :internal:<br>
&#43;<br>
&nbsp;<br>
&nbsp;GPU Power/Thermal Controls and Monitoring<br>
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_trace.h<br>
index d3ca2424b5fe..71febb90d3e3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
@@ -37,6 &#43;37,227 @@<br>
&nbsp;#define AMDGPU_JOB_GET_TIMELINE_NAME(job) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;base.s_fence=
-&gt;finished.ops-&gt;get_timeline_name(&amp;job-&gt;base.s_fence-&gt;finis=
hed)<br>
&nbsp;<br>
&#43;/**<br>
&#43; * DOC: AMDGPU Tracing Support<br>
&#43; *<br>
&#43; * The AMDGPU driver provides numerous trace points that can aid<br>
&#43; * in debugging.&nbsp; They are globally enabled by the file:<br>
&#43; *<br>
&#43; * /sys/kernel/debug/tracing/events/amdgpu/enable<br>
&#43; *<br>
&#43; * or individually by the enable files in the sub-directories<br>
&#43; * of that directory.<br>
&#43; *<br>
&#43; * amdgpu_mm_rreg, amdgpu_mm_wreg<br>
&#43; * ------------------------------<br>
&#43; *<br>
&#43; * These trace points track reads and writes to MMIO registers by</div=
>
<div class=3D"PlainText"><span style=3D"font-size: 11pt;">&#43; * the kerne=
l driver (activity inside ring/indirect buffers are not</span><br>
</div>
<div class=3D"PlainText"><span style=3D"font-size: 11pt;">&#43; * traced) w=
hich can be used to diagnose IP block activity and</span><br>
</div>
<div class=3D"PlainText">&#43; * responses.</div>
<div class=3D"PlainText">
<div class=3D"PlainText" style=3D"font-family: Calibri, Helvetica, sans-ser=
if, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, N=
otoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, Emoj=
iSymbols; font-size: 14.6667px;">
<br class=3D"Apple-interchange-newline">
[slava a] Either 'activities are not traced' or 'activity is not traced'</d=
iv>
<div class=3D"PlainText" style=3D"font-family: Calibri, Helvetica, sans-ser=
if, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, N=
otoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, Emoj=
iSymbols; font-size: 14.6667px;">
<span style=3D"font-size: 11pt;">[slava a] Double usage of word 'activity' =
sounds weird.&nbsp;&nbsp;</span></div>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[snap]</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MWHPR12MB1422F8CD20776EFC9B4C8288FE180MWHPR12MB1422namp_--

--===============0523682061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0523682061==--
