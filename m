Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC84DC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 20:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656F973F7A;
	Mon,  6 Dec 2021 20:01:58 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5E173F7A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 20:01:57 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 x19-20020a9d7053000000b0055c8b39420bso15134301otj.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Dec 2021 12:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GUC6Zxivxj3MiIOIZ5cEVKC42eS4oTUph9M2X97d3bA=;
 b=YckZ261PHTjO9ct35mT6qMrquKFnRA4pPieIA8Af+wLMvAZuFQC/2b7WgqPzF9ZRT9
 WfSwS1DUBGFOdHj8CameUW6Wd7j9bRAkoXMhZKL8UwHLeU2oe40lnuLF7MCETh2UPB+q
 eYiKx6sTM6voHOFG6KgDv8a/YkBqPTiCgwGTem5DUbAqbnSh3b3ZMqeCqE0UM/7bQYJj
 yM4pIEbqTfb6Vlu+tIHKwinemgc9gf/32bwm8ZSpAkzZ+EsP2C7u5fHNxZbr9whHiT0Z
 Mds/yn46frcHnLAdw9/pSDIhbEMF0oD9wiuBObuJbzuaiDzX5orTSZjayPAg5bh6dTfC
 wDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GUC6Zxivxj3MiIOIZ5cEVKC42eS4oTUph9M2X97d3bA=;
 b=6XLKAtvwa6Rt/+edGDvrkcdxobOOgrXa1F3BwOdEzkqyIghWo4QUvcKDp/p1VCFvwZ
 oSWSYYWMFHP5eqG5XCk44uWIRcEA2uWZMH99F3Byx/svF5vHoOu0n6gPgaMvWFd1DdAS
 1jEHys89d6p3higfJC1RQ/XwsTAJMTBu/ovQ6kF6xI11yb1j8OV7fOJ4WlQLAf9c785o
 RqpanxqCuxNmxr5bnvT9YIe5smZQPXIChxzuMC9ULFe0qHx7BifPsEJbTn6XeTZGsH4m
 tJu1jilDtM3E40n26T4247VQmpI25nAq+bwBq+ja1Wb0ISxIz9QTjUQrfoph1vgj18tx
 DRpQ==
X-Gm-Message-State: AOAM531RNgfqJB1KBnF9n22EYSncRXAaR1lFeL43p3CwpOeDl5BhkVx2
 w1yx+htVUJ5M+bzlywXQ5ez4WYCqJON1kk/0fDfPRE95bDI=
X-Google-Smtp-Source: ABdhPJx8P98yXtzlKLgFxl5yoBpGC3ekRGW2UauqyOGfZo0+NvR12XztD/1j+EOsQukYiAWSWb6E/yUWHIM51ukPAmM=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr32239431otn.299.1638820916527; 
 Mon, 06 Dec 2021 12:01:56 -0800 (PST)
MIME-Version: 1.0
References: <1473700406.26541073.1638716639650.JavaMail.root@zimbra39-e7>
 <1064509373.27600770.1638735507175.JavaMail.root@zimbra39-e7>
In-Reply-To: <1064509373.27600770.1638735507175.JavaMail.root@zimbra39-e7>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Dec 2021 15:01:45 -0500
Message-ID: <CADnq5_MQnX6dRJ4-YHjWaSS5PYb1f6BQ4FXNkw9wzDmwQarkrA@mail.gmail.com>
Subject: Re: Looking for clarifications around gfx/kcq/kiq
To: Yann Dirson <ydirson@free.fr>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 6, 2021 at 5:29 AM Yann Dirson <ydirson@free.fr> wrote:
>
> Hello,
>
> Context: trying to understand what happens with my Renoir passed through
> to a Xen domu [0] (starting with the "VCN disabled" because I don't need it
> now (so let's postpone the problem with its _fini) and with "PSP disabled"
> because the alternative issue seems easier to solve -- so ip_block_mask=0xF7).
>
> I'm slowed down by a number of additional terms:
>
> * KIQ: we have the acronym, but a few more words about it would be great:
>   it seems to relate to a ring buffer provided by the GFX IP, but this one
>   does not talk much to me (e.g. it tells me less than the names of the
>   "gfx" and "compute" ones)

Kernel Interface Queue.  This is a control queue used by the kernel
driver to manage other gfx and compute queues on the GFX/compute
engine.  You can use it to map/unmap additional queues, etc.

> * "me", "mec" = ?  In some places at least "me" stands for "micro engine" but
>   what are those ?  A "mec" contains pipes which contain queues.  And in
>   amdgpu_ring the "me" field seems to identify a "mec"

MicroEngine Compute.  The is the microcontroller that controls the
compute queues on the GFX/compute engine.

> * "mes", rather looks like an IP/block family than the plural of "me".
>   A specific list of those IPs / hw blocks would be useful (maybe with
>   a diagram showing how they interact, much as what was started by
>   Rodrigo for the DC pipeline, but a first components/subcomponents diagram
>   would probably be helpful)

MicroEngine Scheduler.  This is a new engine for managing queues.
This is currently unused.

> * RLC ?  Looks like a "micro engine" inside the GFX IPs ?

RunList Controller.  This is another microcontroller in the
GFX/Compute engine.  It handles power management related functionality
within the GFX/Compute engine.  The name is a vestige of old hardware
where it was originally added and doesn't really have much relation to
what the engine does now.

> * one starting point for enhancing doc would be to start with amdgpu.h, where
>   a number of acronyms used in structs are not self-explanatory: IB, SS, CP,
>   ACP, CAC, HPD, ...

IB = Indirect Buffer.  A command buffer for a particular engine.
Rather than writing commands directly to the queue, you can write the
commands into a piece of memory and then put a pointer to the memory
into the queue.  The hardware will then follow the pointer and execute
the commands in the memory, then returning to the rest of the commands
in the ring.

SS = Spread Spectrum.

CP = Command Processor.  The name for the hardware block that
encompasses the front end of the GFX/Compute pipeline.  Consists
mainly of a bunch of microcontrollers (PFP, ME, CE, MEC).  The
firmware that runs on these microcontrollers provides the driver
interface to interact with the GFX/Compute engine.

>
> Do we have somewhere a description of what the hardware expects to find in
> those queues ?

It depends on the Engine.  Each engine has it's own packet format.
GFX/Compute uses one format, SDMA uses another, VCN uses another.
They are documented in the code and headers for the relevant engines.

>
> About amdgpu_gfx_enable_kcq():
> - Isn't the `DRM_INFO("kiq ring mec %d pipe %d q %d\n"` line rather meant as
>   DRM_DEBUG ?

It's informational so we can see what queue slot is being used for
KIQ.  There are requirements around the physical queue slot for KIQ so
it useful to know it.  That said, it could probably be made debug
only.

> - An error from amdgpu_ring_alloc() is reported as "failed to lock", but looks
>   like "failed to allocate space on ring" ?
>
> amdgpu_ring_alloc() itself is unconditionally setting count_dw, which looked
> suspicious to me -- so I added the check shown below, and it does look like
> ring_alloc() gets called again too soon.  Am I right in thinking this could be
> the cause of amdgpu_ring_test_helper() failing in timeout ?
>

Not likely.  The PSP failing to load firmware is most likely the
problem.  You need to have a functional PSP for any of the other
engines to be usable.  If we can't load the firmware for the
microcontrollers, the driver can't interact with them.

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -70,6 +70,9 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw)
>         if (WARN_ON_ONCE(ndw > ring->max_dw))
>                 return -ENOMEM;
>
> +       /* check we're not allocating too fast */
> +       WARN_ON_ONCE(ring->count_dw);
> +
>         ring->count_dw = ndw;
>         ring->wptr_old = ring->wptr;
>
>
> About gfx_v9_0_sw_fini():
> - the 2 calls to bo_free are called here without condition, whereas they are
>   allocated from rlc_init, not directly from sw_init.  Is this asymmetry wanted ?
>
>
> Maybe such info should join the documentation at some point?

Yeah, would be useful.

Alex

>
> [0] https://lists.freedesktop.org/archives/amd-gfx/2021-November/071855.html
