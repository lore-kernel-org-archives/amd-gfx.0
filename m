Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EE3C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 14:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8093110E667;
	Fri, 23 Dec 2022 14:23:38 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17A710E630
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Dec 2022 10:00:42 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0CFE56AF92;
 Fri, 23 Dec 2022 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671789641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylwa3UXbYSA1BZ0BDMVS+iRPlorVsmnmMrRmEkRE598=;
 b=iIORwIYeZr9K5U7APGTecJeJnkUSBpQtAqEfGB69Lg+c+vB05zvucvdhgtS/+f/3Oc1QOA
 qmIvbF27RoAYd9UjV4hBwjfbfexCY5U5hQEdZPCdcPS1R+x+1Lshp1wi4OLlE4K4J22ASt
 di0UstZz0TDC1O3vIzELz+2eU9NV3Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671789641;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylwa3UXbYSA1BZ0BDMVS+iRPlorVsmnmMrRmEkRE598=;
 b=qCzSslcR3GosBl81J3Ev+AnOZjNuTMlGyVjbnGAPmkI6BNLNr8fs+fxtUQZyE4X81fDjnX
 UhRYRIzD8qY0I3Bg==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EDB392C142;
 Fri, 23 Dec 2022 10:00:40 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
 id C12E460412; Fri, 23 Dec 2022 11:00:38 +0100 (CET)
Date: Fri, 23 Dec 2022 11:00:38 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Message-ID: <20221223100038.uooxfoz42bq52gnw@lion.mk-sys.cz>
References: <20221219104718.21677-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rsgg4klgmlizj5ft"
Content-Disposition: inline
In-Reply-To: <20221219104718.21677-1-christian.koenig@amd.com>
X-Mailman-Approved-At: Fri, 23 Dec 2022 14:23:33 +0000
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
Cc: mikhail.v.gavrilov@gmail.com, michel@daenzer.net, bp@alien8.de,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--rsgg4klgmlizj5ft
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 11:47:18AM +0100, Christian K=F6nig wrote:
> That function consumes the reference.
>=20
> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> Fixes: aab9cf7b6954 ("drm/amdgpu: use scheduler dependencies for VM updat=
es")

Tested-by: Michal Kubecek <mkubecek@suse.cz>

I can still see weird artefacts in some windows (firefox, konsole) but
those are probably unrelated, the refcount errors are gone with this patch.

Michal

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_sdma.c
> index 59cf64216fbb..535cd6569bcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -238,8 +238,10 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_up=
date_params *p,
>  	/* Wait for PD/PT moves to be completed */
>  	dma_resv_iter_begin(&cursor, bo->tbo.base.resv, DMA_RESV_USAGE_KERNEL);
>  	dma_resv_for_each_fence_unlocked(&cursor, fence) {
> +		dma_fence_get(fence);
>  		r =3D drm_sched_job_add_dependency(&p->job->base, fence);
>  		if (r) {
> +			dma_fence_put(fence);
>  			dma_resv_iter_end(&cursor);
>  			return r;
>  		}
> --=20
> 2.34.1
>=20

--rsgg4klgmlizj5ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmOlfD4ACgkQ538sG/LR
dpUTbQgAhgI1G9eAH6Rxz3W+odSF4eiTKQmJUdVwiWPGsVDzIoWy2KODnFZhoK+a
/R+kun1hOLUhBIpoMVkQ+0XMNF6Ka5pOz3yYW/HEzTGEQXhN0Bq8OHbfV9J2w9SV
AsI8p7DUarDvDSakbM9fhHIzywVDUhVNVV2CnlYFzbIcFL6f3/Hiu+oVhOK64/TV
Niqo2+pFrq5I/lzvQYfC4p6pSCwTUdq2vqsSaRaJqxt8NsdMdynPK/+ehj8L2INf
rK6jaLKzQ2/fMVgRv4YkAFex9JNqjKhEIkqSV6a884jBlX4LaUQ5yHvj2MSectZz
HghddJHmGVjYzhVwPHCDFnGvDQCt5Q==
=T4i5
-----END PGP SIGNATURE-----

--rsgg4klgmlizj5ft--
