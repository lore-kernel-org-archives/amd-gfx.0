Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCB3CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 09:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E308D10EA42;
	Fri,  7 Nov 2025 09:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3P3mYvMH";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A94510EA42
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 09:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1iooKLTVfGqgLxw2Ly9SI0zH1bhSv5qXpVy7/XIaUB9fdBgugGOIAkl/R3bhzeelo/ivO5K9Y3xag5WWxBUoVC+muyLAT68b79mC7FKXzcrWP+n/1rURXOjv2U6uZ9BtaLAllK7nWlYY82wSujoc3SjfJ6QAlLIuTLHqDLkSRjJqrIpJFEUPCMCi1KfD2t7I93r9mqoi+D3vtk2Avxef7PfvjmuiBvbEChpGMshEY5xFXN07v5R7sYPJShmFavF/WS2ClAu1y3dt/UxDvIVuDEkXIYMUw4mhbciD1CiRVxDsmYRJa7Y9UmcfRUuFATy3bFILqeYf22cSzE41gkPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7T2wvJEjtvYjn+W0ouZkdc5YSXyug58dPWdor3HeOw=;
 b=qXGbdNHaEjJt4Ezk6fXY3pEDubLZmXlil4stOsFJL0uaKzyk1Emb/df4Q/cPcrLL6iPanZSKXSaJeSC0cCj/8irhd8s424gX4jcn5P7aKfJI2LOIAi5L4wepdiPyKSNXKTyA58/tPtKUXYKTYys+4Cdudh2aLstrIvmrUvG0usnzuc//7mX9xvECxHDiElKCEnBI7UDWFGXzYI65JFXQe1MIFXmFFOsyZ+yaP6y5wCfhDwzpZ/dBJnM5LdWHvaq0cx749Y3gL1HENpoqK304fQ6uB1i2ClL2hyP64suwJ8m185oU5BY9lqucZ044S9X2SYJX9fUmv6mo6EcBglBlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7T2wvJEjtvYjn+W0ouZkdc5YSXyug58dPWdor3HeOw=;
 b=3P3mYvMH/zlYRL6CHICqvseGFMMnQUPKtjWvGWVQixdVdEJnTWv844CAxDEDYYRi6vKoTMbq2ZkR1sn6B7+2j6roEKilXP9wRCUTHDXy1nVTkMW5smhqyTSQHgwhmRqH8/NdZTvp4QX0IzM+diwYt1oStyX3vv0RdCv15ztV1R0=
Received: from BN9PR03CA0808.namprd03.prod.outlook.com (2603:10b6:408:13f::33)
 by CH1PR12MB9696.namprd12.prod.outlook.com (2603:10b6:610:2b0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:06:37 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::e4) by BN9PR03CA0808.outlook.office365.com
 (2603:10b6:408:13f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Fri, 7
 Nov 2025 09:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 09:06:37 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 01:06:35 -0800
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, <Harish.Kasiviswanathan@amd.com>, chong li
 <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Date: Fri, 7 Nov 2025 17:06:19 +0800
Message-ID: <20251107090619.1673053-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH1PR12MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: b89440cb-8e62-433f-952f-08de1ddcf4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IuIkpmw4EHDdKPMDqaSxJ/bRVErdR4QfScWg71tdfTmsHtdCuh7aLO23V9Jz?=
 =?us-ascii?Q?dgqRFp5ektBhAZbcoAvVSyDRfTZ64eQ97LS+GkOZ6jMzAxWwzGKn1yz1eIwY?=
 =?us-ascii?Q?iIG3xve0aTU46FDrLMJmsSbfj76qwaxMBYH/GmltXA7tyFx4MRcD4MJt1D9k?=
 =?us-ascii?Q?pvIkxO1E7tjtAbh2S86/A/FEAcPTR8nOBU4Dhe+Oero7pS545ovonP/SO0IC?=
 =?us-ascii?Q?EsWWsu4DlwJKpr+JzDBKLRB6ND+cUFq3+ai7Dzmpy36D+/gBnJD+9AurnReb?=
 =?us-ascii?Q?TZXs8dvly2jQm77j09xdhvKFy11d8279qvv+TKnI7y9hsve89A3NfTG2rXzP?=
 =?us-ascii?Q?SS54rzDT4DsiOLjOVQICsHVLWtV2crnG58JaIHA25ef/FBx9PVDo73o7YNFy?=
 =?us-ascii?Q?BIuE8GyyIf3OaT7hfJ6Ux4aOdy0sQl2eLm+3nlkSwr4GKfoQdw1NPltRAo4m?=
 =?us-ascii?Q?UZiuOsuEX3DvDWuyJXMniKsIFCo237PessZa3kYFdi4TOIhulImzsNHG+g/Y?=
 =?us-ascii?Q?PVtJnY4rg7B8Ytjmowc8pLcZ/devMJOW62Uw0zNs4Q94UTnKFeT1fRhKlceU?=
 =?us-ascii?Q?O8y7pf2wGtd+M3VRvuQlCH8XkBd/lmgo8vQ+DsXhEBDycFhnnAnRwn43MGmI?=
 =?us-ascii?Q?oRnU0lb4mhtls7QFFO3oo7UTb5+wZ8GzauqejE0mYlNXgs5JuuBJY7Mpwpsm?=
 =?us-ascii?Q?hfZQJEGX13yya7jaQjMmJNOnbrtEFP5d64mA2xzJopE9Dj30QVhJIM+G5JZj?=
 =?us-ascii?Q?U+XzUj/aGf42kHDj32/nO4mu6ticnNE9x+skrYcaekZbjoeuWM5SHWZttyDV?=
 =?us-ascii?Q?hj8ZGYisyJ1wjMsKdj5l9z3fzJc3HR6w5wOhHwcDF8IAHoftQ1nC6GZt+QrI?=
 =?us-ascii?Q?QePwdZMCgbqdo0pAMr9rUUkfDD95rYIioaOhR1Oqfzwme6/mvi+gOighIpKT?=
 =?us-ascii?Q?Jil3iXPIbfES2xCTYY0upAtEg7JnWPHtAlep+cQ2/R3U3S9DOJTWUPaZqAPP?=
 =?us-ascii?Q?7dTeyuGDqkawpkY/yOYwUBlvbJMw6CVk7TL3/yjbCjkpUF18lhotnME1mYbv?=
 =?us-ascii?Q?uevedK2EKRTcmxiDyPSTTWIQUCtrJZRD010/U6okBVpQu/1r0js2R+jVxadG?=
 =?us-ascii?Q?75PuuJY/Wz4M1qRUWFrjErkG9iSS6e6D5rQWeMVYp1kzPksfzefYWq3YtiEb?=
 =?us-ascii?Q?Sd0vjRKVnFYRJOCkIRe9dK5Q++L2qaOaldoOLPDlZS3FiweP0BtCFf2gmpd9?=
 =?us-ascii?Q?ZaYg1f9zDOcZRnErJUYwDOBWvSXXAU5De/UYEqHXXAlZzxhuYTuzH/sQS+Gt?=
 =?us-ascii?Q?myl+YVbIRbitb4ICgdI3l+xbf0Q8/yiSbiL/l3h75QoZsYIyqHHpHju8hiPU?=
 =?us-ascii?Q?0wublY0ZFt3OgQFjTIGlN8pQX5Wk7fKL4rJZ0nq6wRPglaAqn3efGve7Vf/L?=
 =?us-ascii?Q?98/f2fx3viNNMa+5W8Jc4P3c5NxAv0sQPT7HyjUvBZp4ik0/MnRZ0IjoGtuc?=
 =?us-ascii?Q?k9QpSrFwsLG2qS48Pm3p70JB5M/YTxWLJ3i1gFhY1EwsiF6rRl/I4At7U7rG?=
 =?us-ascii?Q?zKMWJksm55+9O50U49I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:06:37.1980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89440cb-8e62-433f-952f-08de1ddcf4ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9696
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

[Why]
the function "pci_p2pdma_add_resource" in function "kfd_ais_init",
cost too much time.

[How]
move the function "kfd_ais_init" out of gpu full access regions.

Signed-off-by: chong li <chongli2@amd.com>
Change-Id: I2db38d905d9dd7fedc4c6a38e325320268c2d84d
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  3 ---
 6 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 39d712e3e692..e6829e5c8801 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -37,6 +37,7 @@
 #include "amdgpu_umc.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_ras_mgr.h"
+#include "kfd_priv.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -234,6 +235,13 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 	}
 }
 
+void amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev)
+{
+	kfd_ais_init(adev);
+	adev->kfd.dev->init_complete = true;
+	adev->kfd.init_complete = true;
+}
+
 void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev)
 {
 	if (adev->kfd.dev) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 40c46e6c8898..504cf90b84e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -170,6 +170,7 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
+void amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);
 int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
 void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eca11fbc637a..6c8f0de84727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4760,6 +4760,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * completed before the need for a different level is detected.
 	 */
 	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
+
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
@@ -4971,6 +4972,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 	}
 
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+		amdgpu_amdkfd_device_late_init(adev);
+	}
+
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		amdgpu_xgmi_reset_on_init(adev);
 	/*
@@ -6628,8 +6634,10 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
 		/* kfd_post_reset will do nothing if kfd device is not initialized,
 		 * need to bring up kfd here if it's not be initialized before
 		 */
-		if (!adev->kfd.init_complete)
+		if (!adev->kfd.init_complete) {
 			amdgpu_amdkfd_device_init(adev);
+			amdgpu_amdkfd_device_late_init(adev);
+		}
 
 		if (tmp_adev->pcie_reset_ctx.audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4c50530e7c32..423ff3c8502b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -89,6 +89,7 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
 		if (!tmp_adev->kfd.init_complete) {
 			kgd2kfd_init_zone_device(tmp_adev);
 			amdgpu_amdkfd_device_init(tmp_adev);
+			amdgpu_amdkfd_device_late_init(tmp_adev);
 			amdgpu_amdkfd_drm_client_create(tmp_adev);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 6b375665507d..65c3136413f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -686,6 +686,7 @@ int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 	if (flags & AMDGPU_XCP_OPS_KFD) {
 		amdgpu_amdkfd_device_probe(xcp_mgr->adev);
 		amdgpu_amdkfd_device_init(xcp_mgr->adev);
+		amdgpu_amdkfd_device_late_init(xcp_mgr->adev);
 		/* If KFD init failed, return failure */
 		if (!xcp_mgr->adev->kfd.init_complete)
 			ret = -EIO;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 784c28fbadda..a4a91244cbc6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -935,9 +935,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_range_set_max_pages(kfd->adev);
 
-	kfd_ais_init(kfd->adev);
-
-	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
 
-- 
2.48.1

