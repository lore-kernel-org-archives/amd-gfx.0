Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D017C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 13:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F88B23128
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 13:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMnqC1XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F88B23128
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884AD6E8B9;
	Thu,  6 Aug 2020 13:51:54 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261BA6E8B8;
 Thu,  6 Aug 2020 13:51:53 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id p20so9184313wrf.0;
 Thu, 06 Aug 2020 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dwhMMBOomxuI1HU8CCuluqVCaZc0oC4HSUbQVDlA4qU=;
 b=YMnqC1XXD7PjLjCWpYYrQdJ5Yk+pUCCI0tjPzJE2LOrrTA8Vd+kZ194Jk55EZdbQFc
 3AgXEtlHX8PYuFgErpDKTVvtxrsmDfIfHSPb9PIOdkGp7DnyqWCdjO6bA8UST//AbdX+
 WdITSc4HtLAwYth+Ba2HtLIx16qaFSCyqi1bHxpYD2ev0fCE0hMw1tVjkppcOj3sSg2Z
 FGfowEwCHb5UF7xxIQQlXuuWncaMM7ma9KzM3G/GF4W/YsBDgfOaAOgxultiPQnhIoba
 FgfGhdW0kcE7Ss5pvYyQ5qx12O1Kdx5wl7YOuOjp4WibIYixcNNR1e0ykKWzGbzsySm+
 DTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dwhMMBOomxuI1HU8CCuluqVCaZc0oC4HSUbQVDlA4qU=;
 b=DFFPEK/ZJ+l+GwGg4qtDQRFb3t0mspvDX0W9p0mxFOLYgGqlGhvGTkei3s+1L9uVad
 8+r0RuvZOyzv36qsOryEYOAyBz5yMbkdT94aRng5ss+g2XAniJj3+bxPif9Oheqq4lm+
 0NETCpRK8H9iWDcxuV5yIujcsOuFYWVgY+8XWm//+3/7WppsgY8w/CMzwPujnqSKZtNP
 UK3wTDFfBMxkquhcJnhkjvFU5PR6tClDsPbBgRAohnF0Pw3UdRsjVUWrxXFywvYFSQzl
 h0mNSiIiN2YTv4EoVUKsZEBY92knaM+pBFgXgPuqhZjj8jiOkv4Lf8on++wChjXjVA0D
 YtgQ==
X-Gm-Message-State: AOAM533iG7yHm7C7qVrsrgH6AbsFZ7WYslIS32MEmGT5CUrXukMt5akY
 sWuz9u+8VXYqBLUoHkObpHZG9lE6
X-Google-Smtp-Source: ABdhPJy5a65hcscMOnfXcap6vSRgtvPC1QUGVSoT21Tzgv2R3PmwCleGbtbIVu/7XINdc2lY1H+Tnw==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr7634524wrv.208.1596721911505; 
 Thu, 06 Aug 2020 06:51:51 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3fec:7447:4f4b:c982])
 by smtp.gmail.com with ESMTPSA id r206sm6664204wma.6.2020.08.06.06.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:51:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/radeon: drop superflous AGP handling
Date: Thu,  6 Aug 2020 15:51:48 +0200
Message-Id: <20200806135148.2032-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806135148.2032-1-christian.koenig@amd.com>
References: <20200806135148.2032-1-christian.koenig@amd.com>
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
Cc: airlied@gmail.com, daniel@ffwll.ch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIG9iamVjdCBmbGFncyBjcmVhdGVkIGluIHJhZGVvbl90dG1fcGxhY2VtZW50X2Zyb21fZG9t
YWluIHRha2UgY2FyZSB0aGF0CndlIHVzZSB0aGUgY29ycmVjdCBjYWNoaW5nIGZvciBBR1AsIHRo
aXMgaXMganVzdCBzdXBlcmZsb3VzLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX3R0bS5jIHwgMjEgKystLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0
bS5jCmluZGV4IDMxZjRjZjIxMWI2YS4uMjkwYzhiNDc5ODUzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl90dG0uYwpAQCAtNzYsMjYgKzc2LDkgQEAgc3RhdGljIGludCByYWRlb25fdHRtX2lu
aXRfdnJhbShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldikKIAogc3RhdGljIGludCByYWRlb25f
dHRtX2luaXRfZ3R0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogewotCXVpbnQzMl90IGF2
YWlsYWJsZV9jYWNoaW5nLCBkZWZhdWx0X2NhY2hpbmc7Ci0KLQlhdmFpbGFibGVfY2FjaGluZyA9
IFRUTV9QTF9NQVNLX0NBQ0hJTkc7Ci0JZGVmYXVsdF9jYWNoaW5nID0gVFRNX1BMX0ZMQUdfQ0FD
SEVEOwotCi0jaWYgSVNfRU5BQkxFRChDT05GSUdfQUdQKQotCWlmIChyZGV2LT5mbGFncyAmIFJB
REVPTl9JU19BR1ApIHsKLQkJaWYgKCFyZGV2LT5kZGV2LT5hZ3ApIHsKLQkJCURSTV9FUlJPUigi
QUdQIGlzIG5vdCBlbmFibGVkXG4iKTsKLQkJCXJldHVybiAtRUlOVkFMOwotCQl9Ci0JCWF2YWls
YWJsZV9jYWNoaW5nID0gVFRNX1BMX0ZMQUdfVU5DQUNIRUQgfAotCQkJVFRNX1BMX0ZMQUdfV0M7
Ci0JCWRlZmF1bHRfY2FjaGluZyA9IFRUTV9QTF9GTEFHX1dDOwotCX0KLSNlbmRpZgotCiAJcmV0
dXJuIHR0bV9yYW5nZV9tYW5faW5pdCgmcmRldi0+bW1hbi5iZGV2LCBUVE1fUExfVFQsCi0JCQkJ
ICBhdmFpbGFibGVfY2FjaGluZywKLQkJCQkgIGRlZmF1bHRfY2FjaGluZywgdHJ1ZSwKKwkJCQkg
IFRUTV9QTF9NQVNLX0NBQ0hJTkcsCisJCQkJICBUVE1fUExfRkxBR19DQUNIRUQsIHRydWUsCiAJ
CQkJICByZGV2LT5tYy5ndHRfc2l6ZSA+PiBQQUdFX1NISUZUKTsKIH0KIAotLSAKMi4xNy4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
