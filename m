Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E757C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 676D310E317;
	Mon,  3 Jun 2024 08:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="GDXAWe4Y";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="vpfNmRJa";
	dkim-atps=neutral
X-Greylist: delayed 424 seconds by postgrey-1.36 at gabe;
 Mon, 03 Jun 2024 08:31:46 UTC
Received: from bunu.damsy.net (bunu.damsy.net [51.159.160.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1266310E301
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202404r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1717403072;
 bh=ZG352CvwgfIgVWp1HYVbbVY
 S1C9KSOmfdmRGw8x/rw8=; b=GDXAWe4YDT3c0DmuKA+7peHzqFtwt/QML8vQ3oySwXIL94fumi
 xfDciSpDAXF9YlKJ5Ri8UJ+7C9PZTnmqajL726Bx/D0HXrz7+2VO0UjUfG0yQaoJwJWIJAckE46
 9LOwrMXMeKJOGKouW3GNCnPMtKC+wm1kM7O62EaXHgHG9bzxKgEu8mxAgzzKgYr1kllSTMvR9ud
 +zxizVNHKJ3qP8F7metnRQwuuRjRH8ledemQcp9e7SS0nYYkYrFx/vmkUlPId7ITi8Tf/Lyi/Ff
 8wP+9iO5zNITOUjcHu/SV5bJDlLZky9mc5dC0pHFo+U8Di/KvggrvmB2NwVOSgMy+5g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202404e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1717403072; bh=ZG352CvwgfIgVWp1HYVbbVY
 S1C9KSOmfdmRGw8x/rw8=; b=vpfNmRJaDyZfgBy3WELYmq0akGsmacsPvjYJ3vrxkCDcB2yDWC
 wF31JR3oVaMGd7IWtx9PcFH7guJzL3sB3GAA==;
Message-ID: <804c2c99-d903-4601-baa7-339a996dbd22@damsy.net>
Date: Mon, 3 Jun 2024 10:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu/gfx11: enable gfx pipe1 hardware
 support"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-eric.Pelloux-prayer@amd.com
References: <20240531174208.3650007-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20240531174208.3650007-1-alexander.deucher@amd.com>
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

Thanks Alex, the patch is:

      Acked-by: Pierre-Eric Pelloux-Prayer 
<pierre-eric.pelloux-prayer@amd.com>


Le 31/05/2024 à 19:42, Alex Deucher a écrit :
> This reverts commit 269226a8fdf2cac0e03920f9ba0d670a056af3d6.
>
> Pierre-Eric reported problems with this on his navi33.  Revert
> for now until we understand what is going wrong.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Pierre-eric.Pelloux-prayer@amd.com
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 72676bfbac8c..bf05ff77feb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -50,7 +50,7 @@
>   #include "nbio_v4_3.h"
>   #include "mes_v11_0.h"
>   
> -#define GFX11_NUM_GFX_RINGS		2
> +#define GFX11_NUM_GFX_RINGS		1
>   #define GFX11_MEC_HPD_SIZE	2048
>   
>   #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
> @@ -1526,7 +1526,7 @@ static int gfx_v11_0_sw_init(void *handle)
>   	case IP_VERSION(11, 0, 2):
>   	case IP_VERSION(11, 0, 3):
>   		adev->gfx.me.num_me = 1;
> -		adev->gfx.me.num_pipe_per_me = 2;
> +		adev->gfx.me.num_pipe_per_me = 1;
>   		adev->gfx.me.num_queue_per_pipe = 1;
>   		adev->gfx.mec.num_mec = 2;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
> @@ -1537,7 +1537,7 @@ static int gfx_v11_0_sw_init(void *handle)
>   	case IP_VERSION(11, 5, 0):
>   	case IP_VERSION(11, 5, 1):
>   		adev->gfx.me.num_me = 1;
> -		adev->gfx.me.num_pipe_per_me = 2;
> +		adev->gfx.me.num_pipe_per_me = 1;
>   		adev->gfx.me.num_queue_per_pipe = 1;
>   		adev->gfx.mec.num_mec = 1;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
