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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A0AC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2936100A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2936100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0210C6EDEA;
	Thu, 10 Jun 2021 21:05:36 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E646EDEA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:05:34 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id t140so3633505oih.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RgBt7ecjQ3UP1d6KyakSs3WEETGOf6rqIhxn3M8nejQ=;
 b=CMWNhDo8vrNxlNb5sYfnatEYFCfSthHIZP5n84kg0zj8KbuhZxONGkX9M5/hzK/lSP
 eIBLpidZh5XdHnrW/7bWdc27KVg/8PoT2JZslN0Mqfh4IlzFH+G+oJQcZHCa6qQF3+EI
 CSl3eWImqggXx/eWFQEWUd8AlhrI2IlbngRPzYLmoS6w6ts8xTMCzXJR66KGD3oJf1oJ
 vQdXpH07L3jL0v75MdhyjP6GKuD6xD91ZmxBj+kiw2hRlqUS8iWM00nf3KsRQ7qnaVdh
 0X8GVXGjHL+xIhVz80dsf+uQKQkexZInHyFgCyOJsw7qzeUq2e2mECym9az4vbyybHSL
 ffeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RgBt7ecjQ3UP1d6KyakSs3WEETGOf6rqIhxn3M8nejQ=;
 b=R93Wj76jFuDtqZUOSLMkRjjPhPxcW9YKB8Nd/xRqttvkIp/BpGTHjRXKpuAZaKOQ+5
 OYJDX/adQXleLLnsPLhnYqOyUiEwpL+BuJYdRnPRpf1X7IcDW4xegze1okbgLOfVu7sn
 8NoIkG3e0E1dEYw7qHWAcybSPNPUr9JXCssG+SYvZ3UWOus6QeOTUoHa2FqhQbQwEwPO
 t0SqYziNSgmsUeefOw6CpJf8WLTw+tE4S34qHa3Cq7LjrI+jzQAB/dHWmsdVq5RAtZOT
 HnUxeRiKm/uGlV+Z5INJRM9Oh+rOiVWoM5o7+oAwIPiNOBPyy13cpnaP/rHFg0nEiAFg
 Xktw==
X-Gm-Message-State: AOAM532ECPDNEJLl6sfGyWJtAhQ9DVhVxFo6U9oL+W2pUaj9zQBEgWym
 kmCjxz6JlQvm4ChQf8s55r6q84GEct8Ca0i9MAQ=
X-Google-Smtp-Source: ABdhPJzUH6JQO+K7dexdzyPUylyVmbhAIFwPs55Y+of5uyFU3BKg1joZrytUyDmYN+QxLg+LHFxNVP9wl4UaC5VwTyo=
X-Received: by 2002:a05:6808:14c9:: with SMTP id
 f9mr276413oiw.120.1623359133638; 
 Thu, 10 Jun 2021 14:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-28-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-28-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:05:22 -0400
Message-ID: <CADnq5_MaL=x7arK6kVwRfX9nRmBaMYTW4gFs=wgPBeCcdcc_qQ@mail.gmail.com>
Subject: Re: [PATCH 27/40] drm/amdgpu: RAS xfer to read/write
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
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:40 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Wrap amdgpu_ras_eeprom_xfer(..., bool write),
> into amdgpu_ras_eeprom_read() and
> amdgpu_ras_eeprom_write(), as that makes reading
> and understanding the code clearer.
>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  9 ++++---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 24 +++++++++++++++----
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  8 ++++---
>  3 files changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index beaa1fee7f71f3..e3ad081eddd40b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1817,10 +1817,9 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
>         save_count = data->count - control->num_recs;
>         /* only new entries are saved */
>         if (save_count > 0) {
> -               if (amdgpu_ras_eeprom_xfer(control,
> -                                          &data->bps[control->num_recs],
> -                                          save_count,
> -                                          true)) {
> +               if (amdgpu_ras_eeprom_write(control,
> +                                           &data->bps[control->num_recs],
> +                                           save_count)) {
>                         dev_err(adev->dev, "Failed to save EEPROM table data!");
>                         return -EIO;
>                 }
> @@ -1850,7 +1849,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
>         if (!bps)
>                 return -ENOMEM;
>
> -       if (amdgpu_ras_eeprom_xfer(control, bps, control->num_recs, false)) {
> +       if (amdgpu_ras_eeprom_read(control, bps, control->num_recs)) {
>                 dev_err(adev->dev, "Failed to load EEPROM table records!");
>                 ret = -EIO;
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 9e3fbc44b4bc4a..550a31953d2da1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -432,9 +432,9 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
>         return false;
>  }
>
> -int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
> -                          struct eeprom_table_record *records,
> -                          const u32 num, bool write)
> +static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
> +                                 struct eeprom_table_record *records,
> +                                 const u32 num, bool write)
>  {
>         int i, ret = 0;
>         unsigned char *buffs, *buff;
> @@ -554,6 +554,20 @@ int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
>         return ret == num ? 0 : -EIO;
>  }
>
> +int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
> +                          struct eeprom_table_record *records,
> +                          const u32 num)
> +{
> +       return amdgpu_ras_eeprom_xfer(control, records, num, false);
> +}
> +
> +int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
> +                           struct eeprom_table_record *records,
> +                           const u32 num)
> +{
> +       return amdgpu_ras_eeprom_xfer(control, records, num, true);
> +}
> +
>  inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void)
>  {
>         return RAS_MAX_RECORD_NUM;
> @@ -574,13 +588,13 @@ void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control)
>                 recs[i].retired_page = i;
>         }
>
> -       if (!amdgpu_ras_eeprom_xfer(control, recs, 1, true)) {
> +       if (!amdgpu_ras_eeprom_write(control, recs, 1)) {
>
>                 memset(recs, 0, sizeof(*recs) * 1);
>
>                 control->next_addr = RAS_RECORD_START;
>
> -               if (!amdgpu_ras_eeprom_xfer(control, recs, 1, false)) {
> +               if (!amdgpu_ras_eeprom_read(control, recs)) {
>                         for (i = 0; i < 1; i++)
>                                 DRM_INFO("rec.address :0x%llx, rec.retired_page :%llu",
>                                          recs[i].address, recs[i].retired_page);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 6a1bd527bce57a..fa9c509a8e2f2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -82,9 +82,11 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
>
>  bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev);
>
> -int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
> -                          struct eeprom_table_record *records,
> -                          const u32 num, bool write);
> +int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
> +                          struct eeprom_table_record *records, const u32 num);
> +
> +int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
> +                           struct eeprom_table_record *records, const u32 num);
>
>  inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void);
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
