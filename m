Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DCC3CFC4
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665A1246AF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTyiJK5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665A1246AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546686EC40;
	Fri, 13 Dec 2019 19:47:50 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466FD6EC40
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 19:47:49 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y11so731777wrt.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 11:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=dORjuMwhguI1AqgRevw2x+JBr8U9d6qZMaj708WKv58=;
 b=BTyiJK5z7lrFEOXPz+graVafVhdxKe48P88qSYgWzculoc1eD20rF1KJz1PrKEitJx
 FMpwF9rMDvlOPE6vJnD2csTFYcYFEyoCFWcCKw3X2i9oOLbSmv5Xz8fpgB0EEuPzmO6c
 BK8kFSfPOk5bpQEYKBWHpIAKEhnO4RlN6gcoj4s9myfZ7Yu6K6sSJNmF9fuHS5Z53K70
 KitZktfRw49SphGHlMrApTD1bMY02lJa/L86gkd/iddPf/oe+m3wlosK1mkyMYNr0QxC
 qAX1kNIN8TGzwgb4PY+hPP2UFGRwMfnuuMO4TagID1rfi1Foyg2zEuzsJdOdiGXBTfkX
 QvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=dORjuMwhguI1AqgRevw2x+JBr8U9d6qZMaj708WKv58=;
 b=iGSplgmyLBMlzNxPmoZ9WEvkasCJC8W/jsObQXeOfQTyFu3Vg27g+/e6XVDLLH/Uc7
 1+c2BCNCdqaohTKrdmIuLItKjjW022Uj5WJCzFQhMxYLf4g/sYs7Q3BReysObI76XOmt
 IMgGoTMYVWdYQ+Tv2qkRSi16iXM1QQ9HpBqkmNxPdt6d4DYVNjnyMIRZ6iriHLjZEBgq
 fi5pYInTA8kdPm+aV4oRWn8xn83OtOHmNPZR9+Wn3T6GncvP6ZZFOD7wWYb6+Cm/uY7X
 W2Tt5vEN5TP7CYptj2obx5Z5RcvPk0NWc7Y/RF5SGcg3M9ilLBrPoxWzLVxGbM4qvTQX
 9QCg==
X-Gm-Message-State: APjAAAXFqayG0ac7ciDWb3skCDAVCl1Epann7P/k+K3YEgZwU866fq5K
 5z0pGHlu0/PcBWtemX0mxF0=
X-Google-Smtp-Source: APXvYqwTSmnR3lWEEga5cZLVPL9ksNqb2dRz/LcBP/fRITYi8rXU9rabR88Wuj3Cq3rmGzGC0ORbOQ==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr14444193wrn.384.1576266467778; 
 Fri, 13 Dec 2019 11:47:47 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b17sm11152946wrx.15.2019.12.13.11.47.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Dec 2019 11:47:47 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx10: make ring tests less chatty
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191213184854.3901-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6b1aed3a-db65-c6b5-9fb0-646b9de4a355@gmail.com>
Date: Fri, 13 Dec 2019 20:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213184854.3901-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMTIuMTkgdW0gMTk6NDggc2NocmllYiBBbGV4IERldWNoZXI6Cj4gV2UgYWxyZWFkeSBk
aWQgdGhpcyBmb3Igb2xkZXIgZ2VuZXJhdGlvbnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIHNlcmllcy4KCj4gLS0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDM5ICsrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MjkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+
IGluZGV4IDhjZGVmNzlkZTlkNC4uM2VkZTE5Y2U5ZjFmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBAQCAtNDcyLDE4ICs0NzIsMTAgQEAgc3RhdGljIGludCBn
ZnhfdjEwXzBfcmluZ190ZXN0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAgCQll
bHNlCj4gICAJCQl1ZGVsYXkoMSk7Cj4gICAJfQo+IC0JaWYgKGkgPCBhZGV2LT51c2VjX3RpbWVv
dXQpIHsKPiAtCQlpZiAoYW1kZ3B1X2VtdV9tb2RlID09IDEpCj4gLQkJCURSTV9JTkZPKCJyaW5n
IHRlc3Qgb24gJWQgc3VjY2VlZGVkIGluICVkIG1zZWNzXG4iLAo+IC0JCQkJIHJpbmctPmlkeCwg
aSk7Cj4gLQkJZWxzZQo+IC0JCQlEUk1fSU5GTygicmluZyB0ZXN0IG9uICVkIHN1Y2NlZWRlZCBp
biAlZCB1c2Vjc1xuIiwKPiAtCQkJCSByaW5nLT5pZHgsIGkpOwo+IC0JfSBlbHNlIHsKPiAtCQlE
Uk1fRVJST1IoImFtZGdwdTogcmluZyAlZCB0ZXN0IGZhaWxlZCAoc2NyYXRjaCgweCUwNFgpPTB4
JTA4WClcbiIsCj4gLQkJCSAgcmluZy0+aWR4LCBzY3JhdGNoLCB0bXApOwo+IC0JCXIgPSAtRUlO
VkFMOwo+IC0JfQo+ICsKPiArCWlmIChpID49IGFkZXYtPnVzZWNfdGltZW91dCkKPiArCQlyID0g
LUVUSU1FRE9VVDsKPiArCj4gICAJYW1kZ3B1X2dmeF9zY3JhdGNoX2ZyZWUoYWRldiwgc2NyYXRj
aCk7Cj4gICAKPiAgIAlyZXR1cm4gcjsKPiBAQCAtNTMzLDE0ICs1MjUsMTAgQEAgc3RhdGljIGlu
dCBnZnhfdjEwXzBfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgbG9uZyB0
aW1lb3V0KQo+ICAgCX0KPiAgIAo+ICAgCXRtcCA9IFJSRUczMihzY3JhdGNoKTsKPiAtCWlmICh0
bXAgPT0gMHhERUFEQkVFRikgewo+IC0JCURSTV9JTkZPKCJpYiB0ZXN0IG9uIHJpbmcgJWQgc3Vj
Y2VlZGVkXG4iLCByaW5nLT5pZHgpOwo+ICsJaWYgKHRtcCA9PSAweERFQURCRUVGKQo+ICAgCQly
ID0gMDsKPiAtCX0gZWxzZSB7Cj4gLQkJRFJNX0VSUk9SKCJhbWRncHU6IGliIHRlc3QgZmFpbGVk
IChzY3JhdGNoKDB4JTA0WCk9MHglMDhYKVxuIiwKPiAtCQkJICBzY3JhdGNoLCB0bXApOwo+ICsJ
ZWxzZQo+ICAgCQlyID0gLUVJTlZBTDsKPiAtCX0KPiAgIGVycjI6Cj4gICAJYW1kZ3B1X2liX2Zy
ZWUoYWRldiwgJmliLCBOVUxMKTsKPiAgIAlkbWFfZmVuY2VfcHV0KGYpOwo+IEBAIC0zNjA3LDIz
ICszNTk1LDE2IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2NwX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2dm
eF9yaW5nczsgaSsrKSB7Cj4gICAJCXJpbmcgPSAmYWRldi0+Z2Z4LmdmeF9yaW5nW2ldOwo+IC0J
CURSTV9JTkZPKCJnZnggJWQgcmluZyBtZSAlZCBwaXBlICVkIHEgJWRcbiIsCj4gLQkJCSBpLCBy
aW5nLT5tZSwgcmluZy0+cGlwZSwgcmluZy0+cXVldWUpOwo+IC0JCXIgPSBhbWRncHVfcmluZ190
ZXN0X3JpbmcocmluZyk7Cj4gLQkJaWYgKHIpIHsKPiAtCQkJcmluZy0+c2NoZWQucmVhZHkgPSBm
YWxzZTsKPiArCQlyID0gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIocmluZyk7Cj4gKwkJaWYgKHIp
Cj4gICAJCQlyZXR1cm4gcjsKPiAtCQl9Cj4gICAJfQo+ICAgCj4gICAJZm9yIChpID0gMDsgaSA8
IGFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5nczsgaSsrKSB7Cj4gICAJCXJpbmcgPSAmYWRldi0+
Z2Z4LmNvbXB1dGVfcmluZ1tpXTsKPiAtCQlyaW5nLT5zY2hlZC5yZWFkeSA9IHRydWU7Cj4gLQkJ
RFJNX0lORk8oImNvbXB1dGUgcmluZyAlZCBtZWMgJWQgcGlwZSAlZCBxICVkXG4iLAo+IC0JCQkg
aSwgcmluZy0+bWUsIHJpbmctPnBpcGUsIHJpbmctPnF1ZXVlKTsKPiAtCQlyID0gYW1kZ3B1X3Jp
bmdfdGVzdF9yaW5nKHJpbmcpOwo+ICsJCXIgPSBhbWRncHVfcmluZ190ZXN0X2hlbHBlcihyaW5n
KTsKPiAgIAkJaWYgKHIpCj4gLQkJCXJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4gKwkJCXJl
dHVybiByOwo+ICAgCX0KPiAgIAo+ICAgCXJldHVybiAwOwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
