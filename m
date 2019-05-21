From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
Date: Mon, 20 May 2019 22:32:49 -0400
Message-ID: <CADnq5_O=PAK3qZJ-kHUX9jQDkmEYOX+iOhOX7gNaaXp+tC7nUg@mail.gmail.com>
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
 <SN6PR12MB2800A7AEC22121C8704CBB09870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190520162807.GE21222@phenom.ffwll.local> <SN6PR12MB28007ED8F5C6838F2C25A9D587060@SN6PR12MB2800.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SN6PR12MB28007ED8F5C6838F2C25A9D587060@SN6PR12MB2800.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, xiaolinkui <xiaolinkui@kylinos.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, May 20, 2019 at 7:19 PM Pan, Xinhui <Xinhui.Pan@amd.com> wrote:
>
> Daniel, what you are talking about is totally wrong.
> 1) AFAIK, only one zero-size array can be in the end of a struct.
> 2) two struct_size will add up struct itself twice. the sum is wrong then=
.
>
> No offense. I can't help feeling lucky that you are in intel.

Xinhui,

Please keep things civil.  There is no need for comments like this.

Alex

>
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Daniel Vetter <daniel.vetter@ffwll.ch> =E4=
=BB=A3=E8=A1=A8 Daniel Vetter <daniel@ffwll.ch>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B45=E6=9C=8821=E6=97=A5 =
0:28
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Pan, Xinhui
> =E6=8A=84=E9=80=81: Deucher, Alexander; Koenig, Christian; Zhou, David(Ch=
unMing); airlied@linux.ie; daniel@ffwll.ch; Quan, Evan; xiaolinkui; amd-gfx=
@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.=
kernel.org
> =E4=B8=BB=E9=A2=98: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
>
> [CAUTION: External Email]
>
> On Fri, May 17, 2019 at 04:44:30PM +0000, Pan, Xinhui wrote:
> > I am going to put more members which are also array after this struct,
> > not only obj[].  Looks like this struct_size did not help on multiple
> > array case. Thanks anyway.  ________________________________
>
> You can then add them up, e.g. kmalloc(struct_size()+struct_size(),
> GFP_KERNEL), so this patch here still looks like a good idea.
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Cheers, Daniel
>
> > From: xiaolinkui <xiaolinkui@kylinos.cn>
> > Sent: Friday, May 17, 2019 4:46:00 PM
> > To: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); airli=
ed@linux.ie; daniel@ffwll.ch; Pan, Xinhui; Quan, Evan
> > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; lin=
ux-kernel@vger.kernel.org; xiaolinkui@kylinos.cn
> > Subject: [PATCH] gpu: drm: use struct_size() in kmalloc()
> >
> > [CAUTION: External Email]
> >
> > Use struct_size() helper to keep code simple.
> >
> > Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
> > index 22bd21e..4717a64 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
> >         if (con)
> >                 return 0;
> >
> > -       con =3D kmalloc(sizeof(struct amdgpu_ras) +
> > -                       sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_C=
OUNT,
> > +       con =3D kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
> >                         GFP_KERNEL|__GFP_ZERO);
> >         if (!con)
> >                 return -ENOMEM;
> > --
> > 2.7.4
> >
> >
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
