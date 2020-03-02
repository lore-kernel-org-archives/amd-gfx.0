Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF1C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 14:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F45214DB
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgYrGX85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F45214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502A06E45E;
	Mon,  2 Mar 2020 14:26:54 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C9B6E45E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 14:26:53 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t11so6435039wrw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KLLp60YfceqiTER7EXrXvuKwY58q1EgqAyoKPJSIzKQ=;
 b=LgYrGX85hZvywDszX6vtEKFPHWQaNRRoCTbfAHZyn8DBNdBR99bZIHUCmd8mUuAubk
 PGukYqHRUHJ/LPRbHg+hFkyPsjEjeEbFwDlxdep7kjewi0zWu6Ike8vx/Rb55RcU6uHN
 TwS3o8Z48O6C+hfPYJwwcYJk8KMTi0ZsRNyuLWsh4ikqpr6iQW1lCp6jlUNqrYKtq6+V
 BT+Dnacq6mklUJIWC90k0bfhkn2BbRCyyWh/8B7IsAXpIMwXC9LIkFL7rANe/Iu8+0cH
 hjRrATBcdUpX5h2BmjHMwEY3Nmc5x74kYqSiiiGcS424lA/mzTnIOKvnrsN66Q+lsvQF
 MVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KLLp60YfceqiTER7EXrXvuKwY58q1EgqAyoKPJSIzKQ=;
 b=pOEVTFJTkMxsENNDSD1hssWsj96a8ClYoifa1G8mG68p1siPOIC3lwpvXfYA5qliRH
 TQwxojpSyv9Y5w2R8+Dj1clEK8mgKNsVgwYZq1sOetSas8TntmySQo3syrZm9fFT9Pj1
 220ovxVi12pjwpyYLi5rcCwku0sblpU02ZyERswAUgsO0zf6CWmEKaZ4km/U/c3k2NqZ
 IS4eNCkkonk/9CJPoUqA/IdopTPbyq3ir7SUGZ5ZhEbTnc0bYpaWRZ6ljDqaeJXy8kXI
 Ih2XwVZkGe3vz3xDdwoo2mJLOo6s3lWkK6N6QRIxSSYhJW6sR+yn0IfSvY4QWXkCIr8r
 BwDg==
X-Gm-Message-State: APjAAAW8HEXx5OUEb6sq7lFLrpM9dE/avLZp5YwQoiJQklrVAW9z16qJ
 rVnQQQ0FGcfvLI77N2ISLixg2sgxOsZvvtnLBjk=
X-Google-Smtp-Source: APXvYqy9JhzmzvtGfmB8R41Gc3rekXPyBzsjoQRtxlTeiiEwart8RZ1VTM8pOpQBnGjQHsVBR2iRnP9i0Gu9bD8MvwA=
X-Received: by 2002:a5d:5745:: with SMTP id q5mr23226655wrw.374.1583159211799; 
 Mon, 02 Mar 2020 06:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20200227155349.10993-1-hersenxs.wu@amd.com>
 <MN2PR12MB33448440496BD112CE52820BE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MN2PR12MB38404E1958870D36B236B217FDE80@MN2PR12MB3840.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB38404E1958870D36B236B217FDE80@MN2PR12MB3840.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2020 09:26:40 -0500
Message-ID: <CADnq5_N3fn=oc=kWAfPThK0u9k8eNJv8EeiN0F8WTP_a6ChzNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
To: "Wu, Hersen" <hersenxs.wu@amd.com>
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 28, 2020 at 3:59 PM Wu, Hersen <hersenxs.wu@amd.com> wrote:
>
> Follow Evan's review, add smu->mutex.
>
>
> This interface is for dGPU Navi1x. Linux dc-pplib interface depends
>  on window driver dc implementation.
>
>  For Navi1x, clock settings of dcn watermarks are fixed. the settings
>  should be passed to smu during boot up and resume from s3.
>  boot up: dc calculate dcn watermark clock settings within dc_create,
>  dcn20_resource_construct, then call pplib functions below to pass
>  the settings to smu:
>  smu_set_watermarks_for_clock_ranges
>  smu_set_watermarks_table
>  navi10_set_watermarks_table
>  smu_write_watermarks_table
>
>  For Renoir, clock settings of dcn watermark are also fixed values.
>  dc has implemented different flow for window driver:
>  dc_hardware_init / dc_set_power_state
>  dcn10_init_hw
>  notify_wm_ranges
>  set_wm_ranges
>
>  For Linux
>  smu_set_watermarks_for_clock_ranges
>  renoir_set_watermarks_table
>  smu_write_watermarks_table
>
>  dc_hardware_init -> amdgpu_dm_init
>  dc_set_power_state --> dm_resume
>
>  therefore, linux dc-pplib interface of navi10/12/14 is different
>  from that of Renoir.
>
> Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 931cbd7b372e..1ee1d6ff2782 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1435,6 +1435,72 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
>   drm_kms_helper_hotplug_event(dev);
>  }
>
> +static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
> +{
> + struct smu_context *smu = &adev->smu;
> + int ret = 0;
> +
> + if (!is_support_sw_smu(adev))
> + return 0;
> +
> + /* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
> + * on window driver dc implementation.
> + * For Navi1x, clock settings of dcn watermarks are fixed. the settings
> + * should be passed to smu during boot up and resume from s3.
> + * boot up: dc calculate dcn watermark clock settings within dc_create,
> + * dcn20_resource_construct
> + * then call pplib functions below to pass the settings to smu:
> + * smu_set_watermarks_for_clock_ranges
> + * smu_set_watermarks_table
> + * navi10_set_watermarks_table
> + * smu_write_watermarks_table
> + *
> + * For Renoir, clock settings of dcn watermark are also fixed values.
> + * dc has implemented different flow for window driver:
> + * dc_hardware_init / dc_set_power_state
> + * dcn10_init_hw
> + * notify_wm_ranges
> + * set_wm_ranges
> + * -- Linux
> + * smu_set_watermarks_for_clock_ranges
> + * renoir_set_watermarks_table
> + * smu_write_watermarks_table
> + *
> + * For Linux,
> + * dc_hardware_init -> amdgpu_dm_init
> + * dc_set_power_state --> dm_resume
> + *
> + * therefore, this function apply to navi10/12/14 but not Renoir
> + * *
> + */
> + switch(adev->asic_type) {
> + case CHIP_NAVI10:
> + case CHIP_NAVI14:
> + case CHIP_NAVI12:
> + break;
> + default:
> + return 0;
> + }
> +
> + mutex_lock(&smu->mutex);
> +
> + /* pass data to smu controller */
> + if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> + !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
> + ret = smu_write_watermarks_table(smu);
> +
> + if (ret) {
> + DRM_ERROR("Failed to update WMTABLE!\n");
> + return ret;

You need to unlock the mutex here in the failure case.

Alex

> + }
> + smu->watermarks_bitmap |= WATERMARKS_LOADED;
> + }
> +
> + mutex_unlock(&smu->mutex);
> +
> + return 0;
> +}
> +
>  /**
>   * dm_hw_init() - Initialize DC device
>   * @handle: The base driver device containing the amdgpu_dm device.
> @@ -1713,6 +1779,8 @@ static int dm_resume(void *handle)
>
>   amdgpu_dm_irq_resume_late(adev);
>
> + amdgpu_dm_smu_write_watermarks_table(adev);
> +
>   return 0;
>  }
>
> --
> 2.17.1
>
> ________________________________
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: February 27, 2020 9:58 PM
> To: Wu, Hersen <hersenxs.wu@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock settings to smu resume from s3
>
> Thanks. But could you help to confirm whether this is correctly protected by "mutex_lock(&smu->mutex)"?
>
> -----Original Message-----
> From: Hersen Wu <hersenxs.wu@amd.com>
> Sent: Thursday, February 27, 2020 11:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock settings to smu resume from s3
>
>  This interface is for dGPU Navi1x. Linux dc-pplib interface depends  on window driver dc implementation.
>
>  For Navi1x, clock settings of dcn watermarks are fixed. the settings  should be passed to smu during boot up and resume from s3.
>  boot up: dc calculate dcn watermark clock settings within dc_create,  dcn20_resource_construct, then call pplib functions below to pass  the settings to smu:
>  smu_set_watermarks_for_clock_ranges
>  smu_set_watermarks_table
>  navi10_set_watermarks_table
>  smu_write_watermarks_table
>
>  For Renoir, clock settings of dcn watermark are also fixed values.
>  dc has implemented different flow for window driver:
>  dc_hardware_init / dc_set_power_state
>  dcn10_init_hw
>  notify_wm_ranges
>  set_wm_ranges
>
>  For Linux
>  smu_set_watermarks_for_clock_ranges
>  renoir_set_watermarks_table
>  smu_write_watermarks_table
>
>  dc_hardware_init -> amdgpu_dm_init
>  dc_set_power_state --> dm_resume
>
>  therefore, linux dc-pplib interface of navi10/12/14 is different  from that of Renoir.
>
> Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 931cbd7b372e..c58c0e95735e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1435,6 +1435,68 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
>                  drm_kms_helper_hotplug_event(dev);
>  }
>
> +static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device
> +*adev) {
> +       struct smu_context *smu = &adev->smu;
> +       int ret = 0;
> +
> +       if (!is_support_sw_smu(adev))
> +               return 0;
> +
> +       /* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
> +        * on window driver dc implementation.
> +        * For Navi1x, clock settings of dcn watermarks are fixed. the settings
> +        * should be passed to smu during boot up and resume from s3.
> +        * boot up: dc calculate dcn watermark clock settings within dc_create,
> +        * dcn20_resource_construct
> +        * then call pplib functions below to pass the settings to smu:
> +        * smu_set_watermarks_for_clock_ranges
> +        * smu_set_watermarks_table
> +        * navi10_set_watermarks_table
> +        * smu_write_watermarks_table
> +        *
> +        * For Renoir, clock settings of dcn watermark are also fixed values.
> +        * dc has implemented different flow for window driver:
> +        * dc_hardware_init / dc_set_power_state
> +        * dcn10_init_hw
> +        * notify_wm_ranges
> +        * set_wm_ranges
> +        * -- Linux
> +        * smu_set_watermarks_for_clock_ranges
> +        * renoir_set_watermarks_table
> +        * smu_write_watermarks_table
> +        *
> +        * For Linux,
> +        * dc_hardware_init -> amdgpu_dm_init
> +        * dc_set_power_state --> dm_resume
> +        *
> +        * therefore, this function apply to navi10/12/14 but not Renoir
> +        * *
> +        */
> +       switch(adev->asic_type) {
> +       case CHIP_NAVI10:
> +       case CHIP_NAVI14:
> +       case CHIP_NAVI12:
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       /* pass data to smu controller */
> +       if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> +                       !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
> +               ret = smu_write_watermarks_table(smu);
> +
> +               if (ret) {
> +                       DRM_ERROR("Failed to update WMTABLE!\n");
> +                       return ret;
> +               }
> +               smu->watermarks_bitmap |= WATERMARKS_LOADED;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * dm_hw_init() - Initialize DC device
>   * @handle: The base driver device containing the amdgpu_dm device.
> @@ -1713,6 +1775,8 @@ static int dm_resume(void *handle)
>
>          amdgpu_dm_irq_resume_late(adev);
>
> +       amdgpu_dm_smu_write_watermarks_table(adev);
> +
>          return 0;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
