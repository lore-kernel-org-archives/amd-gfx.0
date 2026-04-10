Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765B6E99049
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 07:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D68910E122;
	Fri, 10 Apr 2026 07:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jcjpvTIA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6CF10E122
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 07:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJsb81+1QaoRdnh989835Pfx4Ma2lfhO+n+m/AO6NWw8W3W7tfLLlC19fpICNNu5V6CsYqHhg3cikPxDggsM3535or7Q929azx194Pncv9jRH3kqcNk2Wzuu/qGsTwsUeyaI3Rc8/Co/sKxTuX18TJQl2FnsRY4lpz7g7zMRrsFu5/D9t68LwCsJTISlWa9EaymRR9rw6UfBqFOnqibluXcNVwfgIh5htnIk0YpwuPV7O2U8Y20Bt09nYAZhExfRbl5tEOD8AsJZ4n8g4RM01GmMT6wTSsTUCXws78LdPGtQ9yZzja/u6u9NUm/Q8icCEDwZPwumw7XbaQMRaSZRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b3wukdsCB+XiX3GG8DtjZRVWS1QQovntPF0Rzliuxg=;
 b=j/r5n4lyMgJZGlzWYGurzeINsC3auB3feNc9ZAcCp2wMYnj4qymblSjxjGkpbiGcrD/SROFTDcuT0iwE2dgygoIjy4Gg64MVhs9pRyUOhd+sKyE9Z6mPuKbmqiHIamQdOQ2Jnyub1Wov8ldoNShuyHS31AKmdp4WVfHOgJ/bKUpTnVOyaslb5a/C1XWXagLnNJ3Lb//UfiksY6tXQr8ANENJIXQ55l2gC+Rs2u5TOOQmt1fezci0fCzlguVw4FDOzXHQVLRKqLP+1v54aanqpCwRUhmh6Vmwmyy2lbB70Sz2tUMPRJ6Z1iEUdbruLOvD/v9T6An82KN8gdpY3x7vEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b3wukdsCB+XiX3GG8DtjZRVWS1QQovntPF0Rzliuxg=;
 b=jcjpvTIAiZA/krQy8h3gRmVl1xVHPmDU4HYdu6cvIlgkKAVIaB4Oc2mEHuW29fm+lPpUcAeFVRBIhdMScdKqBEPvZSIf3kQn5f3Hj/STB3AAulsJ5X/m5IFTc4KzEJ2Z2aCSLsmKqvXaTXmqKB/wK8EHIG7Z87T8BmyJqy8/BSE=
Received: from SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42) by
 MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.34; Fri, 10 Apr 2026 07:30:27 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::38) by SN6PR01CA0029.outlook.office365.com
 (2603:10b6:805:b6::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 07:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 07:30:26 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 02:30:24 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: correct single device PCIe reset flow for DPC
Date: Fri, 10 Apr 2026 15:30:13 +0800
Message-ID: <20260410073013.2225397-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 0267d3cb-f9ba-4f3b-40db-08de96d30924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: jkbMhTebUTFVekGk3yyPsPbqJ8Kug3Vhx5TY0o0v6Az9h3HNaNMQsba8HUG8eb4/v48hGavBk6gPerh2IeuixMdkGjzXFN4qWqgVh48sJvuJKDpAIdXWwJsgEMYR2BE08inkWC2ZMNITWwehxLZjh3C8qLmiKn8DwHUoZzftFwj/ama7oPqsIix/w9iQL5uNDnM11LHGMCZMFVTQIXFTZmwLbBlnHdjNpgyk3PJl9YQ2I8P7+r8SnSUGZ9z+cVhCNUXryB5MQ8IqVcpXtpLo9J7F1Pmg2E5JJsaQJymVkHiTfDT8JPI0lxpfk9ZbEKjAb+tF1GSijl3cIORSSFsTwqF6d/hnOcKEOCtuqWc8boGnxFBZBZWWuE+LAgKRl06wqkAZRUrC0Mz/snGuybG8zzqlF+ihsDaJDfOTvSGKPV2zwEQA2f6rCKz6AWUm8/k0cjPRGFtQbn+yVo082CYFYNBKziDorNgMzFFraDq5fykJLd8Ykot8GfkzopxeEJOqYWlRWaMSsnTlsFVhpDxUolaBhUbjU3SXPIEpWzaaZtF4HGXobVXQTB4WCsIm0pdyIgQi1iI6jt1EkD+CyXOpJ3++nqKqmXEGI/dESiGUza6lzbO4JuIa+M2LOSOvoN/qa35Sl1HTAVaQsMcHbJPuHJg0suDT324+OZkXdM+UyPdFiU5ckCaNVEUG4Fp9lDKDreWBxX0dv0SJnq8sLUc+bHBISiZA8IDnF6ZD3tl2UxL/6O5q1SV0DyOBYtzYxAfDqMGABzvLXDLhfYQhGKtNvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ilE3FjUjX4DdZtNaKoUaASAFymZl81pMGhCF9lq1Jp0dxJ0na9VrlkhzN45IQS3N2QZj6JjkXHq9VmmlLq1/6iiPFI/vsjUMJtZ8dPqdHY8MR65rHUse1qa0SsXgeQ7k7Y2v6o/az2gxJO5p6jZDKrBwbFqFHia64l7r8MbsaseFXkhLipCyXH/jn0DXJqdKdSMxcFVQN8bkVbJhj6Mh/H1phvv97B93+iTeFCrt1x8003lrbfGjS7ozRc5u0icEebsWrgk5YVbUCOgUQIBF497WgSTzBa7CmFy2cV9y73jheoraN+hHyoFVVNpqcs/lQUobLVRhn8a+CIyi2QBoXvMpKJUGtOvN+dR7U9uxnV0GMaXA/WCGul2d+52Sl3ZiX9p6+Ksd8qZy7Kbq6Y5cKoFusVKOV3V6jj2Yhs3reNhP8O8D9NWHufok5RaX/X6z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 07:30:26.8172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0267d3cb-f9ba-4f3b-40db-08de96d30924
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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

For triggering the dpc event with a single device, we still need
to set the in_link_reset flag and the dpc status.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index deb41c095b59..df1f6b070ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5518,8 +5518,6 @@ static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 			list_add_tail(&tmp_adev->reset_list, device_list);
 			if (adev->shutdown)
 				tmp_adev->shutdown = true;
-			if (amdgpu_reset_in_dpc(adev))
-				tmp_adev->pcie_reset_ctx.in_link_reset = true;
 		}
 		if (!list_is_first(&adev->reset_list, device_list))
 			list_rotate_to_front(&adev->reset_list, device_list);
@@ -6291,6 +6289,9 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 			amdgpu_reset_set_dpc_status(adev, true);
 
 			mutex_lock(&hive->hive_lock);
+		} else {
+			if (amdgpu_device_bus_status_check(adev))
+				amdgpu_reset_set_dpc_status(adev, true);
 		}
 		memset(&reset_context, 0, sizeof(reset_context));
 		INIT_LIST_HEAD(&device_list);
@@ -6411,6 +6412,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
 			tmp_adev->pcie_reset_ctx.in_link_reset = true;
 	} else {
+		adev->pcie_reset_ctx.in_link_reset = true;
 		set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
 	}
 
@@ -6467,9 +6469,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 			tmp_adev->pcie_reset_ctx.in_link_reset = false;
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 		}
-	} else
+	} else {
+		adev->pcie_reset_ctx.in_link_reset = false;
 		list_add_tail(&adev->reset_list, &device_list);
-
+	}
 	amdgpu_device_sched_resume(&device_list, NULL, NULL);
 	amdgpu_device_gpu_resume(adev, &device_list, false);
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 03d95dca93d7..debb82a2e031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -34,6 +34,7 @@
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_vcn.h"
+#include "amdgpu_reset.h"
 #include "soc15d.h"
 
 /* Firmware Names */
@@ -361,7 +362,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i)
 
 	/* err_event_athub and dpc recovery will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
-	if (in_ras_intr || adev->pcie_reset_ctx.in_link_reset)
+	if (in_ras_intr || amdgpu_reset_in_dpc(adev))
 		return 0;
 
 	return amdgpu_vcn_save_vcpu_bo_inst(adev, i);
-- 
2.34.1

