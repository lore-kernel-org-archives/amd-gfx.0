Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5FAC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 22:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D778823108
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 22:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D778823108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DE86EB71;
	Thu, 10 Dec 2020 22:01:14 +0000 (UTC)
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08966EB6F;
 Thu, 10 Dec 2020 22:01:12 +0000 (UTC)
Date: Thu, 10 Dec 2020 22:01:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1607637670;
 bh=FmTLQjfSj2V4sIkgLBfO1ZQUi/M+NWkIe67YWDNBQuo=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=A23OApJGdY2kZ3w4Qq6w+IYE9/5+sfej7hEwUoUWHx7Pi+QSrN90KmqEnQeQ27UMo
 WD6+jdepWn3l8gKv/e10t3gGzYHMk8ddmJVq7BpmmfHh9UnSVEg9TxabVoFbu4NdcG
 RssK30ZMipm/RI0N7h0mh+pz1fVLzlc5BF3RkrOmosrq2fPNV28fmmHJWjsZFbupkJ
 WXcY+6WPl6qSq2ISyMwJEGXXHTq/s8Ad1+SR12TsNoGRmuJEdIhi0xfqJcmTlcnaCZ
 O/5ENDxCwSXUal6Oauar+7j2yf3NzLIBDqcHcNEr5ZLe5rKmMT9HTEkdV4lS1cD2uD
 EGVDsRhieFAOA==
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 0/3] Experimental freesync video mode optimization
Message-ID: <MC46k2jDYAeDTZaSlv6T5iIq5ibkh2yYwW3KZ-XLXLwoRByjkWsEr6-6eQM4iZqmkiLoleyh84S290ytAub0bK-esJje1OGKIEilcz_iikY=@emersion.fr>
In-Reply-To: <20201210184823.285415-1-aurabindo.pillai@amd.com>
References: <20201210184823.285415-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
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
Cc: stylon.wang@amd.com, thong.thai@amd.com, shashank.sharma@amd.com,
 Martin Peres <martin.peres@free.fr>, amd-gfx@lists.freedesktop.org,
 Pekka Paalanen <ppaalanen@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>, wayne.lin@amd.com,
 alexander.deucher@amd.com, Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

(CC dri-devel, Pekka and Martin who might be interested in this as well.)

On Thursday, December 10th, 2020 at 7:48 PM, Aurabindo Pillai <aurabindo.pillai@amd.com> wrote:

> This patchset enables freesync video mode usecase where the userspace
> can request a freesync compatible video mode such that switching to this
> mode does not trigger blanking.
>
> This feature is guarded by a module parameter which is disabled by
> default. Enabling this paramters adds additional modes to the driver
> modelist, and also enables the optimization to skip modeset when using
> one of these modes.

Thanks for working on this, it's an interesting feature! However I'd like to
take some time to think about the user-space API for this.

As I understand it, some new synthetic modes are added, and user-space can
perform a test-only atomic *without* ALLOW_MODESET to figure out whether it can
switch to a mode without blanking the screen.

However the exact modes amdgpu adds are just some guesses. I think it would be
great if user-space could control the min/max refresh rate values directly.
Not only this would remove the need for the kernel to hard-code "well-known
video refresh rates", but this would also enable more use-cases. For instance
some users might want to mitigate flickering on their screen by reducing the
VRR range. Some users might want to lower their screen refresh rate for power
savings.

What do you think? Would you be fine with adding min/max VRR range properties?

If you're scared about the user-space code requirement, I can provide that.

Thanks,

Simon Ser
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
