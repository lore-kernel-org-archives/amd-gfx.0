Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A73611C8
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83A73611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7EA6E827;
	Thu, 16 Sep 2021 19:00:11 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C74D6E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 19:00:11 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 c8-20020a9d6c88000000b00517cd06302dso9556048otr.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xEDJGrkRlxhEbpoHXBH2e0ETKbk5DXLaK+aqxZ8UY1M=;
 b=o4ImyGNcJB/zN6ajlxr+htxp9P6PqCC0X1zuU7zk1p26NS5TvPTGd8PGjEtemeMhBC
 CD5HcMUxncDeOfay+q/Sz+DnWQl6BGlIe0+x1Vs95z3S46zj0p3Y2BzznCwkRzQfwjVB
 ZZh0Jk7sH5aAt/RJuE41PEyD61ozvhW8h0iszkDtsLotKGTBGbzPUKoyn0ZPhFEfSThs
 Zo4IRCCw2Fo5LB+qz8nNokuU19rLuc2WWpCV0sD3CzM/PlvLhmUt3AvCJobfcY9nQdhd
 jPG4u3VORkKg+YxAQX0aR7qT/DekUIgjPTQ1lyiAd8hxP6bCYhkiE5aUgJsRbSZkqQtz
 JK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xEDJGrkRlxhEbpoHXBH2e0ETKbk5DXLaK+aqxZ8UY1M=;
 b=UZKkB5KMl4u83dyjXktD6d735TuOwbY1JkLr+6kYZdN5VRQE1F8cgdI1Q6bwAqzi29
 jBWqQpDY4pxZ8BXsEbJnk/Mv5guk3mxGRUjOZ9kDfciYfuO4uWm6ooo4EBue1hC44LdF
 XVOGwqvzhubQZMSEOLjc5YNhBn2G2FjrVl3jh9Qe63dAtXM45kq+BTpedfVSY2Qkan+A
 PlQSHSJv8O3sFp9Wrvnpduq+40Qu5aqndXzOOgEp5fHh5DWpAjRCKLkrVuQW42OoRx9w
 JJ12pcjnk9+tjdccznxGev38ssYF9cBnIZ1VZxoiUqdDtQ4yih4keZw3u1A3O2oQEPVY
 zvew==
X-Gm-Message-State: AOAM533TwEDkYV32cKp3EZrNdS068UneWWKHTGzSLRoyheYI/CzQ9lay
 1dy9ef5pDO0xvlnQHyEjFtCMwcs01rScFCtSFBJuAApHeNw=
X-Google-Smtp-Source: ABdhPJwj8auiefIEhKCVf89FEqbS261Qi3tLhD3srEESVIDf/MPuTE+c+6tGgcp0rYoN4hVQrDlDs76XlfKX+tg/I/I=
X-Received: by 2002:a05:6830:2704:: with SMTP id
 j4mr6165867otu.299.1631818810307; 
 Thu, 16 Sep 2021 12:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <AM9P191MB1857E1C7B1552C45D3BA9D55CDDC9@AM9P191MB1857.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB1857E1C7B1552C45D3BA9D55CDDC9@AM9P191MB1857.EURP191.PROD.OUTLOOK.COM>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Sep 2021 14:59:59 -0400
Message-ID: <CADnq5_PNCynNXxLE3oqOk2+ZHW79qxCM1by2UUWWQJ_f2KrNXw@mail.gmail.com>
Subject: Re: I get this error while trying to run 3D applications or games.
To: Davut Demir <davutdemir16@hotmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 16, 2021 at 2:48 PM Davut Demir <davutdemir16@hotmail.com> wrote:
>
> Eyl 16 18:49:02 davut-laptop kernel: amdgpu 0000:01:00.0: PCIE GART of 256M enabled (table at 0x000000F400000000).
> Eyl 16 18:49:26 davut-laptop kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=527, emitted seq=528

Looks like a GPU hang.  What application and GPU is this?  Best to
file a bug (https://gitlab.freedesktop.org/drm/amd/-/issues) and
attach your dmesg output, xorg log (if using X) and any relevant
information about it.  You might also try upgrading or downgrading
mesa.

Alex
