Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7E3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C98410E236;
	Fri,  4 Feb 2022 18:53:15 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F5F10E236
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:53:13 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id q8so9558864oiw.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Feb 2022 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5mU0xz3nn47DwgBQi8eM74PfNGfyVF+0vkW+I5HGRDo=;
 b=eroMk+LtifGfrHUn4hu6+1yxNbLJY0ij4QTvUBKwV4DKrekYmDdY4hqP3recw90AUm
 eJgFYkUCiQQ3w26ptA2qlNQwTS4ElYEh9uhoUnUgnfx2hcaLqRDmbTUE/Pu5ZPXmLLhH
 ygDZfzBUXcVZlZH/mZ6gWtZ0t6yVJwzxViQLXe0fv3iJA/qyZBOy3ka7mY0zxTHPeSSh
 tvLZ35tqi7J1GXKwSzazA0CA5Cp7IBSw/MULTI3JoowFJn2zmWk3jK8J+4h17A0kehnv
 HOAAcHEcdiCNfy0ddYC9+xUN38zWlILXCJGSbGBDAbFPa4liwurzS/BdE+jUXU9QxvUk
 eW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5mU0xz3nn47DwgBQi8eM74PfNGfyVF+0vkW+I5HGRDo=;
 b=TzLqp/oBHgvaLDnkuhQnYtgSBjFRzOd7LwCjzB49YWkOCaxJJMWdBjaZU9e6QDlUK9
 EPPWpoBN452g0xkGS4qFEy2j0VgAEbts9JgapC1XH1EUCb+sQygbZdxfvzcXdDxt8u1I
 4lvqxL+OyIeHe27opp/12FEUAtIPDG+02RqLbWBlOe4wlimrgO+oUnRc2xOnGKBazel2
 DthF1m4ILMkEGPfVtuLonFzp3za0ucwc1OmxNnchvRjqyGptZ0xAPGrne42Dshyip9ed
 nysvEex7BWC8kdkbg46C2lJXYMDQMOFChzbkBfNeO3Q3idGUbaOvHvrxlNhx0YNg0gMT
 hLrg==
X-Gm-Message-State: AOAM532Q2Yd2c2+gkc+9isvIi+3N03HAQvRh1FY2u3DS+gjr+tqnk0x6
 bjlEFfRPlwpJIyb4Gbe4tbBNILRGMaZKPzLAE/bnhcYF
X-Google-Smtp-Source: ABdhPJzOdv247mtLB/hDKxzweLIwYV1N9OTSrGxv9mmBdWi9F7+L6R6kzYGC1Xrf0/X7ZTxpk9Wg9aG7C3QAZUEmroA=
X-Received: by 2002:a05:6808:2011:: with SMTP id
 q17mr2113911oiw.199.1644000792854; 
 Fri, 04 Feb 2022 10:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20220204184756.5387-1-luben.tuikov@amd.com>
In-Reply-To: <20220204184756.5387-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Feb 2022 13:53:01 -0500
Message-ID: <CADnq5_OYjK2mgzzybgKTSM4XmizWjxBcG4a44NcDTqtMLY9y5w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Set FRU bus for Aldebaran and Vega 20
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Roy Sun <Roy.Sun@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 4, 2022 at 1:48 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> The FRU and RAS EEPROMs share the same I2C bus on Aldebaran and Vega 20
> ASICs. Set the FRU bus "pointer" to this single bus, as access to the FRU
> is sought through that bus "pointer" and not through the RAS bus "pointer".
>
> Cc: Roy Sun <Roy.Sun@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Fixes: 9c6d2ba7057abb ("drm/amd: Expose the FRU SMU I2C bus")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index 87acb089cfccd5..dd2d66090d2374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -741,7 +741,7 @@ int smu_v11_0_i2c_control_init(struct amdgpu_device *adev)
>         i2c_set_adapdata(control, smu_i2c);
>
>         adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
> -       adev->pm.fru_eeprom_i2c_bus = NULL;
> +       adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
>
>         res = i2c_add_adapter(control);
>         if (res)
> @@ -756,6 +756,7 @@ void smu_v11_0_i2c_control_fini(struct amdgpu_device *adev)
>
>         i2c_del_adapter(control);
>         adev->pm.ras_eeprom_i2c_bus = NULL;
> +       adev->pm.fru_eeprom_i2c_bus = NULL;
>  }
>
>  /*
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index ba4c9771ffc56b..3d96d4af92d97f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1583,6 +1583,7 @@ static int aldebaran_i2c_control_init(struct smu_context *smu)
>         }
>
>         adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
> +       adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;

Does this need to be set to NULL in control_fini() for consistency?
Other than that, looks good to me.

Alex


>
>         return 0;
>  Out_err:
>
> base-commit: 24b54e10043609a55194badff58bf91189c49793
> prerequisite-patch-id: d694f05bfcdf100c1d6957afa209e304dad98404
> prerequisite-patch-id: b106a5bd7e0d3a7c225a767ca4384162353cca9a
> prerequisite-patch-id: 77d04393fc872e4f4dd158659bd44ba40b749883
> --
> 2.35.0.3.gb23dac905b
>
