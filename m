Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C81AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 14:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5EB810E300;
	Mon, 17 Jan 2022 14:07:24 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A2410E173
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 11:21:22 +0000 (UTC)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de
 [88.67.202.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FFEB1EC0104;
 Mon, 17 Jan 2022 12:21:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1642418476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeV65Fz664fmTImlJb8/LzFUK3RXVfK/m1eYkH8q78I=;
 b=eAHKJdpFEB/3ycHvb0aAkErK98zCr/x1yV17FTlzbQhCfMtNGEBVCK11LrpgsAUvnRV4ee
 N8Nw6G7wyYge2QrmR9RNx0UkLtd90GU8mC9JJgsF/R6GNQXM296pqSavVc8wuZq5b/v4xE
 feMw3okU+g5JuUUBSRJ/v72Im59DkWQ=
Date: Mon, 17 Jan 2022 12:21:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: RIP: 0010:radeon_vm_fini+0x15/0x220 [radeon]
Message-ID: <YeVRMvAViydZnMGl@zn.tnic>
References: <YeLyToEyBFnQqQGB@zn.tnic>
 <1049939c-422f-787a-7481-21a2598eeedd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1049939c-422f-787a-7481-21a2598eeedd@amd.com>
X-Mailman-Approved-At: Mon, 17 Jan 2022 14:07:22 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, lkml <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 17, 2022 at 08:16:09AM +0100, Christian König wrote:
> Interesting to see that even that old stuff is still used.

Well, "used" is a stretch.

This is my way of testing on K8 as pretty much all the big K8 boxes to
which I had access to, got decommissioned so this baby is the only K8
real hw I have now. :-)

Lemme test your patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
