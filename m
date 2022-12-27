Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F0C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 15:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFC310E146;
	Tue, 27 Dec 2022 15:55:57 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CE010E146
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 15:55:55 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 l8-20020a056830054800b006705fd35eceso8390668otb.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 07:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fe45rFYfSm2HbigixmWKAkwrW9ACl6r8YGAqEd7Zx00=;
 b=lujBgaGh9t1eTVAiI3m+hTSpzZ+GGGMLGHOhLQy02BjUC/3zs6dh825vM6jbzAspGX
 BCCSn3nP62rmMdM3zOi3HE74FBAOnllRboZWf7yPgS5x73NISahYQHI9Ifp6mCT4P1Gw
 LRRIIEcs/6Xf/13AKyvLbT/kbSzVuvzMVVMkfmoA3uj+JYYOoFTszPvOAVzbQgFxi/JG
 LnvAKGRI4GPMKyAK/bROcmRVNCFmX/xtvIzftM+TI4uKDCHGWzLTyWr8MlkwVTurgYal
 VY2RLlnK5jrZL+YfnhacaGL+sEzhYZRQdC5Pg+jQCtuyGwxP3HwP0mX5aZOGE28u4eZ7
 n5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fe45rFYfSm2HbigixmWKAkwrW9ACl6r8YGAqEd7Zx00=;
 b=T7d/2/z12M0koL28eZtaw0tv8xxrY/7Q22WQEc1hhXeUiR3QNS2tMUCeHRIss3XLI8
 uAQ0zH49q6sccB+WUpEw7OE7agvSzf73z9qd38Jr0msGclkEOs0ReTMFjkfbOUi2+ddY
 Nx9396BB4fca3SjROuAPyGYEYy3E6ARZXVeSfpkpet1crmxLjAZ9nQ9kKLWWN5SK/hBJ
 n5LAnV1G9J1Fnnw/NLrqFueO6mmJCmDg20EHwZYk9sQ4KCcpyDSnaZtHALscDSz/HIsx
 cnqQLM5fW9A4vqg2n97fkuYnPkHeUoCPKefJNQtx7bZ6YGf2PvRMxr/PaLXxTNi3HrSF
 5B9Q==
X-Gm-Message-State: AFqh2kpg8VHE1F3unD3/D3rGMhAMvu4Gfe9fxEmnJ0UPg8vwR36DgFU1
 aNiSpCFA8bBXeM4KK3h419SZjSxbYKUHm1FQhOI=
X-Google-Smtp-Source: AMrXdXvuSoSdQsOkCuE55fO4itoYf8YbnH0Qj1pGcdv+byyJE+7NaYkg7O2fC/C1kB89A5ox7l1i2EKoUOPcIQovYh0=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr1424604otq.233.1672156554384; Tue, 27
 Dec 2022 07:55:54 -0800 (PST)
MIME-Version: 1.0
References: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
In-Reply-To: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Dec 2022 10:55:43 -0500
Message-ID: <CADnq5_NiDE7a5dmhhuLntQe88DS5JmiZTGqQ6ongXuWyh1A4wg@mail.gmail.com>
Subject: Re: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank
 screen on Linux
To: Aditya Garg <gargaditya08@live.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Orlando Chamberlain <redecorating@protonmail.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 26, 2022 at 8:19 AM Aditya Garg <gargaditya08@live.com> wrote:
>
> The AMD Radeon Pro 5600M with 8GB of HBM2 memory GPU is found in MacBook Pro 16 inch, 2019 (MacBookPro16,4).
>
> The GPU fails to work on Linux, thus a blank black screen gets displayed on boot.
>
> If nomodeset is added as a kernel parameter, we are able to access Linux easily.
>
> The link below contains the journalctl of the failed boot :-
> https://gist.github.com/AdityaGarg8/dfe1a1c23bf2b92b640dad89f55b73c7

Can you file a bug report:
https://gitlab.freedesktop.org/drm/amd/-/issues/

What sort of monitor are you using?  It looks to be failing mode validation:
[drm] Mode Validation Warning: Urgent latency failed validation.

Alex

>
> Thanks
> Aditya
