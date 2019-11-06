Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD6CC5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391742067B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391742067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF0FA6EDDD;
	Wed,  6 Nov 2019 16:34:49 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5493D6EDDD
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 16:34:48 +0000 (UTC)
Received: by mail-yb1-xb44.google.com with SMTP id q18so10645841ybq.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2019 08:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZhAy5VZy8BG68UX6tsZJxd8FDb0RLc12HWwGztAue1U=;
 b=kUOARnITIPJG9vvCKsDDUI+UIme3A7Z0YteSxA3JDI9vB77TFwxDnfVxkjWEod/nD/
 OQPfHYtR7FjnyxrK9Mo4dHHJkLUFIVebqhdstPXn2sgMfOaj9cERknbZSeT5JnjxgSxj
 6pIBqXX2TIoCpvWfeVV/cXKK0UPFHdr1wODD1S2mm7IwUYmO+v8ACxMef6nIfc3PPMtJ
 /c5z1Ir3X35r+J6vXTfD2xCgGK1crQwMzHTKj6ubyUXlz0juHF4l8pJDbtwj8vFQ/oqf
 W7/Vz0KFqfEllWh4K9dakXpHwnH8GUvtCdmTJHql5v+ZL7B/FsI3unI9Dx+BJSfBHkpd
 jSWQ==
X-Gm-Message-State: APjAAAV+ohW4ebQxnvhfHnnet20s5pQTk51KWWRtvOeUKWvKRvNAJ6LH
 cWpGwlzuoff6JPgUNbghOBIeEd9XoS6k945JQdDQPw==
X-Google-Smtp-Source: APXvYqzretiAih39sg3eBpCqaUa+Mi2WMz2AorgrJP20A3xaehLzgM73Nn4uQkX5Ud5iBxxKlAEZ5dWeRkUpmSz9U+8=
X-Received: by 2002:a25:2fca:: with SMTP id v193mr2969177ybv.273.1573058087067; 
 Wed, 06 Nov 2019 08:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20191030142241.1575786-1-alexander.deucher@amd.com>
In-Reply-To: <20191030142241.1575786-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2019 11:34:34 -0500
Message-ID:
 <CADnq5_O8GVkGdomcn9vK3qifkAhYjO7exNfF85JBKM-hPQoFYw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix si_enable_smc_cac() failed issue
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=ZhAy5VZy8BG68UX6tsZJxd8FDb0RLc12HWwGztAue1U=;
 b=OC6CJDo4+MZHY2qejN3Re0Wpd9chiZhbnFYEcWESvFGml8DwyU/YOFgQwqQj4lMBtQ
 2rIlwKdaPVnWdEJH2W7zQW6uwZ9GSTQPn2vMBFLdPC7wL7+x8qmwLwS2jpraDkJCIshf
 pjrwlioWl3uOupWOqTOKz/nFxi8mpaOpbS3mtEa7FA2TeuAciMhTYimpdCQnT0AB6Wt9
 kvpS6kbM8GifV9wrsMbWWru4j22UVyzzCs94koGNYRHSMCdl/63Tv6ZiTvyXkvlFNB+e
 V+btjWtnfFxF9NsC3l0f1Vg8hq9SC6IaPZIXWMW5+JvBi+v6LaqlAgnC8gzt7MALRp5M
 3Siw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106163434.S3vC-1bymYRlugTH7dU1r1-tLiC4Zg6VZ_sN13fvZCU@z>

UGluZz8KCk9uIFdlZCwgT2N0IDMwLCAyMDE5IGF0IDEwOjIyIEFNIEFsZXggRGV1Y2hlciA8YWxl
eGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPgo+IE5lZWQgdG8gc2V0IHRoZSBkdGUgZmxhZyBv
biB0aGlzIGFzaWMuCj4KPiBQb3J0IHRoZSBmaXggZnJvbSBhbWRncHU6Cj4gNWNiODE4Yjg2MWJl
MTE0MTQ4ZThkYmViNDI1OTY5ODE0ODAxOWRkMQo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3NpX2RwbS5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCj4gaW5kZXggNDYwZmQ5OGU0MGE3Li5hMGIzODJhNjM3
YTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMKPiBAQCAtMTk1OCw2ICsxOTU4LDcgQEAg
c3RhdGljIHZvaWQgc2lfaW5pdGlhbGl6ZV9wb3dlcnR1bmVfZGVmYXVsdHMoc3RydWN0IHJhZGVv
bl9kZXZpY2UgKnJkZXYpCj4gICAgICAgICAgICAgICAgIGNhc2UgMHg2ODJDOgo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHNpX3BpLT5jYWNfd2VpZ2h0cyA9IGNhY193ZWlnaHRzX2NhcGVfdmVy
ZGVfcHJvOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNpX3BpLT5kdGVfZGF0YSA9IGR0ZV9k
YXRhX3N1bl94dDsKPiArICAgICAgICAgICAgICAgICAgICAgICB1cGRhdGVfZHRlX2Zyb21fcGwy
ID0gdHJ1ZTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgICAgICAg
ICAgY2FzZSAweDY4MjU6Cj4gICAgICAgICAgICAgICAgIGNhc2UgMHg2ODI3Ogo+IC0tCj4gMi4y
My4wCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
