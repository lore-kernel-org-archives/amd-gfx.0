Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A4EC982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 21:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC9410EAEB;
	Mon, 21 Sep 2026 21:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aqpbO4Ql";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F7D10E9AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 21:38:48 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d6ff2f2c4eso7162865ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790026728; cv=none;
 d=google.com; s=arc-20260327;
 b=nHU/QOvV+Cs8Y/yOeGuk0/TpuPyDrX4wKj6QdBfMa/oM7PUL57289exqj4xVFaYwe3
 0zzeLMUcOpP90SzclkNelv+w95/ERZ5qmvVUTGOEVILxnlempNuCtH1DyYu8FrXROvVi
 s2lemRexsbj4sPSL+2wR6Sq4Hv4K+ULtou86LHk8dsAO30EschnQrhWfRVr6+oVSmT0x
 wAwIvcY179mmJgIs7q0Y1kvczt21+lz+rZra98deukL2eW/rG1YvRnBNZsi+eV9DhOG6
 pkDQ7tsJ+ezKyE0KV1CLmoolFjFYFZvsiG0OSHRNcaTIp6c01UJwLyYZfMERTl2LcOSY
 ySVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=42+LsdJSwqkI6ZdgykzHjxDiU7dpvNfDLxjjxGmd7ZE=;
 fh=k+xdX7N7oHCRL0EAYFn8kzf1PqK5A5H26KCgHxvQ6oQ=;
 b=Pn9DHNRGJmHRqHhWPpIlY+7mVVPPd9lah8hLDVkacxetgdkicIqnFRCPIc6h3oEQJe
 oLzXsXlxRztmpSRqzc0O5MU48yE7pCfc0WzDZbWsA9jUFFTpiOh7A8yM4R1DK3CHz4iu
 07Y39zPy57aMyeEKH6DN6MAL4EQ1kUscyHOzi75lAi/M10ws1nFOnmlGXi+jGpIqR0PM
 RMRCFulCWTpKZv3cbqPQPkrNbbbKJsiuHJxYW9qkI8mWNCHs+yjmvmQiXqDJgSMAbsZ7
 fZfsluKMFsp+vO/xoa2RkNgvSHSgQCNa22cwloPHg1H7dkqgYjPm2ImU9VY0E5o7h5oU
 Fdgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790026728; x=1790631528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=42+LsdJSwqkI6ZdgykzHjxDiU7dpvNfDLxjjxGmd7ZE=;
 b=aqpbO4Qlp70PXALBpN3C9gdOYEbQNydcEKkXb+y/pTuxm9ijiD88ztNbkuedLY2xkf
 YGrjzEKllU8RkeoEFkxX+preaxz1pynlrv5/zd4ilhw0ZXda2wHsmuFOVrVjdZ/sYifr
 ZNO+diOF6dnzmflL+mM3dqRPtsje5j0ofrnBL1HDki1f4BLSFaEc9Uhx7iyHyqrZXn48
 N3IyTcM9k7MNRsmgjODLm4LZTnT+kIRObxhmPn8orZWBnbLheJ+0aB3uNvgYGocOpW3c
 3JbdCBifvWR+pUVSRRsDhC72+3tGY72h2WNvMq6OcRI1OorxPIPej7sMl1m+AYm838Oj
 +2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790026728; x=1790631528;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=42+LsdJSwqkI6ZdgykzHjxDiU7dpvNfDLxjjxGmd7ZE=;
 b=cwbS5PlnPK71agD0rC3tj3m6aE7NPwxgbSZYsFjeP/vrQpkhd7qYiI1VHZNRHqE/8Z
 GLYI2fcMt95CFdi6ZygiP1LsBBUazTN33ZjD9gFmzyKhIqeicbGKFf7zY8f7soa6sdaK
 mNJWDrMo5Hfyf+V5NIoJCy+gNv3AHO/loCRP3dckkZTprfpLZx22rAxlbNU5uclguPjE
 MPj8zKZ0L42WZy2u8VQpt5SRXfj7go4or1Ui8G4E1d9Qy0KuTPwDSRS+fA7yoPii8qqA
 ZQkSk9J57t9T/sR5lA5wyyaOJQiCyxoB1nzL3KXY/EsVWC7q0x00OxXJCgYxOhnYvkUL
 0CDQ==
X-Gm-Message-State: AFuF++kNeX6S5lUkGT9UoaVw30bwIcFF/hnOZid3ZgdT7bpBnRWgWNyn
 3GzIfaeTM9ujvapzGJzifiJsuXzR+KHc6NPzI7mBhNV+PEcUrfYd5PeCu7mkHIZnQK7EfFRW2Ox
 qUOlGa+qz4S4XQFTGjV6Od4O/JvtN/ps=
X-Gm-Gg: AYBFou3rrxGKrppeT6St8+C8+vR6nrYFvq9/f5EM+NWxRH0ylowDEvVyfScDNllJz1S
 oU7P3pUnWrcPMxhuC/VKzwKRZU0wtGZqpR9RnmE60raLMAWfj+fShkhKgbYw5qUUsYevaGKVtFR
 aoavk5W7/LoOBQkAmVurWMGMYWLT2SckXPihXikxjRNjEyIMqimkQE/fwkowTduKvJ6leBoQ11u
 OIlHSkWrUDWlhLKvNME5MmKi3jdqLLXwYPTWvveRpxCpuVeQG4nXAaEu9kSDi3tDa9NhkLKXSAM
 CSOSe6QGcevQ5NEX8vnOSxxPw1KVl/LDhdXVkvLZgoURnYMzJxBtyPzaNJeCN3cjQtZs92jAs8t
 HzsFIVwIls5TTzbQIB18ICDJ2a0g70Z4X+w+UrpPV/Q==
X-Received: by 2002:a17:90a:282:b0:39e:b778:2b2e with SMTP id
 98e67ed59e1d1-39eb7786404mr10461375a91.5.1790026727769; Mon, 21 Sep 2026
 14:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260915145833.601947-1-andrew.martin@amd.com>
 <DS0PR12MB75369C49F33D3D517826ED21F5B82@DS0PR12MB7536.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB75369C49F33D3D517826ED21F5B82@DS0PR12MB7536.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:38:33 -0400
X-Gm-Features: AcwNN1X4IGUkyMavBtT80IGPQR6iafjHTMnqyvtMh7R7p22AVbtvkta2wKwWK1Y
Message-ID: <CADnq5_PG1xYL_LvVgtjA=4-O_xqGW3sA5xVmb_D0XO+CDUFwJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: don't widen the validate GPU set past one
 page owner
To: "Martin, Andrew" <Andrew.Martin@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>
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

On Thu, Sep 17, 2026 at 2:26=E2=80=AFPM Martin, Andrew <Andrew.Martin@amd.c=
om> wrote:
>
> AMD General
>
> Greetings, sending peace
>
> Just a Ping to have a look at this.

Looks reasonable to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> > -----Original Message-----
> > From: Martin, Andrew <Andrew.Martin@amd.com>
> > Sent: Tuesday, September 15, 2026 10:59 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Yang, Philip <Philip.Yang@amd.com>; Martin, Andrew
> > <Andrew.Martin@amd.com>
> > Subject: [PATCH] drm/amdkfd: don't widen the validate GPU set past one =
page
> > owner
> > Importance: High
> >
> > Commit 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to
> > no-access") made svm_range_validate_and_map() OR bitmap_access into
> > ctx->bitmap unconditionally for a range carrying
> > KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED.  Previously that only
> > happened when
> > ctx->bitmap was still empty:
> >
> >       if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> >               if (prange->mapped_to_gpu ||
> >                   prange->flags &
> > KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> >                       bitmap_copy(ctx->bitmap, prange->bitmap_access,
> >                                   MAX_GPU_INSTANCE);
> >       }
> >
> > The block just above already sets the bit for prange->actual_loc when t=
he range
> > has been migrated to VRAM, so under the old code ctx->bitmap was left
> > holding that single GPU and the OR was skipped.  Without the guard it n=
ow
> > also picks up every other GPU with the ACCESS attribute.
> >
> > That matters because ctx->bitmap is not only the set of GPUs to map.  I=
t also
> > selects the HMM owner: owner is taken from the first set bit and reset =
to NULL
> > as soon as two set bits disagree.  On a two GPU system with ACCESS on b=
oth,
> > owner becomes NULL, and amdgpu_hmm_range_get_pages() then no longer
> > recognises the process's own device-private pages.  HMM calls migrate_t=
o_ram
> > on each of them, svm_migrate_to_ram() sees
> > p->svms.faulting_task =3D=3D current and returns 0 without migrating, a=
nd
> > hmm_range_fault() retries the same page forever.
> >
> > Which GPUs disagree depends on the interconnect.
> > SVM_ADEV_PGMAP_OWNER() is the XGMI hive when the device has one and
> > the adev otherwise, so GPUs sharing a hive also share an owner and neve=
r trip
> > this.  It takes two or more GPUs with ACCESS that are not in a common h=
ive,
> > which is why this only shows up on multi-GPU machines with no XGMI link
> > between the cards.
> >
> > On a 2x Instinct MI350P (gfx950) this hangs
> >
> >   HSA_XNACK=3D1 hipblaslt-test \
> >     --gtest_filter=3Daux_handle_test.set_sm_count_target_default_is_zer=
o
> >
> > The application never completes and burns 100% of a CPU in the kernel.
> > /proc/<pid>/stat shows utime frozen while stime climbs and minflt advan=
ces at
> > roughly 12 million faults per second, reaching billions; majflt stays a=
t 0 and the
> > GPU sits at 0% busy.  perf on the stuck task is 24% svm_migrate_to_ram,=
 23%
> > __handle_mm_fault, 5% do_swap_page.  The process cannot be killed and t=
he
> > machine has to be rebooted.
> >
> > Restore the bitmap_empty() guard.  The rest of that commit is kept: the
> > bitmap_mapped tracking, bitmap_needs_unmap, mapping_done and the
> > unmap of ranges set to no-access are all unaffected, and bitmap_mapped =
is still
> > ORed in at the top of the branch, so a range already mapped on a GPU st=
ill has
> > its mapping updated there.
> >
> > The instrumentation, the hardware testing and this changelog were done =
with
> > the assistance of an AI coding agent; the resulting change has been rev=
iewed by
> > hand.
> >
> > Fixes: 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to no-
> > access")
> > Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> > Assisted-by: Claude:claude-opus-5
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > index c521ec07bf3c..75e25f075da3 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > @@ -1758,9 +1758,14 @@ static int svm_range_validate_and_map(struct
> > mm_struct *mm,
> >
> >               /*
> >                * If prange with always mapped flag, update mapping on G=
PUs
> > with
> > -              * ACCESS attribute
> > +              * ACCESS attribute.  Only widen the set when nothing els=
e has
> > +              * selected a GPU: ctx->bitmap also picks the owner passe=
d to
> > +              * amdgpu_hmm_range_get_pages() below, and spanning
> > GPUs with
> > +              * different page owners forces that owner to NULL, which
> > makes
> > +              * HMM fault on the process's own migrated pages.
> >                */
> > -             if (prange->flags &
> > KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> > +             if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE) &&
> > +                 prange->flags &
> > KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> >                       bitmap_or(ctx->bitmap, ctx->bitmap, prange-
> > >bitmap_access,
> >                                 MAX_GPU_INSTANCE);
> >       } else {
> > --
> > 2.43.0
>
