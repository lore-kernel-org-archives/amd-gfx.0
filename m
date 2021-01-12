Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CA7C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B1F22D2A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B1F22D2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E03E6E17F;
	Tue, 12 Jan 2021 09:17:04 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A446E17F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:17:03 +0000 (UTC)
Received: from [192.168.0.6] (ip5f5aed06.dynamic.kabel-deutschland.de
 [95.90.237.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5815320645D7C;
 Tue, 12 Jan 2021 10:17:00 +0100 (CET)
Subject: Re: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset
To: Jack Zhang <Jack.Zhang1@amd.com>
References: <20210107104656.24107-1-Jack.Zhang1@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <f83fb269-7d37-b3bf-a6e9-d39cac9f61d6@molgen.mpg.de>
Date: Tue, 12 Jan 2021 10:16:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107104656.24107-1-Jack.Zhang1@amd.com>
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
Cc: jazha@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBKYWNrLAoKClRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4KClBsZWFzZSBhZGQgYSBjb2xv
biBhZnRlciBhbWRncHUvc3Jpb3YgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHN1bW1hcnkuCgpBbSAw
Ny4wMS4yMSB1bSAxMTo0NiBzY2hyaWViIEphY2sgWmhhbmc6Cj4gW1doeV0KPiBXaGVuIGhvc3Qg
dHJpZ2dlciBhIHdob2xlIGdwdSByZXNldCwgZ3Vlc3Qgd2lsbCBrZWVwCgoqaG9zdHMgdHJpZ2dl
ciogb3IgKmhvc3QgdHJpZ2dlcnMqCgo+IHdhaXRpbmcgdGlsbCBob3N0IGZpbmlzaCByZXNldC4g
QnV0IHRoZXJlJ3MgYSB3b3JrCgpmaW5pc2hlcwoKPiBxdWV1ZSBpbiBndWVzdCBleGNoYW5naW5n
IGRhdGEgYmV0d2VlbiB2ZiZwZiB3aGljaCBuZWVkCgpuZWVkcwoKPiB0byBhY2Nlc3MgZnJhbWUg
YnVmZmVyLiBEdXJpbmcgd2hvbGUgZ3B1IHJlc2V0LCBmcmFtZQo+IGJ1ZmZlciBpcyBub3QgYWNj
ZXNzYWJsZSwgYW5kIHRoaXMgY2F1c2VzIHRoZSBjYWxsIHRyYWNlLgoKYWNjZXNzaWJsZSAoYSBz
cGVsbCBjaGVja2VyIHNob3VsZCBoYXZlIGNhdWdodCB0aGF0KQoKQ2FuIHlvdSBwbGVhc2UgcGFz
dGUgcGFydCBvZiB0aGUgdHJhY2UsIHNvIGl04oCZcyBlYXNpbHkgZmluZGFibGUgYnkgdXNlcnMg
CnJ1bm5pbmcgaW50byB0aGlzLgoKPiBbSG93XQo+IEFmdGVyIHZmIGdldCByZXNldCBub3RpZmlj
YXRpb24gZnJvbSBwZiwgc3RvcCBkYXRhIGV4Y2hhbmdlLgoKSG93IGNhbiB0aGlzIGJlIHJlcHJv
ZHVjZWQgYW5kIHRlc3RlZD8KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCgoKPiBTaWduZWQtb2ZmLWJ5
OiBKaW5nd2VuIENoZW4gPEppbmd3ZW4uQ2hlbjJAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBK
YWNrIFpoYW5nIDxKYWNrLlpoYW5nMUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyB8IDEgKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbXhncHVfYWkuYyAgICB8IDEgKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bXhncHVfbnYuYyAgICB8IDEgKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMKPiBpbmRleCA4M2Nh
NWNiZmZlMmMuLjNlMjEyODYyY2Y1ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmlydC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZpcnQuYwo+IEBAIC01NzEsNiArNTcxLDcgQEAgdm9pZCBhbWRncHVfdmlydF9maW5p
X2RhdGFfZXhjaGFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCURSTV9JTkZP
KCJjbGVhbiB1cCB0aGUgdmYycGYgd29yayBpdGVtXG4iKTsKPiAgIAkJZmx1c2hfZGVsYXllZF93
b3JrKCZhZGV2LT52aXJ0LnZmMnBmX3dvcmspOwo+ICAgCQljYW5jZWxfZGVsYXllZF93b3JrX3N5
bmMoJmFkZXYtPnZpcnQudmYycGZfd29yayk7Cj4gKwkJYWRldi0+dmlydC52ZjJwZl91cGRhdGVf
aW50ZXJ2YWxfbXMgPSAwOwo+ICAgCX0KPiAgIH0KPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbXhncHVfYWkuYwo+IGluZGV4IDc3NjdjY2NhNTI2Yi4uM2VlNDgxNTU3ZmM5IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jCj4gQEAgLTI1NSw2ICsyNTUsNyBAQCBz
dGF0aWMgdm9pZCB4Z3B1X2FpX21haWxib3hfZmxyX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQo+ICAgCWlmICghZG93bl9yZWFkX3RyeWxvY2soJmFkZXYtPnJlc2V0X3NlbSkpCj4gICAJ
CXJldHVybjsKPiAgIAo+ICsJYW1kZ3B1X3ZpcnRfZmluaV9kYXRhX2V4Y2hhbmdlKGFkZXYpOwo+
ICAgCWF0b21pY19zZXQoJmFkZXYtPmluX2dwdV9yZXNldCwgMSk7Cj4gICAKPiAgIAlkbyB7Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X252LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9udi5jCj4gaW5kZXggZGQ1YzFlNmNlMDA5Li40
OGU1ODhkM2M0MDkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhn
cHVfbnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X252LmMKPiBA
QCAtMjc2LDYgKzI3Niw3IEBAIHN0YXRpYyB2b2lkIHhncHVfbnZfbWFpbGJveF9mbHJfd29yayhz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gICAJaWYgKCFkb3duX3JlYWRfdHJ5bG9jaygmYWRl
di0+cmVzZXRfc2VtKSkKPiAgIAkJcmV0dXJuOwo+ICAgCj4gKwlhbWRncHVfdmlydF9maW5pX2Rh
dGFfZXhjaGFuZ2UoYWRldik7Cj4gICAJYXRvbWljX3NldCgmYWRldi0+aW5fZ3B1X3Jlc2V0LCAx
KTsKPiAgIAo+ICAgCWRvIHsKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
