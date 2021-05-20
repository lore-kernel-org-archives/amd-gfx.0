Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C2BC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C87061244
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C87061244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCBA6F50F;
	Thu, 20 May 2021 19:25:06 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED866F50B;
 Thu, 20 May 2021 19:25:04 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id v22so17468245oic.2;
 Thu, 20 May 2021 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lVeE6IXTSZq52YIMiJlL2kagzPEUqCZI6X+G12sjjFk=;
 b=NppzDjpIoyI0AJgaBtwTYOMbeW6j7IM2/FKF5wmpjpVAf4XOhG1i+aZmXpKAYWmrEZ
 QWZu3sRp244vQJASQrXoVgkbhZuCUAaCF6K7KeYAl3q3jfA6FFjH+Iov8R72ZT+bT+np
 xHilSrgDF4womkZkKuDJEbZwxHL6nvz/aBrqYIdcJUuue2K+fqt4216E4zwAsVwffm9N
 0HNP7n+XXlKXVG8UjfrGU6/bH+2Jw2Sl7hjQw7Y6fhmOJz0Vms9S9GCRJEvOQ1MP2/bp
 sYANxZ5PRJ4jVNRVha7NGZFm9xcZ3PDPiOo/1nhCvjvP9Bq0yA9qx27hNa2Nm3usoL4e
 SsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lVeE6IXTSZq52YIMiJlL2kagzPEUqCZI6X+G12sjjFk=;
 b=CbtGNrhZbEeVqwp5+lstTX+Z9TmN3aqBI70GkqDgrFkFoY2Gj2T/iS9InmRxXtfNyx
 04K1TE6ujJcZUdxDAnw8ysJMVFqsKvzSvRM1xn0CNUDIEuM9giJo5N0nf2Itseaz4K9d
 umHpK9JHS1/omptKbuenc60sLKFaMWQRyLyrz973n/AwJW05jsempioPgzm30TJE619W
 /9zlhLbp97O/2JSDa0DrJyhFLNXqva4Raz4Cfb50j83eN6BpVZUNo/p19Pcjw/XmjeUJ
 4s592k1sd34dj0mKvrQZaXH8Ax2xMbvJ9Dl0kjFnXPCUXq96hFKKU6FsODXnlL54A+IW
 RZNQ==
X-Gm-Message-State: AOAM532/vDUkK0SGvAgNeDUAOI8d+7SCBiSPzZ97zLpgsw/hHE9kifGl
 MJQhDF++zo+S4NP+TpoHkx+2rT9AN+/Ms3f3nsZn3jUE
X-Google-Smtp-Source: ABdhPJwUTj/6hABxGzsumBBPCdBSvbVvUey+E+MnywXwN4uKu+7momw2GO2WmgYigcRZgt26sng4UQTTieCnXeyCtKo=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr2494803oiw.123.1621538704376; 
 Thu, 20 May 2021 12:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-36-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-36-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:24:53 -0400
Message-ID: <CADnq5_Pk9ez0e46DD=zZzUOnORh6JX1QCow7hCZvT-UucwJ9Tg@mail.gmail.com>
Subject: Re: [PATCH 35/38] drm/amd/amdgpu/sdma_v5_2: Repair typo in function
 name
To: Lee Jones <lee.jones@linaro.org>
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
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDQgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3Y1XzIuYzo1MDE6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIHNk
bWFfdl8wX2N0eF9zd2l0Y2hfZW5hYmxlKCkuIFByb3RvdHlwZSB3YXMgZm9yIHNkbWFfdjVfMl9j
dHhfc3dpdGNoX2VuYWJsZSgpIGluc3RlYWQKPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6
IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogU3VtaXQgU2Vtd2FsIDxzdW1p
dC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBsaW51eC1tZWRpYUB2
Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4gU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAtLS0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgfCAyICstCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92NV8yLmMKPiBpbmRleCBlY2I4MmMzOWIxMDYyLi5kZWI5MDdmOTYwOTA2IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMKPiBAQCAtNTE3LDcgKzUx
Nyw3IEBAIHN0YXRpYyB2b2lkIHNkbWFfdjVfMl9ybGNfc3RvcChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgfQo+Cj4gIC8qKgo+IC0gKiBzZG1hX3ZfMF9jdHhfc3dpdGNoX2VuYWJsZSAt
IHN0b3AgdGhlIGFzeW5jIGRtYSBlbmdpbmVzIGNvbnRleHQgc3dpdGNoCj4gKyAqIHNkbWFfdjVf
Ml9jdHhfc3dpdGNoX2VuYWJsZSAtIHN0b3AgdGhlIGFzeW5jIGRtYSBlbmdpbmVzIGNvbnRleHQg
c3dpdGNoCj4gICAqCj4gICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiAgICogQGVu
YWJsZTogZW5hYmxlL2Rpc2FibGUgdGhlIERNQSBNRXMgY29udGV4dCBzd2l0Y2guCj4gLS0KPiAy
LjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
