Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E855DC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 10:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632EA64E6F
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 10:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632EA64E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3B36EAC7;
	Tue,  9 Feb 2021 10:23:18 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4996EAC7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Feb 2021 10:23:18 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id 7so20997941wrz.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Feb 2021 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8ruksgeR7S7IxfRPp/AabdJUyLlp9XKych0sXSQ/dfY=;
 b=O/Zj2LQHClvVs1hdqFJkLDpgyfl16W4D7gsuUrwMrRBkzYucXjQeukXLvH4+HVoxt8
 tmzrEjxstFhU4MyiubRIqnbiZxf99sFCqYQ11TE1uWLK/1Zd/m5pugtTIa3YBZbffaR7
 o4RTqUuD7RZCwbqVwulH1QZ73uhmLtgLEychQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8ruksgeR7S7IxfRPp/AabdJUyLlp9XKych0sXSQ/dfY=;
 b=WBCoFTU3E15qiQ+QHCTARXg7RXlL7ucak4SoQYpl/mTRLTgc/Ce6M0FZmeuA1QiBUh
 yHCbsftnQJZn86i6SNQfXPbOeBewoXexo/RWxqpCWSO6B9lDP5WIq4L7m6m3zKqlpZRw
 EKSWBs5tmYRv3+FDgRhIkSb1S14TISRzMEnB0tnGpkypn3m33pXgMwWyn0GXGz/DlWpW
 FH84/C4ZTomyBghedDfAFsw5VUGzNiRBmtLP3OsLiSD/WQDuA4ku+kBoJ5nsnGZyU37z
 bETjD4LqKynDpNeufo5e23RNiVlO90/N82gAV5/Urc/EO0aZvBX6MshcQd0BBeQxufCo
 9p6Q==
X-Gm-Message-State: AOAM532R1mpikAy0AtMOPqFNxN3EbxocKAtLNiTUUXoU1T246Yk3ooWs
 HVJl3N5d5u7UQZDQZ5Mtk7FG4w==
X-Google-Smtp-Source: ABdhPJwEDHTkqfjU0Fr24VJFs+mqwcChGFKVJQq4Ivn90chCVUglbsaugH58kd3qjr+vs01P6tzVYw==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr7701350wrq.51.1612866196812; 
 Tue, 09 Feb 2021 02:23:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u206sm3835237wme.12.2021.02.09.02.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 02:23:16 -0800 (PST)
Date: Tue, 9 Feb 2021 11:23:14 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/4] drm/gma500: Remove in_atomic() usage.
Message-ID: <YCJikjv/jmXdxgeC@phenom.ffwll.local>
References: <20210208233119.391103-1-bigeasy@linutronix.de>
 <20210208233119.391103-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208233119.391103-2-bigeasy@linutronix.de>
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 09, 2021 at 12:31:16AM +0100, Sebastian Andrzej Siewior wrote:
> The driver is using msleep() if it is safe to use based on in_atomic().
> This is not needed this macro is only used from
> i2c_algorithm::master_xfer() which is always invoked from preemptible
> context.
> 
> Remove in_atomic() because it is superfluous. Remove wait_for_atomic()
> because it has no users.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/gma500/intel_gmbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma500/intel_gmbus.c
> index 370bd6451bd9b..eb0924473a218 100644
> --- a/drivers/gpu/drm/gma500/intel_gmbus.c
> +++ b/drivers/gpu/drm/gma500/intel_gmbus.c
> @@ -44,13 +44,13 @@
>  			ret__ = -ETIMEDOUT;				\
>  			break;						\
>  		}							\
> -		if (W && !(in_atomic() || in_dbg_master())) msleep(W);	\
> +		if (W && !(in_dbg_master()))				\
> +			msleep(W);					\
>  	}								\
>  	ret__;								\
>  })
>  
>  #define wait_for(COND, MS) _wait_for(COND, MS, 1)
> -#define wait_for_atomic(COND, MS) _wait_for(COND, MS, 0)
>  
>  #define GMBUS_REG_READ(reg) ioread32(dev_priv->gmbus_reg + (reg))
>  #define GMBUS_REG_WRITE(reg, val) iowrite32((val), dev_priv->gmbus_reg + (reg))
> -- 
> 2.30.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
