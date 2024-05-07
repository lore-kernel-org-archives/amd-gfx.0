Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A587C10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 14:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218F910FA1B;
	Tue,  7 May 2024 14:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HRESktVM";
	dkim-atps=neutral
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2499910FA1B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 14:36:24 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2e43c481b08so1590881fa.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 May 2024 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092582; x=1715697382; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W46Kt5yvQlfhtjiIgYjggG1nDCwThUkmABq3UaihB1c=;
 b=HRESktVMreONeZ7BQxDPPGZZ6yet2DrmcxTN12PAOh/FJX/DS9whasfvX7NhrzkXMw
 XrCmHytD8GIBXM/FdgVR1bLQDgkDVKoPz1ABkXfKQaNTeqIL8bHnh1SKWudmSsaAMCaO
 Bz+h4SsELtkClanBct1MHHkt8WegOfVURtI7TMrsSZU39pGP+XPxBFpc8+JzKiVfMjJQ
 jdQ/hT2KtLsVmmPZTykwKyElnIMvxqSFBqzZPS/y+9puKDES9U1Jq55xRPsGaM9vBTt5
 fiCc6Xgr8HonKx3kT3xHxGUul+M8Mha+PAMvwv3xUTj1lDK5vxlfQwRk3ZNcnUvntjPc
 3OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092582; x=1715697382;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W46Kt5yvQlfhtjiIgYjggG1nDCwThUkmABq3UaihB1c=;
 b=BjjAjVeeMv39k+W/rlyuFTXcH0X7dyS0PPlo0ylZsJUpGB1rBAfnXSdsNHS7F+kYhx
 EgHBSjPz4mCmcQJXpfw0CXsv/Enn27e9M+gVZ68DL/+eyOmt8P6J/gAXgXfbcSdQMSeP
 gIdiljwzWGaeZnZ8IFFWKyBmlpSt0X4/br/F1BeGZfxMmmqifQuQyUadjq/AnAE+rCER
 VYU0e+psrRK4we4DP+xaEF8OONahvA8fFKUD0AfE9c9VrtwzKf0gvHz6/bVWU/Rre7J7
 RA1gM2iKWbULddbaIGgqawNF4de4SXsXA/M8el32JfRK15UKsyKYy6fhvcgHIWbimyJd
 JbuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV91OhYMPao/Aej8czIpTZKZ0izFOpD9BefuYzOBMa6nkNyt+9xR31UcFg8q+kHT8l0VvBxMwYFgHNCPt+Ck4vDJiJh4IkpphHsmHBjUQ==
X-Gm-Message-State: AOJu0YxE71sTfu8cfmaookXsQLmySYXnMrAS4jXwRZ4HizEzCyH7EDaE
 lnnKzOjQKbkx6OEJm3J7h6L7z/PXu9LMg5YKJ3mwkDsVW0VNlVoRXJyiX1fBUY4=
X-Google-Smtp-Source: AGHT+IGKxhVmc5WDuZG7EwSJbTPcSCGzUEMYnRH99AthqRDNVlt54D+51cUwkFZpTtI1PoUNyGcm0w==
X-Received: by 2002:a2e:a555:0:b0:2de:3421:9edd with SMTP id
 e21-20020a2ea555000000b002de34219eddmr10229313ljn.33.1715092581990; 
 Tue, 07 May 2024 07:36:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
 by smtp.gmail.com with ESMTPSA id
 r20-20020a2eb614000000b002e0e3467465sm2053575ljn.12.2024.05.07.07.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:36:21 -0700 (PDT)
Date: Tue, 7 May 2024 17:36:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, inki.dae@samsung.com, sw0312.kim@samsung.com, 
 kyungmin.park@samsung.com, linux@armlinux.org.uk, krzk@kernel.org,
 alim.akhtar@samsung.com, 
 patrik.r.jakobsson@gmail.com, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, 
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, robdclark@gmail.com, 
 quic_abhinavk@quicinc.com, sean@poorly.run, marijn.suijten@somainline.org, 
 tomi.valkeinen@ideasonboard.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, 
 Xinhui.Pan@amd.com, thierry.reding@gmail.com, mperttunen@nvidia.com, 
 jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 09/11] drm/msm: Use fbdev client helpers
Message-ID: <pkjjp5x3stoow7omrvawbsxe6tc63q7zrl2djtjnjrs3azdva4@qrdgdwz6cwjb>
References: <20240507120422.25492-1-tzimmermann@suse.de>
 <20240507120422.25492-10-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507120422.25492-10-tzimmermann@suse.de>
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

On Tue, May 07, 2024 at 01:58:30PM +0200, Thomas Zimmermann wrote:
> Implement struct drm_client_funcs with the respective helpers and
> remove the custom code from the emulation. The generic helpers are
> equivalent in functionality.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/msm/msm_fbdev.c | 58 ++-------------------------------
>  1 file changed, 3 insertions(+), 55 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
