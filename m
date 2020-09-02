Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F41DC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 13:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE94E2087D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tj94buW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE94E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C22C6E588;
	Wed,  2 Sep 2020 13:21:49 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31EC46E588
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 13:21:48 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id o5so5188061wrn.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5DZgFI8FcpWs1MudteVK3vEByEeUTVUMX5a1HWCou6U=;
 b=tj94buW8LImhjfYkbUE0bUeM/Rzwr3vbq3kRT/BE+B+ekI+cwGHivI+L/pgoy81nKp
 lJYNa3mxZoxAIPvKwyuMWMqnUmWprmhiP8bPLFfhZfGJLAidhTG5vdhORD/ygT+Tem7L
 sG/BrlM9wQJtx/aDYkQQwv+mb3teot7S1963lSbNahHZm3Yca/FM5/yFKVePxFVXozpe
 tpJFKkLhcUSDwuBMmcxgzqIo8S5j3Uei36cmv2MpgFXaDM+5QsIwcqVhcqhqqmv87uqq
 FAnY5PgL+DCIfoGz608tesCWEbkswh1zThk1L3JTrzM0vUzGScTyzKDOaTncK6JkuHr7
 2sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=5DZgFI8FcpWs1MudteVK3vEByEeUTVUMX5a1HWCou6U=;
 b=XqH6n5BPOWmxm6Cp641An4ckfygh3yNlqx5nBdX1DfCQe7yEykYrGtkZJqA9WcacLZ
 4PjIwWugR8wOSM5H6eNPr2ZXQfRr6s8eMQug5iaXmWDVHakdY9+JxpNksIQDN5ED1E9c
 7/9gJp9JC5cnW2js4tE1LlKpyOWVJePQ/E6K+cYWgSsMZOP02pIJ3xLctnc7UHt9N/a8
 4Yd1/rujLZPZ1MOa3o7N4WbCLstJTTS258SyvGwhL/gXbWpdVYFi4kXpt3Vwu/wXbWSm
 tIHoxNoD7JZx70wJBsq0B3LHdF2t8g8VCQgaUJzSOukmxXs7TGGe/RuPmjIfcdUedQ6/
 nk9w==
X-Gm-Message-State: AOAM531dxZzwU2tS9mzI+J6TL/TG50TvBAs7XQcyYexcsfIDO4CYm3Br
 GebC32aSp5XqXTzptdJwihSJy8A2hEQ=
X-Google-Smtp-Source: ABdhPJx3xYFVqOu6AWR/9XOL4WiWRvEtAwkql4RxUTgYG7yqrvFCsBeS64m6rO87fytwQvp5/Fvk+A==
X-Received: by 2002:adf:fb01:: with SMTP id c1mr6913199wrr.119.1599052906590; 
 Wed, 02 Sep 2020 06:21:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id r15sm6550208wmn.24.2020.09.02.06.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 06:21:45 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200902120557.2229-1-christian.koenig@amd.com>
 <BFD95252-9F9E-431A-8284-4751698332DB@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7203ab3c-5784-d537-a674-ff8c02b1cf1c@gmail.com>
Date: Wed, 2 Sep 2020 15:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BFD95252-9F9E-431A-8284-4751698332DB@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDkuMjAgdW0gMTU6MDIgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0Oeac
iDLml6UgMjA6MDXvvIxDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4g5YaZ6YGT77yaCj4+Cj4+IENhbGN1bGF0ZSB0aGUgY29ycmVjdCB2YWx1ZSBmb3Ig
bWF4X2VudHJpZXMgb3Igd2UgbWlnaHQgcnVuIGFmdGVyIHRoZQo+PiBwYWdlX2FkZHJlc3MgYXJy
YXkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPj4gRml4ZXM6IDFlNjkxZTI0NDQ4NyBkcm0vYW1kZ3B1OiBzdG9wIGFsbG9j
YXRpbmcgZHVtbXkgR1RUIG5vZGVzCj4+IC0tLQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyB8IDMgKystCj4+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
Pj4gaW5kZXggOGJjMjI1MzkzOWJlLi44YWE5NTg0YzE4NGYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC0xNjk3LDcgKzE2OTcsOCBAQCBzdGF0aWMg
aW50IGFtZGdwdV92bV9ib19zcGxpdF9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+PiAJCQkJQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRTsKPj4gCQl9IGVsc2Ugewo+PiAJ
CQlhZGRyID0gMDsKPj4gLQkJCW1heF9lbnRyaWVzID0gUzY0X01BWDsKPj4gKwkJCW1heF9lbnRy
aWVzID0gKChtYXBwaW5nLT5sYXN0IC0gbWFwcGluZy0+c3RhcnQpID4+Cj4+ICsJCQkJICAgICAg
IEFNREdQVV9HUFVfUEFHRV9TSElGVCkgKyAxOwo+IHNob3VsZCBpdCBiZSBsaWtlIGJlbG93Pwo+
IG1heF9lbnRyaWVzID0gKG1hcHBpbmctPmxhc3QgLSBtYXBwaW5nLT5zdGFydCArIDEgLSBwZm4p
ICogQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRTsKClN0aWxsIG5vdCBjb3JyZWN0LCBidXQg
bWluZSB3YXNuJ3QgY29ycmVjdCBlaXRoZXIuCgo+IGxhc3QgYW5kIHN0YXJ0IGFyZSBhbHJlYWR5
IHBmbnMuIHdoeSBzdGlsbCA+PiBBTURHUFVfR1BVX1BBR0VfU0hJRlQ/IEFtIEkgbWlzc2luZyBz
b21ldGhpbmc/CgpZZWFoLCB0aGF0J3Mgd3JvbmcuCgpCdXQgdGhpcyBpcyBpbiBBTURHUFVfR1BV
X1BBR0VfU0laRSB1bml0cyBhbmQgbm90IFBBR0VfU0laRSB1bml0cywgc28gCm11bHRpcGx5aW5n
IGl0IHdpdGggQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRSBkb2Vzbid0IG1ha2UgdG8gbXVj
aCAKc2Vuc2UgZWl0aGVyLgoKQ2hyaXN0aWFuLgoKPgo+PiAJCX0KPj4KPj4gCQlpZiAocGFnZXNf
YWRkcikgewo+PiAtLSAKPj4gMi4xNy4xCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
