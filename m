Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E2C35242
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2D021741
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVsmoM6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2D021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12416FD8F;
	Fri,  7 Feb 2020 19:51:22 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933626FD8D;
 Fri,  7 Feb 2020 19:51:21 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id d9so270226qte.12;
 Fri, 07 Feb 2020 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V2e5/5/4Extm8IwF0Em+wLxlgLzS4i35oI6Snd77pz0=;
 b=TVsmoM6KIYQUebbV9yvb7AcvhDj0e4WxI+q3pKZo4xE1xDbmcoVLKyd9Mmfgm1XvZs
 hiTER+iorMRr+Hx8UPGqT9kdIma1Pu87OTr5KQraQcGqlqDpd3Hp7+cb/slWjEWpDJTR
 L6wE+PLeJ3hAxFVXafZSM3de4IPRw4yVMuQIC0X+RfNhTgRP4JdMQA0G5i7nQzsf+DEh
 vVPMj1vsKpzaNgACJjP1qn+u+2WzjmUEoWJhtBs7XNjwQ/5FzbszDelizozzfr4JTFjP
 Q4zNOyUgePWpUS7fmvnVNN3kLSDPs4kVwnBjCw5GijfynLGFEQJ/GsTaTs6VXnNGYfuZ
 FGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V2e5/5/4Extm8IwF0Em+wLxlgLzS4i35oI6Snd77pz0=;
 b=C4hX02IwQS/FQnwQYys6kPEqvj7kT1uEFeYwjcRALeGn7nYuMvUFF3syptEkaxanCP
 6K42VkYtj/nbPsbtQYw0LkHZZsrX69+oP3HvtuCX20VWJNJfvgZ6xqogOaeVC3tkIIge
 i6Ylupdc7qM6bxzBBvu9IrLaWPngImgHg3rLHfDlpwWPHdmPthSNON5jmmhccMGgEhdM
 fZUyoVfAKSVnAqFsn7ddrkVwrMoOq6S258GNUBj6d+EOUYLiSLIy8/Likg1DBX/ax0qU
 3nxF2zFOB/PA/MfrVST2To1aqgDFuf904bJHZ7/1WVkXpSMZ9ylg7Ko1GU4kdgeraYm9
 Mpqw==
X-Gm-Message-State: APjAAAXZHK9fcvaTZwFeSDv26ppCPuouyaNk9vygUH2Af4qw1E8ZxR2S
 XG23nkvwiNgWB27R+S+RwW+CweU5
X-Google-Smtp-Source: APXvYqwr1kxZ3NviN3Ty6CTAsSx3Lb91/d+9P5ah02qGSQZZa/AHFGZnG86Gkvzr5C7Ori46TdZZKw==
X-Received: by 2002:ac8:7caf:: with SMTP id z15mr33784qtv.68.1581105080506;
 Fri, 07 Feb 2020 11:51:20 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id w16sm1752226qkj.135.2020.02.07.11.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 11:51:20 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 15/15] drm/amdgpu: drop legacy drm load and unload callbacks
Date: Fri,  7 Feb 2020 14:50:58 -0500
Message-Id: <20200207195058.2354-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207195058.2354-1-alexander.deucher@amd.com>
References: <20200207195058.2354-1-alexander.deucher@amd.com>
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2UndmUgbW92ZWQgdGhlIGRlYnVnZnMgaGFuZGxpbmcgaW50byBhIGNlbnRyYWxpemVkIHBsYWNl
CnNvIHdlIGNhbiByZW1vdmUgdGhlIGxlZ2FjeSBsb2FkIGFuIHVubG9hZCBjYWxsYmFja3MuCgpB
Y2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgIDUgLS0tLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAgICB8IDEzICsrKysrKysrKysr
LS0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggNWFkZjkzNmNm
NzMzLi4zMWUwN2Q0NWViMWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMKQEAgLTMxMjMsMTAgKzMxMjMsNiBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCX0gZWxzZQogCQlhZGV2LT51Y29kZV9zeXNmc19l
biA9IHRydWU7CiAKLQlyID0gYW1kZ3B1X2RlYnVnZnNfaW5pdChhZGV2KTsKLQlpZiAocikKLQkJ
RFJNX0VSUk9SKCJDcmVhdGluZyBkZWJ1Z2ZzIGZpbGVzIGZhaWxlZCAoJWQpLlxuIiwgcik7Ci0K
IAlpZiAoKGFtZGdwdV90ZXN0aW5nICYgMSkpIHsKIAkJaWYgKGFkZXYtPmFjY2VsX3dvcmtpbmcp
CiAJCQlhbWRncHVfdGVzdF9tb3ZlcyhhZGV2KTsKQEAgLTMyNDgsNyArMzI0NCw2IEBAIHZvaWQg
YW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhbWRncHVf
dWNvZGVfc3lzZnNfZmluaShhZGV2KTsKIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfUEVSRl9FVkVO
VFMpKQogCQlhbWRncHVfcG11X2ZpbmkoYWRldik7Ci0JYW1kZ3B1X2RlYnVnZnNfZmluaShhZGV2
KTsKIAlpZiAoYW1kZ3B1X2Rpc2NvdmVyeSAmJiBhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9OQVZJ
MTApCiAJCWFtZGdwdV9kaXNjb3ZlcnlfZmluaShhZGV2KTsKIH0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYwppbmRleCBmMGE4MjQ4NmE5YjcuLmZmNzNhZjE2NWU2MSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtMTAzMSw2ICsxMDMxLDcg
QEAgc3RhdGljIGludCBhbWRncHVfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAogCQkJ
ICAgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpCiB7CiAJc3RydWN0IGRybV9kZXZp
Y2UgKmRldjsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldjsKIAl1bnNpZ25lZCBsb25nIGZs
YWdzID0gZW50LT5kcml2ZXJfZGF0YTsKIAlpbnQgcmV0LCByZXRyeSA9IDA7CiAJYm9vbCBzdXBw
b3J0c19hdG9taWMgPSBmYWxzZTsKQEAgLTExMDAsNiArMTEwMSw4IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwKIAogCXBjaV9zZXRfZHJ2ZGF0YShw
ZGV2LCBkZXYpOwogCisJYW1kZ3B1X2RyaXZlcl9sb2FkX2ttcyhkZXYsIGVudC0+ZHJpdmVyX2Rh
dGEpOworCiByZXRyeV9pbml0OgogCXJldCA9IGRybV9kZXZfcmVnaXN0ZXIoZGV2LCBlbnQtPmRy
aXZlcl9kYXRhKTsKIAlpZiAocmV0ID09IC1FQUdBSU4gJiYgKytyZXRyeSA8PSAzKSB7CkBAIC0x
MTEwLDYgKzExMTMsMTEgQEAgc3RhdGljIGludCBhbWRncHVfcGNpX3Byb2JlKHN0cnVjdCBwY2lf
ZGV2ICpwZGV2LAogCX0gZWxzZSBpZiAocmV0KQogCQlnb3RvIGVycl9wY2k7CiAKKwlhZGV2ID0g
ZGV2LT5kZXZfcHJpdmF0ZTsKKwlyZXQgPSBhbWRncHVfZGVidWdmc19pbml0KGFkZXYpOworCWlm
IChyZXQpCisJCURSTV9FUlJPUigiQ3JlYXRpbmcgZGVidWdmcyBmaWxlcyBmYWlsZWQgKCVkKS5c
biIsIHJldCk7CisKIAlyZXR1cm4gMDsKIAogZXJyX3BjaToKQEAgLTExMjMsNiArMTEzMSw3IEBA
IHN0YXRpYyB2b2lkCiBhbWRncHVfcGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKIHsK
IAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOworCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gZGV2LT5kZXZfcHJpdmF0ZTsKIAogI2lmZGVmIE1PRFVM
RQogCWlmIChUSElTX01PRFVMRS0+c3RhdGUgIT0gTU9EVUxFX1NUQVRFX0dPSU5HKQpAQCAtMTEz
MCw2ICsxMTM5LDggQEAgYW1kZ3B1X3BjaV9yZW1vdmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiAJ
CURSTV9FUlJPUigiSG90cGx1ZyByZW1vdmFsIGlzIG5vdCBzdXBwb3J0ZWRcbiIpOwogCWRybV9k
ZXZfdW5wbHVnKGRldik7CiAJZHJtX2Rldl9wdXQoZGV2KTsKKwlhbWRncHVfZGVidWdmc19maW5p
KGFkZXYpOworCWFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcyhkZXYpOwogCXBjaV9kaXNhYmxlX2Rl
dmljZShwZGV2KTsKIAlwY2lfc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CiB9CkBAIC0xNDM2LDEx
ICsxNDQ3LDkgQEAgc3RhdGljIHN0cnVjdCBkcm1fZHJpdmVyIGttc19kcml2ZXIgPSB7CiAJICAg
IERSSVZFUl9HRU0gfAogCSAgICBEUklWRVJfUkVOREVSIHwgRFJJVkVSX01PREVTRVQgfCBEUklW
RVJfU1lOQ09CSiB8CiAJICAgIERSSVZFUl9TWU5DT0JKX1RJTUVMSU5FLAotCS5sb2FkID0gYW1k
Z3B1X2RyaXZlcl9sb2FkX2ttcywKIAkub3BlbiA9IGFtZGdwdV9kcml2ZXJfb3Blbl9rbXMsCiAJ
LnBvc3RjbG9zZSA9IGFtZGdwdV9kcml2ZXJfcG9zdGNsb3NlX2ttcywKIAkubGFzdGNsb3NlID0g
YW1kZ3B1X2RyaXZlcl9sYXN0Y2xvc2Vfa21zLAotCS51bmxvYWQgPSBhbWRncHVfZHJpdmVyX3Vu
bG9hZF9rbXMsCiAJLmdldF92YmxhbmtfY291bnRlciA9IGFtZGdwdV9nZXRfdmJsYW5rX2NvdW50
ZXJfa21zLAogCS5lbmFibGVfdmJsYW5rID0gYW1kZ3B1X2VuYWJsZV92Ymxhbmtfa21zLAogCS5k
aXNhYmxlX3ZibGFuayA9IGFtZGdwdV9kaXNhYmxlX3ZibGFua19rbXMsCi0tIAoyLjI0LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
