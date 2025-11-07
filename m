Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7114FCCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 10:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047F310EA77;
	Fri,  7 Nov 2025 10:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jda9FzZH";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0122610EA77
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 10:47:14 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so2667855e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 02:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762512433; x=1763117233; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1tJYkkrDEOWSugxlaLxSp9y2w03op0vKi1qdQQCXew=;
 b=Jda9FzZHbI9fbgpzEnCwb23duXM4PDWH5I9DipGDlvDvaAVnIjBMJUOo+adSffPOvq
 5cKqU1+93uaqWiJ9ZhXL7kvYbQLwOpoO/UjnYoNf3rTGG6QdEReC91ILiAnWkeUR3R9b
 xj2EYX3xhUJzrAafFeHreubD5vw6o44aWfuxdRq0CNbJ0y8Z88rhIfAgt35hIGXZvnlc
 DTGPu8tj95eSEc04Dcftj5SJEjWelYaLtnX/29xheqDraHfbWj6U0QGMtOVsuViyVBwc
 HIZpbQFkpr221KryxYnRumsQBO2wlR52qJu4MWIJ/bQMW0uVO8lOALmxrvtxkM7gbR9g
 7XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762512433; x=1763117233;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V1tJYkkrDEOWSugxlaLxSp9y2w03op0vKi1qdQQCXew=;
 b=H6zglC9KBoP+R0Y+fTiWw+gOdI6YHgB1qE4rNwPSYFf2P1ZCHa0mzRSYybSBVKx+ul
 5xDbS4P1skW8uGokp4AHsJikRZvXe8qmhwMk30kbwDNRA3ep255DLUePaKYZPBhtXZRF
 79BzJoJ7RMX3YQ/+SJSgJec+/Y4q0QOrmEtDtdcI7ryrUqTPAOaqtrQkMQMiW3W/ERen
 Czf4LpSSNSgCgWANSYQZQ49P8ZwUlWNm9BJVH/TxMs4B24thmyqSy+JwMLMGwwFRUReg
 1tOOx9T+YpAG0L1QPZCITyrtb7rrXFdNq0UP7pPIVTuxzIFCgQXs14ARqVA17ustoLFY
 Y7DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO+P+8NNlvcsxitVbcVA3YDHixMo6vegKajzuYcdnMDMvAIakpP1N8aRxDE12VyefmUXYbU7xU@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8UJwfD/lrx0IpxPFT2SIMHecK8n6mS9LrawDivovtme/cqBdJ
 Uh1Chpiano28+ihdaD6GyN5uBEUur8UQBkE/6eXEP/yBHRalP1csohUD
X-Gm-Gg: ASbGnct5cf/ykT18enJ52qzLSLkVjCafD6dUoswcLTvSqjxOecojCVYQtAz4IK7hMPP
 0GGyU0/xTJi2yrORout+6lYAA4vGa0V9sm1VfFLAmqW7qRmJJtFgNqKKHrr190CGYJrn/ePUQNX
 LQcA86lwLd++9//FbksyNYBIigwQdytdur6KympjUuehXfJyUC8YQWvMmrpGOcJTsfP23aDWG98
 FfnW2KIhHCYWhRjuMCJzsx6LTruOoycy2SbxO6Lej0yCPixzZCZvkoeBt+eOk+Blgl42iCcmAGX
 Q3K2MY1dhZqOv1ozQLht/v9l2ZwsG+dHWhybvmrSalzJjF9uHxKv2OjS3lyT5oK7bN2xUmgzr9D
 5kFSl9UedPqpse9COgGNGRpaBYhDQlh2Fxt127F/KrnU2gmbi3fqEceHj6PToQjQO+fHLVfMakJ
 EG0SxWrHGisU2hoLazXNNhs7RqNVFGK29G/xeu9Pt+tTcaKeP+uC0//4yyz7fYezHaTfMbBLp3B
 0REVQuwcrDZOiRNe50DTL+5bfWR3jiPT6NFRRZ1KHwb4OjFtHTCkqc=
X-Google-Smtp-Source: AGHT+IGtph3xwbbzSArXIMTpyoZ95fbYq7ACPL0cCmA8Eiept1Pcnb0fsWJrTVvyxGcw8iuHWxpSLQ==
X-Received: by 2002:a05:600c:4f13:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-4776dc1c3a1mr10193665e9.7.1762512433257; 
 Fri, 07 Nov 2025 02:47:13 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3?
 (20014C4E24CAA400C3D82D5ACB81C0D3.dsl.pool.telekom.hu.
 [2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776d39c8f8sm26392415e9.3.2025.11.07.02.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 02:47:12 -0800 (PST)
Message-ID: <a1f6e8e49d4f3d3a90afa8d3232b15626c34d991.camel@gmail.com>
Subject: Re: [PATCH 06/13] drm/amdgpu/vce: Save/restore and pin VCPU BO for
 all VCE (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>,  "Dong, Ruijing"
 <Ruijing.Dong@amd.com>
Date: Fri, 07 Nov 2025 11:47:10 +0100
In-Reply-To: <f0bbffa2-3b34-4f36-9fb2-44bcbcb5b8a3@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-7-timur.kristof@gmail.com>
 <991f6d36-81e4-42d2-b301-0755fa00ffde@amd.com>
 <b7eb6efea5606c6d9b6d1bcdea6552b3602517bf.camel@gmail.com>
 <f0bbffa2-3b34-4f36-9fb2-44bcbcb5b8a3@amd.com>
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

On Fri, 2025-11-07 at 11:01 +0100, Christian K=C3=B6nig wrote:
> On 11/7/25 10:53, Timur Krist=C3=B3f wrote:
> > On Fri, 2025-11-07 at 10:49 +0100, Christian K=C3=B6nig wrote:
> > > On 11/6/25 19:44, Timur Krist=C3=B3f wrote:
> > > > VCE uses the VCPU BO to keep track of currently active
> > > > encoding sessions. To make sure the VCE functions correctly
> > > > after suspend/resume, save the VCPU BO to system RAM on
> > > > suspend and restore it on resume.
> > > >=20
> > > > Additionally, make sure to keep the VCPU BO pinned.
> > > > The VCPU BO needs to stay at the same location before and after
> > > > sleep/resume because the FW code is not relocatable once it's
> > > > started.
> > > >=20
> > > > Unfortunately this is not enough to make VCE suspend work when
> > > > there are encoding sessions active, so don't allow that yet.
> > >=20
> > > The question if this is the right approach or not can only Leo
> > > and
> > > Ruijing answer.
> > >=20
> > > If we can get VCE1-3 to keep session working after suspend/resume
> > > we
> > > should make this change otherwise we should rather make all old
> > > sessions invalid after suspend/resume and only re-load the FW.
> > >=20
> > > Anyway I think you should make the removal of
> > > "amdgpu_bo_kmap(adev-
> > > > vce.vcpu_bo, &cpu_addr);" a separate patch, cause that seems to
> > > > be a
> > > good cleanup no matter what.
> > >=20
> >=20
> > This change is necessary for the VCE1 code when it loads the
> > firmware
> > signature. Without this patch, we would need to call reserve(),
> > kmap(),
> > kunmap(), kunreserve() in vce_v1_0_load_fw_signature().
> >=20
> > Let me know which approach you prefer.
>=20
> In this case definately make removal of amdgpu_bo_kmap(adev-
> >vce.vcpu_bo, &cpu_addr) a separate patch.

Sorry, can you clarify what you mean?
Should I just go back to the way things were on the first version of
the series, and then clean it up later?

>=20
> I want to get initial VCE1 working and landed independent of what
> Leo/Ruijing say to suspend/resume.

Agreed.

>=20
> Can be that suspend/resume is then still broken, but that is also the
> case for VCE2-3 then.

Yes, some extra work is going to be needed on top of this patch to make
suspend/resume work (if it's possible at all).

>=20
>=20
> >=20
> > >=20
> > > >=20
> > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > ---
> > > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++--------=
-
> > > > ----
> > > > =C2=A0drivers/gpu/drm/amd/amdgpu/vce_v4_0.c=C2=A0=C2=A0 | 52 ++++--=
-----------
> > > > ----
> > > > ----
> > > > =C2=A02 files changed, 24 insertions(+), 72 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > index 2297608c5191..4beec5b56c4f 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > @@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct
> > > > amdgpu_device
> > > > *adev, unsigned long size)
> > > > =C2=A0	if (!adev->vce.fw)
> > > > =C2=A0		return -ENOENT;
> > > > =C2=A0
> > > > +	adev->vce.saved_bo =3D kvmalloc(size, GFP_KERNEL);
> > > > +	if (!adev->vce.saved_bo)
> > > > +		return -ENOMEM;
> > > > +
> > > > =C2=A0	r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0 AMDGPU_GEM_DOMAIN_VRAM |
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0 AMDGPU_GEM_DOMAIN_GTT,
> > > > @@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct amdgpu_device
> > > > *adev)
> > > > =C2=A0	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev-
> > > > > vce.gpu_addr,
> > > > =C2=A0		(void **)&adev->vce.cpu_addr);
> > > > =C2=A0
> > > > +	kvfree(adev->vce.saved_bo);
> > > > +	adev->vce.saved_bo =3D NULL;
> > > > +
> > > > =C2=A0	return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > > > @@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct
> > > > amdgpu_device *adev, struct amdgpu_ring *ring)
> > > > =C2=A0 */
> > > > =C2=A0int amdgpu_vce_suspend(struct amdgpu_device *adev)
> > > > =C2=A0{
> > > > -	int i;
> > > > +	int i, idx;
> > > > =C2=A0
> > > > =C2=A0	cancel_delayed_work_sync(&adev->vce.idle_work);
> > > > =C2=A0
> > > > =C2=A0	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > =C2=A0		return 0;
> > > > =C2=A0
> > > > +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > +		memcpy_fromio(adev->vce.saved_bo, adev-
> > > > > vce.cpu_addr,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_bo_size(adev-
> > > > >vce.vcpu_bo));
> > > > +		drm_dev_exit(idx);
> > > > +	}
> > > > +
> > > > =C2=A0	for (i =3D 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
> > > > =C2=A0		if (atomic_read(&adev->vce.handles[i]))
> > > > =C2=A0			break;
> > > > @@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct
> > > > amdgpu_device
> > > > *adev)
> > > > =C2=A0 */
> > > > =C2=A0int amdgpu_vce_resume(struct amdgpu_device *adev)
> > > > =C2=A0{
> > > > -	void *cpu_addr;
> > > > -	const struct common_firmware_header *hdr;
> > > > -	unsigned int offset;
> > > > -	int r, idx;
> > > > +	int idx;
> > > > =C2=A0
> > > > =C2=A0	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > =C2=A0		return -EINVAL;
> > > > =C2=A0
> > > > -	r =3D amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
> > > > -	if (r) {
> > > > -		dev_err(adev->dev, "(%d) failed to reserve VCE
> > > > bo\n", r);
> > > > -		return r;
> > > > -	}
> > > > -
> > > > -	r =3D amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
> > > > -	if (r) {
> > > > -		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> > > > -		dev_err(adev->dev, "(%d) VCE map failed\n",
> > > > r);
> > > > -		return r;
> > > > -	}
> > > > -
> > > > -	hdr =3D (const struct common_firmware_header *)adev-
> > > > >vce.fw-
> > > > > data;
> > > > -	offset =3D le32_to_cpu(hdr->ucode_array_offset_bytes);
> > > > -
> > > > =C2=A0	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > -		memcpy_toio(cpu_addr, adev->vce.fw->data +
> > > > offset,
> > > > -			=C2=A0=C2=A0=C2=A0 adev->vce.fw->size - offset);
> > > > +		memcpy_toio(adev->vce.cpu_addr, adev-
> > > > > vce.saved_bo,
> > > > +			=C2=A0=C2=A0=C2=A0 amdgpu_bo_size(adev-
> > > > >vce.vcpu_bo));
> > > > =C2=A0		drm_dev_exit(idx);
> > > > =C2=A0	}
> > > > =C2=A0
> > > > -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
> > > > -
> > > > -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> > > > -
> > > > =C2=A0	return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > index 2d64002bed61..21b6656b2f41 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > @@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct
> > > > amdgpu_ip_block *ip_block)
> > > > =C2=A0		return r;
> > > > =C2=A0
> > > > =C2=A0	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> > > > -		const struct common_firmware_header *hdr;
> > > > -		unsigned size =3D amdgpu_bo_size(adev-
> > > > >vce.vcpu_bo);
> > > > -
> > > > -		adev->vce.saved_bo =3D kvmalloc(size,
> > > > GFP_KERNEL);
> > > > -		if (!adev->vce.saved_bo)
> > > > -			return -ENOMEM;
> > > > -
> > > > -		hdr =3D (const struct common_firmware_header
> > > > *)adev-
> > > > > vce.fw->data;
> > > > +		const struct common_firmware_header *hdr =3D
> > > > +			(const struct common_firmware_header
> > > > *)adev->vce.fw->data;
> > > > =C2=A0		adev-
> > > > >firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id
> > > > =3D AMDGPU_UCODE_ID_VCE;
> > > > =C2=A0		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].fw =3D
> > > > adev->vce.fw;
> > > > =C2=A0		adev->firmware.fw_size +=3D
> > > > @@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct
> > > > amdgpu_ip_block *ip_block)
> > > > =C2=A0	/* free MM table */
> > > > =C2=A0	amdgpu_virt_free_mm_table(adev);
> > > > =C2=A0
> > > > -	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> > > > -		kvfree(adev->vce.saved_bo);
> > > > -		adev->vce.saved_bo =3D NULL;
> > > > -	}
> > > > -
> > > > =C2=A0	r =3D amdgpu_vce_suspend(adev);
> > > > =C2=A0	if (r)
> > > > =C2=A0		return r;
> > > > @@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct
> > > > amdgpu_ip_block *ip_block)
> > > > =C2=A0static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
> > > > =C2=A0{
> > > > =C2=A0	struct amdgpu_device *adev =3D ip_block->adev;
> > > > -	int r, idx;
> > > > -
> > > > -	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > -		return 0;
> > > > -
> > > > -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > -		if (adev->firmware.load_type =3D=3D
> > > > AMDGPU_FW_LOAD_PSP) {
> > > > -			unsigned size =3D amdgpu_bo_size(adev-
> > > > > vce.vcpu_bo);
> > > > -			void *ptr =3D adev->vce.cpu_addr;
> > > > -
> > > > -			memcpy_fromio(adev->vce.saved_bo, ptr,
> > > > size);
> > > > -		}
> > > > -		drm_dev_exit(idx);
> > > > -	}
> > > > +	int r;
> > > > =C2=A0
> > > > =C2=A0	/*
> > > > =C2=A0	 * Proper cleanups before halting the HW engine:
> > > > @@ -609,25 +585,11 @@ static int vce_v4_0_suspend(struct
> > > > amdgpu_ip_block *ip_block)
> > > > =C2=A0static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
> > > > =C2=A0{
> > > > =C2=A0	struct amdgpu_device *adev =3D ip_block->adev;
> > > > -	int r, idx;
> > > > -
> > > > -	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > -		return -EINVAL;
> > > > -
> > > > -	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> > > > -
> > > > -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > -			unsigned size =3D amdgpu_bo_size(adev-
> > > > > vce.vcpu_bo);
> > > > -			void *ptr =3D adev->vce.cpu_addr;
> > > > +	int r;
> > > > =C2=A0
> > > > -			memcpy_toio(ptr, adev->vce.saved_bo,
> > > > size);
> > > > -			drm_dev_exit(idx);
> > > > -		}
> > > > -	} else {
> > > > -		r =3D amdgpu_vce_resume(adev);
> > > > -		if (r)
> > > > -			return r;
> > > > -	}
> > > > +	r =3D amdgpu_vce_resume(adev);
> > > > +	if (r)
> > > > +		return r;
> > > > =C2=A0
> > > > =C2=A0	return vce_v4_0_hw_init(ip_block);
> > > > =C2=A0}
