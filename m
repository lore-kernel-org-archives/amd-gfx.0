Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440EC2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 12:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE9820836
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 12:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRDdYdsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE9820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87616EB24;
	Wed, 11 Dec 2019 12:25:23 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A206EB24
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 12:25:22 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id b11so6865549wmj.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 04:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xeSZ4CEZaCQNeRqZvz7eS/fBj1xZysfs2Rm3S5pYa0I=;
 b=oRDdYdshv4jsNT3zRBrrANYJWeBhGZp8u6669QC3DAMFdFO3zm7NfI0a545rJPlzSj
 RizyCf6E6Gt5/A2KTYHCKV+a49QFUy9hao5wA0CppFO69fjr0WUjFlJpeSXQUv1FKY0g
 Hv4hDy8NUOP55G828QsRqdQg6EkLgV8gdawgprLXDM7MI359F/LxOk6aBUAZE33h9rjM
 eYLSnmztEPknDUz4J0WVEr404iytCSvmTFexx+pBfJQCt0JGcbghMbFVeAFgKre9Gbj9
 2w8fPetRzbCkK7pDLI7XSwwlSbApZdnwrYa+3xhb8Etm350mR1SjuEJc9UX2aI776MIf
 qxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=xeSZ4CEZaCQNeRqZvz7eS/fBj1xZysfs2Rm3S5pYa0I=;
 b=G9gxRXvfEdzoH6K/9NHoi9Sh9oBRsrdC7NJzQUWwnWBe8d2XAOcmOg5tqa+BpOc++5
 29BnGCKByJbAoZmTzD4sRUe7tNccxBJP6JDRjXAozTOQkWubCLm1mC80f68XwYlgllD+
 OY61ghk6AgXY21AAkqMC2t2/qbDSlSh7HNbIQFPZLK+YMCP5g01fBNGMallPIJbY4LOJ
 C9Elu9gOkwtjI7BVb0kA4NFYc7iN3yAuYofyvVUtgCWNWDg0TXxI1YSYJCpKBju7zp+9
 JcBOT5Q6JtACtFY0UFzDuPKHqQUKB44FOTz+LBnk+j7KR/sj9HFzpfs+elcTjBRloobL
 0PNQ==
X-Gm-Message-State: APjAAAXUuXKxWnaKUfWZYj8U3dSh8y/nISzx1KhZSFel7kGCcmVdSWB1
 /WZ/3RZiCdalbWR1VWzjER3c300H
X-Google-Smtp-Source: APXvYqz7DvfIfvIGQulwMFHGBjdWyoC33xEdOxZAYjk9sM7FJhDAU2i1tv3yQQDAfET1TX2pSEZWdQ==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr3278663wmc.168.1576067121334; 
 Wed, 11 Dec 2019 04:25:21 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u8sm2117558wmm.15.2019.12.11.04.25.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 04:25:20 -0800 (PST)
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, alexander.deucher@amd.com,
 kenny.ho@amd.com, christian.koenig@amd.com
References: <20191210181736.3237-1-nirmoy.das@amd.com>
 <20191210181736.3237-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4ddcd912-80f5-78a8-bad6-ec0ad18966db@gmail.com>
Date: Wed, 11 Dec 2019 13:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210181736.3237-4-nirmoy.das@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMTIuMTkgdW0gMTk6MTcgc2NocmllYiBOaXJtb3kgRGFzOgo+IGVudGl0eSBzaG91bGQg
bm90IGtlZXAgY29weSBhbmQgbWFpbnRhaW4gc2NoZWQgbGlzdCBmb3IKPiBpdHNlbGYuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgfCAxOSArKysrLS0tLS0t
LS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2Vu
dGl0eS5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+IGluZGV4
IGY5YjZjZTI5YzU4Zi4uMmUzYTA1OGZjMjM5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX2VudGl0eS5jCj4gQEAgLTU2LDggKzU2LDYgQEAgaW50IGRybV9zY2hlZF9lbnRp
dHlfaW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+ICAgCQkJICB1bnNpZ25l
ZCBpbnQgbnVtX3NjaGVkX2xpc3QsCj4gICAJCQkgIGF0b21pY190ICpndWlsdHkpCj4gICB7Cj4g
LQlpbnQgaTsKPiAtCj4gICAJaWYgKCEoZW50aXR5ICYmIHNjaGVkX2xpc3QgJiYgKG51bV9zY2hl
ZF9saXN0ID09IDAgfHwgc2NoZWRfbGlzdFswXSkpKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAg
IAo+IEBAIC02NywyMiArNjUsMTQgQEAgaW50IGRybV9zY2hlZF9lbnRpdHlfaW5pdChzdHJ1Y3Qg
ZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+ICAgCWVudGl0eS0+Z3VpbHR5ID0gZ3VpbHR5Owo+
ICAgCWVudGl0eS0+bnVtX3NjaGVkX2xpc3QgPSBudW1fc2NoZWRfbGlzdDsKPiAgIAllbnRpdHkt
PnByaW9yaXR5ID0gcHJpb3JpdHk7Cj4gLQllbnRpdHktPnNjaGVkX2xpc3QgPSAga2NhbGxvYyhu
dW1fc2NoZWRfbGlzdCwKPiAtCQkJCSAgICAgIHNpemVvZihzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVs
ZXIgKiksIEdGUF9LRVJORUwpOwo+ICsJZW50aXR5LT5zY2hlZF9saXN0ID0gbnVtX3NjaGVkX2xp
c3QgPiAxID8gc2NoZWRfbGlzdCA6IE5VTEw7Cj4gKwllbnRpdHktPmxhc3Rfc2NoZWR1bGVkID0g
TlVMTDsKPiAgIAo+IC0JaWYoIWVudGl0eS0+c2NoZWRfbGlzdCkKPiAtCQlyZXR1cm4gLUVOT01F
TTsKPiArCWlmKG51bV9zY2hlZF9saXN0KQo+ICsJCWVudGl0eS0+cnEgPSAmc2NoZWRfbGlzdFsw
XS0+c2NoZWRfcnFbZW50aXR5LT5wcmlvcml0eV07Cj4gICAKPiAgIAlpbml0X2NvbXBsZXRpb24o
JmVudGl0eS0+ZW50aXR5X2lkbGUpOwo+ICAgCj4gLQlmb3IgKGkgPSAwOyBpIDwgbnVtX3NjaGVk
X2xpc3Q7IGkrKykKPiAtCQllbnRpdHktPnNjaGVkX2xpc3RbaV0gPSBzY2hlZF9saXN0W2ldOwo+
IC0KPiAtCWlmIChudW1fc2NoZWRfbGlzdCkKPiAtCQllbnRpdHktPnJxID0gJmVudGl0eS0+c2No
ZWRfbGlzdFswXS0+c2NoZWRfcnFbZW50aXR5LT5wcmlvcml0eV07Cj4gLQo+IC0JZW50aXR5LT5s
YXN0X3NjaGVkdWxlZCA9IE5VTEw7Cj4gLQo+ICAgCXNwaW5fbG9ja19pbml0KCZlbnRpdHktPnJx
X2xvY2spOwo+ICAgCXNwc2NfcXVldWVfaW5pdCgmZW50aXR5LT5qb2JfcXVldWUpOwo+ICAgCj4g
QEAgLTMxMiw3ICszMDIsNiBAQCB2b2lkIGRybV9zY2hlZF9lbnRpdHlfZmluaShzdHJ1Y3QgZHJt
X3NjaGVkX2VudGl0eSAqZW50aXR5KQo+ICAgCj4gICAJZG1hX2ZlbmNlX3B1dChlbnRpdHktPmxh
c3Rfc2NoZWR1bGVkKTsKPiAgIAllbnRpdHktPmxhc3Rfc2NoZWR1bGVkID0gTlVMTDsKPiAtCWtm
cmVlKGVudGl0eS0+c2NoZWRfbGlzdCk7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MKGRybV9zY2hl
ZF9lbnRpdHlfZmluaSk7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
