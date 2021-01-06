Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E472C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 15:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0461B2311B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 15:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0461B2311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5CBC8989A;
	Wed,  6 Jan 2021 15:25:16 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 478E68989A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 15:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 2E9052A6042;
 Wed,  6 Jan 2021 16:25:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id NzqE9R0w8h89; Wed,  6 Jan 2021 16:25:13 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id BE2D52A6016;
 Wed,  6 Jan 2021 16:25:13 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kxAgS-002nZi-Em; Wed, 06 Jan 2021 16:25:12 +0100
To: "Deng, Emily" <Emily.Deng@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
 <20210105083717.468585-3-Emily.Deng@amd.com>
 <CADnq5_MdF6WUTyOWs1NEO_gZtQknwTsGECs-uXVsfLPU8HOhGw@mail.gmail.com>
 <BY5PR12MB411509E4392319DED71623C28FD00@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Message-ID: <43274fba-2ba2-76fc-3f9f-b9af7658af89@daenzer.net>
Date: Wed, 6 Jan 2021 16:25:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB411509E4392319DED71623C28FD00@BY5PR12MB4115.namprd12.prod.outlook.com>
Content-Language: en-CA
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMS0wNiAxMTo0MCBhLm0uLCBEZW5nLCBFbWlseSB3cm90ZToKPj4gRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+Cj4+IE9uIFR1ZSwgSmFuIDUsIDIwMjEg
YXQgMzozNyBBTSBFbWlseS5EZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+IHdyb3RlOgo+Pj4KPj4+
IExpbWl0IHRoZSByZXNvbHV0aW9uIG5vdCBiaWdnZXIgdGhhbiAxNjM4NCwgd2hpY2ggbWVhbnMK
Pj4+IGRldi0+bW9kZV9pbmZvLm51bV9jcnRjICogY29tbW9uX21vZGVzW2ldLncgbm90IGJpZ2dl
ciB0aGFuIDE2Mzg0Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEVtaWx5LkRlbmcgPEVtaWx5LkRl
bmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2Vf
dmlydHVhbC5jIHwgNyArKysrKy0tCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2RjZV92aXJ0dWFsLmMKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGNlX3ZpcnR1YWwuYwo+Pj4gaW5kZXggMmIxNmM4ZmFjYTM0Li5jMjNkMzdiMDJmZDcgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jCj4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jCj4+PiBAQCAtMzE5
LDYgKzMxOSw3IEBAIGRjZV92aXJ0dWFsX2VuY29kZXIoc3RydWN0IGRybV9jb25uZWN0b3IKPj4+
ICpjb25uZWN0b3IpICBzdGF0aWMgaW50IGRjZV92aXJ0dWFsX2dldF9tb2RlcyhzdHJ1Y3QgZHJt
X2Nvbm5lY3Rvcgo+Pj4gKmNvbm5lY3RvcikgIHsKPj4+ICAgICAgICAgIHN0cnVjdCBkcm1fZGV2
aWNlICpkZXYgPSBjb25uZWN0b3ItPmRldjsKPj4+ICsgICAgICAgc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSBkZXYtPmRldl9wcml2YXRlOwo+Pj4gICAgICAgICAgc3RydWN0IGRybV9kaXNw
bGF5X21vZGUgKm1vZGUgPSBOVUxMOwo+Pj4gICAgICAgICAgdW5zaWduZWQgaTsKPj4+ICAgICAg
ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW9kZV9zaXplIHsgQEAgLTM1MCw4ICszNTEsMTAgQEAg
c3RhdGljCj4+PiBpbnQgZGNlX3ZpcnR1YWxfZ2V0X21vZGVzKHN0cnVjdCBkcm1fY29ubmVjdG9y
ICpjb25uZWN0b3IpCj4+PiAgICAgICAgICB9Owo+Pj4KPj4+ICAgICAgICAgIGZvciAoaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKGNvbW1vbl9tb2Rlcyk7IGkrKykgewo+Pj4gLSAgICAgICAgICAgICAg
IG1vZGUgPSBkcm1fY3Z0X21vZGUoZGV2LCBjb21tb25fbW9kZXNbaV0udywKPj4gY29tbW9uX21v
ZGVzW2ldLmgsIDYwLCBmYWxzZSwgZmFsc2UsIGZhbHNlKTsKPj4+IC0gICAgICAgICAgICAgICBk
cm1fbW9kZV9wcm9iZWRfYWRkKGNvbm5lY3RvciwgbW9kZSk7Cj4+PiArICAgICAgICAgICAgICAg
aWYgKGFkZXYtPm1vZGVfaW5mby5udW1fY3J0YyA8PSA0IHx8Cj4+PiArIGNvbW1vbl9tb2Rlc1tp
XS53IDw9IDI1NjApIHsKPj4KPj4gWW91IGFyZSBhbHNvIGxpbWl0aW5nIHRoZSBudW1iZXIgb2Yg
Y3J0Y3MgaGVyZS4gIEludGVuZGVkPyAgV29uJ3QgdGhpcyBicmVhayA1Cj4+IG9yIDYgY3J0YyBj
b25maWdzPwo+Pgo+PiBBbGV4Cj4gWWVzLCBpdCBpcyBpbnRlbmRlZCwgIGZvciBudW1fY3J0YyBi
aWdnZXIgdGhlbiA0LCBkb24ndCBzdXBwb3J0IHJlc29sdXRpb24gYmlnZ2VyIHRoZW4gMjU2MCwg
YmVjYXVzZSBvZiB0aGUgbWF4IHN1cHBvcnRlZCB3aWR0aCBpcyAxNjM4NCBmb3IgeGNiIHByb3Rv
Y29sLgoKVGhlcmUncyBubyBzdWNoIGxpbWl0YXRpb24gd2l0aCBXYXlsYW5kLiBJJ2QgcmVjb21t
ZW5kIGFnYWluc3QgCmFydGlmaWNpYWxseSBpbXBvc2luZyBsaW1pdHMgZnJvbSBYMTEgdG8gdGhl
IGtlcm5lbC4KCgooQXMgYSBzaWRlIG5vdGUsIHRoZSBYMTEgcHJvdG9jb2wgbGltaXQgc2hvdWxk
IGFjdHVhbGx5IGJlIDMyNzY4OyB0aGUgCjE2Mzg0IGxpbWl0IGV4cG9zZWQgaW4gdGhlIFJBTkRS
IGV4dGVuc2lvbiBjb21lcyBmcm9tIHRoZSBrZXJuZWwgZHJpdmVyLCAKc3BlY2lmaWNhbGx5IGRy
bU1vZGVHZXRSZXNvdXJjZXMncyBtYXhfd2lkdGgvaGVpZ2h0KQoKCi0tIApFYXJ0aGxpbmcgTWlj
aGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRoYXQu
Y29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBN
ZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
