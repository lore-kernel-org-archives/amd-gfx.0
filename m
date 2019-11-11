Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FDEC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE9820659
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE9820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F05E6E2E8;
	Mon, 11 Nov 2019 20:49:48 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1206E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 20:49:47 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id q18so6724202ybq.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 12:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nk7Dn9fiySaT3rZgr02InOw2fA/ANB19fD9+43q8N40=;
 b=jAvjTZoxkUYrJ4SHfw6H17a5wm8d353hjPkY2y+fhaxFs+LsAs69pGfZiBh+1CsVZg
 qZEoe6gSs2i9c0zydOHrBnSAelHqFr4n7E24KJ1k/KufLFZD26fvQ+u62ihxzhYsUvN6
 JAgG651zVL6ulf5yHUW626urIB4Ss3imeLgx3VpCC7dmOM25Jg5/YWda8/7b0l8ii7uo
 Y8zUWPGeA2PrnNeWOi0st5tTvu5+J/EG+rQU6eWpZpS6X22FNqStEpYSeywrs4vuoMWH
 YXNt9x/8/JWpqBH4CKCYSyvAMHEhi6WdaPOMEfAYeaCjx6lZrTgIdJ0U2GvlLVyXnCH1
 rs0A==
X-Gm-Message-State: APjAAAWQPQuL8wW1oHPK24bVPVnG+h5bbyL6HlA1H/6K0BV6v2b2jW2U
 guC1UR0dUq9fysO006iLEj5jCCkX
X-Google-Smtp-Source: APXvYqx6VVSXy8HwT0MlFMKoPBL/L+pYwzW+2CimiCCunROWfYDrEJQHN0Qx3PIGfFRIv4bQIbxbdA==
X-Received: by 2002:a25:9304:: with SMTP id f4mr22042528ybo.18.1573505386491; 
 Mon, 11 Nov 2019 12:49:46 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 197sm7095055ywf.42.2019.11.11.12.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 12:49:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn: finish delay work before release resources
Date: Mon, 11 Nov 2019 15:49:38 -0500
Message-Id: <20191111204938.836819-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nk7Dn9fiySaT3rZgr02InOw2fA/ANB19fD9+43q8N40=;
 b=eG2BROaSjYMgi2mbzsCXWym/bx1L3T4yUFBQKc2KCRKtkQeFZ2SIZQOydp7o92u751
 KJcmZi9GC8XgNfEF8o0MqZnbQ7Zraq4iPn1+61dNioRgh+Lk+OUmH1cykeQPBnaA0FZw
 DVPQVxbpck5a9oUDw6VD8BqFp1gFOsjs+teEOTuMSgvd9/66X3nNr5+mbbUJW3pzQgNq
 C6Z0OPZWJJrVYUeZIA9pKM8OEfzRxAJ51gK7Nk1fekj0Uxoe4wZIA/NzG26FS3AvjfA0
 YZqvZHrXpGsEM+GEGIp3FjHe5YmzXzZ6f9gAvDMXRYtS4UwLHA6R3JahCp3ge1e8Jinu
 Acdg==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111204938.7I3B_M5CBaptDEIbD_oOR-MPvZ9zWSmuEWKH--nOIB4@z>

Zmx1c2gvY2FuY2VsIGRlbGF5ZWQgd29ya3MgYmVmb3JlIGRvaW5nIGZpbmFsaXphdGlvbgp0byBh
dm9pZCBjb25jdXJyZW50bHkgcmVxdWVzdHMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwppbmRleCAzMTk5ZTRhNWZmMTIu
LjlkODcwNDQ0ZDdkNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwpA
QCAtMTkzLDYgKzE5Myw4IEBAIGludCBhbWRncHVfdmNuX3N3X2Zpbmkoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCiB7CiAJaW50IGksIGo7CiAKKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMo
JmFkZXYtPnZjbi5pZGxlX3dvcmspOworCiAJaWYgKGFkZXYtPnZjbi5pbmRpcmVjdF9zcmFtKSB7
CiAJCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+dmNuLmRwZ19zcmFtX2JvLAogCQkJCSAg
ICAgICZhZGV2LT52Y24uZHBnX3NyYW1fZ3B1X2FkZHIsCi0tIAoyLjIzLjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
