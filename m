Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC57FC63699
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67263206ED
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I22RgE4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67263206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95D7896DD;
	Mon,  9 Nov 2020 21:21:43 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB42894FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:02 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id h2so960232wmm.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2BhrCBQbfmRZLpUpWXEUFmjezg6+PE2LAePTP+SbH+M=;
 b=I22RgE4HXQJeXrkMywCF0c58g4ymKrdb1XIqYmVJ1l9107iR/zllJYlW3Y4+0HjqrF
 1I7kG3IH0cp0ttyXHv+taVnH4EPBaUNMw9TtUzzpG1WgzAYwfitziY8a5dX1gkdf/LMf
 mGF0vNXCsvS5V8SwO72SFSKOF/cqAKQbKmX9wG1rfk0fhT4ODNDYf/5xjX5CxgczZUEV
 RZ19ryEavZUYOV0g/+JuaeTszemLVfeMLtBO4nnLEvMLP4Idr7jpF+lCOAwW9rDXq7UI
 Ad/i0MkTkUAjIesyKCTDPOxNkRdjmCLfl/mnLKfGr5GQbuZjKGNq+uIgAgONjAGwglkn
 vOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2BhrCBQbfmRZLpUpWXEUFmjezg6+PE2LAePTP+SbH+M=;
 b=bVWdTtLugoO0K/q4QBKgLuaInel8KXv4ZgJFwNSH5aUJSVWsF9bB6Q5nBVmtcDXK6t
 kUNT+ZpATP58T+0ofspE2GCIhTC/4Ebhw596a81hZXgNacLZ7lFoMg+c3LqKdSgjmOyi
 9Ym6Kg2xmOKm1p6wWA0aYsBTVUPF3fuXI3pZ5Zoemf/i6uUJi4WjqddmWVEeCVrJKvVz
 HjAafsF/DqTOqxpjXsUrbeunNAebeki0C1mqio6QyfFA3UVEyTmFBigVWmxWvAkjEOfY
 fC1z5xr26nogKoZ+a2P5MxQgRoNS3fJtFcdVmm6Sh1xQw/vp420PLjMF4H/Pid+h1EKA
 AHTg==
X-Gm-Message-State: AOAM531dyXfeQorvh21PeEe8fKLjhRtyHhQAcVKRtXqo99lXJ62bY/4v
 SwCdZtA0RqQUo+cttzy5+JcmNQ==
X-Google-Smtp-Source: ABdhPJzdcwB8rqaq7cQDbwgS0YbQzyJ5wsfTzVscX3fNhQZDc+xbcBkBa39JWEwmNBKdxoSM6DhCFQ==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr1126625wmc.87.1604956740794;
 Mon, 09 Nov 2020 13:19:00 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:18:59 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 00/20] [Set 3] Rid W=1 warnings from GPU
Date: Mon,  9 Nov 2020 21:18:35 +0000
Message-Id: <20201109211855.3340030-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
Cc: Sumit Semwal <sumit.semwal@linaro.org>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Slava Grigorev <slava.grigorev@amd.com>, linaro-mm-sig@lists.linaro.org,
 Jerome Glisse <glisse@freedesktop.org>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 report to <xorg-driver-ati@lists.x.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBzZXQgaXMgcGFydCBvZiBhIGxhcmdlciBlZmZvcnQgYXR0ZW1wdGluZyB0byBjbGVhbi11
cCBXPTEKa2VybmVsIGJ1aWxkcywgd2hpY2ggYXJlIGN1cnJlbnRseSBvdmVyd2hlbG1pbmdseSBy
aWRkbGVkIHdpdGgKbmlnZ2x5IGxpdHRsZSB3YXJuaW5ncy4KClRoaXMgc2V0IHRha2VzIHRoZSBy
dW5uaW5nIChkZWNyZWFzaW5nKSB0b3RhbCBmcm9tIDUwMDAgYmVmb3JlCltTZXQgMV0gZG93biB0
byAyMzAwLgoKTGVlIEpvbmVzICgyMCk6CiAgZHJtL3JhZGVvbi9yYWRlb25fdHRtOiBQbGFjZSBk
ZWNsYXJhdGlvbiBvZiAncmRldicgaW4gc2FtZSBjbGF1c2UgYXMKICAgIGl0cyB1c2UKICBkcm0v
cmFkZW9uOiBNb3ZlIHJhZGVvbl90dG17aW5pdCxmaW5pfSB0byBzaGFyZWQgbG9jYXRpb24KICBk
cm0vcmFkZW9uL3JhZGVvbl9mZW5jZTogRGVtb3RlIHNvbWUgbm9uLWNvbmZvcm1hbnQga2VybmVs
LWRvYyBoZWFkZXJzCiAgICBhbmQgZml4IGFub3RoZXIKICBkcm0vcmFkZW9uOiBNb3ZlICdyYWRl
b25fYWRkX2xlZ2FjeV9lbmNvZGVyJyBwcm90b3R5cGUgdG8gc2hhcmVkCiAgICBoZWFkZXIKICBk
cm0vcmFkZW9uOiBNb3ZlICdyYWRlb25fYWRkX2xlZ2FjeV9lbmNvZGVyJ3MgcHJvdG90eXBlIHRv
IHNoYXJlZAogICAgbG9jYXRpb24KICBkcm0vcmFkZW9uL3JhZGVvbl9jb25uZWN0b3JzOiBTdHJp
cCBvdXQgc2V0IGJ1dCB1bnVzZWQgdmFyaWFibGUgJ3JldCcKICBkcm0vcmFkZW9uL3JhZGVvbl9k
aXNwbGF5OiBSZW1vdmUgdW51c2VkIHZhcmlhYmxlICdtb2QnCiAgZHJtL3JhZGVvbi9yYWRlb25f
aTJjOiBSZW1vdmUgcG9pbnRsZXNzIGZ1bmN0aW9uIGhlYWRlcgogIGRybS9yYWRlb24vcmFkZW9u
X2lycV9rbXM6IERlbW90ZSBub24tY29uZm9ybWFudCBrZXJuZWwtZG9jIGZpeAogICAgYW5vdGhl
cgogIGRybS9yYWRlb24vcmFkZW9uX3Jpbmc6IEFkZCBtaXNzaW5nIGZ1bmN0aW9uIHBhcmFtZXRl
cnMgJ3JkZXYnIGFuZAogICAgJ2RhdGEnCiAgZHJtL3JhZGVvbi9yNjAwOiBTdHJpcCBvdXQgc2V0
IGJ1dCB1bnVzZWQgJ3RtcCcgdmFyaWFibGVzCiAgZHJtL3JhZGVvbi9yYWRlb25fY3M6IEZpeCBh
IGJ1bmNoIG9mIGRvYy1yb3QgaXNzdWVzCiAgZHJtL3JhZGVvbi9ldmVyZ3JlZW46IE1vdmUgJ3J2
NzcwX3NldF9jbGtfYnlwYXNzX21vZGUnIHByb3RvdHlwZSB0bwogICAgc2hhcmVkIGxvY2F0aW9u
CiAgZHJtL3JhZGVvbjogTW92ZSAncmFkZW9uX3BtX2FjcGlfZXZlbnRfaGFuZGxlcicgcHJvdG90
eXBlIGludG8gc2hhcmVkCiAgICBoZWFkZXIKICBkcm0vcmFkZW9uL3I2MDBkOiBNb3ZlICdyYzYw
MF8qJyBwcm90b3R5cGVzIGludG8gc2hhcmVkIGhlYWRlcgogIGRybS9yYWRlb24vcmFkZW9uX2F1
ZGlvOiBNb3ZlICdkY2UzXzJfKicgcHJvdG90eXBlcyB0byBzaGFyZWQgbG9jYXRpb24KICBkcm0v
cmFkZW9uL2V2ZXJncmVlbmQ6IE1vdmUgJ2V2ZXJncmVlbl8qJyBhbmQgJ3N1bW9fKicgcHJvdG90
eXBlcyBvdXQKICAgIHRvIHNoYXJlZCBsb2NhdGlvbgogIGRybS9yYWRlb24vcmFkZW9uX2Rpc3Bs
YXk6IEZpeCBmdW5jdGlvbiBkb2MgZm9ybWF0dGluZyBhbmQgbWlzc2luZwogICAgcGFyYW0gaXNz
dWVzCiAgZHJtL3JhZGVvbi9yNjAwOiBGaXggYSBtaXNuYW1lZCBwYXJhbWV0ZXIgZGVzY3JpcHRp
b24gYW5kIGEgZm9ybWF0dGluZwogICAgaXNzdWUKICBkcm0vcmFkZW9uL2NpazogRml4IGEgYnVu
Y2ggb2YgZnVuY3Rpb24gcGFyYW1ldGVyIGRlc2NyaXB0aW9ucwoKIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vY2lrLmMgICAgICAgICAgICAgICB8IDEwICsrKy0tLS0KIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vZXZlcmdyZWVuLmMgICAgICAgICB8ICAxIC0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
bmkuYyAgICAgICAgICAgICAgICB8IDE2IC0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcjYwMC5jICAgICAgICAgICAgICB8IDExICsrKy0tLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcjYwMGQuaCAgICAgICAgICAgICB8IDE0ICsrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb24uaCAgICAgICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKwogZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYWNwaS5jICAgICAgIHwgIDIgLS0KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmMgICB8ICA1IC0tLS0KIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2F1ZGlvLmMgICAgICB8IDIzICstLS0tLS0tLS0tLS0tLQogZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXVkaW8uaCAgICAgIHwgMTIgKysrKysrKysKIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NvbWJpb3MuYyAgICB8ICA1IC0tLS0KIGRyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Nvbm5lY3RvcnMuYyB8ICA0ICstLQogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYyAgICAgICAgIHwgMTIgKysrKy0tLS0KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYyAgICB8IDE3ICsrKysrLS0tLS0tCiBkcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9lbmNvZGVycy5jICAgfCAgMyAtLQogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fZmVuY2UuYyAgICAgIHwgIDYgKystLQogZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25faTJjLmMgICAgICAgIHwgIDQgLS0tCiBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9pcnFfa21zLmMgICAgfCAgNiArKy0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9vYmplY3QuYyAgICAgfCAgMiAtLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fcmluZy5jICAgICAgIHwgIDMgKysKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X3R0bS5jICAgICAgICB8ICA4ICsrLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmMgICAg
ICAgICAgICAgICAgfCAgNiAtLS0tCiAyMiBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCsp
LCAxMDggZGVsZXRpb25zKC0pCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogSmVyb21lIEdsaXNzZSA8Z2xpc3NlQGZy
ZWVkZXNrdG9wLm9yZz4KQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpDYzogbGlu
dXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiByZXBvcnQgdG8gPHhvcmctZHJpdmVyLWF0aUBs
aXN0cy54Lm9yZz4KQ2M6IFNsYXZhIEdyaWdvcmV2IDxzbGF2YS5ncmlnb3JldkBhbWQuY29tPgpD
YzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KLS0gCjIuMjUuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
