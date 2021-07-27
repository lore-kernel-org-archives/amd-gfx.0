Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93FDC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 15:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AEF61B28
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 15:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79AEF61B28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5116E90C;
	Tue, 27 Jul 2021 15:14:36 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F274E6E90C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jul 2021 15:14:34 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 l12-20020a4a94cc0000b02902618ad2ea55so3155052ooi.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jul 2021 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wtftnpBdUiETIciSKr5AFVTwqscrzzVPoTfO1qqAiWo=;
 b=pRIIn7Ol/nJ9ZRr8F9g4V7XT3+nh98CSFF0ikhvr58WOJLMjWl1p7aUQ8x8TkUDPL9
 v2om37g4dASI1h3Y1xQv3bq8BG+LZBAbBxiopOfTFH0KdcVfW9GhqKUJ8Y5M945ep+IC
 L6JPW+ycKyo2ValQoiERDdf1Ic6zprEZSWaxplCj74EPx8hYtgwwMX0tDqSVNF6+xtuT
 2WYMuM2Z7WwP7UQ10EnBUbVQAVg5e8jG44ar8QD4rvgq5lZr/seEE0rYuBvunxfqiswO
 ccawtEXTVWvvwgjlMkxAbw8fHsoriPCr3d2+L9Yd31K4HULvXyMZrMJX9fdjh7oquPw+
 4YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wtftnpBdUiETIciSKr5AFVTwqscrzzVPoTfO1qqAiWo=;
 b=KcvLJi2rBQCUqmehau07T2XlJ6VL2pyxPJHLbCqS0doCN2NIHGWiThVvR8MvVXMz20
 SUU7A/GIWFPjWkALLuGCis7N8rt6T1wqeuN9Hte9zG8j3d+WPQhzbZltE+o9V/n7BE7I
 n/T71GHZiSCJipdpc8NrxgIAloDBRGK+Nm4vsCF3liVHL1+sC2gVnsaa0XP+zfPNU58N
 sXsRkR/1Yi4oZ2ZJNwsvB66KzbX16FfVR+e4gmQ2BhjEggSL83L4PHuf/xWeWahPcGmn
 yqda/qCWGWSwaNopvNQZVpCgXAcN4Ofe9XSW++Ay2ExEoAUvRZ07tW6E+D1jTvsQZyun
 9Wkg==
X-Gm-Message-State: AOAM5309ng5IVi2eenlmMrb56moztQbuxfrvBFv8SAeUoNgXxm6jJhOw
 fBvrNTxbKncng7Buyd0YdJmtNugOcyvRJnUIpno=
X-Google-Smtp-Source: ABdhPJzMPiCtVkpa72nG8kM8ORo1zh4pWUBTLequMabxkXwvf3LrZkJ+9Gm+tsxYpGVWroj6AC0ceTd+4GG5coAsJjE=
X-Received: by 2002:a4a:e1f8:: with SMTP id u24mr4698656ood.61.1627398874265; 
 Tue, 27 Jul 2021 08:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <N971xcA16PS0LZcvKTedK0IqLA2nrpKeiTBqJjXg@cp3-web-012.plabs.ch>
In-Reply-To: <N971xcA16PS0LZcvKTedK0IqLA2nrpKeiTBqJjXg@cp3-web-012.plabs.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Jul 2021 11:14:22 -0400
Message-ID: <CADnq5_NNSMSHSZWFwgr4ewX6rPBBWUkhSt7p8Hz04Ai9zkySUg@mail.gmail.com>
Subject: Re: [PATCH] maintainers: add bugs and chat URLs for amdgpu
To: Simon Ser <contact@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU3VuLCBKdWwgMjUsIDIwMjEgYXQgMTI6NDkgUE0gU2ltb24gU2VyIDxjb250YWN0QGVtZXJz
aW9uLmZyPiB3cm90ZToKPgo+IEFkZCBsaW5rcyB0byB0aGUgaXNzdWUgdHJhY2tlciBhbmQgdGhl
IElSQyBjaGFubmVsIGZvciB0aGUgYW1kZ3B1Cj4gZHJpdmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTog
U2ltb24gU2VyIDxjb250YWN0QGVtZXJzaW9uLmZyPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPiBDYzogUGFuIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPgoKQXBw
bGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIE1BSU5UQUlORVJTIHwgMiArKwo+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMg
Yi9NQUlOVEFJTkVSUwo+IGluZGV4IDBkYzg0MzM5Y2ZmNC4uNzhiZjEwYTFmNWQ1IDEwMDY0NAo+
IC0tLSBhL01BSU5UQUlORVJTCj4gKysrIGIvTUFJTlRBSU5FUlMKPiBAQCAtMTUyOTcsNiArMTUy
OTcsOCBAQCBNOiAgICAgIFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+Cj4gIEw6ICAg
ICBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ICBTOiAgICAgU3VwcG9ydGVkCj4gIFQ6
ICAgICBnaXQgaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2FnZDVmL2xpbnV4LmdpdAo+
ICtCOiAgICAgaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMK
PiArQzogICAgIGlyYzovL2lyYy5vZnRjLm5ldC9yYWRlb24KPiAgRjogICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvCj4gIEY6ICAgICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uLwo+ICBGOiAgICAgaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPiAtLQo+IDIuMzIuMAo+Cj4KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBs
aXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
