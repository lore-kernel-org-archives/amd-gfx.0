Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66972C433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 15:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112E164E31
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 15:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112E164E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116FC6EE13;
	Thu, 11 Mar 2021 15:39:12 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 556246EE11;
 Thu, 11 Mar 2021 15:39:10 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id r24so1824736otq.13;
 Thu, 11 Mar 2021 07:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k8nU3otkqKDGoLnXZ+AyQvf2Qyce9hWCQRz5CGYNTV8=;
 b=YcOESLcl6A0DxELmb4Q3UlWuPIwjY/Gi64vBCZUBHVthOHA1c7hZbJ5ZyFx1ShfPX+
 UDBXkbf0bBJ69IdKKvHxGPdrz94adaGRFXEZvmClR/gYFpmJUxiTPatMLAMUwl0Kr2ew
 YImXGZF2QV8Kc0Sdr7//IBmcxMeUp74q1MOdPi4NRzbJnpMT9jd9k2yrBRmOk7Kj3rLI
 VGaEkR4caadslizFgAO2MX86IwC42yJjj6TD53EJBd1ndKHqxOsbQCJY0HagwDv6NK/V
 o29f/1sAPK23OLr1chPlFfl7NN6ki+6ZutXKq9c+JDqMqxex2FEAucpqibpFp1RX3FPO
 1S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k8nU3otkqKDGoLnXZ+AyQvf2Qyce9hWCQRz5CGYNTV8=;
 b=ZWj5eCRtrHYcb4NTbknEuPLvVQeDP3DSYbdrKufzLTJUctx9nJUa6reEnqEyrKfxw6
 FRcf0kAJM0dYB5cOcPoQSLVIu7si9byJLKuJ2Z1ejNEe2nD6ZOhb6aEkHGxIQFSdqhlI
 lXRGpNu7wm0dB/7rd4oe4FlPAzRiKAIKHzbyM7KEG36xaiXWysyiTqJ5KH0nTfQsOl31
 WyhwaBWk7HgCBrICbWDAAAELoxfV++XTMOLyT3ekf4zl2N+UJYmqHa3Lw0D6j0S4dxpu
 w1Ncc0HC8HiFpjldqxBqJ1fvI2IAmZ22ET+63jAg1TxdsqFIAgv09eV1K5XCXnoLk6a4
 kkYw==
X-Gm-Message-State: AOAM532K1KjeSQUDo3JB/2Wi6oIDUAo7nyGbQEXXUwe9olgAtlGOCLe9
 L9Rz5LSC95JdXejfvWAMyPxbSBaE2MZ4Bqb4oeI=
X-Google-Smtp-Source: ABdhPJxOjP/JafiPMC5iAxWgHzxV7klk0G1enHWcpJxnjDmEpaJAZVjHHfOQIxpKPQnRhz+jSKit4DzGCNRjuClDMsk=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr7279798ota.311.1615477149643; 
 Thu, 11 Mar 2021 07:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20210311092830.5106-1-colin.king@canonical.com>
In-Reply-To: <20210311092830.5106-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Mar 2021 10:38:58 -0500
Message-ID: <CADnq5_PNgWJPjV-kny7pfRZZ7pS8FhpHxWYPBKbyGd7kVqW2Fg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Fix spelling mistake "disabed" ->
 "disabled"
To: Colin King <colin.king@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Mar 11, 2021 at 4:28 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a drm debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 617e62e1eff9..dcbae9237cfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3464,7 +3464,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>                                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>                                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
> -                                       DRM_DEBUG("IP %s disabed for hw_init.\n",
> +                                       DRM_DEBUG("IP %s disabled for hw_init.\n",
>                                                 adev->ip_blocks[i].version->funcs->name);
>                                         adev->ip_blocks[i].status.hw = true;
>                                 }
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
