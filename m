From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Revert "drm/amdgpu/gfx8: Fix SET_RESOURCES packet"
Date: Tue, 04 Apr 2017 19:59:28 +0000
Message-ID: <CAAzXoR+TJHk1Eo_h0HJGg-KGfON-uLWE7e27Q-95PXyBY3zcOw@mail.gmail.com>
References: <20170403202534.3311-1-andresx7@gmail.com>
 <3ae98951-f12f-3860-e10a-00e0be2b9e84@amd.com>
 <d4fbb81c-be3a-c54a-6d56-17dc4ae27895@gmail.com>
 <BN6PR12MB1652D90B12B8A60F1F725AC0F70B0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1097058541=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652D90B12B8A60F1F725AC0F70B0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1097058541==
Content-Type: multipart/alternative; boundary=94eb2c1cd53c4b96fd054c5cb767

--94eb2c1cd53c4b96fd054c5cb767
Content-Type: text/plain; charset=UTF-8

I'm using the latest from all open (our internal FC24 repo).  I'll fetch
the exact later with "umr -c".

Tom

On Tue, Apr 4, 2017 at 3:48 PM Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
wrote:

> > -----Original Message-----
> > From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> > Of Andres Rodriguez
> > Sent: Tuesday, April 04, 2017 3:39 PM
> > To: StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Subject: Re: [RFC] Revert "drm/amdgpu/gfx8: Fix SET_RESOURCES packet"
> >
> >
> >
> > On 2017-04-04 08:27 AM, Tom St Denis wrote:
> > > On 03/04/17 04:25 PM, Andres Rodriguez wrote:
> > >> Commit e579f56 results in a KCQ initialization error for polaris10
> > >> cards. Providing the full SET_RESOURCES packet instead of the
> truncated
> > >> version fixes the problem.
> > >>
> > >> I think this patch may have been one of the stabs at fixing the KCQ
> > >> suspend/resume errors. I *think* it may no longer be needed if that is
> > >> the case.
> > >>
> > >> Sending this mostly as an FYI to get the patch removed from the
> 4.12-wip
> > >>
> > >> This reverts commit e579f564c333a7eaddf7e12b1b8414410c36e80f.
> > >> ---
> > >>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 +++++-
> > >>  1 file changed, 5 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > >> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > >> index 2d8d7bb..4c3bf51 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > >> @@ -4647,10 +4647,14 @@ static int gfx_v8_0_kiq_kcq_enable(struct
> > >> amdgpu_device *adev)
> > >>          return r;
> > >>      }
> > >>      /* set resources */
> > >> -    amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 2));
> > >> +    amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES,
> > 6));
> > >>      amdgpu_ring_write(kiq_ring, 0);    /* vmid_mask:0 queue_type:0
> > >> (KIQ) */
> > >>      amdgpu_ring_write(kiq_ring, 0x000000FF);    /* queue mask lo */
> > >>      amdgpu_ring_write(kiq_ring, 0);    /* queue mask hi */
> > >> +    amdgpu_ring_write(kiq_ring, 0);    /* gws mask lo */
> > >> +    amdgpu_ring_write(kiq_ring, 0);    /* gws mask hi */
> > >> +    amdgpu_ring_write(kiq_ring, 0);    /* oac mask */
> > >> +    amdgpu_ring_write(kiq_ring, 0);    /* gds heap base:0, gds heap
> > >> size:0 */
> > >>      for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> > >>          struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
> > >>          uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
> > >>
> > >
> > > This fixes init issues with my polaris board but there's still a clock
> > > problem (CP is pegged at 100% as read by umr) resulting in the GPU
> clock
> > > staying at 1200MHz the entire time.
> > >
> >
> > Yeah I sent this out because I was having KCQ init issues on my
> > polaris10 card. However, I'm not seeing the CP pegged at 100% as you
> > mentioned. Everything sitting quietly at 0% here.
>
> Which firmware are you using?
>
> Alex
>
> >
> >
> > > Tom
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--94eb2c1cd53c4b96fd054c5cb767
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m using the latest from all open (our internal FC24 =
repo).=C2=A0 I&#39;ll fetch the exact later with &quot;umr -c&quot;.<div><b=
r></div><div>Tom</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
>On Tue, Apr 4, 2017 at 3:48 PM Deucher, Alexander &lt;<a href=3D"mailto:Al=
exander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">&gt; -----Original Message-----<br class=3D"=
gmail_msg">
&gt; From: amd-gfx [mailto:<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org" class=3D"gmail_msg" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org</a>] On Behalf<br class=3D"gmail_msg">
&gt; Of Andres Rodriguez<br class=3D"gmail_msg">
&gt; Sent: Tuesday, April 04, 2017 3:39 PM<br class=3D"gmail_msg">
&gt; To: StDenis, Tom; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" cla=
ss=3D"gmail_msg" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br cla=
ss=3D"gmail_msg">
&gt; Subject: Re: [RFC] Revert &quot;drm/amdgpu/gfx8: Fix SET_RESOURCES pac=
ket&quot;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; On 2017-04-04 08:27 AM, Tom St Denis wrote:<br class=3D"gmail_msg">
&gt; &gt; On 03/04/17 04:25 PM, Andres Rodriguez wrote:<br class=3D"gmail_m=
sg">
&gt; &gt;&gt; Commit e579f56 results in a KCQ initialization error for pola=
ris10<br class=3D"gmail_msg">
&gt; &gt;&gt; cards. Providing the full SET_RESOURCES packet instead of the=
 truncated<br class=3D"gmail_msg">
&gt; &gt;&gt; version fixes the problem.<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; I think this patch may have been one of the stabs at fixing t=
he KCQ<br class=3D"gmail_msg">
&gt; &gt;&gt; suspend/resume errors. I *think* it may no longer be needed i=
f that is<br class=3D"gmail_msg">
&gt; &gt;&gt; the case.<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; Sending this mostly as an FYI to get the patch removed from t=
he 4.12-wip<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; This reverts commit e579f564c333a7eaddf7e12b1b8414410c36e80f.=
<br class=3D"gmail_msg">
&gt; &gt;&gt; ---<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 +++++-<br cla=
ss=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)<br class=
=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br class=
=3D"gmail_msg">
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br class=3D"gmail_msg=
">
&gt; &gt;&gt; index 2d8d7bb..4c3bf51 100644<br class=3D"gmail_msg">
&gt; &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br class=3D"gmail=
_msg">
&gt; &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br class=3D"gmail=
_msg">
&gt; &gt;&gt; @@ -4647,10 +4647,14 @@ static int gfx_v8_0_kiq_kcq_enable(st=
ruct<br class=3D"gmail_msg">
&gt; &gt;&gt; amdgpu_device *adev)<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br class=3D"gmail=
_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* set resources */<br class=3D"gmail_msg=
">
&gt; &gt;&gt; -=C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SE=
T_RESOURCES, 2));<br class=3D"gmail_msg">
&gt; &gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SE=
T_RESOURCES,<br class=3D"gmail_msg">
&gt; 6));<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, 0);=C2=A0 =C2=
=A0 /* vmid_mask:0 queue_type:0<br class=3D"gmail_msg">
&gt; &gt;&gt; (KIQ) */<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, 0x000000FF);=
=C2=A0 =C2=A0 /* queue mask lo */<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, 0);=C2=A0 =C2=
=A0 /* queue mask hi */<br class=3D"gmail_msg">
&gt; &gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, 0);=C2=A0 =C2=A0 /=
* gws mask lo */<br class=3D"gmail_msg">
&gt; &gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, 0);=C2=A0 =C2=A0 /=
* gws mask hi */<br class=3D"gmail_msg">
&gt; &gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, 0);=C2=A0 =C2=A0 /=
* oac mask */<br class=3D"gmail_msg">
&gt; &gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_write(kiq_ring, 0);=C2=A0 =C2=A0 /=
* gds heap base:0, gds heap<br class=3D"gmail_msg">
&gt; &gt;&gt; size:0 */<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;gfx.num_com=
pute_rings; i++) {<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_ring *ring =
=3D &amp;adev-&gt;gfx.compute_ring[i];<br class=3D"gmail_msg">
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mqd_addr =3D amdgp=
u_bo_gpu_offset(ring-&gt;mqd_obj);<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; This fixes init issues with my polaris board but there&#39;s stil=
l a clock<br class=3D"gmail_msg">
&gt; &gt; problem (CP is pegged at 100% as read by umr) resulting in the GP=
U clock<br class=3D"gmail_msg">
&gt; &gt; staying at 1200MHz the entire time.<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Yeah I sent this out because I was having KCQ init issues on my<br cla=
ss=3D"gmail_msg">
&gt; polaris10 card. However, I&#39;m not seeing the CP pegged at 100% as y=
ou<br class=3D"gmail_msg">
&gt; mentioned. Everything sitting quietly at 0% here.<br class=3D"gmail_ms=
g">
<br class=3D"gmail_msg">
Which firmware are you using?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Alex<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; &gt; Tom<br class=3D"gmail_msg">
&gt; &gt; _______________________________________________<br class=3D"gmail=
_msg">
&gt; &gt; amd-gfx mailing list<br class=3D"gmail_msg">
&gt; &gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_m=
sg" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_m=
sg">
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.fr=
eedesktop.org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
&gt; _______________________________________________<br class=3D"gmail_msg"=
>
&gt; amd-gfx mailing list<br class=3D"gmail_msg">
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" t=
arget=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
amd-gfx mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
</blockquote></div>

--94eb2c1cd53c4b96fd054c5cb767--

--===============1097058541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1097058541==--
