Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF60C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CE4206FB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYOZpfPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CE4206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE5C6E314;
	Tue, 24 Nov 2020 15:59:02 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB806E223;
 Tue, 24 Nov 2020 15:59:01 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id r3so4538046wrt.2;
 Tue, 24 Nov 2020 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/BiN8OT888OLJPg+YNWbzwo9aTZyP0IkPs+7Sg97asw=;
 b=hYOZpfPVbkqDoGMp6U/sPZXhFcaEBvhDzUQJ3Dyz3jbwVvLywBLxuEcIedhekOmiWI
 poHZbyjL5wv06c3hU64MBR7AXKAZ3yUCujzfE5A5kgEhiOU9BL2RaECb81DQKYB+QdGU
 2IwoXBcKvq4+Eyb022bd2Xm1DeVBmL7ZLoutkMy8MKTqAkI5XIuNJ4hwW4hNAvPozig0
 LBUfAgBnEhq96wgNKNVNWMuckqfiDdv5xFQui9SfmuuNDaNn1x0uzFK681MWML/REzWj
 ZZw7ZAGGjXowwa9IyEYfs6nNbsepBI+quAbrLIIUE4gEg7xOVWczZUpRJfA1CothHY+k
 +xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/BiN8OT888OLJPg+YNWbzwo9aTZyP0IkPs+7Sg97asw=;
 b=EGK/EbkhwMgs3zsUW41M00O2Rm2OIEOUydWDAnEaTaKdMufw08BN4Z/Z1ua+zPEw5q
 5NfnHziKgvjq7k3UqimnPA+NnuARPMhCFF9R3jHwXnVBrJKyTaSOoA2ARqDJL21Q5yD6
 POqi2xU1/RNF+pCKJgqFfWkX3bm8/IDmnRJQDrJTSokytAJg4HQzeTJcZkTsWzlyLpMW
 h7FED64TKbTglosquEZ+u89Ooa0D84g/zZH07dUDD5uHniv6i+idCv7kQKnwJLi2MuJ+
 apmpGqnIZ0aYYSflMnnO2YH3ULi8XBf0l6qnvIHrDa12swysEPUILu64supyFsN5CT22
 rnyQ==
X-Gm-Message-State: AOAM53321FCHJUdvKVjNJhL329i+NX7mAwL0Q5xMsjQH98wVZpeziBfu
 kpDjHpEpmDaV1t7pF26/IV7BQ00WoF2vwV1dYyA=
X-Google-Smtp-Source: ABdhPJyAuBi4CQChFDAhRroxOQD1DQcxn8wckwkoKfnt9jBRoWEepCzTHlhFxxDon6M6KjjRFC1SeLyWMUgmQROPEOM=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr6225217wrn.124.1606233540191; 
 Tue, 24 Nov 2020 07:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-7-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-7-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Nov 2020 10:58:48 -0500
Message-ID: <CADnq5_Mv5ViAiYPP1h3xbda0OWKjmLPVnUi6ApNNWabBatuKZQ@mail.gmail.com>
Subject: Re: [PATCH 06/40] drm/amd/amdgpu/uvd_v4_2: Fix some kernel-doc
 misdemeanours
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgNjoxOSBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmM6MTU3
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdoYW5kbGUnIG5vdCBkZXNj
cmliZWQgaW4gJ3V2ZF92NF8yX2h3X2luaXQnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3V2ZF92NF8yLmM6MTU3OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdhZGV2
JyBkZXNjcmlwdGlvbiBpbiAndXZkX3Y0XzJfaHdfaW5pdCcKPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdXZkX3Y0XzIuYzoyMTI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBt
ZW1iZXIgJ2hhbmRsZScgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y0XzJfaHdfZmluaScKPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYzoyMTI6IHdhcm5pbmc6IEV4Y2VzcyBm
dW5jdGlvbiBwYXJhbWV0ZXIgJ2FkZXYnIGRlc2NyaXB0aW9uIGluICd1dmRfdjRfMl9od19maW5p
Jwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjRfMi5jOjQ0Njogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYWRkcicgbm90IGRlc2NyaWJlZCBpbiAndXZk
X3Y0XzJfcmluZ19lbWl0X2ZlbmNlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djRfMi5jOjQ0Njogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnc2VxJyBu
b3QgZGVzY3JpYmVkIGluICd1dmRfdjRfMl9yaW5nX2VtaXRfZmVuY2UnCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmM6NDQ2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0
ZXIgb3IgbWVtYmVyICdmbGFncycgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y0XzJfcmluZ19lbWl0
X2ZlbmNlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjRfMi5jOjQ0Njogd2Fy
bmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZmVuY2UnIGRlc2NyaXB0aW9uIGluICd1
dmRfdjRfMl9yaW5nX2VtaXRfZmVuY2UnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2
ZF92NF8yLmM6NTEzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdqb2In
IG5vdCBkZXNjcmliZWQgaW4gJ3V2ZF92NF8yX3JpbmdfZW1pdF9pYicKPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYzo1MTM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ2ZsYWdzJyBub3QgZGVzY3JpYmVkIGluICd1dmRfdjRfMl9yaW5nX2VtaXRf
aWInCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZCB3aXRoIG1pbm9yIG1vZGlmaWNhdGlvbnMuCgpU
aGFua3MhCgpBbGV4CgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0
XzIuYyB8IDggKysrKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
dmRfdjRfMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYwo+IGluZGV4
IGIwYzBjNDM4ZmM5M2MuLjJjOGMzNWMzYmNhNTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3V2ZF92NF8yLmMKPiBAQCAtMTQ5LDcgKzE0OSw3IEBAIHN0YXRpYyB2b2lkIHV2ZF92NF8y
X2VuYWJsZV9tZ2NnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAvKioKPiAgICogdXZk
X3Y0XzJfaHdfaW5pdCAtIHN0YXJ0IGFuZCB0ZXN0IFVWRCBibG9jawo+ICAgKgo+IC0gKiBAYWRl
djogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gKyAqIEBoYW5kbGU6IGhhbmRsZSB1c2VkIHRvIHBh
c3MgYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gICAqCj4gICAqIEluaXRpYWxpemUgdGhlIGhhcmR3
YXJlLCBib290IHVwIHRoZSBWQ1BVIGFuZCBkbyBzb21lIHRlc3RpbmcKPiAgICovCj4gQEAgLTIw
NCw3ICsyMDQsNyBAQCBzdGF0aWMgaW50IHV2ZF92NF8yX2h3X2luaXQodm9pZCAqaGFuZGxlKQo+
ICAvKioKPiAgICogdXZkX3Y0XzJfaHdfZmluaSAtIHN0b3AgdGhlIGhhcmR3YXJlIGJsb2NrCj4g
ICAqCj4gLSAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiArICogQGhhbmRsZTogaGFu
ZGxlIHVzZWQgdG8gcGFzcyBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiAgICoKPiAgICogU3RvcCB0
aGUgVVZEIGJsb2NrLCBtYXJrIHJpbmcgYXMgbm90IHJlYWR5IGFueSBtb3JlCj4gICAqLwo+IEBA
IC00MzcsNiArNDM3LDggQEAgc3RhdGljIHZvaWQgdXZkX3Y0XzJfc3RvcChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKPiAgICogdXZkX3Y0XzJfcmluZ19lbWl0X2ZlbmNlIC0gZW1pdCBhbiBm
ZW5jZSAmIHRyYXAgY29tbWFuZAo+ICAgKgo+ICAgKiBAcmluZzogYW1kZ3B1X3JpbmcgcG9pbnRl
cgo+ICsgKiBAYWRkcjogYWRkcmVzcwo+ICsgKiBAc2VxOiBzZXF1ZW5jZSBudW1iZXIKPiAgICog
QGZlbmNlOiBmZW5jZSB0byBlbWl0Cj4gICAqCj4gICAqIFdyaXRlIGEgZmVuY2UgYW5kIGEgdHJh
cCBjb21tYW5kIHRvIHRoZSByaW5nLgo+IEBAIC01MDIsNyArNTA0LDkgQEAgc3RhdGljIGludCB1
dmRfdjRfMl9yaW5nX3Rlc3RfcmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gICAqIHV2
ZF92NF8yX3JpbmdfZW1pdF9pYiAtIGV4ZWN1dGUgaW5kaXJlY3QgYnVmZmVyCj4gICAqCj4gICAq
IEByaW5nOiBhbWRncHVfcmluZyBwb2ludGVyCj4gKyAqIEBqb2I6IHVudXNlZAo+ICAgKiBAaWI6
IGluZGlyZWN0IGJ1ZmZlciB0byBleGVjdXRlCj4gKyAqIEBmbGFnczogdW51c2VkCj4gICAqCj4g
ICAqIFdyaXRlIHJpbmcgY29tbWFuZHMgdG8gZXhlY3V0ZSB0aGUgaW5kaXJlY3QgYnVmZmVyCj4g
ICAqLwo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
