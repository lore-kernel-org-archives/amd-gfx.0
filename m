Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABEAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 21:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D607A60E54
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 21:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D607A60E54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661656E047;
	Wed, 22 Sep 2021 21:26:46 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5646EC7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 21:05:59 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id y28so17257256lfb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/PcqjgcRCkyIpO5H00bhPWTTbPCMNXWR4nKgirdi3Io=;
 b=xEkq7SUZRewChVZqWhm4cS96l8pPzSSEz+ScgQL56dgjn10FcSw+jLPv0OY9bYezIP
 CYphaUGJXn/snvtDU3KSfg579Nb5Qlk3NtUo6CuASAlclCh3ui7cA33wRO6foyyQk9sK
 Mw3x0Ft59CKVBwMroO3W4lugA/tv5mEWbElbrHB+wIwMc5ZNjOZSS8KT6h+Zon+cf4qv
 JmEltnmffmbEBqUsebTV11v0B5U1mVwBUj3sW1gLZspQ54hm7TrP9j1QPJEblcLAhwI2
 nEggNK9m8gYxewjcBCYSYCHLIhl9iSTZmO6vl1lqR1Tl54TSO4jEGxDT96zBALyLtnLS
 Hi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/PcqjgcRCkyIpO5H00bhPWTTbPCMNXWR4nKgirdi3Io=;
 b=0QZxu9HxpTJ9Vr+/odZ094hitCkGharFnSHY980k0rK4ExVKwYdyP/x81MyDy7//S6
 ZScWiMkutWyIee0AyHAHDYgAyiufzsRwk6/+Bh6O0qZxSko3JMVs4E8YO8111b2lSfV8
 p5i6G+YhUmw3LUrfwCLknnVrZ6cMcEU1Z8bKlysvq0QCjDXbgKRFi0ZfHXjVRb36ey5i
 Mul/6geSMG9f0QheNfKovF543DuJiiCo9AoQXXjVgIxafZ91zJVwvA3C2clJXJZdthNE
 UhqGH7plo8GZCXj8tDjXvXSRHcgUBDgpqqUY38XPdGAhCFjq0BJ+t9trhYgBu5VyjSNG
 cVWA==
X-Gm-Message-State: AOAM533a3rvYFH2GU/RBkxONwijMRV82Ldlhp1rxcis9PYOjNxTfXOcH
 b/UG5w+9Ml1S+k51r3K1YMqlgw==
X-Google-Smtp-Source: ABdhPJxFaBhI/uy8npc3Dtax2q52q/CAXrrCmDjvazERLjrealUJSj+rQLNB+0RcTEMnHlaiKFjmmA==
X-Received: by 2002:a05:6512:5c2:: with SMTP id
 o2mr917110lfo.207.1632344757440; 
 Wed, 22 Sep 2021 14:05:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id bi33sm370467ljb.89.2021.09.22.14.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 14:05:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id 60F2A10304D; Thu, 23 Sep 2021 00:05:58 +0300 (+03)
Date: Thu, 23 Sep 2021 00:05:58 +0300
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
Message-ID: <20210922210558.itofvu3725dap5xx@box.shutemov.name>
References: <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUuJZ2qOgbdpfk6N@zn.tnic>
X-Mailman-Approved-At: Wed, 22 Sep 2021 21:26:45 +0000
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

On Wed, Sep 22, 2021 at 09:52:07PM +0200, Borislav Petkov wrote:
> On Wed, Sep 22, 2021 at 05:30:15PM +0300, Kirill A. Shutemov wrote:
> > Not fine, but waiting to blowup with random build environment change.
> 
> Why is it not fine?
> 
> Are you suspecting that the compiler might generate something else and
> not a rip-relative access?

Yes. We had it before for __supported_pte_mask and other users of
fixup_pointer().

See for instance 4a09f0210c8b ("x86/boot/64/clang: Use fixup_pointer() to
access '__supported_pte_mask'")

Unless we find other way to guarantee RIP-relative access, we must use
fixup_pointer() to access any global variables.

-- 
 Kirill A. Shutemov
