Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C338AC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 09:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F0B20674
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 09:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F0B20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E056F50A;
	Fri, 22 Nov 2019 09:17:40 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970C86F50A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 09:17:38 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id z25so5590159oti.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 01:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pzjjzH4UgTeG40VA2UV6AHDBfr0Ocw4jXqlZWXYFvJ8=;
 b=EQpdEOdfwXlwsx3RPAhBKIQocrCvX6D3EGmmATgPzXr19shIr0UpcZPA9uwnBaEUUW
 0jZObkvgkXCmhddp2DUh5Mh1EbvuiQOj9bKIN8q7LdKV1fTdhftuMyOkUlSQ5GSDD3g9
 CqMqoQUcf+7EkO+3GRAyA39fKbHriEXTJuHeLD3EtBP3i96u5tr7iYyQy8jkVaT4yzC8
 Ncz+VO1kYlXky3GpI/AzI0BJ71j6yZeOJPHpID4d8U4TgdiiBKsgkvkSUSRPL7ubl9DX
 tqIm5r9wcmCaJnMSVmKxNZ6RhFTCD6v/sOkx5KIUtHRWs1u7Vebe29J1kjwXKfhZ/vK2
 3jgw==
X-Gm-Message-State: APjAAAWryE3xPT4L2aVEBdzj13L8e4+yDiW4GQUCQt/PZX0/pWsQPf92
 d4N9UmAcJRlIRhYYClVv6vkOPdwLc7ZefJAgvIXAwg==
X-Google-Smtp-Source: APXvYqyhv427Hxx7/MmUbtqChclXEe6nJWw6xg1yaWUV406sDc3FO9lJ2GvjbigdCij390dY9m18ZCX2Ku6kj6cEKso=
X-Received: by 2002:a05:6830:1649:: with SMTP id
 h9mr10352872otr.281.1574414257767; 
 Fri, 22 Nov 2019 01:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20191122063749.27113-1-kraxel@redhat.com>
 <20191122063749.27113-3-kraxel@redhat.com>
In-Reply-To: <20191122063749.27113-3-kraxel@redhat.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 22 Nov 2019 10:17:27 +0100
Message-ID:
 <CAKMK7uFz3hmPT3OE8UtUQwmv+tXsjazUWT2RVHLxAq47X+EaXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm: share address space for dma bufs
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=pzjjzH4UgTeG40VA2UV6AHDBfr0Ocw4jXqlZWXYFvJ8=;
 b=PuTHrRo6gLJNu4P4PUUZivkRf9R8+X7UdnrZdLbDNmrrt/TpJ5FOmxGiHBbktnLk7p
 0L/NwFPVLdJbjnvUE+rXbTFVQk2JD4/qkscDImWPNAQqc2A2LZeJ94l8S2wH6NIG/TjM
 Lguv1/sk/Rm80MHeMl/ogckNAQlZmDWVrIRac=
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
Cc: Rob Herring <robh@kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, intel-gfx <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <mripard@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122091727.UgQa4974mD3UA9dUxA5O2edSveCR2CDzmaOIcRFjMmw@z>

T24gRnJpLCBOb3YgMjIsIDIwMTkgYXQgNzozNyBBTSBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBVc2UgdGhlIHNoYXJlZCBhZGRyZXNzIHNwYWNlIG9mIHRoZSBk
cm0gZGV2aWNlIChzZWUgZHJtX29wZW4oKSBpbgo+IGRybV9maWxlLmMpIGZvciBkbWEtYnVmcyB0
b28uICBUaGF0IHJlbW92ZXMgYSBkaWZmZXJlbmNlIGJldHdlZW0gZHJtCj4gZGV2aWNlIG1tYXAg
dm1hcyBhbmQgZG1hLWJ1ZiBtbWFwIHZtYXMgYW5kIGZpeGVzIGNvcm5lciBjYXNlcyBsaWtlCj4g
ZHJvcHBpbmcgcHRlcyAodXNpbmcgbWFkdmlzZShET05UTkVFRCkgZm9yIGV4YW1wbGUpIG5vdCB3
b3JraW5nCj4gcHJvcGVybHkuCj4KPiBBbHNvIHJlbW92ZSBhbWRncHUgZHJpdmVyJ3MgcHJpdmF0
ZSBkbWFidWYgdXBkYXRlLiAgSXQgaXMgbm90IG5lZWRlZAo+IGFueSBtb3JlIG5vdyB0aGF0IHdl
IGFyZSBkb2luZyB0aGlzIGZvciBldmVyeWJvZHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBHZXJkIEhv
ZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KClJldmlld2VkLWJ5OiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWwudmV0dGVyQGZmd2xsLmNoPgoKQnV0IEkgdGhpbmsgeW91IHdhbnQgYXQgbGVhc3QgYW4g
YWNrIGZyb20gYW1kIGd1eXMgZm9yIGRvdWJsZSBjaGVja2luZyBoZXJlLgotRGFuaWVsCj4gLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgfCA0ICstLS0K
PiAgZHJpdmVycy9ncHUvZHJtL2RybV9wcmltZS5jICAgICAgICAgICAgICAgICB8IDQgKysrLQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYwo+IGluZGV4IGQ1YmNk
ZmVmYmFkNi4uNTg2ZGI0ZmI0NmJkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZG1hX2J1Zi5jCj4gQEAgLTM2MSwxMCArMzYxLDggQEAgc3RydWN0IGRtYV9idWYg
KmFtZGdwdV9nZW1fcHJpbWVfZXhwb3J0KHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ29iaiwKPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVQRVJNKTsKPgo+ICAgICAgICAgYnVmID0g
ZHJtX2dlbV9wcmltZV9leHBvcnQoZ29iaiwgZmxhZ3MpOwo+IC0gICAgICAgaWYgKCFJU19FUlIo
YnVmKSkgewo+IC0gICAgICAgICAgICAgICBidWYtPmZpbGUtPmZfbWFwcGluZyA9IGdvYmotPmRl
di0+YW5vbl9pbm9kZS0+aV9tYXBwaW5nOwo+ICsgICAgICAgaWYgKCFJU19FUlIoYnVmKSkKPiAg
ICAgICAgICAgICAgICAgYnVmLT5vcHMgPSAmYW1kZ3B1X2RtYWJ1Zl9vcHM7Cj4gLSAgICAgICB9
Cj4KPiAgICAgICAgIHJldHVybiBidWY7Cj4gIH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9wcmltZS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9wcmltZS5jCj4gaW5kZXggYTk2
MzNiZDI0MWJiLi5jM2ZjMzQxNDUzYzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ry
bV9wcmltZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9wcmltZS5jCj4gQEAgLTI0MCw2
ICsyNDAsNyBAQCB2b2lkIGRybV9wcmltZV9kZXN0cm95X2ZpbGVfcHJpdmF0ZShzdHJ1Y3QgZHJt
X3ByaW1lX2ZpbGVfcHJpdmF0ZSAqcHJpbWVfZnByaXYpCj4gIHN0cnVjdCBkbWFfYnVmICpkcm1f
Z2VtX2RtYWJ1Zl9leHBvcnQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFfYnVmX2V4cG9ydF9pbmZvICpleHBf
aW5mbykKPiAgewo+ICsgICAgICAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSBleHBfaW5m
by0+cHJpdjsKPiAgICAgICAgIHN0cnVjdCBkbWFfYnVmICpkbWFfYnVmOwo+Cj4gICAgICAgICBk
bWFfYnVmID0gZG1hX2J1Zl9leHBvcnQoZXhwX2luZm8pOwo+IEBAIC0yNDcsNyArMjQ4LDggQEAg
c3RydWN0IGRtYV9idWYgKmRybV9nZW1fZG1hYnVmX2V4cG9ydChzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2LAo+ICAgICAgICAgICAgICAgICByZXR1cm4gZG1hX2J1ZjsKPgo+ICAgICAgICAgZHJtX2Rl
dl9nZXQoZGV2KTsKPiAtICAgICAgIGRybV9nZW1fb2JqZWN0X2dldChleHBfaW5mby0+cHJpdik7
Cj4gKyAgICAgICBkcm1fZ2VtX29iamVjdF9nZXQob2JqKTsKPiArICAgICAgIGRtYV9idWYtPmZp
bGUtPmZfbWFwcGluZyA9IG9iai0+ZGV2LT5hbm9uX2lub2RlLT5pX21hcHBpbmc7Cj4KPiAgICAg
ICAgIHJldHVybiBkbWFfYnVmOwo+ICB9Cj4gLS0KPiAyLjE4LjEKPgoKCi0tIApEYW5pZWwgVmV0
dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgorNDEgKDApIDc5IDM2NSA1
NyA0OCAtIGh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
