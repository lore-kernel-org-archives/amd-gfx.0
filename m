Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98140CA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 18:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D427310E02B;
	Wed,  7 Oct 2026 18:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KkwiTTJO";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391BC10E02B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 18:09:14 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso40538455e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791396552; x=1792001352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+j2FYA42KZ8gXbeBKkIoF/p8AOJkD/LCcWergyht8w4=;
 b=KkwiTTJOkaAP/ZD4dyOQZMLFS0uDSX54xLbcvWF/EPVDSE8E6nwBmk9rXz3TvvpGLO
 8Kc2DICHvOBCiLxnxib+/nYV4ttsXRPXD57FBnv7tj9WnVoSenRWy8hXi567b42mNcPQ
 v3eZ1R94bPE+N6hNRNauEZuR+TTJlpvCxaOyiqNnCejDRqgp2/19/2bogMaVa4nO8rMF
 pFfwAS8EQsYeUlBKFU5O7YJwQ4kfahN4C55cPjofb4F8pCYuICvhs5Wz7bfAFP3oG/6+
 k5f7bjbvToON//mWmuNxQwek3MHOVXhzGIyTzqKEySG4sX8+o2sBBiw+xtO/OJEFo3Cd
 oTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396552; x=1792001352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+j2FYA42KZ8gXbeBKkIoF/p8AOJkD/LCcWergyht8w4=;
 b=N0tfHdcQocnuNxHMRv2tezueQavU+TzWhl2s/snh8a4PrHIAYj8rLe8FrYuQOP726J
 FuEH3st/gSvyVeSvx53n53eJ3qYkjHPt9detWkaXeHDtHgcvc483hTt+eOKmU+/XnpNg
 Dr3yCnhYovG7Ldab3vCg+UxjzvLS/oXWCYuMhH0BojxbindqjU6aq5Gp89nPGDA2R4m8
 l3sPX3c4H366fHOXT0BWIoE96mqYWyfRKmNyVVS4nwx6cxkA6OcYesJ3Nv7kNMiZKjRY
 eWPs6qpgbX0O5efBxkLbeVnbjyAewL0gJBSyQ5IeQ0Bs8kVY5P+01hBuSr5npSescO1B
 oMhg==
X-Gm-Message-State: AFuF++lOFrEQJm1BXbt1nE7dcPqeiRPpTASZkRQJrcWh0gZWo3vma6yv
 OVsvr6rsEGdJ48rZwdNlkbWqO0tNoQwJsRbuh43QSqh7MDi2ShiRYi8CVsvFRsxY
X-Gm-Gg: AYBFou2cLEVTk8mLbIJXPUJk9Ao8mlOkoIXAbhzE83tPda4ryfVZjWrmZ0ahAz5A9Wg
 MWami/tKpCvHeDPDO2Rl6jXfc6/oV6r3AxdHS37T1G1CbFvs6erxYbXNK0qFzoS8GuDoLMtpTkt
 jAP4MoH1wofifb5/lFPCLCqKszjQ+vwaqN6xPLNzAqYi/FkiTmst5dlwegq2zr8aOHOYHR/jGBI
 /10PEDEB2zCWmj0Yr12RQg3RLZmTlVoW7fLcCfWiH8U5CEPzv1UJUclktB9mq8AtrJyqVPkVvMB
 LJhQaihLC2jNkS/bHEaH9YJ4VucD7cEY4ZTbzp1hzCPonl6qLJEEy7HE8A1D3QmF86MmqXpnbNv
 hyBlo2e8dkIhriYiAH+tnNlWmKEGPXwXhIb3JFeDVAyARpSdtsWKs68c1MxD9n+mBjqKPdnJNgp
 5H4DIf3Nl2xDvk3zSEDIi23fZZZX4FqrlOvUmX1oLQEUHbfMRn1tBz74YDMzu4nAiIoa9IM9yNn
 U1YQ75A1z5GtzbxDMOzOotCWvUqtAiyF3TFBKFAMfLIIKOoHKl//3fr3cQe1hWPUNeXt46qn5Po
 LxNYbhL4P6VJS38iJFYUNqK61qnXe58Wtel+cxx+JjpvqhzSR1lkg5fKAKmOnfQwmwYaxNA3lPL
 U/3tLn4QvEGnyhNZCf/e03yrAcbyenwPQtvF95XhNIuth1YE1VpplEmLc1PSN1ocUIuvrdzibVg
 kkikJSbGqkMkoEpGc=
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-4a180422c02mr53420365e9.10.1791396552352; 
 Wed, 07 Oct 2026 11:09:12 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413e:676b:9d85:c07d:dc5e:c7c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm59416855e9.5.2026.10.07.11.09.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 11:09:12 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v4 1/3] drm/amdkfd: teardown processes before freeing kfd.dev
 on surprise removal
Date: Wed,  7 Oct 2026 20:09:07 +0200
Message-ID: <20261007180909.34013-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
References: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On surprise removal the PCI core runs amdgpu_device_fini_hw(), which
calls amdgpu_amdkfd_device_fini_sw() as soon as pci_dev_is_disconnected()
is set. That frees kfd.dev - including the kfd_processes_count it
embeds - before amdgpu_amdkfd_teardown_processes() in
amdgpu_device_ip_fini_early() ever runs. The unconditional
adev->kfd.dev->kfd_processes_count dereference in the wait loop then
crashes the pciehp removal thread (observed as a +0x1b4 NULL deref on
MI50 Thunderbolt unplug).

Move the process teardown ahead of the early fini_sw() on the
disconnected path so that terminate events are sent and the drain wait
runs while kfd.dev is still valid. Keep a NULL guard in
kgd2kfd_teardown_processes() for the second invocation from
ip_fini_early, where kfd.dev is already NULL.

The wait itself stays unbounded: returning while processes still
reference kfd.dev would just trade the NULL deref for a deferred
use-after-free in kfd_process_remove_pdd() when it decrements
kfd_processes_count on freed memory.

Fixes: 28695ca09d32 ("drm/amd: Clean up kfd node on surprise disconnect")
Fixes: d12d05c4bc4c ("drm/amdkfd: Check if there are kfd porcesses using adev by kfd_processes_count")
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v4: unchanged.

Changes in v3:
- drop the 30s bound; the drain wait is unbounded again (CK)
- run teardown before the early fini_sw() on the disconnected path so
  the wait actually observes kfd_processes_count while kfd.dev is
  still valid; NULL guard kept for the second invocation from
  ip_fini_early
- v1 took a bounded-wait approach; v2 of this patch was never posted
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e78..bd9d73a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4315,8 +4315,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (pci_dev_is_disconnected(adev->pdev))
+	if (pci_dev_is_disconnected(adev->pdev)) {
+		/* Drain KFD processes while kfd.dev is still valid */
+		amdgpu_amdkfd_teardown_processes(adev);
 		amdgpu_amdkfd_device_fini_sw(adev);
+	}
 
 	amdgpu_coredump_fini(adev);
 	amdgpu_device_ip_fini_early(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 586e640..43029b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1801,7 +1801,14 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 
 	mutex_unlock(&kfd_processes_mutex);
 
-	/* wait all kfd processes use adev terminate */
+	/* kfd.dev may already be freed on surprise removal */
+	if (!adev->kfd.dev)
+		return;
+
+	/*
+	 * Wait for all KFD processes using adev to terminate. Must be
+	 * unbounded: device state is freed once they are gone.
+	 */
 	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
 		cond_resched();
 }
-- 
2.47.3

