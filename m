Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65254C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198AA61CFC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198AA61CFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA746E925;
	Wed, 30 Jun 2021 04:48:15 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F15BF6E925
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 04:48:14 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 v5-20020a0568301bc5b029045c06b14f83so1335991ota.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5sclTw+OESTJiYhMDp/6SlZbZZVuw22aJ0/tMW88NsQ=;
 b=l/bAhJrGRaDB90ZnT9BKX1qd/8VeTAdEdOnuPrJeQffybLhZc6IdH63rVWPxrNHXWX
 Ow+UpYy1SZOMbK/f0DvcfmGJvOGApim8YksADBPdFjHEw0/rarjFGC+XVTSAsN+D8/6V
 GKiAJ9iiSK/2ZiZt2Kl8RZrGhXT8Rt4try4Q86hLSEBk5afsiqRHmwHz5zKFjaSncGMN
 R0+VtJU5H0fJOoeOFBuQggm70hIJvUBPf+yKRKiTkGnk3tqgmPl9KUdTySw/RCqFQ8FM
 EdIEFrdlXpFksICG3CPCNZTPfk6+7IChFnMAE5p5vslXyONtJMbVlleEB77ZZwaqJa9a
 u7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5sclTw+OESTJiYhMDp/6SlZbZZVuw22aJ0/tMW88NsQ=;
 b=Eu6wr8qJQI5FxBDXOKdFPsDfyVO84DVKxGgmz6BiryC/WJAdFR2Jzko4RM613rKQVT
 mP678rqNwGmulh9a+Kg9YIJZ74LhZJge10D22923lufqCvRVRyot39MWTod+T10Ip2F1
 xk5ItBWhfrkzwzYt1i/e1iEqBwil27pw0zEGDJBmF1nOV2Pbk67Cp/Tl525i/D9Yqq50
 2G+8bs/BUHSjvHwSQxayqsUN4r+xUhI/Hqfacc12ZXT+2aSTxW0AT9K4/TpS/WxF6TmY
 J2NUtbrV8j8n2d8RuUsH8NYeBLYXIbfRJs7vXbtlM8QGFI/rhz9VimsLax/MdvtrsxPY
 Rbpw==
X-Gm-Message-State: AOAM530/fb0+p9rBC4wcuK6lJWMJxbjTuLNPCcsDzVs7d0IpDFynrGAp
 boCvWXtCbUVMMeYLrh/hPD8pPBiqHY6TYEn43ZM=
X-Google-Smtp-Source: ABdhPJzrdRWWAP+ysnZFMer6nPEMW74b1AzudAEM8f04q8Ac836Z2YPvtUslOVwrffOO9iZy+KrvAfkw/L2K9GKDOXg=
X-Received: by 2002:a05:6830:4119:: with SMTP id
 w25mr7693519ott.132.1625028494312; 
 Tue, 29 Jun 2021 21:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3xKZ1VKgaP+Xg8kqwGkvqdmJD6BRjYSajbM7Udnt1iA9WubA@mail.gmail.com>
In-Reply-To: <CAB3xKZ1VKgaP+Xg8kqwGkvqdmJD6BRjYSajbM7Udnt1iA9WubA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Jun 2021 00:48:03 -0400
Message-ID: <CADnq5_P8m5+yFyGy4Si5DMd05HOx+uk6RMAPKvZu926+cc2y+Q@mail.gmail.com>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
To: Ketsui <esgwpl@gmail.com>
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

On Wed, Jun 30, 2021 at 12:45 AM Ketsui <esgwpl@gmail.com> wrote:
>
> >I think the 3200G may be a raven or raven2 variant rather than
> picasso.
>
> Are you sure? Examining vbios_version yields this on my system:
>
> $ cat /sys/class/drm/card0/device/vbios_version
> 113-PICASSO-114
>

I could be wrong.  I can't remember what marketing names map to what
asics.  I can tell if you can get your dmesg output.

Alex

>
> >Can you try the latest firmware from upstream:
> >https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/amdgpu
>
> Sure.
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
