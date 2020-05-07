Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA38C47257
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 07:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F78208CA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 07:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F78208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14BF6E934;
	Thu,  7 May 2020 07:05:29 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0246.hostedemail.com
 [216.40.44.246])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82056E91D;
 Thu,  7 May 2020 06:55:35 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id 643B412F5C;
 Thu,  7 May 2020 06:55:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mass87_4d4fdba8e3930
X-Filterd-Recvd-Size: 2187
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf08.hostedemail.com (Postfix) with ESMTPA;
 Thu,  7 May 2020 06:55:31 +0000 (UTC)
Message-ID: <777550697e44478c46768db5265dcdda094932f4.camel@perches.com>
Subject: Re: [PATCH] drm/amdgpu: allocate large structures dynamically
From: Joe Perches <joe@perches.com>
To: christian.koenig@amd.com, Arnd Bergmann <arnd@arndb.de>, Alex Deucher
 <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Hawking
 Zhang <Hawking.Zhang@amd.com>,  John Clements <john.clements@amd.com>
Date: Wed, 06 May 2020 23:55:30 -0700
In-Reply-To: <845a2e12-538c-fb6d-db80-78e8adf1413f@gmail.com>
References: <20200505140208.284473-1-arnd@arndb.de>
 <006e29037a9314fb286a5d6d84905bce99cef6c7.camel@perches.com>
 <845a2e12-538c-fb6d-db80-78e8adf1413f@gmail.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 07 May 2020 07:05:25 +0000
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
Cc: Guchun Chen <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 2020-05-07 at 08:42 +0200, Christian K=F6nig wrote:
> Am 06.05.20 um 21:01 schrieb Joe Perches:
[]
> > And trivia:
> > =

> > The !! uses with bool seem unnecessary and it's probably better
> > to make amdgpu_ras_is_feature_enabled to return bool.
[]
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
[]
> > @@ -560,7 +560,7 @@ static int __amdgpu_ras_feature_enable(struct amdgp=
u_device *adev,
> >   	 */
> >   	if (!amdgpu_ras_is_feature_allowed(adev, head))
> >   		return 0;
> > -	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
> > +	if (!(enable ^ amdgpu_ras_is_feature_enabled(adev, head)))
> =

> And while we are at improving coding style I think that writing this as =

> "if (enabled =3D=3D amdgpu_ras_is_feature_enabled(adev, head))" would be =

> much more readable.

<blink, chuckle> that's decidedly true...


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
