Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C25CEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 15:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141D510E6AC;
	Fri, 21 Jul 2023 15:41:37 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E6710E6A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 15:41:34 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1bb29ae5977so247249fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689954093; x=1690558893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZUeZwNdV0U5Iq8uRqMVdNhBYKprZtDSnwgSl6S5p0Q=;
 b=cTszaX0cSkdul01nyPVr7nCcAjfFU5vl2ntMYQUvc0ktRd+9R1zCBjC4DKmegMFFLy
 eVdSyg+XxL+Ls+Z1drsBMp7OZO6MQ9lW3HI2cWzjiWcmnrTk8t1UeRAb5HNYOH9vRVYG
 c8MQ3Kvhq+mHgY8D6/4oKYarPNhMnawhSNXTOBZG85fnUrTN1TxnBUHZxTRwzDuUtJUM
 SbgtKUfG+E1dhPJbACvJfbAVA8dcNsvgtSd8D1wciswhhmSv/aDayChBLSv7+YOeTWMM
 M2dvgHWNIK3ahqd1tAkjGpOoMyEI4Ig3CNTVN0kyEmxO3Lexs0GukkA0vDYlhe1RjVkC
 tGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954093; x=1690558893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZUeZwNdV0U5Iq8uRqMVdNhBYKprZtDSnwgSl6S5p0Q=;
 b=ItYSbLTsQrrLTSh6eFGbNHzKLmAxjx+JmK+0GWsVXeCVwKAPKJJMUtTmiHodS8FM1o
 aOW8RhGO/MrnCUgkuM2TIleW3KOKlxqcfbvs+2RsRVkVJVW+mC2J1dP20SmrZBn/+mtk
 Q9mwEE+YRSnSdS+Ff9rW3bTBDIZ0pQfz2ZTERUOdhRxMuQmPLRAQt1gIVG6d5ITUMZ4w
 w9RYwbPPBcVkEJiRjoZH3PF0qWuacocILDPQYmMSFiYGIrVClVPqGDChqdLvH00QnKuP
 0cn3ytbgkZtZ+B1dER8ydQGzV7Fo4RTqUivW0qZhv4QvV51gudTcM8ekS8jP1t1iWPos
 aAUA==
X-Gm-Message-State: ABy/qLa0LROekj3P+XPnczhjycZMy9sb4HUZArdRHKWu63Hcmr0EBR/F
 E6TeAvH7YVcI2o9/RdTNm9KBGqTheKViQWYefTXzY6Iz538=
X-Google-Smtp-Source: APBJJlGrTbzgat9cQezZNxHsNDTFlRV2YM7UHd8eXCH72fRkDjJt15yUC12d8izw0zyaBm66VyH+qXpiOoYo2tWkJW0=
X-Received: by 2002:a05:6871:5207:b0:1b3:f8b7:55b4 with SMTP id
 ht7-20020a056871520700b001b3f8b755b4mr2801460oac.35.1689954093529; Fri, 21
 Jul 2023 08:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230721081623.1291213-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230721081623.1291213-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Jul 2023 11:41:22 -0400
Message-ID: <CADnq5_OaSEE1CZiNsc9fS-AEt9Nf=xT8nUnPg06igccymk6htg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix do not add new typedefs in
 amdgpu_fw_attestation.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 21, 2023 at 4:17=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following to align to coding style:
>
> WARNING: do not add new typedefs
> +typedef struct FW_ATT_DB_HEADER
>
> WARNING: do not add new typedefs
> +typedef struct FW_ATT_RECORD
>
> WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using=
 octal permissions '0400'.
> +                           S_IRUSR,
>
> ERROR: "(foo*)" should be "(foo *)"
> WARNING: please, no space before tabs
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/amdgpu/amdgpu_fw_attestation.c    | 38 +++++++++----------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> index 2ca3c329de6d..2d4b67175b55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> @@ -32,17 +32,15 @@
>  #include "soc15_common.h"
>
>  #define FW_ATTESTATION_DB_COOKIE        0x143b6a37
> -#define FW_ATTESTATION_RECORD_VALID    1
> +#define FW_ATTESTATION_RECORD_VALID    1
>  #define FW_ATTESTATION_MAX_SIZE                4096
>
> -typedef struct FW_ATT_DB_HEADER
> -{
> +struct FW_ATT_DB_HEADER {
>         uint32_t AttDbVersion;           /* version of the fwar feature *=
/
>         uint32_t AttDbCookie;            /* cookie as an extra check for =
corrupt data */
> -} FW_ATT_DB_HEADER;
> +};
>
> -typedef struct FW_ATT_RECORD
> -{
> +struct FW_ATT_RECORD {
>         uint16_t AttFwIdV1;              /* Legacy FW Type field */
>         uint16_t AttFwIdV2;              /* V2 FW ID field */
>         uint32_t AttFWVersion;           /* FW Version */
> @@ -50,7 +48,7 @@ typedef struct FW_ATT_RECORD
>         uint8_t  AttSource;              /* FW source indicator */
>         uint8_t  RecordValid;            /* Indicates whether the record =
is a valid entry */
>         uint32_t AttFwTaId;              /* Ta ID (only in TA Attestation=
 Table) */
> -} FW_ATT_RECORD;
> +};
>
>  static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
>                                                   char __user *buf,
> @@ -60,15 +58,15 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(str=
uct file *f,
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode=
(f)->i_private;
>         uint64_t records_addr =3D 0;
>         uint64_t vram_pos =3D 0;
> -       FW_ATT_DB_HEADER fw_att_hdr =3D {0};
> -       FW_ATT_RECORD fw_att_record =3D {0};
> +       struct FW_ATT_DB_HEADER fw_att_hdr =3D {0};
> +       struct FW_ATT_RECORD fw_att_record =3D {0};
>
> -       if (size < sizeof(FW_ATT_RECORD)) {
> +       if (size < sizeof(struct FW_ATT_RECORD)) {
>                 DRM_WARN("FW attestation input buffer not enough memory")=
;
>                 return -EINVAL;
>         }
>
> -       if ((*pos + sizeof(FW_ATT_DB_HEADER)) >=3D FW_ATTESTATION_MAX_SIZ=
E) {
> +       if ((*pos + sizeof(struct FW_ATT_DB_HEADER)) >=3D FW_ATTESTATION_=
MAX_SIZE) {
>                 DRM_WARN("FW attestation out of bounds");
>                 return 0;
>         }
> @@ -83,8 +81,8 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struc=
t file *f,
>         if (*pos =3D=3D 0) {
>                 amdgpu_device_vram_access(adev,
>                                           vram_pos,
> -                                         (uint32_t*)&fw_att_hdr,
> -                                         sizeof(FW_ATT_DB_HEADER),
> +                                         (uint32_t *)&fw_att_hdr,
> +                                         sizeof(struct FW_ATT_DB_HEADER)=
,
>                                           false);
>
>                 if (fw_att_hdr.AttDbCookie !=3D FW_ATTESTATION_DB_COOKIE)=
 {
> @@ -96,20 +94,20 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(str=
uct file *f,
>         }
>
>         amdgpu_device_vram_access(adev,
> -                                 vram_pos + sizeof(FW_ATT_DB_HEADER) + *=
pos,
> -                                 (uint32_t*)&fw_att_record,
> -                                 sizeof(FW_ATT_RECORD),
> +                                 vram_pos + sizeof(struct FW_ATT_DB_HEAD=
ER) + *pos,
> +                                 (uint32_t *)&fw_att_record,
> +                                 sizeof(struct FW_ATT_RECORD),
>                                   false);
>
>         if (fw_att_record.RecordValid !=3D FW_ATTESTATION_RECORD_VALID)
>                 return 0;
>
> -       if (copy_to_user(buf, (void*)&fw_att_record, sizeof(FW_ATT_RECORD=
)))
> +       if (copy_to_user(buf, (void *)&fw_att_record, sizeof(struct FW_AT=
T_RECORD)))
>                 return -EINVAL;
>
> -       *pos +=3D sizeof(FW_ATT_RECORD);
> +       *pos +=3D sizeof(struct FW_ATT_RECORD);
>
> -       return sizeof(FW_ATT_RECORD);
> +       return sizeof(struct FW_ATT_RECORD);
>  }
>
>  static const struct file_operations amdgpu_fw_attestation_debugfs_ops =
=3D {
> @@ -136,7 +134,7 @@ void amdgpu_fw_attestation_debugfs_init(struct amdgpu=
_device *adev)
>                 return;
>
>         debugfs_create_file("amdgpu_fw_attestation",
> -                           S_IRUSR,
> +                           0400,
>                             adev_to_drm(adev)->primary->debugfs_root,
>                             adev,
>                             &amdgpu_fw_attestation_debugfs_ops);
> --
> 2.25.1
>
