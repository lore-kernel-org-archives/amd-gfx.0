Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C100C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 15:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F28AE10E378;
	Wed, 16 Aug 2023 15:20:47 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B9610E378
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 15:20:46 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a81154c5f5so1800527b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692199245; x=1692804045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0EkBe159EJz3VMGq7bpFP5ZOzeUElnrxgIocUFNZXw=;
 b=HaQCure0xoyXORAcg0k0xRs6LfjIfOzIKXJ+OO4I7Q/ixK6+dqUxtSJlPZ8ujCZtCF
 Tup2n8zxAKv3HAy9zH5KMGq8m0x3dXE4fCexdvTbkQp5q1U2SdchKsm+6333ldZqQvaq
 YPGivj2rsqpI1khVQqRWfhZwKutkl8my9G1PFUs64iWqVpWFSVxvWsYwOwv1w5gdcixg
 okWn6et2y1o3SN0CEstsdrLLGZ+SPVjSHFkpPr3x4ZIlXT41QJ+4UgO2tKor0RNw3wxb
 LCrwYA9DfMUmOisNIk0XvNuB59bMaYDI2L9siJSgIV0LvScBAgw4iAobB2zzuQ6uC+h2
 Q1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692199245; x=1692804045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0EkBe159EJz3VMGq7bpFP5ZOzeUElnrxgIocUFNZXw=;
 b=XJ/cH+LZaOu2PxWdRO6+9sQ5iOPcQbQt77CPcg5QqbhgcOBJ73a8eCorxuqVNzTx+u
 OFGDFX37D1xc2aovVRmfcw/ABKWaSKcA8yz4KEjmwCmLYsXG8xj4SqTZRM+onFeYRSq1
 qNR94ywjVdMTDsHJgktN3spF2JSusvZmrIs1bmDZQp/KqmUS+SxZZfriB8dYvN+iMl3n
 tPK7blYt6K2AcrxcErQChczzTq5mXgi9OB5ZC/hcEUPMRC23ooknoJvSNR1+vn3Rxk3V
 5SZ9NPw2XbFK59EIiH6zw2skdXIaCJImkmF5BrnEdjCWa+tCiyDF7cKirfSaqTDJRO+M
 Y+cA==
X-Gm-Message-State: AOJu0Yw+ZjEFM2XztrNoIltgvVjeVVp/Pl1hplDoKRex+2syXjjP292S
 p+Iwqm0iHXlxr5GzYQfszd5XAKQHhA7w00NWeYA=
X-Google-Smtp-Source: AGHT+IG5oSWWXfpWJUinJ080Qx1CH/PhPec+fMrfuF+9O0tP4pUUQNjmxkW54iFwyw0WkzdcvioGcYgnFIdtR9VI8vM=
X-Received: by 2002:a05:6808:bce:b0:3a7:146d:85b5 with SMTP id
 o14-20020a0568080bce00b003a7146d85b5mr2892026oik.52.1692199245271; Wed, 16
 Aug 2023 08:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230727181048.1222388-1-alexander.deucher@amd.com>
 <CADnq5_PqB9Tehv_+c+cV9_8h3fm-b6+f39HLzQrXB54MTYGkkA@mail.gmail.com>
In-Reply-To: <CADnq5_PqB9Tehv_+c+cV9_8h3fm-b6+f39HLzQrXB54MTYGkkA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Aug 2023 11:20:33 -0400
Message-ID: <CADnq5_NoZ7r5XDh0newotPnstWA8DVO0tNcsb_95dO-9+Cb5Jw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add GPU page fault query interface
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
Cc: samuel.pitoiset@gmail.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Aug 10, 2023 at 3:35=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Thu, Jul 27, 2023 at 2:11=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > This patch set adds support for an application to query GPU
> > page faults.  It's useful for debugging and there are
> > vulkan extensions that could make use of this.  Preliminary
> > user space code which uses this can be found here:
> > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
> > https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/298
> >
> > Note, that I made a small change to the vmhub definition to
> > decouple it from how the kernel tracks vmhubs so that we have
> > a consistent user view even if we decide to add more vmhubs
> > like we recently did for gfx 9.4.3.
> >
> > I've also pushed the changed to:
> > https://gitlab.freedesktop.org/agd5f/linux/-/commits/gpu_fault_info_ioc=
tl
> >
> > Open question, currently we just expose the raw GPU fault status
> > register value for each GPU so UMDs need GPU specific knowlege to decod=
e
> > it, although it's largely the same across generations.  One option woul=
d be to
> > translate to a generic GPU independent fault status.  Opinions?
> >
> > v2:
> > - Fix spelling typos noted by Guchun
> > v3:
> > - Add locking in IOCTL query
> > - Only update cache if fault status is valid
> >
> > Alex Deucher (4):
> >   drm/amdgpu: add cached GPU fault structure to vm struct
> >   drm/amdgpu: cache gpuvm fault information for gmc7+
> >   drm/amdgpu: add new INFO ioctl query for the last GPU page fault
> >   drm/amdgpu: refine fault cache updates
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 50 +++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 31 +++++++++++++--
> >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  3 ++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 ++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 ++++--
> >  include/uapi/drm/amdgpu_drm.h           | 16 ++++++++
> >  10 files changed, 135 insertions(+), 8 deletions(-)
> >
> > --
> > 2.41.0
> >
