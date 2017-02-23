From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix double_offchip_lds_buf for gfx v6
Date: Thu, 23 Feb 2017 10:36:20 +0100
Message-ID: <CAAxE2A6JUUpxPEDV243PNnB7=w6_0Q5Kfnp70twBkZ5ZNGs3XQ@mail.gmail.com>
References: <1487819082-16489-1-git-send-email-Jerry.Zhang@amd.com>
 <CADnq5_PyZJtq4ECJ9UrrGo0tn2nqKcpHRdE39EDRpYgX7XUEyg@mail.gmail.com>
 <96a95e4f-1480-e2f2-2bdf-b408cadb4609@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0661102688=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <96a95e4f-1480-e2f2-2bdf-b408cadb4609-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0661102688==
Content-Type: multipart/alternative; boundary=001a11409ade84f57405492f58e0

--001a11409ade84f57405492f58e0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>

On Feb 23, 2017 9:24 AM, "Christian K=C3=B6nig" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> w=
rote:

> Am 23.02.2017 um 04:07 schrieb Alex Deucher:
>
>> On Wed, Feb 22, 2017 at 10:04 PM, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
>> wrote:
>>
>>> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
>>>
>> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
>
>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> index 138e15a..ab8a8c9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> @@ -1581,7 +1581,7 @@ static void gfx_v6_0_setup_spi(struct
>>> amdgpu_device *adev)
>>>
>>>   static void gfx_v6_0_config_init(struct amdgpu_device *adev)
>>>   {
>>> -       adev->gfx.config.double_offchip_lds_buf =3D 1;
>>> +       adev->gfx.config.double_offchip_lds_buf =3D 0;
>>>   }
>>>
>>>   static void gfx_v6_0_gpu_init(struct amdgpu_device *adev)
>>> --
>>> 1.9.1
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>
>

--001a11409ade84f57405492f58e0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:=
marek.olsak-5C7GfCeVMHo@public.gmane.org">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;</div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Feb 23, 2017 9:24 AM, &quot;Christi=
an K=C3=B6nig&quot; &lt;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsim=
ple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Am 23.02.2017 um 04:07 schrieb Alex Deucher:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Wed, Feb 22, 2017 at 10:04 PM, Junwei Zhang &lt;<a href=3D"mailto:Jerry.=
Zhang-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Jerry.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Signed-off-by: Junwei Zhang &lt;<a href=3D"mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org" targ=
et=3D"_blank">Jerry.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
</blockquote>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
</blockquote>
<br>
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
---<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx<wbr>_v6_0.c | 2 +-<br>
=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/g<wbr>fx_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/g<wbr>fx_v6_0.c<br>
index 138e15a..ab8a8c9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/g<wbr>fx_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/g<wbr>fx_v6_0.c<br>
@@ -1581,7 +1581,7 @@ static void gfx_v6_0_setup_spi(struct amdgpu_device *=
adev)<br>
<br>
=C2=A0 static void gfx_v6_0_config_init(struct amdgpu_device *adev)<br>
=C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.config.double_offch<wbr>ip_lds_buf=
 =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.config.double_offch<wbr>ip_lds_buf=
 =3D 0;<br>
=C2=A0 }<br>
<br>
=C2=A0 static void gfx_v6_0_gpu_init(struct amdgpu_device *adev)<br>
--<br>
1.9.1<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote>
<br>
<br>
</blockquote></div></div>

--001a11409ade84f57405492f58e0--

--===============0661102688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0661102688==--
