From: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: bypass RLC init under sriov for Tonga
Date: Mon, 10 Dec 2018 18:14:11 +0000
Message-ID: <61d18282-a793-9ede-7b38-5778722cf44e@amd.com>
References: <1544148709-7256-1-git-send-email-Tiecheng.Zhou@amd.com>
 <BN6PR12MB180903FE05AC850D8D4BFEC9F7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <18e5b0c7-1d33-a385-38c1-6a14663b9b60@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1138096839=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <18e5b0c7-1d33-a385-38c1-6a14663b9b60-5C7GfCeVMHo@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou, Tiecheng" <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1138096839==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_61d18282a7939ede7b385778722cf44eamdcom_"

--_000_61d18282a7939ede7b385778722cf44eamdcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Never mind, just saw the patch to fix the typo.

On 2018-12-10 1:07 p.m., Yang, Philip wrote:
I got this compilation error message after I rebase this morning, do I miss=
 anything?

/home/yangp/git/compute_staging/kernel/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.=
c: In function =91gfx_v8_0_rlc_resume=92:
/home/yangp/git/compute_staging/kernel/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.=
c:4071:6: error: implicit declaration of function =91amdgpu_sriov=92; did y=
ou mean =91amdgpu_sriov_vf=92? [-Werror=3Dimplicit-function-declaration]
  if (amdgpu_sriov(adev)) {
      ^~~~~~~~~~~~
      amdgpu_sriov_vf
cc1: some warnings being treated as errors
/home/yangp/git/compute_staging/kernel/scripts/Makefile.build:293: recipe f=
or target 'drivers/gpu/drm/amd/amdgpu/gfx_v8_0.o' failed
make[10]: *** [drivers/gpu/drm/amd/amdgpu/gfx_v8_0.o] Error 1

Philip

On 2018-12-07 10:33 a.m., Deucher, Alexander wrote:

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.deucher=
@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Tiecheng Zhou <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>=
<mailto:Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, December 6, 2018 9:11:49 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhou, Tiecheng
Subject: [PATCH] drm/amdgpu: bypass RLC init under sriov for Tonga

SWDEV-173384: vm-mix reboot (4 VMs) fail on Tonga under sriov

Phenomena: there is compute_1.3.1 ring test fail on one VM
           when it starts to do hw_init after it is rebooted

Root cause: RLC will go wrong in soft_reset under sriov

Workaround: init RLC csb, and skip RLC stop, reset, start
            this is because GIM has already done
            full initialization on RLC

refer to 'commit cfee05bc9057 ("drm/amdgpu:bypass RLC init for SRIOV")'
     and 'commit f840cc5f8447 ("drm/amdgpu/sriov:init csb for gfxv9")'

Signed-off-by: Tiecehng Zhou <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org><mailto:Tiecheng.Zhou@a=
md.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 1454fc3..a9c853a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4068,6 +4068,11 @@ static void gfx_v8_0_rlc_start(struct amdgpu_device =
*adev)

 static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)
 {
+       if (amdgpu_sriov(adev)) {
+               gfx_v8_0_init_csb(adev);
+               return 0;
+       }
+
         adev->gfx.rlc.funcs->stop(adev);
         adev->gfx.rlc.funcs->reset(adev);
         gfx_v8_0_init_pg(adev);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx





_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_61d18282a7939ede7b385778722cf44eamdcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <62ED1B4207829E4E92882284BA0D6B8F-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<div class=3D"moz-cite-prefix">Never mind, just saw the patch to fix the ty=
po.<br>
<br>
On 2018-12-10 1:07 p.m., Yang, Philip wrote:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:18e5b0c7-1d33-a385-38c1-6a14663b9b60@=
amd.com">
<div class=3D"moz-cite-prefix">I got this compilation error message after I=
 rebase this morning, do I miss anything?
<br>
<br>
/home/yangp/git/compute_staging/kernel/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.=
c: In function =91gfx_v8_0_rlc_resume=92:<br>
/home/yangp/git/compute_staging/kernel/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.=
c:4071:6: error: implicit declaration of function =91amdgpu_sriov=92; did y=
ou mean =91amdgpu_sriov_vf=92? [-Werror=3Dimplicit-function-declaration]<br=
>
&nbsp; if (amdgpu_sriov(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_vf<br>
cc1: some warnings being treated as errors<br>
/home/yangp/git/compute_staging/kernel/scripts/Makefile.build:293: recipe f=
or target 'drivers/gpu/drm/amd/amdgpu/gfx_v8_0.o' failed<br>
make[10]: *** [drivers/gpu/drm/amd/amdgpu/gfx_v8_0.o] Error 1<br>
<br>
Philip<br>
<br>
On 2018-12-07 10:33 a.m., Deucher, Alexander wrote:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:BN6PR12MB180903FE05AC850D8D4BFEC9F7AA=
0@BN6PR12MB1809.namprd12.prod.outlook.com">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher <a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" moz-do=
-not-send=3D"true">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org" moz-do-not-send=3D"true">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Tiecheng Zho=
u <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org" =
moz-do-not-send=3D"true">
&lt;Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Thursday, December 6, 2018 9:11:49 PM<br>
<b>To:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org" moz-do-not-send=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Zhou, Tiecheng<br>
<b>Subject:</b> [PATCH] drm/amdgpu: bypass RLC init under sriov for Tonga</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">SWDEV-173384: vm-mix reboot (4 VMs) fail on Tonga =
under sriov<br>
<br>
Phenomena: there is compute_1.3.1 ring test fail on one VM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; when it starts=
 to do hw_init after it is rebooted<br>
<br>
Root cause: RLC will go wrong in soft_reset under sriov<br>
<br>
Workaround: init RLC csb, and skip RLC stop, reset, start<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this is =
because GIM has already done<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; full ini=
tialization on RLC<br>
<br>
refer to 'commit cfee05bc9057 (&quot;drm/amdgpu:bypass RLC init for SRIOV&q=
uot;)'<br>
&nbsp;&nbsp;&nbsp;&nbsp; and 'commit f840cc5f8447 (&quot;drm/amdgpu/sriov:i=
nit csb for gfxv9&quot;)'<br>
<br>
Signed-off-by: Tiecehng Zhou <a class=3D"moz-txt-link-rfc2396E" href=3D"mai=
lto:Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org" moz-do-not-send=3D"true">
&lt;Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 &#43;&#43;&#43;&#43;&#43;<b=
r>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 1454fc3..a9c853a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -4068,6 &#43;4068,11 @@ static void gfx_v8_0_rlc_start(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v8_0_init_csb(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;stop(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;reset(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_init_pg(adev);<br=
>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org" moz-do-not-send=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-n=
ot-send=3D"true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>=
<br>
</div>
</span></font></div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
<pre class=3D"moz-quote-pre" wrap=3D"">____________________________________=
___________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org" moz-do-not-send=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx" moz-do-not-send=3D"true">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<br>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
<pre class=3D"moz-quote-pre" wrap=3D"">____________________________________=
___________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a>
</pre>
</blockquote>
<br>
</body>
</html>

--_000_61d18282a7939ede7b385778722cf44eamdcom_--

--===============1138096839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1138096839==--
