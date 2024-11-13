Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBADD462A5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 14:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A5810E70B;
	Wed, 13 Nov 2024 14:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GUFakreu";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFABC10E1B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 10:13:45 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-37d51055097so4064612f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731492824; x=1732097624; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=29r3GUvbzZw8w4aPc5tnOj0HcCOWENCLL4KD5K0a91E=;
 b=GUFakreuT0/7xy42F7kiOUOoPmK9dcv/TkY8r1e8kS9pSVcAEsChUvFjbfMQlb3wSI
 /TUzib6qbhSGRsCjPysG59/HvP3Kern/mD7lA1Q+2KE5/AKvayXZR8GFrfBV2SSM8JNV
 g94KTYcTBJVr5cChqGGyhb9gHaYiHA06df/jhmRSzDJnE3hx1lQgPezBpSWUvSbTIgXS
 3qrDmeWVcl40yQ8s4LyN5xoQ4CiaxoAoe9bMFGw4VGCQkzra6yqwKoe3s34gruWNCITQ
 9oCpYFkidbNC/5OtU+0AEZ97kSW7nE34asxMkh4+tCq+LTAfglxtp1U4oqa5oR1Rqlzg
 gP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731492824; x=1732097624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29r3GUvbzZw8w4aPc5tnOj0HcCOWENCLL4KD5K0a91E=;
 b=jyGz4yb9AvMmwkacXO2D7IYNhr0qKd6sb4f4PuneVO6tMYAlvSqRzYyw2U7aym0bso
 nkpwXlwo4zjBBQFfLiEBwqGAtHUvp9WWGkjH15BPCsY4reJw1X6wCF9gCT7wAxbGG/qc
 bdYTjPRTT4dz6eE+3Dg/lFH+28I8tsbcqUMoJ2OxiAnwYo5NOH4P1q04Dzf5tEvLvioD
 YFFwjqcXvpo+3llvRr4pEVivt43kLFCiSCu0csI7Ej17UNhWD9i6f62aWMbGvB14HX3+
 ScusCpiCw61TTqwf8BlyrJKlDctZpYwMONUa2vGMqMTYeXiErxnGUJrIyWNKmhVEOOWO
 19vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw7jP7KNKBwPR6/2wO+omc0h900GZ0UaTzlFmuIs4xlohqQCavI9L6/NzplZDSR2MKb9wmhrlu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDOE8OJLHpqfn2OByOd3YARXhIfkZTQYCjf+V+ld8SK4MXKYJj
 eaID3KhlGDcHprMX6HDv4RQvlBlgl5EZ6ajt7iR+SlnidL25CrUWSnTy7DEwHrc=
X-Google-Smtp-Source: AGHT+IH2BH3MALMB+E+XITlkb+0lyVpVuMJIDJUUSnd3RYPMU6chFRG2glEc9VGrAjVDTMO03oJKpw==
X-Received: by 2002:a05:6000:210e:b0:382:424:9520 with SMTP id
 ffacd0b85a97d-382042496a7mr6550276f8f.49.1731492823996; 
 Wed, 13 Nov 2024 02:13:43 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970d10sm17689789f8f.20.2024.11.13.02.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 02:13:43 -0800 (PST)
Date: Wed, 13 Nov 2024 13:13:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/amdgpu: Fix spelling mistake "versoin" ->
 "version"
Message-ID: <dceebb5d-9cc6-40ec-b1b4-6ae40cba45fe@stanley.mountain>
References: <20241113095349.1161044-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113095349.1161044-1-colin.i.king@gmail.com>
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:04:26 +0000
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

On Wed, Nov 13, 2024 at 09:53:49AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 9c905b9e9376..feecd099cf86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -646,7 +646,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>  		break;
>  	case MES_MISC_OP_CHANGE_CONFIG:
>  		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x63) {
> -			dev_err(mes->adev->dev, "MES FW versoin must be larger than 0x63 to support limit single process feature.\n");
> +			dev_err(mes->adev->dev, "MES FW version must be larger than 0x63 to support limit single process feature.\n");

What does "to support limit single process feature" mean?

regards,
dan carpenter

