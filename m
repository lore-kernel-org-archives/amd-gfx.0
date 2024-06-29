Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD970C27C4F
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jun 2024 15:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B99B10E073;
	Sat, 29 Jun 2024 15:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="fIveWBJk";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3757310E18A
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jun 2024 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1719675146; x=1719934346;
 bh=ARk1CN4SNcrfhu3AqT6RA6aL1fK6aSQsAxE+h/7vxhs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=fIveWBJkSHRuccK8cvS5m9EEIOm7OhJ7/rp9IPhhkZjWp0WSdqOExdFE+mGuPkHxP
 cDBCGiR0XfY7FeY5UNf0VG2msGpfX/4bJcw3JAemv4hFre+JtpXjqk66x6mbxAINIG
 YtCb39zRvqmZTFMNcC3ko3NNGtvvLMawB+DyLvvH9NOh+l9+271W9CVR6+bOFBREho
 FdRso2Eg4Q8fA2PjhPnFni1RodWQ7zDN+ehoB4FUZpCwAqh6D3jNo4slCK+rs2wVeK
 YS68CZVR+6wz5fg8T9/alry7xsyYtXBkL/fY+J1vZgoAYwRazqsUt4kxHja+RQ37HI
 2t0pJJOyRBVQA==
Date: Sat, 29 Jun 2024 15:32:20 +0000
To: =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Pekka Paalanen <ppaalanen@gmail.com>,
 daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>,
 =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com,
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 1/1] drm/atomic: Allow userspace to use explicit sync with
 atomic async flips
Message-ID: <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
In-Reply-To: <20240622170951.738735-1-andrealmeid@igalia.com>
References: <20240622170951.738735-1-andrealmeid@igalia.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: eb194cda8e85e2e446f855a2521d5ab3ca4f3c8d
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Saturday, June 22nd, 2024 at 19:09, Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:

> Allow userspace to use explicit synchronization with atomic async flips.
> That means that the flip will wait for some hardware fence, and then
> will flip as soon as possible (async) in regard of the vblank.

LGTM.

Would you mind sending a patch for FB_DAMAGE_CLIPS as well?

Reviewed-by: Simon Ser <contact@emersion.fr>
