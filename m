Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F8C388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DA7221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgPNTNpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DA7221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396FE6E5CF;
	Fri, 13 Nov 2020 17:46:31 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A146E5CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 17:46:30 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id h2so9051253wmm.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P/ACQDo6JllZPQafSh1yIIzjDWZ9E9r3y307eAt5UBg=;
 b=mgPNTNppQGHq08Ws4a+Qm0oklrWY1zumHxySw4cmx8eiw5wSD7b/qk3KJpNgzSgni9
 4hhQYMBN5NqzShGZLezmZrHxnsknWJWKG4t0sCAL2YwkeEZBkNAhzOKoNCB/XjCjvkeU
 2scMSUwbZuQI27MgJsduIJwj2wkjq0xRNltpXp4e1PxRoM7tnKRgWS/n9Fqtz47Bl39K
 Syi0Z/ZonXaJdPesrslEJ4Ky6aR6ZfB4pKXpDvWkwExP9s7Q7xSZLc7QFO09/plZf60W
 NygzwBbdVgBXB/KIcStLVpgmYw91ibqntvyeI/nPolonAXXT5zc8MIYtCL1w5rLz5IcF
 h60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P/ACQDo6JllZPQafSh1yIIzjDWZ9E9r3y307eAt5UBg=;
 b=RMc1/aDWC5AzVcCfe7WZHotmLQEP9+ANc+Z0LmBayMmW65YUe4wWBsUJeIQPrqUEdj
 0Qh7t6F1rj+hFaVBTT7Bud1rLW0clMvMCmyHw8VvUnAPSI70wET3k3x8gRzCb6krc0B/
 NXs3VmeSkRGP2s5P8uGh1Gg0VWHwIFQ0FhBc2RNnWaFZveB9Str9xkwwONavqa2yz+na
 PmJhx7Ah1lW6ejd+bY13UXzQae/lZPDKY9WGsJ5EBFXb02rcvUoNvNFlrwsCiVm2uHb2
 SpAC837aBFLXV+BGIcTp/FQoz4dMgeXQjSaXIOr8VLaXQgFWpDAeQTmvt0KliZG90H+N
 1s1Q==
X-Gm-Message-State: AOAM531YNdk4OrP65xIBsPcB8JaywhTKf6WsPWmPTOdlK2nOZDIqvQJV
 M28C7m6+XwKbd96UecT9jQArhUMGp8s2WQgD46cd2fL7
X-Google-Smtp-Source: ABdhPJyDZ3hrhxeGpGsemJWQ3AY7yUXtM22QTF/GwjMwsKPYlWLTy400yvPDb0IasAmhyaWg2GEmGTSFLtQ/h4vCxwg=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr3603437wmi.70.1605289589049; 
 Fri, 13 Nov 2020 09:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20201113173346.38622-1-nirmoy.das@amd.com>
In-Reply-To: <20201113173346.38622-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:46:17 -0500
Message-ID: <CADnq5_OfqqXb+PiZ0OWi3jTJ9Nw3ydDwweAUuQ3_u0ROEtt+vQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix usable gart size calculation
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 13, 2020 at 12:34 PM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> amdgpu_do_test_moves() is failing because of wrong
> usable gart size calculation and throwing:
>
> [drm:amdgpu_do_test_moves [amdgpu]] *ERROR* 0000000020bdc9f3 bind failed
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> index 6042b3b81a4c..7b230bcbf2c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> @@ -42,16 +42,11 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>         size = 1024 * 1024;
>
>         /* Number of tests =
> -        * (Total GTT - IB pool - writeback page - ring buffers) / test size
> +        * (Total GTT - gart_pin_size - (2 transfer windows for buffer moves)) / test size
>          */
> -       n = adev->gmc.gart_size - AMDGPU_IB_POOL_SIZE;
> -       for (i = 0; i < AMDGPU_MAX_RINGS; ++i)
> -               if (adev->rings[i])
> -                       n -= adev->rings[i]->ring_size;
> -       if (adev->wb.wb_obj)
> -               n -= AMDGPU_GPU_PAGE_SIZE;
> -       if (adev->irq.ih.ring_obj)
> -               n -= adev->irq.ih.ring_size;
> +       n = adev->gmc.gart_size - atomic64_read(&adev->gart_pin_size);
> +       n -= AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS *
> +               AMDGPU_GPU_PAGE_SIZE;
>         n /= size;
>
>         gtt_obj = kcalloc(n, sizeof(*gtt_obj), GFP_KERNEL);
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
