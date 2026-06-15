Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41EDCD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 18:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A67F10E5DB;
	Mon, 15 Jun 2026 18:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MF37CtC0";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0763B10E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 18:56:09 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304f9bc869aso404068eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 11:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781549768; cv=none;
 d=google.com; s=arc-20240605;
 b=lxiiAt6B2MG7ZIhyKhqA7m76JugjpNP5MjAKa9xK+pHgsYHoHu0kpeMPfbzbYdlx/W
 zHDNeYNJK128PClocicr3ZfTsx0JXHmWfaF9E3YRre1XuCBYEfs2VIO23rGiNQ58Llo8
 cLC3mUSZM87NRgTkJJKJ8cjlLXTEXxAxB+5Ft09AlhVlv2yFJ9gLhQ3sSR9rp0AHHiJA
 T27foBgTQHgmr+HngQfrImS8SOZFs+KI8vpMsQfDTnyYVSw9g7sW4EFLz7lVCVTCIjOp
 E/BdDy1rSH9cLc65tedYwXjtMhhqn2Vf6BbyucZRxtQU8EoH9PY7u8kAuZ6sOcaPMB38
 cM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l88J7hSJ34zue/b5WlR3pfaKEFBuVosgcw95BPDJDu4=;
 fh=V3HSM5ytO5c4t6PPthIuoNOEEpwQbVHIE4d66byXFYc=;
 b=CXD6DAjhGdkGeAsUOyGK8W2HvrJiplEZhhpX/G6ePbD7c1twtOFuLi9pa5BcbbEhiJ
 16TClXzQoA+87gIK+NrXFuI5RxGC+YEVvbOUdpaGznnLyw+YrCrM8OCmqWvnOZKf8QPB
 I6GtFUETypM1dBdBW0B75+l3tTKYYrEHNL9t4ZwV863yPrIUn8fOTCgJa8Ygyp1EvFC3
 fHyVkYfufHxdC4BPN5aObjW5lhA2L1F4a9tS9RAyc+Gm4HOSMX0ge/bbzpNn/RgvjjAf
 3gTD8NceZzuYSmZrz76KdvnFF5ARnh8U09H20J8XB06HkjpbGQTK8c8ecN8mRC25I+Ej
 Ud7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781549768; x=1782154568; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l88J7hSJ34zue/b5WlR3pfaKEFBuVosgcw95BPDJDu4=;
 b=MF37CtC0gcomHm22avjjhEErNKIOD3jRqkYMllPsvuIJOWCRakkSm23XUAewTi+YUl
 rclb3cKHzZP7VIfxusKMQcaW4EYtcrgjH4JDtSC80YeW9fJiX28173/yBdV1YHL08/JX
 hXlsUEn/1B1o0zzmL84jRsX0ycNe4jTi4UR1RqK+QlKYfTrlvHIhOYdorpMIZ89UmkWn
 W+x1SaMJV3Au5mh6hm6LNrHB3tD1OZXYtD9C91sjx3lSxlMTCWg4cZlSPQ5gH0CnRUkq
 HOpxFMS/VLi4udC898CRHnPL/s0ai4wGafviLOYZ0OJ+CBJybLR8WXW2iRmKEJyN/jwL
 gt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549768; x=1782154568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l88J7hSJ34zue/b5WlR3pfaKEFBuVosgcw95BPDJDu4=;
 b=h+avZ/aIGEE8W0njpl7LGwWxQXBwCjt4ehtC5K9uG8QLHQMDG9FGd4fv5ivs+s2kcp
 pjwYMRQ9dIzcvnO3heR0dvLtTXtxbL9UqnyTX33ry3Eousuf9wfG4ROpdVDDrwYeaXct
 dHY0r1oO8GF8dlDWgVySkyMFnomzwC8ZJcmBW1eQ5nWhfR0wtsQR3KCl0PxSKAzqzBst
 0cw33a1l6cmYsJgP4y279LDdpxXpy5HAvo0zHHV45lDEz78MAy4rN5i9VzaVjt01l5K0
 Gmd8xpjxAsoU4cwDrjkFMXkT6bJJVhPmNyxQZCMX9VDLYJeD1tNV+BTxvWKOOJuW03yu
 +WPw==
X-Gm-Message-State: AOJu0YwYfeOZJBfha6C+6tN++Z1bHtCS9zF/rhCXBzJsKXVUaR4IIjnW
 L1C4A6lx4OEKMauBgxCCB3FwkW4Fz1Y3burPPq1Xqp1g0+X40qMbUVIiJYCeKdH5RFkOjJyEBAl
 drA8Vl0R9FZdQrx8LzYWjENnnP6DXPCY=
X-Gm-Gg: Acq92OHKI11rlaABjVJq8GaNuSTS02ACEWb7T9FxE0ODcLd47ziGy7KxAk4ZkjJV7X2
 UL0hNsrUhxO7F1wZj+uMHvzFGp8F8snr+j0fJu0zkrZhwCEFV6sLSc0k0vFHMYYtNXKSTxUz8VU
 uDBp9nc5CR+73ik6nsWk0WFWYaAX2JvaoHVqYOj1YNYkP+cXCz1BYRpPg3XMHWUY53L1cqoFvRZ
 8xt9xSiiJsqzBxpRkgTZ/6U1V4qiX3R1hgvkA8PrzFzwP5hceuo8DcgZzF6m/iFs5JdoLqlehZU
 wI4G7u2Mra13mdyjtGupLmt7CMfWtFSGvsFRLzeni0ALp3yC3nNXVKjJE3W/uAkNFe7UGg==
X-Received: by 2002:a05:7022:1b07:b0:135:1b09:db43 with SMTP id
 a92af1059eb24-1384bb85444mr2940719c88.6.1781549768105; Mon, 15 Jun 2026
 11:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260615142556.3662454-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260615142556.3662454-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 14:55:56 -0400
X-Gm-Features: AVVi8CcWXbfUYULkXNKm_vvrq6j7EccoQfzEh7Eaur7wrjUv-kkjYsPg3Z2oAtk
Message-ID: <CADnq5_MP2DiYrU_-w52z9ByFbqy7aBCkibvwfHZkZKfj9+jRWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Disable queue reset on gfx11 SR-IOV VF
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Amber Lin <Amber.Lin@amd.com>
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

On Mon, Jun 15, 2026 at 10:44=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> Queue reset is not supported when running as an SR-IOV virtual
> function on gfx11 dGPUs. Guard HSA_CAP_PER_QUEUE_RESET_SUPPORTED
> with !amdgpu_sriov_vf() so the capability is not reported to user
> space under SR-IOV, matching the gfx9/gfx10 path.
>
> Fixes: afc0c16db999 ("drm/amdkfd: Add queue reset support on gfx11 dGPU")
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

For a future patch we should probably look at doing something like we
do for kernel queues for KFD.  E.g.,
amdgpu_ring_is_reset_type_supported()
so we can clean up all of these IP version checks in common code.

Alex


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index a9879cf8539e..6a90a3ece9ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2020,9 +2020,10 @@ static void kfd_topology_set_capabilities(struct k=
fd_topology_device *dev)
>                 dev->node_props.debug_prop |=3D HSA_DBG_WATCH_ADDR_MASK_L=
O_BIT_GFX10 |
>                                         HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
>                 /* gfx11 dGPU */
> -               if (KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 0) =
||
> -                   KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 2) =
||
> -                   KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 3))
> +               if ((KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 0)=
 ||
> +                    KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 2)=
 ||
> +                    KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 3)=
) &&
> +                   !amdgpu_sriov_vf(dev->gpu->adev))
>                         dev->node_props.capability |=3D HSA_CAP_PER_QUEUE=
_RESET_SUPPORTED;
>
>                 if (KFD_GC_VERSION(dev->gpu) >=3D IP_VERSION(12, 0, 0))
> --
> 2.49.0
>
