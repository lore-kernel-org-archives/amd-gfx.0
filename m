Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 13:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE02206B5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 13:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Aof0WnwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE02206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9196E0F2;
	Wed, 12 Aug 2020 13:49:35 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24AF6E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 13:49:34 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id e11so1967104otk.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6p588ldpfa1PVpJ16iQTZFtp7YHBAN7hgleJ+hPyMLw=;
 b=Aof0WnwL4Zpy/TzlXE9WxgzQzSIBn9eQBLvK3uaFdobVRSFA6hoRM5PP9kBt33r8D2
 lUkSV5tiTUP0ENvEe+exQdP2uazJOa6dDn/xLZES9iVUFHXzn1wKBT8sSRou9DXjSvgN
 rCHCsdVGAFiBdxpYbmuqYBeZCtvokMeYDr+lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6p588ldpfa1PVpJ16iQTZFtp7YHBAN7hgleJ+hPyMLw=;
 b=TxnYOKDgArP8R1eJMsR8bYuEY5D69L2agwhSzkv25zsKXhDrIxbGa7/aHu4L8fjj//
 hOaOkXMbPtJlB7LdKcxp1IP9ACzVFpVHpFfg2+2I2rdelv+my8eNqKamNvKtMtacr1Gg
 cC/Nv5eq42CxgIxEehvUreyAizF9jajaf16qaHrDHq28G0JNSTjezRfU5vH7iN6lF0I3
 5hItMIoNF1g4oWwB8pRB40V2FIYn4HlOkxoEuYHzoljP3Nj//n+bMLGTe94r0GGf1g4e
 KXtF9Rrv+IjhDk+ZXCjcKw1NyFWq8xL5c+280tLcj2ENjSpwPFk4OvlqeyHEIYvB88XW
 STqg==
X-Gm-Message-State: AOAM531k8G3fk9cGSnLOvlRm7X4rLMV+hLKDBpHEYynGHbDFfO0CPF5R
 hFyEaWq0HZBV06biS71lbZC7nccUY5AbA21Gq+KJ8g==
X-Google-Smtp-Source: ABdhPJxEe0H3WGYtNYF7iiy0/vriF3AdeNpxSoMQy6gs/xutnGtPjqYzCu6cznAdYnnxukUfyTao/pCs1WdiecXZaJk=
X-Received: by 2002:a9d:7283:: with SMTP id t3mr8920536otj.303.1597240174269; 
 Wed, 12 Aug 2020 06:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200807133658.1866-1-christian.koenig@amd.com>
 <1975d7d1-8f94-5852-6ccc-19fde4d4a919@gmail.com>
In-Reply-To: <1975d7d1-8f94-5852-6ccc-19fde4d4a919@gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 12 Aug 2020 15:49:23 +0200
Message-ID: <CAKMK7uF7nTgJE38Krhnw9Ca4FtFpw4b=nFr8-tWqPxTkRrh=Pw@mail.gmail.com>
Subject: Re: RFC: How to adjust the trace pid?
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
Cc: Shashank.Sharma@amd.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBBdWcgMTIsIDIwMjAgYXQgMzo0MiBQTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBQaW5nPyBEYW5pZWwsIERhdmUg
YW55IG9waW5pb24gb24gdGhpcz8KClR5cGUgcGF0Y2gsIGNjOiB0cmFjaW5nIHBlb3BsZSwgc2Vl
IHdoYXQgdGhleSBzYXk/IHRiaCBJIGhhdmUgbm8gaWRlYSwKYnV0IHRoZXkgaGF2ZSBiZWVuIG1h
a2luZyB1bmhhcHB5IG5vaXNlcyBhYm91dCBzb21lIG9mIHRoZSB0cmlja3MKd2UndmUgcGxheWVk
IGluIHRoZSBwYXN0IGluIGk5MTUgdHJhY2Vwb2ludHMuIFNvIG5vdCBldmVyeXRoaW5nIGlzCmNv
b2wgaW4gdGhlcmUuCgpPdGhlcndpc2UgSSBndWVzcyBqdXN0IGFkZCBhbm90aGVyIHRyYWNlcG9p
bnQgcGFyYW1ldGVyIHRvIGR1bXAgdGhlCmNvcnJlY3QgdXNlcnNwYWNlIG1tLgoKM3JkIG9wdGlv
biBjb3VsZCBiZSB0byBkdW1wIHRoZSBjdXJyZW50IG1tIChzaW5jZSBJJ20gYXNzdW1pbmcgdGhv
c2UKdGhyZWFkcyBkbyBrdGhyZWFkX3VzZS91bnVzZV9tbSB0byBpbXBlcnNvbmF0ZSB0aGUgcmln
aHQgdXNlcnNwYWNlCnByb2Nlc3MgY29ycmVjdGx5KSBpbiB0aGUgdHJhY2Vwb2ludCBpbmZyYXN0
cnVjdHVyZSB0b28/CgpDaGVlcnMsIERhbmllbAoKPiBDaHJpc3RpYW4uCj4KPiBBbSAwNy4wOC4y
MCB1bSAxNTozNiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4gPiBIaSBldmVyeWJvZHksCj4g
Pgo+ID4gaW4gYW1kZ3B1IHdlIGdvdCB0aGUgZm9sbG93aW5nIGlzc3VlIHdoaWNoIEknbSBzZWVr
aW5nIGFkdmlzZSBob3cgdG8gY2xlYW5seSBoYW5kbGUgaXQuCj4gPgo+ID4gV2UgaGF2ZSBhIGJ1
bmNoIG9mIHRyYWNlIHBvaW50cyB3aGljaCBhcmUgcmVsYXRlZCB0byB0aGUgVk0gc3Vic3lzdGVt
IGFuZCBleGVjdXRlZCBpbiBlaXRoZXIgYSB3b3JrIGl0ZW0sIGt0aHJlYWQgb3IgZm9yZWlnbiBw
cm9jZXNzIGNvbnRleHQuCj4gPgo+ID4gTm93IHRyYWNpbmcgdGhlIHBpZCBvZiB0aGUgY29udGV4
dCB3aGljaCB3ZSBhcmUgZXhlY3V0aW5nIGluIGlzIG5vdCByZWFsbHkgdGhhdCB1c2VmdWwsIHNv
IEknbSB3b25kZXJpbmcgaWYgd2UgY291bGQganVzdCBvdmVyd3JpdGUgdGhlIHBpZCByZWNvcmRl
ZCBpbiB0aGUgdHJhY2UgZW50cnk/Cj4gPgo+ID4gVGhlIGZvbGxvd2luZyBwYXRjaCBkb2VzIGV4
YWN0bHkgdGhhdCBmb3IgdGhlIHZtX2dyYWJfaWQoKSB0cmFjZSBwb2ludCwgYnV0IEknbSBub3Qg
MTAwJSBzdXJlIGlmIHRoYXQgaXMgbGVnYWwgb3Igbm90Lgo+ID4KPiA+IEFueSBpZGVhcz8gQ29t
bWVudHM/Cj4gPgo+ID4gVGhhbmtzLAo+ID4gQ2hyaXN0aWFuLgo+ID4KPiA+Cj4KCgotLSAKRGFu
aWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Js
b2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
