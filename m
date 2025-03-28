Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E09C3DA4A
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Mar 2025 15:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A90E10E280;
	Sun, 30 Mar 2025 15:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xndxv0cF";
	dkim-atps=neutral
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com
 [209.85.166.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C7410EAC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 22:46:03 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id
 ca18e2360f4ac-85e751cffbeso214446139f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1743201962; x=1743806762;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nqtWjpKQl0+Rceovy2PPRz2bVefezStJEzDQIoyhN5w=;
 b=Xndxv0cFbH0XI/1LsTpIQBsc+b0ocU/ULKIco9UoFMaj+tAJUOp/HyPfb38EYjPZCu
 8Rd8IBcoHLgP8YexImNE+f755/uy4OwJRkhU/jBLkptMcyDNDM5fsEJyEWDoh1MYXstc
 zwviKqUFIRoJ3w1N0LcPa5X8qNLOkIR+ClCLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743201962; x=1743806762;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nqtWjpKQl0+Rceovy2PPRz2bVefezStJEzDQIoyhN5w=;
 b=hDIdW/lLnA7gslNr4woGN1UOURXbBDVIp0Qw/DWTvGYZh0JH2f589dtfvfxHc3Pd7H
 FGPXkbRSXtQJxMcPoqqj9GWRV77tu3mo/etdax9wf+vAMhEeiDg5uqTXH/jzro9VBcLC
 d64En/bmj/0jGU8uOeq8aTeTiAhBdSiZDKKaMcjpoMYa15RaBryUu2r6Qy86YzZeE4gL
 acfN1LFKE6p/CcJEJ/DNgdc6HkR0EIVo/rEBfPuTzx9qV3Mivk6Hbe9Lsd8Z0qAg3tRZ
 RHMYcEuwCxlwicMFTu+nO8POI8F6VAF4hsZZR1Hhu5AvcG7sgJlME7/dV3iZovHTrlY5
 4jqw==
X-Gm-Message-State: AOJu0Yw4+1oON4JG653cep04Sm56EIwqeF8G8GlgLP/PY0QIyOoPCdub
 Yvbli0Js69+8100dowYWm2bH9Mvx0yiCxCPD0zM1mxIFTTqrlnSlZWvd/z5T5vY=
X-Gm-Gg: ASbGncsTRHIGSl/DLnGm1/oZw+vnDZop5hyXH/ou5xcMamZpzD2Qhj+TrDhuaak/LBd
 6SMOkg9stlVezq9VtnLCmolPr3wo6a3wfHzlf6YBtIWUuvsaMmYN3X3jW5pyyGHXk2R2oKnocDp
 7F1NYY7lWKokogJIXX/Awokm+v86T6CbniFQAdTXR5CgP5RC21gHqWrBAeAIlWqh3zTOMkwemNZ
 mgafPDMBwSF42lA2x2DF0Kb+/l2dPy50WShjW9UzWlv0gTUMvRrBq2j/GBjWSlE37qqnGTQlBF9
 8T6wCmPSNj5kLkJA37q2v/1I81Yhr8iHFciq6FG9f/pVSh0n9770NkU=
X-Google-Smtp-Source: AGHT+IE8B0Y4+x7cusSExDaFtRYAJ4UtV2GfOT2Knpe2lYH3tt4pvG6kA/VEZg8rg2BDCxRFPuU0xw==
X-Received: by 2002:a05:6e02:1707:b0:3d2:b4ea:5f42 with SMTP id
 e9e14a558f8ab-3d5e0905e33mr16223855ab.6.1743201962227; 
 Fri, 28 Mar 2025 15:46:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d5d5a6ce5fsm6852735ab.27.2025.03.28.15.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 15:46:01 -0700 (PDT)
Message-ID: <476c5bb9-79c5-40b7-bba8-b52fb244e90e@linuxfoundation.org>
Date: Fri, 28 Mar 2025 16:46:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: replace use of msleep(<20) with
 usleep_range for better accuracy
To: James Flowers <bold.zone2373@fastmail.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 aurabindo.pillai@amd.com, alex.hung@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250326070054.68355-1-bold.zone2373@fastmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250326070054.68355-1-bold.zone2373@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 30 Mar 2025 15:24:12 +0000
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

On 3/26/25 01:00, James Flowers wrote:
> msleep < 20ms will often sleep for ~20ms (according to Documentation/timers/timers-howto.rst).

Can you elaborate and explain why this change is necessary?

> 
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 2cd35392e2da..2d225735602b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -682,7 +682,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
>   		if (rc_cmd == cmd)
>   			// active is 0
>   			break;
> -		msleep(10);
> +		usleep_range(10000, 10200);
>   	}
>   
>   	// read rc result

thanks,
-- Shuah
