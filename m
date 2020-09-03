Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F3FC433E7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 00:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F5F2072A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 00:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYG0v04E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F5F2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B37F6E10B;
	Thu,  3 Sep 2020 00:41:58 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101556E10B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 00:41:56 +0000 (UTC)
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8220D2072A;
 Thu,  3 Sep 2020 00:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599093714;
 bh=o53Qzhg6oCGPQsbUVZSSWaG+9k+dRs8dxC7A2ExLnC8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=PYG0v04Ej2VL3JNRHSnRXntrFvnrNcCZrKwBRbbNjk0xMmQA8zj0W3v6qlI6SQkuq
 J0xsMLFxxz9ErnYxG0InZfwv4CQBFxzKNiGbgZbmddZWYw1oAwiHrOy+y+n9R1srQz
 5x52TwewfWZitqJMOHgfr2KoR//vmk2zKSIjLP/U=
Date: Wed, 2 Sep 2020 19:41:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
Message-ID: <20200903004153.GA277699@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4340FC71C17B28E1601EBCDDEA2F0@DM6PR12MB4340.namprd12.prod.outlook.com>
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 02, 2020 at 11:43:41PM +0000, Grodzovsky, Andrey wrote:
> It's based on v5.9-rc2 but won't apply cleanly since there is a
> significant amount of amd-staging-drm-next patches which this was
> applied on top of.

Is there a git branch published somewhere?  It'd be nice to be able to
see the whole thing, including the bits that this depends on from
amd-staging-drm-next.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
