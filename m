Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7D606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FDDA50G0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7CF1125F6;
	Fri, 13 Nov 2026 14:42:00 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F329210E7A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKYFrOUvvCY7Hxy2MAojr4Lu1sko6Iz/LP+ebAaB65rcZq7kOY2k/H+b7I0ONmfyNtVyaUOfZBb4MKqSKAj8g2qGJaUUSPu1gMI51D1J4CdUlR2bt9HtNlBySrpYeWYA8iAwu8DSJa8ISzCNzOkmiD1wMzni8+Y5Flru9o19JPFts9Mkt0ztIHf/Ji4ePC2U2qN2kTbs0dBme3TldtmwtU26n++LFwE0e/kLgyY3Hzx2eJ4bjIwiW+Znw2PulGLkSKElqNrVu749qgdEvyHa55m+gSmFcXer8ybc1rQe7FcfVf8C5KVCkalGetIE7NIqoS14ZTwJLnWJHqrid+lI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1qN4KqZtophM3zySUia6fmF14SXm/QNfJHLikiUsI0=;
 b=pEeFY5kGKvSQ9NP0Kv5WrgOb09rR79x/pdBDPbZKKbs3makeND6fkeEmVH8cuzSRksOGD7wUDUvjN9CaV8lsvf+h4lNmdYAsuYzDZlQRY5iCalHerG1tkNcRGqLbpi+aMYAJ/eNtgshBHdqlfXFq5hs4v2ox2Y2lAs9RFq7TSZcw5WsSeDssZqroeh3muBFGc4xv5hPTyQEOtWrKPBhgaRHatiTeGrLTh4ZF38dYssxQCLftwqOOoOqo65YGuzoT9lHZd0/Wr+0cFOkXm6f31CzcO9KqwhNzS5vjbgsKC2PSs7PLo1Ui384qUrL4Y2zcRBC2IGsNqjDfbAsxHYqswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1qN4KqZtophM3zySUia6fmF14SXm/QNfJHLikiUsI0=;
 b=FDDA50G0+ZiCianQlbq6HS6bXKzmtr9fzpM0lirHfYq44u05aM6dYJh+BulawzC49bJGpBHUozgbNk5qvGZ0eZb9fyXM6US/SRmznijoim9Gbbk3SoSobIhzqdMgck84jxgM05KUz6wD0JYEKO6B+tbmz5oOtcOYXdBGJFRUGFI=
Received: from BN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:e6::15)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 14:41:42 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::97) by BN0PR03CA0010.outlook.office365.com
 (2603:10b6:408:e6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 14:41:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:41:40 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:41:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 13 Nov 2026 08:41:33 -0600
Subject: [PATCH 2/3] drm/amdgpu: unwind bo_init on GMC sw_init failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-superm1-amdgpu-memory-leak-v1-2-4a495cfc2c92@amd.com>
References: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
In-Reply-To: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f5e209-eda7-486a-c14b-08df41943ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|18002099003|22082099003|10067099003|56012099006|11063799006|261102123227099003|261021123027099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: bj7ZouNGKK/9Pb+9VpiTvWoRMMHFZckctK/D2mNXsKrfXMLBBu+WmLUeg71nCa8rQ+Xdo1+zltzq/vySo82YprghhxWSz2JFeyt8jIi2U/EgOHeDnLmQgblXY8p1A8MZzQuiUG7WAFZtNxU8mXsQpNv/Mq4hNAuc89Jhn6Uaq1oPojWYMEthWt4OjePaZkVhPH/HncvxkuM7NVItdvbA06V7CR7WvyKtJaJGDyhKd5ki+GsfTSg4mvg+7vil4Rj6cxqUqUI/b7uKS5PdVsUcwdLoWxcVpwb7rJ1wFMDkYykHwjspIpEVOrtirRPCgLa1xRJkCnbs2DBWNIijOV3PYsrtcd/yhv8APFAnkI4SjVmz3lmtXZIDpoJaGQ5GI472zj0kNDOr3UPlgvsTLzLdpnBnkSpPPpJIwrM3fQB1L41VFxea7AIVDL65tmPrJWV6f1EIa52e1HeDXJXEyuWpLuifUb/+6xV5K8Kc2TD/l6gzJW5EpJuoDORrdKuGAYgu06Jl0Ti376bxJUatYoJYBGhMtT+IOFxESuUP2rbXkuk/87BPR5BFJTEh0JYEAPiQbNdvNRWNNL85BYczdHtUnRr8GwWRbVTLF3cDjeLHBlRcj3Y+t6Wttd+vRUnDrTvqTgwwpEmGXS+dNMD8HTgcBr2xSB6ZjGZxiYvDvSAr9Bo+qrjkqH1OZ4N5qNdggqRO8SedBkuq4OlJVYt24PX6wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t1sGW8cI8rAwFVLAi3tdOoPDULh9KYQx3isz13KRXRqo3nNlq/vyQ1Bdyrh8X71fxBDiF97cXjKKdIzRNu6E0jsvmloHIDrI51UfkHlTFGc/6yiQNUuuzmeAmilKSVR65rIth4UNGOVeWsC10hSwuoMtCUBgfkxSxe6llcfqHw3K2ZjQyDNLOaCubeC3rYyfmBWRaPnhyr6XZKdWytbZhil1F00ryuKWpSxSQuMur8V2xeCvc5QEN7QA9CGiQx5Nar+j27Z8JsaGWZhS1a65QQmhMSSBvtgawsIfUSKFwWMhoEcHltA6+IDiY5NUxn2qxtYrouYqwI2QOfPzjA4/eRF3UlnIrpY4GohBl0kS3JJsYvBCG5hcUMbC3dzto+wYE6LL/adeINupEOBw0slSDIChY42NNFTVQ+fkU8s7OWONxNRcr8tWA0gAw9MkMFo/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:41:40.6590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f5e209-eda7-486a-c14b-08df41943ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When gmc_v*_sw_init() fails after amdgpu_bo_init(), the GMC block's
status.sw stays false, so amdgpu_device_ip_fini() skips its sw_fini and
amdgpu_bo_fini() (and thus ttm_device_fini()) is never called. The
freed device is left on ttm_glob.device_list.

Unwind on the failure paths after amdgpu_bo_init(): GART init failures
call amdgpu_bo_fini(); later failures (RAS sw init on v9-v12,
vm_fault_info allocation on v7/v8) also call amdgpu_vm_manager_fini().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 10 ++++++++--
 7 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 49f593fe2a876..e59fee3955af0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -861,7 +861,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v10_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -880,9 +880,15 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto err_vm_fini;
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index bc3b1ffb54886..e492a8fd8eb21 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -859,7 +859,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v11_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -879,9 +879,15 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto err_vm_fini;
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3bb13cfed92fe..acebd6697372f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -987,7 +987,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v12_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
 		gmc_v12_1_init_nps_details(adev);
@@ -1021,12 +1021,18 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto err_vm_fini;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
 		amdgpu_gmc_sysfs_init(adev);
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a7c353d1ac09d..925e9e243a143 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -817,7 +817,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v6_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -840,6 +840,10 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	return 0;
+
+err_bo_fini:
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 static int gmc_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c09f5153679ea..3f3e4105bf3e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -999,7 +999,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v7_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -1026,11 +1026,19 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->gmc.vm_fault_info = kmalloc_obj(struct kfd_vm_fault_info);
-	if (!adev->gmc.vm_fault_info)
-		return -ENOMEM;
+	if (!adev->gmc.vm_fault_info) {
+		r = -ENOMEM;
+		goto err_vm_fini;
+	}
 	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 static int gmc_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 15592027e7c0c..cb6d6e2259f3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1114,7 +1114,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v8_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -1141,11 +1141,19 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->gmc.vm_fault_info = kmalloc_obj(struct kfd_vm_fault_info);
-	if (!adev->gmc.vm_fault_info)
-		return -ENOMEM;
+	if (!adev->gmc.vm_fault_info) {
+		r = -ENOMEM;
+		goto err_vm_fini;
+	}
 	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 static int gmc_v8_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a705830ef436c..136e4130b7926 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2026,7 +2026,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v9_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	gmc_v9_0_init_nps_details(adev);
 	/*
@@ -2066,12 +2066,18 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto err_vm_fini;
 
 	if (amdgpu_is_multi_aid(adev))
 		amdgpu_gmc_sysfs_init(adev);
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 static int gmc_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)

-- 
2.43.0

