Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC5DC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C627810E0D9;
	Wed, 30 Apr 2025 08:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="A6kNCxT2";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CDE10E0D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:04:50 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZnV8Y6lw7z9tVP;
 Wed, 30 Apr 2025 10:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1746000286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCKrOymQwpeYfCWKFZOZePt2vzeK8WuaSbm8DeEdQYo=;
 b=A6kNCxT2ve78n1YfZxirbUxMwghDMhqEQlkVtpL1xiE4iDrxPIKVwCful55vkml+OPGLNq
 vBzuDHSvYreDaPz0IyY6FqlVuyMFqltQ2Ans3DeMFidOHzbdzn/KnaYk8zF1VevpST4nH4
 y/g8etGvMNHq0i6wjfPhYXzgTvAu9Et4QckItdO11qVGPc6mDhFwXilQeNkABQHznkL2MT
 CJtWg68w+C5WscBuoFFhw4yp6CSh0ylDNPerpKiLSPyETtGT3Nqsrc6zD8i+dt63vw49xB
 8h1tkIET7F19BZzkK+ZtHltH1dQ7YRDzaBloRufVOZjUl/2+kHr5QwI9aSVhrw==
Message-ID: <60f0bac7-cc46-444f-8985-efe889ec4ac3@mailbox.org>
Date: Wed, 30 Apr 2025 10:04:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu/psp: mark securedisplay TA as optional
To: Alex Deucher <alexander.deucher@amd.com>
References: <20250429134739.1523228-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20250429134739.1523228-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 910806ab4ad4aad4a0c
X-MBO-RS-META: oomuawmr9koq5hm563ih6bnptw3c7jxi
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

On 2025-04-29 15:47, Alex Deucher wrote:
> This is an optional TA which is only available on
> certain embedded systems.  Mark it as optional to avoid
> user confusion.  This mirrors what we already do for
> other optional TAs.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4181
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d54bb13772622..1c843b888475e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2214,7 +2214,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
>  
>  	if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
>  	    !psp->securedisplay_context.context.bin_desc.start_addr) {
> -		dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta ucode is not available\n");
> +		dev_info(psp->adev->dev,
> +			 "SECUREDISPLAY: optional securedisplay ta ucode is not available\n");
>  		return 0;
>  	}
>  

Does it need to be dev_info, or could it be dev_dbg?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
