Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF27C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 16:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31B1613EE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 16:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31B1613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4058D89739;
	Thu, 29 Apr 2021 16:03:17 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63F1892C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 16:03:15 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 x54-20020a05683040b6b02902a527443e2fso10714422ott.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xvpb/Pz29zUM19xealEjFNTDSObhAvRH+cvhC7vhqcI=;
 b=FkdgRitSxLRlb1uF+SC3knZqcEHZ3ApeFgYiCJu4fVaOrcej9HhgibJsU6NI0sLrVv
 MjQ6k2owZGNFiJFHywBp/ULM3mNItc8Or02qJ4v8rb2sU/zziU1rdf7vgQH2vh6BhAYv
 Z6Yi7KkZDJ4+GO4uLVc3xFFTEaZfk2U66LoPJXsfGVUE/C/Cy5NJ4sSa3GY7O8OSgnBT
 cbPnSANvvyZUzXoYw5GUNSZ/iPp5QzDNtvTKm4sn8qNJj8DNhSC6eNyK3dwGnYRlOMoz
 Pt/6pr7WNAWLx/B1rVCVKmt70EN1pcMRmBYeIY191OtsOMHKcwKklCtrScJGm3+8dVhA
 a+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xvpb/Pz29zUM19xealEjFNTDSObhAvRH+cvhC7vhqcI=;
 b=nhtoAUK6kO/O2WV7lp+rBehEcX3kIjmr+viG6kcMnTS/wr0lt77AeYewGV3VvEKj1k
 ezCwmk7EBWxQwwQ6scdg6L8hXUlCDapwyvrPcYnr5Ay9tUlb+pqQGgljcB6NlJdPVCRq
 K9aNPZ3K87ikkakRq2xXZKPxamHrSZcy1/ZvZ6/HZ/UZXhKmS75sMy3s8xy+HmRG6LSz
 rNFXmmzg28W4wNM02Wf/k07ozqjsCul2yfE20l7noBrAdLOouCmHAfPT133436XwGrXP
 kGqbPH5+B3ZGZcrRx/d0v22jSqfgltzoq9pGEyI5vhPPiu26yONWSXTShsMO7VIc8UhB
 yNpw==
X-Gm-Message-State: AOAM530eFxKkQ+MPs1UkuBTSWaoup03lFdW8Uuc/fSRvawyYCalRk8wN
 MA1kYuPosV+sQeiryBDVfxm029bu9heVacHtIvE=
X-Google-Smtp-Source: ABdhPJwsXvKHSY2gyFyrmdHtZ7evxV3HLXXXDEoUBTXtL5RxtTcGS9xgRAbamdrMJeLnWKfgTPvtYkM/0kMDVQWpfcQ=
X-Received: by 2002:a9d:63d1:: with SMTP id e17mr1410804otl.311.1619712195169; 
 Thu, 29 Apr 2021 09:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210420192739.1906700-1-alexander.deucher@amd.com>
 <CADnq5_O7OWgmX72VBOqSYKkq=A0dVmxGFmg9om54HCqen0r5EA@mail.gmail.com>
 <BY5PR12MB4885068A1AD3C120C8B9432DEA5F9@BY5PR12MB4885.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4885068A1AD3C120C8B9432DEA5F9@BY5PR12MB4885.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Apr 2021 12:03:04 -0400
Message-ID: <CADnq5_O2vpisA5et1AjsxqOW8Of=E4xohm_qN92HXo2v=NyPJg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 29, 2021 at 4:11 AM Chen, Jiansong (Simon)
<Jiansong.Chen@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
> I notice there is already similar logic in sdma_v5_0_ring_emit_ib, do we need remove it?
>

I think we can also remove this from sdma_v5_0_ring_emit_ib in a
follow up patch.

Alex


> Regards,
> Jiansong
>
> @@ -410,6 +410,18 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
>         unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>         uint64_t csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring, vmid);
>
> +       /* Invalidate L2, because if we don't do it, we might get stale cache
> +        * lines from previous IBs.
> +        */
> +       amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
> +       amdgpu_ring_write(ring, 0);
> +       amdgpu_ring_write(ring, (SDMA_GCR_GL2_INV |
> +                                SDMA_GCR_GL2_WB |
> +                                SDMA_GCR_GLM_INV |
> +                                SDMA_GCR_GLM_WB) << 16);
> +       amdgpu_ring_write(ring, 0xffffff80);
> +       amdgpu_ring_write(ring, 0xffff);
> +
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Thursday, April 29, 2021 11:41 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
>
> Ping?
>
> On Tue, Apr 20, 2021 at 3:28 PM Alex Deucher <alexander.deucher@amd.com> wrote:
> >
> > Add emit mem sync callback for sdma_v5_0
> >
> > In amdgpu sync object test, three threads created jobs to send GFX IB
> > and SDMA IB in sequence. After the first GFX thread joined, sometimes
> > the third thread will reuse the same physical page to store the SDMA
> > IB. There will be a risk that SDMA will read GFX IB in the previous
> > physical page. So it's better to flush the cache before commit sdma
> > IB.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 28
> > ++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > index 920fc6d4a127..d294ef6a625a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -437,6 +437,33 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
> >         amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));  }
> >
> > +/**
> > + * sdma_v5_0_ring_emit_mem_sync - flush the IB by graphics cache
> > +rinse
> > + *
> > + * @ring: amdgpu ring pointer
> > + * @job: job to retrieve vmid from
> > + * @ib: IB object to schedule
> > + *
> > + * flush the IB by graphics cache rinse.
> > + */
> > +static void sdma_v5_0_ring_emit_mem_sync(struct amdgpu_ring *ring) {
> > +    uint32_t gcr_cntl =
> > +                   SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDMA_GCR_GLM_INV |
> > +                       SDMA_GCR_GL1_INV | SDMA_GCR_GLV_INV | SDMA_GCR_GLK_INV |
> > +                       SDMA_GCR_GLI_INV(1);
> > +
> > +       /* flush entire cache L0/L1/L2, this can be optimized by performance requirement */
> > +       amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
> > +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD1_BASE_VA_31_7(0));
> > +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD2_GCR_CONTROL_15_0(gcr_cntl) |
> > +                       SDMA_PKT_GCR_REQ_PAYLOAD2_BASE_VA_47_32(0));
> > +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD3_LIMIT_VA_31_7(0) |
> > +                       SDMA_PKT_GCR_REQ_PAYLOAD3_GCR_CONTROL_18_16(gcr_cntl >> 16));
> > +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD4_LIMIT_VA_47_32(0) |
> > +                       SDMA_PKT_GCR_REQ_PAYLOAD4_VMID(0));
> > +}
> > +
> >  /**
> >   * sdma_v5_0_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
> >   *
> > @@ -1643,6 +1670,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
> >                 10 + 10 + 10, /* sdma_v5_0_ring_emit_fence x3 for user fence, vm fence */
> >         .emit_ib_size = 5 + 7 + 6, /* sdma_v5_0_ring_emit_ib */
> >         .emit_ib = sdma_v5_0_ring_emit_ib,
> > +       .emit_mem_sync = sdma_v5_0_ring_emit_mem_sync,
> >         .emit_fence = sdma_v5_0_ring_emit_fence,
> >         .emit_pipeline_sync = sdma_v5_0_ring_emit_pipeline_sync,
> >         .emit_vm_flush = sdma_v5_0_ring_emit_vm_flush,
> > --
> > 2.30.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJi
> > ansong.Chen%40amd.com%7C1b777b80b17145712a7b08d90ac0a1f4%7C3dd8961fe48
> > 84e608e11a82d994e183d%7C0%7C0%7C637552644738458840%7CUnknown%7CTWFpbGZ
> > sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%7C1000&amp;sdata=T9jZUIJIQHS2gY8bU%2F7uM1ealAP3qxelkg2Slj3JASA%3D&am
> > p;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C1b777b80b17145712a7b08d90ac0a1f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552644738458840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=T9jZUIJIQHS2gY8bU%2F7uM1ealAP3qxelkg2Slj3JASA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
