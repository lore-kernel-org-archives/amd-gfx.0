Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4871DC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 15:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2530F206F1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 15:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2530F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB016E866;
	Wed, 20 May 2020 15:31:27 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04106E866;
 Wed, 20 May 2020 15:31:25 +0000 (UTC)
IronPort-SDR: bn4U8ixpEHoO5pVFczF8kGczswuGiATyGVDU6t2FwWmkEwxSp3TP7nCwJNyAqkSe7EEc2k9o8x
 0vZXS9XM7MsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 08:31:12 -0700
IronPort-SDR: f0Zx2QUrUJxCeU2y5dYw8Py/FVL9nmBPEftqXgmIZrpOjhDhSrm66NX0gdENPJhNtysPNSNOts
 D08i7IpSG0Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; d="scan'208";a="440070660"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga005.jf.intel.com with ESMTP; 20 May 2020 08:31:11 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 08:31:11 -0700
Received: from fmsmsx108.amr.corp.intel.com ([169.254.9.97]) by
 FMSMSX154.amr.corp.intel.com ([169.254.6.79]) with mapi id 14.03.0439.000;
 Wed, 20 May 2020 08:31:11 -0700
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Alex Deucher
 <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: off by one in
 amdgpu_device_attr_create_groups() error handling
Thread-Topic: [PATCH v3] drm/amdgpu: off by one in
 amdgpu_device_attr_create_groups() error handling
Thread-Index: AQHWLrsALezMNhBda0yqAwmq9Jl02KixGQgQ
Date: Wed, 20 May 2020 15:31:11 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663010E230378@FMSMSX108.amr.corp.intel.com>
References: <14063C7AD467DE4B82DEDB5C278E8663010E2302FA@FMSMSX108.amr.corp.intel.com>
 <20200520152556.GQ3041@kadam>
In-Reply-To: <20200520152556.GQ3041@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
MIME-Version: 1.0
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
Cc: David Airlie <airlied@linux.ie>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Rui Huang <ray.huang@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
 Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGFuIENhcnBlbnRlciA8ZGFuLmNh
cnBlbnRlckBvcmFjbGUuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgTWF5IDIwLCAyMDIwIDExOjI2
IEFNDQo+VG86IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT47IEtldmlu
IFdhbmcNCj48a2V2aW4xLndhbmdAYW1kLmNvbT47IFJ1aGwsIE1pY2hhZWwgSiA8bWljaGFlbC5q
LnJ1aGxAaW50ZWwuY29tPg0KPkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+OyBEYXZpZCBBaXJsaWUNCj48YWlybGllZEBsaW51eC5pZT47IERhbmllbCBWZXR0
ZXIgPGRhbmllbEBmZndsbC5jaD47IEV2YW4gUXVhbg0KPjxldmFuLnF1YW5AYW1kLmNvbT47IFJ1
aSBIdWFuZyA8cmF5Lmh1YW5nQGFtZC5jb20+OyBLZW5uZXRoIEZlbmcNCj48a2VubmV0aC5mZW5n
QGFtZC5jb20+OyBZaW50aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT47IEhhd2tpbmcgWmhhbmcNCj48
SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRy
aS0NCj5kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGtlcm5lbC0NCj5qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBbUEFU
Q0ggdjNdIGRybS9hbWRncHU6IG9mZiBieSBvbmUgaW4NCj5hbWRncHVfZGV2aWNlX2F0dHJfY3Jl
YXRlX2dyb3VwcygpIGVycm9yIGhhbmRsaW5nDQo+DQo+VGhpcyBsb29wIGluIHRoZSBlcnJvciBo
YW5kbGluZyBjb2RlIHNob3VsZCBzdGFydCBhICJpIC0gMSIgYW5kIGVuZCBhdA0KPiJpID09IDAi
LiAgQ3VycmVudGx5IGl0IHN0YXJ0cyBhICJpIiBhbmQgZW5kcyBhdCAiaSA9PSAxIi4gIFRoZSBy
ZXN1bHQNCj5pcyB0aGF0IGl0IHJlbW92ZXMgb25lIGF0dHJpYnV0ZSB0aGF0IHdhc24ndCBjcmVh
dGVkIHlldCwgYW5kIGxlYWtzIHRoZQ0KPnplcm9ldGggYXR0cmlidXRlLg0KPg0KPkZpeGVzOiA0
ZTAxODQ3YzM4ZjcgKCJkcm0vYW1kZ3B1OiBvcHRpbWl6ZSBhbWRncHUgZGV2aWNlIGF0dHJpYnV0
ZSBjb2RlIikNCj5TaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9y
YWNsZS5jb20+DQo+LS0tDQo+djI6IHN0eWxlIGNoYW5nZQ0KPnYzOiBGaXggZW1iYXJyYXNzaW5n
IHR5cG8gaW4gdGhlIHN1YmplY3QNCg0K8J+Yig0KDQpBY2tlZC1ieTogTWljaGFlbCBKLiBSdWhs
IDxtaWNoYWVsLmoucnVobEBpbnRlbC5jb20+DQoNCm0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BtLmMgICAgICAgICAgIHwgMyArLS0NCj4gMSBmaWxlcyBjaGFuZ2VkLCAx
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jDQo+Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcG0uYw0KPmluZGV4IGI3NTM2MmJmMDc0Mi4uZTgwOTUzNGZhYmQ0IDEwMDY0
NA0KPi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jDQo+KysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMNCj5AQCAtMTk0Miw5ICsxOTQy
LDggQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2F0dHJfY3JlYXRlX2dyb3VwcyhzdHJ1Y3QN
Cj5hbWRncHVfZGV2aWNlICphZGV2LA0KPiAJcmV0dXJuIDA7DQo+DQo+IGZhaWxlZDoNCj4tCWZv
ciAoOyBpID4gMDsgaS0tKSB7DQo+Kwl3aGlsZSAoaS0tKQ0KPiAJCWFtZGdwdV9kZXZpY2VfYXR0
cl9yZW1vdmUoYWRldiwgJmF0dHJzW2ldKTsNCj4tCX0NCj4NCj4gCXJldHVybiByZXQ7DQo+IH0N
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
