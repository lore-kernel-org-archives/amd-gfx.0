Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63589C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 13:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C0810F039;
	Tue, 17 May 2022 13:13:09 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68987112FE6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 10:06:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 07E44B81803;
 Tue, 17 May 2022 10:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF4FC385B8;
 Tue, 17 May 2022 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652782012;
 bh=NMoilscLmc4PgSYU3AERGYXDODbll8nGlk8mFWQ/E+Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VDBl6/O+U+ffk25lnOuexCCDsFAZIusrbJup1PFWyJtlhRwaXWmv+h5JNiHWdoJpT
 XNddlZSGY0izGxPw45GFl9BAJkwVN8bhlBpOEwq+jIQfC3f/0ooWEUZNxvGTtoIoqP
 Oj8ffsrSXAsvmqwRzSwcO8aDd7iW46/PfQ0x/NGc=
Date: Tue, 17 May 2022 12:06:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: Re: [PATCH 1/1] radeon: fix a possible null pointer dereference
Message-ID: <YoNzt4jkENOakdYF@kroah.com>
References: <20220517095700.7291-1-ruc_gongyuanjun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517095700.7291-1-ruc_gongyuanjun@163.com>
X-Mailman-Approved-At: Tue, 17 May 2022 13:13:09 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 17, 2022 at 05:57:00PM +0800, Yuanjun Gong wrote:
> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
> 
> In radeon_fp_native_mode(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> The failure status of drm_cvt_mode() on the other path is checked too.
> 
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 0cb1345c6ba4..fabe4f4ca124 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -473,6 +473,8 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
>  	    native_mode->vdisplay != 0 &&
>  	    native_mode->clock != 0) {
>  		mode = drm_mode_duplicate(dev, native_mode);
> +		if (!mode)
> +			return NULL;
>  		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>  		drm_mode_set_name(mode);
>  
> @@ -487,6 +489,8 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
>  		 * simpler.
>  		 */
>  		mode = drm_cvt_mode(dev, native_mode->hdisplay, native_mode->vdisplay, 60, true, false, false);
> +		if (!mode)
> +			return NULL;
>  		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>  		DRM_DEBUG_KMS("Adding cvt approximation of native panel mode %s\n", mode->name);
>  	}
> -- 
> 2.17.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
