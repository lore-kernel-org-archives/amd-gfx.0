Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB875C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1579613C9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1579613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48726EDFF;
	Thu, 27 May 2021 03:49:37 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FB36EDFB;
 Thu, 27 May 2021 03:49:36 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id v22so3812189oic.2;
 Wed, 26 May 2021 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DX5LZ59j/U95L+mNk2w46JLq9y9MxosdgzOg6i0ZZ6E=;
 b=u8DB9ze/Jw3EU/Y4+kWrZQ6Cw2+PcWjxFCoDTqyt4TeM+BZFS+KrGfLZhaEBSCoXpl
 dbTbZeMaDXuKOHyGSU0lPjSHx2ndTerJYw44ctn2yUTQaIfyXZB5TJwBjJth9OqkAEV6
 x83RO7YGxNxPM/MaGdoq2HGnCY7nfNSzu9g1OahvUbuq5DRf4t1PJ6pebrxZ8TzsIms5
 qKG9MaTmsOH59Nsk07lS+oksXQZ+1tdCjsbJoz63DHEUGIvQ2XXrTu2wor6Z3rjKLhL2
 Twidj3FMOFJDlN43g/in2ikXjQo8WuW0AqC3nRnZ9OfrD9xn8oUMtfr19h62A7pbta5S
 hHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DX5LZ59j/U95L+mNk2w46JLq9y9MxosdgzOg6i0ZZ6E=;
 b=i/ycqoIn+PsNG+0i8KOyGrsbf8G/THYm9f/6Pw2Jr14Qc/zqTC3V95XLYW5pI55I23
 uOJ7R8/Y3j9UdpfNutAo8Nie+heZ6/HUwOh/6wKJ3pmyX8Uy7FyL757nQahCgU9QGj18
 Saide1Fs26+gW6BSNpOAhhMbUC/UnknJPYOAeF3ZMo4IKbrBluu/ocYligYl0Noxsm19
 1ddeap91YpytWMy5d3LlcJIirFoBN2JG1klrntTu/vfpHw/WpHyT0nMBYBmQUtGaG53I
 jxK/y8hqtfIYgDiKcQuECn8MdOx4qN16iZW6DEIimX/qln9vLzDLh2ndl9xYYJBUBQ1u
 XOPA==
X-Gm-Message-State: AOAM532dghwu8ZaPsSZ5ydgeZzPV/Eanh9Qy0Pl3dSD+4ej290cGa8wS
 cmXSljm8DPoyw7+nllSRv/u61b0o2eb8tY2xmjk=
X-Google-Smtp-Source: ABdhPJw0QDyylvjNLg3lab3rvIBcqi4+H2nhMuvkGY8U8GQq5XqOtT75RF0uJDw4uQ0NCdsuXqZO/VBBrP1e7C1e4Yk=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr1011124oie.120.1622087375887; 
 Wed, 26 May 2021 20:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-3-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-3-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:49:25 -0400
Message-ID: <CADnq5_OFMz2tCCCwXbQ-sj+zOyp2GGNLDCkVADXaRo=GJ1wOTg@mail.gmail.com>
Subject: Re: [PATCH 02/34] drm/amd/pm/swsmu/smu13/aldebaran_ppt: Remove unused
 variable 'ret'
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBzaG91bGQgYmUgY2hlY2tlZC4gIFdpbGwgc2VuZCBvdXQgYSBwYXRjaCBtb21lbnRhcmls
eS4KClRoYW5rcywKCkFsZXgKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDcgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmM6IEluIGZ1bmN0aW9uIOKAmGFs
ZGViYXJhbl9pc19kcG1fcnVubmluZ+KAmToKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jOjEyNjA6Njogd2FybmluZzogdmFyaWFi
bGUg4oCYcmV04oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVd
Cj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAi
Q2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQg
QWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3
bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTEzL2FsZGViYXJhbl9wcHQuYyB8IDMgKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jCj4gaW5kZXggZDZjZTY2NWJhYWYzYi4uZDA3N2Uy
MTEwMTdhOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L2FsZGViYXJhbl9wcHQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTMvYWxkZWJhcmFuX3BwdC5jCj4gQEAgLTEzNjgsMTAgKzEzNjgsOSBAQCBzdGF0aWMgaW50IGFs
ZGViYXJhbl91c3JfZWRpdF9kcG1fdGFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGVudW0g
UFBfT0RfRFBNXwo+Cj4gIHN0YXRpYyBib29sIGFsZGViYXJhbl9pc19kcG1fcnVubmluZyhzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSkKPiAgewo+IC0gICAgICAgaW50IHJldCA9IDA7Cj4gICAgICAg
ICB1aW50MzJfdCBmZWF0dXJlX21hc2tbMl07Cj4gICAgICAgICB1bnNpZ25lZCBsb25nIGZlYXR1
cmVfZW5hYmxlZDsKPiAtICAgICAgIHJldCA9IHNtdV9jbW5fZ2V0X2VuYWJsZWRfbWFzayhzbXUs
IGZlYXR1cmVfbWFzaywgMik7Cj4gKyAgICAgICBzbXVfY21uX2dldF9lbmFibGVkX21hc2soc211
LCBmZWF0dXJlX21hc2ssIDIpOwo+ICAgICAgICAgZmVhdHVyZV9lbmFibGVkID0gKHVuc2lnbmVk
IGxvbmcpKCh1aW50NjRfdClmZWF0dXJlX21hc2tbMF0gfAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICgodWludDY0X3QpZmVhdHVyZV9tYXNrWzFdIDw8IDMyKSk7
Cj4gICAgICAgICByZXR1cm4gISEoZmVhdHVyZV9lbmFibGVkICYgU01DX0RQTV9GRUFUVVJFKTsK
PiAtLQo+IDIuMzEuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
