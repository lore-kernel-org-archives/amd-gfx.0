Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20946C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 10:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A8C60FE6
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 10:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1A8C60FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A7F6E52A;
	Wed, 18 Aug 2021 10:48:55 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DEE6E52A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 10:48:53 +0000 (UTC)
Date: Wed, 18 Aug 2021 10:48:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1629283730;
 bh=Xm/qC/EsECXP+wbkovMcaJ4ROJVnhmUJKc/8yNTC4ak=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=Z5Nky+Nxo0/StQQVfdHAwfYqzQ61FXxU3F3fjjj1/N8imtvxcAn+etMMMQrUWn8GW
 5ggoo+Vl3q5xSugrITJwLPUl4dhyuwJAPPIXAY11/jrstZEKfJWVM0d0suO/l1GZBd
 on8LWeti7RARyQitLOAxyaJm0dHxLmdaEBUftsTAg+WQPnsqwZtDw68bqAbUa88gR9
 jmA1QPlrxqFnPm4m+9uhygKXWU7Ck3n8/Gr/4P2M1z8n0embyJYQnAzSRaTBetRK1s
 Mjcw5H1VQFXrp7PMWAovqwDrvUVF6kGLUOjmd+HNs369ZyGmj+I252oPEpZPvJowN8
 CbRnOgw71ClEw==
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
 Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
Message-ID: <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
In-Reply-To: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
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

Hm. This patch causes a regression for me. I was using primary + overlay
not covering the whole primary plane + cursor before. This patch breaks it.

This patch makes the overlay plane very useless for me, because the primary
plane is always under the overlay plane.

> Basically, we cannot draw the cursor at the same size and position on
> two separated pipes since it uses extra bandwidth and DML only run
> with one cursor.

I don't understand this limitation. Why would it be necessary to draw the
cursor on two separate pipes? Isn't it only necessary to draw it once on
the overlay pipe, and not draw it on the primary pipe?
