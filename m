Return-Path: <SRS0=Ppqo=2W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC6C2D0DC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 12:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EF7206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 12:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw/pJ182"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EF7206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0558999E;
	Wed,  1 Jan 2020 12:52:21 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9478999E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jan 2020 12:52:19 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j42so36904899wrj.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jan 2020 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=nl/EcL9+c66XrcyojOn73re1CP+eE9mkZxUp7nyXiUg=;
 b=fw/pJ182rxjUVL4ZAoE5nCppiz8bUqoRIYaEZ1SFhkxcnT2N7JrQ24R+IpZ54Nvq4W
 dkxBe/2tJRWy90lEDW4hRfqkxAl3qA4ZCwwiDivd7a+di03XXaS7CapuB8u0GV/jkzLZ
 U4zRUoEOvsM+u0queEgPeAsciZ6mVGEohqgPKI2vc8RymEOPLmlsC76NGEDzGBroTDVT
 hzAy/LNtZju3MUTDyK9llbKCylwfzWH+M5ZO1IAUl/3qzh9PZJOf5+2RPdqsjwnr9tCR
 Yz42gdv+YJ/xLWSsc3g0rRCRGTjiK/GN06bED9sEQm6AWqeKFcEuedolxFFmCp+DyU+J
 Shvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=nl/EcL9+c66XrcyojOn73re1CP+eE9mkZxUp7nyXiUg=;
 b=rIFPcNsGip91UkNizZQnle51y0T0m4oniuBjrI/MSvfzV3Z99NrTj8hjN/WzrcZnpc
 3oGPLQdbKKaA8lCXpFrsotyYq3lLHfEKASnf7OcIMkUv1XZOrsmKjjlHcV4d0bKFgH7Z
 W2nfuIvpi0XLLpz6qKFBf5SCX+v9qTe5vhCbo9CuBmAy8U9lVlFTc0N562dNutTtDiUA
 7pT4CbgbFRz79IEHQrTPW1lf5Iwq7RF9ZEPODi102FkwXcieHD+NRUt3AhWgCdpwaNMJ
 bPCKBAcESAwJ1f4TWSSc668Z0mE81KlWoCX+Bv0jxTmTJl0+4dDs6M3vQaKleYW/+DAI
 SIVw==
X-Gm-Message-State: APjAAAXLPMjsxNqWyZ3P7klewDzoh/JwhN7N/Bw3Rdm5nUQ+SPyb0/9+
 FS7234GJSK5huggd9C9/x58=
X-Google-Smtp-Source: APXvYqzjE7DTzOMtwp247c6AQ34xTjR+ou1nzrre6YTbQ7EHe22BnFQOzyKMPNxLEBUATkIodBVIyg==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr72507444wru.294.1577883138319; 
 Wed, 01 Jan 2020 04:52:18 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id m10sm53060457wrx.19.2020.01.01.04.52.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jan 2020 04:52:17 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/amdgpu: fix ctx init failure for asics without
 gfx ring
To: Nirmoy <nirmodas@amd.com>, Le Ma <le.ma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1576755748-9800-1-git-send-email-le.ma@amd.com>
 <468e6ef3-e08c-17ad-8c83-f3efc3b04f85@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cb750a50-6f57-316f-e8fd-14e39112ba53@gmail.com>
Date: Wed, 1 Jan 2020 13:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <468e6ef3-e08c-17ad-8c83-f3efc3b04f85@amd.com>
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
Cc: Feifei.Xu@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMTIuMTkgdW0gMTM6MDEgc2NocmllYiBOaXJtb3k6Cj4gUmV2aWV3ZWQtYnk6IE5pcm1v
eSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPgo+IE9uIDEyLzE5LzE5IDEyOjQyIFBNLCBMZSBN
YSB3cm90ZToKPj4gVGhpcyB3b3JrYXJvdW5kIGRvZXMgbm90IGFmZmVjdCBvdGhlciBhc2ljcyBi
ZWNhdXNlIGFtZGdwdSBvbmx5IG5lZWQgCj4+IGV4cG9zZQo+PiBvbmUgZ2Z4IHNjaGVkIHRvIHVz
ZXIgZm9yIG5vdy4KPj4KPj4gQ2hhbmdlLUlkOiBJY2E5MmI4NTY1YTg5ODk5YWViZTBlYmE3YjJi
NWEyNTE1OWI0MTFkMwo+PiBTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KPj4g
LS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDMgKyst
Cj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyAK
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4gaW5kZXggNjNm
NjM2NS4uNjRlMmJhYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2N0eC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
dHguYwo+PiBAQCAtMTI3LDcgKzEyNyw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldiwKPj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIHN3
aXRjaCAoaSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBBTURHUFVfSFdfSVBfR0ZYOgo+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZHMgPSBhZGV2LT5nZnguZ2Z4X3NjaGVkOwo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZCA9ICZhZGV2LT5nZnguZ2Z4X3JpbmdbMF0u
c2NoZWQ7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNjaGVkcyA9ICZzY2hlZDsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3NjaGVkcyA9IDE7CgpNaG0sIHdlIHNob3VsZCBw
cm9iYWJseSByYXRoZXIgZml4IHRoaXMgaGVyZSBhbmQgZG9uJ3QgZXhwb3NlIGEgR0ZYIHJpbmcg
CndoZW4gdGhlIGhhcmR3YXJlIGRvZXNuJ3QgaGF2ZSBvbmUuCgpDaHJpc3RpYW4uCgo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
QU1ER1BVX0hXX0lQX0NPTVBVVEU6Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
