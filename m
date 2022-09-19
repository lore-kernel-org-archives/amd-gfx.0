Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA31CECAAD3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 13:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B444010E09A;
	Mon, 19 Sep 2022 13:48:19 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C7410E09A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 13:48:16 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id w125so14676416oig.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=1iWTU9TcfGeHDVuRaIoEVHJc+7qWuWI4ZiHZSs6S04c=;
 b=HpnJ3lcVZ8vWdIXkuq2Mzrnnef9A9tkItPkU/MFnPSHyfobqDQW49t1Vf6o15LB4pS
 sqyZL/JUCEkQ1OgZDzG8ruABwK991SyoGkKDnfuK+LMzxtKv6j6//u/dinI4itwSCJW7
 vIsqUm5yDdHLHQQ4E2KrYlP5HIlJALTnqateQlMjT7lJpZF6frs7bxH/lLuEExZt1dQM
 FJxnPO/ejWpTYyTvi6/Z2tn6+khBQDNToL3x4RZvRmWnfABgDoYhn0mo/HrG7sd2JRiN
 p9l1AJHtuPkCXaTHOPBfY3mCeJUt2qbpzeGgevgX5vNwD2iN63dRY1X+fFAs2mJuF2d3
 RL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=1iWTU9TcfGeHDVuRaIoEVHJc+7qWuWI4ZiHZSs6S04c=;
 b=VJ86sTSiSkdbcCZwv3IflC9nqV0OfeFNJIfnL/ICcJkaVFPkH4ziah2iONAqCEoyQG
 rcm+TNQUMQH9vJrxsBvVLQeG2XIeT0TSMKL3jLum8U5prHSgLw5Q2a7DV0KvQJ57cGM0
 iIXPe5zUr0upfivbTQa/q+pidrA3S4gq5kdDWhONrAcvl+XfOZaE4YbiLR18PkiJj5Xv
 0nFVfpcx65qjKeItA315zWIjShMrZQ77vXaUxhG7H2rfUWgJfDoQaHYldXw8dFCgl0Oa
 KES7qD/B5RsMy9LB7L5NxSwSWlOBfY1u6TLJ+SAaUC0f5WM+GIWsaytHIsE8V9V6w1/r
 REWw==
X-Gm-Message-State: ACrzQf1xZejuW25WeyYDiAbbmsfQS+IpYeUTaZCEM7JpwOH0Dbd5NN7P
 t0Z4o6+8VodJJccfzZpiTtTSRCJtWUNcX1aivS7K36ug
X-Google-Smtp-Source: AMsMyM6NNyTxp3HUuJLcUZHNJM2qQj/qRkPMwdJ1dpheE0Aw59fHWBWqBPy/b4qIGQu94jaFqaw0vAQsOQ8/8/Qj91c=
X-Received: by 2002:a05:6808:2194:b0:350:cb3d:ecd2 with SMTP id
 be20-20020a056808219400b00350cb3decd2mr316581oib.46.1663595295650; Mon, 19
 Sep 2022 06:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220919020251.7048-1-evan.quan@amd.com>
 <20220919020251.7048-4-evan.quan@amd.com>
In-Reply-To: <20220919020251.7048-4-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Sep 2022 09:48:04 -0400
Message-ID: <CADnq5_MUdrUQ503YOCY9j-ODRY_dYA8LpO1HfXxa-ynx9vdekQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] drm/amd/pm: move SMU13.0.0 related pptable
 settings to smu_v13_0_0_ppt.c
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, guchun.chen@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Sep 18, 2022 at 10:04 PM Evan Quan <evan.quan@amd.com> wrote:
>
> Separate those ASIC specific settings from common helpers.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ie3224b8719d48c6e6936b738df379959bd1df4ad
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  1 -
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 16 +++++++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 610f9b68ef73..7adbdd3cc13b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1027,7 +1027,6 @@ static void smu_interrupt_work_fn(struct work_struct *work)
>  static void smu_pptable_source_init(struct smu_context *smu)
>  {
>         switch (smu->adev->ip_versions[MP1_HWIP][0]) {
> -       case IP_VERSION(13, 0, 0):

Is this change intended?

Alex

>         case IP_VERSION(13, 0, 7):
>                 smu->pptable_source = PPTABLE_SOURCE_PMFW;
>                 smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 1d454485e0d9..fd405e2420cd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -377,9 +377,12 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0;
>
> -       ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
> -                                               &smu_table->power_play_table,
> -                                               &smu_table->power_play_table_size);
> +       if (smu->pptable_source == PPTABLE_SOURCE_PMFW)
> +               ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
> +                                                       &smu_table->power_play_table,
> +                                                       &smu_table->power_play_table_size);
> +       else
> +               ret = smu_v13_0_setup_pptable(smu);
>         if (ret)
>                 return ret;
>
> @@ -1753,6 +1756,12 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
>         return ret;
>  }
>
> +static void smu_v13_0_0_pptable_source_init(struct smu_context *smu)
> +{
> +       smu->pptable_source = PPTABLE_SOURCE_PMFW;
> +       smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
> +}
> +
>  static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>         .get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
>         .set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
> @@ -1822,6 +1831,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>         .mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
>         .mode1_reset = smu_v13_0_mode1_reset,
>         .set_mp1_state = smu_v13_0_0_set_mp1_state,
> +       .pptable_source_init = smu_v13_0_0_pptable_source_init,
>  };
>
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> --
> 2.34.1
>
