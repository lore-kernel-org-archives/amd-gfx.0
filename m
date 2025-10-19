Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988F0CCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 12:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C334B10E447;
	Mon, 20 Oct 2025 12:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="ihejohlP";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29BF10E0B8
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Oct 2025 22:26:00 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7810289cd4bso3589766b3a.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Oct 2025 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kerneltoast.com; s=google; t=1760912760; x=1761517560;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uv41vgSJLP43sgKhN7DoQwM7mlB7y3Fi88CvidK103c=;
 b=ihejohlPh1siAN7j6RERxpUCui4cEsc7Z8UBE56Qa38uNlZAGGP/BHqMZzPULoBFfX
 vR4/LOrSMX2j+2nBocbDuut7RCZRDMOOWCevFhmkKJQDeymK6xNV9mHGDtSqlw016ILu
 mKa+1gqF4rzQ2xOSv2Ja3sY+twY5wXj/pFF3xLRfOeKodys7OBiyNaATlFHQSQAYP/o/
 cIaK8GyJHImkdzHgm0UxYXo9UKdH3JG7PSonAJ5uH0UN2M+/wwGEBuPoM8qrOYKc4DNZ
 DHfJ3L9dOR8jnqJajnezeaFvk3hfK76UGjvoIoHrXWrkToZrqlnCjP6AwTtogFFQKWNb
 pU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760912760; x=1761517560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uv41vgSJLP43sgKhN7DoQwM7mlB7y3Fi88CvidK103c=;
 b=ruTuK9dvQ4bmQd65g7iKW5sYWavWjKD5uLpGlusfwplpi5NjahSjZb/QOUhi54f5ci
 63D4MLr/dJbzK2xjV9fyHvkYICFdJRqaeL/25YFCNrj1pyiIsoz+H1I+eMkvjGPtFlYN
 c/oHYB1En9y51zN128Y1IMxUfsBZu8i4tPW+pYbjXL6hqre1B5tu8x0fxLVqXrBI2ybF
 hUBa0OadQ9tThaQINZoCySFuaLrbMzxZ/ryghNFYfilJQ/OvjMst19iTclo4F92rfqo/
 wzf7V4HUXZU0l8bQ7x8BT75NfEuENC81jPnos80rlvT+xi40J+7zGLM9oV6+Bbg0irjj
 namw==
X-Gm-Message-State: AOJu0YwF3NKump1Uz8d+P2y7f9GnY4kq43nlF3EPhBYWB4ywm7juYJ14
 yqOhUtIZYmf/i4Y2E9sH1HzPY5JcVB6ysTFNqN7Ux5BAg4hCvAT4Q0UtnM3lDEawnnD0
X-Gm-Gg: ASbGncszAQQtmCehVrF7iqsKDbtOmtNwpsYezrzU5ZRwyjBIPm300zsUpTatHPNJY9J
 IPK2+wI0fv3+ugyBPlcH6wSNRmBf4FWvRdGEu2xxH73VEKY+X275vuEOTi+VdEf3/1rwBvqzrPW
 STwYGkO9hVAeenVL7BaFNnUQDDHmjTRMwb6gc4//mQBgrH5RgLhVF7ftjmDUdyb8QU1l0HrQc7W
 7itUyCOgYytYezU6+iUjVZz/aLVFnvvcy0RHFyqOvOkw2CY5vwMMU/tQBOPIAU8mtX4oDVL+GPc
 +HeE8NpQ8VKmIkYEIWP/1QmIlbpVSOCfDo5S/6ge91l9LRgAOPxWo9OAL+5DjTEZe3lfBg/uGdF
 5Euc2RU07iiXvXfCgFk7WYu/htF3yPB912QVpw0z/nECPA1cMyqg54VCk8kfb2h1bmY1qILYyt/
 T6WjAcOHimJxtgJ6bH
X-Google-Smtp-Source: AGHT+IFJuk2ZCLGZhy0cs3Fm86XhHCYKz+z+bKNo05j2vpm4Ye/1r7pWKEnntdD7ga21S/ysz3Ei8Q==
X-Received: by 2002:aa7:888e:0:b0:780:f6db:b1bd with SMTP id
 d2e1a72fcca58-7a220a43782mr13999850b3a.4.1760912760017; 
 Sun, 19 Oct 2025 15:26:00 -0700 (PDT)
Received: from sultan-box ([2607:fb90:a581:dbd:7adf:1ae2:91ed:6c74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff34e7fsm6430391b3a.30.2025.10.19.15.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 15:25:59 -0700 (PDT)
Date: Sun, 19 Oct 2025 15:25:57 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Peyton.Lee@amd.com
Subject: Re: [PATCH v5] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Message-ID: <aPVldXCcgipLn6Dg@sultan-box>
References: <20251016185527.1796606-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016185527.1796606-1-mario.limonciello@amd.com>
X-Mailman-Approved-At: Mon, 20 Oct 2025 12:48:40 +0000
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

On Thu, Oct 16, 2025 at 01:55:27PM -0500, Mario Limonciello wrote:
> [Why]
> Newer VPE microcode has functionality that will decrease DPM level
> only when a workload has run for 2 or more seconds.  If VPE is turned
> off before this DPM decrease and the PMFW doesn't reset it when
> power gating VPE, the SOC can get stuck with a higher DPM level.
> 
> This can happen from amdgpu's ring buffer test because it's a short
> quick workload for VPE and VPE is turned off after 1s.
> 
> [How]
> In idle handler besides checking fences are drained check PMFW version
> to determine if it will reset DPM when power gating VPE.  If PMFW will
> not do this, then check VPE DPM level. If it is not DPM0 reschedule
> delayed work again until it is.
> 
> Cc: Peyton.Lee@amd.com
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-and-tested-by: Sultan Alsawaf <sultan@kerneltoast.com>

Thanks again for fixing this.

Sultan
