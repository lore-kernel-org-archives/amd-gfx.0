Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2257FCA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 17:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85F710FAC5;
	Thu,  8 Oct 2026 17:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ptThtlCi";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D977110FAA1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 17:33:54 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so30321265e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791480833; x=1792085633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JHyXEA81uIcFaEXFeQajZTPWN3ep6NByIM41lzeyh3Y=;
 b=ptThtlCiygwJQNW5Jdp7MgeKlu9E1EzyFTkvpCsZiZ4pg9BCvagbxfXdJzb+ZqlpZw
 qiSgSdEn85cI1B0wFqRGjAKjRzsMVwoKvXl19AjkG4r8eCB0ggmuJc9vYO+g0cWf64pQ
 2PpMkWj3IZSNI7DR8jiaRSuteWZnj8PXExXfLEucEudcpH5wRcEcFHFjQBMaYdfDs8LX
 +YZwmTD8FrbvkLkRCU6Irazq3nlVtZzODW9BW8KS59ytsFaHjZXz16l2wzldQBlmuq5Y
 GZZ7zsCWIrPUr1bbYKk31IxfmDIBd9R0gHERNGpQHYKSwZrkJRudO508B4E5t1Dr6La8
 ViMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480833; x=1792085633;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHyXEA81uIcFaEXFeQajZTPWN3ep6NByIM41lzeyh3Y=;
 b=xR5OUZHB0Wyyk+JAz50QqMankaqmn+O91iuWfzxroH+AL1TjfR2DCYXyfDs4pTjkjy
 y8l9aRfJvxCL40qZCC2zXb74z0al5Vzdfl/6eDjV6ctYo7HUrnwinBan8YTFW0Hnx0xs
 8Qh/mlrcYi4X9Faj+y8twpeBHnZdfTLJlo528ujFCiBSuOcTSLTGoCpglY2F6Y/qgiYM
 90rM50OFxzIvo8EOsL8uRzcOdGBdRt2UBR27N1WFrt+dd/J7pW2D9okUtQo1pRt9n8Pw
 4sFVsENMRxIqJ5sTNfx24o45ie6PIxDfGZnY7gkGVVPvckWf+9A+UlYZoA+AXpqjX3jw
 SMWQ==
X-Gm-Message-State: AFuF++ncopGsMunf+6s+Q+x6U2M0pu5+NkwT0xOr7h0DOuHj/IkFCqCM
 fw8vBZn/T6Bf+CoIR6ELtSBNK0DSPDryTmef/7ZitPzUoXj9b/kOzA0ashxQ/jc15iU=
X-Gm-Gg: AYBFou22amEuoUYeubjZqIqwHdO91TXLQWdbQiXRdvLIxN29C4gWNr8c7TcFZUILzCn
 08c4Zh47CFodz/rkyuV9k5puNEmMj2xGF1sQUmlc1eb6yRVXojmDCuOdkjyn3o1bxJd+lin25U9
 AXpoNmx7rVuZKjM+IMGR1+ZKtdDwBIX1ZH0zHBjlWXSF63vHh3TvX/TRIL8k0y7zgTjUhxoR11R
 vKZ8fEMSN3GQpBNDTeZ5102nf4baZqLJBCjNVOqDdnxhDFYFJZbFwq7nsIq9DK/dAq9eP7AZS30
 mZXM9wpG20iKxG+yl20b2RUtvjvHWS0R85p/I5fo7HShUWwlfOEe0ISmo6vzmCiRBKe10COzQyR
 77B5yYFoNYR7St6PsXbWmcrgKz1kTFIJHmdKNUdSjRCA7pNCY+aOJ+ar0sla0U4zNGFPMfanYzA
 tiEoOelAI56bAAbWqzv7BMQLf53tsZoAIxf9jXheZDOlRrKAnJjHkRK4jwrsiPr13F18QFmWn28
 AC7CVcsCLdYuov6hZgM5qzPlZSl5NnhgepItb4CLEjm/q8/Xn19uk77bkbm4BnNHUzVFn+PAHnq
 hyEU4166NSBnNaci6wmZLH783f/pcWmqbXYjiYGakAhLKWae+UOtVdxIlMvkqbgDoVoF/18N1fq
 XTKalJi3M8yGJ742xqwA02RHdutoVuOgXvzq+3shTZv09Fioz2BT+11bEhIH4Ks0akM2o57N2vL
 3VOf/7Q9gJgIZs7rI=
X-Received: by 2002:a05:600c:821a:b0:4a0:1a7f:2abf with SMTP id
 5b1f17b1804b1-4a1802f6338mr111349435e9.7.1791480833107; 
 Thu, 08 Oct 2026 10:33:53 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:415e:bf71:e574:69b7:f11e:4204])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db652e593sm659451f8f.34.2026.10.08.10.33.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 10:33:52 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Olivier Kaloudoff <kaloudoff@icloud.com>
Subject: [PATCH v5 1/3] drm/amdkfd: tear down KFD processes before early
 fini_sw on disconnect
Date: Thu,  8 Oct 2026 19:33:48 +0200
Message-ID: <20261008173350.40455-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
References: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
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
Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- added NULL guard for the second teardown_processes call once
  kfd.dev is already freed (Christian König)
- dropped the bounded-wait mechanism from v1; the drain now happens
  before fini_sw instead (Christian König)

Changes in v2:
- none
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
