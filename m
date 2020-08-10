Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A06C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 14:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFEC204EC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dbAw7ysG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFEC204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F7E6E435;
	Mon, 10 Aug 2020 14:20:24 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4386E435
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 14:20:22 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id h22so7358889otq.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ub0gAaFfwgEsp0Sm0HD3MINJ30LaVhiYSGrx9gDLIgw=;
 b=dbAw7ysGlG86B6WakK9JwM/v2xudIYbYznrQaD9fDdtsLyRHfot2DPqCYXpyeBDBrD
 dZ59w214pMZoLSMCJxGdkSknGqx4qMzUjY4cCDrAd1ex77IV1moyjaY9lxmX3hlPRpk7
 9/xQ8/cLLy2u8u4I2IJxMBsvz42BYW0TBzvMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ub0gAaFfwgEsp0Sm0HD3MINJ30LaVhiYSGrx9gDLIgw=;
 b=huRO699cgVutgttohVw2D/I+SBIvYHHp/wKWVs0+HLlLy6UAQKrS466Hb1f23appB2
 fHPZBz0f+OaY/475QjINQtBveqvVn33mD+4cA3sRDdR0UETnIEOU8Jwv7qjstIgP+qOc
 jSf03HuEJAP5YHv/fS8EWOOwlUuDw5vc2kJs2BEHINfr0XyAs9zdKA1xs76xuSOHy8mu
 C7cshooKmrJGYJ4CkAwd/KFiKl/iYUfoA4i+xybTRUcWAzdMMYwce1FJilJ2x4RB/iYz
 VbySek7SJV5nfg+PF4mjrGBd426dsx5lQzdfDiHDROY9y36LqSqz/qeshKuaekGTKHVw
 c/sw==
X-Gm-Message-State: AOAM531iPstgtZLxViXyylTKQzpvWwofm1Bpm7DImVARZ+SFbLZSeHXL
 28qkoWAHg8M5CCFpZ8QSAj7S7g32ZRpugkglQkIWxg==
X-Google-Smtp-Source: ABdhPJy2gb11i+jvriDbKIYqNodOlWjK6tF15m7SfxA6v0sBAcYU2tCQZrKnVJfDb6tQKY97wRYS+7kdJK/czUXsB5g=
X-Received: by 2002:a05:6830:1e71:: with SMTP id
 m17mr1031970otr.188.1597069222064; 
 Mon, 10 Aug 2020 07:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200804213119.25091-1-bas@basnieuwenhuizen.nl>
 <20200804213119.25091-7-bas@basnieuwenhuizen.nl>
 <20200805073210.GU6419@phenom.ffwll.local>
 <20200810122820.GJ2352366@phenom.ffwll.local>
 <49e200cd-3df6-8a11-34f4-d1342a79f75e@daenzer.net>
 <20200810130935.GT2352366@phenom.ffwll.local>
 <CAP+8YyH0ufOc34Bis3PqfUR6XdE+6kRMasfgz1E4XUWJbbmB+A@mail.gmail.com>
In-Reply-To: <CAP+8YyH0ufOc34Bis3PqfUR6XdE+6kRMasfgz1E4XUWJbbmB+A@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 10 Aug 2020 16:20:11 +0200
Message-ID: <CAKMK7uGgTry5mnYczr8fxpcB2QFtiDYsYqdtAfVYDgC0jcsJ4g@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/amd/display: Set DC options from modifiers.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Stone <daniel@fooishbar.org>, "Wentland,
 Harry" <harry.wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBBdWcgMTAsIDIwMjAgYXQgNDoxMyBQTSBCYXMgTmlldXdlbmh1aXplbgo8YmFzQGJh
c25pZXV3ZW5odWl6ZW4ubmw+IHdyb3RlOgo+Cj4gT24gTW9uLCBBdWcgMTAsIDIwMjAgYXQgMzow
OSBQTSBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+IHdyb3RlOgo+ID4KPiA+IE9uIE1v
biwgQXVnIDEwLCAyMDIwIGF0IDAyOjQ5OjAwUE0gKzAyMDAsIE1pY2hlbCBEw6RuemVyIHdyb3Rl
Ogo+ID4gPiBPbiAyMDIwLTA4LTEwIDI6MjggcC5tLiwgRGFuaWVsIFZldHRlciB3cm90ZToKPiA+
ID4gPgo+ID4gPiA+IE9rIGp1c3QgbGVhcm5lZCB0aGF0IGFtZGdwdSBoYXQgc2V0L2dldF90aWxp
bmcsIHNvIEknbSB1cGdyYWRpbmcgbXkgaWRlYQo+ID4gPiA+IGhlcmUgdG8gYSB2ZXJ5IHN0cm9u
ZyByZWNvbW1lbmRhdGlvbiwgaS5lLiBwbGVhc2UgZG8gdGhpcyBleGNlcHQgaWYKPiA+ID4gPiB0
aGVyZSdzIGFuZCBhbWQgZGR4IHdoaWNoIHNvbWVob3cgd2FudHMgdG8gY2hhbmdlIHRpbGluZyBt
b2RlIHdoaWxlIGEgZmIKPiA+ID4gPiBleGlzdHMsIGFuZCBleHBlY3RzIHRoaXMgdG8gcHJvcGFn
YXRlLgo+ID4gPiA+Cj4gPiA+ID4gSW4gaTkxNSB3ZSBldmVuIGRpc2FsbG93IHRoZSBzZXRfdGls
aW5nIGlvY3RsIHdpdGggYW4gZXJyb3IgaWYgYW4gZmIKPiA+ID4gPiBleGlzdHMsIGp1c3QgdG8g
bWFrZSBzdXJlIHVzZXJzcGFjZSBiZWhhdmVzLiBFdmVuIGlmIHVzZXJzcGFjZSB1c2VzCj4gPiA+
ID4gc2V0X3RpbGluZywgdGhpcyB3YXkgd2UgY2FuIGF0IGxlYXN0IGVuZm9yY2UgdGhlIHNhbWUg
c2VtYW50aWNzIG9mICJjbGllbnQKPiA+ID4gPiBjYW4ndCBwdWxsIGNvbXBvc2l0b3Igb3ZlciB0
aGUgdGFibGUgd2l0aCBhIHNldF90aWxpbmcgYXQgdGhlIHdyb25nIHRpbWUiCj4gPiA+ID4gb2Yg
bW9kaWZpZXJzLgo+ID4gPgo+ID4gPiBGV0lXLCB4Zjg2LXZpZGVvLWFtZGdwdSBkb2Vzbid0IGhh
dmUgYW55IGNvZGUgdG8gc2V0IHRoZSB0aWxpbmcKPiA+ID4gbWV0YWRhdGEsIG9ubHkgTWVzYSBh
bmQgcHJlc3VtYWJseSBBTUQncyBWdWxrYW4vT3BlbkdMIFVNRHMgZG8uCj4gPgo+ID4gQWggcmln
aHQgeW91IGRvIGV2ZXJ5dGhpbmcgd2l0aCBnbGFtb3VyLCBzbyB0aGlzIHNob3VsZCBuZXZlciBz
aG93IHVwIGFzIGEKPiA+IHByb2JsZW0uCj4KPiBJIHRoaW5rIGl0IGlzIGEgZ29vZCBpZGVhIHRv
IGRvIHNvLCBidXQgY2Fubm90IGRvIGl0IGNvbXBsZXRlbHkgaW4KPiB0aGlzIHNlcmllcyBhcyB3
ZSBkb24ndCBkZWZpbmUgbW9kaWZpZXJzIGZvciBHRlg2LUdGWDggR1BVIGdlbmVyYXRpb25zCj4g
eWV0LiAod2FudGVkIHRvIGxlYXZlIHRoZXNlIG91dCBmb3IgYSBiaXQgdG8gcmVkdWNlIHRoZSBz
Y29wZSBmb3IgdGhlCj4gaW5pdGlhbCB2ZXJzaW9uKQoKSG0gcmlnaHQsIHRoYXQgbWFrZXMgaXQg
YSBiaXQgYXdrd2FyZC4KCj4gVGhhdCBzYWlkLCB0aGVyZSBpcyBhIHNlcmllcyB0aGF0IGNhcHR1
cmVzIHRoZSB0aWxpbmcgZmxhZ3Mgb24gRkIKPiBjcmVhdGlvbjogaHR0cHM6Ly9wYXRjaHdvcmsu
ZnJlZWRlc2t0b3Aub3JnL3Nlcmllcy84MDEwOS8KClllYWgsIGJ1dCBpdCBvbmx5IHB1c2hlcyBp
dCBkb3duIGludG8gdGhlIHN0YXRlIG9iamVjdHMuIEdvb2QgZmlyc3QKc3RlcCwgd2hhdCBJJ20g
cHJvcG9zaW5nIGlzIHRvIHB1c2ggaXQgYWxsIHRoZSB3YXkgaW50byBhZGRmYi9zdHJ1Y3QKZHJt
X2ZyYW1lYnVmZmVyLiBTaW5jZSBkcm1fZnJhbWVidWZmZXIgaXMgYWxzbyBhbiBpbnZhcmlhbnQg
dGhpbmcgaXQKbWFrZXMgdGhlIG1vc3Qgc2Vuc2UgdG8ga2VlcCB0aGF0IHRoZXJlLiBJJ20gYWxz
byBkaXNjdXNzaW5nIHdpdGgKTmljaG9sYXMgYWJvdXQgd2hhdCB3b3VsZCBiZSB0aGUgaWRlYWwg
ZW5kIHN0YXRlLgoKQnV0IHllYWggbWF5YmUgb25lIHRoaW5nIGF0IHRpbWUuCi1EYW5pZWwKCj4K
PiA+IC1EYW5pZWwKPiA+IC0tCj4gPiBEYW5pZWwgVmV0dGVyCj4gPiBTb2Z0d2FyZSBFbmdpbmVl
ciwgSW50ZWwgQ29ycG9yYXRpb24KPiA+IGh0dHA6Ly9ibG9nLmZmd2xsLmNoCj4gPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gYW1kLWdmeCBtYWls
aW5nIGxpc3QKPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCgoKLS0gCkRhbmll
bCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6Ly9ibG9n
LmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
