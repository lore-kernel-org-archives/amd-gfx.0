From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GART write flush error on SI w/ amdgpu
Date: Fri, 26 May 2017 17:47:36 +0200
Message-ID: <CAAxE2A7Q=qdxtm6HXF3Py9dYpARvA6+Z4ENkWTCEA572SdNEqw@mail.gmail.com>
References: <c53a99e5-eea0-17d1-05e6-b6e66746d774@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2067653660=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c53a99e5-eea0-17d1-05e6-b6e66746d774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2067653660==
Content-Type: multipart/alternative; boundary="001a1134f23a12f5ab05506f4423"

--001a1134f23a12f5ab05506f4423
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 9, 2017 at 2:13 PM, Nicolai H=C3=A4hnle <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> Hi all,
>
> I'm seeing some very strange errors on Verde with CPU readback from GART,
> and am pretty much out of ideas. Some help would be very much appreciated=
.
>
> The error manifests with the
> GL45-CTS.gtf32.GL3Tests.packed_pixels.packed_pixels_pbo test on amdgpu,
but
> *not* on radeon. Here's what the test does:
>
> 1. Upload a texture.
> 2. Read the texture back via a shader that uses shader buffer writes to
> write data to a buffer that is allocated in GART.
> 3. The CPU then reads from the buffer -- and sometimes gets stale data.
>
> This sequence is repeated for many sub-tests. There are some sub-tests
where
> the CPU reads stale data from the buffer, i.e. the shader writes simply
> don't make it to the CPU. The tests vary superficially, e.g. the first
> failing test is (almost?) always one where data is written in 16-bit word=
s
> (but there are succeeding sub-tests with 16-bit writes as well).
>
> The bug is *not* a timing issue. Adding even a 1sec delay (sleep(1);)
> between the fence wait and the return of glMapBuffer does not fix the
> problem. The data must be stuck in a cache somewhere.
>
> Since the test runs okay with the radeon module, I tried some changes
based
> on comparing the IB submit between radeon and amdgpu, and based on
comparing
> register settings via scans obtained from umr. Some of the things I've
> tried:
>
> - Set HDP_MISC_CNTL.FLUSH_INVALIDATE_CACHE to 1 (both radeon and
amdgpu/gfx9
> set this)
> - Add SURFACE_SYNC packets preceded by setting CP_COHER_CNTL2 to the vmid
> (radeon does this)
> - Change gfx_v6_0_ring_emit_hdp_invalidate: select ME engine instead of
PFP
> (which seems more logical, and is done by gfx7+), or remove the
> corresponding WRITE_DATA entirely
>
> None of these changes helped.
>
> What *does* help is adding an artificial wait. Specifically, I'm adding a
> sequence of
>
> - WRITE_DATA
> - CACHE_FLUSH_AND_INV_TS_EVENT (BOTTOM_OF_PIPE_TS has same behavior)
> - WAIT_REG_MEM
>
> as can be seen in the attached patch. This works around the problem, but
it
> makes no sense:
>
> Adding the wait sequence *before* the SURFACE_SYNC in ring_emit_fence
works
> around the problem. However(!) it does not actually cause the UMD to wait
> any longer than before. Without this change, the UMD immediately sees a
> signaled user fence (and never uses an ioctl to wait), and with this
change,
> it *still* sees a signaled user fence.
>
> Also, note that the way I've hacked the change, the wait sequence is only
> added for the user fence emit (and I'm using a modified UMD to ensure tha=
t
> there is enough memory to be used by the added wait sequence).
>
> Adding the wait sequence *after* the SURFACE_SYNC *doesn't* work around
the
> problem.
>
> So for whatever reason, the added wait sequence *before* the SURFACE_SYNC
> encourages some part of the GPU to flush the data from wherever it's
stuck,
> and that's just really bizarre. There must be something really simple I'm
> missing, and any pointers would be appreciated.

Have you tried this?

diff --git a/src/gallium/drivers/radeonsi/si_hw_context.c
b/src/gallium/drivers/radeonsi/si_hw_context.c
index 92c09cb..e6ac0ba 100644
--- a/src/gallium/drivers/radeonsi/si_hw_context.c
+++ b/src/gallium/drivers/radeonsi/si_hw_context.c
@@ -133,7 +133,8 @@ void si_context_gfx_flush(void *context, unsigned flags=
,
                        SI_CONTEXT_PS_PARTIAL_FLUSH;

        /* DRM 3.1.0 doesn't flush TC for VI correctly. */
-       if (ctx->b.chip_class =3D=3D VI && ctx->b.screen->info.drm_minor <=
=3D 1)
+       if ((ctx->b.chip_class =3D=3D VI && ctx->b.screen->info.drm_minor <=
=3D 1)
||
+           (ctx->b.chip_class =3D=3D SI && ctx->b.screen->info.drm_major =
=3D=3D 3))
                ctx->b.flags |=3D SI_CONTEXT_INV_GLOBAL_L2 |
                                SI_CONTEXT_INV_VMEM_L1;

One more cache flush there shouldn't hurt.

Also, Mesa uses PFP_SYNC_ME. It shouldn't be necessary, but it's worth a
try.

Marek

--001a1134f23a12f5ab05506f4423
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>On Tue, May 9, 2017 at 2:13 PM, Nicolai H=C3=A4h=
nle &lt;<a href=3D"mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">nhaehnle@gm=
ail.com</a>&gt; wrote:<br>&gt; Hi all,<br>&gt;<br>&gt; I&#39;m seeing some =
very strange errors on Verde with CPU readback from GART,<br>&gt; and am pr=
etty much out of ideas. Some help would be very much appreciated.<br>&gt;<b=
r>&gt; The error manifests with the<br>&gt; GL45-CTS.gtf32.GL3Tests.<wbr>pa=
cked_pixels.packed_pixels_<wbr>pbo test on amdgpu, but<br>&gt; *not* on rad=
eon. Here&#39;s what the test does:<br>&gt;<br>&gt; 1. Upload a texture.<br=
>&gt; 2. Read the texture back via a shader that uses shader buffer writes =
to<br>&gt; write data to a buffer that is allocated in GART.<br>&gt; 3. The=
 CPU then reads from the buffer -- and sometimes gets stale data.<br>&gt;<b=
r>&gt; This sequence is repeated for many sub-tests. There are some sub-tes=
ts where<br>&gt; the CPU reads stale data from the buffer, i.e. the shader =
writes simply<br>&gt; don&#39;t make it to the CPU. The tests vary superfic=
ially, e.g. the first<br>&gt; failing test is (almost?) always one where da=
ta is written in 16-bit words<br>&gt; (but there are succeeding sub-tests w=
ith 16-bit writes as well).<br>&gt;<br>&gt; The bug is *not* a timing issue=
. Adding even a 1sec delay (sleep(1);)<br>&gt; between the fence wait and t=
he return of glMapBuffer does not fix the<br>&gt; problem. The data must be=
 stuck in a cache somewhere.<br>&gt;<br>&gt; Since the test runs okay with =
the radeon module, I tried some changes based<br>&gt; on comparing the IB s=
ubmit between radeon and amdgpu, and based on comparing<br>&gt; register se=
ttings via scans obtained from umr. Some of the things I&#39;ve<br>&gt; tri=
ed:<br>&gt;<br>&gt; - Set HDP_MISC_CNTL.FLUSH_<wbr>INVALIDATE_CACHE to 1 (b=
oth radeon and amdgpu/gfx9<br>&gt; set this)<br>&gt; - Add SURFACE_SYNC pac=
kets preceded by setting CP_COHER_CNTL2 to the vmid<br>&gt; (radeon does th=
is)<br>&gt; - Change gfx_v6_0_ring_emit_hdp_<wbr>invalidate: select ME engi=
ne instead of PFP<br>&gt; (which seems more logical, and is done by gfx7+),=
 or remove the<br>&gt; corresponding WRITE_DATA entirely<br>&gt;<br>&gt; No=
ne of these changes helped.<br>&gt;<br>&gt; What *does* help is adding an a=
rtificial wait. Specifically, I&#39;m adding a<br>&gt; sequence of<br>&gt;<=
br>&gt; - WRITE_DATA<br>&gt; - CACHE_FLUSH_AND_INV_TS_EVENT (BOTTOM_OF_PIPE=
_TS has same behavior)<br>&gt; - WAIT_REG_MEM<br>&gt;<br>&gt; as can be see=
n in the attached patch. This works around the problem, but it<br>&gt; make=
s no sense:<br>&gt;<br>&gt; Adding the wait sequence *before* the SURFACE_S=
YNC in ring_emit_fence works<br>&gt; around the problem. However(!) it does=
 not actually cause the UMD to wait<br>&gt; any longer than before. Without=
 this change, the UMD immediately sees a<br>&gt; signaled user fence (and n=
ever uses an ioctl to wait), and with this change,<br>&gt; it *still* sees =
a signaled user fence.<br>&gt;<br>&gt; Also, note that the way I&#39;ve hac=
ked the change, the wait sequence is only<br>&gt; added for the user fence =
emit (and I&#39;m using a modified UMD to ensure that<br>&gt; there is enou=
gh memory to be used by the added wait sequence).<br>&gt;<br>&gt; Adding th=
e wait sequence *after* the SURFACE_SYNC *doesn&#39;t* work around the<br>&=
gt; problem.<br>&gt;<br>&gt; So for whatever reason, the added wait sequenc=
e *before* the SURFACE_SYNC<br>&gt; encourages some part of the GPU to flus=
h the data from wherever it&#39;s stuck,<br>&gt; and that&#39;s just really=
 bizarre. There must be something really simple I&#39;m<br>&gt; missing, an=
d any pointers would be appreciated.<br><br>Have you tried this?<br><br>dif=
f --git a/src/gallium/drivers/<wbr>radeonsi/si_hw_context.c b/src/gallium/d=
rivers/<wbr>radeonsi/si_hw_context.c<br>index 92c09cb..e6ac0ba 100644<br>--=
- a/src/gallium/drivers/<wbr>radeonsi/si_hw_context.c<br>+++ b/src/gallium/=
drivers/<wbr>radeonsi/si_hw_context.c<br>@@ -133,7 +133,8 @@ void si_contex=
t_gfx_flush(void *context, unsigned flags,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SI_CONTEXT_PS_PARTI=
AL_FLUSH;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* DRM 3.1.0 doesn&#39;t=
 flush TC for VI correctly. */<br>- =C2=A0 =C2=A0 =C2=A0 if (ctx-&gt;b.chip=
_class =3D=3D VI &amp;&amp; ctx-&gt;b.screen-&gt;info.drm_minor &lt;=3D 1)<=
br>+ =C2=A0 =C2=A0 =C2=A0 if ((ctx-&gt;b.chip_class =3D=3D VI &amp;&amp; ct=
x-&gt;b.screen-&gt;info.drm_minor &lt;=3D 1) ||<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (ctx-&gt;b.chip_class =3D=3D SI &amp;&amp; ctx-&gt;b.screen-&=
gt;info.drm_major =3D=3D 3))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ctx-&gt;b.flags |=3D SI_CONTEXT_INV_GLOBAL_L2 |<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SI_CONTEXT_INV_VMEM_L1;<br><br></div>One more c=
ache flush there shouldn&#39;t hurt.<br><br></div><div>Also, Mesa uses PFP_=
SYNC_ME. It shouldn&#39;t be necessary, but it&#39;s worth a try.<br></div>=
<div><br></div>Marek<br></div>

--001a1134f23a12f5ab05506f4423--

--===============2067653660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2067653660==--
