Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC0AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 13:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1EF60E8B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 13:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F1EF60E8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2746E1B8;
	Fri, 24 Sep 2021 13:11:12 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601276E1A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 09:41:32 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id i4so37971174lfv.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7QWYmDDdQ14wxTTMWtNorG+4hnmrm04qfz4ZOujDnZs=;
 b=a94RXEUJuMmQvxSDKok9kJbMV98Mo28f1Csi4Z4iwvW7+MkRyX5SrQhnYAAaonglNs
 TqzSbC141ptsWvvzM0S2r5099PgvSLUTd+llMs5cQH1O/KYv2VKwA3rHbEQ17XEUoJiN
 b88sf+8/Kq6CN5gKqNMDbt0WofHePWjCWhJfrHH/URopiQYKQJViZtb5wMUubTQfdu6m
 e490qkHKD0Pb0R4D5rMx+0JuhhDDbQUkFWETXBCjCVPYNSZnkKFRM+sk+iiLVm+sara7
 E1aPac0dVliF4TZMk0iL6yousngzwZf3UFxxtnempLUEnPswt9hwLB+6ECQ/gPgJLFvg
 u+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7QWYmDDdQ14wxTTMWtNorG+4hnmrm04qfz4ZOujDnZs=;
 b=s/pSgPXRP6i3HayiGNcfaE8a3WQc8GLV/9YEX9ITDnDU6hb8IM9WrZ/9u7Jsx35b4q
 IHysb3YWiOMPWogaJDjBS1HXnUHV0viwg7RMZ3kgWjS1xMyfpYbghVUAfbIFuIYJH955
 m9YDHQjk5TKI8dL88gszNqMHcidOFbCEkl95NfF0dcK0pla+LWCbXVWer533eJIZjS1/
 esEWDxtbFcAcwT4WCTgAfh8R/DBMix+dVk9lZAt9kkBwd2mrIL7WjvJCq6EGZPNpcDXm
 KJ6xfsnE++3vJjLZpAzjDtdKOZINFDRQviIaqZRCqpIIiKD5DkO943kdyRmuluEbd0Vc
 x0OA==
X-Gm-Message-State: AOAM533lYvGcAtDFcvDG1tgmENeCXePoQlp6eamGTU4z3uFv/TUOtkT5
 7g0PFnRXBsHY5TIEaobrR9V1EA==
X-Google-Smtp-Source: ABdhPJz+tcQG7FGy3FlEBQPrN+mpMikLwlc4Lo7J+ey+pIvMNuRrMxCLd7yfmXFIncsb4Qxt6AJb6g==
X-Received: by 2002:a2e:804c:: with SMTP id p12mr10420673ljg.344.1632476490492; 
 Fri, 24 Sep 2021 02:41:30 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id k21sm952544lji.81.2021.09.24.02.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Sep 2021 02:41:29 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id 84289103068; Fri, 24 Sep 2021 12:41:32 +0300 (+03)
Date: Fri, 24 Sep 2021 12:41:32 +0300
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
Message-ID: <20210924094132.gxyqp4z3qdk5w4j6@box.shutemov.name>
References: <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
 <20210922210558.itofvu3725dap5xx@box.shutemov.name>
 <YUzFj+yH79XRc3F3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUzFj+yH79XRc3F3@zn.tnic>
X-Mailman-Approved-At: Fri, 24 Sep 2021 13:11:11 +0000
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

On Thu, Sep 23, 2021 at 08:21:03PM +0200, Borislav Petkov wrote:
> On Thu, Sep 23, 2021 at 12:05:58AM +0300, Kirill A. Shutemov wrote:
> > Unless we find other way to guarantee RIP-relative access, we must use
> > fixup_pointer() to access any global variables.
> 
> Yah, I've asked compiler folks about any guarantees we have wrt
> rip-relative addresses but it doesn't look good. Worst case, we'd have
> to do the fixup_pointer() thing.
> 
> In the meantime, Tom and I did some more poking at this and here's a
> diff ontop.
> 
> The direction being that we'll stick both the AMD and Intel
> *cc_platform_has() call into cc_platform.c for which instrumentation
> will be disabled so no issues with that.
> 
> And that will keep all that querying all together in a single file.

And still do cc_platform_has() calls in __startup_64() codepath?

It's broken.

Intel detection in cc_platform_has() relies on boot_cpu_data.x86_vendor
which is not initialized until early_cpu_init() in setup_arch(). Given
that X86_VENDOR_INTEL is 0 it leads to false-positive.

I think opencode these two calls is the way forward. Maybe also move the
check from sme_encrypt_kernel() to __startup_64().

-- 
 Kirill A. Shutemov
