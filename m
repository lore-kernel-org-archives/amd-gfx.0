From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Unify the dm resume calls into one
Date: Mon, 5 Feb 2018 16:35:19 -0500
Message-ID: <31a666c6-98b5-c29c-6165-c134b3bfe213@amd.com>
References: <1517865269-15199-1-git-send-email-mikita.lipski@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0915542511=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1517865269-15199-1-git-send-email-mikita.lipski-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: mikita.lipski-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org

This is a multi-part message in MIME format.
--===============0915542511==
Content-Type: multipart/alternative;
 boundary="------------927DC71061DD3A49DBE6D65B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------927DC71061DD3A49DBE6D65B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Andrey Grodzovsky<andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

Andrey


On 02/05/2018 04:14 PM, mikita.lipski-5C7GfCeVMHo@public.gmane.org wrote:
> From: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
>
> amdgpu_dm_display_resume is now called from dm_resume to
> unify DAL resume call into a single function call
>
> There is no more need to separately call 2 resume functions
> for DM.
>
> Initially they were separated to resume display state after
> cursor is pinned. But because there is no longer any corruption
> with the cursor - the calls can be merged into one function hook.
>
> Signed-off-by: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 10 +---------
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +++-
>   2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 850453e..0aaba27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2287,14 +2287,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool resume, bool fbcon)
>   				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
>   			}
>   			drm_modeset_unlock_all(dev);
> -		} else {
> -			/*
> -			 * There is no equivalent atomic helper to turn on
> -			 * display, so we defined our own function for this,
> -			 * once suspend resume is supported by the atomic
> -			 * framework this will be reworked
> -			 */
> -			amdgpu_dm_display_resume(adev);
>   		}
>   	}
>   
> @@ -2515,6 +2507,7 @@ static int amdgpu_device_reset(struct amdgpu_device *adev,
>   				goto out;
>   
>   			r = amdgpu_device_ip_resume_phase2(adev);
> +
>   			if (r)
>   				goto out;
>   
> @@ -2729,7 +2722,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	if (amdgpu_device_has_dc_support(adev)) {
>   		if (drm_atomic_helper_resume(adev->ddev, state))
>   			dev_info(adev->dev, "drm resume failed:%d\n", r);
> -		amdgpu_dm_display_resume(adev);
>   	} else {
>   		drm_helper_resume_force_mode(adev->ddev);
>   	}
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ac82382..8e6e60e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -659,11 +659,13 @@ static int dm_resume(void *handle)
>   {
>   	struct amdgpu_device *adev = handle;
>   	struct amdgpu_display_manager *dm = &adev->dm;
> +	int ret = 0;
>   
>   	/* power on hardware */
>   	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>   
> -	return 0;
> +	ret = amdgpu_dm_display_resume(adev);
> +	return ret;
>   }
>   
>   int amdgpu_dm_display_resume(struct amdgpu_device *adev)


--------------927DC71061DD3A49DBE6D65B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <pre wrap="">Reviewed-by: Andrey Grodzovsky <font color="#000000"><a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a></font>

Andrey 
</pre>
    <br>
    <div class="moz-cite-prefix">On 02/05/2018 04:14 PM,
      <a class="moz-txt-link-abbreviated" href="mailto:mikita.lipski-5C7GfCeVMHo@public.gmane.org">mikita.lipski-5C7GfCeVMHo@public.gmane.org</a> wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1517865269-15199-1-git-send-email-mikita.lipski-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">From: Mikita Lipski <a class="moz-txt-link-rfc2396E" href="mailto:mikita.lipski-5C7GfCeVMHo@public.gmane.org">&lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;</a>

amdgpu_dm_display_resume is now called from dm_resume to
unify DAL resume call into a single function call

There is no more need to separately call 2 resume functions
for DM.

Initially they were separated to resume display state after
cursor is pinned. But because there is no longer any corruption
with the cursor - the calls can be merged into one function hook.

Signed-off-by: Mikita Lipski <a class="moz-txt-link-rfc2396E" href="mailto:mikita.lipski-5C7GfCeVMHo@public.gmane.org">&lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 10 +---------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 850453e..0aaba27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2287,14 +2287,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool resume, bool fbcon)
 				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
 			}
 			drm_modeset_unlock_all(dev);
-		} else {
-			/*
-			 * There is no equivalent atomic helper to turn on
-			 * display, so we defined our own function for this,
-			 * once suspend resume is supported by the atomic
-			 * framework this will be reworked
-			 */
-			amdgpu_dm_display_resume(adev);
 		}
 	}
 
@@ -2515,6 +2507,7 @@ static int amdgpu_device_reset(struct amdgpu_device *adev,
 				goto out;
 
 			r = amdgpu_device_ip_resume_phase2(adev);
+
 			if (r)
 				goto out;
 
@@ -2729,7 +2722,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (amdgpu_device_has_dc_support(adev)) {
 		if (drm_atomic_helper_resume(adev-&gt;ddev, state))
 			dev_info(adev-&gt;dev, "drm resume failed:%d\n", r);
-		amdgpu_dm_display_resume(adev);
 	} else {
 		drm_helper_resume_force_mode(adev-&gt;ddev);
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ac82382..8e6e60e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -659,11 +659,13 @@ static int dm_resume(void *handle)
 {
 	struct amdgpu_device *adev = handle;
 	struct amdgpu_display_manager *dm = &amp;adev-&gt;dm;
+	int ret = 0;
 
 	/* power on hardware */
 	dc_set_power_state(dm-&gt;dc, DC_ACPI_CM_POWER_STATE_D0);
 
-	return 0;
+	ret = amdgpu_dm_display_resume(adev);
+	return ret;
 }
 
 int amdgpu_dm_display_resume(struct amdgpu_device *adev)
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------927DC71061DD3A49DBE6D65B--

--===============0915542511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0915542511==--
