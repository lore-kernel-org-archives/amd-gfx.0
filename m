Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F13AC64E7D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EB620674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdELhwgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EB620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9216EC07;
	Fri, 27 Nov 2020 10:15:07 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78336E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:07 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id l1so2189849wrb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b5HKCJC8iv4gibbIS6cltBxMH+DAVlqg/H12nTJ1XPY=;
 b=BdELhwgg2aXDCVPZiMApozkS+dDFnAj41prA+beMmkmtq5w/7jzoUYaN79lGhPg+b5
 Ao1NeiAYusWBvAPnbIbFxw256w0sjzeS37NG3I/ArloBXx9UsQGzPCHaZ7eq5GMUa9Hq
 xblCmIPAb04gorBKak04DKwX5Ouw95gD99jYEeYF5/t8k6AlIurKssHp9FLsnG/gfuKR
 3bHvkYd8LpUPEBgWAJLoljaerBRARKDD7Z6hdxEPL1xUgeKW/drJy7CKcIkZgzlF8b5V
 1clDkzXxjZPiHr0yHQ1cy4uKZyP94uOV98wuUeATSfrG5vyfKtu3Xud6idIgT8PSTifK
 F7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b5HKCJC8iv4gibbIS6cltBxMH+DAVlqg/H12nTJ1XPY=;
 b=D+Utf86I8vUjAyKlTorj4Z5iMqhsbXAqQzkUPFOaMOn3Rs9KEE1UUIS18zO60iu65l
 iXKRtnYh+Iv065c8TsNPet9Y9W7J//ngM15bbmRDKqeeJE9VGzoak4zVizW9xDXLI2jA
 nE5VLgkYe5gNLshnV/C/w9r0pjZoeP/1JCpzbICerN7wWFhVJZM2XcB6dpDfU+zae2w+
 WgwJWbXQXcWadnmxAK7qCv4FmZ9uLYsoomzXzTzHErOgucEp3DfEte98ekQjr6CIGM0t
 f4R80iw6H709s5+pxeCW2RKFoBq4NpbJa1P21NvyHX8XzrTJMDf/VpI539sSZUCmIQNJ
 pMhg==
X-Gm-Message-State: AOAM531p6SKSIFrIy6dRg9jG0nKj2s3br2F1/3ZOMDBadPqP0hS0gn6k
 6ruT/0Weg6sei9AM4Fm0/qUPVg==
X-Google-Smtp-Source: ABdhPJwPA7XUfQ9Hktvglh4mawyljyRIWgMBX4yMO89KviHWcVv/KdRekllKFpPilB/5KPywm3QnNw==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr4046751wrm.159.1606398186510; 
 Thu, 26 Nov 2020 05:43:06 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:05 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 14/40] drm/amd/pm/powerplay/hwmgr/ppatomfwctrl: Demote
 kernel-doc formatting abuses
Date: Thu, 26 Nov 2020 13:42:14 +0000
Message-Id: <20201126134240.3214176-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3BwYXRvbWZ3Y3RybC5j
Ojc4OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdod21ncicgbm90IGRl
c2NyaWJlZCBpbiAncHBfYXRvbWZ3Y3RybF9pc192b2x0YWdlX2NvbnRyb2xsZWRfYnlfZ3Bpb192
NCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxheS9od21nci9wcGF0
b21md2N0cmwuYzo3ODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAndm9s
dGFnZV90eXBlJyBub3QgZGVzY3JpYmVkIGluICdwcF9hdG9tZndjdHJsX2lzX3ZvbHRhZ2VfY29u
dHJvbGxlZF9ieV9ncGlvX3Y0JwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93
ZXJwbGF5L2h3bWdyL3BwYXRvbWZ3Y3RybC5jOjc4OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0
ZXIgb3IgbWVtYmVyICd2b2x0YWdlX21vZGUnIG5vdCBkZXNjcmliZWQgaW4gJ3BwX2F0b21md2N0
cmxfaXNfdm9sdGFnZV9jb250cm9sbGVkX2J5X2dwaW9fdjQnCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9tZndjdHJsLmM6MjExOiB3YXJuaW5n
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdod21ncicgbm90IGRlc2NyaWJlZCBpbiAn
cHBfYXRvbWZ3Y3RybF9nZXRfcHBfYXNzaWduX3BpbicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL3BtL3Bvd2VycGxheS9od21nci9wcGF0b21md2N0cmwuYzoyMTE6IHdhcm5pbmc6IEZ1
bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3Bpbl9pZCcgbm90IGRlc2NyaWJlZCBpbiAncHBf
YXRvbWZ3Y3RybF9nZXRfcHBfYXNzaWduX3BpbicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL3BtL3Bvd2VycGxheS9od21nci9wcGF0b21md2N0cmwuYzoyMTE6IHdhcm5pbmc6IEZ1bmN0
aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2dwaW9fcGluX2Fzc2lnbm1lbnQnIG5vdCBkZXNjcmli
ZWQgaW4gJ3BwX2F0b21md2N0cmxfZ2V0X3BwX2Fzc2lnbl9waW4nCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9tZndjdHJsLmM6MjMyOiB3YXJu
aW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdod21ncicgbm90IGRlc2NyaWJlZCBp
biAncHBfYXRvbWZ3Y3RybF9lbnRlcl9zZWxmX3JlZnJlc2gnCgpDYzogRXZhbiBRdWFuIDxldmFu
LnF1YW5AYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVs
QGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9u
ZXNAbGluYXJvLm9yZz4KLS0tCiAuLi4vZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9t
ZndjdHJsLmMgfCAyNCArKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9tZndjdHJsLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3Bvd2VycGxheS9od21nci9wcGF0b21md2N0cmwuYwppbmRleCA2MTVjZjJjMDllNTRl
Li5hNDdhNDcyMzhlMmI5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9od21nci9wcGF0b21md2N0cmwuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bv
d2VycGxheS9od21nci9wcGF0b21md2N0cmwuYwpAQCAtNjgsMTEgKzY4LDExIEBAIHN0YXRpYyBz
dHJ1Y3QgYXRvbV92b2x0YWdlX29iamVjdHNfaW5mb192NF8xICpwcF9hdG9tZndjdHJsX2dldF92
b2x0YWdlX2luZm9fdGFiCiAJcmV0dXJuIChzdHJ1Y3QgYXRvbV92b2x0YWdlX29iamVjdHNfaW5m
b192NF8xICopdGFibGVfYWRkcmVzczsKIH0KIAotLyoqCi0qIFJldHVybnMgVFJVRSBpZiB0aGUg
Z2l2ZW4gdm9sdGFnZSB0eXBlIGlzIGNvbnRyb2xsZWQgYnkgR1BJTyBwaW5zLgotKiB2b2x0YWdl
X3R5cGUgaXMgb25lIG9mIFNFVF9WT0xUQUdFX1RZUEVfQVNJQ19WRERDLCBTRVRfVk9MVEFHRV9U
WVBFX0FTSUNfTVZEREMsIFNFVF9WT0xUQUdFX1RZUEVfQVNJQ19NVkREUS4KLSogdm9sdGFnZV9t
b2RlIGlzIG9uZSBvZiBBVE9NX1NFVF9WT0xUQUdFLCBBVE9NX1NFVF9WT0xUQUdFX1BIQVNFCi0q
LworLyoKKyAqIFJldHVybnMgVFJVRSBpZiB0aGUgZ2l2ZW4gdm9sdGFnZSB0eXBlIGlzIGNvbnRy
b2xsZWQgYnkgR1BJTyBwaW5zLgorICogdm9sdGFnZV90eXBlIGlzIG9uZSBvZiBTRVRfVk9MVEFH
RV9UWVBFX0FTSUNfVkREQywgU0VUX1ZPTFRBR0VfVFlQRV9BU0lDX01WRERDLCBTRVRfVk9MVEFH
RV9UWVBFX0FTSUNfTVZERFEuCisgKiB2b2x0YWdlX21vZGUgaXMgb25lIG9mIEFUT01fU0VUX1ZP
TFRBR0UsIEFUT01fU0VUX1ZPTFRBR0VfUEhBU0UKKyAqLwogYm9vbCBwcF9hdG9tZndjdHJsX2lz
X3ZvbHRhZ2VfY29udHJvbGxlZF9ieV9ncGlvX3Y0KHN0cnVjdCBwcF9od21nciAqaHdtZ3IsCiAJ
CXVpbnQ4X3Qgdm9sdGFnZV90eXBlLCB1aW50OF90IHZvbHRhZ2VfbW9kZSkKIHsKQEAgLTIwMiw5
ICsyMDIsOSBAQCBzdGF0aWMgYm9vbCBwcF9hdG9tZndjdHJsX2xvb2t1cF9ncGlvX3BpbigKIAly
ZXR1cm4gZmFsc2U7CiB9CiAKLS8qKgotKiBSZXR1cm5zIFRSVUUgaWYgdGhlIGdpdmVuIHBpbiBp
ZCBmaW5kIGluIGxvb2t1cCB0YWJsZS4KLSovCisvKgorICogUmV0dXJucyBUUlVFIGlmIHRoZSBn
aXZlbiBwaW4gaWQgZmluZCBpbiBsb29rdXAgdGFibGUuCisgKi8KIGJvb2wgcHBfYXRvbWZ3Y3Ry
bF9nZXRfcHBfYXNzaWduX3BpbihzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCQljb25zdCB1aW50
MzJfdCBwaW5faWQsCiAJCXN0cnVjdCBwcF9hdG9tZndjdHJsX2dwaW9fcGluX2Fzc2lnbm1lbnQg
KmdwaW9fcGluX2Fzc2lnbm1lbnQpCkBAIC0yMjQsMTAgKzIyNCwxMCBAQCBib29sIHBwX2F0b21m
d2N0cmxfZ2V0X3BwX2Fzc2lnbl9waW4oc3RydWN0IHBwX2h3bWdyICpod21nciwKIAlyZXR1cm4g
cmV0OwogfQogCi0vKioKLSogRW50ZXIgdG8gU2VsZlJlZnJlc2ggbW9kZS4KLSogQHBhcmFtIGh3
bWdyCi0qLworLyoKKyAqIEVudGVyIHRvIFNlbGZSZWZyZXNoIG1vZGUuCisgKiBAcGFyYW0gaHdt
Z3IKKyAqLwogaW50IHBwX2F0b21md2N0cmxfZW50ZXJfc2VsZl9yZWZyZXNoKHN0cnVjdCBwcF9o
d21nciAqaHdtZ3IpCiB7CiAJLyogMCAtIG5vIGFjdGlvbgotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
