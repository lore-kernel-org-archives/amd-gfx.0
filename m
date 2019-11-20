Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C46EC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 12:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F70223D1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 12:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F70223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D566E4B3;
	Wed, 20 Nov 2019 12:36:55 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6BF6E4B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 12:36:54 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id t20so28715569qtn.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 04:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PCa08u6I5YrbQevYBwK2wwbr/B5GlZGC3OS1zH4YeP4=;
 b=jRjZ+Rj1bqWRC4b+u+ciw7Gt4SfQAMVvP4IkYtOWhCIO+0lu/vxXrWEEGLDodzsfBW
 OqGxh87tHrtZDw4KsKFpQrWKjfVJ5M/HzaDC7S7zyzcruRR1U1prYFYrYSYr3xihwmhj
 4WZNlAR9XDMISbRYyDFmtHOGPJ+70Mjp4espzi7GXAvEjD1TcQcm/OFW44A1o+UuJ4KL
 X9Nzwhx7Guaur+YZkclFGLYGHHY3FdL5+KQhcdIb9OXZAqsLQfD56IllTqULhQD+K4mG
 ajMODUguTYYbpsMSDRn8NjpkWA4u0pRZSKK/iBr/dGNqw0UK6yBA6Z5p/8xqiGWg8BM9
 knkg==
X-Gm-Message-State: APjAAAWg9je3Y6HsWFaB/4PlDFi2o+dJkykiN6BcDXimwwEZ7P5hlPyO
 M1/uHZfhDCuHHZd9FnG9XDn/X1aOcq367QXHBjO7Zoo3
X-Google-Smtp-Source: APXvYqycBEM5oTYKPkbvOIQwydVPQsiEoflTI5UWWRw5htoNOIcVSd62c7FKCBv980FlBUIXhRiqNI2nehm9zlRvPuU=
X-Received: by 2002:ac8:1c03:: with SMTP id a3mr2302416qtk.31.1574253413369;
 Wed, 20 Nov 2019 04:36:53 -0800 (PST)
MIME-Version: 1.0
References: <1571194113-22696-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1571194113-22696-1-git-send-email-curry.gong@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 20 Nov 2019 12:36:41 +0000
Message-ID:
 <CAHbf0-Hv5e_ZtdziJe9F0Zmgnsw9p_kXZ6HujSWZQOdFBvzSNg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/psp: declare PSP TA firmware
To: chen gong <curry.gong@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=PCa08u6I5YrbQevYBwK2wwbr/B5GlZGC3OS1zH4YeP4=;
 b=p2XeYj2V3mFq5ikJ4XsK4vCSYcECKHBIYfle1Q2HvKrSvki6NwXgi1SA/Z1XJmIY26
 hI1UbmoIu9jJr5NYfZp15wL+wfmQQJVylMRlULS+z3Czkhp5xXPW4iH0mVsfzZtGRCwL
 u/q4FLVokk4jOlR0AfxzM5M9C6pqqeeyCoxLJGtJqQMswEqhHFRVWPpAh1zU1mWZzoNU
 fhiD8DRlRSVCRK1kGhON0QI2fdelo6jgJtRBx0GwFRdmJDH/5dF/1jggo4NjLAaZCt9U
 ceoqZPdffqoZSnfoYrtQ6OobC2ZiL4EmzRulQQuAZYOuZ/5T7GRjiW+cRnYsKvEt5Rdv
 L5Yw==
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
Cc: Bhawanpreet.Lakha@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120123641.Un-leEFKt8lIOAjE5QnycuXvu8yVAI-evhfk1iFH34M@z>

SGkKCkFueSBpZGVhIHdoZXJlIEkgY2FuIGZpbmQgdGhvc2UgYmxvYnM/CgpDaGVlcnMKCk1pa2UK
Ck9uIFdlZCwgMTYgT2N0IDIwMTkgYXQgMDM6NDgsIGNoZW4gZ29uZyA8Y3VycnkuZ29uZ0BhbWQu
Y29tPiB3cm90ZToKPgo+IEFkZCBQU1AgVEEgZmlybXdhcmUgZGVjbGFyYXRpb24gZm9yIHJhdmVu
IHJhdmVuMiBwaWNhc3NvCj4KPiBTaWduZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5LmdvbmdA
YW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMF8wLmMg
fCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9wc3BfdjEwXzAuYwo+IGluZGV4IGI5NjQ4NGEuLmIzNDVlNjkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMF8wLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEwXzAuYwo+IEBAIC00MCw2ICs0MCw5IEBA
Cj4gIE1PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L3JhdmVuX2FzZC5iaW4iKTsKPiAgTU9EVUxFX0ZJ
Uk1XQVJFKCJhbWRncHUvcGljYXNzb19hc2QuYmluIik7Cj4gIE1PRFVMRV9GSVJNV0FSRSgiYW1k
Z3B1L3JhdmVuMl9hc2QuYmluIik7Cj4gK01PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L3BpY2Fzc29f
dGEuYmluIik7Cj4gK01PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L3JhdmVuMl90YS5iaW4iKTsKPiAr
TU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvcmF2ZW5fdGEuYmluIik7Cj4KPiAgc3RhdGljIGludCBw
c3BfdjEwXzBfaW5pdF9taWNyb2NvZGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gIHsKPiAt
LQo+IDIuNy40Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
