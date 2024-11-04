Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023B7D132A6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 09:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8D910E3B5;
	Mon,  4 Nov 2024 09:05:07 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F4410E06A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 01:21:37 +0000 (UTC)
X-UUID: 1efe68629a4b11efa216b1d71e6e1362-20241104
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38, REQID:71e3df18-611f-4318-98da-1cf5882465ea, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-6,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-1
X-CID-INFO: VERSION:1.1.38, REQID:71e3df18-611f-4318-98da-1cf5882465ea, IP:5,
 URL
 :0,TC:0,Content:0,EDM:0,RT:0,SF:-6,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:-1
X-CID-META: VersionHash:82c5f88, CLOUDID:2565d0f338c499430975168a6f8a1b63,
 BulkI
 D:2411040918031A9FK27B,BulkQuantity:1,Recheck:0,SF:64|66|17|44|101|841|25|
 100|19|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 1efe68629a4b11efa216b1d71e6e1362-20241104
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(111.48.58.10)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>) (Generic MTA)
 with ESMTP id 1787099959; Mon, 04 Nov 2024 09:21:30 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: alexander.deucher@amd.com
Cc: jfalempe@redhat.com,
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/4] drm/amd/display: add non-DC drm_panic support
Date: Mon,  4 Nov 2024 09:21:27 +0800
Message-Id: <20241104012127.21561-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241031180430.3993389-5-alexander.deucher@amd.com>
References: <20241031180430.3993389-5-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Nov 2024 09:05:01 +0000
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

on 2024/11/1 02:04, Alex Deucher wrote:
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.
>
> Adapt Lu Yao's code to use common helpers derived from
> Jocelyn's patch.  This extends the non-DC code to enable
> access to non-CPU accessible VRAM and adds support for
> other DCE versions.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lu Yao <yaolu@kylinos.cn>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 27 ++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 27 ++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 27 ++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 26 +++++++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 5098c50d54c8..a26f2381504b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -2687,6 +2687,32 @@ static const struct drm_crtc_helper_funcs dce_v10_0_crtc_helper_funcs = {
>  	.get_scanout_position = amdgpu_crtc_get_scanout_position,
>  };
>  
> +static void dce_v10_0_panic_flush(struct drm_plane *plane)
> +{
> +	struct drm_framebuffer *fb;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +	struct amdgpu_device *adev;
> +	uint32_t fb_format;
> +
> +	if (!plane->fb)
> +		return;
> +
> +	fb = plane->fb;
> +	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
> +	adev = drm_to_adev(fb->dev);
> +
> +	/* Disable DC tiling */
> +	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
> +	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
> +	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
> +
> +}
> +
For non-DC ip, 'mmGRPH_CONTROL' and 'GRPH_CONTROL__GRPH_ARRAY_MODE_MASK' val are same, so whether the panic_flush function can also be made same?
>
> +static const struct drm_plane_helper_funcs dce_v10_0_drm_primary_plane_helper_funcs = {
> +	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
The definition of 'amdgpu_display_get_scanout_buffer' seems to be missing. 
