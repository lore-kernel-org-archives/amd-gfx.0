Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8B5CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98D110FD8A;
	Wed, 14 Oct 2026 12:47:51 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0829410E988
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 18:53:18 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso1830925e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791917597; x=1792522397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=elLXg3w+uftutke8mR3uoqDn0vGvbA3T2VIjPuIvzN0=;
 b=dX/i99faNktGzaTla4Sa+jy/Dsk0sFkjPvCcieGmIl24Aol8HCYuwnoSiXE1O0T6nY
 kRQxdT5mpZwy1gXjuh4MAW8hhzClbrPt1hmcPsg8z0Ew17mGC6cNpKOMjHD5qoNxSY6d
 9zbQ3Uug1E+O70jHv3d0yyAxDWRB8TtyvjlQfaqNS8qv2+UgXqbSyQv8u6ZsjHERxLKx
 KIKB/gzTQ2EXNvteUU7o8Qh+kqpANB7CypRXQoO5T78I45jhAAbv4ZlzzhKSGO8a5UIX
 MMwwZRzlzrOluodh9+gpzBSTf8fVjVEiWOSjrhmpdcY6+/YrNqmJjYCf0GiZ+SKFvwii
 rS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917597; x=1792522397;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=elLXg3w+uftutke8mR3uoqDn0vGvbA3T2VIjPuIvzN0=;
 b=kxh4AGrBnAXCpFJu+Z8zFdd9JFyM9h4NTa7NRnwAOCY+NEJNXddHawpsZdC3jznELj
 4cqG61ePfxKncteVxmlrsjltwe1zMcSMdD1TVJarJtA4e2qEpRiWEud0BfZFPJjCB6Ll
 NKjDowHRCdQJU9NsV8Y8JT9pk8GArBW9XR6XoyBi4XZ3lLUsd1N5jWJXU8ZCMPxvWHnu
 IloVdbt2d4CFpx+xsx79DyjSSEJgj5SNUvw9M0UsxplZTtxNAQoQa7+xEEkhqbnHi9GO
 7WWAA7PnkAv8Q3ACIseU6Z4Dn6OaOWsNgUi4P4w/B7VLenOW0xFgg+nSGvbEIx7iZLx/
 2tew==
X-Gm-Message-State: AFq9FYJaZm3/5R6g1+0ROuWh6hiwU8xouLe4Cat+sYosrgv21bZFkeW2
 JrU28SIwOjDlYEaQBu4bsI4Z9uhH8h1xE475eQzz0Lg6soCJzjXcrH8fcctdMg==
X-Gm-Gg: AYBFou2M2gCmq9tcfmcneCeU+x4oRfZdh3zExqJbBETACb7qUhFSx8ZyMzkMkZHOzZa
 mdagbs+lVnJk2aDA7A+Niwwykm6MePhPsOiB250FeCg19ePF1zcokyFBEjWSI1vpy6ktpKyl6rG
 8yiNRCunARnQelApCZ2gNEudy4phhFuSMluVrpuL3VPAngQ64+8XpYK/ZkhVujOAKjMtBzN5hYr
 XOe05NLBe98aKtu2yuQqSYPBZuOULwO7Vwo9SYbFrS2/ZLWK4xZyFPAsGCMJfPy49ZvL9Fvq5ED
 t2AIy2lsCMfD0Hbb1/ouvy8Hh2zlIvO8OLz21DFyT8UkD8ojodC90oaWsTTXJCk60YTQvg0FECL
 U1s8R3/Ki0EpwEOXNbH/nWtKyRPWmyeJK4kqQYTCfd9xlWMk5GBeuFdCO9fpgVLEutLRPMUq5NP
 YXoslzrJNXijyS3peMrfpo1xz+lrAGo6r4lHolTLf9m8GpwRC8m8NftaifvdSS/NEtdootH5zNy
 hPFRcNx85K1F5mWJfyu65Y93cTAKVwoIjj+14n47RQ6fmFXeByX+S7xTq7PmmCMAzo4IEg7HEhg
 Me3btMM1b3M3OyyE+AWfGFWhp+7mtleSTX+OMx4/nQ3+wZpj1jMv2/Gqi/9dM8c+FGmizQcJVD+
 NtddBJGHQfZxvjhEShif5Tf0muWuq28T6BnujcEm/EHeZryFEQCd05hqEO4c8+NM8FX/4DOiKrh
 ocR6pw1TboTtMO392RSBZfoTdO
X-Received: by 2002:a05:600c:3e07:b0:4a1:8627:aec7 with SMTP id
 5b1f17b1804b1-4a18e4987abmr228277075e9.5.1791917597241; 
 Tue, 13 Oct 2026 11:53:17 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18d12fe05sm12340585e9.4.2026.10.13.11.53.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 11:53:16 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v6 1/3] drm/amdkfd: tear down KFD processes before early
 fini_sw on disconnect
Date: Tue, 13 Oct 2026 20:53:11 +0200
Message-ID: <20261013185313.33496-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
References: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

On surprise removal, amdgpu_device_fini_hw() calls
amdgpu_amdkfd_device_fini_sw() when pci_dev_is_disconnected() is true.
fini_sw frees kfd.dev, but KFD processes may still be alive and hold
references to it: kfd_process_destroy() dereferences kfd.dev via
kfd_processes_remove(), and svm_range_list_fini() /
kfd_process_free_outstanding_kfd_bos() touch per-device SVM state.

The kfd_processes_count wait only happens later in
kgd2kfd_teardown_processes(), called from the top-half remove path
well after fini_sw. In the observed failure the killed KFD process
(SIGBUS on unplug) stuck in D state on its exit path, so
kfd_processes_count never drained and the PCIe removal thread wedged
permanently in cond_resched(), producing soft-lockup and hung-task
splats.

Tear KFD processes down before freeing kfd.dev on the disconnect
path, and guard kgd2kfd_teardown_processes() against kfd.dev already
being gone when it runs a second time.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v6: none
Changes in v5: none
Changes in v4: none
Changes in v3:
- added NULL guard for the second teardown_processes call once
  kfd.dev is already freed (Christian König)
- dropped the bounded-wait mechanism from v1; the drain now happens
  before fini_sw instead (Christian König)
Changes in v2: none
---
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
