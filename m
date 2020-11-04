Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B8C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 01:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847492242A
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 01:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXV59tOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847492242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198C06E92A;
	Wed,  4 Nov 2020 01:20:11 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9915C6E927
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 01:13:21 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id a65so15157560qkg.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 17:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GgNdfI3AFJPGvR9+T2Dki1Yf4e3rlqVECgU+wuPJ2K8=;
 b=gXV59tOA3Fe0TUyfNl4I3Qt5M9BXpRx6nXo1rg5ohrmN8s+1/6bd8XKXJd69ZJxxsw
 kL1Tdk9iQ2kkxku3RTZDViNEV3ShjLkUE6Jch5e6Dg3mESfp7fomnJVlkfX/l+kT4ty+
 5quwp4UFW5fvzxiJJcLYp3c1Aw5e0aNQGMnT1E9eb/7/PaftGup4+rnWHsrV8Um6ova+
 aJLMxLuW9O3KeL6/rbTirJi2BDEBdxial8fSTeNpXTpGA088in7N+c5zrJ6IkScWXiHk
 1WCzb675cek0JIh17v2bucJIx0oMqjMa+/BQAmTtTDcEETSFCmL/JAd84yzGyiEjkKJO
 1HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GgNdfI3AFJPGvR9+T2Dki1Yf4e3rlqVECgU+wuPJ2K8=;
 b=uMlGOKrr/2jYMPsOy+n8UPn7cD2FgVqex28jMhY7GWZwc0zrw3jFh2p9G6KaYVcPIl
 y5C6OPZumY3Y0XgoZer4ZB++wt2E2CU3iaJGWmYTaZ2SykKsSA+oM0cxqo8e2N1BhEDz
 x5Jb8cBwydM3ND/A2Sj6WkdFUyrTyklxW0QCWt2C/YgSVl6z64OckJGzbPBzw3zxrul/
 RyBS+rfCU75LTQas18f4YjEUUfofWNPM1CzrYDwEnYyvOEaawFoK9TH6jhDq04Ta2RO2
 6WumS676uEVmcd31d5uAZueTxLW6Aj0avBfumwBUqlQxiXuwXdpDE7IN6hZYtBb0I2ec
 QWFw==
X-Gm-Message-State: AOAM5311SmEmu+DB4pQ4KV25DbzRJKAdIDK92hKOiCFaPMQ8wPW9StHt
 DNiaudlNFipb+VcSZoyH3Qc=
X-Google-Smtp-Source: ABdhPJz37hunKvd7+ujU9Th02o2ugFe7ug7XFZLvD1tEqPKubeNIY/KZ9VFyalhoFY3+4EUl23ctEA==
X-Received: by 2002:a05:620a:6d2:: with SMTP id
 18mr23540746qky.280.1604452400680; 
 Tue, 03 Nov 2020 17:13:20 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
 by smtp.gmail.com with ESMTPSA id y187sm697665qka.116.2020.11.03.17.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 17:13:19 -0800 (PST)
Date: Tue, 3 Nov 2020 18:13:18 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into
 CONFIG_DRM_AMD_DC_DCN
Message-ID: <20201104011318.GA3600936@ubuntu-m3-large-x86>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <20201016165004.1218352-4-alexander.deucher@amd.com>
 <20201029221410.GA1982624@ubuntu-m3-large-x86>
 <CADnq5_OKYmpobjJGQ0sGTbkz3RNuuOBadySLE5URvh0CjxdD8w@mail.gmail.com>
 <20201103010059.GA3268770@ubuntu-m3-large-x86>
 <CADnq5_NrPOc26rzHWxS9TpBqCjpv3rhnaTS_O6B++YX7wEwOjA@mail.gmail.com>
 <20201103182705.GA1750585@ubuntu-m3-large-x86>
 <CADnq5_MTcdH=OjbESa3fV33DhnDRG2-ZkmnC1zJjQEe80kpd=w@mail.gmail.com>
 <20201103224407.GA1807194@ubuntu-m3-large-x86>
 <CADnq5_PCpbZkF4CfG2spxnGfwf+1ZBkGV7c3sRwt1drNPM6CCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_PCpbZkF4CfG2spxnGfwf+1ZBkGV7c3sRwt1drNPM6CCQ@mail.gmail.com>
X-Mailman-Approved-At: Wed, 04 Nov 2020 01:20:09 +0000
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 03, 2020 at 06:12:14PM -0500, Alex Deucher wrote:
> Whoops, missed those last time.  Ok, 4th time's the charm.
> 
> Alex

This one looks good to me, I replied with a tag on the main patch
thread.

Cheers,
Nathan
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
