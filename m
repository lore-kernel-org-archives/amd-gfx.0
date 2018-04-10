From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
Date: Tue, 10 Apr 2018 20:49:14 +0200
Message-ID: <a267625f-259d-d873-f727-76531d86429b@amd.com>
References: <1523384705-3976-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1523384705-3976-1-git-send-email-okaya@codeaurora.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sinan Kaya <okaya@codeaurora.org>, amd-gfx@lists.freedesktop.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: Tom St Denis <tom.stdenis@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Roger He <Hongbo.He@amd.com>, Monk Liu <Monk.Liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, linux-arm-kernel@lists.infradead.org
List-Id: amd-gfx.lists.freedesktop.org

Am 10.04.2018 um 20:25 schrieb Sinan Kaya:
> Code is expecing to observe the same number of buffers returned from
> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
> doesn't hold true universally especially for systems with IOMMU.
>
> IOMMU driver tries to combine buffers into a single DMA address as much
> as it can. The right thing is to tell the DMA layer how much combining
> IOMMU can do.

Good catch, but wrong place to set this.

Please move it into the device initialization functions.

Regards,
Christian.

>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e4bb435..02465cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -787,6 +787,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   	enum dma_data_direction direction = write ?
>   		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
>   
> +	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
> +
>   	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
>   				      ttm->num_pages << PAGE_SHIFT,
>   				      GFP_KERNEL);
