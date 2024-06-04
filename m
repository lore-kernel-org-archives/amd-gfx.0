Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9307C25B7E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 12:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 569E910E46A;
	Tue,  4 Jun 2024 12:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTqUAMYQ";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B4A10E45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 12:00:12 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-354f3f6c3b1so910320f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jun 2024 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717502410; x=1718107210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5yHGGXlC4HQC/0w40QPsIjKoWw8njft0NWcYLjA3EFk=;
 b=hTqUAMYQ+iLbd1wlB8et6m/2GI1s0+uw1mc/YgSTfoZAhcqpy+W+dtcNvlH7FqemRP
 klTPECTFwUOIfkClM0vu39bnM/mKgrIiIQIqLuOp2oBB2t0g1smqmlTAdb5IOklbUOV7
 Opjk7RpANGG62djNzoggIg7DgPsSDWtu8JhTRTEarFjT8z1qfYeu/YpGlVmKZRl4LW8S
 xfs7tMvCN7oPYEu2aePx7MgwmM0YUtJsv6JQPWMbo667mObvtYEWEwJw5R9Zr0TPeLWi
 c8enz7P88en3VwQdyFWKW08JKDAUd24+S82V4q16sYK4MGDdSI711fb9Gz547EgDgC40
 TT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717502410; x=1718107210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5yHGGXlC4HQC/0w40QPsIjKoWw8njft0NWcYLjA3EFk=;
 b=IAMYlocmQOLYuLY7ronwtx9YWWOPEfhGd7G0It52k/onY+gESi6UdwWI568s64MSvS
 Ms2LYCPFCVU+eynSyWoEom0ZySuWWoLDvUpv2JNqc4ZD/+cbOKagLjkDEFFdg2ZNY2cL
 0rbWXiqlhvxq6GH0Pa8xvVP0Wmkw4PpZ/RhT4iT8fvdYmPQyx73rTLDwOIqkv6xszrXi
 kdrN3tUXXaF9R1X4axz+2HWT3bPwdqW3ORgHlQ2FH2iH+23lqT5dR29B4miFHxyk1iJh
 i+iXcto+8k2JCz2ncbk9e4PpAgK1x8gb6p8CVDefgb/kWkS+Z/UK0A4SkiKOZQGMKsbd
 RR0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh7mfRCmbw8FREMzF/0b9dJcvd1XrpbyXJv0/6dCncQq607Mly4ztI1zvOaHeM3LYeoMdLnI0V+mi2QwWoGM6DmMUVcLkjgDkAFgq5Kg==
X-Gm-Message-State: AOJu0YzDC7nflmOJe2p2knVIo1AfTvccf4v95pNMZq8WDBYTlf+sp+Ms
 e1wu3U/gq+ju8eEUXkxxv0An5ObFXhufHYA2npk2Pbh23UVo44LQIWTEbsQ3
X-Google-Smtp-Source: AGHT+IH9DsAmShsNHJWWatqkKKToi4LLD/akKCFmC6LpzwdQJ5pNTLi3SykS/oJ7uP5G0wSuRDPWXQ==
X-Received: by 2002:a5d:6acd:0:b0:35c:a02a:97d3 with SMTP id
 ffacd0b85a97d-35e0f355d53mr8236918f8f.71.1717502410293; 
 Tue, 04 Jun 2024 05:00:10 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e574748ffsm6335898f8f.87.2024.06.04.05.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 05:00:09 -0700 (PDT)
Message-ID: <a490714c-564e-41c0-b0d2-f20b04f1e5dd@gmail.com>
Date: Tue, 4 Jun 2024 14:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix the overflowed constant warning for
 RREG32_SOC15()
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Tim.Huang@amd.com, jesse.zhang@amd.com, christian.koenig@amd.com
Cc: alexander.deucher@amd.com
References: <20240604070829.8872-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240604070829.8872-1-bob.zhou@amd.com>
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

Am 04.06.24 um 09:08 schrieb Bob Zhou:
> To fix potential overflowed constant warning reported by Coverity,
> modify the variables to uint32_t.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> index 0c8ef908d112..74999f29d0a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> @@ -119,7 +119,8 @@ static int imu_v12_0_load_microcode(struct amdgpu_device *adev)
>   
>   static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
>   {
> -	int i, imu_reg_val = 0;
> +	uint32_t imu_reg_val = 0;
> +	int i;
>   
>   	for (i = 0; i < adev->usec_timeout; i++) {
>   		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
> @@ -138,7 +139,7 @@ static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
>   
>   static void imu_v12_0_setup(struct amdgpu_device *adev)
>   {
> -	int imu_reg_val;
> +	uint32_t imu_reg_val;
>   
>   	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
>   	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
> @@ -157,7 +158,7 @@ static void imu_v12_0_setup(struct amdgpu_device *adev)
>   
>   static int imu_v12_0_start(struct amdgpu_device *adev)
>   {
> -	int imu_reg_val;
> +	uint32_t imu_reg_val;
>   
>   	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
>   	imu_reg_val &= 0xfffffffe;

