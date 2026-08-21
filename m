Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E47C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A15810F387;
	Fri, 21 Aug 2026 16:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ms50f8XI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CF910F381
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQ0bmKq/tV16nxfdF2su7lI5aowrYKLd0aQeQgIQXJlobt7L2iY4vJYDfAt6VmDCZ92LNjUkXpUVU3CWCRyv+YDoKjvDhuydz9wifsNi4JdjF/cy7Emep5xCkUb/9C4/4JwirqVtAueHWQ/i26gQwlEqBUijJv3FKp12ft7+fi5/JhIPaROFBeaVPfR2AKEvOC4qWypenE3UfwARLAlBkd8rYLrsng1Z0G9BS02FR1wLmB8YqPZSxKbeqnKJxNezUKMOCUSlxAPSmDCzTCR3mox6N8KJWjAdRONGLftc/0lY8WgnO5F2E5bd+FZf8afIObQuxnh5sR4ZPK7WXj+j6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MssXg9jM5rQFH96Yg6F/2eCx2W3vsi3j+5RQ9QjjPds=;
 b=RuZDHt18Qd6wpg5QiMeV4JglpOLJx55AtXP0agcO0pK4x1ITejTsuojIHZa56eNJ/weyEyGpf7fI2mV2VSHzeLBNc1ffoC1xqrj31V/QlUT4F454jkMVaPD5jMtjwM10qt2TTGyP81M7YRGCJG6LcNjWdzFBJW3amvkZ+k9S61sjGuN8WmDpqu6kkn4YNAoaeL302MnKafhEUIZSf5tW4BXMjC/oJWAhQJFaYTmFkJ+cUx7QkiNdpHhDzNzGsFU1v89uc3+EpVhVcOo0Sxg/9hYABUI2MZIls2oDWf0MNbB2zKss0HSU1uMlHTfitC7hODRxFlIQzqpJKqQl8JnUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MssXg9jM5rQFH96Yg6F/2eCx2W3vsi3j+5RQ9QjjPds=;
 b=ms50f8XIDcF6MGNHQL0N+s04qtTIpLOzvj3l4T+dv5X6vvtJr5ZgtRVUjR6z6dulnSFwoxB11paz6NRqrVrOUCfgcKEL3abMr1sZLkppYIDUVhkwoeCL2jO44YPHZVBE4OCTLHGAHu2aZgln6x8dKNyrRYmG/UkV8bVxN8pOi6k=
Received: from SJ0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:a03:333::18)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:14:28 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::76) by SJ0PR03CA0103.outlook.office365.com
 (2603:10b6:a03:333::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/14] drm/amdgpu: add get_fw_reserved_info implementation
Date: Fri, 21 Aug 2026 12:13:53 -0400
Message-ID: <20260821161401.754042-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: b135747d-f442-411c-baec-08deff9f46ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: XhTOj1goNxHHCZ5PTof3gIJSCe3DKOhXJaImFUwIF7vnM3O6pulDWOgtOKb2ZiHAQsAGu2hVckygbGCvtczIqWtfpSXV0nmzT4x2TihKDn7qkV+qbDUu6o2h+jnclAQcBiLrfwEmWexKE20BbiYx26Rrpv9Loo5v/SsFoMt6URn2q730PXceAUJEZnv/5nUx3rCl0mIvUkXWkq1EVA03mPjIIFFf9F0kcLxFHE5rA+QCk8zEJo6rcxEEi5dKiqcGfoQ7a66yIVdiNzNhbnexTIC8umIkVvoE1MA9x2AtMVv11wsGptkkquRpH7cUlhscEqI2lFncUz01DmFWju75n6dkRqLv9hKK2XlBp73UUaCxm0Fe5CQ94F9uAPz5Oq2fwPq82xTt3JWuJDy2md8YB6KwCbED/U8NRs/Y5ui015MYWH7Bezu9drsY+O8mAGtMidCdN0GQi538azpJqaO+HHa4AZYg7MduC2cjx0wD3fe/nVuGM1Zhm23tuqeEY04nkanJ2kT1pzvomTd6WyjXgsTLeij7fQ5gYXEGqHKlLv4Kasfqb6l4DmxPiNSlY2dSAEJJCAkaXZxi6dIF0opiw3niQyMkNUZ+HbF2Wd9NioykGI2SXmu1+kfsItThEDmsBrElWHP7qUiKf6//QbfeGgDbT9CR8RMqY6lhUZyx/femfoZcsq/lYih+LLC3hgFG/dbi05Xd8nS9LIVYA+0wbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8HMYlwO7n25U7f1EJ/1X+drAZ0cCRnqms8fJEj5aqDETNYYWmxcnzJxOqWenIYKX9+HFT1hkqLwf+4vmPEvvKzrGJXOKtBkAlXWEgjNZD6xSImek6k9oIGWz0o9SMSRqCw6sQBtlHbCkwF8mYgB4Mj3o98/IAfYmCSejK2Bvzf48cmiKKcjWponUsZCpprmB4kLWXsmuzmWzNvTYaOpAyVJklYNNDZTjIu92EWvcDhFUcSXZYnKLR+zG+v6o2l58zUWcIB23L9jcOHe5aXwTh5UPkWUvxOiRAJRZ+lnFB6gWt17XXlQX699i5mS3RUnpam0l/1XBOaG3Ufpd7mbMGcE8sZOlf0wadgQss/AKFzNQgbNrbxukfQsi0g460WBoNjDTIkfP+9Pyv4hraRlik43fktgDlC7uMJ1+Vwzuf1HVKCqvOOVVWFVitDwcYs+4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:28.0575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b135747d-f442-411c-baec-08deff9f46ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
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

Add asic specific callback ->get_fw_reserved_info() that returns the
firmware/UMF VRAM carveout as a (size, offset_within_VRAM) pair, and
provide the soc v1.0 implementation.

Query MASTER_DIE_UMF_REGION_ID from the discovery MEM_RESERVED_INFO
table for the carveout size/start. SPECIFIC_PURPOSE_REGION_ID is used
to resolve the VRAM base in multi-die layouts where VRAM may not start
at the default base.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  3 ++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 50 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c7fa2fa982e93..8a7c89afc88e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -482,6 +482,9 @@ struct amdgpu_asic_funcs {
 	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
 				 enum amdgpu_reg_state reg_state, void *buf,
 				 size_t max_size);
+	/* query FW reserved region (size/offset) from discovery */
+	void (*get_fw_reserved_info)(struct amdgpu_device *adev,
+				     u64 *reserve_size, u64 *offset);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 5b18a5c8114ff..41d7300fd5ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_discovery.h"
 #include "soc15.h"
 #include "soc15_common.h"
 #include "soc_v1_0.h"
@@ -263,6 +264,54 @@ static int soc_v1_0_asic_reset(struct amdgpu_device *adev)
 	return 0;
 }
 
+/*
+ * Function returns a pair of (size, offset_within_vram) to
+ * tell caller to skip the *reserve_size bytes starting at *offset inside VRAM.
+ */
+static void soc_v1_0_get_fw_reserved_info(struct amdgpu_device *adev,
+					  u64 *reserve_size,
+					  u64 *offset)
+{
+	struct mem_reserved_info umf_info, vram_info;
+	u64 vram_base;
+
+	if (amdgpu_discovery_get_mem_reserved_region_by_id(adev,
+							   MASTER_DIE_UMF_REGION_ID, &umf_info)) {
+		dev_warn(adev->dev,
+			 "MASTER_DIE_UMF region not found in discovery\n");
+		return;
+	}
+	/*
+	 * If SPECIFIC_PURPOSE_REGION exists and non-zero, use it as the VRAM base.
+	 * In multi-die layouts, VRAM may be placed at non-default bases.
+	 * Prefer to query SPECIFIC_PURPOSE_REGION to get the vram_base.
+	 */
+	if (!amdgpu_discovery_get_mem_reserved_region_by_id(adev,
+			SPECIFIC_PURPOSE_REGION_ID, &vram_info) &&
+	    vram_info.reserved_region_size)
+		vram_base = vram_info.reserved_region_start;
+	else
+		vram_base = adev->gmc.vram_start;
+	dev_dbg(adev->dev, "%s: vram_base=0x%llx\n", __func__, vram_base);
+
+	if (umf_info.reserved_region_size == 0 ||
+	    umf_info.reserved_region_start < vram_base ||
+	    umf_info.reserved_region_start + umf_info.reserved_region_size >
+			vram_base + adev->gmc.real_vram_size) {
+		dev_warn(adev->dev,
+			 "MASTER_DIE_UMF region out of VRAM: start=0x%llx size=0x%llx vram=[0x%llx,+0x%llx)\n",
+			 umf_info.reserved_region_start, umf_info.reserved_region_size,
+			 vram_base, adev->gmc.real_vram_size);
+		return;
+	}
+	/*
+	 * *offset is the distance from the start of VRAM to the start of the
+	 * UMF carveout.
+	 */
+	*reserve_size = umf_info.reserved_region_size;
+	*offset = umf_info.reserved_region_start - vram_base;
+}
+
 static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
 	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
 	.read_register = &soc_v1_0_read_register,
@@ -274,6 +323,7 @@ static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
 	.reset = soc_v1_0_asic_reset,
 	.reset_method = &soc_v1_0_asic_reset_method,
 	.query_video_codecs = &soc_v1_0_query_video_codecs,
+	.get_fw_reserved_info = &soc_v1_0_get_fw_reserved_info,
 };
 
 static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
-- 
2.55.0

