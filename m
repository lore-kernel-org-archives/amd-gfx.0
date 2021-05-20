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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17950C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0E2611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0E2611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5736F4F7;
	Thu, 20 May 2021 19:22:47 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999E26F4F7;
 Thu, 20 May 2021 19:22:42 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 i8-20020a4aa1080000b0290201edd785e7so4035250ool.1; 
 Thu, 20 May 2021 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EjT7GiCfXinEXUQOvKuQzFUPIz+xSQbJvdKQn8o730Q=;
 b=J6JyotW8A4NEMe3rO8EdKpWc6K9L6dzZQkTX0VlmudWLmoDYuUe1tk0R8L7q1mX4TQ
 FBcSeqnfkGJfo8dGTyRhTqmwKd3RILGOJCAWKF/7IXWgtXAkDsJIq4r5/QCzxdnIXazc
 eDyMEcRlY7Yo+Uskm8PGaxYeX8xn69LQFccSZeUK15taQP5c68EwbFWncAUBDODaz7eR
 8VlbWsit1MeEyvAUdqCBsEX6hZ9zYNFaYuxZ4a02XOcsrTu5JULnfRVfn6WdEaOYFucY
 7TmeSo55tUz0A2Yr5aA932q8UN1XfomsuSFKtzX6EoMUVDzwgrPpgFud6yVdL+JBRIrw
 tvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EjT7GiCfXinEXUQOvKuQzFUPIz+xSQbJvdKQn8o730Q=;
 b=luLCZZFJCMUEr6DrKPfRYtve30+DIhcq8EfI6UoK3rVGo72+a/4Qg4RhOe4Sk9ABj+
 m1v506pFNkX4S8qwuhavTA8SinVBqt2kG4Ta5F5n/D7xHFY6Uf9ON5xAI2K6idNuez1c
 FDvIiRsea25+zz/BAKHOs/rbzh0ldQpUtCvgIDEsGOi4tD734h3VvmPL+7DHFwOjHcqA
 CQO5UXDOzYSwJzAQz2yFUOPu95wPvWeD/5qQzboMUiTwN1RAeISuXX6ziCkythEssPBE
 P2FXq8XViEMUiHwtEA4vpp8fFnvOArhxwnQLoi+5uW0Ev/w552EYcDdxkw51IqB52IpA
 4Dfw==
X-Gm-Message-State: AOAM530qDgAsY86FJ8iwduiuQIG9kzI3kwtzsZsa6ErdBV1KAEjKhuCe
 rUp41F76eLKR6Eb9prIGl+zMPdj6en6Ejg+zOeA=
X-Google-Smtp-Source: ABdhPJy68VS+3Rrx6xIOPNbBqW0+PFwgP19t6GdE0mfrNGhJU9QeDmXfAw6Wqvfqhk5v26syXxUUfcLiuaYFjHe73Nw=
X-Received: by 2002:a4a:d543:: with SMTP id q3mr4949388oos.72.1621538562024;
 Thu, 20 May 2021 12:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-32-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-32-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:22:30 -0400
Message-ID: <CADnq5_NMkxBTOe535wAjmpjT0VH2Xu4v6VRs0gn=Hp3g9y+sbA@mail.gmail.com>
Subject: Re: [PATCH 31/38] drm/amd/amdgpu/sdma_v2_4: Correct misnamed function
 'sdma_v2_4_ring_emit_hdp_flush()'
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3YyXzQuYzoyODE6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIHNk
bWFfdjJfNF9oZHBfZmx1c2hfcmluZ19lbWl0KCkuIFByb3RvdHlwZSB3YXMgZm9yIHNkbWFfdjJf
NF9yaW5nX2VtaXRfaGRwX2ZsdXNoKCkgaW5zdGVhZAo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4K
PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBTdW1pdCBTZW13YWwg
PHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGxpbnV4LW1l
ZGlhQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcK
PiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YyXzQuYyB8IDIgKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Ml80LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zZG1hX3YyXzQuYwo+IGluZGV4IDlmMGRkYTA0MGVjODguLjQ1MDliZDRjY2Uy
ZDYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Ml80LmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YyXzQuYwo+IEBAIC0yNzEs
NyArMjcxLDcgQEAgc3RhdGljIHZvaWQgc2RtYV92Ml80X3JpbmdfZW1pdF9pYihzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsCj4gIH0KPgo+ICAvKioKPiAtICogc2RtYV92Ml80X2hkcF9mbHVzaF9y
aW5nX2VtaXQgLSBlbWl0IGFuIGhkcCBmbHVzaCBvbiB0aGUgRE1BIHJpbmcKPiArICogc2RtYV92
Ml80X3JpbmdfZW1pdF9oZHBfZmx1c2ggLSBlbWl0IGFuIGhkcCBmbHVzaCBvbiB0aGUgRE1BIHJp
bmcKPiAgICoKPiAgICogQHJpbmc6IGFtZGdwdSByaW5nIHBvaW50ZXIKPiAgICoKPiAtLQo+IDIu
MzEuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
