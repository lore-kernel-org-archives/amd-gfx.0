Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BEC48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 20:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F097161264
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 20:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F097161264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749B16EA9E;
	Fri, 18 Jun 2021 20:52:03 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BDE6EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 20:52:02 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id r16so11961880oiw.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+ZYWv0NwqZ+nqZpw/Sip7GNqOyHmnv8s0i8Bhny8Adc=;
 b=Y5xoJnIoxJ+8UUCsSp2K4kbK01GoDV/gWsR5E/MqEdO5EPqqbrdN3deTBS+Yn6pjbt
 VUAUrEOWo6uAUGBNTYItHNxFXOvRxVmCO0CP4Oc0IOC4S5EqzYLbF2lUtmhVtVLVZ7KR
 K39FqnSSHEV0pxfPKMpFQtIZ2cXk+b/1SmiQzyAoxqs5f9XT+OtAhnghbloWYUrxuA+K
 PRkX3SzoyHgBJ+aHe/ZeCBmb8xqKifGt8k6KkiYbMj6DgBg+IHo4l25yDUjL3pw/nm4Z
 86F5JJaF3ZTQkQ8xpOkxBPZpwBq8NKpa+aX4MQ58cWWNfMufjYlHf4uPya7MUw7Nh5zs
 blgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+ZYWv0NwqZ+nqZpw/Sip7GNqOyHmnv8s0i8Bhny8Adc=;
 b=SmFR7tIFTeJNoW20U4OGQyrH0JDN66IvyT6ff+Cn+1n5Q6ZQg3Jp2vlbPhTuY8KuwF
 th9wwg/mPonsZ+9yhFKVw+Pr7PEt4grsUTIqYXjHBmf9d3LDB5TrMghOsi5lHUK3moNm
 JqMpgWCGw/jL6UMIsg3azXoVCnmNXRaeGWH4re1XJEyCFMqkwjh/hXIWK+P2fmBr1vPy
 VhhRlxeHMQFsjVmeHZbY9XGthGzgAxRmoipjiuSfL9EFRhvTkyypBWVzRqgx1ciOwDaa
 iNIm2OFEgFsPrNvQw1fror3UOnF8Aa8b33u7FcbMg/gsAhlipCY6il1RbwITi7KIe31D
 yx0A==
X-Gm-Message-State: AOAM533wqV6+A9e82WDtBRkJ5SSLVaKxrI6gW0L2/tL8KYfjrwQx7yV1
 xVH5KDzfeaaHjgr0NVrEjIijJFzkJKT43BgytD/eElAF
X-Google-Smtp-Source: ABdhPJy0DsEA0UtJwHu7ZWczVOH5kcLiAVB2wZfaMVGtvJsbU6aCy760VxpURC+d/vZgVxDClQaADNHKnxpKDxnFalY=
X-Received: by 2002:a05:6808:999:: with SMTP id
 a25mr8530652oic.123.1624049522105; 
 Fri, 18 Jun 2021 13:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210616104651.3004-1-michel@daenzer.net>
 <eb0ff799-0d2c-ce9e-20c5-da80bc11f77e@daenzer.net>
In-Reply-To: <eb0ff799-0d2c-ce9e-20c5-da80bc11f77e@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jun 2021 16:51:51 -0400
Message-ID: <CADnq5_N+5+r_8mu2bTo2bXgVwvzJ47LRFXZdromqTBht4GoBBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Call drm_framebuffer_init last for
 framebuffer init
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgSnVuIDE3LCAyMDIxIGF0IDY6MzMgQU0g
TWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDIxLTA2
LTE2IDEyOjQ2IHAubS4sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+ID4gRnJvbTogTWljaGVsIETD
pG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+Cj4gPgo+ID4gT25jZSBkcm1fZnJhbWVidWZmZXJf
aW5pdCBoYXMgcmV0dXJuZWQgMCwgdGhlIGZyYW1lYnVmZmVyIGlzIGhvb2tlZCB1cAo+ID4gdG8g
dGhlIHJlZmVyZW5jZSBjb3VudGluZyBtYWNoaW5lcnkgYW5kIGNhbiBubyBsb25nZXIgYmUgZGVz
dHJveWVkIHdpdGgKPiA+IGEgc2ltcGxlIGtmcmVlLiBUaGVyZWZvcmUsIGl0IG11c3QgYmUgY2Fs
bGVkIGxhc3QuCj4gPgo+ID4gRml4ZXM6IGYyNTg5MDdmZGQ4MzVlICJkcm0vYW1kZ3B1OiBWZXJp
ZnkgYm8gc2l6ZSBjYW4gZml0IGZyYW1lYnVmZmVyIHNpemUgb24gaW5pdC4iCj4KPiBJbiBjYXNl
IHRoZSBjb21taXQgbG9nIHdhc24ndCBjbGVhcjogSWYgZHJtX2ZyYW1lYnVmZmVyX2luaXQgcmV0
dXJucyAwIGJ1dCBpdHMgY2FsbGVyIHRoZW4gcmV0dXJucyBub24tMCwgdGhlcmUgd2lsbCBsaWtl
bHkgYmUgbWVtb3J5IGNvcnJ1cHRpb24gZmlyZXdvcmtzIGRvd24gdGhlIHJvYWQuIFRoZSBmb2xs
b3dpbmcgbGVhZCBtZSB0byB0aGlzIGZpeDoKPgo+IFsgICAxMi44OTEyMjhdIGtlcm5lbCBCVUcg
YXQgbGliL2xpc3RfZGVidWcuYzoyNSEKPiBbLi4uXQo+IFsgICAxMi44OTEyNjNdIFJJUDogMDAx
MDpfX2xpc3RfYWRkX3ZhbGlkKzB4NGIvMHg3MAo+IFsuLi5dCj4gWyAgIDEyLjg5MTMyNF0gQ2Fs
bCBUcmFjZToKPiBbICAgMTIuODkxMzMwXSAgZHJtX2ZyYW1lYnVmZmVyX2luaXQrMHhiNS8weDEw
MCBbZHJtXQo+IFsgICAxMi44OTEzNzhdICBhbWRncHVfZGlzcGxheV9nZW1fZmJfdmVyaWZ5X2Fu
ZF9pbml0KzB4NDcvMHgxMjAgW2FtZGdwdV0KPiBbICAgMTIuODkxNTkyXSAgPyBhbWRncHVfZGlz
cGxheV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZSsweDEwZC8weDFmMCBbYW1kZ3B1XQo+IFsgICAx
Mi44OTE3OTRdICBhbWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZSsweDEyNi8w
eDFmMCBbYW1kZ3B1XQo+IFsgICAxMi44OTE5OTVdICBkcm1faW50ZXJuYWxfZnJhbWVidWZmZXJf
Y3JlYXRlKzB4Mzc4LzB4M2YwIFtkcm1dCj4gWyAgIDEyLjg5MjAzNl0gID8gZHJtX2ludGVybmFs
X2ZyYW1lYnVmZmVyX2NyZWF0ZSsweDNmMC8weDNmMCBbZHJtXQo+IFsgICAxMi44OTIwNzVdICBk
cm1fbW9kZV9hZGRmYjIrMHgzNC8weGQwIFtkcm1dCj4gWyAgIDEyLjg5MjExNV0gID8gZHJtX2lu
dGVybmFsX2ZyYW1lYnVmZmVyX2NyZWF0ZSsweDNmMC8weDNmMCBbZHJtXQo+IFsgICAxMi44OTIx
NTNdICBkcm1faW9jdGxfa2VybmVsKzB4ZTIvMHgxNTAgW2RybV0KPiBbICAgMTIuODkyMTkzXSAg
ZHJtX2lvY3RsKzB4M2RhLzB4NDYwIFtkcm1dCj4gWyAgIDEyLjg5MjIzMl0gID8gZHJtX2ludGVy
bmFsX2ZyYW1lYnVmZmVyX2NyZWF0ZSsweDNmMC8weDNmMCBbZHJtXQo+IFsgICAxMi44OTIyNzRd
ICBhbWRncHVfZHJtX2lvY3RsKzB4NDMvMHg4MCBbYW1kZ3B1XQo+IFsgICAxMi44OTI0NzVdICBf
X3NlX3N5c19pb2N0bCsweDcyLzB4YzAKPiBbICAgMTIuODkyNDgzXSAgZG9fc3lzY2FsbF82NCsw
eDMzLzB4NDAKPiBbICAgMTIuODkyNDkxXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NDQvMHhhZQo+Cj4KPgo+IC0tCj4gRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQo+IExpYnJlIHNvZnR3YXJl
IGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Bl
cgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
