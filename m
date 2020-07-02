Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A031C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A92207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rk4RBvhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A92207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC2B6EB4F;
	Fri,  3 Jul 2020 08:12:46 +0000 (UTC)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835A26E454
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 19:42:56 +0000 (UTC)
Received: by mail-lj1-x243.google.com with SMTP id f5so17868514ljj.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2020 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+r53KkXjZK6X/YP4U/7mih9+WzJuu5mUo2Ez1QHbKCs=;
 b=Rk4RBvhHIxqE+t63y4J9FplOopkeMM9EQgH5Tl4KhBHYcjFS04RVuL2G5TQb/4RcSC
 pArZxZMY9ot6xIrTJ7GaFWc9cau+XbYwcrHqWkjH6F+3gdtCFeoaEYVm/IEa0Z6UBBr+
 gxHLZuf9CuL986liZSn1ZkGZW8MaT8TOadzfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+r53KkXjZK6X/YP4U/7mih9+WzJuu5mUo2Ez1QHbKCs=;
 b=ay6yDo07o3mag6wrConwFkQcVgSGRUcg35goX7eCHKFHFYBmgKHVhVbbl/YbS6WzIM
 Rzh+1aQSrr7sUfEuX1ac38qRvgYy/SkAikeLqdXhOf3wsMNtt6RG17YTEXNz97m//JDT
 iDozQCQMSSTJO2oYNnzqpCPLQSra6bUstmR4Bo70mH/ncsRsrgeCavZSQTSi5pCRZ7nB
 MlIm3hcWS3GPO9kbkOgSF3vls+5KO18wkMY6Y52Tc5+8/NqYkto3/H8R7YVAyQVhWiCw
 KJNuorxAjMGenbyk9gHqrs0LQy8jBUBu2saG+9dfbCfG5nXjWN9gyXvHDtVWjHczUQNg
 FbFQ==
X-Gm-Message-State: AOAM532I3J+kM9vZuB3Uzz69OEyEjzwnoc5xNUkvwi1cSnlReKBRwKtU
 Dsoafr8rzvPsfWhwQTUKEhRADQdEyD4=
X-Google-Smtp-Source: ABdhPJyQsoRanr+p2vHqWBKbb99DhTwpu1WhAuBEpOuWeRHRNj7SwABLCx9vxNLw+8Dzwv2bBxofQA==
X-Received: by 2002:a05:651c:484:: with SMTP id
 s4mr16060624ljc.381.1593718974596; 
 Thu, 02 Jul 2020 12:42:54 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178])
 by smtp.gmail.com with ESMTPSA id a15sm3282998ljn.105.2020.07.02.12.42.53
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 12:42:53 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q7so20508763ljm.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2020 12:42:53 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2490210ljj.312.1593718973053; 
 Thu, 02 Jul 2020 12:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
 <7c31d918-c967-5ebb-970e-7f6e913237e8@amd.com>
In-Reply-To: <7c31d918-c967-5ebb-970e-7f6e913237e8@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Jul 2020 12:42:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimBucBdC+tzFEuFJU5X1UFTVWo+AHMvQTSkCcVnTT-ww@mail.gmail.com>
Message-ID: <CAHk-=wimBucBdC+tzFEuFJU5X1UFTVWo+AHMvQTSkCcVnTT-ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] moduleparams: Add hex type parameter
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Fri, 03 Jul 2020 08:12:44 +0000
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
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBKdWwgMiwgMjAyMCBhdCA3OjQyIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBJJ20ganVzdCBub3Qgc3VyZSBob3cgd2VsbCB0
aGlzIGlzIHJlY2VpdmVkIHVwc3RyZWFtIGJlY2F1c2UgaXQgb25seQo+IGNvdmVycyB1MzIKPgo+
IE9uIHRoZSBvdGhlciBoYW5kIHRoYXQgaXMgcHJvYmFibHkgYWxzbyB0aGUgbW9zdCB1c2VkLgoK
Tm90IG5lY2Vzc2FyaWx5IHRydWUuIEknZCBhcmd1ZSB0aGF0ICJ1bnNpZ25lZCBsb25nIiAgaXMg
ZXF1YWxseQpwb3NzaWJsZSBmb3Igc29tZSBiaXQgbWFzayAob3Igb3RoZXIgaGV4LWxpa2VseSkg
dHlwZS4KClNvIGRvbid0IGNhbGwgaXQganVzdCAiaGV4Ii4gQ2FsbCBpdCAiaGV4aW50IiAodGhl
IGhleCBkb2VzIGltcGx5CiJ1bnNpZ25lZCIsIEkgZmVlbCAtIHNob3dpbmcgaGV4IG51bWJlcnMg
d2l0aCBhIHNpZ24gc291bmRzIGluc2FuZSkuCgpUaGF0IHdheSwgaWYgc29tZWJvZHkgZW5kcyB1
cCB3YW50aW5nIGl0IGZvciB1bnNpZ25lZCBsb25nIHZhbHVlcywKd2UncmUgbm90IHN0dWNrLgoK
QW5vdGhlciBvcHRpb24gaXMgdG8ganVzdCBzYXkgdGhhdCBoZXggdmFsdWVzIGFsd2F5cyBoYXZl
IGJpdCBfc2l6ZXNfLgpTbyAiaGV4MzIiIGFuZCAiaGV4NjQiIHdvdWxkIGFsc28gbWFrZSBzZW5z
ZSBhcyBuYW1lcyB0byBtZS4KCldoaWxlIGF0IGl0LCBzaG91bGQgdGhlIGhleCBudW1iZXJzIGFs
d2F5cyBiZSBwYWRkZWQgb3V0IHRvIHRoZSBzaXplPwpUaGUgZXhhbXBsZSBQYXVsIHVzZWQgZG9l
c24ndCBoYXZlIHRoYXQgaXNzdWUgKGhpZ2ggYml0IGJlaW5nIHNldCkuCgpCYnV0IG9mdGVuIGl0
IG1heSBtYWtlIHNlbnNlIHRvIHNob3cgYSAzMi1iaXQgaGV4IG51bWJlciBhcyAiJSMwOHgiCmJl
Y2F1c2UgaXQgcmVhbGx5IG1ha2VzIHRoaW5ncyBjbGVhcmVyIHdoZW4geW91J3JlIGxvb2tpbmcg
YXQgaGlnaApiaXRzLCBzYXkuCgpJdCdzIHJlYWxseSBoYXJkIHRvIHRlbGwgdGhlIGRpZmZlcmVu
Y2UgYmV0d2VlbiAianVzdCBiaXQgMjcgc2V0IiBhbmQKImp1c3QgYml0IDMxIiBzZXQgb3RoZXJ3
aXNlLCBhbmQgdGhhdCdzIG5vdCBhbGwgdGhhdCB1bmNvbW1vbiB3aGVuIHRoZQpiaXRtYXNrcyBh
cmUgc3BhcnNlLgoKICAgICAgICAgICAgIExpbnVzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
