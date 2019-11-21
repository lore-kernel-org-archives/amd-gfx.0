Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C5DC43215
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 15:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A835F20674
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 15:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A835F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62CA36F38F;
	Thu, 21 Nov 2019 15:25:29 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6EE6F39F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 15:25:27 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g206so3908666wme.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 07:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QvbWrsC5BqzcGZLcB213h736Q5OLYneOLt9VDSXAZZY=;
 b=po+WBFofNK4SHfGBByIBdauD6kQ4cq5cD90CJI7qrjnPmMUvbACWExq6hfmmMC22r/
 sGDPc7HEFK9t5CwlVc7S4jAbnBmAY7GsSJ3nTlTZuN6fLFLKQRojcPhdV+F4pikkzvDu
 A45cp0vO/H8+jeM4dSKrLEHV9/F7N+F+rkvOm0uPxy50/VlGCUSPQflVTpWdt5IV5IL9
 rl5RL2S4blvOdjURBpkf3Mmzx+wGTz/0aoYRAYFg0G7XZ73sGuYbPBYFS9JNK1hxQZJl
 IyEIo4nf4q/aY/MSoFlU+D4FOLail3rPVeaqrYhRXLZITIiVZIKLLgZjca8ah51v7ep6
 2ilA==
X-Gm-Message-State: APjAAAUlEKRELNwt5VPu+3iCKcgFlFffL3fftaYgs1vvpkMvXibsmVi3
 QSN613VxuDaU+nvPXRET5ARUgMLaL3KTOxSMjaw=
X-Google-Smtp-Source: APXvYqxJ321N+KMbkNeNraDpKoey+U8OSjyyMk3jrXDez1jASAxplR0rzzDD3HWkhxWkf49R2w4cXuSafJraZjEKLBQ=
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr10606260wml.102.1574349926475; 
 Thu, 21 Nov 2019 07:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20191121061707.25958-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191121061707.25958-1-Jack.Zhang1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Nov 2019 10:25:14 -0500
Message-ID:
 <CADnq5_MrfFWAjC__9ccB46CYzdcLWP=DPKD70aXAm862DJLu1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus
 VF.
To: Jack Zhang <Jack.Zhang1@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=QvbWrsC5BqzcGZLcB213h736Q5OLYneOLt9VDSXAZZY=;
 b=d5D6rWcZAlLA8qzoy5puY6rGaq+SfWag0QJ0Gon+QtEWg+IiJFvCChr/inMHamXH45
 p5m0L0ap8W/BVoO5P3n4Oi49CO6BzLWwPjbNdSvnzc9bP4kCRx81Ec2Y+fAHIbWv8/Qb
 mlppLNAK55559hBA0SzGuYWWXuEj7ZTgi6waFdPGFkgmlv+SWPT9zjko3vzrkLQZbwwm
 Vx7/HBfWuAgY0lekWyVgWHcDnm45S9e/nRsxyejCD80YEmqfGNFHpRuAaAqeoQRCTngK
 ePWMjLUKLLiU9QgcY9ufiXXPo6IrNkpLlcE2685i+wbzPJSUfclqzA7G7eolYhO0DFV9
 Bvdw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121152514.mcFAKSZeA6fzs2RuOsbnn-ZtSsOxpOSCYfSsWpFB4mw@z>

V29uJ3QgdGhpcyBpbXBhY3QgYmFyZSBtZXRhbCBodyB0aGF0IG5lZWRzIHRoaXM/CgpBbGV4CgpP
biBUaHUsIE5vdiAyMSwgMjAxOSBhdCAxOjE3IEFNIEphY2sgWmhhbmcgPEphY2suWmhhbmcxQGFt
ZC5jb20+IHdyb3RlOgo+Cj4gQWZ0ZXIgcmxjZyBmdyAyLjEsIGttZCBkcml2ZXIgc3RhcnRzIHRv
IGxvYWQgZXh0cmEgZncgZm9yCj4gTElTVF9DTlRMLEdQTV9NRU0sU1JNX01FTS4gV2UgbmVlZHMg
dG8gc2tpcCB0aGUgdGhyZWUgZncKPiBiZWNhdXNlIGFsbCBybGNnIHJlbGF0ZWQgZncgaGF2ZSBi
ZWVuIGxvYWRlZCBieSBob3N0IGRyaXZlci4KPiBHdWVzdCBkcml2ZXIgd291bGQgbG9hZCB0aGUg
dGhyZWUgZncgZmFpbCB3aXRob3V0IHRoaXMgY2hhbmdlLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFj
ayBaaGFuZyA8SmFjay5aaGFuZzFAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgNSArKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jCj4gaW5kZXggYzNhNDJkMy4uZWVjZGU4MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKPiBAQCAtMTQ3MCw3ICsxNDcwLDEwIEBAIHN0YXRpYyBp
bnQgcHNwX25wX2Z3X2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gICAgICAgICAgICAg
ICAgICAgICB8fCB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1NETUE1Cj4gICAg
ICAgICAgICAgICAgICAgICB8fCB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1NE
TUE2Cj4gICAgICAgICAgICAgICAgICAgICB8fCB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VD
T0RFX0lEX1NETUE3Cj4gLSAgICAgICAgICAgICAgICAgICB8fCB1Y29kZS0+dWNvZGVfaWQgPT0g
QU1ER1BVX1VDT0RFX0lEX1JMQ19HKSkKPiArICAgICAgICAgICAgICAgICAgICB8fCB1Y29kZS0+
dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1JMQ19HCj4gKyAgICAgICAgICAgICAgICAgICB8
fCB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJU1RfQ05U
TAo+ICsgICAgICAgICAgICAgICAgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09E
RV9JRF9STENfUkVTVE9SRV9MSVNUX0dQTV9NRU0KPiArICAgICAgICAgICAgICAgICAgIHx8IHVj
b2RlLT51Y29kZV9pZCA9PSBBTURHUFVfVUNPREVfSURfUkxDX1JFU1RPUkVfTElTVF9TUk1fTUVN
KSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAvKnNraXAgdWNvZGUgbG9hZGluZyBpbiBTUklP
ViBWRiAqLwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+Cj4gLS0KPiAyLjcu
NAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
