Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE563C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58C92070A
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58C92070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5A76EA38;
	Fri, 22 May 2020 19:53:59 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CAC6E0EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 19:27:31 +0000 (UTC)
IronPort-SDR: thuhAwdDcJ6PVKsfu++AvTmV/Lv9+69nqJ8i9H+MHPdY5duk+H5Uwm12XalQyInondQPFGsAMm
 sXQRr7pq/MJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2020 12:27:30 -0700
IronPort-SDR: V/R6M9hWYqNrGbbLUpcPCE/ywsEUYDw3TgHTLZRMoFwFyldHYCkMc4+NXsdaJGXutFH4kdhQ/c
 WUtlVbLQ5yJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; d="scan'208";a="374848403"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga001.fm.intel.com with ESMTP; 22 May 2020 12:27:30 -0700
Date: Fri, 22 May 2020 12:25:54 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Yong Zhao <Yong.Zhao@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: drm/amdkfd: Change pasid's type to unsigned int
Message-ID: <20200522192554.GA39766@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Fri, 22 May 2020 19:53:58 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Yong,

In commit: 6027b1bf6071fc61a5aa11b9922a2e0e91bff1ea
    drm/amdkfd: Use hex print format for pasid

pasid's type was change to "uint16_t" from "unsigned int" in
struct kfd_process.

But, pasid is a 20-bit value according to PCIe spec and other places
in amdkfd (plus other iommu code) define pasid as "unsigned int".
If defined as uint16_t, pasid will overflow if its value is bigger than 16-bit.

Did I miss anything? Should we change pasid's type back to "unsigned int"?

[a little background: pasid is defined as various types including "int",
"unsigned int", "u32" in iommu. I'm changing pasid's types to "unsigned int"
so that the types are consistent in iommu]

Thanks.

-Fenghua
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
