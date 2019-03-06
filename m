From: William Lewis <minutemaidpark-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: fix a compiling error when CONFIG_HSA_AMD
 disalbed
Date: Wed, 6 Mar 2019 16:34:54 +0000
Message-ID: <MWHPR17MB0943D3796778E3FEC71B3CE7C8730@MWHPR17MB0943.namprd17.prod.outlook.com>
References: <1551887958-3657-1-git-send-email-JinhuiEric.Huang@amd.com>
 <BN6PR12MB18092777ADEAC0257140E23DF7730@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0423264607=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18092777ADEAC0257140E23DF7730-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0423264607==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR17MB0943D3796778E3FEC71B3CE7C8730MWHPR17MB0943namp_"

--_000_MWHPR17MB0943D3796778E3FEC71B3CE7C8730MWHPR17MB0943namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Typo in patch description:  s/disalbed/disabled/


On 3/6/19 10:11 AM, Deucher, Alexander wrote:
Add a line like:

Fixes: 9032ea09e2d2ef ("drm/amdkfd: add RAS ECC event support")

With that added:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.deuc=
her-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Huang, JinHuiEric <JinHuiEric.Huang@a=
md.com><mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, March 6, 2019 10:59 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Huang, JinHuiEric
Subject: [PATCH] drm/amdkfd: fix a compiling error when CONFIG_HSA_AMD disa=
lbed

It fixes a commpiling error on commit
9032ea09e2d2ef0d10e5cd793713bf2eb21643c5
drm/amdkfd: add RAS ECC event support

Change-Id: I8792767726e28eed3a3fcf9072f608701be13c79
Signed-off-by: Eric Huang <JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org><mailto:JinhuiEric.Huan=
g@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index fe1d736..acf8ae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -640,4 +640,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 {
 }
+
+void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
+{
+}
 #endif
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam02.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7C%7C2cf93d5576b848c6d66708d6a24e5=
eb2%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C636874854807263322&sdata=
=3DAV62VQT1o%2F6gVK1eHdzGT4vmCEJveX6C26npgyRgZtY%3D&reserved=3D0>



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://nam02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7C%7C2cf93=
d5576b848c6d66708d6a24e5eb2%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C63=
6874854807293349&amp;sdata=3D7nutYNQv0XODz%2BUzQTTbIrahZI%2B6%2BG9cETOEkBnU=
AU4%3D&amp;reserved=3D0

--_000_MWHPR17MB0943D3796778E3FEC71B3CE7C8730MWHPR17MB0943namp_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <1CE3F2366298F442A5B7ACE9E6CA89FD-D2/8MP7PhqWcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body bgcolor=3D"#FFFFFF" text=3D"#000000">
<p>Typo in patch description:&nbsp; s/disalbed/disabled/<br>
</p>
<p><br>
</p>
<div class=3D"moz-cite-prefix">On 3/6/19 10:11 AM, Deucher, Alexander wrote=
:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:BN6PR12MB18092777ADEAC0257140E23DF773=
0@BN6PR12MB1809.namprd12.prod.outlook.com">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
Add a line like:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
Fixes: <font size=3D"2"><span style=3D"font-size:11pt">9032ea09e2d2ef</span=
></font> <font size=3D"2">
(<span style=3D"font-size:11pt">&quot;drm/amdkfd: add RAS ECC event support=
</span></font>&quot;)</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
With that added:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto=
:alexander.deucher-5C7GfCeVMHo@public.gmane.org">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Huang, JinHu=
iEric <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:JinHuiEric.Huang@am=
d.com">
&lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Wednesday, March 6, 2019 10:59 AM<br>
<b>To:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Huang, JinHuiEric<br>
<b>Subject:</b> [PATCH] drm/amdkfd: fix a compiling error when CONFIG_HSA_A=
MD disalbed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It fixes a commpiling error on commit<br>
9032ea09e2d2ef0d10e5cd793713bf2eb21643c5<br>
drm/amdkfd: add RAS ECC event support<br>
<br>
Change-Id: I8792767726e28eed3a3fcf9072f608701be13c79<br>
Signed-off-by: Eric Huang <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto=
:JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org">
&lt;JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 &#43;&#43;&#43;&#43;<b=
r>
&nbsp;1 file changed, 4 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index fe1d736..acf8ae0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -640,4 &#43;640,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)<br>
&nbsp;void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry=
)<br>
&nbsp;{<br>
&nbsp;}<br>
&#43;<br>
&#43;void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)<br>
&#43;{<br>
&#43;}<br>
&nbsp;#endif<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://nam02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7C%7C2cf93d5576b848c6d66708d6a24e5eb2%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7=
C1%7C0%7C636874854807263322&amp;sdata=3DAV62VQT1o%2F6gVK1eHdzGT4vmCEJveX6C2=
6npgyRgZtY%3D&amp;reserved=3D0" originalsrc=3D"https://lists.freedesktop.or=
g/mailman/listinfo/amd-gfx" shash=3D"wJ7Jx6w2ducSGOBwKsXyGKjFfSvEUMlArajXY4=
z3oxN43BS6sc85sBXhf5ystW7OmVSYn/MhseAKCCxTVigTYSqIKZEgJc3LPytTH987QTPIuwF3z=
i2j7o&#43;ZVFbRdnKzLHJKiN6ENrjUsFBwgw2HC3JM3NdOrxX&#43;C5xpKxKpMnk=3D" moz-=
do-not-send=3D"true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
</a></div>
</span></font></div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
<pre class=3D"moz-quote-pre" wrap=3D"">____________________________________=
___________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://nam02.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flisti=
nfo%2Famd-gfx&amp;amp;data=3D02%7C01%7C%7C2cf93d5576b848c6d66708d6a24e5eb2%=
7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C636874854807293349&amp;amp;sda=
ta=3D7nutYNQv0XODz%2BUzQTTbIrahZI%2B6%2BG9cETOEkBnUAU4%3D&amp;amp;reserved=
=3D0">https://nam02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%=
7C%7C2cf93d5576b848c6d66708d6a24e5eb2%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C=
1%7C0%7C636874854807293349&amp;amp;sdata=3D7nutYNQv0XODz%2BUzQTTbIrahZI%2B6=
%2BG9cETOEkBnUAU4%3D&amp;amp;reserved=3D0</a></pre>
</blockquote>
</body>
</html>

--_000_MWHPR17MB0943D3796778E3FEC71B3CE7C8730MWHPR17MB0943namp_--

--===============0423264607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0423264607==--
