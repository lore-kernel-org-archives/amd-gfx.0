Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7132CA9EBB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 07:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C5820856
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 07:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C5820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E726E116;
	Thu, 24 Oct 2019 07:31:06 +0000 (UTC)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9EB6EAE9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 14:35:38 +0000 (UTC)
Received: by mail-yw1-xc44.google.com with SMTP id d5so1931259ywk.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 07:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pZ4thQ0v1T5d/3KKu6FY+f6uHJ+6DxiLQVBSGiRY5WY=;
 b=ZpM/orhhO44bsaExq1AUX3ae/bA0oSpT2m2q8envkt5TS+xWDAH+JbRP99FS/O97WD
 pILqMg71jeatx8qBOiifAuzbmab1PXKYoVDHyblnbvxx+3WFhu3whzWBIzAD91gYvUlF
 /vhl1yLQrrGkYRLdot2+KNIY6XE43a4cF5mgFzI9VyBbe08UaVqL6E5WSksO4rwk2PCh
 Jyr3ieYjpnBeumEu7a6XGbsxwlo/QlueTCxKuIzImoKjWaw/D2k2uaEiizvW6GYOZKWD
 tmMZMqIU+jl0yRR/7WTGmw30Waja8QAtfG1HNvybq/Tj0dpL+0Gom5OslvP4Qkv8BxL3
 niow==
X-Gm-Message-State: APjAAAUeiAsTzglokjVyeoGt2v99Msz/jmgxd/9yo5xgVTmzlXDkgFUt
 SO0ukK0PhVv+LwADlguXVuaEwJDWJzM=
X-Google-Smtp-Source: APXvYqyfnCpHEETY2Qa+nhmCZc3aJq3wCgjsRFOwfA4ztTETEAGiEPSVd7GQJHTwSgB/mFqamlG93Q==
X-Received: by 2002:a81:4a02:: with SMTP id x2mr3007712ywa.31.1571841337403;
 Wed, 23 Oct 2019 07:35:37 -0700 (PDT)
Received: from brihaspati.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id s184sm5190883ywg.61.2019.10.23.07.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 07:35:36 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu: remove unused variable in amdgpu_gfx_kiq_free_ring
Date: Wed, 23 Oct 2019 16:35:17 +0200
Message-Id: <20191023143517.57753-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 24 Oct 2019 07:31:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pZ4thQ0v1T5d/3KKu6FY+f6uHJ+6DxiLQVBSGiRY5WY=;
 b=eAkj+XasyDF085xkRvfjoGBiVMNziaTrkdzrAsdRZ7roYlu6fv8urzvKVISHKwdSsZ
 Uti0NJi1XNgsNM2Wnwt/UqhQ/OL0CUpk/XBBKMbtNKX0VAETa0JsW5bYXAQSQLZmDJbZ
 QPr1bHjrCutS3I977BIXELAnw2rkPpWfq8OxIn1M2q+tWH5cgyf47ySLBfwmltztjmoc
 v+UBu9EZrsK5J5H7r0QVcq73rVTehii2YgMKcxaA4BSvCoyy+MptbjRw75jgRD34C8V0
 LVYzyzSEMiHUvWNdFj1n5LW3xzeGm66l8P0Gslq0N1rOGfwHNBmJHAufMBRj7Pgj6sX1
 hLfQ==
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023143517.6brd8oezsJVh3lW0k5ofSBrQIUILXQX-dtJe9kIqf94@z>

U2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyB8IDMgKy0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmggfCAzICstLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMgIHwgMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y4XzAuYyAgIHwgMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAg
IHwgMiArLQogNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jCmluZGV4IDA2OTUxNWY1N2My
YS4uYzlkMWZhZGE2MTg4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2Z4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5j
CkBAIC0zMTksOCArMzE5LDcgQEAgaW50IGFtZGdwdV9nZnhfa2lxX2luaXRfcmluZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKIAlyZXR1cm4gcjsKIH0KIAotdm9pZCBhbWRncHVfZ2Z4X2tp
cV9mcmVlX3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAotCQkJICAgICAgc3RydWN0IGFt
ZGdwdV9pcnFfc3JjICppcnEpCit2b2lkIGFtZGdwdV9nZnhfa2lxX2ZyZWVfcmluZyhzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcpCiB7CiAJYW1kZ3B1X2RldmljZV93Yl9mcmVlKHJpbmctPmFkZXYs
IHJpbmctPmFkZXYtPnZpcnQucmVnX3ZhbF9vZmZzKTsKIAlhbWRncHVfcmluZ19maW5pKHJpbmcp
OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCmluZGV4IDM1ZWZmOWU2Y2Ux
Ni4uNDU5YWE5MDU5NTQyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2Z4LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5o
CkBAIC0zMzAsOCArMzMwLDcgQEAgaW50IGFtZGdwdV9nZnhfa2lxX2luaXRfcmluZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAog
CQkJICAgICBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMgKmlycSk7CiAKLXZvaWQgYW1kZ3B1X2dmeF9r
aXFfZnJlZV9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKLQkJCSAgICAgIHN0cnVjdCBh
bWRncHVfaXJxX3NyYyAqaXJxKTsKK3ZvaWQgYW1kZ3B1X2dmeF9raXFfZnJlZV9yaW5nKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZyk7CiAKIHZvaWQgYW1kZ3B1X2dmeF9raXFfZmluaShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldik7CiBpbnQgYW1kZ3B1X2dmeF9raXFfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5k
ZXggOGZjYTZhYjVmYThmLi5hYzQzYjFhZjY5ZTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTBfMC5jCkBAIC0xNDQzLDcgKzE0NDMsNyBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9z
d19maW5pKHZvaWQgKmhhbmRsZSkKIAkJYW1kZ3B1X3JpbmdfZmluaSgmYWRldi0+Z2Z4LmNvbXB1
dGVfcmluZ1tpXSk7CiAKIAlhbWRncHVfZ2Z4X21xZF9zd19maW5pKGFkZXYpOwotCWFtZGdwdV9n
Znhfa2lxX2ZyZWVfcmluZygmYWRldi0+Z2Z4LmtpcS5yaW5nLCAmYWRldi0+Z2Z4LmtpcS5pcnEp
OworCWFtZGdwdV9nZnhfa2lxX2ZyZWVfcmluZygmYWRldi0+Z2Z4LmtpcS5yaW5nKTsKIAlhbWRn
cHVfZ2Z4X2tpcV9maW5pKGFkZXYpOwogCiAJZ2Z4X3YxMF8wX3BmcF9maW5pKGFkZXYpOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKaW5kZXggYTdmZTBlYTI0ZDFmLi5lNGM2NDVk
YTRlMjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwpAQCAtMjEwMyw3ICsy
MTAzLDcgQEAgc3RhdGljIGludCBnZnhfdjhfMF9zd19maW5pKHZvaWQgKmhhbmRsZSkKIAkJYW1k
Z3B1X3JpbmdfZmluaSgmYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXSk7CiAKIAlhbWRncHVfZ2Z4
X21xZF9zd19maW5pKGFkZXYpOwotCWFtZGdwdV9nZnhfa2lxX2ZyZWVfcmluZygmYWRldi0+Z2Z4
LmtpcS5yaW5nLCAmYWRldi0+Z2Z4LmtpcS5pcnEpOworCWFtZGdwdV9nZnhfa2lxX2ZyZWVfcmlu
ZygmYWRldi0+Z2Z4LmtpcS5yaW5nKTsKIAlhbWRncHVfZ2Z4X2tpcV9maW5pKGFkZXYpOwogCiAJ
Z2Z4X3Y4XzBfbWVjX2ZpbmkoYWRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
YwppbmRleCBkZDM0NWZjZWRiOTcuLjlmZTk1ZTc2OTNkNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCkBAIC0yMTUzLDcgKzIxNTMsNyBAQCBzdGF0aWMgaW50IGdmeF92OV8w
X3N3X2Zpbmkodm9pZCAqaGFuZGxlKQogCQlhbWRncHVfcmluZ19maW5pKCZhZGV2LT5nZnguY29t
cHV0ZV9yaW5nW2ldKTsKIAogCWFtZGdwdV9nZnhfbXFkX3N3X2ZpbmkoYWRldik7Ci0JYW1kZ3B1
X2dmeF9raXFfZnJlZV9yaW5nKCZhZGV2LT5nZngua2lxLnJpbmcsICZhZGV2LT5nZngua2lxLmly
cSk7CisJYW1kZ3B1X2dmeF9raXFfZnJlZV9yaW5nKCZhZGV2LT5nZngua2lxLnJpbmcpOwogCWFt
ZGdwdV9nZnhfa2lxX2ZpbmkoYWRldik7CiAKIAlnZnhfdjlfMF9tZWNfZmluaShhZGV2KTsKLS0g
CjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
