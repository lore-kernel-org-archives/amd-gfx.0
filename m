Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6583AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 15:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7BF207DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0CKfSDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7BF207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC2D6E90B;
	Wed, 12 Aug 2020 15:34:01 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2208F6E907;
 Wed, 12 Aug 2020 15:34:00 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id d6so2736340ejr.5;
 Wed, 12 Aug 2020 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=m+2qVHlDZpY7hx9L3KMg3fe8c3A5JPSpPG3a+ctXXAY=;
 b=m0CKfSDryPPtkng12FCAgfBja3BVI2AmhARiFxnpFU8MkvZk8n4EV6onExKL8Ln0jS
 xmf0JKUtBAI3yHddlf3Ej0jYPr0ylVMYE5B5LAB12sAS0HNzbRZpMaot7KnmbPvcqEMg
 2yfTjklAnGlK5+g/+zzqdob2UEdKQM8ScIqAGJQL73cHnfU+O8UXlkdCNiHDd2zYGJGW
 pdJGsxs6rJFu7mb9WrJiqQPjF1ZAdIONSfFNACGIydJspHOpsHqnfQVOBEH3b337aSIH
 mFMgRh/dos+z2zLWYum63y5ceaJvFFv0WINBSViZOKtcN4RqoC/73xgVegG82uMECTZd
 wudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=m+2qVHlDZpY7hx9L3KMg3fe8c3A5JPSpPG3a+ctXXAY=;
 b=OoWYmVVNe3LHG2/b45sM3R8cDRDKQnwYhRwUBUrzOorTbWWxSxz2OOGGqF6T2zMy3a
 q7/stbmkYzlhERCMp30EnJ7V4P0Cu4Gu2ubBn/vpbrrKH8y7eqh/xM1jPxIkXZiH9Jz3
 C2i+sVs7jjTjqEGRudiiHKEWWDNbIL6nPAbQYxi02OXUPzoJd3PtOirfU+NSaJnM1iqE
 ukgsrHI9zdR/qMo6cFgDeiPJoo1F7EqMeNi95gmR7O7mXxTQlXnK07h92q/TGTAvnSAM
 /g+fwa7ww7nEoYMdIVcuNKmrEcrXFXAZX3S0Inv4XaqfhLmCqMwlhuNtOVZDFcTTcSnE
 mVWQ==
X-Gm-Message-State: AOAM530zSDA9jJEO/0mWOSqBAIi42lgge4Wv0ymxdbdys1GyVRf1e+gK
 lp3nVv6Q1kvz/no1S32oDsoNTio1
X-Google-Smtp-Source: ABdhPJzPWeKt4CeauJw6Lhyn5G4LPcMjQUCGwNmBjAvHlQ3upLq09MpfkXFz5KzwkqWy22XqHbGIBw==
X-Received: by 2002:a17:906:1986:: with SMTP id
 g6mr372317ejd.404.1597246438814; 
 Wed, 12 Aug 2020 08:33:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id gl20sm1826200ejb.86.2020.08.12.08.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 08:33:58 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: adjust the pid in the grab_id trace point
To: Steven Rostedt <rostedt@goodmis.org>
References: <20200807133658.1866-1-christian.koenig@amd.com>
 <20200807133658.1866-2-christian.koenig@amd.com>
 <20200812141755.GA8136@home.goodmis.org>
 <e48b6300-7ba7-f2fc-b7f7-a205d32607a4@gmail.com>
 <20200812111920.06efa663@oasis.local.home>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8f262830-7e73-09aa-e790-7222ab66038d@gmail.com>
Date: Wed, 12 Aug 2020 17:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812111920.06efa663@oasis.local.home>
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
Cc: Shashank.Sharma@amd.com, daniel.vetter@ffwll.ch,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMDguMjAgdW0gMTc6MTkgc2NocmllYiBTdGV2ZW4gUm9zdGVkdDoKPiBPbiBXZWQsIDEy
IEF1ZyAyMDIwIDE2OjM2OjM2ICswMjAwCj4gQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWlj
aHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4+IEFtIDEyLjA4LjIwIHVtIDE2OjE3IHNj
aHJpZWIgU3RldmVuIFJvc3RlZHQ6Cj4+PiBPbiBGcmksIEF1ZyAwNywgMjAyMCBhdCAwMzozNjo1
OFBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IFRyYWNlIHNvbWV0aGluZyB1
c2VmdWwgaW5zdGVhZCBvZiB0aGUgcGlkIG9mIGEga2VybmVsIHRocmVhZCBoZXJlLgo+Pj4+Cj4+
Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+Pj4+IC0tLQo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
cmFjZS5oIHwgMSArCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+Pj4K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNl
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+IGluZGV4
IDVkYTIwZmMxNjZkOS4uMDdmOTllZjY5ZDkxIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4+PiBAQCAtMjI4LDYgKzIyOCw3IEBAIFRSQUNF
X0VWRU5UKGFtZGdwdV92bV9ncmFiX2lkLAo+Pj4+ICAgIAkJCSAgICAgKSwKPj4+PiAgICAKPj4+
PiAgICAJICAgIFRQX2Zhc3RfYXNzaWduKAo+Pj4+ICsJCQkgICBfX2VudHJ5LT5lbnQucGlkID0g
dm0tPnRhc2tfaW5mby5waWQ7Cj4+PiBJZiB0aGUgZW50LnBpZCBpcyBub3QgdGhlIHBpZCB5b3Ug
YXJlIGludGVyZXN0ZWQgaW4gZm9yIHRoaXMgdHJhY2UgZXZlbnQsIGp1c3QKPj4+IGFkZCBhICJw
aWQiIGZpZWxkIHRvIHRoZSB0cmFjZSBldmVudCBhbmQgcGxhY2UgaXQgdGhlcmUuIERvIG5vdCBt
b2RpZnkgdGhlCj4+PiBnZW5lcmljIHBpZCB0aGF0IGlzIHJlY29yZGVkLCBhcyB3ZSB3b3VsZCBs
aWtlIHRoYXQgdG8gYmUgY29uc2lzdGVudCBmb3IgYWxsCj4+PiB0cmFjZSBldmVudHMuCj4+IFRo
ZSBwcm9ibGVtIG15IHVzZXJzcGFjZSBndXlzIGhhdmUgaXMgdGhhdCB0aGlzIGRvZXNuJ3Qgd29y
ayB3aXRoCj4+ICJ0cmFjZS1jbWQgLVAgJHBpZCIuCj4+Cj4+IEJ1dCBJIHRoaW5rIEkgY2FuIHRl
YWNoIHRoZW0gaG93IGZpbHRlcnMgd29yayA6KQo+IFllcCwgdHJhY2UtY21kIHJlY29yZCAtZSBl
dmVudCAtZiAicGlkID09ICRwaWQiCj4KPj4+IFRoZSAiZW50LnBpZCIgdHVybnMgaW50byAiY29t
bW9uX3BpZCIgaW4gdGhlIGZpZWxkLCBsZWF2aW5nICJwaWQiIGZyZWUgdG8gdXNlLgo+Pj4gT3Ro
ZXIgdHJhY2UgZXZlbnRzIChsaWtlIHNjaGVkX3dha2luZykgcmVjb3JkIGEgcGlkIGZpZWxkIHRo
YXQgaXMgbm90IHRoZSBzYW1lCj4+PiBhcyB0aGUgcGlkIG9mIHRoZSBleGVjdXRpbmcgdGFzay4K
Pj4gWWVzLCB3ZSB0aG91Z2h0IGFib3V0IHRoaXMgYWx0ZXJuYXRpdmUgYXMgd2VsbC4KPj4KPj4+
IFRoZSAiZW50LnBpZCIgc2hvdWxkIGFsd2F5cyBiZSB0aGUgcGlkIG9mIHRoZSB0YXNrIHRoYXQg
ZXhlY3V0ZWQgdGhlIGV2ZW50Lgo+PiBXaHk/IEZvciB0aGUgY2FzZSBoZXJlIHdlIGp1c3QgZXhl
Y3V0ZSBhIHdvcmsgaXRlbSBpbiB0aGUgYmFja2dyb3VuZCBmb3IKPj4gYW4gdXNlcnNwYWNlIHBy
b2Nlc3MuCj4+Cj4+IFRyYWNpbmcgdGhlIHBpZCBvZiB0aGUgd29ya2VyIHBvb2wgd2hpY2ggZXhl
Y3V0ZXMgaXQgZG9lc24ndCBzZWVtIHRvCj4+IG1ha2UgdG8gbXVjaCBzZW5zZS4KPiBNYXliZSBu
b3QgZm9yIHlvdSwgYnV0IGl0IGRvZXMgZm9yIG1lLiBBbGwgdHJhY2UgZXZlbnRzIHNob3cgd2hh
dAo+IGhhcHBlbmVkIHdoZW4gaXQgaGFwcGVuZWQgYW5kIHdobyBleGVjdXRlZCBpdC4gSSBsaWtl
IHRvIHNlZSB3aGF0Cj4gd29ya2VyIHRocmVhZHMgYXJlIGV4ZWN1dGluZy4gSSBtYXkgZmlsdGVy
IG9uIHRoZSB3b3JrZXIgdGhyZWFkLCBhbmQgYnkKPiBjaGFuZ2luZyB0aGUgZW50LnBpZCwgSSB3
b250IHNlZSB3aGF0IGl0IGlzIGRvaW5nLgoKVGhhdCdzIGVub3VnaCBleHBsYW5hdGlvbiBmb3Ig
bWUuIEdvaW5nIHdpdGggdGhlIHNlcGFyYXRlIHBpZCBmaWVsZCB0aGVuLgoKVGhhbmtzLApDaHJp
c3RpYW4uCgo+Cj4gVGhhdCBzYWlkLCBJIHRoaW5rIEkgbWF5IGFkZCBhIGZlYXR1cmUgdG8gYSB0
cmFjZSBldm50IGZvciBhIHNwZWNpYWwgZmlsdGVyCj4gdG8gc2F5LCAidGVzdCBmaWVsZCB0byB0
aGUgc2V0X2V2ZW50X3BpZCIsIGFuZCBpZiBpdCBleGlzdHMgaW4gdGhhdAo+IGZpbGUgdG8gaW5j
bHVkZSB0aGF0IGV2ZW50IGluIHRoZSBmaWx0ZXJlZCB0cmFjZS4gVGhpcyB3b3VsZCBpbmNsdWRl
Cj4gc2NoZWRfd2FraW5nIHRyYWNlIGV2ZW50cyBhcyB3ZWxsLgo+Cj4gVGhhdCB3YXkgInRyYWNl
LWNtZCByZWNvcmQgLVAgJHBpZCIgd2lsbCBzdGlsbCB3b3JrIGZvciB5b3VyIGNhc2UuCj4KPiAt
LSBTdGV2ZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
