Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A14C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704CF610F7
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704CF610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD47A6E49A;
	Wed,  5 May 2021 13:12:31 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DA46E49A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 13:12:30 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id m13so2081037oiw.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 May 2021 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nX/cue1FtS93vK8kaBqe42ubBG/I3rvovfHCSVQIaTE=;
 b=sqFLux+9DQiWq9nMr+xNmJEFSmammKbJwXlQhYNfdLl3kf4ATrnlYJXJP9GS46oYLf
 WyJ4QSKw61zI5COD6F56h0i67MCkCidjZ525H3c3nPNhx/ZG+2VSZBOD/HoDg4Sxwz47
 4IPMjbZe+hNKizVGucbvuhDPiQssr3Sei/H0mHSS90UnTmKJWUETQRYZ5YWcqSyi3Ay2
 ZmCBQ8tcXFwzFU2zZkkD8dgwFZUzGI5u4lyher5c3vt82ph3tXnoUeiU/AkGb3w3mBBM
 zkKxmdAy6mQMk5ziRPUk4KJDxXsWG/cdydBxVl3p3jU1goHEX8zPs99k5GjwQEo2RZSX
 Q3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nX/cue1FtS93vK8kaBqe42ubBG/I3rvovfHCSVQIaTE=;
 b=QX3bMPzZra7Yd6BXqfJHhdhpfHsjACI3eNAq7HvprqZ0AerGuPCsqfkjV6rxqJgfkB
 6faxM7FadUgxJ42ob8FQXIjW4z04EfpPQCI5IS+QXvUpViA8WYtW58g97nt17Td+sxBS
 aaz2eW8aARiBOqWpG+2RgyJCYDd/7HxgUymLEaImckoDCBswgCVeN3xHj1pTHQWFfEQT
 PfaVc3UbDWs5xEu4/5Vi6R0VbrIb2Dzq/CQazuOTrmd5vqQkNKwY6IuRt62364IKQK6a
 Yvbgj32eyBzAem7aIiYJAP/oU8KzIxyxFKE9UoqfglVNf8Lbmgn3bX8WhJoRvnORG6wp
 N3ig==
X-Gm-Message-State: AOAM530CgxyiUI5KXn1m/qyzSMUstzmOMCjOzX1//YlytHeBAhL0Ev9D
 lyfxWfkNlDJS2ztV+X9VvnjTD4FC3B++4ukbV8GIhPrA
X-Google-Smtp-Source: ABdhPJytREQl0vMlLlQY5Dyc5MIwKbCBMGyiE306HnVqcK2ESU5E4vvhyxAounrEBVNvvklMyVbqkVQnr0Wqd37QgKI=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr15816897oii.123.1620220350373; 
 Wed, 05 May 2021 06:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210505110146.11689-1-christian.koenig@amd.com>
In-Reply-To: <20210505110146.11689-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 May 2021 09:12:19 -0400
Message-ID: <CADnq5_O4u5tfrD=b+Z5AbjT+RRTfNd9kCkVDsxOK7a8KQj8Qrw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Xinhui Pan as another AMDGPU contact
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 xinhui pan <Xinhui.Pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBNYXkgNSwgMjAyMSBhdCA3OjAxIEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IFNpbmNlIENodW5taW5nIFpob3Ug
bGVmdCBBTUQgbGFzdCB5ZWFyIHdlIGFyZSBkb3duIHRvIG9ubHkKPiB0d28gbWFpbnRhaW5lcnMg
b25jZSBtb3JlLiBTbyBhZGQgWGluaHUgUGFuIGFzIGFub3RoZXIKPiBjb250YWN0IGFzIHdlbGwu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgoKPiAtLS0KPiAgTUFJTlRBSU5FUlMgfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwo+IGlu
ZGV4IDY0ZWQ4Yjc3Y2ZhOS4uZTJjYjVhOGFjZGYxIDEwMDY0NAo+IC0tLSBhL01BSU5UQUlORVJT
Cj4gKysrIGIvTUFJTlRBSU5FUlMKPiBAQCAtMTQ5NzAsNiArMTQ5NzAsNyBAQCBGOiAgICAgIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL3F1YW50ZW5uYQo+ICBSQURFT04gYW5kIEFNREdQVSBEUk0gRFJJ
VkVSUwo+ICBNOiAgICAgQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
ICBNOiAgICAgQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ICtN
OiAgICAgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4KPiAgTDogICAgIGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gIFM6ICAgICBTdXBwb3J0ZWQKPiAgVDogICAgIGdpdCBo
dHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvYWdkNWYvbGludXguZ2l0Cj4gLS0KPiAyLjI1
LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
