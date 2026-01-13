Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA788D2D0F9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 13:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E7D10E1C2;
	Tue, 13 Jan 2026 13:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jjkr9xJg";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EB710E1C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:17:46 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8bb6a27d407so734694585a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 05:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768310266; x=1768915066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q0yzFDQr4MVzbwYnCxDXUlBCDC8a1ozaF40EsWAGP5U=;
 b=jjkr9xJgEGyxWHjj/jDuHzu8gFxBVhUV/Oa7jciHOPA0HyABUXhdp0g5CMllgIjkXF
 oG0mjHIWkE85/vB507F9aEyASq1+OGsCBjAkx7j5sx9cKkD0JHaz7yGiplTlTYU8B+Sj
 P1N6FEd/v2ptcrcbswMeknk66USXJ/I8qtkSVn4k/RWi+NJBI0zSKzjCBmmelDOrWm5x
 Cf1eX6b5nCKS4ahy0vIGZDB8DtDiKG4xm4lGGyPtmRZ1EYpsRyFG7RDvFqEfFfTZFla0
 lw6p1sAeFT/ECYY+WLR7lV1uWymNQxiQ3xanckvm7+H1xWNSDO8+ctHvpZ6q0SkCXp5x
 v1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768310266; x=1768915066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q0yzFDQr4MVzbwYnCxDXUlBCDC8a1ozaF40EsWAGP5U=;
 b=Tt0mdtyimASLPxOwoXkD0Mx2EZ449n08Bb2uJ8QQrrd+09Z030EMUzCtsNUi478U99
 UwVJsSFsFF+58VWfbZPv3A0hDU/E8lJWHMViCbbvKJXeASCSxzr0TUDiO/czhfaYdJ0V
 ZCLh2RE8lBNN5ncWPBuQDhiktrBeGmoqvEc/2dxACSsgSDgvmfdMhFdAj3Nd9Dll8VUI
 LHP+ac3TdhQzxUskMGi7V+aewWpmnb7nTdGdX9DUokadUCBJip45cvMDaLS6ofdWIEJ3
 A0E3Y4rACwMHR3hNfoRSFDn37fVmrHkJ1sNqGJ/VcHOiMerD1HxpYzpTAoHdUORDWbJl
 8a7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtaFnDofAA+MAATK8faBiLiCglh9bNF/szb2IFWMh9tHnIBYtbZKg54vLXZpPXxWux1ZBLeIGD@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywx8TzNQ6UKKfnfeRwQQe6wOdV06/mnZ+eT44LQQnq1aQ17TfY0
 alH2+AXyD5hKHL8M6M5FQPb/W85ukeuLb/XKdP8vWJMYaalWPurm5xOp
X-Gm-Gg: AY/fxX5ouRdkITrqNF9LL7av8Y8R6kYOGAM0BCTWRV7Zgr8S546ms187WpErk9xX37z
 +SJzS6+drk2zdiEzDHU16A+jEEmbZ+sEtpZ+rcu1G4pq7vXuvyxrS3dO8q09Ku9Uy6Geb3vYPei
 umjpvu+kMOq6eknlSYseIrAeRBft6Av+6brdwWb0mPLDw7JmwksRJ9c7/1qqWjcuH4uFrC+bbqV
 IsR1K4Xy2s1ftkKm0GXcWj3UxUgi2TXsU2KGqift6RKYHgfR59w97z08nSGNkHe5oTJYRI0w6v+
 0mo0CG/eop2NoicbnFB78qGZA8chtoCEKiUkDJPjWwdAsC6/++qOaUw2dkpPnkg2s6aefGTwBzP
 906+BUIjkqJs5/VCu8LFCV6grFj7VHNCh0BHD6eF+AUei7sXTVCsSrQ938kiEsUx+fLvaGoz+3g
 ydi2GBbq1IIh7IlqTaxpNyx2+0SYtUA5MT4z2owQeC0iA=
X-Google-Smtp-Source: AGHT+IGvA7Xdrkatn1fPD0vZcJIlJIjzrJXB6Pu1NM+ZqjDenAkRO77iYso7WVXblV1ZytyNGUnSIg==
X-Received: by 2002:a05:620a:3188:b0:8b2:7754:f492 with SMTP id
 af79cd13be357-8c38940cfa7mr2876416085a.81.1768310265723; 
 Tue, 13 Jan 2026 05:17:45 -0800 (PST)
Received: from [10.254.120.192] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770d2cf5sm157085306d6.1.2026.01.13.05.17.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Jan 2026 05:17:45 -0800 (PST)
Message-ID: <08a6057a-7e95-4007-a4ee-ec8f6e3e5540@gmail.com>
Date: Tue, 13 Jan 2026 14:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/42] drm/amdgpu: don't call drm_sched_stop/start() in
 asic reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Philipp Stanner <phasta@kernel.org>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-30-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260108144843.493816-30-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 1/8/26 15:48, Alex Deucher wrote:
> We only want to stop the work queues, not mess with the
> pending list so just stop the work queues.

Oh, yes please! I can't remember how long we have worked towards that.

But we also need to change the return code so that the scheduler now re-inserts the job into the pending list.

Adding Philip on CC to double check what I say above.

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 80572f71ff627..868ab5314c0d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6301,7 +6301,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  			if (!amdgpu_ring_sched_ready(ring))
>  				continue;
>  
> -			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
> +			drm_sched_wqueue_stop(&ring->sched);
>  
>  			if (need_emergency_restart)
>  				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
> @@ -6385,7 +6385,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
>  			if (!amdgpu_ring_sched_ready(ring))
>  				continue;
>  
> -			drm_sched_start(&ring->sched, 0);
> +			drm_sched_wqueue_start(&ring->sched);
>  		}
>  
>  		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)

