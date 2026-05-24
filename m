Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5C7CD5BB1
	for <amd-gfx@archiver.kernel.org>; Sun, 24 May 2026 11:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D002210E11D;
	Sun, 24 May 2026 11:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YV+9Om6a";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D39A10E11D
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 May 2026 11:32:22 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so21578375e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 May 2026 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779622341; x=1780227141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sB9xgGrJZKURSlZrCf4F0dGYjJQvnBVfot6PTQUJHHk=;
 b=YV+9Om6aDgBhTPsUpdCs30qK+FureBc47zrDaryZXGeR7mbpcxm2HmB6UCftaERiEf
 2pAgVoZu00b1qMz4zdTKEMWNCucR9GbeBkAw7QuxBkWCjwwf0HJEMwU2ePVQRIZJ13ml
 35fbXxlxTUSDkZmjSlg0gjC+YvYxCES1vO0tIqRFCYFcOoU/vVwTNSSUUyNTQ4Pvw/rJ
 6PaSWnEj+Ic0seHnRwaf2dA1zREfEaTok0Lg8Rm39UkRIJItGLQQt7H6BHmetX6cGVNI
 O09jwU/PMyAjdnaPE1XFcebfugK0TPig3qqoN4mTVNzzVy5DgZHLMznmfVgQpdNAn+Gc
 0gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779622341; x=1780227141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sB9xgGrJZKURSlZrCf4F0dGYjJQvnBVfot6PTQUJHHk=;
 b=JH6yFd/YvZXYp99mW7B7dJk+CQaeUOBF2p5ZXj4S8ojc3bVkk8UB1wLnYhmBYclnSj
 /Q3mdZlKe52IPTGUDv7Q0vlifvzrrNPTkj4jpWF2DUexkdaMdoJ3Lqkyz/2HKzpmIS0U
 lcU/rapZm7Ci+f5E5yiOr+Dz+Rl8DjuFFft4zCkJncQUSa4a/NTIr63OoROT6ZdX3oA9
 V5uLyLobSwth4Vkb+noIs/0L8Z0RbiAJkYZl6cptCoT5lGH5PUUyNej4p0bdaXNiz0O0
 hDQ3klIGw636TLIPy7Fw2SUZQL9a4zHPUgiYFkr3Vd9HzrSCuiwM6NprJadmhNLp5PwY
 tURw==
X-Gm-Message-State: AOJu0Yx+EsGWjeE74ZOX5tQKWc9r3DlEQf7LI0ozPGzLdODfI950jYER
 OKhlJzP5yj5I/f16IYHPofq9ssqURrfTLB2UCMWalPxVOrQatSYtHhb094Xeag==
X-Gm-Gg: Acq92OGqY33XnmA5AjjVsII0Ujk8gla/X69PQ87eXPpO7sH31wgQPW99s45FiKbOA2x
 BKf8ujZ0mkJulhRWqmePqRPspFHydIcH6Zbw6/sVgsbHOe3QWAsrXEHRrlUamsiJarnAx+qEgaY
 7xr7z1F8LMCGqxGcyst1rWFJqJ+Q99sFnCbiSZ7sXqgZAPd1TwfcU5Rq6HG3UKg6RvjLDIrwC/V
 K/XBNMAXH3GyTxqL+2LKZbzV5uGT4W94I7ljpd32MhUwrSA2Ean7aiU6F2wzrxXEwfGeZToVcgQ
 o+IohMPxD5Zv7YYbemsz7/3qMllyBmOjpdYIpY+dg12zSvKxmsa56jWACsbnvjM7PYX9UrpHHe3
 sqy6YVq/iBhWLB7Gxv/sJZSmCB2Y2nrUS8M569BHzHvW7kyJgptbHE5ZhV2qbMj6I5p/Z+5mjQc
 jzQKat4eRPSWU5r0V9QEpP0RQLx+RJpiiR4MHHGr1uH1Xyc9bAFgxGeJixd6hvD5Lv2zwnGzWn0
 HpsUAUYEsq5lYO4/Eg=
X-Received: by 2002:a05:600c:5298:b0:48f:e230:1d12 with SMTP id
 5b1f17b1804b1-490428dd63emr175841625e9.31.1779622340816; 
 Sun, 24 May 2026 04:32:20 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428e5adcsm66823295e9.21.2026.05.24.04.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 04:32:20 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
Date: Sun, 24 May 2026 13:32:19 +0200
Message-ID: <3626507.sQuhbGJ8Bu@timur-hyperion>
In-Reply-To: <CAOGA6Hix7yPkF2o3hapz9zfpRZ5HHjaaJuDcyWjp+Aoihxf9-A@mail.gmail.com>
References: <20260519084158.72960-1-timur.kristof@gmail.com>
 <CAOGA6Hix7yPkF2o3hapz9zfpRZ5HHjaaJuDcyWjp+Aoihxf9-A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Hi Jeremy & Alex,

> Apologies for my late reply. I tested the patch series (SI laptop
> 1002:6606) and the problem remains where the clock speeds don't boost upon
> switching to AC. Timur and I investigated this and found 2 problems

Thanks for getting back to us on this topic.
At Alex's suggestion, I removed the clock recalculation and added the check to 
verify ATOM_PP_PLATFORM_CAP_HARDWAREDC. I'm sad to hear that this broke your 
patches. I apologize for that.

Unfortunately I don't have a SI laptop GPU to test this stuff, so there was no 
way for me to verify the correctness of those changes before I sent the 
patches to the mailing list.

> 1. It seems that it is necessary after all to recompute clock speeds when
> toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has no effect.
> Each ASIC family's apply_state_adjust_rules appears to be responsible for
> the switch by setting the max_limits, and this function is only called as
> part of computing clocks.

That's right. I took another look at:
si_apply_state_adjust_rules()
smu7_apply_state_adjust_rules()

Both of these rely on adev->pm.ac_power when determining max_limits, and they 
set the maximum clocks accordingly. We should indeed re-calculate these clocks 
on both SI and SMU7 when there is an AC/DC switch to make sure to apply the 
updated max_limits. Additionally I think we should probably lock the mutexes 
to ensure that we are sending only one message at a time.

My suggestion would be to call pm_compute_clocks() inside notify_ac_dc(), and 
also to lock the mutexes:
https://gitlab.freedesktop.org/Venemo/linux/-/commit/
e98279dff480cc297cbb1fe50c2b71ebd65b9576

if that works, I'd like to submit that patch (and will also port it to SMU7).

> I'm considering removing the .notify_ac_dc field
> from the IP block entirely and just calling .pm_compute_clocks from
> amdgpu_pm_acpi_event_handler, but I only know for certain that this works
> for my GPU.

I don't agree with that. amdgpu_dpm is generic between all supported HW 
generations and shouldn't contain HW generation specific code. Also, it clearly 
doesn't work the same way on every GPU generation, so we shouldn't generalize.

Furthermore, we should minimize the amount of messages we send to the SMU, so 
we shouldn't send the RunningOnAC message every time we recompute the clocks, 
only when it actually switches to AC.

> 2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for my GPU, causing
> PPSMC_MSG_RunningOnAC to never be sent. Either the flag is enabled
> erroneously, or we're interpreting its intended usage incorrectly.

It's hard to judge that without having access to the hardware or docs.
Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on your 
laptop? Isn't it enough to just re-compute the clocks?

Can you check what exactly is the value of adev->pm.dpm.platform_caps on your 
laptop? Maybe we are looking at the wrong flag, or maybe the HARDWAREDC flag 
only refers to the AC->DC transition and not the DC->AC transition.

This is just guesswork on my part, but maybe we should look at the 
SBIOSPOWERSOURCE flag instead, which is explained in pptable_v1_0.h:
/* This cap indicates whether power source notificaiton is done by SBIOS 
directly. */
Can you check if this flag is set on your laptop?

Thanks & best regards,
Timur



