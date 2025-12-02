Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B08D116F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 14:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0F810E656;
	Tue,  2 Dec 2025 14:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y3PhQj44";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B44010E656
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 14:13:04 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7bac5b906bcso658945b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Dec 2025 06:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764684784; x=1765289584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+sQbpvtY4/na8tub8gyR+iFgzgYyiBFf925P4TxzMs=;
 b=Y3PhQj44UHHiwW4wA+mt7K9i+ge7iosXFzPwcLP0wxNd5bZTqChYmsqd97K2cbgg4a
 DzxlKKMbisBauqPdyF8f4IiI3DY48tCjYmUm8boYrhmGnQe2RO3gCMH3lqijdnAgPOyE
 TSbokmVaIqsVbrQfsFR/DmLOxyeY5+vvup2dInUckCLJEV9hRzx7EpRQrMCJrs8V8ktU
 4v42Ls6KoZqTdJbDvFTZB0xGikAHnJQ1UReQQcTAmsuHJroxOcPyOG9xrPa3ah7wV/bo
 CTI7iXzEbE6AHjOl60gGBC8719ZTkW44R3kMoEpriumXYnR1D/zgN/W8TO17s53PTmrA
 rw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764684784; x=1765289584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p+sQbpvtY4/na8tub8gyR+iFgzgYyiBFf925P4TxzMs=;
 b=fCM+P3pqhul3A2p2DC6+Cn2sjjJbZMmcbddv++sloUD6dcr2p3f9FTfeC+5NwfMb92
 WNF5HRj3cvCNgVidYNUmUplVSPtxO1lfYnrNExQ+b1fgYBSMihpKqHkgA8PCJTtKM9gw
 HqqM/kpjFmnUu1Fxnhi95yl2h20d59753ZCXBK3l6WQSG0mpgQ8lxliM/QJc5jIPYBSf
 bNKkdtz3dIwS015gQebURmQ45padi3W5i6zmS4Z+zmxS/NNPEg7t90DJrRwaWDRDOUFN
 NJzqBfxhtBbk0WzlRbIGTZ6E2FQA00EiGerZcPiYlJHj/McKP2JrpaEfx+8hNLf2zMHE
 vYhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRTwSPBKSerRKlkLs1NEvHNNKjUvsiVFPY/c2ww0a6QXRLlukgSUXQRkdGiWX+XPwK1QsT1MKj@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+FIa+hX1gOS9HuEJjVtOmQp5hhfwAdpbjsFPQlpgpy1sukyE0
 XF4EDfRZ6UK1fPp/4TaNOsF2dULwNwhmf8p0J5pxqEWZSMPWauMgbc71bZ1OsoFMFPPnmGptM3L
 pDJG9WYIFVEUenwRUH0CFJK+jwSe9adc=
X-Gm-Gg: ASbGncvVk5USqM1o8WcaLL8yDkRxB0aMSqS6fD3lPJ4BP/npqfKM0csOuID6Y+cOHYs
 QgJaV8lfQcOmdCKl5wOTq3DD/g3Qfa9YTmZfEbDTEms7eltFHjTXryRwSWd++Vr9KxSwHBEWkoy
 Y3r6iUZFe0967sEAGAlw0Jpcnje2t3Maw6tmABwPzUTgj2SOgNh/YgzXYPoPxQpj+Hsn/IwY1J4
 sPA4FOo5DrOiLmOyOCOmG0EJUXuZyT1zcaZu7PBTh52co1TUnK9bIBRHYTi9QvENHRWfNo=
X-Google-Smtp-Source: AGHT+IGAKCDFstfillvv5e8YUADxN4Sa9HQorVxw5+8jDWHR2PnJsIbOQt5LZHhdA0/ADA9xExoPJSZo5uLeMkfvI+U=
X-Received: by 2002:a05:7022:6299:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11c9f31a210mr25778090c88.2.1764684783558; Tue, 02 Dec 2025
 06:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20251202100259.310182-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251202100259.310182-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Dec 2025 09:12:52 -0500
X-Gm-Features: AWmQ_blvXeJRFuEQvNO1typPoYaLaOLbYmoKkiA3GQUPSUVTv3JOeSTafNXQ_Xk
Message-ID: <CADnq5_PKPnVL_6OoMYrPLaR67wuJUqnw2a=F0pfV4hKwFS+cpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma_v7_1: Add missing inst_mask entry in
 sdma_v7_1_inst_gfx_resume()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 2, 2025 at 5:09=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> The comment for sdma_v7_1_inst_gfx_resume() did not include the
> inst_mask parameter, even though the function takes it as an argument.
>
> Update the comment to document inst_mask as the mask of SDMA engine
> instances to be enabled.
>
> Fixes the below with gcc W=3D1:
> drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c:644 function parameter 'inst_mask'=
 not described in 'sdma_v7_1_inst_gfx_resume'
>
> Cc: Likun Gao <Likun.Gao@amd.com>
> Cc: Le Ma <le.ma@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_1.c
> index 89ce07ae18b4..f998edf52c28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -635,7 +635,7 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgp=
u_device *adev, int i, bool
>   * sdma_v7_1_inst_gfx_resume - setup and start the async dma engines
>   *
>   * @adev: amdgpu_device pointer
> - * inst_mask: mask of dma engine instances to be enabled
> + * @inst_mask: mask of dma engine instances to be enabled
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
> --
> 2.34.1
>
