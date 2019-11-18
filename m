From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/powerplay: fix dereference before null
 check of pointer hwmgr
Date: Mon, 18 Nov 2019 12:47:49 -0500
Message-ID: <CADnq5_ODJOk3vV1QBQRQkMxZTa5reBqsPy-Q+1rrEBw4dJEtoQ@mail.gmail.com>
References: <20191115094754.40920-1-colin.king@canonical.com> <MN2PR12MB3344F8D7498FC9DA8302AD05E44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR12MB3344F8D7498FC9DA8302AD05E44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: Colin King <colin.king@canonical.com>, Rex Zhu <rex.zhu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  Thanks!

Alex

On Mon, Nov 18, 2019 at 1:56 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: Colin King <colin.king@canonical.com>
> Sent: Friday, November 15, 2019 5:48 PM
> To: Rex Zhu <rex.zhu@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Deucher, A=
lexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@a=
md.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; David Airlie <airlied=
@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-gfx@lists.freedesktop.org;=
 dri-devel@lists.freedesktop.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH][next] drm/amdgpu/powerplay: fix dereference before null =
check of pointer hwmgr
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The assignment of adev dereferences pointer hwmgr before hwmgr is null ch=
ecked, hence there is a potential null pointer deference issue. Fix this by=
 assigning adev after the null check.
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 0896d2f7ba4d ("drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/dr=
m/amd/powerplay/hwmgr/hwmgr.c
> index 443625c83ec9..d2909c91d65b 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> @@ -81,7 +81,7 @@ static void hwmgr_init_workload_prority(struct pp_hwmgr=
 *hwmgr)
>
>  int hwmgr_early_init(struct pp_hwmgr *hwmgr)  {
> -       struct amdgpu_device *adev =3D hwmgr->adev;
> +       struct amdgpu_device *adev;
>
>         if (!hwmgr)
>                 return -EINVAL;
> @@ -96,6 +96,8 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
>         hwmgr_init_workload_prority(hwmgr);
>         hwmgr->gfxoff_state_changed_by_workload =3D false;
>
> +       adev =3D hwmgr->adev;
> +
>         switch (hwmgr->chip_family) {
>         case AMDGPU_FAMILY_CI:
>                 adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
