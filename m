Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684B7C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 11:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43F010F2F1;
	Thu,  2 Jul 2026 11:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SOAnVuqC";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5C410F2F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 11:28:12 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1398561f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782991691; x=1783596491; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LglR3yqv1MYESlAG0srTxG7e1unf8WfiWnISQG0/klg=;
 b=SOAnVuqC6RE9k3BMpqpqdN4an2PYpXnt6Jutl0h+mStUkwPCa+nn+mt7nGVPaljPwQ
 l+nr8io0ProejigXfnC/FPZFshgO9v0VXCaKNAAP7oWZsNT+QQK6i1FlSVXq8iZzC+An
 O8KFURru85AZ3o+1IKbfLUdV5PDbGlqwaeInHHvt9TJ8mbWwka85T8s8ezmSZPcvPH8Y
 omBU3Imz6GQ5e7ELvsl9Cr3LiOG4GDKN0Yr3tU9Gw/+AxuLtnmiupquQcIGIlD1hBF7K
 NSX2kId7Cb1wgQDezBqg/EQx1ZIpncxYShZh6BGA7dVZU3VM74vMc2mqhrTJszDfXdX0
 Gjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782991691; x=1783596491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LglR3yqv1MYESlAG0srTxG7e1unf8WfiWnISQG0/klg=;
 b=LvAe9jXoIGRmZ1tS1RNEZa2k8dNkgV8B1it+UW4hQBMO924/XOZHl7wUn01yUW9yjF
 UVLNQmLPSe53Tum7RUCRLWv0LQ5Zt8zr2eCOJDbW2M5KgdfWGONGxXlSyVvXRSYu+maD
 dGpcksNzDzX0SiIsDjd/DT0ElybNZ+uKNPisBTCfs/WzaTXQcH642QVciZFNF4LhhDyI
 G1V0vnBztGN/4sqJP0qBm8l+qB/FgdzNUsjqydqu/SxNTMomGOSrVDezrrb7KI87TBzO
 yhpS2QaC0mzCbtT0kaVAvrrwGeTUHcAU6aeo8N80a8k2PqLckb8l3hMDRt6/7pGE49Qj
 gzKQ==
X-Gm-Message-State: AOJu0Yy5nX/+Uao/0ldVvHulIPYZvwejPFy+9aMm/bHu2cuS71alvPWj
 2BBtjxiTOmWRDIPw0q7aJBbAYaUkl+aifpTD61qwaTKBPrrtZqgW+V5D5C6olQ6H
X-Gm-Gg: AfdE7cmSLvtmlM3gcqNGwdhjjXQZ9MCV56Z4skQbxQg5AA6cGEjqQv0NxRsgmp5KuC1
 3Z4BDkOv9Lcdj+gBpQt1q0zChudH/qsNF4u6cCG+N59yc7JaxZu3UoqhI8fK6T3lDqD0hPgZM6t
 bHLf/e1gr2Gq1dyUWcvTPc5kxVMQ9eLQxhAYNEI7Ag2J4OppzgEkWVHxZ9eCtUnMf1dZsghXz/t
 EC3NiMqtEQzbc00B63UGIKlI3XX2CbWl4wvqwQYgMVTaORhrQqw6RXCc6bRG+iuP9c1gedjvhAc
 CzjTM2opIcKsnLFLWv/W2UlX57JQl/zFZ/2rzTP7qjZ9YJFaVwcwJasohb4VVHND0JHW3Phz88X
 +iais/qJyS2+fX2NnNtCuhA3Gh11pwA25+0JpvQGkLTlN7+3CvomIMBsPAPk61bjnexgrviV7pA
 5HE6ppLMJ8l9776QpXOaagSPCLJg47tBLsU8ifYhQt6IJk1obEW8VRl9sgw3RR9zbuMl3b5GbNf
 zUVP+lm/vnLnjaynw==
X-Received: by 2002:a5d:5f8e:0:b0:46c:cffc:7638 with SMTP id
 ffacd0b85a97d-4775a1010ccmr8474637f8f.30.1782991690659; 
 Thu, 02 Jul 2026 04:28:10 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EF0F0080162CDB5B2DFACF.dsl.pool.telekom.hu.
 [2001:4c4e:24ef:f00:8016:2cdb:5b2d:facf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4ad4sm8386022f8f.11.2026.07.02.04.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 04:28:10 -0700 (PDT)
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
Date: Thu, 02 Jul 2026 13:28:08 +0200
Message-ID: <27457954.1r3eYUQgxm@timur-max>
In-Reply-To: <44f84ba4-e91d-4cf0-bf82-635b03e668b6@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-11-timur.kristof@gmail.com>
 <44f84ba4-e91d-4cf0-bf82-635b03e668b6@amd.com>
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

On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 12:22:23 k=C3=B6z=C3=A9p-=
eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 7/1/26 18:17, Timur Krist=C3=B3f wrote:
> > PTE_IS_PTE seems necessary for handling retry faults on GFX12.
> >=20
> > For reference see:
> > amdgpu_vm_pte_update_flags() that explains the problem
> > svm_range_get_pte_flags() that uses the flag on GFX12
> >=20
> > Also add NOALLOC on GFX10.3+ as we don't need to allocate
> > the fault handling PTE in the infinity cache (MALL).
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 32719f31b6c9..a915d06108=
5f
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -3044,7 +3044,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> > *adev, u32 pasid,>=20
> >  	}
> >  =09
> >  	addr /=3D AMDGPU_GPU_PAGE_SIZE;
> >=20
> > -	flags =3D AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> > +	flags =3D adev->gmc.init_pte_flags |
> > +		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> >=20
> >  		AMDGPU_PTE_SYSTEM;
>=20
> That doesn't make sense the PTE flags should be adjusted to the device
> specific flags by the callbacks.

Can you please elaborate on what is it that doesn't make sense here and why=
,=20
and what you recommend to do instead?

> >  	if (is_compute_context) {
> >=20
> > @@ -3054,11 +3055,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> > *adev, u32 pasid,>=20
> >  		flags =3D AMDGPU_VM_NORETRY_FLAGS;
> >  		value =3D 0;
> >  =09
> >  	} else if (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_NEVER) {
> >=20
> > +		/* Don't allocate this PTE in the MALL */
> > +		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D=20
IP_VERSION(10, 3, 0))
> > +			flags |=3D AMDGPU_PTE_NOALLOC;
> > +
>=20
> This doesn't make sense either, mall allocation for the dummy page should=
 be
> perfectly fine.

I think we shouldn't waste space for this PTE in the MALL.

>=20
> >  		/* Redirect the access to the dummy page */
> >  		value =3D adev->dummy_page_addr;
> >  		flags |=3D AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
> >  	=09
> >  			AMDGPU_PTE_WRITEABLE;
> >=20
> > -
> >=20
> >  	} else {
> >  =09
> >  		/* Let the hw retry silently on the PTE */
> >  		value =3D 0;




