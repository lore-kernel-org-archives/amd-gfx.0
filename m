Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16446C38A2A
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 01:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26DD20746
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 01:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgaX345W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26DD20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24AD6E0BA;
	Mon, 11 May 2020 01:45:16 +0000 (UTC)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4316E0BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 01:45:16 +0000 (UTC)
Received: by mail-lj1-x244.google.com with SMTP id f18so7667790lja.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 May 2020 18:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wOEMeX4+UUPZBfX1OWiWrmz539JpAWHmW8fC2byDR3o=;
 b=IgaX345W/AshNDVqxRtNSYEvJ+Ttoop5nE4wtmexRkBLi41h7VlUpHaCh1JRiBq9YC
 fCCY4lr5QiMmcIw6p9BXZsst5nUXetZ0mP0yKpfsfsr/+SZOjDT/0dv9wORUTKkF9auU
 tc2khr4/X+xE5j1KAk8ydtOK7CWZyrzEtSBxgmfC8X9Kih6Ba2aW0kNqBdu5x1Pjl9W/
 Tn3oGnMcJiyyrIYWMNYYtpCXSJDTEuX0p6ao6XYrhhrihPv7H/LTt01zlSjTTWGZfTNk
 O+IbeGKm/gI9YnO4mEshC2QqgPRP7TKPRwWuvgy2VsKh+SveVeOqpjg51bbhW/F+1QjK
 kj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wOEMeX4+UUPZBfX1OWiWrmz539JpAWHmW8fC2byDR3o=;
 b=foEKTgHRbUgb2FDM8Pf5t9vb6IL5ZLqWf9KAr3eIwWQWoRNyOFjW4eaYZ7NE5o+jtF
 v94nwY6F96RW/KVAvr1EsQSGoocMZ3st9gaoGeA3lnspnTrbQBwUbtiqbGf+wj0SJ0Lz
 drTYSy6q/RkUl/Wl/CP+dIkViy0+X0RM/QaPI0Z0MqJAa0RZWXk7w3e9+n8oODIHGW4C
 6e5g9oy0mQQnEK9sUQ9+mF1OcwGlm6Tt1K071fEwCm6rL7zK67YZHio76wHHOAam/7AV
 CifYLkzrhWU1jCMmjgtFgh6OU+Ln5IFWakY8xJKL5YBhmdfTwJfcOM8OcGSvdM42bk+P
 Sqpw==
X-Gm-Message-State: AOAM5338sJW7kfwk1C0RCZY+alM9Z8w6+z1KCDe5hSk8NsMMoXzXNJ7u
 Xu++bKW1jfLrhrLRUMzduKfDeqZQDPfU+fly7RA=
X-Google-Smtp-Source: ABdhPJwWhtJvKKA7YXvDYAMPogQtQpGtnvST2ci1YAYyQNc8KDC4+3eoVGGvryWrSPlg/zF+01IuKRwE97BrM/Bm/CU=
X-Received: by 2002:a05:651c:230:: with SMTP id
 z16mr8445211ljn.185.1589161514564; 
 Sun, 10 May 2020 18:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200509054834.21484-1-zhoubb.aaron@gmail.com>
 <CADnq5_Ms1oyxqODE4j_-4+WKwUbE6VthECRgA8cvsYBzMwzs5g@mail.gmail.com>
In-Reply-To: <CADnq5_Ms1oyxqODE4j_-4+WKwUbE6VthECRgA8cvsYBzMwzs5g@mail.gmail.com>
From: Aaron Chou <zhoubb.aaron@gmail.com>
Date: Mon, 11 May 2020 09:45:01 +0800
Message-ID: <CAMpQs4LXBf3wfwhUY45GzqC-+yqyA3F+25K5bxXi=vE-rEx_gQ@mail.gmail.com>
Subject: Re: [PATCH] drm/admgpu: check HDMI HPD status after ddc probe
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 zhoubinbin <zhoubinbin@uniontech.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, hristian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCBNYXkgOSwgMjAyMCBhdCA5OjM1IFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPiB3cm90ZToKPgo+IE9uIFNhdCwgTWF5IDksIDIwMjAgYXQgMTo0OCBBTSBCaW5i
aW4gWmhvdSA8emhvdWJiLmFhcm9uQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gTm93LCB3ZSBj
aGVjayB0aGUgcHJlc2VuY2Ugb2YgdGhlIEVESUQgdG8gZGV0ZXJtaW5lIGlmIHRoZXJlIGlzIGEg
bW9uaXRvcgo+ID4gcHJlc2VudC4KPiA+Cj4gPiBEVkktSSBjb25uZWN0b3JzIGhhdmUgYm90aCBh
bmFsb2cgYW5kIGRpZ2l0YWwgZW5jb2RlcnMgYW5kIHRoZSBIUEQgcGluCj4gPiBpcyBvbmx5IHJl
bGlhYmxlIG9uIHRoZSBkaWdpdGFsIHBhcnQuCj4gPgo+ID4gQnV0IHdoZW4gSSBwdWxsIG91dCB0
aGUgUmFkZW9uIEhEODU3MCdzIEhETUkgY29ubmVjdG9yLCB0aGUgSERNSSBzdGF0dXMKPiA+IGlu
IHN5c3RlbSBpcyBzdGlsbCBwZXJmb3JtIGNvbm5lY3RlZC4KPiA+Cj4gPiBhc2RAYXNkLVBDOn4k
IGNhdCAvc3lzL2NsYXNzL2RybS9jYXJkMC1IRE1JLUEtMS9zdGF0dXMKPiA+IGNvbm5lY3RlZAo+
ID4KPiA+IEF0IHRoaXMgbW9tZW50LCBpZiBJIHdhbnQgdG8gcmVhZCB0aGUgRURJRCBieSAvZGV2
L2kyYy1YIHdpdGggSTJDCj4gPiBkcml2ZXIsIHRoZXJlIGlzIG5vIEVESUQgY2FuIGJlIHJlYWQu
Cj4gPgo+ID4gRG1lc2cgd2l0aGEgZHJtLmRlYnVnPTB4Niwgd2UgY2FuIGZpbmQgdGhlIGZvbGxv
d2luZyBtZXNzYWdlOgo+ID4KPiA+IFtkcm06ZHJtX2hlbHBlcl9ocGRfaXJxX2V2ZW50XSBbQ09O
TkVDVE9SOjQxOkhETUktQS0xXSBzdGF0dXMKPiA+IHVwZGF0ZWQgZnJvbSBjb25uZWN0ZWQgdG8g
Y29ubmVjdGVkCj4gPgo+ID4gQmFzZWQgb24gdGhlIGFwcGVhcmFuY2UsIEkgdGhvdWdodCB0byBj
aGVjayB0aGUgSFBEIHN0YXR1cyBhZ2FpbiwgYmVjYXVzZQo+ID4gdGhlIEhQRCBzdGF0dXMgaXMg
cGVyZm9ybSBkaXNjb25uZWN0ZWQsIGFmdGVyIGFtZGdwdV9kaXNwbGF5X2RkY19wcm9iZSgpLgo+
ID4gSWYgdGhlIGFtZGdwdV9kaXNwbGF5X2hwZF9zZW5zZSgpIHJldHVybiBmYWxzZSwgSSB0aGlu
ayB0aGUgSERNSSBjb25uZWN0b3IKPiA+IHN0YXR1cyBpcyB1bmRlZmluZWQsIGFuZCBqdXN0IHJl
dHVybiBkaXNjb25uZWN0ZWQgc2ltcGx5Lgo+ID4KPiA+IEknbSBub3Qgc3VyZSBpZiBpdCBoYXBw
ZW5lZCB0byBvdGhlciBBTUQgY2FyZHMuCj4KPiBUaGlzIGlzIHRoZSBwYXJ0IEkgZG9uJ3QgdW5k
ZXJzdGFuZC4gIFRoZSBsb2dpYyBhbHJlYWR5IGNoZWNrcyB0aGUgSFBECj4gc3RhdHVzIGluIGFt
ZGdwdV9jb25uZWN0b3JfY2hlY2tfaHBkX3N0YXR1c191bmNoYW5nZWQoKS4gIERvZXMgaXQKPiBz
dGlsbCByZXBvcnQgY29ubmVjdGVkIGF0IHRoYXQgcG9pbnQ/ICBBZnRlciB0aGF0IGl0IHRpcmVz
IHRvIHJlYWQgdGhlCj4gRURJRCBpbiBhbWRncHVfZGlzcGxheV9kZGNfcHJvYmUoKS4gIElmIHRo
ZSBtb25pdG9yIGlzIGRpc2Nvbm5lY3RlZCwKPiB0aGVyZSBzaG91bGQgYmUgbm8gRURJRCBzbyBk
cmV0IHNob3VsZCBiZSBmYWxzZS4gIFdlIHNob3VsZCB0cnkgYW5kCj4gZmlndXJlIG91dCB3aHkg
dGhlIGZpcnN0IEhQRCBjaGVjayByZXBvcnRzIGNvbm5lY3RlZCBhbmQgdGhlIEVESUQKPiBwcm9i
ZSByZXR1cm5zIHRydWUuCj4KPiBBbGV4CgpFbW0uLi4uLgpJIGhhdmUgdHJpZWQgd2l0aCBSYWRl
b24gZHJpdmVyLCBpdCBpcyB0aGUgc2FtZS4KQW5kIEluIHRoZSBNaW50IHN5c3RlbSwgSSBmaW5k
IGlmIEkgcGljayBvdXQgdGhlIEhETUkgY29ubmVjdG9yLCBJIGNhbgpzZWUgdGhlIHN0YXR1cyBp
cyBzdGlsbCBjb25uZWN0ZWQsCkF0IHRoZSBtb21lbnQsIElmIEkgZG8gdGhlIHhyYW5kciBjb21t
YW5kIG9yIG9wZW4gdGhlIFNldHRpbmctPkRpc3BsYXkKYXBwbGljYXRpb24sIHRoZSBIRE1JIHN0
YXR1cyB3aWxsIHJlZnJlc2ggdG8gZGlzY29ubmVjdGVkLgpUaGUgb3BlcmF0aW9uIG1lYW5zIHRv
IGRldGVjdCB0aGUgZGlzcGxheSBhZ2Fpbi4KCkRvZXMgdGhlIHBoZW5vbWVub24gbWVldCB0aGUg
ZXhwZWN0YXRpb27vvJ8KClJlZ2FyZHMuCkFhcm9uLgo+Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTog
QmluYmluIFpob3UgPHpob3ViYi5hYXJvbkBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9ycy5jIHwgOSArKysrKysrLS0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9y
cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYwo+ID4g
aW5kZXggZjM1NWQ5YTc1MmQyLi5lZTY1N2RiOWEyMjggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9ycy5jCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9ycy5jCj4gPiBAQCAtOTczLDcgKzk3
Myw3IEBAIGFtZGdwdV9jb25uZWN0b3JfZHZpX2RldGVjdChzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAq
Y29ubmVjdG9yLCBib29sIGZvcmNlKQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgZHJtX2VuY29k
ZXJfaGVscGVyX2Z1bmNzICplbmNvZGVyX2Z1bmNzOwo+ID4gICAgICAgICBpbnQgcjsKPiA+ICAg
ICAgICAgZW51bSBkcm1fY29ubmVjdG9yX3N0YXR1cyByZXQgPSBjb25uZWN0b3Jfc3RhdHVzX2Rp
c2Nvbm5lY3RlZDsKPiA+IC0gICAgICAgYm9vbCBkcmV0ID0gZmFsc2UsIGJyb2tlbl9lZGlkID0g
ZmFsc2U7Cj4gPiArICAgICAgIGJvb2wgZHJldCA9IGZhbHNlLCBicm9rZW5fZWRpZCA9IGZhbHNl
LCB1bmRlZmluZWRfZmxhZyA9IGZhbHNlOwo+ID4KPiA+ICAgICAgICAgaWYgKCFkcm1fa21zX2hl
bHBlcl9pc19wb2xsX3dvcmtlcigpKSB7Cj4gPiAgICAgICAgICAgICAgICAgciA9IHBtX3J1bnRp
bWVfZ2V0X3N5bmMoY29ubmVjdG9yLT5kZXYtPmRldik7Cj4gPiBAQCAtOTg4LDcgKzk4OCwxMiBA
QCBhbWRncHVfY29ubmVjdG9yX2R2aV9kZXRlY3Qoc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5l
Y3RvciwgYm9vbCBmb3JjZSkKPiA+Cj4gPiAgICAgICAgIGlmIChhbWRncHVfY29ubmVjdG9yLT5k
ZGNfYnVzKQo+ID4gICAgICAgICAgICAgICAgIGRyZXQgPSBhbWRncHVfZGlzcGxheV9kZGNfcHJv
YmUoYW1kZ3B1X2Nvbm5lY3RvciwgZmFsc2UpOwo+ID4gLSAgICAgICBpZiAoZHJldCkgewo+ID4g
Kwo+ID4gKyAgICAgICAvKiBDaGVjayB0aGUgSERNSSBIUEQgcGluIHN0YXR1cyBhZ2FpbiAqLwo+
ID4gKyAgICAgICBpZiAoIWFtZGdwdV9kaXNwbGF5X2hwZF9zZW5zZShhZGV2LCBhbWRncHVfY29u
bmVjdG9yLT5ocGQuaHBkKSkKPiA+ICsgICAgICAgICAgICAgICB1bmRlZmluZWRfZmxhZyA9IHRy
dWU7Cj4gPiArCj4gPiArICAgICAgIGlmIChkcmV0ICYmICF1bmRlZmluZWRfZmxhZykgewo+ID4g
ICAgICAgICAgICAgICAgIGFtZGdwdV9jb25uZWN0b3ItPmRldGVjdGVkX2J5X2xvYWQgPSBmYWxz
ZTsKPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfY29ubmVjdG9yX2ZyZWVfZWRpZChjb25uZWN0
b3IpOwo+ID4gICAgICAgICAgICAgICAgIGFtZGdwdV9jb25uZWN0b3JfZ2V0X2VkaWQoY29ubmVj
dG9yKTsKPiA+IC0tCj4gPiAyLjE3LjEKPiA+Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
