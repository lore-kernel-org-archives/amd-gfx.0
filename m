Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A932C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 17:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F5A60FD8
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 17:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F5A60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671AE6EA11;
	Mon, 17 May 2021 17:21:08 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07B46EA11
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 17:21:06 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id b25so7221362oic.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zIkkgiiVoGg01nvhNBPLFBnnca+sQRgcIN6kYBoFmhs=;
 b=vViQ2upT1hdWvFTyDaK31/8VsjZ3WVc1os0i73psdUb4KBqdZSi9mhfnnnOjNy3FKW
 jgviFRWIGYMDLqOVemKUxEN1pZgHBhov9flCx6tGCfh3QEHYsp0ANOmP4e709J7/mZhT
 fEJC6a6Dw1eWKnahe2r1H9idVzINJ6X5J4cVY1FzS7+gI4yloNfO+bkzAcXh1LIQF1O3
 u07yafn3lMKFT6hWZiBC3X7y9G4mwXy6WcK8FIH6CoPMQog+yQp28v2EVvkXlVLofXT4
 eKHXaa1iU5ERs3k2+zlxb7byGIr9cAhrD63FLKgPZxQxXbXiCAxflJnmw6XORdkos/4/
 d9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zIkkgiiVoGg01nvhNBPLFBnnca+sQRgcIN6kYBoFmhs=;
 b=QIXpPgWXexGHe5n5aKsfuAblWBlHxgiufY+kujYnURXX5VOz1mZ2YTyNJO3KgP5duk
 7cCpDWFYxrSkCK2SfoCo0+/jknTWUR1xD9Mc5HNxuSOFdc4KUOcK6iOW9bEG3a2hWugk
 AzYLj4A5v+VRrbeZIpmDeRaR06R562+7x+NXWpNLYjKMm+6xN6Ek649cw7ZZ6g3vMmS6
 16DUsHroKOStWxFvloLQn1A7Hujz06NWG4T2JNq9286wYh741ZXnGZFBUqZwTZnrRshA
 chKIEVniF1gaeSpETt2Qv4sHLCezv9Ue4KBvCMheYOIe8zNp/ElMdLkymB+zEnERDxa0
 ulXA==
X-Gm-Message-State: AOAM531TOq+6y628n+w+OAIrbtmfc/38L2Ysr5zuRhJI6Q7pQjTyEDWM
 N8tGJLzdl3WDpUxj0jDna/YPzKRjg5WwDEaXDxU=
X-Google-Smtp-Source: ABdhPJz8VYUm1vaHNdn3lSTp59fYO3V0snH8Msw7jN12GtnnY/RmX2bAwdq/j49JCdtkSTUPwI1Pj+TI22PMt2woMBY=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr631362oie.120.1621272066359; 
 Mon, 17 May 2021 10:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210517082626.1528678-1-Jingwen.Chen2@amd.com>
 <f29cfcb9-bd28-f7a6-40dc-bc188999e119@gmail.com>
In-Reply-To: <f29cfcb9-bd28-f7a6-40dc-bc188999e119@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 May 2021 13:20:55 -0400
Message-ID: <CADnq5_MqauN5y_CNvWWhp-7ML=r7Rqc0in1N6XQKPMKV6Viogg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: fix refcount leak
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, "monk.liu" <monk.liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBNYXkgMTcsIDIwMjEgYXQgNDo0NyBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxNy4wNS4yMSB1bSAxMDoy
NiBzY2hyaWViIEppbmd3ZW4gQ2hlbjoKPiA+IFtXaHldCj4gPiB0aGUgZ2VtIG9iamVjdCByZmIt
PmJhc2Uub2JqWzBdIGlzIGdldCBhY2NvcmRpbmcgdG8gbnVtX3BsYW5lcwo+ID4gaW4gYW1kZ3B1
ZmJfY3JlYXRlLCBidXQgaXMgbm90IHB1dCBhY2NvcmRpbmcgdG8gbnVtX3BsYW5lcwo+ID4KPiA+
IFtIb3ddCj4gPiBwdXQgcmZiLT5iYXNlLm9ialswXSBpbiBhbWRncHVfZmJkZXZfZGVzdHJveSBh
Y2NvcmRpbmcgdG8gbnVtX3BsYW5lcwo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEppbmd3ZW4gQ2hl
biA8SmluZ3dlbi5DaGVuMkBhbWQuY29tPgo+Cj4gTG9va3Mgc2FuZSB0byBtZSwgYnV0IEFsZXgg
bWlnaHQgd2FudCB0byB0YWtlIGEgbG9vayBhcyB3ZWxsLgo+Cj4gQWNrZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkxvb2tzIGdvb2QgdG8gbWUgYXMg
d2VsbC4KClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Cgo+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Zi
LmMgfCAzICsrKwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMKPiA+IGluZGV4IDRmMTBjNDUyOTg0
MC4uMDliMDQ4NjQ3NTIzIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZiLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9mYi5jCj4gPiBAQCAtMjg4LDEwICsyODgsMTMgQEAgc3RhdGljIGludCBhbWRncHVmYl9jcmVh
dGUoc3RydWN0IGRybV9mYl9oZWxwZXIgKmhlbHBlciwKPiA+ICAgc3RhdGljIGludCBhbWRncHVf
ZmJkZXZfZGVzdHJveShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QgYW1kZ3B1X2ZiZGV2
ICpyZmJkZXYpCj4gPiAgIHsKPiA+ICAgICAgIHN0cnVjdCBhbWRncHVfZnJhbWVidWZmZXIgKnJm
YiA9ICZyZmJkZXYtPnJmYjsKPiA+ICsgICAgIGludCBpOwo+ID4KPiA+ICAgICAgIGRybV9mYl9o
ZWxwZXJfdW5yZWdpc3Rlcl9mYmkoJnJmYmRldi0+aGVscGVyKTsKPiA+Cj4gPiAgICAgICBpZiAo
cmZiLT5iYXNlLm9ialswXSkgewo+ID4gKyAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcmZi
LT5iYXNlLmZvcm1hdC0+bnVtX3BsYW5lczsgaSsrKQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGRybV9nZW1fb2JqZWN0X3B1dChyZmItPmJhc2Uub2JqWzBdKTsKPiA+ICAgICAgICAgICAgICAg
YW1kZ3B1ZmJfZGVzdHJveV9waW5uZWRfb2JqZWN0KHJmYi0+YmFzZS5vYmpbMF0pOwo+ID4gICAg
ICAgICAgICAgICByZmItPmJhc2Uub2JqWzBdID0gTlVMTDsKPiA+ICAgICAgICAgICAgICAgZHJt
X2ZyYW1lYnVmZmVyX3VucmVnaXN0ZXJfcHJpdmF0ZSgmcmZiLT5iYXNlKTsKPgo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
