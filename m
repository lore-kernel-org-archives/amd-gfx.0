Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D428AC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DF861166
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DF861166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B95816E8FA;
	Mon, 17 May 2021 08:47:32 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3396E8FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 08:47:31 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id z12so6549762ejw.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TYeb+52bPQDx6G9DTNwhKNfZULfIEEql6xEGxFaqplU=;
 b=I8y4WVu2hsAW8S57Nrm3KiaN9W/U+cs6jLgajvoWcBAPs4n4uCUown2OYZYCM2Z2U/
 O82M1pbZ4XdawSv8Yc33nMsMufxvcOvwHHMswjrLgoYOeRmOAXV3UZ7fndkv6/+Uk5GW
 7BZ5tQsDJ7eBbI1ZGeTJ9wLlqQHOAo0bFpBpP1ketviTae3fzOBPTutCQiMvHHqUMH4S
 6YjNCJb1mqFyJi2Bp9xGgoonmXBU5FKRySGjmLC4meRzFbcQ2RSCBMknBxz33rQEtLWk
 HC/Tvj2nTkx0KnGrJ/dRmqiBMK6UoIU4+SfqATCyzk2gNqR6oBLI/9WR1U/KJpD83161
 uUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TYeb+52bPQDx6G9DTNwhKNfZULfIEEql6xEGxFaqplU=;
 b=XKlGqEP4LSwamSOpKfdhU2zNJ2OHNOPu6KBvsp9Ox9hFh8OdGJ4n4UVwMNGjbDLQW1
 TX2Mlh96b5IP3szpnLiw4tJxRctBRX0sPIll+xd5mku50YtFa1M2FY+P/XQo/2cvKJjm
 5uHMArIoVap51yu8ab3d5b+hYrrFBPUCY2v8UPZrvkD4ZQGyMQdX1HC+upgdcewPwsYs
 mLmF5y0Dq+7LqATli7AHayHodsEWouzVMd/0TFmGWyIH4TMoKmDrovQzLEqDedk4BIxp
 4/uojCVuSEk8XOqTbMlRd+gm1BoBkkXGiXPxyEKU1ebYm+zDuX/ZpDXfQyc09qHh57wc
 nB4Q==
X-Gm-Message-State: AOAM531nmaPW0jXljl13QG/DAxYKU9eh3zZNcz411ekVlUmn+Xakewb7
 3jsgf2jCS1+G/ybC3TyPmAkpM//TwbM=
X-Google-Smtp-Source: ABdhPJzpDKnnqiRyVq3mCoKgD0Ar+/OmPgh0uabggZ2LByaiRXQvi/L8FPjHxJBZlQGHL1vKBDnZnA==
X-Received: by 2002:a17:906:5584:: with SMTP id
 y4mr60659944ejp.120.1621241250491; 
 Mon, 17 May 2021 01:47:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6bbe:b48c:2de1:422d?
 ([2a02:908:1252:fb60:6bbe:b48c:2de1:422d])
 by smtp.gmail.com with ESMTPSA id o22sm586054edt.29.2021.05.17.01.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 01:47:30 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: fix refcount leak
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210517082626.1528678-1-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f29cfcb9-bd28-f7a6-40dc-bc188999e119@gmail.com>
Date: Mon, 17 May 2021 10:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517082626.1528678-1-Jingwen.Chen2@amd.com>
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
Cc: monk.liu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDUuMjEgdW0gMTA6MjYgc2NocmllYiBKaW5nd2VuIENoZW46Cj4gW1doeV0KPiB0aGUg
Z2VtIG9iamVjdCByZmItPmJhc2Uub2JqWzBdIGlzIGdldCBhY2NvcmRpbmcgdG8gbnVtX3BsYW5l
cwo+IGluIGFtZGdwdWZiX2NyZWF0ZSwgYnV0IGlzIG5vdCBwdXQgYWNjb3JkaW5nIHRvIG51bV9w
bGFuZXMKPgo+IFtIb3ddCj4gcHV0IHJmYi0+YmFzZS5vYmpbMF0gaW4gYW1kZ3B1X2ZiZGV2X2Rl
c3Ryb3kgYWNjb3JkaW5nIHRvIG51bV9wbGFuZXMKPgo+IFNpZ25lZC1vZmYtYnk6IEppbmd3ZW4g
Q2hlbiA8SmluZ3dlbi5DaGVuMkBhbWQuY29tPgoKTG9va3Mgc2FuZSB0byBtZSwgYnV0IEFsZXgg
bWlnaHQgd2FudCB0byB0YWtlIGEgbG9vayBhcyB3ZWxsLgoKQWNrZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYyB8IDMgKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZiLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwo+IGlu
ZGV4IDRmMTBjNDUyOTg0MC4uMDliMDQ4NjQ3NTIzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZiLmMKPiBAQCAtMjg4LDEwICsyODgsMTMgQEAgc3RhdGljIGludCBhbWRn
cHVmYl9jcmVhdGUoc3RydWN0IGRybV9mYl9oZWxwZXIgKmhlbHBlciwKPiAgIHN0YXRpYyBpbnQg
YW1kZ3B1X2ZiZGV2X2Rlc3Ryb3koc3RydWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0IGFtZGdw
dV9mYmRldiAqcmZiZGV2KQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZnJhbWVidWZmZXIgKnJm
YiA9ICZyZmJkZXYtPnJmYjsKPiArCWludCBpOwo+ICAgCj4gICAJZHJtX2ZiX2hlbHBlcl91bnJl
Z2lzdGVyX2ZiaSgmcmZiZGV2LT5oZWxwZXIpOwo+ICAgCj4gICAJaWYgKHJmYi0+YmFzZS5vYmpb
MF0pIHsKPiArCQlmb3IgKGkgPSAwOyBpIDwgcmZiLT5iYXNlLmZvcm1hdC0+bnVtX3BsYW5lczsg
aSsrKQo+ICsJCQlkcm1fZ2VtX29iamVjdF9wdXQocmZiLT5iYXNlLm9ialswXSk7Cj4gICAJCWFt
ZGdwdWZiX2Rlc3Ryb3lfcGlubmVkX29iamVjdChyZmItPmJhc2Uub2JqWzBdKTsKPiAgIAkJcmZi
LT5iYXNlLm9ialswXSA9IE5VTEw7Cj4gICAJCWRybV9mcmFtZWJ1ZmZlcl91bnJlZ2lzdGVyX3By
aXZhdGUoJnJmYi0+YmFzZSk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
