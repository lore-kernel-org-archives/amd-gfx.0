Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9EFC63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FE12076C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndXitIrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FE12076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B132897D4;
	Mon, 30 Nov 2020 22:11:31 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32BA89798;
 Mon, 30 Nov 2020 22:11:29 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id n12so12926737otk.0;
 Mon, 30 Nov 2020 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ETFvsz7DPdLzPT7VlFuUB/Fkyqm4Ejp9KpTAnp1NCwQ=;
 b=ndXitIrz54miGNcQSrozcAEwWCdIJKXgWMZk62ZLI2HkixdmOHzTQM+TZwhUgswJ4n
 EjtZGRieJtB+0N/H5SeXKdDjNiF3NU0v3Gvn6b2lIrHOCoEcaPTBsPt3oP5j+1g02XNZ
 ZJkr3nA+Zsdc/ZMJP20Amy8Zs4N9o/TNrBEFB1OSzfr0Ls7aVKdz7n9ZDyQy7JdVoddS
 Ax8ALMpE96jLs3MGl1xTeVQa0ig64u9ryjgZgwhsujSftvi1u6jb7RyaQO/48nVF2mX8
 sXTjXQvr7v9PW3qT5IW1n5Z1fMBOZMDgexlhM4Oxo82n6ZXYW+IB4JBrmh6Z/RW3XxWD
 gZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ETFvsz7DPdLzPT7VlFuUB/Fkyqm4Ejp9KpTAnp1NCwQ=;
 b=HqmrVuRqirfjzSTNNUCjGXUA/0ba2vRTVfyeG/fYUCnZe9COllKPMoKFjm97muFA73
 qX+NWdQETjvIcEiasoZA7xnybU8V2eEgeBWuPnq/whr+B5zV9JguI/jdgX57PD3fBBTD
 mMHEoKs1mcbrTOB5jRG7hB8g11g5WgNna9owhSAg7DKi6m6JSxdP6qs1xiyp2Fp8uWQZ
 iJqIcYa+9bSSxlbtE0BW4uQOXLeAO4f4zuzphDyCysywnIyBrr/HSWTSLOe+5EW+R5d4
 QpJHQXd1xQephpFq3IBlgm2KPNaTwjpbwC6XVFHt6JZ1ZnKb7spIEJfSM7fvVXdj3D7A
 loVQ==
X-Gm-Message-State: AOAM531PngpHsphEhheqGK+0anGvSGXOYFa14AR6PGvogFU36DtJfYHy
 jG14eekl4elZsh8ntU4LUyoRmKiI38vvQJ//y3CpMM5A
X-Google-Smtp-Source: ABdhPJwhOON7aAvHf5vEQnbPq+Zn1bRIyLJ221qqr9kjhkdxurNXiMOF4uiyqatAIebwHcYfxEj/y1hCzwWzyz0SJjM=
X-Received: by 2002:a05:6830:22e4:: with SMTP id
 t4mr18967658otc.23.1606774289360; 
 Mon, 30 Nov 2020 14:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org>
 <20201124193824.1118741-12-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-12-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 17:11:18 -0500
Message-ID: <CADnq5_Oev8Kfxa1HGR=NRBktOMUe9N_11WKBYDzgi8MfB3BOtQ@mail.gmail.com>
Subject: Re: [PATCH 11/40] drm/amd/amdgpu/psp_v11_0: Make local function
 'psp_v11_0_wait_for_bootloader()' static
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMjo0NSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jOjIy
Mzo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHBzcF92MTFfMF93YWl0
X2Zvcl9ib290bG9hZGVy4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPgo+IENjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogSGF3
a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQuICBU
aGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEx
XzAuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYwo+IGluZGV4IGVkZDJk
NmJkMWQ4NmEuLmJkNDI0OGM5M2M0OWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvcHNwX3YxMV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9w
c3BfdjExXzAuYwo+IEBAIC0yMjAsNyArMjIwLDcgQEAgc3RhdGljIGludCBwc3BfdjExXzBfaW5p
dF9taWNyb2NvZGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gICAgICAgICByZXR1cm4gZXJy
Owo+ICB9Cj4KPiAtaW50IHBzcF92MTFfMF93YWl0X2Zvcl9ib290bG9hZGVyKHN0cnVjdCBwc3Bf
Y29udGV4dCAqcHNwKQo+ICtzdGF0aWMgaW50IHBzcF92MTFfMF93YWl0X2Zvcl9ib290bG9hZGVy
KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiA9IHBzcC0+YWRldjsKPgo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
