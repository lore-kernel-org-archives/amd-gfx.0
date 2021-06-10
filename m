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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8671BC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6CC6100A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6CC6100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66686E2C8;
	Thu, 10 Jun 2021 21:17:51 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8334D6E2C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:17:51 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 i12-20020a05683033ecb02903346fa0f74dso1085627otu.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DjD0xGa41vKKvZskmfJP2lLSG2GM1RH60CL4Pe/fCSI=;
 b=kFwZ1RgDni182kOhKxqaKxscyxbkxt1cPA2UYvUMwJpacU0rTFeByU7/5dA5ugVRMR
 jVBCpPJ1Yk1/OpuqbTt9DieemeyIpXmcaoqbjCH9n8bgLfyqkuzTNMufiwJ72Hk/X3Z7
 MSsR3qGwz0JV7S91VnypQh78wPJ2lQKi6TmZLUMoo9RBQ8ooaXsUxOjICzbbrHZejq7K
 dzQNvQjVUP6nU5AaMd4u/yO9kRJNwrngnhRXBCBEVw6YzBOfkMpXMaS9A+SBFxIrMQ7U
 oPrxZmQcr8muIYPPb4F+q4WQD4208dGQhYpoMxVA7zACeV/cehsusGpupBYUZI6mloYN
 ysJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DjD0xGa41vKKvZskmfJP2lLSG2GM1RH60CL4Pe/fCSI=;
 b=GHQpUdRzMOmrsRzQcAVnYsQZBbv+Lhanern1TAEZwL7cSTGMcFEjZDqpv2a8prUq2t
 2xyyxRNV43tmYBlmQ7jv8/gi0HYuJoWkv5kg2wkwJyV1xHo9SPLb1F+KFGbBZ4A2mwBd
 io5w/4YrmB+06O61l+NBrioOm278o/6W2kUBOAteitsvyaHZaVUY8zKVVWlsqsOk5VnD
 78Wyzw0B8NaJ4Resj6osBr/DF8nN3OajInSDIcn0vuVpVdsd0pLiQUC2kYxibqeo/G/h
 HH/DwBxjl/KbBWNn6ry9cSTzigPUiHgiyY8Z0WhTrHFCTWuhNRKqaGjPhDYVspUmePN6
 jVfg==
X-Gm-Message-State: AOAM533M/Xgqh6n6wOgvxw96Pm5BZwpwgAMvFKXdQlaai2qVH+zGO1Jy
 erxQA1Jp0FYrKp/nNtDSX6rPnRbjH2iFqG40v7I4truqn9E=
X-Google-Smtp-Source: ABdhPJw0eFQr+jGEhPz+V8y/2OdeY0vtmJoN6OzfOMkrSEH/dn1O6R8kdU/SnkNhbArnW3lkV9AqM4qf/JaMW6C6a2s=
X-Received: by 2002:a05:6830:33ef:: with SMTP id
 i15mr285482otu.311.1623359870906; 
 Thu, 10 Jun 2021 14:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-37-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-37-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:17:40 -0400
Message-ID: <CADnq5_NFsR8LzRUdSSonzMhWjU1dnDY01bGoT+_xn=ZPpXcsRQ@mail.gmail.com>
Subject: Re: [PATCH 36/40] drm/amdgpu: Use explicit cardinality for clarity
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
 John Clements <john.clements@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> RAS_MAX_RECORD_NUM may mean the maximum record
> number, as in the maximum house number on your
> street, or it may mean the maximum number of
> records, as in the count of records, which is also
> a number. To make this distinction whether the
> number is ordinal (index) or cardinal (count),
> rename this macro to RAS_MAX_RECORD_COUNT.
>
> This makes it easy to understand what it refers
> to, especially when we compute quantities such as,
> how many records do we have left in the table,
> especially when there are so many other numbers,
> quantities and numerical macros around.
>
> Also rename the long,
> amdgpu_ras_eeprom_get_record_max_length() to the
> more succinct and clear,
> amdgpu_ras_eeprom_max_record_count().
>
> When computing the threshold, which also deals
> with counts, i.e. "how many", use cardinal
> "max_eeprom_records_count", than the quantitative
> "max_eeprom_records_len".
>
> Simplify the logic here and there, as well.
>
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  9 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 50 ++++++++-----------
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  8 +--
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +-
>  4 files changed, 30 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3de1accb060e37..0203f654576bcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -853,11 +853,10 @@ MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legac
>  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>
>  /**
> - * DOC: bad_page_threshold (int)
> - * Bad page threshold is to specify the threshold value of faulty pages
> - * detected by RAS ECC, that may result in GPU entering bad status if total
> - * faulty pages by ECC exceed threshold value and leave it for user's further
> - * check.
> + * DOC: bad_page_threshold (int) Bad page threshold is specifies the
> + * threshold value of faulty pages detected by RAS ECC, which may
> + * result in the GPU entering bad status when the number of total
> + * faulty pages by ECC exceeds the threshold value.
>   */
>  MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
>  module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 66c96c65e7eeb9..95ab400b641af0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -71,8 +71,8 @@ const char *ras_block_string[] = {
>  /* inject address is 52 bits */
>  #define        RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
>
> -/* typical ECC bad page rate(1 bad page per 100MB VRAM) */
> -#define RAS_BAD_PAGE_RATE              (100 * 1024 * 1024ULL)
> +/* typical ECC bad page rate is 1 bad page per 100MB VRAM */
> +#define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
>
>  enum amdgpu_ras_retire_page_reservation {
>         AMDGPU_RAS_RETIRE_PAGE_RESERVED,
> @@ -1841,27 +1841,24 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
>  static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ras_eeprom_control *control =
> -                                       &adev->psp.ras.ras->eeprom_control;
> -       struct eeprom_table_record *bps = NULL;
> -       int ret = 0;
> +               &adev->psp.ras.ras->eeprom_control;
> +       struct eeprom_table_record *bps;
> +       int ret;
>
>         /* no bad page record, skip eeprom access */
> -       if (!control->num_recs || (amdgpu_bad_page_threshold == 0))
> -               return ret;
> +       if (control->num_recs == 0 || amdgpu_bad_page_threshold == 0)
> +               return 0;
>
>         bps = kcalloc(control->num_recs, sizeof(*bps), GFP_KERNEL);
>         if (!bps)
>                 return -ENOMEM;
>
> -       if (amdgpu_ras_eeprom_read(control, bps, control->num_recs)) {
> +       ret = amdgpu_ras_eeprom_read(control, bps, control->num_recs);
> +       if (ret)
>                 dev_err(adev->dev, "Failed to load EEPROM table records!");
> -               ret = -EIO;
> -               goto out;
> -       }
> -
> -       ret = amdgpu_ras_add_bad_pages(adev, bps, control->num_recs);
> +       else
> +               ret = amdgpu_ras_add_bad_pages(adev, bps, control->num_recs);
>
> -out:
>         kfree(bps);
>         return ret;
>  }
> @@ -1901,11 +1898,9 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
>  }
>
>  static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
> -                                       uint32_t max_length)
> +                                         uint32_t max_count)
>  {
>         struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -       int tmp_threshold = amdgpu_bad_page_threshold;
> -       u64 val;
>
>         /*
>          * Justification of value bad_page_cnt_threshold in ras structure
> @@ -1926,18 +1921,15 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
>          *      take no effect.
>          */
>
> -       if (tmp_threshold < -1)
> -               tmp_threshold = -1;
> -       else if (tmp_threshold > max_length)
> -               tmp_threshold = max_length;
> +       if (amdgpu_bad_page_threshold < 0) {
> +               u64 val = adev->gmc.mc_vram_size;
>
> -       if (tmp_threshold == -1) {
> -               val = adev->gmc.mc_vram_size;
> -               do_div(val, RAS_BAD_PAGE_RATE);
> +               do_div(val, RAS_BAD_PAGE_COVER);
>                 con->bad_page_cnt_threshold = min(lower_32_bits(val),
> -                                               max_length);
> +                                                 max_count);
>         } else {
> -               con->bad_page_cnt_threshold = tmp_threshold;
> +               con->bad_page_cnt_threshold = min_t(int, max_count,
> +                                                   amdgpu_bad_page_threshold);
>         }
>  }
>
> @@ -1945,7 +1937,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>         struct ras_err_handler_data **data;
> -       uint32_t max_eeprom_records_len = 0;
> +       u32  max_eeprom_records_count = 0;
>         bool exc_err_limit = false;
>         int ret;
>
> @@ -1965,8 +1957,8 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>         atomic_set(&con->in_recovery, 0);
>         con->adev = adev;
>
> -       max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
> -       amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
> +       max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count();
> +       amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
>
>         /* Todo: During test the SMU might fail to read the eeprom through I2C
>          * when the GPU is pending on XGMI reset during probe time
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 54ef31594accd9..21e1e59e4857ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -54,7 +54,7 @@
>  #define RAS_TBL_SIZE_BYTES      (256 * 1024)
>  #define RAS_HDR_START           0
>  #define RAS_RECORD_START        (RAS_HDR_START + RAS_TABLE_HEADER_SIZE)
> -#define RAS_MAX_RECORD_NUM      ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
> +#define RAS_MAX_RECORD_COUNT    ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
>                                  / RAS_TABLE_RECORD_SIZE)
>
>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
> @@ -532,7 +532,7 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
>                  * TODO - Check the assumption is correct
>                  */
>                 control->num_recs += num;
> -               control->num_recs %= RAS_MAX_RECORD_NUM;
> +               control->num_recs %= RAS_MAX_RECORD_COUNT;
>                 control->tbl_hdr.tbl_size += RAS_TABLE_RECORD_SIZE * num;
>                 if (control->tbl_hdr.tbl_size > RAS_TBL_SIZE_BYTES)
>                         control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE +
> @@ -568,9 +568,9 @@ int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
>         return amdgpu_ras_eeprom_xfer(control, records, num, true);
>  }
>
> -inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void)
> +inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
>  {
> -       return RAS_MAX_RECORD_NUM;
> +       return RAS_MAX_RECORD_COUNT;
>  }
>
>  /* Used for testing if bugs encountered */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 4906ed9fb8cdd3..504729b8053759 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -88,7 +88,7 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
>  int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
>                             struct eeprom_table_record *records, const u32 num);
>
> -inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void);
> +inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
>
>  void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control);
>
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
