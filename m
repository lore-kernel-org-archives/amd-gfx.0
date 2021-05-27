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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27095C4708A
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA5D610CC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA5D610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9726EE0D;
	Thu, 27 May 2021 03:59:20 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18596E8BA;
 Thu, 27 May 2021 03:59:19 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 v19-20020a0568301413b0290304f00e3d88so3173564otp.4; 
 Wed, 26 May 2021 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GwO6hJTK9pMNiwOSyto0K/M7BIjvwe2kKr/NYGp3HmM=;
 b=fyrsG2+DIYTWujXjBGM4BV9gq0EDSmTSnTWiaPcjmz/R5tkMVNrDYRs4JBtcr3FAN7
 qY56UgKx7lo7AIKwadaHdjFDyI+Yqq4qNrcUVHMUaNY/NytUHe/gZEtCdieaD0ucEGLY
 iKg8/JcFyrM2DuTAbuacIk83HFxhxikO62ECTt9p6561AFo7qYtUSzqXZN3SufbjV3EB
 8jDxtnxyM1Bhteu5cHh+qZNDJ8TWmSSEs9cPUkNf1dXFCVORXKhQTZS/neSjgkj9L+Kj
 wQStrH0lKOpiNPn2LS4WrDLovPKyrk+9YmlvfA9EH0rLOeuTpV08+byU9QDhTV2uxGH9
 6qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GwO6hJTK9pMNiwOSyto0K/M7BIjvwe2kKr/NYGp3HmM=;
 b=sgnPqVvc7/5zEof9N2cB4Gu+tZ03xp0zLLT4SRbsTxKfthDi/cfcnZ+f2ARkhKdcDz
 A1X2nEEo8NbqDF2WwgLp4ghZqwW80eBYuAH+/Bk41PWALetuHGrm2GNWiy+IbLSrg9Vi
 DcJDb8pWp7NCizQy24svQBq+4yFemwQm2FkOMZm6q6IfgMq5zNjMOpFUw+6088UZoEbB
 FymlhUOyl7hUbHfz18qcwevwiUJR4bHVE1IbQpjxRCuQvOKx3XQ6rcOHVtW1DCSB7t53
 Z011xJqWGZqjxZlVTi+hUhPsPjUGWpN3yKFDW/44VQHLPuxrt5trRueUKLNEsbneC9da
 Bs1Q==
X-Gm-Message-State: AOAM531dmqZq1GO+4YIqdiFv75FiZW1IlJCSmF1c4BJHhs5OxTVNTPjI
 oBdp7sJZO2VHBU29whq6OtuUv+Yqu6NhrAJpWmg=
X-Google-Smtp-Source: ABdhPJyATqLeX4DjT0DHydcZY1XslJVIVgJQsHnV55ps2XsRxhAGo5OyUKoCOIt7xtwjLTxMvz62nA4/v7zSGdPQAn8=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1214250otl.311.1622087959271; 
 Wed, 26 May 2021 20:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-13-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-13-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:59:08 -0400
Message-ID: <CADnq5_N=O8-4POzw2_vviyKmNxKSREZwCAfiDxEhoPC-4x249Q@mail.gmail.com>
Subject: Re: [PATCH 12/34] drm/amd/display/amdgpu_dm/amdgpu_dm: Functions must
 directly follow their headers
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDcgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYzo2MDg6IHdhcm5pbmc6IEZ1bmN0
aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2ludGVycnVwdF9wYXJhbXMnIG5vdCBkZXNjcmliZWQg
aW4gJ2RtX2Rjbl92ZXJ0aWNhbF9pbnRlcnJ1cHQwX2hpZ2hfaXJxJwo+Cj4gQ2M6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBMZW8gTGkgPHN1bnBlbmcubGlA
YW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IGI0ZTk1ZDNmZjNiODguLmFlMGE5
NWM1ZjFkOGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMKPiBAQCAtNjAxLDYgKzYwMSw3IEBAIHN0YXRpYyB2b2lkIGRtX2Ny
dGNfaGlnaF9pcnEodm9pZCAqaW50ZXJydXB0X3BhcmFtcykKPiAgfQo+Cj4gICNpZiBkZWZpbmVk
KENPTkZJR19EUk1fQU1EX0RDX0RDTikKPiArI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURfU0VD
VVJFX0RJU1BMQVkpCj4gIC8qKgo+ICAgKiBkbV9kY25fdmVydGljYWxfaW50ZXJydXB0MF9oaWdo
X2lycSgpIC0gSGFuZGxlcyBPVEcgVmVydGljYWwgaW50ZXJydXB0MCBmb3IKPiAgICogRENOIGdl
bmVyYXRpb24gQVNJQ3MKPiBAQCAtNjA4LDcgKzYwOSw2IEBAIHN0YXRpYyB2b2lkIGRtX2NydGNf
aGlnaF9pcnEodm9pZCAqaW50ZXJydXB0X3BhcmFtcykKPiAgICoKPiAgICogVXNlZCB0byBzZXQg
Y3JjIHdpbmRvdy9yZWFkIG91dCBjcmMgdmFsdWUgYXQgdmVydGljYWwgbGluZSAwIHBvc2l0aW9u
Cj4gICAqLwo+IC0jaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9TRUNVUkVfRElTUExBWSkKPiAg
c3RhdGljIHZvaWQgZG1fZGNuX3ZlcnRpY2FsX2ludGVycnVwdDBfaGlnaF9pcnEodm9pZCAqaW50
ZXJydXB0X3BhcmFtcykKPiAgewo+ICAgICAgICAgc3RydWN0IGNvbW1vbl9pcnFfcGFyYW1zICpp
cnFfcGFyYW1zID0gaW50ZXJydXB0X3BhcmFtczsKPiAtLQo+IDIuMzEuMQo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
