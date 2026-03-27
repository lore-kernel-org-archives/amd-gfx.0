Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3A310F2867
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 20:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DCD10E2D8;
	Fri, 27 Mar 2026 20:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dMTX+NNR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC7810E2D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 20:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiOLvXXhfm3DwbUDNZ2F3dfddNE7NXn/I4G0AXjKYVaA+mPzw7p3Rg3Dwkss5S89LnkwUtwVeiurqv9UOPUj5/K8O88fByqR1Bt3lLPjEv5xpJJOLGkEZHOn6uKAKdQicOUEwIg2x7iX9Ie2v5gPi2dBcnMRsaeaUJaxNdkRFJ5rYI/Wd1uA//0lIOGUFGQh1Y0VOqK+2X9kjKz4mGCSnh3KEvR2Op99f4YKxUWVuuT9ffJJEJAtVzONlPr+l3Mu9JEyil4XFWe4060UJEgvlwI8/EhN3hsPdGIUuz1KVvf3L0eZFixt/fr9wPYzgLz0f4j36bkEpBucHnsvfPXl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/esVx3nDPkuODiWz9sEJtTDmK99psbF5cxA57MLQYM=;
 b=RZVNtDbwn3vq6M2966k+XzTDem6ECt1SWrUQ0AHNIuhbaOtYnvO9YQWjvPtH9p4DB3ALHar1WKMF55YZxMKk78vrSXE6FAdrtTg+cYF8ScXNSKA62DjqPbF8JPRYMJn1IF26/mIM3ybB/qgahlGmH+56XaNnP+aW4zpYkdwDI4NKwbgYVLPk9Fd3hw7d/gcqjKFL73HJ9YluF/FuoV3zE5qPENlZuMCpY9lzoTkKaMTfXus70rxgJ001HA10g+Jz3aRjMb3LgqvhGQs5TidE74eXefqZQFDJ7Llzbb45MQYYmdgs+LnL5/6xCDM/Wc1qS8Z/ayrnQk/P59VFIBvcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/esVx3nDPkuODiWz9sEJtTDmK99psbF5cxA57MLQYM=;
 b=dMTX+NNR2b5vq6XDJ6iW7GMEWZaZdOeVVAu1cdD5AA296Wrb7c1X0AGwGk+qdhp+XRRQG1s+H/SBtXut2IlEwTYOJLsf7YMUnjP2GK5GypAS0gOcrWKeZkoAH5E71lXJfA7j6zfa58eApC3yHroctvNCNu30RhG6pVgkVOWySxY=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 20:32:48 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::fb) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Fri,
 27 Mar 2026 20:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 20:32:47 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 15:32:47 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH v3 04/10] drm/amdgpu: Create hqd info structure
Date: Fri, 27 Mar 2026 16:31:51 -0400
Message-ID: <20260327203152.1578828-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f961f3-cbc3-45ae-63d4-08de8c400260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: wqYmLrNdeFJYfddVsa/wxiAKK9kblbhcVlqLYzg5PFIDYqAupgWaI2IWEWG/2uEy2zlRQzR+nCMrL9mmUy02OCRRB79HPQz0ooHUFcBq813HcP52MnSYeM1xKT9yRV9XptESXgXdLGtJK2B/pVi29rGHDrehc5uIxqe8v2Yulh1VCr5DQVxlhjPdt6KF82785724OEH/ANYKhnabbZqUjsz5k19cfRi6dOLCpMU+3bSfUnU87zz29MSsEF5WYw0GBga4mOwQVyfqx6Aj65Z2FdfR6nEtPrlZyY/zcVovS9hhRaLWqOM0HP6M0IAuCHnwPG1KWPTI0CavgVoBm6hThOGO5MF5GoflhL17XhCsMu4yR06LiZFBEd6KNWx7uVIHhmOzqawJKsHmU+ShpovjWgKNLImtmEyuJ5g1doJH/LcMqGqkSYfRo0YiSVMMM3991pMB8HhBY/BBjmrirgrChUGy5zmtutuwSNks4UdWvq4izgacExCkXvs0zgV40y0WRLS/mgG6XETcVjuGlLymtQNAuK0CPpQ1yqCOf8sKjSMbz9SoTOxMH76M2A5YKBvmmoYxxBtZS6I7Xt/wjGEEZ2jaR9c9rd3i7Z52eM2ez1Ukv4cIc6nQcLLIG30BrO1IYIfnptoWr38kenHUJ1aaft/rL+bq3aG+2344iaKn4p/4zQJdoIDBq2LL7B23ziuG4FJTSLIPgjlOKuHfgHpTaGf5+ZvC0H2ZRqWPgjpNDoZnCa9PW44FFa8j9FJd50xFNZGRa1POYXxGRZNH+dKvLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Och8tlWd4wugQTwYQPSuhghfP0D7kuBAE5G93b5AcfAVW2ujlQ+o9oEwgYCLqhhfKVhp39Jr0L24cW8NrJtbWH/y84Atkc2skvMMZMHTNDg0zfG7zANTAizx+TXFObB3CK51m6br/7JzS6eZT7U1ClFwZsgFfFb2uaE2JLbF5H+E+CtRZO84xysFQe23+uXuIAokKrQuurNsJXkCj8ikcHDpMaL/yMv0HUwZlpsF9h4JqyICy6v2GXlrdjNg9E059+EoOBG6mvYM1R/ekt32x2fYqE49Tzp7+gPoeqJ7O+++Mbm+2aTbWc8QYuz5afUkqPXDJpxGG12uGjGM7FizDsGNx0NqkoSrxxdyT6pOLM+N8xvse6vq/XdqL5Gwg/7wyqDVHlHNPD+4kXGv7zfItRS5anP7b5MwpYlTssoNUSGY71B/lbvPf5UoLsu8Unw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 20:32:47.8116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f961f3-cbc3-45ae-63d4-08de8c400260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

Create hung_queue_hqd_info structure and fill in hung queses information
passed by MES, including queue type, pipe id, and queue id.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 17 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f1f8bbfc31e0..436a46ba1dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 {
 	struct mes_detect_and_reset_queue_input input;
 	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
-	int r, i;
+	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
 
 	if (!hung_db_num || !hung_db_array)
 		return -EINVAL;
@@ -471,6 +471,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		return r;
 	}
 
+	if (r && (queue_type != AMDGPU_RING_TYPE_COMPUTE)) {
+		dev_err(adev->dev, "MES resetting queue type %d is not supported\n",
+				queue_type);
+		return r;
+	}
+
 	*hung_db_num = 0;
 	/* MES passes hung queues' doorbell to driver */
 	for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
@@ -486,13 +492,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		return r;
 	}
 
-	/*
-	 * TODO: return HQD info for MES scheduled user compute queue reset cases
-	 * stored in hung_db_array hqd info offset to full array size
-	 */
-
-	if (r)
-		dev_err(adev->dev, "failed to reset\n");
+	for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
+		hung_db_array[i] = db_array[i];
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index f80e3aca9c78..2e6ae9f84db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -170,6 +170,19 @@ struct amdgpu_mes {
 	uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
 };
 
+struct amdgpu_mes_hung_queue_hqd_info {
+	union {
+		struct {
+			uint32_t queue_type: 3; // queue type
+			uint32_t pipe_index: 4; // pipe index
+			uint32_t queue_index: 8; // queue index
+			uint32_t reserved: 17;
+		};
+
+		uint32_t bit0_31;
+	};
+};
+
 struct amdgpu_mes_gang {
 	int 				gang_id;
 	int 				priority;
-- 
2.43.0

