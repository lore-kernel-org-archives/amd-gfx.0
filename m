Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98F4C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 17:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCF4207FC
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR5dH7Ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCF4207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5916E82C;
	Mon, 20 Apr 2020 17:40:08 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F906E82C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 17:40:06 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id u13so13263465wrp.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZTaQqoxu95/D9YR+ktKf51v3VBNqPxU80TMeTgMD3EQ=;
 b=NR5dH7Ys9t3fTl6IIGXTUeDSuMdOcFrJQv3wElQQOzALEtIgpRGMl5nSESO1vaJPhu
 L+6iWgC2vfe9RhvWJ7brutc3l3yca7G8t1Ufk79rWs9hFVER10mlCDvk0G5+ocNmvGNp
 KBt/ZMCck54D2by5PJm5+r8J7Gxw/MjXtqPaSBKMUemHoK8E7FTJiIsUr2LSwm+Y0t4a
 4wg6uYtHzxMKouo+ArH/hN6ZpIQfPQJCfYiHdz6FpTRSleoh0fnHTJVLZT7qYfJPu4fr
 6EBFhzvtpX68UzZnePtLfC0CYr9aoHyLmh8RRmFSyhzRuqP9Sb7h2T4iMet+tehj6ZRs
 O5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZTaQqoxu95/D9YR+ktKf51v3VBNqPxU80TMeTgMD3EQ=;
 b=MfXSjISjcTkSilivh+S5i0BkGP9TRjEJnb3rWRN+1t7UIqE1zbbBMr6ADrQMzH26II
 3otdZAAQIWHW9QXWSQ2RZlPl19qfenfgoZEQ5sNwi3R88KCWKNgkxtQjMFMXpecXaavv
 RlaRR45Iha+/E3K/7GeoSQlh5AszEEXFrxGc+u7mkJ73VJVCyOV0A2JdifQookFMrEfJ
 5FilqG039O8BK6McunpypqhS8twq3pzl6Q3BkHbC75OKKUnhf6eqdQBD4re/japxYhlS
 oikmE0Pdqcw42BQMZoDQoDpGaXWwjmZ72RQGNo86/x7agjxKj23pmoCxoK6MpZ9VVqqG
 FfkQ==
X-Gm-Message-State: AGi0PuZXqBQ30MOO4tVdX4f0H/bcus9peRA6oZtlCwbsrrOp9Rbl0tW4
 Unv8jU3/nktRRBB1y9zgwAS+hb9TqvwpBjDn/CU=
X-Google-Smtp-Source: APiQypJl6N+zsWaDuSRrPqLR+eFpuR7dvYpJgGU7HZZg0T8qgPe1PV4Wv0IrW6oCSW3THNd764Luq17CWu8IqSV78yk=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr21165674wrs.124.1587404405268; 
 Mon, 20 Apr 2020 10:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
 <1587377804-3836-4-git-send-email-Hawking.Zhang@amd.com>
 <abee97af-1506-8a38-9852-7684f24ce940@amd.com>
In-Reply-To: <abee97af-1506-8a38-9852-7684f24ce940@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2020 13:39:53 -0400
Message-ID: <CADnq5_MgZrWVQaARPkviaw8reUA4WQ3VxC5q9RPFW5pcfedBjw@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/amdgpu: retire unused check_fw_loading status
To: Luben Tuikov <luben.tuikov@amd.com>
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
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 20, 2020 at 10:45 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-04-20 6:16 a.m., Hawking Zhang wrote:
> > It is not allowed to read out engine sram via registers
> > to check the fw loading status.
> >
>
> Who or what is "It"--do you mean "The driver"?
>

The driver can't access these registers on production boards.  These
are leftover from bring up.  Adding a sentence like that should help
clarify.

Alex

> Abbreviations should be capitalized: SRAM, ASIC, etc.
>
> Regards,
> Luben
>
> > Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  34 --------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |   7 --
> >  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 124 -----------------------------
> >  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 133 --------------------------------
> >  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c  | 123 -----------------------------
> >  drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 123 -----------------------------
> >  6 files changed, 544 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 901ee79..7797065 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -37,8 +37,6 @@
> >
> >  #include "amdgpu_ras.h"
> >
> > -static void psp_set_funcs(struct amdgpu_device *adev);
> > -
> >  static int psp_sysfs_init(struct amdgpu_device *adev);
> >  static void psp_sysfs_fini(struct amdgpu_device *adev);
> >
> > @@ -82,8 +80,6 @@ static int psp_early_init(void *handle)
> >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >       struct psp_context *psp = &adev->psp;
> >
> > -     psp_set_funcs(adev);
> > -
> >       switch (adev->asic_type) {
> >       case CHIP_VEGA10:
> >       case CHIP_VEGA12:
> > @@ -1487,11 +1483,6 @@ static int psp_np_fw_load(struct psp_context *psp)
> >                               return ret;
> >                       }
> >               }
> > -#if 0
> > -             /* check if firmware loaded sucessfully */
> > -             if (!amdgpu_psp_check_fw_loading_status(adev, i))
> > -                     return -EINVAL;
> > -#endif
> >       }
> >
> >       return 0;
> > @@ -1849,21 +1840,6 @@ int psp_ring_cmd_submit(struct psp_context *psp,
> >       return 0;
> >  }
> >
> > -static bool psp_check_fw_loading_status(struct amdgpu_device *adev,
> > -                                     enum AMDGPU_UCODE_ID ucode_type)
> > -{
> > -     struct amdgpu_firmware_info *ucode = NULL;
> > -
> > -     if (!adev->firmware.fw_size)
> > -             return false;
> > -
> > -     ucode = &adev->firmware.ucode[ucode_type];
> > -     if (!ucode->fw || !ucode->ucode_size)
> > -             return false;
> > -
> > -     return psp_compare_sram_data(&adev->psp, ucode, ucode_type);
> > -}
> > -
> >  static int psp_set_clockgating_state(void *handle,
> >                                    enum amd_clockgating_state state)
> >  {
> > @@ -2000,16 +1976,6 @@ static void psp_sysfs_fini(struct amdgpu_device *adev)
> >       device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
> >  }
> >
> > -static const struct amdgpu_psp_funcs psp_funcs = {
> > -     .check_fw_loading_status = psp_check_fw_loading_status,
> > -};
> > -
> > -static void psp_set_funcs(struct amdgpu_device *adev)
> > -{
> > -     if (NULL == adev->firmware.funcs)
> > -             adev->firmware.funcs = &psp_funcs;
> > -}
> > -
> >  const struct amdgpu_ip_block_version psp_v3_1_ip_block =
> >  {
> >       .type = AMD_IP_BLOCK_TYPE_PSP,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > index 65a7d0a..f8b1f03 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > @@ -93,9 +93,6 @@ struct psp_funcs
> >                           enum psp_ring_type ring_type);
> >       int (*ring_destroy)(struct psp_context *psp,
> >                           enum psp_ring_type ring_type);
> > -     bool (*compare_sram_data)(struct psp_context *psp,
> > -                               struct amdgpu_firmware_info *ucode,
> > -                               enum AMDGPU_UCODE_ID ucode_type);
> >       bool (*smu_reload_quirk)(struct psp_context *psp);
> >       int (*mode1_reset)(struct psp_context *psp);
> >       int (*xgmi_get_node_id)(struct psp_context *psp, uint64_t *node_id);
> > @@ -307,8 +304,6 @@ struct amdgpu_psp_funcs {
> >  #define psp_ring_create(psp, type) (psp)->funcs->ring_create((psp), (type))
> >  #define psp_ring_stop(psp, type) (psp)->funcs->ring_stop((psp), (type))
> >  #define psp_ring_destroy(psp, type) ((psp)->funcs->ring_destroy((psp), (type)))
> > -#define psp_compare_sram_data(psp, ucode, type) \
> > -             (psp)->funcs->compare_sram_data((psp), (ucode), (type))
> >  #define psp_init_microcode(psp) \
> >               ((psp)->funcs->init_microcode ? (psp)->funcs->init_microcode((psp)) : 0)
> >  #define psp_bootloader_load_kdb(psp) \
> > @@ -340,8 +335,6 @@ struct amdgpu_psp_funcs {
> >  #define psp_mem_training(psp, ops) \
> >       ((psp)->funcs->mem_training ? (psp)->funcs->mem_training((psp), (ops)) : 0)
> >
> > -#define amdgpu_psp_check_fw_loading_status(adev, i) (adev)->firmware.funcs->check_fw_loading_status((adev), (i))
> > -
> >  #define psp_ras_trigger_error(psp, info) \
> >       ((psp)->funcs->ras_trigger_error ? \
> >       (psp)->funcs->ras_trigger_error((psp), (info)) : -EINVAL)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> > index 7539104..6e041b7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> > @@ -230,129 +230,6 @@ static int psp_v10_0_ring_destroy(struct psp_context *psp,
> >       return ret;
> >  }
> >
> > -static int
> > -psp_v10_0_sram_map(struct amdgpu_device *adev,
> > -                unsigned int *sram_offset, unsigned int *sram_addr_reg_offset,
> > -                unsigned int *sram_data_reg_offset,
> > -                enum AMDGPU_UCODE_ID ucode_id)
> > -{
> > -     int ret = 0;
> > -
> > -     switch(ucode_id) {
> > -/* TODO: needs to confirm */
> > -#if 0
> > -     case AMDGPU_UCODE_ID_SMC:
> > -             *sram_offset = 0;
> > -             *sram_addr_reg_offset = 0;
> > -             *sram_data_reg_offset = 0;
> > -             break;
> > -#endif
> > -
> > -     case AMDGPU_UCODE_ID_CP_CE:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_PFP:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_ME:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_MEC1:
> > -             *sram_offset = 0x10000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_MEC2:
> > -             *sram_offset = 0x10000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_RLC_G:
> > -             *sram_offset = 0x2000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_SDMA0:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
> > -             break;
> > -
> > -/* TODO: needs to confirm */
> > -#if 0
> > -     case AMDGPU_UCODE_ID_SDMA1:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_UVD:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_VCE:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -#endif
> > -
> > -     case AMDGPU_UCODE_ID_MAXIMUM:
> > -     default:
> > -             ret = -EINVAL;
> > -             break;
> > -     }
> > -
> > -     return ret;
> > -}
> > -
> > -static bool psp_v10_0_compare_sram_data(struct psp_context *psp,
> > -                                     struct amdgpu_firmware_info *ucode,
> > -                                     enum AMDGPU_UCODE_ID ucode_type)
> > -{
> > -     int err = 0;
> > -     unsigned int fw_sram_reg_val = 0;
> > -     unsigned int fw_sram_addr_reg_offset = 0;
> > -     unsigned int fw_sram_data_reg_offset = 0;
> > -     unsigned int ucode_size;
> > -     uint32_t *ucode_mem = NULL;
> > -     struct amdgpu_device *adev = psp->adev;
> > -
> > -     err = psp_v10_0_sram_map(adev, &fw_sram_reg_val, &fw_sram_addr_reg_offset,
> > -                             &fw_sram_data_reg_offset, ucode_type);
> > -     if (err)
> > -             return false;
> > -
> > -     WREG32(fw_sram_addr_reg_offset, fw_sram_reg_val);
> > -
> > -     ucode_size = ucode->ucode_size;
> > -     ucode_mem = (uint32_t *)ucode->kaddr;
> > -     while (!ucode_size) {
> > -             fw_sram_reg_val = RREG32(fw_sram_data_reg_offset);
> > -
> > -             if (*ucode_mem != fw_sram_reg_val)
> > -                     return false;
> > -
> > -             ucode_mem++;
> > -             /* 4 bytes */
> > -             ucode_size -= 4;
> > -     }
> > -
> > -     return true;
> > -}
> > -
> > -
> >  static int psp_v10_0_mode1_reset(struct psp_context *psp)
> >  {
> >       DRM_INFO("psp mode 1 reset not supported now! \n");
> > @@ -379,7 +256,6 @@ static const struct psp_funcs psp_v10_0_funcs = {
> >       .ring_create = psp_v10_0_ring_create,
> >       .ring_stop = psp_v10_0_ring_stop,
> >       .ring_destroy = psp_v10_0_ring_destroy,
> > -     .compare_sram_data = psp_v10_0_compare_sram_data,
> >       .mode1_reset = psp_v10_0_mode1_reset,
> >       .ring_get_wptr = psp_v10_0_ring_get_wptr,
> >       .ring_set_wptr = psp_v10_0_ring_set_wptr,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > index 20fbd43..f633577 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > @@ -554,138 +554,6 @@ static int psp_v11_0_ring_destroy(struct psp_context *psp,
> >       return ret;
> >  }
> >
> > -static int
> > -psp_v11_0_sram_map(struct amdgpu_device *adev,
> > -               unsigned int *sram_offset, unsigned int *sram_addr_reg_offset,
> > -               unsigned int *sram_data_reg_offset,
> > -               enum AMDGPU_UCODE_ID ucode_id)
> > -{
> > -     int ret = 0;
> > -
> > -     switch (ucode_id) {
> > -/* TODO: needs to confirm */
> > -#if 0
> > -     case AMDGPU_UCODE_ID_SMC:
> > -             *sram_offset = 0;
> > -             *sram_addr_reg_offset = 0;
> > -             *sram_data_reg_offset = 0;
> > -             break;
> > -#endif
> > -
> > -     case AMDGPU_UCODE_ID_CP_CE:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_PFP:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_ME:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_MEC1:
> > -             *sram_offset = 0x10000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_MEC2:
> > -             *sram_offset = 0x10000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_RLC_G:
> > -             *sram_offset = 0x2000;
> > -             if (adev->asic_type < CHIP_NAVI10) {
> > -                     *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
> > -                     *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
> > -             } else {
> > -                     *sram_addr_reg_offset = adev->reg_offset[GC_HWIP][0][1] + mmRLC_GPM_UCODE_ADDR_NV10;
> > -                     *sram_data_reg_offset = adev->reg_offset[GC_HWIP][0][1] + mmRLC_GPM_UCODE_DATA_NV10;
> > -             }
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_SDMA0:
> > -             *sram_offset = 0x0;
> > -             if (adev->asic_type < CHIP_NAVI10) {
> > -                     *sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
> > -                     *sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
> > -             } else {
> > -                     *sram_addr_reg_offset = adev->reg_offset[GC_HWIP][0][1] + mmSDMA0_UCODE_ADDR_NV10;
> > -                     *sram_data_reg_offset = adev->reg_offset[GC_HWIP][0][1] + mmSDMA0_UCODE_DATA_NV10;
> > -             }
> > -             break;
> > -
> > -/* TODO: needs to confirm */
> > -#if 0
> > -     case AMDGPU_UCODE_ID_SDMA1:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_UVD:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_VCE:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -#endif
> > -
> > -     case AMDGPU_UCODE_ID_MAXIMUM:
> > -     default:
> > -             ret = -EINVAL;
> > -             break;
> > -     }
> > -
> > -     return ret;
> > -}
> > -
> > -static bool psp_v11_0_compare_sram_data(struct psp_context *psp,
> > -                                    struct amdgpu_firmware_info *ucode,
> > -                                    enum AMDGPU_UCODE_ID ucode_type)
> > -{
> > -     int err = 0;
> > -     unsigned int fw_sram_reg_val = 0;
> > -     unsigned int fw_sram_addr_reg_offset = 0;
> > -     unsigned int fw_sram_data_reg_offset = 0;
> > -     unsigned int ucode_size;
> > -     uint32_t *ucode_mem = NULL;
> > -     struct amdgpu_device *adev = psp->adev;
> > -
> > -     err = psp_v11_0_sram_map(adev, &fw_sram_reg_val, &fw_sram_addr_reg_offset,
> > -                             &fw_sram_data_reg_offset, ucode_type);
> > -     if (err)
> > -             return false;
> > -
> > -     WREG32(fw_sram_addr_reg_offset, fw_sram_reg_val);
> > -
> > -     ucode_size = ucode->ucode_size;
> > -     ucode_mem = (uint32_t *)ucode->kaddr;
> > -     while (ucode_size) {
> > -             fw_sram_reg_val = RREG32(fw_sram_data_reg_offset);
> > -
> > -             if (*ucode_mem != fw_sram_reg_val)
> > -                     return false;
> > -
> > -             ucode_mem++;
> > -             /* 4 bytes */
> > -             ucode_size -= 4;
> > -     }
> > -
> > -     return true;
> > -}
> > -
> >  static int psp_v11_0_mode1_reset(struct psp_context *psp)
> >  {
> >       int ret;
> > @@ -1190,7 +1058,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
> >       .ring_create = psp_v11_0_ring_create,
> >       .ring_stop = psp_v11_0_ring_stop,
> >       .ring_destroy = psp_v11_0_ring_destroy,
> > -     .compare_sram_data = psp_v11_0_compare_sram_data,
> >       .mode1_reset = psp_v11_0_mode1_reset,
> >       .xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
> >       .xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > index d3c86a0..42c485b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > @@ -324,128 +324,6 @@ static int psp_v12_0_ring_destroy(struct psp_context *psp,
> >       return ret;
> >  }
> >
> > -static int
> > -psp_v12_0_sram_map(struct amdgpu_device *adev,
> > -               unsigned int *sram_offset, unsigned int *sram_addr_reg_offset,
> > -               unsigned int *sram_data_reg_offset,
> > -               enum AMDGPU_UCODE_ID ucode_id)
> > -{
> > -     int ret = 0;
> > -
> > -     switch (ucode_id) {
> > -/* TODO: needs to confirm */
> > -#if 0
> > -     case AMDGPU_UCODE_ID_SMC:
> > -             *sram_offset = 0;
> > -             *sram_addr_reg_offset = 0;
> > -             *sram_data_reg_offset = 0;
> > -             break;
> > -#endif
> > -
> > -     case AMDGPU_UCODE_ID_CP_CE:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_PFP:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_ME:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_MEC1:
> > -             *sram_offset = 0x10000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_MEC2:
> > -             *sram_offset = 0x10000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_RLC_G:
> > -             *sram_offset = 0x2000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_SDMA0:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
> > -             break;
> > -
> > -/* TODO: needs to confirm */
> > -#if 0
> > -     case AMDGPU_UCODE_ID_SDMA1:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_UVD:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_VCE:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -#endif
> > -
> > -     case AMDGPU_UCODE_ID_MAXIMUM:
> > -     default:
> > -             ret = -EINVAL;
> > -             break;
> > -     }
> > -
> > -     return ret;
> > -}
> > -
> > -static bool psp_v12_0_compare_sram_data(struct psp_context *psp,
> > -                                    struct amdgpu_firmware_info *ucode,
> > -                                    enum AMDGPU_UCODE_ID ucode_type)
> > -{
> > -     int err = 0;
> > -     unsigned int fw_sram_reg_val = 0;
> > -     unsigned int fw_sram_addr_reg_offset = 0;
> > -     unsigned int fw_sram_data_reg_offset = 0;
> > -     unsigned int ucode_size;
> > -     uint32_t *ucode_mem = NULL;
> > -     struct amdgpu_device *adev = psp->adev;
> > -
> > -     err = psp_v12_0_sram_map(adev, &fw_sram_reg_val, &fw_sram_addr_reg_offset,
> > -                             &fw_sram_data_reg_offset, ucode_type);
> > -     if (err)
> > -             return false;
> > -
> > -     WREG32(fw_sram_addr_reg_offset, fw_sram_reg_val);
> > -
> > -     ucode_size = ucode->ucode_size;
> > -     ucode_mem = (uint32_t *)ucode->kaddr;
> > -     while (ucode_size) {
> > -             fw_sram_reg_val = RREG32(fw_sram_data_reg_offset);
> > -
> > -             if (*ucode_mem != fw_sram_reg_val)
> > -                     return false;
> > -
> > -             ucode_mem++;
> > -             /* 4 bytes */
> > -             ucode_size -= 4;
> > -     }
> > -
> > -     return true;
> > -}
> > -
> >  static int psp_v12_0_mode1_reset(struct psp_context *psp)
> >  {
> >       int ret;
> > @@ -512,7 +390,6 @@ static const struct psp_funcs psp_v12_0_funcs = {
> >       .ring_create = psp_v12_0_ring_create,
> >       .ring_stop = psp_v12_0_ring_stop,
> >       .ring_destroy = psp_v12_0_ring_destroy,
> > -     .compare_sram_data = psp_v12_0_compare_sram_data,
> >       .mode1_reset = psp_v12_0_mode1_reset,
> >       .ring_get_wptr = psp_v12_0_ring_get_wptr,
> >       .ring_set_wptr = psp_v12_0_ring_set_wptr,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> > index ab03190..9ca37d0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> > @@ -398,128 +398,6 @@ static int psp_v3_1_ring_destroy(struct psp_context *psp,
> >       return ret;
> >  }
> >
> > -static int
> > -psp_v3_1_sram_map(struct amdgpu_device *adev,
> > -               unsigned int *sram_offset, unsigned int *sram_addr_reg_offset,
> > -               unsigned int *sram_data_reg_offset,
> > -               enum AMDGPU_UCODE_ID ucode_id)
> > -{
> > -     int ret = 0;
> > -
> > -     switch(ucode_id) {
> > -/* TODO: needs to confirm */
> > -#if 0
> > -     case AMDGPU_UCODE_ID_SMC:
> > -             *sram_offset = 0;
> > -             *sram_addr_reg_offset = 0;
> > -             *sram_data_reg_offset = 0;
> > -             break;
> > -#endif
> > -
> > -     case AMDGPU_UCODE_ID_CP_CE:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_PFP:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_ME:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_MEC1:
> > -             *sram_offset = 0x10000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_CP_MEC2:
> > -             *sram_offset = 0x10000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_RLC_G:
> > -             *sram_offset = 0x2000;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_SDMA0:
> > -             *sram_offset = 0x0;
> > -             *sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
> > -             *sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
> > -             break;
> > -
> > -/* TODO: needs to confirm */
> > -#if 0
> > -     case AMDGPU_UCODE_ID_SDMA1:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_UVD:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -
> > -     case AMDGPU_UCODE_ID_VCE:
> > -             *sram_offset = ;
> > -             *sram_addr_reg_offset = ;
> > -             break;
> > -#endif
> > -
> > -     case AMDGPU_UCODE_ID_MAXIMUM:
> > -     default:
> > -             ret = -EINVAL;
> > -             break;
> > -     }
> > -
> > -     return ret;
> > -}
> > -
> > -static bool psp_v3_1_compare_sram_data(struct psp_context *psp,
> > -                                    struct amdgpu_firmware_info *ucode,
> > -                                    enum AMDGPU_UCODE_ID ucode_type)
> > -{
> > -     int err = 0;
> > -     unsigned int fw_sram_reg_val = 0;
> > -     unsigned int fw_sram_addr_reg_offset = 0;
> > -     unsigned int fw_sram_data_reg_offset = 0;
> > -     unsigned int ucode_size;
> > -     uint32_t *ucode_mem = NULL;
> > -     struct amdgpu_device *adev = psp->adev;
> > -
> > -     err = psp_v3_1_sram_map(adev, &fw_sram_reg_val, &fw_sram_addr_reg_offset,
> > -                             &fw_sram_data_reg_offset, ucode_type);
> > -     if (err)
> > -             return false;
> > -
> > -     WREG32(fw_sram_addr_reg_offset, fw_sram_reg_val);
> > -
> > -     ucode_size = ucode->ucode_size;
> > -     ucode_mem = (uint32_t *)ucode->kaddr;
> > -     while (ucode_size) {
> > -             fw_sram_reg_val = RREG32(fw_sram_data_reg_offset);
> > -
> > -             if (*ucode_mem != fw_sram_reg_val)
> > -                     return false;
> > -
> > -             ucode_mem++;
> > -             /* 4 bytes */
> > -             ucode_size -= 4;
> > -     }
> > -
> > -     return true;
> > -}
> > -
> >  static bool psp_v3_1_smu_reload_quirk(struct psp_context *psp)
> >  {
> >       struct amdgpu_device *adev = psp->adev;
> > @@ -596,7 +474,6 @@ static const struct psp_funcs psp_v3_1_funcs = {
> >       .ring_create = psp_v3_1_ring_create,
> >       .ring_stop = psp_v3_1_ring_stop,
> >       .ring_destroy = psp_v3_1_ring_destroy,
> > -     .compare_sram_data = psp_v3_1_compare_sram_data,
> >       .smu_reload_quirk = psp_v3_1_smu_reload_quirk,
> >       .mode1_reset = psp_v3_1_mode1_reset,
> >       .ring_get_wptr = psp_v3_1_ring_get_wptr,
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
