From: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: fix locking in
 smu_feature_set_supported()
Date: Wed, 15 May 2019 09:53:33 +0000
Message-ID: <MN2PR12MB33099BF7946484E6AE1F75F5EC090@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20190515095130.GF3409@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515095130.GF3409@mwanda>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Gao, Likun" <Likun.Gao@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, May 15, 2019 5:52 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang)
> <Kevin1.Wang@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
> <daniel@ffwll.ch>; Huang, Ray <Ray.Huang@amd.com>; Gao, Likun
> <Likun.Gao@amd.com>; Gui, Jack <Jack.Gui@amd.com>; amd-
> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] drm/amd/powerplay: fix locking in
> smu_feature_set_supported()
>=20
> There is a typo so the code unlocks twice instead of taking the lock and =
then
> releasing it.
>=20
> Fixes: f14a323db5b0 ("drm/amd/powerplay: implement update enabled
> feature state to smc for smu11")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20

Thanks!
Reviewed-by: Huang Rui <ray.huang@amd.com>

Will apply it.

---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 52d919a8b70a..85ac29af5363 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -310,7 +310,7 @@ int smu_feature_set_supported(struct smu_context
> *smu, int feature_id,
>=20
>         WARN_ON(feature_id > feature->feature_num);
>=20
> -       mutex_unlock(&feature->mutex);
> +       mutex_lock(&feature->mutex);
>         if (enable)
>                 test_and_set_bit(feature_id, feature->supported);
>         else
> --
> 2.20.1
