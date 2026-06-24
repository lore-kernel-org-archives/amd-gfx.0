Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401A2CDE001
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 15:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F1E10EF97;
	Wed, 24 Jun 2026 15:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H/YM9Ix8";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B6610EF96
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 15:42:45 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4626fdc829aso962294f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782315763; x=1782920563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kMVLZn/hUc4uFh26TWQAfqnUcgHbZCuDUvzt+0qkJ9U=;
 b=H/YM9Ix8IE04hLbARQ8jEi/w2UHHc7Zcqeji4Jt0U3536fUxkc9xs+6M0t5AdkzJw4
 YiBeakbN9O/0/l7Gh2RIIXZHB+Qb/txFKH2Sg1Qq4ezeV+5FlsJrNL2w9LsRNh2Heog7
 VIsdPVqOMvaHgJEcW57A0ttkezDKrTl2DpWhMFmfomiL0CoXd7HzfFOQWRPE1s4jQsV0
 RW0dzTMvsqnOaE0F6jJK8VdBNf+cFRJn1y9eQHHSBnTqI6gctHMuznU3sJs7AGEHJk1E
 DaDLoBPiqQv+r/wpEGl0+lBAig+VJy5THPb8K7iLSUgn3mMMDIdAoeggY9AgCQxOPh93
 rQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315763; x=1782920563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kMVLZn/hUc4uFh26TWQAfqnUcgHbZCuDUvzt+0qkJ9U=;
 b=AUyRN97SW/H8s6CUb5vzfCOkzBXDt1vvUf08B3mYRRvRWXp4W2DfsvA6h6AM0oYVb+
 olhM10/Qtu/zTjBGm8Gk685UwgF9V5/jiSXCqQIl74+KRVJCJ+N7riRTB2QCzLCmQO45
 udZUdwGZ6KMV4w+z86+8TCLnA9eGUPQnlclbIBlrQd5NQCl14f6IVNlu68GFHnRp5oUq
 ZjA1lC7qN763OirZb9IaGVpnl5CjbpDZWbypR2P5ev1a8JVHR7PFNpampD3Nv5V0IEKF
 ufTOztIng9qOu83Qr/0tfr68oXIULHJE50P5eUynSwnPb522YS+IAgPSxVCxTEUk4OFr
 jljw==
X-Gm-Message-State: AOJu0YxPrZtlHaWPJlUgIImnr2N+wb6eI5d0SBOW3TMqG158aYF0J7GZ
 IjTlqROLW+bnxRPdKkegMRYKkR9jWb0fMhlrUwDehezGFrFBE2AiFfATUk5spi9B
X-Gm-Gg: AfdE7cmjBTwVSpRX4ptxexBspCIA6fdOuzjUz9CWXbnbPUyq5w2sYERqOGXvKZg3pnD
 dX8KSy3oO4WDHbKNpym147qio6UcUFRakCKqQ/MP48PuYCFc1KzATXfDJsXe7j4AP3sJG87oZQs
 JX10n3sALEKtViSRm59HsX6M6iiWuUrK8ykw85CstmJdqrTSmEy0HT0zBRgSquQ8uSdGgWaLLgd
 /X8yCGEvrnoVPvjIP9YTzjA194HObc/Ogno8h9t2vvPuLgXOYnM6OH1SMnpn+/I1zyQfEnW1lY/
 Jh2RxWwChKZK3IBGKTjFyKN/8x8g46kuI7vyVmXoM4brVu8f+wMaFBqegnsHeLgnrg8tU0aEr62
 QbkDSJdJ468G84AUTqeAXTvlDaDOl7vvT/q2+8n0LWCnpQVzZ9XPfYJoM+1oNYVm/yOWiMR5oNS
 5ioMNWzgtWPbcL3liVOjaWBHT6OvjiBfJG1MtF
X-Received: by 2002:a05:6000:438a:b0:461:a5d6:8794 with SMTP id
 ffacd0b85a97d-46ad8a3a162mr12955859f8f.6.1782315763226; 
 Wed, 24 Jun 2026 08:42:43 -0700 (PDT)
Received: from timur-max.localnet ([62.77.225.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm8107709f8f.9.2026.06.24.08.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:42:42 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 2/7] drm/amdgpu: ACK the retry CAM after VM update finishes
Date: Wed, 24 Jun 2026 17:42:41 +0200
Message-ID: <2343144.t9SDvczpPo@timur-max>
In-Reply-To: <50b62ba1-c709-4f9e-818d-956bc431c89b@ursulin.net>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <2746166.fDdHjke4Dd@timur-max>
 <50b62ba1-c709-4f9e-818d-956bc431c89b@ursulin.net>
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

On 2026. j=C3=BAnius 24., szerda 17:14:59 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 24/06/2026 15:52, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAnius 24., szerda 16:31:20 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Tvrtko
> > Ursulin
> >=20
> > wrote:
> >> On 29/05/2026 11:30, Timur Krist=C3=B3f wrote:
> >>> Add a fence callback to the VM update and ACK the retry CAM
> >>> after the VM update is finished. Previously, we would ACK it
> >>> immediately after calling amdgpu_vm_handle_fault() which
> >>> caused a race condition that was likely to trigger the same
> >>> interrupt again, causing the same fault to be handled
> >>> multiple times.
> >>>=20
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>=20
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 28
> >>>    +++++++++++++++++++--
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  8 ++++++
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
> >>>    4 files changed, 36 insertions(+), 4 deletions(-)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> >>> 26aea960e2759..21c8d87477448 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>> @@ -545,6 +545,16 @@ void amdgpu_gmc_filter_faults_remove(struct
> >>> amdgpu_device *adev, uint64_t addr,>
> >>>=20
> >>>    	} while (fault->timestamp < tmp);
> >>>   =20
> >>>    }
> >>>=20
> >>> +static void amdgpu_gmc_retry_fault_handled(struct dma_fence *fence,
> >>> +					   struct dma_fence_cb
> >=20
> > *cb)
> >=20
> >>> +{
> >>> +	struct amdgpu_fence_cb *afc =3D container_of(cb, struct
> >=20
> > amdgpu_fence_cb,
> >=20
> >>> cb); +	struct amdgpu_device *adev =3D afc->adev;
> >>> +
> >>> +	/* CAM index is the array index of the current callback struct */
> >>> +	adev->irq.ih_funcs->retry_cam_ack(adev, afc - &adev-
> >>=20
> >> gmc.retry_cb[0]);
> >>=20
> >> Is the "afc - &adev->gmc.retry_cb[0]" part correct? It will be the ind=
ex
> >> of the array element, while ->retry_cam_ack() expects the content of
> >> that element, no?
> >=20
> > Like the comment says, the CAM index is the array index.
> > We just need the CAM index in order to tell the CAM to ACK the current
> > entry. The contents of the array are just there to make
> > dma_fence_add_callback() work with this callback function.
>=20
> Ah you are right, I got confused. But it is also a bit bad, and I mean
> not just the array sizing dilema from lower in the email. But since the
> cam_index comes from the hardware and then below we blindly do:
>=20
> 	if (dma_fence_add_callback(fence, &adev-
>gmc.retry_cb[cam_index].cb,
> amdgpu_gmc_retry_fault_handled))
>=20
> Should hardware manage to send two faults with the same cam_index when
> the previous one hasn't been handled

The retry CAM exists to filter page fault interrupts and prevent sending=20
multiple interrupts for the same fault. It won't send and interrupt with th=
e=20
same cam_index until we ACK the previous one.

> that is the very same callback is
> already installed and unsignaled (expect the unexpected), we have just
> upgraded the hardware bug to a kernel crash.
>=20
> If I now understand it right, you want to "remember" the cam_index
> received so callback knows what to handle. Hmm.. Allocating memory does
> seem allowed if I follow correctly that amdgpu_vm_handle_fault() is
> calling dma_resv_reserve_fences(). So unless I am missing something
> perhaps kmalloc of struct amdgpu_fence_cb would be fine after all?

It may be fine, but I'd very much prefer to avoid it if possible.

> And
> if so you should also probably rename it to a less generic name along
> the lines of amgpud_retry_fault_cb or so. Workable?

I'm OK to rename it for sure.

Timur

>=20
> >>> +}
> >>> +
> >>>=20
> >>>    int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
> >>>   =20
> >>>    				  struct amdgpu_iv_entry *entry,
> >>>    				  u64 addr,
> >>>=20
> >>> @@ -552,6 +562,7 @@ int amdgpu_gmc_handle_retry_fault(struct
> >>> amdgpu_device
> >>> *adev,>
> >>>=20
> >>>    				  u32 node_id,
> >>>    				  bool write_fault)
> >>>   =20
> >>>    {
> >>>=20
> >>> +	struct dma_fence *fence =3D NULL;
> >>>=20
> >>>    	int ret;
> >>>    =09
> >>>    	if (adev->irq.retry_cam_enabled) {
> >>>=20
> >>> @@ -564,8 +575,21 @@ int amdgpu_gmc_handle_retry_fault(struct
> >>> amdgpu_device *adev,>
> >>>=20
> >>>    		}
> >>>    	=09
> >>>    		ret =3D amdgpu_vm_handle_fault(adev, entry->pasid,
> >=20
> > entry->vmid, node_id,
> >=20
> >>> -					     addr, entry-
> >>=20
> >> timestamp, write_fault, NULL);
> >>=20
> >>> -		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
> >>> +					     addr, entry-
> >>=20
> >> timestamp, write_fault, &fence);
> >>=20
> >>> +
> >>> +		/* If the update is already done, ACK now, otherwise
> >=20
> > when it's done. */
> >=20
> >>> +		if (fence) {
> >>> +			adev->gmc.retry_cb[cam_index].adev =3D adev;
> >>=20
> >> Why is 16 retry_cb elements enough? I see in the code cam_index extrac=
ed
> >> from the IV entry with a mask such as 0x3ff.
> >=20
> > I think this came up in a conversation after I had already submitted the
> > patch. The maximum amount of CAM entries are specified by the
> > IH_RETRY_INT_CAM_CNTL.CAM_SIZE field.  The content of the field will ne=
ed
> > to be interpreted as something like this:
> > ((CAM_SIZE + 1) * 64) =3D (15 + 1) * 64 =3D 1024
> >=20
> > It is a good question whether we actually want to statically allocate t=
hat
> > many items. We should very much avoid doing dynamic allocation in the p=
age
> > fault handler. I'm open to suggestions on how to move forward with this.
> >=20
> >>> +
> >>> +			if (dma_fence_add_callback(fence, &adev-
> >>=20
> >> gmc.retry_cb[cam_index].cb,
> >>=20
> >>> +
> >=20
> > amdgpu_gmc_retry_fault_handled))
> >=20
> >>> +				adev->irq.ih_funcs-
> >>=20
> >> retry_cam_ack(adev, cam_index);
> >>=20
> >>> +
> >>> +			dma_fence_put(fence);
> >>> +		} else {
> >>> +			adev->irq.ih_funcs->retry_cam_ack(adev,
> >=20
> > cam_index);
> >=20
> >>> +		}
> >>> +
> >>>=20
> >>>    		if (ret)
> >>>    	=09
> >>>    			return 1;
> >>>    =09
> >>>    	} else {
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
> >>> 77eb153802845..3bfb06e011a86 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>> @@ -27,6 +27,7 @@
> >>>=20
> >>>    #define __AMDGPU_GMC_H__
> >>>   =20
> >>>    #include <linux/types.h>
> >>>=20
> >>> +#include <linux/dma-fence.h>
> >>>=20
> >>>    #include "amdgpu_irq.h"
> >>>    #include "amdgpu_xgmi.h"
> >>>=20
> >>> @@ -214,6 +215,11 @@ struct amdgpu_gmc_memrange {
> >>>=20
> >>>    	int nid_mask;
> >>>   =20
> >>>    };
> >>>=20
> >>> +struct amdgpu_fence_cb {
> >>> +	struct amdgpu_device *adev;
> >>> +	struct dma_fence_cb cb;
> >>> +};
> >>> +
> >>>=20
> >>>    enum amdgpu_gart_placement {
> >>>   =20
> >>>    	AMDGPU_GART_PLACEMENT_BEST_FIT =3D 0,
> >>>    	AMDGPU_GART_PLACEMENT_HIGH,
> >>>=20
> >>> @@ -305,6 +311,8 @@ struct amdgpu_gmc {
> >>>=20
> >>>    	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
> >>>    	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
> >>>=20
> >>> +	struct amdgpu_fence_cb retry_cb[16];
> >>> +
> >>>=20
> >>>    	bool tmz_enabled;
> >>>    	bool is_app_apu;
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
> >>> 8c3ba7213eb22..f5e9b97e92a8c 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> @@ -3035,7 +3035,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> >>> *adev, u32 pasid,>
> >>>=20
> >>>    	r =3D amdgpu_vm_update_pdes(adev, vm, true);
> >>>=20
> >>> -	*fence =3D vm->last_update;
> >>> +	*fence =3D dma_fence_get(vm->last_update);
> >>=20
> >> Ah! But passing over since you said you are dropping that patch anyway.
> >=20
> > That line should have gone to the previous patch and was added to this =
one
> > by mistake.
> >=20
> >>>    error_unlock:
> >>>    	amdgpu_bo_unreserve(root);
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c index
> >>> 2eb64df6daa94..6e28f0e435bf5 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> >>> @@ -132,7 +132,7 @@ static int amdgpu_vm_sdma_commit(struct
> >>> amdgpu_vm_update_params *p,>
> >>>=20
> >>>    				   DMA_RESV_USAGE_BOOKKEEP);
> >>>    =09
> >>>    	}
> >>>=20
> >>> -	if (fence && !p->immediate) {
> >>> +	if (fence) {
> >>=20
> >> Is this deliberate and if so what it is about? Commit message should
> >> explain it as well.
> >=20
> > The reason it is changed is because previously it wouldn't return a fen=
ce
> > in immediate mode. This line also should have gone to the previous patch
> > and was added to this one by mistake.
> >=20
> > Thanks & best regards,
> > Timur




