Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EEEF01820
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4733B10ECA7;
	Fri,  6 Mar 2026 08:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="d8l6wiA3";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE50810EB96;
 Thu,  5 Mar 2026 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1772718901;
 bh=Zbv+Cukn35v0xISz7agKyOhVi+C8KAFcmdtSnKAG6Ak=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d8l6wiA3p2Z1YmjsGB1KvpqMZJS8G0sB49WqDOnnstTDHpeNvwfjzx3Z0pSoYqDlI
 lRtK8oxVdlTSer7GKJIoCAU5xibRyjs+Fnu7mUoZk2uh70xyWuuHBQltcOAqNKIrDx
 2a6k4wM4RT9tj71x+fnFxW2169f7iOO2JC08EluWerbUCgSkYYY3EHMmVTiAio37Pa
 bF0VYE//jglDRd8i3Wb9I5ZPOY/JTYpjhTmeA3Eo/V810a9yO2fQlmwj0OTqLcuK50
 x6Oa+EMzP5f9k/oAUvvwv/XBXv6YlevNYYR4IdkfAPlgK8obQOk+fAN88p8jzl4gVO
 hUIa/Voo10b3g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EA4C417E0071;
 Thu,  5 Mar 2026 14:55:00 +0100 (CET)
Message-ID: <e01c9a6d-c001-4969-86b4-f627e1c18a66@collabora.com>
Date: Thu, 5 Mar 2026 14:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] drm/amdgpu: Fix kernel-doc comments for some
 LUT properties
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260305-amdgpu-fix-kdoc-lut-v2-1-37947aca68e8@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260305-amdgpu-fix-kdoc-lut-v2-1-37947aca68e8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 06 Mar 2026 08:52:54 +0000
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

Il 05/03/26 12:16, Cristian Ciocaltea ha scritto:
> The following members of struct amdgpu_mode_info do not have valid
> references in the related kernel-doc sections:
> 
>   - plane_shaper_lut_property
>   - plane_shaper_lut_size_property,
>   - plane_lut3d_size_property
> 
> Correct all affected comment blocks.
> 
> Fixes: f545d82479b4 ("drm/amd/display: add plane shaper LUT and TF driver-specific properties")
> Fixes: 671994e3bf33 ("drm/amd/display: add plane 3D LUT driver-specific properties")
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


