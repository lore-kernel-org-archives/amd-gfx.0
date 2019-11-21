From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: remove redundant assignment to pointer write_frame
Date: Thu, 21 Nov 2019 13:35:59 -0500
Message-ID: <CADnq5_OGNUUvixju5qJf7Q_iYu--LAD3LWhXB4pkQFpjS5HpMQ@mail.gmail.com>
References: <20191121165401.405845-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191121165401.405845-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Thu, Nov 21, 2019 at 11:54 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer write_frame is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 2a8a08aa6eaf..c02f9ffe5c6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1728,7 +1728,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>                         int index)
>  {
>         unsigned int psp_write_ptr_reg = 0;
> -       struct psp_gfx_rb_frame *write_frame = psp->km_ring.ring_mem;
> +       struct psp_gfx_rb_frame *write_frame;
>         struct psp_ring *ring = &psp->km_ring;
>         struct psp_gfx_rb_frame *ring_buffer_start = ring->ring_mem;
>         struct psp_gfx_rb_frame *ring_buffer_end = ring_buffer_start +
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
