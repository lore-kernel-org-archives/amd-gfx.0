Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC3AC5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 09:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2062F217F4
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 09:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2062F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8CE6EC84;
	Wed,  6 Nov 2019 09:35:08 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12CAF6EC85
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 09:35:07 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id c22so2510609wmd.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2019 01:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/Y1XF0N69JuH9SXUamZ/Fa6dcTApFJtKFLOlIexTxEQ=;
 b=bVCi8ZGelNrTWiig5yXu+XTesjyeBxug5Ofk54N6cpkHhVPEQpZNvx8rC6OA8dPuSH
 rlgLzbB4dzBasbOLxx12ZJlEg4CmGPSEfsGXTevsNq2LTlGpKFXgZniHTeB0n5QcTxAa
 bNExvreizfxSHWwPZ1QfjWtnSnzCiyZ5m61xCGTwQULBp0T6n434MS7jfuFreFXI7Dnn
 2Tw2K8kCNyJYxibJHySbJ0pHf8UFBEQRwM4DI+XVqzHVyA/Z6IV3OBmh4/J9n85Tw93u
 coXzM6YBpdYE3bzCwfBwLI+PSeE4oNKeXREtoZoCr6o3Fl9CEPrCqFnFhzioBnWT4ZnL
 nHPg==
X-Gm-Message-State: APjAAAV6zlL9Xb1HpASMi/3NqSccc1T9+R3dSnOLaxeDJUC63JTTZMT7
 VKolCSW5vcAKLDwywgepJCWS/KUu
X-Google-Smtp-Source: APXvYqzqLaIQkVG76XjaZ/30XOXeeCkGVvKFymDJ5W2TEYzrX6qTAJ08+aE4j+CpOuWXKCg9AYSfHQ==
X-Received: by 2002:a05:600c:301:: with SMTP id
 q1mr1575000wmd.141.1573032905470; 
 Wed, 06 Nov 2019 01:35:05 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g4sm15960240wru.75.2019.11.06.01.35.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2019 01:35:05 -0800 (PST)
Subject: Re: [PATCH] drm/amd/amdgpu: Add mutex to protect IB resources
To: Jesse Zhang <zhexi.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1573023416-10462-1-git-send-email-zhexi.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2b3eb7e2-2f32-6778-eef5-6b5d9f1d9e14@gmail.com>
Date: Wed, 6 Nov 2019 10:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573023416-10462-1-git-send-email-zhexi.zhang@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=/Y1XF0N69JuH9SXUamZ/Fa6dcTApFJtKFLOlIexTxEQ=;
 b=o2rReT1F8wVRLs11sdCcbsBWdjTvWvxXTLgPDTuu31VnaY1ZB+negRwpJIjng0+W1x
 9wY3AHqG3yeXYvAwAvCptH6DNorUYUxDO58E6HV6bYdeqYSgnAYHy2jOHcjN5hHO4KIp
 Vo1ChcMd9T3QuD7vTnJCWxkcQNVqsaJu0Orf7jL4iGpSTwFm2gQGEQ2hgMpMMBU9zXdC
 mJ17Vpx4ZEb4fuVKAaqhvmR4CwZhMozVbVoj8ocjsY9CqeIdiXNdi1CpVi55PmpgjFyL
 bL4vGXccQM+itsaBTndJJrQUv1uncGMjhwH6K5oanvRJQQ4nRp1SPIxN5z/2+2mb4NhO
 TqRw==
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
Message-ID: <20191106093504.nStaLjATykh_HD_azd3RYbY_Q6g7aAa6DLURTVzYp3E@z>

QW0gMDYuMTEuMTkgdW0gMDc6NTYgc2NocmllYiBKZXNzZSBaaGFuZzoKPiBVbmxvYWRpbmcgZHJp
dmVyIGhhcyBjYWxsIHRyYWNlIHdoZW4gdW5sb2FkaW5nIGhhcHBlbnMKPiAycyBhZnRlciBsb2Fk
aW5nIGRyaXZlci4KPgo+IFNpbmNlIHJpbmcgdGVzdCBhcmUgZGVsYXllZCBhZnRlciBpbml0aWFs
aXppbmcgZHJpdmVyLAo+IGl0IGlzIHBvc3NpYmxlIHRoYXQgZHJpdmVyIGhhcyBiZWVuIHVubG9h
ZGVkIGJlZm9yZSBvcgo+IHdoaWxlIGRvaW5nIHJpbmcgdGVzdC4KPgo+IEFkZCBtdXRleCB0byBw
cmV2ZW50IHJpbmcgdGVzdCBhbmQgZHJpdmVyIGZpbmFsaXphdGlvbgo+IG9jY3VycyBhdCB0aGUg
c2FtZSB0aW1lIGFuZCBjaGVjayBiZWZvcmUgZG9pbmcgcmluZyB0ZXN0Cj4gaWYgcmVxdWlyZWQg
cmVzb3VyY2VzIHN0aWxsIGV4aXN0LgoKTkFLLCBhIG11dGV4IGlzIHRoZSB3cm9uZyBhcHByb2Fj
aC4KCllvdSBqdXN0IG5lZWQgdG8gYWRkIGFuIGZsdXNoX2RlbGF5ZWRfd29yaygmYWRldi0+ZGVs
YXllZF9pbml0X3dvcmspIHRvIAphbWRncHVfZGV2aWNlX2ZpbmkoKS4KClJlZ2FyZHMsCkNocmlz
dGlhbi4KCj4KPiBDaGFuZ2UtSWQ6IEkyN2I1MmMyYzYzMGFkMzg1M2M2Mzg0ZTdiNjkwNmYwZmFl
NTkwZWFkCj4gU2lnbmVkLW9mZi1ieTogSmVzc2UgWmhhbmcgPHpoZXhpLnpoYW5nQGFtZC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgfCAx
ICsKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDEgKwo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMgICAgIHwgOSArKysrKysr
KysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmgKPiBpbmRleCAwNDY5Y2M1Li5iODI1YWQwIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPiBAQCAtOTIzLDYgKzkyMyw3IEBAIHN0cnVjdCBhbWRn
cHVfZGV2aWNlIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcJCSpyaW5nc1tBTURHUFVfTUFYX1JJ
TkdTXTsKPiAgIAlib29sCQkJCWliX3Bvb2xfcmVhZHk7Cj4gICAJc3RydWN0IGFtZGdwdV9zYV9t
YW5hZ2VyCXJpbmdfdG1wX2JvOwo+ICsJc3RydWN0IG11dGV4CQkJaWJfbG9jazsKPiAgIAo+ICAg
CS8qIGludGVycnVwdHMgKi8KPiAgIAlzdHJ1Y3QgYW1kZ3B1X2lycQkJaXJxOwo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCBiMmYzOGIwLi44YWRi
YjI1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+
IEBAIC0yODA2LDYgKzI4MDYsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+ICAgCW11dGV4X2luaXQoJmFkZXYtPmxvY2tfcmVzZXQpOwo+ICAg
CW11dGV4X2luaXQoJmFkZXYtPnZpcnQuZHBtX211dGV4KTsKPiAgIAltdXRleF9pbml0KCZhZGV2
LT5wc3AubXV0ZXgpOwo+ICsJbXV0ZXhfaW5pdCgmYWRldi0+aWJfbG9jayk7Cj4gICAKPiAgIAly
ID0gYW1kZ3B1X2RldmljZV9jaGVja19hcmd1bWVudHMoYWRldik7Cj4gICAJaWYgKHIpCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPiBpbmRleCBkMTIxYmJkLi5lZjUzMzll
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPiBAQCAtMzE3LDEw
ICszMTcsMTIgQEAgaW50IGFtZGdwdV9pYl9wb29sX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4gICAgKi8KPiAgIHZvaWQgYW1kZ3B1X2liX3Bvb2xfZmluaShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKPiAgIHsKPiArCW11dGV4X2xvY2soJmFkZXYtPmliX2xvY2spOwo+ICAg
CWlmIChhZGV2LT5pYl9wb29sX3JlYWR5KSB7Cj4gICAJCWFtZGdwdV9zYV9ib19tYW5hZ2VyX2Zp
bmkoYWRldiwgJmFkZXYtPnJpbmdfdG1wX2JvKTsKPiAgIAkJYWRldi0+aWJfcG9vbF9yZWFkeSA9
IGZhbHNlOwo+ICAgCX0KPiArCW11dGV4X3VubG9jaygmYWRldi0+aWJfbG9jayk7Cj4gICB9Cj4g
ICAKPiAgIC8qKgo+IEBAIC0zNjQsNiArMzY2LDExIEBAIGludCBhbWRncHVfaWJfcmluZ190ZXN0
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkJc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nID0gYWRldi0+cmluZ3NbaV07Cj4gICAJCWxvbmcgdG1vOwo+ICAgCj4gKwkJaWYgKGFkZXYt
PnNodXRkb3duKSB7Cj4gKwkJCURSTV9JTkZPKCJEZXZpY2UgZmluYWxpemVkLCBza2lwIHVuZmlu
aXNoZWQgcmluZyB0ZXN0XG4iKTsKPiArCQkJcmV0dXJuIDA7Cj4gKwkJfQo+ICsKPiAgIAkJLyog
S0lRIHJpbmdzIGRvbid0IGhhdmUgYW4gSUIgdGVzdCBiZWNhdXNlIHdlIG5ldmVyIHN1Ym1pdCBJ
QnMKPiAgIAkJICogdG8gdGhlbSBhbmQgdGhleSBoYXZlIG5vIGludGVycnVwdCBzdXBwb3J0Lgo+
ICAgCQkgKi8KPiBAQCAtMzgxLDcgKzM4OCw5IEBAIGludCBhbWRncHVfaWJfcmluZ190ZXN0cyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkJZWxzZQo+ICAgCQkJdG1vID0gdG1vX2dm
eDsKPiAgIAo+ICsJCW11dGV4X2xvY2soJmFkZXYtPmliX2xvY2spOwo+ICAgCQlyID0gYW1kZ3B1
X3JpbmdfdGVzdF9pYihyaW5nLCB0bW8pOwo+ICsJCW11dGV4X3VubG9jaygmYWRldi0+aWJfbG9j
ayk7Cj4gICAJCWlmICghcikgewo+ICAgCQkJRFJNX0RFVl9ERUJVRyhhZGV2LT5kZXYsICJpYiB0
ZXN0IG9uICVzIHN1Y2NlZWRlZFxuIiwKPiAgIAkJCQkgICAgICByaW5nLT5uYW1lKTsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
