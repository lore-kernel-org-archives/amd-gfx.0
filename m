Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF00C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137CD206C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Hn3cSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137CD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92B56EA20;
	Fri, 22 May 2020 18:05:33 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AED86E0E4;
 Fri, 22 May 2020 18:05:33 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id x14so5637998wrp.2;
 Fri, 22 May 2020 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HnUAvj8/hcOeu5wap80XKbA2U7OiBYgIef/CmYB0LcE=;
 b=n8Hn3cSXEhsGcYzPiRk9a13J/yYmoVNORbpdvW9NQCNH6z9492FBfQQulIHSIDwPg5
 /RuLl/aQv0LTnd1zyykYtcH3rsySaVW0dGkgmb66yMgVL9VjWhT29Sg9eR6QL9CHihc3
 ZC6ZPAMFqucNMcTvYl3Wasaa3dnmthhWqCOzPvUdBhFd0OUoc6e9znj0JNkb4F9LrYHb
 LeIN9HXGpwGZBuhEJiunQleQS18juPyCWrOZh50rzawJTiikOa/HHwFdPhIuapqPyUKj
 9oXhth3/2P682nA1JUyPhYoEQpSHewlsrd5tU4WhiNJKfAcIwxe72HMlBzqvjc5j9AFx
 er/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HnUAvj8/hcOeu5wap80XKbA2U7OiBYgIef/CmYB0LcE=;
 b=hr8Uksp8JzQ9iHzF8cqDwBPX4q8fKbZ8ZAUvk/KxhbQZcktC/oTituGEOHz81NUY8v
 YmB9uXhJ93O1O1c/3rPnw/qeOC3FulVmNxy8bRS0Iy9J4py+0cbhjN7JtWk54sLoHFNn
 JwAtv1fpAM9pD/aTtVxEBoAOAWPEfxK4P5ZGdERKlUCtAnoMvCd+ACtOp3kvGXtQQKoH
 wAJoJxPSdp/QVIlvytAO5stYSOX8cDMuz1OY0ctxCY68ElbcRWpSfZgO7unQvui0j270
 kcpcWNOjrFLFRYxg7D2bfItxGPw4s0JuwzL+BYfkhwecH9y/WxP2UXDIPrPg8mrb73ZJ
 KLXw==
X-Gm-Message-State: AOAM532Q/lj2DSAUhhgtHu+UjPP5c1tSC7Z1ToUK64eGESl0ZC5wj7/W
 7OrZBdKN3VwLmZD9oUGxgHd3W0UgQ1W49ds9wAY=
X-Google-Smtp-Source: ABdhPJzVEjF74Bvg+XdgYHXOPimWqs5bnL8Tj6Gf7h9YyFb5zQutmPwsVRo8Is5UeRZFmtUyDVFernc7M55zUnleyvY=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr4569405wrp.419.1590170731715; 
 Fri, 22 May 2020 11:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200522173419.GA2297@embeddedor>
In-Reply-To: <20200522173419.GA2297@embeddedor>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 May 2020 14:05:20 -0400
Message-ID: <CADnq5_Ncx8sa5Z_qykbiXVGPJ0WfwHLsCm45mZFYg=-ciBMxdA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon/dpm: Replace one-element array and use
 struct_size() helper
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBNYXkgMjIsIDIwMjAgYXQgMToyOSBQTSBHdXN0YXZvIEEuIFIuIFNpbHZhCjxndXN0
YXZvYXJzQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gVGhlIGN1cnJlbnQgY29kZWJhc2UgbWFrZXMg
dXNlIG9mIG9uZS1lbGVtZW50IGFycmF5cyBpbiB0aGUgZm9sbG93aW5nCj4gZm9ybToKPgo+IHN0
cnVjdCBzb21ldGhpbmcgewo+ICAgICBpbnQgbGVuZ3RoOwo+ICAgICB1OCBkYXRhWzFdOwo+IH07
Cj4KPiBzdHJ1Y3Qgc29tZXRoaW5nICppbnN0YW5jZTsKPgo+IGluc3RhbmNlID0ga21hbGxvYyhz
aXplb2YoKmluc3RhbmNlKSArIHNpemUsIEdGUF9LRVJORUwpOwo+IGluc3RhbmNlLT5sZW5ndGgg
PSBzaXplOwo+IG1lbWNweShpbnN0YW5jZS0+ZGF0YSwgc291cmNlLCBzaXplKTsKPgo+IGJ1dCB0
aGUgcHJlZmVycmVkIG1lY2hhbmlzbSB0byBkZWNsYXJlIHZhcmlhYmxlLWxlbmd0aCB0eXBlcyBz
dWNoIGFzCj4gdGhlc2Ugb25lcyBpcyBhIGZsZXhpYmxlIGFycmF5IG1lbWJlclsxXVsyXSwgaW50
cm9kdWNlZCBpbiBDOTk6Cj4KPiBzdHJ1Y3QgZm9vIHsKPiAgICAgICAgIGludCBzdHVmZjsKPiAg
ICAgICAgIHN0cnVjdCBib28gYXJyYXlbXTsKPiB9Owo+Cj4gQnkgbWFraW5nIHVzZSBvZiB0aGUg
bWVjaGFuaXNtIGFib3ZlLCB3ZSB3aWxsIGdldCBhIGNvbXBpbGVyIHdhcm5pbmcKPiBpbiBjYXNl
IHRoZSBmbGV4aWJsZSBhcnJheSBkb2VzIG5vdCBvY2N1ciBsYXN0IGluIHRoZSBzdHJ1Y3R1cmUs
IHdoaWNoCj4gd2lsbCBoZWxwIHVzIHByZXZlbnQgc29tZSBraW5kIG9mIHVuZGVmaW5lZCBiZWhh
dmlvciBidWdzIGZyb20gYmVpbmcKPiBpbmFkdmVydGVudGx5IGludHJvZHVjZWRbM10gdG8gdGhl
IGNvZGViYXNlIGZyb20gbm93IG9uLiBTbywgcmVwbGFjZQo+IHRoZSBvbmUtZWxlbWVudCBhcnJh
eSB3aXRoIGEgZmxleGlibGUtYXJyYXkgbWVtYmVyLgo+Cj4gQWxzbywgbWFrZSB1c2Ugb2YgdGhl
IG5ldyBzdHJ1Y3Rfc2l6ZSgpIGhlbHBlciB0byBwcm9wZXJseSBjYWxjdWxhdGUgdGhlCj4gc2l6
ZSBvZiBzdHJ1Y3QgTklTTEFORFNfU01DX1NXU1RBVEUuCj4KPiBUaGlzIGlzc3VlIHdhcyBmb3Vu
ZCB3aXRoIHRoZSBoZWxwIG9mIENvY2NpbmVsbGUgYW5kLCBhdWRpdGVkIGFuZCBmaXhlZAo+IF9t
YW51YWxseV8uCj4KPiBbMV0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy9aZXJv
LUxlbmd0aC5odG1sCj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy8y
MQo+IFszXSBjb21taXQgNzY0OTc3MzI5MzJmICgiY3hnYjMvbDJ0OiBGaXggdW5kZWZpbmVkIGJl
aGF2aW91ciIpCj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rh
dm9hcnNAa2VybmVsLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+IENoYW5n
ZXMgaW4gdjI6Cj4gIC0gVXNlIHR5cGUgc2l6ZV90IGluc3RlYWQgb2YgdTE2IGZvciBzdGF0ZV9z
aXplIHZhcmlhYmxlLgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5oIHwg
MiArLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RwbS5jICAgICB8IDcgKysrKy0tLQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5oCj4gaW5kZXggNmI3ZDI5MmI5MTlmMy4uYmMwYmU2
ODE4ZTIxOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0u
aAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5oCj4gQEAgLTc4MSw3
ICs3ODEsNyBAQCBzdHJ1Y3QgTklTTEFORFNfU01DX1NXU1RBVEUKPiAgICAgIHVpbnQ4X3QgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGxldmVsQ291bnQ7Cj4gICAgICB1aW50OF90ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBwYWRkaW5nMjsKPiAgICAgIHVpbnQ4X3QgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBhZGRpbmczOwo+IC0gICAgTklTTEFORFNfU01DX0hXX1BFUkZP
Uk1BTkNFX0xFVkVMICAgbGV2ZWxzWzFdOwo+ICsgICAgTklTTEFORFNfU01DX0hXX1BFUkZPUk1B
TkNFX0xFVkVMICAgbGV2ZWxzW107Cj4gIH07Cj4KPiAgdHlwZWRlZiBzdHJ1Y3QgTklTTEFORFNf
U01DX1NXU1RBVEUgTklTTEFORFNfU01DX1NXU1RBVEU7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vbmlfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RwbS5j
Cj4gaW5kZXggYjU3YzM3ZGRkMTY0Yy4uYWJiNjM0NWJmYWUzMiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RwbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9uaV9kcG0uYwo+IEBAIC0yNjg1LDExICsyNjg1LDEyIEBAIHN0YXRpYyBpbnQgbmlfdXBsb2Fk
X3N3X3N0YXRlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LAo+ICAgICAgICAgc3RydWN0IHJ2
N3h4X3Bvd2VyX2luZm8gKnBpID0gcnY3NzBfZ2V0X3BpKHJkZXYpOwo+ICAgICAgICAgdTE2IGFk
ZHJlc3MgPSBwaS0+c3RhdGVfdGFibGVfc3RhcnQgKwo+ICAgICAgICAgICAgICAgICBvZmZzZXRv
ZihOSVNMQU5EU19TTUNfU1RBVEVUQUJMRSwgZHJpdmVyU3RhdGUpOwo+IC0gICAgICAgdTE2IHN0
YXRlX3NpemUgPSBzaXplb2YoTklTTEFORFNfU01DX1NXU1RBVEUpICsKPiAtICAgICAgICAgICAg
ICAgKChOSVNMQU5EU19NQVhfU01DX1BFUkZPUk1BTkNFX0xFVkVMU19QRVJfU1dTVEFURSAtIDEp
ICogc2l6ZW9mKE5JU0xBTkRTX1NNQ19IV19QRVJGT1JNQU5DRV9MRVZFTCkpOwo+ICsgICAgICAg
TklTTEFORFNfU01DX1NXU1RBVEUgKnNtY19zdGF0ZTsKPiArICAgICAgIHNpemVfdCBzdGF0ZV9z
aXplID0gc3RydWN0X3NpemUoc21jX3N0YXRlLCBsZXZlbHMsCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgTklTTEFORFNfTUFYX1NNQ19QRVJGT1JNQU5DRV9MRVZFTFNfUEVSX1NXU1RBVEUpOwo+
ICAgICAgICAgaW50IHJldDsKPiAtICAgICAgIE5JU0xBTkRTX1NNQ19TV1NUQVRFICpzbWNfc3Rh
dGUgPSBremFsbG9jKHN0YXRlX3NpemUsIEdGUF9LRVJORUwpOwo+Cj4gKyAgICAgICBzbWNfc3Rh
dGUgPSBremFsbG9jKHN0YXRlX3NpemUsIEdGUF9LRVJORUwpOwo+ICAgICAgICAgaWYgKHNtY19z
dGF0ZSA9PSBOVUxMKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPgo+IC0tCj4g
Mi4yNi4yCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
