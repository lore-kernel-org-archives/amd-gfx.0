Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD71C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 14:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9BF10E0E2;
	Wed, 20 Dec 2023 14:07:43 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6E110E0E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 14:07:42 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c60dfa5bfso66811935e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703081261; x=1703686061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U8G8v++S6GEhPE/ZDM2TQCDdV167QVMuiv+qcpYERSk=;
 b=IKw8bwm0ynphJU7VJY2fFkMok5iF7HLV4ioAGBlfB+hkPX398Xp+4FLkES5Ip8Jz9Q
 eI4IpK3ax7FQBfv63SFxvnPfitEXaRK2JTyetJH4W6wQn9V+JSSO5QxNwrLhESJ9b4AS
 QUpXaOcDO5lLy1g2tnhIHEkbU5hiWFQTq6cNFHcJaDWHGbdJMIDV6ncQAGJf42xaM03H
 YEDORKud3IJjNIe95f8VgBZsAcj49FHIMCo4L1Tp4iMOT/+nSmcCbtsRSrk13bMBAU6t
 5RPTZTuFOxFIQLvOA/wJ3ViRKRloKixyg004K9IrLjhbhlRrJdzmsNYHPlu0uHN1Hqcz
 wV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703081261; x=1703686061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U8G8v++S6GEhPE/ZDM2TQCDdV167QVMuiv+qcpYERSk=;
 b=E7QGZ8zc1CGY2IlY9Co1IY9xcfU7ss/i11Jd8+aU7of04v+dfNZUWZR7gUwDeDH4jq
 eWJUCJSRX2ch9IEQ1mcnezpVgAlBPkjHMYTv+TtXu/ebyPH+Y1gfBcHjDCTelk4Be16x
 sMWDovLajSH/z0ZpzqqaS6EO8qq1J0hVbjrS5CKhSxybRRUOuZD0Kf2MQS/kQsDUrJL3
 h+LfVLKGEk0PZ/FnbBdfPsj2kz/l08TeAC/64e+SGPvGP6U6tbcooxRsljM2HNvJvKoz
 0veZS51kvX6qZcGtzyR+wmhxxvbYN6wNt8jZ0dWn4HDJziRgmdHkpU3gKoE42+kePEz/
 y9MQ==
X-Gm-Message-State: AOJu0Yw7PluunZD0eoitcraWkIFAtNaCu/EjiDIhe1nYsYZmsFaCP4BD
 D9Szam7eKPHv0NjBKr+YwSuFsR+15Ic=
X-Google-Smtp-Source: AGHT+IGWLi6mVZJIbIGHM5wMddNAnr9VWwP5qeiu5NE1dzs6Ao1v5pXF5n50msCDqy4e/olxBqMfsw==
X-Received: by 2002:a05:600c:458b:b0:40d:3a7e:a4ef with SMTP id
 r11-20020a05600c458b00b0040d3a7ea4efmr132353wmo.32.1703081260567; 
 Wed, 20 Dec 2023 06:07:40 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a05600c4f4100b0040c03c3289bsm7374405wmq.37.2023.12.20.06.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 06:07:39 -0800 (PST)
Message-ID: <f2cf8fbb-3057-40e0-a823-b8bd95b9348d@gmail.com>
Date: Wed, 20 Dec 2023 15:07:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Cleanup indenting in
 amdgpu_connector_dvi_detect()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231219133807.542179-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231219133807.542179-1-srinivasan.shanmugam@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.12.23 um 14:38 schrieb Srinivasan Shanmugam:
> drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1106 amdgpu_connector_dvi_detect() warn: inconsistent indenting
>
> 'Fixes: 760817a60724 ("drm/amdgpu: Refactor
> 'amdgpu_connector_dvi_detect' in amdgpu_connectors.c")'
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index 96f63fd39b9e..9caba10315a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -1103,7 +1103,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
>   			 * DDC line.  The latter is more complex because with DVI<->HDMI adapters
>   			 * you don't really know what's connected to which port as both are digital.
>   			 */
> -			 amdgpu_connector_shared_ddc(&ret, connector, amdgpu_connector);
> +			amdgpu_connector_shared_ddc(&ret, connector, amdgpu_connector);
>   		}
>   	}
>   

