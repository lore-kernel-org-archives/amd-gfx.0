Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5372E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 06:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED0B10E05E;
	Fri,  3 Jan 2025 06:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ifTIDVvp";
	dkim-atps=neutral
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3BD510E05E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 05:59:59 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3003d7ca01cso128265671fa.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2025 21:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735883938; x=1736488738; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sFlWSYAVuSson+OhthOc5MObp0JO2PaKlR/7cwxtKLk=;
 b=ifTIDVvp+XMVoyeegJeVQV0+0y1mmro+GYtQGBXh246TeQ3aUku53kOayUE998iZ8X
 bHZZNzucwrgSKTkOCLFCtNeR8gopJlDiFq/+HavKczF7HkAsGW597Yqu+Mr70pqdxIw6
 Hld935sfF4UqfoXwvS6B4WynHXAU4PP6QAPDMG6Rntr953DzqzePKBGPfkGw8fr3Xlhm
 rqJcgqIegkkRQGaxKIf/IkNCxEQ9Ys6eLdppatfR99lM1aAlLd2j80gd5yjpNd3Ajg0S
 f+XqZRwnGM23P3x42UPpkMDTCiNGYotiEG2EpoMexZoilQ2+TYAHnbp6VW10elZLwDmB
 kyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735883938; x=1736488738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFlWSYAVuSson+OhthOc5MObp0JO2PaKlR/7cwxtKLk=;
 b=QbYU3Kt+H08PrdrDh5T1xulTgKz0e+opoHoqQ/c8UEBtYER4LpMOyUBrg6UFAT9bHL
 LeWEQUJPFkYYAXZ7KTrX15his/lry9NkuygjkU6jQZUpv5EqxKmcuEoziQ6Jd9WAJfsP
 b2/30giIYTLNVsQeeznhiR+FPxJOPaa4BQ7ToOkOpidGIy2o2xfqIjyaS7ZI1Di60W9U
 PBr4vdb5OVLER4iOabjIGhRzvwyBQO5Q6VAEKIRgGiNamFx138ZqEqCBPLWuw15OIvrt
 WHCLcFssWeqQQUHEQnoBPTSLSPx7/FqbjqEfb+UD0DRDnD+ZgOMcPCkz5F4A4ai59viG
 I/5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFwgMr2iTtUhydeDrXj2i11slsAzKfnDaCJfOzGigMxfUek5xSZE1VLfafrx6S0eXvvqix5YHg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyq+ljOWwVeqjsihwE1oH837eZOY+LNdFaQtTtXYj0qDLo+8uht
 HI6iUD77bFlxxG58cPzInA3OzYGxHYIaIqXyy8BAjx4bPcMLEwbPXfL6FmXNhwg=
X-Gm-Gg: ASbGncuWAyoHFhihyZHfnwgYEVfs88JQguw9SpVPxCdXXHVScOjE8+dumKJH7axxmHx
 8QxEgjj+Fd/nLVijrAqkRI0WejAgBV9RF8r/ZXVvc0fvNDbUCrTSfFW2EjfWRt/6LnoYK1Yg42d
 gKJwIjov7ytvN11OE/q71r23UgM2S7LiyD4MkqFe5Z9dtPHg/IPV58ez80rNzX5gB8COFTzoqYa
 n/kDKUHZfPz4sy2ffmXGoCpVxlmlFQ4TACx9LsrOnqeONMofoMEXdnbWha32Yc0raHi++lFjvMr
 glzkriLmnBA7w0ZFxDwmfGhoR11HvsYueDr8
X-Google-Smtp-Source: AGHT+IE6y4JdTtlzcbrnGGg7v7FjSgwU7e/vWxQ7TgNE5uhhWt7BpBzFop0XHrbVtbgwiv0CXbLJOQ==
X-Received: by 2002:a2e:bc1a:0:b0:302:3a46:10a7 with SMTP id
 38308e7fff4ca-3046851f9cemr129431821fa.5.1735883938405; 
 Thu, 02 Jan 2025 21:58:58 -0800 (PST)
Received: from eriador.lumag.spb.ru
 (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3049ec4ca6bsm26165151fa.56.2025.01.02.21.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 21:58:57 -0800 (PST)
Date: Fri, 3 Jan 2025 07:58:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, 
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/ci: uprev IGT
Message-ID: <dj2r22upxnj2aicjnsvoqnhd4n73tyfgm36jtvixxp4vphocev@gggcjakm3xge>
References: <20241217160655.2371138-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217160655.2371138-1-vignesh.raman@collabora.com>
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

On Tue, Dec 17, 2024 at 09:36:52PM +0530, Vignesh Raman wrote:
> Uprev IGT to the latest version and update expectation files.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v1:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1327810
>     Will update the flake bug report link after v1 is reviewed.
> 
> v2:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1331363
>     Updated flake test bug report links.
> 

What is the current state of this patch? It would have been really nice
to get it in, we have patches depending on updated IGT.

-- 
With best wishes
Dmitry
