Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB7EC47087
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 02:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0ED6142B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 02:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0ED6142B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDB36E471;
	Wed, 26 May 2021 02:23:31 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8AD6E471;
 Wed, 26 May 2021 02:23:30 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id y76so82755oia.6;
 Tue, 25 May 2021 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D7TryFyV+eLaRQPE4j490XHNdMtGWKF1gYzaD13cJNU=;
 b=TVE1+KH60aAJDxWS1E4vLRcQK+0VEUSKdAPjIHcWaG1OwdjbalLO/lcZyWqgGTZxaK
 lD4+Fy2qu4K6DA2mDEHKyrFxqtltV7RXrZ+FUa1OpE0PN7XZZYWsr3QTb/KiTjVtodlK
 Kf7e1oTT/xgYCegrwUyxl4uQiGwfwfzO61L1ukuMfUqbCh9BpDq/31mOZdDmpVgRpYCp
 4lzVuki8Qh9BsP0qC2WUGBDbWtFQlTZi/Cxi9Mn1xfLcm993vNQN9xeckCci9saFBJOO
 K0ZC26+D3CvMCe07KDpwZm+13pTK457D5/lYfMDTGEjAhgvqVbEC7r4JC3475oVb7dPp
 du/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D7TryFyV+eLaRQPE4j490XHNdMtGWKF1gYzaD13cJNU=;
 b=iGjHO5Z+k27XtV6g1mbZfIuQZmmXiiI9k6Z4V4m5+38SCkymyeTEmtzmWJjC9MxYOn
 vd9DqPBO6xCd7328Q5YttQvvEDv5l1FEfj0UaPzmAklPH2M++ao2QngeDDtkgG2pqF83
 jBqGcxufm2MCdq9w7WBwlMoLhkzEWlVYA8BwGgLE02CSAC+qbz7vtwnw71dB7m15L2Ok
 3vxAuKmeczUr15uVB9CC0Qp7bPTRakZ+7NBaK1IWGh10KAJByU14/AS4XGSoP3wcX7TM
 9mYTtl7CnNFd6TgbbAX+Wbx7ZS9AhUA8vt78Tzy3v8qlJY/7AaHjnW8a5zoDE26aDybF
 LxGg==
X-Gm-Message-State: AOAM532K8N+Hh5JLkrv5YO4984Os4O1DJAL7XLY+3lI05vAi7UoHPmzN
 WGvOKkXRMDAvTQwiSSa8oQD982+jd2ne0cAI0Cs=
X-Google-Smtp-Source: ABdhPJzHUs+eGFzokNVHbrK6uFO0bv09up0cTV0ACBYAUAhnEAEJiApcU5dA04B7Xrnf10loHK9VJiigxj95QyKzXQI=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr402763oie.120.1621995810261; 
 Tue, 25 May 2021 19:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <1621945944-52797-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1621945944-52797-1-git-send-email-zhangshaokun@hisilicon.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 May 2021 22:23:19 -0400
Message-ID: <CADnq5_Ow8P-znest+-DHwejP_xyChYNTTwjsaEssVbS=pJeL4w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/evergreen: Remove the repeated declaration
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBNYXkgMjUsIDIwMjEgYXQgODozMyBBTSBTaGFva3VuIFpoYW5nCjx6aGFuZ3NoYW9r
dW5AaGlzaWxpY29uLmNvbT4gd3JvdGU6Cj4KPiBGdW5jdGlvbiAnZXZlcmdyZWVuX3ByaW50X2dw
dV9zdGF0dXNfcmVncycgaXMgZGVjbGFyZWQgdHdpY2UsIHJlbW92ZQo+IHRoZSByZXBlYXRlZCBk
ZWNsYXJhdGlvbi4KPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
IFNpZ25lZC1vZmYtYnk6IFNoYW9rdW4gWmhhbmcgPHpoYW5nc2hhb2t1bkBoaXNpbGljb24uY29t
PgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vZXZlcmdyZWVuLmggfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5oIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uaAo+IGluZGV4IDQwMjVhNGU0NzRkMS4uYjA3YmVm
ZTE0NDU4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmgK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5oCj4gQEAgLTQ1LDcgKzQ1
LDYgQEAgdm9pZCBzdW1vX3JsY19maW5pKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAg
aW50IHN1bW9fcmxjX2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICB2b2lkIGV2
ZXJncmVlbl9ncHVfcGNpX2NvbmZpZ19yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
Cj4gIHUzMiBldmVyZ3JlZW5fZ2V0X251bWJlcl9vZl9kcmFtX2NoYW5uZWxzKHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2KTsKPiAtdm9pZCBldmVyZ3JlZW5fcHJpbnRfZ3B1X3N0YXR1c19yZWdz
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAgdTMyIGV2ZXJncmVlbl9ncHVfY2hlY2tf
c29mdF9yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gIGludCBldmVyZ3JlZW5f
cmxjX3Jlc3VtZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gIHN0cnVjdCBldmVyZ3Jl
ZW5fcG93ZXJfaW5mbyAqZXZlcmdyZWVuX2dldF9waShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRl
dik7Cj4gLS0KPiAyLjcuNAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
