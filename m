Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480DC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34C1613D8
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34C1613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE086E4FB;
	Thu, 10 Jun 2021 20:59:34 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87C36E4FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 20:59:33 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 w23-20020a9d5a970000b02903d0ef989477so1036666oth.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HSs6usRBS+EoqFLcj1H2oGOrnk4cxAMT4Ki4di7HJ5k=;
 b=a7pzgb/5rT/Xhkjk2bZaBsZodd7g4svMO8nO75jTRxh09FzrV3dSUdPl/cFIWx6sGo
 sRRKQiy9dNKXU/qtLmJj4pe12AUrkmv7iGNjH3gAvZKGaW215SM0Ltu+9MJJwbTMGmYV
 lBlz9Nyj6PJdSw1C2yJiPP/t74ZNlsEDIWMfT8D8s+kVVs33e892UUiWHMLcHMxTWQZh
 5eGu/BOod6w1/6YsnwEXe+MGkzAScO+9DJD9ngHbwJLjaQ79s2FKmThIX9Ak8yDq/El4
 LljX1d2Cq4W4Ggd2oPYmyCPY3x0GNJN/+b5aIa1d6Xh9HzOgBbmP8SOQix4E5Ty9sPhh
 Jocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HSs6usRBS+EoqFLcj1H2oGOrnk4cxAMT4Ki4di7HJ5k=;
 b=DXAMS0+7po070P4VCAk50d3TVNXULLu3emzpsgIGwOP8N1frApEucnr0nfKCqH/fVe
 v72Btouc7t0F4QkP41XtTg+4i3lK9Pfs/a5KsaFxCc4WDaF42ANSveNAkjiG80tnPzPY
 89s523czZlB4uqPJTwQ01Bgqo8HZkXu2E9jw3dV6+LVKVmK/WTRsHII/cnWjd0oE0fjx
 Icftn7/dWg6Ar3/Dc/uCVLGsnm5z6g5+VMuQm660/OSmF/t8qH+iOeODRgdAaH4Eid9A
 QRo17hlJIT03S2J4MuXiji0X6XOJC1GPSj6BOSJBuCRvGZKnv7lbJRCxjWizyN0JB1w6
 XImQ==
X-Gm-Message-State: AOAM530WN9qnFUPqbJxRxA97Ah2EQfgg2YjMrftIlt5hIZwiKCdKuSiN
 J3Uw58+er8CJzb9r2PXnqIgOV+nVVnb5fiFk1AMRJuaSqDE=
X-Google-Smtp-Source: ABdhPJyO6hVxGWWzRElFOonQBFt/nszUxNZJEIiKByMLbzo5Dxlqu43tuHD0bWPQB8juln+7/z2cxxaNPLxVtqhUcq8=
X-Received: by 2002:a9d:6287:: with SMTP id x7mr271503otk.132.1623358773114;
 Thu, 10 Jun 2021 13:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-23-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-23-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 16:59:22 -0400
Message-ID: <CADnq5_NZJvxcU_Gcf9xzmH6kN5HEDoQmL6a1-0=0V4HmBkSwBw@mail.gmail.com>
Subject: Re: [PATCH 22/40] drm/amdgpu: RAS and FRU now use 19-bit I2C address
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:40 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Convert RAS and FRU code to use the 19-bit I2C
> memory address and remove all "slave_addr", as
> this is now absolved into the 19-bit address.
>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: John Clements <john.clements@amd.com>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 19 ++---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 82 +++++++------------
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +-
>  3 files changed, 39 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 2b854bc6ae34bb..69b9559f840ac3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -29,8 +29,8 @@
>  #include "amdgpu_fru_eeprom.h"
>  #include "amdgpu_eeprom.h"
>
> -#define I2C_PRODUCT_INFO_ADDR          0x56
> -#define I2C_PRODUCT_INFO_OFFSET                0xC0
> +#define FRU_EEPROM_MADDR        0x60000
> +#define I2C_PRODUCT_INFO_OFFSET 0xC0
>
>  static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
>  {
> @@ -62,12 +62,11 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
>  }
>
>  static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
> -                          unsigned char *buff)
> +                                 unsigned char *buff)
>  {
>         int ret, size;
>
> -       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, I2C_PRODUCT_INFO_ADDR,
> -                                addrptr, buff, 1, true);
> +       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr, buff, 1, true);
>         if (ret < 1) {
>                 DRM_WARN("FRU: Failed to get size field");
>                 return ret;
> @@ -78,8 +77,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
>          */
>         size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
>
> -       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, I2C_PRODUCT_INFO_ADDR,
> -                                addrptr + 1, buff, size, true);
> +       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr + 1, buff, size,
> +                                true);
>         if (ret < 1) {
>                 DRM_WARN("FRU: Failed to get data field");
>                 return ret;
> @@ -91,8 +90,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
>  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>  {
>         unsigned char buff[34];
> -       int addrptr, size;
> -       int len;
> +       u32 addrptr;
> +       int size, len;
>
>         if (!is_fru_eeprom_supported(adev))
>                 return 0;
> @@ -115,7 +114,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>          * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
>          * and the language field, so just start from 0xb, manufacturer size
>          */
> -       addrptr = 0xb;
> +       addrptr = FRU_EEPROM_MADDR + 0xb;
>         size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
>         if (size < 1) {
>                 DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2b981e96ce5b9e..f316fb11b16d9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -28,11 +28,11 @@
>  #include "atom.h"
>  #include "amdgpu_eeprom.h"
>
> -#define EEPROM_I2C_TARGET_ADDR_VEGA20          0x50
> -#define EEPROM_I2C_TARGET_ADDR_ARCTURUS                0x54
> -#define EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342   0x50
> -#define EEPROM_I2C_TARGET_ADDR_SIENNA_CICHLID   0x50
> -#define EEPROM_I2C_TARGET_ADDR_ALDEBARAN        0x50
> +#define EEPROM_I2C_MADDR_VEGA20         0x0
> +#define EEPROM_I2C_MADDR_ARCTURUS       0x40000
> +#define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
> +#define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
> +#define EEPROM_I2C_MADDR_ALDEBARAN      0x0
>
>  /*
>   * The 2 macros bellow represent the actual size in bytes that
> @@ -58,7 +58,6 @@
>  #define EEPROM_HDR_START 0
>  #define EEPROM_RECORD_START (EEPROM_HDR_START + EEPROM_TABLE_HEADER_SIZE)
>  #define EEPROM_MAX_RECORD_NUM ((EEPROM_SIZE_BYTES - EEPROM_TABLE_HEADER_SIZE) / EEPROM_TABLE_RECORD_SIZE)
> -#define EEPROM_ADDR_MSB_MASK GENMASK(17, 8)
>
>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
>
> @@ -74,43 +73,43 @@ static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
>  }
>
>  static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
> -                                      uint16_t *i2c_addr)
> +                                      struct amdgpu_ras_eeprom_control *control)
>  {
>         struct atom_context *atom_ctx = adev->mode_info.atom_context;
>
> -       if (!i2c_addr || !atom_ctx)
> +       if (!control || !atom_ctx)
>                 return false;
>
>         if (strnstr(atom_ctx->vbios_version,
>                     "D342",
>                     sizeof(atom_ctx->vbios_version)))
> -               *i2c_addr = EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342;
> +               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS_D342;
>         else
> -               *i2c_addr = EEPROM_I2C_TARGET_ADDR_ARCTURUS;
> +               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
>
>         return true;
>  }
>
>  static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
> -                                 uint16_t *i2c_addr)
> +                                 struct amdgpu_ras_eeprom_control *control)
>  {
> -       if (!i2c_addr)
> +       if (!control)
>                 return false;
>
>         switch (adev->asic_type) {
>         case CHIP_VEGA20:
> -               *i2c_addr = EEPROM_I2C_TARGET_ADDR_VEGA20;
> +               control->i2c_address = EEPROM_I2C_MADDR_VEGA20;
>                 break;
>
>         case CHIP_ARCTURUS:
> -               return __get_eeprom_i2c_addr_arct(adev, i2c_addr);
> +               return __get_eeprom_i2c_addr_arct(adev, control);
>
>         case CHIP_SIENNA_CICHLID:
> -               *i2c_addr = EEPROM_I2C_TARGET_ADDR_SIENNA_CICHLID;
> +               control->i2c_address = EEPROM_I2C_MADDR_SIENNA_CICHLID;
>                 break;
>
>         case CHIP_ALDEBARAN:
> -               *i2c_addr = EEPROM_I2C_TARGET_ADDR_ALDEBARAN;
> +               control->i2c_address = EEPROM_I2C_MADDR_ALDEBARAN;
>                 break;
>
>         default:
> @@ -154,8 +153,9 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>
>         /* i2c may be unstable in gpu reset */
>         down_read(&adev->reset_sem);
> -       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, control->i2c_address,
> -                                EEPROM_HDR_START, buff, EEPROM_TABLE_HEADER_SIZE, false);
> +       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
> +                                control->i2c_address + EEPROM_HDR_START,
> +                                buff, EEPROM_TABLE_HEADER_SIZE, false);
>         up_read(&adev->reset_sem);
>
>         if (ret < 1)
> @@ -277,7 +277,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
>  }
>
>  int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
> -                       bool *exceed_err_limit)
> +                          bool *exceed_err_limit)
>  {
>         int ret = 0;
>         struct amdgpu_device *adev = to_amdgpu_device(control);
> @@ -294,14 +294,15 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>         if (!adev->pm.smu_i2c.algo)
>                 return -ENOENT;
>
> -       if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
> +       if (!__get_eeprom_i2c_addr(adev, control))
>                 return -EINVAL;
>
>         mutex_init(&control->tbl_mutex);
>
>         /* Read/Create table header from EEPROM address 0 */
> -       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, control->i2c_address,
> -                                EEPROM_HDR_START, buff, EEPROM_TABLE_HEADER_SIZE, true);
> +       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
> +                                control->i2c_address + EEPROM_HDR_START,
> +                                buff, EEPROM_TABLE_HEADER_SIZE, true);
>         if (ret < 1) {
>                 DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
>                 return ret;
> @@ -395,8 +396,6 @@ static void __decode_table_record_from_buff(struct amdgpu_ras_eeprom_control *co
>
>  /*
>   * When reaching end of EEPROM memory jump back to 0 record address
> - * When next record access will go beyond EEPROM page boundary modify bits A17/A8
> - * in I2C selector to go to next page
>   */
>  static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
>  {
> @@ -409,20 +408,6 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
>                 return EEPROM_RECORD_START;
>         }
>
> -       /*
> -        * To check if we overflow page boundary  compare next address with
> -        * current and see if bits 17/8 of the EEPROM address will change
> -        * If they do start from the next 256b page
> -        *
> -        * https://www.st.com/resource/en/datasheet/m24m02-dr.pdf sec. 5.1.2
> -        */
> -       if ((curr_address & EEPROM_ADDR_MSB_MASK) != (next_address & EEPROM_ADDR_MSB_MASK)) {
> -               DRM_DEBUG_DRIVER("Reached end of EEPROM memory page, jumping to next: %lx",
> -                               (next_address & EEPROM_ADDR_MSB_MASK));
> -
> -               return  (next_address & EEPROM_ADDR_MSB_MASK);
> -       }
> -
>         return curr_address;
>  }
>
> @@ -452,22 +437,20 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
>  }
>
>  int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
> -                                           struct eeprom_table_record *records,
> -                                           bool write,
> -                                           int num)
> +                                    struct eeprom_table_record *records,
> +                                    bool write, int num)
>  {
>         int i, ret = 0;
>         unsigned char *buffs, *buff;
>         struct eeprom_table_record *record;
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>         struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> -       u16 slave_addr;
>
>         if (!__is_ras_eeprom_supported(adev))
>                 return 0;
>
>         buffs = kcalloc(num, EEPROM_ADDRESS_SIZE + EEPROM_TABLE_RECORD_SIZE,
> -                        GFP_KERNEL);
> +                       GFP_KERNEL);
>         if (!buffs)
>                 return -ENOMEM;
>
> @@ -507,22 +490,15 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
>
>                 control->next_addr = __correct_eeprom_dest_address(control->next_addr);
>
> -               /*
> -                * Update bits 16,17 of EEPROM address in I2C address by setting them
> -                * to bits 1,2 of Device address byte
> -                */
> -               slave_addr = control->i2c_address |
> -                       ((control->next_addr & EEPROM_ADDR_MSB_MASK) >> 15);
> -
>                 /* EEPROM table content is stored in LE format */
>                 if (write)
>                         __encode_table_record_to_buff(control, record, buff);
>
>                 /* i2c may be unstable in gpu reset */
>                 down_read(&adev->reset_sem);
> -               ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, slave_addr,
> -                                        control->next_addr, buff,
> -                                        EEPROM_TABLE_RECORD_SIZE, write ? false : true);
> +               ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
> +                                        control->i2c_address + control->next_addr,
> +                                        buff, EEPROM_TABLE_RECORD_SIZE, !write);
>                 up_read(&adev->reset_sem);
>
>                 if (ret < 1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 17872117097455..4c4c3d840a35c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -44,11 +44,11 @@ struct amdgpu_ras_eeprom_table_header {
>
>  struct amdgpu_ras_eeprom_control {
>         struct amdgpu_ras_eeprom_table_header tbl_hdr;
> +       u32 i2c_address; /* Base I2C 19-bit memory address */
>         uint32_t next_addr;
>         unsigned int num_recs;
>         struct mutex tbl_mutex;
>         uint32_t tbl_byte_sum;
> -       uint16_t i2c_address; // 8-bit represented address
>  };
>
>  /*
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
