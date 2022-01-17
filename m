Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB8DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 14:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E6710E2E3;
	Mon, 17 Jan 2022 14:07:23 +0000 (UTC)
X-Greylist: delayed 156163 seconds by postgrey-1.36 at gabe;
 Mon, 17 Jan 2022 11:34:49 UTC
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A2610E195
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 11:34:49 +0000 (UTC)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de
 [88.67.202.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA87B1EC0104;
 Mon, 17 Jan 2022 12:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1642419282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdcuEG1Gr/C1crhdDvpS00+4TPZUV4gG5WmT4+oXrxQ=;
 b=MTFXhkyb6R3yPci8MJqkHyLCtStkHhErcjUfs8dkehjlwUdpHbf7fJ7vAaKQ0u3a32YTnI
 U7Eyp7IqraqpWo0bKXitG6PLA/I7w2waO5KSYXOb7nKNJBJY4iLJ0NHza8XNUipQgYE3Je
 Tp/faWgrAQagBH7QBNke/qAIH9s3Gm0=
Date: Mon, 17 Jan 2022 12:34:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/radeon: fix error handling in radeon_driver_open_kms
Message-ID: <YeVUVB2AppIQSRMZ@zn.tnic>
References: <20220117093848.1884-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117093848.1884-1-christian.koenig@amd.com>
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
Cc: arthur.marsh@internode.on.net, jstancek@redhat.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 17, 2022 at 10:38:48AM +0100, Christian König wrote:
> The return value was never initialized so the cleanup code executed when
> it isn't even necessary.
> 
> Just add proper error handling.
> 
> Fixes: 2ad5d8fca195 ("drm/radeon/radeon_kms: Fix a NULL pointer dereference in radeon_driver_open_kms()")
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_kms.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Looks good, box boots fine with it.

Tested-by: Borislav Petkov <bp@suse.de>

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
