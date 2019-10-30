Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F756CA9EC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4209B20856
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4209B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1004E6EC54;
	Wed, 30 Oct 2019 19:09:05 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAC56EC54;
 Wed, 30 Oct 2019 19:09:03 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id q70so3282428wme.1;
 Wed, 30 Oct 2019 12:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uYBiTBzZt5vgvU2mRqgnC6ae48T65098RS0JVybZs/s=;
 b=st4F4GWs4k2KWAWzPXNf23nI8rTBswopQQKH2YhSnUMSp+OKwVx+qIxF6UTPCfoQAb
 QB4b43kOfklxRJiLWlFJ4QiFQxD4Qmd1lF/nt0z0qCWfZHZ+kD3Uj7U9xVo8V/pevDRW
 1nLVp9lZiCM3r/7mu2TgcxshedLM10f2b/qZB3lMF5ZZxdLc7Cp+fy+jikWqOkX1kd+w
 i7SqyJpsEkvOTqBux8Yi+Xk1TtRutXs8CcBtvc4S25ml2U6tscepWaXJnPWkReyCwkUU
 OR8xE/r0+rWU44ooGVaB7RWFFreOZ3pGK7R+Bbh6e5Kd0KhLNmOzCLD+QbNq/iVVkSn+
 cM+Q==
X-Gm-Message-State: APjAAAVa5EYX+umohevT+wE47e6ddzFOmxrbOHF2/EWlEZGnp+G/4jFX
 yKLyqA6/SzxNIrXy+gA/BH/Vk2VZKKyBEPhEhvI=
X-Google-Smtp-Source: APXvYqy1ij+4I1Bx6v2W2ptYFfh5jfigzMHR682nMX26nuyY33Mtt7Jc4N/bGKLHG6e/DVfD8Vs0CkaXXBmohnUW7Fo=
X-Received: by 2002:a7b:c186:: with SMTP id y6mr1007516wmi.67.1572462542027;
 Wed, 30 Oct 2019 12:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
In-Reply-To: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Oct 2019 15:08:48 -0400
Message-ID:
 <CADnq5_PHHNYp-nfjsgRfeoaMEo+QeQD1-rtDpQhqdJeG7gMMVA@mail.gmail.com>
Subject: Re: [PATCH] Drivers: gpu: drm: amd: display: amdgpu_dm: amdgpu_dm.h:
 Fixed a documentation warning
To: madhuparnabhowmik04@gmail.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=uYBiTBzZt5vgvU2mRqgnC6ae48T65098RS0JVybZs/s=;
 b=fIzW0cTv0OFE3KRoEXVVCnS4mqtonyrpX0B+jtwNkLE6FwBeqvYhUZza2h9TZ9bYqm
 tApeumreXyquaAVj0spMTUCUbbtC4adInjw6t3uIkwEy5cqYX22vfmqdMH5yM5Xp/8d/
 UN0NjxNlKlITH3a6GMCP3oXtwqarO6elrP9kKtPrpXeVZcC3LeWo4/S+H8Wq9JXma9HF
 eRroFUJslrY+g0nEQuqEUoqwOX0GgYENRZ4AI/rMx+9JOgFhFhltl2uVHKnLKwK9xco4
 ZrHscJ5STKJmh4Ye7L/bVFv/u86tKFWYogN64nCMgAX2jw9iz0UAun6i6wcHuwyGcQ7F
 G7gg==
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030190848.a5_sKwcHFPpti2pHyMRTtYgNFxsL4GG0Fhl7x3En8lk@z>

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgNDoyNSBBTSA8bWFkaHVwYXJuYWJob3dtaWswNEBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gRnJvbTogTWFkaHVwYXJuYSBCaG93bWlrIDxtYWRodXBhcm5hYmhv
d21pazA0QGdtYWlsLmNvbT4KPgo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGZvbGxvd2luZyAgd2Fy
bmluZzogSW5jb3JyZWN0IHVzZSBvZgo+ICBrZXJuZWwtZG9jIGZvcm1hdDogICAgICAgICAgKiBA
YXRvbWljX29iago+IGJ5IGFkZGluZyBhIGNvbG9uIGFmdGVyIEBhdG9taWNfb2JqLgo+Cj4gU2ln
bmVkLW9mZi1ieTogTWFkaHVwYXJuYSBCaG93bWlrIDxtYWRodXBhcm5hYmhvd21pazA0QGdtYWls
LmNvbT4KClRoYW5rcyBmb3IgdGhlIHBhdGNoLiAgVGhpcyBhcyBhbHJlYWR5IGZpeGVkIGJ5IEhh
cnJ5LgoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uaCB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmgKPiBpbmRleCBjOGM1MjVhMmI1MDUuLjgwZDUzZDA5NTc3MyAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uaAo+IEBAIC0xMjgsNyArMTI4LDcgQEAgc3RydWN0IGFtZGdwdV9kaXNwbGF5X21hbmFnZXIg
ewo+ICAgICAgICAgdTE2IGRpc3BsYXlfaW5kZXhlc19udW07Cj4KPiAgICAgICAgIC8qKgo+IC0g
ICAgICAgICogQGF0b21pY19vYmoKPiArICAgICAgICAqIEBhdG9taWNfb2JqOgo+ICAgICAgICAg
ICoKPiAgICAgICAgICAqIEluIGNvbWJpbmF0aW9uIHdpdGggJmRtX2F0b21pY19zdGF0ZSBpdCBo
ZWxwcyBtYW5hZ2UKPiAgICAgICAgICAqIGdsb2JhbCBhdG9taWMgc3RhdGUgdGhhdCBkb2Vzbid0
IG1hcCBjbGVhbmx5IGludG8gZXhpc3RpbmcKPiAtLQo+IDIuMTcuMQo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
