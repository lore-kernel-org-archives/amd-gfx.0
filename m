Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502DAC55178
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 18:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6CB20EDD
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 18:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oifvqLuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6CB20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5896E514;
	Fri, 23 Oct 2020 18:58:39 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACC56E448;
 Fri, 23 Oct 2020 18:58:38 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id y12so3273595wrp.6;
 Fri, 23 Oct 2020 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HVVGoFH+W6TXbwZk/lJDswsi31Devdn0bKrhChGZkSw=;
 b=oifvqLuPq3+kt6YtYbANPBM9dRUg1EIA7QF5vNUYPPyrBU78UHFhGUF1lQX0Xst+jG
 X6tO/bqSp6e16Za1yek76z98m5+wzRq5h91bKIQfk8QYOy1JXaOh6HKiBN0XVQJEwCu9
 +EnxXKRbZxJT7jGcJStMkFIu4lyQZr+EhL85UvUWW5qnj/k5VBzaedJvudGI2Pzt8mYd
 yVO+CNJN6/IxTaDNL6Eff1uNe3MB1EosEM3e1BkZQugCyc938gn1tcgipCDXF1ndNY7L
 wcqiTH2CjC5ieg7jYWpf1cY1pjK+ZGG4WZVSGlU1IiKhHP3j7/9hSVzMgjBD67tP8/W+
 1aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HVVGoFH+W6TXbwZk/lJDswsi31Devdn0bKrhChGZkSw=;
 b=gzGnz7InJuo5H3WEy28/zdj574XO/FusVyb7/ooGbXZQ/588Lp4T1yBWGDzk2MtIR9
 m+eRPEWA70OohFWgqEmrCwdj78o7LNPtDqvW2j8ik3uLkI998TScDHHweotbgiatF6RY
 9jNcJInN7xf3NLf+MaqyuLWnG9dU+ViWGVQawlMywezJNZjl8vvt2I4zutNCTU6JQm3w
 lpQgFKDmnSBucM/vGIZt4yVKG5usSgSqw3I/F0LE4x2lCEtPALvxQwe8IFFPHf+YcoTy
 Rn1qNZHOjD3GDyyXljEbncxfEQEr54Rf0EykEGLymy+Q7CwOfoXcTFRV/1YySFVRfEmJ
 uW6g==
X-Gm-Message-State: AOAM5308/4f6Bk7x4KNwUUR+bqERMdfuO++YLtnjAS5pzNIkeVPEvfLL
 m06IZf+koHnP2aF/foEnSxC1CsUdH/r4JYCKdZo=
X-Google-Smtp-Source: ABdhPJxhOalGy8AVCk6uFL0CL8XNNtHj2n59zH+OlgCHHeE/mvzoX8Mkq8zjdC575NT151N0gWOsX5KiiZu/oQ7WESg=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr4374706wrl.124.1603479516631; 
 Fri, 23 Oct 2020 11:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <632b3b11118969ff6fccb8a2f606c87fde41c138.1603469755.git.mchehab+huawei@kernel.org>
 <ecb99629-f593-b389-60b3-dc6f1b306c8b@amd.com>
In-Reply-To: <ecb99629-f593-b389-60b3-dc6f1b306c8b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Oct 2020 14:58:24 -0400
Message-ID: <CADnq5_OF2+QpPeBOXkR+JWkCog1ZAckejK2y2o4yf44U9Jrxgw@mail.gmail.com>
Subject: Re: [PATCH v3 03/56] amdgpu: fix a few kernel-doc markup issues
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
Cc: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIEZyaSwgT2N0IDIzLCAyMDIwIGF0IDEyOjM4IFBN
IENocmlzdGlhbiBLw7ZuaWcKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBB
bSAyMy4xMC4yMCB1bSAxODozMiBzY2hyaWViIE1hdXJvIENhcnZhbGhvIENoZWhhYjoKPiA+IEEg
a2VybmVsLWRvYyBtYXJrdXAgY2FuJ3QgYmUgbWl4ZWQgd2l0aCBhIHJhbmRvbSBjb21tZW50LAo+
ID4gYXMgaXQgY2F1c2VzIHBhcnNpbmcgcHJvYmxlbXMuCj4gPgo+ID4gV2hpbGUgaGVyZSwgY2hh
bmdlIGFuIGludmFsaWQga2VybmVsLWRvYyBtYXJrdXAgaW50bwo+ID4gYSBjb21tb24gY29tbWVu
dC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIr
aHVhd2VpQGtlcm5lbC5vcmc+Cj4KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIHwgOCArKysrKy0tLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiA+IGluZGV4IGY4Nzg1YmRlYzc5Yy4uMWQ0YjU0
OTUwNTI4IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMKPiA+IEBAIC0yMzksOSArMjM5LDExIEBAIGJvb2wgYW1kZ3B1X2RldmljZV9zdXBwb3J0
c19iYWNvKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpCj4gPiAgICAgICByZXR1cm4gYW1kZ3B1X2Fz
aWNfc3VwcG9ydHNfYmFjbyhhZGV2KTsKPiA+ICAgfQo+ID4KPiA+ICsvKgo+ID4gKyAqIFZSQU0g
YWNjZXNzIGhlbHBlciBmdW5jdGlvbnMKPiA+ICsgKi8KPiA+ICsKPiA+ICAgLyoqCj4gPiAtICog
VlJBTSBhY2Nlc3MgaGVscGVyIGZ1bmN0aW9ucy4KPiA+IC0gKgo+ID4gICAgKiBhbWRncHVfZGV2
aWNlX3ZyYW1fYWNjZXNzIC0gcmVhZC93cml0ZSBhIGJ1ZmZlciBpbiB2cmFtCj4gPiAgICAqCj4g
PiAgICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiA+IEBAIC00NDk3LDcgKzQ0OTks
NyBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKPiA+ICAgICAgIGJvb2wgbmVlZF9lbWVyZ2VuY3lfcmVzdGFydCA9IGZhbHNlOwo+ID4g
ICAgICAgYm9vbCBhdWRpb19zdXNwZW5kZWQgPSBmYWxzZTsKPiA+Cj4gPiAtICAgICAvKioKPiA+
ICsgICAgIC8qCj4gPiAgICAgICAgKiBTcGVjaWFsIGNhc2U6IFJBUyB0cmlnZ2VyZWQgYW5kIGZ1
bGwgcmVzZXQgaXNuJ3Qgc3VwcG9ydGVkCj4gPiAgICAgICAgKi8KPiA+ICAgICAgIG5lZWRfZW1l
cmdlbmN5X3Jlc3RhcnQgPSBhbWRncHVfcmFzX25lZWRfZW1lcmdlbmN5X3Jlc3RhcnQoYWRldik7
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
