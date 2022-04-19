Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C32EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 14:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B0410E7BF;
	Tue, 19 Apr 2022 14:04:10 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFE110E7BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 14:04:07 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae90d.dynamic.kabel-deutschland.de
 [95.90.233.13])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 69FF861CCD787;
 Tue, 19 Apr 2022 16:04:05 +0200 (CEST)
Message-ID: <6729c3d4-c3e9-d3d8-d23a-3892384794f6@molgen.mpg.de>
Date: Tue, 19 Apr 2022 16:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220413201522.2084041-1-alexander.deucher@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220413201522.2084041-1-alexander.deucher@amd.com>
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
Cc: Michele Ballabio <ballabio.m@gmail.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex,


Thank you for the patch.

Am 13.04.22 um 22:15 schrieb Alex Deucher:
> We normally runtime suspend when there are displays attached if they
> are in the DPMS off state, however, if something wakes the GPU
> we send a hotplug event on resume (in case any displays were connected
> while the GPU was in suspend) which can cause userspace to light
> up the displays again soon after they were turned off.
> 
> Prior to
> commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's."),
> the driver took a runtime pm reference when the fbdev emulation was
> enabled because we didn't implement proper shadowing support for
> vram access when the device was off so the device never runtime
> suspended when there was a console bound.  Once that commit landed,
> we now utilize the core fb helper implementation which properly
> handles the emulation, so runtime pm now suspends in cases where it did
> not before.  Ultimately, we need to sort out why runtime suspend in not
> working in this case for some users, but this should restore similar
> behavior to before.
> 
> v2: move check into runtime_suspend
> 
> Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
> Tested-by: Michele Ballabio <ballabio.m@gmail.com>

On what system and device?

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 107 ++++++++++++++++--------
>   1 file changed, 72 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4efaa183abcd..97a1aa02d76e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2395,6 +2395,71 @@ static int amdgpu_pmops_restore(struct device *dev)
>   	return amdgpu_device_resume(drm_dev, true);
>   }
>   
> +static int amdgpu_runtime_idle_check_display(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +
> +	if (adev->mode_info.num_crtc) {
> +		struct drm_connector *list_connector;
> +		struct drm_connector_list_iter iter;
> +		int ret = 0;
> +
> +		/* XXX: Return busy if any displays are connected to avoid
> +		 * possible display wake ups after runtime resume due to

Nit: wakeups

> +		 * hotplug events in case any displays were connected while
> +		 * the GPU was in suspend.  Remove this once that is fixed.
> +		 */

Do you have an (internal) issue to track this?

> +		mutex_lock(&drm_dev->mode_config.mutex);
> +		drm_connector_list_iter_begin(drm_dev, &iter);
> +		drm_for_each_connector_iter(list_connector, &iter) {
> +			if (list_connector->status == connector_status_connected) {
> +				ret = -EBUSY;
> +				break;
> +			}
> +		}
> +		drm_connector_list_iter_end(&iter);
> +		mutex_unlock(&drm_dev->mode_config.mutex);
> +
> +		if (ret)
> +			return ret;
> +
> +		if (amdgpu_device_has_dc_support(adev)) {
> +			struct drm_crtc *crtc;
> +
> +			drm_for_each_crtc(crtc, drm_dev) {
> +				drm_modeset_lock(&crtc->mutex, NULL);
> +				if (crtc->state->active)
> +					ret = -EBUSY;
> +				drm_modeset_unlock(&crtc->mutex);
> +				if (ret < 0)
> +					break;
> +			}
> +		} else {
> +			mutex_lock(&drm_dev->mode_config.mutex);
> +			drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> +
> +			drm_connector_list_iter_begin(drm_dev, &iter);
> +			drm_for_each_connector_iter(list_connector, &iter) {
> +				if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> +					ret = -EBUSY;
> +					break;
> +				}
> +			}
> +
> +			drm_connector_list_iter_end(&iter);
> +
> +			drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> +			mutex_unlock(&drm_dev->mode_config.mutex);
> +		}
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -2407,6 +2472,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   		return -EBUSY;
>   	}
>   
> +	ret = amdgpu_runtime_idle_check_display(dev);
> +	if (ret)
> +		return ret;
> +
>   	/* wait for all rings to drain before suspending */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> @@ -2516,41 +2585,9 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>   		return -EBUSY;
>   	}
>   
> -	if (amdgpu_device_has_dc_support(adev)) {
> -		struct drm_crtc *crtc;
> -
> -		drm_for_each_crtc(crtc, drm_dev) {
> -			drm_modeset_lock(&crtc->mutex, NULL);
> -			if (crtc->state->active)
> -				ret = -EBUSY;
> -			drm_modeset_unlock(&crtc->mutex);
> -			if (ret < 0)
> -				break;
> -		}
> -
> -	} else {
> -		struct drm_connector *list_connector;
> -		struct drm_connector_list_iter iter;
> -
> -		mutex_lock(&drm_dev->mode_config.mutex);
> -		drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> -
> -		drm_connector_list_iter_begin(drm_dev, &iter);
> -		drm_for_each_connector_iter(list_connector, &iter) {
> -			if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> -				ret = -EBUSY;
> -				break;
> -			}
> -		}
> -
> -		drm_connector_list_iter_end(&iter);
> -
> -		drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> -		mutex_unlock(&drm_dev->mode_config.mutex);
> -	}
> -
> -	if (ret == -EBUSY)
> -		DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> +	ret = amdgpu_runtime_idle_check_display(dev);
> +	if (ret)
> +		return ret;
>   
>   	pm_runtime_mark_last_busy(dev);
>   	pm_runtime_autosuspend(dev);

The overall change looks good.


Kind regards,

Paul
