Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFACC5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D34218AE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D34218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674D36E25A;
	Wed,  6 Nov 2019 17:15:45 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576F46E255;
 Wed,  6 Nov 2019 17:15:43 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id z19so4328581wmk.3;
 Wed, 06 Nov 2019 09:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FqojnfYcPbpr6KlP+Ft2/Gak6vptdJZ9xOr44jOMXnA=;
 b=P8850SIuiuIUavkgldmLYpC22RyW4JZWAheLK/emnHsIOOn+zR6lwwif4F0I4N7lMd
 R9N/fyAN2cNidGRkj5+Irr1Uqe7/o3tAFgunV6Hg/7qwLuUA5CShTQJAJk59x7nL1EC1
 AI6EuNecs+I/8siCdcRwJ+uR2CoxuNBxHbX2Ens39SuIl8W9gg2+lJMTN6BsVd5jzdcV
 MKHfHPs5g1ZMj4GHbzNjhFu6yJR0HCDRQsKjMqsVy5I6QhOwDaaQU9PulYt4rCFtoVHx
 8CNb1kHNvSgyynNi+CAKta0DFQe1RjJYBu1ncwS8NI0lPFLHUQW5KrNZznGbZejA1d1U
 wVwQ==
X-Gm-Message-State: APjAAAWN6rYfVNmrKN8clr0C1Ds6pI/nNpBm9itTuDTR7rb5yeIxib3O
 AFEfmT/Ebvr0ufdwCoXnMe69PkY0Ze4DbpZvWas=
X-Google-Smtp-Source: APXvYqxjPjEx3asqTpjp4vKsp2+A7S51N7f18TYCVywGXqWdqcC5r2midJFtjkDsHCgtr+/qe5CInKwpDXjoLN9dJy8=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr3718261wme.127.1573060541884; 
 Wed, 06 Nov 2019 09:15:41 -0800 (PST)
MIME-Version: 1.0
References: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
 <1572874046-30996-8-git-send-email-yukuai3@huawei.com>
In-Reply-To: <1572874046-30996-8-git-send-email-yukuai3@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2019 12:15:30 -0500
Message-ID:
 <CADnq5_MjhnBA-mUwPgdHRuit+=CgZjs0HC+JHqeD_gmciaONFQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amdgpu: remove set but not used variable
 'mc_shared_chmap'
To: yu kuai <yukuai3@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FqojnfYcPbpr6KlP+Ft2/Gak6vptdJZ9xOr44jOMXnA=;
 b=tMxNIDvAAP/3hNNmYb9dR65I23CNeDHFutYeUIj9UPBedZMtQzp3pYv5OUT+TvGVXK
 +be5HiG0r/qx+rEtzAVw+mNotoUdTmkLyldiFaLeag1CMBNl89KjljTBm2Kbv43R+IF1
 ljyerVW6mBUC5F/3GrLuHyBxjdl/oaEtJLseE5zDbssgIGmn18VnhADXluty/a/s6NNQ
 7hqapMvw//uieaJYjRfPZSG4Istnz/3w91Oj2cNmPemFqjzyOpnuWw3j8PSR+m+DNoMI
 hCwPvrK1VPwcOtfNx2lYJr9yuIm7nvhMNiM2KDL256WYI/HiqsNe8R2XrGj3QIkrLLgc
 ZaKA==
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, "Zhou, Jammy" <Jammy.Zhou@amd.com>,
 Dave Airlie <airlied@linux.ie>, yi.zhang@huawei.com,
 tiancyin <tianci.yin@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 zhengbin <zhengbin13@huawei.com>, "Tuikov, Luben" <luben.tuikov@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Sam Ravnborg <sam@ravnborg.org>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106171530.JfzI311T-zpaDrOCFBDm3T5qYSeDCC57MbY64Xzq2qY@z>

T24gTW9uLCBOb3YgNCwgMjAxOSBhdCA4OjU0IEFNIHl1IGt1YWkgPHl1a3VhaTNAaHVhd2VpLmNv
bT4gd3JvdGU6Cj4KPiBGaXhlcyBnY2MgJy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5p
bmc6Cj4KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jOiBJbiBmdW5jdGlv
bgo+IOKAmGdmeF92OF8wX2dwdV9lYXJseV9pbml04oCZOgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OF8wLmM6MTcxMzo2OiB3YXJuaW5nOiB2YXJpYWJsZQo+IOKAmG1jX3NoYXJl
ZF9jaG1hcOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+
Cj4gRml4ZXM6IDBiZGUzYTk1ZWFhOSAoImRybS9hbWRncHU6IHNwbGl0IGdmeDggZ3B1IGluaXQg
aW50byBzdyBhbmQgaHcgcGFydHMiKQo+IFNpZ25lZC1vZmYtYnk6IHl1IGt1YWkgPHl1a3VhaTNA
aHVhd2VpLmNvbT4KCkxvb2tzIGxpa2UgZ2Z4X3Y3XzAuYyBhbmQgZ2Z4X3Y2XzAuYyBjb3VsZCBo
YXZlIHRoZSBzYW1lIHRyZWF0bWVudC4KQ2FyZSB0byBzZW5kIHBhdGNoZXM/CgpBcHBsaWVkIHRo
ZSBzZXJpZXMuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjhfMC5jIHwgMyArLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4g
aW5kZXggZTRjNjQ1ZC4uODBiNzk1OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjhfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y4XzAuYwo+IEBAIC0xNzEwLDcgKzE3MTAsNyBAQCBzdGF0aWMgaW50IGdmeF92OF8wX2RvX2Vk
Y19ncHJfd29ya2Fyb3VuZHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gIHN0YXRpYyBp
bnQgZ2Z4X3Y4XzBfZ3B1X2Vhcmx5X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4g
IHsKPiAgICAgICAgIHUzMiBnYl9hZGRyX2NvbmZpZzsKPiAtICAgICAgIHUzMiBtY19zaGFyZWRf
Y2htYXAsIG1jX2FyYl9yYW1jZmc7Cj4gKyAgICAgICB1MzIgbWNfYXJiX3JhbWNmZzsKPiAgICAg
ICAgIHUzMiBkaW1tMDBfYWRkcl9tYXAsIGRpbW0wMV9hZGRyX21hcCwgZGltbTEwX2FkZHJfbWFw
LCBkaW1tMTFfYWRkcl9tYXA7Cj4gICAgICAgICB1MzIgdG1wOwo+ICAgICAgICAgaW50IHJldDsK
PiBAQCAtMTg1MCw3ICsxODUwLDYgQEAgc3RhdGljIGludCBnZnhfdjhfMF9ncHVfZWFybHlfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4g
ICAgICAgICB9Cj4KPiAtICAgICAgIG1jX3NoYXJlZF9jaG1hcCA9IFJSRUczMihtbU1DX1NIQVJF
RF9DSE1BUCk7Cj4gICAgICAgICBhZGV2LT5nZnguY29uZmlnLm1jX2FyYl9yYW1jZmcgPSBSUkVH
MzIobW1NQ19BUkJfUkFNQ0ZHKTsKPiAgICAgICAgIG1jX2FyYl9yYW1jZmcgPSBhZGV2LT5nZngu
Y29uZmlnLm1jX2FyYl9yYW1jZmc7Cj4KPiAtLQo+IDIuNy40Cj4KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
