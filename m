Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8489FC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FB3206F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d6psg1bT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FB3206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E71786EC22;
	Fri,  3 Apr 2020 16:40:57 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44746EC22
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:40:56 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id y71so6626725oia.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QMFojYHgYc5POEgG1gKWUrcpFWbGEJtOr0VoqZadidI=;
 b=d6psg1bTquQQVi9TVxdni9J4LWC+r0xrZwD7m56IbxE90zgYyTRvSQOsKSVoEJvHTW
 7XaL4rJSPLX+EyMXBRDhFco0W4u+HLznKrJ3DZQR3CCKe5qLUOxoPehp+CdVEmr22Lfx
 cOZTzX2shA7S8aP9RziGbcUlrhEsPwfB3HQDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QMFojYHgYc5POEgG1gKWUrcpFWbGEJtOr0VoqZadidI=;
 b=Ql3M5Xpm3Vt+xmFHv75augKVvCVmzwF4eQi8m6CPlwJcu3+LHQhaaZ6v4og7sg8WRw
 gzBQIpglP/TYHQeZD1D4De/1S7EhIyThU8W78OWxLgs1EtkOkq2z6hOubPs5xy8B/QfU
 rGYUhkkAQcTU+TSOLEPLYxiQH6+0VK1boV2tCkGSTNytgLF2SDMf045mWt1CQdTnvuZa
 OR4oKkwfxNaSLYRqF4f46BrXacj/enNO6a20P+BiCDgzuifB3az+I9AFFh1KkHZ5PRIe
 0njaF2ob457inf8nfitFhb3E1vS8eGZxkcWi1r9PK+Bi0BFGeBVmHaPAmwlvMft3EOkL
 aE+A==
X-Gm-Message-State: AGi0PuZM726hk/h72quaNS865RqhW8nS8DVY5HkZDe2kEIQ0ALIIPR2X
 9by05zu6QMHsZwRMb1Hr3S2Vq035RwPMNEusq6qOyA==
X-Google-Smtp-Source: APiQypINQXFYvlqsO8o3OWTfxbeytpK6SLfKl/L44/YPToO5hGmem9Mvy0jnKVSHlYtBrjjZ/oXyyoVbMLGno43slck=
X-Received: by 2002:a54:4189:: with SMTP id 9mr3812860oiy.128.1585932056141;
 Fri, 03 Apr 2020 09:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <9bef42f5-2f6e-a102-917d-7c55f2bf83d4@daenzer.net>
 <CAKMK7uHxtvd4=POpBEPNfimjpz6Q7AO4P_XWsgd0fiLN8G1bUA@mail.gmail.com>
In-Reply-To: <CAKMK7uHxtvd4=POpBEPNfimjpz6Q7AO4P_XWsgd0fiLN8G1bUA@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 3 Apr 2020 18:40:44 +0200
Message-ID: <CAKMK7uGL88uEFGzQgogk4vqRDcmmBb3AR+sCqK=SWtJ4p6UCxA@mail.gmail.com>
Subject: Re: amdgpu dropping load callback triggers WARN_ON in
 __drm_mode_object_add
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

NSBzZWNvbmRzIG9uIGlyYyBhbmQgSSd2ZSBmb3VuZCB0aGUgc3BsYXQgLi4uCgpkcm1fcHJvcGVy
dGllcyBuZWVkIHRvIGJlIGNyZWF0ZWQgYXQgZHJpdmVyIGxvYWQgdGltZSwgdXBmcm9udC4gWW91
CmNhbiBhdHRhY2ggdGhlbSB0byBob3RwbHVnZ2FibGUgZHJtX2Nvbm5lY3RvciBvYmplY3RzIGxh
dGVyIG9uLCBidXQKb25seSBiZWZvcmUgY2FsbGluZyBkcm1fY29ubmVjdG9yX3JlZ2lzdGVyKCku
CgpUaGUgd2FybmluZyBleGlzdHMgYmVjYXVzZSBpOTE1IGhhZCB0aGUgc2FtZSBidWcgOi0pCi1E
YW5pZWwKCk9uIEZyaSwgQXByIDMsIDIwMjAgYXQgNjozOCBQTSBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+IHdyb3RlOgo+Cj4gT24gRnJpLCBBcHIgMywgMjAyMCBhdCA2OjMwIFBNIE1p
Y2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+ID4KPiA+Cj4gPiBJJ20g
Z2V0dGluZyB0aGUgYXR0YWNoZWQgV0FSTklORyBzcGxhdHMgc2luY2UgYW1kZ3B1IGRyb3BwZWQg
aXRzIGxvYWQKPiA+IGNhbGxiYWNrLiBUaGV5J3JlIGZyb20KPiA+Cj4gPiAgICAgICAgIFdBUk5f
T04oIWRldi0+ZHJpdmVyLT5sb2FkICYmIGRldi0+cmVnaXN0ZXJlZCAmJiAhb2JqX2ZyZWVfY2Ip
Owo+ID4KPiA+IGluIF9fZHJtX21vZGVfb2JqZWN0X2FkZC4KPiA+Cj4gPiBJJ20gbm90IHN1cmUg
aG93IHRvIGFkZHJlc3MgdGhpcywgc2luY2Ugb2JqX2ZyZWVfY2IgaXMgYWx3YXlzIE5VTEwgaGVy
ZSwKPiA+IGFuZCBJIGRvbid0IHRoaW5rIE1TVCBjb25uZWN0b3JzIGdldHRpbmcgYWRkZWQgYWZ0
ZXIgZGV2LT5yZWdpc3RlcmVkIGlzCj4gPiBzZXQgY2FuIGJlIGF2b2lkZWQ/Cj4KPiBJIG5lZWQg
dGhlIGZ1bGwgc3BsYXQsIG90aGVyd2lzZSBjYW4ndCB0ZWxsIHlvdSB3aGF0J3MgZ29pbmcgd3Jv
bmcuCj4gVGhlcmUncyAyIGNhc2VzOgo+Cj4gLSBob3RwbHVnZ2FibGUgc3R1ZmYsIHdoaWNoIGhh
cyB0aGUgb2JqX2ZyZWVfY2Igc2V0LiBFc3NlbnRpYWxseSBNU1QgY29ubmVjdG9ycy4KPgo+IC0g
bm90LWhvdHBsdWdnYWJsZSBzdHVmZiwgd2hpY2ggaXMgZXZlcnl0aGluZyBlbHNlLiBUaGV5IGRv
bid0IGhhdmUKPiBvYmpfZnJlZV9jYiBzZXQuIEl0J3MgYSBkcml2ZXIgYnVnIHRvIHJlZ2lzdGVy
IHRob3NlIGFmdGVyIHRoZSBvdmVyYWxsCj4gZHJtX2RldmljZSBoYXMgYWxyZWFkeSBiZWVuIHJl
Z2lzdGVyZWQgYW5kIHB1Ymxpc2hlZCB0byB1c2Vyc3BhY2UuCj4gLURhbmllbAo+IC0tCj4gRGFu
aWVsIFZldHRlcgo+IFNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgo+ICs0MSAo
MCkgNzkgMzY1IDU3IDQ4IC0gaHR0cDovL2Jsb2cuZmZ3bGwuY2gKCgoKLS0gCkRhbmllbCBWZXR0
ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCis0MSAoMCkgNzkgMzY1IDU3
IDQ4IC0gaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
