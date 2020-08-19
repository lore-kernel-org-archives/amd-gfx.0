Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B72DC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 20:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587492078D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 20:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ1ubsJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587492078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3B06E81C;
	Wed, 19 Aug 2020 20:46:14 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8744A6E81C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 20:46:13 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f1so44923wro.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tSQSHpzFV/vlzyA1MZ8Ulkop1jGiHqoKfatmgWq/IbA=;
 b=mZ1ubsJ9hA+H2XcZZWe+ewqXW19CyMMVf2Uu6Z2tmlfIBj/OCAJzafPNZHmFEk+fL+
 pOYjT4K/V7fsa4oXWKweH/fQLHyZk7x4exRvWCSUE90WbzlhsPGIGIKAdgC+3b9iVtv2
 QqB5dWwrFHN5S6Qls6BgHksrRPyDUIY7Ixtyo9X6MZ2dIA51IUlboHPy70Vbv3KffcPZ
 H54Hi6P3F94a/T5ghG5vXQEhABx2pCAGT4tKG6cRhB0fKOWITDvHWpyPWH4f1JdZq1eY
 R3/stYv+ZYXCfktIPPtY9TCEwipY6V0ZxsFKlIZwzLq6vdFx/e+2lZKTXpWW3FjRZ5fO
 CvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tSQSHpzFV/vlzyA1MZ8Ulkop1jGiHqoKfatmgWq/IbA=;
 b=QIXpy1A1npMVMSZrROKdK/bfIESjfNiJmOuNDnncZxE40bviGJ6PFadX8hql5V6nCH
 yOZy//Y0rcEyXzESa7z+KIpnjHyR8uhAqhCZpA9pq5o2R0jTssfeFjA0zsLFUXfvYIjc
 3cawTsRvJZHFGpHANyEpl1QnPDWi9w0IaNF+GDG7eS8uHQOBXSgjK5AOBsDw4H94wKrp
 OaM8UfwzXHvPehqeOHMXKhoSf8JUmRt6d4pZlnbyOfKZcb9N5plcrqeVze2qYmCGNyJ8
 xf6rHS1oEhNk4HmsCZqJJDCje8+gyAvTMAUv2pWRpgtAzt6sd4sW+G2tYBRP0yhmjfFj
 DTig==
X-Gm-Message-State: AOAM5318cXDgMj6YvefRWjR4LgLH/3bKJEnwAzPhKD29H/JTq0t1b5RQ
 h6TwXUk8YDu9laQUF0sqNOKsX82lyyZOZpP284c=
X-Google-Smtp-Source: ABdhPJz6Oj+OMpvUvVjlF8gzf7T4OWrONovmXy2UIY779bElP/DNlLXn6fuSYlLa1rVmP7+ZXBUS0j+apME60wPRPp0=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr28315924wrs.124.1597869972041; 
 Wed, 19 Aug 2020 13:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200819095833.11420-1-evan.quan@amd.com>
In-Reply-To: <20200819095833.11420-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Aug 2020 16:46:01 -0400
Message-ID: <CADnq5_OG3sFBkAtEN=N+FBvyF+E0Rb6qwAkdHT5WQdg4vW-WsA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amd/pm: correct gfx and pcie settings on umd
 pstate switching
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 19, 2020 at 5:58 AM Evan Quan <evan.quan@amd.com> wrote:
>
> For entering UMD stable Pstate, the operations to enter rlc_safe
> mode, disable mgcg_perfmon and disable PCIE aspm are needed. And
> the opposite operations should be performed on UMD stable Pstate
> exiting.
>
> Change-Id: Iff4aa465fd16f55a4f4de8ee0503997b204f8f9d
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Might want to add stub callbacks for si.c, cik.c, vi.c as well to
avoid unwanted crashes if this ends up getting used elsewhere.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 3 +++
>  drivers/gpu/drm/amd/amdgpu/nv.c           | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/soc15.c        | 7 +++++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
>  4 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8ba389780001..6ff4ddb09d1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -617,6 +617,8 @@ struct amdgpu_asic_funcs {
>         uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
>         /* device supports BACO */
>         bool (*supports_baco)(struct amdgpu_device *adev);
> +       /* enter/exit umd stable pstate */
> +       int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
>  };
>
>  /*
> @@ -1132,6 +1134,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  #define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
>  #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
>  #define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco((adev))
> +#define amdgpu_asic_update_umd_stable_pstate(adev, enter) (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter))
>
>  #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 54e941e0db60..d07c84a7543d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -691,6 +691,12 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
>         adev->doorbell_index.sdma_doorbell_range = 20;
>  }
>
> +static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
> +                                      bool enter)
> +{
> +       return 0;
> +}
> +
>  static const struct amdgpu_asic_funcs nv_asic_funcs =
>  {
>         .read_disabled_bios = &nv_read_disabled_bios,
> @@ -710,6 +716,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
>         .need_reset_on_init = &nv_need_reset_on_init,
>         .get_pcie_replay_count = &nv_get_pcie_replay_count,
>         .supports_baco = &nv_asic_supports_baco,
> +       .update_umd_stable_pstate = &nv_update_umd_stable_pstate,
>  };
>
>  static int nv_common_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 3cd98c144bc6..d9671db3b98d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1029,6 +1029,12 @@ static uint64_t soc15_get_pcie_replay_count(struct amdgpu_device *adev)
>         return (nak_r + nak_g);
>  }
>
> +static int soc15_update_umd_stable_pstate(struct amdgpu_device *adev,
> +                                         bool enter)
> +{
> +       return 0;
> +}
> +
>  static const struct amdgpu_asic_funcs soc15_asic_funcs =
>  {
>         .read_disabled_bios = &soc15_read_disabled_bios,
> @@ -1049,6 +1055,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
>         .need_reset_on_init = &soc15_need_reset_on_init,
>         .get_pcie_replay_count = &soc15_get_pcie_replay_count,
>         .supports_baco = &soc15_supports_baco,
> +       .update_umd_stable_pstate = &soc15_update_umd_stable_pstate,
>  };
>
>  static const struct amdgpu_asic_funcs vega20_asic_funcs =
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8eb5b92903cd..db0f1718087d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1442,6 +1442,7 @@ static int smu_enable_umd_pstate(void *handle,
>                                                                AMD_CG_STATE_UNGATE);
>                         smu_gfx_ulv_control(smu, false);
>                         smu_deep_sleep_control(smu, false);
> +                       amdgpu_asic_update_umd_stable_pstate(smu->adev, true);
>                 }
>         } else {
>                 /* exit umd pstate, restore level, enable gfx cg*/
> @@ -1449,6 +1450,7 @@ static int smu_enable_umd_pstate(void *handle,
>                         if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
>                                 *level = smu_dpm_ctx->saved_dpm_level;
>                         smu_dpm_ctx->enable_umd_pstate = false;
> +                       amdgpu_asic_update_umd_stable_pstate(smu->adev, false);
>                         smu_deep_sleep_control(smu, true);
>                         smu_gfx_ulv_control(smu, true);
>                         amdgpu_device_ip_set_clockgating_state(smu->adev,
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
