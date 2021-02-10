Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437E8C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 23:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0855964E02
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 23:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0855964E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76E26ED26;
	Wed, 10 Feb 2021 23:36:17 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288EC6E043;
 Wed, 10 Feb 2021 23:36:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B226264EBB;
 Wed, 10 Feb 2021 23:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612999563;
 bh=z8PK7lQxdEjakhT1mHS5xkJS/hPiBnY76N9BArEFwI4=;
 h=Date:From:To:Cc:Subject:From;
 b=VHlMdkT+qJ2LMjznNTTzv1KOzBwgPGAT53rOQwZEt75wjMHB+z6g9eUm7YrFyNFXl
 3+C7C+HhmgUJt/9n+dyLxhXE2xHxs8nWrkcXwnPQmM+LChfhsQgOiMmR6k6xqEVw9k
 M3IAjSHXGqTqGw+Gc7mLOwZZmnzCJoA6s8j76wAa3xQsF+3oLi1xCzzF6ljjdJp8J9
 7omyZpecO7i8WzMbd0oIQTGH5YNFbkc2n+XtzKN3SGgPYleAz0hTvKVAb3onmc2Pwu
 g/RWjBSasGV/n7GjhUWUpf3AoY0PXmkDBFjD8DTDDtcGWqQZNQW7CtbsYD/V4aWS75
 GFh0igzGmUaSA==
Date: Wed, 10 Feb 2021 17:26:00 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH][next] drm/amd/pm: Replace one-element array with
 flexible-array in struct _ATOM_Vega10_GFXCLK_Dependency_Table
Message-ID: <20210210232600.GA66488@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlcmUgaXMgYSByZWd1bGFyIG5lZWQgaW4gdGhlIGtlcm5lbCB0byBwcm92aWRlIGEgd2F5IHRv
IGRlY2xhcmUgaGF2aW5nCmEgZHluYW1pY2FsbHkgc2l6ZWQgc2V0IG9mIHRyYWlsaW5nIGVsZW1l
bnRzIGluIGEgc3RydWN0dXJlLiBLZXJuZWwgY29kZQpzaG91bGQgYWx3YXlzIHVzZSDigJxmbGV4
aWJsZSBhcnJheSBtZW1iZXJz4oCdWzFdIGZvciB0aGVzZSBjYXNlcy4gVGhlIG9sZGVyCnN0eWxl
IG9mIG9uZS1lbGVtZW50IG9yIHplcm8tbGVuZ3RoIGFycmF5cyBzaG91bGQgbm8gbG9uZ2VyIGJl
IHVzZWRbMl0uCgpVc2UgZmxleGlibGUtYXJyYXkgbWVtYmVyIGluIHN0cnVjdCBfQVRPTV9WZWdh
MTBfR0ZYQ0xLX0RlcGVuZGVuY3lfVGFibGUsCmluc3RlYWQgb2Ygb25lLWVsZW1lbnQgYXJyYXku
CgpBbHNvLCB0aGlzIGhlbHBzIHdpdGggdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGUgLVdh
cnJheS1ib3VuZHMgYW5kCmZpeCB0aGUgZm9sbG93aW5nIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmM6IEluIGZ1
bmN0aW9uIOKAmHZlZ2ExMF9nZXRfcHBfdGFibGVfZW50cnlfY2FsbGJhY2tfZnVuY+KAmToKZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jOjMxMTM6MzA6IHdhcm5pbmc6IGFycmF5IHN1YnNjcmlwdCA0IGlzIGFib3ZlIGFycmF5IGJv
dW5kcyBvZiDigJhBVE9NX1ZlZ2ExMF9HRlhDTEtfRGVwZW5kZW5jeV9SZWNvcmRbMV3igJkge2Fr
YSDigJhzdHJ1Y3QgX0FUT01fVmVnYTEwX0dGWENMS19EZXBlbmRlbmN5X1JlY29yZFsxXeKAmX0g
Wy1XYXJyYXktYm91bmRzXQogMzExMyB8ICAgICBnZnhjbGtfZGVwX3RhYmxlLT5lbnRyaWVzWzRd
LnVsQ2xrOwogICAgICB8ICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Xn5+CgpbMV0gaHR0
cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvRmxleGlibGVfYXJyYXlfbWVtYmVyClsyXSBodHRw
czovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y1LjkvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwj
emVyby1sZW5ndGgtYW5kLW9uZS1lbGVtZW50LWFycmF5cwoKTGluazogaHR0cHM6Ly9naXRodWIu
Y29tL0tTUFAvbGludXgvaXNzdWVzLzc5Ckxpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xp
bnV4L2lzc3Vlcy8xMDkKQnVpbGQtdGVzdGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC82MDIzZmYzZC5XWTNz
U0NrR1JRUGRQbFZvJTI1bGtwQGludGVsLmNvbS8KU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBS
LiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9wcHRhYmxlLmggfCA2ICsrKy0tLQogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfcHB0YWJsZS5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3BwdGFibGUuaAppbmRl
eCBjOTM0ZTk2MTJjMWIuLjljNDc5YmQ5YTc4NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3BwdGFibGUuaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfcHB0YWJsZS5oCkBAIC0xNjEsOSAr
MTYxLDkgQEAgdHlwZWRlZiBzdHJ1Y3QgX0FUT01fVmVnYTEwX01DTEtfRGVwZW5kZW5jeV9SZWNv
cmQgewogfSBBVE9NX1ZlZ2ExMF9NQ0xLX0RlcGVuZGVuY3lfUmVjb3JkOwogCiB0eXBlZGVmIHN0
cnVjdCBfQVRPTV9WZWdhMTBfR0ZYQ0xLX0RlcGVuZGVuY3lfVGFibGUgewotICAgIFVDSEFSIHVj
UmV2SWQ7Ci0gICAgVUNIQVIgdWNOdW1FbnRyaWVzOyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLyogTnVtYmVyIG9mIGVudHJpZXMuICovCi0gICAgQVRPTV9WZWdhMTBf
R0ZYQ0xLX0RlcGVuZGVuY3lfUmVjb3JkIGVudHJpZXNbMV07ICAgICAgICAgICAgLyogRHluYW1p
Y2FsbHkgYWxsb2NhdGUgZW50cmllcy4gKi8KKwlVQ0hBUiB1Y1JldklkOworCVVDSEFSIHVjTnVt
RW50cmllczsJCQkJCS8qIE51bWJlciBvZiBlbnRyaWVzLiAqLworCUFUT01fVmVnYTEwX0dGWENM
S19EZXBlbmRlbmN5X1JlY29yZCBlbnRyaWVzW107CQkvKiBEeW5hbWljYWxseSBhbGxvY2F0ZSBl
bnRyaWVzLiAqLwogfSBBVE9NX1ZlZ2ExMF9HRlhDTEtfRGVwZW5kZW5jeV9UYWJsZTsKIAogdHlw
ZWRlZiBzdHJ1Y3QgX0FUT01fVmVnYTEwX01DTEtfRGVwZW5kZW5jeV9UYWJsZSB7Ci0tIAoyLjI3
LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
