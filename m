Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C54C98310
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF4710F322;
	Thu, 24 Sep 2026 07:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VlWokMcp";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235FD10F322
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5zMuRd95jNVZD8zSr7Q3hV2tp/qyqD7eBW6jnODWA0AjgcdBgMjNgCRPfpUkzjgVlLw8RguKt2AkYZhW/fTG9NLZKAfRGFJ+0I2doYJKtUas3olJNyxmDtVg2QQrsVpeW5OjFK0SUqqwoSALix1W6A1oRENd6YfmXea4QJMsklGWqluw++yevVIla+iyTmGTcD9g5JQZkzCu2KgVpVpi9+g4rL4QgBfOhLqdBWbmdG6g4avlIXefEj+Ur8jAPqYFLly5xl6rF3wCVTASsmMo8Os07FFqG5Z/ywre395YgZxp4g36lHnnNYcTRFRfccKS6iENC9kxHaCYsYVO0Ekyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwX4C3QpA1tgN3jDBYLAO6nsBcUBQZR/fr+PdDrjcY8=;
 b=CbBricZNnM1CZE3MrG7S7Nh5Y2KRUqdvGNKTQY1lboS0EH6+2zchYShC6mljC0p64ffqMMlmeCECHAgwCf21EO6U9UqGwH68vRKCeiJqjU5cVZt+L+wY2xcLXYhf5ZNKsDwFzehD4Puemw4PLRSymoJykMwRahywDqaewJ6sZosZRizHHsqtskKv3bSXs3ykd/ldk/sq+3+S+aVg+tiJTfYXYHqJz5m5MB1cbEpniFiRWQD5EviGedmPd7CnKLty1KS4PSgv3nloTlkHuGzaGEMOk+lJqoR/r0KaLaT3Mb0/zdn/yYSJg4yHAxzXYFcmcarnOZLPuNhmmOS0SxyKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwX4C3QpA1tgN3jDBYLAO6nsBcUBQZR/fr+PdDrjcY8=;
 b=VlWokMcphjuIcAN/69kw8G3HCNtZUif4Hfma31nvIuMQoHPbRgMusDn5kEXRCSIOxfRUAWQJ+wDxgV2mivOIKQPWuU9ApzKVk5xEpOiyAAIXwNZp32bC1SYDr1FXqMV7QbmAvqEymAvTZj5DoslJB7BWbrXfuX5SQfmkN0hMUy8=
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:01:39 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::5b) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 07:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 07:01:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 02:01:38 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 24 Sep 2026 02:01:37 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amdgpu: fix the unit of the SR-IOV IP discovery size check
Date: Thu, 24 Sep 2026 15:01:31 +0800
Message-ID: <20260924070131.2150481-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5e4d2d-feec-4df5-b286-08df1a09ae2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: /eYT86yuhebdf+oiMfCpxOxSsBBdK+mCeJYSEa+FqhINBM2JdyZYFzBjDqiSP3gl+km/Voq06IWTZgQWSozKKYsQCxN6hgmj6jkpru3eR4CsypaHfb6M64u/AVbIK4gGhRsw/yj+fhRssN40/X2Bs45iBZhjv2sEkfo3A2GhkkkN8z1viMsptOjvuXbdhDRPA+rQ4q5CNSfWRZeKtxWd+wBr5RqEBJMc0BibnWhz9ds0zu7deXJ9Bzs89wDfVwRRjmw9Xh9MFoD0qqlHu/qekTfWITHhJFVjbXFboPvZhwkENfwdOg+1NwYea32zsXKU9GVTAONakOHnm4poU2tYrN5j0FVKNyb+5VZeSQBqpFjTtQtlDUv4WWquc+Q5EFG5KgrT+2a4a573YVC7vjUbkN/3KBbOsYOhmosYVjJ/BBBjvE/HAgy5R062U0wQwvpQzRYl9/oUQ4GT2sSFF+9s+LJOKE/AzhXk7v8hvEB1lMb5/C5v+VMKOBpmvXFIQoHImf3oobHCqXC6SDrgLy+nFu7PRtS1Gd2gkbar4FACocIRepuYfppbJ+Ffm3HnAntA3HA1oyX9N7shcT8ndvYqw8jCzHr8cnhDHeSZKLcBgQgbFoT/ZRfD2HUiU/ZkeY9twJpG7LwNwrvziPRK+7zxviR560zTcsMtGmJ/IORKAhs6KNXixdG744EpKi+gURFewKAYnxrFw671biW2PPlUuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LtBc+6XYEHFj7tRW/0gdthh/4ldhHKOXA5Znf+Gpqovk8RnSrs7Gm9hq7NRxZ/Agpm128//GYmwvSckvwxjx8Krt35xTE5YQOIXaJ6QUM52GtXGqbhzbpvCNSEmzMxc4N9moU3z0R+0qBwLla8AQFLUiI0jBQOs+WqDVRV+tYaG4RHaWnqcSSocCM3S0iQxb2pPMaE14C5iCTpMzK9IaVv3i72Xz/qDC4gyA55nkDbBWloix8kD657ld0miv2FYYHcUN+pfk6emh5aje6Xb/1+I2Odk7o50dM3t76WxQ6yWMztyyBfNmVrqlvfNeUOcGnRiRmOePiXRpspSGsZGUNdo/8uROTfOtlSR5scw9fxb7lERnn5yZcRK0W0Eqt5OAfQV2CtGg3w4jY4O0wFpjOlscspgZLVz6BSIZdl0PEiGhqrr48Tsp1mEjCaPxS8qb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:01:38.8002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5e4d2d-feec-4df5-b286-08df1a09ae2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
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

ip_discovery_size_in_kb is in KB but was compared against
DISCOVERY_TMR_SIZE, a byte count, so the check never fired.

Compare both sides in KB against a new 16KB SR-IOV bound, since 10KB does
not cover new ASICs which need 0x2840, and drop the duplicate check below.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 11 ++---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 6e1d55e78790..94964efa7dac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -28,6 +28,7 @@
 #include "discovery.h"
 
 #define DISCOVERY_TMR_SIZE      (10 << 10)
+#define DISCOVERY_TMR_SIZE_SRIOV (16 << 10)
 #define DISCOVERY_TMR_OFFSET    (64 << 10)
 
 struct ip_discovery_top;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a454c6f12d38..73d9072f0c6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1115,7 +1115,8 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	/* Validation and initialization for each table entry */
 	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_IPD_TABLE_ID)) {
 		if (!init_data_hdr->ip_discovery_size_in_kb ||
-				init_data_hdr->ip_discovery_size_in_kb > DISCOVERY_TMR_SIZE) {
+				init_data_hdr->ip_discovery_size_in_kb >
+					(DISCOVERY_TMR_SIZE_SRIOV >> 10)) {
 			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
 				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID],
 				init_data_hdr->ip_discovery_size_in_kb);
@@ -1189,14 +1190,6 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 			init_data_hdr->bad_page_size_in_kb;
 	}
 
-	/* Validation for critical region info */
-	if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb > DISCOVERY_TMR_SIZE) {
-		dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
-				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb);
-		r = -EINVAL;
-		goto out;
-	}
-
 	/* reserved memory starts from crit region base offset with the size of 5MB */
 	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
 				  adev->virt.crit_regn.offset,
-- 
2.34.1

