Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A536CA1015
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 13:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281E810E87D;
	Wed,  3 Sep 2025 13:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.b="TWawbMf1";
	dkim-atps=neutral
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C524E10E1E8;
 Tue,  2 Sep 2025 18:37:39 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6EF2340E01C9; 
 Tue,  2 Sep 2025 18:37:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id i4uTVl8a0PKQ; Tue,  2 Sep 2025 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1756838252; bh=RTRfd7zofb3PyMli/Euz+uhWWmQAjhsGgILAjsKlJ0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TWawbMf18i5u5MtOtR6SOLwpkPRE+ctEIzWYobBNSKiJVb2YSyGdT7V+zWZlTVW0F
 3DlxUGmbrGlT2AHxos6UuTrTiFvCH5bJRIT6rhWQaEqYZRsCCGAqWAYchQyOpwynSC
 z4KNgIpNzfHySYnPkpFa8p+wW69Hr0Tpaj/fAR8LsxbYn2txgA4eshS/rPerDDtvYl
 dZfNlYem7ayDtZP+lH1PUSShjqYKp/WkbikW0CM0Erh/P3A0FJHwMMY3YvAA9/rtTO
 Hs5+K3Lt7Lt665OgbiIwZ3A/PPaHIyK5L5OXqCD2PFdPQ5g0KD2r3hetUh4gyLds3b
 UOcyrkodcVrhzjYTzcTb/Ik5cGKm++dvFej7tP5yZHtMkWGphBzXdXauBrZJShsSOa
 BFhDJ48G/JAyRXHHpjr6woxJyekPB/1MLKc9gojZ9IUJx2MMy1FBxNReT3rgvHTZRx
 4zJIqzt0YhjFLqc40FL4DxLm20p6VOhlm87KucGIy8HINUeLK70rLFI4U0jJkolSXa
 qFkOV3iUz0X+1vexTlyEJGbAudT0JYBLDMJosjzp2HSnRAPstKPUkxps99DzQVZW7R
 YEvdVp8iYoQQ8hvQPh3dnTNG/xu16P+zpnvhVhzC5Fav3Y246yWZCekDFzEwsBVAVU
 HUD+fZChyV8VABdc7fhatVjw=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id
 993B440E01AC; Tue,  2 Sep 2025 18:37:29 +0000 (UTC)
Date: Tue, 2 Sep 2025 20:37:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/radeon: use dev_warn_once() in CS parsers
Message-ID: <20250902183721.GHaLc5YbyeypFWJePU@fat_crate.local>
References: <20250902165332.2388864-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902165332.2388864-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Wed, 03 Sep 2025 13:20:17 +0000
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

On Tue, Sep 02, 2025 at 12:53:32PM -0400, Alex Deucher wrote:
> Older GPUs did not support memory protection, so the kernel
> driver would validate the command submissions (CS) from userspace
> to avoid the GPU accessing any memory it shouldn't.
> 
> Change any error messages in that validatio to dev_warn_once() to

validation

> avoid spamming the kernel log in the event of a bad CS.  If users
> see any of these messages they should report them to the user space
> component, which in most cases is mesa
> (https://gitlab.freedesktop.org/mesa/mesa/-/issues).
> 
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
