Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35534C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC18C61186
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC18C61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E75B6E82C;
	Thu, 20 May 2021 03:24:24 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7FC6E82C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:24:22 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id j75so15077051oih.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lp9qnxruk/XB21thQCyFzathKsl9RCMwmjmnsILDgLM=;
 b=RLWzUm8/7x9wwGMgqgBk/FD1tb76b1xOdbKTkLIZQThTmlv2BU1sK8lRKE8eryU8OK
 yL4npjFn3HvZoX+6+FTH72PREBNBdGPebVmd9eR6kR5pWOO091IE2pLrR2mBJVkXTquA
 QciUJ2s5YSH6/5pPXtcqTOWDTI/wB2WjPcxlee5w8zRFMNcIrF+aApcHcYqaxiFw+fRc
 qiq6XXFhOhwsv0b//Rzaeg24sgVsdku+pp4nZyDBKEfj61yfRVOhvVyBtXROn9/b1cce
 PlIuxpOltdE/K2VE4p7nzFZEnKOVCI5l6LptBQ6f0iSA4P3GXIRJCeTbI5HD7G3VWWUD
 THFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lp9qnxruk/XB21thQCyFzathKsl9RCMwmjmnsILDgLM=;
 b=R5jaKOCP97x85se7DDiWJKp/lMoqkk8wShdvRupyKdYMZ2XFITqtq+H80VmUC90Rjx
 Wxgb7U6O7gv9854hP6FQvKDPy5Z0Iukki6/rt9gJ7+7kH586H0n+gJPCECt47aV0IMCc
 eLKV7fd8epHGt5S2sKKwvpAGiERnqzIqPcIz201b+WvbiQdg2drTPb+Z7GNzW9tcBQRY
 A4eRzV3dPprRNoLv9PEC0qWwZXZVl0ea3FSi/Av8++bHmkV0JIzFfrI2vfDmZJrGDJZV
 ZfpaV3tqxUCtNHN/6v91Ff70iyzdIHvdFigrXkUF5LYXvPHgarNVE9ZSAfyN94E0JEzJ
 jF/g==
X-Gm-Message-State: AOAM530+RGJXgszUatcWrkRqAJ1xg9IHW+y3ZzbxAWx7Oye6ojK4D+QR
 oWaNmV2z3X6HgPi8suRbu/D5J929IfLnI2BH5Nk=
X-Google-Smtp-Source: ABdhPJzu1dx7zcea/80Xw4ok+34aJMw0rJnyzrGPjt1mv7XFzzB3glbuwW6o8+BLMURxMHnN7aKkSFBtucVJZUKY2Ew=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr1765098oie.120.1621481062184; 
 Wed, 19 May 2021 20:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210520025846.10789-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210520025846.10789-1-Jiawei.Gu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 May 2021 23:24:11 -0400
Message-ID: <CADnq5_MOmDhuun1Ho4V1Yvt7Db2ayt1m8tLdXCCwv8-ayMNHgQ@mail.gmail.com>
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
Cc: Marek Olsak <maraeo@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Emily Deng <emily.deng@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, "Nieto,
 David M" <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 19, 2021 at 10:59 PM Jiawei Gu <Jiawei.Gu@amd.com> wrote:
>
> Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.
>
> Provides a way for the user application to get the VBIOS
> information without having to parse the binary.
> It is useful for the user to be able to display in a simple way the VBIOS
> version in their system if they happen to encounter an issue.
>
> V2:
> Use numeric serial.
> Parse and expose vbios version string.
>
> V3:
> Remove redundant data in drm_amdgpu_info_vbios struct.
>
> V4:
> 64 bit alignment in drm_amdgpu_info_vbios.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>

Assuming you send out the updated umr patch,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  15 ++
>  drivers/gpu/drm/amd/amdgpu/atom.c          | 172 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/atom.h          |  10 ++
>  drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
>  include/uapi/drm/amdgpu_drm.h              |  11 ++
>  5 files changed, 213 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8d12e474745a..524e4fe5efe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -861,6 +861,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>                                             min((size_t)size, (size_t)(bios_size - bios_offset)))
>                                         ? -EFAULT : 0;
>                 }
> +               case AMDGPU_INFO_VBIOS_INFO: {
> +                       struct drm_amdgpu_info_vbios vbios_info = {};
> +                       struct atom_context *atom_context;
> +
> +                       atom_context = adev->mode_info.atom_context;
> +                       memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
> +                       memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
> +                       vbios_info.version = atom_context->version;
> +                       memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
> +                                               sizeof(atom_context->vbios_ver_str));
> +                       memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
> +
> +                       return copy_to_user(out, &vbios_info,
> +                                               min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
> +               }
>                 default:
>                         DRM_DEBUG_KMS("Invalid request %d\n",
>                                         info->vbios_info.type);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 3dcb8b32f48b..6fa2229b7229 100644
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
> @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_context *ctx, int base)
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
> +static void atom_get_vbios_version(struct atom_context *ctx)
> +{
> +       unsigned char *vbios_ver;
> +
> +       /* find anchor ATOMBIOSBK-AMD */
> +       vbios_ver = atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 1024, 64);
> +       if (vbios_ver != NULL) {
> +               /* skip ATOMBIOSBK-AMD VER */
> +               vbios_ver += 18;
> +               memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
> +       } else {
> +               ctx->vbios_ver_str[0] = '\0';
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
> @@ -1353,6 +1510,21 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
>                 strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
>         }
>
> +       atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
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
> +       atom_get_vbios_version(ctx);
>
>         return ctx;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
> index d279759cab47..0c1839824520 100644
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
> @@ -140,6 +144,12 @@ struct atom_context {
>         uint32_t *scratch;
>         int scratch_size_bytes;
>         char vbios_version[20];
> +
> +       uint8_t name[STRLEN_LONG];
> +       uint8_t vbios_pn[STRLEN_LONG];
> +       uint32_t version;
> +       uint8_t vbios_ver_str[STRLEN_NORMAL];
> +       uint8_t date[STRLEN_NORMAL];
>  };
>
>  extern int amdgpu_atom_debug;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 275468e4be60..28deecc2f990 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
>    DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,
>  };
>
> +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
> +#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
> +#define BIOS_STRING_LENGTH 43
>
>  /*
>  enum atom_string_def{
> @@ -215,6 +218,8 @@ enum atombios_image_offset{
>    MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      = 20,  /*including the terminator 0x0!*/
>    OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   = 0x2f,
>    OFFSET_TO_GET_ATOMBIOS_STRING_START        = 0x6e,
> +  OFFSET_TO_VBIOS_PART_NUMBER                = 0x80,
> +  OFFSET_TO_VBIOS_DATE                       = 0x50,
>  };
>
>  /****************************************************************************
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9169df7fadee..90bcd64c0147 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
>         #define AMDGPU_INFO_VBIOS_SIZE          0x1
>         /* Subquery id: Query vbios image */
>         #define AMDGPU_INFO_VBIOS_IMAGE         0x2
> +       /* Subquery id: Query vbios info */
> +       #define AMDGPU_INFO_VBIOS_INFO          0x3
>  /* Query UVD handles */
>  #define AMDGPU_INFO_NUM_HANDLES                        0x1C
>  /* Query sensor related information */
> @@ -949,6 +951,15 @@ struct drm_amdgpu_info_firmware {
>         __u32 feature;
>  };
>
> +struct drm_amdgpu_info_vbios {
> +       __u8 name[64];
> +       __u8 vbios_pn[64];
> +       __u32 version;
> +       __u32 pad;
> +       __u8 vbios_ver_str[32];
> +       __u8 date[32];
> +};
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
