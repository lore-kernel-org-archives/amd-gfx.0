Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338AD606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IEam18cI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA5810E5FF;
	Tue, 17 Nov 2026 15:14:44 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689B910E844
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:14:17 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-8629ffd14abso290127a34.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928456; cv=none;
 d=google.com; s=arc-20260327;
 b=aFAaJxHYTY6B5LeuHQKTspDA5H9DoAmA8arxbRJLeUZtMq0Occ6HGYhYv82QkWeoVO
 /uuUgHTIPKcD1oh2vyvI5O8Yw3BRV2l7igrUKX3y0bMGaSuvAaSXCnoqC+7GxE75OIuM
 5UO0dkkQrj3flPJwrwKwCbpl3C5h6PYesL5SEMxWq9x/Pcztl3jq0QMR/E7fF6IrTnkN
 zgCIHGes/ubg/0ud2lM6YgmlIzdJNirA18GtUuTLnpbE7bH6ArlQgQolcsDFKQ3P+uER
 cneIpl6CPtSj0QwXzLbgI/MrXTRpc8xa5RX6KnWn+qjZ43fT55lrZxdGASoYFbSloRep
 ZjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wdW/Ou+Ci0sYqSqPGbaWZ4zFDhr/BFlmACXrJQ3nMh8=;
 fh=SvwrmD57K+MIPOntSyBxLVd6xaqOwLiQ7TUiUirs4cs=;
 b=JHwCXXCNtdr8BcQN7Gd1tDQrDEjFmxoM1YJLBYRb5WgJpQ43+xyWOUWlunV5HYYfVx
 l4xlGpBRC60djlol+rLNm5dnqx0AcW05cUsOL5RxdC2PMoo3TEIJkaBFtL7Dwm5USFVP
 7r1uvWCXFVxOPN2RQwiOezpFa6AXbmpetOR+iXIw7/eS0rgXF4phaKLHBmoOI7zjsliS
 CxpDmVKkSCmRX/ZHeuVx0KfmV/G/AD1/TtjU4bGPcTt5+o2SmCBZRcTptPg+0ZCZH+3S
 Der2rpWZAI0SamAr1VKMmkWiOTmU0OP3dOUDOgnig34vhKWJM7hSqw45hzCy0v/K41wa
 pPPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928456; x=1795533256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wdW/Ou+Ci0sYqSqPGbaWZ4zFDhr/BFlmACXrJQ3nMh8=;
 b=IEam18cI4Og4gyoA/jUsCh60Frl6ybtqO7HysN5QtlDr/nvmQat04YYRCNx+6R5mER
 pE9OZyOg+FfO7ZBACygtX0VWhdg6CDpOkkn/Mfyt0KEcXFILKyYqgdOxGaf3xc0+ZKYk
 XpQZWZ15spLYc2SP/1zbI2z28mzIrLMPqDxcnIJkQL0ft2q8OUgDibdEjDZ0+EcVuSA4
 XdYIJgexSeb4WwvxLI3dMBwyCfvptzNxtfw/WR6mnFzS5m6DI4wQMbWLaciGdbHprcD/
 Q31exayDRl0FP0+NeZGz63QPi2jQf47UDk1AC/hzlonkkxA6hmtQk/RcEKQHNQ6LuZ0Z
 hWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928456; x=1795533256;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wdW/Ou+Ci0sYqSqPGbaWZ4zFDhr/BFlmACXrJQ3nMh8=;
 b=qYrWG84rwMvHFFd4KXNQNCv64ELUtDKqWQRiwS+lBK8bI7CK+/m0RQL2P0n18TjyHi
 vqAldosPT6EvFLPKcrokgYu+8GwD9sdQ35vgvaXfaWRIbt4b1/ajKB0FCd39NAXDClnU
 gOWwkbBFbVbtWW3xAZH+6aA39bW9uAO2MrZ95Bg4thK7JX1tZ0xo5NlAsTDYY65YnhU/
 KPRBPNCPZH36OLlfJhB9pJ8ukB8EL6mkOAwvZT2w/A2nil8Sbr6hohYpcqDABJblBOcW
 9moAUTqBE6yxQNg3nAyOhr7zfnFf8dwcNHEQx0TmWFBXc6ZV2nyuVZEL/NIolrIZl9E2
 Tt1Q==
X-Gm-Message-State: APuU4Z8WidoH2j3KuwAnMb9WlEXxK2CqfT/C2AIFmxjKuLEd93NxZ6AO
 ElFN7Z1q03GHTcRSbcEMpMU/VO6HbBFxVX3ejknOHjMmbxvpUrP4gNwJQNH1d1DVyJYQ2pXeDMT
 Wf28VQ9PJDkd4ucweeMfohY9RW2lOxhI=
X-Gm-Gg: AYBFou1uzr0TXeIG6NmAQVdDCxLcNSgVxHI38W+zIqX45WFadlO2RQSEqfcAXbU3hKp
 8QaBKXSH81ZRzsogGWn8s6ioRG44e65kl2OYJ1poFGVIgpf3ZUTcG2QGL6aoumPx3MBGUJQAiso
 DDGSIWp2JwtoqQTUsmt4ZEHu+pxOhthF1mleR74p9UsalhwoC/d5iO26XEm9d9lq0WG0sbzuj/i
 B1PA8my+NL6vLfJAs1NriRpBegQp+JKI2E92mb6T+Eh2gnaqgr0iaD3hFAF4uu5yFwu76gWucGM
 t4GXmzMwaGZYGFa9ghvq7dCG4czCTSnZ2r2mqsMfwa9ip+rKx8Ebu9Cds4dRrd7xWZTA/ruJFu7
 AjNgpNH8B7LsRjUGAnRZ/+mwsHowmvbvjFlEdzs1htp6+BM0rLjLVuO0hOcC0xAOuBmyV6ZK+n2
 uc6+TCkEHyRZiwM5A8TVvfTYSKeP1bQDMzaCeL8u5JbXoxJuPzeX8/WH46bBMt1BIuws/TkOFhS
 goyc8t4
X-Received: by 2002:a05:6808:1804:b0:53a:5069:cdef with SMTP id
 5614622812f47-56e64dfabbfmr17624967b6e.4.1794928456492; Tue, 17 Nov 2026
 07:14:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109184113.3656539-1-alexander.deucher@amd.com>
 <20261109184113.3656539-2-alexander.deucher@amd.com>
In-Reply-To: <20261109184113.3656539-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:14:04 -0500
X-Gm-Features: AclHuK9vv1-EI3ALbmJE3Qf1kIsGim1HWrgzlywSMGaGEsDG1cBIc-MZpvgY5C8
Message-ID: <CADnq5_PycwwwBr2hzqu12pqZQMH9LNO7ghWF_1N6Fe39coE8iA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Add max_cu_per_engine property
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, David Belanger <david.belanger@amd.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 2:06=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: David Belanger <david.belanger@amd.com>
>
> This property is the max possible number of CU for an engine and consider
> asymmetric configuration.
>
> Signed-off-by: David Belanger <david.belanger@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 4 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h     | 1 +
>  4 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index f10560b65f116..9d500e4d01951 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2168,6 +2168,8 @@ static int amdgpu_discovery_get_gfx_info(struct amd=
gpu_device *adev)
>                 adev->gfx.config.max_cu_per_sh =3D 2 * (le32_to_cpu(gc_in=
fo->v1.gc_num_wgp0_per_sa) +
>                                               le32_to_cpu(gc_info->v1.gc_=
num_wgp1_per_sa));
>                 adev->gfx.config.max_sh_per_se =3D le32_to_cpu(gc_info->v=
1.gc_num_sa_per_se);
> +               adev->gfx.config.max_cu_per_se =3D
> +                       adev->gfx.config.max_sh_per_se * adev->gfx.config=
.max_cu_per_sh;
>                 adev->gfx.config.max_backends_per_se =3D le32_to_cpu(gc_i=
nfo->v1.gc_num_rb_per_se);
>                 adev->gfx.config.max_texture_channel_caches =3D le32_to_c=
pu(gc_info->v1.gc_num_gl2c);
>                 adev->gfx.config.max_gprs =3D le32_to_cpu(gc_info->v1.gc_=
num_gprs);
> @@ -2208,6 +2210,7 @@ static int amdgpu_discovery_get_gfx_info(struct amd=
gpu_device *adev)
>                                            le32_to_cpu(gc_info->v1_4.gc_n=
um_twgp1_per_sa1);
>                         adev->gfx.config.max_cu_per_sh =3D 2 * (num_wgps_=
per_sa >=3D num_wgps_per_sa1 ?
>                                                               num_wgps_pe=
r_sa : num_wgps_per_sa1);
> +                       adev->gfx.config.max_cu_per_se =3D 2 * (num_wgps_=
per_sa + num_wgps_per_sa1);
>                 } else if (le16_to_cpu(gc_info->v1.header.version_minor) =
>=3D 3) {
>                         adev->gfx.config.gc_tcp_size_per_cu =3D le32_to_c=
pu(gc_info->v1_3.gc_tcp_size_per_cu);
>                         adev->gfx.config.gc_tcp_cache_line_size =3D le32_=
to_cpu(gc_info->v1_3.gc_tcp_cache_line_size);
> @@ -2229,12 +2232,15 @@ static int amdgpu_discovery_get_gfx_info(struct a=
mdgpu_device *adev)
>                                            le32_to_cpu(gc_info->v1_5.gc_n=
um_wgp1_per_sa1);
>                         adev->gfx.config.max_cu_per_sh =3D num_wgps_per_s=
a >=3D num_wgps_per_sa1 ?
>                                                          num_wgps_per_sa =
: num_wgps_per_sa1;
> +                       adev->gfx.config.max_cu_per_se =3D 2 * (num_wgps_=
per_sa + num_wgps_per_sa1);
>                 }
>                 break;
>         case 2:
>                 adev->gfx.config.max_shader_engines =3D le32_to_cpu(gc_in=
fo->v2.gc_num_se);
>                 adev->gfx.config.max_cu_per_sh =3D le32_to_cpu(gc_info->v=
2.gc_num_cu_per_sh);
>                 adev->gfx.config.max_sh_per_se =3D le32_to_cpu(gc_info->v=
2.gc_num_sh_per_se);
> +               adev->gfx.config.max_cu_per_se =3D
> +                       adev->gfx.config.max_sh_per_se * adev->gfx.config=
.max_cu_per_sh;
>                 adev->gfx.config.max_backends_per_se =3D le32_to_cpu(gc_i=
nfo->v2.gc_num_rb_per_se);
>                 adev->gfx.config.max_texture_channel_caches =3D le32_to_c=
pu(gc_info->v2.gc_num_tccs);
>                 adev->gfx.config.max_gprs =3D le32_to_cpu(gc_info->v2.gc_=
num_gprs);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 5939e1fb3b241..e4458b5e35380 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -238,6 +238,7 @@ struct amdgpu_gfx_config {
>         unsigned max_tile_pipes;
>         unsigned max_cu_per_sh;
>         unsigned max_sh_per_se;
> +       unsigned max_cu_per_se;
>         unsigned max_backends_per_se;
>         unsigned max_texture_channel_caches;
>         unsigned max_gprs;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 1ef4d26a0ac69..af0c161c520dd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -466,6 +466,8 @@ static ssize_t node_show(struct kobject *kobj, struct=
 attribute *attr,
>                               dev->node_props.cu_per_simd_array);
>         sysfs_show_32bit_prop(buffer, offs, "simd_per_cu",
>                               dev->node_props.simd_per_cu);
> +       sysfs_show_32bit_prop(buffer, offs, "max_cu_per_engine",
> +                             dev->node_props.max_cu_per_engine);
>         sysfs_show_32bit_prop(buffer, offs, "max_slots_scratch_cu",
>                               dev->node_props.max_slots_scratch_cu);
>         sysfs_show_32bit_prop(buffer, offs, "gfx_target_version",
> @@ -2100,6 +2102,8 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>         dev->node_props.simd_arrays_per_engine =3D
>                 gfx_info->max_sh_per_se;
>
> +       dev->node_props.max_cu_per_engine =3D gpu->adev->gfx.config.max_c=
u_per_se;
> +
>         dev->node_props.gfx_target_version =3D
>                                 gpu->kfd->device_info.gfx_target_version;
>         dev->node_props.vendor_id =3D gpu->adev->pdev->vendor;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.h
> index ad63ba67b5774..0f29da44c45ae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -62,6 +62,7 @@ struct kfd_node_properties {
>         uint32_t simd_arrays_per_engine;
>         uint32_t cu_per_simd_array;
>         uint32_t simd_per_cu;
> +       uint32_t max_cu_per_engine;
>         uint32_t max_slots_scratch_cu;
>         uint32_t engine_id;
>         uint32_t gfx_target_version;
> --
> 2.56.0
>
