Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6173C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 22:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866CE2073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 22:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEZAPXIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866CE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 886466E264;
	Tue, 21 Jul 2020 22:46:07 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4434B6E132;
 Tue, 21 Jul 2020 22:46:06 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id y10so183008eje.1;
 Tue, 21 Jul 2020 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9xr1v2W2JnKVVLyTRtwOt/n6iJhD2D3A0fwqKMz4hPs=;
 b=rEZAPXIor3Dz4RHCbGWSYP7bPSEIjpr4PFXwS2Im8j4mhj6ape6iAKrEuKt9/16wJb
 lZpHG0XlEaVhnsqWhDvwzZnhbH2qGMHiCuDZM7WS0KrrZjv8jJcsCna7l+z6N03RSryI
 U8/GUuaiXjjM2Legmhg4UW/y2nxUfiL9rhNEEIH/m+ikMiguNIXPzWp5FcJ8lZyev8PT
 WLWiiHIj1Ebcit0XN21uV4r+cIGcJsECcR3QBWCPN5odx48VmqH3GUnoXIOIUIHYK2TF
 yOJJ06VoDsthqoqZ7vPs3+DXb1cqJV++ZhwSCJu2JFkx6/PDQzDmpkrcwLU4TMBFOJQB
 RSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9xr1v2W2JnKVVLyTRtwOt/n6iJhD2D3A0fwqKMz4hPs=;
 b=eVHoKeRZld9upd59QxrMJFo/sXoGOT7VbKgHYPdQl6wkGKta9CV1ZcfRkBbyJMQKPM
 glhydCu2jhwEPJXS0fKcKyUQwWIhLEQJQ1EGgHDnv6836Wn8QY8fi9nsTa9FN548IQCT
 lLJlg6kF/WxfXz1uxI182ES1I+Zn/M0/1F6137yPg8aj1ei4EtrFAg0vnsC+ayHbUi9y
 9OxNSKoaTGqMEQmUSnWdCy3J9wGY5257sTedpGierpdv5yQj1zZWayaAoLXK5p4dQC6A
 2zmLO++7NcFMTaPAerueI/fti3jX02Ypdx0YEveb676de0ZfuTfGM5vgqMsFcekaBaXW
 CzRA==
X-Gm-Message-State: AOAM530wAnNQ/x10hZ+TqDmstIOaLSLlQ09h6SLyV9aPxiKo1SsznEWs
 ryc0qxDBT0dUSN/y6YzRgwr9he+jhJyozJc9das=
X-Google-Smtp-Source: ABdhPJwZ3Ot7QKWc1rFSm9ERPUfpZAjcJpv8FnDDuXOOnkUxeoTuK9PsCTyGH0MloHa+IJHrTWbjlRTbPgJrqaOl/nY=
X-Received: by 2002:a17:906:4086:: with SMTP id u6mr3259703ejj.9.1595371564794; 
 Tue, 21 Jul 2020 15:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
In-Reply-To: <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 22 Jul 2020 08:45:53 +1000
Message-ID: <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= <thomas_os@shipmail.org>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Daniel Stone <daniels@collabora.com>, linux-rdma <linux-rdma@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Steve Pronovost <spronovo@microsoft.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCAyMSBKdWwgMjAyMCBhdCAxODo0NywgVGhvbWFzIEhlbGxzdHLDtm0gKEludGVsKQo8
dGhvbWFzX29zQHNoaXBtYWlsLm9yZz4gd3JvdGU6Cj4KPgo+IE9uIDcvMjEvMjAgOTo0NSBBTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiA+IEFtIDIxLjA3LjIwIHVtIDA5OjQxIHNjaHJpZWIg
RGFuaWVsIFZldHRlcjoKPiA+PiBPbiBNb24sIEp1bCAyMCwgMjAyMCBhdCAwMToxNToxN1BNICsw
MjAwLCBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpCj4gPj4gd3JvdGU6Cj4gPj4+IEhpLAo+ID4+
Pgo+ID4+PiBPbiA3LzkvMjAgMjozMyBQTSwgRGFuaWVsIFZldHRlciB3cm90ZToKPiA+Pj4+IENv
bWVzIHVwIGV2ZXJ5IGZldyB5ZWFycywgZ2V0cyBzb21ld2hhdCB0ZWRpb3VzIHRvIGRpc2N1c3Ms
IGxldCdzCj4gPj4+PiB3cml0ZSB0aGlzIGRvd24gb25jZSBhbmQgZm9yIGFsbC4KPiA+Pj4+Cj4g
Pj4+PiBXaGF0IEknbSBub3Qgc3VyZSBhYm91dCBpcyB3aGV0aGVyIHRoZSB0ZXh0IHNob3VsZCBi
ZSBtb3JlIGV4cGxpY2l0IGluCj4gPj4+PiBmbGF0IG91dCBtYW5kYXRpbmcgdGhlIGFtZGtmZCBl
dmljdGlvbiBmZW5jZXMgZm9yIGxvbmcgcnVubmluZyBjb21wdXRlCj4gPj4+PiB3b3JrbG9hZHMg
b3Igd29ya2xvYWRzIHdoZXJlIHVzZXJzcGFjZSBmZW5jaW5nIGlzIGFsbG93ZWQuCj4gPj4+IEFs
dGhvdWdoIChpbiBteSBodW1ibGUgb3BpbmlvbikgaXQgbWlnaHQgYmUgcG9zc2libGUgdG8gY29t
cGxldGVseQo+ID4+PiB1bnRhbmdsZQo+ID4+PiBrZXJuZWwtaW50cm9kdWNlZCBmZW5jZXMgZm9y
IHJlc291cmNlIG1hbmFnZW1lbnQgYW5kIGRtYS1mZW5jZXMgdXNlZAo+ID4+PiBmb3IKPiA+Pj4g
Y29tcGxldGlvbi0gYW5kIGRlcGVuZGVuY3kgdHJhY2tpbmcgYW5kIGxpZnQgYSBsb3Qgb2YgcmVz
dHJpY3Rpb25zCj4gPj4+IGZvciB0aGUKPiA+Pj4gZG1hLWZlbmNlcywgaW5jbHVkaW5nIHByb2hp
Yml0aW5nIGluZmluaXRlIG9uZXMsIEkgdGhpbmsgdGhpcyBtYWtlcwo+ID4+PiBzZW5zZQo+ID4+
PiBkZXNjcmliaW5nIHRoZSBjdXJyZW50IHN0YXRlLgo+ID4+IFllYWggSSB0aGluayBhIGZ1dHVy
ZSBwYXRjaCBuZWVkcyB0byB0eXBlIHVwIGhvdyB3ZSB3YW50IHRvIG1ha2UgdGhhdAo+ID4+IGhh
cHBlbiAoZm9yIHNvbWUgY3Jvc3MgZHJpdmVyIGNvbnNpc3RlbmN5KSBhbmQgd2hhdCBuZWVkcyB0
byBiZQo+ID4+IGNvbnNpZGVyZWQuIFNvbWUgb2YgdGhlIG5lY2Vzc2FyeSBwYXJ0cyBhcmUgYWxy
ZWFkeSB0aGVyZSAod2l0aCBsaWtlIHRoZQo+ID4+IHByZWVtcHRpb24gZmVuY2VzIGFtZGtmZCBo
YXMgYXMgYW4gZXhhbXBsZSksIGJ1dCBJIHRoaW5rIHNvbWUgY2xlYXIgZG9jcwo+ID4+IG9uIHdo
YXQncyByZXF1aXJlZCBmcm9tIGJvdGggaHcsIGRyaXZlcnMgYW5kIHVzZXJzcGFjZSB3b3VsZCBi
ZSByZWFsbHkKPiA+PiBnb29kLgo+ID4KPiA+IEknbSBjdXJyZW50bHkgd3JpdGluZyB0aGF0IHVw
LCBidXQgcHJvYmFibHkgc3RpbGwgbmVlZCBhIGZldyBkYXlzIGZvcgo+ID4gdGhpcy4KPgo+IEdy
ZWF0ISBJIHB1dCBkb3duIHNvbWUgKHZlcnkpIGluaXRpYWwgdGhvdWdodHMgYSBjb3VwbGUgb2Yg
d2Vla3MgYWdvCj4gYnVpbGRpbmcgb24gZXZpY3Rpb24gZmVuY2VzIGZvciB2YXJpb3VzIGhhcmR3
YXJlIGNvbXBsZXhpdHkgbGV2ZWxzIGhlcmU6Cj4KPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3Rv
cC5vcmcvdGhvbWFzaC9kb2NzLy0vYmxvYi9tYXN0ZXIvVW50YW5nbGluZyUyMGRtYS1mZW5jZSUy
MGFuZCUyMG1lbW9yeSUyMGFsbG9jYXRpb24ub2R0CgpXZSBhcmUgc2VlaW5nIEhXIHRoYXQgaGFz
IHJlY292ZXJhYmxlIEdQVSBwYWdlIGZhdWx0cyBidXQgb25seSBmb3IKY29tcHV0ZSB0YXNrcywg
YW5kIHNjaGVkdWxlciB3aXRob3V0IHNlbWFwaG9yZXMgaHcgZm9yIGdyYXBoaWNzLgoKU28gYSBz
aW5nbGUgZHJpdmVyIG1heSBoYXZlIHRvIGV4cG9zZSBib3RoIG1vZGVscyB0byB1c2Vyc3BhY2Ug
YW5kCmFsc28gaW50cm9kdWNlcyB0aGUgcHJvYmxlbSBvZiBob3cgdG8gaW50ZXJvcGVyYXRlIGJl
dHdlZW4gdGhlIHR3bwptb2RlbHMgb24gb25lIGNhcmQuCgpEYXZlLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
