From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Date: Thu, 7 Nov 2019 18:54:11 +0000
Message-ID: <DM6PR12MB2778007D58A5332F6A030DA3F0780@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
 <20191031001739.10764-2-Yong.Zhao@amd.com>
 <31102345-20f7-1b0e-dd2a-f7984b253a07@amd.com>
 <DM6PR12MB2778C141CFEA0006DA2CEC6DF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
 <CY4PR1201MB2533087B346C4619F461FF3185780@CY4PR1201MB2533.namprd12.prod.outlook.com>
 <41a6b535-ab7a-44f4-2899-f211f5ddc296@amd.com>
 <85fd399c-5fa9-bdef-cdf6-433e80ba6407@amd.com>,
 <CADnq5_Og4AWKdYFpa8hvmd2XXjr1Wzb_a26gqsq1H6c7NkWmMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0859267297=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Og4AWKdYFpa8hvmd2XXjr1Wzb_a26gqsq1H6c7NkWmMA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0859267297==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778007D58A5332F6A030DA3F0780DM6PR12MB2778namp_"

--_000_DM6PR12MB2778007D58A5332F6A030DA3F0780DM6PR12MB2778namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

This consolidation is a must, because we should not have duplicated it in t=
he first place. The kernel queue functions by design are generic. The reass=
on why GFX8 and GFX9 are different is because GFX9 is SOC15 where packet fo=
rmats and doorbell size changed.  On the other hand, kfd_kernel_queue_v7.c =
file is pretty much empty by reusing v8 functions, even though it is there.=
 Furthermore, in my opinion kfd_kernel_queue_v7.c should be merged into v8 =
counterpart, From GFX9 onwards, packet formats should stay the same. For ke=
rnel queues, we should be able to differentiate it by pre SOC15 or not, and=
 I have an impression that MEC firmware agrees to maintain the kernel queue=
 interface stable across generations most of time.

Regards,
Yong
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, November 7, 2019 1:32 PM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>; a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Haw=
aii

On Thu, Nov 7, 2019 at 12:47 PM Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> wr=
ote:
>
> No, please lets not add a new nomenclature for PM4 packet versions. GFX v=
ersions are agreed on between hardware, firmware, and software and it's gen=
erally understood what they mean. If we add a new PM4 packet versioning sch=
eme on our own, then this will add a lot of confusion when talking to firmw=
are teams.
>
> You know, this would all be more straight forward if we accepted a little=
 bit of code duplication and had packet writing functions per GFX version. =
You'll see this pattern a lot in the amdgpu driver where each IP version du=
plicates a bunch of code. In many cases you may be able to save a few lines=
 of code by sharing functions between IP versions. But you'll add some conf=
usion and burden on future maintenance.
>
> This is the price we pay for micro-optimizing minor code duplication.

What we've tried to do in amdgpu is to break out shared code in to
common helpers that are not IP specific and use that in each IP module
(e.g., amdgpu_uvd.c amdgpu_gfx.c, etc.).  Sometimes we can use a
particular chunk of code across multiple generations.  E.g., the uvd
stuff is a good example.  We have shared generic uvd helpers that work
for most UVD IP versions, and then if we need an IP specific version,
we override that in the callbacks with a version specific one.  E.g.,
for the video decode engines we use the generic helpers for a number
of ring functions:

static const struct amdgpu_ring_funcs uvd_v7_0_ring_vm_funcs =3D {
...
    .test_ring =3D uvd_v7_0_ring_test_ring,
        .test_ib =3D amdgpu_uvd_ring_test_ib,
        .insert_nop =3D uvd_v7_0_ring_insert_nop,
        .pad_ib =3D amdgpu_ring_generic_pad_ib,
        .begin_use =3D amdgpu_uvd_ring_begin_use,
        .end_use =3D amdgpu_uvd_ring_end_use,
...
};

while we override more of them for the video encode engines:

static const struct amdgpu_ring_funcs uvd_v7_0_enc_ring_vm_funcs =3D {
...
    .test_ring =3D uvd_v7_0_enc_ring_test_ring,
        .test_ib =3D uvd_v7_0_enc_ring_test_ib,
        .insert_nop =3D amdgpu_ring_insert_nop,
    .insert_end =3D uvd_v7_0_enc_ring_insert_end,
        .pad_ib =3D amdgpu_ring_generic_pad_ib,
        .begin_use =3D amdgpu_uvd_ring_begin_use,
        .end_use =3D amdgpu_uvd_ring_end_use,
...
};

But still maintain IP specific components.

Alex

>
> Regards,
>   Felix
>
> On 2019-11-07 12:39, Zhao, Yong wrote:
>
> Hi Kent,
>
> I can't agree more on this. Also, the same applies to the file names. Def=
initely we need to agree on the naming scheme before making it happen.
>
> Yong
>
> On 2019-11-07 12:33 p.m., Russell, Kent wrote:
>
> I think that the versioning is getting a little confusing since we=92re u=
sing the old GFX versions, but not really sticking to it due to the shareab=
ility of certain managers and shaders. Could we look into doing something l=
ike gen1 or gen2, or some other more ambiguous non-GFX-related versioning? =
Otherwise we=92ll keep having these questions of =93why is Hawaii GFX8=94, =
=93why is Arcturus GFX9=94, etc. Then if things change, we just up the valu=
e concretely, instead of maybe doing a v11 if GFX11 changes things, and onl=
y GFX11 ASICs use those functions/variables.
>
>
>
> Obviously not high-priority, but maybe something to consider as you conti=
nue to consolidate and remove duplicate code.
>
>
>
> Kent
>
>
>
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Zhao, =
Yong
> Sent: Thursday, November 7, 2019 11:57 AM
> To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg
> Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for H=
awaii
>
>
>
> Hi Felix,
>
>
>
> That's because v8 and v7 share the same packet_manager_funcs. In this cas=
e, it is better to keep it as it is.
>
>
>
> Regards,
>
> Yong
>
> ________________________________
>
> From: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> Sent: Wednesday, November 6, 2019 11:45 PM
> To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gf=
x@lists.freedesktop.org>
> Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for H=
awaii
>
>
>
> On 2019-10-30 20:17, Zhao, Yong wrote:
> > release_mem won't be used at all on GFX9 and GFX10, so delete it.
>
> Hawaii was GFXv7. So we're not using the release_mem packet on GFXv8
> either. Why arbitrarily limit this change to GFXv9 and 10?
>
> Regards,
>    Felix
>
> >
> > Change-Id: I13787a8a29b83e7516c582a7401f2e14721edf5f
> > Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 35 ++----------------=
-
> >   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c  | 33 ++---------------
> >   2 files changed, 4 insertions(+), 64 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> > index aed32ab7102e..bfd6221acae9 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> > @@ -298,37 +298,6 @@ static int pm_query_status_v10(struct packet_manag=
er *pm, uint32_t *buffer,
> >        return 0;
> >   }
> >
> > -
> > -static int pm_release_mem_v10(uint64_t gpu_addr, uint32_t *buffer)
> > -{
> > -     struct pm4_mec_release_mem *packet;
> > -
> > -     WARN_ON(!buffer);
> > -
> > -     packet =3D (struct pm4_mec_release_mem *)buffer;
> > -     memset(buffer, 0, sizeof(struct pm4_mec_release_mem));
> > -
> > -     packet->header.u32All =3D pm_build_pm4_header(IT_RELEASE_MEM,
> > -                                     sizeof(struct pm4_mec_release_mem=
));
> > -
> > -     packet->bitfields2.event_type =3D CACHE_FLUSH_AND_INV_TS_EVENT;
> > -     packet->bitfields2.event_index =3D event_index__mec_release_mem__=
end_of_pipe;
> > -     packet->bitfields2.tcl1_action_ena =3D 1;
> > -     packet->bitfields2.tc_action_ena =3D 1;
> > -     packet->bitfields2.cache_policy =3D cache_policy__mec_release_mem=
__lru;
> > -
> > -     packet->bitfields3.data_sel =3D data_sel__mec_release_mem__send_3=
2_bit_low;
> > -     packet->bitfields3.int_sel =3D
> > -             int_sel__mec_release_mem__send_interrupt_after_write_conf=
irm;
> > -
> > -     packet->bitfields4.address_lo_32b =3D (gpu_addr & 0xffffffff) >> =
2;
> > -     packet->address_hi =3D upper_32_bits(gpu_addr);
> > -
> > -     packet->data_lo =3D 0;
> > -
> > -     return sizeof(struct pm4_mec_release_mem) / sizeof(unsigned int);
> > -}
> > -
> >   const struct packet_manager_funcs kfd_v10_pm_funcs =3D {
> >        .map_process                    =3D pm_map_process_v10,
> >        .runlist                        =3D pm_runlist_v10,
> > @@ -336,13 +305,13 @@ const struct packet_manager_funcs kfd_v10_pm_func=
s =3D {
> >        .map_queues                     =3D pm_map_queues_v10,
> >        .unmap_queues                   =3D pm_unmap_queues_v10,
> >        .query_status                   =3D pm_query_status_v10,
> > -     .release_mem                    =3D pm_release_mem_v10,
> > +     .release_mem                    =3D NULL,
> >        .map_process_size               =3D sizeof(struct pm4_mes_map_pr=
ocess),
> >        .runlist_size                   =3D sizeof(struct pm4_mes_runlis=
t),
> >        .set_resources_size             =3D sizeof(struct pm4_mes_set_re=
sources),
> >        .map_queues_size                =3D sizeof(struct pm4_mes_map_qu=
eues),
> >        .unmap_queues_size              =3D sizeof(struct pm4_mes_unmap_=
queues),
> >        .query_status_size              =3D sizeof(struct pm4_mes_query_=
status),
> > -     .release_mem_size               =3D sizeof(struct pm4_mec_release=
_mem)
> > +     .release_mem_size               =3D 0,
> >   };
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> > index 3b5ca2b1d7a6..f0e4910a8865 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> > @@ -336,35 +336,6 @@ static int pm_query_status_v9(struct packet_manage=
r *pm, uint32_t *buffer,
> >        return 0;
> >   }
> >
> > -
> > -static int pm_release_mem_v9(uint64_t gpu_addr, uint32_t *buffer)
> > -{
> > -     struct pm4_mec_release_mem *packet;
> > -
> > -     packet =3D (struct pm4_mec_release_mem *)buffer;
> > -     memset(buffer, 0, sizeof(struct pm4_mec_release_mem));
> > -
> > -     packet->header.u32All =3D pm_build_pm4_header(IT_RELEASE_MEM,
> > -                                     sizeof(struct pm4_mec_release_mem=
));
> > -
> > -     packet->bitfields2.event_type =3D CACHE_FLUSH_AND_INV_TS_EVENT;
> > -     packet->bitfields2.event_index =3D event_index__mec_release_mem__=
end_of_pipe;
> > -     packet->bitfields2.tcl1_action_ena =3D 1;
> > -     packet->bitfields2.tc_action_ena =3D 1;
> > -     packet->bitfields2.cache_policy =3D cache_policy__mec_release_mem=
__lru;
> > -
> > -     packet->bitfields3.data_sel =3D data_sel__mec_release_mem__send_3=
2_bit_low;
> > -     packet->bitfields3.int_sel =3D
> > -             int_sel__mec_release_mem__send_interrupt_after_write_conf=
irm;
> > -
> > -     packet->bitfields4.address_lo_32b =3D (gpu_addr & 0xffffffff) >> =
2;
> > -     packet->address_hi =3D upper_32_bits(gpu_addr);
> > -
> > -     packet->data_lo =3D 0;
> > -
> > -     return 0;
> > -}
> > -
> >   const struct packet_manager_funcs kfd_v9_pm_funcs =3D {
> >        .map_process            =3D pm_map_process_v9,
> >        .runlist                =3D pm_runlist_v9,
> > @@ -372,12 +343,12 @@ const struct packet_manager_funcs kfd_v9_pm_funcs=
 =3D {
> >        .map_queues             =3D pm_map_queues_v9,
> >        .unmap_queues           =3D pm_unmap_queues_v9,
> >        .query_status           =3D pm_query_status_v9,
> > -     .release_mem            =3D pm_release_mem_v9,
> > +     .release_mem            =3D NULL,
> >        .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> >        .runlist_size           =3D sizeof(struct pm4_mes_runlist),
> >        .set_resources_size     =3D sizeof(struct pm4_mes_set_resources)=
,
> >        .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
> >        .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> >        .query_status_size      =3D sizeof(struct pm4_mes_query_status),
> > -     .release_mem_size       =3D sizeof(struct pm4_mec_release_mem)
> > +     .release_mem_size       =3D 0,
> >   };
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB2778007D58A5332F6A030DA3F0780DM6PR12MB2778namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Kent,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This <span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px;=
 background-color: rgb(255, 255, 255); display: inline !important">
consolidation is a must, because we should not have duplicated it in the fi=
rst place. The kernel queue functions by design are generic. The reasson wh=
y GFX8 and GFX9 are different is because GFX9 is SOC15 where packet formats=
 and doorbell size changed.&nbsp; On
 the other hand, kfd_kernel_queue_v7.c file is pretty much empty by reusing=
 v8 functions, even though it is there. Furthermore, in my opinion&nbsp;<sp=
an style=3D"font-family: Calibri, sans-serif; background-color: rgb(255, 25=
5, 255); display: inline !important">kfd_kernel_queue_v7.c
 should be merged into v8 counterpart</span>, From GFX9 onwards,&nbsp;<span=
 style=3D"font-family: Calibri, sans-serif; background-color: rgb(255, 255,=
 255); display: inline !important">packet formats should stay the same. For=
 kernel queues, we should be able to differentiate
 it by pre SOC15 or not, and I have an impression that MEC firmware agrees =
to maintain the kernel queue interface stable across generations most of ti=
me.</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; back=
ground-color: rgb(255, 255, 255); display: inline !important"><span style=
=3D"font-family: Calibri, sans-serif; background-color: rgb(255, 255, 255);=
 display: inline !important"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; back=
ground-color: rgb(255, 255, 255); display: inline !important"><span style=
=3D"font-family: Calibri, sans-serif; background-color: rgb(255, 255, 255);=
 display: inline !important">Regards,</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; back=
ground-color: rgb(255, 255, 255); display: inline !important"><span style=
=3D"font-family: Calibri, sans-serif; background-color: rgb(255, 255, 255);=
 display: inline !important">Yong</span></span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, November 7, 2019 1:32 PM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; Russell, Kent &lt;Kent.Rus=
sell-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Nov 7, 2019 at 12:47 PM Kuehling, Felix &l=
t;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; No, please lets not add a new nomenclature for PM4 packet versions. GF=
X versions are agreed on between hardware, firmware, and software and it's =
generally understood what they mean. If we add a new PM4 packet versioning =
scheme on our own, then this will add
 a lot of confusion when talking to firmware teams.<br>
&gt;<br>
&gt; You know, this would all be more straight forward if we accepted a lit=
tle bit of code duplication and had packet writing functions per GFX versio=
n. You'll see this pattern a lot in the amdgpu driver where each IP version=
 duplicates a bunch of code. In many
 cases you may be able to save a few lines of code by sharing functions bet=
ween IP versions. But you'll add some confusion and burden on future mainte=
nance.<br>
&gt;<br>
&gt; This is the price we pay for micro-optimizing minor code duplication.<=
br>
<br>
What we've tried to do in amdgpu is to break out shared code in to<br>
common helpers that are not IP specific and use that in each IP module<br>
(e.g., amdgpu_uvd.c amdgpu_gfx.c, etc.).&nbsp; Sometimes we can use a<br>
particular chunk of code across multiple generations.&nbsp; E.g., the uvd<b=
r>
stuff is a good example.&nbsp; We have shared generic uvd helpers that work=
<br>
for most UVD IP versions, and then if we need an IP specific version,<br>
we override that in the callbacks with a version specific one.&nbsp; E.g.,<=
br>
for the video decode engines we use the generic helpers for a number<br>
of ring functions:<br>
<br>
static const struct amdgpu_ring_funcs uvd_v7_0_ring_vm_funcs =3D {<br>
...<br>
&nbsp;&nbsp;&nbsp; .test_ring =3D uvd_v7_0_ring_test_ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ib =3D amdgpu_uvd_ring_tes=
t_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D uvd_v7_0_ring_in=
sert_nop,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D amdgpu_ring_generic_=
pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .begin_use =3D amdgpu_uvd_ring_b=
egin_use,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .end_use =3D amdgpu_uvd_ring_end=
_use,<br>
...<br>
};<br>
<br>
while we override more of them for the video encode engines:<br>
<br>
static const struct amdgpu_ring_funcs uvd_v7_0_enc_ring_vm_funcs =3D {<br>
...<br>
&nbsp;&nbsp;&nbsp; .test_ring =3D uvd_v7_0_enc_ring_test_ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ib =3D uvd_v7_0_enc_ring_t=
est_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D amdgpu_ring_inse=
rt_nop,<br>
&nbsp;&nbsp;&nbsp; .insert_end =3D uvd_v7_0_enc_ring_insert_end,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D amdgpu_ring_generic_=
pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .begin_use =3D amdgpu_uvd_ring_b=
egin_use,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .end_use =3D amdgpu_uvd_ring_end=
_use,<br>
...<br>
};<br>
<br>
But still maintain IP specific components.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt;&nbsp;&nbsp; Felix<br>
&gt;<br>
&gt; On 2019-11-07 12:39, Zhao, Yong wrote:<br>
&gt;<br>
&gt; Hi Kent,<br>
&gt;<br>
&gt; I can't agree more on this. Also, the same applies to the file names. =
Definitely we need to agree on the naming scheme before making it happen.<b=
r>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; On 2019-11-07 12:33 p.m., Russell, Kent wrote:<br>
&gt;<br>
&gt; I think that the versioning is getting a little confusing since we=92r=
e using the old GFX versions, but not really sticking to it due to the shar=
eability of certain managers and shaders. Could we look into doing somethin=
g like gen1 or gen2, or some other more
 ambiguous non-GFX-related versioning? Otherwise we=92ll keep having these =
questions of =93why is Hawaii GFX8=94, =93why is Arcturus GFX9=94, etc. The=
n if things change, we just up the value concretely, instead of maybe doing=
 a v11 if GFX11 changes things, and only GFX11
 ASICs use those functions/variables.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Obviously not high-priority, but maybe something to consider as you co=
ntinue to consolidate and remove duplicate code.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Kent<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of Zhao, Yong<br>
&gt; Sent: Thursday, November 7, 2019 11:57 AM<br>
&gt; To: Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org<br>
&gt; Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function fo=
r Hawaii<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Felix,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; That's because v8 and v7 share the same packet_manager_funcs. In this =
case, it is better to keep it as it is.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Wednesday, November 6, 2019 11:45 PM<br>
&gt; To: Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
&gt; Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function fo=
r Hawaii<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2019-10-30 20:17, Zhao, Yong wrote:<br>
&gt; &gt; release_mem won't be used at all on GFX9 and GFX10, so delete it.=
<br>
&gt;<br>
&gt; Hawaii was GFXv7. So we're not using the release_mem packet on GFXv8<b=
r>
&gt; either. Why arbitrarily limit this change to GFXv9 and 10?<br>
&gt;<br>
&gt; Regards,<br>
&gt;&nbsp;&nbsp;&nbsp; Felix<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: I13787a8a29b83e7516c582a7401f2e14721edf5f<br>
&gt; &gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 35 &#=
43;&#43;-----------------<br>
&gt; &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c&nbsp; | =
33 &#43;&#43;---------------<br>
&gt; &gt;&nbsp;&nbsp; 2 files changed, 4 insertions(&#43;), 64 deletions(-)=
<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; &gt; index aed32ab7102e..bfd6221acae9 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10=
.c<br>
&gt; &gt; @@ -298,37 &#43;298,6 @@ static int pm_query_status_v10(struct pa=
cket_manager *pm, uint32_t *buffer,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -static int pm_release_mem_v10(uint64_t gpu_addr, uint32_t *buffe=
r)<br>
&gt; &gt; -{<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mec_release_mem *packet;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!buffer);<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mec_release_mem =
*)buffer;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mec=
_release_mem));<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_p=
m4_header(IT_RELEASE_MEM,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sizeof(struct pm4_mec_release_mem));<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_type =3D CA=
CHE_FLUSH_AND_INV_TS_EVENT;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_index =3D e=
vent_index__mec_release_mem__end_of_pipe;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tcl1_action_ena =
=3D 1;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tc_action_ena =3D=
 1;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.cache_policy =3D =
cache_policy__mec_release_mem__lru;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.data_sel =3D data=
_sel__mec_release_mem__send_32_bit_low;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.int_sel =3D<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; int_sel__mec_release_mem__send_interrupt_after_write_confirm;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.address_lo_32b =
=3D (gpu_addr &amp; 0xffffffff) &gt;&gt; 2;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;address_hi =3D upper_32_bits=
(gpu_addr);<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D 0;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct pm4_mec_release_me=
m) / sizeof(unsigned int);<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp; const struct packet_manager_funcs kfd_v10_pm_funcs =
=3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_process_v10,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_runlist_v10,<br>
&gt; &gt; @@ -336,13 &#43;305,13 @@ const struct packet_manager_funcs kfd_v=
10_pm_funcs =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_queues_v10,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D pm_unmap_queues_v10,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D pm_query_status_v10,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D pm_release_mem_v10,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =3D NULL,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D sizeof(struct pm4_mes_map_process),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_runlist),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D si=
zeof(struct pm4_mes_set_resources),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D sizeof(struct pm4_mes_map_queues),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D sizeof(struct pm4_mes_unmap_queues),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D sizeof(struct pm4_mes_query_status),<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(s=
truct pm4_mec_release_mem)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0,<b=
r>
&gt; &gt;&nbsp;&nbsp; };<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; &gt; index 3b5ca2b1d7a6..f0e4910a8865 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.=
c<br>
&gt; &gt; @@ -336,35 &#43;336,6 @@ static int pm_query_status_v9(struct pac=
ket_manager *pm, uint32_t *buffer,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -static int pm_release_mem_v9(uint64_t gpu_addr, uint32_t *buffer=
)<br>
&gt; &gt; -{<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mec_release_mem *packet;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mec_release_mem =
*)buffer;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mec=
_release_mem));<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_p=
m4_header(IT_RELEASE_MEM,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sizeof(struct pm4_mec_release_mem));<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_type =3D CA=
CHE_FLUSH_AND_INV_TS_EVENT;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_index =3D e=
vent_index__mec_release_mem__end_of_pipe;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tcl1_action_ena =
=3D 1;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tc_action_ena =3D=
 1;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.cache_policy =3D =
cache_policy__mec_release_mem__lru;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.data_sel =3D data=
_sel__mec_release_mem__send_32_bit_low;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.int_sel =3D<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; int_sel__mec_release_mem__send_interrupt_after_write_confirm;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.address_lo_32b =
=3D (gpu_addr &amp; 0xffffffff) &gt;&gt; 2;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;address_hi =3D upper_32_bits=
(gpu_addr);<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D 0;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp; const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_process_=
v9,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D pm_runlist_v9,<br>
&gt; &gt; @@ -372,12 &#43;343,12 @@ const struct packet_manager_funcs kfd_v=
9_pm_funcs =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_que=
ues_v9,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_unmap_queues_v9,<=
br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_query_status_v9,<=
br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_release_mem_v9,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D NULL,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_map_process),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_me=
s_runlist),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbs=
p;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_set_resources),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_map_queues),<=
br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_unmap_queues),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_query_status),<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D sizeof(struct pm4_mec_release_mem)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 0,<br>
&gt; &gt;&nbsp;&nbsp; };<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778007D58A5332F6A030DA3F0780DM6PR12MB2778namp_--

--===============0859267297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0859267297==--
