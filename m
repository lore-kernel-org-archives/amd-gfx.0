Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F690C5321D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 07:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7585310E897;
	Wed, 21 Aug 2024 07:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zCgNrYRI";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD5F10E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 14:49:01 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so964746166b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165340; x=1724770140; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2YaLZ+0V3VWfcae/qqnaZyv35zNsNu2JTJUshy4c9tU=;
 b=zCgNrYRIYmjo5k1pULuuu53nh09Ch5ZC3mlrpt1Pv+8M65zxYsKimmktCs7eeSZ9XC
 3DBkoUHvElvZqJgbwASF/R2UmjSlWkBUHID/s5kAfLWxxpC4Z89JR9MhfmIz4LP7O+ym
 GBn8WgzycdhlTFe/ZgHDdDRzTSutBoFCntPgYERlxZK4pSd4wwQc/fzTDkgNT3/zdb6B
 o8Fu+aMsSJ6fgBEiGvbs7uTjAFLaObSCCMyTc5adgcjbZaRBnlmO9RqC1EX0/Jcr5vYD
 yLzyuq3PtwjZQZez3JR23foiJoceYnODeiwydFuZ2avFAxJPmifK4rPqiNmN1Lxd3dh6
 dF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165340; x=1724770140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YaLZ+0V3VWfcae/qqnaZyv35zNsNu2JTJUshy4c9tU=;
 b=sFs4Q7Yy9f/UKpEHjvn8w4h6Ztk89D+VrnEtOc8li4BY7fTQDzapA1dvZ76VCEjwmx
 SZ25HtwYJQ0hTrayD1hh8E7BOmjzx/iQLxkxmHuMCrahTBzHseHcXntJPr5Fjo5A24Hv
 WesG8XlXMg6vd0LLVgEpn+c8vd/X2wUzTtSC4gYO8PrwAlvfTeux4QtBMpmNTYlbMZPu
 8V+8ND2wzHiItHvmqk3EShpeoX1M2aTU5OMmTheUfz4iqz/WdAZPlS0lnCZ2Cbx4Slh4
 U9Uu2Qi5yuTWaCMeogQgWUS2S/nXhxUNpUP91byiwswB3vmC9ZFrgHZXvFhA9qJ+99TE
 +R0w==
X-Gm-Message-State: AOJu0YwZbhEWg8yrH/WmRhYzvoZRhcfvSeJ7Ny6n6kt9VBV/uPSzZFSE
 v+MSrsYs0k/lJFVLN9C52BjyGqBhVuJ82EACYh9H+uTYeqB05B7uh9xiVWmAGE0=
X-Google-Smtp-Source: AGHT+IFMONhHLM2+mq8E7LcD5cDuQG95OSK7Bj9m5/lBOEhwVUrwJH6L1U6/5gFtHeUe2P0Agvz4mw==
X-Received: by 2002:a17:906:c111:b0:a6f:e7a0:91cf with SMTP id
 a640c23a62f3a-a8643ffb8e5mr316017066b.24.1724165339790; 
 Tue, 20 Aug 2024 07:48:59 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbdfad42sm6908628a12.47.2024.08.20.07.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:48:59 -0700 (PDT)
Date: Tue, 20 Aug 2024 17:48:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/gfx11: move the gfx mutex into the caller
Message-ID: <49c41696-bdb7-41b6-8f72-c06bc434a145@stanley.mountain>
References: <20240820143909.1933483-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820143909.1933483-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Wed, 21 Aug 2024 07:16:18 +0000
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

On Tue, Aug 20, 2024 at 10:39:09AM -0400, Alex Deucher wrote:
> Otherwise we can fail to drop the software mutex when
> we fail to take the hardware mutex.
> 
> Fixes: 76acba7b7f12 ("drm/amdgpu/gfx11: add a mutex for the gfx semaphore")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thanks so much!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

