Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3B5C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 19:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DA12173E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 19:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DA12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC7A6E06B;
	Fri,  6 Dec 2019 19:41:31 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF16E6E06B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 19:41:29 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so8494419wma.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2019 11:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=xJ1tph60kpvMrEqHuFBzr65oQEHfyZTM2F8oQwcBmI4=;
 b=NJhAReAoR9vrxwwqw0qe4PzmDWG85I/mfTwRa3QFvKERQJOIl/EQ4yfN+N8LkT/YDl
 LTMIxfWb7oXAbfBuuidkFNJWnNUuD+ogNqtjJJdx47o2LCIX2HmuLnHv4H4CCFSPog0w
 I+bWbmCzD/RTacNFhcGvwDdOQ98A95B6N79tCmWRRJGZ6RA5v1uE6NQhu3MjzPnNEzQd
 cVBpEhQcjzZPObrZvRmbWRXgwsa2QaxjIu33cDI14ZBKgWhfxKBm5eaDmsWRY7e484Up
 9zTyrFB+F8rHN9SrZ3DQPybAEOMljYiCkJbTrZ6B8FW8iUr4DM1FnG8/Cb00eHp/Ut23
 xEOw==
X-Gm-Message-State: APjAAAX4bB69M3VoYEJKtE8h4DhS1fDm5rC+EXtZ0kjmxNA7gQm5+/tA
 N/4GB8jV+ZSgWl8mSnZhv9aQqAXU
X-Google-Smtp-Source: APXvYqyheWHMjSYoQAnOJicOGsRsL8+AokRufUe7aS8aAS9TibF6Emhz6PQqoR3w9DvFYzOkWgR0cQ==
X-Received: by 2002:a05:600c:a:: with SMTP id
 g10mr11835017wmc.69.1575661288327; 
 Fri, 06 Dec 2019 11:41:28 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s19sm4105138wmj.33.2019.12.06.11.41.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Dec 2019 11:41:27 -0800 (PST)
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, alexander.deucher@amd.com,
 kenny.ho@amd.com, christian.koenig@amd.com
References: <20191206173304.3025-1-nirmoy.das@amd.com>
 <20191206173304.3025-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6cc23df3-97f7-f961-12f3-d99677cd5304@gmail.com>
Date: Fri, 6 Dec 2019 20:41:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191206173304.3025-4-nirmoy.das@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xJ1tph60kpvMrEqHuFBzr65oQEHfyZTM2F8oQwcBmI4=;
 b=hVLuqValLZLcCUdKFVxaMRGYj62hhZYfWmwkSZiKb7jMr8eMQUbNQr26H6wQaWsvAJ
 bsHD8GTfCM7OI6Mxqk0WZPR1YXhW+PxHMRBopV9b7G6DhXSVMLp4m5c3NRdgBg6CTdR8
 sNky0W9DL8IvtAa/4ylsxlJa4LY5XAdZNeHcMxrDoz0BOoq6RfLwoAtHbb6e0z5GVex0
 wPYLhf5XRSq007UqrTNQPenRbzZ9y7xsgRURWGxlIgE0BfuOFMWU83fwCFCcqN5R8Vk0
 fQ1zlq9Dqnajfl/urqIa4iXFk+PnvrPiHUGfdRzYNLxJYJ6F9pGNMYovXnVgwKoN6G30
 gcTg==
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMTIuMTkgdW0gMTg6MzMgc2NocmllYiBOaXJtb3kgRGFzOgo+IGVudGl0eSBzaG91bGQg
bm90IGtlZXAgY29weSBhbmQgbWFpbnRhaW4gc2NoZWQgbGlzdCBmb3IKPiBpdHNlbGYuCgpUaGF0
IGlzIGEgZ29vZCBzdGVwLCBidXQgd2UgbmVlZCB0byB0YWtlIHRoaXMgZnVydGhlci4KClRoZSBz
Y2hlZF9saXN0IGlzIHN0YXRpYyBmb3IgdGhlIHdob2xlIGRldmljZSBhbmQgd2Ugc2hvdWxkbid0
IGFsbG9jYXRlIAppdCBpbnNpZGUgdGhlIGNvbnRleHQgYXQgYWxsLgoKQ2hyaXN0aWFuLgoKPgo+
IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyAgfCAxMSArKysrKysrKy0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oICB8ICAxICsKPiAg
IGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgfCAxMiArLS0tLS0tLS0t
LS0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gaW5kZXggYzc2NDNh
Zjg4MjdmLi4xOTM5YjQxNGQyM2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2N0eC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2N0eC5jCj4gQEAgLTcxLDcgKzcxLDYgQEAgc3RhdGljIGludCBhbWRncHVfY3R4X3ByaW9y
aXR5X3Blcm1pdChzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsCj4gICBzdGF0aWMgaW50IGFtZGdwdV9j
dHhfaW5pdF9lbnRpdHkoc3RydWN0IGFtZGdwdV9jdHggKmN0eCwgdTMyIGh3X2lwKQo+ICAgewo+
ICAgCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZ3NbQU1ER1BVX01BWF9SSU5HU107Cj4gLQlzdHJ1
Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkX2xpc3RbQU1ER1BVX01BWF9SSU5HU107Cj4gICAJ
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBjdHgtPmFkZXY7Cj4gICAJdW5zaWduZWQgbnVt
X3JpbmdzID0gMDsKPiAgIAl1bnNpZ25lZCBudW1fc2NoZWRzID0gMDsKPiBAQCAtMTI5LDE2ICsx
MjgsMjEgQEAgc3RhdGljIGludCBhbWRncHVfY3R4X2luaXRfZW50aXR5KHN0cnVjdCBhbWRncHVf
Y3R4ICpjdHgsIHUzMiBod19pcCkKPiAgIAkJCWJyZWFrOwo+ICAgCX0KPiAgIAo+ICsJY3R4LT5z
Y2hlZF9saXN0ID0ga2NhbGxvYyhudW1fcmluZ3MsCj4gKwkJCQkgIHNpemVvZihzdHJ1Y3QgZHJt
X2dwdV9zY2hlZHVsZXIgKiksIEdGUF9LRVJORUwpOwo+ICsJaWYgKGN0eC0+c2NoZWRfbGlzdCA9
PSBOVUxMICkKPiArCQlyZXR1cm4gLUVOT01FTTsKPiArCj4gICAJZm9yIChpID0gMDsgaSA8IG51
bV9yaW5nczsgKytpKSB7Cj4gICAJCWlmICghcmluZ3NbaV0tPmFkZXYpCj4gICAJCQljb250aW51
ZTsKPiAgIAo+IC0JCXNjaGVkX2xpc3RbbnVtX3NjaGVkcysrXSA9ICZyaW5nc1tpXS0+c2NoZWQ7
Cj4gKwkJY3R4LT5zY2hlZF9saXN0W251bV9zY2hlZHMrK10gPSAmcmluZ3NbaV0tPnNjaGVkOwo+
ICAgCX0KPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCBhbWRncHVfY3R4X251bV9lbnRpdGllc1to
d19pcF07ICsraSkKPiAgIAkJciA9IGRybV9zY2hlZF9lbnRpdHlfaW5pdCgmY3R4LT5lbnRpdGll
c1tod19pcF1baV0uZW50aXR5LAo+IC0JCQkJY3R4LT5pbml0X3ByaW9yaXR5LCBzY2hlZF9saXN0
LCBudW1fc2NoZWRzLCAmY3R4LT5ndWlsdHkpOwo+ICsJCQkJY3R4LT5pbml0X3ByaW9yaXR5LCBj
dHgtPnNjaGVkX2xpc3QsIG51bV9zY2hlZHMsICZjdHgtPmd1aWx0eSk7Cj4gICAJaWYgKHIpCj4g
ICAJCWdvdG8gZXJyb3JfY2xlYW51cF9lbnRpdGllczsKPiAgIAo+IEBAIC0yMjgsNiArMjMyLDcg
QEAgc3RhdGljIHZvaWQgYW1kZ3B1X2N0eF9maW5pKHN0cnVjdCBrcmVmICpyZWYpCj4gICAJCWZv
ciAoaiA9IDA7IGogPCBhbWRncHVfc2NoZWRfam9iczsgKytqKQo+ICAgCQkJZG1hX2ZlbmNlX3B1
dChjdHgtPmVudGl0aWVzWzBdW2ldLmZlbmNlc1tqXSk7Cj4gICAJa2ZyZWUoY3R4LT5mZW5jZXMp
Owo+ICsJa2ZyZWUoY3R4LT5zY2hlZF9saXN0KTsKPiAgIAlrZnJlZShjdHgtPmVudGl0aWVzWzBd
KTsKPiAgIAo+ICAgCW11dGV4X2Rlc3Ryb3koJmN0eC0+bG9jayk7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguaCBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jdHguaAo+IGluZGV4IGRhODA4NjMzNzMyYi4uOWZkMDJjYzQ3MzUy
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguaAo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguaAo+IEBAIC00NCw2
ICs0NCw3IEBAIHN0cnVjdCBhbWRncHVfY3R4IHsKPiAgIAlzcGlubG9ja190CQkJcmluZ19sb2Nr
Owo+ICAgCXN0cnVjdCBkbWFfZmVuY2UJCSoqZmVuY2VzOwo+ICAgCXN0cnVjdCBhbWRncHVfY3R4
X2VudGl0eQkqZW50aXRpZXNbQU1ER1BVX0hXX0lQX05VTV07Cj4gKwlzdHJ1Y3QgZHJtX2dwdV9z
Y2hlZHVsZXIJKipzY2hlZF9saXN0Owo+ICAgCWJvb2wJCQkJcHJlYW1ibGVfcHJlc2VudGVkOwo+
ICAgCWVudW0gZHJtX3NjaGVkX3ByaW9yaXR5CQlpbml0X3ByaW9yaXR5Owo+ICAgCWVudW0gZHJt
X3NjaGVkX3ByaW9yaXR5CQlvdmVycmlkZV9wcmlvcml0eTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvc2NoZWRfZW50aXR5LmMKPiBpbmRleCBmOWI2Y2UyOWM1OGYuLmM4NGE5YTY2ZjdmMCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+IEBAIC01Niw4
ICs1Niw2IEBAIGludCBkcm1fc2NoZWRfZW50aXR5X2luaXQoc3RydWN0IGRybV9zY2hlZF9lbnRp
dHkgKmVudGl0eSwKPiAgIAkJCSAgdW5zaWduZWQgaW50IG51bV9zY2hlZF9saXN0LAo+ICAgCQkJ
ICBhdG9taWNfdCAqZ3VpbHR5KQo+ICAgewo+IC0JaW50IGk7Cj4gLQo+ICAgCWlmICghKGVudGl0
eSAmJiBzY2hlZF9saXN0ICYmIChudW1fc2NoZWRfbGlzdCA9PSAwIHx8IHNjaGVkX2xpc3RbMF0p
KSkKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiBAQCAtNjcsMTcgKzY1LDEwIEBAIGludCBk
cm1fc2NoZWRfZW50aXR5X2luaXQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKPiAg
IAllbnRpdHktPmd1aWx0eSA9IGd1aWx0eTsKPiAgIAllbnRpdHktPm51bV9zY2hlZF9saXN0ID0g
bnVtX3NjaGVkX2xpc3Q7Cj4gICAJZW50aXR5LT5wcmlvcml0eSA9IHByaW9yaXR5Owo+IC0JZW50
aXR5LT5zY2hlZF9saXN0ID0gIGtjYWxsb2MobnVtX3NjaGVkX2xpc3QsCj4gLQkJCQkgICAgICBz
aXplb2Yoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICopLCBHRlBfS0VSTkVMKTsKPiAtCj4gLQlp
ZighZW50aXR5LT5zY2hlZF9saXN0KQo+IC0JCXJldHVybiAtRU5PTUVNOwo+ICsJZW50aXR5LT5z
Y2hlZF9saXN0ID0gIHNjaGVkX2xpc3Q7Cj4gICAKPiAgIAlpbml0X2NvbXBsZXRpb24oJmVudGl0
eS0+ZW50aXR5X2lkbGUpOwo+ICAgCj4gLQlmb3IgKGkgPSAwOyBpIDwgbnVtX3NjaGVkX2xpc3Q7
IGkrKykKPiAtCQllbnRpdHktPnNjaGVkX2xpc3RbaV0gPSBzY2hlZF9saXN0W2ldOwo+IC0KPiAg
IAlpZiAobnVtX3NjaGVkX2xpc3QpCj4gICAJCWVudGl0eS0+cnEgPSAmZW50aXR5LT5zY2hlZF9s
aXN0WzBdLT5zY2hlZF9ycVtlbnRpdHktPnByaW9yaXR5XTsKPiAgIAo+IEBAIC0zMTIsNyArMzAz
LDYgQEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X2Zpbmkoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkg
KmVudGl0eSkKPiAgIAo+ICAgCWRtYV9mZW5jZV9wdXQoZW50aXR5LT5sYXN0X3NjaGVkdWxlZCk7
Cj4gICAJZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IE5VTEw7Cj4gLQlrZnJlZShlbnRpdHktPnNj
aGVkX2xpc3QpOwo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTChkcm1fc2NoZWRfZW50aXR5X2Zpbmkp
Owo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
