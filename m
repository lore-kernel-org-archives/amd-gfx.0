From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: initialize the context reset_counter in
 amdgpu_ctx_init
Date: Thu, 6 Oct 2016 12:28:27 +0200
Message-ID: <CAAxE2A55JNWJ3hP5MtbHA=Jz_5bKQDnfvvTrwvW-g2LiDf8TrA@mail.gmail.com>
References: <1475567106-5818-1-git-send-email-nhaehnle@gmail.com>
 <2d749b1b-5d1b-f0bc-502b-358acf09e04a@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0061078590=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2d749b1b-5d1b-f0bc-502b-358acf09e04a-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0061078590==
Content-Type: multipart/alternative; boundary=001a113bfb7a2015a0053e2fc19b

--001a113bfb7a2015a0053e2fc19b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Do we need to bump the DRM version for this bug fix?

Marek

On Oct 4, 2016 10:20 AM, "Christian K=C3=B6nig" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> w=
rote:

> Am 04.10.2016 um 09:45 schrieb Nicolai H=C3=A4hnle:
>
>> From: Nicolai H=C3=A4hnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>>
>> Ensure that we really only report a GPU reset if one has happened since
>> the
>> creation of the context.
>>
>> Signed-off-by: Nicolai H=C3=A4hnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index e203e55..a5e2fcb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -36,20 +36,23 @@ static int amdgpu_ctx_init(struct amdgpu_device
>> *adev, struct amdgpu_ctx *ctx)
>>         spin_lock_init(&ctx->ring_lock);
>>         ctx->fences =3D kcalloc(amdgpu_sched_jobs * AMDGPU_MAX_RINGS,
>>                               sizeof(struct fence*), GFP_KERNEL);
>>         if (!ctx->fences)
>>                 return -ENOMEM;
>>         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>>                 ctx->rings[i].sequence =3D 1;
>>                 ctx->rings[i].fences =3D &ctx->fences[amdgpu_sched_jobs =
*
>> i];
>>         }
>> +
>> +       ctx->reset_counter =3D atomic_read(&adev->gpu_reset_counter);
>> +
>>         /* create context entity for each ring */
>>         for (i =3D 0; i < adev->num_rings; i++) {
>>                 struct amdgpu_ring *ring =3D adev->rings[i];
>>                 struct amd_sched_rq *rq;
>>                 rq =3D &ring->sched.sched_rq[AMD_SCHED_PRIORITY_NORMAL];
>>                 r =3D amd_sched_entity_init(&ring->sched,
>> &ctx->rings[i].entity,
>>                                           rq, amdgpu_sched_jobs);
>>                 if (r)
>>                         break;
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a113bfb7a2015a0053e2fc19b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Do we need to bump the DRM version for this bug fix?</p>
<p dir=3D"ltr">Marek</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Oct 4, 2016 10=
:20 AM, &quot;Christian K=C3=B6nig&quot; &lt;<a href=3D"mailto:deathsimple@=
vodafone.de">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Am 04.10.2016 um 09:45 schrieb Nicolai H=C3=
=A4hnle:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Nicolai H=C3=A4hnle &lt;<a href=3D"mailto:nicolai.haehnle-5C7GfCeVMHo@public.gmane.org" ta=
rget=3D"_blank">nicolai.haehnle-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Ensure that we really only report a GPU reset if one has happened since the=
<br>
creation of the context.<br>
<br>
Signed-off-by: Nicolai H=C3=A4hnle &lt;<a href=3D"mailto:nicolai.haehnle@am=
d.com" target=3D"_blank">nicolai.haehnle-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
</blockquote>
<br>
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
---<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_ctx.c | 3 +++<br>
=C2=A0 1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_ctx.c b/drivers/gpu/drm=
/amd/amdgpu/a<wbr>mdgpu_ctx.c<br>
index e203e55..a5e2fcb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_ctx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_ctx.c<br>
@@ -36,20 +36,23 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev, =
struct amdgpu_ctx *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&amp;ctx-&gt;ring_lock<wbr>);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;fences =3D kcalloc(amdgpu_sched_jobs * =
AMDGPU_MAX_RINGS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct fence*), GFP_KERNEL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ctx-&gt;fences)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;rings[i].se=
quence =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;rings[i].fe=
nces =3D &amp;ctx-&gt;fences[amdgpu_sched_jobs * i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;reset_counter =3D atomic_read(&amp;adev=
-&gt;gpu_reset_c<wbr>ounter);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* create context entity for each ring */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;num_rings; i++) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_ring =
*ring =3D adev-&gt;rings[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amd_sched_rq=
 *rq;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rq =3D &amp;ring-&g=
t;sched.sched_rq[AMD_SCHE<wbr>D_PRIORITY_NORMAL];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amd_sched_ent=
ity_init(&amp;ring-&gt;s<wbr>ched, &amp;ctx-&gt;rings[i].entity,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
q, amdgpu_sched_jobs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
</blockquote>
<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div></div>

--001a113bfb7a2015a0053e2fc19b--

--===============0061078590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0061078590==--
