Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0675EC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 14:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D3314A480;
	Wed, 20 Jul 2022 14:26:58 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D9111B23B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dMoVYQxnaUxzSnpXC3b4QhKMds/tnwk4wVoudOV5YtQ=; b=nGYa2NHYZzVU0rNNjDuerD4bRH
 erzfGP9LOhHLQ+ocI0mY5qfeGZZvQyTWGCv9O1/Bf3eZvwZOOzhGyXG0iaOirgRtUQ3Ipls9s9paF
 ToFUI6xcBX2k+3mshuSUuecqJvWj0nPAe2DNLMDwT48cy+R8wj8f9ha4ZBwgPRNQ6SC+9QjnIPlpg
 Nvk6atiEIfCG1v9FCahXmwAvMSDPaUhPMWsgR3KSFBqZRQvRz5wSgQPOIosuwMNYB3oSyXUk0hSy8
 rKrFKpa+dmyXesQtDpYh4f3XDh4xskpBAR8g73F5kBqp9XWzFqQP+HIsyGnra6RmK0oI97Gyf/tnm
 6w0yQvFg==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oEAf7-000OMB-Tn; Wed, 20 Jul 2022 16:26:53 +0200
Message-ID: <619fc381-04e0-bc1f-62ad-a1169a63febc@igalia.com>
Date: Wed, 20 Jul 2022 11:26:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix the incomplete product number
Content-Language: en-US
To: Roy Sun <Roy.Sun@amd.com>
References: <20220720082659.49637-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220720082659.49637-1-Roy.Sun@amd.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 05:26 de 20/07/22, Roy Sun escreveu:
> The comments say that the product number is a 16-digit HEX string so the
> buffer needs to be at least 17 characters to hold the NUL terminator.
> 

Which comment?

> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9f729a648005..187e3dae3965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,7 +1019,7 @@ struct amdgpu_device {
>  	bool                            psp_sysfs_en;
>  
>  	/* Chip product information */
> -	char				product_number[16];
> +	char				product_number[20];

If 17 is enough, why setting as 20?

>  	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
>  	char				serial[20];
>  
