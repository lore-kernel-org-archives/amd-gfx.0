Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5BAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 15:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF53210EA05;
	Fri, 14 Jan 2022 15:52:56 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C8810EA05
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 15:52:56 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com
 [188.165.51.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4Jb5D43XdQz4x0Dw
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 15:43:00 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="m5aL4UXJ"
Date: Fri, 14 Jan 2022 15:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1642174975;
 bh=EDKmMDpJ4aF8Jp9f8mriWffkkG6VIvSJs4wR/AP+ggA=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:From:To:Cc;
 b=m5aL4UXJkpjG0FRD9uFetuEs+xpH+kXIMKqxUSkXtD9HMRy8geRSGttKTRj9N6qHf
 sUfn1Sip08X5dbDnVeC3bHDbv0dIsUXfFMs70iR6N1s+DPNEQCS1S1IPJny7HNDnz0
 CbgAp5WmoKrU2W2dF20PQYvmFTHaYgx9S+o4NP/suE1AAOnoZ5la2zx3F1sjzzBIYL
 mNTPnhJK7tzj0E6324hNyzhxEnE42IUE6Y2ORoHzfZs0zze3CVghcaxDAiDfrtt38M
 K442F2rVZkm8DcV0ikY1XLCz3MMuc5av/OizhUhgJRh2Lm/6RcHyIWgMiniuxCcIz5
 ZqRULRIgThSXg==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [RFC PATCH v3 2/3] drm: add support modifiers for drivers whose
 planes only support linear layout
Message-ID: <HlAWH76EJyftP63YJq3RteG0352axOjZgfftI2FwvQSapuSXn_sN1j3XhBXcql0GZbLe4YTQ5KO0R-TdtBC-SUCf8Br6j__CoU5GpT9ln8g=@emersion.fr>
In-Reply-To: <YeGUIYK3hYo7wLJt@smile.fi.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-3-etom@igel.co.jp>
 <YeGFugZvwbF7l2I/@smile.fi.intel.com>
 <7eljcd3F4aWL2jjBRwr3DISmyt0XPWFIH1_kebFGqZTJXLZRx0bm_8c8yaIuEuH8rS0MaJhU6SY1y-fc6U_zCLaKgoLM124nZpr0H91nSjw=@emersion.fr>
 <YeGUIYK3hYo7wLJt@smile.fi.intel.com>
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Daniel Stone <daniel@fooishbar.org>, Lee Jones <lee.jones@linaro.org>,
 Tomohito Esaki <etom@igel.co.jp>, Rob Clark <robdclark@chromium.org>,
 Takanari Hayama <taki@igel.co.jp>, amd-gfx@lists.freedesktop.org,
 Ben Skeggs <bskeggs@redhat.com>, Petr Mladek <pmladek@suse.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <abhinavk@codeaurora.org>,
 Alex Deucher <alexander.deucher@amd.com>, Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Evan Quan <evan.quan@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Damian Hobson-Garcia <dhobsong@igel.co.jp>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Friday, January 14th, 2022 at 16:17, Andy Shevchenko <andriy.shevchenko@=
linux.intel.com> wrote:

> On Fri, Jan 14, 2022 at 03:07:21PM +0000, Simon Ser wrote:
> > On Friday, January 14th, 2022 at 15:16, Andy Shevchenko <andriy.shevche=
nko@linux.intel.com> wrote:
> >
> > > Why not enum?
> >
> > There is no enum for DRM format modifiers.
>
> I'm not sure how this prevents to use enum in the code instead of const u=
64.
> Any specific reason for that?

I'm not sure how one would use an enum as the array item type, when there i=
s no
defined enum type.

Moreover, all the rest of DRM uses uint64 for modifiers.
