Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F03FC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2736112F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2736112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7082F6EB62;
	Tue, 18 May 2021 13:03:54 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12CC66EB60
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 13:03:53 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id et19so7359577ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=ET3+d5zhj0UVBakNEy6ZzItS/SDtA5LEWsXR7l+zvZI=;
 b=izFAI6TRZ4992nWUNhDhG3BUCXAmcBEMytHgPCdy6YYKKHOdOKWjTwKivHbUtgSwHG
 k7mEFzNpCFxlblW3b1jPByE/lslfvn/dt+vB0ytdcolCULSHODMS9cUvYTr+Yvjtoou/
 3f2TLaz+DPbgJw6PVbjK/0I+i02pxDhjFC9UxBxMzsilchhnVjQXMOl0TE+Vl5a5R6AC
 W4L5f6U5UxUFM9nmQ7Io8xGaOnd8ey5BhfiZ2zBRGWOFOuD3s8ZK7JHOmUt+Y4nFWoEh
 hYzHcqSg+6A+LEASx+LSD0/n2cmqXwtqJgz46oj9k/ApP9dLF26vvhxOjvxWvBgpDzre
 J7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=ET3+d5zhj0UVBakNEy6ZzItS/SDtA5LEWsXR7l+zvZI=;
 b=Q6UV1Gzov3YQBhCwErm5aoAbPBVlV6o4D6lYFc+dHl8VDxatMd8SyIQJlWAIsO6Mlt
 97LjyboOiV7USQwwzqOfpxGBnIUj6mfcoF2Dg/M9+qFBed0+Vs7DwistXbnSo51kRbwx
 qaxNg/5A1bLg/tU7cUw86E+QLvJT5dVTiEZaznUUrOtoWgBcNrvlCiDX4AvHQ0rAj/zm
 MJu17DCXuLSK1KMcRRSqouwCOGNYWVKGX5R3pBxjyXWnxHRd6Z+gYG67/sKMIFuWTeKh
 ZVjAJ85O+alO7Vf+RWubwx62MtP88vPj5EtZ/ARqwId7MIscwyS1v6MMtjnrHN0ZMLfP
 H9Ow==
X-Gm-Message-State: AOAM53297Y3oHOUD+qxCOu/lR2RRdzdhVNvesLtct/2QNw4GivuLPBgb
 glomofYnmo4GmCaLc7eGoxfA4j1Gn5s=
X-Google-Smtp-Source: ABdhPJwsP/TEPKlagfg8DlC/9di/zCb5ZK9W9KyTLMr49SS6sHbuayaUPp/D6twMonxrAGZUS2rETg==
X-Received: by 2002:a17:906:fa83:: with SMTP id
 lt3mr5840380ejb.261.1621343030935; 
 Tue, 18 May 2021 06:03:50 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8470:36a5:2010:f0c4?
 ([2a02:908:1252:fb60:8470:36a5:2010:f0c4])
 by smtp.gmail.com with ESMTPSA id r17sm12803313edt.33.2021.05.18.06.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 06:03:50 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
To: "Nieto, David M" <David.Nieto@amd.com>,
 "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210517055413.28417-1-Jiawei.Gu@amd.com>
 <4d02568a-0a84-1e68-23d5-23b0cb3865bf@gmail.com>
 <BYAPR12MB284058062B8E32A58BDBA02FF42D9@BYAPR12MB2840.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e4316e71-5e74-fc41-8cf4-ccde72b2f434@gmail.com>
Date: Tue, 18 May 2021 15:03:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB284058062B8E32A58BDBA02FF42D9@BYAPR12MB2840.namprd12.prod.outlook.com>
Content-Language: en-US
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: multipart/mixed; boundary="===============0697940582=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0697940582==
Content-Type: multipart/alternative;
 boundary="------------07AA974907B728C0DCB1835B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------07AA974907B728C0DCB1835B
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

When this is not compliant with RFC4122 then why do we try to expose a 
UUID which seems to be compliant?

And emulating it for older hardware doesn't sounds like something I 
would want in the kernel driver. That can perfectly be handled in 
userspace as far as I can see.

Christian.

Am 17.05.21 um 22:08 schrieb Nieto, David M:
>
> [AMD Official Use Only]
>
>
> It is for unique identification of the GPU in system management 
> applications, the 64 bit asic number is only available in Vega10 and 
> later and not compliant with RFC4122.
>
> David
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Sunday, May 16, 2021 11:52 PM
> *To:* Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deng, Emily <Emily.Deng@amd.com>; Nieto, David M 
> <David.Nieto@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
> Am 17.05.21 um 07:54 schrieb Jiawei Gu:
> > Introduce an RFC 4122 compliant UUID for the GPUs derived
> > from the unique GPU serial number (from Vega10) on gpus.
> > Where this serial number is not available, use a compliant
> > random UUID.
> >
> > For virtualization, the unique ID is passed by the host driver
> > in the PF2VF structure.
>
> The question is why this is useful.
>
> >
> > Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 36 ++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  4 +
> >   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +-
> >   drivers/gpu/drm/amd/amdgpu/nv.c             |  5 ++
> >   drivers/gpu/drm/amd/amdgpu/nv.h             |  3 +
> >   6 files changed, 146 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 3147c1c935c8..ad6d4b55be6c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -802,6 +802,40 @@ struct amd_powerplay {
> >                                          (rid == 0x01) || \
> >                                          (rid == 0x10))))
> >
> > +union amdgpu_uuid_info {
> > +     struct {
> > +             union {
> > +                     struct {
> > +                             uint32_t did    : 16;
> > +                             uint32_t fcn    : 8;
> > +                             uint32_t asic_7 : 8;
> > +                     };
>
> Bitfields are not allowed in structures used for communication with
> hardware or uAPI.
>
> Regards,
> Christian.
>
> > +                     uint32_t time_low;
> > +             };
> > +
> > +             struct {
> > +                     uint32_t time_mid  : 16;
> > +                     uint32_t time_high : 12;
> > +                     uint32_t version   : 4;
> > +             };
> > +
> > +             struct {
> > +                     struct {
> > +                             uint8_t clk_seq_hi : 6;
> > +                             uint8_t variant    : 2;
> > +                     };
> > +                     union {
> > +                             uint8_t clk_seq_low;
> > +                             uint8_t asic_6;
> > +                     };
> > +                     uint16_t asic_4;
> > +             };
> > +
> > +             uint32_t asic_0;
> > +     };
> > +     char as_char[16];
> > +};
> > +
> >   #define AMDGPU_RESET_MAGIC_NUM 64
> >   #define AMDGPU_MAX_DF_PERFMONS 4
> >   struct amdgpu_device {
> > @@ -1074,6 +1108,8 @@ struct amdgpu_device {
> >        char product_name[32];
> >        char                            serial[20];
> >
> > +     union amdgpu_uuid_info uuid_info;
> > +
> >        struct amdgpu_autodump          autodump;
> >
> >        atomic_t throttling_logging_enabled;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 7c6c435e5d02..079841e1cb52 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -37,6 +37,7 @@
> >   #include <linux/vgaarb.h>
> >   #include <linux/vga_switcheroo.h>
> >   #include <linux/efi.h>
> > +#include <linux/uuid.h>
> >   #include "amdgpu.h"
> >   #include "amdgpu_trace.h"
> >   #include "amdgpu_i2c.h"
> > @@ -3239,11 +3240,104 @@ static int 
> amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
> >        return ret;
> >   }
> >
> > +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info 
> *uuid_info)
> > +{
> > +     return (uuid_info->time_low    == 0 &&
> > +                     uuid_info->time_mid    == 0 &&
> > +                     uuid_info->time_high   == 0 &&
> > +                     uuid_info->version     == 0 &&
> > +                     uuid_info->clk_seq_hi  == 0 &&
> > +                     uuid_info->variant     == 0 &&
> > +                     uuid_info->clk_seq_low == 0 &&
> > +                     uuid_info->asic_4      == 0 &&
> > +                     uuid_info->asic_0      == 0);
> > +}
> > +
> > +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,
> > +                             uint64_t serial, uint16_t did, uint8_t 
> idx)
> > +{
> > +     uint16_t clk_seq = 0;
> > +
> > +     /* Step1: insert clk_seq */
> > +     uuid_info->clk_seq_low = (uint8_t)clk_seq;
> > +     uuid_info->clk_seq_hi  = (uint8_t)(clk_seq >> 8) & 0x3F;
> > +
> > +     /* Step2: insert did */
> > +     uuid_info->did = did;
> > +
> > +     /* Step3: insert vf idx */
> > +     uuid_info->fcn = idx;
> > +
> > +     /* Step4: insert serial */
> > +     uuid_info->asic_0 = (uint32_t)serial;
> > +     uuid_info->asic_4 = (uint16_t)(serial >> 4 * 8) & 0xFFFF;
> > +     uuid_info->asic_6 = (uint8_t)(serial >> 6 * 8) & 0xFF;
> > +     uuid_info->asic_7 = (uint8_t)(serial >> 7 * 8) & 0xFF;
> > +
> > +     /* Step5: insert version */
> > +     uuid_info->version = 1;
> > +     /* Step6: insert variant */
> > +     uuid_info->variant = 2;
> > +}
> > +
> > +/* byte reverse random uuid */
> > +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)
> > +{
> > +     char b0, b1;
> > +     int i;
> > +
> > +     generate_random_uuid(uuid_info->as_char);
> > +     for (i = 0; i < 8; i++) {
> > +             b0 = uuid_info->as_char[i];
> > +             b1 = uuid_info->as_char[16-i];
> > +             uuid_info->as_char[16-i] = b0;
> > +             uuid_info->as_char[i] = b1;
> > +     }
> > +}
> > +
> > +/**
> > + *
> > + * The amdgpu driver provides a sysfs API for providing uuid data.
> > + * The file uuid_info is used for this, and returns string of 
> amdgpu uuid.
> > + */
> > +static ssize_t amdgpu_get_uuid_info(struct device *dev,
> > +                                   struct device_attribute *attr,
> > +                                   char *buf)
> > +{
> > +     struct drm_device *ddev = dev_get_drvdata(dev);
> > +     struct amdgpu_device *adev = 
> drm_to_adev(ddev);//ddev->dev_private;
> > +     union amdgpu_uuid_info *uuid = &adev->uuid_info;
> > +
> > +     return sysfs_emit(buf,
> > + "%08x-%04x-%x%03x-%02x%02x-%04x%08x\n",
> > + uuid->time_low,
> > + uuid->time_mid,
> > + uuid->version,
> > + uuid->time_high,
> > + uuid->clk_seq_hi |
> > + uuid->variant << 6,
> > + uuid->clk_seq_low,
> > + uuid->asic_4,
> > + uuid->asic_0);
> > +}
> > +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);
> > +
> > +static void amdgpu_uuid_init(struct amdgpu_device *adev)
> > +{
> > +     if (amdgpu_is_uuid_info_empty(&adev->uuid_info)) {
> > +             if (adev->unique_id)
> > + amdgpu_gen_uuid_info(&adev->uuid_info, adev->unique_id, 
> adev->pdev->device, 31);
> > +             else
> > + amdgpu_gen_uuid_random(&adev->uuid_info);
> > +     }
> > +}
> > +
> >   static const struct attribute *amdgpu_dev_attributes[] = {
> >        &dev_attr_product_name.attr,
> >        &dev_attr_product_number.attr,
> >        &dev_attr_serial_number.attr,
> >        &dev_attr_pcie_replay_count.attr,
> > +     &dev_attr_uuid_info.attr,
> >        NULL
> >   };
> >
> > @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >
> >        amdgpu_fbdev_init(adev);
> >
> > +     amdgpu_uuid_init(adev);
> > +
> >        r = amdgpu_pm_sysfs_init(adev);
> >        if (r) {
> >                adev->pm_sysfs_en = false;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > index b71dd1deeb2d..2dfebfe38079 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct 
> amdgpu_device *adev,
> >   static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
> >   {
> >        struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = 
> adev->virt.fw_reserve.p_pf2vf;
> > +     union amdgpu_uuid_info *uuid = &adev->uuid_info;
> >        uint32_t checksum;
> >        uint32_t checkval;
> >
> > @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct 
> amdgpu_device *adev)
> >
> >                adev->unique_id =
> >                        ((struct amd_sriov_msg_pf2vf_info 
> *)pf2vf_info)->uuid;
> > +
> > +             memcpy(uuid, &((struct amd_sriov_msg_pf2vf_info 
> *)pf2vf_info)->uuid_info_reserved,
> > +                     sizeof(union amdgpu_uuid_info));
> >                break;
> >        default:
> >                DRM_ERROR("invalid pf2vf version\n");
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> > index a434c71fde8e..0d1d36e82aeb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> > @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {
> >                uint32_t encode_max_frame_pixels;
> >        } mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
> >        /* UUID info */
> > -     struct amd_sriov_msg_uuid_info uuid_info;
> > +     uint32_t uuid_info_reserved[4];
> >        /* reserved */
> > -     uint32_t reserved[256 - 47];
> > +     uint32_t reserved[256-47];
> >   };
> >
> >   struct amd_sriov_msg_vf2pf_info_header {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> > index 32c34470404c..16d4a480f4c0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)
> >                if (amdgpu_sriov_vf(adev))
> >                        adev->rev_id = 0;
> >                adev->external_rev_id = adev->rev_id + 0xa;
> > +             if (!amdgpu_sriov_vf(adev)) {
> > +                     adev->unique_id = RREG32(mmFUSE_DATA_730);
> > +                     adev->unique_id <<= 32;
> > +                     adev->unique_id |= RREG32(mmFUSE_DATA_729);
> > +             }
> >                break;
> >        case CHIP_SIENNA_CICHLID:
> >                adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h 
> b/drivers/gpu/drm/amd/amdgpu/nv.h
> > index 515d67bf249f..520ac2b98744 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.h
> > @@ -26,6 +26,9 @@
> >
> >   #include "nbio_v2_3.h"
> >
> > +#define mmFUSE_DATA_729 (0x176D9)
> > +#define mmFUSE_DATA_730 (0x176DA)
> > +
> >   void nv_grbm_select(struct amdgpu_device *adev,
> >                    u32 me, u32 pipe, u32 queue, u32 vmid);
> >   void nv_set_virt_ops(struct amdgpu_device *adev);
>


--------------07AA974907B728C0DCB1835B
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    When this is not compliant with RFC4122 then why do we try to expose
    a UUID which seems to be compliant?<br>
    <br>
    And emulating it for older hardware doesn't sounds like something I
    would want in the kernel driver. That can perfectly be handled in
    userspace as far as I can see.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 17.05.21 um 22:08 schrieb Nieto,
      David M:<br>
    </div>
    <blockquote type="cite"
cite="mid:BYAPR12MB284058062B8E32A58BDBA02FF42D9@BYAPR12MB2840.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;"
        align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);">
          It is for unique identification of the GPU in system
          management applications, the 64 bit asic number is only
          available in Vega10 and later and not compliant with RFC4122.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);">
          David</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Sunday, May 16, 2021 11:52 PM<br>
            <b>To:</b> Gu, JiaWei (Will) <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>; Nieto,
            David M <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Expose rfc4122
            compliant UUID</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">Am 17.05.21 um 07:54 schrieb Jiawei
                Gu:<br>
                &gt; Introduce an RFC 4122 compliant UUID for the GPUs
                derived<br>
                &gt; from the unique GPU serial number (from Vega10) on
                gpus.<br>
                &gt; Where this serial number is not available, use a
                compliant<br>
                &gt; random UUID.<br>
                &gt;<br>
                &gt; For virtualization, the unique ID is passed by the
                host driver<br>
                &gt; in the PF2VF structure.<br>
                <br>
                The question is why this is useful.<br>
                <br>
                &gt;<br>
                &gt; Signed-off-by: Jiawei Gu <a class="moz-txt-link-rfc2396E" href="mailto:Jiawei.Gu@amd.com">&lt;Jiawei.Gu@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 36
                ++++++++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96
                +++++++++++++++++++++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  4
                +<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4
                +-<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/nv.c             |  5
                ++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/nv.h             |  3
                +<br>
                &gt;   6 files changed, 146 insertions(+), 2
                deletions(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; index 3147c1c935c8..ad6d4b55be6c 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; @@ -802,6 +802,40 @@ struct amd_powerplay {<br>
                &gt;                                          (rid ==
                0x01) || \<br>
                &gt;                                          (rid ==
                0x10))))<br>
                &gt;   <br>
                &gt; +union amdgpu_uuid_info {<br>
                &gt; +     struct {<br>
                &gt; +             union {<br>
                &gt; +                     struct {<br>
                &gt; +                             uint32_t did    : 16;<br>
                &gt; +                             uint32_t fcn    : 8;<br>
                &gt; +                             uint32_t asic_7 : 8;<br>
                &gt; +                     };<br>
                <br>
                Bitfields are not allowed in structures used for
                communication with <br>
                hardware or uAPI.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                &gt; +                     uint32_t time_low;<br>
                &gt; +             };<br>
                &gt; +<br>
                &gt; +             struct {<br>
                &gt; +                     uint32_t time_mid  : 16;<br>
                &gt; +                     uint32_t time_high : 12;<br>
                &gt; +                     uint32_t version   : 4;<br>
                &gt; +             };<br>
                &gt; +<br>
                &gt; +             struct {<br>
                &gt; +                     struct {<br>
                &gt; +                             uint8_t clk_seq_hi :
                6;<br>
                &gt; +                             uint8_t variant    :
                2;<br>
                &gt; +                     };<br>
                &gt; +                     union {<br>
                &gt; +                             uint8_t clk_seq_low;<br>
                &gt; +                             uint8_t asic_6;<br>
                &gt; +                     };<br>
                &gt; +                     uint16_t asic_4;<br>
                &gt; +             };<br>
                &gt; +<br>
                &gt; +             uint32_t asic_0;<br>
                &gt; +     };<br>
                &gt; +     char as_char[16];<br>
                &gt; +};<br>
                &gt; +<br>
                &gt;   #define AMDGPU_RESET_MAGIC_NUM 64<br>
                &gt;   #define AMDGPU_MAX_DF_PERFMONS 4<br>
                &gt;   struct amdgpu_device {<br>
                &gt; @@ -1074,6 +1108,8 @@ struct amdgpu_device {<br>
                &gt;        char                           
                product_name[32];<br>
                &gt;        char                            serial[20];<br>
                &gt;   <br>
                &gt; +     union amdgpu_uuid_info uuid_info;<br>
                &gt; +<br>
                &gt;        struct amdgpu_autodump          autodump;<br>
                &gt;   <br>
                &gt;        atomic_t                       
                throttling_logging_enabled;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; index 7c6c435e5d02..079841e1cb52 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; @@ -37,6 +37,7 @@<br>
                &gt;   #include &lt;linux/vgaarb.h&gt;<br>
                &gt;   #include &lt;linux/vga_switcheroo.h&gt;<br>
                &gt;   #include &lt;linux/efi.h&gt;<br>
                &gt; +#include &lt;linux/uuid.h&gt;<br>
                &gt;   #include "amdgpu.h"<br>
                &gt;   #include "amdgpu_trace.h"<br>
                &gt;   #include "amdgpu_i2c.h"<br>
                &gt; @@ -3239,11 +3240,104 @@ static int
                amdgpu_device_get_job_timeout_settings(struct
                amdgpu_device *adev)<br>
                &gt;        return ret;<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; +static bool amdgpu_is_uuid_info_empty(union
                amdgpu_uuid_info *uuid_info)<br>
                &gt; +{<br>
                &gt; +     return (uuid_info-&gt;time_low    == 0
                &amp;&amp;<br>
                &gt; +                     uuid_info-&gt;time_mid    ==
                0 &amp;&amp;<br>
                &gt; +                     uuid_info-&gt;time_high   ==
                0 &amp;&amp;<br>
                &gt; +                     uuid_info-&gt;version     ==
                0 &amp;&amp;<br>
                &gt; +                     uuid_info-&gt;clk_seq_hi  ==
                0 &amp;&amp;<br>
                &gt; +                     uuid_info-&gt;variant     ==
                0 &amp;&amp;<br>
                &gt; +                     uuid_info-&gt;clk_seq_low ==
                0 &amp;&amp;<br>
                &gt; +                     uuid_info-&gt;asic_4      ==
                0 &amp;&amp;<br>
                &gt; +                     uuid_info-&gt;asic_0      ==
                0);<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +static void amdgpu_gen_uuid_info(union
                amdgpu_uuid_info *uuid_info,<br>
                &gt; +                             uint64_t serial,
                uint16_t did, uint8_t idx)<br>
                &gt; +{<br>
                &gt; +     uint16_t clk_seq = 0;<br>
                &gt; +<br>
                &gt; +     /* Step1: insert clk_seq */<br>
                &gt; +     uuid_info-&gt;clk_seq_low = (uint8_t)clk_seq;<br>
                &gt; +     uuid_info-&gt;clk_seq_hi  = (uint8_t)(clk_seq
                &gt;&gt; 8) &amp; 0x3F;<br>
                &gt; +<br>
                &gt; +     /* Step2: insert did */<br>
                &gt; +     uuid_info-&gt;did = did;<br>
                &gt; +<br>
                &gt; +     /* Step3: insert vf idx */<br>
                &gt; +     uuid_info-&gt;fcn = idx;<br>
                &gt; +<br>
                &gt; +     /* Step4: insert serial */<br>
                &gt; +     uuid_info-&gt;asic_0 = (uint32_t)serial;<br>
                &gt; +     uuid_info-&gt;asic_4 = (uint16_t)(serial
                &gt;&gt; 4 * 8) &amp; 0xFFFF;<br>
                &gt; +     uuid_info-&gt;asic_6 = (uint8_t)(serial
                &gt;&gt; 6 * 8) &amp; 0xFF;<br>
                &gt; +     uuid_info-&gt;asic_7 = (uint8_t)(serial
                &gt;&gt; 7 * 8) &amp; 0xFF;<br>
                &gt; +<br>
                &gt; +     /* Step5: insert version */<br>
                &gt; +     uuid_info-&gt;version = 1;<br>
                &gt; +     /* Step6: insert variant */<br>
                &gt; +     uuid_info-&gt;variant = 2;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +/* byte reverse random uuid */<br>
                &gt; +static void amdgpu_gen_uuid_random(union
                amdgpu_uuid_info *uuid_info)<br>
                &gt; +{<br>
                &gt; +     char b0, b1;<br>
                &gt; +     int i;<br>
                &gt; +<br>
                &gt; +     generate_random_uuid(uuid_info-&gt;as_char);<br>
                &gt; +     for (i = 0; i &lt; 8; i++) {<br>
                &gt; +             b0 = uuid_info-&gt;as_char[i];<br>
                &gt; +             b1 = uuid_info-&gt;as_char[16-i];<br>
                &gt; +             uuid_info-&gt;as_char[16-i] = b0;<br>
                &gt; +             uuid_info-&gt;as_char[i] = b1;<br>
                &gt; +     }<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +/**<br>
                &gt; + *<br>
                &gt; + * The amdgpu driver provides a sysfs API for
                providing uuid data.<br>
                &gt; + * The file uuid_info is used for this, and
                returns string of amdgpu uuid.<br>
                &gt; + */<br>
                &gt; +static ssize_t amdgpu_get_uuid_info(struct device
                *dev,<br>
                &gt; +                                   struct
                device_attribute *attr,<br>
                &gt; +                                   char *buf)<br>
                &gt; +{<br>
                &gt; +     struct drm_device *ddev =
                dev_get_drvdata(dev);<br>
                &gt; +     struct amdgpu_device *adev =
                drm_to_adev(ddev);//ddev-&gt;dev_private;<br>
                &gt; +     union amdgpu_uuid_info *uuid =
                &amp;adev-&gt;uuid_info;<br>
                &gt; +<br>
                &gt; +     return sysfs_emit(buf,<br>
                &gt; +                                    
                "%08x-%04x-%x%03x-%02x%02x-%04x%08x\n",<br>
                &gt; +                                    
                uuid-&gt;time_low,<br>
                &gt; +                                    
                uuid-&gt;time_mid,<br>
                &gt; +                                    
                uuid-&gt;version,<br>
                &gt; +                                    
                uuid-&gt;time_high,<br>
                &gt; +                                    
                uuid-&gt;clk_seq_hi |<br>
                &gt; +                                    
                uuid-&gt;variant &lt;&lt; 6,<br>
                &gt; +                                    
                uuid-&gt;clk_seq_low,<br>
                &gt; +                                    
                uuid-&gt;asic_4,<br>
                &gt; +                                    
                uuid-&gt;asic_0);<br>
                &gt; +}<br>
                &gt; +static DEVICE_ATTR(uuid_info, S_IRUGO,
                amdgpu_get_uuid_info, NULL);<br>
                &gt; +<br>
                &gt; +static void amdgpu_uuid_init(struct amdgpu_device
                *adev)<br>
                &gt; +{<br>
                &gt; +     if
                (amdgpu_is_uuid_info_empty(&amp;adev-&gt;uuid_info)) {<br>
                &gt; +             if (adev-&gt;unique_id)<br>
                &gt; +                    
                amdgpu_gen_uuid_info(&amp;adev-&gt;uuid_info,
                adev-&gt;unique_id, adev-&gt;pdev-&gt;device, 31);<br>
                &gt; +             else<br>
                &gt; +                    
                amdgpu_gen_uuid_random(&amp;adev-&gt;uuid_info);<br>
                &gt; +     }<br>
                &gt; +}<br>
                &gt; +<br>
                &gt;   static const struct attribute
                *amdgpu_dev_attributes[] = {<br>
                &gt;        &amp;dev_attr_product_name.attr,<br>
                &gt;        &amp;dev_attr_product_number.attr,<br>
                &gt;        &amp;dev_attr_serial_number.attr,<br>
                &gt;        &amp;dev_attr_pcie_replay_count.attr,<br>
                &gt; +     &amp;dev_attr_uuid_info.attr,<br>
                &gt;        NULL<br>
                &gt;   };<br>
                &gt;   <br>
                &gt; @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct
                amdgpu_device *adev,<br>
                &gt;   <br>
                &gt;        amdgpu_fbdev_init(adev);<br>
                &gt;   <br>
                &gt; +     amdgpu_uuid_init(adev);<br>
                &gt; +<br>
                &gt;        r = amdgpu_pm_sysfs_init(adev);<br>
                &gt;        if (r) {<br>
                &gt;                adev-&gt;pm_sysfs_en = false;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
                &gt; index b71dd1deeb2d..2dfebfe38079 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
                &gt; @@ -429,6 +429,7 @@ static void
                amdgpu_virt_add_bad_page(struct amdgpu_device *adev,<br>
                &gt;   static int amdgpu_virt_read_pf2vf_data(struct
                amdgpu_device *adev)<br>
                &gt;   {<br>
                &gt;        struct amd_sriov_msg_pf2vf_info_header
                *pf2vf_info = adev-&gt;virt.fw_reserve.p_pf2vf;<br>
                &gt; +     union amdgpu_uuid_info *uuid =
                &amp;adev-&gt;uuid_info;<br>
                &gt;        uint32_t checksum;<br>
                &gt;        uint32_t checkval;<br>
                &gt;   <br>
                &gt; @@ -498,6 +499,9 @@ static int
                amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)<br>
                &gt;   <br>
                &gt;                adev-&gt;unique_id =<br>
                &gt;                        ((struct
                amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;uuid;<br>
                &gt; +<br>
                &gt; +             memcpy(uuid, &amp;((struct
                amd_sriov_msg_pf2vf_info
                *)pf2vf_info)-&gt;uuid_info_reserved,<br>
                &gt; +                     sizeof(union
                amdgpu_uuid_info));<br>
                &gt;                break;<br>
                &gt;        default:<br>
                &gt;                DRM_ERROR("invalid pf2vf
                version\n");<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
                b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
                &gt; index a434c71fde8e..0d1d36e82aeb 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
                &gt; @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info
                {<br>
                &gt;                uint32_t encode_max_frame_pixels;<br>
                &gt;        }
                mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];<br>
                &gt;        /* UUID info */<br>
                &gt; -     struct amd_sriov_msg_uuid_info uuid_info;<br>
                &gt; +     uint32_t uuid_info_reserved[4];<br>
                &gt;        /* reserved */<br>
                &gt; -     uint32_t reserved[256 - 47];<br>
                &gt; +     uint32_t reserved[256-47];<br>
                &gt;   };<br>
                &gt;   <br>
                &gt;   struct amd_sriov_msg_vf2pf_info_header {<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
                b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
                &gt; index 32c34470404c..16d4a480f4c0 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
                &gt; @@ -1167,6 +1167,11 @@ static int
                nv_common_early_init(void *handle)<br>
                &gt;                if (amdgpu_sriov_vf(adev))<br>
                &gt;                        adev-&gt;rev_id = 0;<br>
                &gt;                adev-&gt;external_rev_id =
                adev-&gt;rev_id + 0xa;<br>
                &gt; +             if (!amdgpu_sriov_vf(adev)) {<br>
                &gt; +                     adev-&gt;unique_id =
                RREG32(mmFUSE_DATA_730);<br>
                &gt; +                     adev-&gt;unique_id &lt;&lt;=
                32;<br>
                &gt; +                     adev-&gt;unique_id |=
                RREG32(mmFUSE_DATA_729);<br>
                &gt; +             }<br>
                &gt;                break;<br>
                &gt;        case CHIP_SIENNA_CICHLID:<br>
                &gt;                adev-&gt;cg_flags =
                AMD_CG_SUPPORT_GFX_MGCG |<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h
                b/drivers/gpu/drm/amd/amdgpu/nv.h<br>
                &gt; index 515d67bf249f..520ac2b98744 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.h<br>
                &gt; @@ -26,6 +26,9 @@<br>
                &gt;   <br>
                &gt;   #include "nbio_v2_3.h"<br>
                &gt;   <br>
                &gt; +#define mmFUSE_DATA_729 (0x176D9)<br>
                &gt; +#define mmFUSE_DATA_730 (0x176DA)<br>
                &gt; +<br>
                &gt;   void nv_grbm_select(struct amdgpu_device *adev,<br>
                &gt;                    u32 me, u32 pipe, u32 queue, u32
                vmid);<br>
                &gt;   void nv_set_virt_ops(struct amdgpu_device *adev);<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------07AA974907B728C0DCB1835B--

--===============0697940582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0697940582==--
