Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30987C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 14:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E256761058
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 14:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E256761058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2B96E419;
	Tue,  5 Oct 2021 14:41:59 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9656E419
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 14:39:04 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0d20008b62c5101b4e88fa.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0d:2000:8b62:c510:1b4e:88fa])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DD0D1EC0489;
 Tue,  5 Oct 2021 16:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1633444742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dBI3lASetDpNcd+YaZnzQv/73q7wDSsq3FUu+gvanQ=;
 b=lUDmpPcKn3PQ688uR08pB/MGzBROHkFehFVkZgF+sbELIf8nSsW3ghxQ65HYf1Y4hm+B4h
 bkwKarKtZ/4V2UKSHEf1sYyHmMoj2rcL7MHKo0NFKsmYhAiSoxhc+Uf/QK6bx933QFAyH0
 iNe7vnQ6D+V9FeIKkGewdkPnJQrrlgE=
Date: Tue, 5 Oct 2021 16:38:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
Message-ID: <YVxjgFScCZNwliMi@zn.tnic>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
X-Mailman-Approved-At: Tue, 05 Oct 2021 14:41:58 +0000
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

On Tue, Oct 05, 2021 at 04:29:41PM +0200, Paul Menzel wrote:
> Selecting the symbol `AMD_MEM_ENCRYPT` – as
> done in Debian 5.13.9-1~exp1 [1] – also selects
> `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT`, as it defaults to yes,

I'm assuming that "selecting" is done automatically: alldefconfig,
olddefconfig?

Because CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT only depends on
CONFIG_AMD_MEM_ENCRYPT and former can be disabled in oldconfig or
menuconfig etc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
