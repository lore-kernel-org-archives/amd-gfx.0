Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B0C432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 13:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F5620748
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 13:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F5620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1386E0E4;
	Mon, 18 Nov 2019 13:46:55 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFAF89A9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 13:46:54 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id b18so18114076wrj.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 05:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=YLWvb+aaJwRA1GCHj6hUPZHIwWN27TZDR1393flzbmE=;
 b=qQ2btcGxT0aKX6VPHje9BLKdOq7rW2mL1wqZ9eZz1ACYzWq+Oh2VMeuOH4Z38xtSkH
 NZz/WtlEQ62WOR4arAFERbfaMILEhpK1WW+rZF6nuOCKdZzYzi8OOeSApk7ytf8PtpVC
 /zLiuo+5dZDoeVneTs+RU2LYYY6TMPbzHylF1y4i5ngX+BVdhKKvtB+eB42pRk2jILOw
 zyXHFtJGNeYWqq0yLbrS9RSMM0ovEoxd+6ELDDhLHh3vXr5nW8wf1HWIvQ2R4U8KtfZh
 PLTDeQHtbH82qrbwKJI1RZDtMCSiCxxGUA3+HzIaB3JTONuRZd1DpE2F9kFH5MMRqiBE
 Ka3g==
X-Gm-Message-State: APjAAAUgL5mrozKIKIoIr9wpm5WOLAsiEY22BIC0uyoQJY6SS/zVYZBa
 y3RMGjtZXGOrVMB1b96KCG/yUXPn
X-Google-Smtp-Source: APXvYqz+7KYJwBC+IUqvbwWiP0a/t2G/00Ng/1KynjUkuqwnNqezbS4Xp/zxn6Cq3ESwzeu3UW4C2w==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr28085600wrm.94.1574084813136; 
 Mon, 18 Nov 2019 05:46:53 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i13sm22402922wrp.12.2019.11.18.05.46.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 05:46:52 -0800 (PST)
Subject: Re: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191115174314.73446-1-alex.sierra@amd.com>
 <bd9f76ca-9dc7-6c29-9c41-fc3e0d3c0bf1@amd.com>
 <BL0PR12MB258076EDAE60740E94C92972804D0@BL0PR12MB2580.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b391a2bb-a078-d397-50f9-9f4cd2824cb3@gmail.com>
Date: Mon, 18 Nov 2019 14:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BL0PR12MB258076EDAE60740E94C92972804D0@BL0PR12MB2580.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=YLWvb+aaJwRA1GCHj6hUPZHIwWN27TZDR1393flzbmE=;
 b=RG3D6RKWi/OWLkNPTT+TtTbO+9ibiqQuKNRQy1ohoyz69GI02nqtppurLSslWWQUyv
 S7rZxN2zzyK1/K2ylz6utXx5i7G0GT75PHkwmp10UiD9BnC+gwDJnNftA00pDmcq8Iv+
 zD63LN+C8cZTLvbis2/xUHv6h88otTbTvsiMHKQkxNLdFX4dj5XSLLPIFRXZeWSzE81o
 NPjqH14iDywtYOW4IHs5HDF6gocwGRhHDwKOrQ2p7eFmrBVjyv4NibvVwuP2hdGTxQHg
 4zyO/Wj2mXjwB8BZYWUFP9ui+B93aYS/Jnjv46stVNfSv4Gs/CMDKC1FudAKm8/OR7g+
 Py/Q==
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118134651.vqzW5DvwmZRg0Y1sSpR0hataxaYLKlNkAxm-efIAO7s@z>

SGkgT2FrLAoKd2VsbCB5b3VyIHF1ZXN0aW9ucyBhcmUgcmVhbGx5IHZhbGlkLiBUaGlzIGlzIGEg
Zm9sbG93IHVwIGZyb20gYW4gCmludGVybmFsIGRpc2N1c3Npb24gb24gaG93IHRvIGhhbmRsZSB0
aGUgZGVidWcgdHJhcCBoYW5kbGVyIG9uIFZlZ2EgYW5kIApuZXdlci4KClRoZSBrZXkgbWlzc2lu
ZyBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgdGhhdCB3ZSBhcmUgCmludGVu
dGlvbmFsbHkgdXNpbmcgYW4gaW52YWxpZCBjb21iaW5hdGlvbiBvZiBmbGFncyAoRiBhbmQgUCBz
ZXQgYXQgdGhlIApzYW1lIHRpbWUpIHRvIHRyaWdnZXIgYSBuby1yZXRyeSBmYXVsdC4KClRoaXMg
aXMgdXNlZCB3aXRoIHRoZSBkZWJ1ZyB0cmFwIGhhbmRsZXIgdG8gZW50ZXIgZGVidWdnaW5nIHdo
ZW4gYW4gCmFwcGxpY2F0aW9uIGFjY2Vzc2VzIGFuIGludmFsaWQgYWRkcmVzcyBvbiB0aGUgR1BV
LgoKT3RoZXJ3aXNlIHdlIHdvdWxkIGp1c3QgcmUtdHJ5IHRoZSBhY2Nlc3Mgb3ZlciBhbmQgb3Zl
ciBhZ2FpbiBiZWNhdXNlIAp0aGUgaGFyZHdhcmUgdGhpbmtzIHRoYXQgdGhpcyBpcyBmb3IgcGFn
ZSBtaWdyYXRpb24uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAxOC4xMS4xOSB1bSAwNDo0MiBz
Y2hyaWViIFplbmcsIE9hazoKPiBIaSBQaGlsaXAvQWxleCwKPgo+IEkgZm91bmQgSSBjYW4ndCB1
bmRlcnN0YW5kIHRoaXMgcGF0Y2ggd2l0aG91dCBtb3JlIGRldGFpbHMgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLiBJcyB0aGlzIHByZXBhcmF0aW9uIHdvcmsgZm9yIHRoZSBwYWdlIG1pZ3JhdGlvbj8g
V2h5IHNldHRpbmcgdGhlIHRyYW5zbGF0aW9uIGZ1cnRoZXIgYml0IGNhbiBmb3JjZSBhIG5vLXJl
dHJ5LWZhdWx0PyBXb24ndCBzZXR0aW5nIHRoaXMgYml0IGNhdXNlIFVUQ0wyIHRyZWF0IHRoZSBQ
VEUgYXMgYSBQREUgYW5kIGNvbnRpbnVlIHRvIHdhbGsgdG8gdGhlIFBURSB0aGF0IHRoaXMgUFRF
IHBvaW50aW5nIHRvPyBCdXQgZnJvbSB0aGUgcGF0Y2ggYmVsb3csIHRoZSBuZXh0IGxldmVsIG9m
IFBURSAocHNldWRvbHkgdGhlIDV0aCBsZXZlbCBwYWdlIHRhYmxlKSBpcyBub3Qgc2V0Lgo+Cj4g
V2h5IHRoaXMgc2V0dGluZyB3aWxsIGNhdXNlIHRoZSB3YXZlIHRvIGVudGVyIHRyYXAgaGFuZGxl
cj8gQXMgSSB1bmRlcnN0YW5kIGl0LCB3YXZlIGVudGVycyB0cmFwIGhhbmRsZXIgKHNhdmluZyBj
b250ZXh0KSBlaXRoZXIgaXQgZW5jb3VudGVyIGEgc190cmFwIGluc3RydWN0aW9uLCBvciBDUCBj
YW4gaW5pdGlhbGl6ZSBzdXNwZW5zaW9uIHRvIHByZWVtcHQgdGhlIHJ1bm5pbmcgd2F2ZXMsIG9y
IGNvbnRleHQgc3dpdGNoIGNhbiBiZSB0cmlnZ2VyZWQgYnkgY2VydGFpbiBjb3VudGVyIChtb25p
dG9yZWQgYnkgU1BJKS4KPgo+IEZ1cnRoZXIgcXVlc3Rpb24gd2lsbCBiZSwgd2hhdCBpcyB0aGUg
cGxhbm5lZCBwYWdlIG1pZ3JhdGlvbiBwcm9jZXNzPyBIYWx0IHdhdmUvc2F2ZSBjb250ZXh0IC0+
IG1pZ3JhdGUgcGFnZS91cGRhdGUgcGFnZSB0YWJsZS0+IHJlc3RvcmUgd2F2ZT8KPgo+IEFsc28g
d2hlbiBJIGNoZWNrIG5hdmkxMCBHUFVWTSBwcm9ncmFtbWluZyBndWlkZSwgaXQgY2xlYXJseSBz
YXlzIHRoYXQgY3VycmVudGx5IHRoZSBUcmFuc2xhdGUgRnVydGhlciAoRikgb3B0aW9uIGNhbm5v
dCBiZSB1c2VkIGluIGNvbmNlcnQgd2l0aCB0aGUgUERFIGFzIFBURSAoUCkgb3B0aW9uLiBCdXQg
dGhpcyBwYXRjaCBzZXQgRiBhbmQgUC4KPgo+IFNvcnJ5IGZvciB0b28gbWFueSBxdWVzdGlvbnMu
Cj4KPiBSZWdhcmRzLAo+IE9hawo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9t
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhh
bGYgT2YgUGhpbGlwIFlhbmcKPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE1LCAyMDE5IDE6MDQg
UE0KPiBUbzogU2llcnJhIEd1aXphLCBBbGVqYW5kcm8gKEFsZXgpIDxBbGV4LlNpZXJyYUBhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBhbWQvYW1kZ3B1OiBmb3JjZSB0byB0cmlnZ2VyIGEgbm8tcmV0cnktZmF1bHQgYWZ0ZXIgYSBy
ZXRyeS1mYXVsdAo+Cj4gT25lIHN1Z2dlc3Rpb24gYmVsb3csIG1vdmUgdGhlIGZsYWdzIHNldHRp
bmcgZm9yIGVsc2UgcGF0aCBpbnRvIGVsc2UgcGF0aCBsb29rcyBiZXR0ZXIuCj4KPiBQaGlsaXAK
Pgo+IE9uIDIwMTktMTEtMTUgMTI6NDMgcC5tLiwgQWxleCBTaWVycmEgd3JvdGU6Cj4+IEFmdGVy
IGEgcmV0cnktZmF1bHQgaGFwcGVucywgdGhlIGZhdWx0IGhhbmRsZXIgd2lsbCBtb2RpZnkgdGhl
IFVUQ0wyCj4+IHRvIHNldCBQVEUgYml0cyB0byBmb3JjZSBhIG5vLXJldHJ5LWZhdWx0LiBUaGlz
IHdpbGwgY2F1c2UgdGhlIHdhdmUgdG8KPj4gZW50ZXIgdGhlIHRyYXAgaGFuZGxlci4KPj4KPj4g
Q2hhbmdlLUlkOiBJMTc3MTAyODkxZjcxNTA2OGYxNTYwNTk1N2ZmMjNiMGNhYjg2MjYwMwo+PiBT
aWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KPj4gLS0tCj4+
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTMgKysrKystLS0t
LS0tLQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBpbmRleCAz
YzBiZDY0NzJhNDYuLmU0ZDFhOGZjOTdkNSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKPj4gQEAgLTMxNjcsNyArMzE2Nyw4IEBAIGJvb2wgYW1kZ3B1X3ZtX2hh
bmRsZV9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgaW50IHBhc2lk
LAo+PiAgICAJCQkgICAgdWludDY0X3QgYWRkcikKPj4gICAgewo+PiAgICAJc3RydWN0IGFtZGdw
dV9ibyAqcm9vdDsKPj4gLQl1aW50NjRfdCB2YWx1ZSwgZmxhZ3M7Cj4+ICsJdWludDY0X3QgdmFs
dWUgPSAwOwo+PiArCXVpbnQ2NF90IGZsYWdzOwo+PiAgICAJc3RydWN0IGFtZGdwdV92bSAqdm07
Cj4+ICAgIAlsb25nIHI7Cj4+ICAgIAo+PiBAQCAtMzIwMCwxMyArMzIwMSw5IEBAIGJvb2wgYW1k
Z3B1X3ZtX2hhbmRsZV9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQg
aW50IHBhc2lkLAo+PiAgICAJCUFNREdQVV9QVEVfU1lTVEVNOwo+PiAgICAKPiAgID4tCWZsYWdz
ID0gQU1ER1BVX1BURV9WQUxJRCB8IEFNREdQVV9QVEVfU05PT1BFRCB8Cj4gICA+LQkJQU1ER1BV
X1BURV9TWVNURU07Cj4gICA+Cj4+ICAgIAlpZiAoYW1kZ3B1X3ZtX2ZhdWx0X3N0b3AgPT0gQU1E
R1BVX1ZNX0ZBVUxUX1NUT1BfTkVWRVIpIHsKPj4gLQkJLyogUmVkaXJlY3QgdGhlIGFjY2VzcyB0
byB0aGUgZHVtbXkgcGFnZSAqLwo+PiAtCQl2YWx1ZSA9IGFkZXYtPmR1bW15X3BhZ2VfYWRkcjsK
Pj4gLQkJZmxhZ3MgfD0gQU1ER1BVX1BURV9FWEVDVVRBQkxFIHwgQU1ER1BVX1BURV9SRUFEQUJM
RSB8Cj4+IC0JCQlBTURHUFVfUFRFX1dSSVRFQUJMRTsKPiAgID4gKwkJLyogU2V0dGluZyBQVEUg
ZmxhZ3MgdG8gdHJpZ2dlciBhIG5vLXJldHJ5LWZhdWx0ICAqLwo+ICAgPiArCQlmbGFncyA9IEFN
REdQVV9QVEVfRVhFQ1VUQUJMRSB8IEFNREdQVV9QREVfUFRFIHwKPiAgID4gKwkJCUFNREdQVV9Q
VEVfVEY7Cj4gCX0gZWxzZSB7Cj4+IC0JCXZhbHVlID0gMDsKPiAgID4rCQlmbGFncyA9IEFNREdQ
VV9QVEVfVkFMSUQgfCBBTURHUFVfUFRFX1NOT09QRUQgfAo+ICAgPisJCQlBTURHUFVfUFRFX1NZ
U1RFTTsKPiAgID4gICAJfQo+Cj4+ICAgIAo+PiAgICAJciA9IGFtZGdwdV92bV9ib191cGRhdGVf
bWFwcGluZyhhZGV2LCB2bSwgdHJ1ZSwgTlVMTCwgYWRkciwgYWRkciArCj4+IDEsCj4+Cj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
