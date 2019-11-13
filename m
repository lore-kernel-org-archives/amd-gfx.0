Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D2C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 15:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70969222D3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 15:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70969222D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E1C6ED43;
	Wed, 13 Nov 2019 15:04:52 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730866ED43
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 15:04:50 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id r10so2768519wrx.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 07:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WIHYdeoBzE9Fcj2vg0H1ihGzqkhjzWVBPXD7w3QarHE=;
 b=OXNV4ipgbG66o/Po/2t/LWQ8on01KZcm03Obm6/gOlbbuz/Icd5U52xZSOWVJbyurG
 R/1ADoPA9vUNG8qdY3ZJCR0hUYuHNZJhxgaECm2uGpYAfK4RB9Qz+yuDW/hJ54TTcWb0
 wWfQ+yg8UbRYp2hp+iMZzNyEhe6MfngUTB9VzEyCfZ7L19/Nd4Ewi6byKiNuyqsaxv25
 KxGU4AQLHtswYBHtP9sESk6mrpkwtbvZRQIR1hY8MIvVVBotK98qtc2TgpB8M/F9jSAc
 fO200j0Aq5io4ewKeiS1KPTOeP/fVfnh18lcKmgQid8E4XY+JULEHWFlijSz+Xf4gmEu
 fN0Q==
X-Gm-Message-State: APjAAAUVjOgHOsgZe1bSx0eTkXdebbJxUGsWk8VmN0zCRhoxwoABvF3W
 SVjRYKL39PGz32f3qToCrKkMVviTouHmcHT3WQBnbQ==
X-Google-Smtp-Source: APXvYqxWdAr9ib47XkTRrZmeCZgwk8mzgkJdsNs1XgiSDoSJcEZobDlRRkLFavsUfd4QLLG2U5d9rPP28mgy43naCh0=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr3258463wrq.40.1573657488960;
 Wed, 13 Nov 2019 07:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20191113145705.12298-1-Hawking.Zhang@amd.com>
 <20191113145705.12298-2-Hawking.Zhang@amd.com>
In-Reply-To: <20191113145705.12298-2-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Nov 2019 10:04:36 -0500
Message-ID:
 <CADnq5_Pr_Ug5G_r8zNz4zoHj8si78TsU7EgL=JBY4E86-e_OZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: init umc functions for arcturus umc ras
To: Hawking Zhang <Hawking.Zhang@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=WIHYdeoBzE9Fcj2vg0H1ihGzqkhjzWVBPXD7w3QarHE=;
 b=kmNlXkIT/cWU+kkZ1ZPuDRNv4pP8Qc4WGVfRnmffbAAsF4OxL/KgVWLjnSJTuMqnkr
 bU9GQP8hkzpL7nMR1E+lCz9uMUYqfBfx9gye99CBaK27mvqJX7P1vBPppYnxXdF/D4KG
 rHhCERypfF0U1Oea9LGQSBQb8gS96RvqhXJ1Jbe6Fb067gMXwWmAGV2Qr4wPoEbqMzK2
 Z6W+oAw4UmaexMx97vRpdBk/zbLwCnOzuqKgvmCScaqB/T8QoSKJqEy8haPbt1Pn3P8y
 Efs2/In39kd5IByClSz1dQI2+NQU/ljsJKeo12IkIRGyjbGuhJipz912wBCDAaqrgCpt
 C8XA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 John Clements <John.Clements@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113150436.sFfDjOj1kJtkkL0zcRAcOoVAei8CwLOQfgL5jhi5e9c@z>

T24gV2VkLCBOb3YgMTMsIDIwMTkgYXQgOTo1NyBBTSBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4gcmV1c2UgdmcyMCB1bWMgZnVuY3Rpb25zIGZvciBhcmN0
dXJ1cyB1bWMgcmFzCj4KPiBDaGFuZ2UtSWQ6IElhOGFmM2MyMGE3MTdjNzZlYzE4YWE1ZmEzMzJj
ZmQ4MWNhNjBmZjY5Cj4gU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPgoKU2VyaWVzIGlzOgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3Y5XzAuYyB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gaW5kZXggMzc4NGI2MjIwMWIwLi44
YTViNzIyY2U1YjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBA
QCAtNjM1LDYgKzYzNSw3IEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX3NldF91bWNfZnVuY3Moc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAgICAgICAgICAgICAgIGFkZXYtPnVtYy5mdW5j
cyA9ICZ1bWNfdjZfMF9mdW5jczsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBj
YXNlIENISVBfVkVHQTIwOgo+ICsgICAgICAgY2FzZSBDSElQX0FSQ1RVUlVTOgo+ICAgICAgICAg
ICAgICAgICBhZGV2LT51bWMubWF4X3Jhc19lcnJfY250X3Blcl9xdWVyeSA9IFVNQ19WNl8xX1RP
VEFMX0NIQU5ORUxfTlVNOwo+ICAgICAgICAgICAgICAgICBhZGV2LT51bWMuY2hhbm5lbF9pbnN0
X251bSA9IFVNQ19WNl8xX0NIQU5ORUxfSU5TVEFOQ0VfTlVNOwo+ICAgICAgICAgICAgICAgICBh
ZGV2LT51bWMudW1jX2luc3RfbnVtID0gVU1DX1Y2XzFfVU1DX0lOU1RBTkNFX05VTTsKPiBAQCAt
NzQ4LDYgKzc0OSw3IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRs
ZSkKPiAgICAgICAgICAgICAgICAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiAgICAgICAg
ICAgICAgICAgY2FzZSBDSElQX1ZFR0ExMDoKPiAgICAgICAgICAgICAgICAgY2FzZSBDSElQX1ZF
R0EyMDoKPiArICAgICAgICAgICAgICAgY2FzZSBDSElQX0FSQ1RVUlVTOgo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHIgPSBhbWRncHVfYXRvbWZpcm13YXJlX21lbV9lY2Nfc3VwcG9ydGVkKGFk
ZXYpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghcikgewo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRFJNX0lORk8oIkVDQyBpcyBub3QgcHJlc2VudC5cbiIpOwo+IC0t
Cj4gMi4xNy4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
