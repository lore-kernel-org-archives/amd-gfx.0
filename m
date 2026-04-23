Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F3FF99358
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 08:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E36D10EFF5;
	Thu, 23 Apr 2026 08:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fdH78H62";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D86610E2F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 05:21:52 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-79ea87af213so102000697b3.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776921711; x=1777526511; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfHr6pcpD2C/ztclk7Kju/ZxhPOZZ1kn8hHu4T9x84w=;
 b=fdH78H62MjB3GTCKylogwI5IwgMbdKdHnfxpDDcxb3+EJYMcJ52bAbh7tSVTrNSvAv
 w/untBM+4H1Fr+eC5tI7AmyReVe2xODvoHCjUclLEVeggdhwup+4mfb3HoDasLJxrGId
 ELzAaDGGQPsN9EOcAzNfaE827Pex333uw6wGjxyMxPXqlVCMypmoReMr5jvGe3WehJVJ
 vzWAJ1xxchYRuJFAbaxqs2DVe4Uj1RNAi9zZ/Tg9QhByNhmPGbG0oGLqAWcKNlhqXHJ+
 jMhozfPL9w4osgcOAtQdDl5bRpZq6YRcvlJODyeHyqALaiKYkHXD5Fti8zC96FgU6tHK
 pYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776921711; x=1777526511;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfHr6pcpD2C/ztclk7Kju/ZxhPOZZ1kn8hHu4T9x84w=;
 b=C2VOQ0XFIi6EFPokUFh0WJ89EPMc5sP+MMFKU/ZWYsvlk8BXFvCpKHtnrCT5sJOVA8
 67EHquiDgBcCqojFfuU/TfZo+jadM/2AAsc1tEoddLxtiRtmOGYTaEcqMiLm3g4c2lsn
 4k3EzetzDDYi/eQVwniZXmmNeuQBqf27EMsTivYXC0eBTqXXkAC7UH4eS/TUYdJEDD2r
 WkYraRgll7OcD4rr8fhIz4OnIGfAjet5xVMhyukr2zY9AiacS60B9oCR3oQu4gDOjod6
 ylPaAplblAz1bqxQg54CfByMIewdGK6Hn2+tmsP1DaLvaDkomSe2EU1OnI9M9rltww+L
 zZjw==
X-Gm-Message-State: AOJu0YyAx6Ung2iBgZ6gqaRfcvN6Bni/IKqkD5ryslAmce/IIoU5wQlZ
 ah9cqXdV2LEOY/bjjBC7e8wWfJ61a8VvXAIKv6/TRqv6j55IxivHP3cz
X-Gm-Gg: AeBDievlbeG0+5/DXQVY/ZQEuVmBMRGjcHVINsWg+FTQx9ZZ2RjHSmLTNu1GO2RnnBW
 Je+mK/+B3JQozuckkKZh9+il1VECL1Iseh5WAcaTWWaLvgJ7TNAoO8yf98yQGpoZThmmVysRNcs
 RcBB1kfr7dP+Xesk8jjrXSbrIwkuK/8Lp0CxWM3ugpDNv9VlPHBsQ6DCYNjXDs0of9DZdKk4fxc
 XwyxoAPPKiyjiV5Zy55UAdAQGmDazVs3y/4ouagQ/BMdGnyyKxZSLROwBg+VdR3M4dxJSytjvWJ
 jUfrfL+KIq9hClDBE3Q/CUkcuvyGhOzHl/HCFyaFmQk1U0xTVdMS3VWLhJkwneaMAg6OOUaQr4N
 5MR1xLqtT6QXlIr6L9Ub1HHCPTxkf972F7PwspA5XIle7WqyeY3RaLDCCc0Qq26hOG9wiOQhqr3
 sCsGaaI3kei2YxGRGknGpk2O7OrSE8
X-Received: by 2002:a05:690c:288:b0:7b6:9a0e:8725 with SMTP id
 00721157ae682-7b9ed2ce182mr208110007b3.12.1776921711532; 
 Wed, 22 Apr 2026 22:21:51 -0700 (PDT)
Received: from localhost ([172.216.252.33]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7b9ee99bb09sm79486537b3.32.2026.04.22.22.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 22:21:50 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:21:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ray Wu <ray.wu@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Introduce power module on Linux
Message-ID: <aemsaAK-kuQ6fyl8@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:52:16 +0000
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

Hello Ray Wu,

Commit 4cef2ac4c795 ("drm/amd/display: Introduce power module on
Linux") from Feb 27, 2026 (linux-next), leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/modules/power/power.c:172 calc_psr_num_static_frames()
	warn: previously used 'vsync_rate_hz' as divisor (see line 163)

drivers/gpu/drm/amd/amdgpu/../display/modules/power/power.c
    158 static unsigned int calc_psr_num_static_frames(unsigned int vsync_rate_hz)
    159 {
    160         /* Calculate number of static frames before generating interrupt to
    161          * enter PSR.
    162          */
    163         unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
                                                             ^^^^^^^^^^^^^
vsync_rate_hz is used as a divisor here

    164 
    165         // Init fail safe of 2 frames static
    166         unsigned int num_frames_static = 2;
    167 
    168         /* Round up
    169          * Calculate number of frames such that at least 30 ms of time has
    170          * passed.
    171          */
--> 172         if (vsync_rate_hz != 0)
                    ^^^^^^^^^^^^^^^^^^
If it's zero then we already hit a divide by zero bug and crashed.

    173                 num_frames_static = (30000 / frame_time_microsec) + 1;
    174 
    175         return num_frames_static;
    176 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
