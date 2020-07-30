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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45875C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1518A2074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmkcW8bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1518A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6EF6E95E;
	Thu, 30 Jul 2020 20:04:29 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B95B6E95E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:29 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id o22so21077847qtt.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YNxtp3qyYykpTtzHZKpIaFPrf7PLOKjpwihHvI10NsQ=;
 b=KmkcW8bRzw1dEecJkj1V+Ixo7zn1Tc6Kd7byz65i2IwL4a+4Rr6Gpm1r5nyxc2j0Ea
 1+kCcMQEJ4rV6gM73zda69/kHyYP0khy7PG+sLJLRp+EYGszquSxea1ZQMAnVO/YMxNQ
 S6i6HPJN1wHinYAGctfL/gtBidS92e5QCDAx+8QfnKSs4VN0vEt2WCVSxXHgegjdRxNw
 1pmpzqyHLWhudWEslXXt87dl5YmcTVv58q+zRgICSp4cbnw8k6wJkxJvxKCY2RWcDAoc
 KOGvuseyPDlARBJJzz02d+lfKx8ht2aPlRG3SOvmWAPVvZu7+nwCHqLjYrLHWSeT7P6i
 /4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YNxtp3qyYykpTtzHZKpIaFPrf7PLOKjpwihHvI10NsQ=;
 b=UBnsT4fkh3I8fDX0TRjxOAM6qQBBK9cPr/00Vk6UrwMzlyi4DSvUPxZ28IU3vBTrUy
 FfcXUsrQPmmvTwppSYMjVY5PN1YhMIll3pXDq0EDbl2k86SvcUgLOv+3OXI0g9Rz5qjL
 DHpwN1B4VYo/RhmEVc3GebbM+ZOtmHJEaZyvu1lY6/93FQX/lhxLAB5u0Wzdy4FxSvfT
 tZkEwo7zjbEcqG8VOR1WrgUmkoMXM/4YWuS95I4pEqTmbsyNzLTZ5scwEUyPOlk6SBUW
 ellmKo/+AGnmdhpd4nNm7ROVoKsgKzCvRoeDgqqsDGo652tE8+hYU65PnMi1wx592a96
 uJTA==
X-Gm-Message-State: AOAM530vpd7ub0L5x3DgbGWz7xTCGLvo50pqONhtFdN6hDlhMXEIFkbb
 RNXxjYbRhVWCm6H/9bcUF5L7cVqD
X-Google-Smtp-Source: ABdhPJzHqkLwhhmI+jCPk4TMXMPgS65P+vUuIrLzhsQX/Svq2Rwa9X1sh3S5XAtZM9D2g21p8IrMUA==
X-Received: by 2002:ac8:748b:: with SMTP id v11mr328656qtq.293.1596139467452; 
 Thu, 30 Jul 2020 13:04:27 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:26 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/17] drm/amdgpu: move keep stolen memory check into gmc core
Date: Thu, 30 Jul 2020 16:04:02 -0400
Message-Id: <20200730200414.40485-6-alexander.deucher@amd.com>
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

UmF0aGVyIHRoYW4gbGVhdmluZyB0aGlzIGFzIGEgZ21jIHY5IHNwZWNpZmljIGhhY2suCgpSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZp
ZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCAgMSArCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAgOSArKysrKysrKy0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgICB8IDExICsrKy0tLS0tLS0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5oCmluZGV4IGRkYjY0YmU2NzBjMi4uMGNmMThmMDFlNjdhIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCkBAIC0yMTUsNiArMjE1LDcgQEAg
c3RydWN0IGFtZGdwdV9nbWMgewogCWJvb2wJCQlwcnRfd2FybmluZzsKIAl1aW50NjRfdAkJc3Rv
bGVuX3ZnYV9zaXplOwogCXN0cnVjdCBhbWRncHVfYm8JKnN0b2xlbl92Z2FfbWVtb3J5OworCWJv
b2wJCQlrZWVwX3N0b2xlbl92Z2FfbWVtb3J5OwogCXVpbnQzMl90CQlzZHBpZl9yZWdpc3RlcjsK
IAkvKiBhcGVydHVyZXMgKi8KIAl1NjQJCQlzaGFyZWRfYXBlcnR1cmVfc3RhcnQ7CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggMzk3ODExMjdkMDU5Li5mZDYxNzY5
MjAyYjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTIwNDIs
OCArMjA0MiwxMCBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogdm9pZCBhbWRncHVfdHRtX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIHsKIAl2b2lkICpzdG9sZW5fdmdhX2J1ZjsKKwogCS8qIHJldHVybiB0aGUgVkdBIHN0b2xl
biBtZW1vcnkgKGlmIGFueSkgYmFjayB0byBWUkFNICovCi0JYW1kZ3B1X2JvX2ZyZWVfa2VybmVs
KCZhZGV2LT5nbWMuc3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsICZzdG9sZW5fdmdhX2J1Zik7CisJ
aWYgKCFhZGV2LT5nbWMua2VlcF9zdG9sZW5fdmdhX21lbW9yeSkKKwkJYW1kZ3B1X2JvX2ZyZWVf
a2VybmVsKCZhZGV2LT5nbWMuc3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsICZzdG9sZW5fdmdhX2J1
Zik7CiB9CiAKIC8qKgpAQCAtMjA1MSwxMCArMjA1MywxNSBAQCB2b2lkIGFtZGdwdV90dG1fbGF0
ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogICovCiB2b2lkIGFtZGdwdV90dG1f
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKKwl2b2lkICpzdG9sZW5fdmdhX2J1
ZjsKKwogCWlmICghYWRldi0+bW1hbi5pbml0aWFsaXplZCkKIAkJcmV0dXJuOwogCiAJYW1kZ3B1
X3R0bV90cmFpbmluZ19yZXNlcnZlX3ZyYW1fZmluaShhZGV2KTsKKwkvKiByZXR1cm4gdGhlIHN0
b2xlbiB2Z2EgbWVtb3J5IGJhY2sgdG8gVlJBTSAqLworCWlmIChhZGV2LT5nbWMua2VlcF9zdG9s
ZW5fdmdhX21lbW9yeSkKKwkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nbWMuc3RvbGVu
X3ZnYV9tZW1vcnksIE5VTEwsICZzdG9sZW5fdmdhX2J1Zik7CiAJLyogcmV0dXJuIHRoZSBJUCBE
aXNjb3ZlcnkgVE1SIG1lbW9yeSBiYWNrIHRvIFZSQU0gKi8KIAlhbWRncHVfYm9fZnJlZV9rZXJu
ZWwoJmFkZXYtPmRpc2NvdmVyeV9tZW1vcnksIE5VTEwsIE5VTEwpOwogCWFtZGdwdV90dG1fZndf
cmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAu
YwppbmRleCBiNjZjNjA2ODBkYmEuLmM1ZDJlNDM5MGZiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jCkBAIC05MzIsOCArOTMyLDcgQEAgc3RhdGljIGludCBnbWNfdjlfMF9s
YXRlX2luaXQodm9pZCAqaGFuZGxlKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0
cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwogCWludCByOwogCi0JaWYgKCFnbWNfdjlfMF9r
ZWVwX3N0b2xlbl9tZW1vcnkoYWRldikpCi0JCWFtZGdwdV9ib19sYXRlX2luaXQoYWRldik7CisJ
YW1kZ3B1X2JvX2xhdGVfaW5pdChhZGV2KTsKIAogCXIgPSBhbWRncHVfZ21jX2FsbG9jYXRlX3Zt
X2ludl9lbmcoYWRldik7CiAJaWYgKHIpCkBAIC0xMDc2LDcgKzEwNzUsNyBAQCBzdGF0aWMgdW5z
aWduZWQgZ21jX3Y5XzBfZ2V0X3ZiaW9zX2ZiX3NpemUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJICogVE9ETyBSZW1vdmUgb25jZSBHQVJUIGNvcnJ1cHRpb24gaXMgcmVzb2x2ZWQKIAkg
KiBDaGVjayByZWxhdGVkIGNvZGUgaW4gZ21jX3Y5XzBfc3dfZmluaQogCSAqICovCi0JaWYgKGdt
Y192OV8wX2tlZXBfc3RvbGVuX21lbW9yeShhZGV2KSkKKwlpZiAoYWRldi0+Z21jLmtlZXBfc3Rv
bGVuX3ZnYV9tZW1vcnkpCiAJCXJldHVybiBBTURHUFVfVkJJT1NfVkdBX0FMTE9DQVRJT047CiAK
IAlkMXZnYV9jb250cm9sID0gUlJFRzMyX1NPQzE1KERDRSwgMCwgbW1EMVZHQV9DT05UUk9MKTsK
QEAgLTEyNDMsNiArMTI0Miw3IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdCh2b2lkICpo
YW5kbGUpCiAJaWYgKHIpCiAJCXJldHVybiByOwogCisJYWRldi0+Z21jLmtlZXBfc3RvbGVuX3Zn
YV9tZW1vcnkgPSBnbWNfdjlfMF9rZWVwX3N0b2xlbl9tZW1vcnkoYWRldik7CiAJYWRldi0+Z21j
LnN0b2xlbl92Z2Ffc2l6ZSA9IGdtY192OV8wX2dldF92Ymlvc19mYl9zaXplKGFkZXYpOwogCiAJ
LyogTWVtb3J5IG1hbmFnZXIgKi8KQEAgLTEyNzUsMTUgKzEyNzUsMTAgQEAgc3RhdGljIGludCBn
bWNfdjlfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfZmlu
aSh2b2lkICpoYW5kbGUpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Ci0Jdm9pZCAqc3RvbGVuX3ZnYV9idWY7CiAKIAlhbWRn
cHVfZ21jX3Jhc19maW5pKGFkZXYpOwogCWFtZGdwdV9nZW1fZm9yY2VfcmVsZWFzZShhZGV2KTsK
IAlhbWRncHVfdm1fbWFuYWdlcl9maW5pKGFkZXYpOwotCi0JaWYgKGdtY192OV8wX2tlZXBfc3Rv
bGVuX21lbW9yeShhZGV2KSkKLQkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nbWMuc3Rv
bGVuX3ZnYV9tZW1vcnksIE5VTEwsICZzdG9sZW5fdmdhX2J1Zik7Ci0KIAlhbWRncHVfZ2FydF90
YWJsZV92cmFtX2ZyZWUoYWRldik7CiAJYW1kZ3B1X2JvX2ZpbmkoYWRldik7CiAJYW1kZ3B1X2dh
cnRfZmluaShhZGV2KTsKLS0gCjIuMjUuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
