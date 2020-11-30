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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F57C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E0F2076C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7UcTmqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E0F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F9B89C89;
	Mon, 30 Nov 2020 23:10:27 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8269B89C89;
 Mon, 30 Nov 2020 23:10:25 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id k26so16150886oiw.0;
 Mon, 30 Nov 2020 15:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MqB4uxSS+iPnXKAcDpnlQHbGQ3lVIUy31ucDNBjIS5Q=;
 b=G7UcTmqfY6UjddXaZ0hntPYD8upw1vIMeqdjsItMhcP/O5i13V3TNuBr6R9uHWy8XV
 FHmmiPPUBSXO83tALNmEzUe4OHR7wT5Kre/+zOwGBwP1XrsKUEbWKgWXPCJONZ/+738b
 CZWoa/Iumw7I110YQLpm0oOhih6QLG3Ad7YqFtn4+hxuMq1h6SyvDTn0VVBPPNciAt8T
 9BtOmzuD0wfVnq8bTjkIxw+oD4lrL9nKrcEMCBISKEkrNvTn9j4DMW93FXdHSuTirMEv
 5I2Mh8x0cQPP+NAv1j20kDHR7WdwkhxSGBX+GZxYqBBrBKY/6v7nUH9Wvuwvo0p3mqAs
 j1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MqB4uxSS+iPnXKAcDpnlQHbGQ3lVIUy31ucDNBjIS5Q=;
 b=nnrBC1A/OODaSdwTVuomv/REup5sB8P0JcXkL0kJWU/ccCZCb8dtwhQLTBEmG+n1mn
 blbBUOFxDYFCC75QMVxwxlN7viy15zv6jMtw3AhRLVzb7a5l82VlD9hD4ZuQF9UPduOD
 2rEaJvhJs1PKp1JSOFxhFc5qjyNbPAHdkLKZK4F71Py36deBg/Y0HXj32SMt2XSAixoE
 veaOQ9rk7ndsNivo56R/Lu9U72H/XBg39WqCUFw+yX93j8EzPVWBkkoPbxolUBwOZMau
 0ACOVf5DDS9OCVMn8mbSCC9ZAyJgqDgn7J9KW4i0nEGGS4hRPjJ6v5GbirlQCTNiHOoA
 swRQ==
X-Gm-Message-State: AOAM5308EA+MHOO1UNGDKLb5VmzEeVJXtpUcgYs26owVnbK/h7dRUAEX
 d2ziE9rkiFvJssJRhBtjkTrUhsxVy4kh36YDBMUbBuZL
X-Google-Smtp-Source: ABdhPJzQxjaycZ7pd5ksW0geDAvANUHHs/8Sm3OJPUfBBMN3TgvDSJ461DMyJjPYQrSKK324GWYNwB166U2buuMp94c=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr72250oih.123.1606777824964;
 Mon, 30 Nov 2020 15:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-3-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-3-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:10:13 -0500
Message-ID: <CADnq5_Njrr_3LAzk9R8+yaF0V4gfXGTrc31z7kKT1XR4FZEJGQ@mail.gmail.com>
Subject: Re: [PATCH 02/40] drm/amd/pm/powerplay/smumgr/polaris10_smumgr: Make
 function called by reference static
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
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMjYsIDIwMjAgYXQgODo0MiBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxh
eS9zbXVtZ3IvcG9sYXJpczEwX3NtdW1nci5jOjIxNDU6NTogd2FybmluZzogbm8gcHJldmlvdXMg
cHJvdG90eXBlIGZvciDigJhwb2xhcmlzMTBfdGhlcm1hbF9hdmZzX2VuYWJsZeKAmSBbLVdtaXNz
aW5nLXByb3RvdHlwZXNdCj4KPiBDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc211bWdyLmMgfCAyICstCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBf
c211bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJp
czEwX3NtdW1nci5jCj4gaW5kZXggMDUyYmM4OGNmMzNjOS4uNDUyMTRhMzY0YmFhOSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJpczEw
X3NtdW1nci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdy
L3BvbGFyaXMxMF9zbXVtZ3IuYwo+IEBAIC0yMTQyLDcgKzIxNDIsNyBAQCBzdGF0aWMgaW50IHBv
bGFyaXMxMF9wcm9ncmFtX21lbV90aW1pbmdfcGFyYW1ldGVycyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3
bWdyKQo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPgo+IC1pbnQgcG9sYXJpczEwX3RoZXJtYWxf
YXZmc19lbmFibGUoc3RydWN0IHBwX2h3bWdyICpod21ncikKPiArc3RhdGljIGludCBwb2xhcmlz
MTBfdGhlcm1hbF9hdmZzX2VuYWJsZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQo+ICB7Cj4gICAg
ICAgICBzdHJ1Y3Qgc211N19od21nciAqZGF0YSA9IChzdHJ1Y3Qgc211N19od21nciAqKShod21n
ci0+YmFja2VuZCk7Cj4KPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
