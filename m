Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FB7C17441
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 16:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40945222C5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 16:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40945222C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C4C6EB76;
	Tue, 12 Nov 2019 16:45:20 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8D4CA6EB74;
 Tue, 12 Nov 2019 16:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id E45422A6046;
 Tue, 12 Nov 2019 17:45:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id IU3ZG7YC6ovU; Tue, 12 Nov 2019 17:45:17 +0100 (CET)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.245.116])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id DF2832A6045;
 Tue, 12 Nov 2019 17:45:16 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93-RC1)
 (envelope-from <michel@daenzer.net>)
 id 1iUZI3-0007oQ-QX; Tue, 12 Nov 2019 17:45:15 +0100
Subject: Re: [PATCH 1/2] drm: replace incorrect Compliance/Margin magic
 numbers with PCI_EXP_LNKCTL2 definitions
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20191111192932.36048-1-helgaas@kernel.org>
 <20191111192932.36048-2-helgaas@kernel.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <6d86246e-504a-b762-aff8-0449dd6f3d31@daenzer.net>
Date: Tue, 12 Nov 2019 17:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111192932.36048-2-helgaas@kernel.org>
Content-Language: en-CA
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Frederick Lawler <fred@fredlawl.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112164515.v79dc3vrSPz_eZsbp_Dd_GlEbJExiDme1ajrYuuWXBc@z>

T24gMjAxOS0xMS0xMSA4OjI5IHAubS4sIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4gRnJvbTogQmpv
cm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KPiAKPiBBZGQgZGVmaW5pdGlvbnMgZm9y
IHRoZXNlIFBDSWUgTGluayBDb250cm9sIDIgcmVnaXN0ZXIgZmllbGRzOgo+IAo+ICAgRW50ZXIg
Q29tcGxpYW5jZQo+ICAgVHJhbnNtaXQgTWFyZ2luCj4gCj4gYW5kIHVzZSB0aGVtIGluIGFtZGdw
dSBhbmQgcmFkZW9uLgo+IAo+IE5PVEU6IFRoaXMgaXMgYSBmdW5jdGlvbmFsIGNoYW5nZSBiZWNh
dXNlICI3IDw8IDkiIHdhcyBhcHBhcmVudGx5IGEgdHlwby4KPiBUaGF0IG1hc2sgaW5jbHVkZWQg
dGhlIGhpZ2ggb3JkZXIgYml0IG9mIFRyYW5zbWl0IE1hcmdpbiwgdGhlIEVudGVyCj4gTW9kaWZp
ZWQgQ29tcGxpYW5jZSBiaXQsIGFuZCB0aGUgQ29tcGxpYW5jZSBTT1MgYml0LCBidXQgSSB0aGlu
ayB3aGF0Cj4gd2FzIGludGVuZGVkIHdhcyB0aGUgMy1iaXQgVHJhbnNtaXQgTWFyZ2luIGZpZWxk
IGF0IGJpdHMgOTo3LgoKQ2FuIHlvdSBzcGxpdCBvdXQgdGhlIGZ1bmN0aW9uYWwgY2hhbmdlIGlu
dG8gYSBzZXBhcmF0ZSBwYXRjaCAxPyBUaGF0CmNvdWxkIG1ha2UgdGhpbmdzIGVhc2llciBmb3Ig
YW55b25lIHdobyBiaXNlY3RzIHRoZSBmdW5jdGlvbmFsIGNoYW5nZQpmb3Igd2hhdGV2ZXIgcmVh
c29uLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAg
ICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
