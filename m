Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CF9C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7980F10F37E;
	Fri, 21 Aug 2026 16:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BCNvORuL";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF5F10F37A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABwpOryqnsNSIKboKQP4IZ2GsnYX/a4DExQZeTC7QCzJgrIqcrOOuvGlYQ8c/o+ZmlTNZiSMxXQCLU4k00ybNyYXHExLlFSOFhTBvc1n4dK7SHsGdHcKcR+Tfjnp93wq90/u99V/TkORNfm5jgPSJ9/cfdmZGmxJkmEDWgs0CsV+TDrMld49t0fcJAXch4xO63/Y6flZ5U9638Pd2NkEnUzvLljrq7+IogNBm68aWAlLccAcrNSfjGH+UwYAVdgH9u/SUmL7i7TlK7Pz5JF6+P2A2tBXahNxlYcAPXyo2YtnxN3UHWFpy53QtB+AFieWqP/rIZvN/yDo3yAlUmnUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh0wOJ7OLXYqVdm62SADAcVGK6yKLlv1wpTi3Cc/sh0=;
 b=a3T+j2IV/72peDRVhGAG+yRinywV1uWq/mroFNvEfEWYEt4XRVR2GCYVZIAb3LQDEKsAx5/Zne65cedt410fBGxti4crz7WT0vnYvUkkpitDzh+xIRnE+59sOZVjVg0g79TTJWmjZyd9YKPHx8FTF2JiLxT/7x8Yo8lKnEzG0QPpTXfx7k46KQFY3mgJRtQ0g8maIT241bKWXKyzcrJ/XsNYoQ9KNHMnyRwS5rI+LIn0wN1RhptHAVyrhVdQxKNLA9gr3r0pagEXximz83pweECO8+4A2VWS0tFdDDaz0CRibgUJAF4+JWD1/V4o+2rwPRL4naTue+qyn3uq0bhCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh0wOJ7OLXYqVdm62SADAcVGK6yKLlv1wpTi3Cc/sh0=;
 b=BCNvORuLKwBUnhBkncnTV0aTBvZ6XOF/GJxXCFpHeDdhZe0ll+r+5eEt1xUHliHf2Az4vc6KmVNQMH69Kdgd6oGTmPXD8vlHBKY20zjNw5Z7IyVp8v1xPdbBjuIuPcE7/qUTDFvu0qxNd4ospgBZQkBMKjD1rWuEvBx1BtpcuLI=
Received: from SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:14:25 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::10) by SJ0PR03CA0092.outlook.office365.com
 (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/14] drm/amdgpu: add
 amdgpu_discovery_get_mem_reserved_info_table
Date: Fri, 21 Aug 2026 12:13:51 -0400
Message-ID: <20260821161401.754042-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 05343aa9-3b4f-44d8-4a04-08deff9f44f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|6133799003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Fj0YT6BNrb/e1gk1pBYfJoGOuPXm+yU8d/Nta/tuRg2GNzY7+lRa4lN4M4FcUkH1fP8m0CiR/mpTBE8dw3E2G4DicREWjM7XJyaNJtKklZAvHTwg39rVKRum4+VnOhFSiUNZH4EqwLRF0NZ2K82Ajmyk2IRnyyiPXDJGfFqkUc7PL9gahoduo8E67pNHtMEgZlcx+VkezH2CimTVcAu+mdJL8xSRf63EmH1Aj8lLJhzC7Y/LKsAJXracSMQ3AlobiWHrG51+yJGIZeEFDSYpJEChZNA+49GcqD2R0PUtDIm9fqrIXaEuwr2fxKI83iYiLfmd8kHI6MAljh1ikYkVIzarzWYRDf3+OJPf7YjP303H52VZkf1VWvwadXbyYdm/3B64GiCCAkczPSfj4ps0ubtWbBnK4bCzn0xK2rfjlSImroAsx+8TcR/jaInhlJY9oG3XkBLuouoP+G+K4PedniPZimtaHsvLC5XPIqybT9QhHtj3NK+A2lJY/yBIA2qz+ZVg9CzDTGYNPdbA7bdCVyLZ0Ne4dh196KujiQiX+ThH6pGPTeH2NpB5HGs+J74JwmTsHoUCv/ZiR0IdqrBAy2A5YS2tCdQYE4+5gj3/sl3njok/wP9zw3Fy+BGNDk6cvt82CVY3Z/l6KjXOPQVbCKmaOReLzSNLer0/Q11eHVTbFaFO7TSEB6s6eI5+bn1qEyEd20/wCivW0LULhR46oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(6133799003)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fW14OxuzzdS4yLAk7p9KGs+4S9PdRMVDRzvP8pY7el2OuxNFDlbh3/nwoT0OTgJ73Di6wOcrxERrkjF4gsNPDdc/dbOi9t5fEvfzFGWZHbSsuAkqQvdNJxlLP2llo2+LMM2+0eTHt8+jGtjwKX8KznEhQ4xp8CTY9Va8wsCVQcpyI1qa15DsdRcbq9C+qTVQi9BkqGRnL/3EE2rpvHUzzzY00amqO4oocQy01EcfUn9CzZljg27Ilf7VYltzgGMvkj7M80kqUpwDxtyiKyeBuzNk4QaFXcHOtjMfS8OO0wJwtuuOsERWPxAPE1O7s4UzKGGrGfSX5yN1UmyZ2nuE6W40kLoyxVgpelUQZY335SBm/cLL5+FWB8LwEPmNJNamhB5YKIOdYtEQ1rqNb8ynz3qLMD42eiJ+f+WMhxtRkWcJrnWPm8crh0aCetRVYFAl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:24.8764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05343aa9-3b4f-44d8-4a04-08deff9f44f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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

From: Feifei Xu <Feifei.Xu@amd.com>

Add interface to query the optional MEM_RESERVED_INFO table:

  - introduce amdgpu_discovery_get_mem_reserved_info_table() which
    resolves the table from the discovery binary and caches the pointer
    in adev->discovery.mem_reserved_table so subsequent lookups are
    cheap;
  - invoke it once at init time. Missing/invalid table is non-fatal.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 55 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  4 ++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index af1404ae2b70c..4d55933f033cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -684,6 +684,15 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 		check_table = false;
 		break;
 	}
+	case MEM_RESERVED_INFO: {
+		struct mem_reserved_info_header *mrhdr =
+			(struct mem_reserved_info_header *)(discovery_bin + offset);
+		act_val = le32_to_cpu(mrhdr->signature);
+		exp_val = MEM_RSV_TABLE_SIGNATURE;
+		table_size = le32_to_cpu(mrhdr->size);
+		table_name = "mem_reserved table";
+		break;
+	}
 	default:
 		dev_err(adev->dev, "invalid ip discovery table id %d specified\n", table_id);
 		check_table = false;
@@ -772,12 +781,17 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	for (table_id = 0; table_id <= MALL_INFO; table_id++) {
+	for (table_id = 0; table_id < TOTAL_TABLES; table_id++) {
 		r = amdgpu_discovery_table_check(adev, discovery_bin, table_id);
 		if (r)
 			goto out;
 	}
 
+	/*
+	 * Resolve the MEM_RESERVED_INFO table once at init time. The table
+	 * is optional, so missing it is not a fatal error.
+	 */
+	amdgpu_discovery_get_mem_reserved_info_table(adev);
 	return 0;
 
 out:
@@ -796,6 +810,8 @@ void amdgpu_discovery_fini(struct amdgpu_device *adev)
 
 	kfree(adev->discovery.bin);
 	adev->discovery.bin = NULL;
+	/* Cached pointer lives inside discovery.bin; drop it to avoid UAF. */
+	adev->discovery.mem_reserved_table = NULL;
 }
 
 static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
@@ -2375,6 +2391,43 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * Resolve the MEM_RESERVED_INFO table from the IP discovery binary and
+ * cache it in adev->discovery.mem_reserved_table.
+ * Return: 0 on success, -ENOENT/-EINVAL if the table unavailable.
+ */
+int amdgpu_discovery_get_mem_reserved_info_table(struct amdgpu_device *adev)
+{
+	uint8_t *discovery_bin = adev->discovery.bin;
+	struct table_info *info;
+
+	/* If already queried, do not query again. */
+	if (adev->discovery.mem_reserved_table)
+		return 0;
+
+	if (!discovery_bin) {
+		dev_err(adev->dev, "ip discovery uninitialized\n");
+		return -ENOENT;
+	}
+
+	if (amdgpu_discovery_get_table_info(adev, &info, MEM_RESERVED_INFO)) {
+		dev_dbg(adev->dev, "MEM_RESERVED_INFO table entry not present\n");
+		return -EINVAL;
+	}
+
+	if (!le16_to_cpu(info->offset)) {
+		dev_dbg(adev->dev, "MEM_RESERVED_INFO table offset is 0, invalid!\n");
+		return -EINVAL;
+	}
+
+	/* Cache for subsequent lookups. */
+	adev->discovery.mem_reserved_table =
+		(struct mem_reserved_info_table_v1_0 *)(discovery_bin + le16_to_cpu(info->offset));
+
+	dev_dbg(adev->dev, "MEM_RESERVED_INFO table exist\n");
+	return 0;
+}
+
 static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 {
 	/* what IP to use for this? */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 5b2b16f68576c..070b404c1944c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -25,6 +25,7 @@
 #define __AMDGPU_DISCOVERY__
 
 #include <linux/debugfs.h>
+#include "discovery.h"
 
 #define DISCOVERY_TMR_SIZE      (10 << 10)
 #define DISCOVERY_TMR_OFFSET    (64 << 10)
@@ -39,6 +40,7 @@ struct amdgpu_discovery_info {
 	uint32_t size;
 	uint8_t *bin;
 	bool reserve_tmr;
+	struct mem_reserved_info_table_v1_0 *mem_reserved_table;
 };
 
 void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
@@ -59,4 +61,6 @@ int amdgpu_discovery_sysfs_early_init(struct amdgpu_device *adev,
 				       struct pci_dev *pdev);
 void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev);
 
+int amdgpu_discovery_get_mem_reserved_info_table(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_DISCOVERY__ */
-- 
2.55.0

