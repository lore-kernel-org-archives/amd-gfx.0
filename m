From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu/gfx9: Raven has two MECs
Date: Wed, 7 Jun 2017 15:31:23 -0400
Message-ID: <728d2100-061f-f041-d3e1-3185a9064d37@amd.com>
References: <1496848229-12761-1-git-send-email-alexander.deucher@amd.com>
 <1496848229-12761-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0306426016=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496848229-12761-3-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0306426016==
Content-Type: multipart/alternative;
 boundary="------------91AE5B4B16C958E01CE49966"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------91AE5B4B16C958E01CE49966
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


On 2017-06-07 11:10 AM, Alex Deucher wrote:
> This was missed when Andres' queue patches were rebased.
>
> Fixes: 42794b27 (drm/amdgpu: take ownership of per-pipe configuration v3)
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 3ea0e71..e0193e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -872,6 +872,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>   
>   	switch (adev->asic_type) {
>   	case CHIP_VEGA10:
> +	case CHIP_RAVEN:
>   		adev->gfx.mec.num_mec = 2;
>   		break;
>   	default:


--------------91AE5B4B16C958E01CE49966
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Reviewed-by: Alex Xie <a class="moz-txt-link-rfc2396E"
        href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
    <br>
    <div class="moz-cite-prefix">On 2017-06-07 11:10 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1496848229-12761-3-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">This was missed when Andres' queue patches were rebased.

Fixes: 42794b27 (drm/amdgpu: take ownership of per-pipe configuration v3)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3ea0e71..e0193e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -872,6 +872,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 
 	switch (adev-&gt;asic_type) {
 	case CHIP_VEGA10:
+	case CHIP_RAVEN:
 		adev-&gt;gfx.mec.num_mec = 2;
 		break;
 	default:
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------91AE5B4B16C958E01CE49966--

--===============0306426016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0306426016==--
