From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix a bug that vm size is wrong on Raven
Date: Mon, 18 Dec 2017 17:00:57 +0000
Message-ID: <MWHPR12MB143800E804732F641083D673F00E0@MWHPR12MB1438.namprd12.prod.outlook.com>
References: <1513269904-3385-1-git-send-email-yong.zhao@amd.com>
 <9ebd38b5-2b12-8797-65e5-3a920ce697aa@gmail.com>,
 <e3d20771-df70-b9e5-345b-9914c54db292@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0163584890=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e3d20771-df70-b9e5-345b-9914c54db292-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?iso-8859-1?Q?Felix_K=FChling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0163584890==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB143800E804732F641083D673F00E0MWHPR12MB1438namp_"

--_000_MWHPR12MB143800E804732F641083D673F00E0MWHPR12MB1438namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Felix,


we ended up with this fix. http://git.amd.com:8080/#/c/122202/


I explored the option to override the VM size only for KFD VMs, but it was =
not easy as amdgpu_check_vm_size() and amdgpu_vm_adjust_size() come in duri=
ng loading amdgpu, i. e. before KFD VMs are created. So to fix the problem =
quickly, we ended up to not overwrite the VM size for all Raven VMs.


Regards,

Yong

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, December 18, 2017 4:22:43 AM
To: Felix K=FChling; Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Fix a bug that vm size is wrong on Raven

The problem was a merge conflict.

No idea what exactly went wrong, but Yong ended up with a branch where the =
vm_size was always overwritten with the value 64.

So we can completely drop this patch and yes when an user overrides the vm_=
size value he/she should know what the consequences are.

Regards,
Christian.

Am 17.12.2017 um 00:21 schrieb Felix K=FChling:

Is there a way to override the VM size for KFD VMs only? Only they
depend on ATS, so only they need to be forced to be 48-bits.

On the other hand, it could be argued that a user who manually sets the
VM size with a module parameter knows what they're doing. So let them
break ATS.

Regards,
  Felix


Am 14.12.2017 um 17:45 schrieb Yong Zhao:


Change-Id: Id522c1cbadb8c069720f4e64a31cff42cd014733
Signed-off-by: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org><mailto:yong.zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 709587d..93500e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2534,7 +2534,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev=
, uint32_t vm_size,
        uint64_t tmp;

        /* adjust vm size first */
-       if (amdgpu_vm_size !=3D -1) {
+       if (amdgpu_vm_size !=3D -1 && adev->asic_type !=3D CHIP_RAVEN) {
                unsigned max_size =3D 1 << (max_bits - 30);

                vm_size =3D amdgpu_vm_size;








_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_MWHPR12MB143800E804732F641083D673F00E0MWHPR12MB1438namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Felix,&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">we ended up with this fix.&nbsp;<=
a href=3D"http://git.amd.com:8080/#/c/122202/" class=3D"OWAAutoLink" id=3D"=
LPlnk552811" previewremoved=3D"true" style=3D"font-size: 12pt;">http://git.=
amd.com:8080/#/c/122202/</a></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I explored the option to override=
 the VM size only&nbsp;for KFD VMs, but it was not easy as
<span>amdgpu_check_vm_size() and&nbsp;</span><span style=3D"color: rgb(33, =
33, 33); font-size: 15px;">amdgpu_vm_adjust_size() come in during loading a=
mdgpu, i.&nbsp;e.&nbsp;before KFD VMs are created. So to fix the problem qu=
ickly, we ended up to not overwrite the VM size for
 all&nbsp;Raven VMs.&nbsp;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-size: 15px;">Regards,</span></p>
<p style=3D"margin-top:0;margin-bottom:0">Yong</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, December 18, 2017 4:22:43 AM<br>
<b>To:</b> Felix K=FChling; Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix a bug that vm size is wrong on =
Raven</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">The problem was a merge conflict.<br>
<br>
No idea what exactly went wrong, but Yong ended up with a branch where the =
vm_size was always overwritten with the value 64.<br>
<br>
So we can completely drop this patch and yes when an user overrides the vm_=
size value he/she should know what the consequences are.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 17.12.2017 um 00:21 schrieb Felix K=FChling:<br>
</div>
<blockquote type=3D"cite">
<pre>Is there a way to override the VM size for KFD VMs only? Only they
depend on ATS, so only they need to be forced to be 48-bits.

On the other hand, it could be argued that a user who manually sets the
VM size with a module parameter knows what they're doing. So let them
break ATS.

Regards,
&nbsp; Felix


Am 14.12.2017 um 17:45 schrieb Yong Zhao:
</pre>
<blockquote type=3D"cite">
<pre>Change-Id: Id522c1cbadb8c069720f4e64a31cff42cd014733
Signed-off-by: Yong Zhao <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:yong.zhao-5C7GfCeVMHo@public.gmane.org">&lt;yong.zhao-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 &#43;-
 1 file changed, 1 insertion(&#43;), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 709587d..93500e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2534,7 &#43;2534,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *=
adev, uint32_t vm_size,
 	uint64_t tmp;
=20
 	/* adjust vm size first */
-	if (amdgpu_vm_size !=3D -1) {
&#43;	if (amdgpu_vm_size !=3D -1 &amp;&amp; adev-&gt;asic_type !=3D CHIP_RA=
VEN) {
 		unsigned max_size =3D 1 &lt;&lt; (max_bits - 30);
=20
 		vm_size =3D amdgpu_vm_size;
</pre>
</blockquote>
<pre>

</pre>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________
amd-gfx mailing list
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"x_moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/am=
d-gfx</a>
</pre>
</blockquote>
<br>
</div>
</body>
</html>

--_000_MWHPR12MB143800E804732F641083D673F00E0MWHPR12MB1438namp_--

--===============0163584890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0163584890==--
