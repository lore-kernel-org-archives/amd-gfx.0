Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675F5CF45CD
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 20:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0887410E42A;
	Mon, 12 Jan 2026 20:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X2sjljbp";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D11E10E42A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 20:39:24 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-11f450147cfso551057c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 12:39:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768250364; cv=none;
 d=google.com; s=arc-20240605;
 b=ED4Vdfka/T1xwwarlrmvCueq7OQ6kYGh6DqJCBkaF9HzbVx4IrQEH2FtMbSLibGUwU
 LqQiA3Dpo1avJmBkkOxqGrBrHAAhgRv0cFQd6VCUoV1ccmwHEI2f7YMvhWJxKpLfBKsk
 X3jP3sHkzemggKs0Is7HdXkCCuUYwcnpIoHFWsxdX1V3Er6ngLn7HY/O3tk8z8NzxVSd
 BWd7+Lg/oKfsPAKmfIkgK/5vT1lvjhkFzVtb1dvxvhUHLNFrCWOQ8AJJGdwHP/TeRCpD
 GDLw8OY2vvsOUrEpqXwYNuNd+22DO0BUPK7F0JuHm2DSiWSZcJnFZn2XJnImgSw5hy9D
 VqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YC8AzZLHzYGphulFEq65wU6xQFNVs96yef1KGKqBwmo=;
 fh=cmbnxKGaY/GV8qYvKIqKF/CiZQ/tz8BYAOrWv0SqFeI=;
 b=TPvTnRp9kN4z3uVBrvqkqVOWb0GsPA4rNyvt/iegUT1JdKf9BRx6SZMSZd5VCObA0U
 vr+Br200LOMtB+si/c5BnNCQ4iU7YkfpV14tUYP0cP+JHgj2z7s0StDnpu1kNx+EGybc
 qNNwsfzNLsaNNqlSRyiDbWjhJ2ygjFtk+WQg03NA1Pxxox2lvdaBcYKkVlbt/8sIlCwV
 +NHLN685zFX0cI2MURYomfJkHK/FapVZX6/WvbRR6OLnxQopzKJQ8Qh5zDj0xMb+Ne6P
 +AOh5R8AJpKwBXGr8Lrue3HEQ1IjXeCiQ6nOUHI3UKRcmlWDIHSs+JITAlKGw0q2dtG/
 InOg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768250364; x=1768855164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YC8AzZLHzYGphulFEq65wU6xQFNVs96yef1KGKqBwmo=;
 b=X2sjljbpACEvdh7WcH9ZHqP0I5p4ZADvEnrxU2P9rd9T8oepN/mj99N19+EGx8m9J3
 JbQW5VuvQSK8/dxofkDi2tt8/ZrSpqNXHh1s6vN/y1By3Uq8E6Df0eDgRprt8BBl/nM9
 WjyS8quPYhQSS/DxVnG8jHgYxKRpobXGI+ClJy+5r6h0vi8+C/dhmaJrZFLA8NwDyNF3
 RHJqTwqFH540UmDr0z2hCMVCN3DGLyMmrhp6mco1B9o7ukOGOuCeINBdjk9/I3BeIJv/
 g33302cFeGmvd+yriY9JTfpxQjSYxi46FjNz7E8QpJK/UFcJF6G2eGCyTCz7szK8zQ1c
 uuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768250364; x=1768855164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YC8AzZLHzYGphulFEq65wU6xQFNVs96yef1KGKqBwmo=;
 b=skAbcX6wbzNf5euF+igGNzjzl2dmnim0GP+xLL0tRrlNP5V1OVX7cXckjiJTSO8dln
 jIaFCxvOXBXfBKMqkMZVnCrEuUV+6c4t3PTBtYJyPrOYs13eukkCOyNmlpR7q9Q1F58f
 X5x+T69FMnJt2MN22Fg1wh2cfGSF82jgBfR/16bkt7IOsJDKIHyf9Unl0Sm9KlY41tPx
 dwjI/HgCATfLsb7jj6GJ3CDEXXi0A3XJ5dfB6/2tmg509M/Uz5kWlLmc9kkKoVoCTMP/
 Wwf3+No3P7R6ANuIcKRS4RtWKHpI6zZ6kAorgtVq/ZIxXjtWUN9rx+RukwKVaK9vuwkD
 pnpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6x6QoUxViIsfPXwEVU0gnfg/95Y7VlT/SavbhIezG/C02RLDRnw58NEwnzgaDQxHIFAZOTJ1Q@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4n+qD0AEQFtmftS5UCHdVroR5BQ2mmLs+wLu6qKx7tqHkz+/D
 MB0R/x5U0a4NzYGHcRN5W6BoHx0KGm0dh1uglT//6BchlrTU+E6LH26r9hQvyiNt1suHL43GYCR
 CSaLtxYuZliHbk7wFFfWAZ54nm82BV5g=
X-Gm-Gg: AY/fxX7BZZb1nhkLPE1eHwN9lTXUTJfHHd72Z78+POg8yOK7aPlO6l1vUz0c1bScMUR
 vd7LxABXSP48QeXO/ypYMogg0XnVQvT+Ndy79c58SdUJ/sJmj5tL7RAvH+KN87XrXQ+R74W412m
 3Iam6tOJuEI3iHvbIqUpuuy92nr/S3qKzgU2+tiMY/BVmY+gboFVGkwmWYmWFVxrL74F6x8DT88
 DTsXLuyj5KCYE+6qXUw4ovzB/R7Dq23l07KKtBPBm0tL65BWTm0VU4j+Ec69BAtetb0uRuzUpYx
 ezGR+no=
X-Google-Smtp-Source: AGHT+IFMKBnpblhgyNf9I34rO5Xg/8Nx36yp3s5ZkBPmnjWfG296kjn6oRLUKbR8789xreE8l0hRcKQrCr7cCaxZbY0=
X-Received: by 2002:a05:7300:aa6:b0:2b0:2e6:5363 with SMTP id
 5a478bee46e88-2b17d1fedb2mr5893902eec.1.1768250363675; Mon, 12 Jan 2026
 12:39:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768223974.git.donettom@linux.ibm.com>
 <c04c9770-fc06-4e75-bbe5-6e418f7491a4@amd.com>
In-Reply-To: <c04c9770-fc06-4e75-bbe5-6e418f7491a4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Jan 2026 15:39:12 -0500
X-Gm-Features: AZwV_Qg-Me2YDY79bMItUSLAPT_r6rB8kUS54fgYgaJnsFhpl4sSnO0Q3TL-HD4
Message-ID: <CADnq5_MUwyYa4DSHk+9Aa80KGLTNAbir8Q11wStQSG1tK271Nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amdkfd: Add support for non-4K page size
 systems - part1
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com, Kent.Russell@amd.com, 
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, 
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
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

On Mon, Jan 12, 2026 at 3:28=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
>
> On 2026-01-12 09:06, Donet Tom wrote:
> > RFC -> v2
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In RFC patch v1 [1], there were 8 patches. From that series, patches 1=
=E2=80=933 are
> > required to enable minimal support for 64K pages in AMDGPU. I have adde=
d those
> > 3 pacthes in this series.
> >
> > With these three patches applied, all RCCL tests and the rocr-debug-age=
nt tests
> > pass on a ppc64le system with 64K page size on 2GPUs.  However, on syst=
ems with
> > more than 2 GPUs and with XNACK enabled, we require  additional Patches=
 [4-8]
> > which were posted earlier as part of RFC [1]  Since that require a bit =
of additional
> > work and discussion. We will post v2 of them later as Part-2.
> >
> > 1. Patch 1 was updated to only relax the EOP buffer size check, based o=
n Philip Yang=E2=80=99s comment.
> >
> > 2. Philip=E2=80=99s review comments on Patch 2 were addressed, and Revi=
ewed-by tags were added to
> >     Patch 2 and Patch 3.
> >
> > [1] https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm=
.com/
> >
> > If this looks good, could we pull these changes into v6.20?
>
> The series looks good to me.
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
> Alex, what does it take to get this into 6.20? I guess you'll want to
> include this in a pull-request for drm-fixes ASAP?

Yes, if you can land it in amd-staging-drm-next ASAP, I'll include it
in this week's PR.

Alex

>
> Regards,
>    Felix
>
>
> >
> > This patch series addresses few issues which we encountered while runni=
ng rocr
> > debug agent and rccl unit tests with AMD GPU on Power10 (ppc64le), usin=
g 64k
> > system pagesize.
> >
> > Note that we don't observe any of these issues while booting with 4k sy=
stem
> > pagesize on Power. So with the 64K system pagesize what we observed so =
far is,
> > at few of the places, the conversion between gpu pfn to cpu pfn (or vic=
e versa)
> > may not be done correctly (due to different page size of AMD GPU (4K)
> > v/s cpu pagesize (64K)) which causes issues like gpu page faults or gpu=
 hang
> > while running these tests.
> >
> > Changes so far in this series:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > 1. For now, during kfd queue creation, this patch lifts the restriction=
 on EOP
> >     buffer size to be same buffer object mapping size.
> >
> > 2. Fix SVM range map/unmap operations to convert CPU page numbers to GP=
U page
> >     numbers before calling amdgpu_vm_update_range(), which expects 4K G=
PU pages.
> >     Without this the rocr-debug-agent tests and rccl unit  tests were f=
ailing.
> >
> > 3. Fix GART PTE allocation in migration code to account for multiple GP=
U pages
> >     per CPU page. The current code only allocates PTEs based on number =
of CPU
> >     pages, but GART may need one PTE per 4K GPU page.
> >
> > Setup details:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > System details: Power10 LPAR using 64K pagesize.
> > AMD GPU:
> >    Name:                    gfx90a
> >    Marketing Name:          AMD Instinct MI210
> >
> > Donet Tom (3):
> >    drm/amdkfd: Relax size checking during queue buffer get
> >    drm/amdkfd: Fix SVM map/unmap address conversion for non-4k page siz=
es
> >    drm/amdkfd: Fix GART PTE for non-4K pagesize in svm_migrate_gart_map=
()
> >
> >   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
> >   drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  6 ++---
> >   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 29 +++++++++++++++++------=
-
> >   3 files changed, 25 insertions(+), 12 deletions(-)
> >
