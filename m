Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB9C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 12:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC7710E4C0;
	Thu,  2 Jul 2026 12:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k0zMmH5B";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4740610E4C0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 12:58:55 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493b786d6c0so9261965e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782997134; x=1783601934; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Xm6/w28NpRMiecM4TI1l6kCk2CrQuSS9yDQYpe0kl4=;
 b=k0zMmH5BeB1X6vFOqfkvvuJEmwrSij4cV9bbIFkWpFUmP17+N4CQtbQfqcwosQRF0E
 a+5ccfahHijzzlQRt/SAiAfcd1FBk3c4EHtICwziVvIuSQ0RKMg+1e570KE3A4IiUjhY
 22sklxvu8HjJO/nUfEBqSgc1QGI75RXhbU4ppAzhWEvK+k6+jn19HtiDwA2v5wjQhHX7
 1FXQhf1k31U/wDK09HhrmeImA0kLIss9/uxWQdqoGNGYwGbUTU4DGoLPK7EVDx0fQtyG
 46Boul7Nz0dIfuFQd+qLyEYp96Dcrd2sfhX4XTfocWDmi1c1lTrJ96cf3mo03nF8eze4
 /I/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997134; x=1783601934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0Xm6/w28NpRMiecM4TI1l6kCk2CrQuSS9yDQYpe0kl4=;
 b=V+rCduTMLAE1gBbcebX0Dy3uTeMwWytsdzZZVl4+KI+BqoE1Oo0pUXkSuBwRLlPxiu
 OJuUsB2RqCxm6OeiA6GV6kDZ7HOpzrJVZOmJgtb/zsYwCbkhONuYA97dj9CI3SrNUHmK
 5Q3x90b1wfEp/gk7aMaMg0xQYvUdrbFjVfpI5QXcuxSmKps2ZS1PQcctlQ+EpDBJcyfb
 fzStVrqOe6i6izaqcePsT/hk0hJkpxOgYfJOBSoS8tGixuIu8JfTFNZ4Y5I9w2UEaCDR
 gw8yLXV+a5ixoqNe9lM5QxdfEVV47+sNmkIgZpN0nedMq05abvT+5gXQqCc0l0r0KbbH
 LI+g==
X-Gm-Message-State: AOJu0YzCo60FdOH1SP6E+CPZeAIWeomo38IKo/m3kn/Iizv0YWSM4UEp
 asgS6l6Pfjx4VRQ+Oli5hvyI1Hz/ImIsTSHqjWjX62FIdmgeeGlrRv6L/OMByqAi
X-Gm-Gg: AfdE7cniy8HLk+zNIiYEeyu4LIWxF+mcizejhLYCN6BK0ojhECmld528I+oJrN2ib0F
 SuR6VjdhXkE9BJjlcSsf+Kl9CQeYIFY1NlPF5RNNkRtxBOhzNkMizvQJgZNNwQzbwoYeX8BKgbS
 tb7UGzroG/LmUT0p4cWGQmrCxhbP4h3A+MGzFHU2ExHC/6FXRntSN8X9SxZP/vi+tRAT0IObXLZ
 ReK+6EC0wtkOT4w6O5PmhxuToUOfCYNDtboDGQw1001PewYMfkOk71ExpUlLpjyQnkm16jjsot5
 69LFzmsHkngWg2VtO78z/nvt9Z2zCgw3QtoGkiE7tMSTKrzokM9+TWJDtUAc10d4hjGPCaO7wUA
 ti3XdIik3kBIO86DDKZOx0aHp88QxsSG60h6lanbAIL9yWb3j1EQgmjrAAk73pinDoAojoUNpIO
 FY0abTT3NkXTJt2ZUKwhUtb8glBxHuUdnBwfA8U/IIkwfmycd6PL/DQlSExBC0Cr68Ephazk736
 Mz7tqxrSFWlXNMJxQ==
X-Received: by 2002:a05:600d:c:b0:492:454c:347c with SMTP id
 5b1f17b1804b1-493c2b3a758mr75868125e9.7.1782997133418; 
 Thu, 02 Jul 2026 05:58:53 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EF0F0080162CDB5B2DFACF.dsl.pool.telekom.hu.
 [2001:4c4e:24ef:f00:8016:2cdb:5b2d:facf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63172fesm83049815e9.0.2026.07.02.05.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:58:52 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 10/14] drm/amdgpu/vm: Use init PTE flags and NOALLOC in
 amdgpu_vm_handle_fault()
Date: Thu, 02 Jul 2026 14:58:51 +0200
Message-ID: <16536545.Emhk5qWAgF@timur-max>
In-Reply-To: <24718594-f84a-46a6-8c27-ec6729647554@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <27457954.1r3eYUQgxm@timur-max>
 <24718594-f84a-46a6-8c27-ec6729647554@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 14:18:45 k=C3=B6z=C3=A9p-=
eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 7/2/26 13:28, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 12:22:23 k=C3=B6z=C3=
=A9p-eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian
> > K=C3=B6nig>=20
> > wrote:
> >> On 7/1/26 18:17, Timur Krist=C3=B3f wrote:
> >>> PTE_IS_PTE seems necessary for handling retry faults on GFX12.
> >>>=20
> >>> For reference see:
> >>> amdgpu_vm_pte_update_flags() that explains the problem
> >>> svm_range_get_pte_flags() that uses the flag on GFX12
> >>>=20
> >>> Also add NOALLOC on GFX10.3+ as we don't need to allocate
> >>> the fault handling PTE in the infinity cache (MALL).
> >>>=20
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>=20
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
> >>>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
> >>> 32719f31b6c9..a915d061085f
> >>> 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> @@ -3044,7 +3044,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> >>> *adev, u32 pasid,>
> >>>=20
> >>>  	}
> >>>  =09
> >>>  	addr /=3D AMDGPU_GPU_PAGE_SIZE;
> >>>=20
> >>> -	flags =3D AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> >>> +	flags =3D adev->gmc.init_pte_flags |
> >>> +		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> >>>=20
> >>>  		AMDGPU_PTE_SYSTEM;
> >>=20
> >> That doesn't make sense the PTE flags should be adjusted to the device
> >> specific flags by the callbacks.
> >=20
> > Can you please elaborate on what is it that doesn't make sense here and
> > why, and what you recommend to do instead?
>=20
> I had to dig up what the problem here is as well. We use the ASIC specific
> AMDGPU_PTE_* flags directly.
>=20
> Instead we should use the AMDGPU_VM_PAGE_* flags and then call
> amdgpu_gmc_get_vm_pte(adev, vm, NULL, in_flags, &out_flags) to translate
> the AMDGPU_VM_PAGE_* flags into the ASIC specific ones.
>=20
> This will automatically add flags like AMDGPU_PTE_TF and AMDGPU_PTE_IS_PTE
> etc...

As far as I understand, the init_pte_flags was added specifically for this=
=20
purpose, and that's what SVM uses too.

Are you suggesting to call to amdgpu_gmc_get_vm_pte() here?
As far as I see the implementation of that function for Navi 4 is=20
gmc_v12_0_get_vm_pte() which doesn't set the PTE_IS_PTE flag so it wouldn't=
=20
resolve the issue with the fault that this commit is fixing.

> >>>  	if (is_compute_context) {
> >>>=20
> >>> @@ -3054,11 +3055,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_dev=
ice
> >>> *adev, u32 pasid,>
> >>>=20
> >>>  		flags =3D AMDGPU_VM_NORETRY_FLAGS;
> >>>  		value =3D 0;
> >>>  =09
> >>>  	} else if (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_NEVER) {
> >>>=20
> >>> +		/* Don't allocate this PTE in the MALL */
> >>> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
> >=20
> > IP_VERSION(10, 3, 0))
> >=20
> >>> +			flags |=3D AMDGPU_PTE_NOALLOC;
> >>> +
> >>=20
> >> This doesn't make sense either, mall allocation for the dummy page sho=
uld
> >> be perfectly fine.
> >=20
> > I think we shouldn't waste space for this PTE in the MALL.
>=20
> Hui? The PTE doesn't enter the MALL, it is the dummy page which enters the
> MALL and since it is only 4k it basically doesn't waste much space.
>=20

Sure I can remove this line if you feel that strongly about it.
Do we gain any benefit from allowing this page in the MALL?


>=20
> >>>  		/* Redirect the access to the dummy page */
> >>>  		value =3D adev->dummy_page_addr;
> >>>  		flags |=3D AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
> >>>  	=09
> >>>  			AMDGPU_PTE_WRITEABLE;
> >>>=20
> >>> -
> >>>=20
> >>>  	} else {
> >>>  =09
> >>>  		/* Let the hw retry silently on the PTE */
> >>>  		value =3D 0;




