Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288DAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 09:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D74113F01;
	Mon, 20 Dec 2021 09:43:43 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5358113F0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 09:43:42 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 j140-20020a1c2392000000b003399ae48f58so9093188wmj.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 01:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ROJgopUUnQZIGTv5KtOBScHw/EXv42kqY46Z9OcVbwo=;
 b=eDWoH43bh1PI7YYFmv2Tx4Rp9Nzx9YnJKURGmQduqjCStXmpMN/ZBOuq1eDLLnhxn2
 9akO1ISbxn+7rv5gHE5dNoqCv+26S02GRXM0a3T/42OGtPKmEwLFZy3VjNIOpzeudIVe
 /CPydC17jvPADVWejcN6jl+QyT3AeCYh8yx54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ROJgopUUnQZIGTv5KtOBScHw/EXv42kqY46Z9OcVbwo=;
 b=cS5g29qDQLQpoBbO4IxOKlou/JekDW+G44ZLeoAJgw12+u+pjg1BdjOxDlYZHVoz+M
 JH+ZjJDd91pl5mCBCVVm2yJgSWANjo5o+GNQfG/Tjr2/jkfMzQzTlqlnFRUVBYPYKuAk
 kf4/lmo5bSU1M9m0RWDyM/kajfpUOvNnaILZHywKWKwP902Q1UpQ3IKM9hLQXU1NOFI7
 HLnfhxi7swlE45/s3/eBkihBGceW30AlEGDqjBgVUNIilsumiL5WRMjFY0hc4k/VjfMq
 44XQWkTXlsgphIwpzsYmA+s9sl5tUK8ufEx5K48n6IGVMCh0hIbRTipAbLpEQDTei6kB
 4ZyQ==
X-Gm-Message-State: AOAM530feMIQjDo7Y5rPHSZxf7jkSX6yLMlXpxCfzzMrBfBzkWjyI7ag
 5dwIof3EtPCNnnZWgg9MIAzw0g==
X-Google-Smtp-Source: ABdhPJxb4gGIn5faIu5r7HvECNQYNxSUIzRj4gATdfoNmhxaFErxEkNl5vV+eEHvD/bnuPT3q5Frjw==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr15004583wmq.107.1639993421223; 
 Mon, 20 Dec 2021 01:43:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id d4sm6156222wrx.102.2021.12.20.01.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Dec 2021 01:43:40 -0800 (PST)
Date: Mon, 20 Dec 2021 10:43:38 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [RFC 0/6] Define and use reset domain for GPU recovery in amdgpu
Message-ID: <YcBQSgynkO0VYUoC@phenom.ffwll.local>
References: <20211217222745.881637-1-andrey.grodzovsky@amd.com>
 <0a30778e-28b8-7d02-01e9-9db690227222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a30778e-28b8-7d02-01e9-9db690227222@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, horace.chen@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, christian.koenig@amd.com, Monk.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 20, 2021 at 08:25:05AM +0100, Christian König wrote:
> Am 17.12.21 um 23:27 schrieb Andrey Grodzovsky:
> > This patchset is based on earlier work by Boris[1] that allowed to have an
> > ordered workqueue at the driver level that will be used by the different
> > schedulers to queue their timeout work. On top of that I also serialized
> > any GPU reset we trigger from within amdgpu code to also go through the same
> > ordered wq and in this way simplify somewhat our GPU reset code so we don't need
> > to protect from concurrency by multiple GPU reset triggeres such as TDR on one
> > hand and sysfs trigger or RAS trigger on the other hand.
> > 
> > As advised by Christian and Daniel I defined a reset_domain struct such that
> > all the entities that go through reset together will be serialized one against
> > another.
> > 
> > TDR triggered by multiple entities within the same domain due to the same reason will not
> > be triggered as the first such reset will cancel all the pending resets. This is
> > relevant only to TDR timers and not to triggered resets coming from RAS or SYSFS,
> > those will still happen after the in flight resets finishes.
> > 
> > [1] https://patchwork.kernel.org/project/dri-devel/patch/20210629073510.2764391-3-boris.brezillon@collabora.com/
> > 
> > P.S Going through drm-misc-next and not amd-staging-drm-next as Boris work hasn't landed yet there.
> 
> Patches #1 and #5, #6 are Reviewed-by: Christian König
> <christian.koenig@amd.com>
> 
> Some minor comments on the rest, but in general absolutely looks like the
> way we want to go.

I only scrolled through quickly, but yeah I'm concurring.
-Daniel
> 
> Regards,
> Christian.
> 
> > 
> > Andrey Grodzovsky (6):
> >    drm/amdgpu: Init GPU reset single threaded wq
> >    drm/amdgpu: Move scheduler init to after XGMI is ready
> >    drm/amdgpu: Fix crash on modprobe
> >    drm/amdgpu: Serialize non TDR gpu recovery with TDRs
> >    drm/amdgpu: Drop hive->in_reset
> >    drm/amdgpu: Drop concurrent GPU reset protection for device
> > 
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 206 +++++++++++----------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  36 +---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  10 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |   3 +-
> >   7 files changed, 132 insertions(+), 136 deletions(-)
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
