Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FECC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 21:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CA361166
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 21:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69CA361166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF356E868;
	Tue, 21 Sep 2021 21:38:42 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A886E82A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 21:34:02 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id g41so3238917lfv.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=onYH57UKgRX2y9FA652B6Jil/Y6sRo6kbtM4byaxFbk=;
 b=eBVF3W3VBl8/Kcc3edgbmiaMz5aGtiFcsghvZhSejZhbmeEyK5UQw/1PFkiQyXYHaG
 ep1Qe79XGKoddakjbluJzSSdU6e7ItIa/VyOBVU9ai0Bymzz3iDJtyFjRD39EIPM25vz
 4qz0qSZamNXJd68fq5IJpTDDpau43+mSfg2XWhoKoGxbOFiuRtiRYE7GfxGmSUDaHEJg
 E7kAQREHoi4We6KjgT1K6PZUTHBzzEa/WGaKq/wElm+NwA9Dj3BI08sAZJBTPlkJn2D7
 eFgy10WdV1zv/1WS3CBekNlpT18oJkYC++DPHzSZnogr5FAXrL71q6vwYz/oJyJkBY1z
 HMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=onYH57UKgRX2y9FA652B6Jil/Y6sRo6kbtM4byaxFbk=;
 b=gmWY580jbtwsjleEmZmzO1JchfKxmvksb3gOcfxzXp6LbOwsqZQuHuYtM/LDMuDLTy
 1oxEalXKqLnNaxcnzhI3mmYFe9p8QuGqHw7srZE59G0lEgqV2SsimtFavhHiosV+AGE0
 W61s6nwesVyhVEsWnfElP7jHhx1N4eiNQ8laLFFyZxLPnGuu0uNNJdbPHwdfv/nYzGji
 Y0zUSogusBg5G6DxkcEQ8tpGsQJ6q7prFSUc95wCe4L//rzH09HC321dWhK1zZ8iBUoQ
 +KZRMde7OGEJP3eW9+nuloldlHH9QdtacW63ovPODWRPjauWuHEBarGB/Clw6qq4DVcr
 4lNQ==
X-Gm-Message-State: AOAM532DSkZqxIwqNAJ6e6FrILDg1VXXw3FQwaV318/EbD+TB/PM93b8
 xs1/J4YcUzZO8qddD26mKLJ+Ig==
X-Google-Smtp-Source: ABdhPJwdW58yGabAJZgobn6vaDrfqJrmQRLjEbi4LByZcJNYEBlALvg49HirVUieAeO4lwAN455DSA==
X-Received: by 2002:a05:6512:3096:: with SMTP id
 z22mr19350411lfd.167.1632260040535; 
 Tue, 21 Sep 2021 14:34:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id t14sm16618lfp.15.2021.09.21.14.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 14:34:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id 3890410305C; Wed, 22 Sep 2021 00:34:01 +0300 (+03)
Date: Wed, 22 Sep 2021 00:34:01 +0300
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
Message-ID: <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUpONYwM4dQXAOJr@zn.tnic>
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

On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
> On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> > I still believe calling cc_platform_has() from __startup_64() is totally
> > broken as it lacks proper wrapping while accessing global variables.
> 
> Well, one of the issues on the AMD side was using boot_cpu_data too
> early and the Intel side uses it too. Can you replace those checks with
> is_tdx_guest() or whatever was the helper's name which would check
> whether the the kernel is running as a TDX guest, and see if that helps?

There's no need in Intel check this early. Only AMD need it. Maybe just
opencode them?

-- 
 Kirill A. Shutemov
