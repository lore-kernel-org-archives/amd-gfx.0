Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53217C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19ECB60EFE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19ECB60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79806892BD;
	Tue, 26 Oct 2021 16:08:34 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549BF892BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 16:08:33 +0000 (UTC)
Date: Tue, 26 Oct 2021 16:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1635264510;
 bh=86z5jAlQiizWxO6okXJNfa4BFrHIwdQGrnVgzjW35Gk=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=XkKcwBg3rq/YzLT3V8kF7wDOJdqIQZdoXx0F9YdPDzYxiyD+Z4CtntF3AC3MzCXUe
 aVfBl/nTNAvxOX4mUR9kzaeh6ZE3fjx8EKtcY8SkxsAzD2htO/QLmVNnGfNv6xV0i1
 w6GMQ7DZGfOa9rbHrJrNSOuxOp0HeD/KxCZgew1gQfsbbOJ5ZJOnStG+sT4VzdcHSC
 YtY2ZSwywnn2tiwVNVqRaEse+yaLivq/KVx1uJrg63kHN5gSMYIlKNQTgiEkgEHmlV
 kXSHJ68GW770OUjbPcDB+/w2a7lRYOkuJAjTeTIVlZJiXSefdAACf00By3kvZXp8a6
 65yBZqczSgDDg==
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com
Subject: Re: [PATCH] drm/amd/display: Fix error handling on waiting for
 completion
Message-ID: <P81H3ot388-2r8h9f2D4jqbP7eys1TKtvXWTwXkgEWslTv6PcsQObN_hSX6KaH_MMkhscnt4TFF6B11fqho5Yd2a3q_qS-AUog7vaaylVrA=@emersion.fr>
In-Reply-To: <b29f5d0e-a0d4-2a2c-d9ee-6e16541b9906@amd.com>
References: <20211026110740.152936-1-stylon.wang@amd.com>
 <0087f1c6-733e-4c31-63c5-c39da51138c1@daenzer.net>
 <b29f5d0e-a0d4-2a2c-d9ee-6e16541b9906@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, October 26th, 2021 at 18:03, Kazlauskas, Nicholas <nicholas.kaz=
lauskas@amd.com> wrote:

> If it's just an error in the log without a functional issue then maybe
> we should downgrade it to a debug statement in the case where it returns
> -ERESTARTSYS.
>
> If this is a functional issue (DRM not automatically retrying the
> commit?) then maybe we should take a deeper look into the IOCTL itself.

libdrm handles EINTR but not ERESTARTSYS. So, if the kernel returns ERESTAR=
TSYS
then Mutter will error out.

Should the kernel be fixed to return EINTR instead of ERESTARTSYS, or shoul=
d
libdrm be fixed to handle ERESTARTSYS?
