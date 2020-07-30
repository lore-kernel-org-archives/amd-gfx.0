Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08C9C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9428C207F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkxioqUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9428C207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30CCF6E960;
	Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8CA6E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:31 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id e5so7295090qth.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H6J/OMUiTX/EqW9wNqahKFQ3T/6gOSNVZDo7hs8BMvU=;
 b=FkxioqUJsFl/IzSqMA+BuhzPwS4Trf+yMHYV5Jont2z5lP9uIt6yCmA3aBa97ljPz2
 OVRA45c1Czx3LLhFi1T1wMbDtVwTi+Bg/spJtzdJEwC43B6jbUMecf0C7S3WUkD5wr8G
 jJW9+mdUYtt50592PFdalmfqPk2nNL6Dyq402YnBlquS0sI5i5Q0pgZIMGx4csciSLyE
 BdBFNDolIdFtE168EU1VjWa4Tz27pxin7D+AHx1Yqfyu9tl/3t3EsRsWcwlTNILkxJxl
 NLzN8YUc1e66TetHKcaxCB/ChgGfhXL8I9DqUVvrTOCIYFC2e8GuEfW88sz6pnJOYVMq
 Qq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H6J/OMUiTX/EqW9wNqahKFQ3T/6gOSNVZDo7hs8BMvU=;
 b=TeopHJl/jYG97ad0BWjmKcqexoUUBVOOqqly4bdILkvXDK/QCzU/SDl+6v4UvOQgrw
 GBbjTLvR7Wtmdbq/7GrPmEE41Rh1ipyeqQcXTUyfTxVB/kra4oqISPoHEDs5UBWvVgir
 cEjYC1k7Ya/SrgrMVEd2Lo+cqJtld/cMc4N+lKckPVXOi7PJcCNsHrxIGKjWK3kCTy8w
 Hb6gsLyne/Hw7ePUk/L75LKyGU3roel8koyIMD22qb+uCUx85MmXuuNz0rrc+G4vD0XN
 YkAToEajefZ/Uf19/QGcphj3BbHD/cmhFxza8pDoo5p7a1Pl55TFtbvziwEd303tdjI4
 ijGg==
X-Gm-Message-State: AOAM530+fTbkQ4G6r8mrGXQqpgML8Gks9g+zoZ2meoVEIN6JwbZYdixU
 F3EVtJ0YyVpbNcmYmIJMMOvb7l3w
X-Google-Smtp-Source: ABdhPJw3pbxgyDH5IRr3O3qxY05EnsynUh5Pqp2U2gSDUI45H4GQCARSTM2nnuyhmO4akL0dP4//Og==
X-Received: by 2002:ac8:2b88:: with SMTP id m8mr344592qtm.183.1596139470178;
 Thu, 30 Jul 2020 13:04:30 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:29 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/17] drm/amdgpu/gmc: add new helper to get the FB size used
 by pre-OS console
Date: Thu, 30 Jul 2020 16:04:04 -0400
Message-Id: <20200730200414.40485-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200730200414.40485-1-alexander.deucher@amd.com>
References: <20200730200414.40485-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBhZGRzIGEgbmV3IGdtYyBjYWxsYmFjayB0byBnZXQgdGhlIHNpemUgcmVzZXJ2ZWQgYnkg
dGhlIHByZS1PUwpjb25zb2xlIGFuZCBwcm92aWRlcyBhIGhlbHBlciBmdW5jdGlvbiBmb3IgdXNl
IGJ5IGdtYyBJUCBkcml2ZXJzLgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dt
Yy5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5oIHwgIDUgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21j
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKaW5kZXggMjFkMmM4
NTQzZjg1Li5mYzllMThhYWE3NmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMKQEAgLTI3LDYgKzI3LDcgQEAKICNpbmNsdWRlIDxsaW51eC9pby02NC1ub25hdG9taWMt
bG8taGkuaD4KIAogI2luY2x1ZGUgImFtZGdwdS5oIgorI2luY2x1ZGUgImFtZGdwdV9nbWMuaCIK
ICNpbmNsdWRlICJhbWRncHVfcmFzLmgiCiAjaW5jbHVkZSAiYW1kZ3B1X3hnbWkuaCIKIApAQCAt
NDMxLDMgKzQzMiw0NSBAQCB2b2lkIGFtZGdwdV9nbWNfc2V0X3ZtX2ZhdWx0X21hc2tzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgaHViX3R5cGUsCiAJCVdSRUczMihyZWcsIHRtcCk7
CiAJfQogfQorCit2b2lkIGFtZGdwdV9nbWNfZ2V0X3ZiaW9zX2FsbG9jYXRpb25zKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQoreworCXVuc2lnbmVkIHNpemU7CisKKwkvKgorCSAqIFRPRE86
CisJICogQ3VycmVudGx5IHRoZXJlIGlzIGEgYnVnIHdoZXJlIHNvbWUgbWVtb3J5IGNsaWVudCBv
dXRzaWRlCisJICogb2YgdGhlIGRyaXZlciB3cml0ZXMgdG8gZmlyc3QgOE0gb2YgVlJBTSBvbiBT
MyByZXN1bWUsCisJICogdGhpcyBvdmVycmlkZXMgR0FSVCB3aGljaCBieSBkZWZhdWx0IGdldHMg
cGxhY2VkIGluIGZpcnN0IDhNIGFuZAorCSAqIGNhdXNlcyBWTV9GQVVMVFMgb25jZSBHVFQgaXMg
YWNjZXNzZWQuCisJICogS2VlcCB0aGUgc3RvbGVuIG1lbW9yeSByZXNlcnZhdGlvbiB1bnRpbCB0
aGUgd2hpbGUgdGhpcyBpcyBub3Qgc29sdmVkLgorCSAqLworCXN3aXRjaCAoYWRldi0+YXNpY190
eXBlKSB7CisJY2FzZSBDSElQX1ZFR0ExMDoKKwljYXNlIENISVBfUkFWRU46CisJY2FzZSBDSElQ
X0FSQ1RVUlVTOgorCWNhc2UgQ0hJUF9SRU5PSVI6CisJCWFkZXYtPmdtYy5rZWVwX3N0b2xlbl92
Z2FfbWVtb3J5ID0gdHJ1ZTsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJYWRldi0+Z21jLmtlZXBf
c3RvbGVuX3ZnYV9tZW1vcnkgPSBmYWxzZTsKKwkJYnJlYWs7CisJfQorCisJaWYgKCFhbWRncHVf
ZGV2aWNlX2lwX2dldF9pcF9ibG9jayhhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9EQ0UpKQorCQlz
aXplID0gMDsKKwllbHNlCisJCXNpemUgPSBhbWRncHVfZ21jX2dldF92Ymlvc19mYl9zaXplKGFk
ZXYpOworCisJLyogc2V0IHRvIDAgaWYgdGhlIHByZS1PUyBidWZmZXIgdXNlcyB1cCBtb3N0IG9m
IHZyYW0gKi8KKwlpZiAoKGFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSAtIHNpemUpIDwgKDggKiAx
MDI0ICogMTAyNCkpCisJCXNpemUgPSAwOworCisJaWYgKHNpemUgPiBBTURHUFVfVkJJT1NfVkdB
X0FMTE9DQVRJT04pIHsKKwkJYWRldi0+Z21jLnN0b2xlbl92Z2Ffc2l6ZSA9IEFNREdQVV9WQklP
U19WR0FfQUxMT0NBVElPTjsKKwkJYWRldi0+Z21jLnN0b2xlbl9leHRlbmRlZF9zaXplID0gc2l6
ZSAtIGFkZXYtPmdtYy5zdG9sZW5fdmdhX3NpemU7CisJfSBlbHNlIHsKKwkJYWRldi0+Z21jLnN0
b2xlbl92Z2Ffc2l6ZSA9IHNpemU7CisJCWFkZXYtPmdtYy5zdG9sZW5fZXh0ZW5kZWRfc2l6ZSA9
IDA7CisJfQorfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dtYy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCmluZGV4IDhm
NGFmOTU1ZDcyYy4uYzJhODVkMGIxNTQ2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5oCkBAIC0xMzEsNiArMTMxLDggQEAgc3RydWN0IGFtZGdwdV9nbWNfZnVuY3Mgewog
CXZvaWQgKCpnZXRfdm1fcHRlKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgIHN0
cnVjdCBhbWRncHVfYm9fdmFfbWFwcGluZyAqbWFwcGluZywKIAkJCSAgIHVpbnQ2NF90ICpmbGFn
cyk7CisJLyogZ2V0IHRoZSBhbW91bnQgb2YgbWVtb3J5IHVzZWQgYnkgdGhlIHZiaW9zIGZvciBw
cmUtT1MgY29uc29sZSAqLworCXVuc2lnbmVkIGludCAoKmdldF92Ymlvc19mYl9zaXplKShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiB9OwogCiBzdHJ1Y3QgYW1kZ3B1X3hnbWkgewpAQCAt
MjUzLDYgKzI1NSw3IEBAIHN0cnVjdCBhbWRncHVfZ21jIHsKICNkZWZpbmUgYW1kZ3B1X2dtY19t
YXBfbXR5cGUoYWRldiwgZmxhZ3MpIChhZGV2KS0+Z21jLmdtY19mdW5jcy0+bWFwX210eXBlKChh
ZGV2KSwoZmxhZ3MpKQogI2RlZmluZSBhbWRncHVfZ21jX2dldF92bV9wZGUoYWRldiwgbGV2ZWws
IGRzdCwgZmxhZ3MpIChhZGV2KS0+Z21jLmdtY19mdW5jcy0+Z2V0X3ZtX3BkZSgoYWRldiksIChs
ZXZlbCksIChkc3QpLCAoZmxhZ3MpKQogI2RlZmluZSBhbWRncHVfZ21jX2dldF92bV9wdGUoYWRl
diwgbWFwcGluZywgZmxhZ3MpIChhZGV2KS0+Z21jLmdtY19mdW5jcy0+Z2V0X3ZtX3B0ZSgoYWRl
diksIChtYXBwaW5nKSwgKGZsYWdzKSkKKyNkZWZpbmUgYW1kZ3B1X2dtY19nZXRfdmJpb3NfZmJf
c2l6ZShhZGV2KSAoYWRldiktPmdtYy5nbWNfZnVuY3MtPmdldF92Ymlvc19mYl9zaXplKChhZGV2
KSkKIAogLyoqCiAgKiBhbWRncHVfZ21jX3ZyYW1fZnVsbF92aXNpYmxlIC0gQ2hlY2sgaWYgZnVs
bCBWUkFNIGlzIHZpc2libGUgdGhyb3VnaCB0aGUgQkFSCkBAIC0zMDcsNCArMzEwLDYgQEAgZXh0
ZXJuIHZvaWQKIGFtZGdwdV9nbWNfc2V0X3ZtX2ZhdWx0X21hc2tzKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBpbnQgaHViX3R5cGUsCiAJCQkgICAgICBib29sIGVuYWJsZSk7CiAKK3ZvaWQg
YW1kZ3B1X2dtY19nZXRfdmJpb3NfYWxsb2NhdGlvbnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpOworCiAjZW5kaWYKLS0gCjIuMjUuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
