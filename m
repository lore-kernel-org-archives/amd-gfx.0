Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406EACCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 19:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBFB10E193;
	Wed, 22 Oct 2025 19:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZxhzkfN";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA6F10E193
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 19:29:09 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b6cf214a3ceso38235a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761161349; x=1761766149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t05Zh2mq3qVP3OhBg4U8mYLEiRLx9PJdOIF3LFjzU/M=;
 b=QZxhzkfN1gepMFCyfot3y8k6fQI6R20w9t/08OfFk48cx257qCaK8L8pMIdz2YzNOZ
 +8litrIwqNTfBit2I+i4bZzbZpmfdML9jYqTqIrIsG0q+Wun2GIwIrVli7/tMUO68hAA
 +vPzUNWx2t4qPFRs3c1V4LXDfzNmA6OLgcIALwVkaPGpRCnykBbNTaknMsnEKA5WWw5Z
 Rx7fBGIt7wmProyhLdklBIApz7OjKA4voim6SoO3m7Y9xxZHo+AKX08GdIOrX9PaTBOZ
 EQyhtj6QfH9R0ucT1ldvj8HBppzsna3PtGKlSWYwyRFV31qinMvzzfCONg8QYGhL/xKz
 5OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161349; x=1761766149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t05Zh2mq3qVP3OhBg4U8mYLEiRLx9PJdOIF3LFjzU/M=;
 b=XUfjihj5a12T2wAorbCmNZgTmoCJ368Ciw+0mnpY1qU5yfjtnlZz+Ps9O3E0veAU2x
 7/Xni6LZlzpQH9PlKp5E5WDoik/GuZrJus1ZA1Tc0NjqCGDgmrqj2rLQ2ilUZL30Bs7K
 KKOLJhEDLwVycao1H+PmYZ3L2NnGUIyCauuyY7HvKPmsSfk8tM2h8gqKweE9IXskf4Nb
 lRyRf2CpB/tSih4vzKhtGNprrcpaHX7dvChgGcgpZgSKgrfDYTkBjlW24O17hjqH2C+6
 ZA2NxKT0QkKQ8KXAgzvdA8VqAGit7KTrERN60QiZd0rKbXqRibLpmCx2w6gDPkpxiiNA
 XEBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSbrNQWNdLDxe0F7pPXTLqrZ1+7NJqSn978pCZ1X7dZVHzIor+5Ln93trhghTPulSwlgFaAxqN@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0Tt21v9vXIaSU7RjBiGTlDNyAh1yRTlCEDGDdr4zmAbPkuAOk
 5DCjMY5wyzqJ+sjGOHgZTliD5+6AbFNRsxB8LWSKLS8yTX4Kj8qY1xlpHWxTSCMDC7nRBr7V0wo
 EfFfkoT1PmagjQL79NJdIKRBoBfwGDt8=
X-Gm-Gg: ASbGncvB/WcBRZv1k1unBiXM5w04TJNrsBhC3ExJGZxoa1lioTIBk42S0sU14giBZ3q
 TAUNsVCvdDLTn3KRtGGXvm2ldWx9f7f+56ipJ+ccFgevmYKgiNN37Xm9pyTq/7Vi33nXbeabopQ
 5WXPDUoV/mHQgXPV3RoX1wtAXrgRmINdAXnP4G/FkFgoF10AWWx6AUzEjwqbPYOa16Gs7moxjZz
 VqM7mZU40zdnf0ghk48tlGFhWxaiPf4EeltZESj4TW1LZo3WL07mL68FkBfdWa82TbBpno=
X-Google-Smtp-Source: AGHT+IERIkFQ5kgn2NKb5JsGttPz2IJnINu/TRtJN6IM9MCns9xx+I9xrSjuMs22LACpmuS9WbtTrcqWrclFncQQhJ0=
X-Received: by 2002:a17:902:ce8e:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-292d3e67f33mr55270815ad.4.1761161349155; Wed, 22 Oct 2025
 12:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251022122009.237253-1-srinivasan.shanmugam@amd.com>
 <SA0PR12MB74628CF83DF35BFD10081AE1E9F3A@SA0PR12MB7462.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB74628CF83DF35BFD10081AE1E9F3A@SA0PR12MB7462.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Oct 2025 15:28:57 -0400
X-Gm-Features: AS18NWAFyflIeMLFUAQxDUszAlx7sb22n2dqbrWq2AXdKjK4jRdVqNhWF9-hD7M
Message-ID: <CADnq5_NCGXdC1MRhh5QOXRZ7BT4V+3c1yFM6R3WaGVX3s-9JBw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Make SR-IOV critical region checks
 overflow-safe
To: "Pan, Ellen" <Yunru.Pan@amd.com>
Cc: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Oct 22, 2025 at 2:36=E2=80=AFPM Pan, Ellen <Yunru.Pan@amd.com> wrot=
e:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Please have Alex or Lijo reviewed it too.
>
> Reviewed-by: Ellen Pan <yunru.pan@amd.com>
>
> Thanks,
> Ellen
>
> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Wednesday, October 22, 2025 8:20 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Ale=
xander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHAN=
MUGAM@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
> Subject: [PATCH] drm/amdgpu: Make SR-IOV critical region checks overflow-=
safe
>
> The function amdgpu_virt_init_critical_region() contained an invalid chec=
k for a negative init_hdr_offset value:
>
>     if (init_hdr_offset < 0)
>
> Since init_hdr_offset is an unsigned 32-bit integer, this condition can n=
ever be true and triggers a Smatch warning:
>
>     warn: unsigned 'init_hdr_offset' is never less than zero
>
> In addition, the subsequent bounds check: if ((init_hdr_offset +
> init_hdr_size) > vram_size) was vulnerable to integer overflow when addin=
g the two unsigned values.  Thus, by promoting offset and size to 64-bit an=
d using check_add_overflow() to safely validate the sum against VRAM size.
>
> Fixes: a5d4d72eee03 ("drm/amdgpu: Introduce SRIOV critical regions v2 dur=
ing VF init") Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Ellen Pan <yunru.pan@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 66e9cd103597..45f2ad083338 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -937,9 +937,10 @@ static uint8_t amdgpu_virt_crit_region_calc_checksum=
(uint8_t *buf_start, uint8_t  int amdgpu_virt_init_critical_region(struct a=
mdgpu_device *adev)  {
>         struct amd_sriov_msg_init_data_header *init_data_hdr =3D NULL;
> -       uint32_t init_hdr_offset =3D adev->virt.init_data_header.offset;
> -       uint32_t init_hdr_size =3D adev->virt.init_data_header.size_kb <<=
 10;
> -       uint64_t vram_size;
> +       u64 init_hdr_offset =3D adev->virt.init_data_header.offset;
> +       u64 init_hdr_size =3D (u64)adev->virt.init_data_header.size_kb <<=
 10; /* KB =E2=86=92 bytes */
> +       u64 vram_size;
> +       u64 end;
>         int r =3D 0;
>         uint8_t checksum =3D 0;
>
> @@ -957,7 +958,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_de=
vice *adev)
>                 return -EINVAL;
>         vram_size <<=3D 20;
>
> -       if ((init_hdr_offset + init_hdr_size) > vram_size) {
> +       if (check_add_overflow(init_hdr_offset, init_hdr_size, &end) || e=
nd >
> +vram_size) {
>                 dev_err(adev->dev, "init_data_header exceeds VRAM size, e=
xiting\n");
>                 return -EINVAL;
>         }
> --
> 2.34.1
>
