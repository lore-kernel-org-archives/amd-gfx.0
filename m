Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E0C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 13:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF5161179
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 13:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF5161179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4186E49B;
	Wed, 14 Apr 2021 13:02:03 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF456E49B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 13:02:02 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id b3so5713187oie.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dx85E6SIpDFCHzsJmI0WoeS+r/wnmof58/5sGyxHlTw=;
 b=qQTo/TwTd1PBHz0VvtkWQGZ8EZimLyQpg4PkxF9a3/9bNod7vLkMkUj8W5JhhvHMts
 TFaLWWzqECByVtQn7sua+y/sMSr6uTssYw2xaCjQfVVDMQ1f7yMxBve/koVKOI/MlxIO
 PbJUm+0qxJKgqayw8ZSmQc5bdeZuJC4sxnkeTfCIxkb8AgQ89iqyi963w9qAS4xv8rBr
 rMWGp4iN4/qN1LHPoD1bI0eEwpWaaJTShX4D/O1lp7aYZalyD3tF3AdvxxKgUmci0rRX
 7AJsdv0VFdgF3GuJRyxai9YlmEG75FLlbqB6sDOHPdixD3s/QYyxcA59VpetGnuwtbA3
 JY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dx85E6SIpDFCHzsJmI0WoeS+r/wnmof58/5sGyxHlTw=;
 b=nEkYL9tp4vZJ6XOvPMoXx+xmRp0stpyeWCX8JdN0ej8n3ZuZAHjID0ddGNrxBj0c+R
 3IDa8sFO0orxwz1HpswKmPAGSbXlPTsK/Mm05lGRmjbIS4YPNsH15Y+2F9jyU9i1zlh8
 yjSURa62JxFNciLi7erATEEnLWprrYkVP2HInCAQxfFteWgleT6hhPu5jXO+aX360pwA
 AqW5eb3FEfiSYhVX+FEw5McUvUsvfm1w5mzaK3ytMnRVZuXjkQt9+m6kGj0UQBeE25xH
 zUHnQoVNpqMiuq3vZ0UlBfqkSUel4D5Y/+51wfP9k2dKyTi+kUAN8Pf9z1UQNupoY4Z+
 +FRA==
X-Gm-Message-State: AOAM533aNPXmb/rD1jmyjrPWe3MbqKE4pmu2W+QTi7F4JUofb5Dd92vL
 7X36vRkAFBZI9VEBFIBEptAVz+iJeKmkKIRcixY=
X-Google-Smtp-Source: ABdhPJz2aTCp/E7L5ng3BOm0cOsHcfGsbSXHZgbAEkcRSaFRSoZfx3JVmYQgPt9g7/jGbSoaMqIm9s7i3wjWCs06J7E=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr2245942oig.120.1618405322191; 
 Wed, 14 Apr 2021 06:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210414090853.20993-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210414090853.20993-1-Jiawei.Gu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Apr 2021 09:01:51 -0400
Message-ID: <CADnq5_OWVirYgyNZa9Wy07QBmMu3Rd3_1UN9gQQpnh6vMmdofg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
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
Cc: Emily Deng <emily.deng@amd.com>, Roy Sun <roy.sun@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 14, 2021 at 5:09 AM Jiawei Gu <Jiawei.Gu@amd.com> wrote:
>
> Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.

Please provide a link to patches for an open source tool which uses
this new query.

>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  19 +++
>  drivers/gpu/drm/amd/amdgpu/atom.c          | 158 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/atom.h          |  11 ++
>  drivers/gpu/drm/amd/include/atomfirmware.h |  16 ++-
>  include/uapi/drm/amdgpu_drm.h              |  15 ++
>  5 files changed, 213 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 39ee88d29cca..a20b016b05ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -861,6 +861,25 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>                                             min((size_t)size, (size_t)(bios_size - bios_offset)))
>                                         ? -EFAULT : 0;
>                 }
> +               case AMDGPU_INFO_VBIOS_INFO: {
> +                       struct drm_amdgpu_info_vbios vbios_info = {};
> +                       struct atom_context *atom_context;
> +
> +                       atom_context = adev->mode_info.atom_context;
> +                       memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
> +                       vbios_info.dbdf = PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
> +                       memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
> +                       vbios_info.version = atom_context->version;
> +                       memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
> +                       memcpy(vbios_info.serial, adev->serial, sizeof(adev->serial));
> +                       vbios_info.dev_id = adev->pdev->device;
> +                       vbios_info.rev_id = adev->pdev->revision;
> +                       vbios_info.sub_dev_id = atom_context->sub_dev_id;
> +                       vbios_info.sub_ved_id = atom_context->sub_ved_id;
> +
> +                       return copy_to_user(out, &vbios_info,
> +                                               min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
> +               }
>                 default:
>                         DRM_DEBUG_KMS("Invalid request %d\n",
>                                         info->vbios_info.type);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 3dcb8b32f48b..0e2f0ea13b40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -31,6 +31,7 @@
>
>  #define ATOM_DEBUG
>
> +#include "atomfirmware.h"
>  #include "atom.h"
>  #include "atom-names.h"
>  #include "atom-bits.h"
> @@ -1299,12 +1300,153 @@ static void atom_index_iio(struct atom_context *ctx, int base)
>         }
>  }
>
> +static void atom_get_vbios_name(struct atom_context *ctx)
> +{
> +       unsigned char *p_rom;
> +       unsigned char str_num;
> +       unsigned short off_to_vbios_str;
> +       unsigned char *c_ptr;
> +       int name_size;
> +       int i;
> +
> +       const char *na = "--N/A--";
> +       char *back;
> +
> +       p_rom = ctx->bios;
> +
> +       str_num = *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
> +       if (str_num != 0) {
> +               off_to_vbios_str =
> +                       *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
> +
> +               c_ptr = (unsigned char *)(p_rom + off_to_vbios_str);
> +       } else {
> +               /* do not know where to find name */
> +               memcpy(ctx->name, na, 7);
> +               ctx->name[7] = 0;
> +               return;
> +       }
> +
> +       /*
> +        * skip the atombios strings, usually 4
> +        * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
> +        */
> +       for (i = 0; i < str_num; i++) {
> +               while (*c_ptr != 0)
> +                       c_ptr++;
> +               c_ptr++;
> +       }
> +
> +       /* skip the following 2 chars: 0x0D 0x0A */
> +       c_ptr += 2;
> +
> +       name_size = strnlen(c_ptr, STRLEN_LONG - 1);
> +       memcpy(ctx->name, c_ptr, name_size);
> +       back = ctx->name + name_size;
> +       while ((*--back) == ' ')
> +               ;
> +       *(back + 1) = '\0';
> +}
> +
> +static void atom_get_vbios_date(struct atom_context *ctx)
> +{
> +       unsigned char *p_rom;
> +       unsigned char *date_in_rom;
> +
> +       p_rom = ctx->bios;
> +
> +       date_in_rom = p_rom + OFFSET_TO_VBIOS_DATE;
> +
> +       ctx->date[0] = '2';
> +       ctx->date[1] = '0';
> +       ctx->date[2] = date_in_rom[6];
> +       ctx->date[3] = date_in_rom[7];
> +       ctx->date[4] = '/';
> +       ctx->date[5] = date_in_rom[0];
> +       ctx->date[6] = date_in_rom[1];
> +       ctx->date[7] = '/';
> +       ctx->date[8] = date_in_rom[3];
> +       ctx->date[9] = date_in_rom[4];
> +       ctx->date[10] = ' ';
> +       ctx->date[11] = date_in_rom[9];
> +       ctx->date[12] = date_in_rom[10];
> +       ctx->date[13] = date_in_rom[11];
> +       ctx->date[14] = date_in_rom[12];
> +       ctx->date[15] = date_in_rom[13];
> +       ctx->date[16] = '\0';
> +}
> +
> +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, char *str, int start,
> +                                          int end, int maxlen)
> +{
> +       unsigned long str_off;
> +       unsigned char *p_rom;
> +       unsigned short str_len;
> +
> +       str_off = 0;
> +       str_len = strnlen(str, maxlen);
> +       p_rom = ctx->bios;
> +
> +       for (; start <= end; ++start) {
> +               for (str_off = 0; str_off < str_len; ++str_off) {
> +                       if (str[str_off] != *(p_rom + start + str_off))
> +                               break;
> +               }
> +
> +               if (str_off == str_len || str[str_off] == 0)
> +                       return p_rom + start;
> +       }
> +       return NULL;
> +}
> +
> +static void atom_get_vbios_pn(struct atom_context *ctx)
> +{
> +       unsigned char *p_rom;
> +       unsigned short off_to_vbios_str;
> +       unsigned char *vbios_str;
> +       int count;
> +
> +       off_to_vbios_str = 0;
> +       p_rom = ctx->bios;
> +
> +       if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) != 0) {
> +               off_to_vbios_str =
> +                       *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
> +
> +               vbios_str = (unsigned char *)(p_rom + off_to_vbios_str);
> +       } else {
> +               vbios_str = p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
> +       }
> +
> +       if (*vbios_str == 0) {
> +               vbios_str = atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
> +               if (vbios_str == NULL)
> +                       vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
> +       }
> +       if (vbios_str != NULL && *vbios_str == 0)
> +               vbios_str++;
> +
> +       if (vbios_str != NULL) {
> +               count = 0;
> +               while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >= ' ' &&
> +                      vbios_str[count] <= 'z') {
> +                       ctx->vbios_pn[count] = vbios_str[count];
> +                       count++;
> +               }
> +
> +               ctx->vbios_pn[count] = 0;
> +       }
> +}
> +
>  struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
>  {
>         int base;
>         struct atom_context *ctx =
>             kzalloc(sizeof(struct atom_context), GFP_KERNEL);
>         char *str;
> +       struct _ATOM_ROM_HEADER *atom_rom_header;
> +       struct _ATOM_MASTER_DATA_TABLE *master_table;
> +       struct _ATOM_FIRMWARE_INFO *atom_fw_info;
>         u16 idx;
>
>         if (!ctx)
> @@ -1353,6 +1495,22 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
>                 strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
>         }
>
> +       atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
> +       ctx->sub_dev_id = atom_rom_header->usSubsystemVendorID;
> +       ctx->sub_ved_id = atom_rom_header->usSubsystemID;
> +       if (atom_rom_header->usMasterDataTableOffset != 0) {
> +               master_table = (struct _ATOM_MASTER_DATA_TABLE *)
> +                               CSTR(atom_rom_header->usMasterDataTableOffset);
> +               if (master_table->ListOfDataTables.FirmwareInfo != 0) {
> +                       atom_fw_info = (struct _ATOM_FIRMWARE_INFO *)
> +                                       CSTR(master_table->ListOfDataTables.FirmwareInfo);
> +                       ctx->version = atom_fw_info->ulFirmwareRevision;
> +               }
> +       }
> +
> +       atom_get_vbios_name(ctx);
> +       atom_get_vbios_pn(ctx);
> +       atom_get_vbios_date(ctx);
>
>         return ctx;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
> index d279759cab47..c729f7ceba4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -112,6 +112,10 @@ struct drm_device;
>  #define ATOM_IO_SYSIO          2
>  #define ATOM_IO_IIO            0x80
>
> +#define STRLEN_NORMAL          32
> +#define STRLEN_LONG            64
> +#define STRLEN_VERYLONG                254
> +
>  struct card_info {
>         struct drm_device *dev;
>         void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
> @@ -140,6 +144,13 @@ struct atom_context {
>         uint32_t *scratch;
>         int scratch_size_bytes;
>         char vbios_version[20];
> +
> +       uint8_t name[STRLEN_LONG];
> +       uint8_t vbios_pn[STRLEN_LONG];
> +       uint32_t version;
> +       uint8_t date[STRLEN_NORMAL];
> +       uint32_t sub_dev_id;
> +       uint32_t sub_ved_id;
>  };
>
>  extern int amdgpu_atom_debug;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index c77ed38c20fb..3a8e404099b0 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -197,6 +197,8 @@ enum atom_dp_vs_preemph_def{
>    DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,
>  };
>
> +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
> +#define BIOS_STRING_LENGTH 43
>
>  /*
>  enum atom_string_def{
> @@ -209,12 +211,14 @@ atom_bios_string          = "ATOM"
>  #pragma pack(1)                          /* BIOS data must use byte aligment*/
>
>  enum atombios_image_offset{
> -OFFSET_TO_ATOM_ROM_HEADER_POINTER          =0x00000048,
> -OFFSET_TO_ATOM_ROM_IMAGE_SIZE              =0x00000002,
> -OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE       =0x94,
> -MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =20,  /*including the terminator 0x0!*/
> -OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =0x2f,
> -OFFSET_TO_GET_ATOMBIOS_STRING_START        =0x6e,
> +  OFFSET_TO_ATOM_ROM_HEADER_POINTER          = 0x00000048,
> +  OFFSET_TO_ATOM_ROM_IMAGE_SIZE              = 0x00000002,
> +  OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE       = 0x94,
> +  MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      = 20,  /*including the terminator 0x0!*/
> +  OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   = 0x2f,
> +  OFFSET_TO_GET_ATOMBIOS_STRING_START        = 0x6e,
> +  OFFSET_TO_VBIOS_PART_NUMBER                = 0x80,
> +  OFFSET_TO_VBIOS_DATE                       = 0x50,
>  };
>
>  /****************************************************************************
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 8b832f7458f2..77980445d486 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -758,6 +758,8 @@ struct drm_amdgpu_cs_chunk_data {
>         #define AMDGPU_INFO_VBIOS_SIZE          0x1
>         /* Subquery id: Query vbios image */
>         #define AMDGPU_INFO_VBIOS_IMAGE         0x2
> +       /* Subquery id: Query vbios info */
> +       #define AMDGPU_INFO_VBIOS_INFO          0x3
>  /* Query UVD handles */
>  #define AMDGPU_INFO_NUM_HANDLES                        0x1C
>  /* Query sensor related information */
> @@ -951,6 +953,19 @@ struct drm_amdgpu_info_firmware {
>         __u32 feature;
>  };
>
> +struct drm_amdgpu_info_vbios {
> +       __u8 name[64];
> +       __u32 dbdf;
> +       __u8 vbios_pn[64];
> +       __u32 version;
> +       __u8 date[32];
> +       __u8 serial[16];
> +       __u32 dev_id;
> +       __u32 rev_id;
> +       __u32 sub_dev_id;
> +       __u32 sub_ved_id;
> +};

Please make sure this structure is 64 bit aligned.

Alex

> +
>  #define AMDGPU_VRAM_TYPE_UNKNOWN 0
>  #define AMDGPU_VRAM_TYPE_GDDR1 1
>  #define AMDGPU_VRAM_TYPE_DDR2  2
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
