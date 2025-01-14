Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC58AC02183
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 14:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3276610E10A;
	Tue, 14 Jan 2025 14:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AC0mvzDG";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C292810E10A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 14:21:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ef7733a1dcso1250708a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 06:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736864442; x=1737469242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcH6fstpHuxy5MZ1lkm+HgZhlZ1ZdgprakLS0RPEsLw=;
 b=AC0mvzDGqgvIJRR62iUlVWCQDEgoZa8nStlo51KPpIdJAek6O2b4D2zuahOtVR39LR
 qnyZz3nlMepwx6GsHPwzqOysRwq74AjNHp81JhXmtsQF79/NwzjovQdmSGB1VBbDuGSD
 zvbWaS1fwDPaqD1DiC38J/9erFDB7021Ue4H0lk9Tox4pg8wpbS98cDPONPgdiP6nyIv
 f6VDCDGYacdTnBTX17NXyXI1PJwJeaR07yPmoG8W+G/b3iJuEL26cHGt5wC0cXo8RH5s
 Y84pSfATwjGtJBT1LgK1lQ+GZeQ1yzwtM57z3R6oUlO9enT5JcJ3fgtU4t/vyKTP/T0u
 GRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736864442; x=1737469242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcH6fstpHuxy5MZ1lkm+HgZhlZ1ZdgprakLS0RPEsLw=;
 b=ZotcjL1t0wt73lamLnItGeUJpkBIK7P4uUgpkfZXWaRvsAgYfnD8CF+Nqbyum/mfoO
 XlgnqkP4u11uCOKOOxHbo8mrfpn83SLvwErwQ092nofQnsMaoq0Op+zuHme62J8Jb0Np
 uhToZ2oNXNFkRcIi7rEBnu5NUq2RKk9kzENxjCHJt1J3eAeJusAF4Xr0jdCw2cGjlhsc
 ZlJewUPKfpfeF6Uro953JZMTIog0M3tLFIciOU/s62qrNY4VfPNY5svszH+HTpJAzf4v
 0ywNKw/3UOdNu6if/otuoeDclZDSBGmzf5qhVeEmG+gdEIwqIT4pBy0LXeJVUqTTnDfK
 k7xA==
X-Gm-Message-State: AOJu0Yz7PDkl/cUn+el2KFqJv45ok8fTwoOCO4QuvKRlY3pKReEtUaJH
 zPt7K1oc/5ufuFKcp/TjsRmRPUXIfOx+Sax8H/w0q1kJukEZser+5N91Pizbqj3LeX+nCbmtxf2
 /yW0DSwtr567FwWz4zCjYVyD+xjo=
X-Gm-Gg: ASbGncvU3EoIMlAblIJQ0T2G8JT0eNuqV4syUNy0IjC789Myh1wLL9QpQ7MdH2BMZBx
 n4GeMOq6YF00kRlATBAHO8zALZk4y58WzGJgUBg==
X-Google-Smtp-Source: AGHT+IFaIL/JdaDLv6EWVlq656abQxfwsg8erSF2BEwN/14BB+us7EjNasy6wPoqTFYVj+FVHRlKQSFlr9o0Rvlop/A=
X-Received: by 2002:a17:90b:2c8c:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2f548f05913mr14257726a91.1.1736864442239; Tue, 14 Jan 2025
 06:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20250110052150.3295085-1-jesse.zhang@amd.com>
 <DM4PR12MB51529B4159FB4FEEFEC4D845E3182@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51529B4159FB4FEEFEC4D845E3182@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jan 2025 09:20:30 -0500
X-Gm-Features: AbW1kvbtrf3w8WSFW5LgdJoILaEOK3CbTPVpoI7pA35XS3O5feiQh3um0JwQ9iw
Message-ID: <CADnq5_M-z80PvxeMTme22A4VvXJS0WsVcHxtCAi9HQgHvxXZ4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 V2] drm/amdgpu/gfx10: implement iqueue reset via MMIO
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Huang, Tim" <Tim.Huang@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 13, 2025 at 8:27=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping ...
>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Friday, January 10, 2025 1:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhu, Jiadong <Jiad=
ong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie=
) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/2 V2] drm/amdgpu/gfx10: implement iqueue reset via MMIO
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> Using mmio to do queue reset.
>
> v2: Alignment this function with gfx9/gfx9.4.3.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 ++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 5ba263fe5512..6157e1126030 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3790,12 +3790,46 @@ static void gfx10_kiq_invalidate_tlbs(struct amdg=
pu_ring *kiq_ring,
>         gfx_v10_0_ring_invalidate_tlbs(kiq_ring, pasid, flush_type, all_h=
ub, 1);  }
>
> +static void gfx_v10_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, u=
int32_t queue_type,
> +                                       uint32_t me_id, uint32_t pipe_id,=
 uint32_t queue_id,
> +                                       uint32_t xcc_id, uint32_t vmid)
> +{
> +       struct amdgpu_device *adev =3D kiq_ring->adev;
> +       unsigned i;
> +
> +       /* enter save mode */
> +       amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
> +       mutex_lock(&adev->srbm_mutex);
> +       nv_grbm_select(adev, me_id, pipe_id, queue_id, 0);
> +
> +       if (queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> +               WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0x2);
> +               WREG32_SOC15(GC, 0, mmSPI_COMPUTE_QUEUE_RESET, 0x1);
> +               /* wait till dequeue take effects */
> +               for (i =3D 0; i < adev->usec_timeout; i++) {
> +                       if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
> +                               break;
> +                       udelay(1);
> +               }
> +               if (i >=3D adev->usec_timeout)
> +                       dev_err(adev->dev, "fail to wait on hqd deactive\=
n");
> +       } else {
> +               dev_err(adev->dev, "reset queue_type(%d) not supported\n"=
, queue_type);
> +       }
> +
> +       nv_grbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +       /* exit safe mode */
> +       amdgpu_gfx_rlc_exit_safe_mode(adev, 0); }
> +
>  static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs =3D {
>         .kiq_set_resources =3D gfx10_kiq_set_resources,
>         .kiq_map_queues =3D gfx10_kiq_map_queues,
>         .kiq_unmap_queues =3D gfx10_kiq_unmap_queues,
>         .kiq_query_status =3D gfx10_kiq_query_status,
>         .kiq_invalidate_tlbs =3D gfx10_kiq_invalidate_tlbs,
> +       .kiq_reset_hw_queue =3D gfx_v10_0_kiq_reset_hw_queue,
>         .set_resources_size =3D 8,
>         .map_queues_size =3D 7,
>         .unmap_queues_size =3D 6,
> --
> 2.25.1
>
