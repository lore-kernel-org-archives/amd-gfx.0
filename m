Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A8AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 01:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6E261184
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 01:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C6E261184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E376E9FB;
	Wed, 22 Sep 2021 01:37:05 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A08C6E83F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 21:58:31 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id b20so3450587lfv.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3LA4/O2mCyOef4VI1WFdoR8n1dGVVw7qzM7cBS6DVhU=;
 b=uz74/2S9fGGuaG1ODTSPcqBPXWYPIeYWZ5doyMS2bRw5AX5Q0Ua+uMdim4ZuJxyrxA
 jJZQO4P96OqxH5cKvegadiVeIhPzNJbdYGDNOj6HudiXM/SjkCNrO1WvHS6o1vufFzsX
 2aSN3AaXAf4xQbbvR+FPssTEArjutFFJ66GH7RUNHyFCNozOqySWjjTExvVocPFb39xr
 6cGXTnJkbxFWnWohqMtGSjOnjJQnu/xNRG5R8l2FsElk/Lpvl66TfQOcwUYfJ1TTZ5xS
 XHIL9Tea6doFMlP16r8MNgBnWMAMa0JaH2OsWma5jit+qxznz4qqyPPj9R612HR9czFp
 8TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3LA4/O2mCyOef4VI1WFdoR8n1dGVVw7qzM7cBS6DVhU=;
 b=LYTKfhF7GvWOZqRIx5vV0ZqCO7xnjKg1+uZ0bgRR8Sl2p+hxRBEK93COn0eFKf3KJw
 BuIC6kALFUQWtN3/QYXfEizDsUWsoPCenZtSHbcZuUcMPR6GjyKT1QqkuN3eN6z5uxO4
 20D3QGXaQSix/PI4r+DhQRdE6DE9iio4uCNNwmU6GoAEu2IcRQZPtUBi/VWYUWEw3dse
 cHv7GKQYbXnpNePpDQTAqE/hqiRxvAB9CJQp5GMGmKL+vbdTJ4i8zKScrksVxeBGJlfs
 vqQbif/2pyZYgbF8lIQXscrKZVodc3xy9+ZhiiO1VRCAYaxHDNMPgrl0O1WB8Pk8HUsQ
 DPug==
X-Gm-Message-State: AOAM533drst9NsOR4ISG26bxrZZvxxHn2Y4C+0W7CW0Qx7gkY0fstrln
 /c4IOocZgA6re9XQbYJOHFE6Gw==
X-Google-Smtp-Source: ABdhPJwDR/A8UmkVQG/A20LQ6G5BoWJFTrnWNencwdMb7p0WPRY497q9Nuc+l8sjchxpIRdzv87pHg==
X-Received: by 2002:a2e:86ce:: with SMTP id n14mr11214294ljj.211.1632261509754; 
 Tue, 21 Sep 2021 14:58:29 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id q7sm16555ljg.137.2021.09.21.14.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 14:58:29 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id 5DF1710305C; Wed, 22 Sep 2021 00:58:30 +0300 (+03)
Date: Wed, 22 Sep 2021 00:58:30 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org,
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
Message-ID: <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
X-Mailman-Approved-At: Wed, 22 Sep 2021 01:37:04 +0000
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

On Tue, Sep 21, 2021 at 04:43:59PM -0500, Tom Lendacky wrote:
> On 9/21/21 4:34 PM, Kirill A. Shutemov wrote:
> > On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
> > > On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> > > > I still believe calling cc_platform_has() from __startup_64() is totally
> > > > broken as it lacks proper wrapping while accessing global variables.
> > > 
> > > Well, one of the issues on the AMD side was using boot_cpu_data too
> > > early and the Intel side uses it too. Can you replace those checks with
> > > is_tdx_guest() or whatever was the helper's name which would check
> > > whether the the kernel is running as a TDX guest, and see if that helps?
> > 
> > There's no need in Intel check this early. Only AMD need it. Maybe just
> > opencode them?
> 
> Any way you can put a gzipped/bzipped copy of your vmlinux file somewhere I
> can grab it from and take a look at it?

You can find broken vmlinux and bzImage here:

https://drive.google.com/drive/folders/1n74vUQHOGebnF70Im32qLFY8iS3wvjIs?usp=sharing

Let me know when I can remove it.

-- 
 Kirill A. Shutemov
