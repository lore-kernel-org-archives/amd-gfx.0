Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF36C5AE49
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 486BC10E5DA;
	Mon, 10 Aug 2026 03:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ymm53Se1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188EB10E5E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQ6ooqellBnNcTdoxSOpxJUmLmiUHFxbOnKWyQvVDCGAb5J8pYkmUKdhgfazhffpsG5K2gCxpMMMVk8qaMy9n7wj7xEN/VxIb1p5HfpfwnXP40dCY1yaz4FLEJYuoWbG5YGXtHMFMjq5gqWhManTvgiJo8O8vGjdD5MiVh++i1kGuwUYJSITPbQJpLxWt1O3RUq74JOJRkHonIPJX4yYjynu3ZBHfABkb1W6VZTqYRDSopL8XA05Umr1/1LfsJzPJnSn5XfgbqkPrqx66JYRbIQsE7nqI4Sm1Efryr6q0IU1zSpWbfq5A0DBRLACP7Z8FF6jqrWcNPTg7aU5gPzW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6enCIYDPG1owkHaVgtZ7akm5sHY0+yMkaEtryITxaV0=;
 b=RRqUNXRMtWAvZyIOc3B8Njy0KBkszr+YDGPt/Vea0PwWbtZuLtSVgK6uCSnybk0pSUjZXp27sy0TZnUy9CA5MvCy0otEpPISCrrQRty6HWotD8N9T6BhBP36j3Xco/fTEij533T5WrEgjIyI5oUGPIhvuEm4yjXj14EYV3JZ/Ww/jhGhjHisulr4Ef5c/AfI+rD1TDoN4feea6R5BbBFXECIi+TaChmrm/L5feSiSlMekZj/rwMurwt13UG+3OyURnW0rsaSblY97KNKguWZ9z/3IMHnQmSaqLh1jsGzRb9s8fvLhO6pcVsmLNZs7RAQmr2cSAscV8CREUubuBzinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6enCIYDPG1owkHaVgtZ7akm5sHY0+yMkaEtryITxaV0=;
 b=Ymm53Se1KCDg8doTORxCF7HT8FLV7Ce6j+YuiemexHOiNT94FdNIDYYwiUhk9q1lv6qzInlp9WzmagdwJq3nrdmy08j+zz6/2UTwf08dbJZTcyVOVxt31laGtbR1affPJb/tP7P3FY/QcdgO0c2DStn7Zet8+Xxq3i3JUmLSra4=
Received: from DM6PR06CA0073.namprd06.prod.outlook.com (2603:10b6:5:336::6) by
 MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 03:41:12 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::36) by DM6PR06CA0073.outlook.office365.com
 (2603:10b6:5:336::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:12 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:08 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 11/13] drm/amdgpu: Jpeg 5_0_2 enable doorbell
Date: Sun, 9 Aug 2026 23:36:42 -0400
Message-ID: <20260810033644.118194-11-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: e47696c3-bef2-47c0-ccf8-08def691393f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1le/VRqsLi/pPYGRiHWG3j6QKDL1EOMNTgD/l4CG5a0NdH5rnDkzmaVBHOtqHOv9xKCeD+7mGeLGRKQNcB7z+tV1k1K8j1EJyn6mCY5HktksyBRf3nXLmukO+IFUUkrNAA/287OvWUHepsRID+4WYp21KXAAk/9ocuf5KOuSQs5c/0/G7iUIwDDdTFvMR6tuwszqzefent5ojisGHOy4l+Vy17CZEUViJXOtKqv+mffnE+1aNkTBzXskz+uIO6BrEy0dSBXz2mgMlbpYZjwmtqZxEcWSrV3kITx2OEcs44KOVAJc1HRnFwueDMC3jJNs3dHGgz9/rVNXBc8RCApXGtxf4xlMik3U1gdvSkY0iYLSBA6GjuXJtudAsjHCgXy9JbF2V819G5j5aUb1hd0WSJKce5WmOD6SMSPF5b+AJaSv1QBn74p/lLhtZ5l9U/3CbMcjhh9NCtcv/ViL6xNQsNJsgROxt2UwyBE0RxPEObKWtLqzfkDikJwMC9xg9HVqehxsrVnrWmN7FPKXpbh03PntWEJx1PsBoJ0RM83jjD4r4jQjmO2VssCuj/9gqb9sEKYluUpf750Emldau2I99RmZzhMpgF6jWZrSsacQKQe+/UFxm7D2GrFq/F/9oYFG/i+l32RE/OidzUyCJNBfv+igSy8CvhrCij24EFgAZCzpokLuAGUaDOGr+bG4BVP6CTkAOkePCvQzUfT7NJ5o3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Eb6WNq5rkX7d4Qv7Z0RMcftRyKMEhpRSI/EpgV16zZx5t4bzPq06dcTuUUqfRekL4bp/mtGGGXf0wUATjqmxHPHmiJa/tLihW1dasBcklbj9VciazLHivY5I2EOdE1eXjB786ykfCAcsbEu/SJ7KEnVvGOjE83dVtNhmeX93A0dai8WiUP63F2ZbuKktzlvOfiLmsjOPLflQhS5SQsIelh+yoit93HbB1UHCoN+c5ZH/5ktafMlwsDAa3YL2egfSkFJfoZXot4pytNI8FaEgqCZ8s/hbqubrzAFm+mm/tSExzzM00bJQRVcXsgPE35aJbGVb9Ej/yY5fk4KHLKn9Z7VTNzUKbeoChmK3a75QkXQix7aHzg+dkGfOrd5ePtzUmiD51YRzpHkXIHFMFV1wDHbAxxJDOBr87yFkeLy7f58LtW9J5EFap34gasGxmFEm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:12.3497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e47696c3-bef2-47c0-ccf8-08def691393f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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

From: Sonny Jiang <sonny.jiang@amd.com>

Enable JPEG 5_0_2 doorbell

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 059b6b927251..341577db7d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -162,7 +162,7 @@ static int jpeg_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-			ring->use_doorbell = false;
+			ring->use_doorbell = true;
 			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
 			ring->doorbell_index =
 				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-- 
2.43.0

