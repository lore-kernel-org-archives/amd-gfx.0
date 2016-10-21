From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix s3 resume back, uvd dpm randomly
 can't disable.
Date: Fri, 21 Oct 2016 13:07:56 +0200
Message-ID: <c2524a31-254e-54dd-391f-390b1c184117@vodafone.de>
References: <1477044836-21474-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0900559233=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477044836-21474-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0900559233==
Content-Type: multipart/alternative;
 boundary="------------5D7D149856B235FD1344B2A9"

This is a multi-part message in MIME format.
--------------5D7D149856B235FD1344B2A9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.10.2016 um 12:13 schrieb Rex Zhu:
> the value of last_mclk_dpm_enable_mask will be changed if
> other clients(vce,dal) trigger set power state between enable
> and disable uvd dpm.
>
> Change-Id: I5bdca2ff7d401243780c71c8d73fdc1e8febaae1
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org> for the series/./

> ---
>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> index 6ecfc48..966e5bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> @@ -4081,7 +4081,7 @@ static int ci_enable_uvd_dpm(struct amdgpu_device *adev, bool enable)
>   							  pi->dpm_level_enable_mask.mclk_dpm_enable_mask);
>   		}
>   	} else {
> -		if (pi->last_mclk_dpm_enable_mask & 0x1) {
> +		if (pi->uvd_enabled == true) {
>   			pi->uvd_enabled = false;
>   			pi->dpm_level_enable_mask.mclk_dpm_enable_mask |= 1;
>   			amdgpu_ci_send_msg_to_smc_with_parameter(adev,



--------------5D7D149856B235FD1344B2A9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 21.10.2016 um 12:13 schrieb Rex Zhu:<br>
    </div>
    <blockquote
      cite="mid:1477044836-21474-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <pre wrap="">the value of last_mclk_dpm_enable_mask will be changed if
other clients(vce,dal) trigger set power state between enable
and disable uvd dpm.

Change-Id: I5bdca2ff7d401243780c71c8d73fdc1e8febaae1
Signed-off-by: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a></pre>
    </blockquote>
    <br>
    Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> for the
    series<i>.</i><br>
    <br>
    <blockquote
      cite="mid:1477044836-21474-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <pre wrap="">
---
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
index 6ecfc48..966e5bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
@@ -4081,7 +4081,7 @@ static int ci_enable_uvd_dpm(struct amdgpu_device *adev, bool enable)
 							  pi-&gt;dpm_level_enable_mask.mclk_dpm_enable_mask);
 		}
 	} else {
-		if (pi-&gt;last_mclk_dpm_enable_mask &amp; 0x1) {
+		if (pi-&gt;uvd_enabled == true) {
 			pi-&gt;uvd_enabled = false;
 			pi-&gt;dpm_level_enable_mask.mclk_dpm_enable_mask |= 1;
 			amdgpu_ci_send_msg_to_smc_with_parameter(adev,
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------5D7D149856B235FD1344B2A9--

--===============0900559233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0900559233==--
