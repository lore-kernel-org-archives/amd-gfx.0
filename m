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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2F1C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C1361362
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C1361362
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98BF6E432;
	Thu, 10 Jun 2021 21:23:52 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9746E432
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:23:51 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so1181225otl.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T6WV63ed8OT0KY01oeRz0GARRi8bxwoL7bcpda/n3Ds=;
 b=qYDm3WPzyQNHIHzuGa48xIvZcR3FYWWd/7VUu0MEH8htPka4GVvQhOKXeStEil6PMA
 otsAVb9sulKAAeNsvFo0XiMnuAzIDIFE7R9Tg4DVmxX0my430/JS+L1mkvZfauTxgzKq
 AY1gkAJ6+58MSkaYw0yiS26A6Qvw3BxwRiR5TfbdSeZknmgdaR4PtSoD/XZb9LVEuMhP
 LP3+jiEtOCtK6YZj81F/KCF2QRBNOIbjmpAmdjgmkd+3t3UYETf601VdT75RcI/2XRZE
 LbxIMVieqYgqZs7CkuCkNY6wuoBPfALasbf0PwfT8A6K7VP4kJg1qGpv6huLES96OGfg
 aVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T6WV63ed8OT0KY01oeRz0GARRi8bxwoL7bcpda/n3Ds=;
 b=aAAn9eSYMnYfeO50shm7hnzhFJdm0w64xLo0hjXLuxjpMKba0MCh12bi0EEYmWWRwo
 qhIjGgqDc+HqTWcFuR91j40gvMxyg2f92bv+LAaEHsBMU8nSdCjfX7FzsMEfVh/ZrWy9
 J+0ZDhqIsF4R/EE+rUKYHNwGewB1HPulomuykAbRSuq/yGUG+dGW1vKNgmEITpNZEGEF
 0eTVKo44zKHG9c24TOe9MnMUc2HewGiTHt/0x90/Sk9woVBh4OY6UzCjQDQm45KWtcir
 5Ln/9gt555Zd+zAG2G+XRX9BrP99FGisGxYMBqUmA3w2lMl62WRe4kg8RGeyjpVUQgHq
 p0Bg==
X-Gm-Message-State: AOAM532kMmO1w/WPHtJwZ2kAe7DV+3fmbQNTkekAxHdkWeNYHWR0FGfS
 +biY000hFj0J0R/NGdevaaj7OOyHnEZ+gvmSC+8=
X-Google-Smtp-Source: ABdhPJyk5wk/JvSlHkZcNhtTWfBxZRPXrFsrXGbXFhTjt6dojH8VQ9kLlvoMpMjpA+4kBY35ZZjVl69PSqd+8G9FUMk=
X-Received: by 2002:a05:6830:33ef:: with SMTP id
 i15mr301297otu.311.1623360231069; 
 Thu, 10 Jun 2021 14:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-40-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-40-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:23:40 -0400
Message-ID: <CADnq5_PK4FGegLc28DRTMpdJmj7FGZLZCeQNmc4wxQBVcJqS-A@mail.gmail.com>
Subject: Re: [PATCH 39/40] drm/amdgpu: Fix koops when accessing RAS EEPROM
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
 John Clements <john.clements@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Debugfs RAS EEPROM files are available when
> the ASIC supports RAS, and when the debugfs is
> enabled, an also when "ras_enable" module
> parameter is set to 0. However in this case,
> we get a kernel oops when accessing some of
> the "ras_..." controls in debugfs. The reason
> for this is that struct amdgpu_ras::adev is
> unset. This commit sets it, thus enabling access
> to those facilities. Note that this facilitates
> EEPROM access and not necessarily RAS features or
> functionality.
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d791a360a92366..772d87701ad4a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1947,11 +1947,20 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>         bool exc_err_limit = false;
>         int ret;
>
> -       if (adev->ras_enabled && con)
> -               data = &con->eh_data;
> -       else
> +       if (!con)
> +               return 0;
> +
> +       /* Allow access to RAS EEPROM via debugfs, when the ASIC
> +        * supports RAS and debugfs is enabled, but when
> +        * adev->ras_enabled is unset, i.e. when "ras_enable"
> +        * module parameter is set to 0.
> +        */
> +       con->adev = adev;
> +
> +       if (!adev->ras_enabled)
>                 return 0;
>
> +       data = &con->eh_data;
>         *data = kmalloc(sizeof(**data), GFP_KERNEL | __GFP_ZERO);
>         if (!*data) {
>                 ret = -ENOMEM;
> @@ -1961,7 +1970,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>         mutex_init(&con->recovery_lock);
>         INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
>         atomic_set(&con->in_recovery, 0);
> -       con->adev = adev;
>
>         max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count();
>         amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
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
