Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3A606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E7l4/NWN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B29810E021;
	Wed, 21 Oct 2026 15:57:02 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBC910E307
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 15:56:56 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-313bab9cfe7so133733eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 08:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792598215; cv=none;
 d=google.com; s=arc-20260327;
 b=m5lDnhmR7ozJfiLniBmxlxMtlL8rfWzLDmcF3bLsYT14mcrSMMGy6SjSuAbjdnM+8s
 9syvuVtLJVBGAnDt7XsBGF2meEWxMJlvwU0z1ZU1e9fCSuUaETuy7beGtWIo7ITB2XIV
 J601Zw3T0krKVvjnsKJ4Y4aHEQrQSV+WSHIMMEIK4Ydc4cArO+bG+tPyAkC6AyTBX98W
 CjUN6U9nRVHdxWEAtWqv6MTFA1PgX0mQ2yjnIaR5c+2e3V62Y3Mb0fNsAYebsLGKFXtK
 amOfYR/i5J6CFuQ9cNmYrL9l3YsPzQj4Q1mBTTSXzeYuASluy22pZi19aiW+48cAPDqe
 t+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R6x6PsKdleLRdGpKQFu+j3eRZNn5i+96zbEG6Fih+/Y=;
 fh=cHZEvNIPcKHiS3Nz+MOo9uv6X88vhLwmcpVUrF7NuOA=;
 b=VgR/mKuEQgEJDGhK+YNthVocKZT6C2jgr+gvztjjeFdVAaRqXXjVTZ7bLfBb6YIHp6
 q6oZrVXFDY5d0GTfjzOBTzozZ8eQcI++p6CuZ8+c8uQV6Ks2GHd/YKfB5xb/3qSnAyos
 gcoGkWt0klaEolhgFGaJ1ToIBIPFJImpwSsojjRihhWiRkYAzJqjkE/RD4kWda5K2plk
 tsxT/tSglCBpU21HHuizpJid0JfNbRrwnP+ZwjOwX9jCPX5V4Dmt8Tue3gRlUmm7z9Dj
 kIKfrVDxp9wGf8nTsce8lUEub523pfyU89ZX+iHwAoEaOk+ra01RKGDbs6nSOVyWOc9d
 NH2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792598215; x=1793203015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R6x6PsKdleLRdGpKQFu+j3eRZNn5i+96zbEG6Fih+/Y=;
 b=E7l4/NWNtGI4UAA3m5LrnAqs1bPQEDSgye3g/6TeliH4uTZCqCyGMmfINYd1qpGbB7
 vgwjVKaTtJ7hTJA/mAky3Po5fO+hTHEbNIOOIizam2/p8TdY5cCZe1AatX6mfn6OFtF4
 NBT3TKYGMf9HOG2yp/u7pDJRSZ5uL8eMkOSYlVnvKmqRK5Z0DYxbV7Bv9+NKjmYxQb6N
 mj58ozrP0mACT8LSovTF1Muu1zr34IyzdvPzog0mtELbHMFs0GsJA0sqR6lbt00qWiiK
 5ryhlD68TOfNvlF8jtNMyo6Jgw9lChMP5z7Fj98GOhlV7HTIr2RedGctv4WtH9NDDL80
 Agnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598215; x=1793203015;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R6x6PsKdleLRdGpKQFu+j3eRZNn5i+96zbEG6Fih+/Y=;
 b=fd+IDyfY8CZdgYsVnIDWXy+PVova0L5o15OnSauGsK+MceGmJzlGkmrHMCrIbFrq/t
 KwvUVz1YiTVw1EjNbEF28FOE5Hf9vTgwR7d3dc1+INaM9x6+rDOeurkzS5Fcfv173Tbn
 0bqsUzWBxdEbd6i+R8SAEgcfQEEeAk4a5q3Ry1+c4j4NzNOrqM0ItB/snKSkqIL2zudQ
 OIMVr3wXnqONq7nub0104fVlZ10DThmFnNLbdxWERKS1/u1IolaG9IFfIhRk0qbi8VcX
 JxUQ9Hl31la572v5Izuo2ICSWVCvrNYGqjTvOJOYUFRZbvGPgxDKzLhmBjLm6NhewrFg
 09dQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByb4Xf8ZSqmC/iOCMubgl7+FhBrLOSB2eUvG+tc1B4z/O/VJPKQcnhEiQp2OrxVGteh4DOZLtFp@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLVvnbhWlz5ViLwxa6FdRp0mNdfYkIF291ei+RyRvPy+kTYdyej
 1PpJ/tGmjUjRmSyfGIziTR396B5E4dj9I0kar6bQfhkgJbrP1WE6aNf08mzqojBdLvExeR+uCUi
 h+Ga7bP+jRwiyZ2qzglZ8vC2YSVfxnP4=
X-Gm-Gg: AYBFou38sruGIk4ik4Awlh/J+TEcWirBByX2JJSMmVgwF8Co3nD5XmJlIRQJ2RU2REr
 Yotf/KccZLxN9MNpTc5rUQMpXd8zDPMT4IfSk/v8/RWVdsQuCX6V7tfNUKik5Oi1js8yUH8+5AL
 58dcncc9AqKlFWH0AYFz+/Hz63zI/UXLl1tkKdkQdgFPjzbNPRO8jX/kK3uZf+ply2rIJM6u8bR
 bPruhY4ckGk/6uJzN/agGr/w+dWxtXJhvSFIOo85cuD7YPKwLtTasJzhl3JIt+Iy/kyZroWbObd
 pa1kVahiNpB/hawlIhnsPPwr9WR8CB1KSYrXEDmQuiudx1VHceMr7PZLOziWr2+3mNR0pYVGjnG
 iG0FgF5RgOr75U84kkMgfdVsUhmOS0df3N0yb0c+D1NaONdI1tBZaMFjiTpg66KRbzWFvDItioL
 S2ufMMbtcPJd3mgjigHsYUams=
X-Received: by 2002:a05:701b:4301:b0:190:e602:c769 with SMTP id
 a92af1059eb24-190e602c831mr4140871c88.1.1792598215474; Wed, 21 Oct 2026
 08:56:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
 <20261021111003.3371005-9-lingshan.zhu@amd.com>
In-Reply-To: <20261021111003.3371005-9-lingshan.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2026 11:56:44 -0400
X-Gm-Features: AclHuK81MXMZDdGqk8HgxoUiT7esdXoQEg1D3Y-ccyYJ8d99RDRWCxustoOxmvY
Message-ID: <CADnq5_OCp9_drutPypO9qCLWHgxzJDm=k1PZBSTW20SNxLJV8A@mail.gmail.com>
Subject: Re: [PATCH 08/12] drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com, Benjamin.Welton@amd.com,
 Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 7:16=E2=80=AFAM Zhu Lingshan <lingshan.zhu@amd.com>=
 wrote:
>
> This commit implements a new callback set_mqd_perfcount
> in struct amdgpu_mqd. This callback helps setting
> mqd->compute_perfcount_enable from amdgpu_mqd_prop->perfcount_enable.
>
> This is a per-IP callback and it is NULL if an IP does not
> support PMC.
>
> This commit also implements set_mqd_perfcount for GFX11.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 373c52b7022d..5ccaf805adb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -480,12 +480,18 @@ struct amdgpu_mqd_prop {
>         uint32_t ctx_save_area_size;
>         uint32_t ctl_stack_size;
>         bool modify;
> +       /* PMC compute_perfcount_enable that programmed into this queue's=
 MQD */
> +       bool perfcount_enable;
>  };
>
>  struct amdgpu_mqd {
>         unsigned mqd_size;
>         int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>                         struct amdgpu_mqd_prop *p);
> +       /* Per-IP callback to set compute_perfcount_enable,
> +        * NULL when this IP's MQD has no perfcount_enable field.
> +        */
> +       void (*set_mqd_perfcount)(void *mqd, struct amdgpu_mqd_prop *p);

Rather than adding a new callback, just route the update via init_mqd
similar to what Jesse did for the modify queue interface.

Alex

>  };
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 4b5faecf13b9..04e2d857e352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4326,6 +4326,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>
>         mqd->header =3D 0xC0310800;
>         mqd->compute_pipelinestat_enable =3D 0x00000001;
> +       mqd->compute_perfcount_enable =3D prop->perfcount_enable;
>         mqd->compute_static_thread_mgmt_se0 =3D 0xffffffff;
>         mqd->compute_static_thread_mgmt_se1 =3D 0xffffffff;
>         mqd->compute_static_thread_mgmt_se2 =3D 0xffffffff;
> @@ -4466,6 +4467,14 @@ static int gfx_v11_0_compute_mqd_init(struct amdgp=
u_device *adev, void *m,
>         return 0;
>  }
>
> +static void gfx_v11_0_compute_mqd_set_perfcount(void *m,
> +                                               struct amdgpu_mqd_prop *p=
rop)
> +{
> +       struct v11_compute_mqd *mqd =3D m;
> +
> +       mqd->compute_perfcount_enable =3D prop->perfcount_enable;
> +}
> +
>  static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -7270,6 +7279,8 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_d=
evice *adev)
>                 sizeof(struct v11_compute_mqd);
>         adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =3D
>                 gfx_v11_0_compute_mqd_init;
> +       adev->mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =3D
> +               gfx_v11_0_compute_mqd_set_perfcount;
>  }
>
>  static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_=
device *adev,
> --
> 2.53.0
>
