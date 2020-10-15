Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2345BC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 15:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9106C22256
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 15:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/wx2GUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9106C22256
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5956ED38;
	Thu, 15 Oct 2020 15:05:46 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83E96ED33
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 15:05:44 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id j18so2214822pfa.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0GF4Wn/8ew39HBI+XaMnuO9j8yg2aCSICyeKdqSEoy0=;
 b=W/wx2GUUoZqbOD1fzYPZpByM/iCKWc/HPc61ffGqy45n/5i+ZtWkYIZR4r8LO24v58
 bhh9U1whbAcDpsL2Jp7TYLbVA7skF1yWKVmYOtlfLxqww549eGKUgTZcwMneKugCMi9F
 OBor6L+tMoX/Wj56383LtSPxbLW7kqMraLlfHs33FDQTySNMlOK5FP7Xn3MvTxYr1O9M
 aPLZB4NMwxInvXc10Nw6zE//OX8vz3wDdY3ik1KOwr11hiRTyhBCP7yQ9zCANF8um5vj
 28Vhobd7qtiZ5IMQgdPx9MAfIzC9iJbku7s3YuyQU+Igcc5sgwTbt1jydu/hUAXZShVf
 wi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0GF4Wn/8ew39HBI+XaMnuO9j8yg2aCSICyeKdqSEoy0=;
 b=mlvZQu4sFPmBcSl9AM/LvOEvfwblO9rORbrgmaMCVNErzdQOZNS222aYebtOnYImnR
 VxjVqqiNxN4IBOE95kbiBpfdAhLJ8o0SyOL75R+h9zE2HJ4MShOim0SJ5nqzF/SAmS0/
 Aj0kceZAYnIk7uCQr/7BIY3F1hbk/tI2LNCUZEBCCCeLlhJQrOiSH6tXlOpqNxTPICQF
 M+GIqfCJHyDOppHwi0vV330e54veIUBH74ApryGpmaq/jTZNhbKUV+FIT53l0GZRVhcR
 77jKurhB7gAWxyXOIVEbiIL3FjkEh7gYr704oJmv5aGa9sjymHO+FUBtMDlsCG/ZXctA
 tJGw==
X-Gm-Message-State: AOAM533R+GWHVL2GLU4CzWAVUh782WapeqOKsXjAHR6dWZjpGM19R54W
 4drGAPhP2IrM4GirkUB9+11h//LolYk7QYJAetc=
X-Google-Smtp-Source: ABdhPJz0b9kWMxMq9EAbFDK0D2fMczqTo5eZyxSC5iJqThH5UuouKTimlUpcq9PznyWy3QDaTcWUcVB8ooTWAKerdgQ=
X-Received: by 2002:a63:d19:: with SMTP id c25mr3784937pgl.208.1602774344123; 
 Thu, 15 Oct 2020 08:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <1596181868-28879-1-git-send-email-Monk.Liu@amd.com>
 <1596181868-28879-2-git-send-email-Monk.Liu@amd.com>
 <904d9605-f061-d6a0-b72b-42b0d73bf11d@amd.com>
In-Reply-To: <904d9605-f061-d6a0-b72b-42b0d73bf11d@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 15 Oct 2020 11:05:07 -0400
Message-ID: <CAAxE2A5JMHCxKKV+hSO7YL1Bt-M-9fuwcJKkSUSWyXxff9mezw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: introduce a new parameter to configure
 how many KCQ we want(v5)
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Monk Liu <Monk.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============1205023114=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1205023114==
Content-Type: multipart/alternative; boundary="0000000000006fc86a05b1b6fb54"

--0000000000006fc86a05b1b6fb54
Content-Type: text/plain; charset="UTF-8"

Monk or perhaps Felix,

Do you by any chance know why the CS ioctl returns -EINVAL for all compute
submissions if num_kcq <= 4 and what could cause that?

If not, is there any way to disable mid-IB preemption for compute?

Thanks,
Marek

On Fri, Jul 31, 2020 at 9:53 AM Felix Kuehling <felix.kuehling@amd.com>
wrote:

> Am 2020-07-31 um 3:51 a.m. schrieb Monk Liu:
> > what:
> > the MQD's save and restore of KCQ (kernel compute queue)
> > cost lots of clocks during world switch which impacts a lot
> > to multi-VF performance
> >
> > how:
> > introduce a paramter to control the number of KCQ to avoid
> > performance drop if there is no kernel compute queue needed
> >
> > notes:
> > this paramter only affects gfx 8/9/10
> >
> > v2:
> > refine namings
> >
> > v3:
> > choose queues for each ring to that try best to cross pipes evenly.
> >
> > v4:
> > fix indentation
> > some cleanupsin the gfx_compute_queue_acquire()
> >
> > v5:
> > further fix on indentations
> > more cleanupsin gfx_compute_queue_acquire()
> >
> > TODO:
> > in the future we will let hypervisor driver to set this paramter
> > automatically thus no need for user to configure it through
> > modprobe in virtual machine
> >
> > Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>
> This patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 49
> ++++++++++++------------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 +++++++++---------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 +++++++++---------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 ++++++++++---------
> >  7 files changed, 76 insertions(+), 73 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index e97c088..de11136 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -201,6 +201,7 @@ extern int amdgpu_si_support;
> >  #ifdef CONFIG_DRM_AMDGPU_CIK
> >  extern int amdgpu_cik_support;
> >  #endif
> > +extern int amdgpu_num_kcq;
> >
> >  #define AMDGPU_VM_MAX_NUM_CTX                        4096
> >  #define AMDGPU_SG_THRESHOLD                  (256*1024*1024)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 62ecac9..cf445bab 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1199,6 +1199,11 @@ static int amdgpu_device_check_arguments(struct
> amdgpu_device *adev)
> >
> >       amdgpu_gmc_tmz_set(adev);
> >
> > +     if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> > +             amdgpu_num_kcq = 8;
> > +             dev_warn(adev->dev, "set kernel compute queue number to 8
> due to invalid paramter provided by user\n");
> > +     }
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 6291f5f..b545c40 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -150,6 +150,7 @@ int amdgpu_noretry;
> >  int amdgpu_force_asic_type = -1;
> >  int amdgpu_tmz = 0;
> >  int amdgpu_reset_method = -1; /* auto */
> > +int amdgpu_num_kcq = -1;
> >
> >  struct amdgpu_mgpu_info mgpu_info = {
> >       .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> > @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
> >  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default),
> 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
> >  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
> >
> > +MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to
> setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
> > +module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
> > +
> >  static const struct pci_device_id pciidlist[] = {
> >  #ifdef  CONFIG_DRM_AMDGPU_SI
> >       {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 8eff017..0cd9de6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -202,40 +202,29 @@ bool
> amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> >
> >  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
> >  {
> > -     int i, queue, pipe, mec;
> > +     int i, queue, pipe;
> >       bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
> > -
> > -     /* policy for amdgpu compute queue ownership */
> > -     for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
> > -             queue = i % adev->gfx.mec.num_queue_per_pipe;
> > -             pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> > -                     % adev->gfx.mec.num_pipe_per_mec;
> > -             mec = (i / adev->gfx.mec.num_queue_per_pipe)
> > -                     / adev->gfx.mec.num_pipe_per_mec;
> > -
> > -             /* we've run out of HW */
> > -             if (mec >= adev->gfx.mec.num_mec)
> > -                     break;
> > -
> > -             if (multipipe_policy) {
> > -                     /* policy: amdgpu owns the first two queues of the
> first MEC */
> > -                     if (mec == 0 && queue < 2)
> > -                             set_bit(i, adev->gfx.mec.queue_bitmap);
> > -             } else {
> > -                     /* policy: amdgpu owns all queues in the first
> pipe */
> > -                     if (mec == 0 && pipe == 0)
> > -                             set_bit(i, adev->gfx.mec.queue_bitmap);
> > +     int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
> > +                                  adev->gfx.mec.num_queue_per_pipe,
> > +                                  adev->gfx.num_compute_rings);
> > +
> > +     if (multipipe_policy) {
> > +             /* policy: make queues evenly cross all pipes on MEC1 only
> */
> > +             for (i = 0; i < max_queues_per_mec; i++) {
> > +                     pipe = i % adev->gfx.mec.num_pipe_per_mec;
> > +                     queue = (i / adev->gfx.mec.num_pipe_per_mec) %
> > +                             adev->gfx.mec.num_queue_per_pipe;
> > +
> > +                     set_bit(pipe * adev->gfx.mec.num_queue_per_pipe +
> queue,
> > +                                     adev->gfx.mec.queue_bitmap);
> >               }
> > +     } else {
> > +             /* policy: amdgpu owns all queues in the given pipe */
> > +             for (i = 0; i < max_queues_per_mec; ++i)
> > +                     set_bit(i, adev->gfx.mec.queue_bitmap);
> >       }
> >
> > -     /* update the number of active compute rings */
> > -     adev->gfx.num_compute_rings =
> > -             bitmap_weight(adev->gfx.mec.queue_bitmap,
> AMDGPU_MAX_COMPUTE_QUEUES);
> > -
> > -     /* If you hit this case and edited the policy, you probably just
> > -      * need to increase AMDGPU_MAX_COMPUTE_RINGS */
> > -     if (WARN_ON(adev->gfx.num_compute_rings >
> AMDGPU_MAX_COMPUTE_RINGS))
> > -             adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> > +     dev_dbg(adev->dev, "mec queue bitmap weight=%d\n",
> bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES));
> >  }
> >
> >  void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index f571e25..4172bc8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -4022,21 +4022,23 @@ static int gfx_v10_0_mec_init(struct
> amdgpu_device *adev)
> >       amdgpu_gfx_compute_queue_acquire(adev);
> >       mec_hpd_size = adev->gfx.num_compute_rings * GFX10_MEC_HPD_SIZE;
> >
> > -     r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> > -                                   AMDGPU_GEM_DOMAIN_GTT,
> > -                                   &adev->gfx.mec.hpd_eop_obj,
> > -                                   &adev->gfx.mec.hpd_eop_gpu_addr,
> > -                                   (void **)&hpd);
> > -     if (r) {
> > -             dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> > -             gfx_v10_0_mec_fini(adev);
> > -             return r;
> > -     }
> > +     if (mec_hpd_size) {
> > +             r = amdgpu_bo_create_reserved(adev, mec_hpd_size,
> PAGE_SIZE,
> > +                                           AMDGPU_GEM_DOMAIN_GTT,
> > +                                           &adev->gfx.mec.hpd_eop_obj,
> > +
>  &adev->gfx.mec.hpd_eop_gpu_addr,
> > +                                           (void **)&hpd);
> > +             if (r) {
> > +                     dev_warn(adev->dev, "(%d) create HDP EOP bo
> failed\n", r);
> > +                     gfx_v10_0_mec_fini(adev);
> > +                     return r;
> > +             }
> >
> > -     memset(hpd, 0, mec_hpd_size);
> > +             memset(hpd, 0, mec_hpd_size);
> >
> > -     amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> > -     amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> > +             amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> > +             amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> > +     }
> >
> >       if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> >               mec_hdr = (const struct gfx_firmware_header_v1_0
> *)adev->gfx.mec_fw->data;
> > @@ -7162,7 +7164,7 @@ static int gfx_v10_0_early_init(void *handle)
> >               break;
> >       }
> >
> > -     adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> > +     adev->gfx.num_compute_rings = amdgpu_num_kcq;
> >
> >       gfx_v10_0_set_kiq_pm4_funcs(adev);
> >       gfx_v10_0_set_ring_funcs(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > index 8d72089..7df567a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -1343,21 +1343,22 @@ static int gfx_v8_0_mec_init(struct
> amdgpu_device *adev)
> >       amdgpu_gfx_compute_queue_acquire(adev);
> >
> >       mec_hpd_size = adev->gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
> > +     if (mec_hpd_size) {
> > +             r = amdgpu_bo_create_reserved(adev, mec_hpd_size,
> PAGE_SIZE,
> > +                                           AMDGPU_GEM_DOMAIN_VRAM,
> > +                                           &adev->gfx.mec.hpd_eop_obj,
> > +
>  &adev->gfx.mec.hpd_eop_gpu_addr,
> > +                                           (void **)&hpd);
> > +             if (r) {
> > +                     dev_warn(adev->dev, "(%d) create HDP EOP bo
> failed\n", r);
> > +                     return r;
> > +             }
> >
> > -     r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> > -                                   AMDGPU_GEM_DOMAIN_VRAM,
> > -                                   &adev->gfx.mec.hpd_eop_obj,
> > -                                   &adev->gfx.mec.hpd_eop_gpu_addr,
> > -                                   (void **)&hpd);
> > -     if (r) {
> > -             dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> > -             return r;
> > -     }
> > -
> > -     memset(hpd, 0, mec_hpd_size);
> > +             memset(hpd, 0, mec_hpd_size);
> >
> > -     amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> > -     amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> > +             amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> > +             amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> > +     }
> >
> >       return 0;
> >  }
> > @@ -5294,7 +5295,7 @@ static int gfx_v8_0_early_init(void *handle)
> >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >
> >       adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
> > -     adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> > +     adev->gfx.num_compute_rings = amdgpu_num_kcq;
> >       adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
> >       gfx_v8_0_set_ring_funcs(adev);
> >       gfx_v8_0_set_irq_funcs(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index e4e751f..ef07e59 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -1938,22 +1938,23 @@ static int gfx_v9_0_mec_init(struct
> amdgpu_device *adev)
> >       /* take ownership of the relevant compute queues */
> >       amdgpu_gfx_compute_queue_acquire(adev);
> >       mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
> > +     if (mec_hpd_size) {
> > +             r = amdgpu_bo_create_reserved(adev, mec_hpd_size,
> PAGE_SIZE,
> > +                                           AMDGPU_GEM_DOMAIN_VRAM,
> > +                                           &adev->gfx.mec.hpd_eop_obj,
> > +
>  &adev->gfx.mec.hpd_eop_gpu_addr,
> > +                                           (void **)&hpd);
> > +             if (r) {
> > +                     dev_warn(adev->dev, "(%d) create HDP EOP bo
> failed\n", r);
> > +                     gfx_v9_0_mec_fini(adev);
> > +                     return r;
> > +             }
> >
> > -     r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> > -                                   AMDGPU_GEM_DOMAIN_VRAM,
> > -                                   &adev->gfx.mec.hpd_eop_obj,
> > -                                   &adev->gfx.mec.hpd_eop_gpu_addr,
> > -                                   (void **)&hpd);
> > -     if (r) {
> > -             dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> > -             gfx_v9_0_mec_fini(adev);
> > -             return r;
> > -     }
> > -
> > -     memset(hpd, 0, mec_hpd_size);
> > +             memset(hpd, 0, mec_hpd_size);
> >
> > -     amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> > -     amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> > +             amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> > +             amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> > +     }
> >
> >       mec_hdr = (const struct gfx_firmware_header_v1_0
> *)adev->gfx.mec_fw->data;
> >
> > @@ -4625,7 +4626,7 @@ static int gfx_v9_0_early_init(void *handle)
> >               adev->gfx.num_gfx_rings = 0;
> >       else
> >               adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> > -     adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> > +     adev->gfx.num_compute_rings = amdgpu_num_kcq;
> >       gfx_v9_0_set_kiq_pm4_funcs(adev);
> >       gfx_v9_0_set_ring_funcs(adev);
> >       gfx_v9_0_set_irq_funcs(adev);
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000006fc86a05b1b6fb54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Monk or perhaps Felix,</div><div><br></div><div>Do yo=
u by any chance know why the CS ioctl returns -EINVAL for all compute submi=
ssions if num_kcq &lt;=3D 4 and what could cause that?</div><div><br></div>=
<div>If not, is there any way to disable mid-IB preemption for compute?<br>=
</div><div><br></div><div>Thanks,</div><div>Marek<br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 31, =
2020 at 9:53 AM Felix Kuehling &lt;<a href=3D"mailto:felix.kuehling@amd.com=
">felix.kuehling@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Am 2020-07-31 um 3:51 a.m. schrieb Monk Liu:<br>
&gt; what:<br>
&gt; the MQD&#39;s save and restore of KCQ (kernel compute queue)<br>
&gt; cost lots of clocks during world switch which impacts a lot<br>
&gt; to multi-VF performance<br>
&gt;<br>
&gt; how:<br>
&gt; introduce a paramter to control the number of KCQ to avoid<br>
&gt; performance drop if there is no kernel compute queue needed<br>
&gt;<br>
&gt; notes:<br>
&gt; this paramter only affects gfx 8/9/10<br>
&gt;<br>
&gt; v2:<br>
&gt; refine namings<br>
&gt;<br>
&gt; v3:<br>
&gt; choose queues for each ring to that try best to cross pipes evenly.<br=
>
&gt;<br>
&gt; v4:<br>
&gt; fix indentation<br>
&gt; some cleanupsin the gfx_compute_queue_acquire()<br>
&gt;<br>
&gt; v5:<br>
&gt; further fix on indentations<br>
&gt; more cleanupsin gfx_compute_queue_acquire()<br>
&gt;<br>
&gt; TODO:<br>
&gt; in the future we will let hypervisor driver to set this paramter<br>
&gt; automatically thus no need for user to configure it through<br>
&gt; modprobe in virtual machine<br>
&gt;<br>
&gt; Signed-off-by: Monk Liu &lt;<a href=3D"mailto:Monk.Liu@amd.com" target=
=3D"_blank">Monk.Liu@amd.com</a>&gt;<br>
<br>
This patch is Reviewed-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehl=
ing@amd.com" target=3D"_blank">Felix.Kuehling@amd.com</a>&gt;<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=C2=A0 5 +++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c=C2=A0 =C2=A0 |=C2=A0 4 +=
++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=C2=A0 =C2=A0 | 49 ++++++=
++++++------------------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c=C2=A0 =C2=A0 =C2=A0| 30 +=
++++++++---------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c=C2=A0 =C2=A0 =C2=A0 | 29 +=
++++++++---------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c=C2=A0 =C2=A0 =C2=A0 | 31 +=
+++++++++---------<br>
&gt;=C2=A0 7 files changed, 76 insertions(+), 73 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index e97c088..de11136 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -201,6 +201,7 @@ extern int amdgpu_si_support;<br>
&gt;=C2=A0 #ifdef CONFIG_DRM_AMDGPU_CIK<br>
&gt;=C2=A0 extern int amdgpu_cik_support;<br>
&gt;=C2=A0 #endif<br>
&gt; +extern int amdgpu_num_kcq;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define AMDGPU_VM_MAX_NUM_CTX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4096<br>
&gt;=C2=A0 #define AMDGPU_SG_THRESHOLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (256*1024*1024)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 62ecac9..cf445bab 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -1199,6 +1199,11 @@ static int amdgpu_device_check_arguments(struct=
 amdgpu_device *adev)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gmc_tmz_set(adev);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (amdgpu_num_kcq &gt; 8 || amdgpu_num_kcq &lt; =
0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_num_kcq =3D 8;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(adev-&gt;dev=
, &quot;set kernel compute queue number to 8 due to invalid paramter provid=
ed by user\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 6291f5f..b545c40 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -150,6 +150,7 @@ int amdgpu_noretry;<br>
&gt;=C2=A0 int amdgpu_force_asic_type =3D -1;<br>
&gt;=C2=A0 int amdgpu_tmz =3D 0;<br>
&gt;=C2=A0 int amdgpu_reset_method =3D -1; /* auto */<br>
&gt; +int amdgpu_num_kcq =3D -1;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct amdgpu_mgpu_info mgpu_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.mutex =3D __MUTEX_INITIALIZER(mgpu_info.mut=
ex),<br>
&gt; @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);<br=
>
&gt;=C2=A0 MODULE_PARM_DESC(reset_method, &quot;GPU reset method (-1 =3D au=
to (default), 0 =3D legacy, 1 =3D mode0, 2 =3D mode1, 3 =3D mode2, 4 =3D ba=
co)&quot;);<br>
&gt;=C2=A0 module_param_named(reset_method, amdgpu_reset_method, int, 0444)=
;<br>
&gt;=C2=A0 <br>
&gt; +MODULE_PARM_DESC(num_kcq, &quot;number of kernel compute queue user w=
ant to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+=
)&quot;);<br>
&gt; +module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);<br>
&gt; +<br>
&gt;=C2=A0 static const struct pci_device_id pciidlist[] =3D {<br>
&gt;=C2=A0 #ifdef=C2=A0 CONFIG_DRM_AMDGPU_SI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, CHIP_TAHITI},<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.c<br>
&gt; index 8eff017..0cd9de6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; @@ -202,40 +202,29 @@ bool amdgpu_gfx_is_high_priority_compute_queue(s=
truct amdgpu_device *adev,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev=
)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int i, queue, pipe, mec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i, queue, pipe;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool multipipe_policy =3D amdgpu_gfx_is_mult=
ipipe_capable(adev);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* policy for amdgpu compute queue ownership */<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; AMDGPU_MAX_COMPUTE_QUEUES; +=
+i) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue =3D i % adev-&g=
t;gfx.mec.num_queue_per_pipe;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe =3D (i / adev-&g=
t;gfx.mec.num_queue_per_pipe)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0% adev-&gt;gfx.mec.num_pipe_per_mec;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mec =3D (i / adev-&gt=
;gfx.mec.num_queue_per_pipe)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/ adev-&gt;gfx.mec.num_pipe_per_mec;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* we&#39;ve run out =
of HW */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mec &gt;=3D adev-=
&gt;gfx.mec.num_mec)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (multipipe_policy)=
 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* policy: amdgpu owns the first two queues of the first MEC */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (mec =3D=3D 0 &amp;&amp; queue &lt; 2)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(i, adev-&gt;gfx.mec.queue_bitmap=
);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* policy: amdgpu owns all queues in the first pipe */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (mec =3D=3D 0 &amp;&amp; pipe =3D=3D 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(i, adev-&gt;gfx.mec.queue_bitmap=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int max_queues_per_mec =3D min(adev-&gt;gfx.mec.n=
um_pipe_per_mec *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.mec.num_queu=
e_per_pipe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.num_compute_=
rings);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (multipipe_policy) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* policy: make queue=
s evenly cross all pipes on MEC1 only */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
max_queues_per_mec; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pipe =3D i % adev-&gt;gfx.mec.num_pipe_per_mec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0queue =3D (i / adev-&gt;gfx.mec.num_pipe_per_mec) %<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.mec.num_queue_per_pipe;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0set_bit(pipe * adev-&gt;gfx.mec.num_queue_per_pipe + queue,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx=
.mec.queue_bitmap);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* policy: amdgpu own=
s all queues in the given pipe */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
max_queues_per_mec; ++i)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0set_bit(i, adev-&gt;gfx.mec.queue_bitmap);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* update the number of active compute rings */<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_compute_rings =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bitmap_weight(adev-&g=
t;gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* If you hit this case and edited the policy, yo=
u probably just<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 * need to increase AMDGPU_MAX_COMPUTE_RINGS */<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0if (WARN_ON(adev-&gt;gfx.num_compute_rings &gt; A=
MDGPU_MAX_COMPUTE_RINGS))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_comp=
ute_rings =3D AMDGPU_MAX_COMPUTE_RINGS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_dbg(adev-&gt;dev, &quot;mec queue bitmap weig=
ht=3D%d\n&quot;, bitmap_weight(adev-&gt;gfx.mec.queue_bitmap, AMDGPU_MAX_CO=
MPUTE_QUEUES));<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *ade=
v)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v10_0.c<br>
&gt; index f571e25..4172bc8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -4022,21 +4022,23 @@ static int gfx_v10_0_mec_init(struct amdgpu_de=
vice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_compute_queue_acquire(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mec_hpd_size =3D adev-&gt;gfx.num_compute_ri=
ngs * GFX10_MEC_HPD_SIZE;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_create_reserved(adev, mec_hpd_siz=
e, PAGE_SIZE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMDGPU_GEM_DOMAIN_G=
TT,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gfx.m=
ec.hpd_eop_obj,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gfx.m=
ec.hpd_eop_gpu_addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void **)&amp;hpd);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(adev-&gt;dev=
, &quot;(%d) create HDP EOP bo failed\n&quot;, r);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_mec_fini(ad=
ev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (mec_hpd_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_creat=
e_reserved(adev, mec_hpd_size, PAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AMDGPU_GEM_DOMAIN_GTT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;adev-&gt;gfx.mec.hpd_eop_obj,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;adev-&gt;gfx.mec.hpd_eop_gpu_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(void **)&amp;hpd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_warn(adev-&gt;dev, &quot;(%d) create HDP EOP bo failed\n&quot;, =
r);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gfx_v10_0_mec_fini(adev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0memset(hpd, 0, mec_hpd_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(hpd, 0, mec_hp=
d_size);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0amdgpu_bo_kunmap(adev-&gt;gfx.mec.hpd_eop_obj);<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0amdgpu_bo_unreserve(adev-&gt;gfx.mec.hpd_eop_obj)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_kunmap(adev=
-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_unreserve(a=
dev-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;firmware.load_type =3D=3D AMDGP=
U_FW_LOAD_DIRECT) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mec_hdr =3D (con=
st struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.mec_fw-&gt;data;<br>
&gt; @@ -7162,7 +7164,7 @@ static int gfx_v10_0_early_init(void *handle)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_compute_rings =3D AMDGPU_MAX_COM=
PUTE_RINGS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_compute_rings =3D amdgpu_num_kcq=
;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_set_kiq_pm4_funcs(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_set_ring_funcs(adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c<br>
&gt; index 8d72089..7df567a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -1343,21 +1343,22 @@ static int gfx_v8_0_mec_init(struct amdgpu_dev=
ice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_compute_queue_acquire(adev);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mec_hpd_size =3D adev-&gt;gfx.num_compute_ri=
ngs * GFX8_MEC_HPD_SIZE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (mec_hpd_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_creat=
e_reserved(adev, mec_hpd_size, PAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AMDGPU_GEM_DOMAIN_VRAM,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;adev-&gt;gfx.mec.hpd_eop_obj,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;adev-&gt;gfx.mec.hpd_eop_gpu_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(void **)&amp;hpd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_warn(adev-&gt;dev, &quot;(%d) create HDP EOP bo failed\n&quot;, =
r);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_create_reserved(adev, mec_hpd_siz=
e, PAGE_SIZE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMDGPU_GEM_DOMAIN_V=
RAM,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gfx.m=
ec.hpd_eop_obj,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gfx.m=
ec.hpd_eop_gpu_addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void **)&amp;hpd);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(adev-&gt;dev=
, &quot;(%d) create HDP EOP bo failed\n&quot;, r);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0memset(hpd, 0, mec_hpd_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(hpd, 0, mec_hp=
d_size);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0amdgpu_bo_kunmap(adev-&gt;gfx.mec.hpd_eop_obj);<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0amdgpu_bo_unreserve(adev-&gt;gfx.mec.hpd_eop_obj)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_kunmap(adev=
-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_unreserve(a=
dev-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; @@ -5294,7 +5295,7 @@ static int gfx_v8_0_early_init(void *handle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D (struct amdgp=
u_device *)handle;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_gfx_rings =3D GFX8_NUM_GFX_=
RINGS;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_compute_rings =3D AMDGPU_MAX_COM=
PUTE_RINGS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_compute_rings =3D amdgpu_num_kcq=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.funcs =3D &amp;gfx_v8_0_gfx_fun=
cs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v8_0_set_ring_funcs(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v8_0_set_irq_funcs(adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index e4e751f..ef07e59 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -1938,22 +1938,23 @@ static int gfx_v9_0_mec_init(struct amdgpu_dev=
ice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* take ownership of the relevant compute qu=
eues */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_compute_queue_acquire(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mec_hpd_size =3D adev-&gt;gfx.num_compute_ri=
ngs * GFX9_MEC_HPD_SIZE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (mec_hpd_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_creat=
e_reserved(adev, mec_hpd_size, PAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AMDGPU_GEM_DOMAIN_VRAM,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;adev-&gt;gfx.mec.hpd_eop_obj,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;adev-&gt;gfx.mec.hpd_eop_gpu_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(void **)&amp;hpd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_warn(adev-&gt;dev, &quot;(%d) create HDP EOP bo failed\n&quot;, =
r);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gfx_v9_0_mec_fini(adev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_create_reserved(adev, mec_hpd_siz=
e, PAGE_SIZE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMDGPU_GEM_DOMAIN_V=
RAM,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gfx.m=
ec.hpd_eop_obj,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gfx.m=
ec.hpd_eop_gpu_addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void **)&amp;hpd);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(adev-&gt;dev=
, &quot;(%d) create HDP EOP bo failed\n&quot;, r);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v9_0_mec_fini(ade=
v);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0memset(hpd, 0, mec_hpd_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(hpd, 0, mec_hp=
d_size);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0amdgpu_bo_kunmap(adev-&gt;gfx.mec.hpd_eop_obj);<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0amdgpu_bo_unreserve(adev-&gt;gfx.mec.hpd_eop_obj)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_kunmap(adev=
-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_unreserve(a=
dev-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mec_hdr =3D (const struct gfx_firmware_heade=
r_v1_0 *)adev-&gt;gfx.mec_fw-&gt;data;<br>
&gt;=C2=A0 <br>
&gt; @@ -4625,7 +4626,7 @@ static int gfx_v9_0_early_init(void *handle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num=
_gfx_rings =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num=
_gfx_rings =3D GFX9_NUM_GFX_RINGS;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_compute_rings =3D AMDGPU_MAX_COM=
PUTE_RINGS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.num_compute_rings =3D amdgpu_num_kcq=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v9_0_set_kiq_pm4_funcs(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v9_0_set_ring_funcs(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v9_0_set_irq_funcs(adev);<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000006fc86a05b1b6fb54--

--===============1205023114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1205023114==--
