Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554A2C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 15:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D24206B6
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OwLv4qS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D24206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7A389E35;
	Mon, 25 May 2020 15:15:20 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A8289E35
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 15:15:19 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id j16so4933793wrb.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nZhVmkt+k/PyFcD9bZVLAYu1XJoNkOIXHLmqHm7k94U=;
 b=OwLv4qS2wQCVMlsqNIL7hzAy5rqofwmaMCuWSrDQQbULLzvLH2jVF5vSjJY39qp7ne
 XaG9HLb/49ZUZ5hVr1Xk91gF61IdTzHomegLrQWv7OGAnA9rVB0TgfDxa+pTFkHa0bsu
 4FbobgB4V2eUmWU83NuYbbQgttOk0WfZWdeZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nZhVmkt+k/PyFcD9bZVLAYu1XJoNkOIXHLmqHm7k94U=;
 b=Ff50MZ7a/rvEq48nb/knrUPzIFl4PVXe+TjKdodBu7kiFZmXa59z8g9pmXZqKWI9Lv
 C2k6hInc9jrSicIMzg3vVniEf2rd/4rPg/6Eq7p1gKCwRjuugzWw0ilUHWFtKmfCs7EH
 o5HB3/NQtbrokA+8cuMB5ZfZbFAtnpgPdJbyCKCBiM8Aa73lPH0AxZ4DKFHlzwmZpVF1
 jG+saBiXXBpUfHJH2h1LJZowhSBg0hksKBU9yLzbzZK7TMhpMTB1Ic1T7lmyPnDnFvFO
 jkMX2n2xj4jl66NlwT/FpM1eM2n16ozUAaYZZBAOveRMhJEr8F7Q6HNUhTURc20jY+KR
 ut3A==
X-Gm-Message-State: AOAM5306R9QrrpE2RH0ZUrhV2yIakE7a/rKNzdAa4kyv/y6aKOXjCR4F
 qRMmH0lU+FgiiajHHORHI/IChAVBQwY=
X-Google-Smtp-Source: ABdhPJxIJvxgJNFHAOk12epKlT8D3FmfQISZTgg/56ci6AWFGzlVao5dIvFQRUqthb2mQZOBmTT60w==
X-Received: by 2002:adf:a34d:: with SMTP id d13mr10229237wrb.270.1590419718614; 
 Mon, 25 May 2020 08:15:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id r11sm18637253wrv.14.2020.05.25.08.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:15:17 -0700 (PDT)
Date: Mon, 25 May 2020 17:15:15 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: uday kiran pichika <udaykiran.pichika@gmail.com>
Subject: Re: Adaptive Sync enabling in Xorg Modesetting driver
Message-ID: <20200525151515.GK206103@phenom.ffwll.local>
References: <CAGcx_0Yu4D6F2BiPp5CnJhMyrupGsnFnzEH0-Gv=8rFuVtDi+w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGcx_0Yu4D6F2BiPp5CnJhMyrupGsnFnzEH0-Gv=8rFuVtDi+w@mail.gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 25, 2020 at 07:01:21PM +0530, uday kiran pichika wrote:
> Hello,
> 
> Am working on enabling the Adaptive sync feature as part of the
> Xorg/Modesetting DDX driver by taking the reference of AMD DDX Driver
> (xf86-video-amdgpu). Below is the commit which i submitted.
> https://gitlab.freedesktop.org/pichika/xserver/-/commit/682565a645bda7371cc3731ee805cc4a0ace80db
> 
> 
> I have made the below changes to enable this feature
> 1. Enable Adaptive sync in Graphics Driver
> 2. Added Xorg.conf file with VariableRefresh property which is read in the
> Modesetting driver --> This is working fine.

-modesetting, even in latest git master branch doesn't have VRR support.

So yeah this wont work.
-Daniel

> 
> After taking the above changes, am observing that Adaptive sync is not
> working.
> 
> Below are my observations.
> 1. loader_dri3_helper.c  --> Adaptive sync property is being set once the
> system is booted successfully on one Window. Once
> set_adaptive_sync_property() method gets called, adaptive_sync_active flag
> is setting to true. From the next time, when fullscreen applications are
> loaded, this property never gets set on any window.
> 2. Once this property is being set, received a notification in modesetting
> ddx driver and read the property from the Stuff->window.
> 3. But when the fullscreen application(Either DOTA or Xonotic), not
> observing that this propety is not being set on any app window.
> 
> Can any one please help me why this property is not being set in the
> application windows ?
> 
> Thanks
> Uday Kiran

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
