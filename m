Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4168EC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 11:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131B42084C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 11:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QXKYfmXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131B42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9F86E1E2;
	Tue, 14 Jul 2020 11:12:26 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776336E1E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:12:26 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z13so20867504wrw.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VJUMRju7OKuE24xgVbETEzznY9nUxSvHfkGn/7lFRJc=;
 b=QXKYfmXCGRLPUrNkOqg5GHB6w56deMXiDRBvJUKkOa99upUqSTzhOTtteoMRkPKNfw
 BtR9jMTMIiIUaUJ0o1zyHoUR6aV5iyzF6GVIhkWK2K0Glhu+cfsE2CYMNQJFaMvBaW1n
 1/BG4wF1/vDhGYbqcBNX7HfYQvgJBdCSrCWGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VJUMRju7OKuE24xgVbETEzznY9nUxSvHfkGn/7lFRJc=;
 b=Yi5yAmmsbUlinb2kpBCAjCtO87S6OVzAr8GlRTu0uurfxZDkQW+BHIw8+62l03HK0m
 uXjiTy3dfq5fd5DK6rdqZnO9FZvD/SUxr2uabiHAuit7sfcuNzC1Lfxr7zWzJV7nt5hz
 ZsbIqwaW7aHEO7fNzKOWEbxezz4llaIA/yyq6h9QZvgTrEuKvdT7Ppj8N23rEZJSTUpI
 yLvwTt38etS6D14idmhy9fl8wFL5300G0y/2waIcFy+CtHeJq0qj6nyg9JgJgkpnat9q
 j8IfzKxrzvl63wH+y4HT8TggtpvGZaXXpr/17VMREArl9y5vCa9RVrfJgfcYoL8N9tK+
 T4mg==
X-Gm-Message-State: AOAM533psqhblqVz7NBBeu81AOCw+kWqYtHFRdzc0ToxkZKZxZ3TqEXm
 nY3/RsC+IqW9esb8kyS/SvxpmQ==
X-Google-Smtp-Source: ABdhPJz5Pus9C7QZEyzkJv8l+/+SFrBsdEtrmB/rDpt1sctjAKSgOKT85PdH59/MA9EocwuEPu+DYA==
X-Received: by 2002:adf:f542:: with SMTP id j2mr4633600wrp.61.1594725145156;
 Tue, 14 Jul 2020 04:12:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l1sm29243097wrb.12.2020.07.14.04.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 04:12:24 -0700 (PDT)
Date: Tue, 14 Jul 2020 13:12:22 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 20/25] drm/amdgpu: DC also loves to allocate stuff where
 it shouldn't
Message-ID: <20200714111222.GE3278063@phenom.ffwll.local>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-21-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707201229.472834-21-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 linaro-mm-sig@lists.linaro.org, Daniel Vetter <daniel.vetter@intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 07, 2020 at 10:12:24PM +0200, Daniel Vetter wrote:
> Not going to bother with a complete&pretty commit message, just
> offending backtrace:
> =

>         kvmalloc_node+0x47/0x80
>         dc_create_state+0x1f/0x60 [amdgpu]
>         dc_commit_state+0xcb/0x9b0 [amdgpu]
>         amdgpu_dm_atomic_commit_tail+0xd31/0x2010 [amdgpu]
>         commit_tail+0xa4/0x140 [drm_kms_helper]
>         drm_atomic_helper_commit+0x152/0x180 [drm_kms_helper]
>         drm_client_modeset_commit_atomic+0x1ea/0x250 [drm]
>         drm_client_modeset_commit_locked+0x55/0x190 [drm]
>         drm_client_modeset_commit+0x24/0x40 [drm]
> =

> v2: Found more in DC code, I'm just going to pile them all up.
> =

> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Anyone from amdgpu DC team started to look into this and the subsequent
patches in DC? Note that the last one isn't needed anymore because it's
now fix in upstream with

commit cdaae8371aa9d4ea1648a299b1a75946b9556944
Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Date:   Mon May 11 14:21:17 2020 -0400

    drm/amd/display: Handle GPU reset for DC block

But that patch has a ton of memory allocations in the reset path now, so
you just replaced one deadlock with another one ...

Note that since amdgpu has it's private atomic_commit_tail implemenation
this won't hold up the generic atomic annotations, but I think it will
hold up the tdr annotations at least. Plus would be nice to fix this
somehow.
-Daniel

> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c                 | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c          | 4 +++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 4cfc786699c7..1b0c674fab25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1226,7 +1226,7 @@ static int amdgpu_atom_execute_table_locked(struct =
atom_context *ctx, int index,
>  	ectx.abort =3D false;
>  	ectx.last_jump =3D 0;
>  	if (ws)
> -		ectx.ws =3D kcalloc(4, ws, GFP_KERNEL);
> +		ectx.ws =3D kcalloc(4, ws, GFP_ATOMIC);
>  	else
>  		ectx.ws =3D NULL;
>  =

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6afcc33ff846..3d41eddc7908 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6872,7 +6872,7 @@ static void amdgpu_dm_commit_planes(struct drm_atom=
ic_state *state,
>  		struct dc_stream_update stream_update;
>  	} *bundle;
>  =

> -	bundle =3D kzalloc(sizeof(*bundle), GFP_KERNEL);
> +	bundle =3D kzalloc(sizeof(*bundle), GFP_ATOMIC);
>  =

>  	if (!bundle) {
>  		dm_error("Failed to allocate update bundle\n");
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 942ceb0f6383..f9a58509efb2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1475,8 +1475,10 @@ bool dc_post_update_surfaces_to_stream(struct dc *=
dc)
>  =

>  struct dc_state *dc_create_state(struct dc *dc)
>  {
> +	/* No you really cant allocate random crap here this late in
> +	 * atomic_commit_tail. */
>  	struct dc_state *context =3D kvzalloc(sizeof(struct dc_state),
> -					    GFP_KERNEL);
> +					    GFP_ATOMIC);
>  =

>  	if (!context)
>  		return NULL;
> -- =

> 2.27.0
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
