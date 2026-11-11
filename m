Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B3606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fv47qaTm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4859E10E41C;
	Wed, 11 Nov 2026 15:52:07 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43EB410E41C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:52:01 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36e895f329cso40753eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 07:52:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412320; cv=none;
 d=google.com; s=arc-20260327;
 b=Us0bMAF6D+QKFojtDVtTfgzUUsLKW48hTxttpvEfmxbRhi9cEpl1JPGe+nk4dp4tMO
 +REairb/43goQLCqmUxCTbjc2Pfkq9WRGlIeIi8mj2ovygxqmErnzPcdvLlbhuOQLD/+
 5gs5LyztwHllMFYiZCFy07Ql5h9IeH0BIosu0UCqxwSK99qUBfsiEOROPMucMzfhot77
 8xQ1WzTsoXacWaVJDzqVjBqZvuFSIZu1uWPD2XupSvHcS47mNjiyLGOP2YKkkwCDUioU
 a5FAneDcoejFNXYjLL/FCiCCle/QGT1vlmlgeVW93GAWDht4gLeAYm5QI9QdFXY1aycj
 1eQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KBQmXpergQV0k3yAGb4YmxsK7ApjQIjQQTJj+akkdKY=;
 fh=j/X3BLMtn55FUm26zUqcpkE9pc9BYxMS7DRBhrxEDXY=;
 b=dhURqgmp3Gwrz2YJhv5J0gRkvVgeAHpk7tsX2zF3eDsgLLeqTDrgZFz9QgI6XNoB6Z
 /cw+QzaDpQM4QwSvJLb57rIVz/D6MV+nHkl7EMKVtfmMDnAEppVo9FIL1ntRKOlh/qeM
 c3RLOCj4OOFEBI/bW2BnnunIBIFyDFKcMzjqolpNPAjzywof1mJ4HBN8M3hz+jARAYwn
 ypnQx0I2KDSwiEeBT44ez56pHnkT0l+326Xg+3DcngaZevLJQbnannCHQl9vOZoGM0hu
 hqEelEbzfJZDlxXuDAkztbfu6kygb6v2cWIlXh0CNgdcFs+Q87VLUSyNWmL+nfPwbbIx
 18JA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794412320; x=1795017120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KBQmXpergQV0k3yAGb4YmxsK7ApjQIjQQTJj+akkdKY=;
 b=fv47qaTmBvXEMPG79Z3ghFoNqIxWFhQQ3rx3YmAVERLqUJ2SMxEw1K47eILxKKY3wb
 Hdku5bzxOvzB9LXRgL3U1WXKFdJVs9kp5JNPbtIWfrK2fM05MEf1XC+ww6nJXU01wTd/
 7TjHSeGG8bGyB6rsW306vampTxQ0Ix1J2e3r4lhO0f7ATISF+ONCyK96D1LxJn1gK9HG
 qyn0cAMpEvzUpTOLgfXpXhtNxt+qBBi5vYA3Mmh3L96Vc+tPtYXkpeQ/F98GNz/HLRC4
 6m/MdV+Q19E0ToxubIOJqvD+hTQn2Vb9TsJXYL6Xxj4imep5g7xGR7p2pgTXpnolT5Cf
 Zw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794412320; x=1795017120;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KBQmXpergQV0k3yAGb4YmxsK7ApjQIjQQTJj+akkdKY=;
 b=NkWKRaqKDuKz77uOAL71mwtPPh2ZhaMNK85CIoCzEYWjezOIWH4I2goZxUwg/jwzq0
 3ZBN4p6JNcGF9gLrpBMztj7qE9YjV/ugcvgl2VRJkIjHBFxYgtg2G0gGVtpnqoP0easG
 U8B+TxUBoG1wRX8EN400vgIdjhT8fYxThyoQB04fgSzjs3wQmCPaoA88EjwiSgLn4deH
 BGnau57mAfNXe21W33K41IIZYlyIsAsgau4VDdSuTRspOGAPbfwP0Luj4Dv/NQGpoLgu
 AiapGN/dnCe7k2giLK2cinAHbD2sZbLqhiautuXW1PZtSiylXUVayJHpTx/ziv7/gnp0
 wGjg==
X-Forwarded-Encrypted: i=1;
 AL+hErHb8rETCRVzwDsRSWQOqBjsKulZh6vVW2bML9cuA85pNZT/UJJcj60FgF5c64hSZz8ouPR7ik07@lists.freedesktop.org
X-Gm-Message-State: APuU4Z88O/fXO4dLDlqVbFzrDgK9T/mGWVnAcl0QBoXjs1U3XZrmzdFy
 G7adKmakrYqTWqgI2rPggV2eLfbYxzWc/9INQPx/VbW7EvuiiojbKkia2qwGzCJ2HmlxHHQilbB
 +ui/j9NVyf71W2tRTQE08NF3JzqgaOmQ=
X-Gm-Gg: AYBFou2YAXsZWbGYXVNE0y3ZrGtU4TCvW63Wk6IKN2zHnfZUog7fizfxu1DHAZzYg6p
 CbGnbNTgzZrWzeQQ591as0uQWV5fMDrK/EjN5C3PX1rCdchgNoiHriSBHXncvI6V3+8MQKG56ty
 bTEYFdfNfUcdo6NuTU00sbkpf/hUXmswFs4VfjJtR9KgVmrtcoJoMkJXTDN38zosLOKUGokkQhM
 b5o3C7eZ4l/ci2dIEMufJrEeAM588lXaIyEN673E29AhuC0572jZq6THtBszHmSdsbCr9DRoQk4
 Huyrriahqm4/MxTrYe2M+zwkVa36221nCsUIMKBNaVVaw2UMdsVBPo1c9dUuRse3YnLi/3J617U
 y5xJ6+obs9J/M4X5q9lecE/F7x/UUwTIPzkR4fwx5pVXgM05oh93pGh8ZgkdgM8btE+Ie752eBq
 ZC1DtOzRz6UgN6IhLf1SCxB/GU6a6PRqMPBhIJ63z+DobEbyFUwWLLZx/g4zs=
X-Received: by 2002:a05:7022:5f1c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1b3c02e9530mr3474381c88.2.1794412320307; Wed, 11 Nov 2026
 07:52:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110120326.538252-1-tzimmermann@suse.de>
 <CADnq5_NCF2J0Dzea5swubs+eEKBLq+8ontc5n=kihYZVA3A1aw@mail.gmail.com>
 <cd49a9ea-a992-4b38-a5d7-d46d1647010f@suse.de>
In-Reply-To: <cd49a9ea-a992-4b38-a5d7-d46d1647010f@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 10:51:47 -0500
X-Gm-Features: AclHuK-V9rhzh3ZjlBaGulsYdclwg7wvF6eK8h0-zGf088bOkC0LAbbJi1wg6Ks
Message-ID: <CADnq5_Oi3-zGYV_BiuJzV5VQvxTSTLN1btqFFH7JYz0ra+dP0g@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amdgpu,radeon: Inline drm_crtc_init()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 4:35=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 10.11.26 um 22:49 schrieb Alex Deucher:
> > On Tue, Nov 10, 2026 at 7:11=E2=80=AFAM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
> >> The helper drm_crtc_init() sets up a CRTC with a primary plane for
> >> non-atomic mode setting. Only drivers for some AMD hardware still
> >> use it.
> >>
> >> Inline drm_crtc_init() into amdgpu and radeon and remove it from
> >> DRM. All new code implements atomic mode setting, which does not
> >> use drm_crtc_init().
> >>
> > I'd like to drop all of the old amdgpu non-DC code since DC is now the
> > default, and we have an LTS kernel now.  I'm planning to send these
> > out in the near future:
> > https://gitlab.freedesktop.org/agd5f/linux/-/commits/remove-non-dc-disp=
lay?ref_type=3Dheads
>
> That's even better. :) Do you have an ETA for this work? Resolving
> drm_crtc_init() is required for that series I referred to at [1].

Just sent them out.

Thanks,

Alex

>
>
> > So that just leaves radeon.
>
> I'll fix the Sashiko report and send this out in a separate patch.
>
> Best regards
> Thomas
>
> >
> > Alex
> >
> >> DRM support for kernel panic is only implemented in amdgpu. Take
> >> the panic helpers from drm_crtc_init() in amdgpu, but clean it up
> >> in radeon.
> >>
> >> With this series in place, DRM's helpers for drawing panic screens
> >> can be further integrated with other drawing helpers, as outlined
> >> in [1].
> >>
> >> Tested on radeon with a Radeon HD 6570.
> >>
> >> [1] https://lore.kernel.org/dri-devel/20261019154612.777074-1-tzimmerm=
ann@suse.de/
> >>
> >> Thomas Zimmermann (5):
> >>    drm/amdgpu: dce_v6_0: Inline drm_crtc_init()
> >>    drm/amdgpu: dce_v8_0: Inline drm_crtc_init()
> >>    drm/amdgpu: dce_v10_0: Inline drm_crtc_init()
> >>    drm/radeon: Inline drm_crtc_init()
> >>    drm: Remove drm_crtc_init()
> >>
> >>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 44 ++++++++++++++-
> >>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 44 ++++++++++++++-
> >>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 44 ++++++++++++++-
> >>   drivers/gpu/drm/drm_crtc.c              | 26 +++------
> >>   drivers/gpu/drm/drm_modeset_helper.c    | 74 -----------------------=
--
> >>   drivers/gpu/drm/radeon/radeon_display.c | 47 +++++++++++++---
> >>   include/drm/drm_modeset_helper.h        |  3 -
> >>   include/drm/drm_plane.h                 |  5 --
> >>   8 files changed, 170 insertions(+), 117 deletions(-)
> >>
> >> --
> >> 2.56.0
> >>
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG N=C3=BCrnbe=
rg)
>
>
