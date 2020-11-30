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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBEBC64E7B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E922076C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOPRVaN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E922076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3742C8996F;
	Mon, 30 Nov 2020 23:09:21 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BAD8996F;
 Mon, 30 Nov 2020 23:09:20 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id h19so13083948otr.1;
 Mon, 30 Nov 2020 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J/JA2QHuMpYftB+Osd3l6b/sOo2jHBKPSU8ic35WqME=;
 b=nOPRVaN2A1Le1NwZHS3q6mYRIhcuB7foKxQN64YeNJn/uuBx+RG1P6JclOCG+oy8ko
 pvpNgIfCshDjKK4kooB7p2oIYcytgpwmg9zut0uWDNyPs38wXK0M8p3XbNtWlM86VrYb
 ADl3XIIMGbPHST15YX8aRdqbIoC7i11VKjQHJMRNqLy+8zXvIbiNWoACkqbdp7XaJr+D
 A5I4ipaXHMUEI5EfUpWafL8vgzvBd3YY54S4/WX9TF/0cyZkRKTncu6JZPTp/zm93WnN
 Bz+sucYWuLVcZj4dGBsoSxFiNlUgM1jfxiG69rS6N9i9/4MOxHoaV3j44s7yZhWbi+zB
 2nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J/JA2QHuMpYftB+Osd3l6b/sOo2jHBKPSU8ic35WqME=;
 b=DaC1wHEU2b6HgEXYrBOesZad1lj4LUuHH7JHr6SXRJJY2YONZ3FXxssyL6GlGJWnAK
 oXZbdIEmDYb2av2XgOxIWLHntpz1Xue+H2Aw1/tUtn30MD7fqEHUFRqnxt0GvSVQI3HJ
 37Zt59tDp3kGZ3POkfZjqvPDlK0oMdA45UNkhF9KbknfvDgEdSHC902zCsSsINrBtOwm
 AZWqYknthxW3kQYPoXUC1UkHI0efvk7tArAzGNisMNfe4mRTlEUsBt4aGa2d3Ww1s4OT
 m/GUgqzedSti7A6H4jy3bs0WMG+2lK13zee+Ek9WljlZsp4ATrHV53k5r/UaV3k4m3Av
 Xdow==
X-Gm-Message-State: AOAM53092ggcioMLYZVAQ2bfJpUp24Ic5hInMTu0YbHBJDNFagT8f2DE
 s8PNnJb7zhRWoia0sY8JenlTiDQzJKia/dUgCrQ=
X-Google-Smtp-Source: ABdhPJxCSXUMPP0ZI97R0IC/K40/cxIU5+ZMkCy3yWJIZXmdRE+bjla5Nxc+Y2fG7e73MWuOH4H9h70bydvMKNOy2MI=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19320659otf.132.1606777760122; 
 Mon, 30 Nov 2020 15:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-2-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-2-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:09:08 -0500
Message-ID: <CADnq5_P56t2WVe2akpysWfQ=6SbxacoS_d41GtehgJGws2vpUg@mail.gmail.com>
Subject: Re: [PATCH 01/40] drm/amd/pm/powerplay/smumgr/tonga_smumgr: Remove
 set but unused variable 'res'
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
eS9zbXVtZ3IvdG9uZ2Ffc211bWdyLmM6IEluIGZ1bmN0aW9uIOKAmHRvbmdhX3RoZXJtYWxfc2V0
dXBfZmFuX3RhYmxl4oCZOgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dl
cnBsYXkvc211bWdyL3RvbmdhX3NtdW1nci5jOjI0Njk6Njogd2FybmluZzogdmFyaWFibGUg4oCY
cmVz4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCj4KPiBD
YzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+
IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBT
aWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvdG9uZ2Ffc211bWdyLmMgfCA5
ICsrKy0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3Nt
dW1nci90b25nYV9zbXVtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3Nt
dW1nci90b25nYV9zbXVtZ3IuYwo+IGluZGV4IDRiZmFkYjQ5NTIxYmMuLmMyOGYzZTEyOTk3MDEg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdyL3Rv
bmdhX3NtdW1nci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211
bWdyL3RvbmdhX3NtdW1nci5jCj4gQEAgLTI0NjYsNyArMjQ2Niw2IEBAIHN0YXRpYyBpbnQgdG9u
Z2FfdGhlcm1hbF9zZXR1cF9mYW5fdGFibGUoc3RydWN0IHBwX2h3bWdyICpod21ncikKPiAgICAg
ICAgIHVpbnQzMl90IHRfZGlmZjEsIHRfZGlmZjIsIHB3bV9kaWZmMSwgcHdtX2RpZmYyOwo+ICAg
ICAgICAgdWludDE2X3QgZmRvX21pbiwgc2xvcGUxLCBzbG9wZTI7Cj4gICAgICAgICB1aW50MzJf
dCByZWZlcmVuY2VfY2xvY2s7Cj4gLSAgICAgICBpbnQgcmVzOwo+ICAgICAgICAgdWludDY0X3Qg
dG1wNjQ7Cj4KPiAgICAgICAgIGlmICghcGhtX2NhcF9lbmFibGVkKGh3bWdyLT5wbGF0Zm9ybV9k
ZXNjcmlwdG9yLnBsYXRmb3JtQ2FwcywKPiBAQCAtMjUzOSwxMSArMjUzOCw5IEBAIHN0YXRpYyBp
bnQgdG9uZ2FfdGhlcm1hbF9zZXR1cF9mYW5fdGFibGUoc3RydWN0IHBwX2h3bWdyICpod21ncikK
Pgo+ICAgICAgICAgZmFuX3RhYmxlLkZhbkNvbnRyb2xfR0xfRmxhZyA9IDE7Cj4KPiAtICAgICAg
IHJlcyA9IHNtdTdfY29weV9ieXRlc190b19zbWMoaHdtZ3IsCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNtdV9kYXRhLT5zbXU3X2RhdGEuZmFuX3RhYmxlX3N0YXJ0
LAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodWludDhfdCAqKSZm
YW5fdGFibGUsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1aW50
MzJfdClzaXplb2YoZmFuX3RhYmxlKSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgU01DX1JBTV9FTkQpOwo+ICsgICAgICAgc211N19jb3B5X2J5dGVzX3RvX3NtYyho
d21nciwgc211X2RhdGEtPnNtdTdfZGF0YS5mYW5fdGFibGVfc3RhcnQsCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICh1aW50OF90ICopJmZhbl90YWJsZSwKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKHVpbnQzMl90KXNpemVvZihmYW5fdGFibGUpLCBTTUNfUkFNX0VO
RCk7Cj4KCldlIHNob3VsZCBwcm9iYWJseSByZXR1cm4gdGhlIGVycm9yIGhlcmUgcmF0aGVyIHRo
YW4gZHJvcHBpbmcgaXQuCkknbGwgc2VuZCBvdXQgYSBwYXRjaC4KClRoYW5rcywKCkFsZXgKCgo+
ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0
Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
