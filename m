Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB43C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 13:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66F960C41
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 13:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A66F960C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397486E4AD;
	Mon, 11 Oct 2021 13:14:17 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D298989DB9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 13:11:21 +0000 (UTC)
Received: from zn.tnic (p200300ec2f08bb00608dded251e09f1b.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:bb00:608d:ded2:51e0:9f1b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 839701EC01B7;
 Mon, 11 Oct 2021 15:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1633957878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=14wVWak4eZ+r5Y5NK1cPANN9bVrXIaHrRP9j8eIgMpU=;
 b=niSn4qv+1tXL/9b8zIyEWOa69LRZl5388zjrVW1KIi0IyLXbfbtWdWm/qqmKugh3AVcm7R
 XCdJ1Qoi6gI/FOnAEQ2unUXCxU9njtrJqAFsZ9e+ij88POX4RUMLSdNZBTaouNpxln/5K/
 5txuz20lPJhGfieewOjGq2ITPH77F3w=
Date: Mon, 11 Oct 2021 15:11:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
Message-ID: <YWQ3963xcO3xbFo5@zn.tnic>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com>
 <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
X-Mailman-Approved-At: Mon, 11 Oct 2021 13:14:16 +0000
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

On Mon, Oct 11, 2021 at 03:05:33PM +0200, Paul Menzel wrote:
> I think, the IOMMU is enabled on the MSI B350M MORTAR, but otherwise, yes
> this looks fine. The help text could also be updated to mention problems
> with AMD Raven devices.

This is not only about Raven GPUs but, as Alex explained, pretty much
about every device which doesn't support a 48 bit DMA mask. I'll expand
that aspect in the changelog.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
