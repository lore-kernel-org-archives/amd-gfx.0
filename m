Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD6C43467
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 13:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C293F222BA
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 13:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVGWz6bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C293F222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613886ECF2;
	Fri,  9 Oct 2020 13:49:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FA46ECE4;
 Fri,  9 Oct 2020 13:49:06 +0000 (UTC)
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0304B222B9;
 Fri,  9 Oct 2020 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602251345;
 bh=wl1fuI8lefh+3YsVxao7a3dyyLNUQhlLz4oNgzuFbLc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lVGWz6bscyAd1Q327E060Iz1w2Nr7nAKiIC7kTgVLRveWqIs/oKeRRovqVDW0jBJV
 tTVFadyniJetltJn8E2xB4ij52UJMud3O6wIH21iOKxycc7XLZg+kvK9HzImLrXdU3
 3WC9lAOb/e2eKvKZWOThK0VmDWL/eqUi7NhYl1wI=
Date: Fri, 9 Oct 2020 08:54:30 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH][next] amd/amdgpu_ctx: Use struct_size() helper and
 kmalloc()
Message-ID: <20201009135430.GA31347@embeddedor>
References: <20201008143450.GA23077@embeddedor>
 <4fe00048-2612-39f3-29bb-c9424000f836@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4fe00048-2612-39f3-29bb-c9424000f836@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 09, 2020 at 09:08:51AM +0200, Christian K=F6nig wrote:
> Am 08.10.20 um 16:34 schrieb Gustavo A. R. Silva:
> > Make use of the new struct_size() helper instead of the offsetof() idio=
m.
> > Also, use kmalloc() instead of kcalloc().
> > =

> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.c
> > index c80d8339f58c..5be125f3b92a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -100,7 +100,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx=
 *ctx, u32 hw_ip,
> >   	enum drm_sched_priority priority;
> >   	int r;
> > -	entity =3D kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_j=
obs]),
> > +	entity =3D kmalloc(struct_size(entity, fences, amdgpu_sched_jobs),
> =

> NAK. You could use kzalloc() here, but kmalloc won't zero initialize the
> memory which could result in unforeseen consequences.

Oh I see.. I certainly didn't take that into account.

I'll fix that up and respin.

Thanks
--
Gustavo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
