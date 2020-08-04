Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB42C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 17:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA61E206C0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 17:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBPvscrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA61E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5CB6E4B0;
	Tue,  4 Aug 2020 17:29:56 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E376E4B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 17:29:55 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id a14so38196996wra.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Flu8zxwd9SYVA83ZSifdSS4TWGmigR1QwUHZu1JCQ9U=;
 b=ZBPvscrA1VsV8CZBqee07rZQGA6h1LhRKQq1/bxC4edzsPCtPVd6T7J05Y55F2Hoxi
 qZu+fWVSX0QRPa8ipn8lfL4Vi0g0lrDI92gpZpU3tSscN4wjFZpy6HSmzikFAQRxt7p+
 PmD6nchffnZycmROxnF/Dsfoe9BV5tRHY9XHXWXOhFkauSh1hy4sysgI2JBZsRDSqTDy
 w8q34qeOhRDHXeBM7gFQxcG234UrBwg9RE5Hn/IG8NhMP6wXtaZ2cF1z777CO7B+JwYd
 nz8P7EqIJRzhCgbEh6oVbECOPi6+00KqeKYkHYWhDczuEIOb6BTqdHmPxtrMs4ZJkjGm
 eWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Flu8zxwd9SYVA83ZSifdSS4TWGmigR1QwUHZu1JCQ9U=;
 b=pazfKzIlNfmPl+jF01nFOMVfzqHN2nDJOHru+2JEcrbCk0Je8gwHcKBLrl2P90JHiC
 SkwNxz+RhlJxoL63f9COPYjhzcJKMr/v1XoRf+qWcxzcn+dAe5xTyfYQEXMIG7ZkDArM
 k6KP7UCkoHGFnTtJ9KtBxPaCua6WSZIcg+gvr7e6TW94iF+uOuMuQ6wjL8xd7QGBnPaO
 UWt8Z04Bzk/NsLZ87PYuHEAJKiPOQzEafUvV10aStpc3LIuncnDB6UOsrI/+PC18hJ6D
 zFd3yfIx3qfZcSdb3/Avw5As7P/JBKfcEd3+1Wb22Pyyzoj2IHyS0G+uZ1yZFFEdqDbn
 PUtQ==
X-Gm-Message-State: AOAM532rWr0UGSXT7Exxtuy8EBIQf7ysF7T1p5rvohsrWu2DPiOg2hE8
 W5lXy/C72YH/YS9c8Rq1V/Nf6NlN6xOjwppRN8iXCQ==
X-Google-Smtp-Source: ABdhPJxb0O8rBdTti+qionJ927o7dTUEmc6P0YfjDhgvhAsCZbHx0uyYRmq9WEggUIhol1YFBF4R6ISLIzjIvu7Drks=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr3018960wrs.419.1596562194293; 
 Tue, 04 Aug 2020 10:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200727132455.26657-1-Philip.Yang@amd.com>
 <406653af-5b66-6c77-1104-8fdf89be5c99@amd.com>
In-Reply-To: <406653af-5b66-6c77-1104-8fdf89be5c99@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2020 13:29:43 -0400
Message-ID: <CADnq5_Nbg+sKXOJ9diUwqt6y19Uk+v_YNcE_PhDEGmgnZLm0cw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: option to disable system mem limit
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 4, 2020 at 1:27 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2020-07-27 um 9:24 a.m. schrieb Philip Yang:
> > If multiple process share system memory through /dev/shm, KFD allocate
> > memory should not fail if it reachs the system memory limit because
> > one copy of physical system memory are shared by multiple process.
> >
> > Add module parameter to provide user option to disable system memory
> > limit check, to run multiple process share memory application. By
> > default the system memory limit is on.
> >
> > Print out debug message to warn user if KFD allocate memory failed
> > because of system memory limit.
> >
> > Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          | 9 +++++++++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index e97c088d03b3..3c0d5ecfe0d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -187,9 +187,11 @@ extern int amdgpu_force_asic_type;
> >  #ifdef CONFIG_HSA_AMD
> >  extern int sched_policy;
> >  extern bool debug_evictions;
> > +extern bool no_system_mem_limit;
> >  #else
> >  static const int sched_policy = KFD_SCHED_POLICY_HWS;
> >  static const bool debug_evictions; /* = false */
> > +static const bool no_system_mem_limit;
> >  #endif
> >
> >  extern int amdgpu_tmz;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 8703aa1fe4a5..502e8204c012 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -99,7 +99,10 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
> >       mem *= si.mem_unit;
> >
> >       spin_lock_init(&kfd_mem_limit.mem_limit_lock);
> > -     kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
> > +     if (no_system_mem_limit)
> > +             kfd_mem_limit.max_system_mem_limit = U64_MAX;
> > +     else
> > +             kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
> >       kfd_mem_limit.max_ttm_mem_limit = (mem >> 1) - (mem >> 3);
> >       pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
> >               (kfd_mem_limit.max_system_mem_limit >> 20),
> > @@ -148,6 +151,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> >
> >       spin_lock(&kfd_mem_limit.mem_limit_lock);
> >
> > +     if (kfd_mem_limit.system_mem_used + system_mem_needed >
> > +         kfd_mem_limit.max_system_mem_limit)
> > +             pr_debug("Set no_system_mem_limit if using shared memory\n");
> > +
> >       if ((kfd_mem_limit.system_mem_used + system_mem_needed >
> >            kfd_mem_limit.max_system_mem_limit) ||
> >           (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 6291f5f0d223..e9acd0a9f327 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -715,6 +715,15 @@ MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1
> >  bool debug_evictions;
> >  module_param(debug_evictions, bool, 0644);
> >  MODULE_PARM_DESC(debug_evictions, "enable eviction debug messages (false = default)");
> > +
> > +/**
> > + * DOC: no_system_mem_limit(bool)
> > + * Disable system memory limit, to support multiple process shared memory
> > + */
> > +bool no_system_mem_limit;
> > +module_param(no_system_mem_limit, bool, 0644);
>
> The permissions suggest that this parameter is writable at runtime using
> sysfs. However, the parameter is only read once during module init. So
> any runtime changes to this parameter will not take effect.
>
> You can fix this in two ways:
>
>  1. Make the parameter read only
>  2. Change the implementation of amdgpu_amdkfd_reserve_mem_limit to
>     check the parameter every time and only apply the system memory
>     limit check if necessary
>
> I think the second option is preferable, because it allows user to
> experiment with this without rebooting.

Agreed.  If we go with that approach, maybe just drop the module
parameter altogether and just let the user set it manually per device
at runtime.

Alex

>
> Regards,
>   Felix
>
>
> > +MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = default)");
> > +
> >  #endif
> >
> >  /**
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
