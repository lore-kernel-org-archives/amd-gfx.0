Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C5FC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 23:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784F520708
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 23:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784F520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C846EA70;
	Wed, 20 Nov 2019 23:25:06 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E596EA70
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 23:25:04 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id b18so2015290wrj.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 15:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uzixmAToJsMowqUWMdcAL5SrhoTEG9xLhdYTs/YVhXg=;
 b=ESU1Aq9Ar8VWPaIR77vBW+CHsm2YsLVb6Wa65tP/kvxt3DC2JKeCPZKCLsGIs2kbaU
 z7y2/934ROuPxH3uF1SOOkZJk3PdmBh24xOHCRquUZJIOwhZ3/56vbEn9rBzxM/9YSvf
 N1bR3t3xSSSFXSDFKyeWs/io1I6k0xX3IhAAW3abl8GzfZ/zwAqUooqrjiHJnJQ5dOqY
 lczkoiiZBoFOmb54XqSq9jOIL4tBi3Uc6BU4W1tyYjjVRcNuqM3XcZ5TQcRfXWJP2r23
 wZ67kmpGIF+uTdpuwIQp3N754T0Hup+/PTmxOTsry32VxdCtDWl2J2HtROiEmFMoERtl
 ihLA==
X-Gm-Message-State: APjAAAX4w3BB7GcyTBR0Md8iK7qOG60hblPDMoWstqBq6qT0dC8mBzIy
 0CEPIwwgvG0HIjKOa3vVlCemXcaTPHoqrvV0+5+M4g==
X-Google-Smtp-Source: APXvYqzs4fz1GGYOjBMiB0yMBstwhnKOVG1eM1THoqXkEZeMTRApR9a5eNbVvMIhMEsZBGI2ZSzAywvfidsMmsD9wHQ=
X-Received: by 2002:adf:e444:: with SMTP id t4mr6980628wrm.50.1574292302521;
 Wed, 20 Nov 2019 15:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20191115160119.658620-1-alexander.deucher@amd.com>
In-Reply-To: <20191115160119.658620-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Nov 2019 18:24:49 -0500
Message-ID:
 <CADnq5_P5m-eWDy5Xb5qs2HpcZbh3FxLTAxhxsXRZGDbkYrTZnA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: re-enable wait in pipelock,
 but add timeout
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=uzixmAToJsMowqUWMdcAL5SrhoTEG9xLhdYTs/YVhXg=;
 b=uXyilxpsNXmVuvtIlAW1fNrNWVRhBy7dSDrKpGMwTbwdhh/6nFTGNp0R6Vh5MNKRGw
 JEpuDWgk25iT0GwgnEgyIlXQPyLsjbSvzzWlv8KGj+cG9LbJCPaFD0NgxAYY5n2NNOvQ
 OzbGfYurOr0HE7w7iGtUat+XHT+sIhcVc13RslYcbADqsr3/ymU+EeVKcMdKi8v98jgP
 TgIIry+MhSa7+sFhXdicgU5hOgvigb4qIiW1345ihDUESbO6loTSP/pSQ9zmqVbS/2QP
 zDhxAjo4tgLjey8TgD1UtwcMmTRpWojvFmRuooQhdu8YT8z6udmZ19JlB0g1zYrlWUAh
 2jRw==
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
Message-ID: <20191120232449.xnm3TefRQcSHl-lvtLq8MUAFzA5pdAYFWgVFFSLB94M@z>

UGluZz8KCk9uIEZyaSwgTm92IDE1LCAyMDE5IGF0IDExOjAxIEFNIEFsZXggRGV1Y2hlciA8YWxl
eGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPgo+IFJlbW92aW5nIHRoaXMgY2F1c2VzIGhhbmdz
IGluIHNvbWUgZ2FtZXMsIHNvIHJlLWFkZCBpdCwgYnV0IGFkZAo+IGEgdGltZW91dCBzbyB3ZSBk
b24ndCBoYW5nIHdoaWxlIHN3aXRjaGluZyBmbGlwIHR5cGVzLgo+Cj4gQnVnOiBodHRwczovL2J1
Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTE2OQo+IEJ1ZzogaHR0cHM6Ly9i
dWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTEyMjY2Cj4gQnVnOiBodHRwczov
L2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTE2OQo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAtLS0KPiAgLi4u
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jICAgIHwgMTkgKysrKysrKysr
KysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2VxLmMKPiBp
bmRleCAwMDQ2YTA5OWM5ZTkuLjEyMGU2MmM1MTkzYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCj4gQEAgLTEwMzMsNiAr
MTAzMywyNSBAQCB2b2lkIGRjbjIwX3BpcGVfY29udHJvbF9sb2NrKAo+ICAgICAgICAgaWYgKHBp
cGUtPnBsYW5lX3N0YXRlICE9IE5VTEwpCj4gICAgICAgICAgICAgICAgIGZsaXBfaW1tZWRpYXRl
ID0gcGlwZS0+cGxhbmVfc3RhdGUtPmZsaXBfaW1tZWRpYXRlOwo+Cj4gKyAgICAgICBpZiAoZmxp
cF9pbW1lZGlhdGUgJiYgbG9jaykgewo+ICsgICAgICAgICAgICAgICBjb25zdCBpbnQgVElNRU9V
VF9GT1JfRkxJUF9QRU5ESU5HID0gMTAwMDAwOwo+ICsgICAgICAgICAgICAgICBpbnQgaTsKPiAr
Cj4gKyAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBUSU1FT1VUX0ZPUl9GTElQX1BFTkRJ
Tkc7ICsraSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICghcGlwZS0+cGxhbmVfcmVz
Lmh1YnAtPmZ1bmNzLT5odWJwX2lzX2ZsaXBfcGVuZGluZyhwaXBlLT5wbGFuZV9yZXMuaHVicCkp
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiArICAgICAgICAgICAg
ICAgICAgICAgICB1ZGVsYXkoMSk7Cj4gKyAgICAgICAgICAgICAgIH0KPiArCj4gKyAgICAgICAg
ICAgICAgIGlmIChwaXBlLT5ib3R0b21fcGlwZSAhPSBOVUxMKSB7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZm9yIChpID0gMDsgaSA8IFRJTUVPVVRfRk9SX0ZMSVBfUEVORElORzsgKytpKSB7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXBpcGUtPmJvdHRvbV9waXBl
LT5wbGFuZV9yZXMuaHVicC0+ZnVuY3MtPmh1YnBfaXNfZmxpcF9wZW5kaW5nKHBpcGUtPmJvdHRv
bV9waXBlLT5wbGFuZV9yZXMuaHVicCkpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWRlbGF5
KDEpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgfQo+ICsg
ICAgICAgfQo+ICsKPiAgICAgICAgIC8qIEluIGZsaXAgaW1tZWRpYXRlIGFuZCBwaXBlIHNwbGl0
dGluZyBjYXNlLCB3ZSBuZWVkIHRvIHVzZSBHU0wKPiAgICAgICAgICAqIGZvciBzeW5jaHJvbml6
YXRpb24uIE9ubHkgZG8gc2V0dXAgb24gbG9ja2luZyBhbmQgb24gZmxpcCB0eXBlIGNoYW5nZS4K
PiAgICAgICAgICAqLwo+IC0tCj4gMi4yMy4wCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
