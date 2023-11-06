Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8675C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 07:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CB910E028;
	Mon,  6 Nov 2023 07:20:03 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2435D10E028
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 07:20:01 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so38004995ad.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 05 Nov 2023 23:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699255200; x=1699860000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u9fAZAztE0fZnRppsuZW5whBvfbPMksUXtw2NeivLjo=;
 b=OeNo2DMGQXv6BXntWZ53k5+qO3dDsW+Ucl+WRQBmEj1Ina8zlRnQ0ZLC0tK7Z+ytof
 QliitBQhAng2/hbNPgreed3lvy4lGaDIM674Jp6uEibW/nMqyyGvHfbFfBb3ifIIryVB
 aK3IAaWXHzjqwsNFpDPoEqfw4Ajuk2DsGmjZJd7kGc9bx1gKfBz1usAi9EyAEofHZr6+
 x9R2sLBEn2VghJjJCy+2prWqnPwGwbb/t+L4FKVz8YNebyPlTUBlFNdmITXUES/DUDtL
 /wUWnt1tmknRLZWyzUpmdqT+XR5LnU4WxylLnsgvBiW6gIjxqGyCxI4HJv+tFANcAfWi
 4m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699255200; x=1699860000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9fAZAztE0fZnRppsuZW5whBvfbPMksUXtw2NeivLjo=;
 b=fS20mx8u99sxiXYmy3hEJ15hFVRKBlUR9JLDOZi70xKAaweztzIXt0V+hhI2LfxCp3
 UZsH9mhi7ER4pvvzYP8A8+IY3HHw6mbaxqaRa+pIwYsA9PZyw9qNOP/VFRhS0i8/enPk
 8dub+15lLPySzhISyRaw5MhThaX3LhJhOwmZecD7Shdey6Hvcp1Kyf8CfKmlFqtlN8RC
 nA8XBFOlmuso8ZveWcEeMPyCXpHzKAGPPvkaIjuUxeSPMx3k6O1K0YZjWVbRjVScG+67
 IqloeaSc4uZOZwM7GcohfnHUO32mOH1tsI7cIODGFePGZgJ9a1BBxFnn6D2HgjFnNuts
 Gasg==
X-Gm-Message-State: AOJu0YwDtjrNehX/xpUL66TmDBb5NLprnpMUyOUsSvKUG3jqQ+rpqULe
 iqM0rrFu8F77RuQf2BXgrlTZMcf6ym0=
X-Google-Smtp-Source: AGHT+IEc+ecCvffm4mdNPAT+KiQFTOJepUh3OxRYFp6o3oo+9BPdzNqMGuhV51+ntARJruE9WDrgtQ==
X-Received: by 2002:a17:903:c4:b0:1cc:3b86:cfc5 with SMTP id
 x4-20020a17090300c400b001cc3b86cfc5mr20634177plc.4.1699255199932; 
 Sun, 05 Nov 2023 23:19:59 -0800 (PST)
Received: from localhost.localdomain ([2601:644:400:c541:161b:8203:d9e6:f4dc])
 by smtp.gmail.com with ESMTPSA id
 jc10-20020a17090325ca00b001cc3a6813f8sm5197062plb.154.2023.11.05.23.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:19:59 -0800 (PST)
From: Lawrence Yiu <lawyiu.dev@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH] drm/amdkfd: Skip locking KFD when unbinding GPU
Date: Sun,  5 Nov 2023 23:14:05 -0800
Message-Id: <20231106071405.121981-1-lawyiu.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, christian.koenig@amd.com,
 Lawrence Yiu <lawyiu.dev@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After unbinding a GPU, KFD becomes locked and unusable, resulting in
applications not being able to use ROCm for compute anymore and rocminfo
outputting the following error message:

ROCk module is loaded
Unable to open /dev/kfd read-write: Invalid argument

KFD remains locked even after rebinding the same GPU and a system reboot
is required to unlock it. Fix this by not locking KFD during the GPU
unbind process.

Closes: https://github.com/RadeonOpenCompute/ROCm/issues/629
Signed-off-by: Lawrence Yiu <lawyiu.dev@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0a9cf9dfc224..c9436039e619 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -949,8 +949,8 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	if (!kfd->init_complete)
 		return;
 
-	/* for runtime suspend, skip locking kfd */
-	if (!run_pm) {
+	/* for runtime suspend or GPU unbind, skip locking kfd */
+	if (!run_pm && !drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
 		mutex_lock(&kfd_processes_mutex);
 		count = ++kfd_locked;
 		mutex_unlock(&kfd_processes_mutex);
-- 
2.34.1

