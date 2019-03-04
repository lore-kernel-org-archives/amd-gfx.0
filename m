From: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: Fix missing break in switch
 statement
Date: Mon, 4 Mar 2019 14:32:57 +0800
Message-ID: <20190304063256.GC10714@hr-amur2>
References: <20190301212943.GA21585@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190301212943.GA21585@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S++/vW5pZw==?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Mar 01, 2019 at 03:29:43PM -0600, Gustavo A. R. Silva wrote:
> Add missing break statement in order to prevent the code from falling
> through to case SMU_Discrete_DpmTable.
> 
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Fixes: 34a564eaf528 ("drm/amd/powerplay: implement fw image related smum interface for Polaris.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 52abca065764..222fb79d319e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -2330,6 +2330,7 @@ static uint32_t polaris10_get_offsetof(uint32_t type, uint32_t member)
>  		case DRAM_LOG_BUFF_SIZE:
>  			return offsetof(SMU74_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>  		}
> +		break;
>  	case SMU_Discrete_DpmTable:
>  		switch (member) {
>  		case UvdBootLevel:
> -- 
> 2.21.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
