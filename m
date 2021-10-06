Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA456C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 13:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0E461151
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 13:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C0E461151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D468D6E505;
	Wed,  6 Oct 2021 13:47:23 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B676E505
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 13:46:50 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0d3600bd612f435519a27c.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0d:3600:bd61:2f43:5519:a27c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FD411EC04BF;
 Wed,  6 Oct 2021 15:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1633528009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=tzik7tIsVu7/8H5H0YintX63qe5jAGmz+E84DZeaw4M=;
 b=jvM/oQeKcdOqtzSg35cEv0v3qA9MCZhFpgxQF3Oic1X+xNi8zFUmT+ShQqL9eobf6PCi8f
 UgEtiYZm1Z72djtQUO4g0M9CBrrRvAdB3J412Db7gi9YVQFWoNpXOQeWrMhYQD4fsoBTLm
 82jp5sGBkCz2j/lVrk3ImlvqGyD1CIg=
Date: Wed, 6 Oct 2021 15:46:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
Message-ID: <YV2oxBw4I4kizvhF@zn.tnic>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
X-Mailman-Approved-At: Wed, 06 Oct 2021 13:47:23 +0000
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

On Wed, Oct 06, 2021 at 09:23:22AM -0400, Alex Deucher wrote:
> There could be some OEM systems that disable the IOMMU on the platform
> and don't provide a switch in the bios to enable it.  The GPU driver
> will still work in that case, it will just not be able to enable KFD
> support for ROCm compute.  SME won't work for most devices in that
> case however since most devices have a DMA mask too small to handle
> the C bit for encryption.  SME should be dependent on IOMMU being
> enabled.

Yeah, I'd let you hash this out with Tom.

> I'm not an SME expert, but I thought that that was already the case.

Yeah, I think Paul wants this:

---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b79e88ee6627..e94c2df7a043 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1518,7 +1518,6 @@ config AMD_MEM_ENCRYPT
 
 config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 	bool "Activate AMD Secure Memory Encryption (SME) by default"
-	default y
 	depends on AMD_MEM_ENCRYPT
 	help
 	  Say yes to have system memory encrypted by default if running on

---

The reason we did this is so that you don't want to supply
mem_encrypt=on on the cmdline but didn't anticipate any such fun with
some devices.

> We just added the error condition in the GPU driver to prevent the
> driver from loading when the user forced SME on.  IIRC, there were
> users that cared more about SME than graphics support.

Well, it's a distro kernel so we should at least try to make everyone
happy. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
