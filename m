Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1668C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 21:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3EA20714
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 21:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3EA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576956E527;
	Mon, 15 Jun 2020 21:48:38 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED366E512
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 21:25:01 +0000 (UTC)
IronPort-SDR: vt1JggyX4SZrKGY6Ukq/L+H39PwnK2NCzQNwGBv6jjiTcRvm45tKV9oJz0XZO2q55QARxHoenK
 7T/TtWTrb08A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 14:25:01 -0700
IronPort-SDR: DPbSSKkl15RGLXjpYQfnrBQzsDrL2NKVfrTHzComI5JPwOJAfj8xqnwP2YPVXomnmdcjFehp/x
 VNCrnqd1nQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; d="scan'208";a="262830374"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2020 14:25:00 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 14:25:00 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.6]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 14:24:59 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@amacapital.net>
Subject: RE: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Topic: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Index: AQHWQRt0fMmHYsE9aUKb3rSjyAIL46jZyC2AgACD5gCAAAQ1gIAAJA2AgAAFHACAAAbEgIAAA+gAgAATCICAAAmFgP//iy/ggAB8XID//4sJsA==
Date: Mon, 15 Jun 2020 21:24:59 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F66C93C@ORSMSX115.amr.corp.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
 <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
In-Reply-To: <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
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
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, "Hansen, Dave" <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Yu, 
 Yu-cheng" <yu-cheng.yu@intel.com>, Andrew
 Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PiBTbyB3aGF04oCZcyB0aGUgUkRNU1IgZm9yPyAgU3VyZWx5IHlvdQ0KPiBoYXZlIHNvbWUgc3Rh
dGUgc29tZXdoZXJlIHRoYXQgc2F5cyDigJx0aGlzIHRhc2sgaGFzIGEgUEFTSUQu4oCdDQo+IENh
buKAmXQgeW91IGp1c3QgbWFrZSBzdXJlIHRoYXQgc3RheXMgaW4gc3luYyB3aXRoIHRoZSBNU1I/
ICBUaGVuLCBvbiAjR1AsIGlmIHRoZSB0YXNrIGFscmVhZHkgaGFzIGEgUEFTSUQsIHlvdSBrbm93
IHRoZSBNU1IgaXMgc2V0Lg0KDQpXZSBoYXZlIHN0YXRlIHRoYXQgc2F5cyB0aGUgcHJvY2VzcyAo
Im1tIikgaGFzIGJlZW4gYWxsb2NhdGVkIGEgUEFTSUQuIEJ1dCBub3QgZm9yIGVhY2ggdGFzay4N
Cg0KRS5nLiBhIHByb2Nlc3MgbWF5IGNsb25lIGEgYnVuY2ggb2YgdGFza3MsIHRoZW4gb25lIG9m
IHRoZW0gb3BlbnMgYSBkZXZpY2UgdGhhdCBuZWVkcw0KYSBQQVNJRC4gICBXZSBkaWQgaW50ZXJu
YWxseSBoYXZlIHBhdGNoZXMgdG8gZ28gaHVudCBkb3duIGFsbCB0aG9zZSBvdGhlciB0YXNrcyBh
bmQNCmZvcmNlIGEgUEFTSUQgb250byBlYWNoLiBCdXQgdGhlIGNvZGUgd2FzIGJpZyBhbmQgdWds
eS4gQWxzbyBtYXliZSB0aGUgd3JvbmcgdGhpbmcNCnRvIGRvIGlmIHRob3NlIHRocmVhZHMgZGlk
bid0IGV2ZXIgbmVlZCB0byBhY2Nlc3MgdGhlIGRldmljZS4NCg0KUGV0ZXJaIHN1Z2dlc3RlZCB0
aGF0IHdlIGNhbiBhZGQgYSBiaXQgdG8gdGhlIHRhc2sgc3RydWN0dXJlIGZvciB0aGlzIHB1cnBv
c2UuDQoNCkZlbmdodWEgaXMgaGVzaXRhbnQgYWJvdXQgYWRkaW5nIGFuIHg4NiBvbmx5IGJpdCB0
aGVyZS4NCg0KLVRvbnkNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
