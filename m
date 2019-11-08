Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87CEFA372C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 13:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C2B206A3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 13:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C2B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F386F986;
	Fri,  8 Nov 2019 13:11:46 +0000 (UTC)
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com
 [IPv6:2607:f8b0:4864:20::a42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513356F984;
 Fri,  8 Nov 2019 13:11:45 +0000 (UTC)
Received: by mail-vk1-xa42.google.com with SMTP id k24so1460082vko.7;
 Fri, 08 Nov 2019 05:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BM/azPPQPov7fAdWwUi35YWrQ2EMZSUuci26TPJ1gZM=;
 b=fkiZmvxlvkOAljr33HBgCFGNsDqkXHSOhHRBHPKwoMG0btF9ZGd8mD0n8IPfJ061nO
 b6yQKg18I46ll6IQFKDYQY4lwsCcW370MtY36GGK4Gb5F91Plmh3av1ESz7mgpGK8fr0
 aNf4Vh2X00ZY6tnZCXOQFrANTKgAmUFcdIG+WZ9w6ERSt1ngvob0VqTPvPGIP1iwkvga
 4k1kcAkLU+60rRfXI7e52a3mSd/S7mqj1uXBoBHYabI+BRsp3Jguu5+UXvR1NiDG9m8p
 sSNseWyZ4D3Yi5nB8cmuNvhIhZiEo/pB+n0IgLKaNU2DFBkTJK3L6KBItwe8AhYlGb3Q
 aYUw==
X-Gm-Message-State: APjAAAVzL0htSB/Nv5MVSb4FSccugEdG3hoCT9F+5/W4DIT63x5fCXci
 wO93/qA6eIjKvoAglk3TpRsCfitTPeBkgxIkZUqG4Q==
X-Google-Smtp-Source: APXvYqx2azUzl4dgjIi3IR9HBF9ysBALiVjpt1oUTP5As5IVlUXq8ynTY7LY14QQkAjU5M2/YxJGtC3loWUxcufdlsU=
X-Received: by 2002:a1f:e0c2:: with SMTP id x185mr7313975vkg.6.1573218704038; 
 Fri, 08 Nov 2019 05:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20191101130313.8862-1-emil.l.velikov@gmail.com>
 <20191101130313.8862-5-emil.l.velikov@gmail.com>
In-Reply-To: <20191101130313.8862-5-emil.l.velikov@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 8 Nov 2019 13:11:26 +0000
Message-ID:
 <CACvgo50f6DTV+U1HVKM9dcDAhbbBVb=nZjF3+KZ2iLH7Gwu5-A@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm: drop DRM_AUTH from PRIME_TO/FROM_HANDLE ioctls
To: ML dri-devel <dri-devel@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BM/azPPQPov7fAdWwUi35YWrQ2EMZSUuci26TPJ1gZM=;
 b=GOsTfBhl5CWIuwghYdjTQdRBSiH+pEzp5YLbZ+bk/tds/0KjDSME9rcWMQSbsIt5eE
 sK89Qz3PFEScCxK8rtD0GzQbVeIPHz0mReyWzGC57f7H3UgbIcVdE+xW5VkoR2AIwV7k
 52KEbqYXRgByT5BgFN8ADr4ZETg5snIEzQLpkm4WzDcC5zhJdsTwVHjLBu4o4FNgCnDu
 awpn/ubG/WDHEkeCqRvv552Zjmoq5xxQqkXF+X8omxI2Ek9Vasr821xiCtCUPGZ+XE/o
 WDCkMhOWRGxiJ6H/8oiqTL4iSpTEUsyYTf7J4CK8Du4Cl2EdF5Nw19SVRXrUHhe0erAl
 3t2A==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>,
 Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108131126.BX3mRTQPrKFarfgcV3Fn8QHv-1_TEGfE-RwRjbcmo8A@z>

T24gRnJpLCAxIE5vdiAyMDE5IGF0IDEzOjA1LCBFbWlsIFZlbGlrb3YgPGVtaWwubC52ZWxpa292
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBFbWlsIFZlbGlrb3YgPGVtaWwudmVsaWtvdkBj
b2xsYWJvcmEuY29tPgo+Cj4gQXMgbWVudGlvbmVkIGJ5IENocmlzdGlhbiwgZm9yIGRyaXZlcnMg
d2hpY2ggc3VwcG9ydCBvbmx5IHByaW1hcnkgbm9kZXMKPiB0aGlzIGNoYW5nZXMgdGhlIHJldHVy
bmVkIGVycm9yIGZyb20gLUVBQ0NFUyBpbnRvIC1FT1BOT1RTVVBQLy1FTk9TWVMuCj4KPiBGb3Ig
b3RoZXJzLCB0aGlzIGNoZWNrIGluIHBhcnRpY3VsYXIgd2lsbCBiZSBhIG5vb3AuIFNvIGxldCdz
IHJlbW92ZSBpdAo+IGFzIHN1Z2dlc3RlZCBieSBDaHJpc3RpYW4uCj4KPiBDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IFNl
YW4gUGF1bCA8c2VhbkBwb29ybHkucnVuPgo+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRW1pbCBWZWxpa292IDxl
bWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2RybV9p
b2N0bC5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9pb2N0bC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9pb2N0bC5jCj4gaW5kZXggZmNkNzI4ZDdjZjcyLi41YWZiMzk2
ODhiNTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9pb2N0bC5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9pb2N0bC5jCj4gQEAgLTY1Miw4ICs2NTIsOCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGRybV9pb2N0bF9kZXNjIGRybV9pb2N0bHNbXSA9IHsKPgo+ICAgICAgICAg
RFJNX0lPQ1RMX0RFRihEUk1fSU9DVExfTU9ERV9HRVRSRVNPVVJDRVMsIGRybV9tb2RlX2dldHJl
c291cmNlcywgMCksCj4KPiAtICAgICAgIERSTV9JT0NUTF9ERUYoRFJNX0lPQ1RMX1BSSU1FX0hB
TkRMRV9UT19GRCwgZHJtX3ByaW1lX2hhbmRsZV90b19mZF9pb2N0bCwgRFJNX0FVVEh8RFJNX1JF
TkRFUl9BTExPVyksCj4gLSAgICAgICBEUk1fSU9DVExfREVGKERSTV9JT0NUTF9QUklNRV9GRF9U
T19IQU5ETEUsIGRybV9wcmltZV9mZF90b19oYW5kbGVfaW9jdGwsIERSTV9BVVRIfERSTV9SRU5E
RVJfQUxMT1cpLAo+ICsgICAgICAgRFJNX0lPQ1RMX0RFRihEUk1fSU9DVExfUFJJTUVfSEFORExF
X1RPX0ZELCBkcm1fcHJpbWVfaGFuZGxlX3RvX2ZkX2lvY3RsLCBEUk1fUkVOREVSX0FMTE9XKSwK
PiArICAgICAgIERSTV9JT0NUTF9ERUYoRFJNX0lPQ1RMX1BSSU1FX0ZEX1RPX0hBTkRMRSwgZHJt
X3ByaW1lX2ZkX3RvX2hhbmRsZV9pb2N0bCwgRFJNX1JFTkRFUl9BTExPVyksCj4KPiAgICAgICAg
IERSTV9JT0NUTF9ERUYoRFJNX0lPQ1RMX01PREVfR0VUUExBTkVSRVNPVVJDRVMsIGRybV9tb2Rl
X2dldHBsYW5lX3JlcywgMCksCj4gICAgICAgICBEUk1fSU9DVExfREVGKERSTV9JT0NUTF9NT0RF
X0dFVENSVEMsIGRybV9tb2RlX2dldGNydGMsIDApLAo+IC0tCkh1bWJsZSBwb2tlPyBTZWFuLCBv
dGhlcnM/CgpUaGFua3MKRW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
