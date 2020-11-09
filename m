Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40735C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB826206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VK/PVkAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB826206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D69289471;
	Mon,  9 Nov 2020 21:16:28 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F7A89322
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:15:32 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d142so927904wmd.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=cPfEKs3WQgi21dRprWvl0/cuPQQi8MnROC+cTFK/Hjk=;
 b=VK/PVkAs5xGOczSmdLeGGr1UjLAa1wNkT5KEULJPwAMYtTFospgWvQXmWweWxFrYSL
 q6U6xZf7/8yQcSPJDC9gc29/HZUDZJQxumZl8PUVUzDZQgsTT+tLbqAImT1M6MeJXwyZ
 oV7xNWvQnVaFCxNiqpxB+3voW1ZQ3/8BmZefBXukvEHYKHRH7eqIWIdfbW70msWZCwkK
 JvZY5XZ8k+JRvZILBg43HeLT/GvQXGoyf2hxdUCenBQmb+mura13aVQ8f3Xswo3giyBh
 18whO+eWLkOIZibns4Aiol1Az1LfYRH8imLmYxYgEPw2BD7hcD8kAl5lsTKjRErlRI3g
 nKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cPfEKs3WQgi21dRprWvl0/cuPQQi8MnROC+cTFK/Hjk=;
 b=QEOG/YFD49i6Jjl3AWT43bR2IJJHliOyphlsiVyG/LKc5IJNiwyRjelcLQFz2MOe9P
 8MKeuWF8V7qDzjqEpxiNinff2rK2F/FS3QoTuO/VaQjO05otf0yDi211C5dmobl30z9C
 LFx8rOe8vzuf7Ud7tCubAHFURaBM8KW+sM92D0IaKYCINGbTXLpd6qo8HIxp4Pq8Buga
 d/bWInILY5b2y3BZKBQfBgFcdQ++Ofr/0ApnlrYjhoT2iJ9T/BKD+NvUbY92miTyGl+m
 SAHsgatvdFetH3JPZP3qnfAZEDTcUmBD1RmXGUIu8FkY77cnjG2d/r7dkOSX9K2TvQBC
 /K0Q==
X-Gm-Message-State: AOAM533m3gHI92KH08b61X3u/ivOeKgeRj77+r7FknZ4IM4SouWzn6nQ
 P+b7H25SsZlFk1S7qV6PguQTQQ==
X-Google-Smtp-Source: ABdhPJxyV7TDW5Pt0GMSmlw9Wcknf4YsuZ7MwnLmYcynaZ+tHhjDvCCTux+hN1vU/Ah+Y0DkH8bbAw==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr1161753wmh.150.1604956531356; 
 Mon, 09 Nov 2020 13:15:31 -0800 (PST)
Received: from dell ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 35sm12713729wro.71.2020.11.09.13.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:15:30 -0800 (PST)
Date: Mon, 9 Nov 2020 21:15:28 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Message-ID: <20201109211528.GD2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
 <20201109195557.GA1940813@ravnborg.org>
 <20201109201013.GC2063125@dell>
 <20201109205236.GA1952447@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201109205236.GA1952447@ravnborg.org>
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:16:26 +0000
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAwOSBOb3YgMjAyMCwgU2FtIFJhdm5ib3JnIHdyb3RlOgoKPiBPbiBNb24sIE5vdiAw
OSwgMjAyMCBhdCAwODoxMDoxM1BNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBPbiBNb24s
IDA5IE5vdiAyMDIwLCBTYW0gUmF2bmJvcmcgd3JvdGU6Cj4gPiAKPiA+ID4gSGkgQWxleCwKPiA+
ID4gT24gTW9uLCBOb3YgMDksIDIwMjAgYXQgMDI6NTA6MzVQTSAtMDUwMCwgQWxleCBEZXVjaGVy
IHdyb3RlOgo+ID4gPiA+IE9uIEZyaSwgTm92IDYsIDIwMjAgYXQgNDo1MCBQTSBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBGaXhlcyB0
aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPiA+ID4gPiA+Cj4gPiA+
ID4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6MjI2OiB3YXJuaW5nOiBG
dW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdkZXYnIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVv
bl9pbmZvX2lvY3RsJwo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2tt
cy5jOjIyNjogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAncmRldicgZGVzY3Jp
cHRpb24gaW4gJ3JhZGVvbl9pbmZvX2lvY3RsJwo+ID4gPiA+ID4KPiA+ID4gPiA+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiA+ID4gPiBDYzogIkNocmlz
dGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiA+ID4gPiBDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+ID4gPiA+ID4gQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KPiA+ID4gPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+ID4gPiA+ID4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiA+
ID4gPiAtLS0KPiA+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYyB8
IDIgKy0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKPiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwo+
ID4gPiA+ID4gaW5kZXggMGQ4ZmJhYmZmY2VhZC4uMjFjMjA2Nzk1YzM2NCAxMDA2NDQKPiA+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jCj4gPiA+ID4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwo+ID4gPiA+ID4gQEAgLTIx
Myw3ICsyMTMsNyBAQCBzdGF0aWMgdm9pZCByYWRlb25fc2V0X2ZpbHBfcmlnaHRzKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsCj4gPiA+ID4gPiAgLyoqCj4gPiA+ID4gPiAgICogcmFkZW9uX2luZm9f
aW9jdGwgLSBhbnN3ZXIgYSBkZXZpY2Ugc3BlY2lmaWMgcmVxdWVzdC4KPiA+ID4gPiA+ICAgKgo+
ID4gPiA+ID4gLSAqIEByZGV2OiByYWRlb24gZGV2aWNlIHBvaW50ZXIKPiA+ID4gPiA+ICsgKiBA
ZGV2OiByYWRlb24gZGV2aWNlIHBvaW50ZXIKPiA+ID4gPiAKPiA+ID4gPiBUaGlzIHNob3VsZCBi
ZToKPiA+ID4gPiArICogQGRldjogZHJtIGRldmljZSBwb2ludGVyCj4gPiA+IAo+ID4gPiBnb29k
IHNwb3QuIEkgYW0gY29udGludWluZyB0aGUgd29yayBvbiByYWRlb24gYW5kIHdpbGwgcG9zdCBh
IHBhdGNoc2V0Cj4gPiA+IHRoYXQgY29udGFpbnMgb25seSByYWRlb24gZml4ZXMgd2l0aCBMZWUn
cyBwYXRjaGVzIGFuZCBhIGZldyBtb3JlIGJ5IG1lLgo+ID4gPiBJIHdpbGwgZml4IHRoZSBhYm92
ZS4KPiA+IAo+ID4gV2hhdCBkbyB5b3UgbWVhbiBieSAiY29udGludWluZyBvbiI/Cj4gPiAKPiA+
IEhvdyB3aWxsIHlvdSBwcmV2ZW50IHlvdXIgd29yayBmcm9tIGNvbmZsaWN0aW5nIHdpdGggbXkg
Y3VycmVudCBlZmZvcnQ/Cj4gCj4gUXVvdGluZyBmcm9tIHByZXZpb3VzIG1haWwgaW4gdGhpcyB0
aHJlYWQ6Cj4gCj4gICAiCj4gICA+ID4gSG93IHdvdWxkIHlvdSBsaWtlIG1lIHRvIG1vdmUgZm9y
d2FyZD8KPiAgID4KPiAgID4gRml4IHRoZSB0aG91c2FuZCBvZiB3YXJuaW5ncyBpbiBvdGhlciBw
bGFjZXMgOi0pCj4gICA+IEkgd2lsbCB0YWtlIGEgbG9vayBhdCByYWRlb24gYW5kIHBvc3QgYSBu
ZXcgc2VyaWVzIGJhc2VkIG9uIHlvdXIgd29yawo+ICAgPiB3aXRoIGFsbCBXPTEgd2FybmluZ3Mg
Zml4ZWQuCj4gCj4gICBJJ2xsIGRyb3AgdGhpcyBwYXRjaCBhbmQgY2Fycnkgb24gcGxvdWdoaW5n
IHRocm91Z2ggdGhlIHJlc3Qgb2YgdGhlbS4KPiAiCj4gCj4gSGVyZSBJIHByb21pc2VkIHlvdSB0
byBmaXggYWxsIHdhcm5pbmdzIGluIHRoZSByYWRlb24gZHJpdmVyLgo+IEFuZCBkZXNwaXRlIHRo
aXMgYmVpbmcgbW9yZSB3b3JrIHRoYW4gYW50aWNpcGF0ZWQgYSBwcm9taXNlIGlzIGEKPiBwcm9t
aXNlLiBTbyB0aGVyZWZvcmUgSSBzdGFydGVkIHdvcmtpbmcgb24gdGhpcy4KPiAKPiBJZiB5b3Ug
d2FudCB0byBkbyB0aGUgcmVzdCBvZiB0aGUgcmFkZW9uIGRyaXZlciB5b3UgYXJlIHdlbGNvbWUg
YW5kIEkKPiB3aWxsIGdsYWRseSBkcm9wIHRoaXMgYWdhaW4uIEp1c3QgbGV0IG1lIGtub3cgeW91
ciBwcmVmZXJlbmNlLgoKVGhhdCB3YXMgdGhlIHBsYW4uICBUbyBjb250aW51ZSBvbiBhbmQgc29s
dmUgYXMgbWFueSB3YXJuaW5ncyBhcyBJIGNhbgpiZWZvcmUgSSBzdGFydCBidW1waW5nIGludG8g
bW9yZSBzZXJpb3VzIGlzc3VlcyBsaWtlIHRoZSBvbmUgbWVudGlvbmVkCmFib3ZlLiAgSWYgeW91
J2QgbGlrZSB0byBzb2x2ZSB0aGUgcmFkZW9uX2luaXQoKSBpc3N1ZSByaWdodCBhd2F5Owpob3dl
dmVyLCB0aGF0IHdvdWxkIGJlIHN1cGVyIGhlbHBmdWwuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzm
lq9dClNlbmlvciBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3Jn
IOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFj
ZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
