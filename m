Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208FC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 13:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BD62076A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PJLM8Zj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BD62076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47926E332;
	Mon, 15 Jun 2020 13:20:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E6D89CDF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 07:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IFIgfCZKxYBKxbJqOaOomXVh77FtYCcmEiPni2KP6UA=; b=PJLM8Zj6g6NZ+vPpv2mFDxYEVR
 ZjwG4jOU060O8kA/hZ3nBzvV0Ys1Ob067i4BJAzLXk0kJFvnTPk9HZv2N4bq1zlOx6kt6I0wYqNYD
 WxXEU7shn6V1Hnnc7bMPriYIGQJxK6my2wENuYqexpKzud2otelfOGiVZI8ThFKaGsZx3wAkFAehx
 xyuZg+PiJgIGmBooQprqIC07vu+0si6nXsW+gBniM0mtgDy0EY4XX2SW3mvm3WDBh0Zyo6E43wWXf
 h7zkeOgMVO5U0sw55sa+N7+9CXGuXOBfv7vXirugectMtOB6P+FPq3eo1CWbJiozbXhA4ITyj/cH5
 ElEiN+6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkjua-0001C1-5z; Mon, 15 Jun 2020 07:52:08 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2710307458;
 Mon, 15 Jun 2020 09:52:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id EF23021059BE4; Mon, 15 Jun 2020 09:52:02 +0200 (CEST)
Date: Mon, 15 Jun 2020 09:52:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 00/12] x86: tag application address space for devices
Message-ID: <20200615075202.GI2497@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
X-Mailman-Approved-At: Mon, 15 Jun 2020 13:20:59 +0000
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
Cc: Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 12, 2020 at 05:41:21PM -0700, Fenghua Yu wrote:

> This series only provides simple and basic support for ENQCMD and the MSR:
> 1. Clean up type definitions (patch 1-3). These patches can be in a
>    separate series.
>    - Define "pasid" as "unsigned int" consistently (patch 1 and 2).
>    - Define "flags" as "unsigned int"
> 2. Explain different various technical terms used in the series (patch 4).
> 3. Enumerate support for ENQCMD in the processor (patch 5).
> 4. Handle FPU PASID state and the MSR during context switch (patches 6-7).
> 5. Define "pasid" in mm_struct (patch 8).
> 5. Clear PASID state for new mm and forked and cloned thread (patch 9-10).
> 6. Allocate and free PASID for a process (patch 11).
> 7. Fix up the PASID MSR in #GP handler when one thread in a process
>    executes ENQCMD for the first time (patches 12).

If this is per mm, should not switch_mm() update the MSR ? I'm not
seeing that, nor do I see it explained why not.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
