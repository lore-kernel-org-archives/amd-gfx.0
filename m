From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC] Revert "drm/amdgpu/gfx8: Fix SET_RESOURCES packet"
Date: Wed, 5 Apr 2017 11:34:19 -0400
Message-ID: <CAFQ_0eHiU=HNCpPA=2+Op0944anFsb1w-=Q3923LXPY02Pia3Q@mail.gmail.com>
References: <20170403202534.3311-1-andresx7@gmail.com>
 <3ae98951-f12f-3860-e10a-00e0be2b9e84@amd.com>
 <d4fbb81c-be3a-c54a-6d56-17dc4ae27895@gmail.com>
 <BN6PR12MB1652D90B12B8A60F1F725AC0F70B0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CAAzXoR+TJHk1Eo_h0HJGg-KGfON-uLWE7e27Q-95PXyBY3zcOw@mail.gmail.com>
 <32c1f7e8-54a4-8db7-c764-8bae55bf3f94@gmail.com>
 <BN6PR12MB1652C9E0D15D794E02FAB2ADF70B0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CAFQ_0eH8wU1NOfj5TXR+SKWAbFcRqqS4mK-xEFWuSG82V-zozg@mail.gmail.com>
 <08b6ee6a-f201-272c-d812-7f7404a51863@amd.com>
 <CADnq5_O7KZy08QQ2P0mqGMkOdFtFYRh5jrJx_Gfm5Ahxvse8Vw@mail.gmail.com>
 <682c9bb0-19d6-f64a-84d1-73dd77824aa4@amd.com>
 <BN6PR12MB1652D439580DE76681B0EFA7F70A0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0144900573=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652D439580DE76681B0EFA7F70A0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0144900573==
Content-Type: multipart/alternative; boundary=001a1147e15e458b49054c6d2060

--001a1147e15e458b49054c6d2060
Content-Type: text/plain; charset=UTF-8

Hey Tom,

If it's the same as your old firmware you might be missing an extra step. I
usually just run the kernel 'make install' as that usually take care of the
distro specific quirks.

Regards,
Andres

On Apr 5, 2017 9:56 AM, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
wrote:

> > -----Original Message-----
> > From: StDenis, Tom
> > Sent: Wednesday, April 05, 2017 9:14 AM
> > To: Alex Deucher
> > Cc: Andres Rodriguez; Deucher, Alexander; Tom St Denis; amd-
> > gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Subject: Re: [RFC] Revert "drm/amdgpu/gfx8: Fix SET_RESOURCES packet"
> >
> > On 05/04/17 09:06 AM, Alex Deucher wrote:
> > > On Wed, Apr 5, 2017 at 7:30 AM, Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> > wrote:
> > >> My firmware is
> > >>
> > >>         fw.VCE == .feature==0 .firmware==0x34040300
> > >>         fw.UVD == .feature==0 .firmware==0x015b0b00
> > >>         fw.MC == .feature==0 .firmware==0x00000000
> > >>         fw.ME == .feature==46 .firmware==0x000000a1
> > >>         fw.PFP == .feature==46 .firmware==0x000000eb
> > >>         fw.CE == .feature==46 .firmware==0x00000086
> > >>         fw.RLC == .feature==1 .firmware==0x0000009c
> > >>         fw.MEC == .feature==46 .firmware==0x000002c1
> > >>         fw.MEC2 == .feature==46 .firmware==0x000002c1
> > >>         fw.SOS == .feature==0 .firmware==0x00000000
> > >>         fw.ASD == .feature==0 .firmware==0x00000000
> > >>         fw.SMC == .feature==0 .firmware==0x00000000
> > >>         fw.SDMA0 == .feature==0 .firmware==0x00000022
> > >>         fw.SDMA1 == .feature==0 .firmware==0x00000022
> > >>
> > >> It seems like our all-open is behind what he has for SDMA, SMC, RLC
> but
> > >> ahead for others?  Bizarre.
> > >
> > > Can you try the upstream ucode?  That is what Andres is using.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-
> > firmware.git
> >
> > Copying the tip of master from that to my /lib/firmware/ results in the
> > same firmware versions being loaded.
> >
>
> Same as you or same as Andres?
>
> Alex
>
> > >
> > > Alex
> > >
> > >>
> > >> Tom
> > >>
> > >>
> > >> On 04/04/17 04:17 PM, Andres Rodriguez wrote:
> > >>>
> > >>> This should be the the linux-firmware repository @ commit
> > >>> 6d3bc8886517d171068fd1263176b8b5c51df204
> > >>>
> > >>> I reverted back to that firmware since I didn't want to deal with
> > >>> possible bugs when testing my patches.
> > >>>
> > >>> Regards,
> > >>> Andres
> > >>>
> > >>> On Tue, Apr 4, 2017 at 4:03 PM, Deucher, Alexander
> > >>> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:
> > >>>>>
> > >>>>> -----Original Message-----
> > >>>>> From: Andres Rodriguez [mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> > >>>>> Sent: Tuesday, April 04, 2017 4:01 PM
> > >>>>> To: Tom St Denis; Deucher, Alexander; StDenis, Tom; amd-
> > >>>>> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > >>>>> Subject: Re: [RFC] Revert "drm/amdgpu/gfx8: Fix SET_RESOURCES
> > packet"
> > >>>>>
> > >>>>> This is my info in case that is useful:
> > >>>>>
> > >>>>>      umr.version == ea8e49bb15ed
> > >>>>>
> > >>>>>      fw.VCE == .feature==0 .firmware==0x34040300
> > >>>>>      fw.UVD == .feature==0 .firmware==0x014f1000
> > >>>>>      fw.MC == .feature==0 .firmware==0x00000000
> > >>>>>      fw.ME == .feature==37 .firmware==0x00000094
> > >>>>>      fw.PFP == .feature==37 .firmware==0x000000dc
> > >>>>>      fw.CE == .feature==37 .firmware==0x00000080
> > >>>>>      fw.RLC == .feature==1 .firmware==0x0000010e
> > >>>>>      fw.MEC == .feature==37 .firmware==0x000002a2
> > >>>>>      fw.MEC2 == .feature==37 .firmware==0x000002a2
> > >>>>>      fw.SOS == .feature==0 .firmware==0x00000000
> > >>>>>      fw.ASD == .feature==0 .firmware==0x00000000
> > >>>>>      fw.SMC == .feature==0 .firmware==0x00170f00
> > >>>>>      fw.SDMA0 == .feature==31 .firmware==0x00000036
> > >>>>>      fw.SDMA1 == .feature==0 .firmware==0x00000036
> > >>>>>
> > >>>>>      asic.instance == 0
> > >>>>>
> > >>>>>
> > >>>>>      gfx.max_shader_engines == 4
> > >>>>>      gfx.max_tile_pipes == 8
> > >>>>>      gfx.max_cu_per_sh == 9
> > >>>>>      gfx.max_sh_per_se == 1
> > >>>>>      gfx.max_backends_per_se == 2
> > >>>>>      gfx.max_texture_channel_caches == 8
> > >>>>>      gfx.max_gprs == 256
> > >>>>>      gfx.max_gs_threads == 32
> > >>>>>      gfx.max_hw_contexts == 8
> > >>>>>      gfx.sc_prim_fifo_size_frontend == 32
> > >>>>>      gfx.sc_prim_fifo_size_backend == 256
> > >>>>>      gfx.sc_hiz_tile_fifo_size == 48
> > >>>>>      gfx.sc_earlyz_tile_fifo_size == 304
> > >>>>>      gfx.num_tile_pipes == 8
> > >>>>>      gfx.backend_enable_mask == 255
> > >>>>>      gfx.mem_max_burst_length_bytes == 256
> > >>>>>      gfx.mem_row_size_in_kb == 4
> > >>>>>      gfx.shader_engine_tile_size == 32
> > >>>>>      gfx.num_gpus == 1
> > >>>>>      gfx.multi_gpu_tile_size == 64
> > >>>>>      gfx.mc_arb_ramcfg == 24738
> > >>>>>      gfx.gb_addr_config == 570494979
> > >>>>>      gfx.num_rbs == 8
> > >>>>>      gfx.family = 130, Volcanic Islands
> > >>>>>      gfx.rev_id == 00000001
> > >>>>>      gfx.external_rev_id == 00000051
> > >>>>>      gfx.cg_flags == 003fffcd
> > >>>>>          AMD_CG_SUPPORT_GFX_MGCG
> > >>>>>          AMD_CG_SUPPORT_GFX_CGCG
> > >>>>>          AMD_CG_SUPPORT_GFX_CGLS
> > >>>>>          AMD_CG_SUPPORT_GFX_CP_LS
> > >>>>>          AMD_CG_SUPPORT_GFX_RLC_LS
> > >>>>>          AMD_CG_SUPPORT_MC_LS
> > >>>>>          AMD_CG_SUPPORT_MC_MGCG
> > >>>>>          AMD_CG_SUPPORT_SDMA_LS
> > >>>>>          AMD_CG_SUPPORT_SDMA_MGCG
> > >>>>>          AMD_CG_SUPPORT_BIF_LS
> > >>>>>          AMD_CG_SUPPORT_UVD_MGCG
> > >>>>>          AMD_CG_SUPPORT_VCE_MGCG
> > >>>>>          AMD_CG_SUPPORT_HDP_LS
> > >>>>>          AMD_CG_SUPPORT_HDP_MGCG
> > >>>>>          AMD_CG_SUPPORT_ROM_MGCG
> > >>>>>      gfx.pg_flags == 00000000
> > >>>>
> > >>>>
> > >>>> Is this the stock firmware from upstream or the stuff I pointed you
> to
> > >>>> yesterday on my fdo site?
> > >>>>
> > >>>> Alex
> > >>>>
> > >>>>>
> > >>>>> Regards,
> > >>>>> Andres
> > >>>>>
> > >>>>> On 2017-04-04 03:59 PM, Tom St Denis wrote:
> > >>>>>>
> > >>>>>> I'm using the latest from all open (our internal FC24 repo).  I'll
> > >>>>>> fetch
> > >>>>>> the exact later with "umr -c".
> > >>>>>>
> > >>>>>> Tom
> > >>>>>>
> > >>>>>> On Tue, Apr 4, 2017 at 3:48 PM Deucher, Alexander
> > >>>>>
> > >>>>> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> > >>>>>>
> > >>>>>> wrote:
> > >>>>>>
> > >>>>>>>> -----Original Message-----
> > >>>>>>>> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
> > On
> > >>>>>
> > >>>>> Behalf
> > >>>>>>>>
> > >>>>>>>> Of Andres Rodriguez
> > >>>>>>>> Sent: Tuesday, April 04, 2017 3:39 PM
> > >>>>>>>> To: StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > >>>>>>>> Subject: Re: [RFC] Revert "drm/amdgpu/gfx8: Fix SET_RESOURCES
> > >>>>>
> > >>>>> packet"
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On 2017-04-04 08:27 AM, Tom St Denis wrote:
> > >>>>>>>>>
> > >>>>>>>>> On 03/04/17 04:25 PM, Andres Rodriguez wrote:
> > >>>>>>>>>>
> > >>>>>>>>>> Commit e579f56 results in a KCQ initialization error for
> polaris10
> > >>>>>>>>>> cards. Providing the full SET_RESOURCES packet instead of the
> > >>>>>>>
> > >>>>>>> truncated
> > >>>>>>>>>>
> > >>>>>>>>>> version fixes the problem.
> > >>>>>>>>>>
> > >>>>>>>>>> I think this patch may have been one of the stabs at fixing
> the
> > KCQ
> > >>>>>>>>>> suspend/resume errors. I *think* it may no longer be needed
> > if that
> > >>>>>
> > >>>>> is
> > >>>>>>>>>>
> > >>>>>>>>>> the case.
> > >>>>>>>>>>
> > >>>>>>>>>> Sending this mostly as an FYI to get the patch removed from
> > the
> > >>>>>>>
> > >>>>>>> 4.12-wip
> > >>>>>>>>>>
> > >>>>>>>>>> This reverts commit
> > e579f564c333a7eaddf7e12b1b8414410c36e80f.
> > >>>>>>>>>> ---
> > >>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 +++++-
> > >>>>>>>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > >>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > >>>>>>>>>> index 2d8d7bb..4c3bf51 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > >>>>>>>>>> @@ -4647,10 +4647,14 @@ static int
> > gfx_v8_0_kiq_kcq_enable(struct
> > >>>>>>>>>> amdgpu_device *adev)
> > >>>>>>>>>>           return r;
> > >>>>>>>>>>       }
> > >>>>>>>>>>       /* set resources */
> > >>>>>>>>>> -    amdgpu_ring_write(kiq_ring,
> > PACKET3(PACKET3_SET_RESOURCES,
> > >>>>>
> > >>>>> 2));
> > >>>>>>>>>>
> > >>>>>>>>>> +    amdgpu_ring_write(kiq_ring,
> > >>>>>
> > >>>>> PACKET3(PACKET3_SET_RESOURCES,
> > >>>>>>>>
> > >>>>>>>> 6));
> > >>>>>>>>>>
> > >>>>>>>>>>       amdgpu_ring_write(kiq_ring, 0);    /* vmid_mask:0
> > >>>>>>>>>> queue_type:0
> > >>>>>>>>>> (KIQ) */
> > >>>>>>>>>>       amdgpu_ring_write(kiq_ring, 0x000000FF);    /* queue
> mask
> > lo
> > >>>>>>>>>> */
> > >>>>>>>>>>       amdgpu_ring_write(kiq_ring, 0);    /* queue mask hi */
> > >>>>>>>>>> +    amdgpu_ring_write(kiq_ring, 0);    /* gws mask lo */
> > >>>>>>>>>> +    amdgpu_ring_write(kiq_ring, 0);    /* gws mask hi */
> > >>>>>>>>>> +    amdgpu_ring_write(kiq_ring, 0);    /* oac mask */
> > >>>>>>>>>> +    amdgpu_ring_write(kiq_ring, 0);    /* gds heap base:0,
> gds
> > >>>>>>>>>> heap
> > >>>>>>>>>> size:0 */
> > >>>>>>>>>>       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> > >>>>>>>>>>           struct amdgpu_ring *ring =
> &adev->gfx.compute_ring[i];
> > >>>>>>>>>>           uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring-
> > >mqd_obj);
> > >>>>>>>>>>
> > >>>>>>>>> This fixes init issues with my polaris board but there's still
> a
> > >>>>>>>>> clock
> > >>>>>>>>> problem (CP is pegged at 100% as read by umr) resulting in the
> > GPU
> > >>>>>>>
> > >>>>>>> clock
> > >>>>>>>>>
> > >>>>>>>>> staying at 1200MHz the entire time.
> > >>>>>>>>>
> > >>>>>>>> Yeah I sent this out because I was having KCQ init issues on my
> > >>>>>>>> polaris10 card. However, I'm not seeing the CP pegged at 100% as
> > you
> > >>>>>>>> mentioned. Everything sitting quietly at 0% here.
> > >>>>>>>
> > >>>>>>> Which firmware are you using?
> > >>>>>>>
> > >>>>>>> Alex
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>>> Tom
> > >>>>>>>>> _______________________________________________
> > >>>>>>>>> amd-gfx mailing list
> > >>>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > >>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > >>>>>>>>
> > >>>>>>>> _______________________________________________
> > >>>>>>>> amd-gfx mailing list
> > >>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > >>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > >>>>>>>
> > >>>>>>> _______________________________________________
> > >>>>>>> amd-gfx mailing list
> > >>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > >>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > >>>>>>>
> > >>>>
> > >>
> > >> _______________________________________________
> > >> amd-gfx mailing list
> > >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>

--001a1147e15e458b49054c6d2060
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hey Tom,<div dir=3D"auto"><br></div><div dir=3D"auto">If =
it&#39;s the same as your old firmware you might be missing an extra step. =
I usually just run the kernel &#39;make install&#39; as that usually take c=
are of the distro specific quirks.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Regards,</div><div dir=3D"auto">Andres=C2=A0</div></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Apr 5, 2017 9:56 AM, &=
quot;Deucher, Alexander&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">&gt; -----Original Message-----<br>
&gt; From: StDenis, Tom<br>
&gt; Sent: Wednesday, April 05, 2017 9:14 AM<br>
&gt; To: Alex Deucher<br>
&gt; Cc: Andres Rodriguez; Deucher, Alexander; Tom St Denis; amd-<br>
&gt; <a href=3D"mailto:gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
</a><br>
&gt; Subject: Re: [RFC] Revert &quot;drm/amdgpu/gfx8: Fix SET_RESOURCES pac=
ket&quot;<br>
&gt;<br>
&gt; On 05/04/17 09:06 AM, Alex Deucher wrote:<br>
&gt; &gt; On Wed, Apr 5, 2017 at 7:30 AM, Tom St Denis &lt;<a href=3D"mailt=
o:tom.stdenis-5C7GfCeVMHo@public.gmane.org">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt;&gt; My firmware is<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.VCE =3D=3D .feature=3D=3D=
0 .firmware=3D=3D0x34040300<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.UVD =3D=3D .feature=3D=3D=
0 .firmware=3D=3D0x015b0b00<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.MC =3D=3D .feature=3D=3D0=
 .firmware=3D=3D0x00000000<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.ME =3D=3D .feature=3D=3D4=
6 .firmware=3D=3D0x000000a1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.PFP =3D=3D .feature=3D=3D=
46 .firmware=3D=3D0x000000eb<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.CE =3D=3D .feature=3D=3D4=
6 .firmware=3D=3D0x00000086<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.RLC =3D=3D .feature=3D=3D=
1 .firmware=3D=3D0x0000009c<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.MEC =3D=3D .feature=3D=3D=
46 .firmware=3D=3D0x000002c1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.MEC2 =3D=3D .feature=3D=
=3D46 .firmware=3D=3D0x000002c1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.SOS =3D=3D .feature=3D=3D=
0 .firmware=3D=3D0x00000000<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.ASD =3D=3D .feature=3D=3D=
0 .firmware=3D=3D0x00000000<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.SMC =3D=3D .feature=3D=3D=
0 .firmware=3D=3D0x00000000<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.SDMA0 =3D=3D .feature=3D=
=3D0 .firmware=3D=3D0x00000022<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw.SDMA1 =3D=3D .feature=3D=
=3D0 .firmware=3D=3D0x00000022<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; It seems like our all-open is behind what he has for SDMA, SM=
C, RLC but<br>
&gt; &gt;&gt; ahead for others?=C2=A0 Bizarre.<br>
&gt; &gt;<br>
&gt; &gt; Can you try the upstream ucode?=C2=A0 That is what Andres is usin=
g.<br>
&gt; &gt; <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/firmwa=
re/linux-" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/=
<wbr>scm/linux/kernel/git/firmware/<wbr>linux-</a><br>
&gt; firmware.git<br>
&gt;<br>
&gt; Copying the tip of master from that to my /lib/firmware/ results in th=
e<br>
&gt; same firmware versions being loaded.<br>
&gt;<br>
<br>
Same as you or same as Andres?<br>
<br>
Alex<br>
<br>
&gt; &gt;<br>
&gt; &gt; Alex<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Tom<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 04/04/17 04:17 PM, Andres Rodriguez wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; This should be the the linux-firmware repository @ commit=
<br>
&gt; &gt;&gt;&gt; 6d3bc8886517d171068fd1263176b8<wbr>b5c51df204<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I reverted back to that firmware since I didn&#39;t want =
to deal with<br>
&gt; &gt;&gt;&gt; possible bugs when testing my patches.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Regards,<br>
&gt; &gt;&gt;&gt; Andres<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On Tue, Apr 4, 2017 at 4:03 PM, Deucher, Alexander<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexande=
r.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt;&gt; From: Andres Rodriguez [mailto:<a href=3D"mailto:=
andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt; &gt;&gt;&gt;&gt;&gt; Sent: Tuesday, April 04, 2017 4:01 PM<br>
&gt; &gt;&gt;&gt;&gt;&gt; To: Tom St Denis; Deucher, Alexander; StDenis, To=
m; amd-<br>
&gt; &gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">gfx@=
lists.freedesktop.org</a><br>
&gt; &gt;&gt;&gt;&gt;&gt; Subject: Re: [RFC] Revert &quot;drm/amdgpu/gfx8: =
Fix SET_RESOURCES<br>
&gt; packet&quot;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; This is my info in case that is useful:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 umr.version =3D=3D ea8e49bb15=
ed<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.VCE =3D=3D .feature=3D=3D0=
 .firmware=3D=3D0x34040300<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.UVD =3D=3D .feature=3D=3D0=
 .firmware=3D=3D0x014f1000<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.MC =3D=3D .feature=3D=3D0 =
.firmware=3D=3D0x00000000<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.ME =3D=3D .feature=3D=3D37=
 .firmware=3D=3D0x00000094<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.PFP =3D=3D .feature=3D=3D3=
7 .firmware=3D=3D0x000000dc<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.CE =3D=3D .feature=3D=3D37=
 .firmware=3D=3D0x00000080<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.RLC =3D=3D .feature=3D=3D1=
 .firmware=3D=3D0x0000010e<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.MEC =3D=3D .feature=3D=3D3=
7 .firmware=3D=3D0x000002a2<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.MEC2 =3D=3D .feature=3D=3D=
37 .firmware=3D=3D0x000002a2<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.SOS =3D=3D .feature=3D=3D0=
 .firmware=3D=3D0x00000000<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.ASD =3D=3D .feature=3D=3D0=
 .firmware=3D=3D0x00000000<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.SMC =3D=3D .feature=3D=3D0=
 .firmware=3D=3D0x00170f00<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.SDMA0 =3D=3D .feature=3D=
=3D31 .firmware=3D=3D0x00000036<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fw.SDMA1 =3D=3D .feature=3D=
=3D0 .firmware=3D=3D0x00000036<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 asic.instance =3D=3D 0<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_shader_engines =3D=3D=
 4<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_tile_pipes =3D=3D 8<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_cu_per_sh =3D=3D 9<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_sh_per_se =3D=3D 1<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_backends_per_se =3D=
=3D 2<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_texture_channel_cache=
s =3D=3D 8<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_gprs =3D=3D 256<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_gs_threads =3D=3D 32<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.max_hw_contexts =3D=3D 8<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.sc_prim_fifo_size_fronten=
d =3D=3D 32<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.sc_prim_fifo_size_backend=
 =3D=3D 256<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.sc_hiz_tile_fifo_size =3D=
=3D 48<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.sc_earlyz_tile_fifo_size =
=3D=3D 304<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.num_tile_pipes =3D=3D 8<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.backend_enable_mask =3D=
=3D 255<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.mem_max_burst_length_byte=
s =3D=3D 256<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.mem_row_size_in_kb =3D=3D=
 4<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.shader_engine_tile_size =
=3D=3D 32<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.num_gpus =3D=3D 1<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.multi_gpu_tile_size =3D=
=3D 64<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.mc_arb_ramcfg =3D=3D 2473=
8<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.gb_addr_config =3D=3D 570=
494979<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.num_rbs =3D=3D 8<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.family =3D 130, Volcanic =
Islands<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.rev_id =3D=3D 00000001<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.external_rev_id =3D=3D 00=
000051<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.cg_flags =3D=3D 003fffcd<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
GFX_MGCG<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
GFX_CGCG<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
GFX_CGLS<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
GFX_CP_LS<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
GFX_RLC_LS<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
MC_LS<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
MC_MGCG<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
SDMA_LS<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
SDMA_MGCG<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
BIF_LS<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
UVD_MGCG<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
VCE_MGCG<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
HDP_LS<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
HDP_MGCG<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_CG_SUPPORT_=
ROM_MGCG<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 gfx.pg_flags =3D=3D 00000000<=
br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Is this the stock firmware from upstream or the stuff=
 I pointed you to<br>
&gt; &gt;&gt;&gt;&gt; yesterday on my fdo site?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Alex<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Regards,<br>
&gt; &gt;&gt;&gt;&gt;&gt; Andres<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; On 2017-04-04 03:59 PM, Tom St Denis wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; I&#39;m using the latest from all open (our i=
nternal FC24 repo).=C2=A0 I&#39;ll<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; fetch<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; the exact later with &quot;umr -c&quot;.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Tom<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; On Tue, Apr 4, 2017 at 3:48 PM Deucher, Alexa=
nder<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">=
Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; From: amd-gfx [mailto:<a href=3D"mail=
to:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces@lists.<wbr>freede=
sktop.org</a>]<br>
&gt; On<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Behalf<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Of Andres Rodriguez<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sent: Tuesday, April 04, 2017 3:39 PM=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; To: StDenis, Tom; <a href=3D"mailto:a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Subject: Re: [RFC] Revert &quot;drm/a=
mdgpu/gfx8: Fix SET_RESOURCES<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; packet&quot;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2017-04-04 08:27 AM, Tom St Denis =
wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 03/04/17 04:25 PM, Andres Rodr=
iguez wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Commit e579f56 results in a K=
CQ initialization error for polaris10<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cards. Providing the full SET=
_RESOURCES packet instead of the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; truncated<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; version fixes the problem.<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I think this patch may have b=
een one of the stabs at fixing the<br>
&gt; KCQ<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; suspend/resume errors. I *thi=
nk* it may no longer be needed<br>
&gt; if that<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; is<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the case.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sending this mostly as an FYI=
 to get the patch removed from<br>
&gt; the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; 4.12-wip<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This reverts commit<br>
&gt; e579f564c333a7eaddf7e12b1b8414<wbr>410c36e80f.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0drivers/gpu/drm/a=
md/amdgpu/<wbr>gfx_v8_0.c | 6 +++++-<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A01 file changed, 5=
 insertions(+), 1 deletion(-)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/=
amd/amdgpu/<wbr>gfx_v8_0.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/=
<wbr>gfx_v8_0.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; index 2d8d7bb..4c3bf51 100644=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amd=
gpu/<wbr>gfx_v8_0.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amd=
gpu/<wbr>gfx_v8_0.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -4647,10 +4647,14 @@ stati=
c int<br>
&gt; gfx_v8_0_kiq_kcq_enable(struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return r;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
set resources */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 amdgpu_ring_wr=
ite(kiq_ring,<br>
&gt; PACKET3(PACKET3_SET_RESOURCES,<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; 2));<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_wr=
ite(kiq_ring,<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; PACKET3(PACKET3_SET_RESOURCES,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 6));<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amd=
gpu_ring_write(kiq_ring, 0);=C2=A0 =C2=A0 /* vmid_mask:0<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; queue_type:0<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (KIQ) */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amd=
gpu_ring_write(kiq_ring, 0x000000FF);=C2=A0 =C2=A0 /* queue mask<br>
&gt; lo<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amd=
gpu_ring_write(kiq_ring, 0);=C2=A0 =C2=A0 /* queue mask hi */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_wr=
ite(kiq_ring, 0);=C2=A0 =C2=A0 /* gws mask lo */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_wr=
ite(kiq_ring, 0);=C2=A0 =C2=A0 /* gws mask hi */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_wr=
ite(kiq_ring, 0);=C2=A0 =C2=A0 /* oac mask */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 amdgpu_ring_wr=
ite(kiq_ring, 0);=C2=A0 =C2=A0 /* gds heap base:0, gds<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; heap<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; size:0 */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for=
 (i =3D 0; i &lt; adev-&gt;gfx.num_compute_rings; i++) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct amdgpu_ring *ring =3D &amp;adev-&gt;gfx.compute_ring[i]=
;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint64_t mqd_addr =3D amdgpu_bo_gpu_offset(ring-<br>
&gt; &gt;mqd_obj);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This fixes init issues with my po=
laris board but there&#39;s still a<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; clock<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; problem (CP is pegged at 100% as =
read by umr) resulting in the<br>
&gt; GPU<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; clock<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; staying at 1200MHz the entire tim=
e.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Yeah I sent this out because I was ha=
ving KCQ init issues on my<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; polaris10 card. However, I&#39;m not =
seeing the CP pegged at 100% as<br>
&gt; you<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; mentioned. Everything sitting quietly=
 at 0% here.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Which firmware are you using?<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Alex<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Tom<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ______________________________<wb=
r>_________________<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:amd-gfx@lists.f=
reedesktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.freedesk=
top.org/mailman/listinfo/amd-gfx" rel=3D"noreferrer" target=3D"_blank">http=
s://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ______________________________<wbr>__=
_______________<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx" rel=3D"noreferrer" target=3D"_blank">https://=
lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; ______________________________<wbr>______=
___________<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx" rel=3D"noreferrer" target=3D"_blank">https://list=
s.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ______________________________<wbr>_________________<br>
&gt; &gt;&gt; amd-gfx mailing list<br>
&gt; &gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@list=
s.freedesktop.org</a><br>
&gt; &gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd=
-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<w=
br>mailman/listinfo/amd-gfx</a><br>
<br>
</blockquote></div></div>

--001a1147e15e458b49054c6d2060--

--===============0144900573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0144900573==--
