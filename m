Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2781FCCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE38710E291;
	Thu, 15 Oct 2026 19:30:18 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0FCC10E291
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:11 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so45752155e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092610; x=1792697410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=elLXg3w+uftutke8mR3uoqDn0vGvbA3T2VIjPuIvzN0=;
 b=nveQ8a3i8eXeO9cNn+4MLU+ajYvhn0rVqIYacDf7jF7jPMq/cdzG93WetXwn6yurfT
 rg9UtmVFFE2BdJKSbNsNVJx/bE4AQc/pFc4XQ8zWPvmG0Cq7JybcTmrg1Ql/6Imk06Eh
 St+VuKRkFDGq1HY13GnXAWXz8yDCtRR6H9WVcc/c4WnTbT+ipjyvo2D6xC0CMuLpmKul
 1jq0LdVz19yOO7NGerpJL3YCz65XMeLr9ak5swTjQ09WQ6nT/5UKDu404ZozjY/QOM0c
 xiTa4z/hgdT+zjCxnFbHREdXwcUYBibWrwtLxZ8bxvyrGR1SmG8IT907hVe+H09l637s
 fkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092610; x=1792697410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=elLXg3w+uftutke8mR3uoqDn0vGvbA3T2VIjPuIvzN0=;
 b=LVPx4zy86Pv2FDlJ1QvmXXWtd/ea5h5HWlKzm9umGANvb/vnQOmMzxns3qO4HI5BPQ
 ClNeWCXbwbA7RjP26LBjGeUNT0CZGZ2bVJzJFco4o4WXoP83zwn7QvdaM81pt35bQiuj
 vuTaqbPIZZoqQrElvb40KB2sLUzIjUCzddQxeWawsPjKBNX+V0fATN4s1eB6fcuJjtU5
 wffDJB9zLHYMOAq5l//KnOK9q959mbA7AajfHCjb1efpRpJmdIN2+cMIFSTs1pLq9Msv
 U/wT2KxQROFot8kt5MOx5e7DNeCwefhInJsNTruS5eeJpr5YAZD5RcCbyaqTV8okQGbH
 YK9A==
X-Gm-Message-State: AFq9FYJzAkBimfLYvhy+HABMGhnZpDsVXqTkMNZdSK7+OQUZJ+TcSxS9
 nO5Uu3ZgeCUuAwGjtxZq9jlod99bj3ooCh4TY8aUOjaviAcQVdK5bQ8YZ5V+Xg==
X-Gm-Gg: AYBFou0K7NAL6UwGVYLn5nVM/UY8RjnJka+7dAUqKiHUK6fWWBX5Yyv8pMnEdq6Mn7H
 oVeDyWLymkpFRyRvZMfj2pGH7AqZGECvGu23hFvOWVUwZlqv9II+0TCFiBLSKUDsJCeyFqLAK5K
 pjCVT1k3rOm3l1xY8veckRxiiqzJRHVA9ixvqfIOlCR505TJ5rY+vBsuqHHFu/nwezoDyO3+0Pe
 ZVacfDKeGFw1MESQDARYLf+XBd4qnH1a6OOPiefb3srcla1b2exvl4XV0ZePcOLXX/UVtU+7yDM
 q04xjM6RKjUBqybLxYI9SWnep4PF/LNNr2Wsso+p74lozDGiWmlrEKHBlFT7n8RtPllYwTvAzZd
 iC6+LOkL0dXmN8ktC9NnP3EFE2nAqOn4MU7aWEg9vQgwxYGXak9mz6qTZ8cOM9HDz437lWjD6Ma
 ByZiBaWj/Rv/mIwHZeph5fv2cHKyQcRhqDvo2lwBqg1WbTWTCksPGgCBnYLaWf32VjRA+uQj5i6
 0qmr1mx8g+tFQhuhTXyqbqHV2PUFR2YQeWm4JX1mvfxjEkq5B+23no+B9QgVESblqR39pVsFTzT
 +rJIgrNizFtNlcKg8hUccrK7D6xNWirzoYUm8bMkEFzJqDpUjwxm8AAkjfqJQ8fAqn3IN3LESoT
 YYN21RUlmJmSwhJy1DKgUgOWL9tsFwOvZuD4dgrpJudlbnnE73pjf9hqMjf0f0/yVcmOHtCTuyH
 ajqEWJSZYO8gckCUc=
X-Received: by 2002:a05:600c:46cf:b0:4a1:7e1f:21bc with SMTP id
 5b1f17b1804b1-4a18e4d6636mr425344605e9.29.1792092609831; 
 Thu, 15 Oct 2026 12:30:09 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a88bbsm94694375e9.3.2026.10.15.12.30.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:09 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v6 1/3] drm/amdkfd: tear down KFD processes before early
 fini_sw on disconnect
Date: Thu, 15 Oct 2026 21:30:05 +0200
Message-ID: <20261015193007.86066-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015193007.86066-1-olivier.kaloudoff@gmail.com>
References: <20261015193007.86066-1-olivier.kaloudoff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
