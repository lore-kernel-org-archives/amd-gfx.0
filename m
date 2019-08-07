From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH] drm/amdgpu: replace readq/writeq with atomic64 operations
Date: Wed, 7 Aug 2019 03:09:05 +0000
Message-ID: <20190807105759.58a28ef0@xhacker.debian>
References: <20190807025640.682-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190807025640.682-1-tao.zhou1@amd.com>
Content-Language: en-US
Content-ID: <5E427FF48ECA554D95F17DF5415C85A3@namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tao Zhou <tao.zhou1@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel-build-reports@lists.linaro.org" <kernel-build-reports@lists.linaro.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "dennis.li@amd.com" <dennis.li@amd.com>, "hawking.zhang@amd.com" <hawking.zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 7 Aug 2019 10:56:40 +0800 Tao Zhou wrote:


> 
> 
> readq/writeq are not supported on all architectures
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 558fe6d091ed..7eb9e0b9235a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -272,14 +272,10 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>   */
>  uint64_t amdgpu_mm_rreg64(struct amdgpu_device *adev, uint32_t reg)
>  {
> -       uint64_t ret;
> -
>         if ((reg * 4) < adev->rmmio_size)
> -               ret = readq(((void __iomem *)adev->rmmio) + (reg * 4));
> +               return atomic64_read((atomic64_t *)(adev->rmmio + (reg * 4)));

atomic64_read doesn't equal to readq on some architectures..

>         else
>                 BUG();
> -
> -       return ret;
>  }
> 
>  /**
> @@ -294,7 +290,7 @@ uint64_t amdgpu_mm_rreg64(struct amdgpu_device *adev, uint32_t reg)
>  void amdgpu_mm_wreg64(struct amdgpu_device *adev, uint32_t reg, uint64_t v)
>  {
>         if ((reg * 4) < adev->rmmio_size)
> -               writeq(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> +               atomic64_set((atomic64_t *)(adev->rmmio + (reg * 4)), v);
>         else
>                 BUG();
>  }
> --
> 2.17.1
