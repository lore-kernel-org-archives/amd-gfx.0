From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use dev_get_drvdata where possible
Date: Tue, 23 Jul 2019 14:47:52 -0400
Message-ID: <CADnq5_Py-Bj0947A_aj4ORDyg6UA3R5y=3v5FLttzL6nBvixkA@mail.gmail.com>
References: <20190723090449.27589-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723090449.27589-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuhong Yuan <hslester96@gmail.com>
Cc: David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 23, 2019 at 9:36 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index f2e8b4238efd..df82091a29d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1097,16 +1097,14 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>
>  static int amdgpu_pmops_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
>         return amdgpu_device_suspend(drm_dev, true, true);
>  }
>
>  static int amdgpu_pmops_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>
>         /* GPU comes up enabled by the bios on resume */
>         if (amdgpu_device_is_px(drm_dev)) {
> @@ -1120,33 +1118,29 @@ static int amdgpu_pmops_resume(struct device *dev)
>
>  static int amdgpu_pmops_freeze(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
>         return amdgpu_device_suspend(drm_dev, false, true);
>  }
>
>  static int amdgpu_pmops_thaw(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
>         return amdgpu_device_resume(drm_dev, false, true);
>  }
>
>  static int amdgpu_pmops_poweroff(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
>         return amdgpu_device_suspend(drm_dev, true, true);
>  }
>
>  static int amdgpu_pmops_restore(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
>         return amdgpu_device_resume(drm_dev, false, true);
>  }
>
> @@ -1205,8 +1199,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>
>  static int amdgpu_pmops_runtime_idle(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>         struct drm_crtc *crtc;
>
>         if (!amdgpu_device_is_px(drm_dev)) {
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
