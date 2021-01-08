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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB607C433E9
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884EB23AC1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884EB23AC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0362F6E8CA;
	Fri,  8 Jan 2021 20:30:52 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02F16E8CA;
 Fri,  8 Jan 2021 20:30:50 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id x13so10906899oto.8;
 Fri, 08 Jan 2021 12:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8rX5uQHouoI4FRLqYNMC44Y4GpGcbHM8bJ4cljG7WHw=;
 b=VxZNWixJ9jeyM+bRpStXCk4K+N3m4Y9Ybu9ZCvuqS+CqhTWY1XWogyftNuSMgnEt90
 ZWXsoD5HgCuGbbR8yxZJm4DvSQUw17tQ6O0QsVdUjg45cjKPEYUpH1FCcejSkq6ORIYn
 XAcAM/S0kVwh7zsTDEr8rAQB1UU1psvDMPg7jCpp5DSEHM2hpkMDDVQB/PW98ZIWMbr3
 x67+sermSbPEUWP8Ar+zVI9n2jXRI9ynkgBaIV+S/4Y/Z7YxTxIg48Oxwai3JoCgj9Fm
 ZUrwzATMTbL/qZ5Va1HBYi6CQAw6oGXcMbPgp9o4dnLqEELRyvGE4WLSrUCDARalPWOW
 eIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8rX5uQHouoI4FRLqYNMC44Y4GpGcbHM8bJ4cljG7WHw=;
 b=Mviyh28dYA8hPpCglQvTB7wJJdGYWbgPQHY57Gq3thw4Om3y1jwxacYGp3g0EedcNV
 1kxHESELvHY/NiTkHEz9cDrJmVMUZi/1H9lk9rfpUQwnUadxk7UikF2mxPa192Ivjd4n
 0U0gSJwUS4W5fUv4KmXfzzHz+9rQDcMXY+3EjKKK3Nqjgdp93v2C98Lra4++85//tpcX
 EuZIpzk63cWYL/cNGQDMQ6k4AMeuy3Zb7+WYYR5RrGt0XvJ1SJ7xAScYinfwV+sBg2Xa
 KZWO8UWqxuI952/tu0EiXbCeLhV3Ar/uBs3ZcLKbE+xxBfidoSNDH72EsiSiHAbaWT5n
 TZTg==
X-Gm-Message-State: AOAM533di78QOOg9vQ6C9MBAL7U0xRURu8wd0KhnmBbHzoi7qbwCXc7L
 kFIQzNzrSBfbiJ84o6qBAXGBqkV9oe+Kr+YpvH4=
X-Google-Smtp-Source: ABdhPJz7Zw0UXJkV9YhbqEzt+3/lMNn51AX5yaKpxgYs2S9iN5GxGCnckdi3xe1/x6OJGrPsnJjXsOH6rXR/u32R+7A=
X-Received: by 2002:a05:6830:1d66:: with SMTP id
 l6mr3782098oti.23.1610137850323; 
 Fri, 08 Jan 2021 12:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org>
 <20210108201457.3078600-5-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-5-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 15:30:38 -0500
Message-ID: <CADnq5_M7R1rhP73iUWg+mcOTm_n+j8h2nh0ykLRUVda2xmNvMA@mail.gmail.com>
Subject: Re: [PATCH 04/40] drm/amd/amdgpu/amdgpu_ih: Update
 'amdgpu_ih_decode_iv_helper()'s function header
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAzOjE1IFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmM6MjIw
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJl
ZCBpbiAnYW1kZ3B1X2loX2RlY29kZV9pdl9oZWxwZXInCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9paC5jOjIyMDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1l
bWJlciAnZW50cnknIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9paF9kZWNvZGVfaXZfaGVscGVy
Jwo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlk
IEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZm
d2xsLmNoPgo+IENjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2loLmMgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jCj4gaW5kZXgg
NzI1YTljNzNkNTFmMC4uZGM4NTJhZjRmM2I3NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9paC5jCj4gQEAgLTIwOSw2ICsyMDksOCBAQCBpbnQgYW1kZ3B1X2loX3Byb2Nl
c3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgp
Cj4gICAqIGFtZGdwdV9paF9kZWNvZGVfaXZfaGVscGVyIC0gZGVjb2RlIGFuIGludGVycnVwdCB2
ZWN0b3IKPiAgICoKPiAgICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgo+ICsgKiBAaWg6
IGloIHJpbmcgdG8gcHJvY2Vzcwo+ICsgKiBAZW50cnk6IElWIGVudHJ5Cj4gICAqCj4gICAqIERl
Y29kZXMgdGhlIGludGVycnVwdCB2ZWN0b3IgYXQgdGhlIGN1cnJlbnQgcnB0cgo+ICAgKiBwb3Np
dGlvbiBhbmQgYWxzbyBhZHZhbmNlIHRoZSBwb3NpdGlvbiBmb3IgZm9yIFZlZ2ExMAo+IC0tCj4g
Mi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
