Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 11:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D50710E171;
	Fri,  8 Apr 2022 11:48:24 +0000 (UTC)
X-Greylist: delayed 6404 seconds by postgrey-1.36 at gabe;
 Fri, 08 Apr 2022 11:48:22 UTC
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5E610E171
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 11:48:22 +0000 (UTC)
Date: Fri, 08 Apr 2022 11:48:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1649418500;
 bh=Zvbi7xqEswNRrjsp8sgXVujH0Lr0d/k1PRut6FcweZY=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID;
 b=hemnCB5PgV6MjKUqiZcXyUtavYgatU3HjzR5zjUPE3u4KXYfkBfTlt8no33INNxWW
 KJRsLOwEe1yoJ+Uqp/C3IT4LCEEhVivfaLb4HC6qOw/2vfBQm8o7WPHmhQyNdMz1nq
 vEtpdnbFTrTpiC1ZW21UpBt8M1VMBr04UGxJrailoyJmbk6zVqUIl9ast2Ae+C9ftD
 xYeibHwc1dbSsi5HSPRz1lK65BJJLVmRzrUgVRqTtnqepmz+okiM+rCiwJp36Ei21/
 Gsg9VN/SP0FqSxxoM5wndaCL9/2jEBfpVRrDft+Y3VO7+56GM5yXbZwb4Esb1SC5+d
 jpDph04eTdTDA==
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference
Message-ID: <QfKpxmkE_cy9wt5VJruw_TSdnl5KceKM8BxJGmZSBs-KiaRwIYfgc8h_-5h7Wmj6G-NtUJ3A88V5pzPvZuLlpkK-oRO5pSjeTxwHcZWlogs=@emersion.fr>
In-Reply-To: <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com>
References: <20220408092803.3188-1-h0tc0d3@gmail.com>
 <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
 <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com>
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Grigory Vasilyev <h0tc0d3@gmail.com>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@linux.ie>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Sean Paul <seanpaul@chromium.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Friday, April 8th, 2022 at 13:28, Bas Nieuwenhuizen <bas@basnieuwenhuize=
n.nl> wrote:

> On Fri, Apr 8, 2022 at 12:01 PM Simon Ser contact@emersion.fr wrote:
>
> > Is amdgpu_display_get_fb_info ever called with NULL tiling_flags/tmz_su=
rface?
> > If not, there's no point in adding NULL checks.
>
> It isn't called with NULL anywhere, the NULL checks that already exist
> seem redundant.

Grigory, would be be willing to submit a v2 which removes the unnecessary
NULL checks?
