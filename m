Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7DCC433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657D6611AB
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657D6611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA5889C8F;
	Mon,  3 May 2021 16:28:37 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8C889C8F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 16:28:37 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id i11so5912229oig.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 May 2021 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cRFDpuMwuNrzRCZerqEUIZJfwBeJZa1OXw2reMpB/BA=;
 b=t+9zPtD/vgbXyi7ZVtybylYA1F9S2tvCyzvwtJp5jJxqceCiz7Iep5T2pZOJpcqOEs
 6abMYSPD1fCAiqQxiBvUK19ZFPwPXovZBsg7l0TlkH3T5Rsi1SwL3QcfIsquyIJ4MfvJ
 9yFeP8sb8VZvupxs6KlrQGE0T6EGwC/0AqpL+CMh30QMeUhKL5ChbudaNQczKJDbx8WW
 5xQ6KbTWGWhlFK4/xuRtwMd+D5RU5NyEiL4Tiu5mUPKPqIzcR3fn9AbkDRxRCYu6TwKC
 JLWYBBSd+x/atA74B2QbyAss24QRcMlMfn6n8ZAQsiJxY45TAotuIcYDMf6LAx67GOWs
 B7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cRFDpuMwuNrzRCZerqEUIZJfwBeJZa1OXw2reMpB/BA=;
 b=ity/hMKJh4vZX/fDvRDzFLWOwszjB5JoU+dIQ6McY7ba2eIshJSsJh0makT1zI4Ehn
 Km7mRWtGalpUJYoAbbc1oWB/WTRSiqm4I4FUI41g1Yyuu7e2IBE+U4lfXIqx0dlmrz2r
 aE6bHNpEr6A1lklG45oTetxtbzCO68DiRWHUM4f6ikiID6+aGNErzftL0l7BUFBXFy5j
 uhFQ65WkTe5mLiYw6MRbP4Rrls5zOMPGIoO73ztD+s37Q8kqx3ioGFG3fAfAzPu1TwC9
 84JbQAvT/78WjlaqRknu1fnLCD5Oc/MN3I36W2dUuklnYT3JwTRHUnHexK85OhFXXwEj
 qXxA==
X-Gm-Message-State: AOAM5331zUtjr8d/+ScTG/mfF2jtU79lWPP55lsSmb1Q2b3RRhdX5dya
 pCD9Zf8WbWkJM9BcCvR1BP5eCb3eBT0p+eMGAu8=
X-Google-Smtp-Source: ABdhPJwMp9FtUGvzhME4BtwRjW7926eRz5B7a42Bqmlr3haGwwOIUYScAuu193mGYpcJp/o/69FoIl9cVaqbLDsOdT8=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr8490607oii.123.1620059316447; 
 Mon, 03 May 2021 09:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2105031023580.29348@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2105031023580.29348@file01.intranet.prod.int.rdu2.redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 May 2021 12:28:25 -0400
Message-ID: <CADnq5_O7Mbodcoj3-NtVesQ00tH8jaAEG0vOoZx5NoDE37Cw6A@mail.gmail.com>
Subject: Re: A hotplug bug in AMDGPU
To: Mikulas Patocka <mpatocka@redhat.com>
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
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 3, 2021 at 11:40 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Hi
>
> There's a bug with monitor hotplug starting with the kernel 5.7.
>
> I have Radeon RX 570. If I boot the system with the monitor unplugged and
> then plug the monitor via DVI, the kernel 5.6 and below will properly
> initialized graphics; the kernels 5.7+ will not initialize it - and the
> monitor reports no signal.
>
> I bisected the issue and it is caused by the patch
> 4fdda2e66de0b7d37aa27af3c1bbe25ecb2d5408 ("drm/amdgpu/runpm: enable runpm
> on baco capable VI+ asics")
>
> When I remove the code that sets adev->runpm on the kernel 5.12, monitor
> hotplug works correctly.

This isn't really a hotplug bug per se.  That patch enabled runtime
power management which powered down the GPU completely to save power.
Unfortunately when it's powered down, hotplug interrupts won't work
because the entire GPU is powered off.  Disabling runtime pm will
allow hotplug interrupts to work, but will cause the GPU to burn a lot
more power.  I'm not sure what the best solution is.  You can manually
wake the card via sysfs (either via the runtime pm controls in
/sys/class/drm/card0/device/power or by reading a sensor on the board
like temperature) then hotplut the monitor or via a direct request to
probe the displays via the display server.

Alex

>
> Mikulas
>
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |    2 --
>  1 file changed, 2 deletions(-)
>
> Index: linux-5.12/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> ===================================================================
> --- linux-5.12.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     2021-04-26 14:50:53.000000000 +0200
> +++ linux-5.12/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  2021-05-03 16:19:54.000000000 +0200
> @@ -183,8 +183,6 @@ int amdgpu_driver_load_kms(struct amdgpu
>                                 adev->runpm = true;
>                         break;
>                 default:
> -                       /* enable runpm on CI+ */
> -                       adev->runpm = true;
>                         break;
>                 }
>                 if (adev->runpm)
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
