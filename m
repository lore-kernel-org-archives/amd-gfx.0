Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945CCC27C43
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 14:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD0FC10E08E;
	Tue, 28 May 2024 14:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLHvT2SW";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723DE10E08E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 14:44:13 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-420180b5922so10539105e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716907451; x=1717512251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X2nnysbAmlUfOen3mxlZa1K+jlYHZyEvNaf9gDq2qZ0=;
 b=ZLHvT2SW/N74hmgOlbPY/drqPlAhpKgXMx8Xze3Ax9m17gjJudzPBty2v95hFvWgTR
 xkYz65AcL8OR+7hkk200bX46hu5pJSxBvtxOhxrY7HHZOkgo8TLSBFn6h6wBbHHFA+Gr
 b+Fr1XNDGO0BE3FjbxjuKCuKbWHEk3+naOi5R1d/8+zSA7nKJkN77NA3mfXtIkuguKmI
 01H6m/S5F1jRLReM+5M1WNOu2pvE+rvtCnKrl4c3UesxjqPIUNejSP71TldrejXt+zpG
 DOcLpMES+PIgb/1O1TsbAGnMgY9Xy5jjgW8dT3Tvty0rvEE++EG2ec0iFmxsxJSE9DU2
 w03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907451; x=1717512251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2nnysbAmlUfOen3mxlZa1K+jlYHZyEvNaf9gDq2qZ0=;
 b=mRi0H7iaIaB1Xe0yYlxHBM5WKmNudR1xGLlHYC76e6BNt8qOp/bPJOuOz5nryaT5MN
 vZwWCVlvbivUP4ww0lSMhE6ssWc5epQDtZ/cm4jSaooJTRUAXn82mFPBgje+9WDtGOkd
 cQBnShEzR24XEbTUoTbX4A+1BwdoQFpS11Ow+6sF5Fd0nd/9jZq1M3kkxlhle0snsu0+
 SDXaAGD2pGoTq+C3FY1+mJIfchjtzWmx5uhjk3CKBNtJlAuAIZktetZ0B1yo1m3L6uvC
 4CJ/Tx9yRyx7rEPGxf330iDIWu1kKSRQMynDyJDVvcQhoKbZx77DCAPV3bOEL2yyPkX3
 gX7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Q6T6M1Q7O0hiLocnUqgPuy3QWLDPz1MWDm1o2BI6FdWKDvt9J3dheiSQgXTJ7YrmGmoAq7znwUkbOlYMj5AA34FnUjnXR+ok7JYcmQ==
X-Gm-Message-State: AOJu0YwL4PnKaCCM065+NgOpjhQulmDs1fNodN7wrJdYPNFQO0qqtdY4
 TbIceJuKKd4Q1++YSWPcgKHHVv0s/WTKDlmXBQVLQa9/Rgz/BdJ4
X-Google-Smtp-Source: AGHT+IHvndcoBa72Uq6Y9h9EhK73RwRcC5vW1OoKNDXO44jQSvaacGgDALqMYHWN+BzENmXa5PN8Ng==
X-Received: by 2002:a05:600c:19d0:b0:421:20ac:1244 with SMTP id
 5b1f17b1804b1-42120ac12d2mr14532625e9.22.1716907451082; 
 Tue, 28 May 2024 07:44:11 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee806esm176940745e9.3.2024.05.28.07.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 07:44:10 -0700 (PDT)
Message-ID: <9c055c20-4a78-4d0c-abd0-fbc4f9c0c42d@gmail.com>
Date: Tue, 28 May 2024 16:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx11: select HDP ref/mask according to
 gfx ring pipe
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240513202514.141828-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240513202514.141828-1-alexander.deucher@amd.com>
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

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
series.

Regards,
Christian.

Am 13.05.24 um 22:25 schrieb Alex Deucher:
> Use correct ref/mask for differnent gfx ring pipe. Ported from
> ZhenGuo's patch for gfx10.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index c87943f6c4436..c8c055ef2f3c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5294,7 +5294,7 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   		}
>   		reg_mem_engine = 0;
>   	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> +		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>   		reg_mem_engine = 1; /* pfp */
>   	}
>   

