Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A06D78769
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 12:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5065210EE08;
	Fri, 19 Dec 2025 12:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="oTTtx4gY";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930E110EF8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 12:41:13 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so10508465e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 04:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1766148072; x=1766752872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zfLhYYskh7twKjEbDnWHnjCPUTtJy5rVU5ckCpBjzjQ=;
 b=oTTtx4gYST68Xy6kd5ViiXBGWqkOd/bFfHu+YahWfeXmECMhOIzn1/iMXsP6WQ4k95
 mIzxxbu38HLiiagmhlxtzyhh5t/swm8Bcgf/AByXNzSfXcnmYK9P2Argq4jw/nI4BAZ3
 uPM/ZhRcBLTLHiOOu9mYhE0m4n9+NQ8R0un6LpsT/lXt7E4zGULr0+rtU/8nyuyIR7Qf
 Z8Z0f+ejGZDjOjkBULhVUPD/WBKqmtDNctonWbowOAWgFg+1ePWAZXeOf5adgylOHM/B
 kZjHUrg1vvRfKXAVDGpcRu5ona257HAE3KFTbBfLkFzHSCqKrmeB1bb7TcZe8kYD3ATK
 Rvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766148072; x=1766752872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfLhYYskh7twKjEbDnWHnjCPUTtJy5rVU5ckCpBjzjQ=;
 b=aIMAB6zFoxdkaLB72fhgD1IyhrhXk1hAkvCsgQ6wItDx8QnFaY3FkaA9sXYU8dAZ+e
 aOXeDJbR2rlz2HGzVihcXsZD5dXyigzGX1C3r2qbsGIy59SjannLYHcyKOZW5xBZyTMj
 yR9Cuq4HsZWGAvBH7RgwTT+ka8q7ApxdvgdX1Lk6W63lEhdDEj6nOTN+19S/G2wv87hv
 pb9oMw+ELq93meFyJ46wb6VIgg4g9fzZITCbF934omq42V9VzlEDrmcWgM7ZL3nYSbEd
 IXoQGM01PLdKZrfRdesBW6p2yhVk0PHy7gzfv7UuYDNvyqhblmMx0Kvob5Qu8HUN+wkZ
 bEpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVabsMQ6jkgeiQs37Y8VpEiNO2Zvaululex957eZZ0/qbpiD0Tg2I8QbZ0xcNsaavERRhrVO/AL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw/mwyUcRMEdMxRHMGQP6SKssDnU4XJpqpEXWnRoif9Kl1myAM
 DJBvy4PYVSk1Q8H7i9uGcV6QLIGErZU3nL2pYZjyJmxACPN+G4SvMol0dnNHKEPI9+4=
X-Gm-Gg: AY/fxX6h/M73YXeB0ca1BxuYiAfovvJndbiV2KsvwpU87VWUOEtPSw944BpRqeVLgiJ
 MsNEpjgD8NtFJGG5iMHFKbkFX6QGyMfnWgPDWMkjVSfClDfzgJRrNyng+YfxR7lCAGKp02pXAIs
 hftLI7vPZTXGQ/wZAZVjRUiZ4bAtLXrs+b4cN6l3kGQBk2uH0rtekdQfKEnoyDQ5WvcUzd+I0nU
 yoWqdR/wDQEBzVBLGtIa0FG1789FPbOQaUBXYP4b0r7VyCO1aLTuS3w7bi9dHBfsokA4/t3YfrL
 yklyYdrjCkYVjVP7cih7kgQ0EJQySbKEDjTTdyc6NxUs16Mi+vXkhonR1Bbey+evoEL8WwSEVV5
 vtxsJ4/fQRlY0cb+FO1SotaKTAn+ibxOe9JGPxrP9twVsJ5b4ulMxkyIh4Ouy459jBKF8pI7RWq
 QiDcmUewzKFnhNoR1AhtPjItxOGUvBb9/X
X-Google-Smtp-Source: AGHT+IEGZdliwt0MChc5NqjLJ+YAJgJgc2olYV76f27Cr00O4FLaFYAwsi3nD4R45ycagAKVl8pUEA==
X-Received: by 2002:a05:600c:8208:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-47d1958d960mr21806545e9.32.1766148071409; 
 Fri, 19 Dec 2025 04:41:11 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c5f8sm90509065e9.9.2025.12.19.04.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 04:41:11 -0800 (PST)
Message-ID: <83bf2281-e604-48fd-a8ff-533ae86bc52e@ursulin.net>
Date: Fri, 19 Dec 2025 12:41:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 39/51] drm/amd/display: add 3x4 matrix colorop
To: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: wayland-devel@lists.freedesktop.org, harry.wentland@amd.com,
 leo.liu@amd.com, ville.syrjala@linux.intel.com,
 pekka.paalanen@collabora.com, contact@emersion.fr, mwen@igalia.com,
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com,
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org,
 xaver.hugl@gmail.com, victoria@system76.com, daniel@ffwll.ch,
 uma.shankar@intel.com, quic_naseer@quicinc.com, quic_cbraga@quicinc.com,
 quic_abhinavk@quicinc.com, marcan@marcan.st, Liviu.Dudau@arm.com,
 sashamcintosh@google.com, chaitanya.kumar.borah@intel.com,
 louis.chauvet@bootlin.com, mcanal@igalia.com, nfraprado@collabora.com,
 arthurgrillo@riseup.net, Daniel Stone <daniels@collabora.com>
References: <20251115000237.3561250-1-alex.hung@amd.com>
 <20251115000237.3561250-40-alex.hung@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251115000237.3561250-40-alex.hung@amd.com>
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


On 15/11/2025 00:02, Alex Hung wrote:
> This adds support for a 3x4 color transformation matrix.
> 
> With this change the following IGT tests pass:
> kms_colorop --run plane-XR30-XR30-ctm_3x4_50_desat
> kms_colorop --run plane-XR30-XR30-ctm_3x4_overdrive
> kms_colorop --run plane-XR30-XR30-ctm_3x4_oversaturate
> kms_colorop --run plane-XR30-XR30-ctm_3x4_bt709_enc
> kms_colorop --run plane-XR30-XR30-ctm_3x4_bt709_dec
> 
> The color pipeline now consists of the following colorops:
> 1. 1D curve colorop
> 2. 3x4 CTM
> 3. 1D curve colorop
> 4. 1D LUT
> 5. 1D curve colorop
> 6. 1D LUT
> 
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> ---
> v13:
>   - Remove redundant ternary null check for drm_color_ctm_3x4 blob (Coverity Scan)
> 
> V10:
>   - Change %lu to %zu for sizeof() in drm_warn (kernel test robot)
>   - Remove redundant DRM_ERROR(...)
> 
> V9:
>   - Update function names by _plane_ (Chaitanya Kumar Borah)
> 
> v8:
>   - Return -EINVAL when drm_color_ctm_3x4's size mismatches (Leo Li)
> 
> v7:
>   - Change %lu to %zu for sizeof() in drm_warn
> 
> v6:
>   - fix warnings in dbg prints
> 
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 52 +++++++++++++++++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 15 ++++++
>   2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index b958f9c0a0c2..298f337f0eb4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1378,6 +1378,47 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
>   	return __set_colorop_in_tf_1d_curve(dc_plane_state, colorop_state);
>   }
>   
> +static int
> +__set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
> +				  struct dc_plane_state *dc_plane_state,
> +				  struct drm_colorop *colorop)
> +{
> +	struct drm_colorop *old_colorop;
> +	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> +	struct drm_atomic_state *state = plane_state->state;
> +	const struct drm_device *dev = colorop->dev;
> +	const struct drm_property_blob *blob;
> +	struct drm_color_ctm_3x4 *ctm = NULL;
> +	int i = 0;
> +
> +	/* 3x4 matrix */
> +	old_colorop = colorop;
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> +		if (new_colorop_state->colorop == old_colorop &&
> +		    new_colorop_state->colorop->type == DRM_COLOROP_CTM_3X4) {
> +			colorop_state = new_colorop_state;
> +			break;
> +		}
> +	}
> +
> +	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_CTM_3X4) {
> +		drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
> +		blob = colorop_state->data;
> +		if (blob->length == sizeof(struct drm_color_ctm_3x4)) {
> +			ctm = (struct drm_color_ctm_3x4 *) blob->data;
> +			__drm_ctm_3x4_to_dc_matrix(ctm, dc_plane_state->gamut_remap_matrix.matrix);
> +			dc_plane_state->gamut_remap_matrix.enable_remap = true;
> +			dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
> +		} else {
> +			drm_warn(dev, "blob->length (%zu) isn't equal to drm_color_ctm_3x4 (%zu)\n",
> +				 blob->length, sizeof(struct drm_color_ctm_3x4));
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
>   			      struct dc_plane_state *dc_plane_state,
> @@ -1581,6 +1622,17 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
>   	if (ret)
>   		return ret;
>   
> +	/* 3x4 matrix */
> +	colorop = colorop->next;
> +	if (!colorop) {
> +		drm_dbg(dev, "no 3x4 matrix colorop found\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = __set_dm_plane_colorop_3x4_matrix(plane_state, dc_plane_state, colorop);
> +	if (ret)
> +		return ret;
> +
>   	/* 1D Curve & LUT - SHAPER TF & LUT */
>   	colorop = colorop->next;
>   	if (!colorop) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index 4845f26e4a8a..f2be75b9b073 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -74,6 +74,21 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
>   
>   	i++;
>   
> +	/* 3x4 matrix */
> +	ops[i] = kzalloc(sizeof(struct drm_colorop), GFP_KERNEL);
> +	if (!ops[i]) {
> +		ret = -ENOMEM;
> +		goto cleanup;

Does this cleanup path leak the list->name allocated a few lines above, 
outside the diff? Kmemleak appears to think it can leak from somewhere 
at least:

unreferenced object 0xffff8881143c1e00 (size 32):
   comm "(udev-worker)", pid 588, jiffies 4294888494
   hex dump (first 32 bytes):
     43 6f 6c 6f 72 20 50 69 70 65 6c 69 6e 65 20 33  Color Pipeline 3
     31 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00  13..............
   backtrace (crc a75af242):
     __kmalloc_node_track_caller_noprof+0x525/0x890
     kvasprintf+0xb6/0x130
     kasprintf+0xb2/0xe0
     amdgpu_dm_initialize_default_pipeline+0x1ce/0x840 [amdgpu]
     dm_plane_init_colorops+0x19c/0x2e0 [amdgpu]
     amdgpu_dm_plane_init+0x4c4/0xf10 [amdgpu]
     initialize_plane+0xf1/0x280 [amdgpu]
     amdgpu_dm_init+0x23d0/0x7450 [amdgpu]
     dm_hw_init+0x3d/0x200 [amdgpu]
     amdgpu_device_init+0x67cd/0x9b20 [amdgpu]
     amdgpu_driver_load_kms+0x13/0xf0 [amdgpu]
     amdgpu_pci_probe+0x437/0xf30 [amdgpu]
     local_pci_probe+0xda/0x180
     pci_device_probe+0x381/0x730
     really_probe+0x1da/0x970
     __driver_probe_device+0x18c/0x3e0

Could it be a false positive, or leaking later after the success path, 
or some other path I am not sure since I am not at home in this code.

There is no error checking on list->name either, so I supppose the code 
which can touch that can handle a NULL harmlessly?

Regards,

Tvrtko

> +	}
> +
> +	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane);
> +	if (ret)
> +		goto cleanup;
> +
> +	drm_colorop_set_next_property(ops[i-1], ops[i]);
> +
> +	i++;
> +
>   	/* 1D curve - SHAPER TF */
>   	ops[i] = kzalloc(sizeof(struct drm_colorop), GFP_KERNEL);
>   	if (!ops[i]) {

