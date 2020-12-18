Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F86DC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202A623B87
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202A623B87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B459289AF3;
	Fri, 18 Dec 2020 22:01:31 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01D689AF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:01:30 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id q205so4394635oig.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jX1+FFmDHFuq31i/JU7I3rel0Nb++rfSDlqgiIwlEtE=;
 b=Sr3AQN4EgA/g0nVDNyeilKtiJNGyD33aqgYji583iBotjzpQBYZGFSZfING+RkNWFE
 YqhVc+O7KZrSUq6ofuU3CvlQVW2OCCYupl0MRneaGCCsF/4Buyc0BrPnngjMNlrx4hAK
 XW9NoOWdxxX7yWUIhjyuuMjnPgNdhNALJktStTOzXjLa0OVf0IeJP+YnxzUFSmYPFogR
 rX6LDYLo+5nC+8L/JS4brV3JZWDGSZCJx9a06WC9PoVsYTgTIFcKT0xWynxw3ifWTOUK
 lJiEnsTD4U/LGL90P+kso1LNuMaDcoXYljHAu1sgVWlNmef6VhZsnn93JgP9IJK7u1y+
 9L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jX1+FFmDHFuq31i/JU7I3rel0Nb++rfSDlqgiIwlEtE=;
 b=e/gp5TvIefLdrXr9XRoLRu6wumhVxzLJ88zNwdRf/GVvwWGT8Cuj0VtTeXbhhKu+2P
 ewS6AYP9Nd0xKVR/VNvZDnx9D7/vQ4rQ/XP/4Xv6FlhTII39O95OzSMublQ4F229Onww
 wuJ05avcDKsV4MTbBneRV05ng7Qrl4jdqbBKgx7Q4o7Ab7T/MGur/yo0TXBKbY6IJKAT
 sbZyTh7rUCptfv0EgpwFNES9KOF/zheH9lLct3n+6zF4PGffDHHd0q7y72kCdRfd60u6
 Bsg3wKA78ZBdWKd+cfgCxeCP1m8N/rP7zel0k8K2R5E0nvQzqXKR6x0+yxdWHncs9iXK
 mCEw==
X-Gm-Message-State: AOAM5316KeLhMa0p5+cYJgYMPW9RdPxqihKdkIoiW5GEFgbrvihnNF0u
 wZvv4OFBL/zQs7N5M2Pnuz6r5O8BGQS/Y8Ahm/Q=
X-Google-Smtp-Source: ABdhPJzKTUr0mI1wbXdjexjdbt3ivpp+DGlOJNqu4QJKl7h477YWVph28Mz6D+TbavLUALzUQSE8BneLEisQvdCLEd8=
X-Received: by 2002:a54:4083:: with SMTP id i3mr4203798oii.120.1608328890181; 
 Fri, 18 Dec 2020 14:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20201218213416.61131-1-alexander.deucher@amd.com>
 <79d80ede-4562-d3b1-8e85-51d27027afa9@amd.com>
In-Reply-To: <79d80ede-4562-d3b1-8e85-51d27027afa9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Dec 2020 17:01:19 -0500
Message-ID: <CADnq5_PWomXZWg8qCgJn2nfRTemdrYdN3k2MmP_0nkr149t2EA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: check both client id and src id in interrupt
 handlers
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 18, 2020 at 4:54 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2020-12-18 um 4:34 p.m. schrieb Alex Deucher:
> > We can have the same src ids for different client ids so make sure to
> > check both the client id and the source id when handling interrupts.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Looks reasonable to me. Does this fix a real problem, e.g. KFD
> intercepting an interrupt meant for another client?

yeah, we are debugging an issue on another chip and ending up doing
the wrong thing here because the source ids are the same for a
different client id.  I guess another option would be to filter the
client ids sent to amdgpu_amdkfd_interrupt().  E.g.,

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index afbbec82a289..77a542c2c194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -464,7 +464,20 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
        }

        /* Send it to amdkfd as well if it isn't already handled */
-       if (!handled)
+       if (!handled &&
+           (client_id == AMDGPU_IRQ_CLIENTID_LEGACY ||
+            client_id == SOC15_IH_CLIENTID_GRBM_CP ||
+            client_id == SOC15_IH_CLIENTID_SDMA0 ||
+            client_id == SOC15_IH_CLIENTID_SDMA1 ||
+            client_id == SOC15_IH_CLIENTID_SDMA2 ||
+            client_id == SOC15_IH_CLIENTID_SDMA3 ||
+            client_id == SOC15_IH_CLIENTID_SDMA4 ||
+            client_id == SOC15_IH_CLIENTID_SDMA5 ||
+            client_id == SOC15_IH_CLIENTID_SDMA6 ||
+            client_id == SOC15_IH_CLIENTID_SDMA7 ||
+            client_id == SOC15_IH_CLIENTID_VMC ||
+            client_id == SOC15_IH_CLIENTID_VMC1 ||
+            client_id == SOC15_IH_CLIENTID_UTCL2))
                amdgpu_amdkfd_interrupt(adev, entry.iv_entry);
 }


Alex


>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> > ---
> >  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 46 ++++++++++++++-----
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> > index 241bd6ff79f4..0ca0327a39e5 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> > @@ -44,6 +44,21 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
> >       client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
> >       pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
> >
> > +     /* Only handle clients we care about */
> > +     if (client_id != SOC15_IH_CLIENTID_GRBM_CP &&
> > +         client_id != SOC15_IH_CLIENTID_SDMA0 &&
> > +         client_id != SOC15_IH_CLIENTID_SDMA1 &&
> > +         client_id != SOC15_IH_CLIENTID_SDMA2 &&
> > +         client_id != SOC15_IH_CLIENTID_SDMA3 &&
> > +         client_id != SOC15_IH_CLIENTID_SDMA4 &&
> > +         client_id != SOC15_IH_CLIENTID_SDMA5 &&
> > +         client_id != SOC15_IH_CLIENTID_SDMA6 &&
> > +         client_id != SOC15_IH_CLIENTID_SDMA7 &&
> > +         client_id != SOC15_IH_CLIENTID_VMC &&
> > +         client_id != SOC15_IH_CLIENTID_VMC1 &&
> > +         client_id != SOC15_IH_CLIENTID_UTCL2)
> > +             return false;
> > +
> >       /* This is a known issue for gfx9. Under non HWS, pasid is not set
> >        * in the interrupt payload, so we need to find out the pasid on our
> >        * own.
> > @@ -96,17 +111,26 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
> >       vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
> >       context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
> >
> > -     if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
> > -             kfd_signal_event_interrupt(pasid, context_id, 32);
> > -     else if (source_id == SOC15_INTSRC_SDMA_TRAP)
> > -             kfd_signal_event_interrupt(pasid, context_id & 0xfffffff, 28);
> > -     else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
> > -             kfd_signal_event_interrupt(pasid, context_id & 0xffffff, 24);
> > -     else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
> > -             kfd_signal_hw_exception_event(pasid);
> > -     else if (client_id == SOC15_IH_CLIENTID_VMC ||
> > -             client_id == SOC15_IH_CLIENTID_VMC1 ||
> > -              client_id == SOC15_IH_CLIENTID_UTCL2) {
> > +     if (client_id == SOC15_IH_CLIENTID_GRBM_CP) {
> > +             if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
> > +                     kfd_signal_event_interrupt(pasid, context_id, 32);
> > +             else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
> > +                     kfd_signal_event_interrupt(pasid, context_id & 0xffffff, 24);
> > +             else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
> > +                     kfd_signal_hw_exception_event(pasid);
> > +     } else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
> > +                client_id == SOC15_IH_CLIENTID_SDMA1 ||
> > +                client_id == SOC15_IH_CLIENTID_SDMA2 ||
> > +                client_id == SOC15_IH_CLIENTID_SDMA3 ||
> > +                client_id == SOC15_IH_CLIENTID_SDMA4 ||
> > +                client_id == SOC15_IH_CLIENTID_SDMA5 ||
> > +                client_id == SOC15_IH_CLIENTID_SDMA6 ||
> > +                client_id == SOC15_IH_CLIENTID_SDMA7) {
> > +             if (source_id == SOC15_INTSRC_SDMA_TRAP)
> > +                     kfd_signal_event_interrupt(pasid, context_id & 0xfffffff, 28);
> > +     } else if (client_id == SOC15_IH_CLIENTID_VMC ||
> > +                client_id == SOC15_IH_CLIENTID_VMC1 ||
> > +                client_id == SOC15_IH_CLIENTID_UTCL2) {
> >               struct kfd_vm_fault_info info = {0};
> >               uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
