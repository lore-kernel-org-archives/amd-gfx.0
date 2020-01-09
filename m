Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFEAC32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 10:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD2120678
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 10:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5Sj9dFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD2120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B21D6E8F2;
	Thu,  9 Jan 2020 10:30:56 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EA76E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 10:30:55 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p9so2306806wmc.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 02:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KWmG5VlWVx+xfdGUn5yA38gTB53B8dnEmfxalc6w0yo=;
 b=C5Sj9dFDlvnzvMz/iG5yIEAk8bDrRBF+WC77E/jzvWGjVpJ+Y2LNcxgej6XcMv2SrD
 awAPK1+cY5WXvdqByyAoOSiydjoojU2JH9lJd9d9E8S5f5AKbGE46UqFIDpwLBhIFoZC
 rIMiXd/EaREUQVKMpP5PpBFHIo85dyPFJ6hfD9hL/XGLAh/Qu52hO+691br4ExT+BeHB
 3DjS9wxz7FP3yHOd/79YCpLNbr7ooa0Axxxz2HQL4JVcpA3zT/k2t3oWOGFsZYOVqR1f
 25hJd43S9i3z2sWu40s69/s9BQYTd4pwPj7vPh9KMpBFaKRZXNzHKR05LJkwjS1JMmgy
 SxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=KWmG5VlWVx+xfdGUn5yA38gTB53B8dnEmfxalc6w0yo=;
 b=myfj1mcKpPIGJCITFvdbPqzuPeVay1ssxYjN6vUfVJNx8kQAkAhwHWfpqSKAz0Hcwe
 yhjE4nBlEsg81A8ZtMQEZu+ysFfvaI5MVJWswJ6y5yZP8e72o3cg9LhFApnlA10xKIIk
 GeYBcHMezm4W/ybAVFo9RujQp/RndlGuqDkFH8/cCzIM9j8K81o85FgKZOLC2G5QaWI9
 t6aJttplx6Y7zSUta61gryYI/eHYQDP5dm7UyYe33YZQArlcYFONuFXNUTfb6P+MazZw
 ckKU6yFcU19aXJoeB+VmlEPvNjsrw2y/E20eDi9DFZ0cNwgEJ5Co4h7ILkRRyYfyto79
 l/5A==
X-Gm-Message-State: APjAAAVc6h+SiBoSJyygJdNP41IB6weouJJo7/SWigg8qJpebHY5SGqn
 oJc3ame02ciHgTjYNc8IOXkYOCA0
X-Google-Smtp-Source: APXvYqwgsOaROdekTMRY7MGq3ktz+7AV0fLIgEgo12u9beVo66F4BdCJbK2Ju1LQlAm9Is0vUo0Dtw==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr3861545wme.132.1578565853730; 
 Thu, 09 Jan 2020 02:30:53 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l15sm7242971wrv.39.2020.01.09.02.30.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2020 02:30:53 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc10: remove dead code
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200109031602.343800-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3b2fa9a8-e2c7-7eb2-34bc-321cea6fcc87@gmail.com>
Date: Thu, 9 Jan 2020 11:30:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109031602.343800-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDEuMjAgdW0gMDQ6MTYgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gTGVmdG92ZXIgZnJv
bSBicmluZyB1cC4gIFdlIGxvb2sgdXAgdGhlIGFjdHVhbCBwcmUtT1MgbWVtb3J5IHVzYWdlCj4g
dmFsdWUgbGF0ZXIgaW4gdGhlIHNhbWUgZnVuY3Rpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIHNlcmllcy4KCj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyB8IDkgLS0tLS0t
LS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192MTBfMC5jCj4gaW5kZXggN2RjOGMwNjhjNjJhLi5mYWEzMTBiNzZiNTAg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IEBAIC03MzYsMTUg
KzczNiw2IEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQo+ICAg
CSAqLwo+ICAgCWFkZXYtPmdtYy5tY19tYXNrID0gMHhmZmZmZmZmZmZmZmZVTEw7IC8qIDQ4IGJp
dCBNQyAqLwo+ICAgCj4gLQkvKgo+IC0JICogUmVzZXJ2ZSA4TSBzdG9sZW4gbWVtb3J5IGZvciBu
YXZpMTAgbGlrZSB2ZWdhMTAKPiAtCSAqIFRPRE86IHdpbGwgY2hlY2sgaWYgaXQncyByZWFsbHkg
bmVlZGVkIG9uIGFzaWMuCj4gLQkgKi8KPiAtCWlmIChhbWRncHVfZW11X21vZGUgPT0gMSkKPiAt
CQlhZGV2LT5nbWMuc3RvbGVuX3NpemUgPSAwOwo+IC0JZWxzZQo+IC0JCWFkZXYtPmdtYy5zdG9s
ZW5fc2l6ZSA9IDkgKiAxMDI0ICoxMDI0Owo+IC0KPiAgIAlyID0gZG1hX3NldF9tYXNrX2FuZF9j
b2hlcmVudChhZGV2LT5kZXYsIERNQV9CSVRfTUFTSyg0NCkpOwo+ICAgCWlmIChyKSB7Cj4gICAJ
CXByaW50ayhLRVJOX1dBUk5JTkcgImFtZGdwdTogTm8gc3VpdGFibGUgRE1BIGF2YWlsYWJsZS5c
biIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
