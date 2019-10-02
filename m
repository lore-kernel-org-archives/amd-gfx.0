From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove set but not used variable 'pipe'
Date: Wed, 2 Oct 2019 09:44:31 -0400
Message-ID: <CADnq5_N9a+s5stOOX8QaMZXWJ680povytY975QvO0Eu7Y=UBYA@mail.gmail.com>
References: <1569760723-119944-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569760723-119944-1-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yu kuai <yukuai3@huawei.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, yi.zhang@huawei.com, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, zhengbin13@huawei.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Sep 30, 2019 at 3:03 AM yu kuai <yukuai3@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> rivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
> =E2=80=98amdgpu_gfx_graphics_queue_acquire=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:234:16: warning:
> variable =E2=80=98pipe=E2=80=99 set but not used [-Wunused-but-set-variab=
le]
>
> It is never used, so can be removed.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index f9bef31..c1035a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -231,12 +231,10 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu=
_device *adev)
>
>  void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
>  {
> -       int i, queue, pipe, me;
> +       int i, queue, me;
>
>         for (i =3D 0; i < AMDGPU_MAX_GFX_QUEUES; ++i) {
>                 queue =3D i % adev->gfx.me.num_queue_per_pipe;
> -               pipe =3D (i / adev->gfx.me.num_queue_per_pipe)
> -                       % adev->gfx.me.num_pipe_per_me;
>                 me =3D (i / adev->gfx.me.num_queue_per_pipe)
>                       / adev->gfx.me.num_pipe_per_me;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
