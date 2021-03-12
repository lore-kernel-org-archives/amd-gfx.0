Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B57BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 18:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994CB64DEC
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 18:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994CB64DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531F66E235;
	Fri, 12 Mar 2021 18:35:25 +0000 (UTC)
X-Greylist: delayed 697 seconds by postgrey-1.36 at gabe;
 Fri, 12 Mar 2021 18:26:57 UTC
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4366E5AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 18:26:57 +0000 (UTC)
Received: from zn.tnic (p200300ec2f09530069bf3b114cad3bdc.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f09:5300:69bf:3b11:4cad:3bdc])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B65C1EC046C;
 Fri, 12 Mar 2021 19:26:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1615573616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=0NLLFaOfDBcU+Z/lo+5uOJvhFOGul6fIx8p8zXWhzMY=;
 b=XVi46yLcjUEYhsSD4LNUAePLsKfRybnWr9/dVgM/EHHapADbPkXZ/4KysPA7E1T4NeF0eZ
 18JKFAYa6krp4nkawgAbyuF58aPqBUImdcyLC5AM2JjK6lxFQTpNu/wbDbLSvjZoACJ/wL
 cw8emlTOvhUTnZLoX2aT6EuzSlKaDFY=
Date: Fri, 12 Mar 2021 19:26:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amdgpu, WARNING: CPU: 12 PID: 389 at
 arch/x86/kernel/fpu/core.c:129 kernel_fpu_begin_mask+0xd5/0x100
Message-ID: <20210312182654.GD22098@zn.tnic>
References: <20210312181511.GC22098@zn.tnic>
 <MN2PR12MB4488E771571F247B1E3ECEF3F76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488E771571F247B1E3ECEF3F76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Fri, 12 Mar 2021 18:35:24 +0000
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, x86-ml <x86@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 12, 2021 at 06:20:25PM +0000, Deucher, Alexander wrote:
> Should be fixed with these patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15e8b95d5f7509e0b09289be8c422c459c9f0412
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=680174cfd1e1cea70a8f30ccb44d8fbdf996018e

Looks like it. Lemme know if I should run them explicitly now or
alternatively, I'll wait until they land in -rc3. They'll get tested
eventually as that machine is a test box...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
