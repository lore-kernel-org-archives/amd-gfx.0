Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280F4C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE9423A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE9423A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3996E8CB;
	Fri,  8 Jan 2021 20:34:24 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD736E8CA;
 Fri,  8 Jan 2021 20:34:22 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id q6so2692339ooo.8;
 Fri, 08 Jan 2021 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Nn5Yj71tkKIVrulq1WIDxZxckjqVz9PFKak3TcGJVF0=;
 b=moUBx6E02X34CiH2aZUlZWkIkglOKoDjtYh17GXYyicOZbLSi9/7jas14rvX8JC7Jm
 d20hG0sgrjmOh1mN1ukeRuluOMuoGTUtfeV+hSOIGsIB4pbCI0dKyeX1q2D9c7BIMvq8
 mo/WdUUymM0x+y1+YBq8yZ9dxvyrfJCBzu+jEORkqGkIr707jgDMnK5/1p4C7XQi0Bz9
 Zg0VkXuYhdNoXRW4uARrdSAhDtIgMffhHmSw/FpwElhVLYFGcoXX3ZCNyfIgCIrgD51P
 EFV3y68F3p7vJEdxRdnTZndxVbMSebvqu2xhuFfUZGNf5Ps1ZJ6CfD/1tkA4YtDxF4sC
 4o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Nn5Yj71tkKIVrulq1WIDxZxckjqVz9PFKak3TcGJVF0=;
 b=FLmg+ADroxTjQ54S/atihU/4+05jzPehv+bkiMzzpm+pweajuRSNzin2IF+IWrCMHS
 RkT5n6z8wcZclToVyMk/f2PYppGW8LlgyImsIbgxnkW+ViYRbpxWXfQ9hyIArlhNW2BC
 rB7N9twSbRzs/8N3zTqV+5FaL/2e5VyiKqAFSKm8SiOPWI1cAsNfzUB3fyZkkI4NBMjr
 Uh1MAJcTUu5qW5jsB2cVqtPrJDTAoshj7mmqN7ScHi3nfnI4me7DwgQfdPCwE/yMXXLt
 3jaEc5cwY37Pe8OZrZDnr62mF5GWNyEHk59+uPaMuIJGNXPdGMbebROP+yKwuxjfrnOR
 HKGg==
X-Gm-Message-State: AOAM531tbcOFabJZZIoWCqjsoYtqVPMwOAHhwOPXHuZtu6h2Qoe+6dUz
 W65HxOt9KV8gVUaWaQc7dNpuzpt8xAkZ0mIAdyE=
X-Google-Smtp-Source: ABdhPJzS2GpG+PF4XXrf90up0wn3fJ1R8B3W9Fo+t+b0+7NVShJkdDQdv1Rqlv//xNl4nKVcjrFVwLkoPl7y0nM9h4E=
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr5577304oof.61.1610138062004;
 Fri, 08 Jan 2021 12:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org>
 <20210108201457.3078600-9-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-9-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 15:34:11 -0500
Message-ID: <CADnq5_PMi=7n+7McEhm23ZjhjYQNpJYqRknYj8d=0J-d7wWvAA@mail.gmail.com>
Subject: Re: [PATCH 08/40] drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Fix legacy
 function header formatting
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

T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAzOjE1IFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5
L2h3bWdyL3ZlZ2ExMl9od21nci5jOjcyODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9y
IG1lbWJlciAnaHdtZ3InIG5vdCBkZXNjcmliZWQgaW4gJ3ZlZ2ExMl9pbml0X3NtY190YWJsZScK
Pgo+IENjOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBs
aWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dl
cnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmMgfCAxMSArKysrKy0tLS0tLQo+ICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmMKPiBpbmRl
eCBkYzIwNmZhODhjNWU1Li5jMDc1MzAyOWE4ZTJhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmMKPiBAQCAtNzE4
LDEyICs3MTgsMTEgQEAgc3RhdGljIGludCB2ZWdhMTJfc2F2ZV9kZWZhdWx0X3Bvd2VyX3Byb2Zp
bGUoc3RydWN0IHBwX2h3bWdyICpod21ncikKPiAgI2VuZGlmCj4KPiAgLyoqCj4gLSogSW5pdGlh
bGl6ZXMgdGhlIFNNQyB0YWJsZSBhbmQgdXBsb2FkcyBpdAo+IC0qCj4gLSogQHBhcmFtICAgIGh3
bWdyICB0aGUgYWRkcmVzcyBvZiB0aGUgcG93ZXJwbGF5IGhhcmR3YXJlIG1hbmFnZXIuCj4gLSog
QHBhcmFtICAgIHBJbnB1dCAgdGhlIHBvaW50ZXIgdG8gaW5wdXQgZGF0YSAoUG93ZXJTdGF0ZSkK
PiAtKiBAcmV0dXJuICAgYWx3YXlzIDAKPiAtKi8KPiArICogSW5pdGlhbGl6ZXMgdGhlIFNNQyB0
YWJsZSBhbmQgdXBsb2FkcyBpdAo+ICsgKgo+ICsgKiBAaHdtZ3I6ICB0aGUgYWRkcmVzcyBvZiB0
aGUgcG93ZXJwbGF5IGhhcmR3YXJlIG1hbmFnZXIuCj4gKyAqIHJldHVybjogIGFsd2F5cyAwCj4g
KyAqLwo+ICBzdGF0aWMgaW50IHZlZ2ExMl9pbml0X3NtY190YWJsZShzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyKQo+ICB7Cj4gICAgICAgICBpbnQgcmVzdWx0Owo+IC0tCj4gMi4yNS4xCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
