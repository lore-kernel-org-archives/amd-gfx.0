From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add new VegaM pci id
Date: Fri, 21 Dec 2018 11:36:41 -0500
Message-ID: <CADnq5_Mkx9EHq1ZjdRUbpuLVnyNQ-frSHNu3N41z0ftp5Wvymw@mail.gmail.com>
References: <20181220151017.11077-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181220151017.11077-1-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

ping?

On Thu, Dec 20, 2018 at 10:10 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Add a new pci id.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 9c77eaa45982..c806f984bcc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -865,6 +865,7 @@ static const struct pci_device_id pciidlist[] = {
>         /* VEGAM */
>         {0x1002, 0x694C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGAM},
>         {0x1002, 0x694E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGAM},
> +       {0x1002, 0x694F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGAM},
>         /* Vega 10 */
>         {0x1002, 0x6860, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
>         {0x1002, 0x6861, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
> --
> 2.13.6
>
