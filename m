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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF2DC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA051613B3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA051613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5F76EDE9;
	Thu, 10 Jun 2021 21:04:51 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AAD36EDE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:04:50 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id u11so3602955oiv.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AB1v/cPYQoN7ckDjkTZ+whrca3oKuwkqJwMefFS8vx8=;
 b=gVW070o+1Jp6wUBOrZcrqcyqmewFcXLWVqSaJEYkIN/oA13Xw5yIGSt1qpHoGI6oVf
 TCmcTFjIX950w19HAtA0vRMQ/v1h4D52QoxD8+pbo609qnERE64WIRGjQP+y0xzJXAbM
 ak/2bAh8xWi6Epzii8R6z7TFZc1V+ORmSF+ZHTCaZs/7B4DWN5LaSrRatRfCJW1+ceOn
 k2V2HVkYQF3bIDMDmFXjLu9Eq49h9wdCUB/Tbrh63sp1FDs9DVbd5WbGo9Cl8QXs+emF
 RXwMy28gmnFRVtDcYliRkBAxlflj8kH/PlVVdcLkHnQP80+IGnvijjLg/hp2GfVb3Y8c
 wS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AB1v/cPYQoN7ckDjkTZ+whrca3oKuwkqJwMefFS8vx8=;
 b=fIkwZraSKBH2LyelBd43jOthL0esBPzNokR+nHJGjyKn6jw+X1MXt+Xiz0LyELu3w1
 f49x5a0aK8tVmQqX8ZHNSwT6WzbPhnuBHm5zaDp+edx7Gl4k/11+9Irc4o8mkzVgSBIg
 fauGtyR0NVs95ITKgZvHwwyAWHaGscF3VwUmZqxB/iK+BPOjRVd4ouOhdC7Yq1t+2Ppj
 toUVpVQV5T6DFFSnqibs32+CBae8NvcIS2pYuBx/dR6nTo9bihrSLM1hvPXEGW1MtiyI
 nnEs0lPV5sYTtHtAt6Kn6XhB2mRpNtb6pPNSLt+fZEh5A7yR8Z7Kud5onSnEhDUcOJxt
 Pi1w==
X-Gm-Message-State: AOAM5327fRlNhkb0zMuO/HrUz61um5pCEOjImusKxepAh8G+ayhSsjAK
 WE3y6JB54YyyERRd4Ye46ICRwvncFQsdbjSMS+A=
X-Google-Smtp-Source: ABdhPJy2ZWZwjWhRx80FaFvmK2RltsHyQ7ZcLte9yc222CgKkF8TmMdngIy2odiOi5f/YG62vFdQkxpiV8Q4bW4xO9E=
X-Received: by 2002:a05:6808:14c9:: with SMTP id
 f9mr274519oiw.120.1623359089476; 
 Thu, 10 Jun 2021 14:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-27-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-27-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:04:38 -0400
Message-ID: <CADnq5_PGdpbas0+KJzs5EGa_n=HqEZaMiPVh0gzVxhaWKBN7wA@mail.gmail.com>
Subject: Re: [PATCH 26/40] drm/amdgpu: Rename misspelled function
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
> Instead of fixing the spelling in
>   amdgpu_ras_eeprom_process_recods(),
> rename it to,
>   amdgpu_ras_eeprom_xfer(),
> to look similar to other I2C and protocol
> transfer (read/write) functions.
>
> Also to keep the column span to within reason by
> using a shorter name.
>
> Change the "num" function parameter from "int" to
> "const u32" since it is the number of items
> (records) to xfer, i.e. their count, which cannot
> be a negative number.
>
> Also swap the order of parameters, keeping the
> pointer to records and their number next to each
> other, while the direction now becomes the last
> parameter.
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 11 +++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  7 +++----
>  3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ec936cde272602..beaa1fee7f71f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1817,10 +1817,10 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
>         save_count = data->count - control->num_recs;
>         /* only new entries are saved */
>         if (save_count > 0) {
> -               if (amdgpu_ras_eeprom_process_recods(control,
> -                                                       &data->bps[control->num_recs],
> -                                                       true,
> -                                                       save_count)) {
> +               if (amdgpu_ras_eeprom_xfer(control,
> +                                          &data->bps[control->num_recs],
> +                                          save_count,
> +                                          true)) {
>                         dev_err(adev->dev, "Failed to save EEPROM table data!");
>                         return -EIO;
>                 }
> @@ -1850,8 +1850,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
>         if (!bps)
>                 return -ENOMEM;
>
> -       if (amdgpu_ras_eeprom_process_recods(control, bps, false,
> -               control->num_recs)) {
> +       if (amdgpu_ras_eeprom_xfer(control, bps, control->num_recs, false)) {
>                 dev_err(adev->dev, "Failed to load EEPROM table records!");
>                 ret = -EIO;
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index d3678706bb736d..9e3fbc44b4bc4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -432,9 +432,9 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
>         return false;
>  }
>
> -int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
> -                                    struct eeprom_table_record *records,
> -                                    bool write, int num)
> +int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
> +                          struct eeprom_table_record *records,
> +                          const u32 num, bool write)
>  {
>         int i, ret = 0;
>         unsigned char *buffs, *buff;
> @@ -574,13 +574,13 @@ void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control)
>                 recs[i].retired_page = i;
>         }
>
> -       if (!amdgpu_ras_eeprom_process_recods(control, recs, true, 1)) {
> +       if (!amdgpu_ras_eeprom_xfer(control, recs, 1, true)) {
>
>                 memset(recs, 0, sizeof(*recs) * 1);
>
>                 control->next_addr = RAS_RECORD_START;
>
> -               if (!amdgpu_ras_eeprom_process_recods(control, recs, false, 1)) {
> +               if (!amdgpu_ras_eeprom_xfer(control, recs, 1, false)) {
>                         for (i = 0; i < 1; i++)
>                                 DRM_INFO("rec.address :0x%llx, rec.retired_page :%llu",
>                                          recs[i].address, recs[i].retired_page);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 4c4c3d840a35c5..6a1bd527bce57a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -82,10 +82,9 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
>
>  bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev);
>
> -int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
> -                                           struct eeprom_table_record *records,
> -                                           bool write,
> -                                           int num);
> +int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
> +                          struct eeprom_table_record *records,
> +                          const u32 num, bool write);
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
