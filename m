Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FCFC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 16:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4194F206F0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 16:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4194F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664B76E33A;
	Wed, 27 Nov 2019 16:28:23 +0000 (UTC)
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com
 [IPv6:2607:f8b0:4864:20::e44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984736E339;
 Wed, 27 Nov 2019 16:28:21 +0000 (UTC)
Received: by mail-vs1-xe44.google.com with SMTP id p6so10371501vsj.11;
 Wed, 27 Nov 2019 08:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0FzcWYCmn0RWABpcgA0kJVxb/PlKVIkTcM9gwAyKkAw=;
 b=mAqiBZdX0R0Q/Up23wpMMVQDX0P7ZfOwcopQIxjJcdZHdl+9ecDrMaM0WlTquAUdYT
 ZPT8gY7mBuItCW/vXJTwVeuNxd6XsIhx4i5RUt/Dtpwv3IKaQ8i4BeCNCX9BJLwZpLQL
 Fdcz2GyKeCYka0gO92PMxOGRIt98uTE5t0o40jccyHwJ7f+lvfB5OWY5zB3pTh5nBNCm
 pibRyWhVUs/hCuXEH5Nk0UHCov/Oj8ijO5uXZTXjVqnawg/enjeIJsJ2rFUGmCojTSNp
 o8qnF9dNcnIR9HRjBaTJx/QczqUbsUVhR2mN55H9uyngYZZ197jqzgxMuVx7ttGHv8ij
 fRAA==
X-Gm-Message-State: APjAAAX76TZb/qPpPPyv8cM6YRyXpULOvzLNwhKfOsWCNa/bVnn3A5KD
 2WKBjybcr3wUMXHCdLFY87ct0JjUkkHNENGfwtU=
X-Google-Smtp-Source: APXvYqyMdDjFYVVjkKty7MCU9pQETSgvIRQo+VG4HV8ufLCJQClTn5aq0hJe+q6/NUYqWpbcaL6CgZlXWkS6qQGeo4o=
X-Received: by 2002:a67:2ecf:: with SMTP id u198mr15299340vsu.37.1574872100691; 
 Wed, 27 Nov 2019 08:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20191101130313.8862-1-emil.l.velikov@gmail.com>
 <20191101130313.8862-5-emil.l.velikov@gmail.com>
 <20191127084104.1ceb1f62@collabora.com>
In-Reply-To: <20191127084104.1ceb1f62@collabora.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 27 Nov 2019 16:27:29 +0000
Message-ID:
 <CACvgo52UB-sAv55_kREgHbRsg6b5KXv7At0TbgUPdc0e1E+QaA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm: drop DRM_AUTH from PRIME_TO/FROM_HANDLE ioctls
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=0FzcWYCmn0RWABpcgA0kJVxb/PlKVIkTcM9gwAyKkAw=;
 b=CvnwUzdwaHm3S5c9MEtBQcrHlEVKYXvxfynTOx/o/na620SD/hZgd2MTrKNNR4YNmg
 GhCo8Whk+dKMq7oNbmYqUhusCV/KQh2KRt1Lms720n6rY4BaiVWfSoJtt5dpmDIYLUxO
 5RD5cwP3bjbbt4OLuNGWPKZyFQK1LGJOcJ59FcttloYtUc5GMY3X6zDyOhM+Mb2zVrAc
 mrFuilTfEQq2EW/H1igdkcKyEsq2+3r8EKruu7w3waEi1IRMVdEN77aodKLykE8U2uB4
 EH7LjZaMoIeSHvEK7gAKrUgE3X7x5X7HVm5mfg3WQms4MHh8TfAlJq79lWOhhS7jcjmI
 MQ4w==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127162729.jtkAvOmjGo-8PwmNvNlHXTtYXJzHV0QynDfahvH7H_Y@z>

T24gV2VkLCAyNyBOb3YgMjAxOSBhdCAwNzo0MSwgQm9yaXMgQnJlemlsbG9uCjxib3Jpcy5icmV6
aWxsb25AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4KPiBIaSBFbWlsLAo+Cj4gT24gRnJpLCAgMSBO
b3YgMjAxOSAxMzowMzoxMyArMDAwMAo+IEVtaWwgVmVsaWtvdiA8ZW1pbC5sLnZlbGlrb3ZAZ21h
aWwuY29tPiB3cm90ZToKPgo+ID4gRnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29s
bGFib3JhLmNvbT4KPiA+Cj4gPiBBcyBtZW50aW9uZWQgYnkgQ2hyaXN0aWFuLCBmb3IgZHJpdmVy
cyB3aGljaCBzdXBwb3J0IG9ubHkgcHJpbWFyeSBub2Rlcwo+ID4gdGhpcyBjaGFuZ2VzIHRoZSBy
ZXR1cm5lZCBlcnJvciBmcm9tIC1FQUNDRVMgaW50byAtRU9QTk9UU1VQUC8tRU5PU1lTLgo+Cj4g
QXJlIHlvdSBzdXJlIHRoaXMgaXMgdHJ1ZSBmb3IgTU9ERVNFVC1vbmx5IG5vZGVzICh0aG9zZSB0
aGF0IGRvIG5vdAo+IGhhdmUgdGhlIFJFTkRFUiBjYXAgc2V0KSBpbXBsZW1lbnRpbmcgLT57ZmRf
dG9faGFuZGxlLGhhbmRsZV90b19mZH0oKT8KPiBTaG91bGRuJ3QgdGhlIGlzX2F1dGhlbnRpY2F0
ZWQoKSBjaGVjayBzdGlsbCBiZSBkb25lIGluIHRoYXQgY2FzZT8KPgpUaGFua3MgZm9yIGNhdGNo
aW5nIHRoaXMuIEp1c3Qgc2VudCBvdXQgdjIsIHdoaWNoIEkgc2hvdWxkIGFkZHJlc3MgdGhlIGNv
bmNlcm4uCgotRW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
