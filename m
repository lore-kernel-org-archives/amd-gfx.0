Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F63C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 15:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B086261360
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 15:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B086261360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739956EA66;
	Tue, 25 May 2021 15:38:59 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9DFD6EA66;
 Tue, 25 May 2021 15:38:58 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so4686635otl.3; 
 Tue, 25 May 2021 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G29C7319Dv2jp3aawArMwM12C1t7ygPQnrD+x7K3emo=;
 b=KU7xaHHWx+wjYxjyiCHaCZEWUPHeUexy/WMEsPCmjL8AAcOY6Vq2QpeGYW0xF87Ll7
 q261c+N8lKPgZf/XwQ7j7x3C6Qa6A12CgzAe3UzfA2ubPMbkB1zFND9rE4wuz9ScI9+J
 agYywA53hAc2mlCHM4WT2j/Y1/8PaTyCaXJMDwnj9xHnIl/jxyOV6TuuFx1Vk6Z+b0nz
 l/ha/d3NccEWuIY09x7gkQPjt9pmGPRYLH+KxlE2+Z6ZSQqlYUIedi/QPpWaGTKOTfqO
 S+AvIR8SGj09nK1ODGEOX5JoJS05lrzwrYIAvbnJAF6ZkmkyKm18LulSYjCIKAWTsTT3
 jkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G29C7319Dv2jp3aawArMwM12C1t7ygPQnrD+x7K3emo=;
 b=Ugruow4qjoYx0KmJ8wTDBxMowtOwDfZGhGKBr6bNW+wpF7GILvI0JHrmPLVLEt74Pz
 Q/qTqA44hdm+CB4x9tChZtlHJlsCSrwROKB6hbVp221DOncklVFgCzQaG5/GbHM0i1SR
 v2XMRQDU6z0wv0s4fvcLKRMUZzxrJiRDAsHU9WoEo0yFOiT2Fn2D9nFJ6+iQ9vWPa4nL
 vxFvTiPjtttlrE58nShG3k9hH37Y7aTanNLwr5rNXdtL+wT2Pg2tPpzQe4xm78lBlXNH
 TpQ4/6PdRBA1066Vj6K9hnDhfy9bXyUvK1KAf/hPhr/rkZMCt9L3AUSd5pkMJ1xbuN75
 0J9Q==
X-Gm-Message-State: AOAM531G8JIkUxCYvqdjJIsVtb+dft8e92ujET9EoJBSe6WIS9szqC8Y
 gVtREo3spj5fsuDBzvmYafDmiH/ohQl4YtuUocs=
X-Google-Smtp-Source: ABdhPJyGNsx4a/dIqRXAcEEjQuHqAgdTAML8/MtCbrWA0+YY4Kkwm24gxdVHMVAyL+bFEaY7hRXemO0XzttpEfnPt+s=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr24158328otl.132.1621957138307; 
 Tue, 25 May 2021 08:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <1621853213-55876-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <CADnq5_N3WkoYHcn8b1-qZ23+t=E9xxV5fV_1Lwqck6x2dUPqmA@mail.gmail.com>
 <950d5d2a-c01f-35d4-0933-04cae2c4984d@gmail.com>
In-Reply-To: <950d5d2a-c01f-35d4-0933-04cae2c4984d@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 May 2021 11:38:47 -0400
Message-ID: <CADnq5_PgmZMTOKGSt29_MkonMaf5exgBy1VUgHyd14dKT+_13A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unreachable code
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBNYXkgMjUsIDIwMjEgYXQgMTE6MjcgQU0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gQW0gMjQuMDUuMjEgdW0gMjA6
NDggc2NocmllYiBBbGV4IERldWNoZXI6Cj4gPiBBcHBsaWVkLiAgVGhhbmtzIQo+Cj4gT2ssIHRo
YXQncyB1bmZvcnR1bmF0ZS4KPgo+IElJUkMgd2UgYWRkZWQgdGhlIGNvZGUgYmVjYXVzZSBvZiBh
IGRpZmZlcmVudCBjb21waWxlciB3YXJuaW5nLgo+CgpJIGNhbiByZXZlcnQgaXQuCgpBbGV4Cgo+
IENocmlzdGlhbi4KPgo+ID4KPiA+IEFsZXgKPiA+Cj4gPiBPbiBNb24sIE1heSAyNCwgMjAyMSBh
dCA2OjQ3IEFNIEppYXBlbmcgQ2hvbmcKPiA+IDxqaWFwZW5nLmNob25nQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+PiBJbiB0aGUgZnVuY3Rpb24gYW1kZ3B1X3V2ZF9jc19tc2coKSwgZXZl
cnkgYnJhbmNoIGluIHRoZSBzd2l0Y2gKPiA+PiBzdGF0ZW1lbnQgd2lsbCBoYXZlIGEgcmV0dXJu
LCBzbyB0aGUgY29kZSBiZWxvdyB0aGUgc3dpdGNoIHN0YXRlbWVudAo+ID4+IHdpbGwgbm90IGJl
IGV4ZWN1dGVkLgo+ID4+Cj4gPj4gRWxpbWluYXRlIHRoZSBmb2xsb3cgc21hdGNoIHdhcm5pbmc6
Cj4gPj4KPiA+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmM6ODQ1IGFt
ZGdwdV91dmRfY3NfbXNnKCkgd2FybjoKPiA+PiBpZ25vcmluZyB1bnJlYWNoYWJsZSBjb2RlLgo+
ID4+Cj4gPj4gUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51eC5hbGliYWJhLmNv
bT4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBKaWFwZW5nIENob25nIDxqaWFwZW5nLmNob25nQGxpbnV4
LmFsaWJhYmEuY29tPgo+ID4+IC0tLQo+ID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3V2ZC5jIHwgMiAtLQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0p
Cj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3V2ZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCj4gPj4gaW5k
ZXggODJmMDU0Mi4uMzc1YjM0NiAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXZkLmMKPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXZkLmMKPiA+PiBAQCAtODQyLDggKzg0Miw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X3V2ZF9jc19tc2coc3RydWN0IGFtZGdwdV91dmRfY3NfY3R4ICpjdHgsCj4gPj4gICAgICAgICAg
ICAgICAgICBEUk1fRVJST1IoIklsbGVnYWwgVVZEIG1lc3NhZ2UgdHlwZSAoJWQpIVxuIiwgbXNn
X3R5cGUpOwo+ID4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPj4gICAgICAg
ICAgfQo+ID4+IC0gICAgICAgQlVHKCk7Cj4gPj4gLSAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+
PiAgIH0KPiA+Pgo+ID4+ICAgLyoqCj4gPj4gLS0KPiA+PiAxLjguMy4xCj4gPj4KPiA+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
