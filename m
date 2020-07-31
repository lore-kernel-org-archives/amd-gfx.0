Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD897C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 23:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B3C20829
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 23:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfNbFwK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B3C20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0706E0FB;
	Fri, 31 Jul 2020 23:34:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643576E0FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 23:34:25 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E05DB22D01
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 23:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596238465;
 bh=ITLemeA+7bIT0Gyumefb19FaUYhRK8aANpWoBIk24ak=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CfNbFwK7qwd6ihXuy0P5hsUYKewJA+WywPHNtuX1iDnsKCes6sJRAXaN4WbBs4zJK
 wfa4XzM82M0KJeNi9qCShk6aEiOx7uDAaj4gFhFFYFwenB13doT7bSaGn6EFDigZSQ
 6DL3GXweZwCO+CyAh/ZPQ+T51kipBMbyP6LeXCPQ=
Received: by mail-wm1-f51.google.com with SMTP id p14so9757775wmg.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 16:34:24 -0700 (PDT)
X-Gm-Message-State: AOAM533ootwTdG/wC6suMdD819AErE1yVIzvtrlcpgA52lNWHShNWquC
 s28ZPTuY+11GTIqtp1eLBrZjjNngJNS+eLdTaYWdog==
X-Google-Smtp-Source: ABdhPJwHRJFpNjV4x8D1GMUC1YCOqAimw3vWn2FV0L8VSZMCzBymUACLIz90Tn5KcszLgZJWFdAUcRlC6fy1hhSBmbk=
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr948983wmf.49.1596238462535;
 Fri, 31 Jul 2020 16:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 31 Jul 2020 16:34:11 -0700
X-Gmail-Original-Message-ID: <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
Message-ID: <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
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
>
> Decoding the user instruction is ugly and sets a bad architecture
> precedent. It may not function if the faulting instruction is modified
> after #GP.
>
> Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
> without a valid PASID value programmed. #GP error codes are 16 bits and all
> 16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
> choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
> when loading from the source operand, so its not fully comprehending all
> the reasons. Rather than special case the ENQCMD, in future Intel may
> choose a different fault mechanism for such cases if recovery is needed on
> #GP.

Decoding the user instruction is ugly and sets a bad architecture
precedent, but we already do it in #GP for UMIP.  So I'm unconvinced.

Memo to Intel, though: you REALLY need to start thinking about what
the heck an OS is supposed to do with all these new faults you're
coming up with.  The new #NM for TILE is utterly nonsensical.  Sure,
it works for an OS that does not use CR0.TS and as long as no one
tries to extend the same mechanism for some new optional piece of
state, but as soon as Intel tries to use the same mechanism for
anything else, it falls apart.

Please do better.

> +
> +/*
> + * Write the current task's PASID MSR/state. This is called only when PASID
> + * is enabled.
> + */
> +static void fpu__pasid_write(u32 pasid)
> +{
> +       u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> +
> +       fpregs_lock();
> +
> +       /*
> +        * If the MSR is active and owned by the current task's FPU, it can
> +        * be directly written.
> +        *
> +        * Otherwise, write the fpstate.
> +        */
> +       if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +               wrmsrl(MSR_IA32_PASID, msr_val);
> +       } else {
> +               struct ia32_pasid_state *ppasid_state;
> +
> +               ppasid_state = get_xsave_addr(&current->thread.fpu.state.xsave,
> +                                             XFEATURE_PASID);
> +               /*
> +                * ppasid_state shouldn't be NULL because XFEATURE_PASID
> +                * is enabled.
> +                */
> +               WARN_ON_ONCE(!ppasid_state);
> +               ppasid_state->pasid = msr_val;

WARN instead of BUG is nice, but you'll immediate oops if this fails.
How about:

if (!WARN_ON_ONCE(!ppasid_state))
  ppasid_state->pasid = msr_val;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
