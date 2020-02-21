Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C230C35647
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 10:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35EC207FD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 10:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaif5f0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35EC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7642E6EF2F;
	Fri, 21 Feb 2020 10:28:44 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E2F6EF2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 10:28:42 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id k11so1385013wrd.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=olZBPvWY9pX74OHBMSeVSFj3EbTW4rXTLCmwJS8JSFc=;
 b=eaif5f0Ln9tly6trIfl+6rAkvX5w631LXZB2B/3UQZRWaTgsCCPF0nVhY9IgHU0d30
 sQVYcaFYBujIEdnQNCnC0j/c4I3VWnp8R72nrprzAs3haZvRDl1Bui4EpKGW9faLaAqD
 vfL6e4ketxa7ivYhUSry9M274f4h0VIY00tlm0JnGo/vifNjHzqZQdB/pMZrhYYirWZB
 4Xy5w/E1wN8b2BigWdDYhcWP35miM8ofwLry4NAcL/gFiomlfqm/f0sLYGU4sWwOhi+/
 Sr2MIiRCYy3h89jw/kHMcFvojqOJ7b9Yp9YWy3PHvPEf1ygYHOZ+oM6jVE7KHzUZFzqv
 ZQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=olZBPvWY9pX74OHBMSeVSFj3EbTW4rXTLCmwJS8JSFc=;
 b=PnbV0v8jO1uIF6o9W3QaLAnEWpu1uSrkZ0GgP5QNQo2Q3R+nEOoeiRseD7ZxGXAZSk
 rtt/Yr7vDVDVkXqN6jD23Zv4J5tz13LYD29X+VSB8AYHWkzG8NTkdjOM1GD9hOtSXiJi
 LOHQbuHbBmgc0Hnx9mKpMfi8x/6vAot7UqhBCthHNPYhcxjAwSdB2t4T1KmLMuUeNQMj
 Z3mkkQnuZoVsKOYXrin4J5ul0AoBWANR9UWeWo5TwUyhhqQz5DPPfLHGADVY5nVPJDSl
 h5tIpMxMAp5GQyAQ+to9sgG38big/EtIwXlHd00IFrGeGyBOToEDvdNRq1NcljQNqf6h
 NiNA==
X-Gm-Message-State: APjAAAUPHEG7BpydgXGwEmX1DysSbBmNdMzQLsjfbNMJ+Lc59+okXOAD
 pbuYw6ymncgUWBCteCfmm4F/fiAw
X-Google-Smtp-Source: APXvYqyIJ5LmN50fFePElSPzaqqjzA018EmW0uNq2TLOjFdpm2u4Gd266QmhbFQj9D7p/D90Hs+1NQ==
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr46044784wrn.85.1582280920819; 
 Fri, 21 Feb 2020 02:28:40 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 4sm3053217wmg.22.2020.02.21.02.28.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Feb 2020 02:28:39 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
 "He, Jacob" <Jacob.He@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200219101506.16779-1-jacob.he@amd.com>
 <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
 <MWHPR12MB1406B3418562F0692572C511B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
 <MN2PR12MB337663C5CCF3D53744FD377D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
 <MN2PR12MB3376E699E0A85E8065D3E72D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
 <MWHPR12MB140699AA6711A7E6876C56E5B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e09919bf-f084-55ed-04a7-f52bec5b0be9@gmail.com>
Date: Fri, 21 Feb 2020 11:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MWHPR12MB140699AA6711A7E6876C56E5B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
Content-Language: en-US
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============1634978877=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1634978877==
Content-Type: multipart/alternative;
 boundary="------------AAE4332634AE0E9F85D1F1BE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------AAE4332634AE0E9F85D1F1BE
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

That would probably be a no-go, but we could enhance the kernel driver 
to update the RLC_SPM_VMID register with the reserved VMID.

Handling that in userspace is most likely not working anyway, since the 
RLC registers are usually not accessible by userspace.

Regards,
Christian.

Am 20.02.20 um 16:15 schrieb Zhou, David(ChunMing):
>
> [AMD Official Use Only - Internal Distribution Only]
>
> You can enhance amdgpu_vm_ioctl In amdgpu_vm.c to return vmid to 
> userspace.
>
> -David
>
> *From:* He, Jacob <Jacob.He@amd.com>
> *Sent:* Thursday, February 20, 2020 10:46 PM
> *To:* Zhou, David(ChunMing) <David1.Zhou@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
> amdgpu_vm_reserve_vmid doesn’t return the reserved vmid back to user 
> space. There is no chance for user mode driver to update RLC_SPM_VMID.
>
> Thanks
>
> Jacob
>
> *From: *He, Jacob <mailto:Jacob.He@amd.com>
> *Sent: *Thursday, February 20, 2020 6:20 PM
> *To: *Zhou, David(ChunMing) <mailto:David1.Zhou@amd.com>; Koenig, 
> Christian <mailto:Christian.Koenig@amd.com>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> *Subject: *RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
> Looks like amdgpu_vm_reserve_vmid could work, let me have a try to 
> update the RLC_SPM_VMID with pm4 packets in UMD.
>
> Thanks
>
> Jacob
>
> *From: *Zhou, David(ChunMing) <mailto:David1.Zhou@amd.com>
> *Sent: *Thursday, February 20, 2020 10:13 AM
> *To: *Koenig, Christian <mailto:Christian.Koenig@amd.com>; He, Jacob 
> <mailto:Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>
> *Subject: *RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Christian is right here, that will cause many problems for simply 
> using VMID in kernel.
> We already have an pair interface for RGP, I think you can use it 
> instead of involving additional kernel change.
> amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.
>
> -David
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org 
> <mailto:amd-gfx-bounces@lists.freedesktop.org>> On Behalf Of Christian 
> König
> Sent: Wednesday, February 19, 2020 7:03 PM
> To: He, Jacob <Jacob.He@amd.com <mailto:Jacob.He@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
> Am 19.02.20 um 11:15 schrieb Jacob He:
> > [WHY]
> > When SPM trace enabled, SPM_VMID should be updated with the current
> > vmid.
> >
> > [HOW]
> > Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us
> > which job should update SPM_VMID.
> > Right before a job is submitted to GPU, set the SPM_VMID accordingly.
> >
> > [Limitation]
> > Running more than one SPM trace enabled processes simultaneously is
> > not supported.
>
> Well there are multiple problems with that patch.
>
> First of all you need to better describe what SPM tracing is in the 
> commit message.
>
> Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously 
> on the ring. Otherwise we might corrupt an already executing SPM trace.
>
> And you also need to make sure to disable the tracing again or 
> otherwise we run into a bunch of trouble when the VMID is reused.
>
> You also need to make sure that IBs using the SPM trace are serialized 
> with each other, e.g. hack into amdgpu_ids.c file and make sure that 
> only one VMID at a time can have that attribute.
>
> Regards,
> Christian.
>
> >
> > Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666
> > Signed-off-by: Jacob He <jacob.he@amd.com <mailto:jacob.he@amd.com>>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 ++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 ++++++++++++++-
> >   8 files changed, 48 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index f9fa6e104fef..3f32c4db5232 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct 
> amdgpu_cs_parser *p, union drm_amdgpu_cs
> >        uint32_t uf_offset = 0;
> >        int i;
> >        int ret;
> > +     bool update_spm_vmid = false;
> >
> >        if (cs->in.num_chunks == 0)
> >                return 0;
> > @@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct 
> amdgpu_cs_parser *p, union drm_amdgpu_cs
> >                case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
> >                        break;
> >
> > +             case AMDGPU_CHUNK_ID_SPM_TRACE:
> > +                     update_spm_vmid = true;
> > +                     break;
> > +
> >                default:
> >                        ret = -EINVAL;
> >                        goto free_partial_kdata;
> > @@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct 
> amdgpu_cs_parser *p, union drm_amdgpu_cs
> >        if (ret)
> >                goto free_all_kdata;
> >
> > +     p->job->need_update_spm_vmid = update_spm_vmid;
> > +
> >        if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
> >                ret = -ECANCELED;
> >                goto free_all_kdata;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > index cae81914c821..36faab12b585 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring 
> *ring, unsigned num_ibs,
> >                return -EINVAL;
> >        }
> >
> > -     if (vm && !job->vmid) {
> > -             dev_err(adev->dev, "VM IB without ID\n");
> > -             return -EINVAL;
> > +     if (vm) {
> > +             if (!job->vmid) {
> > +                     dev_err(adev->dev, "VM IB without ID\n");
> > +                     return -EINVAL;
> > +             } else if (adev->gfx.rlc.funcs->update_spm_vmid && 
> job->need_update_spm_vmid) {
> > + adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
> > +             }
> >        }
> >
> >        alloc_size = ring->funcs->emit_frame_size + num_ibs * diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > index 2e2110dddb76..4582536961c7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -52,6 +52,7 @@ struct amdgpu_job {
> >        bool                    vm_needs_flush;
> >        uint64_t                vm_pd_addr;
> >        unsigned                vmid;
> > +     bool                    need_update_spm_vmid;
> >        unsigned                pasid;
> >        uint32_t                gds_base, gds_size;
> >        uint32_t                gws_base, gws_size;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > index d3d4707f2168..52509c254cbd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
> >        void (*stop)(struct amdgpu_device *adev);
> >        void (*reset)(struct amdgpu_device *adev);
> >        void (*start)(struct amdgpu_device *adev);
> > +     void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned 
> vmid);
> >   };
> >
> >   struct amdgpu_rlc {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 5e9fb0976c6c..91eb788d6229 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -4214,6 +4214,18 @@ static int 
> gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
> >        return 0;
> >   }
> >
> > +static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev,
> > +unsigned vmid) {
> > +     u32 data;
> > +
> > +     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> > +
> > +     data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> > +     data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
> > +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> > +
> > +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
> > +
> >   static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
> >        .is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
> >        .set_safe_mode = gfx_v10_0_set_safe_mode, @@ -4224,7 +4236,8 @@
> > static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
> >        .resume = gfx_v10_0_rlc_resume,
> >        .stop = gfx_v10_0_rlc_stop,
> >        .reset = gfx_v10_0_rlc_reset,
> > -     .start = gfx_v10_0_rlc_start
> > +     .start = gfx_v10_0_rlc_start,
> > +     .update_spm_vmid = gfx_v10_0_update_spm_vmid
> >   };
> >
> >   static int gfx_v10_0_set_powergating_state(void *handle, diff --git
> > a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > index 8f20a5dd44fe..b24fc55cf13a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs 
> gfx_v7_0_rlc_funcs = {
> >        .resume = gfx_v7_0_rlc_resume,
> >        .stop = gfx_v7_0_rlc_stop,
> >        .reset = gfx_v7_0_rlc_reset,
> > -     .start = gfx_v7_0_rlc_start
> > +     .start = gfx_v7_0_rlc_start,
> > +     .update_spm_vmid = NULL
> >   };
> >
> >   static int gfx_v7_0_early_init(void *handle) diff --git
> > a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > index fa245973de12..66640d2b6b37 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs 
> iceland_rlc_funcs = {
> >        .resume = gfx_v8_0_rlc_resume,
> >        .stop = gfx_v8_0_rlc_stop,
> >        .reset = gfx_v8_0_rlc_reset,
> > -     .start = gfx_v8_0_rlc_start
> > +     .start = gfx_v8_0_rlc_start,
> > +     .update_spm_vmid = NULL
> >   };
> >
> >   static void gfx_v8_0_update_medium_grain_clock_gating(struct
> > amdgpu_device *adev, diff --git
> > a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 9b7ff783e9a5..df872f949f68 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -4704,6 +4704,18 @@ static int 
> gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
> >        return 0;
> >   }
> >
> > +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev,
> > +unsigned vmid) {
> > +     u32 data;
> > +
> > +     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> > +
> > +     data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> > +     data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
> > +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> > +
> > +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
> > +
> >   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
> >        .is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
> >        .set_safe_mode = gfx_v9_0_set_safe_mode, @@ -4715,7 +4727,8 @@
> > static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
> >        .resume = gfx_v9_0_rlc_resume,
> >        .stop = gfx_v9_0_rlc_stop,
> >        .reset = gfx_v9_0_rlc_reset,
> > -     .start = gfx_v9_0_rlc_start
> > +     .start = gfx_v9_0_rlc_start,
> > +     .update_spm_vmid = gfx_v9_0_update_spm_vmid
> >   };
> >
> >   static int gfx_v9_0_set_powergating_state(void *handle,
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177069753914395&amp;sdata=9rSL4kgPJweuZ4EJpdqtqTxyCVGEkmsg6aUzbtvGFrs%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cjacob.he%40amd.com%7C0b340cec0e2d41dd4f8c08d7b5ee6f65%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177908007702357&sdata=dRtYat6X178kHA8kJgsJOfiM9XhjDpmhM7dZTZy11lk%3D&reserved=0>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------AAE4332634AE0E9F85D1F1BE
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That would probably be a no-go, but we
      could enhance the kernel driver to update the RLC_SPM_VMID
      register with the reserved VMID.<br>
      <br>
      Handling that in userspace is most likely not working anyway,
      since the RLC registers are usually not accessible by userspace.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 20.02.20 um 16:15 schrieb Zhou, David(ChunMing):<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR12MB140699AA6711A7E6876C56E5B4130@MWHPR12MB1406.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Bookman Old Style";
	panose-1:2 5 6 4 5 5 5 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheader4d0fcdd7"
          style="margin:0in;margin-bottom:.0001pt"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">You can enhance amdgpu_vm_ioctl In
          amdgpu_vm.c to return vmid to userspace.
          <o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">-David<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> He, Jacob
              <a class="moz-txt-link-rfc2396E" href="mailto:Jacob.He@amd.com">&lt;Jacob.He@amd.com&gt;</a> <br>
              <b>Sent:</b> Thursday, February 20, 2020 10:46 PM<br>
              <b>To:</b> Zhou, David(ChunMing)
              <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou@amd.com">&lt;David1.Zhou@amd.com&gt;</a>; Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Subject:</b> RE: [PATCH] drm/amdgpu: Add a chunk ID for
              spm trace<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">amdgpu_vm_reserve_vmid doesn’t return the
          reserved vmid back to user space. There is no chance for user
          mode driver to update RLC_SPM_VMID.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><span
            style="font-size:9.0pt;font-family:&quot;Bookman Old
            Style&quot;,serif">Thanks<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:9.0pt;font-family:&quot;Bookman Old
            Style&quot;,serif">Jacob<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div style="border:none;border-top:solid #E1E1E1
          1.0pt;padding:3.0pt 0in 0in 0in">
          <p class="MsoNormal"><b>From: </b><a
              href="mailto:Jacob.He@amd.com" moz-do-not-send="true">He,
              Jacob</a><br>
            <b>Sent: </b>Thursday, February 20, 2020 6:20 PM<br>
            <b>To: </b><a href="mailto:David1.Zhou@amd.com"
              moz-do-not-send="true">Zhou, David(ChunMing)</a>; <a
              href="mailto:Christian.Koenig@amd.com"
              moz-do-not-send="true">
              Koenig, Christian</a>; <a
              href="mailto:amd-gfx@lists.freedesktop.org"
              moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
            <b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk ID for
            spm trace<o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Looks like amdgpu_vm_reserve_vmid could
          work, let me have a try to update the RLC_SPM_VMID with pm4
          packets in UMD.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><span
            style="font-size:9.0pt;font-family:&quot;Bookman Old
            Style&quot;,serif">Thanks<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:9.0pt;font-family:&quot;Bookman Old
            Style&quot;,serif">Jacob<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div style="border:none;border-top:solid #E1E1E1
          1.0pt;padding:3.0pt 0in 0in 0in">
          <p class="MsoNormal"><b>From: </b><a
              href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">Zhou,
              David(ChunMing)</a><br>
            <b>Sent: </b>Thursday, February 20, 2020 10:13 AM<br>
            <b>To: </b><a href="mailto:Christian.Koenig@amd.com"
              moz-do-not-send="true">Koenig, Christian</a>; <a
              href="mailto:Jacob.He@amd.com" moz-do-not-send="true">
              He, Jacob</a>; <a
              href="mailto:amd-gfx@lists.freedesktop.org"
              moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
            <b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk ID for
            spm trace<o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">[AMD Official Use Only - Internal
          Distribution Only]<br>
          <br>
          Christian is right here, that will cause many problems for
          simply using VMID in kernel.<br>
          We already have an pair interface for RGP, I think you can use
          it instead of involving additional kernel change.<br>
          amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.<br>
          <br>
          -David<br>
          <br>
          -----Original Message-----<br>
          From: amd-gfx &lt;<a
            href="mailto:amd-gfx-bounces@lists.freedesktop.org"
            moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
          On Behalf Of Christian König<br>
          Sent: Wednesday, February 19, 2020 7:03 PM<br>
          To: He, Jacob &lt;<a href="mailto:Jacob.He@amd.com"
            moz-do-not-send="true">Jacob.He@amd.com</a>&gt;; <a
            href="mailto:amd-gfx@lists.freedesktop.org"
            moz-do-not-send="true">
            amd-gfx@lists.freedesktop.org</a><br>
          Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace<br>
          <br>
          Am 19.02.20 um 11:15 schrieb Jacob He:<br>
          &gt; [WHY]<br>
          &gt; When SPM trace enabled, SPM_VMID should be updated with
          the current <br>
          &gt; vmid.<br>
          &gt;<br>
          &gt; [HOW]<br>
          &gt; Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD
          can tell us <br>
          &gt; which job should update SPM_VMID.<br>
          &gt; Right before a job is submitted to GPU, set the SPM_VMID
          accordingly.<br>
          &gt;<br>
          &gt; [Limitation]<br>
          &gt; Running more than one SPM trace enabled processes
          simultaneously is <br>
          &gt; not supported.<br>
          <br>
          Well there are multiple problems with that patch.<br>
          <br>
          First of all you need to better describe what SPM tracing is
          in the commit message.<br>
          <br>
          Then the updating of mmRLC_SPM_MC_CNTL must be executed
          asynchronously on the ring. Otherwise we might corrupt an
          already executing SPM trace.<br>
          <br>
          And you also need to make sure to disable the tracing again or
          otherwise we run into a bunch of trouble when the VMID is
          reused.<br>
          <br>
          You also need to make sure that IBs using the SPM trace are
          serialized with each other, e.g. hack into amdgpu_ids.c file
          and make sure that only one VMID at a time can have that
          attribute.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          &gt;<br>
          &gt; Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666<br>
          &gt; Signed-off-by: Jacob He &lt;<a
            href="mailto:jacob.he@amd.com" moz-do-not-send="true">jacob.he@amd.com</a>&gt;<br>
          &gt; ---<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15
          ++++++++++++++-<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15
          ++++++++++++++-<br>
          &gt;   8 files changed, 48 insertions(+), 7 deletions(-)<br>
          &gt;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c <br>
          &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; index f9fa6e104fef..3f32c4db5232 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; @@ -113,6 +113,7 @@ static int
          amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union
          drm_amdgpu_cs<br>
          &gt;        uint32_t uf_offset = 0;<br>
          &gt;        int i;<br>
          &gt;        int ret;<br>
          &gt; +     bool update_spm_vmid = false;<br>
          &gt;   <br>
          &gt;        if (cs-&gt;in.num_chunks == 0)<br>
          &gt;                return 0;<br>
          &gt; @@ -221,6 +222,10 @@ static int
          amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union
          drm_amdgpu_cs<br>
          &gt;                case
          AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:<br>
          &gt;                        break;<br>
          &gt;   <br>
          &gt; +             case AMDGPU_CHUNK_ID_SPM_TRACE:<br>
          &gt; +                     update_spm_vmid = true;<br>
          &gt; +                     break;<br>
          &gt; +<br>
          &gt;                default:<br>
          &gt;                        ret = -EINVAL;<br>
          &gt;                        goto free_partial_kdata;<br>
          &gt; @@ -231,6 +236,8 @@ static int
          amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union
          drm_amdgpu_cs<br>
          &gt;        if (ret)<br>
          &gt;                goto free_all_kdata;<br>
          &gt;   <br>
          &gt; +     p-&gt;job-&gt;need_update_spm_vmid =
          update_spm_vmid;<br>
          &gt; +<br>
          &gt;        if (p-&gt;ctx-&gt;vram_lost_counter !=
          p-&gt;job-&gt;vram_lost_counter) {<br>
          &gt;                ret = -ECANCELED;<br>
          &gt;                goto free_all_kdata;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c <br>
          &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
          &gt; index cae81914c821..36faab12b585 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
          &gt; @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct
          amdgpu_ring *ring, unsigned num_ibs,<br>
          &gt;                return -EINVAL;<br>
          &gt;        }<br>
          &gt;   <br>
          &gt; -     if (vm &amp;&amp; !job-&gt;vmid) {<br>
          &gt; -             dev_err(adev-&gt;dev, "VM IB without
          ID\n");<br>
          &gt; -             return -EINVAL;<br>
          &gt; +     if (vm) {<br>
          &gt; +             if (!job-&gt;vmid) {<br>
          &gt; +                     dev_err(adev-&gt;dev, "VM IB
          without ID\n");<br>
          &gt; +                     return -EINVAL;<br>
          &gt; +             } else if
          (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid &amp;&amp;
          job-&gt;need_update_spm_vmid) {<br>
          &gt; +                    
          adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev,
          job-&gt;vmid);<br>
          &gt; +             }<br>
          &gt;        }<br>
          &gt;   <br>
          &gt;        alloc_size = ring-&gt;funcs-&gt;emit_frame_size +
          num_ibs * diff --git <br>
          &gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h <br>
          &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
          &gt; index 2e2110dddb76..4582536961c7 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
          &gt; @@ -52,6 +52,7 @@ struct amdgpu_job {<br>
          &gt;        bool                    vm_needs_flush;<br>
          &gt;        uint64_t                vm_pd_addr;<br>
          &gt;        unsigned                vmid;<br>
          &gt; +     bool                    need_update_spm_vmid;<br>
          &gt;        unsigned                pasid;<br>
          &gt;        uint32_t                gds_base, gds_size;<br>
          &gt;        uint32_t                gws_base, gws_size;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h <br>
          &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
          &gt; index d3d4707f2168..52509c254cbd 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
          &gt; @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {<br>
          &gt;        void (*stop)(struct amdgpu_device *adev);<br>
          &gt;        void (*reset)(struct amdgpu_device *adev);<br>
          &gt;        void (*start)(struct amdgpu_device *adev);<br>
          &gt; +     void (*update_spm_vmid)(struct amdgpu_device *adev,
          unsigned vmid);<br>
          &gt;   };<br>
          &gt;   <br>
          &gt;   struct amdgpu_rlc {<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c <br>
          &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
          &gt; index 5e9fb0976c6c..91eb788d6229 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
          &gt; @@ -4214,6 +4214,18 @@ static int
          gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,<br>
          &gt;        return 0;<br>
          &gt;   }<br>
          &gt;   <br>
          &gt; +static void gfx_v10_0_update_spm_vmid(struct
          amdgpu_device *adev, <br>
          &gt; +unsigned vmid) {<br>
          &gt; +     u32 data;<br>
          &gt; +<br>
          &gt; +     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);<br>
          &gt; +<br>
          &gt; +     data &amp;= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;<br>
          &gt; +     data |= (vmid &amp;
          RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) &lt;&lt; <br>
          &gt; +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
          &gt; +<br>
          &gt; +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }<br>
          &gt; +<br>
          &gt;   static const struct amdgpu_rlc_funcs
          gfx_v10_0_rlc_funcs = {<br>
          &gt;        .is_rlc_enabled = gfx_v10_0_is_rlc_enabled,<br>
          &gt;        .set_safe_mode = gfx_v10_0_set_safe_mode, @@
          -4224,7 +4236,8 @@ <br>
          &gt; static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs
          = {<br>
          &gt;        .resume = gfx_v10_0_rlc_resume,<br>
          &gt;        .stop = gfx_v10_0_rlc_stop,<br>
          &gt;        .reset = gfx_v10_0_rlc_reset,<br>
          &gt; -     .start = gfx_v10_0_rlc_start<br>
          &gt; +     .start = gfx_v10_0_rlc_start,<br>
          &gt; +     .update_spm_vmid = gfx_v10_0_update_spm_vmid<br>
          &gt;   };<br>
          &gt;   <br>
          &gt;   static int gfx_v10_0_set_powergating_state(void
          *handle, diff --git <br>
          &gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c <br>
          &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
          &gt; index 8f20a5dd44fe..b24fc55cf13a 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
          &gt; @@ -4221,7 +4221,8 @@ static const struct
          amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {<br>
          &gt;        .resume = gfx_v7_0_rlc_resume,<br>
          &gt;        .stop = gfx_v7_0_rlc_stop,<br>
          &gt;        .reset = gfx_v7_0_rlc_reset,<br>
          &gt; -     .start = gfx_v7_0_rlc_start<br>
          &gt; +     .start = gfx_v7_0_rlc_start,<br>
          &gt; +     .update_spm_vmid = NULL<br>
          &gt;   };<br>
          &gt;   <br>
          &gt;   static int gfx_v7_0_early_init(void *handle) diff --git
          <br>
          &gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c <br>
          &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          &gt; index fa245973de12..66640d2b6b37 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          &gt; @@ -5600,7 +5600,8 @@ static const struct
          amdgpu_rlc_funcs iceland_rlc_funcs = {<br>
          &gt;        .resume = gfx_v8_0_rlc_resume,<br>
          &gt;        .stop = gfx_v8_0_rlc_stop,<br>
          &gt;        .reset = gfx_v8_0_rlc_reset,<br>
          &gt; -     .start = gfx_v8_0_rlc_start<br>
          &gt; +     .start = gfx_v8_0_rlc_start,<br>
          &gt; +     .update_spm_vmid = NULL<br>
          &gt;   };<br>
          &gt;   <br>
          &gt;   static void
          gfx_v8_0_update_medium_grain_clock_gating(struct <br>
          &gt; amdgpu_device *adev, diff --git <br>
          &gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
          &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          &gt; index 9b7ff783e9a5..df872f949f68 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          &gt; @@ -4704,6 +4704,18 @@ static int
          gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,<br>
          &gt;        return 0;<br>
          &gt;   }<br>
          &gt;   <br>
          &gt; +static void gfx_v9_0_update_spm_vmid(struct
          amdgpu_device *adev, <br>
          &gt; +unsigned vmid) {<br>
          &gt; +     u32 data;<br>
          &gt; +<br>
          &gt; +     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);<br>
          &gt; +<br>
          &gt; +     data &amp;= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;<br>
          &gt; +     data |= (vmid &amp;
          RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) &lt;&lt; <br>
          &gt; +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
          &gt; +<br>
          &gt; +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }<br>
          &gt; +<br>
          &gt;   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs
          = {<br>
          &gt;        .is_rlc_enabled = gfx_v9_0_is_rlc_enabled,<br>
          &gt;        .set_safe_mode = gfx_v9_0_set_safe_mode, @@
          -4715,7 +4727,8 @@ <br>
          &gt; static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =
          {<br>
          &gt;        .resume = gfx_v9_0_rlc_resume,<br>
          &gt;        .stop = gfx_v9_0_rlc_stop,<br>
          &gt;        .reset = gfx_v9_0_rlc_reset,<br>
          &gt; -     .start = gfx_v9_0_rlc_start<br>
          &gt; +     .start = gfx_v9_0_rlc_start,<br>
          &gt; +     .update_spm_vmid = gfx_v9_0_update_spm_vmid<br>
          &gt;   };<br>
          &gt;   <br>
          &gt;   static int gfx_v9_0_set_powergating_state(void *handle,<br>
          <br>
          _______________________________________________<br>
          amd-gfx mailing list<br>
          <a href="mailto:amd-gfx@lists.freedesktop.org"
            moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
          <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cjacob.he%40amd.com%7C0b340cec0e2d41dd4f8c08d7b5ee6f65%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177908007702357&amp;sdata=dRtYat6X178kHA8kJgsJOfiM9XhjDpmhM7dZTZy11lk%3D&amp;reserved=0"
            moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177069753914395&amp;amp;sdata=9rSL4kgPJweuZ4EJpdqtqTxyCVGEkmsg6aUzbtvGFrs%3D&amp;amp;reserved=0</a><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------AAE4332634AE0E9F85D1F1BE--

--===============1634978877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1634978877==--
