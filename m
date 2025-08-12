Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209A4C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 07:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E3C10E5B6;
	Tue, 12 Aug 2025 07:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Hxp4Qaj4";
	dkim-atps=neutral
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com
 [209.85.210.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C1910E599
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 06:37:17 +0000 (UTC)
Received: by mail-pf1-f225.google.com with SMTP id
 d2e1a72fcca58-76bde897110so4164305b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 23:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754980637; x=1755585437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vnf9J8D/lbhMrAAVySeXBqauE+p5C7GABrpw1C+CN+M=;
 b=nT0ct40LXkFYTvRPIg52KNASYYcvv8Kigr0oEyVa7Bgb7kMa+0+v3SnZzoEyD9qMIB
 ztvrbJWC6rk0ZsGrvTcpPHjDp6PJGEWq9DNT7b2O3sEO4wwBZlhMc+ztOQMrSnPNh0H9
 7P69uzmqqULpmpXAfiDzL66LNY9gdVGB31v5mdyGX9Jv2hIIRkgU7i8HCClbYTHR90Mx
 pEZUosg9JH6ieQiZnSXlZD7tpuoH90kvAuMGRLQVzQXx6IEgQ5iS3AuP/cLIrH2LH28W
 Kk1wJZ8nek/yBhnuas4RmeZDqnh09ex1y9JHtTbTh6CmYn3CaTz4UshRBiIQQlj6WMgq
 Qsog==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7ndKtK16S60CxqGxFWRLwxe9mNRAM1kHBlaH0q/+KkdMeO+Rko6SGJjoICVM7bXs4HViUuHY3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFbG6Y8hcmiI9drTQfrnJIfBfoY5LlQ7sDToWvKvfPakBwVaX3
 g59sig1pkXsPC6C4aAhI6MYKC50WVKIOqlsQeC5ktmqNPTOb+JCrc2fkKufPgJtZO7WlauOXn69
 /1ouE0iHMXhenWXN/qrn0RVJ82FScNTjOmRUhnNq8LeaQ2mr9QaeYmgbs2NlF34TwNOrEZrPSNF
 NrgoPnXSsSPRiiiDqeeX6Hr7qLN1HjEuc3RfIHa0KNGWr6PIuS/R5l7gXCQeB1tO9hLeTudTDS9
 16pihNLGOA0FQgsVtufUWbldtg=
X-Gm-Gg: ASbGnctx17gZ6jtHOPNJKegx3VqTNa4fkTTqG2W2W73queM3Ha65tGH/TlpHYaRAcPt
 GprePQuH1hkpl3scJvYmHVIqNTrF/J693oIllsddN12XiQw3v5lslqhThwoLXNeFjgW9JoNgnbV
 T6TreOOg4+VfyzxRxYepus8mUhPzqFIk4oqxLiugjscg/K0P5unz9pr004aq7KgSsFQdptrf7vI
 LYkTKuWl+h5DXSzGM3Kidvgf1DuVRPMsptpbRP272mxP4Evjfy8M7STPegKqMFpxIQZhNTkN6pU
 ds3xMTD/HfFpZjvvuc2LWMTKf//nVaHx891BSZ6dCOC2oTcQMrlCaIjgn8VN0/b0/jZNFeU/rUf
 m7BfLrhDl8Pq+d/NrjF0Oxqct5WFy1VETRucg5dle+LXqvCtiwSqhp5L8BC6vT4RANA9dLjqV+9
 5VcQz6Aw==
X-Google-Smtp-Source: AGHT+IGEWAs5ptjDblk8VMf98a11HpZVg3+KtHy4qcJXbgYdYSkOcQm/UFSkMEJkd7s0KndYUK+QuiQy/Uc1
X-Received: by 2002:a05:6a21:6d94:b0:240:1c36:79a2 with SMTP id
 adf61e73a8af0-240550452f9mr23189443637.10.1754980636629; 
 Mon, 11 Aug 2025 23:37:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-76bccf30247sm2377873b3a.12.2025.08.11.23.37.16
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:37:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b06a73b55aso127382801cf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1754980635; x=1755585435;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vnf9J8D/lbhMrAAVySeXBqauE+p5C7GABrpw1C+CN+M=;
 b=Hxp4Qaj4R1FNh05nGbzX1e4LetY451hy1Kb1bRwOUErkitrheU09tsTsg/gcN6c6VT
 0IFa4wCOdPKuhmbeGbkwI4eFw0WzuhEMbd5uJBCTUfIsQ4Gsy7sTv6USv0IRp7SSvT38
 B3obv8SA81RwBlEDU65IR35KyWTMUXicOJ7jA=
X-Forwarded-Encrypted: i=1;
 AJvYcCWBtOBmvx/68Y8+4GWvPyX7EMGjUtvuGpIK7bFnZBHjLhEh1YfX4mC/A7Ornw5j3+yyANhEiXEO@lists.freedesktop.org
X-Received: by 2002:a05:622a:3c7:b0:4b0:641a:ddde with SMTP id
 d75a77b69052e-4b0aed86506mr214213991cf.59.1754980635084; 
 Mon, 11 Aug 2025 23:37:15 -0700 (PDT)
X-Received: by 2002:a05:622a:3c7:b0:4b0:641a:ddde with SMTP id
 d75a77b69052e-4b0aed86506mr214213721cf.59.1754980634597; 
 Mon, 11 Aug 2025 23:37:14 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b095e6c7d4sm85319621cf.54.2025.08.11.23.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 23:37:14 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 tapas.kundu@broadcom.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 lijo.lazar@amd.com, mario.limonciello@amd.com, sunil.khatri@amd.com,
 srinivasan.shanmugam@amd.com, siqueira@igalia.com, cesun102@amd.com,
 linux@treblig.org, zhangzekun11@huawei.com, andrey.grodzovsky@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Guchun Chen <guchun.chen@amd.com>, Sasha Levin <sashal@kernel.org>,
 Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] drm/amdgpu: handle the case of pci_channel_io_frozen
 only in amdgpu_pci_resume
Date: Mon, 11 Aug 2025 23:23:49 -0700
Message-Id: <20250812062349.149549-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 12 Aug 2025 07:33:59 +0000
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

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit 248b061689a40f4fed05252ee2c89f87cf26d7d8 ]

In current code, when a PCI error state pci_channel_io_normal is detectd,
it will report PCI_ERS_RESULT_CAN_RECOVER status to PCI driver, and PCI
driver will continue the execution of PCI resume callback report_resume by
pci_walk_bridge, and the callback will go into amdgpu_pci_resume
finally, where write lock is releasd unconditionally without acquiring
such lock first. In this case, a deadlock will happen when other threads
start to acquire the read lock.

To fix this, add a member in amdgpu_device strucutre to cache
pci_channel_state, and only continue the execution in amdgpu_pci_resume
when it's pci_channel_io_frozen.

Fixes: c9a6b82f45e2 ("drm/amdgpu: Implement DPC recovery")
Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ff5555353eb4..683bbefc39c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -997,6 +997,7 @@ struct amdgpu_device {
 
 	bool                            in_pci_err_recovery;
 	struct pci_saved_state          *pci_state;
+	pci_channel_state_t		pci_channel_state;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 40d2f0ed1c75..8efd3ee2621f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4944,6 +4944,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	adev->pci_channel_state = state;
+
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
@@ -5079,6 +5081,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
 	DRM_INFO("PCI error: resume callback!!\n");
 
+	/* Only continue execution for the case of pci_channel_io_frozen */
+	if (adev->pci_channel_state != pci_channel_io_frozen)
+		return;
+
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-- 
2.40.4

