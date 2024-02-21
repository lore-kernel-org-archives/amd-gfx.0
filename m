Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D336AC48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 15:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D9510E7B6;
	Wed, 21 Feb 2024 15:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iAH9eqWY";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9677F10E7B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 15:50:45 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so6255465ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708530645; x=1709135445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWTgTrsjm1nIcvsYZH9qhiyZ5y4f9MzlaFlw82zm38E=;
 b=iAH9eqWY5EIkPOY8rfEdmMa15HnPnVJR7pTZYIMY7uWuP0TEs0Icm971gPhnp32Iv1
 ScYH6VsWxg1Rvk9fgszgv3ee86uwrHnsKSEqis+d6zaG3VkdxI+WCyXOpAsxTZWGnVqT
 hUtVfsIDL7F+ZJ/uRyoopIG41VLzy9WwEp67R+eDD4/IGnfuBVEQBB3g5tZ5H9MWJ4Jt
 q/kELcBYIpqbLjtZCY6yDK5wF8Ag4RUFPgiYEgAGgacWEPAn5iSANRtmrjlbTXH2CPre
 +7cLv/VDOePaqNg5O0oi22zRFg4VtNsMfdvLKdEsLbg48BesI7qTgxjBbVh9UMzuk8OS
 ksiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708530645; x=1709135445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWTgTrsjm1nIcvsYZH9qhiyZ5y4f9MzlaFlw82zm38E=;
 b=hEduyjNLicaMVsI+y/dGXe6OWDHbE0ak1rEK5DcvJACY0c6/g6Sp/lQcKee4WRExbo
 4FTfdS0/w58//mrLqLYxh0Z4eIPS9/uHe4ytsHoNPMwpAohIa7VbBuEvTNYc99f9G07P
 SWICiST8wWrYNCuy735APpDPxH1g6EHWph6+L8UOpdb9D6a3m6wo6S5QsPLu30vdU+C0
 qhsfE6Aswi20a74OL0nJ1D1/3QXNSIHybtA+94NvRXPsgwhqAOlXVFG1zU6yDApNebzG
 1wxIUw0QuS9izg5QcgUKLJxh04rDjyUSWWXP5r1J7VV8dndNomu/M9whtfgeN+PoF/W1
 fYgQ==
X-Gm-Message-State: AOJu0YzLDXTFfc19bwUr9Rg8dPEjIJcHqp64hQRKkqfH2mRQ9TbslqXz
 I89P2hCxMGwjyJFF9FszhS2sJE1hExbZtbSTA2I/+gNCqX7oig2yALPLVz0iCmxiqglDD2rYb3a
 8SBzHNmarV4HQ4jKqOYVg1Y1NPhg=
X-Google-Smtp-Source: AGHT+IEtmsITwdclFRW/lHfiKHrvnMFtua86VevA1myGjt1CZYMxFzKFkmOPtvceJzyF2bg025EB+kKRSbJ4lUvkUGY=
X-Received: by 2002:a17:902:b285:b0:1db:e089:7461 with SMTP id
 u5-20020a170902b28500b001dbe0897461mr10166551plr.31.1708530644968; Wed, 21
 Feb 2024 07:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20240220192021.431356-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240220192021.431356-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Feb 2024 10:50:33 -0500
Message-ID: <CADnq5_MVEjyr1nz+=bzQEtn5o0XvUxJgMzCuQv95pxmWOYz3YA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Update atomfirmware.h for DCN401
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 hawking.zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 20, 2024 at 2:38=E2=80=AFPM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> Add new firmware header definitions reqiured for DCN401
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/atomfirmware.h | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index fa7d6ced786f..206c8a025f9e 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -610,6 +610,39 @@ struct atom_firmware_info_v3_4 {
>          uint32_t reserved[2];
>  };
>
> +struct atom_firmware_info_v3_5
> +{
> +  struct atom_common_table_header table_header;
> +  uint32_t firmware_revision;
> +  uint32_t bootup_clk_reserved[2];
> +  uint32_t firmware_capability;             // enum atombios_firmware_ca=
pability
> +  uint32_t fw_protect_region_size_in_kb;    /* FW allocate a write prote=
ct region at top of FB. */
> +  uint32_t bios_scratch_reg_startaddr;      // 1st bios scratch register=
 dword address
> +  uint32_t bootup_voltage_reserved[2];
> +  uint8_t  mem_module_id;
> +  uint8_t  coolingsolution_id;              /*0: Air cooling; 1: Liquid =
cooling ... */
> +  uint8_t  hw_blt_mode;                     //0:HW_BLT_DMA_PIO_MODE; 1:H=
W_BLT_LITE_SDMA_MODE; 2:HW_BLT_PCI_IO_MODE
> +  uint8_t  reserved1;
> +  uint32_t mc_baseaddr_high;
> +  uint32_t mc_baseaddr_low;
> +  uint8_t  board_i2c_feature_id;            // enum of atom_board_i2c_fe=
ature_id_def
> +  uint8_t  board_i2c_feature_gpio_id;       // i2c id find in gpio_lut d=
ata table gpio_id
> +  uint8_t  board_i2c_feature_slave_addr;
> +  uint8_t  ras_rom_i2c_slave_addr;
> +  uint32_t bootup_voltage_reserved1;
> +  uint32_t zfb_reserved;
> +  // if pplib_pptable_id!=3D0, pplib get powerplay table inside driver i=
nstead of from VBIOS
> +  uint32_t pplib_pptable_id;
> +  uint32_t hw_voltage_reserved[3];
> +  uint32_t maco_pwrlimit_mw;                // bomaco mode power limit i=
n unit of m-watt
> +  uint32_t usb_pwrlimit_mw;                 // power limit when USB is e=
nable in unit of m-watt
> +  uint32_t fw_reserved_size_in_kb;          // VBIOS reserved extra fw s=
ize in unit of kb.
> +  uint32_t pspbl_init_reserved[3];
> +  uint32_t spi_rom_size;                    // GPU spi rom size
> +  uint16_t support_dev_in_objinfo;
> +  uint16_t disp_phy_tunning_size;
> +  uint32_t reserved[16];
> +};
>  /*
>    **********************************************************************=
*****
>      Data Table lcd_info  structure
> --
> 2.43.0
>
