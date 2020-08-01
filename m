Return-Path: <SRS0=fd1u=BL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4CEC433DF
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Aug 2020 01:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA6422CAD
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Aug 2020 01:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyiKjd9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA6422CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F716EB52;
	Sat,  1 Aug 2020 01:28:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037226EB52
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Aug 2020 01:28:51 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9741F22D01
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Aug 2020 01:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596245330;
 bh=iEFTd5J3OaIz2CPblhNjm4HIdHFf3NTyBlaCyk5tBwc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=oyiKjd9jYrsQoTyhz9So/eaYiCUToFDRE+yR5g+YKhAtuoTBf++uEjYmgaJO0yqqO
 qnJf3bCLRvBIa7DYC2uz+LmCEDskSnC4cnYhI+4Ncll+MjqEsOQuS2Xxm8wbccwuol
 vNVp2k1dV+au0yLp8bu3hI5+0WnCXeDq9gno9e+U=
Received: by mail-wm1-f49.google.com with SMTP id t14so5528111wmi.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 18:28:50 -0700 (PDT)
X-Gm-Message-State: AOAM533vE+GZ0QPSdbYg5zH+813XyLIZHuBdlc7lJzzA+j7H+JIFXis2
 3KWaMhO98AMYeuxpczD5mEgjpT4FT+XUAU+GZCrM/g==
X-Google-Smtp-Source: ABdhPJwqMB4yU9t8y4FC7B3ExHcTCCL1w+nLeHjKE26+trC+5yOlCmBolk7+/lVqfoJLVEkj6eyrxs3QsKfB+JPQNtY=
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr5903705wmk.176.1596245328660; 
 Fri, 31 Jul 2020 18:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 31 Jul 2020 18:28:37 -0700
X-Gmail-Original-Message-ID: <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
Message-ID: <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
To: Fenghua Yu <fenghua.yu@intel.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Borislav Petkov <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> A #GP fault is generated when ENQCMD instruction is executed without
> a valid PASID value programmed in the current thread's PASID MSR. The
> #GP fault handler will initialize the MSR if a PASID has been allocated
> for this process.

Let's take a step back here.  Why are we trying to avoid IPIs?  If you
call munmap(), you IPI other CPUs running tasks in the current mm.  If
you do perf_event_open() and thus acquire RDPMC permission, you IPI
other CPUs running tasks in the current mm.  If you call modify_ldt(),
you IPI other CPUs running tasks in the current mm.  These events can
all happen more than once per process.

Now we have ENQCMD.  An mm can be assigned a PASID *once* in the model
that these patches support.  Why not just send an IPI using
essentially identical code to the LDT sync or the CR4.PCE sync?

--Andy
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
