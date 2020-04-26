Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B4EC55199
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 07:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947D22072D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 07:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947D22072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9C289F03;
	Mon, 27 Apr 2020 07:25:31 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0044.hostedemail.com
 [216.40.44.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E816E055;
 Sun, 26 Apr 2020 17:53:10 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id 69AA75DE1;
 Sun, 26 Apr 2020 17:53:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: eye08_558d5011d7757
X-Filterd-Recvd-Size: 2129
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Sun, 26 Apr 2020 17:53:07 +0000 (UTC)
Message-ID: <ae65a955251bd43ac71b7a162320bbc1fe220a67.camel@perches.com>
Subject: Re: [PATCH] drm/radeon: cleanup coding style a bit
From: Joe Perches <joe@perches.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Bernard
 Zhao <bernard@vivo.com>, Alex Deucher <alexander.deucher@amd.com>, "David
 (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Sun, 26 Apr 2020 10:53:06 -0700
In-Reply-To: <2c67e29b-df17-6ae3-cb55-af950acc022c@amd.com>
References: <20200426131244.22293-1-bernard@vivo.com>
 <2c67e29b-df17-6ae3-cb55-af950acc022c@amd.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 27 Apr 2020 07:25:30 +0000
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
Cc: opensource.kernel@vivo.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, 2020-04-26 at 15:18 +0200, Christian K=F6nig wrote:
> Am 26.04.20 um 15:12 schrieb Bernard Zhao:
> > Maybe no need to check ws before kmalloc, kmalloc will check
> > itself, kmalloc`s logic is if ptr is NULL, kmalloc will just
> > return
> > =

> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
> =

> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> =

> I'm wondering why the automated scripts haven't found that one before.

because this pattern is

	if (foo)
		kfree(bar);

and the pattern looked for is:

	if (foo)
		kfree(foo);

> > diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/ato=
m.c
[]
> > @@ -1211,8 +1211,7 @@ static int atom_execute_table_locked(struct atom_=
context *ctx, int index, uint32
> >   	SDEBUG("<<\n");
> >   =

> >   free:
> > -	if (ws)
> > -		kfree(ectx.ws);
> > +	kfree(ectx.ws);
> >   	return ret;
> >   }

I'm wondering if this removal is correct as the function
is named _locked and it may be recursive or called under
some external lock.


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
