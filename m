Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7B9C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 16:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9ED610E09F;
	Wed, 12 Aug 2026 16:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AcMed5AY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F8D10E09F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=RCGHjLq991hzKf9SIxopw6vv85Z4pDkVFoa9AcUOVfY=; b=AcMed5AYL/aiXrVMBP+Ppv1JlK
 Qx5Lnjhd2LVhsbOY3H1aP/qjQ3ZyHICgMMKw1ukp0gGQb5il4j7PrjjVq32/lkMtmnj0QXvnvtKsX
 oD32h8WuH5DKx4Z8+LS9JZp2z7rUt0eSIGMAK1DiqxByQeLdoBFyQtawgugpYeDzYo+RpobjMfgX3
 GmR2fz4lJ8muZ1Hcwlcxt7kiXO1viqfPH5PFzmhdAZsFHjlpJ2ZWerFp3n303Tmr9u0E1I2rv5hEt
 y1SX701KWP1/ywJBWfTmBNMe+Pv7P6ktWepkQUIdtlJ6OWhiAglk0h0l/7Wgn76X3xx8SxYzgx1hs
 EGFaAdVA==;
Received: from [31.4.134.207] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuBhK-0009gG-Am; Wed, 12 Aug 2026 18:20:58 +0200
Message-ID: <8d7306c8-94b8-4e8b-b9e0-5f8d43a67be4@igalia.com>
Date: Wed, 12 Aug 2026 18:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 1/2] drm/amd/display: avoid divide-by-zero in
 __is_lut_linear()
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260804210405.278934-1-harry.wentland@amd.com>
Content-Language: en-US
In-Reply-To: <20260804210405.278934-1-harry.wentland@amd.com>
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
> __is_lut_linear() computes the expected value of each entry with
>
> 	expected = i * MAX_DRM_LUT_VALUE / (size - 1);
>
> If it is ever called with a single-entry LUT, size - 1 is zero and the
> kernel takes a divide error (#DE). A LUT with fewer than two entries
> cannot describe a linear mapping anyway, so return false early instead
> of dividing by zero.
>
> Fixes: 086247a4b2fb ("drm/amd/display: Use 4096 lut entries")
> Cc:stable@vger.kernel.org
> Signed-off-by: Harry Wentland<harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 7b68c6846039..26e5c89375a5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -471,6 +471,12 @@ bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
>   	uint32_t expected;
>   	int delta;
>   
> +	/* A LUT with fewer than two entries can't be interpolated and would
> +	 * divide by zero below (size - 1); it can't be treated as linear.
> +	 */
> +	if (size < 2)
> +		return false;
> +

LGTM

Reviewed-by: Melissa Wen <mwen@igalia.com>

>   	for (i = 0; i < size; i++) {
>   		/* All color values should equal */
>   		if ((lut[i].red != lut[i].green) || (lut[i].green != lut[i].blue))

