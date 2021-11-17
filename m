Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FECBC3525C
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 21:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1762E61265
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 21:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1762E61265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E736E0B8;
	Wed, 17 Nov 2021 21:54:47 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AAFE6E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 21:54:47 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 h19-20020a9d3e53000000b0056547b797b2so7232193otg.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 13:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wCZjo247i1TFZb6Jyxr4/V4jXSXfJ06uE+3gcgUfwm8=;
 b=azw+j2s2tFvRs4P2C4Ja1e8SIP0mOhfOohoufwi4tH5tjZTLOANSC+ZuTzbQ+ZVTl+
 xmblOwmpjEHLaS8+1ye67aH+qv8wt1Qo8MdW5aJIUHRB8VJUBf0fQpkzDMCJPga4qVL/
 cjJassTMAviJoXb5wm42cf2Oj6JRskJTDeWAYxwYkUq6489Zwe7S//AzXZyEGKkYpYT9
 6FTqniRSrxwyk3XcgYleXuB3QeZAS38aWXq0GKHKlxlBSK1g/5QhMasYFdh5mBEkkRpo
 k+0r9/YQVUhD4ljGcioQZvmu/U0VsvNsPAhwxzNyhWtXJQODZ7xaaqCjXvaYkz/3i9bu
 UZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wCZjo247i1TFZb6Jyxr4/V4jXSXfJ06uE+3gcgUfwm8=;
 b=u3XTtnCXjnnbuqtipO39y4wdpwOELLi77tJWVvJmvSX/Tj7sscULGWHN2ZeTuq+6Yc
 0qhNPq6RqZ9hSutL4yUY81kD8FLcDYs7o4ZT5guevqkXBWyw+a81wAHN5GPFqzt+NZLc
 b1MnAv2W7l6In7wybs/d+7wzmlUd3yj33DGyKojN069ViOJmPw2K5NyFsay2/w4ZIf/s
 wOiVSQDz9NkNz2veuEjNU2qxol6uXI3bqziYZnqREK5EGVIp0HPyrauYuT8tmRJmZ/Rp
 xMO4bbWCDAZLeSdyCtvcsjejLlRAowJv9+7dJT51u6XzZp6DWgRowyjJS0lTgo7Q9tVo
 4LNw==
X-Gm-Message-State: AOAM530frbnt0LxCjeDy09uu4ges0iq5MTw8jIN3GfKXkO8IBZmeEWOs
 mYMTZLZIOTfIXObmBPe9I/8Fwy/9tCekJSOAHcpdY4ECaU4=
X-Google-Smtp-Source: ABdhPJxeHvh8NiBtYnCyu7XTLSFJX7Z30dNwNTKUN1xJ9zaqnpa8u0JD/2ev0wkuew1yhdHGDCryI6I4GWeH7iY1N/8=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr17055704ota.200.1637186086522; 
 Wed, 17 Nov 2021 13:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20211117185512.102807-1-luben.tuikov@amd.com>
In-Reply-To: <20211117185512.102807-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Nov 2021 16:54:35 -0500
Message-ID: <CADnq5_PkhsvBm_+Yz+JcUEY7dxeeiwiTMM89w_DVxTjPBQwsPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: Add debug prints
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 17, 2021 at 1:56 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Add prints where there are none and none are printed in the callee.
>
> Add a print in sienna_cichlid_run_btc() to help debug and to mirror other
> platforms, as no print is present in the caller, smu_smc_hw_setup().
>
> Remove the word "previous" from comment and print to make it shorter and
> avoid confusion in various prints.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 8 +++++---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 +++++++-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 01168b8955bff3..67cc6fb4f422f4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1153,6 +1153,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>                 case IP_VERSION(11, 5, 0):
>                 case IP_VERSION(11, 0, 12):
>                         ret = smu_system_features_control(smu, true);
> +                       if (ret)
> +                               dev_err(adev->dev, "Failed system features control!\n");
>                         break;
>                 default:
>                         break;
> @@ -1277,8 +1279,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>         }
>
>         ret = smu_notify_display_change(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to notify display change!\n");
>                 return ret;
> +       }
>
>         /*
>          * Set min deep sleep dce fclk with bootup value from vbios via
> @@ -1286,8 +1290,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>          */
>         ret = smu_set_min_dcef_deep_sleep(smu,
>                                           smu->smu_table.boot_values.dcefclk / 100);
> -       if (ret)
> -               return ret;
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b0bb389185d51c..f3522320df7e58 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2135,7 +2135,13 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
>
>  static int sienna_cichlid_run_btc(struct smu_context *smu)
>  {
> -       return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
> +       int res;
> +
> +       res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
> +       if (res)
> +               dev_err(smu->adev->dev, "RunDcBtc failed!\n");
> +
> +       return res;

Maybe better to split this hunk into a separate patch and also fix up
the run_btc functions for other asics.

Alex


>  }
>
>  static int sienna_cichlid_baco_enter(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index ea6f50c08c5f3b..f9a42a07eeaebf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -97,7 +97,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>   * smu: a pointer to SMU context
>   *
>   * Returns the status of the SMU, which could be,
> - *    0, the SMU is busy with your previous command;
> + *    0, the SMU is busy with your command;
>   *    1, execution status: success, execution result: success;
>   * 0xFF, execution status: success, execution result: failure;
>   * 0xFE, unknown command;
> @@ -143,7 +143,7 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
>                 u32 msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
>                 u32 prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>                 dev_err_ratelimited(adev->dev,
> -                                   "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
> +                                   "SMU: I'm not done with your command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
>                                     msg_idx, prm);
>         }
>                 break;
>
> base-commit: ae2faedcc13fa5ee109ceb9e8cc05d759ad57980
> --
> 2.34.0
>
