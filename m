Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8F2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D305564F47
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D305564F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED6789CF8;
	Wed, 10 Mar 2021 16:17:31 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E620789CF8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 16:17:29 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id s23so497652oot.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uBKzmT0GmHX9WKO+MnyDgA1Ero17ezCv2HvhvLXd1fc=;
 b=alnnuICKtTv0uVljoyOKA6uhxfzKhzrliwDYP3M8SP83SnErTIJihhkSbN2Jfpc5o/
 1DzU5pEQEG6BDW4W+NVpCKJEDF8CdF/GDPzDAnJzuoWsq28DdtmD4FQDYAA6ODgjXuN1
 5+lde50+QdUbcUjNTbifIl7WEWlV6/+0ikMK0DaefinFk/FK3BF5O84R7HMxkELb2Crb
 thF3lSrOkT4WMC0uhqNbSeU5KjGFy9rjzbQLNRSX2/ALcRzbpoACS1FKa+EwltLeEq6r
 Lpil1ck+4ZH035UDEWwtt4AlIr3TvSxcNQd/J+oTl/L/fxH9mObnOEWzdLs+h3fYs2XU
 Ru8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uBKzmT0GmHX9WKO+MnyDgA1Ero17ezCv2HvhvLXd1fc=;
 b=MN84cYrFmcvL7zhECZ1NSVIV6FG0nh52PcfPWI6znr+BYhhv1J7W8ZRZBqV5vrb0x2
 ZCwrq2EcUP+5fSGoDTLiVRsDHYtqik7XfgRmbgengbLONyyj2ul0CvGAAIAEoB5jAupO
 Y/yWViPS7wt4fIoJ5fgJatB5xzYPii6IR6ZfzNBUOQ/63XQz1O+eDpkVGOOe517TZEC+
 MB5qVakYbwxsXf+RpAFHr1P4K5d43QERNpvG5oXnGOrsIpLmfb0I9blfBfnvwXeGumTx
 qxjHsd0QAZcM0qk3ddhD0ekykp28VxOeyuD1fOrvxqTk8D0S93QhOXG64zd7I8Tv8aRa
 Abfw==
X-Gm-Message-State: AOAM532ZxZnUr/TF4gGAzz3+SmybsRA9oRrskDP9CGRhgIoAQaLtqtZ6
 yuWmitUdYiyQ9Ks/aspTHcw7f1gU0ONrVztt2NjQdbBK
X-Google-Smtp-Source: ABdhPJxXXKVcK649s/xpWCxOtjBFD/g3TBDi9d9wNmvW93pZFDZsvUGmPgs9jp8X16tpQjU36C15V3TVwlmsNrHm/MI=
X-Received: by 2002:a4a:9801:: with SMTP id y1mr2809871ooi.90.1615393049263;
 Wed, 10 Mar 2021 08:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20210310041150.289806-1-alexander.deucher@amd.com>
 <MN2PR12MB45498613B920ADB224FF308997919@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45498613B920ADB224FF308997919@MN2PR12MB4549.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Mar 2021 11:17:18 -0500
Message-ID: <CADnq5_Pu1uWj1jAR+AVe6JYB27dgmgjALjLQOKHFoG3cSEEMfg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 10, 2021 at 3:25 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [AMD Public Use]
>
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Wednesday, March 10, 2021 9:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query
>
> Was added in newer versions of the firmware.  Add support for it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h         |  1 +
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 30 ++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> index 4c7e08ba5fa4..171f12b82716 100644
> --- a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> @@ -84,6 +84,7 @@
>  #define PPSMC_MSG_PowerGateMmHub                0x35
>  #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
>  #define PPSMC_MSG_GpuChangeState                0x37
> +#define PPSMC_MSG_GetGfxBusy                    0x3D
>  #define PPSMC_Message_Count                     0x42
>
>  typedef uint16_t PPSMC_Result;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index c932b632ddd4..52fcdec738e9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1261,9 +1261,21 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                           void *value, int *size)
>  {
>         struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
> -       uint32_t sclk, mclk;
> +       struct amdgpu_device *adev = hwmgr->adev;
> +       uint32_t sclk, mclk, activity_percent;
> +       bool has_gfx_busy;
>         int ret = 0;
>
> +       /* GetGfxBusy support was added on RV SMU FW 30.85.00 and PCO 4.30.59 */
> +       if ((adev->apu_flags & AMD_APU_IS_PICASSO) &&
> +           (hwmgr->smu_version >= 0x41e3b))
> +               has_gfx_busy = true;
> +       else if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +                (hwmgr->smu_version >= 0x1e5500))
> +               has_gfx_busy = true;
> +       else
> +               has_gfx_busy = false;
> +
>         switch (idx) {
>         case AMDGPU_PP_SENSOR_GFX_SCLK:
>                 smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk); @@ -1284,6 +1296,22 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                 *(uint32_t *)value =  smu10_data->vcn_power_gated ? 0 : 1;
>                 *size = 4;
>                 break;
> +       case AMDGPU_PP_SENSOR_GPU_LOAD:
> +               if (has_gfx_busy) {
> +                       ret = smum_send_msg_to_smc(hwmgr,
> +                                                  PPSMC_MSG_GetGfxBusy,
> +                                                  &activity_percent);
> +                       if (!ret) {
> +                               activity_percent = activity_percent > 100 ? 100 : activity_percent;
> +                       } else {
> +                               activity_percent = 50;
>
> <> Why this is assumed? Isn't this as good as not supported?

I was just to be consistent with what we did for carrizo/stoney.  I
can return an error if you prefer.

Alex


>
> Thanks,
> Lijo
>
> +                       }
> +                       *((uint32_t *)value) = activity_percent;
> +                       return 0;
> +               } else {
> +                       return -EOPNOTSUPP;
> +               }
> +               break;
>         default:
>                 ret = -EOPNOTSUPP;
>                 break;
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C4ae33de1e1cb46155eef08d8e37aaf58%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509463368911804%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2KX02OYjW4d7%2FFK3dOUz6kiBb8MUItOSOqoDEnu8Lrk%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
