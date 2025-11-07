Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE46BCCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 13:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 828A610EAC6;
	Fri,  7 Nov 2025 13:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wl8mRI92";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCF310EAC6
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 13:39:05 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4298b865f84so383697f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 05:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762522744; x=1763127544; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/O2SIEIRfZR+x3FJyVlZFZ6A2yumtiscnZVsNrBCN4=;
 b=Wl8mRI92E43WXzV2I+tKglLco1SvJKOaXAJL/S4s7SnyHqBG4B8x298fV13xtRRgDS
 0zEo4HIhGs1mshB3FSHlmhikNqFXF3gafmRnGrrpZ22naNPDTBBeZE6Tk0DfhHSPt4Sv
 VAWU4O1DPVpbLy9PjOSAZPF9Jb7I1WFQYFcdKZOdFqk+JUC5TutY28/EqnziF/6oQ630
 p0ysbsDEwLf5DDESrgaEoIyw3ZDf/wfsQOpohRDtzBIZAMJAkQT2Gdr7vmeWY6YrSoaW
 a2Z7i2dbklILtigzXb6U/gJIi+tWqJaxQqACBXylMNrh+PTpkogBsCIwEXcAMN+2CdbN
 EYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762522744; x=1763127544;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/O2SIEIRfZR+x3FJyVlZFZ6A2yumtiscnZVsNrBCN4=;
 b=Ywbj388KG+QzjHresZh/e+aGlEfuRIMjWnJPlymLmXTwm37WNms4qGluPgbVbWTUUB
 Rvb0sXTkA+yDjClAg+lr8e3lagfL9haGVIFQ78SUo4p21dlq9DTxO+leeHebuhtMAuuv
 YIvOr/4r2g4+lSjOEV6EYIirPsGZpZaXNIP3N2j02nOosREA1chOIx8ctBc2UgzadePJ
 WtTVuXy/BrsZv/exu7rXziaFYkmN27ufq2QMKt1eV/fbSbwiWYQxc2eOaWawZoU6gq+8
 5FzSjwjpxGr3U+gNxIQiAH4KnbDwRG59qqtRJ/nHmmV4aZStz+NvHwzrHxzPMPLwK3fZ
 mJ1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+e17nLmtOHuFS11Lgxr+a5KmzX/HIUvav0JuAMkUDzqbtYOEHs7ouLooTLh6gZQAwgL1e+bi8@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0sj9Y7Qso8xU1oi9Ukmp3bSN442q+GiL6OW9w42rnyW7jGx6+
 Vcb3ZKqtcGFWCRwxwu4ukx1mYsE/1xPEaU817AL+CFzoNxwYXQPbCriP
X-Gm-Gg: ASbGnctD+SDYMjwahwmhrLAdA2z2eaiILYKvL35S+qqCMEs4rFJjbhonk9lgGdet/LV
 O9Iyo8iNNpGKDCmVEhK6t9LswiAxcb6AzPt+wiaUZMw0WQec897aTr0YvU/kc6ytKBU/aK81/pt
 oUPXTfhXklQ8GDH5EmIcSb96vrPoEf3oZR+vqiwv35O6Q6tTlFncgafmIbUCpKMKGyy0eLxd/tp
 Um34t0Gdb6a3L8PCp3dp7Z+awUS6ZEb4winbA+xb3lBlUFQ5dT27YYNCVkZAzhIJhLltrLlvb6U
 5vtugcUl3RPgTAs8LSuPUwyuOIpvp/TDqxzVLaDBCL85KsdnL4YwARTYB++wI33HQS7ko8ecNSi
 +Z/69KcdWEIR/j3bGGCX0xFTShEyBTLrpZFcAcXrZ3s9IzAzjr71bFOVb7ziYAvDxZOsUNM1dOK
 1EhufVgmQZBksoua82pXB77bnOYaK3C9noi9YI5PDXZi6ZEr4MSc3pCOUQWycSI6D0PoYUwDa/n
 01cJcv5kvQO5mTtWZFuWBXVVCfNNSBk8CPPzXqfXBvjDxMl7+lg/TU=
X-Google-Smtp-Source: AGHT+IFR/SkvZHuh9fRCb0fa1EcSJivvOCvO9pe6Op1bPXNztnR/6kf+2f/rNrPmrHhWY1WTx2aU4g==
X-Received: by 2002:a05:6000:26cd:b0:427:900:68ac with SMTP id
 ffacd0b85a97d-42ae5ac2149mr2972317f8f.39.1762522743700; 
 Fri, 07 Nov 2025 05:39:03 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3?
 (20014C4E24CAA400C3D82D5ACB81C0D3.dsl.pool.telekom.hu.
 [2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67921c3sm5570161f8f.40.2025.11.07.05.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 05:39:03 -0800 (PST)
Message-ID: <0e885d6bb1d1c6b179b122d6fa1598e148f2da5b.camel@gmail.com>
Subject: Re: [PATCH 06/13] drm/amdgpu/vce: Save/restore and pin VCPU BO for
 all VCE (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>,  "Dong, Ruijing"
 <Ruijing.Dong@amd.com>
Date: Fri, 07 Nov 2025 14:39:02 +0100
In-Reply-To: <425e9d98-73ea-4799-b4b0-7fde38927080@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-7-timur.kristof@gmail.com>
 <991f6d36-81e4-42d2-b301-0755fa00ffde@amd.com>
 <b7eb6efea5606c6d9b6d1bcdea6552b3602517bf.camel@gmail.com>
 <f0bbffa2-3b34-4f36-9fb2-44bcbcb5b8a3@amd.com>
 <a1f6e8e49d4f3d3a90afa8d3232b15626c34d991.camel@gmail.com>
 <180c651a-1711-4618-96d4-692d0c9c8996@amd.com>
 <9363414739e3053e04d971424a38293552c51348.camel@gmail.com>
 <425e9d98-73ea-4799-b4b0-7fde38927080@amd.com>
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

On Fri, 2025-11-07 at 14:33 +0100, Christian K=C3=B6nig wrote:
> On 11/7/25 14:31, Timur Krist=C3=B3f wrote:
> > On Fri, 2025-11-07 at 14:14 +0100, Christian K=C3=B6nig wrote:
> > > On 11/7/25 11:47, Timur Krist=C3=B3f wrote:
> > > > On Fri, 2025-11-07 at 11:01 +0100, Christian K=C3=B6nig wrote:
> > > > > On 11/7/25 10:53, Timur Krist=C3=B3f wrote:
> > > > > > On Fri, 2025-11-07 at 10:49 +0100, Christian K=C3=B6nig wrote:
> > > > > > > On 11/6/25 19:44, Timur Krist=C3=B3f wrote:
> > > > > > > > VCE uses the VCPU BO to keep track of currently active
> > > > > > > > encoding sessions. To make sure the VCE functions
> > > > > > > > correctly
> > > > > > > > after suspend/resume, save the VCPU BO to system RAM on
> > > > > > > > suspend and restore it on resume.
> > > > > > > >=20
> > > > > > > > Additionally, make sure to keep the VCPU BO pinned.
> > > > > > > > The VCPU BO needs to stay at the same location before
> > > > > > > > and
> > > > > > > > after
> > > > > > > > sleep/resume because the FW code is not relocatable
> > > > > > > > once
> > > > > > > > it's
> > > > > > > > started.
> > > > > > > >=20
> > > > > > > > Unfortunately this is not enough to make VCE suspend
> > > > > > > > work
> > > > > > > > when
> > > > > > > > there are encoding sessions active, so don't allow that
> > > > > > > > yet.
> > > > > > >=20
> > > > > > > The question if this is the right approach or not can
> > > > > > > only
> > > > > > > Leo
> > > > > > > and
> > > > > > > Ruijing answer.
> > > > > > >=20
> > > > > > > If we can get VCE1-3 to keep session working after
> > > > > > > suspend/resume
> > > > > > > we
> > > > > > > should make this change otherwise we should rather make
> > > > > > > all
> > > > > > > old
> > > > > > > sessions invalid after suspend/resume and only re-load
> > > > > > > the
> > > > > > > FW.
> > > > > > >=20
> > > > > > > Anyway I think you should make the removal of
> > > > > > > "amdgpu_bo_kmap(adev-
> > > > > > > > vce.vcpu_bo, &cpu_addr);" a separate patch, cause that
> > > > > > > > seems to
> > > > > > > > be a
> > > > > > > good cleanup no matter what.
> > > > > > >=20
> > > > > >=20
> > > > > > This change is necessary for the VCE1 code when it loads
> > > > > > the
> > > > > > firmware
> > > > > > signature. Without this patch, we would need to call
> > > > > > reserve(),
> > > > > > kmap(),
> > > > > > kunmap(), kunreserve() in vce_v1_0_load_fw_signature().
> > > > > >=20
> > > > > > Let me know which approach you prefer.
> > > > >=20
> > > > > In this case definately make removal of amdgpu_bo_kmap(adev-
> > > > > > vce.vcpu_bo, &cpu_addr) a separate patch.
> > > >=20
> > > > Sorry, can you clarify what you mean?
> > > > Should I just go back to the way things were on the first
> > > > version
> > > > of
> > > > the series, and then clean it up later?
> > >=20
> > > Just add a patch (early in the series, probably as first patch)
> > > to
> > > remove amdgpu_bo_kmap(adev-> vce.vcpu_bo, &cpu_addr).
> >=20
> > Is it allowed to keep a BO mapped when it is unreserved?
>=20
> Yes, as long as it is also pinned.
>=20
> IIRC the VCE BO is allocated by amdgpu_bo_create_kernel() and that
> both pins and maps the BO.

I am asking because amdgpu_vce_resume calls amdgpu_bo_unreserve on the
BO, but then vce_v1_0_load_fw_signature needs to access it. So I wonder
if the CPU address of the BO will be still correct when it's
unreserved. Also wonder, do I have to call amdgpu_bo_reserve before
accessing the BO? Or is it enough that it's mapped?

>=20
> Regards,
> Christian.
>=20
> >=20
> > >=20
> > > Then put the memset_io() into amdgpu_vce_resume() like you had in
> > > the
> > > first series of the patch so that VCE1 behaves the same as VCE2-
> > > 3.
> >=20
> > Ok
> >=20
> > >=20
> > > And when the series has landed we can clean everything up
> > > depending
> > > on what Leo/Ruijing has decided to do with suspend/resume on
> > > VCE1-3.
> >=20
> > Sounds good.
> >=20
> >=20
> >=20
> > >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > I want to get initial VCE1 working and landed independent of
> > > > > what
> > > > > Leo/Ruijing say to suspend/resume.
> > > >=20
> > > > Agreed.
> > > >=20
> > > > >=20
> > > > > Can be that suspend/resume is then still broken, but that is
> > > > > also
> > > > > the
> > > > > case for VCE2-3 then.
> > > >=20
> > > > Yes, some extra work is going to be needed on top of this patch
> > > > to
> > > > make
> > > > suspend/resume work (if it's possible at all).
> > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > > > > ---
> > > > > > > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++=
-
> > > > > > > > ----
> > > > > > > > ----
> > > > > > > > ----
> > > > > > > > =C2=A0drivers/gpu/drm/amd/amdgpu/vce_v4_0.c=C2=A0=C2=A0 | 5=
2 ++++-----
> > > > > > > > ----
> > > > > > > > ----
> > > > > > > > ----
> > > > > > > > ----
> > > > > > > > =C2=A02 files changed, 24 insertions(+), 72 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > > > > > index 2297608c5191..4beec5b56c4f 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > > > > > > @@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct
> > > > > > > > amdgpu_device
> > > > > > > > *adev, unsigned long size)
> > > > > > > > =C2=A0	if (!adev->vce.fw)
> > > > > > > > =C2=A0		return -ENOENT;
> > > > > > > > =C2=A0
> > > > > > > > +	adev->vce.saved_bo =3D kvmalloc(size,
> > > > > > > > GFP_KERNEL);
> > > > > > > > +	if (!adev->vce.saved_bo)
> > > > > > > > +		return -ENOMEM;
> > > > > > > > +
> > > > > > > > =C2=A0	r =3D amdgpu_bo_create_kernel(adev, size,
> > > > > > > > PAGE_SIZE,
> > > > > > > > =C2=A0				=C2=A0=C2=A0=C2=A0
> > > > > > > > AMDGPU_GEM_DOMAIN_VRAM
> > > > > > > > >=20
> > > > > > > > =C2=A0				=C2=A0=C2=A0=C2=A0
> > > > > > > > AMDGPU_GEM_DOMAIN_GTT,
> > > > > > > > @@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct
> > > > > > > > amdgpu_device
> > > > > > > > *adev)
> > > > > > > > =C2=A0	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo,
> > > > > > > > &adev-
> > > > > > > > > vce.gpu_addr,
> > > > > > > > =C2=A0		(void **)&adev->vce.cpu_addr);
> > > > > > > > =C2=A0
> > > > > > > > +	kvfree(adev->vce.saved_bo);
> > > > > > > > +	adev->vce.saved_bo =3D NULL;
> > > > > > > > +
> > > > > > > > =C2=A0	return 0;
> > > > > > > > =C2=A0}
> > > > > > > > =C2=A0
> > > > > > > > @@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct
> > > > > > > > amdgpu_device *adev, struct amdgpu_ring *ring)
> > > > > > > > =C2=A0 */
> > > > > > > > =C2=A0int amdgpu_vce_suspend(struct amdgpu_device *adev)
> > > > > > > > =C2=A0{
> > > > > > > > -	int i;
> > > > > > > > +	int i, idx;
> > > > > > > > =C2=A0
> > > > > > > > =C2=A0	cancel_delayed_work_sync(&adev-
> > > > > > > > >vce.idle_work);
> > > > > > > > =C2=A0
> > > > > > > > =C2=A0	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > > > > > =C2=A0		return 0;
> > > > > > > > =C2=A0
> > > > > > > > +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > > > > > +		memcpy_fromio(adev->vce.saved_bo,
> > > > > > > > adev-
> > > > > > > > > vce.cpu_addr,
> > > > > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_bo_size(adev-
> > > > > > > > > vce.vcpu_bo));
> > > > > > > > +		drm_dev_exit(idx);
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > =C2=A0	for (i =3D 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
> > > > > > > > =C2=A0		if (atomic_read(&adev-
> > > > > > > > >vce.handles[i]))
> > > > > > > > =C2=A0			break;
> > > > > > > > @@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct
> > > > > > > > amdgpu_device
> > > > > > > > *adev)
> > > > > > > > =C2=A0 */
> > > > > > > > =C2=A0int amdgpu_vce_resume(struct amdgpu_device *adev)
> > > > > > > > =C2=A0{
> > > > > > > > -	void *cpu_addr;
> > > > > > > > -	const struct common_firmware_header *hdr;
> > > > > > > > -	unsigned int offset;
> > > > > > > > -	int r, idx;
> > > > > > > > +	int idx;
> > > > > > > > =C2=A0
> > > > > > > > =C2=A0	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > > > > > =C2=A0		return -EINVAL;
> > > > > > > > =C2=A0
> > > > > > > > -	r =3D amdgpu_bo_reserve(adev->vce.vcpu_bo,
> > > > > > > > false);
> > > > > > > > -	if (r) {
> > > > > > > > -		dev_err(adev->dev, "(%d) failed to
> > > > > > > > reserve
> > > > > > > > VCE
> > > > > > > > bo\n", r);
> > > > > > > > -		return r;
> > > > > > > > -	}
> > > > > > > > -
> > > > > > > > -	r =3D amdgpu_bo_kmap(adev->vce.vcpu_bo,
> > > > > > > > &cpu_addr);
> > > > > > > > -	if (r) {
> > > > > > > > -		amdgpu_bo_unreserve(adev-
> > > > > > > > >vce.vcpu_bo);
> > > > > > > > -		dev_err(adev->dev, "(%d) VCE map
> > > > > > > > failed\n",
> > > > > > > > r);
> > > > > > > > -		return r;
> > > > > > > > -	}
> > > > > > > > -
> > > > > > > > -	hdr =3D (const struct common_firmware_header
> > > > > > > > *)adev-
> > > > > > > > > vce.fw-
> > > > > > > > > data;
> > > > > > > > -	offset =3D le32_to_cpu(hdr-
> > > > > > > > > ucode_array_offset_bytes);
> > > > > > > > -
> > > > > > > > =C2=A0	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > > > > > -		memcpy_toio(cpu_addr, adev->vce.fw-
> > > > > > > > >data +
> > > > > > > > offset,
> > > > > > > > -			=C2=A0=C2=A0=C2=A0 adev->vce.fw->size -
> > > > > > > > offset);
> > > > > > > > +		memcpy_toio(adev->vce.cpu_addr, adev-
> > > > > > > > > vce.saved_bo,
> > > > > > > > +			=C2=A0=C2=A0=C2=A0 amdgpu_bo_size(adev-
> > > > > > > > > vce.vcpu_bo));
> > > > > > > > =C2=A0		drm_dev_exit(idx);
> > > > > > > > =C2=A0	}
> > > > > > > > =C2=A0
> > > > > > > > -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
> > > > > > > > -
> > > > > > > > -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> > > > > > > > -
> > > > > > > > =C2=A0	return 0;
> > > > > > > > =C2=A0}
> > > > > > > > =C2=A0
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > > > > > index 2d64002bed61..21b6656b2f41 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > > > > > > > @@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct
> > > > > > > > amdgpu_ip_block *ip_block)
> > > > > > > > =C2=A0		return r;
> > > > > > > > =C2=A0
> > > > > > > > =C2=A0	if (adev->firmware.load_type =3D=3D
> > > > > > > > AMDGPU_FW_LOAD_PSP) {
> > > > > > > > -		const struct common_firmware_header
> > > > > > > > *hdr;
> > > > > > > > -		unsigned size =3D amdgpu_bo_size(adev-
> > > > > > > > > vce.vcpu_bo);
> > > > > > > > -
> > > > > > > > -		adev->vce.saved_bo =3D kvmalloc(size,
> > > > > > > > GFP_KERNEL);
> > > > > > > > -		if (!adev->vce.saved_bo)
> > > > > > > > -			return -ENOMEM;
> > > > > > > > -
> > > > > > > > -		hdr =3D (const struct
> > > > > > > > common_firmware_header
> > > > > > > > *)adev-
> > > > > > > > > vce.fw->data;
> > > > > > > > +		const struct common_firmware_header
> > > > > > > > *hdr =3D
> > > > > > > > +			(const struct
> > > > > > > > common_firmware_header
> > > > > > > > *)adev->vce.fw->data;
> > > > > > > > =C2=A0		adev-
> > > > > > > > > firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id
> > > > > > > > =3D AMDGPU_UCODE_ID_VCE;
> > > > > > > > =C2=A0		adev-
> > > > > > > > > firmware.ucode[AMDGPU_UCODE_ID_VCE].fw =3D
> > > > > > > > adev->vce.fw;
> > > > > > > > =C2=A0		adev->firmware.fw_size +=3D
> > > > > > > > @@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct
> > > > > > > > amdgpu_ip_block *ip_block)
> > > > > > > > =C2=A0	/* free MM table */
> > > > > > > > =C2=A0	amdgpu_virt_free_mm_table(adev);
> > > > > > > > =C2=A0
> > > > > > > > -	if (adev->firmware.load_type =3D=3D
> > > > > > > > AMDGPU_FW_LOAD_PSP) {
> > > > > > > > -		kvfree(adev->vce.saved_bo);
> > > > > > > > -		adev->vce.saved_bo =3D NULL;
> > > > > > > > -	}
> > > > > > > > -
> > > > > > > > =C2=A0	r =3D amdgpu_vce_suspend(adev);
> > > > > > > > =C2=A0	if (r)
> > > > > > > > =C2=A0		return r;
> > > > > > > > @@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block *ip_block)
> > > > > > > > =C2=A0static int vce_v4_0_suspend(struct amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > > =C2=A0{
> > > > > > > > =C2=A0	struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > > -	int r, idx;
> > > > > > > > -
> > > > > > > > -	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > > > > > -		return 0;
> > > > > > > > -
> > > > > > > > -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > > > > > > -		if (adev->firmware.load_type =3D=3D
> > > > > > > > AMDGPU_FW_LOAD_PSP) {
> > > > > > > > -			unsigned size =3D
> > > > > > > > amdgpu_bo_size(adev-
> > > > > > > > > vce.vcpu_bo);
> > > > > > > > -			void *ptr =3D adev-
> > > > > > > > >vce.cpu_addr;
> > > > > > > > -
> > > > > > > > -			memcpy_fromio(adev-
> > > > > > > > >vce.saved_bo,
> > > > > > > > ptr,
> > > > > > > > size);
> > > > > > > > -		}
> > > > > > > > -		drm_dev_exit(idx);
> > > > > > > > -	}
> > > > > > > > +	int r;
> > > > > > > > =C2=A0
> > > > > > > > =C2=A0	/*
> > > > > > > > =C2=A0	 * Proper cleanups before halting the HW
> > > > > > > > engine:
> > > > > > > > @@ -609,25 +585,11 @@ static int
> > > > > > > > vce_v4_0_suspend(struct
> > > > > > > > amdgpu_ip_block *ip_block)
> > > > > > > > =C2=A0static int vce_v4_0_resume(struct amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > > =C2=A0{
> > > > > > > > =C2=A0	struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > > -	int r, idx;
> > > > > > > > -
> > > > > > > > -	if (adev->vce.vcpu_bo =3D=3D NULL)
> > > > > > > > -		return -EINVAL;
> > > > > > > > -
> > > > > > > > -	if (adev->firmware.load_type =3D=3D
> > > > > > > > AMDGPU_FW_LOAD_PSP) {
> > > > > > > > -
> > > > > > > > -		if (drm_dev_enter(adev_to_drm(adev),
> > > > > > > > &idx)) {
> > > > > > > > -			unsigned size =3D
> > > > > > > > amdgpu_bo_size(adev-
> > > > > > > > > vce.vcpu_bo);
> > > > > > > > -			void *ptr =3D adev-
> > > > > > > > >vce.cpu_addr;
> > > > > > > > +	int r;
> > > > > > > > =C2=A0
> > > > > > > > -			memcpy_toio(ptr, adev-
> > > > > > > > > vce.saved_bo,
> > > > > > > > size);
> > > > > > > > -			drm_dev_exit(idx);
> > > > > > > > -		}
> > > > > > > > -	} else {
> > > > > > > > -		r =3D amdgpu_vce_resume(adev);
> > > > > > > > -		if (r)
> > > > > > > > -			return r;
> > > > > > > > -	}
> > > > > > > > +	r =3D amdgpu_vce_resume(adev);
> > > > > > > > +	if (r)
> > > > > > > > +		return r;
> > > > > > > > =C2=A0
> > > > > > > > =C2=A0	return vce_v4_0_hw_init(ip_block);
> > > > > > > > =C2=A0}
