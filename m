Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60752C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF8D10E612;
	Wed, 28 May 2025 13:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJyQAhRs";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914A810E614
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:49:39 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-af90510be2eso518705a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748440179; x=1749044979; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVYwcBdYQRn+hnIx90geFwPfxN+Q9Kw74hkLyO5/YaM=;
 b=kJyQAhRsPoArnTaRuDLINRV4fBGvgngZO4Htj5ShG5d1NXyMBRxuEIl5bz2qic6kKZ
 /JBzc96K7X6wJNKYmuM40iVs+A1WLPh8i+GrLPIjjlSjug9LKcLqyj0TltXilqGfk9B8
 zuHoGPQs7kwgf+Y3quzmzaYrJcaoh/1MJ+6gmSqBPpSnTyDi32MdqnPJI6/RO8D0B6LE
 JVOxpX26uz0CaruhoIzHGR8Fv104TGfv3HO1mTy4tSnVS+X18sBzHCRwv8HQn1IDD9Rs
 qhAYU1LDkWrTDrMvRdSmrdp4+P3gLjcW0OJ+sQMLBPkYM5at6rhIMlS4jsBHHDwK8XXc
 K21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748440179; x=1749044979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVYwcBdYQRn+hnIx90geFwPfxN+Q9Kw74hkLyO5/YaM=;
 b=JzZQPSfesBGSbTCjQslmOn3gFVqaeATbiw0JsJ2Zy+OeRIMOgmrVW+C8KjUiNJkBn+
 3+5EEprZe7rlfSlICj9lrTuG5M/FPbLQWmTf/qw9IAxgvYmjZPh152MwuWryTMKba+ZM
 ppZoE5fZAyZmzcxVCk0XFHEBHncIKh42Kd6FvgDt01yQQ+JcKVS1qJBvBjoLnzhabU7y
 r+re0APirImOzAogC/YFbRMIzoq7wWcj8G1WYfBPdJqImnopjXTBzxKiBqxNxBCjbRJZ
 PXnYxcsccSJsPG31/vWgEAJ//9jl+maNaZRKZFFXEPAXXTj8Ww+0qTjn35BWlrQ6/ZZU
 P0yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD3NzUz3p1XuKYRQsUhTMfiAHJV8UNtkahelZKv1EYvKX3z1tvDSwwtIYSh9J/PplEr78UWecd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAjCQfdKyRzAlYfAJ5oNQsZpiQOToi0BdJ/Z08LPJwpjZoLZVx
 eHkj8xNbgm4uaTMO+/yGRxzsV31WPMUN/Daas20b62z1oAMWduojkUJYxHumEF1tJqULtWQGKMS
 4kfVKpOYlQ243wGc7HbZZuy4a1TT50j4Vzg==
X-Gm-Gg: ASbGncsc3PTWKuZeNFdhRPFLwPUONCXyRvcWNufUWVZASqmC8SCVarJ3IrpD6nRfDNq
 aPOxQXu144AmuvLBMx791eDXg/aTWpKWRAT5xVa22BIc5Avt3MB5KHbHtbAH68KPaSKCINjzxrb
 +tZrTp6D+8v4aRZTgjz/r/KSy6clrEqSEYZSNd2vgeUiUz
X-Google-Smtp-Source: AGHT+IGDrUnoo+GnLOeeJgqo75X0TuzDGGyxh4iw/9QNAqZFm0cXEut72cU3cO6584KiU0HCF9zHTy76SV77vOcWh8A=
X-Received: by 2002:a17:90b:3c81:b0:312:db8:dbcf with SMTP id
 98e67ed59e1d1-3120db8ddadmr139457a91.6.1748440178957; Wed, 28 May 2025
 06:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-11-alexander.deucher@amd.com>
 <7299c780-8d32-4840-91f8-0056d7acdf52@amd.com>
 <CADnq5_PaFMC+VxnDmeqXZLqj7_0ifwgLpVB5aVw8x3VghK2VaQ@mail.gmail.com>
 <d8fd14ec-6c5b-4719-9bca-6f4c732aacab@amd.com>
In-Reply-To: <d8fd14ec-6c5b-4719-9bca-6f4c732aacab@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 May 2025 09:49:27 -0400
X-Gm-Features: AX0GCFs1YLYqnrdUzx3YgFkJE8z3dFqymOL1nlXM7b8qwse05ly8PlJniamlY4o
Message-ID: <CADnq5_MbjJBw=QB7UM6H+Zdnzgq=su4nsVNZtEm=hKfqT3hUwg@mail.gmail.com>
Subject: Re: [PATCH 10/19] drm/amdgpu: pad ring in amdgpu_ib_schedule
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, May 28, 2025 at 9:42=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/28/25 15:41, Alex Deucher wrote:
> > On Wed, May 28, 2025 at 7:45=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/28/25 06:19, Alex Deucher wrote:
> >>> We'll want to include the padding in the wptr count
> >>> for resets.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ib.c
> >>> index 802743efa3b39..3e05e8bfaca4a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>> @@ -304,6 +304,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, =
unsigned int num_ibs,
> >>>           ring->hw_prio =3D=3D AMDGPU_GFX_PIPE_PRIO_HIGH)
> >>>               ring->funcs->emit_wave_limit(ring, false);
> >>>
> >>> +     amdgpu_ring_pad_to_fetch_size(ring);
> >>> +
> >>
> >> Hui? Why that here? amdgpu_ring_commit will do that anyway.
> >
> > So that I can know the full size of the submission frame for this job
> > when I grab the follow-on ring contents to re-emit.  See the next
> > patch.
>
> Ah! Ok, why not doing that after the ring_commit? Then we don't need to c=
hange anything here.

Oh, yeah, that should work.

Alex


>
> Christian.
>
> >
> > Alex
> >
> >>
> >>
> >>>       amdgpu_ring_ib_end(ring);
> >>>       amdgpu_ring_commit(ring);
> >>>       return 0;
> >>
>
