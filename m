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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19936C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A010C613C7
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A010C613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485626EE03;
	Thu, 27 May 2021 03:52:41 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108526EE00;
 Thu, 27 May 2021 03:52:40 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 v19-20020a0568301413b0290304f00e3d88so3162308otp.4; 
 Wed, 26 May 2021 20:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GMNN8zidej8CCx7epceEx2ySsZhlFSGB0Zr+V9xhpsE=;
 b=WQ51LN90zU6GGhJNh70xPboiDCxVvC0k64dOhSBqzbuqmTIQkgmACc4VQ5GwW4Se4z
 P/W1tAMTAiQuc/lV0vYTMOuxr+lq6YtLgXeHd1X+bpdb1QmsP0O8aU9u8opmJuxmPZVk
 fCHVDsIylgwUOb+pb+E4Y7RoCtT9c/xQ6aeBGU7DKQDwbZPdWm32zl+aNpEUzfE0YFsu
 R9iAh1YEPhE5lK6T1dqZcPoLHzHK67z/1QJ+hmriu9c4o9kDW5jpOqr9HKlwcQAhjhMb
 PCTQJU6lvh0to4U1UGg5qDu9PS2IoI3ooVD658khTIFNijds2dbBJ3atoa4PMRkhuVV6
 SzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GMNN8zidej8CCx7epceEx2ySsZhlFSGB0Zr+V9xhpsE=;
 b=tGnDEzuyDEB1Xbhme7b9VDTlRMd0KCNufHehju27OFYCy/zewRt3vbeX/WH9RFOYXq
 FKPM2qY1O+8NR//LDlNbWE5+5mACxquUyuETWD2HQX2NeAOMSIzutl56CbnCZIwlKpiu
 yhTFpSRrxv8W3r/41BNUmwIFK8uuEjf0MiUC3aZs/9rgc1mAHNA1iMj18KyYVfZH7Sxy
 H4N29incZuWsYhdYoPNu5dmJ/7c9r6Vx0QbmOBx7X6+dyCd+ljzAfGl8Y+d+bhsLsPjG
 DY01VFifxL3xP0J0+5cT5tfJItEJzRP+hhZWpjc3TE+Gx1Q8CPfGu/P1TesM3SOCKlQ/
 Fcag==
X-Gm-Message-State: AOAM533yn0nOv6RUJ9SdPNRPMy7OdNM1oTS+ARjGgciTzvN9n3DPLue4
 dI7I9Puk9qGpUx716l2mzfRAnBoKv2zVFOXbzhnRK1QU
X-Google-Smtp-Source: ABdhPJwejt1H97rNvX0CfGW0uyBD5BPQYzbjUvBiuVZWOTUQktXyL/vOFPR6r2TmKVdvNZPBu2gg5fAoui3ceq/p3ek=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1197817otl.311.1622087559482; 
 Wed, 26 May 2021 20:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-5-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-5-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:52:28 -0400
Message-ID: <CADnq5_Pm3rtKnmjGND7vs5eSNF5xEzT9FmfUsT81JmNW55mmcw@mail.gmail.com>
Subject: Re: [PATCH 04/34] drm/amd/pm/powerplay/hwmgr/vega12_thermal: Provide
 function name
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDcgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX3RoZXJtYWwuYzoxNzE6IHdhcm5pbmc6
IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIFNldCB0aGUgcmVxdWVzdGVkIHRlbXBlcmF0dXJlIHJh
bmdlIGZvciBoaWdoIGFuZCBsb3cgYWxlcnQgc2lnbmFscygpLiBQcm90b3R5cGUgd2FzIGZvciB2
ZWdhMTJfdGhlcm1hbF9zZXRfdGVtcGVyYXR1cmVfcmFuZ2UoKSBpbnN0ZWFkCj4KPiBDYzogRXZh
biBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBE
YW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQt
b2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTJfdGhlcm1hbC5jIHwgMyArKy0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl90
aGVybWFsLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTJf
dGhlcm1hbC5jCj4gaW5kZXggMGRjMTZmMjVhNDYzYi4uZWQzZGZmMGI1MmQyMSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTJfdGhlcm1h
bC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEy
X3RoZXJtYWwuYwo+IEBAIC0xNTksNyArMTU5LDggQEAgaW50IHZlZ2ExMl90aGVybWFsX2dldF90
ZW1wZXJhdHVyZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQo+ICB9Cj4KPiAgLyoqCj4gLSAqIFNl
dCB0aGUgcmVxdWVzdGVkIHRlbXBlcmF0dXJlIHJhbmdlIGZvciBoaWdoIGFuZCBsb3cgYWxlcnQg
c2lnbmFscwo+ICsgKiB2ZWdhMTJfdGhlcm1hbF9zZXRfdGVtcGVyYXR1cmVfcmFuZ2UgLSBTZXQg
dGhlIHJlcXVlc3RlZCB0ZW1wZXJhdHVyZSByYW5nZQo+ICsgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBmb3IgaGlnaCBhbmQgbG93IGFsZXJ0IHNpZ25hbHMKPiAgICoK
PiAgICogQGh3bWdyOiBUaGUgYWRkcmVzcyBvZiB0aGUgaGFyZHdhcmUgbWFuYWdlci4KPiAgICog
QHJhbmdlOiBUZW1wZXJhdHVyZSByYW5nZSB0byBiZSBwcm9ncmFtbWVkIGZvcgo+IC0tCj4gMi4z
MS4xCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
