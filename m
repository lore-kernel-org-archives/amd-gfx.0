Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB027C46467
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 14:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5735A10E14C;
	Mon, 16 Jan 2023 14:50:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB3210E14C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/hs2+8g0IShOxNmKSffjX1mUcyNDyGXQwIlDMKWRvOo=; b=Eo7gJfZJQXKDZTg3fzA/4G2+B4
 cYR5wRkcDzhzbOuxv4zoJFZLPu1bNUTnN/sHlJxFnPE11NBLgVc4C0AAFPs5/me/vtXUy9faSHjDg
 hcXVEVKF9/peeJAxnKUx6ZKmaAzuctwwJhZiGMPLOmVXDd7JdiUTNM18pNdaHr9jj+KQ8jyq6xr07
 XGwBzjMkqZGBxhjW9lBXD/TOgNbfMjn7LMV9lHLxP356HtGzwfh60xNizSlDtdbCn5+qB/vXD//sR
 gZfJmwP1JJW7kjpw7H0OmGYS2M/AWsxzTbFrGknpUR7pDyqvfmnUJ7IpghJurc1KOawUsz7UWg6Ys
 Kq0eZGqw==;
Received: from [38.44.66.31] (helo=[192.168.31.42])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pHQoz-009slm-Lr; Mon, 16 Jan 2023 15:50:49 +0100
Message-ID: <d9d534bc-938c-c112-c779-4bc95360cf45@igalia.com>
Date: Mon, 16 Jan 2023 13:50:48 -0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From: Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH] drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix
To: Joshua Ashton <joshua@froggi.es>
References: <20230110225042.6710-1-joshua@froggi.es>
Content-Language: en-US
In-Reply-To: <20230110225042.6710-1-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 01/10, Joshua Ashton wrote:
> The YCC conversion matrix for RGB -> COLOR_SPACE_YCBCR2020_TYPE is
> missing the values for the fourth column of the matrix.
> 
> The fourth column of the matrix is essentially just a value that is
> added given that the color is 3 components in size.
> These values are needed to bias the chroma from the [-1, 1] -> [0, 1]
> range.
> 
> This fixes color being very green when using Gamescope HDR on HDMI
> output which prefers YCC 4:4:4.
> 
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 471078fc3900..652270a0b498 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -90,8 +90,8 @@ static const struct out_csc_color_matrix_type output_csc_matrix[] = {
>  		{ 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, 0x16E3,
>  				0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
>  	{ COLOR_SPACE_YCBCR2020_TYPE,
> -		{ 0x1000, 0xF149, 0xFEB7, 0x0000, 0x0868, 0x15B2,
> -				0x01E6, 0x0000, 0xFB88, 0xF478, 0x1000, 0x0000} },
> +		{ 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
> +				0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },

LGTM.

I'd also add a fixes tag here to:

Fixes: 40df2f809e8f ("drm/amd/display: color space ycbcr709 support")

Thanks,

Reviewed-by: Melissa Wen <mwen@igalia.com>

>  	{ COLOR_SPACE_YCBCR709_BLACK_TYPE,
>  		{ 0x0000, 0x0000, 0x0000, 0x1000, 0x0000, 0x0000,
>  				0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x1000} },
> -- 
> 2.39.0
> 

