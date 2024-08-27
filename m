Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4320FC54734
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131E510E3ED;
	Tue, 27 Aug 2024 17:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Mqi7YJfa";
	dkim-atps=neutral
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057E410E3E2;
 Tue, 27 Aug 2024 17:49:54 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
 by mslow1.mail.gandi.net (Postfix) with ESMTP id 95C46C4690;
 Tue, 27 Aug 2024 17:49:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98C4DC0006;
 Tue, 27 Aug 2024 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1724780990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9qLPGS9B2JIxDIaPJHcjKLwa8SjULH3vZPZesBPU6I=;
 b=Mqi7YJfa++YN2sDZmbhxcxdKlxTnn6Dp1vNVIZ/Q1wpnxGOLvKpfPG3GQcRWs41VGG+9LS
 K+8gq3TD4LxhkttjEVs9U9lmfBy/anh97axC+LZcOOD6S8cSTDMqdXRjKgSqzy9Zr4pkLa
 SzTqSkVGBNLztjbPE2hh/2W27AiunSGbImzozXtNWkTnmUf7/I/B90H31LUaYP3Xg8lAos
 S6qnE9M4BHaGZDIpsNyGn71jsgivW1vzaSnj1lA1iIhSb+CV7S69gS1D0CCcKGP998zXSn
 qM2wB3Oc781nKjLPy/jHHYyavVag2qZElr0yCbqntVbM/ttC4kYZ3y/f55uw7A==
Date: Tue, 27 Aug 2024 19:49:49 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 02/44] drm/vkms: Round fixp2int conversion in lerp_u16
Message-ID: <Zs4RvYYAXN5iGd0R@louis-chauvet-laptop>
References: <20240819205714.316380-1-harry.wentland@amd.com>
 <20240819205714.316380-3-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819205714.316380-3-harry.wentland@amd.com>
X-GND-Sasl: louis.chauvet@bootlin.com
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

Le 19/08/24 - 16:56, Harry Wentland a écrit :
> fixp2int always rounds down, fixp2int_ceil rounds up. We need
> the new fixp2int_round.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index e7441b227b3c..3d6785d081f2 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -98,7 +98,7 @@ static u16 lerp_u16(u16 a, u16 b, s64 t)
>  
>  	s64 delta = drm_fixp_mul(b_fp - a_fp,  t);
>  
> -	return drm_fixp2int(a_fp + delta);
> +	return drm_fixp2int_round(a_fp + delta);
>  }
>  
>  static s64 get_lut_index(const struct vkms_color_lut *lut, u16 channel_value)
> -- 
> 2.46.0
> 

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
