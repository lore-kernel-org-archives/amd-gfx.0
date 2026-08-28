Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C47CC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919B710E286;
	Fri, 28 Aug 2026 15:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQFRfNZs";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AADC10E286
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:38:00 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c2531f453eeso186680666b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787931479; x=1788536279; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VXOy5RX76XU18ZmsIrtbwi3Ox8+6xD1VMnorRB3woLE=;
 b=GQFRfNZsbVd/7LgqWnTGM80DY0SvU/kNGFza4bnoJM03xHmtTvSX7PJ3HWdv1hqnCd
 tdYKkc8wm22jC3sVIDZ7ITvKnASQsKYHeyYYMl0vgFwwIdSMPA9GGTT7a+Ig84ogKixr
 PMGTpvf/Il/aepH8/PyBQeFHgv27IN1OZtGsq1Yt8F4GPquozgD0nNZ1Z/XxExQyuv1a
 4Kq8/oSieRBjI03B3ub+PGqNzkkaZHHuV1S716Dq3T4Mu7KshomM6Fv96GW1GJM/FJAf
 2KCw/jhWIT+fM2lNyA33MV+n3AHMXM6ApCEX+zntJ/fnnb4q2t8V2thcuZWSwVtfAQ9o
 mIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787931479; x=1788536279;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VXOy5RX76XU18ZmsIrtbwi3Ox8+6xD1VMnorRB3woLE=;
 b=gExYcKW/TmbfMY/ytBMBTArh0a2ZBL7kLtheT4/hKx/VdC+9/ND6f7wci/XnJN3H5T
 UqkyTTIUTrBZrzrvQoSmHxGCtnv4SmD8W9uME73xfx0LwBkBb6M9EfdIbaIxTEB6gnLS
 m96dFWG9WEy4MuC+jAVxVxk3E/fliDtHqlseD+h8ITxdivpgx/BQqmoPsr7T+/wbnyHd
 5iEc7CSCPLv2h4yYJu+DDDd6F1Qm6wftOWMFp9QMCsOLkhcymAcHyKu4fH2aAtU2gQLS
 vh+EfF7WTWO4mL3MmPLFTmbLVPWoybG0X33Z2nHfc+1ubkcg2pMtZHdRxITzjar45Pz8
 p9Wg==
X-Gm-Message-State: AFuF++nWbzuY+tQ+SVvKNB5SoYqND64wjiRQ9Q3SA/ctb8kIQSBFHQIO
 iX6c34KLWvme3KXoxqI0w8sEppUvF7bmBGZ0tMaR78XbK1Bd9F0GRSBXSrmU5A==
X-Gm-Gg: AR+sD10OTov63OUnTMPYje9zyqDmdB8WiviG8+lGuvVdiUjK8+Tm2KNP8oPoPXIHNHE
 rsjy+g7wE0n7sZ7LKp1N/3RjyafPDHRD1OTz8dEG9JmTDNWnR1i2DovEKg3rsdle8H0RG+STKx/
 1YmflFCBN2oVDR8QEbIfxCaUOd+gRYTHPi9q+D9x+x78bZXyOxuOvTKPGzUK5gCcztDVaF/bZqB
 Sd2TAGvQj8WRK3StcpvGMd3oiyWCNgMx4+wnqP3+g5hpsD70q/WPlmme61x91rlIYxkYuLafMYm
 QPfuUxWTv/lCn3FZbB4CsXhherBXjhm6L7kdf10OlBZXOki4v9/73JhN0N/9N9KcxyeN9XBKo9Q
 T9C7KB75+f5kOpAlzoLepB+yZN0iX0O6Cpk60MW9jlopyX0WJ5Df7rHaUgGapGMeCvOWFqaIVLJ
 +u9r/VkHpvfMHQ5Sbb+4jKZbo0hK/FIVfHB7OcRYu9Nt+0CDsFJP9u6dC+brPp+9y6mcwF7qwoZ
 LEmwtGIpJFQECJg12ZSI+EdXpZx4lTq5WiGaSEwifKkruU=
X-Received: by 2002:a17:906:9c8a:b0:c20:23f8:99a5 with SMTP id
 a640c23a62f3a-c2557181411mr580363066b.15.1787931478624; 
 Fri, 28 Aug 2026 08:37:58 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B9A5E.dsl.pool.telekom.hu.
 [94.27.154.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1fb965sm96799366b.49.2026.08.28.08.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 08:37:58 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common
 code
Date: Fri, 28 Aug 2026 17:37:57 +0200
Message-ID: <EhsDbURtRYeOUXN6bnOG9Q@gmail.com>
In-Reply-To: <032550fc-5680-4f6c-974c-fe96cc8083e1@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-4-timur.kristof@gmail.com>
 <032550fc-5680-4f6c-974c-fe96cc8083e1@amd.com>
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

On Friday, August 28, 2026 4:20:19=E2=80=AFPM Central European Summer Time =
Lazar, Lijo=20
wrote:
> On 28-Aug-26 5:37 PM, Timur Krist=C3=B3f wrote:
> > The code was exactly the same between SDMA v5.0 and v5.2
> > furthermore the exact same implementation can be shared
> > between all SDMA versions that don't use MES.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 37 ++++++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  4 +++
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 25 +---------------
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 +---------------
> >   4 files changed, 43 insertions(+), 48 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index
> > 66f278f77f71..9eebd8380834 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > @@ -635,3 +635,40 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device
> > *adev, uint32_t instance_id,>=20
> >   	return ret;
> >  =20
> >   }
> >=20
> > +
> > +/**
> > + * amdgpu_sdma_reset_queue_legacy() - Reset legacy SDMA queue after
> > timeout (without MES) + *
> > + * @ring: Pointer to the ring of the SDMA queue
> > + * @vmid: VMID of the timed out job
> > + * @timedout_fence: Fence of the timed out job
> > + *
> > + * Common implementation for resetting SDMA queues without MES (legacy=
).
> > + * This relies on the proper amdgpu_sdma_funcs to be set up
> > + * for the given ring.
> > + *
> > + * Applicable to SDMA versions that don't rely on the MES yet,
> > + * that is all versions up to SDMA v5.x and older.
> > + */
> > +int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
> > +				   unsigned int vmid,
> > +				   struct amdgpu_fence=20
*timedout_fence)
> > +{
> > +	struct amdgpu_device *adev =3D ring->adev;
> > +	int r;
> > +
> > +	if (ring->me >=3D adev->sdma.num_instances) {
> > +		dev_err(adev->dev, "sdma instance not found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > +
> > +	amdgpu_amdkfd_suspend(adev, true);
> > +	r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> > +	amdgpu_amdkfd_resume(adev, true);
> > +	if (r)
> > +		return r;
> > +
> > +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +}
>=20
> Instead of moving it here - sdma_v5_x_reset_queue and using it for 5.2
> is better. This may not work in the same way for all legacy queues.
>=20
> Thanks,
> Lijo

Hi,

As far as I see, this function can be reused for all generations that don't=
=20
use MES. If you don't think so, please explain why not.

Thanks,
Timur

>=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h index
> > 4f4e56022c97..7c4e145ca0c1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > @@ -160,6 +160,10 @@ struct amdgpu_buffer_funcs {
> >=20
> >   int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> >   instance_id,>  =20
> >   			     bool caller_handles_kernel_queues);
> >=20
> > +int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
> > +				   unsigned int vmid,
> > +				   struct amdgpu_fence=20
*timedout_fence);
> > +
> >=20
> >   #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t)
> >   (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
> >   #define amdgpu_emit_fill_buffer(adev, ib, s, d, b)
> >   (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))>=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c index 0da54c335822..76f8765fb1=
75
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -1518,29 +1518,6 @@ static int sdma_v5_0_wait_for_idle(struct
> > amdgpu_ip_block *ip_block)>=20
> >   	return -ETIMEDOUT;
> >  =20
> >   }
> >=20
> > -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
> > -				 unsigned int vmid,
> > -				 struct amdgpu_fence=20
*timedout_fence)
> > -{
> > -	struct amdgpu_device *adev =3D ring->adev;
> > -	int r;
> > -
> > -	if (ring->me >=3D adev->sdma.num_instances) {
> > -		dev_err(adev->dev, "sdma instance not found\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > -
> > -	amdgpu_amdkfd_suspend(adev, true);
> > -	r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> > -	amdgpu_amdkfd_resume(adev, true);
> > -	if (r)
> > -		return r;
> > -
> > -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > -}
> > -
> >=20
> >   static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
> >   {
> >  =20
> >   	u32 f32_cntl, freeze, cntl, stat1_reg;
> >=20
> > @@ -1936,7 +1913,7 @@ static const struct amdgpu_ring_funcs
> > sdma_v5_0_ring_funcs =3D {>=20
> >   	.emit_reg_write_reg_wait =3D=20
sdma_v5_0_ring_emit_reg_write_reg_wait,
> >   	.init_cond_exec =3D sdma_v5_0_ring_init_cond_exec,
> >   	.preempt_ib =3D sdma_v5_0_ring_preempt_ib,
> >=20
> > -	.reset =3D sdma_v5_0_reset_queue,
> > +	.reset =3D amdgpu_sdma_reset_queue_legacy,
> >=20
> >   };
> >  =20
> >   static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c index 5543e381dcca..e7f4b74f27=
b4
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -1436,29 +1436,6 @@ static int sdma_v5_2_wait_for_idle(struct
> > amdgpu_ip_block *ip_block)>=20
> >   	return -ETIMEDOUT;
> >  =20
> >   }
> >=20
> > -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
> > -				 unsigned int vmid,
> > -				 struct amdgpu_fence=20
*timedout_fence)
> > -{
> > -	struct amdgpu_device *adev =3D ring->adev;
> > -	int r;
> > -
> > -	if (ring->me >=3D adev->sdma.num_instances) {
> > -		dev_err(adev->dev, "sdma instance not found\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > -
> > -	amdgpu_amdkfd_suspend(adev, true);
> > -	r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> > -	amdgpu_amdkfd_resume(adev, true);
> > -	if (r)
> > -		return r;
> > -
> > -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > -}
> > -
> >=20
> >   static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
> >   {
> >  =20
> >   	u32 f32_cntl, freeze, cntl, stat1_reg;
> >=20
> > @@ -1951,7 +1928,7 @@ static const struct amdgpu_ring_funcs
> > sdma_v5_2_ring_funcs =3D {>=20
> >   	.emit_reg_write_reg_wait =3D=20
sdma_v5_2_ring_emit_reg_write_reg_wait,
> >   	.init_cond_exec =3D sdma_v5_2_ring_init_cond_exec,
> >   	.preempt_ib =3D sdma_v5_2_ring_preempt_ib,
> >=20
> > -	.reset =3D sdma_v5_2_reset_queue,
> > +	.reset =3D amdgpu_sdma_reset_queue_legacy,
> >=20
> >   };
> >  =20
> >   static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)




