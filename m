Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C0AC2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 09:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BCA20679
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LPqgcg/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BCA20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE436E969;
	Wed,  4 Nov 2020 09:43:18 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34DC6E96A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 09:43:17 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id n15so21347919wrq.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2020 01:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lEv4v5EmULMb/ms42XJcNV7F3yLyss4vuS+lGaVOZwY=;
 b=LPqgcg/kiZMFu8TlIGT9IAe4MGP4xKHKC9wWNKdewzkgtmCRqGySLoA/pakjEnq7Lu
 M7rEeiovzzbpwM3Hv0Ml3dmds1oAd0djDaCFUi+i2ffnhSa/9BfcYdHFQx259TlGJAzE
 y+QfeRQVp7FRU8obnPN7fDuoIMzXcvumWAf8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lEv4v5EmULMb/ms42XJcNV7F3yLyss4vuS+lGaVOZwY=;
 b=kGYIRTdmW51z9mE1iTq9gW3BIYyBxnwDHHhfpfM1M+oafBqjfrQW8cSxsavh7Mafe+
 zcUodVwhCLzLU5PbTwFE6XE+nOXh69BzJZb0Cic4ZptdTdsK/YgauEoikO844mlV+TRL
 AGzuVqz15UUobA2XuJSPvfiOyy/syu/DK3awuLXLiRfzLJyeEq88HUXA+izYPK9eQnpl
 nMlCcQI7MVp2A6yJAbQHJckucZHCdX95tp8Lh8HubuhKEIZ00pgljkU+8Iqq4PawTBHj
 sioOpRXN4+vdrRzvQscyvpbdlEEk+bzKEp16uVvW3c6ptnoorWHzzBNa1jZ2N+0MDo9U
 Nabw==
X-Gm-Message-State: AOAM53353LyJt1wD/nJcEJz1HmLN5Ry3g/1MmRf/Fh+DWt+mHChrJbSV
 DCWkuxqjTszCuNkzg8KD+Onz3g==
X-Google-Smtp-Source: ABdhPJwlY5iUbnJsERzg3nMEYRaSm6ku4ZooiceZMm70iyIJrKlJs45cWCfhD9CAKy9QiUjLyP5nAA==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr30920288wrs.131.1604482996465; 
 Wed, 04 Nov 2020 01:43:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id a12sm1736095wrr.31.2020.11.04.01.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 01:43:15 -0800 (PST)
Date: Wed, 4 Nov 2020 10:43:14 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 0/2] amdgpu's drm_driver becomes const
Message-ID: <20201104094314.GM401619@phenom.ffwll.local>
References: <20201104031129.361178-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201104031129.361178-1-luben.tuikov@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 03, 2020 at 10:11:27PM -0500, Luben Tuikov wrote:
> Hi Daniel,
> 
> These two patches follow up your latest
> DRM work to make definitions of struct drm_driver
> in DRM low-level drivers, constant, in amdgpu.
> 
> This set doesn't descend from my previous patch
> "drm/amdgpu: Convert to using devm_drm_dev_alloc() (v2)",
> since our branch doesn't have it, and I can see
> that your const patches aren't in drm-next yet,
> but they are based on my conversion patch.
> Perhaps you can graft these two patches locally
> and dispatch them via drm-next. (There'll be
> a one-line conflict, namely the devm_drm_dev_alloc().)

Ah cool, thanks for doing this. I'll take your series here and include it
in mine and resend the entire pile.
-Daniel
> 
> Thanks and Regards,
> Luben
> 
> Alex Deucher (1):
>   drm/amdgpu/virt: fix handling of the atomic flag
> 
> Luben Tuikov (1):
>   drm/amdgpu: Make struct drm_driver const
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 32 +++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 25 +-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  4 ++-
>  3 files changed, 32 insertions(+), 29 deletions(-)
> 
> -- 
> 2.29.2.154.g7f7ebe054a
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
