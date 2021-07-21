Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C4C12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 07:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FA1606A5
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 07:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FA1606A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7353D6E542;
	Wed, 21 Jul 2021 07:29:57 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8B26E90C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 06:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+skYpVFx7D26gZP3u4sFvQmDQJ66kJNmYAf8MY+5yFI=; b=TaTMVqhlAYzzaMNEl9YC7dzmxn
 1CXjRkMdMpvsxrcDsiWSN+C7YsUcSGcnzfszUyULbfcS4ooEOY9tYgSTcSDi8G0+oWilUGS6sOcPf
 nLp4xhpCmloqX13mk1sMDi5gtqkhduaQ+k6J7vhS99Z+ty7iwqeV+TAF87tjbFtL39SRWdu7qwI4I
 Vgt4l+1YRSeRmJMUI+A2kV6QVzaS/HZMFW/RSB+q0xG3mDki08KQH4msQrqT0KjcXd87usNNUZ9Ch
 ufmPwWhMwnf8G0/afdBOJAMzOP2q4EjptdlCBBhK1vzXw/mz7U7siUAfM4yKdONCURjyTTfLtOm62
 Wn3DySvA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m665B-008tgP-6t; Wed, 21 Jul 2021 06:51:56 +0000
Date: Wed, 21 Jul 2021 07:51:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christian K??nig <christian.koenig@amd.com>
Subject: Re: [RFC v2 2/2] drm/amd/display: Use PPC FPU functions
Message-ID: <YPfECUtD0SRCjrSm@infradead.org>
References: <20210721044801.840501-1-Anson.Jacob@amd.com>
 <20210721044801.840501-3-Anson.Jacob@amd.com>
 <9094cea1-602e-6e71-4ff7-c06fd04af6c5@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9094cea1-602e-6e71-4ff7-c06fd04af6c5@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Wed, 21 Jul 2021 07:29:54 +0000
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
Cc: Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Anson Jacob <Anson.Jacob@amd.com>, mpe@ellerman.id.au, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 christophe.leroy@csgroup.eu, roman.li@amd.com,
 Christoph Hellwig <hch@infradead.org>, Sunpeng.Li@amd.com,
 Aurabindo.Pillai@amd.com, paulus@samba.org, amd-gfx@lists.freedesktop.org,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 21, 2021 at 08:29:43AM +0200, Christian K??nig wrote:
> Looks good in general, but question is what about other architectures like
> ARM?

DRM_AMD_DC_DCN currently requires X86 || PPC64.

Maybe a good think would be to add a new KERNEL_FPU_API Kconfig symbol,
selected by x86 and powerpc (I think ppc32 should be fine too now) so
that we get these arch dependencies out of the driver.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
