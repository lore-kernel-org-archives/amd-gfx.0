Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2478FC47410
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 16:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0200520740
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 16:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0200520740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AB7898F5;
	Mon, 25 Nov 2019 16:57:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7EE35898F5;
 Mon, 25 Nov 2019 16:57:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FABE31B;
 Mon, 25 Nov 2019 08:57:20 -0800 (PST)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0C53F68E;
 Mon, 25 Nov 2019 08:57:19 -0800 (PST)
Subject: Re: [PATCH v3 2/2] drm/scheduler: Avoid accessing freed bad job.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
References: <1574691041-5499-1-git-send-email-andrey.grodzovsky@amd.com>
 <1574691041-5499-2-git-send-email-andrey.grodzovsky@amd.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <fd06b664-8cfe-cf42-6fd0-2a6a3e109412@arm.com>
Date: Mon, 25 Nov 2019 16:57:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574691041-5499-2-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
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
Cc: Emily.Deng@amd.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125165718.7Kxji9DFVJI2XMwJehXFcKbfJZl-unZNR7IUCokPR1w@z>

T24gMjUvMTEvMjAxOSAxNDoxMCwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4gUHJvYmxlbToK
PiBEdWUgdG8gYSByYWNlIGJldHdlZW4gZHJtX3NjaGVkX2NsZWFudXBfam9icyBpbiBzY2hlZCB0
aHJlYWQgYW5kCj4gZHJtX3NjaGVkX2pvYl90aW1lZG91dCBpbiB0aW1lb3V0IHdvcmsgdGhlcmUg
aXMgYSBwb3NzaWJsaXR5IHRoYXQKPiBiYWQgam9iIHdhcyBhbHJlYWR5IGZyZWVkIHdoaWxlIHN0
aWxsIGJlaW5nIGFjY2Vzc2VkIGZyb20gdGhlCj4gdGltZW91dCB0aHJlYWQuCj4gCj4gRml4Ogo+
IEluc3RlYWQgb2YganVzdCBwZWVraW5nIGF0IHRoZSBiYWQgam9iIGluIHRoZSBtaXJyb3IgbGlz
dAo+IHJlbW92ZSBpdCBmcm9tIHRoZSBsaXN0IHVuZGVyIGxvY2sgYW5kIHRoZW4gcHV0IGl0IGJh
Y2sgbGF0ZXIgd2hlbgo+IHdlIGFyZSBnYXJhbnRlZWQgbm8gcmFjZSB3aXRoIG1haW4gc2NoZWQg
dGhyZWFkIGlzIHBvc3NpYmxlIHdoaWNoCj4gaXMgYWZ0ZXIgdGhlIHRocmVhZCBpcyBwYXJrZWQu
Cj4gCj4gdjI6IExvY2sgYXJvdW5kIHByb2Nlc3NpbmcgcmluZ19taXJyb3JfbGlzdCBpbiBkcm1f
c2NoZWRfY2xlYW51cF9qb2JzLgo+IAo+IHYzOiBSZWJhc2Ugb24gdG9wIG9mIGRybS1taXNjLW5l
eHQuIHYyIGlzIG5vdCBuZWVkZWQgYW55bW9yZSBhcwo+IGRybV9zY2hlZF9jbGVhbnVwX2pvYnMg
YWxyZWFkeSBoYXMgYSBsb2NrIHRoZXJlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9k
em92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gVGVzdGVkLWJ5OiBFbWlseSBE
ZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfbWFpbi5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBm
aWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX21haW4uYwo+IGluZGV4IDY3NzQ5NTUuLmE2MDRkZmEgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+IEBAIC0yODQsMTAgKzI4NCwyNCBAQCBzdGF0aWMg
dm9pZCBkcm1fc2NoZWRfam9iX3RpbWVkb3V0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAg
CXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gIAo+ICAJc2NoZWQgPSBjb250YWluZXJfb2Yod29yaywg
c3RydWN0IGRybV9ncHVfc2NoZWR1bGVyLCB3b3JrX3Rkci53b3JrKTsKPiArCj4gKwkvKgo+ICsJ
ICogUHJvdGVjdHMgYWdhaW5zdCBjb25jdXJyZW50IGRlbGV0aW9uIGluIGRybV9zY2hlZF9jbGVh
bnVwX2pvYnMgdGhhdAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl4KCmRybV9zY2hlZF9jbGVhbnVwX2pvYnMoKSBp
cyBnb25lIC0gcmVwbGFjZWQgd2l0aApkcm1fc2NoZWRfZ2V0X2NsZWFudXBfam9iKCkgYW5kIGNv
ZGUgaW4gZHJtX3NjaGVkX21haW4oKS4gU2VlOgoKNTg4Yjk4MjhmMDc0ICgiZHJtOiBEb24ndCBm
cmVlIGpvYnMgaW4gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKCkiKQoKPiArCSAqIGlzIGFscmVh
ZHkgaW4gcHJvZ3Jlc3MuCj4gKwkgKi8KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZzY2hlZC0+am9i
X2xpc3RfbG9jaywgZmxhZ3MpOwo+ICAJam9iID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKCZz
Y2hlZC0+cmluZ19taXJyb3JfbGlzdCwKPiAgCQkJCSAgICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2pv
Yiwgbm9kZSk7Cj4gIAo+ICAJaWYgKGpvYikgewo+ICsJCS8qCj4gKwkJICogUmVtb3ZlIHRoZSBi
YWQgam9iIHNvIGl0IGNhbm5vdCBiZSBmcmVlZCBieSBhbHJlYWR5IGluIHByb2dyZXNzCj4gKwkJ
ICogZHJtX3NjaGVkX2NsZWFudXBfam9icy4gSXQgd2lsbCBiZSByZWluc3J0ZWQgYmFjayBhZnRl
ciBzY2hlZC0+dGhyZWFkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5eXl5eXl5eXgpUeXBvOiBzL3JlaW5zcnRlZC9yZWluc2VydGVkLwoKPiAr
CQkgKiBpcyBwYXJrZWQgYXQgd2hpY2ggcG9pbnQgaXQncyBzYWZlLgo+ICsJCSAqLwo+ICsJCWxp
c3RfZGVsX2luaXQoJmpvYi0+bm9kZSk7Cj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2No
ZWQtPmpvYl9saXN0X2xvY2ssIGZsYWdzKTsKPiArCj4gIAkJam9iLT5zY2hlZC0+b3BzLT50aW1l
ZG91dF9qb2Ioam9iKTsKPiAgCj4gIAkJLyoKPiBAQCAtMjk4LDYgKzMxMiw4IEBAIHN0YXRpYyB2
b2lkIGRybV9zY2hlZF9qb2JfdGltZWRvdXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAJ
CQlqb2ItPnNjaGVkLT5vcHMtPmZyZWVfam9iKGpvYik7Cj4gIAkJCXNjaGVkLT5mcmVlX2d1aWx0
eSA9IGZhbHNlOwo+ICAJCX0KPiArCX0gZWxzZSB7Cj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmc2NoZWQtPmpvYl9saXN0X2xvY2ssIGZsYWdzKTsKPiAgCX0KPiAgCj4gIAlzcGluX2xvY2tf
aXJxc2F2ZSgmc2NoZWQtPmpvYl9saXN0X2xvY2ssIGZsYWdzKTsKPiBAQCAtMzcwLDYgKzM4Niwx
OSBAQCB2b2lkIGRybV9zY2hlZF9zdG9wKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQs
IHN0cnVjdCBkcm1fc2NoZWRfam9iICpiYWQpCj4gIAlrdGhyZWFkX3Bhcmsoc2NoZWQtPnRocmVh
ZCk7Cj4gIAo+ICAJLyoKPiArCSAqIFJlaW5zZXJ0IGJhY2sgdGhlIGJhZCBqb2IgaGVyZSAtIG5v
dyBpdCdzIHNhZmUgYXMgZHJtX3NjaGVkX2NsZWFudXBfam9icwoKQW5vdGhlciByZWZlcmVuY2Ug
dG8gZHJtX3NjaGVkX2NsZWFudXBfam9icy4KCj4gKwkgKiBjYW5ub3QgcmFjZSBhZ2FpbnN0IHVz
IGFuZCByZWxlYXNlIHRoZSBiYWQgam9iIGF0IHRoaXMgcG9pbnQgLSB3ZSBwYXJrZWQKPiArCSAq
ICh3YWl0ZWQgZm9yKSBhbnkgaW4gcHJvZ3Jlc3MgKGVhcmxpZXIpIGNsZWFudXBzIGFuZCBhbnkg
bGF0ZXIgb25lcyB3aWxsCj4gKwkgKiBiYWlsIG91dCBkdWUgdG8gc2NoZWQtPnRocmVhZCBiZWlu
ZyBwYXJrZWQuCgpBcyBleHBsYWluZWQgaW4gdGhlIG90aGVyIHBhdGNoIC0gYWZ0ZXIgdGhlIGt0
aHJlYWRfcGFyaygpIGhhcyByZXR1cm5lZAp0aGVyZSB3aWxsIGJlIG5vIG1vcmUgY2FsbHMgdG8g
ZHJtX3NjaGVkX2dldF9jbGVhbnVwX2pvYigpIHVudGlsIHRoZQp0aHJlYWQgaXMgdW5wYXJrZWQu
CgpTdGV2ZQoKPiArCSAqLwo+ICsJaWYgKGJhZCAmJiBiYWQtPnNjaGVkID09IHNjaGVkKQo+ICsJ
CS8qCj4gKwkJICogQWRkIGF0IHRoZSBoZWFkIG9mIHRoZSBxdWV1ZSB0byByZWZsZWN0IGl0IHdh
cyB0aGUgZWFybGllc3QKPiArCQkgKiBqb2IgZXh0cmFjdGVkLgo+ICsJCSAqLwo+ICsJCWxpc3Rf
YWRkKCZiYWQtPm5vZGUsICZzY2hlZC0+cmluZ19taXJyb3JfbGlzdCk7Cj4gKwo+ICsJLyoKPiAg
CSAqIEl0ZXJhdGUgdGhlIGpvYiBsaXN0IGZyb20gbGF0ZXIgdG8gIGVhcmxpZXIgb25lIGFuZCBl
aXRoZXIgZGVhY3RpdmUKPiAgCSAqIHRoZWlyIEhXIGNhbGxiYWNrcyBvciByZW1vdmUgdGhlbSBm
cm9tIG1pcnJvciBsaXN0IGlmIHRoZXkgYWxyZWFkeQo+ICAJICogc2lnbmFsZWQuCj4gCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
