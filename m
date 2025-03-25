Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE6FC36008
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 20:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61ED610E5F3;
	Tue, 25 Mar 2025 20:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dDY+q0zR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3504210E5F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 20:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bznD8K2AHJ7XeWN/yTbp7WhitiGm8AAMSx/giE3gARU=; b=dDY+q0zRkxpmGKyZbwRQ+pHmHL
 ariccukgIRJRy1l88Kv5QGjjgpTx8X4zxqqdwQyRCq5lzeYu0ygccPM2Q4j0jcJ3f2uihd4yT24PB
 n8ZrlD3N9KEncd5qCvKQzrVbg24N5OSI2uPAqDUIPmfyYa9cSs+wVLZLYBTOTwuRMxYuyvEcQjQ0t
 vleEDezacauLDPE+yXnF1+/05NP2/b9c+nv73krkeucFSpp5citHKDs1I/JtQYufhRCf9hFai/NEN
 4XIp+MpMip2ZssZ3tjFehEIIvw8Y7t9NQVQi8ZL755ONEgaepVld3QL3IDJwLWjxL96GdEfMTkQ+Q
 Q5kHujuQ==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1txAhP-006IyR-6l; Tue, 25 Mar 2025 21:16:35 +0100
Date: Tue, 25 Mar 2025 14:16:32 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/6] drm/amdgpu/gfx6: fix CSIB handling
Message-ID: <qb3g5stqctrdwfqwbrlwzuevcuxvof4z3yj2iigfuv4mrzpbc2@ubfz5xidet53>
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319162225.3775315-1-alexander.deucher@amd.com>
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

On 03/19, Alex Deucher wrote:
> We shouldn't return after the last section.
> We need to update the rest of the CSIB.

What is CSIB?

What happens if the other CSIB is not updated?

Thanks

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 13fbee46417af..cee2cf47112c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -2874,8 +2874,6 @@ static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev,
>  				buffer[count++] = cpu_to_le32(ext->reg_index - 0xa000);
>  				for (i = 0; i < ext->reg_count; i++)
>  					buffer[count++] = cpu_to_le32(ext->extent[i]);
> -			} else {
> -				return;
>  			}
>  		}
>  	}
> -- 
> 2.48.1
> 

-- 
Rodrigo Siqueira
