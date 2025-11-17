Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94C5CEBF61
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 14:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609F710E3B5;
	Mon, 17 Nov 2025 14:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QqWddNAo";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDD010E3B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 14:18:15 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7b8ba3c8ca1so446647b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 06:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763389095; x=1763993895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+z/t8ovWaxc9aCgFtVKKObr40noveF0hKfORpQw/znA=;
 b=QqWddNAo6pNY3rpmTI1YDbOvLX47ee19bknIdka/EmqtQtCc+A8h6wJb0w893jTF5A
 uDw4EQHL1D7PqptzSBpkduCjc2RbnWFsU0EpBjnn+X2wgLerom3Huco6fkB7rNUJcI1j
 T1KzYxcMsHkGmddKwg2vvMybmtMZ8zRUyORubtBWUrUNXPW+FpT5FfZt6TGxg4BsCoOh
 T98+IWyaKv1XpvjL/KAUPFNpAwTnBe9yi2T7sO9f2BJKx44GuW5YYnQSF8/apOyuApL3
 Ub91nTjZFDIjvGmyRw3jlaoVi5gGVfrbw5dHbadWw1goQsEf/ISYqdYsJBcJzaCv1Gt5
 ZZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763389095; x=1763993895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+z/t8ovWaxc9aCgFtVKKObr40noveF0hKfORpQw/znA=;
 b=Qz1l6QaCP3RQyzqtXmEor2z8A6snxEq+MKy0AgHdTKMGeLvQVEjknJ570jUbuYuyy1
 7wXiac7fpGwJ+PwsE3dVvhM9V970WDAYqMptTbhXbRSDOXKPL4sYQ7IJG1zgpkgoxlpY
 qaXHPzYTV3yvASBhc2RU5U+aQxuhuGtqr/t2pNTT9Qg59PAWSu2TY8hYz7phKINieUU0
 cGlIntIx+6ltX2ZqX+jf1ExUFL8VGn5Bq+Ac2QaAkfKQgT7EMfgbiSR08wNvZ3/57WRR
 beZzRILFqpaGdnvZTtQ7pRRbvXaDXmlG9PDdJ/DljHD0e7qY3cHFonc6lbYd+mjBrSc1
 h/5w==
X-Gm-Message-State: AOJu0Yy0KYbvHRdkvEtLP7ZyBOU1mksHLKuYmtHCfIBTDuuXRhL3kbvR
 gnghhYXWNlzowyZPREYMHCQVyiKrpClYJK4QcBQkGNs6/HMMtfjAztPdsydl/7IOrZwKB92coZv
 l4T7MureeLefBLgOgto21+t9Q5s9nfSw=
X-Gm-Gg: ASbGnctnDICqKm5/6CUM86k+w+VeEmeUC63jIklvRD6Wieww+qR+dZaI/Ur5uTLjp7I
 yv6tPzWbsiYWNEXtlKVc0bAkU5dgSLMRZGKt+Yem1daJQzxuNtQ0PCFWcHPyEFJeotJ6boOeBw4
 Ys9tvXXJ5blvBrgtWLcbMnl9MyvmfXGXjuNRf9numsUgFC+110Jzo+bgHUqCEDcBzgfmxPrzrFx
 B41/EIENHu3G4WGUR9qvJ13G3iKTi2Z76EY97FdjnO77ESAS8rG94KGDvlSnxOXC3h+NG0=
X-Google-Smtp-Source: AGHT+IHT9sDt/qgPNYp1jsFjwH/RVnG3Ma8p9l/pgh6tfPIpGozLtkKPEl9RBAuHDrAtBhlGoqE7A2+mODAfmlJDmPs=
X-Received: by 2002:a05:7022:1093:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-11b4892ac93mr3395504c88.0.1763389094778; Mon, 17 Nov 2025
 06:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20251117050310.255283-3-Yifan.Zha@amd.com>
In-Reply-To: <20251117050310.255283-3-Yifan.Zha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Nov 2025 09:18:03 -0500
X-Gm-Features: AWmQ_blY29-4F_C5B9BotUCQsjxFtuQVQWH6YtcCXEkSh4_XJZ_As_PYUvcVWP8
Message-ID: <CADnq5_PRq5nmzmqiHjJ-Hupbv+3Dqvg0SeWvGhLFLtETG-AiPw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Skip emit de meta data on gfx11 with rs64
 enabled
To: Yifan Zha <Yifan.Zha@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
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

On Mon, Nov 17, 2025 at 12:42=E2=80=AFAM Yifan Zha <Yifan.Zha@amd.com> wrot=
e:
>
> [Why]
> Accoreding to CP updated to RS64 on gfx11,
> WRITE_DATA with PREEMPTION_META_MEMORY(dst_sel=3D8) is illegal for CP FW.
> That packet is used for MCBP on F32 based system.
> So it would lead to incorrect GRBM write and FW is not handling that
> extra case correctly.
>
> [How]
> With gfx11 rs64 enabled, skip emit de meta data.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 02d7cfae22bd..8a2ee2de390f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5874,9 +5874,9 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgp=
u_ring *ring,
>                 if (flags & AMDGPU_IB_PREEMPTED)
>                         control |=3D INDIRECT_BUFFER_PRE_RESUME(1);
>
> -               if (vmid)
> +               if (vmid && !ring->adev->gfx.rs64_enable)
>                         gfx_v11_0_ring_emit_de_meta(ring,
> -                                   (!amdgpu_sriov_vf(ring->adev) && flag=
s & AMDGPU_IB_PREEMPTED) ? true : false);
> +                               !amdgpu_sriov_vf(ring->adev) && (flags & =
AMDGPU_IB_PREEMPTED));
>         }
>
>         amdgpu_ring_write(ring, header);
> --
> 2.43.0
>
