Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD52BC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353F920A8B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbibu0MT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353F920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86726E4E6;
	Fri, 13 Nov 2020 17:25:00 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC4A6E4E6;
 Fri, 13 Nov 2020 17:24:59 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k2so10795295wrx.2;
 Fri, 13 Nov 2020 09:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uBRhPERLFwM9kVQueXTDW4VzWLQKorMvtcJ1DKfFCr8=;
 b=gbibu0MT1eCJuXVDo5/wiV3XKB65YBnbQ1ZN+z8148AhZ+PoypqBMpT/ghUmb5r6uF
 VEb8iLpHG7oZw7PTew5daLieAieoISp/P9NhxPZdI5hJC/Dgq8/6vwcF0ZRXnTYYjfgC
 /ZS+DuxHiONLTjpX2BNn3PJFShJfck9CZLqlw/PvtmvFLFcJR8Ao+CXaafdfGoS/Parm
 6luXFr/SxpPzLRjcX0MAbFIouieeFFC1VOQtH8JE3RaS0qEdKGHeS8EBx470tyxjMlW6
 5YQAIVbd/MF3AAq3ApGHpZ8dqaevXSzq6M9jQX13whxrx34ARrURpJYO1EQ8UO6vYhR8
 qb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uBRhPERLFwM9kVQueXTDW4VzWLQKorMvtcJ1DKfFCr8=;
 b=Es3Qflg+xCHH1YZfNhZUk4JK+o95hbVVZVTi9fHtuxAtImt8Ychaw9GvqNPk8pqyeA
 hi0ErGEoPppNlA5ylENJYf/rr0OIorS6FJgJ4Zqd7GraTXD9X6htO1b5uqdb0RKEX8AX
 u3+mzp1MW+4HjImMj1XKmuMsZti4QcdAK1fgXmOTXPEzgCmemwqwiTPY6v/08P5z0eh/
 bXfxz5tW5sTmH+63kks+16vH9JbyI46Ks25gOGxPh0PE0TZLB7gCghXFeXn7DTu03xYh
 HbHCPivpPgdYvxbd3eWWtILJhuCHyu7acYP7XI7T8MNO06zohIFK5HWHCre9lsLEfidv
 Sa+g==
X-Gm-Message-State: AOAM530U/0zLAOmGfiAI+4YxvUSXLbQRBRLbG6AkecBCtn/dFJzaSKC/
 bEru3qwu9clQrARY4IQ/srcp1yHP7tf9QKxCLYNu22lN
X-Google-Smtp-Source: ABdhPJxtNQRZV0jj9joYdWfh3kfNhGsqnXi4N5xFBsTJ5f47wweNLoUMzJSeS0o2sdUa4Fnt9rH9xeb73/U4vUysprM=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr5043675wrn.124.1605288298092; 
 Fri, 13 Nov 2020 09:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-23-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-23-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:24:46 -0500
Message-ID: <CADnq5_OmY=tfLL9zsr9wMrMjTkHBWeeRvkui4wqEut=UUwyNBg@mail.gmail.com>
Subject: Re: [PATCH 22/40] drm/amd/amdgpu/amdgpu_sched: Consume our own header
 containing prototypes
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Luben Tuikov <luben.tuikov@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andres Rodriguez <andresx7@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBOb3YgMTMsIDIwMjAgYXQgODo1MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zY2hlZC5j
OjM1OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYYW1kZ3B1X3RvX3Nj
aGVkX3ByaW9yaXR54oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3NjaGVkLmM6MTIyOjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHBy
b3RvdHlwZSBmb3Ig4oCYYW1kZ3B1X3NjaGVkX2lvY3Rs4oCZIFstV21pc3NpbmctcHJvdG90eXBl
c10KPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6
ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZp
ZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4KPiBDYzogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KPiBDYzog
QW5kcmVzIFJvZHJpZ3VleiA8YW5kcmVzeDdAZ21haWwuY29tPgo+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQu
ICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfc2NoZWQuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3NjaGVkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2NoZWQuYwo+
IGluZGV4IDBkYTBhMGQ5ODY3MjAuLmI3ZDg2MWVkNTI4NDkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NjaGVkLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfc2NoZWQuYwo+IEBAIC0yOSw3ICsyOSw3IEBACj4gICNpbmNs
dWRlIDxkcm0vYW1kZ3B1X2RybS5oPgo+Cj4gICNpbmNsdWRlICJhbWRncHUuaCIKPiAtCj4gKyNp
bmNsdWRlICJhbWRncHVfc2NoZWQuaCIKPiAgI2luY2x1ZGUgImFtZGdwdV92bS5oIgo+Cj4gIGlu
dCBhbWRncHVfdG9fc2NoZWRfcHJpb3JpdHkoaW50IGFtZGdwdV9wcmlvcml0eSwKPiAtLQo+IDIu
MjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
