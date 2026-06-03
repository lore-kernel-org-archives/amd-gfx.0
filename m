Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC9CD6E60
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 13:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3903410FE2A;
	Wed,  3 Jun 2026 13:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="euNazdZV";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1738010FE2A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 13:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwyKtiyWhN2vrfDkLsk43CpN5PWA0OnnEe9mDpkD3Atk4ttJNWpA3WFa9sX9hMelF0+VaHT727rMHUYsfAVfaptziDAkMf2zmZRnjRxd+iZKnS/JIn1qy+ZNhz1/+/Xn4ctsPoE/AKmde3tEBN07aCpvHaUPWtUnPftTUzvYWUQ0JsIFTPaJJ05c3mkDCJv/gtj6/k/mVztb56hqKHV+Fl0Y+fyVNLIdPScci/mkjQSAGRPk06QWo+NbGXFD5yy9qzvq4lTBmwKB52ejW9zNlcP+TTrN6CtHm8EK4IlaDDFl5UHZoLmWFD7AEegRku4eL3kBHcPtMIS5G/2YUxjMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/WIP3rDMRFFj0hyVnmxARd6AhKPb84Fsb/Gu8UA0t8=;
 b=LmBCtFDIQHVahT7VSq8JLCgjMUplaPnPbot4Yv+TkfgaeHeRuVD6Y2PvQdXzgbGyFe/JvT/uSTk3R1yTpmlWQVT6n3N+RoEGVbi7AtomEaKPR3PbWdmZCzPdZQpohZltzQVTZ/pNKCbvO3/FSCr5v9M8TtgyXrkr/CWhR3Mz4FqIAoFPEcmGcDtTMdA4+u/acLY0TOapLL6BPND2udOhlRZMlGPFTLQ9r97nHkL+tuXwgw4WbyxfEk2+BP4d7cqL2BfIOq6xYKu62XIePFL27hTEB7ZM9qDd1Eh47Bvj65EJ9HU6p92dF4pcJFF12SZyOFYHcRV+l1/1EMULwKaXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/WIP3rDMRFFj0hyVnmxARd6AhKPb84Fsb/Gu8UA0t8=;
 b=euNazdZV+zHsD3xIlYlYrfQrRADm5TpeQ3qrqvwda9JK8FvNfQYAdkzY7c/efyWqhPGWx86wSl0xhxtnTZeyeseWGtstz+0VqxpKoYyrTZv79mjfFB6lQ8xVGj5HL6TVvLVcSgr6Z47XmjMuh8ekSwOvvhAigScaws9FNRIkcLY=
Received: from PH0PR07CA0077.namprd07.prod.outlook.com (2603:10b6:510:f::22)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 13:27:56 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::96) by PH0PR07CA0077.outlook.office365.com
 (2603:10b6:510:f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 13:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 13:27:54 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 08:27:54 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Move mqd_on_vram out of v9 mqd manager
Date: Wed, 3 Jun 2026 09:27:38 -0400
Message-ID: <20260603132740.180346-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: abdbab98-096a-43a1-9072-08dec173eb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: HIhaadnaZBgrzMZ0IChr6obzCR4xK19cu19R6sTyKGvxP2wygfNNf+vpf3Qz6/0JywBjda6CHhH9ucWgxj4X176BQ9UkBDrWFK2pS7pdPcJiq7PC4hvWLG3oFG1cfP+fLHB4aoogI8w3OXmbg5PqCvFtwBk+vdjiDb5J5f3kFNImyEVEn2Uc0dPuoeoE6TZvJ2UPZjrkJpGy++iGrvJ5q/OYl2O7h541yzSHeyZrVne6IKlitXuqqvleqj0vLKmHlnuoy0YYUGEKY1emlF9CNaRU7lqQtjmKNH6rLfPF+k5svzYAmATew7ySDbieRZyXlPbKcyFSCnvaG9mkXp1hdxiAide594Pn/nv6HbeKds555zlNX8xKO9CWISx+6DXaBGGPL47zJg36Jme2VZubn5w5dJoci2PINUcYzeXlR3X50EoHW34+ec8/Bcx4YVeEHy9yrbJ7YIIpLkL9PKQ/8ivezHHI5d6YUaQv6RMmT33c0OSRmOzYNJGhDYG+MQLht/6uaM4OsH9am2iUUvy9USY03H54ubCc8qPnp/TGtaRQYHlaAnrilpj2Oa4Dhrro+91lma55gM8+ofb3ZPrrafYMBaZfdwbpHBPNQVeHVqloivqC1j8AHmlwNPR2yfOHGUNkjRJGCsPT22p9M+8Uh8Epw/eoUOpf/zatgNwIlxDOw370Y12SgcJ6lJe+mnS6wpCWTvuxw3py8npBFFSXuht1V3mCIorQVpbQ2xng56A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8AgpAL09riRP7fryXi4jU4GAo1xpAcdjIF0jbsqgEyvxE6cUDOwCiWeeFUJroTn7jkFDaocq7YIWRtRVrWtSe8VvT4rfRmYuDZR/1ZZMx6q0T03K/x2YNim2VDjC4C+xGJm4UdqyI9xeLMIKYp8ngruUz8yRqEy4CtF9Vh4ClJ6lcyaA8emQwYyT0f+lZTDWydgABgwoX9yAuteYJ8Rpia2yITk30YmF7ov5PcUIy68Zv2EeR4YSeD6kKydFQY06LeZDneGIfzGwPOT+KUN6hGAe3FYWepfFaoTc4Yoydgbsr0wzvwicXDUUn2SJYgxtf0jpFk7AiVmuHyKzj0aV4o5lPHW+1ssOgdwoelP9LzB7XgCBW4u4LY7sX1pupjQQy5hWDtx5grll1Sg6//99j3dbKc3p97kpn1/zc1nIeTZnOgMJhYXMlEaiQJmKdlMs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:27:54.8795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abdbab98-096a-43a1-9072-08dec173eb79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674
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

This will allow it to be used outside of gfx9

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c    | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 14 --------------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index d88d0de58edd..02b52f907f80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -315,3 +315,17 @@ bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
 
 	return false;
 }
+
+bool mqd_on_vram(struct amdgpu_device *adev)
+{
+	if (adev->apu_prefer_gtt)
+		return false;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 5, 0):
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 06ca6235ff1b..140ee1fc5d81 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -201,4 +201,6 @@ uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 			struct queue_properties *q);
 bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
 				   uint32_t inst);
+bool mqd_on_vram(struct amdgpu_device *adev);
+
 #endif /* KFD_MQD_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index a04102fd2fb7..ce379ab17916 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -115,20 +115,6 @@ static void set_priority(struct v9_mqd *m, struct queue_properties *q)
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
 }
 
-static bool mqd_on_vram(struct amdgpu_device *adev)
-{
-	if (adev->apu_prefer_gtt)
-		return false;
-
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(9, 4, 3):
-	case IP_VERSION(9, 5, 0):
-		return true;
-	default:
-		return false;
-	}
-}
-
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
-- 
2.43.0

