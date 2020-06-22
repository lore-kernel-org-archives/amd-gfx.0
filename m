Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF09C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 19:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C92220716
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 19:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Jora8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C92220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40946E8D7;
	Mon, 22 Jun 2020 19:48:42 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49F96E8D7;
 Mon, 22 Jun 2020 19:48:41 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g75so693843wme.5;
 Mon, 22 Jun 2020 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=311SvhxGkudFsc5pZh72Ar1Ei6DXigWyevFxNk4TjS4=;
 b=b3Jora8WMLEdv59PF2q4nujrOs3tlnuUqkKvokx+u0eQxgvS1A2uymksDZIK2zCHzF
 KZLMY7iI0qb/M3CyonLx6+6Lua6NVW2r5BL3BBTJu+RQmRluabaA7IcXg7zE2qcok0sl
 x56M128Y8Fpn2iwCjeHU19u0MQlU/fyUGvrQXm92FuWt+dnSybdw+NFcthA6ym4YrKIo
 PmIChv4mwoyruCWUlAP8m2lh/y2ZDNxnPOjPKPPVp8ZxVAiPedzytsyBMrOZpfUB5COn
 TG43KS1BxWniwLpTIGmjEPyhlgZJmKqNB7zuqvptLz96dDg+cEX8OestkVqFlQeMnjPe
 Sx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=311SvhxGkudFsc5pZh72Ar1Ei6DXigWyevFxNk4TjS4=;
 b=FTnPP6aitCUUef+vzdmPU2CGPspq1I3qmyrraCnIqAWU6eH4fEuc4OotdaRpZ35tKH
 QCQ/pffyue2ntPOzQMzOUxwtMEbYL0gO2ojfZ1yRYQ4jRnC7/iOP9zlSG9KcIMyaDUWl
 rPOMGekw0a6hbcXfwT9ngtKplb6lePfsJXLnXed0zNmSFBpdazzkPXrV6N/ZgVwAzwry
 HguNWw2eSBzzIgyRnDO+MFfCBICdpByaSbLFXmow1vlBV2DKNpYYr/MQfPN3AEb9RoW6
 hjDCD9AH/dHb6MovpCl3cWKWnv7J7283kuB8OVB5VXphuhKrcON+J/NRIIawLy+uZNdn
 aqsw==
X-Gm-Message-State: AOAM530U/dGz11okuzsxZ5jncYhWU0tDntZEavzWJa/TI2uX/p1deLp5
 KHOwybQwkDhXcbw23OCP7t5VgA9sTo2TWqVMWrKiBg==
X-Google-Smtp-Source: ABdhPJw7GvPZha0yIkF0qwQeOLruLOGZ7Pj/G6FXm1Xa83g18fWWKgdY6oZIym/g/36El7x7QAWjPVzCc7yBePYPTzw=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr20390328wmy.79.1592855320363; 
 Mon, 22 Jun 2020 12:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-7-git-send-email-andrey.grodzovsky@amd.com>
 <ec7dc51a-231f-f9e7-6082-5aad02965c67@gmail.com>
In-Reply-To: <ec7dc51a-231f-f9e7-6082-5aad02965c67@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jun 2020 15:48:29 -0400
Message-ID: <CADnq5_Oz_858bq-PRc=DsL62=TiqFaONw4qARK8NVbUVzMfuCw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] drm/amdgpu: Unmap entire device address space on
 device remove.
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKdW4gMjIsIDIwMjAgYXQgMzozOCBQTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAyMS4wNi4yMCB1bSAwODow
MyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+ID4gVXNlIHRoZSBuZXcgVFRNIGludGVyZmFj
ZSB0byBpbnZhbGlkYXRlIGFsbCBleHNpc3RpbmcgQk8gQ1BVIG1hcHBpbmdzCj4gPiBmb3JtIGFs
bCB1c2VyIHByb2NjZXNzZXMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zz
a3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gSSB0aGluayB0aG9zZSB0d28g
cGF0Y2hlcyBjb3VsZCBhbHJlYWR5IGxhbmQgaW4gYW1kLXN0YWdpbmctZHJtLW5leHQKPiBzaW5j
ZSB0aGV5IGFyZSBhIGdvb2QgaWRlYSBpbmRlcGVuZGVudCBvZiBob3cgZWxzZSB3ZSBmaXggdGhl
IG90aGVyIGlzc3Vlcy4KClBsZWFzZSBtYWtlIHN1cmUgdGhleSBsYW5kIGluIGRybS1taXNjIGFz
IHdlbGwuCgpBbGV4Cgo+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jIHwgMSArCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiA+IGluZGV4IDQz
NTkyZGMuLjY5MzJkNzUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYwo+ID4gQEAgLTExMzUsNiArMTEzNSw3IEBAIGFtZGdwdV9wY2lfcmVtb3ZlKHN0cnVj
dCBwY2lfZGV2ICpwZGV2KQo+ID4gICAgICAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IHBjaV9n
ZXRfZHJ2ZGF0YShwZGV2KTsKPiA+Cj4gPiAgICAgICBkcm1fZGV2X3VucGx1ZyhkZXYpOwo+ID4g
KyAgICAgdHRtX2JvX3VubWFwX3ZpcnR1YWxfYWRkcmVzc19zcGFjZSgmYWRldi0+bW1hbi5iZGV2
KTsKPiA+ICAgICAgIGFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcyhkZXYpOwo+ID4KPiA+ICAgICAg
IHBjaV9kaXNhYmxlX2RldmljZShwZGV2KTsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
