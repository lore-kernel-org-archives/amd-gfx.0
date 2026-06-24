Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3092CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 14:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5695810E0CB;
	Wed, 24 Jun 2026 14:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RyahkqV0";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAAC10E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 14:52:34 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-46cbf263113so570865f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782312752; x=1782917552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uFHlt4GmeRuL0yx8RlcHBHsHdy27BVu7415Roxsj7YY=;
 b=RyahkqV0KYmJvIBAwa0Dull3ur+3ikjFrovXY+UrxWBxemfQJdYbgsAJZJIjtfvc5A
 lnVQO9+c5R+/iRzIdRbnwGdNwSi6ma3lPu4B98OIx9xlioXU13iIkY39TP4DW83Xc9E8
 N+dYc9FZOIidFSIE/kEN5gBCU+dDfom0IZHRhTgom9wHecA0HqCAkvbAEkR/I1L+T7TL
 cBHfC2yfCFo7NOu30SMCy9eEYac1sSt+S4wwfufR/x/YlctGPOk2nzZwTLDinNc54ZdX
 WpKnF5WP0jlmDoPs0pqhzGh4ABoL0FUgqRpzSKNKZjneWxgioNUidFB9z6a0zoEXhWW+
 N/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782312752; x=1782917552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uFHlt4GmeRuL0yx8RlcHBHsHdy27BVu7415Roxsj7YY=;
 b=bpDTQgYQni56nNg0lPcF9fvRoDgMNLARHEbFUwgDPLsEaq6W89co0t1s0FVVfGTqKJ
 vyywgbf78rM1EGW/uVzqhHky11R/krxgbfKtIY50pQO/cHvflU/u+j8z2IXRcfl2uOP0
 FU9Ao21tNS2VIPIIk+K6flql8P1M9FBF8nx7JHHb7NR34F1a1+rFj/ptjbjov00keIHL
 hcEpqBCcLmt9y9HeSlnEfX9aqSCELsWwsndudtc0YAkBosc3JgWIc1/HCJ5THzHc9WHv
 mVvRtxuNza6Dk2s8b02l0RdBQwZRhrVH0XQG9cU1c+Yp03m5Jbh+M5RUDnezmIrTHtBt
 R/qQ==
X-Gm-Message-State: AOJu0Yy/0l7qc0sgh2owNNSR3Fz8GF/0eGSui9z920c3ykulakWK9DHB
 8Dpti/0DZH9GAMGD3NNfCH5hOKPxkVvQPXmSu0PtPSo9UXM5bJIY2hXZXk69yA==
X-Gm-Gg: AfdE7cnb3/HSqGxsQA3dw4kME4yy9oX3mEQfywl+6YxXDCvckJJjF3Nkv9FLNuZ5lyH
 2/Z7qYNK7JruUEfHfXwJI/g73UQpAJIzWqxVQx5ihRiwwiIinc2VIf7Gw5pyzasqDpoCQARS1yr
 rljtp7/AkOcxkREbkA5iTs/ObATcnSg47z+H4vcb9yHeUF6RGMiXF7qMwWh8idXs6OQiLhfVjPc
 V7E2UM5mPCWS5PbCHnEvUBNapfUB1DqzxH5mVnHstcO3UJMYvm1Trm6/8G37VvYfXkRnCG/TyLL
 Y9uf3zf3YvqdV8nI/iRRkA+zziHM+AWOHMJALfQFw8IOrPX45g/tjsRotBOQT/xfMdiY/aJDjc4
 m7Uz7FYIc28YcArL3beFcBIhkg65Q5M/g81I9w0CuCqGCVIJmCsMIwjnhzgijYuBZqPQO8xi8Lj
 kSWmu++c9Q33Krv7ftnPd2kOpfpA==
X-Received: by 2002:a05:6000:41f1:b0:45d:77f4:1ac2 with SMTP id
 ffacd0b85a97d-46c068f00bamr6161533f8f.0.1782312752238; 
 Wed, 24 Jun 2026 07:52:32 -0700 (PDT)
Received: from timur-max.localnet ([62.77.225.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c226a6f13sm7036093f8f.26.2026.06.24.07.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:52:31 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 2/7] drm/amdgpu: ACK the retry CAM after VM update finishes
Date: Wed, 24 Jun 2026 16:52:30 +0200
Message-ID: <2746166.fDdHjke4Dd@timur-max>
In-Reply-To: <55bb616f-343f-4189-8ef8-e9f20429cdbb@ursulin.net>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <20260529103059.21470-3-timur.kristof@gmail.com>
 <55bb616f-343f-4189-8ef8-e9f20429cdbb@ursulin.net>
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

On 2026. j=C3=BAnius 24., szerda 16:31:20 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 29/05/2026 11:30, Timur Krist=C3=B3f wrote:
> > Add a fence callback to the VM update and ACK the retry CAM
> > after the VM update is finished. Previously, we would ACK it
> > immediately after calling amdgpu_vm_handle_fault() which
> > caused a race condition that was likely to trigger the same
> > interrupt again, causing the same fault to be handled
> > multiple times.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 28 +++++++++++++++++++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  8 ++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
> >   4 files changed, 36 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> > 26aea960e2759..21c8d87477448 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -545,6 +545,16 @@ void amdgpu_gmc_filter_faults_remove(struct
> > amdgpu_device *adev, uint64_t addr,>=20
> >   	} while (fault->timestamp < tmp);
> >  =20
> >   }
> >=20
> > +static void amdgpu_gmc_retry_fault_handled(struct dma_fence *fence,
> > +					   struct dma_fence_cb=20
*cb)
> > +{
> > +	struct amdgpu_fence_cb *afc =3D container_of(cb, struct=20
amdgpu_fence_cb,
> > cb); +	struct amdgpu_device *adev =3D afc->adev;
> > +
> > +	/* CAM index is the array index of the current callback struct */
> > +	adev->irq.ih_funcs->retry_cam_ack(adev, afc - &adev-
>gmc.retry_cb[0]);
>=20
> Is the "afc - &adev->gmc.retry_cb[0]" part correct? It will be the index
> of the array element, while ->retry_cam_ack() expects the content of
> that element, no?

Like the comment says, the CAM index is the array index.
We just need the CAM index in order to tell the CAM to ACK the current entr=
y.
The contents of the array are just there to make dma_fence_add_callback() w=
ork=20
with this callback function.

>=20
> > +}
> > +
> >=20
> >   int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
> >  =20
> >   				  struct amdgpu_iv_entry *entry,
> >   				  u64 addr,
> >=20
> > @@ -552,6 +562,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_dev=
ice
> > *adev,>=20
> >   				  u32 node_id,
> >   				  bool write_fault)
> >  =20
> >   {
> >=20
> > +	struct dma_fence *fence =3D NULL;
> >=20
> >   	int ret;
> >   =09
> >   	if (adev->irq.retry_cam_enabled) {
> >=20
> > @@ -564,8 +575,21 @@ int amdgpu_gmc_handle_retry_fault(struct
> > amdgpu_device *adev,>=20
> >   		}
> >   	=09
> >   		ret =3D amdgpu_vm_handle_fault(adev, entry->pasid,=20
entry->vmid, node_id,
> >=20
> > -					     addr, entry-
>timestamp, write_fault, NULL);
> > -		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
> > +					     addr, entry-
>timestamp, write_fault, &fence);
> > +
> > +		/* If the update is already done, ACK now, otherwise=20
when it's done. */
> > +		if (fence) {
> > +			adev->gmc.retry_cb[cam_index].adev =3D adev;
>=20
> Why is 16 retry_cb elements enough? I see in the code cam_index extraced
> from the IV entry with a mask such as 0x3ff.

I think this came up in a conversation after I had already submitted the=20
patch. The maximum amount of CAM entries are specified by the=20
IH_RETRY_INT_CAM_CNTL.CAM_SIZE field.  The content of the field will need t=
o be=20
interpreted as something like this:
((CAM_SIZE + 1) * 64) =3D (15 + 1) * 64 =3D 1024

It is a good question whether we actually want to statically allocate that=
=20
many items. We should very much avoid doing dynamic allocation in the page=
=20
fault handler. I'm open to suggestions on how to move forward with this.

>=20
> > +
> > +			if (dma_fence_add_callback(fence, &adev-
>gmc.retry_cb[cam_index].cb,
> > +						  =20
amdgpu_gmc_retry_fault_handled))
> > +				adev->irq.ih_funcs-
>retry_cam_ack(adev, cam_index);
> > +
> > +			dma_fence_put(fence);
> > +		} else {
> > +			adev->irq.ih_funcs->retry_cam_ack(adev,=20
cam_index);
> > +		}
> > +
> >=20
> >   		if (ret)
> >   	=09
> >   			return 1;
> >   =09
> >   	} else {
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
> > 77eb153802845..3bfb06e011a86 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -27,6 +27,7 @@
> >=20
> >   #define __AMDGPU_GMC_H__
> >  =20
> >   #include <linux/types.h>
> >=20
> > +#include <linux/dma-fence.h>
> >=20
> >   #include "amdgpu_irq.h"
> >   #include "amdgpu_xgmi.h"
> >=20
> > @@ -214,6 +215,11 @@ struct amdgpu_gmc_memrange {
> >=20
> >   	int nid_mask;
> >  =20
> >   };
> >=20
> > +struct amdgpu_fence_cb {
> > +	struct amdgpu_device *adev;
> > +	struct dma_fence_cb cb;
> > +};
> > +
> >=20
> >   enum amdgpu_gart_placement {
> >  =20
> >   	AMDGPU_GART_PLACEMENT_BEST_FIT =3D 0,
> >   	AMDGPU_GART_PLACEMENT_HIGH,
> >=20
> > @@ -305,6 +311,8 @@ struct amdgpu_gmc {
> >=20
> >   	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
> >   	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
> >=20
> > +	struct amdgpu_fence_cb retry_cb[16];
> > +
> >=20
> >   	bool tmz_enabled;
> >   	bool is_app_apu;
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
> > 8c3ba7213eb22..f5e9b97e92a8c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -3035,7 +3035,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> > *adev, u32 pasid,>=20
> >   	r =3D amdgpu_vm_update_pdes(adev, vm, true);
> >=20
> > -	*fence =3D vm->last_update;
> > +	*fence =3D dma_fence_get(vm->last_update);
>=20
> Ah! But passing over since you said you are dropping that patch anyway.

That line should have gone to the previous patch and was added to this one =
by=20
mistake.

>=20
> >   error_unlock:
> >   	amdgpu_bo_unreserve(root);
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c index
> > 2eb64df6daa94..6e28f0e435bf5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> > @@ -132,7 +132,7 @@ static int amdgpu_vm_sdma_commit(struct
> > amdgpu_vm_update_params *p,>=20
> >   				   DMA_RESV_USAGE_BOOKKEEP);
> >   =09
> >   	}
> >=20
> > -	if (fence && !p->immediate) {
> > +	if (fence) {
>=20
> Is this deliberate and if so what it is about? Commit message should
> explain it as well.

The reason it is changed is because previously it wouldn't return a fence i=
n=20
immediate mode. This line also should have gone to the previous patch and w=
as=20
added to this one by mistake.=20

Thanks & best regards,
Timur



