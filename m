Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55781C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 22:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20947214D8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 22:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewcUSFAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20947214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59CF6E144;
	Tue, 28 Jan 2020 22:26:41 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11EE76E144
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 22:26:41 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t23so4245684wmi.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 14:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zfJVhJCF9XrnStKtymgQ5wt7up5lujprnIz+VOh7BjQ=;
 b=ewcUSFAoVF4Z+cw82822veTv/2W+eznnweNW/W8dkcspSUvgOlPZ4mDM/txDS72y8R
 EqtlfTeqmRCRNluMteBjkin4klQ6BVrsg8XZa9RZWy9LcGQjHjhvSplLzFJjG1s5BBCU
 gDeR2fqS8V5hWwqnVF3dciPvknhk0HyvaLWYOQhP/FYWf78Pk6oqo4gbG0OnEui0yoDr
 DnBMS+PhlHPj7vO/UFbObHHDgLas3TpbzKRJBX+0ZMmW1ctrircoAD4oB+29LSlSYyN1
 9n6Z3jcX0Q7YbIulUi8nY5gbs/oJOwIz/ZCdbvtuq/Z8RHvIrHMtFCiQfDpYjWys+WcW
 6ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zfJVhJCF9XrnStKtymgQ5wt7up5lujprnIz+VOh7BjQ=;
 b=U2GUU4ebrLo9nD2G6FXUe3xRlO4aaSRPmcHXC0U4d3zg85D3k5zCkCztIZRkVy/Bvr
 qT9TU2gFGp0ouiSzZGV6ZQP/M+Cz/S9lQhoDtZK1jzRmhNiIs1TkzzRSMtH/iXLqSnrq
 GiSTLczMyfvSaaMFl+cx35C5Vtio454Gy1N35Bo/S2bOU7inZmE+Ui5AINbE5sMA0uSb
 3GI+vlKhPkYS5aWm8rSqE5aHcVzFXfcM9SXVHmFKaFfo4moTd2kTyhdMNzTVe3wVSEj0
 KOtIg2iC1IcN5AWXCB0eb1txAekvwRCC4TP5zUmoYZWxRfB9deJEIr5m/P/rAjgnoxgw
 GPRQ==
X-Gm-Message-State: APjAAAULA2ri+XorTDNxW06jajlot/6O3+yqyuaZOJ0qfLkKjBZ97sir
 3yEiJYGYsIAdn6H0GPLSXTpw4VbVHlMpVxKcehw=
X-Google-Smtp-Source: APXvYqxA27zD7Jcl78cv1UiHDzLFRlVsQAEl0BNwUjsUgK8IDOqxQFGBElbay23DEE1RfEHB3g3CPccfPyrkSSuuWyI=
X-Received: by 2002:a7b:c152:: with SMTP id z18mr7154659wmi.70.1580250399719; 
 Tue, 28 Jan 2020 14:26:39 -0800 (PST)
MIME-Version: 1.0
References: <f63fecc3-fd56-55cb-4bcf-178ead1628d6@gmail.com>
 <20200128201009.90607-1-mcoffin13@gmail.com>
In-Reply-To: <20200128201009.90607-1-mcoffin13@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2020 17:26:28 -0500
Message-ID: <CADnq5_MEByspseDhv=ca0X7XhTDz_Uh4w6WfMovDtEydJ0snRA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu_v11_0: Correct behavior of restoring
 default tables
To: Matt Coffin <mcoffin13@gmail.com>
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

On Tue, Jan 28, 2020 at 3:10 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> Previously, the syfs functionality for restoring the default powerplay
> table was sourcing it's information from the currently-staged powerplay
> table.
>
> This patch adds a step to cache the first overdrive table that we see on
> boot, so that it can be used later to "restore" the powerplay table

Missing your signed-off by.  With that fixed, patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  9 +++---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  6 ++++
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    | 28 ++++++-------------
>  4 files changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index b0591a8dda41..1e33c3e9b98d 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -273,6 +273,7 @@ struct smu_table_context
>         uint8_t                         thermal_controller_type;
>
>         void                            *overdrive_table;
> +       void                            *boot_overdrive_table;
>  };
>
>  struct smu_dpm_context {
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index f60762f9b143..26cfccc57331 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2064,12 +2064,11 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>                 od_table->UclkFmax = input[1];
>                 break;
>         case PP_OD_RESTORE_DEFAULT_TABLE:
> -               ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
> -               if (ret) {
> -                       pr_err("Failed to export over drive table!\n");
> -                       return ret;
> +               if (!(table_context->overdrive_table && table_context->boot_overdrive_table)) {
> +                       pr_err("Overdrive table was not initialized!\n");
> +                       return -EINVAL;
>                 }
> -
> +               memcpy(table_context->overdrive_table, table_context->boot_overdrive_table, sizeof(OverDriveTable_t));
>                 break;
>         case PP_OD_COMMIT_DPM_TABLE:
>                 navi10_dump_od_table(od_table);
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 02f8c9cb89d9..0dc49479a7eb 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1882,6 +1882,12 @@ int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize,
>                         pr_err("Failed to export overdrive table!\n");
>                         return ret;
>                 }
> +               if (!table_context->boot_overdrive_table) {
> +                       table_context->boot_overdrive_table = kmemdup(table_context->overdrive_table, overdrive_table_size, GFP_KERNEL);
> +                       if (!table_context->boot_overdrive_table) {
> +                               return -ENOMEM;
> +                       }
> +               }
>         }
>         ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, true);
>         if (ret) {
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 38febd5ca4da..4ad8d6c14ee5 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -1706,22 +1706,11 @@ static int vega20_set_default_od_settings(struct smu_context *smu,
>         struct smu_table_context *table_context = &smu->smu_table;
>         int ret;
>
> -       if (initialize) {
> -               if (table_context->overdrive_table)
> -                       return -EINVAL;
> -
> -               table_context->overdrive_table = kzalloc(sizeof(OverDriveTable_t), GFP_KERNEL);
> -
> -               if (!table_context->overdrive_table)
> -                       return -ENOMEM;
> -
> -               ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> -                                      table_context->overdrive_table, false);
> -               if (ret) {
> -                       pr_err("Failed to export over drive table!\n");
> -                       return ret;
> -               }
> +       ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
> +       if (ret)
> +               return ret;
>
> +       if (initialize) {
>                 ret = vega20_set_default_od8_setttings(smu);
>                 if (ret)
>                         return ret;
> @@ -2778,12 +2767,11 @@ static int vega20_odn_edit_dpm_table(struct smu_context *smu,
>                 break;
>
>         case PP_OD_RESTORE_DEFAULT_TABLE:
> -               ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
> -               if (ret) {
> -                       pr_err("Failed to export over drive table!\n");
> -                       return ret;
> +               if (!(table_context->overdrive_table && table_context->boot_overdrive_table)) {
> +                       pr_err("Overdrive table was not initialized!\n");
> +                       return -EINVAL;
>                 }
> -
> +               memcpy(table_context->overdrive_table, table_context->boot_overdrive_table, sizeof(OverDriveTable_t));
>                 break;
>
>         case PP_OD_COMMIT_DPM_TABLE:
> --
> 2.25.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
