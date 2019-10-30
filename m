Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A67CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 13:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EDE20874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 13:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EDE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01AFD6EA12;
	Wed, 30 Oct 2019 13:55:06 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388736EA12
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 13:55:04 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 6so4359102wmf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 06:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QzBzumLm7e8lVJ4kvFU3Lw0Vcurddol46akkf/EKvCE=;
 b=WFZ04ouAmqKVEe4spbHfd3bh+erWaXPjBwW/Z8kiSQLl5tVlbzMgzaxFwKReSEnQ7Z
 s+nUWNnfqUCRaRggGyE1776lwyqqDT3dOicx2ssZ2Hfj57MbXetYXXOMLRD0T2JEtfYm
 ql/DNv+bkrCFX1h6VfqV1FuhRB6DO7nhG+CrJr5LLlU3Lu7/fZGvyEosFnfbIZ4h+G8m
 XH9UNzfWAZ3ZFC1kM76mU/4xQLdwDzhswy9/36bVNy7QH6LXcZ9b2jdZnYlNVR7WE5aR
 I17BJVXb6oA/Z5njZ7u91+EkMsZzNzFV+HBJqSohv3yVyj5ALwGB+cG8xbhv6JHQF6il
 hhBg==
X-Gm-Message-State: APjAAAVUeARhj7gn1s/FD2om2STytcbuz91SWZ7PysPJJPVE5SKfMGrc
 65gHc9/56/F2LiKJD6C9Uy7RhCtz5Q7froaAPYYuSA==
X-Google-Smtp-Source: APXvYqxxqxeq5E5iLIb53g283Fr1GZWxqCOs/enPYARlxmjbUWj84iPnok1Sfd1heQMm3TjKcXI7RtgKsxenY6UIJKk=
X-Received: by 2002:a7b:cd18:: with SMTP id f24mr2321041wmj.141.1572443702519; 
 Wed, 30 Oct 2019 06:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191029201031.1514210-1-alexander.deucher@amd.com>
In-Reply-To: <20191029201031.1514210-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Oct 2019 09:54:47 -0400
Message-ID:
 <CADnq5_PF+DdtAoqb_36JxNjQmkSG1w39452OGOakvECeUa8FWA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/renoir: move gfxoff handling into gfx9 module
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=QzBzumLm7e8lVJ4kvFU3Lw0Vcurddol46akkf/EKvCE=;
 b=Tq9eVIzEVMaDRUYj96lHcyAVbLsyMmVdM79m+SH+l7q9jhnUyUVSHWY82hBQP7uvoO
 ZMw3Fp1MEsk40472f4wBt61DNLKUsV5fwqjXKexmv97vWHPjSZ0hxLn1jYq/DDAEoVTE
 zsf7SoTHOZH8pxdhUNSumwlIeSnCGs9zG1hZ5calKkCoHfZFnDmaEN70trE4MUKCTXD2
 5fIez1SjWx1deIUEYdzuizMlmV+vYyjkXZIrUMsWChek2QR1J444wsOpfGl25POmvHEU
 JqLVSVUqPCE9TuIXVsttUK+8KznYi4X+VJdcJYIvMSsOtMW2BCDSzIbrm4j6w6HjP9vQ
 ZHMQ==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030135447.kSrn0kQZ_7Zxy2YtQG0SuPBlm8Ns5vcBNS8jCAJhRyQ@z>

UGluZz8KCk9uIFR1ZSwgT2N0IDI5LCAyMDE5IGF0IDQ6MTAgUE0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gVG8gcHJvcGVybHkgaGFuZGxlIHRoZSBvcHRp
b24gcGFyc2luZyBvcmRlcmluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYyB8IDYgKysrKysrCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMgICAgfCA1IC0tLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gaW5k
ZXggOWZlOTVlNzY5M2Q1Li5iMmIzZWI3NWM0OGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMKPiBAQCAtMTA1MSw2ICsxMDUxLDEyIEBAIHN0YXRpYyB2b2lkIGdmeF92
OV8wX2NoZWNrX2lmX25lZWRfZ2Z4b2ZmKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAhYWRldi0+Z2Z4LnJsYy5pc19ybGNfdjJfMSkpCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+cG0ucHBfZmVhdHVyZSAmPSB+UFBfR0ZYT0ZG
X01BU0s7Cj4KPiArICAgICAgICAgICAgICAgaWYgKGFkZXYtPnBtLnBwX2ZlYXR1cmUgJiBQUF9H
RlhPRkZfTUFTSykKPiArICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5wZ19mbGFncyB8PSBB
TURfUEdfU1VQUE9SVF9HRlhfUEcgfAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QU1EX1BHX1NVUFBPUlRfQ1AgfAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1E
X1BHX1NVUFBPUlRfUkxDX1NNVV9IUzsKPiArICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAg
ICBjYXNlIENISVBfUkVOT0lSOgo+ICAgICAgICAgICAgICAgICBpZiAoYWRldi0+cG0ucHBfZmVh
dHVyZSAmIFBQX0dGWE9GRl9NQVNLKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnBn
X2ZsYWdzIHw9IEFNRF9QR19TVVBQT1JUX0dGWF9QRyB8Cj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBBTURfUEdfU1VQUE9SVF9DUCB8Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2Mx
NS5jCj4gaW5kZXggMTZjNWJiNzU4ODlmLi4yNWU2OWVhNzRhNDEgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMKPiBAQCAtMTI2MywxMSArMTI2Myw2IEBAIHN0YXRpYyBpbnQgc29j
MTVfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEFNRF9QR19TVVBQT1JUX1ZDTiB8Cj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRzsKPiAgICAgICAgICAgICAgICAgYWRl
di0+ZXh0ZXJuYWxfcmV2X2lkID0gYWRldi0+cmV2X2lkICsgMHg5MTsKPiAtCj4gLSAgICAgICAg
ICAgICAgIGlmIChhZGV2LT5wbS5wcF9mZWF0dXJlICYgUFBfR0ZYT0ZGX01BU0spCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgYWRldi0+cGdfZmxhZ3MgfD0gQU1EX1BHX1NVUFBPUlRfR0ZYX1BH
IHwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9QR19TVVBQT1JUX0NQIHwK
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9QR19TVVBQT1JUX1JMQ19TTVVf
SFM7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgZGVmYXVsdDoKPiAgICAgICAg
ICAgICAgICAgLyogRklYTUU6IG5vdCBzdXBwb3J0ZWQgeWV0ICovCj4gLS0KPiAyLjIzLjAKPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
