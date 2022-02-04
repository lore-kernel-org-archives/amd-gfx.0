Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6516DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FC710E663;
	Fri,  4 Feb 2022 18:57:47 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372DE10E663
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:57:46 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 t75-20020a4a3e4e000000b002e9c0821d78so5682416oot.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Feb 2022 10:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MjNNX1RznjtPOSdKh98jRpOr9eMyD3CED5eAGb2d4PE=;
 b=O+NkeVzbIn9tQfW7kCe7ylpMCtxcLS30Qqw1Wd2P0zAwGtbT1X2hD3aOrmMZDyVJgC
 kDvmu2E64Ps5ZGe1CJtFWlhatbrMX0TQDzEG0WD/OMO+4+jouG/Lwoe0vGzdFpMGxamz
 7iO0vuRE8kRzt19y7jBx/MEE+c9FEKsuKXeFirIzELsZnuMdXKYyUbWzs4i3vBCo89WG
 ddumGFsmH7yvy5rcuK9HlhiQKUbqls2Md0GcuLbV3Ov4HL4r0rfLmNib+PSX64owI7gE
 1tA/E7q5CC1ADHqW1nUNtqgivMCGbaah3wGgNigFiwL9XLlWjRGEKvNPZSWnY+Q9ECA5
 Ev0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MjNNX1RznjtPOSdKh98jRpOr9eMyD3CED5eAGb2d4PE=;
 b=OXJZ9AG4vVaT7ZTMfdeCJBnGii+YgCN70FnWMOCjHFCffpASH3Ikdglb4l1uRbLiiM
 PJG/nXylXaWy4w0hI8E3jC9Axw8VVLopxcJzNms6i6c+1GbNVFBCJMaFRkHz9FEZp64x
 1sLcQLYhujT4xMFQNvkB5PDXX0CRMOW0fzeqPxfh7bkHSyESw9IHWUU22RmjE5vxs3Av
 fG0ZlRV9HFzpWlHO4B3nGkvfCy5bwira4OwHA1/KS/9km2z8EqcmQAY6P+0v1xdvWwZz
 D8/T4TsbNfx2gzAZ9eIVkBHRkLykdw1hayx5z1R0IFicavhL19asiib9I8YSZX9fyE+F
 H6Bg==
X-Gm-Message-State: AOAM5329jIlXcfCCLW/JTJzLVuzIvqJUzXlA2yvFE76lloqD2eSB7XHI
 OuYYdbGy12d0bzYVtYPTNe8GwQpNl1NXFGL/ywM=
X-Google-Smtp-Source: ABdhPJytDDwJRUtowj35/fLL3vfC8DdQ6dC9oDhT62uF+zGpfaH8fxc0+NaC7OEM3su0+IyLYl7lT9s27r+SExI5D0g=
X-Received: by 2002:a05:6870:a445:: with SMTP id
 n5mr102804oal.225.1644001065470; 
 Fri, 04 Feb 2022 10:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20220204184756.5387-1-luben.tuikov@amd.com>
 <CADnq5_OYjK2mgzzybgKTSM4XmizWjxBcG4a44NcDTqtMLY9y5w@mail.gmail.com>
 <22d57dd6-8674-66be-84a2-45da4dab39d5@amd.com>
In-Reply-To: <22d57dd6-8674-66be-84a2-45da4dab39d5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Feb 2022 13:57:34 -0500
Message-ID: <CADnq5_M5eHpEjO1faG-VCrjHWVVqVTdB85+gae3h9R-iAS5MAg@mail.gmail.com>
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

On Fri, Feb 4, 2022 at 1:56 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2022-02-04 13:53, Alex Deucher wrote:
> > On Fri, Feb 4, 2022 at 1:48 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
> >>
> >> The FRU and RAS EEPROMs share the same I2C bus on Aldebaran and Vega 20
> >> ASICs. Set the FRU bus "pointer" to this single bus, as access to the FRU
> >> is sought through that bus "pointer" and not through the RAS bus "pointer".
> >>
> >> Cc: Roy Sun <Roy.Sun@amd.com>
> >> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> >> Fixes: 9c6d2ba7057abb ("drm/amd: Expose the FRU SMU I2C bus")
> >> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         | 3 ++-
> >>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 +
> >>  2 files changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> >> index 87acb089cfccd5..dd2d66090d2374 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> >> @@ -741,7 +741,7 @@ int smu_v11_0_i2c_control_init(struct amdgpu_device *adev)
> >>         i2c_set_adapdata(control, smu_i2c);
> >>
> >>         adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
> >> -       adev->pm.fru_eeprom_i2c_bus = NULL;
> >> +       adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
> >>
> >>         res = i2c_add_adapter(control);
> >>         if (res)
> >> @@ -756,6 +756,7 @@ void smu_v11_0_i2c_control_fini(struct amdgpu_device *adev)
> >>
> >>         i2c_del_adapter(control);
> >>         adev->pm.ras_eeprom_i2c_bus = NULL;
> >> +       adev->pm.fru_eeprom_i2c_bus = NULL;
> >>  }
> >>
> >>  /*
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> >> index ba4c9771ffc56b..3d96d4af92d97f 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> >> @@ -1583,6 +1583,7 @@ static int aldebaran_i2c_control_init(struct smu_context *smu)
> >>         }
> >>
> >>         adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
> >> +       adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
> >
> > Does this need to be set to NULL in control_fini() for consistency?
> > Other than that, looks good to me.
>
> It already is--I didn't need to add it as I did above for Vega20.

In that case:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards,
> Luben
>
> >
> > Alex
> >
> >
> >>
> >>         return 0;
> >>  Out_err:
> >>
> >> base-commit: 24b54e10043609a55194badff58bf91189c49793
> >> prerequisite-patch-id: d694f05bfcdf100c1d6957afa209e304dad98404
> >> prerequisite-patch-id: b106a5bd7e0d3a7c225a767ca4384162353cca9a
> >> prerequisite-patch-id: 77d04393fc872e4f4dd158659bd44ba40b749883
> >> --
> >> 2.35.0.3.gb23dac905b
> >>
>
> Regards,
> --
> Luben
