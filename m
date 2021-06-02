Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602A2C47080
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 01:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD56610C8
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 01:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD56610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18AF6EB56;
	Wed,  2 Jun 2021 01:57:48 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B9B6EB45;
 Wed,  2 Jun 2021 01:57:46 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id h9so1265832oih.4;
 Tue, 01 Jun 2021 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SU3VNhIHP4qFfMS6BHdB+T/4wdfQUGXE54wCPeu58gQ=;
 b=QQO75cNDTpDKr0tOdLOk5vG9ysCKgZa/phRsAdD89jlR+TT9Wjgl3mHuc1yXOnZu9L
 xsRhHTI9U8g5BYgBihgDXw6SikyKy9uI+vcBR/0GRLeuZPZPL/sZ+Q8NyhCrFi6h/8Rq
 ZEOkfNeRAWeAfwfI/4mLVNOdfpqIvjsk/+BgiSUjprCSv3xhbHyQZJvd23gxCfFk6QKD
 QOImaejnjZGYi3c+IWhtKD14pHWKC11iaZ1fLPcXIYgwoFVMWYOv7mN3EYxOAP7W4T9/
 yHHTxTAYdLhrWVepaPX/WcM0IxKK2z1R8oLv3rcFrSmis3GkxABc1obOY4Yh0u0nmFw4
 Ckkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SU3VNhIHP4qFfMS6BHdB+T/4wdfQUGXE54wCPeu58gQ=;
 b=lLXCuB+djC/lRxyr1ylcoW2FeCAoLbNFPW28QlS0Ueq2Q7fIFhXovaDUHwBu8NDK6i
 mCf5LqVHdY/TcVVxw5zONqFDfzNmdu0aHxxfxWB7+IG9WU0A9jC81ymvzia1JVk5pehH
 DTjnM7toDbhmImRegm4X29F+2FZStf6W/16qBDnQanWR1hDQHaixJcvyntt6Zxww0dvW
 QNAeOAh3AKfWpvgiaP2VD9qJeselx6EckhVhNZvTee3yBC47lvi+d7YTf5QM1JmyMi7G
 dUNDbFVYifmj6xRpF5VUq3aE8zMiFWI/4XNnH4BVto0jnPU6Xb67vVZPoQLAeg74fOk9
 ODQw==
X-Gm-Message-State: AOAM532739sYzXFBsS+Nj5ahW19xv3fuRpvjwdrY+/n3sLu2V1Z62j23
 FEEOrzHg4uZjsZ5e7WVMfXrjDcD2tz2NSwr9d04=
X-Google-Smtp-Source: ABdhPJz1oJcj/TIW7IPXKfUGMx+mKb7O5I8+KY9nNPCZgngt3Y0TTxSNjp3R9qmQkBVU/dtI0mfS9UGxQ14qdDZsEFg=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr19903224oiw.123.1622599066060; 
 Tue, 01 Jun 2021 18:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <1622194158-70898-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <37a4f0bf-4acb-3961-699b-8335e194e315@amd.com>
In-Reply-To: <37a4f0bf-4acb-3961-699b-8335e194e315@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jun 2021 21:57:35 -0400
Message-ID: <CADnq5_NY_uWzB6QjsM0_+xcbQkMfy1wm2gQx3v7xW_eHQ804YA@mail.gmail.com>
Subject: Re: [PATCH v3] amdgpu: remove unreachable code
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIEZyaSwgTWF5IDI4LCAyMDIxIGF0IDg6MTggQU0gQ2hyaXN0
aWFuIEvDtm5pZwo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFtIDI4LjA1
LjIxIHVtIDExOjI5IHNjaHJpZWIgSmlhcGVuZyBDaG9uZzoKPiA+IEluIHRoZSBmdW5jdGlvbiBh
bWRncHVfdXZkX2NzX21zZygpLCBldmVyeSBicmFuY2ggaW4gdGhlIHN3aXRjaAo+ID4gc3RhdGVt
ZW50IHdpbGwgaGF2ZSBhIHJldHVybiwgc28gdGhlIGNvZGUgYmVsb3cgdGhlIHN3aXRjaCBzdGF0
ZW1lbnQKPiA+IHdpbGwgbm90IGJlIGV4ZWN1dGVkLgo+ID4KPiA+IEVsaW1pbmF0ZSB0aGUgZm9s
bG93IHNtYXRjaCB3YXJuaW5nOgo+ID4KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91dmQuYzo4NDUgYW1kZ3B1X3V2ZF9jc19tc2coKSB3YXJuOgo+ID4gaWdub3JpbmcgdW5y
ZWFjaGFibGUgY29kZS4KPiA+Cj4gPiBSZXBvcnRlZC1ieTogQWJhY2kgUm9ib3QgPGFiYWNpQGxp
bnV4LmFsaWJhYmEuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogSmlhcGVuZyBDaG9uZyA8amlhcGVu
Zy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiA+IC0tLQo+ID4gQ2hhbmdlcyBpbiB2
MjoKPiA+ICAgIC1Gb3IgdGhlIGZvbGxvdyBhZHZpY2U6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3BhdGNod29yay9wYXRjaC8xNDM1OTY4Lwo+ID4KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3V2ZC5jIHwgMyArLS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXZkLmMKPiA+IGluZGV4IGM2ZGJjMDguLjM1ZjY4NzQgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+ID4gQEAgLTgyOSw5ICs4MjksOCBAQCBz
dGF0aWMgaW50IGFtZGdwdV91dmRfY3NfbXNnKHN0cnVjdCBhbWRncHVfdXZkX2NzX2N0eCAqY3R4
LAo+ID4KPiA+ICAgICAgIGRlZmF1bHQ6Cj4gPiAgICAgICAgICAgICAgIERSTV9FUlJPUigiSWxs
ZWdhbCBVVkQgbWVzc2FnZSB0eXBlICglZCkhXG4iLCBtc2dfdHlwZSk7Cj4gPiAtICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOwo+ID4gICAgICAgfQo+ID4gLSAgICAgQlVHKCk7Cj4gPiArCj4g
PiAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+ICAgfQo+ID4KPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
