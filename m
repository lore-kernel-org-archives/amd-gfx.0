Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6B3C4743D
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 01:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0DF60FDA
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 01:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0DF60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F6C6EC6E;
	Wed,  9 Jun 2021 01:04:24 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01BB26EC70
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 00:55:52 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id l9so2964666wms.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Jun 2021 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9qeiNnEqHnToVwTF+YALaJhts33Y3hAzDOiNFEpUNqM=;
 b=nqsl5TFA6nFViy1WhnYLZii0d/gfdyqbxMgo5ZeCK+zscVoklu4FygICY98Ui//B6f
 nCqThTZMMhYiHD4SThREyZrFCg+F9BfwGkG4DqwOzwpjwwl7ICQYAkZ/P3DlUE32eBtl
 npsM7xAJQBoLFsBLrlmr81kRgV5HvHjICWZSA/fZgQBWkdDx/2nHjZU1GQ/Lj6p2IV98
 FmmigXGK7Z0E94aqQpyP2g921KQ/vi1edhJoiU6MSqBsPr9zsKXC8FFKOo4R32sUVPuB
 WWLLPhyl/pILiWvSG9BUxQf+Jkkb0QIyP35vDEmcfqloSOejvDWhu0tJnTMgBQOcc/sy
 Ovww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9qeiNnEqHnToVwTF+YALaJhts33Y3hAzDOiNFEpUNqM=;
 b=BQ+eBGZtZ1fbmDlJKBezWhVkVYWB6Cy4q9ijDmoW7dy+P8lcXJXvw37+/YJrUJ0lyL
 YXDOSbUbPq1D0bZIpspsomeUYpBQmRlDmMJnDtiWiCayjzin8pKHMd4IaVqrPEXBKgZb
 JlGlG43xmzSGhMe/o/4cDgrHwDZBnlMkKeReQEZ06v4RZ3e6p5mX+qIDTF7uz2edKy4I
 4NGZA3KZhttY0ROKRZYI6v6JBxxgjdOZRh73W5IwwAH23Ar/nPx+EhENqkolA+wdUxVT
 u+7K5c62CRo2TCUdsh+DBOeWbWKyCTp8E0CY+vkLBP1Px07UecBu/1JFLs1kCQ41nhvu
 UgSQ==
X-Gm-Message-State: AOAM533s2oZg2s39XGpAMFMFyZPLof4nSYD5I4C0ZTidpAkmr3aAx4mZ
 1+4vJbNtmXiQBNYW0IJ0FymGE61w8u043B8tNYsgCw==
X-Google-Smtp-Source: ABdhPJwGRvjqPAaMqbRNcEgccpnUGqtyTTgun+Da0x1HGhPQzUmbKr8INifXJjdvTGBCDxpQ3rvZx1RAIbgdMxBGVss=
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr25640495wmi.2.1623200151418; 
 Tue, 08 Jun 2021 17:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210608143159.1.I230026301243fbcee23d408c75aa468c1fec58f7@changeid>
 <e599ffb5-da5c-e4bb-a7d6-c2208a48868d@amd.com>
In-Reply-To: <e599ffb5-da5c-e4bb-a7d6-c2208a48868d@amd.com>
From: "Anand K. Mistry" <amistry@google.com>
Date: Wed, 9 Jun 2021 10:55:38 +1000
Message-ID: <CAATStaPcjYAoMdUVj_G3p_OQuw_faQY0PGiXeo3unPFd=WN2vA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix error code on failure to set
 brightness
To: Harry Wentland <harry.wentland@amd.com>
X-Mailman-Approved-At: Wed, 09 Jun 2021 01:04:23 +0000
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
Cc: Eryk Brol <eryk.brol@amd.com>, David Airlie <airlied@linux.ie>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nikola Cornij <nikola.cornij@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

>
> Thanks for your patch but this code has changed on amd-staging-drm-next.
>
> Can you try with the latest? The new backlight_update_status will always
> return 0 now.

Perfect! This solves my actual issue which is that restoring the
backlight level is failing on my device. Thank you.


-- 
Anand K. Mistry
Software Engineer
Google Australia
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
