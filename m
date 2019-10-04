From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: remove redundant variable r and
 redundant return statement
Date: Fri, 4 Oct 2019 08:57:25 -0400
Message-ID: <CADnq5_N6WP=gDE=Yqv6CqKs13LkUJzFx9C6YmiU1ua_MSg_uiw@mail.gmail.com>
References: <20191003214049.23067-1-colin.king@canonical.com> <70c50fec-7ab7-3ac9-3f49-d5f2651554e4@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <70c50fec-7ab7-3ac9-3f49-d5f2651554e4@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Colin King <colin.king@canonical.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Oct 4, 2019 at 3:29 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 03.10.19 um 23:40 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a return statement that is not reachable and a variable that
> > is not used.  Remove them.
> >
> > Addresses-Coverity: ("Structurally dead code")
> > Fixes: de7b45babd9b ("drm/amdgpu: cleanup creating BOs at fixed locatio=
n (v2)")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Applied.  Thanks!

Alex

>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 481e4c381083..814159f15633 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1636,7 +1636,6 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struc=
t amdgpu_device *adev)
> >   static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev=
)
> >   {
> >       uint64_t vram_size =3D adev->gmc.visible_vram_size;
> > -     int r;
> >
> >       adev->fw_vram_usage.va =3D NULL;
> >       adev->fw_vram_usage.reserved_bo =3D NULL;
> > @@ -1651,7 +1650,6 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct=
 amdgpu_device *adev)
> >                                         AMDGPU_GEM_DOMAIN_VRAM,
> >                                         &adev->fw_vram_usage.reserved_b=
o,
> >                                         &adev->fw_vram_usage.va);
> > -     return r;
> >   }
> >
> >   /**
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
