Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB656CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 10:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E26710E116;
	Fri,  5 Jun 2026 10:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aLk1ZS9/";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A246810E116
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 10:11:07 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso14909975e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2026 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780654266; x=1781259066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7HAS2PlCdMvegt9EyWAXWZ0dEMMbR/1/BF1g6rITxt4=;
 b=aLk1ZS9/Z8joPSmqzsXcRmZAgM3U4TFRxq9GmltldXD/L3GotvxE4S367SlQeqeUrE
 XXZ/s0dwQ0C29uQzpHIw+r8YdKbUh24m040J4SGfatU2soUGOTV3FuCo3geYpDj3tKNT
 n+ZRWHC6/0shkJufnE1ToF07uOkzJiHWlTbl0JCQ22ZryBNQm9b67ebSTNMRzodUecav
 PKK4/08F30PyExSUqs5hwoGZ6KJk1RRASyKtTcF5JPjlQ3vQzaq2BG3fOsoyNwekxBQA
 uYh4o5mj97LY7UrqaM/7Y3aO8coWVWeZhQQFrlOrPN+hmPEyv+TQhFUVfgH3YZnqS8sy
 NOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780654266; x=1781259066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7HAS2PlCdMvegt9EyWAXWZ0dEMMbR/1/BF1g6rITxt4=;
 b=jkwsG65lTy9MmWTYc5/exg0yV3b2lF6FpTZPH7VVnok3rELZfccNcER6x1a2byzz9C
 ZUzoJGoN+m8NMsBpKdX6bUALMpE+1ToO5j6K42PO6ybZlymxH2BHRWRQHtOUhClaHhKZ
 9uMTPKo7or5ezxbLsex8VzZkojwrBcfFb2eFAA17KVPiufJV220EChZF7qwUMYsf7MmQ
 hl7EocXW7dOB82WUGbGtT8O3qABMrzntbJHmOE19xWtGTUTAefSLAwXBFrAblyY86oIb
 VjMLHjk3VQkZdKiLxftxzegllhnMfamt+aSXLCwBaGwzSGH18rHXrTspH2iHiKCXkCy/
 Ybig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r4/KmGk/sRL1oAHIUM3MIApeTlY9M2ICurPDvFDMSN23SQZ5gFSRX9m0lKAp5bhAdTkSZOEGL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6aeMmaVpWsh5umFlEA3mZPn7uChOGIZgqPGmMH+/tSpXNA5KY
 y1ZOzKI19Xnj+011wgcRag+VVbokhFegs9CK/p6IBHATAF3JEcA+xX1I
X-Gm-Gg: Acq92OGcG2F6zxIelnQlXWy8wbQCjN7h1EoqRWdfxYsBk97GGPo6V+AaSrKcNawJY8O
 aFFLN/n4NDBZK3ZCIC4tfQiHNlu/fjPe3pxsKzqdGo9EVWY+1rwV/YFCYmVAZ14VibSUvQyO47x
 1C9D/I45rjN+soYiWjfLYsizgThqLk8CuPLHayqQF2sG9KKXh8ReMign5xwyNGMJrG6BPoNFWUo
 ARNreX8yhdGtATulOm9ll2kDM8D0qu19MVGVKjgJ0ziobr5bkgQgnplMvvWhKWGl3MbuZPS3Jk4
 gv4QYigic8AhFySNcq48SKSyFovwp/evfuQ4AECMrzWIYxufd1I6IOmO8w2QbgQrJ+QNF0LgGbI
 vD/w1LQfBYtlqTaTuO5LLujub56Y72x5DCh9YYS4rT3uDUpx3Z6PutNFHuC4+2czWBpYS3kYKXy
 e0Yq5ZAjpuCWWJj6/aX0w7ghnPpUOKIBemJTsDM7235o38g68m/jqqoa3qmqqIo1+VDikIcrr2c
 z2YXq+h/kYqaPKLqZvcphz6nmNbxi9UA/dMjxKk
X-Received: by 2002:a05:600c:1d29:b0:490:50eb:b777 with SMTP id
 5b1f17b1804b1-490c2597822mr45584565e9.5.1780654265613; 
 Fri, 05 Jun 2026 03:11:05 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39def5sm134843295e9.5.2026.06.05.03.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 03:11:05 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: always emit the job vm fence
Date: Fri, 05 Jun 2026 12:11:04 +0200
Message-ID: <5051245.OV4Wx5bFTl@timur-max>
In-Reply-To: <9cc1c11a-ffbd-4b33-9608-111ba12bed1d@amd.com>
References: <20260603194535.2371150-1-alexander.deucher@amd.com>
 <9cc1c11a-ffbd-4b33-9608-111ba12bed1d@amd.com>
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

On 2026. j=C3=BAnius 5., p=C3=A9ntek 11:24:45 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 6/3/26 21:45, Alex Deucher wrote:
> > We need the fence to reemit the gds switch or spm update
> > after a queue reset.
> >=20
> > Fixes: a17ef941212b ("drm/amdgpu: rework ring reset backup and reemit v=
9")
> > Cc: timur.kristof@gmail.com
> > Cc: christian.koenig@amd.com
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> That was avoided because it means another entry in the EOP ring buffer wh=
ich
> can be bad for performance.
>=20
> But correctness is obviously more important, just to keep in mind when we
> suddenly see 1% fps decrease and don't know where it's coming from.
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks Christian, that's a valid point.
Do you think we should worry about an actual perf impact here?

If we want to avoid adding an extra fence, then an alternative solution cou=
ld=20
be to include the emitted commands in the ib_wptr of the job's own fence wh=
en=20
a VM fence was not emitted.

What do you guys think?

Thanks,
Timur

>=20
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
> > 2f3470208829e..7e0e2281719b1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -853,12 +853,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring,
> > struct amdgpu_job *job,>=20
> >  					    job->oa_size);
> >  =09
> >  	}
> >=20
> > -	if (vm_flush_needed || pasid_mapping_needed ||=20
cleaner_shader_needed) {
> > -		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> > -		fence =3D &job->hw_vm_fence->base;
> > -		/* get a ref for the job */
> > -		dma_fence_get(fence);
> > -	}
> > +	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> > +	fence =3D &job->hw_vm_fence->base;
> > +	/* get a ref for the job */
> > +	dma_fence_get(fence);
> >=20
> >  	if (vm_flush_needed) {
> >  =09
> >  		mutex_lock(&id_mgr->lock);




