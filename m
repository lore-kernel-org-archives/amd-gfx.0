Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F33EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 08:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7B864F30
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 08:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7B864F30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qtec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A166E162;
	Thu, 18 Mar 2021 08:18:32 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939FA6E0C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 08:18:30 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id w37so3163188lfu.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtec.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O/WY2Bl4bEwXZZzzpuZUOllqUEJ+Z8Y/vfnp2iRL83U=;
 b=fDR0gy+9vrvudTQpd8ALd/Pi3bgro8qTAxQigVBuyYE5fefSUqrOPfNC94xzZedzqr
 hnq76OVGUfFwS258l8rVenrcSCgFjRhCa9YaAX7TnzAedyGfbM4+1uA/hycOT4YqveQS
 w0KJxg7X+yNYRMnow3I6GRXKOe3FCCuVG7vrk0qhV2jbEdiihLNndkQwV+e12UDRKlUO
 8HjL65l0MSrkY6pxpacWr5oD9JEIMF+jlWPlG7m53Y7Cm3EzOAGg52AHLRFVgQtPzWaY
 xHLP67ZuQ/DwGsmOM5ClC8/ngx/FaQSBvqSgeZhrmZ2se0TDayHUrvL8apgqXECSMHFJ
 nLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O/WY2Bl4bEwXZZzzpuZUOllqUEJ+Z8Y/vfnp2iRL83U=;
 b=DaWiXK6srNjNwORX3SD2modOhN10q93+UKkc5zRCS/TI/ABNHb+Gw0x2kcjvgSdMqV
 UjxcYngA7NClmmPX73U+RiJltdUUR2mZEdwA/lidxSWoi9+l3RpFSpXDjhykDhMkFSck
 z6P9eKqQOtMQGPAB9Ad/ztLB3YCfEzswM54Os7EEspIuYxTUPA9vjHzJKuVPwjiZjhv2
 +URBVUL/ogL8eEbpv+srVFZT6B+sETTaF8nMVc7K46hCH4o5v6+/imPQp3XFcB/ZtGHb
 0DyWpAMqwGcsNhtoKJn+mO/ItbD9A9bNQMikY5FaQQ4yhEUJlP2y8bIGOgk0nBhhqVmb
 WRng==
X-Gm-Message-State: AOAM531RTZT8LGSGpMGEiOqckVXBNbCawXR1tavBZ3Z75C8XAERRfW01
 sNrUg2WB4AiktQQx/eBf5fbFRVNjyFj1WIs6NDZZIA==
X-Google-Smtp-Source: ABdhPJxeSEGQ5VxzxzzuKMz+JRZK3Y8C7XkLNiducFb7gkrMCDzzC+lAffXBLb1HjWZ0YQ0AsfAJEhTXxhi/sUbQYT4=
X-Received: by 2002:a19:791e:: with SMTP id u30mr4703038lfc.621.1616055509025; 
 Thu, 18 Mar 2021 01:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210317160840.36019-1-daniel@qtec.com>
 <bb94b582-a720-9c4f-3d37-d1f7fd29da44@amd.com>
In-Reply-To: <bb94b582-a720-9c4f-3d37-d1f7fd29da44@amd.com>
From: Daniel Gomez <daniel@qtec.com>
Date: Thu, 18 Mar 2021 09:18:17 +0100
Message-ID: <CAH1Ww+SBgw6-HikPBpE1_yLG-X75LfSBbNerzzqBzyCArgm1-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/ttm: Fix memory leak userptr pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Gomez <dagmcr@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>, Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCAxOCBNYXIgMjAyMSBhdCAwODo0OSwgQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFtIDE3LjAzLjIxIHVtIDE3OjA4IHNjaHJpZWIg
RGFuaWVsIEdvbWV6Ogo+ID4gSWYgdXNlcnB0ciBwYWdlcyBoYXZlIGJlZW4gcGlubmVkIGJ1dCBu
b3QgYm91bmRlZCwKPiA+IHRoZXkgcmVtYWluIHVuY2xlYXJlZC4KPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBEYW5pZWwgR29tZXogPGRhbmllbEBxdGVjLmNvbT4KPgo+IEdvb2QgY2F0Y2gsIG5vdCBz
dXJlIGlmIHRoYXQgY2FuIGV2ZXIgaGFwcGVuIGluIHByYWN0aWNlIGJ1dCBiZXR0ZXIgc2F2ZQo+
IHRoYW4gc29ycnkuClRoYW5rcyEgV2UgYWN0dWFsbHkgaGFkIGEgY2FzZSB3aXRoIGNsRW5xdWV1
ZVdyaXRlQnVmZmVyIHdoZXJlIHRoZQpkcml2ZXIgd2FzIGxlYWtpbmcuCkkgY2FuIHNlZSB0aGUg
cHJvYmxlbSBhbHNvIGFmZmVjdHMgdG8gdGhlIHJhZGVvbiBkcml2ZXIgc28sIEknbGwgc2VuZAph
IHBhdGNoIGZvciB0aGF0IG9uZSBhcwp3ZWxsLgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDYgKysrLS0tCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+ID4gaW5kZXggOWZkMjE1N2IxMzNhLi41MGMy
YjQ4MjdjMTMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
Ywo+ID4gQEAgLTExNjIsMTMgKzExNjIsMTMgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3R0bV9iYWNr
ZW5kX3VuYmluZChzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwKPiA+ICAgICAgIHN0cnVjdCBh
bWRncHVfdHRtX3R0ICpndHQgPSAodm9pZCAqKXR0bTsKPiA+ICAgICAgIGludCByOwo+ID4KPiA+
IC0gICAgIGlmICghZ3R0LT5ib3VuZCkKPiA+IC0gICAgICAgICAgICAgcmV0dXJuOwo+ID4gLQo+
ID4gICAgICAgLyogaWYgdGhlIHBhZ2VzIGhhdmUgdXNlcnB0ciBwaW5uaW5nIHRoZW4gY2xlYXIg
dGhhdCBmaXJzdCAqLwo+ID4gICAgICAgaWYgKGd0dC0+dXNlcnB0cikKPiA+ICAgICAgICAgICAg
ICAgYW1kZ3B1X3R0bV90dF91bnBpbl91c2VycHRyKGJkZXYsIHR0bSk7Cj4gPgo+ID4gKyAgICAg
aWYgKCFndHQtPmJvdW5kKQo+ID4gKyAgICAgICAgICAgICByZXR1cm47Cj4gPiArCj4gPiAgICAg
ICBpZiAoZ3R0LT5vZmZzZXQgPT0gQU1ER1BVX0JPX0lOVkFMSURfT0ZGU0VUKQo+ID4gICAgICAg
ICAgICAgICByZXR1cm47Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
