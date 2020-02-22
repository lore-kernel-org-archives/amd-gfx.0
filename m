Return-Path: <SRS0=juic=4K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224EBC35671
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Feb 2020 17:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F103F206ED
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Feb 2020 17:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Xe6ViE0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F103F206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C99F6E969;
	Sat, 22 Feb 2020 17:54:43 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005C66E969
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2020 17:54:41 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c9so5601808wrw.8
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2020 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MJWGaxMUKVFJF6qqk3Gzcv8gSfm1oFTteY5HRbRqSd8=;
 b=Xe6ViE0S3L+FQtUqUyyBUV/mvHKlCG4SkV050TiY3lPiW4s3w70TrVULhHrqnMFPBx
 vTQbU8ZSnFwhaA+pDLVJRl0syROZ2hLldsXkqns3qKT+MLxWyrQg4NeNGvzNyPdjWPye
 D3gFvK+jspfTPEqw7L+y600SbXAcMXtQhtRxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MJWGaxMUKVFJF6qqk3Gzcv8gSfm1oFTteY5HRbRqSd8=;
 b=e6//tBW2RvVaBi/9RWJfvRUIXQJujATDfJlaf+fnHzm33Ay5hYv3SlOAeHUR19rgbl
 RANtITRM3ya7XpEEVZMRFi4sTimUCcncWM7F1jI0+7znzdD2Na+3OaZ3yfnEVQxRiSWt
 xoZej4qOWnkGOFU176YnjrfCBe0dxmxtp6rit2OMUJjM5ONNLBX5NKyIgMlm1jvcQY70
 go3Jtt+WkSIKxwPKvtluFs1Mz14N2CbMW/RCQxzLrbk86m9KmkyNOne5zw1YWO6oQTKR
 Fu6bypGEMFmgKYW7ADQKOc/iNHo9uCrH7pMbcSwvXIE928q+bCwSVreLDLaojesEZIU5
 dz9g==
X-Gm-Message-State: APjAAAUUNO/Gsc3HcdqafUNlIJski4TKN5k+vwLWhBAF67jky8ZHNw9h
 a+FGPUXCSAd8x/rCfPbhSrwoXQ==
X-Google-Smtp-Source: APXvYqzcY/7+ZhK3LAgCvZdKQ2CGuNKrKMNl/HiDRDpputuW9Sz6U6N2cmBJDcNCZ5Q4MSOfpvKbEg==
X-Received: by 2002:adf:f641:: with SMTP id x1mr3445375wrp.248.1582394080619; 
 Sat, 22 Feb 2020 09:54:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l15sm9373405wrv.39.2020.02.22.09.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2020 09:54:40 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/radeon: Inline drm_get_pci_dev
Date: Sat, 22 Feb 2020 18:54:32 +0100
Message-Id: <20200222175433.2259158-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200222175433.2259158-1-daniel.vetter@ffwll.ch>
References: <20200222175433.2259158-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SXQncyB0aGUgbGFzdCB1c2VyLCBhbmQgbW9yZSBpbXBvcnRhbnRseSwgaXQncyB0aGUgbGFzdCBu
b24tbGVnYWN5CnVzZXIgb2YgYW55dGhpbmcgaW4gZHJtX3BjaS5jLgoKVGhlIG9ubHkgdHJpY2t5
IGJpdCBpcyB0aGUgYWdwIGluaXRpYWxpemF0aW9uLiBCdXQgYSBjbG9zZSBsb29rIHNob3dzCnRo
YXQgcmFkZW9uIGRvZXMgbm90IHVzZSB0aGUgZHJtX2FncCBtaWRsYXllciAodGhlIG1haW4gdXNl
IG9mIHRoYXQgaXMKZHJtX2J1ZnMgZm9yIGxlZ2FjeSBkcml2ZXJzKSwgYW5kIGluc3RlYWQgY291
bGQgdXNlIHRoZSBhZ3Agc3Vic3lzdGVtCmRpcmVjdGx5IChsaWtlIG5vdXZlYXUgZG9lcyBhbHJl
YWR5KS4gSGVuY2Ugd2UgY2FuIGp1c3QgcHVsbCB0aGlzIGluCnRvby4KCkEgZnVydGhlciBzdGVw
IHdvdWxkIGJlIHRvIGVudGlyZWx5IGRyb3AgdGhlIHVzZSBvZiBkcm1fZGV2aWNlLT5hZ3AsCmJ1
dCBmZWVscyBsaWtlIHRvbyBtdWNoIGNodXJuIGp1c3QgZm9yIHRoaXMgcGF0Y2guCgpTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT4KQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogIkRhdmlkIChDaHVuTWluZykgWmhvdSIg
PERhdmlkMS5aaG91QGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwot
LS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIHwgNDMgKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jIHwg
IDYgKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKaW5kZXggNDljZTJlN2Q1ZjllLi41OWY4
MTg2YTI0MTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCkBAIC0zNyw2ICszNyw3
IEBACiAjaW5jbHVkZSA8bGludXgvdmdhX3N3aXRjaGVyb28uaD4KICNpbmNsdWRlIDxsaW51eC9t
bXVfbm90aWZpZXIuaD4KIAorI2luY2x1ZGUgPGRybS9kcm1fYWdwc3VwcG9ydC5oPgogI2luY2x1
ZGUgPGRybS9kcm1fY3J0Y19oZWxwZXIuaD4KICNpbmNsdWRlIDxkcm0vZHJtX2Rydi5oPgogI2lu
Y2x1ZGUgPGRybS9kcm1fZmJfaGVscGVyLmg+CkBAIC0zMjIsNiArMzIzLDcgQEAgc3RhdGljIGlu
dCByYWRlb25fcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAogCQkJICAgIGNvbnN0IHN0
cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpCiB7CiAJdW5zaWduZWQgbG9uZyBmbGFncyA9IDA7CisJ
c3RydWN0IGRybV9kZXZpY2UgKmRldjsKIAlpbnQgcmV0OwogCiAJaWYgKCFlbnQpCkBAIC0zNjIs
NyArMzY0LDQ0IEBAIHN0YXRpYyBpbnQgcmFkZW9uX3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAq
cGRldiwKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCi0JcmV0dXJuIGRybV9nZXRfcGNpX2Rl
dihwZGV2LCBlbnQsICZrbXNfZHJpdmVyKTsKKwlkZXYgPSBkcm1fZGV2X2FsbG9jKCZrbXNfZHJp
dmVyLCAmcGRldi0+ZGV2KTsKKwlpZiAoSVNfRVJSKGRldikpCisJCXJldHVybiBQVFJfRVJSKGRl
dik7CisKKwlyZXQgPSBwY2lfZW5hYmxlX2RldmljZShwZGV2KTsKKwlpZiAocmV0KQorCQlnb3Rv
IGVycl9mcmVlOworCisJZGV2LT5wZGV2ID0gcGRldjsKKyNpZmRlZiBfX2FscGhhX18KKwlkZXYt
Pmhvc2UgPSBwZGV2LT5zeXNkYXRhOworI2VuZGlmCisKKwlwY2lfc2V0X2RydmRhdGEocGRldiwg
ZGV2KTsKKworCWlmIChwY2lfZmluZF9jYXBhYmlsaXR5KGRldi0+cGRldiwgUENJX0NBUF9JRF9B
R1ApKQorCQlkZXYtPmFncCA9IGRybV9hZ3BfaW5pdChkZXYpOworCWlmIChkZXYtPmFncCkgewor
CQlkZXYtPmFncC0+YWdwX210cnIgPSBhcmNoX3BoeXNfd2NfYWRkKAorCQkJZGV2LT5hZ3AtPmFn
cF9pbmZvLmFwZXJfYmFzZSwKKwkJCWRldi0+YWdwLT5hZ3BfaW5mby5hcGVyX3NpemUgKgorCQkJ
MTAyNCAqIDEwMjQpOworCX0KKworCXJldCA9IGRybV9kZXZfcmVnaXN0ZXIoZGV2LCBlbnQtPmRy
aXZlcl9kYXRhKTsKKwlpZiAocmV0KQorCQlnb3RvIGVycl9hZ3A7CisKKwlyZXR1cm4gMDsKKwor
ZXJyX2FncDoKKwlpZiAoZGV2LT5hZ3ApCisJCWFyY2hfcGh5c193Y19kZWwoZGV2LT5hZ3AtPmFn
cF9tdHJyKTsKKwlrZnJlZShkZXYtPmFncCk7CisJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOwor
ZXJyX2ZyZWU6CisJZHJtX2Rldl9wdXQoZGV2KTsKKwlyZXR1cm4gcmV0OwogfQogCiBzdGF0aWMg
dm9pZApAQCAtNTYyLDcgKzYwMSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRp
b25zIHJhZGVvbl9kcml2ZXJfa21zX2ZvcHMgPSB7CiAKIHN0YXRpYyBzdHJ1Y3QgZHJtX2RyaXZl
ciBrbXNfZHJpdmVyID0gewogCS5kcml2ZXJfZmVhdHVyZXMgPQotCSAgICBEUklWRVJfVVNFX0FH
UCB8IERSSVZFUl9HRU0gfCBEUklWRVJfUkVOREVSLAorCSAgICBEUklWRVJfR0VNIHwgRFJJVkVS
X1JFTkRFUiwKIAkubG9hZCA9IHJhZGVvbl9kcml2ZXJfbG9hZF9rbXMsCiAJLm9wZW4gPSByYWRl
b25fZHJpdmVyX29wZW5fa21zLAogCS5wb3N0Y2xvc2UgPSByYWRlb25fZHJpdmVyX3Bvc3RjbG9z
ZV9rbXMsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jCmluZGV4IGNhYjg5MWY4NmRjMC4u
NTgxNzZkYjg1OTUyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9r
bXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwpAQCAtMzIsNiAr
MzIsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KICNpbmNsdWRlIDxsaW51eC92Z2Ff
c3dpdGNoZXJvby5oPgogCisjaW5jbHVkZSA8ZHJtL2RybV9hZ3BzdXBwb3J0Lmg+CiAjaW5jbHVk
ZSA8ZHJtL2RybV9mYl9oZWxwZXIuaD4KICNpbmNsdWRlIDxkcm0vZHJtX2ZpbGUuaD4KICNpbmNs
dWRlIDxkcm0vZHJtX2lvY3RsLmg+CkBAIC03Nyw2ICs3OCwxMSBAQCB2b2lkIHJhZGVvbl9kcml2
ZXJfdW5sb2FkX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQogCXJhZGVvbl9tb2Rlc2V0X2Zp
bmkocmRldik7CiAJcmFkZW9uX2RldmljZV9maW5pKHJkZXYpOwogCisJaWYgKGRldi0+YWdwKQor
CQlhcmNoX3BoeXNfd2NfZGVsKGRldi0+YWdwLT5hZ3BfbXRycik7CisJa2ZyZWUoZGV2LT5hZ3Ap
OworCWRldi0+YWdwID0gTlVMTDsKKwogZG9uZV9mcmVlOgogCWtmcmVlKHJkZXYpOwogCWRldi0+
ZGV2X3ByaXZhdGUgPSBOVUxMOwotLSAKMi4yNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
