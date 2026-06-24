Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F800CDB481
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 14:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7AE510E0A8;
	Wed, 24 Jun 2026 14:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJByVxgn";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E1210E0A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 14:10:50 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c0d6c75c58cso189679066b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782310248; x=1782915048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TciN1Xqt1hFRE0qAoFMgzpxL9xrSsf1wzBczJJBqllk=;
 b=mJByVxgnEAjYkkp3l8nElncoCsb6A1EFWLJm6kAZsd4TSZ1MCA5viw2QJyqZqDzjO4
 we2/27NKfnhVLHlfD+akG6QDA1uSnl7B12S0SQPT/dclI95j/NmGxtOYX8iVFJ8TClIj
 fhH4SUqpZVbUMhGVlupdeCxHTFnUGwxIK8QprEbiscFShSxHnHMlCnlJDLWRcdmKPocr
 aY0K9TP4eGuKqqzpEkOqwAOFL7XR/acB79I3Bb7mI+/z8A5qV+nR4xlpeCl/P2lhgl2n
 nMgRbJQQ8gkHI3rGl+OuiJ6deB0ZPAZoGFVestm3f4fSBE04wY8o29qBIPEYZKkgepkV
 8sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782310248; x=1782915048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TciN1Xqt1hFRE0qAoFMgzpxL9xrSsf1wzBczJJBqllk=;
 b=O+DIwSr71h2DhtrxPNkyR5pShIUa2oGA9gJBzPXkN2nEn8JeH84nZYJ/NNUmDCCqcH
 aLrADRx5/gr3JpUo8PaneiGe2POfMwzclNkNPsaSZkRsKvoIo+U3z15IvOaUY3cs0cD/
 JbAcBuKsplmKlBGHez/isA/LUtkEZ3UJuK8C/215wK2Eq6zZC+ctbZOHW/Y69fTFVvPS
 IAwfkKIZSnx1CgSzPsXsrlOWPrE/FJdeN0PNs8TaAzkdFmZcgG+usF7g6kP0fUWAaqfi
 K6Tw781dvs0ZkU0jGdsOsW1I8/nJyBEHM85NnJj9dshnEeFZMQTq66vSia6e4Lzb+LA2
 v92A==
X-Gm-Message-State: AOJu0Yzb1shdqvEzwnGAMuw5yKDwQTX1xrFN/jwzVtCOFBbSgDWguqfU
 W5iMnyyoH5BZerhQzVHQoFXr69Yn/yANTK8gYwB1kqdP75W3SfkPjxaO+RBUGQ==
X-Gm-Gg: AfdE7clsJtaqk4Nphcs43A8meW2nB1AHG5etmqQb35ejAnIGIAxJBi7NFcecSAAZXV6
 StCAPQPCfX8/NxxRHgk0yk4wT9VZK70EolSfUKmy34SQE/YtdgK8eC17f8xE+pImO+firih1JYX
 oEl+fnkGQEmDIBCIvZL11n9ulkOPPAp3Ey47UDt8GMH064NVZ80N5m8p2GSsglGO/UpcljbCzgL
 ClUHJECDgGjxMo79z16Y1Bba4PvlaUnZVcrhLo7kv2iaYlKrLr3Wd+sMQL5ZVTrx2JfC5FogzOO
 mABtEoqxu73Kd2qvgzsOXX0CzC3z1ABi7ceWbJ6JVl6JQQdvy4vFzSXzrXCL/ilsnNz7wAj9Un4
 nWGEL2IGib9OMCwOtVvMSjy/FGMPoYCDv1IW/69yWSLqQNFBx1m1n4Ihun9HSrs7+ZyCCtoiBlI
 6a30IYPQOOBedHkyGGjRTjrsm51bomYQJ+cs6Row==
X-Received: by 2002:a17:907:7244:b0:bab:cab:c372 with SMTP id
 a640c23a62f3a-c0c64694cc8mr1087959666b.22.1782310248027; 
 Wed, 24 Jun 2026 07:10:48 -0700 (PDT)
Received: from timur-max.localnet (netacc-gpn-7-144-116.pool.yettel.hu.
 [176.77.144.116]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c5b304722sm660245966b.0.2026.06.24.07.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:10:47 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 1/7] drm/amdgpu/vm: Add fence argument to
 amdgpu_vm_handle_fault()
Date: Wed, 24 Jun 2026 16:09:54 +0200
Message-ID: <5790868.rdbgypaU67@timur-max>
In-Reply-To: <5dc2e31f-7e28-4076-9842-2c4245c01e67@ursulin.net>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <20260529103059.21470-2-timur.kristof@gmail.com>
 <5dc2e31f-7e28-4076-9842-2c4245c01e67@ursulin.net>
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

On 2026. j=C3=BAnius 24., szerda 15:54:30 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 29/05/2026 11:30, Timur Krist=C3=B3f wrote:
> > Allow the caller to respond to when the VM update is finished.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 5 ++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 4 ++--
> >   4 files changed, 9 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> > d790b7619ccd4..26aea960e2759 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -564,7 +564,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_dev=
ice
> > *adev,>=20
> >   		}
> >   	=09
> >   		ret =3D amdgpu_vm_handle_fault(adev, entry->pasid,=20
entry->vmid, node_id,
> >=20
> > -					     addr, entry-
>timestamp, write_fault);
> > +					     addr, entry-
>timestamp, write_fault, NULL);
> >=20
> >   		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
> >   		if (ret)
> >   	=09
> >   			return 1;
> >=20
> > @@ -587,7 +587,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_dev=
ice
> > *adev,>=20
> >   		 * tables
> >   		 */
> >   	=09
> >   		if (amdgpu_vm_handle_fault(adev, entry->pasid, entry-
>vmid, node_id,
> >=20
> > -					   addr, entry-
>timestamp, write_fault))
> > +					   addr, entry-
>timestamp, write_fault, NULL))
> >=20
> >   			return 1;
> >   =09
> >   	}
> >   	return 0;
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
> > b523a7b97d6f1..8c3ba7213eb22 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2962,13 +2962,14 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct
> > amdgpu_device *adev,>=20
> >    *           GFX 9.4.3.
> >    * @addr: Address of the fault
> >    * @write_fault: true is write fault, false is read fault
> >=20
> > + * @fence: optional resulting fence, signaled after update is done
> >=20
> >    *
> >    * Try to gracefully handle a VM fault. Return true if the fault was
> >    handled and * shouldn't be reported any more.
> >    */
> >  =20
> >   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> >  =20
> >   			    u32 vmid, u32 node_id, uint64_t addr,
> >=20
> > -			    uint64_t ts, bool write_fault)
> > +			    uint64_t ts, bool write_fault, struct=20
dma_fence **fence)
> >=20
> >   {
> >  =20
> >   	bool is_compute_context =3D false;
> >   	struct amdgpu_bo *root;
> >=20
> > @@ -3034,6 +3035,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> > *adev, u32 pasid,>=20
> >   	r =3D amdgpu_vm_update_pdes(adev, vm, true);
> >=20
> > +	*fence =3D vm->last_update;
>=20
> Unless the heat wave is severely interfering with my ability to read
> code, fence here is mostly NULL and who owns the reference is suspect.
> Did you mean like this:
>=20
> if (fence)
> 	*fence =3D dma_fence_get(vm->last_update);
>=20
> Kernel doc should perhaps clarify along the lines of:
>=20
> "@fence: If non-null, returns a fence with an extra reference for the
> caller, which is signaled after update is done.".
>=20
> Regards,
>=20
> Tvrtko

Thank you!
Yes, that's a valid point. I will fix this.

Note that I will likely drop this patch from the next version of the series=
=20
and submit it separately, because it conflicts with Christian's series.
>=20
> > +
> >=20
> >   error_unlock:
> >   	amdgpu_bo_unreserve(root);
> >   	if (r < 0)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index
> > cc096c005e348..72da6b3d98c70 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -589,7 +589,7 @@ void amdgpu_vm_put_task_info(struct amdgpu_task_info
> > *task_info);>=20
> >   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> >  =20
> >   			    u32 vmid, u32 node_id, uint64_t addr,=20
uint64_t ts,
> >=20
> > -			    bool write_fault);
> > +			    bool write_fault, struct dma_fence=20
**fence);
> >=20
> >   struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
> >  =20
> >   					  struct amdgpu_bo=20
**root, u32 pasid);
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c index
> > 855cd29cbffaa..da18c02013966 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> > @@ -155,7 +155,7 @@ static int gmc_v12_1_process_interrupt(struct
> > amdgpu_device *adev,>=20
> >   			cam_index =3D entry->src_data[3] & 0x3ff;
> >   		=09
> >   			ret =3D amdgpu_vm_handle_fault(adev, entry-
>pasid, entry->vmid,
> >   			node_id,
> >=20
> > -						=09
addr, entry->timestamp, write_fault);
> > +						=09
addr, entry->timestamp, write_fault, NULL);
> >=20
> >   			WDOORBELL32(adev-
>irq.retry_cam_doorbell_index, cam_index);
> >   			if (ret)
> >   		=09
> >   				return 1;
> >=20
> > @@ -178,7 +178,7 @@ static int gmc_v12_1_process_interrupt(struct
> > amdgpu_device *adev,>=20
> >   			 * tables
> >   			 */
> >   		=09
> >   			if (amdgpu_vm_handle_fault(adev, entry-
>pasid, entry->vmid, node_id,
> >=20
> > -						   addr,=20
entry->timestamp, write_fault))
> > +						   addr,=20
entry->timestamp, write_fault, NULL))
> >=20
> >   				return 1;
> >   	=09
> >   		}
> >   =09
> >   	}



