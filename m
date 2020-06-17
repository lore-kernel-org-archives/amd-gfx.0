Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D310C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 11:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701B7207DD
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 11:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwxn7Oq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701B7207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30966E0F6;
	Wed, 17 Jun 2020 11:41:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC066E0F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 11:41:07 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id h5so1978740wrc.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gJ9uMKLYe/HmcANLVX8y9dJZtup3g7yUrY0HDHYM6dk=;
 b=Lwxn7Oq8cwZrf0B0J+GKNj/vJ3mdOZRTe6yff8xk1gujfuX2FaRWbjhFwX5N7Q2FiV
 /NVn31RO9I3nqv9qxZH7bRq0rni7DZLNLJnoqXJLXv5YQ0TTpn98Qs4lkyJt0K0VSmPJ
 0jwp+NDRwsDOnSJBBSMbnNig70yqX46jYW9MwJMmdeR8DgJ0+4SV9xWLp0Kxqhb2VQAO
 oz3IE7BqGCUSPur0NJz2rjTEKhchI6UfwQ2hu0jnQgNXdi8DDmUvO+a9Id8qoOs28gsn
 qjAwPczPfJZmN9nCe049w5vSVSihoErKFcJcpRwhwtE00lvyeCMB0WXOVzde4DcEDwvt
 YFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gJ9uMKLYe/HmcANLVX8y9dJZtup3g7yUrY0HDHYM6dk=;
 b=pMsXBkGvoZbcEc1Mm61FAt9UjZ+E23nq1MgjnGTXdKuf8Ss53wLXTkJZW8cwvvAIsq
 c2wQ5kUXz0tqOYqfM20mcrFajnlQypkWCG1JHop8az9E83z+w09TkAQmN992iqaO1sb3
 I+bILYC2eL2Zrc3+UtZuCUCwhyyMusUsUKr7NKBWRBhXQYbANCgHAePra9hjUdhJEKH5
 DzWO1Pj/+JgOBMpj7LOwWndGG6oNRMB2MzrFOFetW/NjjQH8+rzu0uCsN9s5wHdpTkhZ
 8P8dq4IMyiY7oc1Wg2OejBSMHMY3zTHhXWYh35NjwJhC+SM9hF6xa/ZAgXSBzEnEm/nF
 FMJg==
X-Gm-Message-State: AOAM530lLG+Eqyhlq4WwmRa9mGvJb30R4T/z8B6DB71vu0JRZc7WMEL2
 X1dSOEF52aqQM5BzG1qJogfTWOZzlxc=
X-Google-Smtp-Source: ABdhPJysr/QKGJbiGrci+8Mrgz2jDKoV9roa5XUgEHV7WSdy4An+VFWSDOH/T1ri6un58egId7w7eA==
X-Received: by 2002:adf:efc7:: with SMTP id i7mr8015509wrp.408.1592394065544; 
 Wed, 17 Jun 2020 04:41:05 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300c58f235100662246e764d1921a.dip0.t-ipconnect.de.
 [2003:c5:8f23:5100:6622:46e7:64d1:921a])
 by smtp.gmail.com with ESMTPSA id a16sm33239542wrx.8.2020.06.17.04.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 04:41:04 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: fix compiler warning
Date: Wed, 17 Jun 2020 13:42:18 +0200
Message-Id: <20200617114218.42330-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
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
Cc: nirmoy.das@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgYmVsb3cgd2FybmluZzoKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5j
OiBJbiBmdW5jdGlvbiDigJhkZl92M182X3Jlc2V0X3BlcmZtb25fY250cuKAmToKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5jOjU3MToyOiB3YXJuaW5nOiDigJhoaV9iYXNlX2Fk
ZHLigJkgbWF5IGJlIHVzZWQKdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJl
LXVuaW5pdGlhbGl6ZWRdCiAgNTcxIHwgIGRmX3YzXzZfcGVyZm1vbl93cmVnKGFkZXYsIGxvX2Jh
c2VfYWRkciwgMCwgaGlfYmFzZV9hZGRyLCAwKTsKICAgICAgfCAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpTaWduZWQtb2ZmLWJ5
OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZGZfdjNfNi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGZfdjNfNi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5jCmluZGV4IGE3
YjgyOTJjZWZlZS4uMWFiMjYxODM2OTgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9kZl92M182LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjNf
Ni5jCkBAIC01NjAsNyArNTYwLDcgQEAgc3RhdGljIHZvaWQgZGZfdjNfNl9wbWNfcmVsZWFzZV9j
bnRyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogc3RhdGljIHZvaWQgZGZfdjNfNl9yZXNl
dF9wZXJmbW9uX2NudHIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCSB1aW50NjRf
dCBjb25maWcpCiB7Ci0JdWludDMyX3QgbG9fYmFzZV9hZGRyLCBoaV9iYXNlX2FkZHI7CisJdWlu
dDMyX3QgbG9fYmFzZV9hZGRyID0gMCwgaGlfYmFzZV9hZGRyID0gMDsKIAogCWRmX3YzXzZfcG1j
X2dldF9yZWFkX3NldHRpbmdzKGFkZXYsIGNvbmZpZywgJmxvX2Jhc2VfYWRkciwKIAkJCQkgICAg
ICAmaGlfYmFzZV9hZGRyKTsKLS0gCjIuMjYuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
