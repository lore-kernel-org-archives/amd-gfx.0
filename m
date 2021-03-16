Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659D0C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 14:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DA36508A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 14:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DA36508A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D88C6E40D;
	Tue, 16 Mar 2021 14:56:53 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9106E40D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 14:56:52 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 v24-20020a9d69d80000b02901b9aec33371so6992629oto.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2se3+e9Ty82WG6N01sc2W0mG05sr42JpjvxW7zrVMCk=;
 b=MhhzFZrkr6YEqRVz37DvV9grXuxObsMBga/0R37knsqkg5b7L/OX8cZ/uWelKeyje2
 3uA5VbjbvdT8tbDfyaaQbpAD8Hc3G5N1fo+R8UjWRGGZnaXr5UY94CprK6qloStAJ5dp
 K63GW80vSHRA1SWpl5Qx9DwKFGpIl5fe3L59j2G8Wiw1Do5pPP/tp8FnyD3Tr0OQdJW3
 AOJChdycqqzb7RoQno3P/9kTYpTzGyw1wgQjs3hDcelC3i2xfL7GcdheeQKEtOr2RI2I
 uE/zR/IV5oaq85DelFemGunZZGMC71/js8hNrVOWH1UQCkHzzvCVkGAy/RZGv47GBnQ8
 CPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2se3+e9Ty82WG6N01sc2W0mG05sr42JpjvxW7zrVMCk=;
 b=MFD1KxEiGbh0R3d18NeLPF5zC8GTxeJSJbmJ4lvuVp9jwPnbRYUYz0dqSqb1nfRaj+
 KaTYJNLCmW/WYiKWvovFHlKJ08QXisi79V4lSlPyCwXq5kh54QY+RZBhWXDz0C+u83B/
 LuNYeeZl9avJLNY/Jy3H5m9W2Xz1vIDGwo0ZZbqOlxeVFVd2dIMkDczl6rBAfAlsngm+
 eeQNm3mtmhE10n97XXT8Cy7hSiQATrAX7Ct9TDG2FCijOqoMLPS6hLGpZyZJUsosH6SR
 saeCRy5yJtyi3C8FyJsaDbaWfIF2VIxXOHzpcAlyOAtz9eN91jSX7fmPwTBwqldp3hWc
 Du1A==
X-Gm-Message-State: AOAM531RnJ1Kzhsz/Vg6F3jwPHr8VXSGHDEPuvQywQIyy69iZv2lnOt/
 iEf/7wjlIY6H5LmRUHBRSMC7mT0smEGM7/CJXFc=
X-Google-Smtp-Source: ABdhPJw1V+m/frJM/2xtN4jtFECvZq+UptL7ppwSLvwcrvet8uuaqdC5LroSwKwQTqqaxIxEd+LVQFm2vXL/vWe67Ic=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr3920327ota.311.1615906611516; 
 Tue, 16 Mar 2021 07:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <1298946407.166914.1615904893558@mailbusiness.ionos.de>
In-Reply-To: <1298946407.166914.1615904893558@mailbusiness.ionos.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Mar 2021 10:56:40 -0400
Message-ID: <CADnq5_NuUD0k4KybVwDeZEW3B5nbs4jt2OWzrehrX+EXS1eMNg@mail.gmail.com>
Subject: Re: Is amd-staging-drm-next dead?
To: Martin Babutzka <martin.babutzka@online.de>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 16, 2021 at 10:55 AM Martin Babutzka
<martin.babutzka@online.de> wrote:
>
> Dear AMD Developers,
>
> I am building your amd-staging-drm-next kernels for more than 2 years now and patch this up with the official kernel patches and ubuntu's sauce patches: https://github.com/M-Bab/linux-kernel-amdgpu-binaries
>
> Since quite a while (end of 2020) there have been no updates in https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next . Is this repository abandoned? Is there any new way or repository from which the most recent AMD linux graphics drivers in the kernel source?
>
> I was asked multiple times to update the kernel but there is no chance without updates of the staging kernel.
>
> Looking forward to your response.

It moved to gitlab:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next

Alex


>
> Many regards,
> Martin (M-bab)
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
