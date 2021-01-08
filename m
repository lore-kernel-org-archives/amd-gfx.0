Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89610C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 14:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE0A238A1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 14:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE0A238A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E036E826;
	Fri,  8 Jan 2021 14:43:48 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB196E82D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 14:43:47 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id r4so8600659wmh.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 06:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Zz6s1vLUquVIaMSsU3Vyn+Tdw2WdAT7heodUrvSNM4s=;
 b=X5DrkUDovLN8/y/LWQotWq8rFdZhEk+U1c9napJhXFCQuWnNybzAZTjgDsfjwV8LzU
 cXKex96lQOmm8p6FPa+8CBGvHqAr0BaZnT3f/0Wa4GkRnOdz6SO0hCLA3d77SQomEte3
 DVSlVD5tMR56V0F5eq3m3HOlYo8jbvAyzD73o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Zz6s1vLUquVIaMSsU3Vyn+Tdw2WdAT7heodUrvSNM4s=;
 b=blLbeze2NWRppDTRShLA5S8wM8fusNcFFiQ6nFZ/Jzw5tYwM/YnqTC+KUuvMXiRDjV
 /beUAKCakWSFh10tTmqVeycnpSGv2IFu/0m4joJVtAgLVyPTfu549SwEAxkJRDRmLK4B
 s8kjkSZJc+EHa0tvz9+gJPtBIqMl09WBi+mUai9uyvHv3+4zuNsfYPeyEQYKBI1TmD4p
 x8jOdU6Jjk/aZLeQaQ81uVo8oNhLClprqQwQ/0vN8LN8EhmLhgiczvEjXklTcTDbcGF8
 06s9wkrbl5Q+UJTKRbMSaC9XC+P/ydXs83hB0nM/U+y0XIPIMj5lwt83vHvymcM1flyB
 wGzQ==
X-Gm-Message-State: AOAM530GNx03v6YuzVSF88rH9bikMYzmjoV1nWW9uGVWsfjUjY6a1uyZ
 wHsvbAE5uatfNOab4ZY/MF2Hhg==
X-Google-Smtp-Source: ABdhPJwJ1sBT1PbMGNuy5atJZmbHtN6XOvxg9ezY32hnetIrwNVIqLAqHU83WjKlMvNy+a+jJVkvuA==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr3312347wmc.10.1610117025848; 
 Fri, 08 Jan 2021 06:43:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id o124sm12775655wmb.5.2021.01.08.06.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 06:43:45 -0800 (PST)
Date: Fri, 8 Jan 2021 15:43:43 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 0/3] Revert "drm/amd/display: Expose new CRC window
 property" and changes associated with this commit
Message-ID: <X/hvnwDPq+sSW+d8@phenom.ffwll.local>
References: <20210107205321.166698-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210107205321.166698-1-Rodrigo.Siqueira@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Roman Li <Roman.Li@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <Wayne.Lin@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Bindu R <Bindu.R@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 07, 2021 at 03:53:18PM -0500, Rodrigo Siqueira wrote:
> Hi,
> 
> A couple of weeks ago, Daniel highlighted  [1] some issue related to a
> patch entitle "drm/amd/display: Expose new CRC window property". After
> discussion, we realize that we can revert that patch because we will
> need to create a debugfs or full UAPI for CRC soon, which will make this
> code obsolete. We got two other patches related to this same code; for
> this reason, this patchset reverts all changes associated with that
> specific commit.
> 
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Bindu R <Bindu.R@amd.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> 
> 1. https://www.spinics.net/lists/dri-devel/msg283767.html 

Thanks for taking care of this. Since it's not super pressing I'll leave
it to Alex for merging with the usual -fixes pull request train next week.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

> 
> Thanks
> 
> Rodrigo Siqueira (3):
>   Revert "drm/amd/display: Fix unused variable warning"
>   Revert "drm/amdgpu/disply: fix documentation warnings in display
>     manager"
>   Revert "drm/amd/display: Expose new CRC window property"
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 ++----------------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  38 -----
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  56 +------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   5 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +
>  5 files changed, 14 insertions(+), 229 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
