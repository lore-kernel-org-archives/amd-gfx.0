Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F109C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534462065D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrb6zY6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534462065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A606E2C7;
	Tue, 21 Jul 2020 17:16:35 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C8D6E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 17:16:34 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a6so2628912wmm.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BfHQlIK6LGajQkbhQPI2QvftF8dSjjIx6VMXG6l3e80=;
 b=rrb6zY6fFLd835feZrdMo6aYPgCmLvklDhqTEN6kiYolHX4qrA5IPBOD634JTlGeNx
 oFiv35NMRLUomfUmAy72YYLzMM4SWy0WZ+AFjnxBVoEHv/r16G/i/zz/PStrMMiGBzAH
 TNC0UbY200geTBIeG1Pizgtd0R/aimAihDSa4GBzqzwH+4jViUmcAu5vijUaOS8VywTC
 Jxho0KBrsMyIOMXPdUrmCi3wvdo0L/sTQJ0oxLDrXt5/xbaXiZaoPkaFbCcRyR6CGsFS
 aLFQOzG9JTF5oKwE2CEWToTYJBtR2cp0JnkwlEgpVaNNAEJna8Z77WNXXucqX7o1Kdhh
 2aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BfHQlIK6LGajQkbhQPI2QvftF8dSjjIx6VMXG6l3e80=;
 b=K3Mrk25bhWoAdWZbKXyJr850VaGAhhfAVPy2+xhKPHMVoYc3dnTUqAQkVUVRgymxbz
 z7KNwVjIDvf1M7AZ2fsM/ZiOcvBUXUAYd2/9JRBjiQ+NJFeeFkaj+85a0+p3nFs+tI6L
 rk7q6hbmHvt8DeIUSUNLOo5VLfl9WHFQ6b3M5veY/MUyziHiOAb4FASMRtqZ3pBwv2Wi
 c0yA/3TYW8XkA9us9rD5CdH9O4PLHAZ4QxPQuo5UiwnY95yzlpJflvrq7HYeHi+Ucu7V
 Qi0G4l1E6KWbhbmxGjnSiUr+UroJ5iZbrNc7LmeZuqHBhm/ilyGBje3xfDCdSLAhzn4E
 5g4w==
X-Gm-Message-State: AOAM531iUIlFj3usO0FLEg9DxUyxgY+2oiQLKRRnSYMU4H/rdZ6svTYY
 SC7fjtW0QvFDgjStR/NU8TStATXwNllPM8cSkxmo3A==
X-Google-Smtp-Source: ABdhPJxsJR1qNPY53SRwIxxb0Mmrwwy+ZbHIMGjTiBGx5hgDPfig8tfDU9m1XCAyzQb+dkDJErROYkpfZ+Io+xeBH+k=
X-Received: by 2002:a1c:2:: with SMTP id 2mr5059332wma.79.1595351792797; Tue,
 21 Jul 2020 10:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200719155453.GA16077@tower>
In-Reply-To: <20200719155453.GA16077@tower>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jul 2020 13:16:21 -0400
Message-ID: <CADnq5_NjLgOyFn5YqgvW7Pft3pk76795hgtL8LHN76tsiFMkHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL dereference in dpm sysfs handlers
To: =?UTF-8?Q?Pawe=C5=82_Gronowski?= <me@woland.xyz>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFN1biwgSnVsIDE5LCAyMDIwIGF0IDEyOjIyIFBN
IFBhd2XFgiBHcm9ub3dza2kgPG1lQHdvbGFuZC54eXo+IHdyb3RlOgo+Cj4gTlVMTCBkZXJlZmVy
ZW5jZSBvY2N1cnMgd2hlbiBzdHJpbmcgdGhhdCBpcyBub3QgZW5kZWQgd2l0aCBzcGFjZSBvcgo+
IG5ld2xpbmUgaXMgd3JpdHRlbiB0byBzb21lIGRwbSBzeXNmcyBpbnRlcmZhY2UgKGZvciBleGFt
cGxlIHBwX2RwbV9zY2xrKS4KPiBUaGlzIGhhcHBlbnMgYmVjYXVzZSBzdHJzZXAgcmVwbGFjZXMg
dGhlIHRtcCB3aXRoIE5VTEwgaWYgdGhlIGRlbGltaXRlcgo+IGlzIG5vdCBwcmVzZW50IGluIHN0
cmluZywgd2hpY2ggaXMgdGhlbiBkZXJlZmVyZW5jZWQgYnkgdG1wWzBdLgo+Cj4gUmVwcm9kdWN0
aW9uIGV4YW1wbGU6Cj4gc3VkbyBzaCAtYyAnZWNobyAtbiAxID4gL3N5cy9jbGFzcy9kcm0vY2Fy
ZDAvZGV2aWNlL3BwX2RwbV9zY2xrJwo+Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIEdyb25vd3Nr
aSA8bWVAd29sYW5kLnh5ej4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BtLmMgfCA5ICsrKy0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMK
PiBpbmRleCAwMmU2ZjhjNGRkZTAuLmViYjhhMjhmZjAwMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4gQEAgLTc3OCw4ICs3NzgsNyBAQCBzdGF0aWMgc3NpemVf
dCBhbWRncHVfc2V0X3BwX29kX2Nsa192b2x0YWdlKHN0cnVjdCBkZXZpY2UgKmRldiwKPiAgICAg
ICAgICAgICAgICAgdG1wX3N0cisrOwo+ICAgICAgICAgd2hpbGUgKGlzc3BhY2UoKisrdG1wX3N0
cikpOwo+Cj4gLSAgICAgICB3aGlsZSAodG1wX3N0clswXSkgewo+IC0gICAgICAgICAgICAgICBz
dWJfc3RyID0gc3Ryc2VwKCZ0bXBfc3RyLCBkZWxpbWl0ZXIpOwo+ICsgICAgICAgd2hpbGUgKChz
dWJfc3RyID0gc3Ryc2VwKCZ0bXBfc3RyLCBkZWxpbWl0ZXIpKSAhPSBOVUxMKSB7Cj4gICAgICAg
ICAgICAgICAgIHJldCA9IGtzdHJ0b2woc3ViX3N0ciwgMCwgJnBhcmFtZXRlcltwYXJhbWV0ZXJf
c2l6ZV0pOwo+ICAgICAgICAgICAgICAgICBpZiAocmV0KQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOwo+IEBAIC0xMDM5LDggKzEwMzgsNyBAQCBzdGF0aWMgc3NpemVf
dCBhbWRncHVfcmVhZF9tYXNrKGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCB1aW50MzJf
dCAqbWFzaykKPiAgICAgICAgIG1lbWNweShidWZfY3B5LCBidWYsIGJ5dGVzKTsKPiAgICAgICAg
IGJ1Zl9jcHlbYnl0ZXNdID0gJ1wwJzsKPiAgICAgICAgIHRtcCA9IGJ1Zl9jcHk7Cj4gLSAgICAg
ICB3aGlsZSAodG1wWzBdKSB7Cj4gLSAgICAgICAgICAgICAgIHN1Yl9zdHIgPSBzdHJzZXAoJnRt
cCwgZGVsaW1pdGVyKTsKPiArICAgICAgIHdoaWxlICgoc3ViX3N0ciA9IHN0cnNlcCgmdG1wLCBk
ZWxpbWl0ZXIpKSAhPSBOVUxMKSB7Cj4gICAgICAgICAgICAgICAgIGlmIChzdHJsZW4oc3ViX3N0
cikpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBrc3RydG9sKHN1Yl9zdHIsIDAs
ICZsZXZlbCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkKPiBAQCAtMTYzNyw4
ICsxNjM1LDcgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X3NldF9wcF9wb3dlcl9wcm9maWxlX21v
ZGUoc3RydWN0IGRldmljZSAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGkrKzsKPiAg
ICAgICAgICAgICAgICAgbWVtY3B5KGJ1Zl9jcHksIGJ1ZiwgY291bnQtaSk7Cj4gICAgICAgICAg
ICAgICAgIHRtcF9zdHIgPSBidWZfY3B5Owo+IC0gICAgICAgICAgICAgICB3aGlsZSAodG1wX3N0
clswXSkgewo+IC0gICAgICAgICAgICAgICAgICAgICAgIHN1Yl9zdHIgPSBzdHJzZXAoJnRtcF9z
dHIsIGRlbGltaXRlcik7Cj4gKyAgICAgICAgICAgICAgIHdoaWxlICgoc3ViX3N0ciA9IHN0cnNl
cCgmdG1wX3N0ciwgZGVsaW1pdGVyKSkgIT0gTlVMTCkgewo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldCA9IGtzdHJ0b2woc3ViX3N0ciwgMCwgJnBhcmFtZXRlcltwYXJhbWV0ZXJfc2l6ZV0p
Owo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
