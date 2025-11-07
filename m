Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F29CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 13:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDB910E16F;
	Fri,  7 Nov 2025 13:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ME92rIoH";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8340810E16F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 13:31:33 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-429b7ba208eso446546f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 05:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762522292; x=1763127092; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOd3Kn3TZ9JFnNYj8CkfYlM5ori5k136DDmRwzG8muw=;
 b=ME92rIoHpOuGFw7R/XS45cc98eVtaO/SN+SxPp4v5eCmy21SYd3K+w8A9vieC4Cjm4
 59JKCEZHFUaE0JqDrSVeZUF0sTOg29XrtOMWu80P2wh9hkLhlTep9ky7eSi59UTiOLs2
 8Fj0lRnrVuyG3LgQ2BqrlBlW4hllmXgDToDkU939YGR6F04lsVIkAOfFLoU+Vn6J2YFg
 0v2ZbExWrEkbkjttaNhSm+GE128uZb50bxZw8vq00KaXN4W3SqfVR7FIMvuSpbaVj3lo
 /qdB2k8NFInQabxYFYK/rOet8oXCsqS3FXNfj1VxV9IYsnB17nkQlK7lONFfzmf7/pq1
 swbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762522292; x=1763127092;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lOd3Kn3TZ9JFnNYj8CkfYlM5ori5k136DDmRwzG8muw=;
 b=cRal2p1/rTr4yaJ7+8k0uh4Vqi1z7gcgbcPbSGPIiixJSwmBh1NhRPZOpjEeBAZyny
 X9Va/c/e16eBdT133BqCqPtKiuCufqBfwOu6aAdWZ4w0RSfAhZSryHRc3/n+JVa3mybk
 ZpXd52OGDJrX9veBNdoNuhPCYSbqiUZi0n1VXiWMhhiVolS9bTiipsDjKuhestT/37Tu
 z2rNWfGHRz4XD7KVayv+nefQNOdsg9wOCurpk6rTEoC+ygBlnaJYWR20b93GM6med1iA
 GvqMkn78k2JdsaeUPcrejR3Bf4h/15Z44pepFtGs1c9y0xLnEyBuawnTshmnxxiPLZS0
 byRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9SYwG5gbRAK/hctq2ak+8EPFjLgCSXCZu3X1VTfPXtvfTHm6WRe2Seurts5q4i1lh6/l/NvU3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyvfvg6xplcLt9/YkGBFAcjcaeoMzfynJkb3Bfl56a+kSyqweau
 QIMafrVgftXY6CW0GuWXtzgfmQNI+E336ocAIeioeN+9ZVq/XOAmqlx3
X-Gm-Gg: ASbGncuwCvAVQuLFngTs5Ueo6+LlIALaxt2DYHLRw10WdfCkar5+ktslpRm74sFLTeW
 5LBtGO6er85wCI3CUefly8UqskPvXnlkgkBEeXVzb0ECg/8aI8rk6cAMwrdZBGuLdXXhnL+6X7i
 uOPjV7hMiMiXd5Vusc58BtIpbZjYEfhatHY/VqIxOVOpA+sAcT3aW/jIUYJXsSUQ8Lgl1/73NjD
 7TLg4rM6xsOegemEMK/zUU9UmVKbrT8m8o6SuMr16NB9QKIz0kOAp6BHT4+uTWBHEme2Aqy8CXF
 4wsXN2SQeERBDMyD5KGCMLUgVkbMeYj1xO2JhzcDG5G7aXfc4jbA/IbV+eVoApn+RXKtKy2Ldlh
 SlnFzyTrLy7N8J2m83XB8y7OQ5X0W7Cg8Isu/XpFdRJGQdMHe9ovFgXl/GmfX6I7zhMjeEqAhp5
 ieZgnDtdzQQxTQqzrNYIjr78Al3A7P78Y8OYNByR3ahuMA/pifEyVRhnjX1LcPqTiqHpBvcC0R7
 ybHoZwMmHP4o5/Fd1ryAKZp6B+9+QPHvFpmmWUoq9NQzkQEc6iS6V0=
X-Google-Smtp-Source: AGHT+IGHY58sGu2L1mxv/RlwiZ4bZnGCqx/cYJUqu68aHD+Q4gYcOHvoTJPxb4/pd9WMnCz81QSp3g==
X-Received: by 2002:a05:6000:2284:b0:3ff:d5c5:6b01 with SMTP id
 ffacd0b85a97d-42ae5880ca1mr2930918f8f.19.1762522291525; 
 Fri, 07 Nov 2025 05:31:31 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3?
 (20014C4E24CAA400C3D82D5ACB81C0D3.dsl.pool.telekom.hu.
 [2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac675c9fdsm5262379f8f.28.2025.11.07.05.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 05:31:31 -0800 (PST)
Message-ID: <9363414739e3053e04d971424a38293552c51348.camel@gmail.com>
Subject: Re: [PATCH 06/13] drm/amdgpu/vce: Save/restore and pin VCPU BO for
 all VCE (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>,  "Dong, Ruijing"
 <Ruijing.Dong@amd.com>
Date: Fri, 07 Nov 2025 14:31:30 +0100
In-Reply-To: <180c651a-1711-4618-96d4-692d0c9c8996@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-7-timur.kristof@gmail.com>
 <991f6d36-81e4-42d2-b301-0755fa00ffde@amd.com>
 <b7eb6efea5606c6d9b6d1bcdea6552b3602517bf.camel@gmail.com>
 <f0bbffa2-3b34-4f36-9fb2-44bcbcb5b8a3@amd.com>
 <a1f6e8e49d4f3d3a90afa8d3232b15626c34d991.camel@gmail.com>
 <180c651a-1711-4618-96d4-692d0c9c8996@amd.com>
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

On Fri, 2025-11-07 at 14:14 +0100, Christian K=C3=B6nig wrote:
> On 11/7/25 11:47, Timur Krist=C3=B3f wrote:
> > On Fri, 2025-11-07 at 11:01 +0100, Christian K=C3=B6nig wrote:
> > > On 11/7/25 10:53, Timur Krist=C3=B3f wrote:
> > > > On Fri, 2025-11-07 at 10:49 +0100, Christian K=C3=B6nig wrote:
> > > > > On 11/6/25 19:44, Timur Krist=C3=B3f wrote:
> > > > > > VCE uses the VCPU BO to keep track of currently active
> > > > > > encoding sessions. To make sure the VCE functions correctly
> > > > > > after suspend/resume, save the VCPU BO to system RAM on
> > > > > > suspend and restore it on resume.
> > > > > >=20
> > > > > > Additionally, make sure to keep the VCPU BO pinned.
> > > > > > The VCPU BO needs to stay at the same location before and
> > > > > > after
> > > > > > sleep/resume because the FW code is not relocatable once
> > > > > > it's
> > > > > > started.
> > > > > >=20
> > > > > > Unfortunately this is not enough to make VCE suspend work
> > > > > > when
> > > > > > there are encoding sessions active, so don't allow that
> > > > > > yet.
> > > > >=20
> > > > > The question if this is the right approach or not can only
> > > > > Leo
> > > > > and
> > > > > Ruijing answer.
> > > > >=20
> > > > > If we can get VCE1-3 to keep session working after
> > > > > suspend/resume
> > > > > we
> > > > > should make this change otherwise we should rather make all
> > > > > old
> > > > > sessions invalid after suspend/resume and only re-load the
> > > > > FW.
> > > > >=20
> > > > > Anyway I think you should make the removal of
> > > > > "amdgpu_bo_kmap(adev-
> > > > > > vce.vcpu_bo, &cpu_addr);" a separate patch, cause that
> > > > > > seems to
> > > > > > be a
> > > > > good cleanup no matter what.
> > > > >=20
> > > >=20
> > > > This change is necessary for the VCE1 code when it loads the
> > > > firmware
> > > > signature. Without this patch, we would need to call reserve(),
> > > > kmap(),
> > > > kunmap(), kunreserve() in vce_v1_0_load_fw_signature().
> > > >=20
> > > > Let me know which approach you prefer.
> > >=20
> > > In this case definately make removal of amdgpu_bo_kmap(adev-
> > > > vce.vcpu_bo, &cpu_addr) a separate patch.
> >=20
> > Sorry, can you clarify what you mean?
> > Should I just go back to the way things were on the first version
> > of
> > the series, and then clean it up later?
>=20
> Just add a patch (early in the series, probably as first patch) to
> remove amdgpu_bo_kmap(adev-> vce.vcpu_bo, &cpu_addr).

Is it allowed to keep a BO mapped when it is unreserved?

>=20
> Then put the memset_io() into amdgpu_vce_resume() like you had in the
> first series of the patch so that VCE1 behaves the same as VCE2-3.

Ok

>=20
> And when the series has landed we can clean everything up depending
> on what Leo/Ruijing has decided to do with suspend/resume on VCE1-3.

Sounds good.



>=20
>=20
> >=20
> > >=20
> > > I want to get initial VCE1 working and landed independent of what
> > > Leo/Ruijing say to suspend/resume.
> >=20
> > Agreed.
> >=20
> > >=20
> > > Can be that suspend/resume is then still broken, but that is also
> > > the
> > > case for VCE2-3 then.
> >=20
> > Yes, some extra work is going to be needed on top of this patch to
> > make
> > suspend/resume work (if it's possible at all).
> >=20
> > >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > > ---
> > > > > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++----=
-
> > > > > > ----
> > > > > > ----
> > > > > > =C2=A0drivers/gpu/drm/amd/amdgpu/vce_v4_0.c=C2=A0=C2=A0 | 52 ++=
++---------
> > > > > > ----
> > > > > > ----
> > > > > > ----
> > > > > > =C2=A02 files changed, 24 insertions(+), 72 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > > > index 2297608c5191..4beec5b56c4f 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > > > @@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct
> > > > > > amdgpu_device
> > > > > > *adev, unsigned long size)
> > > > > > =C2=A0	if (!adev->vce.fw)
> > > > > > =C2=A0		return -ENOENT;
> > > > > > =C2=A0
> > > > > > +	adev->vce.saved_bo =3D kvmalloc(size, GFP_KERNEL);
> > > > > > +	if (!adev->vce.saved_bo)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > =C2=A0	r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> > > > > > =C2=A0				=C2=A0=C2=A0=C2=A0 AMDGPU_GEM_DOMAIN_VRAM
> > > > > > |
> > > > > > =C2=A0				=C2=A0=C2=A0=C2=A0 AMDGPU_GEM_DOMAIN_GTT,
> > > > > > @@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct
> > > > > > amdgpu_device
> > > > > > *adev)
> > > > > > =C2=A0	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev-
> > > > > > > vce.gpu_addr,
> > > > > > =C2=A0		(void **)&adev->vce.cpu_addr);
> > > > > > =C2=A0
> > > > > > +	kvfree(adev->vce.saved_bo);
> > > > > > +	adev->vce.saved_bo =3D NULL;
> > > > > > +
> > > > > > =C2=A0	return 0;
> > > > > > =C2=A0}
> > > > > > =C2=A0
> > > > > > @@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct
> > > > > > amdgpu_device *adev, struct amdgpu_ring *ring)
> > > > > > =C2=A0 */
> > > > > > =C2=A0int amdgpu_vce_suspend(struct amdgpu_device *adev)
> > > > > > =C2=A0{
> > > > > > -	int i;
> > > > > > +	int i, idx;
> > > > > > =C2=A0
> > > > > > =C2=A0	cancel_delayed_work_sync(&adev->vce.idle_work);
> > > > > > =C2=A0
> > > > > > =C2=A0	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > > > =C2=A0		return 0;
> > > > > > =C2=A0
> > > > > > +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > > > +		memcpy_fromio(adev->vce.saved_bo, adev-
> > > > > > > vce.cpu_addr,
> > > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_bo_size(adev-
> > > > > > > vce.vcpu_bo));
> > > > > > +		drm_dev_exit(idx);
> > > > > > +	}
> > > > > > +
> > > > > > =C2=A0	for (i =3D 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
> > > > > > =C2=A0		if (atomic_read(&adev->vce.handles[i]))
> > > > > > =C2=A0			break;
> > > > > > @@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct
> > > > > > amdgpu_device
> > > > > > *adev)
> > > > > > =C2=A0 */
> > > > > > =C2=A0int amdgpu_vce_resume(struct amdgpu_device *adev)
> > > > > > =C2=A0{
> > > > > > -	void *cpu_addr;
> > > > > > -	const struct common_firmware_header *hdr;
> > > > > > -	unsigned int offset;
> > > > > > -	int r, idx;
> > > > > > +	int idx;
> > > > > > =C2=A0
> > > > > > =C2=A0	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > > > =C2=A0		return -EINVAL;
> > > > > > =C2=A0
> > > > > > -	r =3D amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
> > > > > > -	if (r) {
> > > > > > -		dev_err(adev->dev, "(%d) failed to reserve
> > > > > > VCE
> > > > > > bo\n", r);
> > > > > > -		return r;
> > > > > > -	}
> > > > > > -
> > > > > > -	r =3D amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
> > > > > > -	if (r) {
> > > > > > -		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> > > > > > -		dev_err(adev->dev, "(%d) VCE map
> > > > > > failed\n",
> > > > > > r);
> > > > > > -		return r;
> > > > > > -	}
> > > > > > -
> > > > > > -	hdr =3D (const struct common_firmware_header *)adev-
> > > > > > > vce.fw-
> > > > > > > data;
> > > > > > -	offset =3D le32_to_cpu(hdr-
> > > > > > >ucode_array_offset_bytes);
> > > > > > -
> > > > > > =C2=A0	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > > > -		memcpy_toio(cpu_addr, adev->vce.fw->data +
> > > > > > offset,
> > > > > > -			=C2=A0=C2=A0=C2=A0 adev->vce.fw->size - offset);
> > > > > > +		memcpy_toio(adev->vce.cpu_addr, adev-
> > > > > > > vce.saved_bo,
> > > > > > +			=C2=A0=C2=A0=C2=A0 amdgpu_bo_size(adev-
> > > > > > > vce.vcpu_bo));
> > > > > > =C2=A0		drm_dev_exit(idx);
> > > > > > =C2=A0	}
> > > > > > =C2=A0
> > > > > > -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
> > > > > > -
> > > > > > -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> > > > > > -
> > > > > > =C2=A0	return 0;
> > > > > > =C2=A0}
> > > > > > =C2=A0
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > > > index 2d64002bed61..21b6656b2f41 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > > > @@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct
> > > > > > amdgpu_ip_block *ip_block)
> > > > > > =C2=A0		return r;
> > > > > > =C2=A0
> > > > > > =C2=A0	if (adev->firmware.load_type =3D=3D
> > > > > > AMDGPU_FW_LOAD_PSP) {
> > > > > > -		const struct common_firmware_header *hdr;
> > > > > > -		unsigned size =3D amdgpu_bo_size(adev-
> > > > > > > vce.vcpu_bo);
> > > > > > -
> > > > > > -		adev->vce.saved_bo =3D kvmalloc(size,
> > > > > > GFP_KERNEL);
> > > > > > -		if (!adev->vce.saved_bo)
> > > > > > -			return -ENOMEM;
> > > > > > -
> > > > > > -		hdr =3D (const struct common_firmware_header
> > > > > > *)adev-
> > > > > > > vce.fw->data;
> > > > > > +		const struct common_firmware_header *hdr =3D
> > > > > > +			(const struct
> > > > > > common_firmware_header
> > > > > > *)adev->vce.fw->data;
> > > > > > =C2=A0		adev-
> > > > > > > firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id
> > > > > > =3D AMDGPU_UCODE_ID_VCE;
> > > > > > =C2=A0		adev-
> > > > > > >firmware.ucode[AMDGPU_UCODE_ID_VCE].fw =3D
> > > > > > adev->vce.fw;
> > > > > > =C2=A0		adev->firmware.fw_size +=3D
> > > > > > @@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct
> > > > > > amdgpu_ip_block *ip_block)
> > > > > > =C2=A0	/* free MM table */
> > > > > > =C2=A0	amdgpu_virt_free_mm_table(adev);
> > > > > > =C2=A0
> > > > > > -	if (adev->firmware.load_type =3D=3D
> > > > > > AMDGPU_FW_LOAD_PSP) {
> > > > > > -		kvfree(adev->vce.saved_bo);
> > > > > > -		adev->vce.saved_bo =3D NULL;
> > > > > > -	}
> > > > > > -
> > > > > > =C2=A0	r =3D amdgpu_vce_suspend(adev);
> > > > > > =C2=A0	if (r)
> > > > > > =C2=A0		return r;
> > > > > > @@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct
> > > > > > amdgpu_ip_block *ip_block)
> > > > > > =C2=A0static int vce_v4_0_suspend(struct amdgpu_ip_block
> > > > > > *ip_block)
> > > > > > =C2=A0{
> > > > > > =C2=A0	struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > -	int r, idx;
> > > > > > -
> > > > > > -	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > > > -		return 0;
> > > > > > -
> > > > > > -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > > > -		if (adev->firmware.load_type =3D=3D
> > > > > > AMDGPU_FW_LOAD_PSP) {
> > > > > > -			unsigned size =3D
> > > > > > amdgpu_bo_size(adev-
> > > > > > > vce.vcpu_bo);
> > > > > > -			void *ptr =3D adev->vce.cpu_addr;
> > > > > > -
> > > > > > -			memcpy_fromio(adev->vce.saved_bo,
> > > > > > ptr,
> > > > > > size);
> > > > > > -		}
> > > > > > -		drm_dev_exit(idx);
> > > > > > -	}
> > > > > > +	int r;
> > > > > > =C2=A0
> > > > > > =C2=A0	/*
> > > > > > =C2=A0	 * Proper cleanups before halting the HW engine:
> > > > > > @@ -609,25 +585,11 @@ static int vce_v4_0_suspend(struct
> > > > > > amdgpu_ip_block *ip_block)
> > > > > > =C2=A0static int vce_v4_0_resume(struct amdgpu_ip_block
> > > > > > *ip_block)
> > > > > > =C2=A0{
> > > > > > =C2=A0	struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > -	int r, idx;
> > > > > > -
> > > > > > -	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > > > -		return -EINVAL;
> > > > > > -
> > > > > > -	if (adev->firmware.load_type =3D=3D
> > > > > > AMDGPU_FW_LOAD_PSP) {
> > > > > > -
> > > > > > -		if (drm_dev_enter(adev_to_drm(adev),
> > > > > > &idx)) {
> > > > > > -			unsigned size =3D
> > > > > > amdgpu_bo_size(adev-
> > > > > > > vce.vcpu_bo);
> > > > > > -			void *ptr =3D adev->vce.cpu_addr;
> > > > > > +	int r;
> > > > > > =C2=A0
> > > > > > -			memcpy_toio(ptr, adev-
> > > > > > >vce.saved_bo,
> > > > > > size);
> > > > > > -			drm_dev_exit(idx);
> > > > > > -		}
> > > > > > -	} else {
> > > > > > -		r =3D amdgpu_vce_resume(adev);
> > > > > > -		if (r)
> > > > > > -			return r;
> > > > > > -	}
> > > > > > +	r =3D amdgpu_vce_resume(adev);
> > > > > > +	if (r)
> > > > > > +		return r;
> > > > > > =C2=A0
> > > > > > =C2=A0	return vce_v4_0_hw_init(ip_block);
> > > > > > =C2=A0}
