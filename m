Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B76C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 16:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C4910E419;
	Wed, 12 Aug 2026 16:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="B6EF/bCt";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7B110E419
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=x09cVUmbjUsyEQozm05jQQnrP22oqKc98mmcC4suX+0=; b=B6EF/bCtTAnDBLM/0HgeoLpE/U
 tHoequgwkaEFSNWvs04Wfjr5W8g7n82XJAbxx32I+UahX4UAl7VJ1LZNrzu5cUY3pWoNwHVndFXop
 qxuU/gDw/56SvyzcWig+3VnUMUuv4XiXgEl40Y9ZUivkbI6USgplZKP89B+gYOWgUft1iUkIAckhE
 YnzM7AydlwRgAQM2FPD8om7+fF9NBD95hXGFP6sn/pRIgKCjJYDdzl2+IWiT5FQvhYDHvqlbSCpyp
 rbbx5cWwfhFziMB12YImehEFi2BjTVaTX/DMKHxY/O8UOyavH7kHfhDuDAiY106iZm1jPr4WiFz7V
 0qz2rlng==;
Received: from [31.4.134.207] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuBjt-0009rV-5O; Wed, 12 Aug 2026 18:23:37 +0200
Message-ID: <217a3dbf-a02c-4dd0-9edf-4a9500206a9f@igalia.com>
Date: Wed, 12 Aug 2026 18:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: validate plane degamma LUT size for
 private color prop
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260804210405.278934-1-harry.wentland@amd.com>
 <20260804210405.278934-2-harry.wentland@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260804210405.278934-2-harry.wentland@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 04/08/2026 23:04, Harry Wentland wrote:
> Unlike the CRTC degamma path, which is guarded by
> amdgpu_dm_verify_lut_sizes(), the per-plane degamma LUT size was never
> validated before use. __set_dm_plane_degamma() passed the user-supplied
> size straight into __is_lut_linear() and, for a non-linear LUT, into
> __set_input_tf() -> __drm_lut_to_dc_gamma(), the latter always iterating
> MAX_COLOR_LUT_ENTRIES entries regardless of the actual LUT size.
>
> A malformed AMD_PLANE_DEGAMMA_LUT blob (e.g. a single entry) could thus
> trigger a divide-by-zero in __is_lut_linear() or an out-of-bounds read in
> __drm_lut_to_dc_gamma(). Reject any plane degamma LUT whose size does not
> match MAX_COLOR_LUT_ENTRIES, mirroring the invariant the code already
> asserts a few lines below (and which the CRTC path enforces).
>
> The AMD_PLANE_DEGAMMA_LUT property is only exposed on builds with
> AMD_PRIVATE_COLOR defined.
>
> Fixes: 980f8710075a ("drm/amd/display: add plane degamma TF and LUT support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 26e5c89375a5..d55dc06167a8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1495,6 +1495,13 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
>   	degamma_lut = __extract_blob_lut(dm_plane_state->degamma_lut,
>   					 &degamma_size);
>   
> +	if (degamma_lut && degamma_size != MAX_COLOR_LUT_ENTRIES) {
> +		drm_dbg(plane_state->state->dev,
> +			"Invalid Plane Degamma LUT size. Should be %u but got %u.\n",
> +			MAX_COLOR_LUT_ENTRIES, degamma_size);
> +		return -EINVAL;
> +	}
> +

LGTM

Thanks!

Reviewed-by: Melissa Wen <mwen@igalia.com>

>   	has_degamma_lut = degamma_lut &&
>   			  !__is_lut_linear(degamma_lut, degamma_size);
>   

