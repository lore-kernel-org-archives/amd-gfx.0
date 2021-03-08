Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1132EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5D36520C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5D36520C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3376E87D;
	Mon,  8 Mar 2021 20:34:33 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693C96E87D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 20:34:32 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id n23so4940330otq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 12:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OPyhd22Wy34SGMtLPo13T19t7I8EtWgSTf4nagtRyj4=;
 b=B8fdFFFg7THCbBLQWZAYsoUUCJtTLLtERri8Nu10YIe8L7gRwpx+taxNtiZozAQDv0
 4NBaIHf05QsgeITBZZtkURmXC59jWZ0xgSjghRsT2LB6RrJ7W8kxl7DdN8O+AN0fmcPc
 Zq3EkF3UCOFW/N/LDAaGIxk9rcwK2CeVp16jsPpwROx4yptKYE75ZJ3PsFFlDwJOhwIs
 NWbdkTLF661cGWqOnguLWvG1EcIZfE9q3sMwiCBq9AlpJ80o8M9mbc1QMl8gj/BMKMoM
 Vi9nSbUXn3RLSXTD86/5wfkhB3a1+DEzJOyv0ceaQ6C8xbl2Q8yBR/K7O1FxgLyNkaoO
 3cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OPyhd22Wy34SGMtLPo13T19t7I8EtWgSTf4nagtRyj4=;
 b=G2TnpzqIkrAPpk737xCKoi0rH092Ve2XZNZorWOhYlLO5aRe81qAH2WrAhwhyoqctO
 yVjG3PsGKZ9wMTdH/4/tkesDT7PScjyY6/+AcDK8PwCSflkyk0UUOPwXrUhMJ+jZngCd
 NareapgM2R+vLDw8HoEF0v+tzaffcFYqxtudPodsHb05FK3UVjZGO/CsgUUBmJlZqdRj
 lUTGaK/gStllby4ZDbngxtHOczskeh2bLpMfx4vQn6vpLJb9QI17vVwJ50iMPZ16S4eZ
 w5PZGeEPmbmkxr6KhX+zIxqwaABD1DdERTZmKd5wWyQqdUYgIc0Sr7QEP4gUmbL7CLO7
 wJIw==
X-Gm-Message-State: AOAM531JkOo40RhtxP2Q9WFL3I86J0AIp7Bbbg/SK06UU969GdHKIVVT
 hCWd6oedGYzEeY1PdguakJfRhZByY0QN8HxtkiNyKkR6
X-Google-Smtp-Source: ABdhPJwwtlgKSAAe0K1ElRo8LoXpj9SF5SvqvX+racGap4AYtSFmiY8wspvTlB2lawiDC5tq//3auU5Aa3AFbhC1fuw=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr21534610otl.23.1615235671776; 
 Mon, 08 Mar 2021 12:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20210308153705.37414-1-nirmoy.das@amd.com>
 <20210308153705.37414-3-nirmoy.das@amd.com>
 <409b3da2-1f31-89f8-be28-0fb7854d594d@amd.com>
In-Reply-To: <409b3da2-1f31-89f8-be28-0fb7854d594d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Mar 2021 15:34:20 -0500
Message-ID: <CADnq5_NJJu3h==aqvhx4Cb+ScD4Yk6PtktYOxWxreBa8trL5oQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: fb BO should be ttm_bo_type_device
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBNYXIgOCwgMjAyMSBhdCAzOjIwIFBNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwOC4wMy4yMSB1bSAxNjozNyBzY2hyaWVi
IE5pcm1veSBEYXM6Cj4gPiBGQiBCTyBzaG91bGQgbm90IGJlIHR0bV9ib190eXBlX2tlcm5lbCB0
eXBlIGFuZAo+ID4gYW1kZ3B1ZmJfY3JlYXRlX3Bpbm5lZF9vYmplY3QoKSBwaW5zIHRoZSBGQiBC
TyBhbnl3YXkuCj4KPiBNaG0sIHdoeSB0aGUgaGVjayB3YXMgdGhhdCBhIGtlcm5lbCBvYmplY3Q/
CgpNYXliZSBiZWNhdXNlIHRoZSBmYmNvbiB3YXMgdGhlIG1haW4gdXNlciBmb3IgdGhpcyBoaXN0
b3JpY2FsbHkgYW5kCnRoZSBjb2RlIHdhcyBjb3BpZWQgZnJvbSByYWRlb24gd2hpY2ggYWxzbyBz
dGlsbCBzZXRzIGl0IHRvIGtlcm5lbC4KCkFsZXgKCj4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBO
aXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMgfCAyICstCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mYi5jCj4gPiBpbmRleCA1MWNkNDljNmYzOGYuLjI0MDEwY2FjZjdkMCAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwo+ID4gQEAgLTE0
Niw3ICsxNDYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdWZiX2NyZWF0ZV9waW5uZWRfb2JqZWN0KHN0
cnVjdCBhbWRncHVfZmJkZXYgKnJmYmRldiwKPiA+ICAgICAgIHNpemUgPSBtb2RlX2NtZC0+cGl0
Y2hlc1swXSAqIGhlaWdodDsKPiA+ICAgICAgIGFsaWduZWRfc2l6ZSA9IEFMSUdOKHNpemUsIFBB
R0VfU0laRSk7Cj4gPiAgICAgICByZXQgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUoYWRldiwg
YWxpZ25lZF9zaXplLCAwLCBkb21haW4sIGZsYWdzLAo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHR0bV9ib190eXBlX2tlcm5lbCwgTlVMTCwgJmdvYmopOwo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR0bV9ib190eXBlX2RldmljZSwgTlVM
TCwgJmdvYmopOwo+ID4gICAgICAgaWYgKHJldCkgewo+ID4gICAgICAgICAgICAgICBwcl9lcnIo
ImZhaWxlZCB0byBhbGxvY2F0ZSBmcmFtZWJ1ZmZlciAoJWQpXG4iLCBhbGlnbmVkX3NpemUpOwo+
ID4gICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPgo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
