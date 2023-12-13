Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67D0C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 21:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1937F10E82A;
	Wed, 13 Dec 2023 21:14:00 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4DE10E82A;
 Wed, 13 Dec 2023 21:13:58 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b9df0a6560so5016837b6e.2; 
 Wed, 13 Dec 2023 13:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702502038; x=1703106838; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyvPDaGX9M+bGBT9viv22TNWwjI07vV9DO6NV2vX42Y=;
 b=EsK4RKP9dUHsoW+5Bs6MVydO1lZiOzrgvZCZl/BfYIgOrhy+2PuL+ujo888ENz/0+G
 XRc9cNKVY96y1OxMYTcChLewBNRoXjm8d0FnPfv/a9xo2KTOqH6PUsyLKePLKMNHLEZl
 K5n9QaYgcXVdTCaM5cxrKjCU7Mi8bcWDe3gkzSeeHHf3LLii4Gvcnq/mqZGsy/dycz5N
 Ukilm30KF6V07U6Mb0/7qjbla17j0OckdL0e5pzsaj+/9mHXYy0VWrLOrB92aVBBJvre
 ZBn02cJup8F9l2efSRmQIa+qqSjOSKcM2AIxQrp/D3HAvgIhirctwsG+J3Duw7hMpwNP
 rIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702502038; x=1703106838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyvPDaGX9M+bGBT9viv22TNWwjI07vV9DO6NV2vX42Y=;
 b=VG+JkdEk3IhtsI2uHuVLGzSdsH4FqLJ0cWt1pfSqA6/NN3x0qKOWEDOx3/TW4DDgP+
 BubeQiJEs78jBmNqnQsvhpnl6W3hE+Kb1hfoE4um/Eyrji89zogR514iFP/yaT57tlP2
 D6WpeL6Ejq/K7Zmovxj1/m23fC9i+6kgREaJfJfPCeNWCZzBLFuTvAj2anmOxupmSvKP
 P1z5uZC+Od62L2AcYDMDiXlPSPQs778tuQ97raiZV/aaBgL5ViVxugHfK/V/ecfSrP10
 /qVR1syApOdHhdbu7gWZhDGPWukuQ1ckPU2Os2dlDdivKncpnQO37Yg1r4BzvSfd2h76
 jb8A==
X-Gm-Message-State: AOJu0YyjaG8fypWL9tn4HSBMWxb0owS6I9LUPlu74cWzG7VmRhFfxfts
 NUni87hx1zICqQxN3gKzthRO8snYxPbF88oLbu31aTb1
X-Google-Smtp-Source: AGHT+IFpUDIx/MM+priL9h6iujhB9gK95V8/LehiAQlN/lytgUYOfuw1TLnKeQOvy/mH0vlY5m//O++20Hw/ShmqZ1M=
X-Received: by 2002:a05:6870:558c:b0:203:27a5:cccc with SMTP id
 qj12-20020a056870558c00b0020327a5ccccmr1244046oac.102.1702502037771; Wed, 13
 Dec 2023 13:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20231207180225.439482-1-alexander.deucher@amd.com>
In-Reply-To: <20231207180225.439482-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Dec 2023 16:13:46 -0500
Message-ID: <CADnq5_PdmDWyJsDvtvCbNguExt2aydXy_rZOPHii5imMtt_Z+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] fdinfo shared stats
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 7, 2023 at 1:03=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> We had a request to add shared buffer stats to fdinfo for amdgpu and
> while implementing that, Christian mentioned that just looking at
> the GEM handle count doesn't take into account buffers shared with other
> subsystems like V4L or RDMA.  Those subsystems don't use GEM, so it
> doesn't really matter from a GPU top perspective, but it's more
> correct if you actually want to see shared buffers.

Any thoughts on this?  Seem reasonable?

Alex

>
> Alex Deucher (2):
>   drm: update drm_show_memory_stats() for dma-bufs
>   drm/amdgpu: add shared fdinfo stats
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 ++++++
>  drivers/gpu/drm/drm_file.c                 |  2 +-
>  4 files changed, 22 insertions(+), 1 deletion(-)
>
> --
> 2.42.0
>
