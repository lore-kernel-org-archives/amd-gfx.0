Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF89C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 18:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D3F61153
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 18:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D3F61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E036E959;
	Wed, 14 Apr 2021 18:18:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EF56E959
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618424281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqMQq5ZjcTbXc6ahUAb6RtVIAIQY30tln4IDoLvU+WA=;
 b=D0FS6MN7uUD3y/GnhIc14w0bP4GIFSVUAoSQRN0/i5TgMplZ9hbKiG9hCBHehDk8mYwzOg
 AIPak4q9NQucVrGicPcIc9XT+uPOayDWvgsojmM5kP4L4+c4FNutmzVJbZp0FwGYoB24iZ
 YlKuLnS3Qa4Vv9DxHWvs+0xG8TlvKBM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-sgj8-G_MOlCHNtl5Vw7wSg-1; Wed, 14 Apr 2021 14:17:47 -0400
X-MC-Unique: sgj8-G_MOlCHNtl5Vw7wSg-1
Received: by mail-qv1-f69.google.com with SMTP id
 r7-20020a0562140c47b029019a1a3b7044so157784qvj.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 11:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=PqMQq5ZjcTbXc6ahUAb6RtVIAIQY30tln4IDoLvU+WA=;
 b=UKfFviTqMAiXxy6kB6L2YkRfW8pDVngoSw590+Y7qG/I4TEUTAhwrdIlQCAvUnCeC8
 HpOifkQ62zSVoLpwCCEDu/JHP/nElKkyK2+dxXKy1xBJ0qAMGvdMgHgGfYYK3btpOMz2
 y/NX44AqF3riGZhoiXRn3TEK8H5fMShLhgS08wlE4bmoE0oJYxOgFIwPRgnsyjKs9MpG
 oppJ7FfNzEY5Xf1e0a5h41059GQmEs8kpCZ5G7XQo/MMHnjAovbLZjfN7dnkEliUbZ2x
 ysbjknfUo0MOziSaFk2tmT5WAvwLk4kD2o7A1uBKyEkz2XqyhIg2A/j6djwLaTMKVJYl
 MN8A==
X-Gm-Message-State: AOAM530C5cshLU+kEsg2DUzJoZjdNqauEr5qCpcH2GG4eXQJjOLWyRys
 I7oYeUHyWHFQmM5bYGZao8PXUlf7y4NfHXOVD0IXE8dMkVwW9Xq6K0EFGCin9F+fCVt08YoBqj0
 7IevizGuXoyAsskaDGndaD8Vk/w==
X-Received: by 2002:ae9:ed16:: with SMTP id c22mr21123678qkg.292.1618424267411; 
 Wed, 14 Apr 2021 11:17:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhCLrjqwhBZruoTsJbpDIweXUGa1EcovOGAxb7r+GzlNzNtaJxFvwGSpsXlU7qgvJApBoMyg==
X-Received: by 2002:ae9:ed16:: with SMTP id c22mr21123654qkg.292.1618424267200; 
 Wed, 14 Apr 2021 11:17:47 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id e7sm113738qth.27.2021.04.14.11.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 11:17:46 -0700 (PDT)
Message-ID: <0a64b70c89699b4e6c7aaa3ba8e75531031faa3c.camel@redhat.com>
Subject: Re: [PATCH 03/30] drm/tegra: Don't register DP AUX channels before
 connectors
From: Lyude Paul <lyude@redhat.com>
To: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 14 Apr 2021 14:17:45 -0400
In-Reply-To: <YHcdCAQ7Dlb2vSzn@orome.fritz.box>
References: <20210219215326.2227596-1-lyude@redhat.com>
 <20210219215326.2227596-4-lyude@redhat.com>
 <YHcdCAQ7Dlb2vSzn@orome.fritz.box>
Organization: Red Hat
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 "open list:DRM DRIVERS FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAyMDIxLTA0LTE0IGF0IDE4OjQ5ICswMjAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToK
PiBPbiBGcmksIEZlYiAxOSwgMjAyMSBhdCAwNDo1Mjo1OVBNIC0wNTAwLCBMeXVkZSBQYXVsIHdy
b3RlOgo+ID4gQXMgcG9pbnRlZCBvdXQgYnkgdGhlIGRvY3VtZW50YXRpb24gZm9yIGRybV9kcF9h
dXhfcmVnaXN0ZXIoKSwKPiA+IGRybV9kcF9hdXhfaW5pdCgpIHNob3VsZCBiZSB1c2VkIGluIHNp
dHVhdGlvbnMgd2hlcmUgdGhlIEFVWCBjaGFubmVsIGZvciBhCj4gPiBkaXNwbGF5IGRyaXZlciBj
YW4gcG90ZW50aWFsbHkgYmUgcmVnaXN0ZXJlZCBiZWZvcmUgaXQncyByZXNwZWN0aXZlIERSTQo+
ID4gZHJpdmVyLiBUaGlzIGlzIHRoZSBjYXNlIHdpdGggVGVncmEsIHNpbmNlIHRoZSBEUCBhdXgg
Y2hhbm5lbCBleGlzdHMgYXMgYQo+ID4gcGxhdGZvcm0gZGV2aWNlIGluc3RlYWQgb2YgYmVpbmcg
YSBncmFuZGNoaWxkIG9mIHRoZSBEUk0gZGV2aWNlLgo+ID4gCj4gPiBTaW5jZSB3ZSdyZSBhYm91
dCB0byBhZGQgYSBiYWNrcG9pbnRlciB0byBhIERQIEFVWCBjaGFubmVsJ3MgcmVzcGVjdGl2ZQo+
ID4gRFJNCj4gPiBkZXZpY2UsIGxldCdzIGZpeCB0aGlzIHNvIHRoYXQgd2UgZG9uJ3QgcG90ZW50
aWFsbHkgYWxsb3cgdXNlcnNwYWNlIHRvIHVzZQo+ID4gdGhlIEFVWCBjaGFubmVsIGJlZm9yZSB3
ZSd2ZSBhc3NvY2lhdGVkIGl0IHdpdGggaXQncyBEUk0gY29ubmVjdG9yLgo+ID4gCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiDCoGRy
aXZlcnMvZ3B1L2RybS90ZWdyYS9kcGF1eC5jIHwgMTEgKysrKysrLS0tLS0KPiA+IMKgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS9kcGF1eC5jIGIvZHJpdmVycy9ncHUvZHJtL3Rl
Z3JhL2RwYXV4LmMKPiA+IGluZGV4IDEwNWZiOWNkYmIzYi4uZWE1NmM2ZWMyNWU0IDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2RwYXV4LmMKPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS90ZWdyYS9kcGF1eC5jCj4gPiBAQCAtNTM0LDkgKzUzNCw3IEBAIHN0YXRpYyBpbnQg
dGVncmFfZHBhdXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQo+ID4gKnBkZXYpCj4gPiDC
oMKgwqDCoMKgwqDCoMKgZHBhdXgtPmF1eC50cmFuc2ZlciA9IHRlZ3JhX2RwYXV4X3RyYW5zZmVy
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoGRwYXV4LT5hdXguZGV2ID0gJnBkZXYtPmRldjsKPiA+IMKg
Cj4gPiAtwqDCoMKgwqDCoMKgwqBlcnIgPSBkcm1fZHBfYXV4X3JlZ2lzdGVyKCZkcGF1eC0+YXV4
KTsKPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChlcnIgPCAwKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBlcnI7Cj4gPiArwqDCoMKgwqDCoMKgwqBkcm1fZHBfYXV4X2lu
aXQoJmRwYXV4LT5hdXgpOwo+IAo+IEkganVzdCBub3RpY2VkIHRoYXQgdGhpcyBjaGFuZ2UgY2F1
c2VzIGFuIGVycm9yIG9uIHNvbWUgc2V0dXBzIHRoYXQgSQo+IGhhdmVuJ3Qgc2VlbiBiZWZvcmUu
IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIFNPUiBkcml2ZXIgdHJpZXMgdG8gZ3JhYiBhCj4gcmVm
ZXJlbmNlIHRvIHRoZSBJMkMgZGV2aWNlIHRvIG1ha2Ugc3VyZSBpdCBkb2Vzbid0IGdvIGF3YXkg
d2hpbGUgaXQgaGFzCj4gYSBwb2ludGVyIHRvIGl0Lgo+IAo+IEhvd2V2ZXIsIHNpbmNlIG5vdyB0
aGUgSTJDIGFkYXB0ZXIgaGFzbid0IGJlZW4gcmVnaXN0ZXJlZCB5ZXQsIEkgZ2V0Cj4gdGhpczoK
PiAKPiDCoMKgwqDCoMKgwqDCoMKgW8KgwqAgMTUuMDEzOTY5XSBrb2JqZWN0OiAnKG51bGwpJyAo
MDAwMDAwMDA1YzkwM2U0Myk6IGlzIG5vdAo+IGluaXRpYWxpemVkLCB5ZXQga29iamVjdF9nZXQo
KSBpcyBiZWluZyBjYWxsZWQuCj4gCj4gSSByZWNhbGwgdGhhdCB5b3Ugd2FudGVkIHRvIG1ha2Ug
dGhpcyBjaGFuZ2Ugc28gdGhhdCBhIGJhY2twb2ludGVyIHRvCj4gdGhlIERSTSBkZXZpY2UgY291
bGQgYmUgYWRkZWQgKEkgdGhpbmsgdGhhdCdzIHBhdGNoIDE1IG9mIHRoZSBzZXJpZXMpLAo+IGJ1
dCBJIGRpZG4ndCBzZWUgdGhhdCBwYXRjaCBnZXQgbWVyZ2VkLCBzbyBpdCdzIGEgYml0IGRpZmZp
Y3VsdCB0byB0cnkKPiBhbmQgZml4IHRoaXMgdXAuCgpJJ20gcHJldHR5IHN1cmUgSSBhbHJlYWR5
IG1lcmdlZCB0aGUgdGVncmEgY2hhbmdlIGluIGRybS1taXNjLW5leHQsIHNvIGlmIGl0J3MKY2F1
c2luZyBpc3N1ZXMgeW91IHByb2JhYmx5IHNob3VsZCBzZW5kIG91dCBhIHJldmVydCBmb3Igbm93
IGFuZCBJIGNhbiByLWIgaXQKc28gd2UgY2FuIGZpZ3VyZSBvdXQgYSBiZXR0ZXIgc29sdXRpb24g
Zm9yIHRoaXMgaW4gdGhlIG1lYW4gdGltZQoKPiBIYXMgdGhlIHNpdHVhdGlvbiBjaGFuZ2VkPyBE
byB3ZSBubyBsb25nZXIgbmVlZCB0aGUgYmFja3BvaW50ZXI/IElmIHdlCj4gc3RpbGwgd2FudCBp
dCwgd2hhdCdzIHRoZSBwbGFuIGZvciBtZXJnaW5nIHRoZSBjaGFuZ2U/IFNob3VsZCBJIHdvcmsK
PiB1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IHBhdGNoIHdpbGwgbWFrZSBpdCBpbiBzb21ldGlt
ZSBhbmQgdHJ5IHRvIGZpeAo+IHRoaXMgb24gdG9wIG9mIHRoYXQ/Cgp5ZXMgd2UgZG8gc3RpbGwg
bmVlZCB0aGUgYmFja3BvaW50ZXIgLSBJJ20ganVzdCBzdGlsbCB3b3JraW5nIG9uIGdldHRpbmcK
cmV2aWV3cyBmb3Igc29tZSBvZiB0aGUgb3RoZXIgcGFydHMgb2YgdGhpcyBzZXJpZXMsIGFuZCBo
YXZlIGJlZW4gb24gUFRPL2J1c3kKd2l0aCBhIGNvdXBsZSBvZiBvdGhlciB0aGluZ3MuCgo+IAo+
IEknbSB0aGlua2luZyB0aGF0IHBlcmhhcHMgd2UgY2FuIG1vdmUgdGhlIEkyQyBhZGFwdGVyIHJl
Z2lzdHJhdGlvbiBpbnRvCj4gZHJtX2RwX2F1eF9pbml0KCkgc2luY2UgdGhhdCdzIGluZGVwZW5k
ZW50IG9mIHRoZSBEUk0gZGV2aWNlLgoKWWVhaCB0aGlzIG1ha2VzIHNlbnNlIGZvciBtZSAtIEkg
Y2FuIHRyeSB0byBtYWtlIHRoaXMgY2hhbmdlIG9uIHRoZSBuZXh0CnJlc3BpbiBvZiB0aGlzIHNl
cmllcy4gV2hhdCBraW5kIG9mIHNldHVwIHdlcmUgeW91IGFibGUgdG8gcmVwcm9kdWNlIGlzc3Vl
cyBvbgp0aGlzIHdpdGggYnR3PwoKPiAgSXQgd291bGQKPiBhbHNvIG1ha2UgYSBiaXQgbW9yZSBz
ZW5zZSBmcm9tIHRoZSBUZWdyYSBkcml2ZXIncyBwb2ludCBvZiB2aWV3IHdoZXJlCj4gYWxsIGRl
dmljZXMgd291bGQgYmUgY3JlYXRlZCBkdXJpbmcgdGhlIC0+cHJvYmUoKSBwYXRoLCBhbmQgb25s
eSBkdXJpbmcKPiB0aGUgLT5pbml0KCkgcGF0aCB3b3VsZCB0aGUgY29ubmVjdGlvbiBiZXR3ZWVu
IERSTSBkZXZpY2UgYW5kIERSTSBEUCBBVVgKPiBkZXZpY2UgYmUgZXN0YWJsaXNoZWQuCj4gCj4g
VGhpZXJyeQoKLS0gCkNoZWVycywKIEx5dWRlIFBhdWwgKHNoZS9oZXIpCiBTb2Z0d2FyZSBFbmdp
bmVlciBhdCBSZWQgSGF0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
