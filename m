From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v4] drm/amdgpu: fix multiple memory leaks in acp_hw_init
Date: Wed, 2 Oct 2019 07:47:37 +0200
Message-ID: <c03a8983-3f83-0596-96fa-a1a9312e82f8@web.de>
References: <20191002034612.26607-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002034612.26607-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

> ---

Why did you omit the patch change log at this place?


>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 34 ++++++++++++++++---------


> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -189,7 +189,7 @@ static int acp_hw_init(void *handle)
=E2=80=A6
> +	struct i2s_platform_data *i2s_pdata =3D NULL;
=E2=80=A6

I propose to reconsider this update suggestion once more.


> @@ -393,6 +396,13 @@ static int acp_hw_init(void *handle)
>  	val &=3D ~ACP_SOFT_RESET__SoftResetAud_MASK;
>  	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
>  	return 0;
> +
> +failure:
> +	kfree(i2s_pdata);
> +	kfree(adev->acp.acp_res);
> +	kfree(adev->acp.acp_cell);
> +	kfree(adev->acp.acp_genpd);
> +	return r;
>  }
>
>  /**

Are you going to follow a known programming guideline?
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es#MEM12-C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandr=
eleasingresources-CompliantSolution%28copy_process%28%29fromLinuxkernel%29

Regards,
Markus
