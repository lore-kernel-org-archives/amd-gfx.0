Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80180C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 14:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE9661059
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 14:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE9661059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40496EA04;
	Tue,  8 Jun 2021 14:54:18 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAE36E190;
 Tue,  8 Jun 2021 14:54:17 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id z3so21770964oib.5;
 Tue, 08 Jun 2021 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YOoJEAvOVqbK4v61piMRQZKD7D+2Wxv5vNkMO12sWiQ=;
 b=lp04WpJQ5cFn5howqG+MuDdJmNjwz8GlRj1bvoRTW/1I82dmb2yowy8E3iTj5P2fK1
 mJCMvw2jkZq7wEuGTj2c9Gfryglr6XrC3y6ONNynB7tR+ixr4p8DGlTPJXNTcvINFB/b
 RsvE8qxy/Hgu5wsPSlEDQbHSgI5Emy8/3GoZf0dMzrGi/d9nrOu5jqpa4xzzxyQVUlsp
 l+dnGZF2k0aWDYhh3TZ3w7Lc8/TbQrHzIommbszYqPYXkgYtdjnMGBBO713Jijdy5C7R
 2qOV0ci+YShmXDfSL9uhhkf3g7eEll6wpaP7r4OsGr9Bq5c+PUHJV9YIZSVQHDgA5MLm
 HrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YOoJEAvOVqbK4v61piMRQZKD7D+2Wxv5vNkMO12sWiQ=;
 b=FQBcuuhZTYpigtvffyrYUUnEru2nVahGTkbHcJ5pr7FTZgPBa60PMUTaszkHCZSI2e
 lfVpatmaafd68DnBp8AuXbUj88QVRUHU2aRjafl9zTS/Oh+cw7mZ/j8m2OqwRCZX6DXn
 neDdfpiClt40lZDykNp3pkm3EpuO1w7p7UnkIN1MXvKsILKUhIC586yt06JYhOuozgPS
 yRizqZGBG3IiX4edyJqfn00PoIwVx44k+1mzsFOhmeKQXvTSxeCcHvgT5mvh9fEvvYgd
 FJ/iQWi2uz31x8uGZidVTYdG6JQP9KICBDqwHamNugL1OJR7TAs4eI4MODVbAoFMO/e5
 XcXQ==
X-Gm-Message-State: AOAM530SGnhZEr0EHBg/Q0mYrfz867AI3sDcQ6lkZ+0pdeGJmSiBTcC0
 7MlJJMgP3wVdS0tT95IkJPxh1GOG8sx59lhZZH1wEetT
X-Google-Smtp-Source: ABdhPJzvWbYI44VZl2fltwTHhC1u82++xVlMbWzDht7tkDoco05BKY+OWKvuT9uVpyvyGieu9ZnU0SGmONh+j5r/uic=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr3105250oie.120.1623164056486; 
 Tue, 08 Jun 2021 07:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <1623068820-2479-1-git-send-email-yangtiezhu@loongson.cn>
 <0d1b517f-797f-e87d-4edd-8474b16993ed@amd.com>
 <CADnq5_PvZRu0h60dn-=4v0aXBOaNy=s0KjmeuSndDzU3C8qFog@mail.gmail.com>
 <31de1f2e-5030-3a01-782b-df659d0d2869@loongson.cn>
In-Reply-To: <31de1f2e-5030-3a01-782b-df659d0d2869@loongson.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Jun 2021 10:54:05 -0400
Message-ID: <CADnq5_PMrv7imajh2SNJQL3nOBj8OKwV5Ud=1LQnKn0kN4SoNw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Always call radeon_suspend_kms() in
 radeon_pci_shutdown()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Jianmin Lv <lvjianmin@loongson.cn>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Xuefeng Li <lixuefeng@loongson.cn>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKdW4gNywgMjAyMSBhdCAxMDoyNiBQTSBUaWV6aHUgWWFuZyA8eWFuZ3RpZXpodUBs
b29uZ3Nvbi5jbj4gd3JvdGU6Cj4KPiBPbiAwNi8wNy8yMDIxIDA5OjQyIFBNLCBBbGV4IERldWNo
ZXIgd3JvdGU6Cj4gPiBPbiBNb24sIEp1biA3LCAyMDIxIGF0IDg6MzAgQU0gQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPiA+PiBBbSAwNy4wNi4yMSB1
bSAxNDoyNyBzY2hyaWViIFRpZXpodSBZYW5nOgo+ID4+PiByYWRlb25fc3VzcGVuZF9rbXMoKSBw
dXRzIHRoZSBodyBpbiB0aGUgc3VzcGVuZCBzdGF0ZSAoYWxsIGFzaWNzKSwKPiA+Pj4gaXQgc2hv
dWxkIGFsd2F5cyBjYWxsIHJhZGVvbl9zdXNwZW5kX2ttcygpIGluIHJhZGVvbl9wY2lfc2h1dGRv
d24oKSwKPiA+Pj4gdGhpcyBpcyBhIG5vcm1hbCBjbGVhbnVwIHByb2Nlc3MgdG8gYXZvaWQgbW9y
ZSBvcGVyYXRpb25zIG9uIHJhZGVvbiwKPiA+Pj4ganVzdCByZW1vdmUgI2lmZGVmIENPTkZJR19Q
UEM2NCBhbmQgdGhlIHJlbGF0ZWQgY29tbWVudHMuCj4gPj4gV2VsbCBOQUsuCj4gPj4KPiA+PiBB
bGV4IGtub3dzIG1vcmUgYWJvdXQgdGhlIGRldGFpbHMgYnV0IHN1c3BlbmRpbmcgc2hvdWxkIG5v
dCBiZSBwYXJ0IG9mCj4gPj4gdGhlIHBjaSBzaG90ZG93biBwcm9jZXNzIGF0IGFsbC4KPiA+Pgo+
ID4+IFdlIGp1c3QgYWRkIHRoYXQgaGVyZSB0byBlbmZvcmNlIGEgR1BVIHJlc2V0IG9uIFBQQzY0
IGJvYXJkcyBmb3Igc29tZQo+ID4+IHJlYXNvbi4KPiA+IEV2ZXJ5dGhpbmcgaW4gdGhlIGNvbW1l
bnQgc3RpbGwgYXBwbGllcy4KPiA+Cj4gPiBBbGV4Cj4KPiBIaSBBbGV4IGFuZCBDaHJpc3RpYW4s
Cj4KPiBUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVwbHkuIFdoYXQgZG8geW91IHRoaW5rIG9mIHRo
ZSBmb2xsb3dpbmcgY2hhbmdlcz8KPiBJZiBpdCBpcyBPSywgSSB3aWxsIHNlbmQgdjIuIElmIG5v
LCBwbGVhc2UgaWdub3JlIGl0Lgo+Cj4gQW55IGNvbW1lbnRzIHdpbGwgYmUgbXVjaCBhcHByZWNp
YXRlZC4KCkxvb2tzIGZpbmUuICBQbGVhc2Ugc2VuZCBpdCBvdXQuCgpBbGV4Cgo+Cj4gVGhhbmtz
LAo+IFRpZXpodQo+Cj4KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9yYWRlb246IENhbGwgcmFkZW9u
X3N1c3BlbmRfa21zKCkgaW4KPiAgIHJhZGVvbl9wY2lfc2h1dGRvd24oKSBmb3IgTG9vbmdzb242
NAo+Cj4gT24gdGhlIExvb25nc29uNjQgcGxhdGZvcm0gdXNlZCB3aXRoIFJhZGVvbiBHUFUsIHNo
dXRkb3duIG9yIHJlYm9vdCBmYWlsZWQKPiB3aGVuIGNvbnNvbGU9dHR5IGlzIGluIHRoZSBib290
IGNtZGxpbmUuCj4KPiByYWRlb25fc3VzcGVuZF9rbXMoKSBwdXRzIHRoZSBodyBpbiB0aGUgc3Vz
cGVuZCBzdGF0ZSwgZXNwZWNpYWxseSBzZXQgZmIKPiBzdGF0ZSBhcyBGQklORk9fU1RBVEVfU1VT
UEVOREVEOgo+Cj4gICAgICBpZiAoZmJjb24pIHsKPiAgICAgICAgICBjb25zb2xlX2xvY2soKTsK
PiAgICAgICAgICByYWRlb25fZmJkZXZfc2V0X3N1c3BlbmQocmRldiwgMSk7Cj4gICAgICAgICAg
Y29uc29sZV91bmxvY2soKTsKPiAgICAgIH0KPgo+IFRoZW4gYXZvaWQgdG8gZG8gYW55IG1vcmUg
ZmIgb3BlcmF0aW9ucyBpbiB0aGUgcmVsYXRlZCBmdW5jdGlvbnM6Cj4KPiAgICAgIGlmIChwLT5z
dGF0ZSAhPSBGQklORk9fU1RBVEVfUlVOTklORykKPiAgICAgICAgICByZXR1cm47Cj4KPiBTbyBj
YWxsIHJhZGVvbl9zdXNwZW5kX2ttcygpIGluIHJhZGVvbl9wY2lfc2h1dGRvd24oKSBmb3IgTG9v
bmdzb242NCB0byBmaXgKPiB0aGlzIGlzc3VlLCBpdCBsb29rcyBsaWtlIHNvbWUga2luZCBvZiB3
b3JrYXJvdW5kIGxpa2UgcG93ZXJwYy4KPgo+IENvLWRldmVsb3BlZC1ieTogSmlhbm1pbiBMdiA8
bHZqaWFubWluQGxvb25nc29uLmNuPgo+IFNpZ25lZC1vZmYtYnk6IEppYW5taW4gTHYgPGx2amlh
bm1pbkBsb29uZ3Nvbi5jbj4KPiBTaWduZWQtb2ZmLWJ5OiBUaWV6aHUgWWFuZyA8eWFuZ3RpZXpo
dUBsb29uZ3Nvbi5jbj4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Ry
di5jIHwgOCArKysrLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9kcnYuYwo+IGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKPiBpbmRleCBl
ZmViMTE1Li5kYWFiYmY1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2Rydi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKPiBA
QCAtMzg2LDEzICszODYsMTMgQEAgcmFkZW9uX3BjaV9zaHV0ZG93bihzdHJ1Y3QgcGNpX2RldiAq
cGRldikKPiAgICAgICBpZiAocmFkZW9uX2RldmljZV9pc192aXJ0dWFsKCkpCj4gICAgICAgICAg
IHJhZGVvbl9wY2lfcmVtb3ZlKHBkZXYpOwo+Cj4gLSNpZmRlZiBDT05GSUdfUFBDNjQKPiArI2lm
IGRlZmluZWQoQ09ORklHX1BQQzY0KSB8fCBkZWZpbmVkKENPTkZJR19NQUNIX0xPT05HU09ONjQp
Cj4gICAgICAgLyoKPiAgICAgICAgKiBTb21lIGFkYXB0ZXJzIG5lZWQgdG8gYmUgc3VzcGVuZGVk
IGJlZm9yZSBhCj4gICAgICAgICogc2h1dGRvd24gb2NjdXJzIGluIG9yZGVyIHRvIHByZXZlbnQg
YW4gZXJyb3IKPiAtICAgICAqIGR1cmluZyBrZXhlYy4KPiAtICAgICAqIE1ha2UgdGhpcyBwb3dl
ciBzcGVjaWZpYyBiZWNhdWFzZSBpdCBicmVha3MKPiAtICAgICAqIHNvbWUgbm9uLXBvd2VyIGJv
YXJkcy4KPiArICAgICAqIGR1cmluZyBrZXhlYywgc2h1dGRvd24gb3IgcmVib290Lgo+ICsgICAg
ICogTWFrZSB0aGlzIHBvd2VyIGFuZCBMb29uZ3NvbiBzcGVjaWZpYyBiZWNhdWFzZQo+ICsgICAg
ICogaXQgYnJlYWtzIHNvbWUgb3RoZXIgYm9hcmRzLgo+ICAgICAgICAqLwo+ICAgICAgIHJhZGVv
bl9zdXNwZW5kX2ttcyhwY2lfZ2V0X2RydmRhdGEocGRldiksIHRydWUsIHRydWUsIGZhbHNlKTsK
PiAgICNlbmRpZgo+IC0tCj4gMi4xLjAKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
