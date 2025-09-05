Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF23CA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 14:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8338C10EBAC;
	Fri,  5 Sep 2025 14:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X0ijtlt9";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6997E10EBAC
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 14:02:06 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7728ec910caso181021b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757080926; x=1757685726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqpTl+vk4dhOPDbW6nj+dDKIOdtfXZ022f+aaWs3pr8=;
 b=X0ijtlt9iGT/6ryoNVzjPXykgFR5KSu3zrrMdOxwJG6aq/VYiyhs//5L8eaVb15iXi
 DqwKmZ4qCgWYyfOqbqaAyNGHjDtJmzeQN1Yi6K/Clg8lFImSztSP47vfhb3DFHU6wkDO
 tWU4bkvo3/ds9uLfO6ar0b70XD+/6IFU5XpTQcUtGfx6C9EfDHUbRWQavCvV9nqJOiBh
 K/8EMFdXTq+4+Ljt6ZEa4Rw5DQKXt6T0KwefEId5mXiVYCUEAHEGyRFMRRFeb2ezbH5/
 MV+m6Tw2sRGYzNsh2DZz3OGuUDb99VNRodfEDjRaDTwHyItSSMhg3r6xseGIlROP45q1
 +W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757080926; x=1757685726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqpTl+vk4dhOPDbW6nj+dDKIOdtfXZ022f+aaWs3pr8=;
 b=DXS69DJq1Ri4zreQABr0p9Im5SVN+/3PdhZ2a3aARubV/+n9+FYUFbwwWh6DeVdzN1
 hrwC+Dueja6N/yTQ7uCWrxuVc01WK9z5WJFO1HN0wG8VVpC9j6/NybsgQn2QHu17qJnX
 go2i6doDehw6v3lSG6wn0XXonhju6z/b4GdLjLfFIn7JpHXOMy8dzAbPsU5wd3T4RLE0
 grYkfXJ9nqU2pIduszZyX0lxWw6RRGDPaEphTlmSYJ/OuvX4P44m8iUliNMxsNBiinyh
 YYyU+c/7GuQA0K/J/4m/9vSPDtevDe3q7+Kq/zjBKS8kSNIqZIx6yrrXKeEe/hbE9Gbu
 MLIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLnCoqzJOrqQy7iLJDfPD5fJyj3W9lzhu3LjqNUeDfI/m7oqJRv0dbL1FKaydR+IXLCaC5/Y1z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmWqyu9hSwxA7GXbUu9n4ii1TwgkQgrX++vOJgb7i2sCHwjy8N
 +R1HJuHKnEYGerPAK2j6z4vDdDA58JiTqi/svKUvpS6IeMQWIXAa7zi9G2pUssFLQo/GkJ3cIy4
 UNkzecjZxsoISU8GHslQdB94tBbeFvsw=
X-Gm-Gg: ASbGncuyrtZz/N0ksEcS/iG7aeVREBk9U2ZwLElD+QTdv2JL70rFmhQmJ4sqsZDLhLn
 NVTp0G5sP+lioMXgTMgOrDMHOK1MCri/zq3ulU36myaLZXvwYTn453uDCkyw4wbD4p/2h2LMbls
 kG5XljsUe46jyZK6LrXLBoSgMOeMNFMVTO4pOa5aaToLL0vwejcz3KyCqsrNCXJpHVKuGQ8WCj5
 PAAgk/o2qxav7LqUA==
X-Google-Smtp-Source: AGHT+IHXFGa7NWczA018rgS0LlHuNh5R+hXjzhrDU28sHXa2cOr0r5eDZu5GDOxcVZw+1SIy/nvMbdMx/Ajva5IJhTI=
X-Received: by 2002:a17:902:e845:b0:24c:c445:87c2 with SMTP id
 d9443c01a7336-24cc4458d54mr46166385ad.4.1757080919426; Fri, 05 Sep 2025
 07:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250905101128.3058191-1-john.olender@gmail.com>
 <PH7PR12MB59970F48ECB9A527A377D1088203A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59970F48ECB9A527A377D1088203A@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Sep 2025 10:01:47 -0400
X-Gm-Features: Ac12FXwBc-GFSGpA_We1XpBGFI1khzwhAo0fmbP9Se1lwJ9l3Ly9TmETb-TWB4A
Message-ID: <CADnq5_OvnR82_igzpfUTpC5rOpYxa1QkX_tFEn-5nH9rrTSwOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL ptr deref in
 amdgpu_device_cache_switch_state()
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: John Olender <john.olender@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sun,
 Ce(Overlord)" <Ce.Sun@amd.com>
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

Applied.  Thanks!

On Fri, Sep 5, 2025 at 8:49=E2=80=AFAM Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: John Olender <john.olender@gmail.com>
> Sent: Friday, September 5, 2025 6:11 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@a=
md.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; John Olender <john.o=
lender@gmail.com>
> Subject: [PATCH] drm/amdgpu: Fix NULL ptr deref in amdgpu_device_cache_sw=
itch_state()
>
> Kaveri has no upstream bridge, therefore parent is NULL.
>
> $ lspci -PP
> ...
> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]=
 Kaveri [Radeon R7 Graphics] (rev d4)
>
> For comparison, Raphael:
>
> $ lspci -PP
> ...
> 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ri=
dge Internal GPP Bridge to Bus [C:A] ...
> 00:08.1/0e:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [=
AMD/ATI] Raphael (rev c5)
>
> Fixes: e5e203e0cd53 ("drm/amdgpu: Save and restore switch state")
> Link: https://lore.kernel.org/amd-gfx/38fe6513-f8a9-4669-8e86-89c54c46561=
1@gmail.com/
> Signed-off-by: John Olender <john.olender@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7783272a7930..ca58cde66446 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -7148,7 +7148,7 @@ static void amdgpu_device_cache_switch_state(struct=
 amdgpu_device *adev)
>         struct pci_dev *parent =3D pci_upstream_bridge(adev->pdev);
>         int r;
>
> -       if (parent->vendor !=3D PCI_VENDOR_ID_ATI)
> +       if (!parent || parent->vendor !=3D PCI_VENDOR_ID_ATI)
>                 return;
>
>         /* If already saved, return */
>
> base-commit: 035edba1e204b302ae74269d4f09e355153a79ac
> --
> 2.47.2
>
