Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ED1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A625010F96C;
	Thu, 30 Jun 2022 18:58:57 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB4D10F96C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:58:56 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id sb34so40683656ejc.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 11:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z3Hrq62boapfcqzItKRvzLDjO97uhuiwN5bbQAl3bsA=;
 b=h5DWDgIt+38fSqof0GO/3hMx7cN22mDBBHVVQzSJXY2ECPfZ13Q862dobnC1bq5huv
 tSJ/BWV6C6zwcvtwVzPyjW/lpvnswz0R/yoyPngpkBYdb/IBgVC2RSUjs3z9cfriW3M9
 FBKXtxVKwmR9o2npMogp7gFsOeDYy6togZ3n4B6QvmuhiHDyLANQsAzco9P+ikiZX1xr
 xbMMNfRBgaiGOz+1ILNbpPrwsqLir4Nn8MFGcQGersEJP3zsR0PIvZiEV7AfOBMR6rGd
 iSEr1b/q12uGu8o/Y2jHZdiHPsRtutGHARyfEGyhAdzTW1EFh2vUdnXOHpr0r8x8RGkQ
 c6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z3Hrq62boapfcqzItKRvzLDjO97uhuiwN5bbQAl3bsA=;
 b=eWLo7KzvFMZiJgapdGyHEI2UM0UZptuhIn8cbvpBURV0+hup8TQHTCeyyD0zX1uqUn
 7RAvtBJNeWnU+b8M8mkpsl0rRsPr4I7pTuoaq2VIpiIuI+Rtsq5+tH+MbQ7ZYa0+gPT5
 yTieim6W13BSaaD00WAnAOENOqkatj0WY+zBr3SjkWNK2RsksKHepCpPrTFw2L3ViHTx
 NbN6Tt0gFj/7VQNNpRpnzUETKeALJ/D9UeIWluFb6lrnHZm+hImCBmkqiFmZsvm4e0mT
 aYFo0ilHy/MLxd/u2fYD3or4kovBdZIljZN6noTbSn2OXskzbLmr7/EZkcc7wo/4ewx4
 5IyA==
X-Gm-Message-State: AJIora8OEYDsQMV85bPfxx62lsf6xr5l+iWikhoPS8o/t7Axmar70FBa
 RsB+b7mcOLhi3KHOid9wT0SVCDGprvrQxYA79Nw=
X-Google-Smtp-Source: AGRyM1s6d0MvIF6JyBhGL3PNS+Vx2ZL6Q1t5u/yxGlAY5aCSL4CFB/uD9BaU6ZSUPJUdBYBpS/XcG68q3JkF6KNlCfM=
X-Received: by 2002:a17:907:a40f:b0:726:a8f5:1031 with SMTP id
 sg15-20020a170907a40f00b00726a8f51031mr10441766ejc.185.1656615535155; Thu, 30
 Jun 2022 11:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jun 2022 14:58:42 -0400
Message-ID: <CADnq5_M0Ec4dOD0JE+wYq4oCLJkJVZuCkr8D4c3CdcDSik-E2Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix compilation issues when using i386
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 30, 2022 at 2:46 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> Fix compilation issues when using i386
>
> We recently got feedback from Randy about issues in the x86-32
> compilation.I was able to reproduce a very similar issue by using:
>
> - gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
> - make -j16 ARCH=i386
> - amd-staging-drm-next
>
> I'm able to see these issues:
>
> ERROR: modpost: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__umoddi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> This patchset addresses each compilation issue in its own patch since I
> want to have an easy way to bisect display code in case of regressions.
> Please, let me know if you see any issue with these changes and if it
> fixes the 32-bit compilation. If you still see compilation issues,
> please, report:
>
> - GCC version
> - Config file
> - Branch
>
> Thanks
> Siqueira
>
> Rodrigo Siqueira (4):
>   drm/amd/display: Fix __umoddi3 undefined for 32 bit compilation
>   drm/amd/display: Fix __floatunsidf undefined for 32 bit compilation
>   drm/amd/display: Fix __muldf3 undefined for 32 bit compilation
>   drm/amd/display: Fix __nedf2 undefined for 32 bit compilation

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

I think this patch is also relevant, if someone can review it as well:
https://patchwork.freedesktop.org/patch/491429/

Alex

>
>  .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 15 +++++++++------
>  .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  4 +++-
>  drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 +-
>  3 files changed, 13 insertions(+), 8 deletions(-)
>
> --
> 2.25.1
>
