Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2778C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ED0206A2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV+SxCw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ED0206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA3F6E453;
	Tue,  2 Jun 2020 18:51:26 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48846E453
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 18:51:25 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id v19so3949567wmj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5+7WTzkz9V+aSkJyBXg+eZS5YKtFwBQIzPWPiVEuIls=;
 b=eV+SxCw12LL+ODHHPKRZ0Skku6FrJalijIpeTDfN2zNvAO6eC/XTVhD95DkxKfD8ZT
 3cUco668KjfAYywgzgKVp+HIjytyZsAcXxfMe9gwXYsHUVMg3+NBwi5Vxx+qprzP1YhI
 kKjUSSZi76Bjsg2TIg9E5II2NVDdLSyJItJeXQcCbYGa0Mie/yzqGB0Z0Cpf/jvxi5t1
 MFj8Z+h0dhHT7RC6fhMKRL1qsZcXEa+cBitRFJc1fFHh4judUD2Z2pEtKM+Mx0rVMtai
 udyTVnVBiu1Sk9nM2LpOPbsQeTs65WL5c/qIJW7L9e4eWnI5iXLmSFice2cSWFMBTOTp
 3iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5+7WTzkz9V+aSkJyBXg+eZS5YKtFwBQIzPWPiVEuIls=;
 b=Kpu2kyMnK1ei/xIDjEGiRS9YCFZFa0nw1q0fDx4k3sZKKFYgXO9m5v83RLHtqjIodI
 tL1V4czDtyEJuOgRvn/n3v/XC6qha7AJKXP7R89z5cEg+glhTJTR50N9XV8RFgDT8rOO
 6Ag3VPScHdkMA/D8hbTwzRoWMdp04tHG8LpE2jz5J7LHt7Ele9JaOCQC6T3Ys2ng/97c
 dN3hU7PUTIHPovWwvGVG6U27ikeofqzKGfnx1pzo+REV2P861SfncMXjMW3ilxcUHB6/
 9YhJIwQG09LH+4DLzRKEUcVMEBVaf+o3WCBoxHdieXj3abzxB1E6YWGSJs7r+osVQmh3
 Gq6A==
X-Gm-Message-State: AOAM530J93TGV2qL66/KKjBkhk7bn9WB959YQXZr0ef9K9zpFAnUPAop
 4PrgFnuoDUHRKz97pgDrfnRecBlkcg1dlj84l0U=
X-Google-Smtp-Source: ABdhPJyVcgGytnpbvZVusmABIb3QA2uHnVrfudfhPWy2QEJZZjY6J7i2BivY9xr8edam71s06C99vUhN2sfAZ4w1ec0=
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr5252280wml.70.1591123884414; 
 Tue, 02 Jun 2020 11:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
 <20200601180239.1267430-74-alexander.deucher@amd.com>
 <9640f151-cfe9-600f-cc4f-7b056c09be0f@amd.com>
In-Reply-To: <9640f151-cfe9-600f-cc4f-7b056c09be0f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 14:51:12 -0400
Message-ID: <CADnq5_P9wp8DiJJ98au9FOCWMUyu+LKrPQsfdziUGQQyN2zFDA@mail.gmail.com>
Subject: Re: [PATCH 077/207] drm/amdgpu: no need to set up GPU scheduler for
 mes ring
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMiwgMjAyMCBhdCA1OjMwIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwMS4wNi4yMCB1bSAyMDowMCBzY2hyaWVi
IEFsZXggRGV1Y2hlcjoKPiA+IEZyb206IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5jb20+Cj4g
Pgo+ID4gQXMgbWVzIHJpbmcgZGlyZWN0bHkgc3VibWl0cyB0byBoYXJkd2FyZWQsCj4gPiBpdCdz
IG5vIG5lZWQgdG8gc2V0IHVwIEdQVSBzY2hlZHVsZXIgZm9yIG1lcyByaW5nLgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5jb20+Cj4gPiBBY2tlZC1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gUmV2aWV3ZWQtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiA+IFJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiAtLS0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA1ICsrKy0tCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiA+IGluZGV4IDM0
MTRlMTE5ZjBjYi4uODcxMmEyZTFiODY5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4gPiBAQCAtNDY5LDggKzQ2OSw5IEBAIGludCBhbWRncHVf
ZmVuY2VfZHJpdmVyX2luaXRfcmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4gPiAgICAg
ICBpZiAoIXJpbmctPmZlbmNlX2Rydi5mZW5jZXMpCj4gPiAgICAgICAgICAgICAgIHJldHVybiAt
RU5PTUVNOwo+ID4KPiA+IC0gICAgIC8qIE5vIG5lZWQgdG8gc2V0dXAgdGhlIEdQVSBzY2hlZHVs
ZXIgZm9yIEtJUSByaW5nICovCj4gPiAtICAgICBpZiAocmluZy0+ZnVuY3MtPnR5cGUgIT0gQU1E
R1BVX1JJTkdfVFlQRV9LSVEpIHsKPiA+ICsgICAgIC8qIE5vIG5lZWQgdG8gc2V0dXAgdGhlIEdQ
VSBzY2hlZHVsZXIgZm9yIEtJUSBhbmQgTUVTIHJpbmcgKi8KPiA+ICsgICAgIGlmIChyaW5nLT5m
dW5jcy0+dHlwZSAhPSBBTURHUFVfUklOR19UWVBFX0tJUSB8fAo+ID4gKyAgICAgICAgIHJpbmct
PmZ1bmNzLT50eXBlICE9IEFNREdQVV9SSU5HX1RZUEVfTUVTKSB7Cj4KPiBCVFc6IE1ha2luZyB0
aGlzIGEgZmxhZyBpbiB0aGUgcmluZy0+ZnVuY3Mgc3RydWN0IHdvdWxkIHByb2JhYmx5IGJlCj4g
Y2xlYW5lciB0aGFuIGNoZWNraW5nIHRoZSB0d28gdHlwZXMgaGVyZS4KPgo+IEJ1dCBub3QgYSBt
dXN0IGhhdmUgcmlnaHQgbm93LgoKQWxyZWFkeSBhZGRlZCBhIGZsYWcgZm9yIHRoaXMsIGp1c3Qg
bWlzc2VkIHRoaXMgY2FzZS4KCkFsZXgKCj4KPiBDaHJpc3RpYW4uCj4KPiA+ICAgICAgICAgICAg
ICAgc3dpdGNoIChyaW5nLT5mdW5jcy0+dHlwZSkgewo+ID4gICAgICAgICAgICAgICBjYXNlIEFN
REdQVV9SSU5HX1RZUEVfR0ZYOgo+ID4gICAgICAgICAgICAgICAgICAgICAgIHRpbWVvdXQgPSBh
ZGV2LT5nZnhfdGltZW91dDsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
