Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F626CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 11:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5D220684
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 11:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5D220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35366E25B;
	Thu, 24 Oct 2019 11:01:20 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF2E6E25B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 11:01:19 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c2so20326687wrr.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 04:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=JeOoqbCq7jWrh8moJzJHlWMG4AMXdcLfiquzhteEbcU=;
 b=iTLNTo2q+LZ30Ko/fms86SpEU+uGuyLZhQMhZfRHnnPGWf9X35smTEl6+2PpRmPTQ+
 ApwVUVhm4/MpubdndFJvjGdiElnGw5DEeGZTwQbhpnT6EYVna5WUPWZvy05B0T1fac8i
 FUYvIS5mFJtTUG4Otq7CMSa5xrgndIGWFV7oVU+AF6/OTmJYavqx/tLq2LUxa/7n97nj
 eosWkzrJi0iv4QGSRrHDl7YPefhf1+baOwVxvGilTZmF7fjf8ZV8r6QD3eU67ySbtweP
 3l2t0Bni7IWd5VP7bmvE9XFkHqfJz6Itx8yD2stP5X5PQZWQHHU79WO1mYz7lS32r/QQ
 ixqw==
X-Gm-Message-State: APjAAAXgCEQUNyL//BtOqPm/B5O67eJKSWqZ1s0AFNsX4cWIq8/9TV7X
 AlKtB+OQx95hhIBNFvbiYwPiuVtx
X-Google-Smtp-Source: APXvYqw2gzSDRoirzM/vUrn4DswzTAYbiTov/+VZrmUdBxk8liVLhliqPid4QQpVksUviV1ksf6wTg==
X-Received: by 2002:adf:cc90:: with SMTP id p16mr3022700wrj.377.1571914877798; 
 Thu, 24 Oct 2019 04:01:17 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y13sm36561123wrg.8.2019.10.24.04.01.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 04:01:17 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
To: "S, Shirish" <Shirish.S@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
Date: Thu, 24 Oct 2019 13:01:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JeOoqbCq7jWrh8moJzJHlWMG4AMXdcLfiquzhteEbcU=;
 b=WK7fiAR6cOlTChd1R/tgYcxzdmX7P0hXcXPo7rDeuZ4AHo0md1+bIQSgh65boJdAee
 eAVGe6zLhUqis3naLAkajjJ2B/wi3kZvThgE5frCVYzYm4WX1NM6HYoT+a26hbzP7JOx
 z/THHb9Em//HY/vWRMa/35W7vRWxzgmysSFmHheJ+YopNWEY17Jh1/ZcCP0xoxSoqIi4
 Bn5xcMPE4vZl/a4H6BWsvUVxMOgq3nxOBE4sfhzQKtMA291I7X1QTj0ranwMj6pkJzTL
 yXNqkTQAfvxiBcLYS3tNE4AchUUD820rO9ti35W1f0wC4PIDQfgo22hgkXxMS68CrKFB
 GepQ==
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024110116.1ODGuWZL6Ek4fuSfScyaKVDq2AeRit8vUP_2DOkUsXA@z>

QW0gMjQuMTAuMTkgdW0gMTI6NTggc2NocmllYiBTLCBTaGlyaXNoOgo+IFtXaHldCj4gVXBvbiBH
UFUgcmVzZXQsIGtlcm5lbCBjbGVhbnMgdXAgYWxyZWFkeSBzdWJtaXR0ZWQgam9icwo+IHZpYSBk
cm1fc2NoZWRfY2xlYW51cF9qb2JzLgo+IFRoaXMgc2NoZWR1bGVzIGliJ3MgdmlhIGRybV9zY2hl
ZF9tYWluKCktPnJ1bl9qb2IsIGxlYWRpbmcgdG8KPiByYWNlIGNvbmRpdGlvbiBvZiByaW5ncyBi
ZWluZyByZWFkeSBvciBub3QsIHNpbmNlIGR1cmluZyByZXNldAo+IHJpbmdzIG1heSBiZSBzdXNw
ZW5kZWQuCgpOQUssIGV4YWN0bHkgdGhhdCdzIHdoYXQgc2hvdWxkIG5vdCBoYXBwZW4uCgpUaGUg
c2NoZWR1bGVyIHNob3VsZCBiZSBzdXNwZW5kIHdoaWxlIGEgR1BVIHJlc2V0IGlzIGluIHByb2dy
ZXNzLgoKU28geW91IGFyZSBydW5uaW5nIGludG8gYSBjb21wbGV0ZWx5IGRpZmZlcmVudCByYWNl
IGhlcmUuCgpQbGVhc2Ugc3luYyB1cCB3aXRoIEFuZHJleSBob3cgdGhpcyB3YXMgYWJsZSB0byBo
YXBwZW4uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gW0hvd10KPiBtYWtlIEdQVSByZXNldCdz
IGFtZGdwdV9kZXZpY2VfaXBfcmVzdW1lX3BoYXNlMigpICYKPiBhbWRncHVfaWJfc2NoZWR1bGUo
KSBpbiBhbWRncHVfam9iX3J1bigpIG11dHVhbGx5IGV4Y2x1c2l2ZS4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFNoaXJpc2ggUyA8c2hpcmlzaC5zQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgfCAxICsKPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDMgKysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfam9iLmMgICAgfCAyICsrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPiBpbmRleCBmNGQ5
MDQxLi43YjA3YTQ3YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gQEAg
LTk3Myw2ICs5NzMsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7Cj4gICAJYm9vbCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbl9ncHVfcmVzZXQ7Cj4gICAJZW51bSBwcF9tcDFfc3RhdGUg
ICAgICAgICAgICAgICBtcDFfc3RhdGU7Cj4gICAJc3RydWN0IG11dGV4ICBsb2NrX3Jlc2V0Owo+
ICsJc3RydWN0IG11dGV4ICBsb2NrX2liX3NjaGVkOwo+ICAgCXN0cnVjdCBhbWRncHVfZG9vcmJl
bGxfaW5kZXggZG9vcmJlbGxfaW5kZXg7Cj4gICAKPiAgIAlpbnQgYXNpY19yZXNldF9yZXM7Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4IDY3NmNh
ZDEuLjYzY2FkNzQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCj4gQEAgLTI3NTksNiArMjc1OSw3IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJbXV0ZXhfaW5pdCgmYWRldi0+dmlydC52Zl9l
cnJvcnMubG9jayk7Cj4gICAJaGFzaF9pbml0KGFkZXYtPm1uX2hhc2gpOwo+ICAgCW11dGV4X2lu
aXQoJmFkZXYtPmxvY2tfcmVzZXQpOwo+ICsJbXV0ZXhfaW5pdCgmYWRldi0+bG9ja19pYl9zY2hl
ZCk7Cj4gICAJbXV0ZXhfaW5pdCgmYWRldi0+dmlydC5kcG1fbXV0ZXgpOwo+ICAgCW11dGV4X2lu
aXQoJmFkZXYtPnBzcC5tdXRleCk7Cj4gICAKPiBAQCAtMzc5NSw3ICszNzk2LDkgQEAgc3RhdGlj
IGludCBhbWRncHVfZG9fYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSwK
PiAgIAkJCQlpZiAocikKPiAgIAkJCQkJcmV0dXJuIHI7Cj4gICAKPiArCQkJCW11dGV4X2xvY2so
JnRtcF9hZGV2LT5sb2NrX2liX3NjaGVkKTsKPiAgIAkJCQlyID0gYW1kZ3B1X2RldmljZV9pcF9y
ZXN1bWVfcGhhc2UyKHRtcF9hZGV2KTsKPiArCQkJCW11dGV4X3VubG9jaygmdG1wX2FkZXYtPmxv
Y2tfaWJfc2NoZWQpOwo+ICAgCQkJCWlmIChyKQo+ICAgCQkJCQlnb3RvIG91dDsKPiAgIAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMKPiBpbmRleCBlMWJhZDk5Li5jZDYw
ODJkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2Iu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwo+IEBAIC0y
MzMsOCArMjMzLDEwIEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2ZlbmNlICphbWRncHVfam9iX3J1bihz
dHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc2NoZWRfam9iKQo+ICAgCWlmIChmaW5pc2hlZC0+ZXJyb3Ig
PCAwKSB7Cj4gICAJCURSTV9JTkZPKCJTa2lwIHNjaGVkdWxpbmcgSUJzIVxuIik7Cj4gICAJfSBl
bHNlIHsKPiArCQltdXRleF9sb2NrKCZyaW5nLT5hZGV2LT5sb2NrX2liX3NjaGVkKTsKPiAgIAkJ
ciA9IGFtZGdwdV9pYl9zY2hlZHVsZShyaW5nLCBqb2ItPm51bV9pYnMsIGpvYi0+aWJzLCBqb2Is
Cj4gICAJCQkJICAgICAgICZmZW5jZSk7Cj4gKwkJbXV0ZXhfdW5sb2NrKCZyaW5nLT5hZGV2LT5s
b2NrX2liX3NjaGVkKTsKPiAgIAkJaWYgKHIpCj4gICAJCQlEUk1fRVJST1IoIkVycm9yIHNjaGVk
dWxpbmcgSUJzICglZClcbiIsIHIpOwo+ICAgCX0KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
