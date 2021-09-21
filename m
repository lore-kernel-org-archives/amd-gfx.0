Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E68C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 21:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE6861165
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 21:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCE6861165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2935B6E82C;
	Tue, 21 Sep 2021 21:38:42 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64AD6E5BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 21:21:00 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id g41so3119996lfv.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GYWKxxwDs0cZgU7zoLo4TUhsJ8M50sSfexrGGa7nvK0=;
 b=6GA+nKi4dJGN5Y/djnNixBrKu6T3pljCu3U/BgzvrwouwWOron03nG2FotSmE1IvQS
 MgoEePxggSU/gxjqerZifjJ0UmN+Rpgv4VXnbx+GeN6FcHZXKGVGGXh/gwowELfGRgeB
 k1v+6RGz165vVjf8qTg9T5T2FYUEcrHSwLBk5fRy4e1eic4Bwe7QkdtvB988rBItCSlw
 5pJbiBObITlEWIumnOpwgWSOod/vvf6//SPAXj5IzXKsXsn8DowBeLy2GH+tdsAPmUH0
 ZbwUoQIW4DTzzxX46eJW+ys3iupLGzexzYNkzIcWmfRnNP3AUY1kX51pUUaEoehoA6Yb
 KPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GYWKxxwDs0cZgU7zoLo4TUhsJ8M50sSfexrGGa7nvK0=;
 b=2HqqnNRxX6T3xf9G6hW6bnTy9OmYa48tJctUm5PFxUlzBf3NxThkWomR3v5udhwxy2
 vFgt1tHEqBK/TD70ibSmO7fNnGmHfTMia9S81trxtuAnLhVBsNt22lYWWzwNgYaH6XZR
 ZdYPWbxE+C9zgrmi2pF4AsptuFzwsoJG2eqD6dQEQqyFRiGRClHVQioaI9C4QlGbRIhV
 wqhBhgg7SK9S9jtXblz0+xvM72xD7eJE4iP5pgBDDiz1QTLvVYIk2GioP5Zgz8V7TNDI
 FE4Ug3Xvl+OTJENRDmC6GlBoykrdZOfAJzwLtI0abmZOXNJbeLrfw3NrZUG8mzpdsZLs
 yA/w==
X-Gm-Message-State: AOAM533iwD1l1ArglIL8TAkrRVLjyZrgzVSXxLUpILNdYmcg1F1kdFK7
 kvfYk9TeL6Xpnsmu3hv6YtnVtg==
X-Google-Smtp-Source: ABdhPJwekUVL/x16ZZDpG4z5bQ8XnWA1mYPT1pSdbtQA7F8rIf0C+IYx6L1iOsCNob4BliQK4ObStw==
X-Received: by 2002:a2e:5009:: with SMTP id e9mr25102801ljb.245.1632259258818; 
 Tue, 21 Sep 2021 14:20:58 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id t12sm13948lfc.55.2021.09.21.14.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 14:20:58 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id 1B39910305C; Wed, 22 Sep 2021 00:20:59 +0300 (+03)
Date: Wed, 22 Sep 2021 00:20:59 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-efi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Christoph Hellwig <hch@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUoao0LlqQ6+uBrq@zn.tnic>
X-Mailman-Approved-At: Tue, 21 Sep 2021 21:38:41 +0000
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

On Tue, Sep 21, 2021 at 07:47:15PM +0200, Borislav Petkov wrote:
> On Tue, Sep 21, 2021 at 12:04:58PM -0500, Tom Lendacky wrote:
> > Looks like instrumentation during early boot. I worked with Boris offline to
> > exclude arch/x86/kernel/cc_platform.c from some of the instrumentation and
> > that allowed an allyesconfig to boot.
> 
> And here's the lineup I have so far, I'd appreciate it if ppc and s390 folks
> could run it too:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc2-cc

Still broken for me with allyesconfig.

gcc version 11.2.0 (Gentoo 11.2.0 p1)
GNU ld (Gentoo 2.37_p1 p0) 2.37

I still believe calling cc_platform_has() from __startup_64() is totally
broken as it lacks proper wrapping while accessing global variables.

I think sme_get_me_mask() has the same problem. I just happened to work
(until next compiler update).

This hack makes kernel boot again:

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index f98c76a1d16c..e9110a44bf1b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * there is no need to zero it after changing the memory encryption
 	 * attribute.
 	 */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+	if (0 && cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index eff4d19f9cb4..91638ed0b1db 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -288,7 +288,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+	if (1 || !cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/*
-- 
 Kirill A. Shutemov
