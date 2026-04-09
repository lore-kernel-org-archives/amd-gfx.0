Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD7FE99052
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5330810E8D2;
	Fri, 10 Apr 2026 07:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="AAAtn5nl";
	dkim-atps=neutral
X-Greylist: delayed 453 seconds by postgrey-1.36 at gabe;
 Thu, 09 Apr 2026 18:23:37 UTC
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B99710E057
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 18:23:37 +0000 (UTC)
Message-ID: <afa8bd88-9b9e-42f9-92c8-2c104fcf5c7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1775758562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjvMgV39SyLAC8rt2tzEXPeRjGtutHWHxARV5in/ifM=;
 b=AAAtn5nl+HN90GGjGJ+9aOZ6itXbbEwAX6lvsUQhL03ZG1V7ZxyF+JZcokGw4SMh/02W4T
 KeVZOr8Ds9QobacUYSu50iF+d38rrwt4gdc6pNl6npn67ljG5WHvoBn8E7gcSM44d+w29w
 KaU2VdYeqe/dHo+rZIIvK7XIZWXqRG0=
Date: Thu, 9 Apr 2026 11:15:28 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: fix NULL ptr deref in ISM delayed work
To: Ray Wu <ray.wu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>
References: <20260409072057.1133476-1-ray.wu@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20260409072057.1133476-1-ray.wu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:07:32 +0000
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

On 4/9/26 12:20 AM, Ray Wu wrote:
> dc_destroy() sets dm->dc to NULL before amdgpu_dm_ism_fini() is called,
> leaving a window where in-flight ISM delayed work dereferences the stale
> pointer. Call amdgpu_dm_ism_fini() in amdgpu_dm_fini() before dc_destroy().
> 
> Fixes: f5d0d3f3439e ("drm/amd/display: Add Idle state manager(ISM)")
> Signed-off-by: Ray Wu <ray.wu@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 9 +++++++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 7 ++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bac02ea15b8a..bb79b6bed3c4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2236,6 +2236,8 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
>  static void amdgpu_dm_fini(struct amdgpu_device *adev)
>  {
>  	int i;
> +	struct drm_crtc *crtc;
> +	struct amdgpu_crtc *acrtc;
>  
>  	if (adev->dm.vblank_control_workqueue) {
>  		destroy_workqueue(adev->dm.vblank_control_workqueue);
> @@ -2252,6 +2254,13 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>  		adev->dm.idle_workqueue = NULL;
>  	}
>  
> +	/* Finalize ISM for each CRTC before dc_destroy() sets dm->dc to NULL */
> +	drm_for_each_crtc(crtc, adev_to_drm(adev)) {
> +		acrtc = to_amdgpu_crtc(crtc);
> +		amdgpu_dm_ism_fini(&acrtc->ism);
> +
> +	}
> +
>  	amdgpu_dm_destroy_drm_device(&adev->dm);
>  
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 26f3d513576b..de203445e084 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -459,7 +459,12 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
>  {
>  	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>  
> -	amdgpu_dm_ism_fini(&acrtc->ism);
> +	/*
> +	 * amdgpu_dm_ism_fini() is intentionally called in amdgpu_dm_fini().
> +	 * It must be called before dc_destroy() in amdgpu_dm_fini()
> +	 * to avoid ISM accessing an invalid dc handle once dc is released.
> +	 */

I'm seeing a new build warning with this hunk:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crtc.c: In function ‘amdgpu_dm_crtc_destroy’:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crtc.c:460:29: warning: unused variable ‘acrtc’ [-Wunused-variable]
  460 |         struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
      |                             ^~~~~

This diff resolved it:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index de203445e0844..40c5f74dbe2b6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -457,8 +457,6 @@ static struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *cr
 
 static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 {
-	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-
 	/*
 	 * amdgpu_dm_ism_fini() is intentionally called in amdgpu_dm_fini().
 	 * It must be called before dc_destroy() in amdgpu_dm_fini()

Thanks,
Matt

> +
>  	drm_crtc_cleanup(crtc);
>  	kfree(crtc);
>  }

