From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix uninitialized variable pasid_mapping_needed
Date: Fri, 4 Oct 2019 08:54:56 -0400
Message-ID: <CADnq5_N-tdCJ_LUwunwmrj88vAPBbCLD2uwDTBGzB0XJWdak2g@mail.gmail.com>
References: <20191003215227.23540-1-colin.king@canonical.com> <55116b72-4e15-7efe-09a6-283a7090966a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55116b72-4e15-7efe-09a6-283a7090966a@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Colin King <colin.king@canonical.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Oct 4, 2019 at 3:28 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 03.10.19 um 23:52 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The boolean variable pasid_mapping_needed is not initialized and
> > there are code paths that do not assign it any value before it is
> > is read later.  Fix this by initializing pasid_mapping_needed to
> > false.
> >
> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: 6817bf283b2b ("drm/amdgpu: grab the id mgr lock while accessing =
passid_mapping")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

Applied.  thanks!

Alex

> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index a2c797e34a29..be10e4b9a94d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1055,7 +1055,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
> >               id->oa_size !=3D job->oa_size);
> >       bool vm_flush_needed =3D job->vm_needs_flush;
> >       struct dma_fence *fence =3D NULL;
> > -     bool pasid_mapping_needed;
> > +     bool pasid_mapping_needed =3D false;
> >       unsigned patch_offset =3D 0;
> >       int r;
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
