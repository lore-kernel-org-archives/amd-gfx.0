Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C02AC48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E535C613CF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E535C613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09596F37F;
	Fri, 11 Jun 2021 17:07:31 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B726F37F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 17:07:30 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so3858052otl.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8iODzkat6mJcPogZWyrbAUgqVwYYMHpEcZtGE86wWd0=;
 b=uQpsSwlNG/alTV3FCpXWOnmCMku5EoNt8NxZ3g+7IsvYsWypg6gEG8mBj0i6M7PR6U
 cSF18hABtzo68FX9KClAXSJa5W2AkRB05wZGkSkaP4mmSVDPFYNxAmPVTZnPfS/lmOQl
 1Vu47/k5PCGOABG7S6oULSbzBMSZOwKc1Ka3+aV/JM9xmQ/dJYKYAZEwR2EVoiUW9tOg
 fR4htMyIAQKRHsl9EvYc5uRrUBGqZ1b4fwv0PAhAsrjeh0lp4SII62lfNzo3bo3QxndO
 eyYaK5YL5K0kVT5BFGQ1eaKrS8oOF2ywx6FPDdeN4YIOXBru53qz20GXi5InbZEO/dSk
 9bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8iODzkat6mJcPogZWyrbAUgqVwYYMHpEcZtGE86wWd0=;
 b=iZ7XRV7PvWjHbFGRZ8MeX+bkl+GZyEb7zhu1WlVdP3PYeecsPS50SmBgZ8avgg2iv7
 WuOIrndzKO+JOwwJ55L831GPLo6zc9A6IKh6tDqPmIGxXTC0LkLgq2zD3PnpzJaB5zMu
 kYnO50FXs+FasZtBJwGr5JEBc0Az4USJVvArYexlw80V2ixQ+MzP5A4s3lG5pB2rIK1E
 FtLZuax/tyLwR5zwTLEaWnmccbp775xQaWYUtQ6/HiZ95X1h+HiN1+rHY6HuetIW36Dp
 fUg0uUIa7zjFKdewu6Okbdih2BueKXQF3bT8uxvR6kXUIjh4hMVDRLO7C4nPEsvpDepf
 4jgA==
X-Gm-Message-State: AOAM531r594xQ6rXC7fCMESn8mleZ7NVBxm98IuTmo5osgty8/5wKf7D
 8JDK2dIk6k7zbjK7kwBQ6rWm5X2yeiDNVYWp0bI=
X-Google-Smtp-Source: ABdhPJx7BkqlyjGZG1tdNoXCcKyw9MaG+sBgDoM4FbKXbIixbV47iUl1UBo4oac/uyXhG3X6YWXBVGAqQqJrGmOO4NI=
X-Received: by 2002:a9d:6287:: with SMTP id x7mr4059381otk.132.1623431249624; 
 Fri, 11 Jun 2021 10:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-36-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-36-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Jun 2021 13:07:18 -0400
Message-ID: <CADnq5_OPYQsbZOMsoC=QCKfOYwA9P7s+8nWXp-N5vSaODoJOXg@mail.gmail.com>
Subject: Re: [PATCH 35/40] drm/amdgpu: Simplify RAS EEPROM checksum
 calculations
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Rename update_table_header() to
> write_table_header() as this function is actually
> writing it to EEPROM.
>
> Use kernel types; use u8 to carry around the
> checksum, in order to take advantage of arithmetic
> modulo 8-bits (256).
>
> Tidy up to 80 columns.
>
> When updating the checksum, just recalculate the
> whole thing.
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 98 +++++++++----------
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +-
>  2 files changed, 50 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 7d0f9e1e62dc4f..54ef31594accd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -141,8 +141,8 @@ static void __decode_table_header_from_buff(struct amdgpu_ras_eeprom_table_heade
>         hdr->checksum         = le32_to_cpu(pp[4]);
>  }
>
> -static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
> -                                unsigned char *buff)
> +static int __write_table_header(struct amdgpu_ras_eeprom_control *control,
> +                               unsigned char *buff)
>  {
>         int ret = 0;
>         struct amdgpu_device *adev = to_amdgpu_device(control);
> @@ -162,69 +162,74 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>         return ret;
>  }
>
> -static uint32_t  __calc_hdr_byte_sum(struct amdgpu_ras_eeprom_control *control)
> +static u8 __calc_hdr_byte_sum(const struct amdgpu_ras_eeprom_control *control)
>  {
>         int i;
> -       uint32_t tbl_sum = 0;
> +       u8 hdr_sum = 0;
> +       u8  *p;
> +       size_t sz;
>
>         /* Header checksum, skip checksum field in the calculation */
> -       for (i = 0; i < sizeof(control->tbl_hdr) - sizeof(control->tbl_hdr.checksum); i++)
> -               tbl_sum += *(((unsigned char *)&control->tbl_hdr) + i);
> +       sz = sizeof(control->tbl_hdr) - sizeof(control->tbl_hdr.checksum);
> +       p = (u8 *) &control->tbl_hdr;
> +       for (i = 0; i < sz; i++, p++)
> +               hdr_sum += *p;
>
> -       return tbl_sum;
> +       return hdr_sum;
>  }
>
> -static uint32_t  __calc_recs_byte_sum(struct eeprom_table_record *records,
> -                                     int num)
> +static u8 __calc_recs_byte_sum(const struct eeprom_table_record *record,
> +                              const int num)
>  {
>         int i, j;
> -       uint32_t tbl_sum = 0;
> +       u8  tbl_sum = 0;
> +
> +       if (!record)
> +               return 0;
>
>         /* Records checksum */
>         for (i = 0; i < num; i++) {
> -               struct eeprom_table_record *record = &records[i];
> +               u8 *p = (u8 *) &record[i];
>
> -               for (j = 0; j < sizeof(*record); j++) {
> -                       tbl_sum += *(((unsigned char *)record) + j);
> -               }
> +               for (j = 0; j < sizeof(*record); j++, p++)
> +                       tbl_sum += *p;
>         }
>
>         return tbl_sum;
>  }
>
> -static inline uint32_t  __calc_tbl_byte_sum(struct amdgpu_ras_eeprom_control *control,
> -                                 struct eeprom_table_record *records, int num)
> +static inline u8
> +__calc_tbl_byte_sum(struct amdgpu_ras_eeprom_control *control,
> +                   struct eeprom_table_record *records, int num)
>  {
> -       return __calc_hdr_byte_sum(control) + __calc_recs_byte_sum(records, num);
> +       return __calc_hdr_byte_sum(control) +
> +               __calc_recs_byte_sum(records, num);
>  }
>
> -/* Checksum = 256 -((sum of all table entries) mod 256) */
>  static void __update_tbl_checksum(struct amdgpu_ras_eeprom_control *control,
> -                                 struct eeprom_table_record *records, int num,
> -                                 uint32_t old_hdr_byte_sum)
> +                                 struct eeprom_table_record *records, int num)
>  {
> -       /*
> -        * This will update the table sum with new records.
> -        *
> -        * TODO: What happens when the EEPROM table is to be wrapped around
> -        * and old records from start will get overridden.
> -        */
> -
> -       /* need to recalculate updated header byte sum */
> -       control->tbl_byte_sum -= old_hdr_byte_sum;
> -       control->tbl_byte_sum += __calc_tbl_byte_sum(control, records, num);
> +       u8 v;
>
> -       control->tbl_hdr.checksum = 256 - (control->tbl_byte_sum % 256);
> +       control->tbl_byte_sum = __calc_tbl_byte_sum(control, records, num);
> +       /* Avoid 32-bit sign extension. */
> +       v = -control->tbl_byte_sum;
> +       control->tbl_hdr.checksum = v;
>  }
>
> -/* table sum mod 256 + checksum must equals 256 */
> -static bool __validate_tbl_checksum(struct amdgpu_ras_eeprom_control *control,
> -                           struct eeprom_table_record *records, int num)
> +static bool __verify_tbl_checksum(struct amdgpu_ras_eeprom_control *control,
> +                                 struct eeprom_table_record *records,
> +                                 int num)
>  {
> +       u8 result;
> +
>         control->tbl_byte_sum = __calc_tbl_byte_sum(control, records, num);
>
> -       if (control->tbl_hdr.checksum + (control->tbl_byte_sum % 256) != 256) {
> -               DRM_WARN("Checksum mismatch, checksum: %u ", control->tbl_hdr.checksum);
> +       result = (u8)control->tbl_hdr.checksum + control->tbl_byte_sum;
> +       if (result) {
> +               DRM_WARN("RAS table checksum mismatch: stored:0x%02X wants:0x%02hhX",
> +                        control->tbl_hdr.checksum,
> +                        -control->tbl_byte_sum);
>                 return false;
>         }
>
> @@ -232,8 +237,8 @@ static bool __validate_tbl_checksum(struct amdgpu_ras_eeprom_control *control,
>  }
>
>  static int amdgpu_ras_eeprom_correct_header_tag(
> -                               struct amdgpu_ras_eeprom_control *control,
> -                               uint32_t header)
> +       struct amdgpu_ras_eeprom_control *control,
> +       uint32_t header)
>  {
>         unsigned char buff[RAS_TABLE_HEADER_SIZE];
>         struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
> @@ -243,7 +248,7 @@ static int amdgpu_ras_eeprom_correct_header_tag(
>
>         mutex_lock(&control->tbl_mutex);
>         hdr->header = header;
> -       ret = __update_table_header(control, buff);
> +       ret = __write_table_header(control, buff);
>         mutex_unlock(&control->tbl_mutex);
>
>         return ret;
> @@ -262,11 +267,9 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
>         hdr->first_rec_offset = RAS_RECORD_START;
>         hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
>
> -       control->tbl_byte_sum = 0;
> -       __update_tbl_checksum(control, NULL, 0, 0);
> +       __update_tbl_checksum(control, NULL, 0);
>         control->next_addr = RAS_RECORD_START;
> -
> -       ret = __update_table_header(control, buff);
> +       ret = __write_table_header(control, buff);
>
>         mutex_unlock(&control->tbl_mutex);
>
> @@ -521,8 +524,6 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
>         }
>
>         if (write) {
> -               uint32_t old_hdr_byte_sum = __calc_hdr_byte_sum(control);
> -
>                 /*
>                  * Update table header with size and CRC and account for table
>                  * wrap around where the assumption is that we treat it as empty
> @@ -537,10 +538,9 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
>                         control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE +
>                         control->num_recs * RAS_TABLE_RECORD_SIZE;
>
> -               __update_tbl_checksum(control, records, num, old_hdr_byte_sum);
> -
> -               __update_table_header(control, buffs);
> -       } else if (!__validate_tbl_checksum(control, records, num)) {
> +               __update_tbl_checksum(control, records, num);
> +               __write_table_header(control, buffs);
> +       } else if (!__verify_tbl_checksum(control, records, num)) {
>                 DRM_WARN("EEPROM Table checksum mismatch!");
>                 /* TODO Uncomment when EEPROM read/write is relliable */
>                 /* ret = -EIO; */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index fa9c509a8e2f2b..4906ed9fb8cdd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -48,7 +48,7 @@ struct amdgpu_ras_eeprom_control {
>         uint32_t next_addr;
>         unsigned int num_recs;
>         struct mutex tbl_mutex;
> -       uint32_t tbl_byte_sum;
> +       u8 tbl_byte_sum;
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
