Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC95C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 16:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE28520673
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 16:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVVoA1vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE28520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CB96EA5F;
	Fri, 10 Jan 2020 16:55:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C9A6EA47;
 Fri, 10 Jan 2020 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fRa0AWajRky2XVf3fbVWPpWSKtLLfakhnhtk3oANo5Y=; b=BVVoA1vpiXxufgxsL4a/LbnYj
 fwc2ITR4+UHXAJ5R/Dli2qVrZH8rdmNrcGSJeUs51tjLHoNhHVTLhkA7Mir6U0P0qINfaA/r31mx3
 cb3i6YEHqUVkK1FOJ4prR0uRfIfIB7Qh/8ML0jYJUBu+xTX2O0OI/qD4qTnwH5vUEoRbt8sYBIZj7
 fUgaI3loPRo+VyUx5RpgnDI3o3ww1vJxDRtvEXm+lbU1ViXr7ijryQTo9VAjkwFZNrQJJ4nUQjZO6
 +90FnOw7NfHw1DOL/n5V9juNdFfKYMHp/novkigOm2fABgs7oVuVTkKk/HO+/p1SXKQZyWlDSypPE
 QYLIM/pMA==;
Received: from [2601:1c0:6280:3f0::ed68]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipwqk-00083d-LR; Fri, 10 Jan 2020 16:09:26 +0000
Subject: Re: linux-next: Tree for Jan 10 (amdgpu)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20200110190737.65d8881b@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb8c8e0a-9fd8-07a3-3596-d57b48b220e0@infradead.org>
Date: Fri, 10 Jan 2020 08:09:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200110190737.65d8881b@canb.auug.org.au>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 10 Jan 2020 16:55:25 +0000
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/10/20 12:07 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200109:
> 


on i386:

ld: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.o: in function `compute_mst_dsc_configs_for_link':
amdgpu_dm_mst_types.c:(.text+0x784): undefined reference to `__udivdi3'
ld: amdgpu_dm_mst_types.c:(.text+0x7a2): undefined reference to `__udivdi3'
ld: amdgpu_dm_mst_types.c:(.text+0x84a): undefined reference to `__udivdi3'
ld: amdgpu_dm_mst_types.c:(.text+0x868): undefined reference to `__udivdi3'
ld: amdgpu_dm_mst_types.c:(.text+0x8d0): undefined reference to `__udivdi3'
ld: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.o:amdgpu_dm_mst_types.c:(.text+0x8ee): more undefined references to `__udivdi3' follow


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
