Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8DEC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 17:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6600D60201
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 17:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6600D60201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEDB76E21D;
	Thu, 25 Feb 2021 17:36:16 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5AD6E21D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 17:36:16 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id c23so1508889edr.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=tnMXRp7MOzXbEm2pDjyz3ZqbC3P5i7iV548mIkJfi3c=;
 b=IeFwDRjFjsHGVOLAIJi45s1PIvXdXuZYr5qs83qKClvoDXosgfgH1/ScDJMWDDUfSH
 7xeQ83pZE3DZmxsKmUOz03EeYOqTy1cdaG2VU8oqhd1mEfQrcGgH6Usaj2Wji1noZ+pt
 8nvATu6iB8EUk8mnKJ1Cmo0bKqHzELscg9T/0Kj0LWOcr4duNEhIGkacS/pyfOqhBlOT
 XEY0VHxq47xlAcgugRfo1dIckBVf9A/D9ivJtJt50CR+XK0EsXCqSA1WlQOhLyu2Egbr
 VOX+Canh7segX2O9m/B5q5Gmt8/6zj5/cSYZNNiwkieRqkC8uXDWEr+quM733iowIFb4
 8aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tnMXRp7MOzXbEm2pDjyz3ZqbC3P5i7iV548mIkJfi3c=;
 b=Xr5Cvtg8bi9sqLpdt/4LSdOFD7ksPR4KYnk1nD1dEdkrnrulGAauF9DMBtJA/7eOGq
 knI3ZAidP+RcVQO+hKE+0zBLv6y2qcMHrbPaLfsMfwHsSm8aNoSokStEn3uCAWpQ7guw
 N+M5SC4a5jT47c8PC6aBNRASPTFd5OauuiW1Rq6Qw1b9xMvRVmeVG7q0vDUuO7ObeLGt
 9OQlJUz257TccNsCYdgrvG9kC/RuXI9PoZVMHuVxIjRL4AK61r0kniHhMWiYvM9AfIOW
 FpIFYUNlcXrRfkysxNCnPIqmlgfpmJmZS9CIbfSfmS3fCcx8VyAJmgl70oT38rK8J6qq
 WA8A==
X-Gm-Message-State: AOAM5320lb0JU72CgYERe/bKIJWrmG8kynGQEY12QpOUcARB/1i7E6xy
 Sb5LvMyUWzViMBv4qapcUOOnTNffw9pxKQ==
X-Google-Smtp-Source: ABdhPJydXMTmhm1rrDfgL/48qbfARJPf31HsnfjFt3paszjECxX+4fvlR9Koe6CZyG9nYlVHxvNkRw==
X-Received: by 2002:aa7:c717:: with SMTP id i23mr4031705edq.81.1614274574846; 
 Thu, 25 Feb 2021 09:36:14 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:7944:296:6ad0:31ef?
 ([2a02:908:1252:fb60:7944:296:6ad0:31ef])
 by smtp.gmail.com with ESMTPSA id l6sm1154243edw.90.2021.02.25.09.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Feb 2021 09:36:14 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Remove amdgpu_device arg from free_sgt api
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210225024956.27425-1-Ramesh.Errabolu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2a27c70b-9686-c371-d4fa-477f5d9e71c5@gmail.com>
Date: Thu, 25 Feb 2021 18:36:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225024956.27425-1-Ramesh.Errabolu@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDIuMjEgdW0gMDM6NDkgc2NocmllYiBSYW1lc2ggRXJyYWJvbHU6Cj4gQ3VycmVudGx5
IGNhbGxlcnMgaGF2ZSB0byBwcm92aWRlIGhhbmRsZSBvZiBhbWRncHVfZGV2aWNlLAo+IHdoaWNo
IGlzIG5vdCB1c2VkIGJ5IHRoZSBpbXBsZW1lbnRhdGlvbi4gSXQgaXMgdW5saWtlbHkgdGhpcwo+
IHBhcmFtZXRlciB3aWxsIGJlY29tZSB1c2VmdWwgaW4gZnV0dXJlLCB0aHVzIHJlbW92aW5nIGl0
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBSYW1lc2ggRXJyYWJvbHUgPFJhbWVzaC5FcnJhYm9sdUBhbWQu
Y29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1
Zi5jICB8IDMgKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmgg
ICAgICB8IDMgKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9t
Z3IuYyB8IDQgKy0tLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RtYV9idWYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVm
LmMKPiBpbmRleCAyODA4ZDU3NTJkZTEuLmU4M2Q3M2VjMGU5ZCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYwo+IEBAIC0zNTksMTQgKzM1OSwxMyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfZG1hX2J1Zl91bm1hcChzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2ht
ZW50ICphdHRhY2gsCj4gICAJc3RydWN0IGRtYV9idWYgKmRtYV9idWYgPSBhdHRhY2gtPmRtYWJ1
ZjsKPiAgIAlzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiA9IGRtYV9idWYtPnByaXY7Cj4gICAJ
c3RydWN0IGFtZGdwdV9ibyAqYm8gPSBnZW1fdG9fYW1kZ3B1X2JvKG9iaik7Cj4gLQlzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOwo+ICAg
Cj4gICAJaWYgKHNndC0+c2dsLT5wYWdlX2xpbmspIHsKPiAgIAkJZG1hX3VubWFwX3NndGFibGUo
YXR0YWNoLT5kZXYsIHNndCwgZGlyLCAwKTsKPiAgIAkJc2dfZnJlZV90YWJsZShzZ3QpOwo+ICAg
CQlrZnJlZShzZ3QpOwo+ICAgCX0gZWxzZSB7Cj4gLQkJYW1kZ3B1X3ZyYW1fbWdyX2ZyZWVfc2d0
KGFkZXYsIGF0dGFjaC0+ZGV2LCBkaXIsIHNndCk7Cj4gKwkJYW1kZ3B1X3ZyYW1fbWdyX2ZyZWVf
c2d0KGF0dGFjaC0+ZGV2LCBkaXIsIHNndCk7Cj4gICAJfQo+ICAgfQo+ICAgCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaAo+IGluZGV4IDkyN2QzM2Q3NWMyMi4uMDI4ZjIw
MGEzNTA5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaAo+IEBA
IC0xMjEsOCArMTIxLDcgQEAgaW50IGFtZGdwdV92cmFtX21ncl9hbGxvY19zZ3Qoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gICAJ
CQkgICAgICBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXIsCj4gICAJCQkgICAgICBzdHJ1Y3Qg
c2dfdGFibGUgKipzZ3QpOwo+IC12b2lkIGFtZGdwdV92cmFtX21ncl9mcmVlX3NndChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKPiAtCQkJICAgICAgc3RydWN0IGRldmljZSAqZGV2LAo+ICt2
b2lkIGFtZGdwdV92cmFtX21ncl9mcmVlX3NndChzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gICAJCQkg
ICAgICBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXIsCj4gICAJCQkgICAgICBzdHJ1Y3Qgc2df
dGFibGUgKnNndCk7Cj4gICB1aW50NjRfdCBhbWRncHVfdnJhbV9tZ3JfdXNhZ2Uoc3RydWN0IHR0
bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4pOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92cmFtX21nci5jCj4gaW5kZXggYjMyNWIwNjc5MjZiLi4xNDkzNmJjNzEzYjAgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+IEBA
IC03MzQsMTUgKzczNCwxMyBAQCBpbnQgYW1kZ3B1X3ZyYW1fbWdyX2FsbG9jX3NndChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIC8qKgo+ICAgICogYW1kZ3B1X3ZyYW1fbWdyX2ZyZWVf
c2d0IC0gYWxsb2NhdGUgYW5kIGZpbGwgYSBzZyB0YWJsZQo+ICAgICoKPiAtICogQGFkZXY6IGFt
ZGdwdSBkZXZpY2UgcG9pbnRlcgo+ICAgICogQGRldjogZGV2aWNlIHBvaW50ZXIKPiAgICAqIEBk
aXI6IGRhdGEgZGlyZWN0aW9uIG9mIHJlc291cmNlIHRvIHVubWFwCj4gICAgKiBAc2d0OiBzZyB0
YWJsZSB0byBmcmVlCj4gICAgKgo+ICAgICogRnJlZSBhIHByZXZpb3VzbHkgYWxsb2NhdGUgc2cg
dGFibGUuCj4gICAgKi8KPiAtdm9pZCBhbWRncHVfdnJhbV9tZ3JfZnJlZV9zZ3Qoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCj4gLQkJCSAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiwKPiArdm9p
ZCBhbWRncHVfdnJhbV9tZ3JfZnJlZV9zZ3Qoc3RydWN0IGRldmljZSAqZGV2LAo+ICAgCQkJICAg
ICAgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLAo+ICAgCQkJICAgICAgc3RydWN0IHNnX3Rh
YmxlICpzZ3QpCj4gICB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
