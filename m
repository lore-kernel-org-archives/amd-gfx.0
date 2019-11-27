Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E57C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 16:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5214D206E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 16:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5214D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45A96E323;
	Wed, 27 Nov 2019 16:26:45 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04656E321;
 Wed, 27 Nov 2019 16:26:44 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a131so3435416wme.5;
 Wed, 27 Nov 2019 08:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qOVtybo7usSbjoqRS9lVUZgze/kCb5tgAd7kGTrcnVo=;
 b=aR1e1AcZTEz7vi2Kl+NGD+CiNVX/wYdV5bon8xuGzj9e7BYlxJEkJtW5d5w2OmDAwE
 /WfPAUYCpYdqqm0ilYHVd1CEOeP1SapCS31KgMqMbVDJLRlXh9IRy+FjzMUQsvi4Cyua
 S8BSrGfjjLkqYjRps9A6CImBiCLzcMaPBHejKYL64/DDhC8634Xa/fE7DBHtgUCKFpQR
 QMz60UK+dOf+KanzVpZ7BI4uwfxzI/C1grZS6CRnfSiZAZt34L/T4kYWEZlWefC/6C8P
 i3ojE02+91CZm6S+5xHWity5uPfgz4xoBHV0WO2ijmtHm2RhNcXqCeSpZzm+LFxWU9DN
 jaCA==
X-Gm-Message-State: APjAAAV7j3gBVKnUf6SWX59Xqdnpxcqc593BJa+M/GRIrMSXnlc0dkuf
 muvnw8ek9i7zt5XOH4pMJFMiyuO8
X-Google-Smtp-Source: APXvYqyKREFCINTGZPzKlf23UoZFoaitJAwZDVukVF/q7qrvkzypIGaAuSCnKgOo7m0pUYXt787d3Q==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr768632wme.133.1574872002926; 
 Wed, 27 Nov 2019 08:26:42 -0800 (PST)
Received: from arch-x1c3.cbg.collabora.co.uk
 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
 by smtp.gmail.com with ESMTPSA id b1sm19680794wrs.74.2019.11.27.08.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 08:26:42 -0800 (PST)
From: Emil Velikov <emil.l.velikov@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm: drop DRM_AUTH from PRIME_TO/FROM_HANDLE ioctls
Date: Wed, 27 Nov 2019 16:25:54 +0000
Message-Id: <20191127162554.2494-1-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101130313.8862-5-emil.l.velikov@gmail.com>
References: <20191101130313.8862-5-emil.l.velikov@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qOVtybo7usSbjoqRS9lVUZgze/kCb5tgAd7kGTrcnVo=;
 b=VCFQFxd8bsRIJkYZEvCLkZLgV+/gP0jP41iyKSALeWJFBfl94LPndBwPOjuCoiVqFy
 GnO8aN1d4vHncXdkKi6nHlEYMakMk/71qX7xQOGITu70zEZZKrWKhlhkC9nRWvD2At06
 u9vGNW0+Xwc6AfcPR+lDNurt3XrHv/3sB3lHEj3TmJA/3+EewJFcZR1nfV+3zvVgav0e
 1syBVVp/8Xlvlhjw8Kz540nRWQnjeMZI03QLHYBG7n0wRd2SWNYrDcZDuz/9pwsjMC3v
 VuPaeLwNHPdhZJrEO9aIMY+D79TgYztrG4plJI70wNFEuAsHOjx+bRSXBrnw5PNn3313
 FLvw==
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
Cc: emil.l.velikov@gmail.com, amd-gfx@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127162554.OLNc4Vf_eWZ4WQJ2qcl3hlkuWTXmgS581mRUS8kMoko@z>

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KCkN1cnJlbnQg
dmFsaWRhdGlvbiByZXF1aXJlcyB0aGF0IHdlJ3JlIGF1dGhlbnRpY2F0ZWQsIGV2ZW4gdGhvdWdo
IHdlIGNhbgpieXBhc3MgKGJ5IGRlc2lnbikgdGhlIGF1dGhlbnRpY2F0aW9uIHdoZW4gdXNpbmcg
YSByZW5kZXIgbm9kZS4KCkxldCdzIGFkZHJlc3MgdGhlIGZvcm1lciBieSBmb2xsb3dpbmcgdGhl
IGRlc2lnbiBkZWNpc2lvbi4KCnYyOiBBZGQgc2ltcGxlciB2YWxpZGF0aW9uIGluIHRoZSBpb2N0
bHMgdGhlbXNlbHZlcyAoQm9yaXMpCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IEJvcmlzIEJy
ZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+CkNjOiBEYW5pZWwgVmV0dGVy
IDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTZWFuIFBhdWwgPHNlYW5AcG9vcmx5LnJ1bj4KQWNrZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9m
Zi1ieTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vZHJtX2lvY3RsLmMgfCAgNCArKy0tCiBkcml2ZXJzL2dwdS9kcm0vZHJtX3By
aW1lLmMgfCAxOSArKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ry
bV9pb2N0bC5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9pb2N0bC5jCmluZGV4IGZjZDcyOGQ3Y2Y3
Mi4uNWFmYjM5Njg4YjU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2lvY3RsLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9pb2N0bC5jCkBAIC02NTIsOCArNjUyLDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBkcm1faW9jdGxfZGVzYyBkcm1faW9jdGxzW10gPSB7CiAKIAlEUk1f
SU9DVExfREVGKERSTV9JT0NUTF9NT0RFX0dFVFJFU09VUkNFUywgZHJtX21vZGVfZ2V0cmVzb3Vy
Y2VzLCAwKSwKIAotCURSTV9JT0NUTF9ERUYoRFJNX0lPQ1RMX1BSSU1FX0hBTkRMRV9UT19GRCwg
ZHJtX3ByaW1lX2hhbmRsZV90b19mZF9pb2N0bCwgRFJNX0FVVEh8RFJNX1JFTkRFUl9BTExPVyks
Ci0JRFJNX0lPQ1RMX0RFRihEUk1fSU9DVExfUFJJTUVfRkRfVE9fSEFORExFLCBkcm1fcHJpbWVf
ZmRfdG9faGFuZGxlX2lvY3RsLCBEUk1fQVVUSHxEUk1fUkVOREVSX0FMTE9XKSwKKwlEUk1fSU9D
VExfREVGKERSTV9JT0NUTF9QUklNRV9IQU5ETEVfVE9fRkQsIGRybV9wcmltZV9oYW5kbGVfdG9f
ZmRfaW9jdGwsIERSTV9SRU5ERVJfQUxMT1cpLAorCURSTV9JT0NUTF9ERUYoRFJNX0lPQ1RMX1BS
SU1FX0ZEX1RPX0hBTkRMRSwgZHJtX3ByaW1lX2ZkX3RvX2hhbmRsZV9pb2N0bCwgRFJNX1JFTkRF
Ul9BTExPVyksCiAKIAlEUk1fSU9DVExfREVGKERSTV9JT0NUTF9NT0RFX0dFVFBMQU5FUkVTT1VS
Q0VTLCBkcm1fbW9kZV9nZXRwbGFuZV9yZXMsIDApLAogCURSTV9JT0NUTF9ERUYoRFJNX0lPQ1RM
X01PREVfR0VUQ1JUQywgZHJtX21vZGVfZ2V0Y3J0YywgMCksCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vZHJtX3ByaW1lLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3ByaW1lLmMKaW5kZXgg
MGEyMzE2ZTBlODEyLi5kYWIxNjZjODYwZWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9k
cm1fcHJpbWUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3ByaW1lLmMKQEAgLTM1OCwxMSAr
MzU4LDI3IEBAIGludCBkcm1fZ2VtX3ByaW1lX2ZkX3RvX2hhbmRsZShzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LAogfQogRVhQT1JUX1NZTUJPTChkcm1fZ2VtX3ByaW1lX2ZkX3RvX2hhbmRsZSk7CiAK
K3N0YXRpYyBpbmxpbmUgYm9vbAorYWxsb3dlZF9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2
LCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdikKK3sKKwkvKiBVbmF1dGhlbnRpY2F0ZWQgbWFz
dGVyIGlzIGFsbG93ZWQsIGZvciByZW5kZXIgY2FwYWJsZSBkZXZpY2VzICovCisJaWYgKGRybV9p
c19wcmltYXJ5X2NsaWVudChmaWxlX3ByaXYpKSB7CisJCWlmICghZmlsZV9wcml2LT5hdXRoZW50
aWNhdGVkICYmCisJCSAgICAhZHJtX2NvcmVfY2hlY2tfZmVhdHVyZShkZXYsIERSSVZFUl9SRU5E
RVIpKQorCQlyZXR1cm4gZmFsc2U7CisJfQorCisJcmV0dXJuIHRydWU7Cit9CisKIGludCBkcm1f
cHJpbWVfZmRfdG9faGFuZGxlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRh
dGEsCiAJCQkJIHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2KQogewogCXN0cnVjdCBkcm1fcHJp
bWVfaGFuZGxlICphcmdzID0gZGF0YTsKIAorCWlmICghYWxsb3dlZF9pb2N0bChkZXYsIGZpbGVf
cHJpdikpCisJCXJldHVybiAtRUFDQ0VTOworCiAJaWYgKCFkZXYtPmRyaXZlci0+cHJpbWVfZmRf
dG9faGFuZGxlKQogCQlyZXR1cm4gLUVOT1NZUzsKIApAQCAtNTExLDYgKzUyNyw5IEBAIGludCBk
cm1fcHJpbWVfaGFuZGxlX3RvX2ZkX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQg
KmRhdGEsCiB7CiAJc3RydWN0IGRybV9wcmltZV9oYW5kbGUgKmFyZ3MgPSBkYXRhOwogCisJaWYg
KCFhbGxvd2VkX2lvY3RsKGRldiwgZmlsZV9wcml2KSkKKwkJcmV0dXJuIC1FQUNDRVM7CisKIAlp
ZiAoIWRldi0+ZHJpdmVyLT5wcmltZV9oYW5kbGVfdG9fZmQpCiAJCXJldHVybiAtRU5PU1lTOwog
Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
