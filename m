Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A97C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0000020772
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYLCVngy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0000020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35776E3DF;
	Tue,  2 Jun 2020 14:01:02 +0000 (UTC)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613E26E3DB;
 Tue,  2 Jun 2020 14:00:32 +0000 (UTC)
Received: by mail-pl1-x642.google.com with SMTP id g12so1366598pll.10;
 Tue, 02 Jun 2020 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7yBqRQ05m/Z4dmTqP2jf4amoRtlJTzK7ps3isjshOVc=;
 b=BYLCVngy4uvXcIBPOgBUgVA0OPaE+H9Fyfe9LVc4F4uRNZXwKG1fmWo90RbVuFdj2h
 3VSgFyffB6NjRiZG+jajuSTEagKpWwT8ZLfryOA7RcaVRV3s57dUZGAGd/QeFaXOKSwN
 wNicNnfkZQHReNgWl0ZUZ6e/OEe5N3ppU6i4QtSFoOfo7QOX3U8HCQ11vyiP680D6vJU
 m4HXHkMCbfQzopvgRyWnUi9Ep/1/CjKLH7xvxAu2KZuk/mVwA9NycekR1paT5abB5qRO
 tcDU1qOcqKNaosOCMDzgpMb9XiDWRPgNIW4a8pre/lp/T+/zExpaJ5ifhkEElourHw2i
 J+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7yBqRQ05m/Z4dmTqP2jf4amoRtlJTzK7ps3isjshOVc=;
 b=ewphgVGfBc/Ms2KeSf+DaGZmVby+9BUfrSQcG5HSvMcAQ98UgDt9UZ97tj2/ocoZdn
 9FtPFjnJcoZe06s/A4bklRhZp6EtHdc8T4eDoNV3IHf5sqhhRPeMCu2cT7Gr5QRTi3wi
 qc5F9XAeDF1PxtpwJyBJ2aRLaaThBIRBsgG9NQvmWz0DIcCmiyL+ryv0He5thRcovaoU
 lqVF8KSwd+vbo+S+eu0YExfJASSVRU+gs1Yop4+lBHH2r7N20rKp3IsQG9rvkc2rCNhu
 Wf0BZ40Ez+yho7d5QT47WkZ4lFt2zvj2USWJ3cOBEMwkUfEhsWLDbkCve3j544Y5IIw/
 vVng==
X-Gm-Message-State: AOAM533QnoiX0jwv44TBhuGKUsECfws7v8QzwhH6KS1D3abuSk51ZVpk
 m5+Om5RyZDohZMHb89SiTTaik+6n7w4tbVqzJvI=
X-Google-Smtp-Source: ABdhPJxbQimuLaI1bwYXtc/xXdK9j/EbdTfKTdAZ6xD5IZjH/RkMWlo/QACxutOeZs5hbdkLutmcnDZurql5j/rBV8g=
X-Received: by 2002:a17:90a:1704:: with SMTP id
 z4mr5657315pjd.181.1591106431949; 
 Tue, 02 Jun 2020 07:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
 <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com>
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Jun 2020 17:00:20 +0300
Message-ID: <CAHp75Vfe5dQkOiFoAZx5b-NS1afiD-YC_w+5LcX8P1Hm0ASenA@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
X-Mailman-Approved-At: Tue, 02 Jun 2020 14:01:01 +0000
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
Cc: David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMiwgMjAyMCBhdCA0OjM4IFBNIFJ1aGwsIE1pY2hhZWwgSiA8bWljaGFlbC5q
LnJ1aGxAaW50ZWwuY29tPiB3cm90ZToKPiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+
RnJvbTogZHJpLWRldmVsIDxkcmktZGV2ZWwtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+
IE9uIEJlaGFsZiBPZgo+ID5QaW90ciBTdGFua2lld2ljego+ID5TZW50OiBUdWVzZGF5LCBKdW5l
IDIsIDIwMjAgNToyMSBBTQo+ID5UbzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPjsgQ2hyaXN0aWFuIEvDtm5pZwo+ID48Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPjsg
RGF2aWQgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT47IERhdmlkCj4gPkFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT47IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiA+Q2M6IFN0YW5r
aWV3aWN6LCBQaW90ciA8cGlvdHIuc3RhbmtpZXdpY3pAaW50ZWwuY29tPjsgZHJpLQo+ID5kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBs
aW51eC0KPiA+a2VybmVsQHZnZXIua2VybmVsLm9yZwo+ID5TdWJqZWN0OiBbUEFUQ0ggMDcvMTVd
IGRybS9hbWRncHU6IHVzZSBQQ0lfSVJRX01TSV9UWVBFUyB3aGVyZQo+ID5hcHByb3ByaWF0ZQoK
Li4uCgo+ID4gICAgICAgICAgICAgICBpbnQgbnZlYyA9IHBjaV9tc2l4X3ZlY19jb3VudChhZGV2
LT5wZGV2KTsKPiA+ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGZsYWdzOwo+ID4KPiA+LSAg
ICAgICAgICAgICAgaWYgKG52ZWMgPD0gMCkgewo+ID4rICAgICAgICAgICAgICBpZiAobnZlYyA+
IDApCj4gPisgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MgPSBQQ0lfSVJRX01TSV9UWVBFUzsK
PiA+KyAgICAgICAgICAgICAgZWxzZQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGZsYWdzID0g
UENJX0lSUV9NU0k7Cj4gPi0gICAgICAgICAgICAgIH0gZWxzZSB7Cj4gPi0gICAgICAgICAgICAg
ICAgICAgICAgZmxhZ3MgPSBQQ0lfSVJRX01TSSB8IFBDSV9JUlFfTVNJWDsKPiA+LSAgICAgICAg
ICAgICAgfQo+Cj4gTWlub3Igbml0Ogo+Cj4gSXMgaXQgcmVhbGx5IG5lY2Vzc2FyeSB0byBzZXQg
ZG8gdGhpcyBjaGVjaz8gIENhbiBmbGFncyBqdXN0Cj4gYmUgc2V0Pwo+Cj4gSS5lLjoKPiAgICAg
ICAgIGZsYWdzID0gUENJX0lSUV9NU0lfVFlQRVM7Cj4KPiBwY2lfYWxsb2NfaXJxX3ZlY3Rvcigp
IHRyaWVzIHN0dWZmIGluIG9yZGVyLiAgSWYgTVNJWCBpcyBub3QgYXZhaWxhYmxlLAo+IGl0IHdp
bGwgdHJ5IE1TSS4KClRoYXQncyBhbHNvIHdoYXQgSSBwcm9wb3NlZCBlYXJsaWVyLiBCdXQgSSBz
dWdnZXN0ZWQgYXMgd2VsbCB0byB3YWl0CmZvciBBTUQgcGVvcGxlIHRvIGNvbmZpcm0gdGhhdCBu
ZWl0aGVyIHBjaV9tc2l4X3ZlY19jb3VudCgpIG5vciBmbGFncwppcyBuZWVkZWQgYW5kIHdlIGNh
biBkaXJlY3RseSBzdXBwbHkgTVNJX1RZUEVTIHRvIHRoZSBiZWxvdyBjYWxsLgoKPiA+ICAgICAg
ICAgICAgICAgLyogd2Ugb25seSBuZWVkIG9uZSB2ZWN0b3IgKi8KPiA+ICAgICAgICAgICAgICAg
bnZlYyA9IHBjaV9hbGxvY19pcnFfdmVjdG9ycyhhZGV2LT5wZGV2LCAxLCAxLCBmbGFncyk7Cgot
LSAKV2l0aCBCZXN0IFJlZ2FyZHMsCkFuZHkgU2hldmNoZW5rbwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
