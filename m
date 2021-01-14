Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C5C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62E623B31
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62E623B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DD28808E;
	Thu, 14 Jan 2021 17:21:13 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0467E8808E;
 Thu, 14 Jan 2021 17:21:11 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id q25so6647309oij.10;
 Thu, 14 Jan 2021 09:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0potRu9mijL2B6HQx5jkNelrrnJJVWm3UpHe2HZ0UkI=;
 b=dkkmdGU5SlZ0ua3SCcGU3Bpw8R1lwPTH0z7h9tR3dKOXN5O2GusOiBM8f7ZQX8w/DX
 V8qYgr75uDn1fomgq80iLg9hjx7GVbiFxxR5Y+/o5ojzkgqHwSV/4YOnG135poq9Heft
 WXcD7NkHAxhXI2TO7+bQ7DO+HcyZ1LbcTzChM2XREx65/QW2ZIsMjQOyiuBrYPiIBNjV
 OxRs8w7Sr3gxgXxSGLg5+lXEf4pYnG/QXxtUItf2sfst4lyZD8DtrEHXJcge6Ltp18Bw
 kQG7G2AEaYQatprXSeT2LxELLyL07gKUZjo22q2J+QWpLfXCIybbK4dkGu1YgPQs/q6n
 7C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0potRu9mijL2B6HQx5jkNelrrnJJVWm3UpHe2HZ0UkI=;
 b=rEu7jPy2D0i2PKuO/563Ntkeb8IG1HvSvQoJVso8RgR8h6zN7khGDA6P/bDOtxfjSJ
 XrYx2yPj7dFoYhkkqp7BST2T1ojNKyJc2Y9ugttCPDqMZ6ekoaPOzRJvivEeeapEp8bD
 XxX1OfVIwXS1LPNssRmbsBXKpqxqkvGscwSuY2qHJMTIoOrBwzULn3ndLvFw11noBp53
 ZH2UOy0zgFhktt+H2aEZNiqVlz+dJxnuM3EFqnqd0DF/gZeJl8Z0IonNpbZagJ3gcoC9
 x2iMgMt0N+GJp4TlGCm3PySJusi7q+Ll+9KmO4QqKj+MGrIkLOuSjuaNSCIzfajVr1zL
 2UfQ==
X-Gm-Message-State: AOAM531krPrN0Eri5J+4CjGfBUS1+b/nK48UPyvc5DdXstnk+HSgTCgP
 scixmzcWjLKTxX7pEeZ1XNjt/6mLvZHzrioOMXI=
X-Google-Smtp-Source: ABdhPJyn7PJvDDprZivb8ih1mYMbCzJxKFwXet2VyRvoQcNfjsbey8uwLYLhfIp0+R/GxGXpS0WipFfH3Bo27FZudg8=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3148051oii.120.1610644871430; 
 Thu, 14 Jan 2021 09:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org>
 <20210113080752.1003793-20-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-20-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jan 2021 12:21:00 -0500
Message-ID: <CADnq5_O5mSkD0badwkm0ZsTnOBaoUd0grM7zwuKRX98U3zW8+Q@mail.gmail.com>
Subject: Re: [PATCH 19/30] drm/amd/display/dc/core/dc_link_dp: Mark
 'result_write_min_hblank' as __maybe_unused
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKYW4gMTMsIDIwMjEgYXQgMzowOCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEl0IGxvb2tzIGxpa2UgaXQgY291bGQgYmUgdXNlZCBpbnNpZGUg
dGhlIERDX1RSQUNFX0xFVkVMX01FU1NBR0UoKSBtYWNyby4KPgo+IEZpeGVzIHRoZSBmb2xsb3dp
bmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmM6IEluIGZ1bmN0aW9uIOKAmGRw
Y2Rfc2V0X3NvdXJjZV9zcGVjaWZpY19kYXRh4oCZOgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jOjQ0MDM6MTg6IHdhcm5pbmc6IHZh
cmlhYmxlIOKAmHJlc3VsdF93cml0ZV9taW5faGJsYW5r4oCZIHNldCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IENjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCj4gaW5kZXggM2MzM2I4ZmUyMThl
NS4uYjllNWUwZWVlM2QyNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY29yZS9kY19saW5rX2RwLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY29yZS9kY19saW5rX2RwLmMKPiBAQCAtNDQwMCw3ICs0NDAwLDcgQEAgdm9pZCBkcF9z
ZXRfZmVjX2VuYWJsZShzdHJ1Y3QgZGNfbGluayAqbGluaywgYm9vbCBlbmFibGUpCj4gIHZvaWQg
ZHBjZF9zZXRfc291cmNlX3NwZWNpZmljX2RhdGEoc3RydWN0IGRjX2xpbmsgKmxpbmspCj4gIHsK
PiAgICAgICAgIGlmICghbGluay0+ZGMtPnZlbmRvcl9zaWduYXR1cmUuaXNfdmFsaWQpIHsKPiAt
ICAgICAgICAgICAgICAgZW51bSBkY19zdGF0dXMgcmVzdWx0X3dyaXRlX21pbl9oYmxhbmsgPSBE
Q19OT1RfU1VQUE9SVEVEOwo+ICsgICAgICAgICAgICAgICBlbnVtIGRjX3N0YXR1cyBfX21heWJl
X3VudXNlZCByZXN1bHRfd3JpdGVfbWluX2hibGFuayA9IERDX05PVF9TVVBQT1JURUQ7Cj4gICAg
ICAgICAgICAgICAgIHN0cnVjdCBkcGNkX2FtZF9zaWduYXR1cmUgYW1kX3NpZ25hdHVyZTsKPiAg
ICAgICAgICAgICAgICAgYW1kX3NpZ25hdHVyZS5BTURfSUVFRV9UeFNpZ25hdHVyZV9ieXRlMSA9
IDB4MDsKPiAgICAgICAgICAgICAgICAgYW1kX3NpZ25hdHVyZS5BTURfSUVFRV9UeFNpZ25hdHVy
ZV9ieXRlMiA9IDB4MDsKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
