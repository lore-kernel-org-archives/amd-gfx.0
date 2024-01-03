Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01250C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 18:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4C310E1A2;
	Wed,  3 Jan 2024 18:51:08 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FEDB10E1A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 18:51:07 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2046b2cd2d3so7143985fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 10:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704307866; x=1704912666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifBdMOVN3dUWnW8i45ra1ONqZTl6Lq40o6xbia0mdcs=;
 b=Emezwqf9+WfPTLRducz+4dtoSOQcnbsM5q6ZZnRmpXPbggHj5xE7DLT7SsVOR6EO+C
 PChlNMbaJ7lSMGx1uhL2IGMIVKEjH81Oa8rdrUGmgwXylLdp2SpxQBjM+sTsE/HmM/Hj
 UJz7xoU7tCkeO0muRdfWTgUGqHLN8TAq5/dEfR0irlUD+Jus8lbeG1dqySoH6R7oMuDp
 06szrNy1UeQEih9quJOaiI90N1hN/eeb4omthtlvr6zeGTMauViooph2xPf8JL4m+0HG
 6HDZJpAcnGiRRqL93Fp46qm21PqZCtE/N7SxqmfInAuPOA6JnE1bHIW1e5K/rft9/Ah9
 69Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704307866; x=1704912666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifBdMOVN3dUWnW8i45ra1ONqZTl6Lq40o6xbia0mdcs=;
 b=nB2ltPcngCCr/ROzox64FxqWAJHMlRaUZjPl8VenSVOh7DNKw+czada59p8kmjer7P
 4V5Dfq7JL4Te1RO4pVwiRXKAsUpgOIycdYuDgxdlNPR36hkgitpZ2KMTAN+LtNFNa+xN
 8rd5T6vLHhrptg3eRCyjaf7msUU8GTqtRf4dtrme6I3cP9AHMXfsMuOduhG+fohIgJym
 dDkfCsI3ZlJQ4AYNfDBhaaVejCFe2hQcoCUT4N6baCo8T93Zp8CHa02hlEcdYlsw5zVx
 TjwtzyPeTRAJq+HHitbOv+EyzR0whDrNt7G0S2DYuMbVEjSsupGBr8d53h0RXQIv7PYH
 nk0Q==
X-Gm-Message-State: AOJu0YxbWnJoMX09ZznWx+G1iSCmDAW8yHyzU7RDEZ5l/eZFrcCqDkAz
 LRZxFkayNTttetg+qjhRIFs+vwTDYc9cazXskFc=
X-Google-Smtp-Source: AGHT+IHOP7qIYn2TOxkjIMKSUChfmkC2yL90eQTWa0qYcI4dYY5oHGWjbHsU1kmGTv2JtdOKQuTZkrUx5yV3Kmb4fQk=
X-Received: by 2002:a05:6871:28f:b0:1fb:75c:3fe8 with SMTP id
 i15-20020a056871028f00b001fb075c3fe8mr26438216oae.72.1704307866552; Wed, 03
 Jan 2024 10:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
In-Reply-To: <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 13:50:54 -0500
Message-ID: <CADnq5_PF8DrWHiSfwq3ju0eKkX0dN8JwZHwnCoBpzXFhucFmzA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
To: Jay Cornwall <jay.cornwall@amd.com>
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
Cc: Kaibo Ma <ent3rm4n@gmail.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Jan 3, 2024 at 10:33=E2=80=AFAM Jay Cornwall <jay.cornwall@amd.com>=
 wrote:
>
> On 1/3/2024 09:19, Alex Deucher wrote:
> > + Jay, Felix
> >
> > On Wed, Jan 3, 2024 at 5:16=E2=80=AFAM Kaibo Ma <ent3rm4n@gmail.com> wr=
ote:
> >>
> >> That commit causes NULL pointer dereferences in dmesgs when
> >> running applications using ROCm, including clinfo, blender,
> >> and PyTorch, since v6.6.1. Revert it to fix blender again.
> >>
> >> This reverts commit 96c211f1f9ef82183493f4ceed4e347b52849149.
> >>
> >> Closes: https://github.com/ROCm/ROCm/issues/2596
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2991
> >> Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 26 ++++++++++---------=
-
> >>  1 file changed, 13 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_flat_memory.c
> >> index 62b205dac..6604a3f99 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> >> @@ -330,12 +330,6 @@ static void kfd_init_apertures_vi(struct kfd_proc=
ess_device *pdd, uint8_t id)
> >>         pdd->gpuvm_limit =3D
> >>                 pdd->dev->kfd->shared_resources.gpuvm_size - 1;
> >>
> >> -       /* dGPUs: the reserved space for kernel
> >> -        * before SVM
> >> -        */
> >> -       pdd->qpd.cwsr_base =3D SVM_CWSR_BASE;
> >> -       pdd->qpd.ib_base =3D SVM_IB_BASE;
> >> -
> >>         pdd->scratch_base =3D MAKE_SCRATCH_APP_BASE_VI();
> >>         pdd->scratch_limit =3D MAKE_SCRATCH_APP_LIMIT(pdd->scratch_bas=
e);
> >>  }
> >> @@ -345,18 +339,18 @@ static void kfd_init_apertures_v9(struct kfd_pro=
cess_device *pdd, uint8_t id)
> >>         pdd->lds_base =3D MAKE_LDS_APP_BASE_V9();
> >>         pdd->lds_limit =3D MAKE_LDS_APP_LIMIT(pdd->lds_base);
> >>
> >> -       pdd->gpuvm_base =3D PAGE_SIZE;
> >> +        /* Raven needs SVM to support graphic handle, etc. Leave the =
small
> >> +         * reserved space before SVM on Raven as well, even though we=
 don't
> >> +         * have to.
> >> +         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so t=
hat they
> >> +         * are used in Thunk to reserve SVM.
> >> +         */
> >> +        pdd->gpuvm_base =3D SVM_USER_BASE;
> >>         pdd->gpuvm_limit =3D
> >>                 pdd->dev->kfd->shared_resources.gpuvm_size - 1;
> >>
> >>         pdd->scratch_base =3D MAKE_SCRATCH_APP_BASE_V9();
> >>         pdd->scratch_limit =3D MAKE_SCRATCH_APP_LIMIT(pdd->scratch_bas=
e);
> >> -
> >> -       /*
> >> -        * Place TBA/TMA on opposite side of VM hole to prevent
> >> -        * stray faults from triggering SVM on these pages.
> >> -        */
> >> -       pdd->qpd.cwsr_base =3D pdd->dev->kfd->shared_resources.gpuvm_s=
ize;
> >>  }
> >>
> >>  int kfd_init_apertures(struct kfd_process *process)
> >> @@ -413,6 +407,12 @@ int kfd_init_apertures(struct kfd_process *proces=
s)
> >>                                         return -EINVAL;
> >>                                 }
> >>                         }
> >> +
> >> +                        /* dGPUs: the reserved space for kernel
> >> +                         * before SVM
> >> +                         */
> >> +                        pdd->qpd.cwsr_base =3D SVM_CWSR_BASE;
> >> +                        pdd->qpd.ib_base =3D SVM_IB_BASE;
> >>                 }
> >>
> >>                 dev_dbg(kfd_device, "node id %u\n", id);
> >> --
> >> 2.42.0
> >>
>
> I saw a segfault issue in Mesa yesterday. Not sure about the others, but =
I don't know how to make this change while compatibility with older UMDs.
>
> So I agree, let's revert it.
>
> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
