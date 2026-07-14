Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE5FC4450A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 18:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BFA10E043;
	Tue, 14 Jul 2026 18:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="nApFKPYg";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CB310E043
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 18:55:30 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so2604035f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784055328; x=1784660128; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1tn7FFKb0rW6RKdXdTjfKXXWEBXKendKrtkjL19C8/g=;
 b=nApFKPYg96V3JnROzyYEFCZFPEzA1Y5jEaUq3Ix1Y+DBCQhY89bVPc4BExvdkYuZkJ
 dPCMzATC6YxnAeqiyg92XtilOz8Ls8pVHuj7CeQHCuaewSyDX/hOoSXkeA76rFvctzzl
 xYh7ImkiMEHEYvfsOS4iPDQ7NDvJNWAxW09MsHxtumMBLWb6l7sMElpPQdGEwi4j4R6p
 yL5IGa05p5JIkWmg3dIhG0MlQtwE1LWPowTr6DIqyYeCk/ddQRFShRlnNV8kqtHslN7f
 0XGrI1hPEf/M2qpywUzrGa2IPShuYlFNFZs+zTuF1Y/3PTtzYDu6s6YYFVO80LvnC3C8
 R2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784055328; x=1784660128;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1tn7FFKb0rW6RKdXdTjfKXXWEBXKendKrtkjL19C8/g=;
 b=UPOVh5AW+V+3SzIq0Ebck1VbrmcD2wES/kC7sCQUlQ0wC5bONJZK8TqcHmib9WKdnT
 1xeSYGOYndu+VUt2O6gkrB4MHKpT0LSxRMn8ypjKm1QkQvDcCA7OH904VTt8cfm+npDi
 wmdDoqcyroGYoPDiXbJQwfMvWaXQ7Cu8Reluft+oJxKQE06EBmnjEUCs9Rn+rxmJFrft
 Yv6z7QongF3zmetzU39gPmtUr5VfGZNgjO9OrLHkMcI1W+rYstLZDayMClye5f4fUZ2Y
 xzdo/Mzc/q/J+sIEM6rPeaNtUaI8y8eoHMfYQumqwDoVn/SvZoHthavqYoAzFVNVQUDD
 BL/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUiYTE5c0JcWvsfg2DETu1P0sC5B2HoFpcpVmLx1Ow6l7DqRnH8CvHnknKmujCMyw5J4az7az2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+xDSayYSkwDvqpglXYeiEawhkoqxRX80oFmMkGAm/11M0HztC
 xa9oIFai+T4WtHDVWO2OCn0vRo8Gi5x7tnDhnZjN0+z78pIX9MKJ8s0inrjDi5jiyy0=
X-Gm-Gg: AfdE7ckt7G/iDzAl+PVoxOTSdCDxEJ34hw0qLEW+4S9JsPQo65v57MF+lkiI5A844cW
 HWGZGXvW5WWa1aF3NmTblpTvV3N42wcIO6IgTvzNJtD/ag+tr/72OLIqblvh7wDWSkZkxzWIsD7
 Xqj1DYpM4gI7Xbk2spWMaNgC0o4K8ZzoioDawd0wPVy5BZH3Jk9npOvulj53VuJE5QCKKVjdZrZ
 YfD5nPnrG9J9waIDvgw9GEWkqNy+ykp+cfmHmWW5+QxCoTNHSzLp7yi8u7Emwf9KTzL0C9AM/Wn
 1++MVdpPelMrGUoaQBr2vyykY7JoVgayY0OgfNAOb1VDFOgDyCiINEuOgBqBCUcoCgdj+i463aY
 9i87g9GYiChcS+63Y/qbbIpRaurFThdoN1Q9DHnJ+ntVxU0aadRsrjgCSMEZs/XSU4jsxAcfBYj
 re8RhNLpaNO6MWlaQgP9qdc9yct5HNozpAVg==
X-Received: by 2002:a05:6000:4301:b0:477:6874:542c with SMTP id
 ffacd0b85a97d-47f4887d7e9mr4558237f8f.22.1784055328527; 
 Tue, 14 Jul 2026 11:55:28 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a974csm12126348f8f.18.2026.07.14.11.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 11:55:28 -0700 (PDT)
Message-ID: <2c920253-9bbc-4057-b5e0-15414220a52b@ursulin.net>
Date: Tue, 14 Jul 2026 19:55:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu/gfx7: Return error code when compute ring
 tests fail
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-4-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260713125838.30607-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 13/07/2026 13:58, Timur Kristóf wrote:
> The gfx_v7_0_cp_compute_resume() function should only return
> success when all compute rings are actually functional.
> This will be especially important for soft reset which needs
> this to know whether the reset was successful.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 9c4b3ac27e1f..a1a9f3fc4567 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3019,12 +3019,14 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
>   
>   	gfx_v7_0_cp_compute_enable(adev, true);
>   
> +	r = 0;
> +
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   		ring = &adev->gfx.compute_ring[i];
> -		amdgpu_ring_test_helper(ring);
> +		r |= amdgpu_ring_test_helper(ring);
>   	}
>   
> -	return 0;
> +	return r;
>   }
>   
>   static void gfx_v7_0_cp_enable(struct amdgpu_device *adev, bool enable)

Gfx8 and 9 (did not look further) do not do it like that. Should they? 
Or there is more work there to be done first?

I actually might like this because maybe it gets us closer to removing 
the ring->sched.ready hack but what I am just not sure if the idea was 
to allow driver to function with some non-functional rings after resume. 
Under the premise that if they initialized during init, then after 
resume they must too, or if they don't, it is a transient glitch. I 
don't know.. I am being imaginative here thinking about silly driver 
workarounds for weird hardware glitches. It is much more likely this was 
just an oversight and it is completely fine to to error out.

I have to defer to Alex and Christian on this one.

Regards,

Tvrtko

