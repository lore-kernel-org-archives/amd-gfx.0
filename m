Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C212CC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7490865259
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7490865259
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D9C6E0C4;
	Tue,  9 Mar 2021 15:08:19 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF206E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 15:08:18 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id p1so20817618edy.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Mar 2021 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=uesIaQEIwUjG9BenvJ9QRVgsunjDgLYT6Q3fk0EGeyY=;
 b=uJTNZeM4loLeYhsiZ1ogOGRrd7R/Bc0YzM0rcxon/c8RcB2/MAYIE2EB4RaSHm/4/r
 mIIBzeVjsL80/eMiwq26ysxgvRbA+Ccc6EoeMRCmKq4/tahkcQkO1XWJ2P9O2fYGgzta
 a5tXySSIwPl8BmmeLIBUisfmtkaCsu6Duv3fnJxydyy4KDbIavsUngI+oAih/2WRNwoi
 hyKMqv3hB+i2kzXENgjRrtaZDZlSUi0Tq1XAIh8/+drtMJgjqfGizSOP7SMEVyTvvS70
 Qh82QJv+OL3392xBV8w6WKBaq5qo8RfgyxcR9LOmcscYPvFyFLAXie7JOq/yv5nikAnh
 SDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uesIaQEIwUjG9BenvJ9QRVgsunjDgLYT6Q3fk0EGeyY=;
 b=jSmtT2OxILfRJWQ4weu6LZQ2M9vXyxHI+4oRnMISAZJrh9wxoRUv0/xvflaSlwee/j
 AIPWpq0OELa6ch95x+1orb2uY1eWsdgboIsVAdvPLvXst0/CEoUW6RI5Z47LFm2TMoez
 DQmfbHPKKRlHeTQh2FwBEHgJiZ/SGK0xoMc7Ob7dsNjAWTkcqqmFDVMarpR37Lyk+Tcj
 QDAJ0G1rn2QyHy8t1TDqtIynRXMgkyuCK33YlHGOoQR+ajRk6mMXGjzJ9OtcBJ0rO0HH
 Z+sadzz4rO9e3zcUAf3F1iGTNdAvkqwdQ/Gcv+8glOUcH9k9gQDaBMwctbEtTMSyxG31
 ndAg==
X-Gm-Message-State: AOAM531azi6dEpiaJSXjSDontVxnWJuEpq4pzaiKcwxOIF+vKhbvFvn9
 VAz/ofMod7nV5rAqBgBQFuoCvctEgOKeNw==
X-Google-Smtp-Source: ABdhPJzIry/sgNHnOxbWNW8ZgdqFxENDH49O8xtHVK5pqVTakDhrK/K2GUz85AJ3VFUkP01YP2Oisg==
X-Received: by 2002:aa7:ce1a:: with SMTP id d26mr4622179edv.206.1615302496747; 
 Tue, 09 Mar 2021 07:08:16 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe?
 ([2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe])
 by smtp.gmail.com with ESMTPSA id t12sm3606799edy.56.2021.03.09.07.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Mar 2021 07:08:16 -0800 (PST)
Subject: Re: [PATCH 3/5] drm/amdgpu: fb BO should be ttm_bo_type_device
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
References: <20210309084659.37649-1-nirmoy.das@amd.com>
 <20210309084659.37649-3-nirmoy.das@amd.com>
 <03c65172-7b17-7b80-7b15-cc687fb45fa0@gmail.com>
 <889d26bb-4281-f9be-6f72-a96f7359b572@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c9c9d0cc-b970-c1e0-e158-eaf8177ff1f1@gmail.com>
Date: Tue, 9 Mar 2021 16:08:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <889d26bb-4281-f9be-6f72-a96f7359b572@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwOS4wMy4yMSB1bSAxNTozMyBzY2hyaWViIE5pcm1veToKPgo+IE9uIDMvOS8yMSAxOjM5
IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAwOS4wMy4yMSB1bSAwOTo0NiBzY2hy
aWViIE5pcm1veSBEYXM6Cj4+PiBGQiBCTyBzaG91bGQgbm90IGJlIHR0bV9ib190eXBlX2tlcm5l
bCB0eXBlIGFuZAo+Pj4gYW1kZ3B1ZmJfY3JlYXRlX3Bpbm5lZF9vYmplY3QoKSBwaW5zIHRoZSBG
QiBCTyBhbnl3YXkuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRh
c0BhbWQuY29tPgo+Pj4gQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZiLmMgfCAyICstCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZiLmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9m
Yi5jCj4+PiBpbmRleCA1MWNkNDljNmYzOGYuLjI0MDEwY2FjZjdkMCAxMDA2NDQKPj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwo+Pj4gQEAgLTE0Niw3ICsxNDYsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdWZiX2NyZWF0ZV9waW5uZWRfb2JqZWN0KHN0cnVjdCAKPj4+IGFtZGdw
dV9mYmRldiAqcmZiZGV2LAo+Pj4gwqDCoMKgwqDCoCBzaXplID0gbW9kZV9jbWQtPnBpdGNoZXNb
MF0gKiBoZWlnaHQ7Cj4+PiDCoMKgwqDCoMKgIGFsaWduZWRfc2l6ZSA9IEFMSUdOKHNpemUsIFBB
R0VfU0laRSk7Cj4+PiDCoMKgwqDCoMKgIHJldCA9IGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShh
ZGV2LCBhbGlnbmVkX3NpemUsIDAsIGRvbWFpbiwgCj4+PiBmbGFncywKPj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0dG1fYm9fdHlwZV9rZXJuZWwsIE5V
TEwsICZnb2JqKTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0dG1fYm9fdHlwZV9kZXZpY2UsIE5VTEwsICZnb2JqKTsKPj4KPj4gQ2FuIHlvdSBkb3Vi
bGUgY2hlY2sgaWYgd2Ugc3RpbGwgbmVlZCB0aGUgdHRtX2JvX3R5cGVfKiBwYXJhbWV0ZXIgdG8g
Cj4+IGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZSgpIGFmdGVyIGFsaWduaW5nIHRoaXM/Cj4KPgo+
IFdlIG5lZWQgdGhhdCBpbiBvbmx5IG9uZSBwbGFjZToKPgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgLS0+IAo+IGFtZGdwdV9kbWFfYnVmX2NyZWF0ZV9vYmoo
KQo+Cj4gNDQ1OiByZXQgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUoYWRldiwgZG1hX2J1Zi0+
c2l6ZSwgUEFHRV9TSVpFLAo+Cj4gNDQ2LSDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIEFNREdQVV9HRU1fRE9NQUlOX0NQVSwgZmxhZ3MsCj4K
PiA0NDctIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgdHRtX2JvX3R5cGVfc2csIHJlc3YsICZnb2JqKTsKCkFoLCBvZiBjb3Vyc2UgdGhhdCBt
YWtlc2Ugc2Vuc2UuCgpUaGFua3MsCkNocmlzdGlhbi4KCj4KPgo+Cj4gTmlybW95Cj4KPj4KPj4g
VGhhbmtzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+PiDCoMKgwqDCoMKgIGlmIChyZXQpIHsKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBwcl9lcnIoImZhaWxlZCB0byBhbGxvY2F0ZSBmcmFtZWJ1ZmZlciAo
JWQpXG4iLCAKPj4+IGFsaWduZWRfc2l6ZSk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FTk9NRU07Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
