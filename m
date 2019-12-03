Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E8C432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 00:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCFE20663
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 00:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCFE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C906E0FF;
	Tue,  3 Dec 2019 00:23:20 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503D76E0FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 00:23:19 +0000 (UTC)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-VpNZDKonP3iWxlE0gBZqyw-1; Mon, 02 Dec 2019 19:23:15 -0500
Received: by mail-qt1-f200.google.com with SMTP id x21so1210486qtp.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2019 16:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=qK7dJt7emn2nPgIkNYQvvT1o0KOTyKHwgqttrH3YRw4=;
 b=IxRoZfFyIBNgDJQSEXDOYHaZ1hcDbFcCBlPswlGruqi6IbYMDIxXNkedYSmRtQrc2N
 8NkovGhp2MGV50TkkgyF7jtgYDPrYzy8igb0GXtC6yc4+M/+Dr8hxLQehnAw2FaU78c1
 QpkiqXKquFyZkNBTZGNuC096obEE5svsKe4FtyLV6+P+XJZrisZPQ8bEvRfsR/gTo/Ap
 Us1YaGCNKsSvaMN06tkpawn7XAJb8kjGgKFfthgk0Twd1iHOCoX+RTmBZpAamPyTj6lw
 cEtKvp+YocnPTyHntg7C4JRHlPiJGaYRtFGPEBFJzGFC9D1K38yair7uJ7JkUbRgXNe3
 OjRA==
X-Gm-Message-State: APjAAAVhX+aaYSo6LmZ8F9EC5ZbcKzw3/kw7zlktYraHw/puB6X5QeJS
 LCqRFM3MPEHrt24YNpESWqYS5gEat1Kndxc7EwNLTs42wunM0cMe0zPPOlA8eqAvC1FHapKJfpP
 fphGPzGgYaWYokkoUAshF5PFk3g==
X-Received: by 2002:ac8:4a02:: with SMTP id x2mr2518848qtq.388.1575332594755; 
 Mon, 02 Dec 2019 16:23:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXPm7oQEUV0hxiQwMwFcRCzo34nlUWBD3UGZbYmef5k3XsS0mJ3MDAPbC/Q6MgG3STwaW+Yw==
X-Received: by 2002:ac8:4a02:: with SMTP id x2mr2518829qtq.388.1575332594462; 
 Mon, 02 Dec 2019 16:23:14 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id c6sm741255qka.111.2019.12.02.16.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 16:23:13 -0800 (PST)
Message-ID: <0ee5e2e9f6a739ee95715764ee8a3673fec29d08.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Correct the bug in
 drm_dp_update_payload_part1()
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Mon, 02 Dec 2019 19:23:12 -0500
In-Reply-To: <20191202035841.16984-1-Wayne.Lin@amd.com>
References: <20191202035841.16984-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: VpNZDKonP3iWxlE0gBZqyw-1
X-Mimecast-Spam-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1575332598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qK7dJt7emn2nPgIkNYQvvT1o0KOTyKHwgqttrH3YRw4=;
 b=DIkXeDlIGqwHauxoxAFS7RT7pwWnKj9vMbij0Btrj2gwb7HVF6Eykj544dpJl/Q48AHFat
 8s5NpVXh4Tpqht1he1074dODbfg4BbD5brxQiHMgL73r5ZU/nzh9VmfpdFYp8UTW5u86BR
 3qW5ABvDo0+tDBvzHtM6Pt9/7VwMezA=
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
Cc: Jerry.Zuo@amd.com, harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAyMDE5LTEyLTAyIGF0IDExOjU4ICswODAwLCBXYXluZSBMaW4gd3JvdGU6Cj4gW1do
eV0KPiBJZiB0aGUgcGF5bG9hZF9zdGF0ZSBpcyBEUF9QQVlMT0FEX0RFTEVURV9MT0NBTCBpbiBz
ZXJpZXMsIGN1cnJlbnQKPiBjb2RlIGRvZXNuJ3QgZGVsZXRlIHRoZSBwYXlsb2FkIGF0IGN1cnJl
bnQgaW5kZXggYW5kIGp1c3QgbW92ZSB0aGUKPiBpbmRleCB0byBuZXh0IG9uZSBhZnRlciBzaHVm
ZmxpbmcgcGF5bG9hZHMuCj4gCj4gW0hvd10KPiBBZnRlciBzaHVmZmxpbmcgcGF5bG9hZHMsIGRl
Y2lkZSB3aGV0aGVyIHRvIG1vdmUgb24gaW5kZXggb3Igbm90Cj4gYWNjb3JkaW5nIHRvIHBheWxv
YWRfc3RhdGUgb2YgY3VycmVudCBwYXlsb2FkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFdheW5lIExp
biA8V2F5bmUuTGluQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0
X3RvcG9sb2d5LmMgfCAzICsrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0
X3RvcG9sb2d5LmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMKPiBp
bmRleCA4MWU5MmIyNjBkN2EuLjhkYTVkNDYxZWEwMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9k
cF9tc3RfdG9wb2xvZ3kuYwo+IEBAIC0zMTc2LDcgKzMxNzYsOCBAQCBpbnQgZHJtX2RwX3VwZGF0
ZV9wYXlsb2FkX3BhcnQxKHN0cnVjdAo+IGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyICptZ3IpCj4g
IAkJCWRybV9kcF9tc3RfdG9wb2xvZ3lfcHV0X3BvcnQocG9ydCk7Cj4gIAl9Cj4gIAo+IC0JZm9y
IChpID0gMDsgaSA8IG1nci0+bWF4X3BheWxvYWRzOyBpKyspIHsKPiArCWZvciAoaSA9IDA7IGkg
PCBtZ3ItPm1heF9wYXlsb2FkczsKPiArCQkobWdyLT5wYXlsb2Fkc1tpXS5wYXlsb2FkX3N0YXRl
ID09IERQX1BBWUxPQURfREVMRVRFX0xPQ0FMKSA/Cj4gaSA6IGkrKykgewoKVG9vayBtZSBhIG1v
bWVudCB0byBmaWd1cmUgb3V0IHdoYXQgdGhpcyBsaW5lIHdhcyBhY3R1YWxseSBkb2luZy4gTmlj
ZSBjYXRjaApieSB0aGUgd2F5IQoKQW55d2F5OiBsZXQncyBqdXN0IGRyb3AgdGhpcyBsaW5lIHRv
IGF2b2lkIG1ha2luZyB0aGluZ3MgY29uZnVzaW5nIHRvIHJlYWQsCmRyb3AgaSsrIGZyb20gdGhl
IGZvciBsb29wIGluc3RlYWQsIGFuZCBqdXN0IHJld3JpdGUgaXQgc28gaXQgbG9va3MgbGlrZSB0
aGlzOgoKZm9yIChpID0gMDsgaSA8IG1nci0+bWF4X3BheWxvYWRzOyAvKiBkbyBub3RoaW5nICov
KSB7CglpZiAobWdyLT5wYXlsb2Fkc1tpXS5wYXlsb2FkX3N0YXRlICE9IERQX1BBWUxPQURfREVM
RVRFX0xPQ0FMKSB7CgkJaSsrOwoJCWNvbnRpbnVlOwoJfQoKV2l0aCB0aG9zZSBjaGFuZ2VzLCB0
aGlzIHBhdGNoIGlzOgoKUmV2aWV3ZWQtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+
CgpJIGNhbiBnbyBhaGVhZCBhbmQgcHVzaCB0aGVzZSBwYXRjaGVzIHRvIGRybS1taXNjIGZvciB5
b3Ugb25jZSB5b3UndmUgc2VudCBtZQp0aGUgdjIKPiAgCQlpZiAobWdyLT5wYXlsb2Fkc1tpXS5w
YXlsb2FkX3N0YXRlICE9IERQX1BBWUxPQURfREVMRVRFX0xPQ0FMKQo+ICAJCQljb250aW51ZTsK
PiAgCi0tIApDaGVlcnMsCglMeXVkZSBQYXVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
