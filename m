Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5344C27C4F
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jun 2024 15:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4A910E083;
	Sat, 29 Jun 2024 15:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="5k00CWLy";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F0B10E1A5
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jun 2024 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1719675270; x=1719934470;
 bh=tcrv1emIiF0c9leopgU8fSqbwyVlehaFj8V97sK9GnE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=5k00CWLysWDqh4H/ioHlbfQgsuuaH575h0D5vgYr2/HcG2vTqNd8csabAx1f8lmeg
 dAgneA4gfeRcru0yBxeARxyrm/hAxMb7TPjFpHHZYk8mxcDKGsVTNskqN380Maotnq
 AsPNmCk++mFAINeHPLDwwffSZ+NFPQbZcQZDwimtiAWTSAddrVj0MM5m9gF219VMH+
 lRoA9i0T7IiVfDQTFs53Jx+/CNkrSf2Bo/gZEic3XPQws3whrdiSXROopY5wITwuqf
 yCtZWH8x6XfNjaAC5sMTt3yDMcL55NLkIH1XM45FLbythv19FWyFSDARLoIHhftbm1
 wCekgVB25I5og==
Date: Sat, 29 Jun 2024 15:34:25 +0000
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
Message-ID: <PPWhSnGWwPfxmBFtMxYf_r6jv7owTpZf43ColyQuh1tcjl9qN9lrHrYO47QVdgS2XXUeORRMlw6gNfwx67bV4MmAQ8IyKpDLe1C8UmjDcUQ=@emersion.fr>
In-Reply-To: <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
References: <20240622170951.738735-1-andrealmeid@igalia.com>
 <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 1b2e1d26fc220e1e05526e8edebce2894d8d6761
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

BTW, should we allow OUT_FENCE_PTR as well? Would that work as expected
with async flips?
