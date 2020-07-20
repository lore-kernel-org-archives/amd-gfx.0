Return-Path: <SRS0=r3ut=A7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436DBC433E7
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FFE22C9C
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="gTkGdHYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FFE22C9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B875C89EAC;
	Mon, 20 Jul 2020 11:24:13 +0000 (UTC)
X-Greylist: delayed 517 seconds by postgrey-1.36 at gabe;
 Mon, 20 Jul 2020 11:24:13 UTC
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se
 [213.80.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A39489EA3;
 Mon, 20 Jul 2020 11:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EEED53F64F;
 Mon, 20 Jul 2020 13:15:33 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=gTkGdHYR; 
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
 by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vixtsmS5pBFA; Mon, 20 Jul 2020 13:15:33 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se
 [155.4.205.35]) (Authenticated sender: mb878879)
 by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7B7A03F2DB;
 Mon, 20 Jul 2020 13:15:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [134.134.139.76])
 by mail1.shipmail.org (Postfix) with ESMTPSA id CCBA93605CC;
 Mon, 20 Jul 2020 13:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1595243729; bh=mjlfxngBtSmrB32mu8iDZVMjrYWXXM5cA0DACfYZQ2A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=gTkGdHYRQjhf+Xn+mawTLz9g2cXReJ781N7XtbRK9TZGGLo4yDhimnm9Mevq/ntPQ
 uyLUhQhfiM7x08z9IjjGWSu3S+AP+bNX+mEqJyRsxaF/sP0FmGUpVvXDhY8a5dEKvZ
 LGF1OoSNnF/ZVdVaQNJHgwIeW7LViWHDfAvpN52E=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
Date: Mon, 20 Jul 2020 13:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709123339.547390-1-daniel.vetter@ffwll.ch>
Content-Language: en-US
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
Cc: Daniel Stone <daniels@collabora.com>, linux-rdma@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, Steve Pronovost <spronovo@microsoft.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-media@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 7/9/20 2:33 PM, Daniel Vetter wrote:
> Comes up every few years, gets somewhat tedious to discuss, let's
> write this down once and for all.
>
> What I'm not sure about is whether the text should be more explicit in
> flat out mandating the amdkfd eviction fences for long running compute
> workloads or workloads where userspace fencing is allowed.

Although (in my humble opinion) it might be possible to completely 
untangle kernel-introduced fences for resource management and dma-fences 
used for completion- and dependency tracking and lift a lot of 
restrictions for the dma-fences, including prohibiting infinite ones, I 
think this makes sense describing the current state.

Reviewed-by: Thomas Hellstrom <thomas.hellstrom@intel.com>


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
