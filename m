Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E45C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7257613CB
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7257613CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E896E311;
	Thu, 17 Jun 2021 19:38:29 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D92A6E311
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 19:38:28 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id l9so4163667wms.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=KeH9m684vHd/OT5Mplw+5EDn2gUyNMB4GP8ab9z2cg4=;
 b=LoK25vzfDFw+8lKxe5ILaxCwhPds4YCOtVoDOG1KF3vZdRzlGU5XFfB55NiP/NZG5w
 D0resYbjArrA4szOwwlsYIBgQXpYp1t5uIEZvVq5Ehoz3uL3SSd5WTbhSEjLUMkHqa0B
 VBZQC4y624llLEtqa6Ww+zeAnwQ2g9AwJpCjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KeH9m684vHd/OT5Mplw+5EDn2gUyNMB4GP8ab9z2cg4=;
 b=sz1x07LH4hb3wyEd78bl9QVHROeERugwoSKD2h+LwlQI2dopisZBNyG+n79wlvXMpq
 NMS7Epdh5bhwbQFS8Y3d1nrITDqXfXfJa9AE5Mv+dTAvd0TddjbN/dN4/+HNZlik6bXX
 6oERPYEUahgCmQ5C1kkvz2poTkECjaX1147Ss+ygdIpvQDOiQx22ejdZsF4ODWpwwp9u
 TgdkxtMqpTFmJJPJUFM4Pp4Vlp/Gro5Gnj9e6VvJS2LZRJAOWwmCgwKyH3cvwPZoog3w
 orQq8HHVD6pXoaKlCVjMROLWjI+cs23nQDTsl4Bt+ZDvXkAlWTU0nnXUJgt3roKK6VsU
 E0zA==
X-Gm-Message-State: AOAM530SFNbVXxKfxoNkNZ7eNZjqXVNuvk00ns6GRzZvuintOMQ+poLN
 Cz2eV+KYUEAJsAHwIgE4y9OECA==
X-Google-Smtp-Source: ABdhPJwMQYxglpaNYuGYfiCD9zDH+urX1I7Gz+Cy7kud+1e6nHh/AIztGnr51ce4uRE2iGerLykaIA==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr7068059wmk.3.1623958706891;
 Thu, 17 Jun 2021 12:38:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l10sm6191258wrs.11.2021.06.17.12.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jun 2021 12:38:26 -0700 (PDT)
Date: Thu, 17 Jun 2021 21:38:24 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: unwrap fence chains in the explicit sync
 fence
Message-ID: <YMuksIKzYmgCZ2qS@phenom.ffwll.local>
References: <20210614174536.5188-1-christian.koenig@amd.com>
 <c474a0e1-e725-be64-0730-57231b5a8d15@gmail.com>
 <YMuGsGN/mxY+WU+q@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMuGsGN/mxY+WU+q@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 17, 2021 at 07:30:24PM +0200, Daniel Vetter wrote:
> On Thu, Jun 17, 2021 at 09:44:25AM +0200, Christian K=F6nig wrote:
> > Alex do want to review those so that we can close the ticket?
> =

> Maybe I'm behind on mails, but 2nd patch still has the issues I think I'm
> seeing ...

Ok with temperatures getting colder towards the night the 2nd patch looks
much better now :-) I replied there.
-Daniel

> -Daniel
> =

> > =

> > Thanks,
> > Christian.
> > =

> > Am 14.06.21 um 19:45 schrieb Christian K=F6nig:
> > > Unwrap the explicit fence if it is a dma_fence_chain and
> > > sync to the first fence not matching the owner rules.
> > > =

> > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> > > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 118 +++++++++++++-------=
---
> > >   1 file changed, 68 insertions(+), 50 deletions(-)
> > > =

> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_sync.c
> > > index 1b2ceccaf5b0..862eb3c1c4c5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> > > @@ -28,6 +28,8 @@
> > >    *    Christian K=F6nig <christian.koenig@amd.com>
> > >    */
> > > +#include <linux/dma-fence-chain.h>
> > > +
> > >   #include "amdgpu.h"
> > >   #include "amdgpu_trace.h"
> > >   #include "amdgpu_amdkfd.h"
> > > @@ -186,6 +188,55 @@ int amdgpu_sync_vm_fence(struct amdgpu_sync *syn=
c, struct dma_fence *fence)
> > >   	return amdgpu_sync_fence(sync, fence);
> > >   }
> > > +/* Determine based on the owner and mode if we should sync to a fenc=
e or not */
> > > +static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
> > > +				   enum amdgpu_sync_mode mode,
> > > +				   void *owner, struct dma_fence *f)
> > > +{
> > > +	void *fence_owner =3D amdgpu_sync_get_owner(f);
> > > +
> > > +	/* Always sync to moves, no matter what */
> > > +	if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> > > +		return true;
> > > +
> > > +	/* We only want to trigger KFD eviction fences on
> > > +	 * evict or move jobs. Skip KFD fences otherwise.
> > > +	 */
> > > +	if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_KFD &&
> > > +	    owner !=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> > > +		return false;
> > > +
> > > +	/* Never sync to VM updates either. */
> > > +	if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_VM &&
> > > +	    owner !=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> > > +		return false;
> > > +
> > > +	/* Ignore fences depending on the sync mode */
> > > +	switch (mode) {
> > > +	case AMDGPU_SYNC_ALWAYS:
> > > +		return true;
> > > +
> > > +	case AMDGPU_SYNC_NE_OWNER:
> > > +		if (amdgpu_sync_same_dev(adev, f) &&
> > > +		    fence_owner =3D=3D owner)
> > > +			return false;
> > > +		break;
> > > +
> > > +	case AMDGPU_SYNC_EQ_OWNER:
> > > +		if (amdgpu_sync_same_dev(adev, f) &&
> > > +		    fence_owner !=3D owner)
> > > +			return false;
> > > +		break;
> > > +
> > > +	case AMDGPU_SYNC_EXPLICIT:
> > > +		return false;
> > > +	}
> > > +
> > > +	WARN(debug_evictions && fence_owner =3D=3D AMDGPU_FENCE_OWNER_KFD,
> > > +	     "Adding eviction fence to sync obj");
> > > +	return true;
> > > +}
> > > +
> > >   /**
> > >    * amdgpu_sync_resv - sync to a reservation object
> > >    *
> > > @@ -211,67 +262,34 @@ int amdgpu_sync_resv(struct amdgpu_device *adev=
, struct amdgpu_sync *sync,
> > >   	/* always sync to the exclusive fence */
> > >   	f =3D dma_resv_excl_fence(resv);
> > > -	r =3D amdgpu_sync_fence(sync, f);
> > > +	dma_fence_chain_for_each(f, f) {
> > > +		struct dma_fence_chain *chain =3D to_dma_fence_chain(f);
> > > +
> > > +		if (amdgpu_sync_test_fence(adev, mode, owner, chain ?
> > > +					   chain->fence : f)) {
> > > +			r =3D amdgpu_sync_fence(sync, f);
> > > +			dma_fence_put(f);
> > > +			if (r)
> > > +				return r;
> > > +			break;
> > > +		}
> > > +	}
> > >   	flist =3D dma_resv_shared_list(resv);
> > > -	if (!flist || r)
> > > -		return r;
> > > +	if (!flist)
> > > +		return 0;
> > >   	for (i =3D 0; i < flist->shared_count; ++i) {
> > > -		void *fence_owner;
> > > -
> > >   		f =3D rcu_dereference_protected(flist->shared[i],
> > >   					      dma_resv_held(resv));
> > > -		fence_owner =3D amdgpu_sync_get_owner(f);
> > > -
> > > -		/* Always sync to moves, no matter what */
> > > -		if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_UNDEFINED) {
> > > +		if (amdgpu_sync_test_fence(adev, mode, owner, f)) {
> > >   			r =3D amdgpu_sync_fence(sync, f);
> > >   			if (r)
> > > -				break;
> > > -		}
> > > -
> > > -		/* We only want to trigger KFD eviction fences on
> > > -		 * evict or move jobs. Skip KFD fences otherwise.
> > > -		 */
> > > -		if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_KFD &&
> > > -		    owner !=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> > > -			continue;
> > > -
> > > -		/* Never sync to VM updates either. */
> > > -		if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_VM &&
> > > -		    owner !=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> > > -			continue;
> > > -
> > > -		/* Ignore fences depending on the sync mode */
> > > -		switch (mode) {
> > > -		case AMDGPU_SYNC_ALWAYS:
> > > -			break;
> > > -
> > > -		case AMDGPU_SYNC_NE_OWNER:
> > > -			if (amdgpu_sync_same_dev(adev, f) &&
> > > -			    fence_owner =3D=3D owner)
> > > -				continue;
> > > -			break;
> > > -
> > > -		case AMDGPU_SYNC_EQ_OWNER:
> > > -			if (amdgpu_sync_same_dev(adev, f) &&
> > > -			    fence_owner !=3D owner)
> > > -				continue;
> > > -			break;
> > > -
> > > -		case AMDGPU_SYNC_EXPLICIT:
> > > -			continue;
> > > +				return r;
> > >   		}
> > > -
> > > -		WARN(debug_evictions && fence_owner =3D=3D AMDGPU_FENCE_OWNER_KFD,
> > > -		     "Adding eviction fence to sync obj");
> > > -		r =3D amdgpu_sync_fence(sync, f);
> > > -		if (r)
> > > -			break;
> > >   	}
> > > -	return r;
> > > +	return 0;
> > >   }
> > >   /**
> > =

> =

> -- =

> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
