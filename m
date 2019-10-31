Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F6BCA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7722086D
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7722086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520FA6EEB7;
	Thu, 31 Oct 2019 14:44:03 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFFD6EEB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:44:02 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id d12so2432418ybn.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 07:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4/7/E6byuuktsBGDhIZq9ku8PeljTeUxI+vqMQaIZe0=;
 b=SDBHBAc7+sN5jhgDZLeB0JDdBN2bZ9LORY6qs2e64OLpir/gbk7SACZrekfYmGpthh
 koPUdtQyVd61FJpwEBvlGCkgKOHyEuK5T5npRMiRIKtUQWROH7eOu9Cw8DvKJGtBa/Sd
 sKNyCYODzdg/93gTaUh0nguUCZm9Zeqww/jQ/NwJFYggsMSwMh/Vf9PM02hMMthhS3oS
 1+QpdrGOh25lmsyLBfCVfmK/GQAOrAQFIT3eTwBeaFSR0XMPjmYPfBHib8foo+jLQkbl
 scxytQCTrEYbikz3QPOqxuKzV9Eu21ZN24i/j3SWfGrgu98PayNyF/6WtyntDJL4TySi
 Wpuw==
X-Gm-Message-State: APjAAAXRtKtPwURwc+N7nh9XIRk+VCNdc82YLXrlnAvtfnQFJvI2bC+w
 BApXnnpvzAOV+wgHvYdiPLuP29ht
X-Google-Smtp-Source: APXvYqxoZ6Q5ueHhMqOlzbY/ph73DmAin1g8IVjS71z+LVBqe5KujD7yMUPriSknsrJjbmcoeeQNPQ==
X-Received: by 2002:a25:e70a:: with SMTP id e10mr4577662ybh.105.1572533040691; 
 Thu, 31 Oct 2019 07:44:00 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m205sm1679516ywd.82.2019.10.31.07.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 07:44:00 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable VCN DPG on Raven and Raven2
Date: Thu, 31 Oct 2019 10:43:41 -0400
Message-Id: <20191031144341.752222-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4/7/E6byuuktsBGDhIZq9ku8PeljTeUxI+vqMQaIZe0=;
 b=bOxwIzuipUoMb8IRZ6rGWFzNgDJu6bYDUfgaiwgcsA56BA8Rw2y5g/PUU2GKuMp8MR
 Y0wyoytGqm9d7r4SjO8RqW4PWyMRfws99lhfE6fZoWUVbdl7ud1Ngsl+XJx3Ieu+0RBq
 /ldVf++P4BtoRQ8/UtLLQNRruim5nmHexwZTNJAu+WvBkEg8CJy5XREcY5VujVS3WcTt
 kPvWv4CJRCl7xfS0XXbW8jb9TAD3Z+6x6uhghq5dTShtVbZjPhbZYH3edkZK7dfTlkkX
 gg+/Hoh5fjI+KxBWFwZDZ0W4zDqyoVGJES6v0NApEks3FjGF1P90oyR9QSV/wAnWoGxc
 Updg==
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
Message-ID: <20191031144341.Qa-KQpeh1iaNq0BaBHX8xQbY4eNQBiOCm1pb67ddqO8@z>

SXQncyBzYWZlIHRvIGVuYWJsZSBkeW5hbWljIFZDTiBwb3dlcmdhdGluZyBvbiByYXZlbiBhbmQK
cmF2ZW4yIGZvciBpbmNyZWFzZWQgcG93ZXIgc2F2aW5ncy4KClNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jIHwgOCArKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwppbmRl
eCA3YzdlOWY1NTBjMDIuLmJhNDU4OGUwYzA4MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2Mx
NS5jCkBAIC0xMTA1LDcgKzExMDUsOSBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9lYXJseV9p
bml0KHZvaWQgKmhhbmRsZSkKIAkJCQlBTURfQ0dfU1VQUE9SVF9TRE1BX0xTIHwKIAkJCQlBTURf
Q0dfU1VQUE9SVF9WQ05fTUdDRzsKIAotCQkJYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdfU1VQUE9S
VF9TRE1BIHwgQU1EX1BHX1NVUFBPUlRfVkNOOworCQkJYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdf
U1VQUE9SVF9TRE1BIHwKKwkJCQlBTURfUEdfU1VQUE9SVF9WQ04gfAorCQkJCUFNRF9QR19TVVBQ
T1JUX1ZDTl9EUEc7CiAJCX0gZWxzZSBpZiAoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4MTVkOCkg
ewogCQkJYWRldi0+Y2dfZmxhZ3MgPSBBTURfQ0dfU1VQUE9SVF9HRlhfTUdDRyB8CiAJCQkJQU1E
X0NHX1NVUFBPUlRfR0ZYX01HTFMgfApAQCAtMTE0OCw3ICsxMTUwLDkgQEAgc3RhdGljIGludCBz
b2MxNV9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiAJCQkJQU1EX0NHX1NVUFBPUlRf
U0RNQV9MUyB8CiAJCQkJQU1EX0NHX1NVUFBPUlRfVkNOX01HQ0c7CiAKLQkJCWFkZXYtPnBnX2Zs
YWdzID0gQU1EX1BHX1NVUFBPUlRfU0RNQSB8IEFNRF9QR19TVVBQT1JUX1ZDTjsKKwkJCWFkZXYt
PnBnX2ZsYWdzID0gQU1EX1BHX1NVUFBPUlRfU0RNQSB8CisJCQkJQU1EX1BHX1NVUFBPUlRfVkNO
IHwKKwkJCQlBTURfUEdfU1VQUE9SVF9WQ05fRFBHOwogCQl9CiAJCWJyZWFrOwogCWNhc2UgQ0hJ
UF9BUkNUVVJVUzoKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
