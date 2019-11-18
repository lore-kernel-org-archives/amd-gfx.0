Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7CC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 08:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFACD2071C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 08:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFACD2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB39A6E0F1;
	Mon, 18 Nov 2019 08:37:11 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892B46E03E;
 Mon, 18 Nov 2019 07:16:58 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F2F5518BF4F6297890BF;
 Mon, 18 Nov 2019 15:16:53 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0;
 Mon, 18 Nov 2019 15:16:49 +0800
Subject: Re: [PATCH] drm/amd/powerplay: remove variable 'result' set but not
 used
To: "Quan, Evan" <Evan.Quan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
 <MN2PR12MB3344A9DA952F41ADDAD6142AE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Chen Wandun <chenwandun@huawei.com>
Message-ID: <71d72dc4-5dae-2ae4-9f10-89cca72458da@huawei.com>
Date: Mon, 18 Nov 2019 15:16:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB3344A9DA952F41ADDAD6142AE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.173.221.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 18 Nov 2019 08:37:06 +0000
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118071632.KL5OKEVRX93VU6kaTprxaGIDznYe4l47aVr7EvloHx0@z>

T0ssIGl0IGluZGVlZCBzaG91bGQgcmV0dXJuIHRoZSAncmVzdWx0JyB0byBjYWxsZXIsCkkgd2ls
bCBtYWtlIGEgbW9kaWZpY2F0aW9uIGFuZCByZXBvc3QgdGhlIHBhdGNoLgoKVGhhbmtzCkNoZW4g
V2FuZHVuCgpPbiAyMDE5LzExLzE4IDE0OjUwLCBRdWFuLCBFdmFuIHdyb3RlOgo+IFRoYW5rcy4g
QnV0IGl0J3MgYmV0dGVyIHRvIHJldHVybiB0aGUgJ3Jlc3VsdCcgb3V0IG9uICdyZXN1bHQgIT0g
MCcuCj4gCj4gUmVnYXJkcywKPiBFdmFuCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBG
cm9tOiBDaGVuIFdhbmR1biA8Y2hlbndhbmR1bkBodWF3ZWkuY29tPgo+IFNlbnQ6IFNhdHVyZGF5
LCBOb3ZlbWJlciAxNiwgMjAxOSAxMTo0MyBBTQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGNoZW53YW5kdW5AaHVh
d2VpLmNvbQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wb3dlcnBsYXk6IHJlbW92ZSB2YXJp
YWJsZSAncmVzdWx0JyBzZXQgYnV0IG5vdCB1c2VkCj4gCj4gRml4ZXMgZ2NjICctV3VudXNlZC1i
dXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgo+IAo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmM6IEluIGZ1bmN0aW9uIHZlZ2FtX3Bv
cHVsYXRlX3NtY19ib290X2xldmVsOgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bv
d2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmM6MTM2NDo2OiB3YXJuaW5nOiB2YXJpYWJsZSBy
ZXN1bHQgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBDaGVuIFdhbmR1biA8Y2hlbndhbmR1bkBodWF3ZWkuY29tPgo+IC0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3ZlZ2FtX3NtdW1nci5jIHwg
MTMgKysrKysrLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvc211bWdyL3ZlZ2FtX3NtdW1nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
c211bWdyL3ZlZ2FtX3NtdW1nci5jCj4gaW5kZXggMjA2OGViMC4uZmFkNzhiZiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdy
LmMKPiBAQCAtMTM2MSwyMCArMTM2MSwxOSBAQCBzdGF0aWMgaW50IHZlZ2FtX3BvcHVsYXRlX3Nt
Y191dmRfbGV2ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwKPiAgIHN0YXRpYyBpbnQgdmVnYW1f
cG9wdWxhdGVfc21jX2Jvb3RfbGV2ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwKPiAgIAkJc3Ry
dWN0IFNNVTc1X0Rpc2NyZXRlX0RwbVRhYmxlICp0YWJsZSkKPiAgIHsKPiAtCWludCByZXN1bHQg
PSAwOwo+ICAgCXN0cnVjdCBzbXU3X2h3bWdyICpkYXRhID0gKHN0cnVjdCBzbXU3X2h3bWdyICop
KGh3bWdyLT5iYWNrZW5kKTsKPiAgIAo+ICAgCXRhYmxlLT5HcmFwaGljc0Jvb3RMZXZlbCA9IDA7
Cj4gICAJdGFibGUtPk1lbW9yeUJvb3RMZXZlbCA9IDA7Cj4gICAKPiAgIAkvKiBmaW5kIGJvb3Qg
bGV2ZWwgZnJvbSBkcG0gdGFibGUgKi8KPiAtCXJlc3VsdCA9IHBobV9maW5kX2Jvb3RfbGV2ZWwo
JihkYXRhLT5kcG1fdGFibGUuc2Nsa190YWJsZSksCj4gLQkJCWRhdGEtPnZiaW9zX2Jvb3Rfc3Rh
dGUuc2Nsa19ib290dXBfdmFsdWUsCj4gLQkJCSh1aW50MzJfdCAqKSYodGFibGUtPkdyYXBoaWNz
Qm9vdExldmVsKSk7Cj4gKwlwaG1fZmluZF9ib290X2xldmVsKCYoZGF0YS0+ZHBtX3RhYmxlLnNj
bGtfdGFibGUpLAo+ICsJCQkgICAgZGF0YS0+dmJpb3NfYm9vdF9zdGF0ZS5zY2xrX2Jvb3R1cF92
YWx1ZSwKPiArCQkJICAgICh1aW50MzJfdCAqKSYodGFibGUtPkdyYXBoaWNzQm9vdExldmVsKSk7
Cj4gICAKPiAtCXJlc3VsdCA9IHBobV9maW5kX2Jvb3RfbGV2ZWwoJihkYXRhLT5kcG1fdGFibGUu
bWNsa190YWJsZSksCj4gLQkJCWRhdGEtPnZiaW9zX2Jvb3Rfc3RhdGUubWNsa19ib290dXBfdmFs
dWUsCj4gLQkJCSh1aW50MzJfdCAqKSYodGFibGUtPk1lbW9yeUJvb3RMZXZlbCkpOwo+ICsJcGht
X2ZpbmRfYm9vdF9sZXZlbCgmKGRhdGEtPmRwbV90YWJsZS5tY2xrX3RhYmxlKSwKPiArCQkJICAg
IGRhdGEtPnZiaW9zX2Jvb3Rfc3RhdGUubWNsa19ib290dXBfdmFsdWUsCj4gKwkJCSAgICAodWlu
dDMyX3QgKikmKHRhYmxlLT5NZW1vcnlCb290TGV2ZWwpKTsKPiAgIAo+ICAgCXRhYmxlLT5Cb290
VmRkYyAgPSBkYXRhLT52Ymlvc19ib290X3N0YXRlLnZkZGNfYm9vdHVwX3ZhbHVlICoKPiAgIAkJ
CVZPTFRBR0VfU0NBTEU7Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
