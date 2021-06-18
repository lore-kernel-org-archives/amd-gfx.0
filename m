Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A9EC48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 21:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235DB61279
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 21:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235DB61279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEE96EAAF;
	Fri, 18 Jun 2021 21:18:48 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E686EA1F;
 Fri, 18 Jun 2021 21:18:46 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 r14-20020a4ad4ce0000b029024b4146e2f5so1117306oos.1; 
 Fri, 18 Jun 2021 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=i0K+CAkNDpvB9BB97WZi89Hi6upuBxwc1H/Mi+DoJdg=;
 b=fnkDSVaxmmiYYY7PApmGvgt3XGZMKQQuXdKVCe8SV5LmeC02fsTYaSifl9w/lKEHex
 1Z4pBuWzh9z0n4hEZBwZENE71tqMxeS5wpROgfbo1WuaMGjwZPc1kjqx+CjzQMhJysKo
 wnEN6bmn8EindP4YDnEdnDMtpRivzjOF8QCxsz3woF3poD2CS8v7/1Rv15/ISBXBHxht
 Q+ec7OplAgnu7st7fbSptLw3eqt+rjdvA3PtcnFCs3mt0lCh1SDD3DboCKfo/cBzTPhU
 Wd7E19I+l5gfE+AyJC2lQBpO26flNLHi1WG7YivbYHRfepAl0NA1jA/2ZX/E4MEAA6b2
 Ikdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=i0K+CAkNDpvB9BB97WZi89Hi6upuBxwc1H/Mi+DoJdg=;
 b=kv8jB+txElX3DLnSGD0lF5OXq/fCGUvtlFHRq6YKpXsA81PVlrW9KRPChwI7aMeOHj
 zmROBPmepdb6NxT94gYvglQ+od8H03RI3TfEnlUECp4ODGIPvGQrAqDb8odX7d+8J0cp
 0i0TK/Z6ZD3vMNsJgfuIym0mji0VpJVIu0sVp5bajFvpyure18FepJXAYLbPPpmFYZ9z
 tBjSNc8qFJjyivGdmnv2nb01r2vpd/wO1Lu/MuPzZC0YeTZaowLw7tbe3PSigBOCn+Zd
 rJTzCbfogw35WWBM0Hfnuw56jsbftIRKnqEs9p1sdoU1fL6TSL/rtbjP8S6qB1GLE5uz
 QpQg==
X-Gm-Message-State: AOAM530bS+rbsXq0aaTiokHdee+iJYVDhh023Rsbj7n6UWeVw7ZPKpVr
 Bqcr3Cd0WM0yS0cyZKpsNOjtXp1S165jaXdSXnM=
X-Google-Smtp-Source: ABdhPJwAdPB2OKndxiBb3QLHU+rMPZGzghYSrerKY4S9jGUMqziKf7k9wPNnlVoECnFAIi2jVZbvAGsi+JDiVVIGxbk=
X-Received: by 2002:a4a:2242:: with SMTP id z2mr10559229ooe.90.1624051126161; 
 Fri, 18 Jun 2021 14:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <YMxbQXg/Wqm0ACxt@mwanda>
 <fadcee22-d830-c1be-09f0-9788b98c45ec@amd.com>
 <adee15a2-f531-688c-1121-7504163ae441@amd.com>
In-Reply-To: <adee15a2-f531-688c-1121-7504163ae441@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jun 2021 17:18:34 -0400
Message-ID: <CADnq5_MtwTXEv=HitiyBfdSyBb-izSRiR3W=zxKNKRNvxdKO1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_preempt_mgr_new()
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKdW4gMTgsIDIwMjEgYXQgMTE6NDAgQU0gRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1
ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4gQW0gMjAyMS0wNi0xOCB1bSA0OjM5IGEubS4gc2No
cmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+ID4gQW0gMTguMDYuMjEgdW0gMTA6Mzcgc2NocmllYiBE
YW4gQ2FycGVudGVyOgo+ID4+IFRoZXJlIGlzIGEgcmV2ZXJzZWQgaWYgc3RhdGVtZW50IGluIGFt
ZGdwdV9wcmVlbXB0X21ncl9uZXcoKSBzbyBpdAo+ID4+IGFsd2F5cyByZXR1cm5zIC1FTk9NRU0u
Cj4gPj4KPiA+PiBGaXhlczogMDliMDIwYmIwNWE1ICgiTWVyZ2UgdGFnICdkcm0tbWlzYy1uZXh0
LTIwMjEtMDYtMDknIG9mCj4gPj4gZ2l0Oi8vYW5vbmdpdC5mcmVlZGVza3RvcC5vcmcvZHJtL2Ry
bS1taXNjIGludG8gZHJtLW5leHQiKQo+ID4+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIg
PGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KPiA+Cj4gPiBNb3N0IGJlIHNvbWUgZmFsbG91dCBm
cm9tIG1lcmdpbmcgaXQgd2l0aCB0aGUgVFRNIGNoYW5nZXMuCj4gPgo+ID4gQW55d2F5LCBwYXRj
aCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+Cj4gVGhpcyBpcyBvYnZpb3VzbHkgbm90IGZvciBhbWQtc3RhZ2luZy1kcm0tbmV4dC4g
Q2hyaXN0aWFuLCBhcmUgeW91IGdvaW5nCj4gdG8gYXBwbHkgaXQgdG8gdGhlIHJlbGV2YW50IGJy
YW5jaGVzPwoKSSd2ZSBhcHBsaWVkIGl0IHRvIG15IGRybS1uZXh0IGJyYW5jaC4KCkFsZXgKCgo+
Cj4gVGhhbmtzLAo+ICAgRmVsaXgKPgo+Cj4gPgo+ID4gVGhhbmtzLAo+ID4gQ2hyaXN0aWFuLgo+
ID4KPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmVl
bXB0X21nci5jIHwgMiArLQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ByZWVtcHRfbWdyLmMKPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wcmVlbXB0X21nci5jCj4gPj4gaW5kZXggZjZhZmY3Y2U1MTYwLi5kMDJjODYz
N2Y5MDkgMTAwNjQ0Cj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ByZWVtcHRfbWdyLmMKPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHJlZW1wdF9tZ3IuYwo+ID4+IEBAIC03MSw3ICs3MSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X3ByZWVtcHRfbWdyX25ldyhzdHJ1Y3QKPiA+PiB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuLAo+
ID4+ICAgICAgIHN0cnVjdCBhbWRncHVfcHJlZW1wdF9tZ3IgKm1nciA9IHRvX3ByZWVtcHRfbWdy
KG1hbik7Cj4gPj4gICAgICAgICAqcmVzID0ga3phbGxvYyhzaXplb2YoKipyZXMpLCBHRlBfS0VS
TkVMKTsKPiA+PiAtICAgIGlmICgqcmVzKQo+ID4+ICsgICAgaWYgKCEqcmVzKQo+ID4+ICAgICAg
ICAgICByZXR1cm4gLUVOT01FTTsKPiA+PiAgICAgICAgIHR0bV9yZXNvdXJjZV9pbml0KHRibywg
cGxhY2UsICpyZXMpOwo+ID4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
