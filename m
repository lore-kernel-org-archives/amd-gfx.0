Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027DAC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 21:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D197320714
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 21:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D197320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A086E528;
	Mon, 15 Jun 2020 21:48:40 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512BD6E509
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 20:56:28 +0000 (UTC)
IronPort-SDR: DTuF3dI2B5Y/x0Al8FmKhcN1FiMWlPSOxohi30kftJIv/7PsPusXM/fl2WgC1ijCORfOcPJvk2
 ET1s65mSP+WA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 13:56:27 -0700
IronPort-SDR: muuOGndW6l2twqgKRUp5gHj+I6DHwdVVXjshaVMnzZ31gcVkdJsq7yUI+1XuAIXfF8xffWXCmG
 4mfjL2O9CNyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; d="scan'208";a="261210056"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2020 13:56:26 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 13:56:15 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@amacapital.net>, "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Topic: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Index: AQHWQRt0fMmHYsE9aUKb3rSjyAIL46jZyC2AgACD5gCAAAQ1gIAAJA2AgAAFHACAAAbEgIAAA+gAgAATCICAAAmFgP//iy/g
Date: Mon, 15 Jun 2020 20:56:15 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
References: <20200615201735.GE13792@romley-ivt3.sc.intel.com>
 <C41D099B-BE2E-4D0E-A7B5-7CE587E11930@amacapital.net>
In-Reply-To: <C41D099B-BE2E-4D0E-A7B5-7CE587E11930@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 Jun 2020 21:48:37 +0000
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
Cc: Peter Zijlstra <peterz@infradead.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "Yu, 
 Yu-cheng" <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> Are we planning to keep PASID live once a task has used it once or are we going to swap it lazily?  If the latter, a percpu variable might be better.

Current plan is "touch it once and the task owns it until exit(2)"

Maybe someday in the future when we have data on how applications
actually use accelerators we could look at something more complex
if usage patterns look like it would be beneficial.

-Tony
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
