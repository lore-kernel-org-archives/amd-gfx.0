Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFD0C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D0B611BF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D0B611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7A06E882;
	Tue, 18 May 2021 14:13:07 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3626E882
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 14:13:05 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 i8-20020a4aa1080000b0290201edd785e7so2261322ool.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q/vV2phW5TBsH+IJnnFH56iGMh0OjE+sIEnrzHbHq0k=;
 b=RAjxXn09AJFCp2EwGtXeSbADSkD5m8fLhJZoVOkso5CUP8bdarRiwGvcfuZrZRTgdr
 WXALeLIIiB8kr9GAq6BQlp9B9l4qF+3H1jcqgytVK24e/qs8BvT7idxKjvUQibKiMVYx
 /JjhtswOJVMIfiSFGQFJiUZO7KxRG8/T75an2EegPP8fHe3qXsiK/nUjuGm/Fo2eww2q
 AbQZOZwAA9Z03ExD9IoUYZThIYyXjFDpDJYIi9DRmxfGdQCpMjIe9hk4m4L5CzNCuR+t
 62SOjm/f3W448Hsx9kAUsSyzX8rvGiwcLDgtSGV/BubdGmX61ORRc9csEy6GzoIhZ348
 oGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q/vV2phW5TBsH+IJnnFH56iGMh0OjE+sIEnrzHbHq0k=;
 b=r4BQBw4hKt7UUdBsC5y4LOknW3Mzea7BSM/OzBeDDnpeWquDJUM0/pthex4/ac+RFg
 Ff07GV7mpseejffM5rgZViPatjKAqnSh3owvZRW/2EaCBQTgaN5IxO19sVAaQ31PczNO
 2BawK/avJWjY68lB+6N+0JTqg8GU3wcJqXYakuDejd4u2NRwqmsAe8RnlHWlbun6nOXU
 qvlY/J0QZpKwOwb1x0dkpCwKMbmR2mBuS+rP7ZbcyBAPccbDQSOYx1PmW3tVO0nvtExS
 2mEAX9zUqSpOHqz/HvI3dS6kdC9vTg8yZ1iy+I6n7SyeDtgLQO7F9xy6R9OR1Yg+d8Xz
 IcdA==
X-Gm-Message-State: AOAM532XQhIrcZWn8MLyYtMHh9qQLc8KCf7ZxVFISIy9Ex8Ofvw4vYMx
 ztmGq6vEEz7/2//A4z3ypdR7lT2YqN29yJkJfs8=
X-Google-Smtp-Source: ABdhPJwYpPBW49woFHDVEvVbM5UYOeybTB0cfFsoJOstIV+Wh3wxSvttI1/mof6K4yWGX1ozI9tCxPVjfTafTvNJXLM=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr4632150oor.61.1621347184991;
 Tue, 18 May 2021 07:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210517055413.28417-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210517055413.28417-1-Jiawei.Gu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 May 2021 10:12:54 -0400
Message-ID: <CADnq5_MLzM8+f3LU5QbDsn0haUNvKECQe3rR9HdoYpcooUpN6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
To: Jiawei Gu <Jiawei.Gu@amd.com>
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
Cc: Emily Deng <emily.deng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Nieto,
 David M" <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 17, 2021 at 1:54 AM Jiawei Gu <Jiawei.Gu@amd.com> wrote:
>
> Introduce an RFC 4122 compliant UUID for the GPUs derived
> from the unique GPU serial number (from Vega10) on gpus.
> Where this serial number is not available, use a compliant
> random UUID.
>
> For virtualization, the unique ID is passed by the host driver
> in the PF2VF structure.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 36 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  4 +
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c             |  5 ++
>  drivers/gpu/drm/amd/amdgpu/nv.h             |  3 +
>  6 files changed, 146 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3147c1c935c8..ad6d4b55be6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -802,6 +802,40 @@ struct amd_powerplay {
>                                           (rid == 0x01) || \
>                                           (rid == 0x10))))
>
> +union amdgpu_uuid_info {
> +       struct {
> +               union {
> +                       struct {
> +                               uint32_t did    : 16;
> +                               uint32_t fcn    : 8;
> +                               uint32_t asic_7 : 8;
> +                       };
> +                       uint32_t time_low;
> +               };
> +
> +               struct {
> +                       uint32_t time_mid  : 16;
> +                       uint32_t time_high : 12;
> +                       uint32_t version   : 4;
> +               };
> +
> +               struct {
> +                       struct {
> +                               uint8_t clk_seq_hi : 6;
> +                               uint8_t variant    : 2;
> +                       };
> +                       union {
> +                               uint8_t clk_seq_low;
> +                               uint8_t asic_6;
> +                       };
> +                       uint16_t asic_4;
> +               };
> +
> +               uint32_t asic_0;
> +       };
> +       char as_char[16];
> +};
> +
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_device {
> @@ -1074,6 +1108,8 @@ struct amdgpu_device {
>         char                            product_name[32];
>         char                            serial[20];
>
> +       union amdgpu_uuid_info uuid_info;
> +
>         struct amdgpu_autodump          autodump;
>
>         atomic_t                        throttling_logging_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7c6c435e5d02..079841e1cb52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -37,6 +37,7 @@
>  #include <linux/vgaarb.h>
>  #include <linux/vga_switcheroo.h>
>  #include <linux/efi.h>
> +#include <linux/uuid.h>
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_i2c.h"
> @@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>         return ret;
>  }
>
> +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_info)
> +{
> +       return (uuid_info->time_low    == 0 &&
> +                       uuid_info->time_mid    == 0 &&
> +                       uuid_info->time_high   == 0 &&
> +                       uuid_info->version     == 0 &&
> +                       uuid_info->clk_seq_hi  == 0 &&
> +                       uuid_info->variant     == 0 &&
> +                       uuid_info->clk_seq_low == 0 &&
> +                       uuid_info->asic_4      == 0 &&
> +                       uuid_info->asic_0      == 0);
> +}
> +
> +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,
> +                               uint64_t serial, uint16_t did, uint8_t idx)
> +{
> +       uint16_t clk_seq = 0;
> +
> +       /* Step1: insert clk_seq */
> +       uuid_info->clk_seq_low = (uint8_t)clk_seq;
> +       uuid_info->clk_seq_hi  = (uint8_t)(clk_seq >> 8) & 0x3F;
> +
> +       /* Step2: insert did */
> +       uuid_info->did = did;
> +
> +       /* Step3: insert vf idx */
> +       uuid_info->fcn = idx;
> +
> +       /* Step4: insert serial */
> +       uuid_info->asic_0 = (uint32_t)serial;
> +       uuid_info->asic_4 = (uint16_t)(serial >> 4 * 8) & 0xFFFF;
> +       uuid_info->asic_6 = (uint8_t)(serial >> 6 * 8) & 0xFF;
> +       uuid_info->asic_7 = (uint8_t)(serial >> 7 * 8) & 0xFF;
> +
> +       /* Step5: insert version */
> +       uuid_info->version = 1;
> +       /* Step6: insert variant */
> +       uuid_info->variant = 2;
> +}
> +
> +/* byte reverse random uuid */
> +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)
> +{
> +       char b0, b1;
> +       int i;
> +
> +       generate_random_uuid(uuid_info->as_char);
> +       for (i = 0; i < 8; i++) {
> +               b0 = uuid_info->as_char[i];
> +               b1 = uuid_info->as_char[16-i];
> +               uuid_info->as_char[16-i] = b0;
> +               uuid_info->as_char[i] = b1;
> +       }
> +}
> +
> +/**
> + *
> + * The amdgpu driver provides a sysfs API for providing uuid data.
> + * The file uuid_info is used for this, and returns string of amdgpu uuid.
> + */
> +static ssize_t amdgpu_get_uuid_info(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     char *buf)
> +{
> +       struct drm_device *ddev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(ddev);//ddev->dev_private;
> +       union amdgpu_uuid_info *uuid = &adev->uuid_info;
> +
> +       return sysfs_emit(buf,
> +                                       "%08x-%04x-%x%03x-%02x%02x-%04x%08x\n",
> +                                       uuid->time_low,
> +                                       uuid->time_mid,
> +                                       uuid->version,
> +                                       uuid->time_high,
> +                                       uuid->clk_seq_hi |
> +                                       uuid->variant << 6,
> +                                       uuid->clk_seq_low,
> +                                       uuid->asic_4,
> +                                       uuid->asic_0);
> +}
> +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);
> +
> +static void amdgpu_uuid_init(struct amdgpu_device *adev)
> +{
> +       if (amdgpu_is_uuid_info_empty(&adev->uuid_info)) {
> +               if (adev->unique_id)
> +                       amdgpu_gen_uuid_info(&adev->uuid_info, adev->unique_id, adev->pdev->device, 31);
> +               else
> +                       amdgpu_gen_uuid_random(&adev->uuid_info);
> +       }
> +}
> +
>  static const struct attribute *amdgpu_dev_attributes[] = {
>         &dev_attr_product_name.attr,
>         &dev_attr_product_number.attr,
>         &dev_attr_serial_number.attr,
>         &dev_attr_pcie_replay_count.attr,
> +       &dev_attr_uuid_info.attr,
>         NULL
>  };
>
> @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         amdgpu_fbdev_init(adev);
>
> +       amdgpu_uuid_init(adev);
> +
>         r = amdgpu_pm_sysfs_init(adev);
>         if (r) {
>                 adev->pm_sysfs_en = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index b71dd1deeb2d..2dfebfe38079 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
>  static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  {
>         struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
> +       union amdgpu_uuid_info *uuid = &adev->uuid_info;
>         uint32_t checksum;
>         uint32_t checkval;
>
> @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>
>                 adev->unique_id =
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
> +
> +               memcpy(uuid, &((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid_info_reserved,
> +                       sizeof(union amdgpu_uuid_info));
>                 break;
>         default:
>                 DRM_ERROR("invalid pf2vf version\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index a434c71fde8e..0d1d36e82aeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {
>                 uint32_t encode_max_frame_pixels;
>         } mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>         /* UUID info */
> -       struct amd_sriov_msg_uuid_info uuid_info;
> +       uint32_t uuid_info_reserved[4];
>         /* reserved */
> -       uint32_t reserved[256 - 47];
> +       uint32_t reserved[256-47];
>  };
>
>  struct amd_sriov_msg_vf2pf_info_header {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 32c34470404c..16d4a480f4c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)
>                 if (amdgpu_sriov_vf(adev))
>                         adev->rev_id = 0;
>                 adev->external_rev_id = adev->rev_id + 0xa;
> +               if (!amdgpu_sriov_vf(adev)) {
> +                       adev->unique_id = RREG32(mmFUSE_DATA_730);
> +                       adev->unique_id <<= 32;
> +                       adev->unique_id |= RREG32(mmFUSE_DATA_729);
> +               }

I would suggest putting this in navi10_get_unique_id() in navi10_ppt.c
for consistency since we query this from the SMU on most other asics.

Alex



>                 break;
>         case CHIP_SIENNA_CICHLID:
>                 adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
> index 515d67bf249f..520ac2b98744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.h
> @@ -26,6 +26,9 @@
>
>  #include "nbio_v2_3.h"
>
> +#define mmFUSE_DATA_729 (0x176D9)
> +#define mmFUSE_DATA_730 (0x176DA)
> +
>  void nv_grbm_select(struct amdgpu_device *adev,
>                     u32 me, u32 pipe, u32 queue, u32 vmid);
>  void nv_set_virt_ops(struct amdgpu_device *adev);
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
