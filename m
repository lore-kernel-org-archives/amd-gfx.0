Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B5CC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 13:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B2A2073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 13:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfUXgZAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B2A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06556EB7F;
	Fri,  3 Apr 2020 13:10:18 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8A06EB82
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 13:10:17 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id h15so8440911wrx.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=X5UTtIq6ZaQCUNe5wN+beQD3tIpiZqTImzH5AN8SbVM=;
 b=BfUXgZAxvqGyJ885DuBN3VxAMKUbZCXR3h6ynajoY/R7vjn59o+q9Zo/FK1xfx9Kl2
 EKsd9HQmoMc+1IgqAm+2UjCl6DnSEfFPNrUYx+QxxyWGufqK2fGid3qVg8qIx2hG+jz/
 W9a94udm5Ot1+o69pW32AvKjpWp2BL0/9Mee4G7fpL14YK6Z0RjRpIDisVSNaCY+L1Vp
 w19e7d3qytRID59sy1FE4Vc1K96fppNUqQi2ON4bbWMJMjzfwxtqZumEsMBPRr9m9SVT
 GzqDLA2rdOYjvnI211dfLxFNax7yTcGMVMoqUsmxXjk0p99GNUAE4zpanNhSnqFLoVgb
 RUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=X5UTtIq6ZaQCUNe5wN+beQD3tIpiZqTImzH5AN8SbVM=;
 b=e3xyTlmnORcscId1XrYV+3FR7IZXc9QR6B/R3bQmeAu8spEIOt9BsjVpw7OX/NJ1VJ
 otDt5J1Kcn1AqC8SIib4bPWnsJX8MVaqLQEBFQCiFiidML6xpwXm8XPDfm5RwvHxzwtr
 OzfCUI+W+oXqeqC6F+NWz7M9KzGXZNH4ZYx5iOZQTEDY7hrb8PwC5UrVxoiznjyX5qhT
 +CLWWRf1x4j+8yodHDBEXTY0+NA8oPb0xu66mJOYotavzDyBb61rULEVzVsrUc4Khhn9
 5BbzLv1zQ4+uDYP8mVn7ZehqNcTCFFFYIZLO5cLKeCfCL25aqYXKyL2Mo8UBtU022z3T
 my+A==
X-Gm-Message-State: AGi0Pubgj6hGKNouA6nbFLyvch56mEHKSCHZsDh6DKedfuylcvT5LLGu
 lDB6TsGJM7MomonwPj4MjpDWYEU4
X-Google-Smtp-Source: APiQypKOzSB9QiLDny7ewDWfL8LzBAG/deU4qYy1UYRnjZ2hNdrPYl4KVMLULZZOgaddFHTR+/WlGQ==
X-Received: by 2002:a5d:45d1:: with SMTP id b17mr8920942wrs.111.1585919413504; 
 Fri, 03 Apr 2020 06:10:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y7sm11897533wrq.54.2020.04.03.06.10.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 03 Apr 2020 06:10:12 -0700 (PDT)
Subject: Re: [PATCH 0/6] refine register access interfaces
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f4d5654f-e9d9-2754-8090-ba1ec281d2c9@gmail.com>
Date: Fri, 3 Apr 2020 15:10:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
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

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9y
IHBhdGNoZXMgIzEsICMyCgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiBmb3IgcGF0Y2hlcyAjMyAtICM2CgpSZWdhcmRzLApDaHJpc3RpYW4u
CgpBbSAwMy4wNC4yMCB1bSAxMjo1NSBzY2hyaWViIEhhd2tpbmcgWmhhbmc6Cj4gVGhlIHNlcmll
cyByZWZpbmVkIHJlZ2lzdGVyIGFjY2VzcyBpbnRlcmZhY2VzIGluY2x1ZGluZzoKPiAxLiBhZGQg
aW5kaXJlY3QgYWNjZXNzIHN1cHBvcnQgdG8gcmVnaXN0ZXJzIG91dHNpZGUgb2YgbW1pbyBiYXIK
PiAyLiByZW1vdmUgdGhlIGlucHJvcGVyIHdvcmthcm91bmQgbGVhdmluZyBpbiB0aGUgbG93IGxl
dmVsIGlmCj4gMy4gcmV0aXJlIGxlZ2FjeSBpbnRlcmZhY2UgUlJFRzMyX0lEWC9XUkVHMzJfSURY
Cj4gNC4gcmV0aXJlIHJlZHVuZGFudCBmbGFncyBBTURHUFVfUkVHU19LSVEvQU1ER1BVX1JFR1Nf
SURYCj4KPiBIYXdraW5nIFpoYW5nICg2KToKPiAgICBkcm0vYW1kZ3B1OiByZW1vdmUgaW5wcm9w
ZXIgd29ya2Fyb3VuZCBmb3IgdmVnYTEwCj4gICAgZHJtL2FtZGdwdTogcmVwbGFjZSBpbmRpcmVj
dCBtbWlvIGFjY2VzcyBpbiBub24tZGMgY29kZSBwYXRoCj4gICAgZHJtL2FtZGdwdTogcmV0aXJl
IGluZGlyZWN0IG1taW8gcmVnIHN1cHBvcnQgZnJvbSBjZ3MKPiAgICBkcm0vYW1kZ3B1OiByZXRp
cmUgUlJFRzMyX0lEWC9XUkVHMzJfSURYCj4gICAgZHJtL2FtZGdwdTogcmV0aXJlIEFNREdQVV9S
RUdTX0tJUSBmbGFnCj4gICAgZHJtL2FtZGdwdTogc3VwcG9ydCBhY2Nlc3MgcmVncyBvdXRzaWRl
IG9mIG1taW8gYmFyCj4KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAg
ICAgICB8IDI5ICsrKysrLS0tLS0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jZ3MuYyAgICB8ICA4ICsrLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyB8IDY5ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggIHwgIDQgKy0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTBfMC5jICAgICB8ICA4ICsrLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jICAgICB8ICA4ICsrLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMgICAgICB8IDE0ICsrKy0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y4XzAuYyAgICAgIHwgMTQgKysrLS0tCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvY2dzX2NvbW1vbi5oICAgfCAgMSAtCj4gICA5IGZp
bGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKyksIDk1IGRlbGV0aW9ucygtKQo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
