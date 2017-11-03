From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH] drm/amdgpu/virt: don't dereference undefined 'module'
 struct
Date: Fri, 3 Nov 2017 06:57:30 +0000
Message-ID: <BY2PR1201MB09353D47BD0360CDF2A548F1EB5D0@BY2PR1201MB0935.namprd12.prod.outlook.com>
References: <20171102112619.72157-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102112619.72157-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>, "Liu, Monk" <Monk.Liu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Reviewed-By: Xiangliang Yu <Xiangliang.Yu@amd.com>

Thanks!

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Thursday, November 02, 2017 7:26 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; David Airlie <airlied@linux.ie>; Liu,
> Monk <Monk.Liu@amd.com>; Yu, Xiangliang <Xiangliang.Yu@amd.com>;
> Chen, Horace <Horace.Chen@amd.com>; amd-gfx@lists.freedesktop.org;
> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] drm/amdgpu/virt: don't dereference undefined 'module'
> struct
>=20
> Accessing the THIS_MODULE directly is only possible when modules are
> enabled, otherwise we get a build failure:
>=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c: In function
> 'amdgpu_virt_init_data_exchange':
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:331:20: error: dereferencing
> pointer to incomplete type 'struct module'
>=20
> Further, THIS_MODULE is NULL when the driver is built-in, so the code wou=
ld
> likely cause a NULL pointer dereference.
>=20
> This adds an #ifdef check to avoid the compile-time error, plus a NULL
> pointer check before dereferencing THIS_MODULE. It might be better to fin=
d
> a way to avoid using the module version altogether.
>=20
> Fixes: 2dc8f81e4f82 ("drm/amdgpu: SR-IOV data exchange between PF&VF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e97f80f86005..4e4a476593e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -328,9 +328,11 @@ void amdgpu_virt_init_data_exchange(struct
> amdgpu_device *adev)
>  					sizeof(amdgim_vf2pf_info));
>  				AMDGPU_FW_VRAM_VF2PF_READ(adev,
> driver_version,
>  					&str);
> +#ifdef MODULE
>  				if (THIS_MODULE->version !=3D NULL)
>  					strcpy(str, THIS_MODULE->version);
>  				else
> +#endif
>  					strcpy(str, "N/A");
>  				AMDGPU_FW_VRAM_VF2PF_WRITE(adev,
> driver_cert,
>  					0);
> --
> 2.9.0
