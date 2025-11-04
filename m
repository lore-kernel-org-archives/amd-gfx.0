Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28158CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE33710E624;
	Tue,  4 Nov 2025 15:11:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I84XAc+6";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483B910E623
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:11:13 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-640741cdda7so7297260a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762269072; x=1762873872; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkWNBCxdu/qJRVWkndYWAF86ue/NeG+i14M/vnx/LtU=;
 b=I84XAc+63EpNpIK6/pSxjFQHcxADafrLlS76qqXSip/9OdH87dA9vdCwHilAmxbIHo
 f3aTI7VxiP0dmtKnBytdfe+kUpOlaWGx/gJZkfMyzY6GkOmntRuuD9ZhiDf3bdOuEyAY
 JCTWVHSXNEBIBjriOo2qo4+2NOQJMhuwYaOe8aVYUiq/pFu9wNoNacKcDOh4djQ8M45W
 jRBUMlvNbQKEgcoAsuVDopKmCXm8u2YJ47YVlxMAgljOufA0hEzbLF8UB8z54L5cav/z
 jJlGM2MVFPcKoN9ZOYuOGVYkSztfagVoYHRpUnTKVUnM5vlqwhBCmwDNCJKFszbUP8pt
 iTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762269072; x=1762873872;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkWNBCxdu/qJRVWkndYWAF86ue/NeG+i14M/vnx/LtU=;
 b=iKhaobnCiOTPGtDUyf51t+iReSWPC292pCZhsZbUJrKEI0rdrfsC/lOTv2Y1zMC8PF
 ff9PvwTLmRdox8KrQxbrl6FXHBExdriXUya3WhdY+6zWlL9GH1IDETTh+LjRTf3QqbXq
 8SSiK7nzjQU9dKPzPoiv7uWNo1UpyzaRYu1fhINOUwGOF2YDRUMQf9eofw4WcSyhpjsp
 hhcwlBxH+c2rvb1/MrWNZeBHvR0DFiXsBukQandnMONHA+MqSLIeEa+PC+1K8AdUkRi/
 6tgT81wDxcvOEUjm6FWyhuaTgiPDnWe1gcPZrnZp8gYb5DYQCN4uRgh1pdyCgbgHBmJi
 fzbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXctnZGaRBIXsxQirC6kuzzASAH8sOaZWALFPP12QmqRjXzdgo1f+n6wOjF88Hbk2hrkLSD4kJ1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyORtx4H0Gtl+jkLJENzEDClgfp+8JHNynRv8f+TwbVkTCLnxU6
 yXqin7rNC0NINRx50sVvlRjg6qGvIyZv7tMSbXzPh8vxR1HhSkwbDq6R
X-Gm-Gg: ASbGncsjxkjMiBEjomuKxGVOZzmclKUkXOWQjqGJGC9luknVT0ZwT81GVmS0pVri8HC
 N0wi7kOK/sgrMQZwOQGn48TMw9tsh32wBAjVrT66dCDIN7ssy9O0xqvLvp7jCHpHEhp6H9+tsps
 BEYd9Yp9yh+FKLfVhBVGaCG3Gdzm9GL2WPJLXp3x+FG8tTmG0G2/Gj9f/DofucR/jwjnLwlbe0U
 Pt7V8TrVlPUCAvU6ZUF/YjzECFin3y00emnxqYJ/L7BAzdlQENQzP+PGSdWLZwVsi4m4iF3FY55
 nTy86Q8BjzQWyU+g5eIl1Y21csJH7fTYHG+kzYszfLiG7AGDJGaEI7f4Ofm3Td4HCaQ5Ii3lbQb
 UapwSQERMgFGLSM93xecn/jJXVsCYRrYwNhG3QIZnsmVdMPZu32GHMshhOz7NPMFTk/BHJrmNx8
 8cLDhmOYv4Aa3CTK0J7NDPJqEpb2Mo7bDBQdWptmvqqdshMRQE0Km+
X-Google-Smtp-Source: AGHT+IGWU1sZbk2SLVjdNtnHpm9u3J9ncv4QZJjvSBRocsvf/4uiLrUL1hE4Jj0kYflKGi4ikAbj+A==
X-Received: by 2002:a17:907:9628:b0:b6d:62e4:a63a with SMTP id
 a640c23a62f3a-b70704c3ec7mr1645897666b.40.1762269071544; 
 Tue, 04 Nov 2025 07:11:11 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:8825:f46d:d14d:d33?
 ([2001:4c4e:24ca:a400:8825:f46d:d14d:d33])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d6f9b7csm237086866b.21.2025.11.04.07.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 07:11:11 -0800 (PST)
Message-ID: <2a99b4d9433889742782f76a0d7cf5e6a9dac8c2.camel@gmail.com>
Subject: Re: [PATCH 05/16] drm/amdgpu/ttm: Use GART helper to map VRAM pages
 (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Date: Tue, 04 Nov 2025 16:11:08 +0100
In-Reply-To: <6814cde4-0b65-4873-a006-ee52520a8fa2@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-6-timur.kristof@gmail.com>
 <6814cde4-0b65-4873-a006-ee52520a8fa2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-11-04 at 14:33 +0100, Christian K=C3=B6nig wrote:
> On 11/3/25 23:23, Timur Krist=C3=B3f wrote:
> > Use the GART helper function introduced in the previous commit
> > to map the VRAM pages of the transfer window to GART.
> > No functional changes, just code cleanup.
> >=20
> > Split this into a separate commit to make it easier to bisect,
> > in case there are problems in the future.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> Could also be squashed into commit #4. Otherwise commit #5 just adds
> unused functionality.
>=20
> But not a must have from my side.
>=20
> Regards,
> Christian.

I prefer to keep the two commits separate to make it easier to bisect
and troubleshoot. In case there are any problems with it, commit #5 can
be reverted without regressing the VCE1 functionality.

Thanks,
Timur

>=20
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++----------
> > =C2=A01 file changed, 2 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index e226c3aff7d7..84f9d5a57d03 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -188,7 +188,6 @@ static int amdgpu_ttm_map_buffer(struct
> > ttm_buffer_object *bo,
> > =C2=A0	struct amdgpu_job *job;
> > =C2=A0	void *cpu_addr;
> > =C2=A0	uint64_t flags;
> > -	unsigned int i;
> > =C2=A0	int r;
> > =C2=A0
> > =C2=A0	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
> > @@ -254,16 +253,9 @@ static int amdgpu_ttm_map_buffer(struct
> > ttm_buffer_object *bo,
> > =C2=A0		dma_addr =3D &bo->ttm->dma_address[mm_cur->start >>
> > PAGE_SHIFT];
> > =C2=A0		amdgpu_gart_map(adev, 0, num_pages, dma_addr,
> > flags, cpu_addr);
> > =C2=A0	} else {
> > -		dma_addr_t dma_address;
> > -
> > -		dma_address =3D mm_cur->start;
> > -		dma_address +=3D adev->vm_manager.vram_base_offset;
> > +		u64 pa =3D mm_cur->start + adev-
> > >vm_manager.vram_base_offset;
> > =C2=A0
> > -		for (i =3D 0; i < num_pages; ++i) {
> > -			amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
> > &dma_address,
> > -					flags, cpu_addr);
> > -			dma_address +=3D PAGE_SIZE;
> > -		}
> > +		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages,
> > flags, cpu_addr);
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	dma_fence_put(amdgpu_job_submit(job));
