Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCBC5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6E0217F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6E0217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3626EE04;
	Wed,  6 Nov 2019 17:20:57 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2B26EE04;
 Wed,  6 Nov 2019 17:20:56 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id c22so4373702wmd.1;
 Wed, 06 Nov 2019 09:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7nuh17+p/kI43xREuVK4a8I5e5bWCvbJIdUjydClras=;
 b=RsdWCbcRHYqAHaW2IKo7q7KgKQ/o5SE17RYKekS04I49yQAlcBRVacSkjVpHzA849j
 iD5NTPx7gd/u80eYV3XN9UVv6QB0aPieAAr2TyTT5UUN9RKCxAg0FIvgwvkeojZND7Wr
 ewiavbKRkgmO2e8Ef5drjUcutTRIrxp9Z4Q6PwaGGSiOAQPi5o4SygNC/hz+3ky2fk7a
 ykoQwJyAQFj2V7NCb8HHNNBaDvAJw5dGtYWp2rJKsi5FRwQA98y8txsR3JtJy9zDrI/4
 1MP+iZYc1va7caS75BU0YHNb5H6cxpJ4GFjp+E+cz7kBj5LApByiO86ywI/Gx2ypoXmG
 vR0Q==
X-Gm-Message-State: APjAAAW7t/W9jHwvXsVIKhddC1prBw3HZoE7gpxV9V15H2eEJlKDP3Nz
 4gcSVv88/AWyBfLut8RRw/bG3PoRDLze9PwG55ge7g==
X-Google-Smtp-Source: APXvYqx6jOFX7fXCIJg5d/gIYJoyJfFp3ZfHehGFXu/BR8JFH7cmkd7yHm4HprgiS1eZRLbMzoLdRM8tuKAakqpk0Ec=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr3740741wme.127.1573060854806; 
 Wed, 06 Nov 2019 09:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
In-Reply-To: <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2019 12:20:42 -0500
Message-ID:
 <CADnq5_O2wgq6YDXJXZizSKKmAbLDxRkQaSwAjofTS3pbTiPc2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix struct init in
 renoir_print_clk_levels
To: Raul E Rangel <rrangel@chromium.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=7nuh17+p/kI43xREuVK4a8I5e5bWCvbJIdUjydClras=;
 b=o56I/jzCa8/bEoQvRfq4lSeT8qmsNY/l0dcc2aI3FNmTf9hmwoCuWZ/vix05OTsLha
 tsR4LF1FtDIeF8UDrXExHTDXiYr1eJMCklPMfaHnw8UQU59HONBopeSAITZ0iOzQSrfF
 MIRWZ5G8cNEItuSag3Uyc3RgqJFYyV8p+5fBzAd6w+dLKzAJY3+15DIyi34CM22O2ckW
 Tk4wXpfpPOu6kRvr0iZxuarK0qxkwbQ5GCIqKoMXAk5F59pQCQRrdYiPs9250DX4geNH
 gK9mKntVVdu04sFuMHjNh6qPysr7+AubRBLJ2UIhToGvM3O9v5atbbqfdMJW3IOF1+rg
 Iwrw==
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Rex Zhu <rex.zhu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106172042.Dq6iK8GuzoZkxZKLdLFJJOtB-6N1gG-UdBnOm1vuQ8A@z>

T24gVHVlLCBOb3YgNSwgMjAxOSBhdCA2OjEwIFBNIFJhdWwgRSBSYW5nZWwgPHJyYW5nZWxAY2hy
b21pdW0ub3JnPiB3cm90ZToKPgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9p
cl9wcHQuYzoxODY6MjogZXJyb3I6IG1pc3NpbmcgYnJhY2VzCj4gYXJvdW5kIGluaXRpYWxpemVy
IFstV2Vycm9yPW1pc3NpbmctYnJhY2VzXQo+ICAgU211TWV0cmljc190IG1ldHJpY3MgPSB7MH07
Cj4gICAgIF4KPgo+IEZpeGVzOiA4YjgwMzE3MDNiZDcgKCJkcm0vYW1kL3Bvd2VycGxheTogaW1w
bGVtZW50IHN5c2ZzIGZvciBnZXR0aW5nIGRwbSBjbG9jayIpCj4KPiBTaWduZWQtb2ZmLWJ5OiBS
YXVsIEUgUmFuZ2VsIDxycmFuZ2VsQGNocm9taXVtLm9yZz4KCkFwcGxpZWQuICB0aGFua3MhCgpB
bGV4Cgo+IC0tLQo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQu
YyB8IDQgKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2ly
X3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCj4gaW5k
ZXggZTYyYmZiYTUxNTYyLi5lNTI4M2RhZmM0MTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCj4gQEAgLTE4MywxMSArMTgzLDEzIEBAIHN0YXRpYyBp
bnQgcmVub2lyX3ByaW50X2Nsa19sZXZlbHMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCj4gICAg
ICAgICBpbnQgaSwgc2l6ZSA9IDAsIHJldCA9IDA7Cj4gICAgICAgICB1aW50MzJfdCBjdXJfdmFs
dWUgPSAwLCB2YWx1ZSA9IDAsIGNvdW50ID0gMCwgbWluID0gMCwgbWF4ID0gMDsKPiAgICAgICAg
IERwbUNsb2Nrc190ICpjbGtfdGFibGUgPSBzbXUtPnNtdV90YWJsZS5jbG9ja3NfdGFibGU7Cj4g
LSAgICAgICBTbXVNZXRyaWNzX3QgbWV0cmljcyA9IHswfTsKPiArICAgICAgIFNtdU1ldHJpY3Nf
dCBtZXRyaWNzOwo+Cj4gICAgICAgICBpZiAoIWNsa190YWJsZSB8fCBjbGtfdHlwZSA+PSBTTVVf
Q0xLX0NPVU5UKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPgo+ICsgICAgICAg
bWVtc2V0KCZtZXRyaWNzLCAwLCBzaXplb2YobWV0cmljcykpOwo+ICsKPiAgICAgICAgIHJldCA9
IHNtdV91cGRhdGVfdGFibGUoc211LCBTTVVfVEFCTEVfU01VX01FVFJJQ1MsIDAsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICh2b2lkICopJm1ldHJpY3MsIGZhbHNlKTsKPiAgICAg
ICAgIGlmIChyZXQpCj4gLS0KPiAyLjI0LjAucmMxLjM2My5nYjFiY2NkM2UzZC1nb29nCj4KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
