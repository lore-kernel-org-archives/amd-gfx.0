Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E4FC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 19:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C2010E055;
	Fri, 28 Aug 2026 19:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M9o10dP1";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C64D10E055
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 19:16:53 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-396a50ce17bso130871a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 12:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787944613; cv=none;
 d=google.com; s=arc-20260327;
 b=QiN3ZiRVfb+sYsXHlZl4uDfVk+lZrO8Z74uJbk/yXCqjgVt5H/Aa1VUAXP7iDDn3Bk
 9nib7W3Yw84geJ9P1dIE6aIwDhUOxe2RDZqBjLO9ofU6LY57HoqF4qf3O+RU02pUtTzP
 Q6jLrvfsE5IideZPp2xCY8Sb/TCCfZ3bgco+057zvh9lgaOnnEwGXsNaMLQHE4V1u35N
 jEyREHWle1nWIaFlqfBElVqiEXsMZa3UK55oeXdgxs/qQ8OmVxcPd23pC8YHKJ03Z0M9
 21Gno8hz4TCW8NwzLyqsSgSkW85N6sp/tbL0bDB0aH9UJlK+QovCN0uo/OAroRdQ7pys
 gVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=el5oMcYmAlVrz5tsyA9X+T+Y9iDv8qPFv8NZQixqwcM=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=ra+yWOvi/G2BIH/iQknu7ZOhOGwDR0pY7lkB9UeBvN8gsNo/ss0i6cj03NR0ZFsxkB
 AI3g5DEb+FsSBhwJM5yd26816HD3cZLlA/wuT+nNT//zK7b6Aw091YnP9A1kSHcTNU47
 sfMs1K1OxMXtLeK7Dk1x04jTDl6cY+6vMsWQSCpOTxcrng6HAdXh0m1cW2bYJHZ9TGt9
 ncNupsem0MM8Pmy2jWgINLGoQTPlCmXS1OV8ZE99Iq4eJsloJd01xeBCuae6GQiJ5y1z
 YiTshvxVHy5HOJCB/qQTfabKCEeng3HrGFTETRKQVTzn+3opfxSBt4DYuvIb+QkX4Oy+
 ZbcQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787944613; x=1788549413; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=el5oMcYmAlVrz5tsyA9X+T+Y9iDv8qPFv8NZQixqwcM=;
 b=M9o10dP1SKURJ//WB1K47JrWrD5qH5ImNUnQI7Lh0JPiN2fJDFQiuC3C6aLE4XlnTO
 L5C5VPQ98B8XJl0YsOLbnPMfS/8sIli62ZknhRz00wd/OOUMes75GvBiVQQ0+c8Q6tJw
 m41yPIv3bvQDl4Q/2FDCgYZI13UKN3iU9nrC4fSF3m0jCRRB+DnqqQuJCToM4DSW0gJy
 FvqpAnVjJaZ8TX6TQek+psLnhhdP58HSRMJ8nm/0w/AoH/QT6QmBAiiE1QzkIGA4s89w
 /lC7oIGzDisZJux4evOI0wZqmphSscn2GdhydTm6lDaXYauw5G+fE0+vdJFtxdrK6glW
 dmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787944613; x=1788549413;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=el5oMcYmAlVrz5tsyA9X+T+Y9iDv8qPFv8NZQixqwcM=;
 b=dq/lK6ifjzoxNb1jIx9H/64r9LUh4mZSLzfc3uAvqcMep4US2uh1vu4cLgBGdwe8jM
 Eghrf6dfJA6MLI5HoQW4GwbKxhz3s5keTj3vgR+VlehTTdNooYTWpvCyHomxjHU8wrFc
 HC7yNKY8WM6reZnSB7g9UWDsz7psK7MhMaiyRVpmEJ1nYJhMaZ2QoSRNTZrBZfDh98u9
 iKygsEMwT1DpOXNXfhdkwGqq/98w6fK3OU9uNdPJUIjoSYGZ69Z+ShXaTYPmH2x2ue+3
 d8Nr6V9GhQM9wheYryGd6oEaVEy/bZstQ8YqQ3QQxDNaKElOvObOCTD0lwLHpUClOILT
 GXFg==
X-Gm-Message-State: AFuF++kv3yxSa7q4qQPpuml/62fFqFmhn8+geXtP0xmCPT777Q+Eoy18
 T/ZB8ERKY+Uc57IfRDozvSulOLyGJFsepeMQzdlSQeHFRY3+cZuHUCBw3xydSO3zZnr6S+NF02/
 EezqiZCDfzX1Ky6IZmPv4V2fkp52rLoc=
X-Gm-Gg: AYBFou16/TtKWz521AgAYkzI1rsYfdwxMKAzds1s1LoODXBcQK8ZllqVt1+lKCp4qFy
 VeN145S417tcdFjvIJdmdTiMsB5nbkB8T8MDnrE7aAclv931dxZ6Wwt7mQR80DymlDTyUD4UL13
 h8x3LTPVKmJUzjPagORQLuzO6/D/hBAk9FFFL1kysWjKDlDW2SvnrtjY8HCMwIuKJgFr3TjDGZV
 GJnYBTZhKsNRn3FD9M0yCsGpsZedWLAzxIhGHvfnLKyAHdqekS22kosE/M8xVg+H2LP5t1HLjHi
 +tnUoZnInCBU51OiiuAjR6gR36Sfj1lUeMdqjafoTUSwIekYrrGGQrio4vc/T2Ckd/2hXCh3L5Y
 iYYu5eW7aQ9yFwuVLgyk+klwb84zx9jY=
X-Received: by 2002:a17:90b:4d88:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-396d0f7d73bmr8505500a91.2.1787944612910; Fri, 28 Aug 2026
 12:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
 <20260828041537.3464782-3-Jesse.Zhang@amd.com>
In-Reply-To: <20260828041537.3464782-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2026 15:16:39 -0400
X-Gm-Features: AcwNN1USAy4o2HoQDmgKEEzCBZhCcgDT0CtVH2j__rLr_YsQRltufRsQyx_SjpU
Message-ID: <CADnq5_OrH3pSwu5sAs5KOCtN7JGPdZj33o63wFxR0SsqWjkXXw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] drm/amdgpu/gfx11: implement compute and GFX
 update_mqd
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Fri, Aug 28, 2026 at 12:25=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> Implement the update_mqd callback for gfx11 compute and GFX user queues.
> Save the read pointer, re-run init_mqd to rebuild the HQD, then restore
> the saved read pointer and forward the write pointer to the user wptr, so
> a re-enabled queue resumes at the first un-consumed packet rather than
> replaying the ring from 0.
>
> v2: rebuild the HQD via init_mqd and save/restore the rptr, matching the
>     SDMA update_mqd style, instead of patching individual MQD fields in
>     place. Keeps all update_mqd callbacks consistent.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 44 ++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index a447562977ab..1feb7c9ee5c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4256,6 +4256,26 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_de=
vice *adev, void *m,
>         return 0;
>  }
>
> +/*
> + * GFX update_mqd: init_mqd resets the ring rptr/wptr, so re-run it to r=
ebuild
> + * the HQD, then restore the saved rptr and forward the user wptr.
> + */
> +static int gfx_v11_0_gfx_mqd_update(struct amdgpu_device *adev, void *m,
> +                                   struct amdgpu_mqd_prop *prop,
> +                                   u64 user_wptr)
> +{
> +       struct v11_gfx_mqd *mqd =3D m;
> +       u32 saved_rptr =3D mqd->cp_gfx_hqd_rptr;
> +
> +       gfx_v11_0_gfx_mqd_init(adev, mqd, prop);
> +
> +       mqd->cp_gfx_hqd_rptr =3D saved_rptr;
> +       mqd->cp_gfx_hqd_wptr =3D lower_32_bits(user_wptr);
> +       mqd->cp_gfx_hqd_wptr_hi =3D upper_32_bits(user_wptr);

This seems fragile.  Rather than doing it this way, can we just use
mqd_init() as is and add a new
prop->modify flag?  Then we can use that in init_mqd to skip state
that should be retained from the MQD.

Alex

> +
> +       return 0;
> +}
> +
>  static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -4477,6 +4497,26 @@ static int gfx_v11_0_compute_mqd_init(struct amdgp=
u_device *adev, void *m,
>         return 0;
>  }
>
> +/*
> + * Compute update_mqd: init_mqd resets the ring rptr/wptr, so re-run it =
to
> + * rebuild the HQD, then restore the saved rptr and forward the user wpt=
r.
> + */
> +static int gfx_v11_0_compute_mqd_update(struct amdgpu_device *adev, void=
 *m,
> +                                       struct amdgpu_mqd_prop *prop,
> +                                       u64 user_wptr)
> +{
> +       struct v11_compute_mqd *mqd =3D m;
> +       u32 saved_rptr =3D mqd->cp_hqd_pq_rptr;
> +
> +       gfx_v11_0_compute_mqd_init(adev, mqd, prop);
> +
> +       mqd->cp_hqd_pq_rptr =3D saved_rptr;
> +       mqd->cp_hqd_pq_wptr_lo =3D lower_32_bits(user_wptr);
> +       mqd->cp_hqd_pq_wptr_hi =3D upper_32_bits(user_wptr);
> +
> +       return 0;
> +}
> +
>  static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -7271,11 +7311,15 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu=
_device *adev)
>                 sizeof(struct v11_gfx_mqd);
>         adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =3D
>                 gfx_v11_0_gfx_mqd_init;
> +       adev->mqds[AMDGPU_HW_IP_GFX].update_mqd =3D
> +               gfx_v11_0_gfx_mqd_update;
>         /* set compute eng mqd */
>         adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =3D
>                 sizeof(struct v11_compute_mqd);
>         adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =3D
>                 gfx_v11_0_compute_mqd_init;
> +       adev->mqds[AMDGPU_HW_IP_COMPUTE].update_mqd =3D
> +               gfx_v11_0_compute_mqd_update;
>  }
>
>  static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_=
device *adev,
> --
> 2.49.0
>
