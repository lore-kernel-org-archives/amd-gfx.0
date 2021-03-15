Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73548C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB63964E20
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB63964E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77ACC89BAF;
	Mon, 15 Mar 2021 10:17:39 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C964289BAF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 10:17:38 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id c10so65090276ejx.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=iOMEnzVrMlkQZsQrHS12jp0Qw7eZ02bodjdsjUhA7/Q=;
 b=V7yJXnCQHowAxHvpluq7RdFfjSImplLaNfO0EB/sagYOy9YfuoyDU505lIyAOxr3B5
 f/roSMLUZQwipo/6EcYhNEHPchUf7OpMzkOYgvW4Pfe2MhzAgY+mNSI0QYaHVpzKjNDU
 6dwi48FiIVT9vZKD6kV7kiijlgE4vOj52PltGmKx6kVZXobYD1JjlA+Um0KP7OFh5mLt
 qofrhYfRQWrX1HlzO1Qc9Y0G0SKSqOvZJ7HVXM0htT+VK/qwvVH4XmjaGGu8fO5rPxcP
 RsQbwFGAJt7WHm2nVR0LC980QcOjhD13kla5Y+mmbv8eRk4LkCz0TsjhHX5SRNSKtpyU
 rQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=iOMEnzVrMlkQZsQrHS12jp0Qw7eZ02bodjdsjUhA7/Q=;
 b=d7eFpTE7+U1szUSrJdVs7c3oBqDS1lFET/buJBM5Xr29NHuqmARTi5vviwz8KCZFsa
 PR4prtLs8CaG4Xc+jMayTJ+U6wly+hmOzabOXgWsayXOIIpWrc+SoCxaMq8LkiXgI9Jr
 5PfZalYNE7uShX/W1RrBFAh/HDXVW2jW6z45v1O2WpL4ShI/aW1H/xhG50n+j1NRCrOQ
 y8kAzgcufIKZjBW0EKMtWqqqU9IK+2jBzLASbLo1FeK1uS2avzYtMZqXGllB3SEjAOEe
 gAM/7qWMP/mP1VBrcxS/KkNmK/rR4wuVwDBqJXUEwD4ZoVzg9DM3jjFBjEfW44S2Jrit
 z2TQ==
X-Gm-Message-State: AOAM530lJjmGojPxw6Sxz0AsfM6WRHMKwuBwq6NR34jWN+DHhLuQzhbv
 5oInumwf/eehXUeojU4AcFz3Xl50+F0=
X-Google-Smtp-Source: ABdhPJwYx/KN+44QUps+2oU7zhpJ4H8UWvf1X0UQmdtDHsaIeYx8BkJHJAPZ0oJhxZl4L02d2JCt8A==
X-Received: by 2002:a17:906:72d1:: with SMTP id
 m17mr22553508ejl.118.1615803457576; 
 Mon, 15 Mar 2021 03:17:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:dd5e:327:8807:376f?
 ([2a02:908:1252:fb60:dd5e:327:8807:376f])
 by smtp.gmail.com with ESMTPSA id g20sm6928982ejz.54.2021.03.15.03.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 03:17:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix recursive lock warnings
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210313024351.10908-1-Felix.Kuehling@amd.com>
 <20210313024351.10908-2-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e2405343-1968-49f0-3475-0b28b0e45663@gmail.com>
Date: Mon, 15 Mar 2021 11:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210313024351.10908-2-Felix.Kuehling@amd.com>
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

QW0gMTMuMDMuMjEgdW0gMDM6NDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBtZW1hbGxvY19u
b2ZzX3NhdmUvcmVzdG9yZSBhcmUgbm8gbG9uZ2VyIHN1ZmZpY2llbnQgdG8gcHJldmVudCByZWN1
cnNpdmUKPiBsb2NrIHdhcm5pbmdzIHdoZW4gaG9sZGluZyBsb2NrcyB0aGF0IGNhbiBiZSB0YWtl
biBpbiBNTVUgbm90aWZpZXJzLiBVc2UKPiBtZW1hbGxvY19ub3JlY2xhaW1fc2F2ZS9yZXN0b3Jl
IGluc3RlYWQuCj4KPiBGaXhlczogZjkyMGU0MTNmZjljICgibW06IHRyYWNrIG1tdSBub3RpZmll
cnMgaW4gZnNfcmVjbGFpbV9hY3F1aXJlL3JlbGVhc2UiKQo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4
IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHRoaXMgb25lLgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNiArKystLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IDMxOGVlZWE1NzdiNS4uYmMz
OTUxYjcxMDc5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBA
QCAtOTMsMTMgKzkzLDEzIEBAIHN0cnVjdCBhbWRncHVfcHJ0X2NiIHsKPiAgIHN0YXRpYyBpbmxp
bmUgdm9pZCBhbWRncHVfdm1fZXZpY3Rpb25fbG9jayhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKPiAg
IHsKPiAgIAltdXRleF9sb2NrKCZ2bS0+ZXZpY3Rpb25fbG9jayk7Cj4gLQl2bS0+c2F2ZWRfZmxh
Z3MgPSBtZW1hbGxvY19ub2ZzX3NhdmUoKTsKPiArCXZtLT5zYXZlZF9mbGFncyA9IG1lbWFsbG9j
X25vcmVjbGFpbV9zYXZlKCk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgaW50IGFtZGdw
dV92bV9ldmljdGlvbl90cnlsb2NrKHN0cnVjdCBhbWRncHVfdm0gKnZtKQo+ICAgewo+ICAgCWlm
IChtdXRleF90cnlsb2NrKCZ2bS0+ZXZpY3Rpb25fbG9jaykpIHsKPiAtCQl2bS0+c2F2ZWRfZmxh
Z3MgPSBtZW1hbGxvY19ub2ZzX3NhdmUoKTsKPiArCQl2bS0+c2F2ZWRfZmxhZ3MgPSBtZW1hbGxv
Y19ub3JlY2xhaW1fc2F2ZSgpOwo+ICAgCQlyZXR1cm4gMTsKPiAgIAl9Cj4gICAJcmV0dXJuIDA7
Cj4gQEAgLTEwNyw3ICsxMDcsNyBAQCBzdGF0aWMgaW5saW5lIGludCBhbWRncHVfdm1fZXZpY3Rp
b25fdHJ5bG9jayhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKPiAgIAo+ICAgc3RhdGljIGlubGluZSB2
b2lkIGFtZGdwdV92bV9ldmljdGlvbl91bmxvY2soc3RydWN0IGFtZGdwdV92bSAqdm0pCj4gICB7
Cj4gLQltZW1hbGxvY19ub2ZzX3Jlc3RvcmUodm0tPnNhdmVkX2ZsYWdzKTsKPiArCW1lbWFsbG9j
X25vcmVjbGFpbV9yZXN0b3JlKHZtLT5zYXZlZF9mbGFncyk7Cj4gICAJbXV0ZXhfdW5sb2NrKCZ2
bS0+ZXZpY3Rpb25fbG9jayk7Cj4gICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
