From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] drm/amdgpu: fix multiple memory leaks in acp_hw_init
Date: Tue, 1 Oct 2019 13:24:39 +0200
Message-ID: <3e685bb8-8a76-cda7-2118-a317516b2bf5@web.de>
References: <20190930212644.9372-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930212644.9372-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>, Alex Deucher <alexander.deucher@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>, Sven Van Asbroeck <thesven73@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -184,12 +184,12 @@ static struct device *get_mfd_cell_dev(const char =
*device_name, int r)
=E2=80=A6
> +	struct i2s_platform_data *i2s_pdata =3D NULL;
=E2=80=A6

I propose to reconsider this update suggestion.


> @@ -231,20 +231,21 @@ static int acp_hw_init(void *handle)
>  	adev->acp.acp_cell =3D kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
>  							GFP_KERNEL);
>
> -	if (adev->acp.acp_cell =3D=3D NULL)
> -		return -ENOMEM;
=E2=80=A6

I suggest to keep this source code place unchanged (at the moment).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D54ecb8f7028c5eb3d740bb82b0f1d90f=
2df63c5c#n456


> @@ -393,6 +399,13 @@ static int acp_hw_init(void *handle)
>  	val &=3D ~ACP_SOFT_RESET__SoftResetAud_MASK;
>  	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
>  	return 0;
> +
> +failure:
> +	kfree(i2s_pdata);
> +	kfree(adev->acp.acp_res);
> +	kfree(adev->acp.acp_cell);
> +	kfree(adev->acp.acp_genpd);
> +	return ret;
>  }
>
>  /**

I would prefer separate jump targets for efficient exception handling.
Please choose more appropriate labels for this function implementation.


> ---

I suggest to replace this second delimiter by a blank line.

Regards,
Markus
