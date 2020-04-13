Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76970C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 18:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3911E20692
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 18:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3911E20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3046E10B;
	Mon, 13 Apr 2020 18:17:13 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FCA6E10B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 18:17:13 +0000 (UTC)
Received: from [192.168.1.6] (x4d0d8c93.dyn.telefonica.de [77.13.140.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A0ECC206442DF;
 Mon, 13 Apr 2020 20:17:11 +0200 (CEST)
Subject: Re: [PATCH] drm/amdgpu: fix the hw hang during perform system reboot
 and reset
To: Alex Deucher <alexdeucher@gmail.com>, Prike Liang <Prike.Liang@amd.com>
References: <1586790530-19464-1-git-send-email-Prike.Liang@amd.com>
 <CADnq5_Os9ePu+u0cmroyKRVyXroYD9Bggyy0Do1mWW18m5-Pbg@mail.gmail.com>
From: Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Message-ID: <1dce548a-c6ea-183c-4c33-6b8f6bc3c6c8@molgen.mpg.de>
Date: Mon, 13 Apr 2020 20:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Os9ePu+u0cmroyKRVyXroYD9Bggyy0Do1mWW18m5-Pbg@mail.gmail.com>
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
Cc: Rahul Kumar <Rahul.Kumar1@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 Johannes Hirte <johannes.hirte@datenkhaos.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBBbGV4LCBkZWFyIFByaWtlLAoKCkFtIDEzLjA0LjIwIHVtIDE3OjE0IHNjaHJpZWIgQWxl
eCBEZXVjaGVyOgo+IE9uIE1vbiwgQXByIDEzLCAyMDIwIGF0IDExOjA5IEFNIFByaWtlIExpYW5n
IDxQcmlrZS5MaWFuZ0BhbWQuY29tPiB3cm90ZToKPj4KPj4gVW5pZnkgc2V0IGRldmljZSBDR1BH
IHRvIHVuZ2F0ZSBzdGF0ZSBiZWZvcmUgZW50ZXIgcG93ZXJvZmYgb3IgcmVzZXQuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPgo+PiBUZXN0ZWQt
Ynk6IE1lbmdiaW5nIFdhbmcgPE1lbmdiaW5nLldhbmdAYW1kLmNvbT4KPiAKPiBBY2tlZC1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKRmlyc3Q6CgpUZXN0ZWQt
Ynk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+IChNU0kgQjM1ME0gTU9SVEFS
IAooTVMtN0EzNykgd2l0aCBhbiBBTUQgUnl6ZW4gMyAyMjAwRykKClNlY29uZCwgSSBhbSBoYXZp
bmcgdHJvdWJsZSB0byB1bmRlcnN0YW5kLCBob3cgeW91IGNhbiBhZGQgeW91ciBBY2tlZC1ieSAK
dGFnIHRvIGEgY29tbWl0IHdpdGggc3VjaCBhIGNvbW1pdCBtZXNzYWdlPwoKVGhlIHByb2JsZW0g
aXMgbm90IGRlc2NyaWJlZCAoYXBwYXJlbnRseSBpdCBvbmx5IGFmZmVjdGVkIGNlcnRhaW4gCmRl
dmljZXMpLCBpdCBpcyBub3QgbWVudGlvbmVkIHRoYXQgaXTigJlzIGEgcmVncmVzc2lvbiAoRml4
ZXM6IHRhZy9saW5lIGlzIAptaXNzaW5nKSwgYW5kIEkgYW0gaGF2aW5nIGEgaGFyZCB0aW1lIHRv
IHVuZGVyc3RhbmQgdGhlIGNvbW1pdCBtZXNzYWdlIAphdCBhbGwgKGFuZCB0aGUgb25lIGZyb20g
dGhlIGNvbW1pdCBpbnRyb2R1Y2luZyB0aGUgcmVncmVzc2lvbikuIFdoeSBpcyAKaXQgbW9yZSBv
ciBsZXNzIHJldmVydGluZyBwYXJ0IG9mIHRoZSBvdGhlciBjb21taXQsIHdoaWxlIHRoZSBpc3N1
ZSB3YXMgCm5vdCByZXByb2R1Y2libGUgb24gUHJpa2XigJlzIHN5c3RlbT8KCj4+IC0tLQo+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKysKPj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gaW5kZXggODdmN2MxMi4uYmJlMDkwYSAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+PiBAQCAtMjQx
Myw2ICsyNDEzLDggQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmRfcGhhc2Ux
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiAgIHsKPj4gICAgICAgICAgaW50IGksIHI7
Cj4+Cj4+ICsgICAgICAgYW1kZ3B1X2RldmljZV9zZXRfcGdfc3RhdGUoYWRldiwgQU1EX1BHX1NU
QVRFX1VOR0FURSk7Cj4+ICsgICAgICAgYW1kZ3B1X2RldmljZV9zZXRfY2dfc3RhdGUoYWRldiwg
QU1EX0NHX1NUQVRFX1VOR0FURSk7Cj4+Cj4+ICAgICAgICAgIGZvciAoaSA9IGFkZXYtPm51bV9p
cF9ibG9ja3MgLSAxOyBpID49IDA7IGktLSkgewo+PiAgICAgICAgICAgICAgICAgIGlmICghYWRl
di0+aXBfYmxvY2tzW2ldLnN0YXR1cy52YWxpZCkKPj4gLS0KPj4gMi43LjQKCktpbmQgcmVnYXJk
cywKClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
