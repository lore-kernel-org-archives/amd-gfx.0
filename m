Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28887C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 01:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F4C20787
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 01:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="RR3inxHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F4C20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aurabindo.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729DB6EB36;
	Thu,  9 Apr 2020 01:42:47 +0000 (UTC)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472806EB12
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 23:18:56 +0000 (UTC)
Received: by mail-il1-x143.google.com with SMTP id a6so8529635ilr.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2020 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xIQm6fd8XzuEF+zm8pOL7pNaI9rUwGZpiWPVM8H1bSE=;
 b=RR3inxHNUItmUkfN6BIANFJr5kU1yf5GC8vhL8B+NMY7ovOMiXXmaF3Og/C7qSnUzt
 YKfEmLLfMm8RLstk1uRScsR279J+7GPXncEpu3UrO6NEGN+m0bPVlcdRQnQlfOk674qo
 +JMnVpY4lYtYwUq3+rAqxr9kPhTKkH6ROO/jQ1rCh2Wj1r+c4rL3GuT7c0mDqzVYmrCh
 FnbrrIH7DkAcNOlqSwgSm8RQKxoTvpOB2wmA1JoK9zlbRcw0O16NMd68q1pvmuguFjU0
 09wHePpXkryGQ8UZFezGovxC+hWSNPz0dC83e92HLT+RkNsVHc8Z2M8atHdycjYmcqyx
 afbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xIQm6fd8XzuEF+zm8pOL7pNaI9rUwGZpiWPVM8H1bSE=;
 b=Shp8Tf58YzCeViDF4aT6UiESyTSYWSjBcp66CIskaG7/wZS65t+Gxy5n53I0B9geN/
 hOHp5CSG3ay1jlDqpHFlpqV+3FlDciJ3U7nrIuTazQsszCJgQ/eaIs1sRTTaZ8c+CfdD
 WkLC28XlwMfEPP3TEeoh4njilzylJiwemykUIAykIlndykX0Gt3KGF4ksqjhimhTyGQH
 +NuWDsTox9vJJkjvMf+/T7jc/kASbUSb4FykeoyFTqZvgP2rHrNmxlNGbfQNDwikBbcD
 Q3voaeN0tJBaWLTC3KhAxAcTsFFrG5Q/O8DVqyGQZ9dguN/OFMiiWgTZpyobDLV1lNrO
 MAIA==
X-Gm-Message-State: AGi0PuaH5eHAEbZTqV+hKqEpxejLAFAz3nX7YdvptfNc5DgM7he29F8e
 vvIz+rc29s8der6ieWGPWiPA7q13X0tILYYkfPsKQQ==
X-Google-Smtp-Source: APiQypKEwbFd6R9kEli2dzEGIji7GKMCjLR71i+SQ8NDaynvVQfLOCGvH4kxXequfugwVmVUaRoYsPr0x4OsopRMnPk=
X-Received: by 2002:a92:5e14:: with SMTP id s20mr10401973ilb.210.1586387935478; 
 Wed, 08 Apr 2020 16:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200408133735.7679-1-mail@aurabindo.in>
 <bfa1a07f6f2046d5edac80d282cc710328d84d72.camel@perches.com>
In-Reply-To: <bfa1a07f6f2046d5edac80d282cc710328d84d72.camel@perches.com>
From: Aurabindo Pillai <mail@aurabindo.in>
Date: Wed, 8 Apr 2020 19:18:44 -0400
Message-ID: <CAMu4TMv5DuAW3WtDOFx2xoQc_EYURZjnF722QA9mMCdUFGkBBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add prefix for pr_* prints
To: Joe Perches <joe@perches.com>
X-Mailman-Approved-At: Thu, 09 Apr 2020 01:42:45 +0000
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
Cc: David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Joe,

On Wed, Apr 8, 2020 at 11:37 AM Joe Perches <joe@perches.com> wrote:
>
> All the embedded uses of "amdgpu:" in logging
> messages should also be deleted.
>
> $ git grep -P '(?:dev_|pr_).*"amdgpu:' drivers/gpu/drm/amd/amdgpu/
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:               pr_err("amdgpu: failed to validate PT BOs\n");
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:               pr_err("amdgpu: failed to validate PD\n");
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:                       pr_err("amdgpu: failed to kmap PD, ret=%d\n", ret);
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:             pr_info("amdgpu: switched on\n");
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:             pr_info("amdgpu: switched off\n");
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:                        dev_dbg(adev->dev, "amdgpu: using MSI/MSI-X.\n");
> drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:          dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:          pr_warn("amdgpu: No suitable DMA available\n");
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:          pr_warn("amdgpu: No suitable DMA available\n");
>
>
>

Thanks for the heads up, I shall submit another set with those changes
you suggested.

-- 

Thanks and Regards,

Aurabindo J Pillai
https://aurabindo.in
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
