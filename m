Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A297C3064E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 15:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF6410E4E5;
	Thu, 17 Aug 2023 15:28:25 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277CF10E4E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 15:28:24 +0000 (UTC)
Date: Thu, 17 Aug 2023 15:28:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1692286101; x=1692545301;
 bh=TtAvhOccHc8TptAonDOSJ/c0ZyEbNsGOkkTQLCdIgTQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FR06icJb8JEOT/25OctnpT5Ab3KvdPBlCSX1ecb1Hrp/i/TXfaDZkv1Xyj9R/rOik
 dHwoWkkHBuiVOEXeznjbxgB9iAT4gx/rOij6eNGJ358m72BbiWgUm21VUqQhKPfhnZ
 opK+RAv1xiueJWe6LruChg2kP5E8x+s3CuAW/cZYrfh57jhtnx1YCKMr9G3XtoqSZE
 gwXqrZV4+7dduvon+Q2TkC9F8noYT96UpoR42/U9V3DRtpUaNAajEBPrCR89rWQNju
 4SY/FUi1diJUlkNpqV/KyY6INnjTlSzHP6Rl/7/HhpvH+mv3v5hwLbzhEMfYGf+MaX
 e/gsqg0FfKw8w==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3 3/4] amd/display: add cursor rotation check
Message-ID: <3vaMbcHwqmT8fddgMMK9iI-NwUD-TTvvOBjHineolMYXr1Ohb1_XCvj5_-90DlR5L5h9wFb_wHdoRHSNUBlOwQ8v8mx_eNg4tP9cGfC_Ruk=@emersion.fr>
In-Reply-To: <9311891d-bc3e-407b-aab4-4bad1679f5e8@amd.com>
References: <20230817105251.103228-1-contact@emersion.fr>
 <20230817105251.103228-4-contact@emersion.fr>
 <13e88b5a-9db5-4a21-97ae-3bdc910456dd@amd.com>
 <9311891d-bc3e-407b-aab4-4bad1679f5e8@amd.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thursday, August 17th, 2023 at 15:46, Harry Wentland <harry.wentland@amd=
.com> wrote:

> On 2023-08-17 09:44, Harry Wentland wrote:
>=20
> > On 2023-08-17 06:53, Simon Ser wrote:
> >=20
> > > The commit 1347385fe187 ("drm/amd/display: don't expose rotation
> > > prop for cursor plane") removed the rotation property for the
> > > cursor plane, assuming the cursor would always be displayed without
> > > any rotation. However the rotation is inherited from the underlying
> > > plane.
> > >=20
> > > As a result, if the primary plane is rotated, then the cursor plane
> > > will incorrectly be rotated as well even though it doesn't have a
> > > rotation property.
> > >=20
> > > To fix this, check that the underlying plane isn't rotated.
> >=20
> > HW cursor works with a rotated screen on KDE on AMD HW. This
> > looks like it will break that.
>=20
> Sorry, scrap that. KDE seems to do a SW rotation with HW cursor.

Actually, you're right still: I've tested again with a rotate-90 primary
plane and a cursor plane via the tentative tool, and the cursor FB is
not rotated.

So please, disregard this patch and the next one.
