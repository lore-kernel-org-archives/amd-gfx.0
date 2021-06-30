Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBBDC11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448176135D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448176135D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B756E994;
	Wed, 30 Jun 2021 11:08:33 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7F4FF89E43
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 11:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 0F2BC20201B;
 Wed, 30 Jun 2021 13:08:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id nmBv522cMARa; Wed, 30 Jun 2021 13:08:30 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id A723E20201A;
 Wed, 30 Jun 2021 13:08:30 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1lyY4y-000s7F-NC; Wed, 30 Jun 2021 13:08:29 +0200
To: Hawking Zhang <Hawking.Zhang@amd.com>
References: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
 <1623395146-2162-6-git-send-email-Hawking.Zhang@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 6/8] drm/amdgpu: add helper function to query psp runtime
 db entry (v2)
Message-ID: <a73c6d35-edb0-d2b5-e98a-778e132f7b4b@daenzer.net>
Date: Wed, 30 Jun 2021 13:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623395146-2162-6-git-send-email-Hawking.Zhang@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0xMSA5OjA1IGEubS4sIEhhd2tpbmcgWmhhbmcgd3JvdGU6Cj4gUFNQIHdpbGwg
ZHVtcCB2YXJpb3VzIGJvb3QgdXAgaW5mb3JtYXRpb24gaW50byBhCj4gcG9ydGlvbiBvZiBsb2Nh
bCBmcmFtZSBidWZmZXIsIGNhbGxlZCBydW50aW1lIGRhdGFiYXNlLgo+IFRoZSBoZWxwZXIgZnVu
Y3Rpb24gaXMgdXNlZCBmb3IgZHJpdmVyIHRvIHF1ZXJ5IHRob3NlCj4gc2hhcmVkIGluZm9ybWF0
aW9uLgo+IAo+IHYyOiBpbml0IHJldCBhbmQgY2hlY2sgIXJldCB0byBleGl0IGxvb3AgYXMgc29v
biBhcwo+IGZvdW5kIHRoZSBlbnRyeQo+IAo+IFNpZ25lZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcg
PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogSm9obiBDbGVtZW50cyA8am9o
bi5jbGVtZW50c0BhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFy
QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YyB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDY4IGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4g
aW5kZXggYWI0ZTg5MTg2MTg2Li5kYzc4NmM5MWVjOWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gQEAgLTE2NCw2ICsxNjQsNzQgQEAgc3RhdGljIGludCBw
c3BfbWVtb3J5X3RyYWluaW5nX2luaXQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gIAlyZXR1
cm4gcmV0Owo+ICB9Cj4gIAo+ICsvKgo+ICsgKiBIZWxwZXIgZnVuY2l0b24gdG8gcXVlcnkgcHNw
IHJ1bnRpbWUgZGF0YWJhc2UgZW50cnkKPiArICoKPiArICogQGFkZXY6IGFtZGdwdV9kZXZpY2Ug
cG9pbnRlcgo+ICsgKiBAZW50cnlfdHlwZTogdGhlIHR5cGUgb2YgcHNwIHJ1bnRpbWUgZGF0YWJh
c2UgZW50cnkKPiArICogQGRiX2VudHJ5OiBydW50aW1lIGRhdGFiYXNlIGVudHJ5IHBvaW50ZXIK
PiArICoKPiArICogUmV0dXJuIGZhbHNlIGlmIHJ1bnRpbWUgZGF0YWJhc2UgZG9lc24ndCBleGl0
IG9yIGVudHJ5IGlzIGludmFsaWQKPiArICogb3IgdHJ1ZSBpZiB0aGUgc3BlY2lmaWMgZGF0YWJh
c2UgZW50cnkgaXMgZm91bmQsIGFuZCBjb3B5IHRvIEBkYl9lbnRyeQo+ICsgKi8KPiArc3RhdGlj
IGJvb2wgcHNwX2dldF9ydW50aW1lX2RiX2VudHJ5KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+ICsJCQkJICAgICBlbnVtIHBzcF9ydW50aW1lX2VudHJ5X3R5cGUgZW50cnlfdHlwZSwKPiAr
CQkJCSAgICAgdm9pZCAqZGJfZW50cnkpCj4gK3sKPiArCXVpbnQ2NF90IGRiX2hlYWRlcl9wb3Ms
IGRiX2Rpcl9wb3M7Cj4gKwlzdHJ1Y3QgcHNwX3J1bnRpbWVfZGF0YV9oZWFkZXIgZGJfaGVhZGVy
ID0gezB9Owo+ICsJc3RydWN0IHBzcF9ydW50aW1lX2RhdGFfZGlyZWN0b3J5IGRiX2RpciA9IHsw
fTsKPiArCWJvb2wgcmV0ID0gZmFsc2U7Cj4gKwlpbnQgaTsKPiArCj4gKwlkYl9oZWFkZXJfcG9z
ID0gYWRldi0+Z21jLm1jX3ZyYW1fc2l6ZSAtIFBTUF9SVU5USU1FX0RCX09GRlNFVDsKPiArCWRi
X2Rpcl9wb3MgPSBkYl9oZWFkZXJfcG9zICsgc2l6ZW9mKHN0cnVjdCBwc3BfcnVudGltZV9kYXRh
X2hlYWRlcik7Cj4gKwo+ICsJLyogcmVhZCBydW50aW1lIGRiIGhlYWRlciBmcm9tIHZyYW0gKi8K
PiArCWFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3MoYWRldiwgZGJfaGVhZGVyX3BvcywgKHVpbnQz
Ml90ICopJmRiX2hlYWRlciwKPiArCQkJc2l6ZW9mKHN0cnVjdCBwc3BfcnVudGltZV9kYXRhX2hl
YWRlciksIGZhbHNlKTsKPiArCj4gKwlpZiAoZGJfaGVhZGVyLmNvb2tpZSAhPSBQU1BfUlVOVElN
RV9EQl9DT09LSUVfSUQpIHsKPiArCQkvKiBydW50aW1lIGRiIGRvZXNuJ3QgZXhpc3QsIGV4aXQg
Ki8KPiArCQlkZXZfd2FybihhZGV2LT5kZXYsICJQU1AgcnVudGltZSBkYXRhYmFzZSBkb2Vzbid0
IGV4aXN0XG4iKTsKPiArCQlyZXR1cm4gZmFsc2U7Cj4gKwl9CgpJIGp1c3Qgbm90aWNlZCB0aGlz
IG1lc3NhZ2UgaW4gdGhlIG91dHB1dCBvZgoKIGRtZXNnIC1sIGVtZXJnLGFsZXJ0LGNyaXQsZXJy
LHdhcm4KCkkgd29uZGVyIGlmIHRoZXNlIG1lc3NhZ2VzIHJlYWxseSBuZWVkIHRvIGJlIHByaW50
ZWQgYnkgZGVmYXVsdCBhdCBhbGwsIGxldCBhbG9uZSBhdCB3YXJuaW5nIGxldmVsLiBEbyB0aGV5
IGluZGljYXRlIGFuIGlzc3VlIHdoaWNoIG5lZWRzIHRvIGJlIGFkZHJlc3NlZD8KCgo+ICsJLyog
cmVhZCBydW50aW1lIGRhdGFiYXNlIGVudHJ5IGZyb20gdnJhbSAqLwo+ICsJYW1kZ3B1X2Rldmlj
ZV92cmFtX2FjY2VzcyhhZGV2LCBkYl9kaXJfcG9zLCAodWludDMyX3QgKikmZGJfZGlyLAo+ICsJ
CQlzaXplb2Yoc3RydWN0IHBzcF9ydW50aW1lX2RhdGFfZGlyZWN0b3J5KSwgZmFsc2UpOwo+ICsK
PiArCWlmIChkYl9kaXIuZW50cnlfY291bnQgPj0gUFNQX1JVTlRJTUVfREJfRElBR19FTlRSWV9N
QVhfQ09VTlQpIHsKPiArCQkvKiBpbnZhbGlkIGRiIGVudHJ5IGNvdW50LCBleGl0ICovCj4gKwkJ
ZGV2X3dhcm4oYWRldi0+ZGV2LCAiSW52YWxpZCBQU1AgcnVudGltZSBkYXRhYmFzZSBlbnRyeSBj
b3VudFxuIik7Cj4gKwkJcmV0dXJuIGZhbHNlOwo+ICsJfQoKCi0tIApFYXJ0aGxpbmcgTWljaGVs
IETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29t
CkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNh
IGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
