Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F03C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027412076B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELQIFif7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027412076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8F289BF0;
	Tue, 29 Sep 2020 17:45:28 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0942F89BF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 17:45:27 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id t17so3075097wmi.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TL6ovIFNf/DVBxQX4f9GOFMFrpbcYTQ1b+bXhZrJ8YE=;
 b=ELQIFif7od1+VZwEbjT5ltFOEhHvDURWvHkXVy8uSStPS1sy9CybINi98ux6VZuk69
 BAiJrz3F1RITEcl5oaKls3Fas4QCxJIalUla8gsYXXLXUy/qq0vFBoIYALuPoVWDVc6C
 XOge63PpTzVbE2nIsuuV6cKI3s+qiZFI1eG0yCcvb4gMvE+rFj2WJ3mV87dVT3YNl00c
 l73Ne2mpv5RIUEQ0VhLNSBOdwavTQJFzzpubS0EU4zq6B+XUGys53t4FnqCWvbi/Vukn
 PyWdWtnAqRNBLtPQuHK4ZsiVgGvmfedq2z/snkvV3hc+VlVfVFSPP5DW7m/tLJ2pRZvN
 Tc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TL6ovIFNf/DVBxQX4f9GOFMFrpbcYTQ1b+bXhZrJ8YE=;
 b=ip1vKZOGKF17Vr3IA8dR4xob3wD7ZONaALT6UfpWmRcLltXMEGL48BpFJU08DXHL7z
 lisUN5qmPSSW0QKbFZYfkBPwubdXkfBij/cR0KS6yRI2G10dU1nm24qKCG+yGZIG4Wnu
 NT/LGPAbD8zFfCC1y9ozFHB2Q26W5T6F2/3RCPhpz1bPGWVE2+Wpbzrh4OvNKEd3/M86
 zdHWLRWYl0tf/aNyIT4LFbtxYWyQHBBaTU3t/r3NGdSjl9NWISQrL/fKOFLK+2gCDdhk
 jZtCiF2sFA09TL5f2/llCzJ3nBQHKH6hFnjhJjGc5WsllLhyHr168A0e6C+vxlB0IQLK
 iNeg==
X-Gm-Message-State: AOAM5308/og6cQyMZIaAOzNytmAN9rQwrpmFG1Z4a4hkDqjRw/H2euI8
 Qv9/nZSVhIfsvuIRDeNlXDfrOZMkmnk1VGuk9nH8epu6Izc=
X-Google-Smtp-Source: ABdhPJyjLQx0WVix9rRO6Av8n7xjC4GDnm3Z6OWI5UxBYz0DuGpJ/UJrA0wmRCz2BTMji3mVglVmJxAx5rE3wELjIno=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr5745118wme.39.1601401525691; 
 Tue, 29 Sep 2020 10:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200929172549.24920-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200929172549.24920-1-Ramesh.Errabolu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 13:45:14 -0400
Message-ID: <CADnq5_OaTb8UoXS=BRBm8QpY=ADLe06MHgm1-AneDsWXgitmYw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 29, 2020 at 1:26 PM Ramesh Errabolu <Ramesh.Errabolu@amd.com> wrote:
>
> [Why]
> Allow user to know number of compute units (CU) that are in use at any
> given moment.
>
> [How]
> Read registers of SQ that give number of waves that are in flight
> of various queues. Use this information to determine number of CU's
> in use.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 +++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h | 3 +++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 346d8288f6ab..b1ab9fd02db7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -49,6 +49,7 @@
>  #include "amdgpu_ras.h"
>
>  #include "gfx_v9_4.h"
> +#include "gfx_v9_0.h"
>
>  #include "asic_reg/pwr/pwr_10_0_offset.h"
>  #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
> @@ -786,9 +787,8 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
>  static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
>  static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
> -                                 struct amdgpu_cu_info *cu_info);
> +                               struct amdgpu_cu_info *cu_info);

unrelated whitespace change.  Please drop.

>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);
>  static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
>  static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>  static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> @@ -2397,7 +2397,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
>         /* TODO */
>  }
>
> -static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance)
> +void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
> +                          u32 instance)
>  {
>         u32 data;
>
> @@ -6924,7 +6925,7 @@ static u32 gfx_v9_0_get_cu_active_bitmap(struct amdgpu_device *adev)
>  }
>
>  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
> -                                struct amdgpu_cu_info *cu_info)
> +               struct amdgpu_cu_info *cu_info)

Unrelated whitespace change. Please drop.

Alex

>  {
>         int i, j, k, counter, active_cu_number = 0;
>         u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> index 407472031daa..dfe8d4841f58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> @@ -26,4 +26,7 @@
>
>  extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
>
> +void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
> +                          u32 instance);
> +
>  #endif
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
