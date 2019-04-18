From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] drm/amd/amdgpu: fix spelling mistake "recieve" ->
 "receive"
Date: Thu, 18 Apr 2019 16:10:14 +0530
Message-ID: <541d2a2a-bcdf-5c4f-b075-7ca128757a45@codeaurora.org>
References: <20190418102510.10253-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418102510.10253-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org


On 4/18/2019 3:55 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 6a0fcd67662a..aef9d059ae52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -515,7 +515,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>   
>   	/* wait until RCV_MSG become 3 */
>   	if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
> -		pr_err("failed to recieve FLR_CMPL\n");
> +		pr_err("failed to receive FLR_CMPL\n");
>   		return;
>   	}
>   
