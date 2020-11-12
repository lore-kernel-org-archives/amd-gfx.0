Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C9EC388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 04:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24508208D5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 04:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iurwi1R3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24508208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680C66E334;
	Fri, 13 Nov 2020 04:34:15 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CA56E0BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 22:10:42 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a3so6781149wmb.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 14:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=0qnbq+VtAYJrqLWmWFv2NmhXM3gXrWp9ucRRD3D1vUY=;
 b=iurwi1R3VHGsEx/f+7EjFPiApRwfwXMCzMmqI1yZLs+X4Wz84WVe3aHLMI4/r074Ik
 1mrFDwWH6SdRYYfV9I8eiEQN03vjyaTp+IGIVjtVhaGB4rpD3Lc/lpl/XPpmkLEayseP
 kj29vLukJL9y/nm+6MCJofb8j136/9ir9GAFOs0xqmKnny1Z4npsaIiZ6x4GvfYEojJr
 Dsv8i0Kj33Z/VBn1IOW8kE+O9qXoxW4ani7DZIQqh1yPZqGEnOXc39ofXOsZqLEeb/aO
 WuVrCpYK9dlpqPUGvwVHdEyEMqls6Cn9Xlc/hypn+WAU3WV67YzLQePmL/AC9lzIS8Vr
 m+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0qnbq+VtAYJrqLWmWFv2NmhXM3gXrWp9ucRRD3D1vUY=;
 b=BYRL9pdr0NkD+Aps4GSEg6LEUBybmPBv29EZlsPuPaxwuRu0DI1HMkSYvTwH5PNfJW
 HySV67wA1GPx5bdAMl0+nug6RNZg74CPnR5JuylFXNTVhN1gYFhTCEk/vs8f+CCMaIuR
 WdBv7HAAEvBm+HzOZhwFrln0YearamntgyjpOC45InW7FmDjVShbJfp2YcYgWO6jskEs
 vgg9GfnHq7OE5ColbwDXKYmlwNATBBP04baVYM8hFp6FrKTFhHc4saeAHwk3LA4xGUkg
 rDA3GWG12lysBuQqAbWdo8LZzWPl8VACH0354ESbaSw+AQg61IOX2Qlc53iJ4YOieo7V
 MUgg==
X-Gm-Message-State: AOAM533hF5HfItZ50Bp2iHXT1H3hfXfNVCIfq4O+lT4SiboQcq/Xs1VI
 e8ZT4M3vR1b3irkbHNa4+E0D0w==
X-Google-Smtp-Source: ABdhPJwXjIC56WmbtyzjCCg4PGgk5NPg/06k7kufDSxq/IJGoMM1EPx00nmBb+swVbwgtTquGjcb0g==
X-Received: by 2002:a05:600c:230e:: with SMTP id
 14mr1731202wmo.119.1605219041178; 
 Thu, 12 Nov 2020 14:10:41 -0800 (PST)
Received: from dell ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id q2sm8388986wru.76.2020.11.12.14.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 14:10:40 -0800 (PST)
Date: Thu, 12 Nov 2020 22:10:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 29/30] drm/amd/amdgpu/atombios_encoders: Remove set but
 unused variable 'backlight_level'
Message-ID: <20201112221038.GC2787115@dell>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-30-lee.jones@linaro.org>
 <CADnq5_MjzzRhu0zwOeefjGP_mJ2tfTVvK1O5x55dE03kRxDa3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_MjzzRhu0zwOeefjGP_mJ2tfTVvK1O5x55dE03kRxDa3Q@mail.gmail.com>
X-Mailman-Approved-At: Fri, 13 Nov 2020 04:34:14 +0000
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
 Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCAxMiBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBUaHUsIE5vdiAx
MiwgMjAyMCBhdCAyOjAxIFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMp
Ogo+ID4KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19lbmNvZGVycy5j
OiBJbiBmdW5jdGlvbiDigJhhbWRncHVfYXRvbWJpb3NfZW5jb2Rlcl9pbml0X2JhY2tsaWdodOKA
mToKPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19lbmNvZGVycy5jOjE3
NDo1OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhiYWNrbGlnaHRfbGV2ZWzigJkgc2V0IGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPiA+Cj4gPiBDYzogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBs
aW51eC5pZT4KPiA+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gPiBDYzog
THViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KPiA+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+ID4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiAt
LS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19lbmNvZGVycy5jIHwg
MyArLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0p
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b21iaW9z
X2VuY29kZXJzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19lbmNvZGVy
cy5jCj4gPiBpbmRleCBmYTgxN2ViZmY5ODA0Li5hZjg3NTA1YWQ3ZDU3IDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZW5jb2RlcnMuYwo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZW5jb2RlcnMuYwo+ID4gQEAg
LTE3MSw3ICsxNzEsNiBAQCB2b2lkIGFtZGdwdV9hdG9tYmlvc19lbmNvZGVyX2luaXRfYmFja2xp
Z2h0KHN0cnVjdCBhbWRncHVfZW5jb2RlciAqYW1kZ3B1X2VuY29kZQo+ID4gICAgICAgICBzdHJ1
Y3QgYmFja2xpZ2h0X3Byb3BlcnRpZXMgcHJvcHM7Cj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVf
YmFja2xpZ2h0X3ByaXZkYXRhICpwZGF0YTsKPiA+ICAgICAgICAgc3RydWN0IGFtZGdwdV9lbmNv
ZGVyX2F0b21fZGlnICpkaWc7Cj4gPiAtICAgICAgIHU4IGJhY2tsaWdodF9sZXZlbDsKPiA+ICAg
ICAgICAgY2hhciBibF9uYW1lWzE2XTsKPiA+Cj4gPiAgICAgICAgIC8qIE1hYyBsYXB0b3BzIHdp
dGggbXVsdGlwbGUgR1BVcyB1c2UgdGhlIGdtdXggZHJpdmVyIGZvciBiYWNrbGlnaHQKPiA+IEBA
IC0yMDcsNyArMjA2LDcgQEAgdm9pZCBhbWRncHVfYXRvbWJpb3NfZW5jb2Rlcl9pbml0X2JhY2ts
aWdodChzdHJ1Y3QgYW1kZ3B1X2VuY29kZXIgKmFtZGdwdV9lbmNvZGUKPiA+Cj4gPiAgICAgICAg
IHBkYXRhLT5lbmNvZGVyID0gYW1kZ3B1X2VuY29kZXI7Cj4gPgo+ID4gLSAgICAgICBiYWNrbGln
aHRfbGV2ZWwgPSBhbWRncHVfYXRvbWJpb3NfZW5jb2Rlcl9nZXRfYmFja2xpZ2h0X2xldmVsX2Zy
b21fcmVnKGFkZXYpOwo+ID4gKyAgICAgICBhbWRncHVfYXRvbWJpb3NfZW5jb2Rlcl9nZXRfYmFj
a2xpZ2h0X2xldmVsX2Zyb21fcmVnKGFkZXYpOwo+IAo+IFdlIGNhbiBkcm9wIHRoaXMgZnVuY3Rp
b24gY2FsbCBhbHRvZ2V0aGVyLiAgV2UgY2FsbCBpdCBhZ2FpbiBiZWxvdyBpbmRpcmVjdGx5LgoK
V2lsbCBkbywgdGhhbmtzLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5pb3IgVGVjaG5p
Y2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ug
c29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8
IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
