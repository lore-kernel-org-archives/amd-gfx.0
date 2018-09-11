From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Fixing SDMA TO after GPU reset
Date: Tue, 11 Sep 2018 13:57:04 +0000
Message-ID: <e7210958-0a4d-4415-8dbf-dd61c73564cb@email.android.com>
References: <059118f3-2729-12a1-7c8d-e306f69369aa@amd.com>
 <aa21f524-ac5e-ddb7-448a-d12ec1599a59@gmail.com>,
 <e73cb83b-750c-fd4f-40c9-635cd04bd979@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1885738265=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e73cb83b-750c-fd4f-40c9-635cd04bd979-5C7GfCeVMHo@public.gmane.org>
Content-Language: de-DE
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1885738265==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_e72109580a4d44158dbfdd61c73564cbemailandroidcom_"

--_000_e72109580a4d44158dbfdd61c73564cbemailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, that is actually desired.

We should not flush the system VM just because we do some clearing command =
submission.

Christian.

Am 11.09.2018 15:54 schrieb "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org=
>:
By current code logic job->vm_pd_addr is never going to be set unless the j=
ob is created for user SC or for buffer copy in amdgpu_copy_buffer
So in any other case we are going to skip VM flush. But amdgpu_vm_flush wan=
ts a flush to happen in case GPU reset just happend (amdgpu_vmid_had_gpu_re=
set is true)
so we will be skipping that VM flush (as in my case with amdgpu_driver_open=
_kms->amdgpu_vm_init->amdgpu_vm_clear_bo right after GPU reset occured)
Is it safe ?

Andrey

On 09/11/2018 07:46 AM, Christian K=F6nig wrote:
It would probably be better to initialize job->vm_pd_addr with AMDGPU_BO_IN=
VALID_OFFSET.

And then just drop the vm flush alltogether when the vm_pd_addr isn't set t=
o something sane.

Thanks,
Christian.

Am 11.09.2018 um 00:52 schrieb Andrey Grodzovsky:
Attached patch fixes SDMA TO after GPU reset, it's a regression caused by c=
bd5285 drm/amdgpu: move setting the GART addr into TTM.

But to me it looks safer just to revert the original patch all together sin=
ce we never can predict for sure if VM flush will take place and so it's sa=
fer to just always assign job->vm_pd_addr.

Andrey




_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx




--_000_e72109580a4d44158dbfdd61c73564cbemailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta content=3D"text/html; charset=3Dutf-8">
</head>
<body bgcolor=3D"#FFFFFF">
<div dir=3D"auto">Yes, that is actually desired.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">We should not flush the system VM just because we do some=
 clearing command submission.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 11.09.2018 15:54 schrieb &quot;Grodzovsky, An=
drey&quot; &lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
<div>By current code logic job-&gt;vm_pd_addr is never going to be set unle=
ss the job is created for user SC or for buffer copy in amdgpu_copy_buffer<=
br>
So in any other case we are going to skip VM flush. But amdgpu_vm_flush wan=
ts a flush to happen in case GPU reset just happend (amdgpu_vmid_had_gpu_re=
set is true)<br>
so we will be skipping that VM flush (as in my case with amdgpu_driver_open=
_kms-&gt;amdgpu_vm_init-&gt;amdgpu_vm_clear_bo right after GPU reset occure=
d)<br>
Is it safe ?<br>
<br>
Andrey<br>
<br>
<div class=3D"moz-cite-prefix">On 09/11/2018 07:46 AM, Christian K=F6nig wr=
ote:<br>
</div>
<blockquote type=3D"cite">
<div class=3D"moz-cite-prefix">It would probably be better to initialize jo=
b-&gt;vm_pd_addr with AMDGPU_BO_INVALID_OFFSET.<br>
<br>
And then just drop the vm flush alltogether when the vm_pd_addr isn't set t=
o something sane.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 11.09.2018 um 00:52 schrieb Andrey Grodzovsky:<br>
</div>
<blockquote type=3D"cite">Attached patch fixes SDMA TO after GPU reset, it'=
s a regression caused by cbd5285 drm/amdgpu: move setting the GART addr int=
o TTM.
<br>
<br>
But to me it looks safer just to revert the original patch all together sin=
ce we never can predict for sure if VM flush will take place and so it's sa=
fer to just always assign job-&gt;vm_pd_addr.
<br>
<br>
Andrey <br>
<br>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a>
</pre>
</blockquote>
<br>
</blockquote>
<br>
</div>
</body>
</html>

--_000_e72109580a4d44158dbfdd61c73564cbemailandroidcom_--

--===============1885738265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1885738265==--
