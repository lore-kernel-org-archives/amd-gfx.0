Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8313C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 10:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A52F61BFA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 10:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A52F61BFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83226E9B4;
	Mon, 15 Nov 2021 10:24:52 +0000 (UTC)
X-Greylist: delayed 581 seconds by postgrey-1.36 at gabe;
 Mon, 15 Nov 2021 07:41:19 UTC
Received: from smtprelay.hostedemail.com (smtprelay0152.hostedemail.com
 [216.40.44.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64986E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 07:41:19 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 9AC1F18015D96
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 07:31:38 +0000 (UTC)
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 50F488384376;
 Mon, 15 Nov 2021 07:31:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf02.hostedemail.com (Postfix) with ESMTPA id 07A75B000181; 
 Mon, 15 Nov 2021 07:31:33 +0000 (UTC)
Message-ID: <cfcae256344c5b83398944d5609e76d983ccbc1b.camel@perches.com>
Subject: Re: [PATCH] drm/amd/amdgpu: remove useless break after return
From: Joe Perches <joe@perches.com>
To: Bernard Zhao <bernard@vivo.com>, Alex Deucher
 <alexander.deucher@amd.com>,  Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, David
 Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, Evan Quan <evan.quan@amd.com>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Sun, 14 Nov 2021 23:31:34 -0800
In-Reply-To: <20211115071429.7314-1-bernard@vivo.com>
References: <20211115071429.7314-1-bernard@vivo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 07A75B000181
X-Stat-Signature: rxw7ub9mqfb8pxrhxqznk9h8sctub7mm
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/BMX1pM41Hx9u3dc67UGKg+oEXxIeNQNY=
X-HE-Tag: 1636961493-426773
X-Mailman-Approved-At: Mon, 15 Nov 2021 10:24:52 +0000
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

On Sun, 2021-11-14 at 23:14 -0800, Bernard Zhao wrote:
> This change is to remove useless break after return.
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
[]
> @@ -2092,22 +2092,18 @@ static int dce_v8_0_pick_dig_encoder(struct drm_encoder *encoder)
>  			return 1;
>  		else
>  			return 0;
> -		break;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
>  		if (dig->linkb)
>  			return 3;
>  		else
>  			return 2;
> -		break;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
>  		if (dig->linkb)
>  			return 5;
>  		else
>  			return 4;
> -		break;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
>  		return 6;
> -		break;
>  	default:
>  		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
>  		return 0;

Perhaps rewrite to make the sequential numbering more obvious.
---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index b200b9e722d97..7307524b706b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2088,26 +2088,13 @@ static int dce_v8_0_pick_dig_encoder(struct drm_encoder *encoder)
 
 	switch (amdgpu_encoder->encoder_id) {
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY:
-		if (dig->linkb)
-			return 1;
-		else
-			return 0;
-		break;
+		return !dig->linkb ? 0 : 1;
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
-		if (dig->linkb)
-			return 3;
-		else
-			return 2;
-		break;
+		return !dig->linkb ? 2 : 3;
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
-		if (dig->linkb)
-			return 5;
-		else
-			return 4;
-		break;
+		return !dig->linkb ? 4 : 5;
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
 		return 6;
-		break;
 	default:
 		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
 		return 0;


