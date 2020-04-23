Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C7FC55191
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 19:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D8B20728
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLpFWA4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D8B20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3536E9B8;
	Thu, 23 Apr 2020 19:48:14 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1271F6E9B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 19:48:13 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id x4so7875313wmj.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5ncK8mUbyQRJAXUcfcK2gNTh5SvopNuWEHUfvAJCpqQ=;
 b=bLpFWA4UYiAXFPphnI/drIN1GwdP+PEY+aec498WCbdFB9Ne3A4nBaX9MlF7nbRoOD
 NQWeJBbTwPuUetdriRD5FVQxoydlmXUSogrxI2olZl1r1hNdmhYzBJMUbQhZRrl0AqhZ
 pBlB6OBNnfnYhmhnMRVYqdtfKcuw0FAtdXD+vu6jJKz95f4fjmNVnCGnZPa7m6qDVSan
 XYi+IkCgG05zXC5RxIim/hLhYu+S36nvMKzzQt6GwAtP1XeC8I2Jzz3h2oSPEBTbHuFH
 In58Q0h7zIYXJhcwh3on5KFxsp5y9f9uLy/hj07KPFeVIVO27UZ7tuckosfWzIIdA6qn
 lH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5ncK8mUbyQRJAXUcfcK2gNTh5SvopNuWEHUfvAJCpqQ=;
 b=l4UMklBIrPc23fdTSpyMM9xYqoyfrG35iaOUC+T5SZPYjp5itblp4muKcmwK4RVaGe
 9qdhij/loJlSLA8lRT8Qyga3nWYgIuaETYleA8r2r7UfwjOQhgk6yBoQrm8K8m6Whf8E
 pUqTuHa/lg0VJPMxbarvXrn4zhkLQfeIo53g/7OYKmcU7SxQVfQYmJNdDujeSYLKSLkg
 HMMPg+GpQStOdAvgu8gDHA2q1ZS1S97G62Bmaxmk3va8/cvF27PpZOs9sCwD1fiFd+J1
 c+maAi8zHg50zOrmGZJu5q7kt1foJeD68EdqDs7gFnHuigblBgz7MyQq16XiW5GDlHP+
 UCjg==
X-Gm-Message-State: AGi0PubDnTjzrF4z1xsLRiTr1vQikWoS2wC2fVQUGDB5mrUUuBhODi/h
 Yljx37TCaFH5N6hfWo3rKE/h8B+hQuXkasVKlG2qdg==
X-Google-Smtp-Source: APiQypIo30/rnrgZYuT/Tf+RXaR19Cm3vwGRTbmj5gfurnmQ8Zg2HvKWZPcYoToYWwl3qtHjzG59O7ZaPt9TgQN0bok=
X-Received: by 2002:adf:f844:: with SMTP id d4mr6608940wrq.362.1587671291493; 
 Thu, 23 Apr 2020 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200406194201.846411-1-alexander.deucher@amd.com>
In-Reply-To: <20200406194201.846411-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Apr 2020 15:48:00 -0400
Message-ID: <CADnq5_PHrTJK7+p6CuiDxt=LVF636DukpHk5FxjK4ASZFPPG+g@mail.gmail.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add additional AMD ZEN root ports to the
 whitelist
To: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KyBCam9ybgoKQ2FuIGNoYW5jZSBJIGNhbiBnZXQgdGhpcyBwaWNrZWQgdXAgZm9yIC1uZXh0PwoK
VGhhbmtzLAoKQWxleAoKT24gTW9uLCBBcHIgNiwgMjAyMCBhdCAzOjQyIFBNIEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPgo+IEFjY29yZGluZyB0byB0aGUgaHcg
YXJjaGl0ZWN0LCBwcmUtWkVOIHBhcnRzIHN1cHBvcnQKPiBwMnAgd3JpdGVzIGFuZCBaRU4gcGFy
dHMgc3VwcG9ydCBib3RoIHAycCByZWFkcyBhbmQgd3JpdGVzLgo+Cj4gQWRkIGVudHJpZXMgZm9y
IFplbiBwYXJ0cyBSYXZlbiAoMHgxNWQwKSBhbmQgUmVub2lyICgweDE2MzApLgo+Cj4gQ2M6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBBY2tlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9wY2kvcDJwZG1hLmMgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wMnBkbWEuYyBiL2RyaXZlcnMvcGNpL3AycGRt
YS5jCj4gaW5kZXggOWE4YTM4Mzg0MTIxLi45MWE0Yzk4NzM5OWQgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9wY2kvcDJwZG1hLmMKPiArKysgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYwo+IEBAIC0yODIs
NiArMjgyLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfcDJwZG1hX3doaXRlbGlzdF9lbnRy
eSB7Cj4gIH0gcGNpX3AycGRtYV93aGl0ZWxpc3RbXSA9IHsKPiAgICAgICAgIC8qIEFNRCBaRU4g
Ki8KPiAgICAgICAgIHtQQ0lfVkVORE9SX0lEX0FNRCwgICAgIDB4MTQ1MCwgMH0sCj4gKyAgICAg
ICB7UENJX1ZFTkRPUl9JRF9BTUQsICAgICAweDE1ZDAsIDB9LAo+ICsgICAgICAge1BDSV9WRU5E
T1JfSURfQU1ELCAgICAgMHgxNjMwLCAwfSwKPgo+ICAgICAgICAgLyogSW50ZWwgWGVvbiBFNS9D
b3JlIGk3ICovCj4gICAgICAgICB7UENJX1ZFTkRPUl9JRF9JTlRFTCwgICAweDNjMDAsIFJFUV9T
QU1FX0hPU1RfQlJJREdFfSwKPiAtLQo+IDIuMjUuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
