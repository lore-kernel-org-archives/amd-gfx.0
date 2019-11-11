Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C52C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C0820818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C0820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4A96E99A;
	Mon, 11 Nov 2019 17:39:55 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC03C6E99A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 17:39:53 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b11so157780wmb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 09:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IsvFfyYzObMz0E80oePEHKNdlBYEnXHiNEie3XzRw4g=;
 b=O3AGR5/iabmqX323yrebbg5gXZlRHI62euFFix168APg33WGSXLPTL2ect0apfMI85
 qFbR7t/w7Gnm57UzTspv/UCqRwRUYhqo+rHkWM7oKQcdd0KT/mNz5t0JoK8hTzV/j3Cl
 LXGlTgNxl1Lmsl1YqjJhIs490xmUDFK1PGRFJ+u4K5vqnXSfWLc+sr1J33gGwaxNFPez
 wJ5IvXA2aHQ8cJUXCPzR5gA5WngVQG3nLmX764fuiOAytdgsshSiM4PM4yb7DTPvZd1C
 aejKcx9o+sTjd5fX0t+ATcVz1iPwuN+GpPqwmBE+c2mDqVhm7nKg8mD/mzswsp0Oo4co
 YCiQ==
X-Gm-Message-State: APjAAAX34GRD/k8prGRUy5M4LR7XGb77phL6d8VP4qdTrJxe0mGQQZd8
 OaiVmyQ6WMJSls93d8/gCb05U0ppOwzG+dkrUrs=
X-Google-Smtp-Source: APXvYqxxIGxAAxe249g0ekm9J2uAeT3EZbyT7gaLVuX0aBuvunWDawECNdVASThvb+L775nnTvGjBAuIlnAWjdK1Vx8=
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr161512wml.102.1573493992334; 
 Mon, 11 Nov 2019 09:39:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573248368.git.mcoffin13@gmail.com>
In-Reply-To: <cover.1573248368.git.mcoffin13@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Nov 2019 12:39:40 -0500
Message-ID:
 <CADnq5_MXWLkDoAwc8w=jB4uRuyd=JSuW=f0BbFXs1Dx8LwKh6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] navi10: Implement overdrive pp_od_clk_voltage
To: Matt Coffin <mcoffin13@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=IsvFfyYzObMz0E80oePEHKNdlBYEnXHiNEie3XzRw4g=;
 b=nbhrLdKeDJOQYWdrQo2vtWZRRn2Re4oD4x0PirB5r8On82gTH/dbMpwOrWHSs4cDU4
 uQyMXYtlFQk8wW0gGJNRKaZKNBm7tUFYJngN+kvvCkG+IzF0W4IFEkpRHeZIqfPPMt34
 5ro0sdo2TBttut9fAZFRQv69PSrPYQX+XncUaX5dKZfM3aa9T29Xboe4rjTcKx30A6ha
 MdFr1TesoZDucV56QlhpU252yqQMMr325b2Zin/XuimsSqtpEHL8tZXPymn20LdRHl3M
 4aV+NBwNui1yKFed3BIiQSB/sIBGZa7rQ5m2hAQU0cUWYZiaNLwxSA2KcAXWQbHybF5t
 Eh3w==
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111173940.CUN0BtsiwwoxAYGGUTfa6pLv7TzA9Qz6w16Rx_cb1wk@z>

UGF0Y2hlcyBhcmUgbWlzc2luZyB5b3VyIFNpZ25lZC1vZmYtYnkuICBQbGVhc2UgZm9sbG93IHVw
IHdpdGggdGhhdAphbmQgSSdsbCBhcHBseSB0aGVtLgoKVGhhbmtzIQoKQWxleAoKT24gRnJpLCBO
b3YgOCwgMjAxOSBhdCA0OjI4IFBNIE1hdHQgQ29mZmluIDxtY29mZmluMTNAZ21haWwuY29tPiB3
cm90ZToKPgo+IFtXaHldCj4gQmVmb3JlIHRoaXMgcGF0Y2hzZXQsIG5hdmkxMCB1c2VycyBjb3Vs
ZCBub3QgdXRpbGl6ZSB0aGUgb3ZlcmRyaXZlCj4gZnVuY3Rpb25hbGl0eS4gVGhpcyBwcmV2ZW50
ZWQgdGhlbSBmcm9tIG92ZXJjbG9ja2luZywgb3ZlcnZvbHRpbmcsIG9yCj4gdW5kZXJ2b2x0aW5n
IHRoZWlyIGNhcmRzLgo+Cj4gW0hvd10KPiBTaW1pbGFyIHRvIHRoZSB2ZWdhMjAgaW1wbGVtZW50
YXRpb24sIGFkZCB0aGUgcHBfb2RfY2xrX3ZvbHRhZ2UKPiBpbnRlcmZhY2UgdG8gdGhlIG5hdmkx
MCBwb3dlcnBsYXkgdGFibGUuCj4KPiBbUG9zc2libGUgQWx0ZXJuYXRpdmVzXQo+IFRoaXMgY291
bGQgYWxzbyBiZSBkb25lIG1vcmUgZ2VuZXJpY2FsbHkgaW4gc211X3YxMV8wIGNvZGUsIGJ1dCB3
b3VsZAo+IHJlcXVpcmUgbW9yZSBzaWduaWZpY2FudCBjaGFuZ2VzIHRvIHRoZSB2ZWdhMjAgY29k
ZSwgYW5kIGZlYXR1cmUtZ2F0aW5nCj4gYmFzZWQgb24gY2hpcCBjYXBhYmlsaXRpZXMgaW4gdGhl
IHNtdSB0byBkaXNhYmxlIG92ZXJkcml2ZSBmb3IgYXJjdGVydXMuCj4gSSBjaG9zZSB0aGlzIHBh
dGggc28gYXMgbm90IHRvIGNvbXBsZXRlbHkgcmVmYWN0b3IgdGhlIHZlZ2EyMCBzaWRlIG9mCj4g
dGhpbmdzLCBhbmQgaW50cm9kdWNlIFNNVSBjb2RlIHdoaWNoIHdvdWxkIG5vdCBwbGF5IG5pY2Vs
eSB3aXRoIG5ldwo+IEFTSUNzLgo+Cj4gdjI6IHJlYmFzZSBvZmYgbGF0ZXN0IGNvZGUsIGFuZCBy
ZW1vdmUgYW4gaW5jb3JyZWN0IGJvdW5kcyBjaGVjawo+Cj4gTWF0dCBDb2ZmaW4gKDMpOgo+ICAg
ZHJtL2FtZGdwdS9uYXZpMTA6IGltcGxlbWVudCBzY2xrL21jbGsgT0QgdmlhIHBwX29kX2Nsa192
b2x0YWdlCj4gICBkcm0vYW1kZ3B1L25hdmkxMDogaW1wbGVtZW50IEdGWENMS19DVVJWRSBvdmVy
ZHJpdmUKPiAgIGRybS9hbWRncHUvbmF2aTEwOiBJbXBsZW1lbnQgb2QgY2xrIHByaW50aW5nCj4K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdV92MTFfMC5oIHwgICAyICsK
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jICAgIHwgMjgyICsr
KysrKysrKysrKysrKysrKwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBf
cHB0LmggICAgfCAgIDIgKwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEx
XzAuYyAgICAgfCAgMjcgKysKPiAgNCBmaWxlcyBjaGFuZ2VkLCAzMTMgaW5zZXJ0aW9ucygrKQo+
Cj4gLS0KPiAyLjIzLjAKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
