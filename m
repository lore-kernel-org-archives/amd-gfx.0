Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73596C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329A4206D8
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5QzMpr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329A4206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0506E87A;
	Mon, 16 Dec 2019 20:22:29 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522866E87A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 20:22:29 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b72so671336wme.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JVkjBhxztb27GKzbsNw6IG+K1cWjkS/TNgBUNnenDqs=;
 b=f5QzMpr3wcbDnHOoICb/JGsHMqohEpwOkmF8UaRds+5wasFvZ2ZWhhxgeXT9gaArIH
 8pvoEoIybgI2rKLlgGzQZZl9vD3vKVYW93F9RXas464KZeD/P2vbxPjZNiiCMpnAJOxX
 KwQ3izHBSd9m70ftLs3NkPdLT3hqbZ2c9XWqkk+onoBKYB/REfc2kiVutreDr+SZMqRe
 6ARtP8ADcXmOb8T0eExaYV5LYwL7SZtCIoXLGt/gak0LkIJQalHvdZJbi2OpobFGDab/
 XXmi2uBdgJhGQK+TW9tBggdhayEfTmaptd3/8yNZYaW5Wa6nSU5qCw1WiqZkZZvQXMSZ
 7MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JVkjBhxztb27GKzbsNw6IG+K1cWjkS/TNgBUNnenDqs=;
 b=X8t403DvI4T+vdBK4Jo+m4h7IGGGPciIOFJdpI8Q3Ymmyhsi8oClPMFeog48SUA6Gj
 VAC2F6stRRh4O69kvyGPoeD4sgRyi7az43/dZIuPxRGvFe+UtgIa//XNbDsLFjaySIs+
 aK+Gb6HCw03btKiP+HIBvXNK9WmqaEmVAt5U+l4/4+tuhWhva8aFV2ObHmbhSFs5zyI2
 fLQm52RiteosCi7R5jurKv5gqPWMu17GDG10kWqjU0it8SLI/8QYQXgUuYSUVBjc7sMG
 ItmmnpN5GkurZ5Vfyg5MnAmmRHE8SKHSwPhryBQozrzJqKNaS0AYq7b2yMZYItorOBzi
 AAKg==
X-Gm-Message-State: APjAAAWmMBeYmuodTfjyzJM1Y93693Oh/5xTkTeo72RIOCBxUmRBj0OX
 MkoL5mwWMdYvp7Cv9OG2WJKMHCXchL77XDQEciIJFtMe
X-Google-Smtp-Source: APXvYqy1gCh42QI+F/Hu2IHs5ptRe1ekLpBc8Q9iBD8h41wjRhxZFZJ8wQkQ50KJL10Oy+2eNkR51/yh8ugbXKEZl44=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr852958wmj.57.1576527747879;
 Mon, 16 Dec 2019 12:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20191216171834.217251-1-alexander.deucher@amd.com>
 <20191216171834.217251-2-alexander.deucher@amd.com>
 <d9b19564-79b4-6044-8b0d-5dba5adf6982@gmail.com>
In-Reply-To: <d9b19564-79b4-6044-8b0d-5dba5adf6982@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2019 15:22:16 -0500
Message-ID: <CADnq5_M1N8Bs1-FH+TpqbDWRXk+bcEx9=+Q8+qr=Bv5NbXwwjw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/pm_runtime: update usage count in fence
 handling
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBEZWMgMTYsIDIwMTkgYXQgMzoxOSBQTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxNi4xMi4xOSB1bSAxODox
OCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+IEluY3JlbWVudCB0aGUgdXNhZ2UgY291bnQgaW4g
ZW1pdCBmZW5jZSwgYW5kIGRlY3JlbWVudCBpbgo+ID4gcHJvY2VzcyBmZW5jZSB0byBtYWtlIHN1
cmUgdGhlIEdQVSBpcyBhbHdheXMgY29uc2lkZXJlZCBpbgo+ID4gdXNlIHdoaWxlIHRoZXJlIGFy
ZSBmZW5jZXMgb3V0c3RhbmRpbmcuICBXZSBhbHdheXMgd2FpdCBmb3IKPiA+IHRoZSBlbmdpbmVz
IHRvIGRyYWluIGluIHJ1bnRpbWUgc3VzcGVuZCwgYnV0IGluIHByYWN0aWNlCj4gPiB0aGF0IG9u
bHkgY292ZXJzIHNob3J0IGxpdmVkIGpvYnMgZm9yIGdmeC4gIFRoaXMgc2hvdWxkCj4gPiBjb3Zl
ciB1cyBmb3IgbG9uZ2VyIGxpdmVkIGZlbmNlcy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA2ICsrKysrLQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiA+IGluZGV4IDM3N2ZlMjBiY2Uy
My4uZTllZmVlMDRjYTIzIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZlbmNlLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mZW5jZS5jCj4gPiBAQCAtMzQsNiArMzQsNyBAQAo+ID4gICAjaW5jbHVkZSA8bGludXgv
a3JlZi5oPgo+ID4gICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+ID4gICAjaW5jbHVkZSA8bGlu
dXgvZmlybXdhcmUuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgo+ID4KPiA+
ICAgI2luY2x1ZGUgPGRybS9kcm1fZGVidWdmcy5oPgo+ID4KPiA+IEBAIC0xNTQsNyArMTU1LDcg
QEAgaW50IGFtZGdwdV9mZW5jZV9lbWl0KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgc3RydWN0
IGRtYV9mZW5jZSAqKmYsCj4gPiAgICAgICAgICAgICAgICAgICAgICBzZXEpOwo+ID4gICAgICAg
YW1kZ3B1X3JpbmdfZW1pdF9mZW5jZShyaW5nLCByaW5nLT5mZW5jZV9kcnYuZ3B1X2FkZHIsCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlcSwgZmxhZ3MgfCBBTURHUFVfRkVOQ0Vf
RkxBR19JTlQpOwo+ID4gLQo+ID4gKyAgICAgcG1fcnVudGltZV9nZXRfbm9yZXN1bWUoYWRldi0+
ZGRldi0+ZGV2KTsKPiA+ICAgICAgIHB0ciA9ICZyaW5nLT5mZW5jZV9kcnYuZmVuY2VzW3NlcSAm
IHJpbmctPmZlbmNlX2Rydi5udW1fZmVuY2VzX21hc2tdOwo+ID4gICAgICAgaWYgKHVubGlrZWx5
KHJjdV9kZXJlZmVyZW5jZV9wcm90ZWN0ZWQoKnB0ciwgMSkpKSB7Cj4gPiAgICAgICAgICAgICAg
IHN0cnVjdCBkbWFfZmVuY2UgKm9sZDsKPiA+IEBAIC0yMzQsNiArMjM1LDcgQEAgc3RhdGljIHZv
aWQgYW1kZ3B1X2ZlbmNlX3NjaGVkdWxlX2ZhbGxiYWNrKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZykKPiA+ICAgYm9vbCBhbWRncHVfZmVuY2VfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJp
bmcpCj4gPiAgIHsKPiA+ICAgICAgIHN0cnVjdCBhbWRncHVfZmVuY2VfZHJpdmVyICpkcnYgPSAm
cmluZy0+ZmVuY2VfZHJ2Owo+ID4gKyAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBy
aW5nLT5hZGV2Owo+ID4gICAgICAgdWludDMyX3Qgc2VxLCBsYXN0X3NlcTsKPiA+ICAgICAgIGlu
dCByOwo+ID4KPiA+IEBAIC0yNzQsNiArMjc2LDggQEAgYm9vbCBhbWRncHVfZmVuY2VfcHJvY2Vz
cyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgQlVH
KCk7Cj4gPgo+ID4gICAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPiA+ICsgICAg
ICAgICAgICAgcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShhZGV2LT5kZGV2LT5kZXYpOwo+ID4g
KyAgICAgICAgICAgICBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChhZGV2LT5kZGV2LT5kZXYp
Owo+Cj4gQXJlIHlvdSBzdXJlIHRoaXMgaXMgb2s/IEtlZXAgaW4gbWluZCB0aGF0IHRoaXMgZnVu
Y3Rpb24gaXMgY2FsbGVkIGluCj4gaW50ZXJydXB0IGNvbnRleHQuCgpBY2NvcmRpbmcgdG86Cmh0
dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vcG93ZXIvcnVudGltZV9wbS50
eHQKaXQncyBvayB0byBjYWxsIHRob3NlIGluIGFuIGludGVycnVwdCBjb250ZXh0LgoKQWxleAoK
Pgo+IENocmlzdGlhbi4KPgo+ID4gICAgICAgfSB3aGlsZSAobGFzdF9zZXEgIT0gc2VxKTsKPiA+
Cj4gPiAgICAgICByZXR1cm4gdHJ1ZTsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
