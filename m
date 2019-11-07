Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F245FC5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 14:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AB22087E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 14:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AB22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319926F6A6;
	Thu,  7 Nov 2019 14:07:50 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2395E6EE43;
 Thu,  7 Nov 2019 14:07:48 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id a15so3145467wrf.9;
 Thu, 07 Nov 2019 06:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PTywv80NEZbqmKrsCN99sUyzwSw8P4E16Qbj+l/wvLg=;
 b=PU4c/BNM9i5RxqZ8ViuqdEnwbAwGW9aNnyTpIulGMzJA8NTSDP1sHENRho0qo3usbL
 oHogmnYK7YLqpD5eki674c8vSTtn+HBbjDjxL2DoAqQcBm+nm9thKhySPoFu/GLfrSvd
 ebGHFBQ6zR5FXsoJsJ9PTygQAZdF6lkTM3lAPZvYYwJu6byG9jDgzR6SHtn6gsoifZ6M
 EJc0ydZKkS4M3Uh1ky5qn2mwevWxdSxokQzivsCwmKUgniwS9LIFnMkdAOax7Y65jzOP
 J68Q0l7Y5rsfmWYrIvyh640w1BiF8JuBUo2Ofnvzty+kjEnBQhpEDMu711CGuZrDH1Xy
 gt4g==
X-Gm-Message-State: APjAAAXGfHN+MmYNSzjLLcMJ1tZudp2Yq9EmyN3MjpBPTrJfSWjToc0n
 ZBt7eqnsqIcC+0OkCv0T5vpc9DzH89Z69UgFOHpgaQ==
X-Google-Smtp-Source: APXvYqxuM5pVBSxldfZaR64OjJjFTXjeX9cqOFvc5W7rSXDrmRviX5PSwATgHJpYW29LeKCF7QnD2/EJ66d+pqhunJ8=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr3220708wrw.206.1573135666657; 
 Thu, 07 Nov 2019 06:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20191107120118.2825-1-christian.koenig@amd.com>
 <20191107120118.2825-2-christian.koenig@amd.com>
 <2f51742d-a89c-c1a7-2df9-86158bc5b3d4@gmail.com>
In-Reply-To: <2f51742d-a89c-c1a7-2df9-86158bc5b3d4@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Nov 2019 09:07:34 -0500
Message-ID:
 <CADnq5_N+8UhMkV5UD-j62QCMO=k+eB4aO5WCRQFs4cKmgLkTnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: finally fix the racy VMA setup
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PTywv80NEZbqmKrsCN99sUyzwSw8P4E16Qbj+l/wvLg=;
 b=ebbISCWzfhTGeuct4dHsoaDw4a4rN6NRZAbYzhTPzkkb11eeGmbZz5pLITUaIXjqPX
 YRK2TUmeMyHV5KsYz3cFuVur2yqmTT8diLUY93OGpP0zRFJGqpULQBykEEt0dySW9e3D
 hFYJzBKx2UVvFxgPZTjPi0/AJn+ymDTmNs98VQ1NrNHIDFHeeKQjU/kDkCOQsDL/9s6y
 xPkG1B+dEvQl2Lv6lDijG0cGHmfa1jRwzvKWVzQPtmrZVf93NXBj1ZR2bG3oFIlApiIX
 r12qvxAWWTkTu5/6WgVsggb5N5bi3MmTDw3GHKbGcfo8OB3HoH0zWUV6pWCt5v+cIuz4
 zm3w==
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107140734.rIq9sQg8eamlu_MK_BcZJh1kSKc4Z6ix4Ce1HW1HmG4@z>

T24gVGh1LCBOb3YgNywgMjAxOSBhdCA3OjAzIEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IEhleSBBbGV4LAo+Cj4gYW55IG9i
amVjdGlvbnMgdGhhdCBJIG1lcmdlIHRob3NlIHR3byBwYXRjaGVzIHRocm91Z2ggZHJtLW1pc2Mt
bmV4dD8KPgo+IEl0J3MgYSBjbGVhbnVwIEkgd2FudGVkIHRvIGRvIGZvciB5ZWFycyBhbmQgVGhv
bWFzIGZpbmFsbHkgZml4ZWQgdXAgVFRNCj4gZm9yIHRoaXMuCgpGaW5lIHdpdGggbWUuICBTZXJp
ZXMgaXM6CkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Cgo+Cj4gQ2hlZXJzLAo+IENocmlzdGlhbi4KPgo+IEFtIDA3LjExLjE5IHVtIDEzOjAxIHNjaHJp
ZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiA+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPgo+ID4KPiA+IEZpbmFsbHkgY2xlYW4gdXAgdGhlIFZN
QSBzZXR1cCBmb3IgcmFkZW9uIG5vdyB0aGF0IFRUTSBleHBvcnRzIHRoZQo+ID4gbmVjZXNzYXJ5
IGZ1bmN0aW9ucy4KPiA+Cj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZSwgYnV0IG9ubHkgY29tcGls
ZSB0ZXN0ZWQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5n
QGFtZC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRt
LmMgfCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fdHRtLmMKPiA+IGluZGV4IDA5OGJjOWY0MGI5OC4uOTE5OTNhMjMzY2IwIDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jCj4gPiBAQCAtODgxLDkgKzg4
MSw2IEBAIHZvaWQgcmFkZW9uX3R0bV9zZXRfYWN0aXZlX3ZyYW1fc2l6ZShzdHJ1Y3QgcmFkZW9u
X2RldmljZSAqcmRldiwgdTY0IHNpemUpCj4gPiAgICAgICBtYW4tPnNpemUgPSBzaXplID4+IFBB
R0VfU0hJRlQ7Cj4gPiAgIH0KPiA+Cj4gPiAtc3RhdGljIHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0
cnVjdCByYWRlb25fdHRtX3ZtX29wczsKPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IHZtX29wZXJh
dGlvbnNfc3RydWN0ICp0dG1fdm1fb3BzID0gTlVMTDsKPiA+IC0KPiA+ICAgc3RhdGljIHZtX2Zh
dWx0X3QgcmFkZW9uX3R0bV9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKPiA+ICAgewo+ID4g
ICAgICAgc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibzsKPiA+IEBAIC04OTEsMzQgKzg4OCwz
NiBAQCBzdGF0aWMgdm1fZmF1bHRfdCByYWRlb25fdHRtX2ZhdWx0KHN0cnVjdCB2bV9mYXVsdCAq
dm1mKQo+ID4gICAgICAgdm1fZmF1bHRfdCByZXQ7Cj4gPgo+ID4gICAgICAgYm8gPSAoc3RydWN0
IHR0bV9idWZmZXJfb2JqZWN0ICopdm1mLT52bWEtPnZtX3ByaXZhdGVfZGF0YTsKPiA+IC0gICAg
IGlmIChibyA9PSBOVUxMKSB7Cj4gPiArICAgICBpZiAoYm8gPT0gTlVMTCkKPiA+ICAgICAgICAg
ICAgICAgcmV0dXJuIFZNX0ZBVUxUX05PUEFHRTsKPiA+IC0gICAgIH0KPiA+ICsKPiA+ICAgICAg
IHJkZXYgPSByYWRlb25fZ2V0X3JkZXYoYm8tPmJkZXYpOwo+ID4gICAgICAgZG93bl9yZWFkKCZy
ZGV2LT5wbS5tY2xrX2xvY2spOwo+ID4gLSAgICAgcmV0ID0gdHRtX3ZtX29wcy0+ZmF1bHQodm1m
KTsKPiA+ICsgICAgIHJldCA9IHR0bV9ib192bV9mYXVsdCh2bWYpOwo+ID4gICAgICAgdXBfcmVh
ZCgmcmRldi0+cG0ubWNsa19sb2NrKTsKPiA+ICAgICAgIHJldHVybiByZXQ7Cj4gPiAgIH0KPiA+
Cj4gPiArc3RhdGljIHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCByYWRlb25fdHRtX3ZtX29w
cyA9IHsKPiA+ICsgICAgIC5mYXVsdCA9IHJhZGVvbl90dG1fZmF1bHQsCj4gPiArICAgICAub3Bl
biA9IHR0bV9ib192bV9vcGVuLAo+ID4gKyAgICAgLmNsb3NlID0gdHRtX2JvX3ZtX2Nsb3NlLAo+
ID4gKyAgICAgLmFjY2VzcyA9IHR0bV9ib192bV9hY2Nlc3MKPiA+ICt9Owo+ID4gKwo+ID4gICBp
bnQgcmFkZW9uX21tYXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hKQo+ID4gICB7Cj4gPiAgICAgICBpbnQgcjsKPiA+ICAgICAgIHN0cnVjdCBkcm1fZmlsZSAq
ZmlsZV9wcml2ID0gZmlscC0+cHJpdmF0ZV9kYXRhOwo+ID4gICAgICAgc3RydWN0IHJhZGVvbl9k
ZXZpY2UgKnJkZXYgPSBmaWxlX3ByaXYtPm1pbm9yLT5kZXYtPmRldl9wcml2YXRlOwo+ID4KPiA+
IC0gICAgIGlmIChyZGV2ID09IE5VTEwpIHsKPiA+ICsgICAgIGlmIChyZGV2ID09IE5VTEwpCj4g
PiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gLSAgICAgfQo+ID4gKwo+ID4gICAg
ICAgciA9IHR0bV9ib19tbWFwKGZpbHAsIHZtYSwgJnJkZXYtPm1tYW4uYmRldik7Cj4gPiAtICAg
ICBpZiAodW5saWtlbHkociAhPSAwKSkgewo+ID4gKyAgICAgaWYgKHVubGlrZWx5KHIgIT0gMCkp
Cj4gPiAgICAgICAgICAgICAgIHJldHVybiByOwo+ID4gLSAgICAgfQo+ID4gLSAgICAgaWYgKHVu
bGlrZWx5KHR0bV92bV9vcHMgPT0gTlVMTCkpIHsKPiA+IC0gICAgICAgICAgICAgdHRtX3ZtX29w
cyA9IHZtYS0+dm1fb3BzOwo+ID4gLSAgICAgICAgICAgICByYWRlb25fdHRtX3ZtX29wcyA9ICp0
dG1fdm1fb3BzOwo+ID4gLSAgICAgICAgICAgICByYWRlb25fdHRtX3ZtX29wcy5mYXVsdCA9ICZy
YWRlb25fdHRtX2ZhdWx0Owo+ID4gLSAgICAgfQo+ID4gKwo+ID4gICAgICAgdm1hLT52bV9vcHMg
PSAmcmFkZW9uX3R0bV92bV9vcHM7Cj4gPiAgICAgICByZXR1cm4gMDsKPiA+ICAgfQo+Cj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
