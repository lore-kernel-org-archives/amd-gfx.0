Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13C7C52D72
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Aug 2024 07:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B619810E132;
	Mon,  5 Aug 2024 07:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="EmWeaQrH";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2ED10E15A
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 16:54:35 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so26175315ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Aug 2024 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1722617674; x=1723222474; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrAppcAAzagZXUnPObci2usi/RqmUcn+ruLZgDFl8+g=;
 b=EmWeaQrHQMsvj8gPY7ANeBPP+BGasp97may0wGvKOpGPTJ/DKQMVCDpCxR8svclI9E
 LtkEJ9p+Z6Q6ljcYk24XbXhdMLkp30fGxDW/aD+7qW3y0v4+RYalkrYXGoBglZxXWIKZ
 LXhXoeb3Cqkp0NZKmPDJaIAXvfvZP4uROUkh5w/TJDwQxzjCZsSstbRejvLOdI1Dqx4k
 bY0cO2U6VmCgiBLx7b68B/7oDOg0XjPgKJsoZOTDvIJPwyfsM/lnYhWBVa3rJdVzyGeB
 FDKY9jNh7aPDzCA6U3PK/YyhiSWZZWel5mGtC+3xXMDqYRCvf5ZpT3XOQZ1WZtL6BHSl
 tXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722617674; x=1723222474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrAppcAAzagZXUnPObci2usi/RqmUcn+ruLZgDFl8+g=;
 b=vps8uqUc0qvP/XIRoapeVXAM4Ug/VWdhi+62B+Qvq73NmRDQFhJFWVp7bOgd3XNnLh
 XVNXWJvtckONpsijTClHvk4/7frHFAOG1Mdl0vK65h3rM3ck4obtkX2pyTkqWpoOAh1x
 Jd2egJDqfXAHLenyEkGohIAy1virFQzI9oi01scGnfFnPstBJHebq6PfJShGlHS4v21z
 l4dOAW75NAJY1MOobVZCwzDNch7J+coMXATqYE/fnyRZKFjAW0ziPOYI7AIVojia3hLk
 X4Xy/FxSjduzyiySSLT3mHP+thU3iftKPPLmeu/k7FLFICpiY0UoF+dKb7kiwMLiVUcK
 pU2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVnowM37QTdWx6pzoJln+AMtPXvCJwX2OBryvqQGyVNe3o0/ejtzwuj6LEJtnXyDya1AiWbqUwALZr1EeaZVXKLy1ToGeEU7AFpfoWvw==
X-Gm-Message-State: AOJu0YyIVeShjWo0nbjyXe9HnkH24Bw72nLPE/BuqupgZYSTQV3EhvuD
 SnkAqPd4D3ZFS9BmQfk10+YML2WvYULAUvCoY/l8ppu3IdiUtZbhBIplBrmL3Ss=
X-Google-Smtp-Source: AGHT+IEYt+XIwdpCJv+hJ1/4V8vHGn2ZEIPipNfIFiZFUexUC8izLQsYMLzSM2ChZaQeCXsqOEIZLw==
X-Received: by 2002:a17:902:e548:b0:1fb:8e29:621f with SMTP id
 d9443c01a7336-1ff57bc50demr60862605ad.16.1722617674449; 
 Fri, 02 Aug 2024 09:54:34 -0700 (PDT)
Received: from localhost.localdomain ([185.153.176.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f29cebsm19358205ad.35.2024.08.02.09.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:54:34 -0700 (PDT)
From: David Tadokoro <davidbtadokoro@usp.br>
To: jiapeng.chong@linux.alibaba.com
Cc: Rodrigo.Siqueira@amd.com, Xinhui.Pan@amd.com, abaci@linux.alibaba.com,
 airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, chaitanya.dhere@amd.com,
 christian.koenig@amd.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, jun.lei@amd.com, linux-kernel@vger.kernel.org,
 sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/display: remove unneeded semicolon
Date: Fri,  2 Aug 2024 13:54:09 -0300
Message-ID: <20240802165409.93652-1-davidbtadokoro@usp.br>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802025942.62734-1-jiapeng.chong@linux.alibaba.com>
References: <20240802025942.62734-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Aug 2024 07:17:01 +0000
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

> No functional modification involved.
> 
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:6463:166-167: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9633
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> index c54c29711a65..8f3c1c0b1cc1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> @@ -6464,8 +6464,8 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
>  			p->SwathHeightC[k] = l->MaximumSwathHeightC[k] / 2;
>  			l->RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
>  			l->RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
> -			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
> -			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
> +			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
> +			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
>  		}
>  
>  		if (p->SwathHeightC[k] == 0)
> -- 
> 2.32.0.3.g01195cf9f

Reviewed-by: David Tadokoro <davidbtadokoro@usp.br>
