Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD987C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 14:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3DB10E661;
	Fri, 23 Dec 2022 14:23:36 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0042A10E18A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Dec 2022 22:50:32 +0000 (UTC)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C1CC1EC0716;
 Thu, 22 Dec 2022 23:43:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1671749006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=EobdnPjjP9RlYsD52myVc5wKOjcNXd2E/KiOadx4Il4=;
 b=eiI4OnStGYAl8TpjWPiWDAmq9Ds/Ve8lc7jPdd/WYsmRcO3/wydZiRnxQ8EiF7wF5I144w
 3H7isE/gP54gqx/fPy2Cq+MACpHlaVYFVrJxMEE7Bw2+EvCNo3y6OS+t7VZZ252zC2/iLa
 rMR8CUHOAzBHQp+5fo9eyGOAh+DdHhk=
Date: Thu, 22 Dec 2022 23:43:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: amdgpu refcount saturation
Message-ID: <Y6TdiG5atyse+5De@zn.tnic>
References: <Y52tzASAKNAJEER3@zn.tnic>
 <0ac03934-27dc-e045-fece-5a4b4328de6c@amd.com>
 <20221222212037.bynlebvgt6ejehut@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222212037.bynlebvgt6ejehut@lion.mk-sys.cz>
X-Mailman-Approved-At: Fri, 23 Dec 2022 14:23:33 +0000
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
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 22, 2022 at 10:20:37PM +0100, Michal Kubecek wrote:
> Unfortunately, just like Boris, I always seem to have multiple stack
> traces tangled together.

See if this fixes it:

https://lore.kernel.org/r/20221219104718.21677-1-christian.koenig@amd.com

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
