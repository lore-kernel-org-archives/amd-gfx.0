Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A27C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 18:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E6E20738
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 18:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMaQVRuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E6E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21C86E303;
	Mon, 22 Jun 2020 18:15:00 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E86D6E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 18:14:59 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 17so499698wmo.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 11:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=/TyEzZHdEA7i2EOyM1feWMvMf+Ckx0C1zjruO2sX2B0=;
 b=CMaQVRuMo3oXWm3JyVV8HoDwxt1idkHK8DqHHzOb+6PZFb4yY3XaV/cGpTwbQVdv8s
 vLmxEZ7osZVvGQmRbAeqGkiCFakt99knraD+UxNnma41LBrwT+eEuYrIAqLGTD0GhPS1
 umOFb1FDfzuGBNfjVqR56wFj07jwezRqWIJUeZaF7XgUPUswtYCjyKpQ4uKJBhlysay8
 DzLDTqQUXlCZd3v33amgPXdAF9Sg0gzFBBisyYFIBi/nOXANdNduTmrfBX/M6ZoIQ64F
 ciG920gt/OaL7wtqQ4Ypxhd4hQgETJ9eMHy0MMAjg7g4a0SsOFhUH3AtnagK5PkUrs8N
 Xriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/TyEzZHdEA7i2EOyM1feWMvMf+Ckx0C1zjruO2sX2B0=;
 b=f+qfBCHk84z1RoIw8BLdfBakZCP3ejQj7ETVIzvf50yrGvB6ZdTXMLLVph0zc59n9+
 wkxv5VTS2DWz5pmZALBE2LDPfmd/BEr3bN3rMkonLBp91IjY3EDggoDJDDIM1nTANQ2j
 iJjxw0r1qdTBRG+XxduY453lX2SySRH0USEcaqerqbccU/6Ht61GvGLPJkb7PFsKJ52E
 3HvwZrw4JQObgrIOEkdcQHgJ+8obfvQWBICy8ZjNwGjwqMUYINnLqCo3u6NyXU+3VMiB
 ujehI7HIj980+ei6QKqrzWwe/iNkOvhX7Bq539lfFIYx1uPbZLXDNRBoehYX3B2Bpb5n
 dLXQ==
X-Gm-Message-State: AOAM532YtoPb5u7Z43GMJlHz/F5ORsZ6spx7aZXcUukNix7bXTLBeJCX
 i9sCUUDmQF3WUj+kdGATyW4qSArQ
X-Google-Smtp-Source: ABdhPJyQ8MFEnYMSQ1pn05RorubS+Irk2KQgZurvTNlyEEk3n1xgNBaNynbEme63/H/Riuy9p6an9A==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr19361767wmh.81.1592849697611; 
 Mon, 22 Jun 2020 11:14:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z7sm383967wmb.42.2020.06.22.11.14.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jun 2020 11:14:56 -0700 (PDT)
Subject: Re: [PATCH 1/7] drm amdgpu: SI UVD PACKET_TYPE0
To: Sonny Jiang <sonny.jiang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200617220016.4844-1-sonny.jiang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cec4c40b-73e9-82d2-bf22-de92d8257eea@gmail.com>
Date: Mon, 22 Jun 2020 20:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200617220016.4844-1-sonny.jiang@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WW91ciBTaWduZWQtb2YtYnkgbGluZSBpcyBtaXNzaW5nIGFuZCBhIG9uZSBsaW5lciBjb21taXQg
bWVzc2FnZSB3b3VsZCAKYmUgbmljZSB0byBoYXZlLiBTb21ldGhpbmcgbGlrZSAiQ2xlYW5pbmcg
dXAgcmFkZW9uIGxlZnRvdmVycy4iCgpXaXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlzIFJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KCkFt
IDE4LjA2LjIwIHVtIDAwOjAwIHNjaHJpZWIgU29ubnkgSmlhbmc6Cj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zaWQuaCB8IDcgKysrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zaWQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Np
ZC5oCj4gaW5kZXggN2NmMTJhZGIzOTE1Li43NWI1ZDQ0MWI2MjggMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lkLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zaWQuaAo+IEBAIC0xNjQ2LDkgKzE2NDYsMTAgQEAKPiAgIC8qCj4gICAgKiBQTTQK
PiAgICAqLwo+IC0jZGVmaW5lIFBBQ0tFVDAocmVnLCBuKQkoKFJBREVPTl9QQUNLRVRfVFlQRTAg
PDwgMzApIHwJCQlcCj4gLQkJCSAoKChyZWcpID4+IDIpICYgMHhGRkZGKSB8CQkJXAo+IC0JCQkg
KChuKSAmIDB4M0ZGRikgPDwgMTYpCj4gKyNkZWZpbmUgUEFDS0VUX1RZUEUwICAgIDAKPiArI2Rl
ZmluZSBQQUNLRVQwKHJlZywgbikgKChQQUNLRVRfVFlQRTAgPDwgMzApIHwJCQkJXAo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgKChyZWcpICYgMHhGRkZGKSB8CQkJCVwKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICgobikgJiAweDNGRkYpIDw8IDE2KQo+ICAgI2RlZmluZSBDUF9QQUNL
RVQyCQkJMHg4MDAwMDAwMAo+ICAgI2RlZmluZQkJUEFDS0VUMl9QQURfU0hJRlQJCTAKPiAgICNk
ZWZpbmUJCVBBQ0tFVDJfUEFEX01BU0sJCSgweDNmZmZmZmZmIDw8IDApCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
