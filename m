From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add missing extern "C" headers
Date: Mon, 15 May 2017 01:06:46 +0000
Message-ID: <MWHPR1201MB0045EF5693B74C28F9021B36F2E10@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <mailman.39.1494763203.10449.amd-gfx@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0573504181=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <mailman.39.1494763203.10449.amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Haehnle,
 Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>

--===============0573504181==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0045EF5693B74C28F9021B36F2E10MWHPR1201MB0045_"

--_000_MWHPR1201MB0045EF5693B74C28F9021B36F2E10MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 amdgpu/amdgpu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index fdea905..1901fa8 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -30,20 +30,24 @@
  * User wanted to use libdrm_amdgpu functionality must include
  * this file.
  *
  */
 #ifndef _AMDGPU_H_
 #define _AMDGPU_H_

 #include <stdint.h>
 #include <stdbool.h>

+#ifdef __cplusplus
+extern "C" {
+#endif
+
 struct drm_amdgpu_info_hw_ip;

 /*------------------------------------------------------------------------=
--*/
 /* --------------------------- Defines -----------------------------------=
- */
 /*------------------------------------------------------------------------=
--*/

 /**
  * Define max. number of Command Buffers (IB) which could be sent to the s=
ingle
  * hardware IP to accommodate CE/DE requirements
  *
@@ -1317,11 +1321,15 @@ int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_ha=
ndle sem);
 /**
  *  Get the ASIC marketing name
  *
  * \param   dev         - \c [in] Device handle. See #amdgpu_device_initia=
lize()
  *
  * \return  the constant string of the marketing name
  *          "NULL" means the ASIC is not found
 */
 const char *amdgpu_get_marketing_name(amdgpu_device_handle dev);

+#ifdef __cplusplus
+}
+#endif
+
 #endif /* #ifdef _AMDGPU_H_ */
--
2.9.3


Reviewed by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>



--_000_MWHPR1201MB0045EF5693B74C28F9021B36F2E10MWHPR1201MB0045_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p><font size=3D"2"><span style=3D"font-size:10pt;">&nbsp;amdgpu/amdgpu.h |=
 8 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 8 insertions(&#43;)<br>
<br>
diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h<br>
index fdea905..1901fa8 100644<br>
--- a/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/amdgpu/amdgpu.h<br>
@@ -30,20 &#43;30,24 @@<br>
&nbsp; * User wanted to use libdrm_amdgpu functionality must include<br>
&nbsp; * this file.<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#ifndef _AMDGPU_H_<br>
&nbsp;#define _AMDGPU_H_<br>
&nbsp;<br>
&nbsp;#include &lt;stdint.h&gt;<br>
&nbsp;#include &lt;stdbool.h&gt;<br>
&nbsp;<br>
&#43;#ifdef __cplusplus<br>
&#43;extern &quot;C&quot; {<br>
&#43;#endif<br>
&#43;<br>
&nbsp;struct drm_amdgpu_info_hw_ip;<br>
&nbsp;<br>
&nbsp;/*-------------------------------------------------------------------=
-------*/<br>
&nbsp;/* --------------------------- Defines ------------------------------=
------ */<br>
&nbsp;/*-------------------------------------------------------------------=
-------*/<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * Define max. number of Command Buffers (IB) which could be sent to =
the single<br>
&nbsp; * hardware IP to accommodate CE/DE requirements<br>
&nbsp; *<br>
@@ -1317,11 &#43;1321,15 @@ int amdgpu_cs_destroy_semaphore(amdgpu_semaphor=
e_handle sem);<br>
&nbsp;/**<br>
&nbsp; *&nbsp; Get the ASIC marketing name<br>
&nbsp; *<br>
&nbsp; * \param&nbsp;&nbsp; dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; - \c [in] Device handle. See #amdgpu_device_initialize()<br>
&nbsp; *<br>
&nbsp; * \return&nbsp; the constant string of the marketing name<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;NULL&q=
uot; means the ASIC is not found<br>
&nbsp;*/<br>
&nbsp;const char *amdgpu_get_marketing_name(amdgpu_device_handle dev);<br>
&nbsp;<br>
&#43;#ifdef __cplusplus<br>
&#43;}<br>
&#43;#endif<br>
&#43;<br>
&nbsp;#endif /* #ifdef _AMDGPU_H_ */<br>
-- <br>
2.9.3</span></font></p>
<div style=3D"color: rgb(0, 0, 0);"><font size=3D"2"><span style=3D"font-si=
ze:10pt;">
<div class=3D"PlainText"><br>
<br>
<span>Reviewed by: Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR1201MB0045EF5693B74C28F9021B36F2E10MWHPR1201MB0045_--

--===============0573504181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0573504181==--
