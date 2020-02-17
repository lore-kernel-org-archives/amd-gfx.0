Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A76DC34024
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D000A20801
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMJScIu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D000A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9EA6E96F;
	Mon, 17 Feb 2020 15:02:06 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEB76E978;
 Mon, 17 Feb 2020 15:02:05 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a5so17447005wmb.0;
 Mon, 17 Feb 2020 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bWJVvbyji5lv93ku6dxciulHZbwF+rGmjiubbT57gkM=;
 b=UMJScIu9Z7aNensdn8Wxr2f4THU/W2zkxKndpS2FtJOlhVzWY9KlL0yAQA7ItGnNC3
 gQK4DqhBYVSq4aISfRxg/QS46AlPoDeBBSv4BpbcZAg2hpIT23PGCndNH/lJO5yN/9Ng
 2sVxhEk9EtCfJle86pfK4GTyOMrB8suInAzjDkVpEjoPsq9IVDiowMTmIDG8gQnRvRu9
 k2mAFN8FTqR6FsyojjE0snKWS7fCzJzGiO+RvjY4CiTY9erhaxpLvnj+iCdruoeX2HvO
 L5pXipvryKAEDv6iSTHd4bP2uLEOJRnKlgbayt4ANlDLendyl4nWZuHCmHWU6X3mRyvF
 IqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bWJVvbyji5lv93ku6dxciulHZbwF+rGmjiubbT57gkM=;
 b=mAwdpSHzzZ6c19Qk8w81SNvj3TLEz0RWSWHDDZPnPPqPhRFsc1xE2l4hFmeJ+01fA7
 s5P5f4wFLXY9gFn1Q3JwvnpA2TBs29o2YotEhPNIFCJAaochpEPHhnmB9D6HRjdgn/fN
 91QbdNfb7obFOY8sYCQfpKLOXkDksTnnKnH+CPc5ItXuEtd32c7iIk4iC/UnVTOEcbBg
 qBvsd1/lV3nC3zdwml0t9S+sUeubbC5e3M9aZwa385nxoYlGaFdUsHN/v8uhdrH/V2Ph
 YWefWcrPnXtBCoW0diyGDGsbTiNGvlIHJmlQ4J+HMHWP8QXb49SpklbrlhqCBlLjJEH+
 +y9w==
X-Gm-Message-State: APjAAAX0zdcbSd/FLAp5Vgsm3UKeb/IXKb7hPlk/SKKAydsZ8Jx9bwtL
 DaA/uK4X3dxTi+XVgcF4A6RhIxgFXO+Lbw==
X-Google-Smtp-Source: APXvYqxBNbveVe405k5YBZp6i7W88P8dQDLO/GbCImzL7lj3wNHNZHo9rCmupBf4L+Zzd0hPx444VQ==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr21652083wmj.7.1581951723580;
 Mon, 17 Feb 2020 07:02:03 -0800 (PST)
Received: from brihaspati.fritz.box (pD9566D64.dip0.t-ipconnect.de.
 [217.86.109.100])
 by smtp.gmail.com with ESMTPSA id j15sm1441099wrp.9.2020.02.17.07.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 07:02:02 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 2/8] drm/radeon: don't use ttm bo->offset
Date: Mon, 17 Feb 2020 16:04:21 +0100
Message-Id: <20200217150427.49994-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217150427.49994-1-nirmoy.das@amd.com>
References: <20200217150427.49994-1-nirmoy.das@amd.com>
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q2FsY3VsYXRlIEdQVSBvZmZzZXQgaW4gcmFkZW9uX2JvX2dwdV9vZmZzZXQgd2l0aG91dCBkZXBl
bmRpbmcgb24KYm8tPm9mZnNldAoKU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRh
c0BhbWQuY29tPgpSZXZpZXdlZC1hbmQtdGVzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24u
aCAgICAgICAgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuaCB8
IDE2ICsrKysrKysrKysrKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5j
ICAgIHwgIDQgKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmggYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCmluZGV4IDMwZTMyYWRjMWZjNi4uYjdjM2Zi
MmJmYjU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmgKQEAgLTI4MjgsNiArMjgyOCw3IEBAIGV4
dGVybiB2b2lkIHJhZGVvbl90dG1fc2V0X2FjdGl2ZV92cmFtX3NpemUoc3RydWN0IHJhZGVvbl9k
ZXZpY2UgKnJkZXYsIHU2NCBzaXplCiBleHRlcm4gdm9pZCByYWRlb25fcHJvZ3JhbV9yZWdpc3Rl
cl9zZXF1ZW5jZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKIAkJCQkJICAgICBjb25zdCB1
MzIgKnJlZ2lzdGVycywKIAkJCQkJICAgICBjb25zdCB1MzIgYXJyYXlfc2l6ZSk7CitzdHJ1Y3Qg
cmFkZW9uX2RldmljZSAqcmFkZW9uX2dldF9yZGV2KHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2
KTsKIAogLyoKICAqIHZtCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9vYmplY3QuaCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVjdC5oCmluZGV4
IGQyM2YyZWQ0MTI2ZS4uNGQzNzU3MWM3ZmY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9vYmplY3QuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9vYmplY3QuaApAQCAtOTAsNyArOTAsMjEgQEAgc3RhdGljIGlubGluZSB2b2lkIHJhZGVvbl9i
b191bnJlc2VydmUoc3RydWN0IHJhZGVvbl9ibyAqYm8pCiAgKi8KIHN0YXRpYyBpbmxpbmUgdTY0
IHJhZGVvbl9ib19ncHVfb2Zmc2V0KHN0cnVjdCByYWRlb25fYm8gKmJvKQogewotCXJldHVybiBi
by0+dGJvLm9mZnNldDsKKwlzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldjsKKwl1NjQgc3RhcnQg
PSAwOworCisJcmRldiA9IHJhZGVvbl9nZXRfcmRldihiby0+dGJvLmJkZXYpOworCisJc3dpdGNo
KGJvLT50Ym8ubWVtLm1lbV90eXBlKSB7CisJY2FzZSBUVE1fUExfVFQ6CisJCXN0YXJ0ID0gcmRl
di0+bWMuZ3R0X3N0YXJ0OworCQlicmVhazsKKwljYXNlIFRUTV9QTF9WUkFNOgorCQlzdGFydCA9
IHJkZXYtPm1jLnZyYW1fc3RhcnQ7CisJCWJyZWFrOworCX0KKworCXJldHVybiAoYm8tPnRiby5t
ZW0uc3RhcnQgPDwgUEFHRV9TSElGVCkgKyBzdGFydDsKIH0KIAogc3RhdGljIGlubGluZSB1bnNp
Z25lZCBsb25nIHJhZGVvbl9ib19zaXplKHN0cnVjdCByYWRlb25fYm8gKmJvKQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl90dG0uYwppbmRleCBiYWRmMWI2ZDE1NDkuLjFjODMwMzQ2OGU4ZiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKQEAgLTU2LDcgKzU2LDcgQEAKIHN0YXRpYyBp
bnQgcmFkZW9uX3R0bV9kZWJ1Z2ZzX2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwog
c3RhdGljIHZvaWQgcmFkZW9uX3R0bV9kZWJ1Z2ZzX2Zpbmkoc3RydWN0IHJhZGVvbl9kZXZpY2Ug
KnJkZXYpOwogCi1zdGF0aWMgc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJhZGVvbl9nZXRfcmRldihz
dHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldikKK3N0cnVjdCByYWRlb25fZGV2aWNlICpyYWRlb25f
Z2V0X3JkZXYoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYpCiB7CiAJc3RydWN0IHJhZGVvbl9t
bWFuICptbWFuOwogCXN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2OwpAQCAtODIsNyArODIsNiBA
QCBzdGF0aWMgaW50IHJhZGVvbl9pbml0X21lbV90eXBlKHN0cnVjdCB0dG1fYm9fZGV2aWNlICpi
ZGV2LCB1aW50MzJfdCB0eXBlLAogCQlicmVhazsKIAljYXNlIFRUTV9QTF9UVDoKIAkJbWFuLT5m
dW5jID0gJnR0bV9ib19tYW5hZ2VyX2Z1bmM7Ci0JCW1hbi0+Z3B1X29mZnNldCA9IHJkZXYtPm1j
Lmd0dF9zdGFydDsKIAkJbWFuLT5hdmFpbGFibGVfY2FjaGluZyA9IFRUTV9QTF9NQVNLX0NBQ0hJ
Tkc7CiAJCW1hbi0+ZGVmYXVsdF9jYWNoaW5nID0gVFRNX1BMX0ZMQUdfQ0FDSEVEOwogCQltYW4t
PmZsYWdzID0gVFRNX01FTVRZUEVfRkxBR19NQVBQQUJMRSB8IFRUTV9NRU1UWVBFX0ZMQUdfQ01B
OwpAQCAtMTA0LDcgKzEwMyw2IEBAIHN0YXRpYyBpbnQgcmFkZW9uX2luaXRfbWVtX3R5cGUoc3Ry
dWN0IHR0bV9ib19kZXZpY2UgKmJkZXYsIHVpbnQzMl90IHR5cGUsCiAJY2FzZSBUVE1fUExfVlJB
TToKIAkJLyogIk9uLWNhcmQiIHZpZGVvIHJhbSAqLwogCQltYW4tPmZ1bmMgPSAmdHRtX2JvX21h
bmFnZXJfZnVuYzsKLQkJbWFuLT5ncHVfb2Zmc2V0ID0gcmRldi0+bWMudnJhbV9zdGFydDsKIAkJ
bWFuLT5mbGFncyA9IFRUTV9NRU1UWVBFX0ZMQUdfRklYRUQgfAogCQkJICAgICBUVE1fTUVNVFlQ
RV9GTEFHX01BUFBBQkxFOwogCQltYW4tPmF2YWlsYWJsZV9jYWNoaW5nID0gVFRNX1BMX0ZMQUdf
VU5DQUNIRUQgfCBUVE1fUExfRkxBR19XQzsKLS0gCjIuMjUuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
