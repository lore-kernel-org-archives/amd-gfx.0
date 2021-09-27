Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE234C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 13:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFAC36103B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 13:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFAC36103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3911D6E851;
	Mon, 27 Sep 2021 13:09:30 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE2BA6E851
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 13:09:29 +0000 (UTC)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com
 [51.77.79.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4HJ2z80jF0z4x1Zg
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 13:09:24 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="b9kTQ/dx"
Date: Mon, 27 Sep 2021 13:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1632748151;
 bh=BnSfJtEaCcmkJzZxduXBRRB3iYQknJfIOtJ9Knwc3Cc=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=b9kTQ/dxtXSZ79P9LMuyk0er0loPVE9lfuolCSzLF3hPSriKWoAyib/AyiaLdwrEr
 NsnYxob0XAk2/gwTH2oosr9T/8r7odShlvALlVuEN74gykcTUOaNmkp8pL6jFBsusw
 BR7aH6T4KIxzYKWK2Zttoa1gFsIM8N7t+sge383DqohumCqv/mgrr1Cey3Nga7MNZB
 +j+r+aw8hxridYetWrqpqcyUYaa97xUdjwGsRnoiQrAMcIl7GqJAEkAK4m+Ec4fgRo
 a/XDrDgNGqJdlh7ltkIUoz0N/OP3CCz/Ap63Oz7J9nOcDOEROU7jxZq1GkVx13MYw6
 WVHbF+h+ctn4w==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: Re: [PATCH] amdgpu: check tiling flags when creating FB on GFX8-
Message-ID: <Kmwa-gfuqYfkMsvvUXAaujfROLLXX4PuTRBRQ5efixoEvM3arNB_yT5eure3D1iqmnFB54wnbB87S1zBLL-79Ci7fhqoKx-M-ciPVs5fcSU=@emersion.fr>
In-Reply-To: <20210920103133.3573-1-contact@emersion.fr>
References: <20210920103133.3573-1-contact@emersion.fr>
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

Alex, Harry, Nicholas: any thoughts on this patch?
