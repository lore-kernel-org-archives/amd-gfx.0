Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11656CD98E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50AF210E787;
	Mon, 15 Jun 2026 23:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TH43HLny";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA6810E780
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJnAYCG6SZBGQ1cGdy2OAGsfqYTRoTraHrnnZoFbg5RBBC4u/fXouoBWY33WbryapP9Yjt9T/DfIeNbpwzS/CPVWhzzO3gayCFya/k2g/1A56f5Ny0TSd+u280Q6CMYpdVc4q9XHS1MTKJA26utDIGyOj6jySsAyrosNhu9X6tYo4X3xLpMA8iydTWhmCOxVt+b8Pvqk8g0ZmjexD/u/Ro1dghnIvK06uiOtCmIZKcoNzTFR3pXZEDQqArA9eG3DSC/cHta6oJGreIxfkaXMeered3WLAeHaw6OirGqBxzTEp8NirbvhBQdzM6H4XfD1sYmCDGG0en8Jy+XpmTMwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz9mnZlpOynk4+MhbuLlVbhRvGcxLf+FD/nxlBEJvyU=;
 b=sUIdmaF7NBvkTAecSQgKaZhy48kA08QfMF8vVKFbCvzBa7RY3Q28VyT5wfV+qw0XzpF9nKxsMRf92Pvo9KDP+Luh93rQfHVWm68yJX074dLOfJTSc4MMU7FUW3UGA6Rvt5Il/nuELGVDgX+/Gt8IJoXOrnyhHAXsquOWhK8w7o1ctybBrBAcShbMVKhtEXRf5BkIlKD5Vw9wg62mSHO8Zg11Tj1QU2IoLUvPu6vfdk3qdwAW8hiewmfo1Uft5vNj/et+tt/bXflSBE8aJUQSpYCDkmzb3xDLyydm1Z2YcNDbLhuEURj9v0btEhVxIB9nvC9NMuVAMky+NQklAfgaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz9mnZlpOynk4+MhbuLlVbhRvGcxLf+FD/nxlBEJvyU=;
 b=TH43HLnyv3FKkjODYQIilyaGkG8/14VGBryWiLUsejvY7cyiKrvdF4Of8MbxPWBj2SKz/b3+b2eRLx4jbj+AGTWEN9Qq4OzsLfR/finG2j2QZVWc/6IjqyPY49RYBklz+P40FustK8vW4ZrqBhAfHtMO20+Jjm5TBKlPdI6PjKg=
Received: from CY5PR22CA0048.namprd22.prod.outlook.com (2603:10b6:930:1d::29)
 by CY3PR12MB9606.namprd12.prod.outlook.com (2603:10b6:930:102::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:13 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::22) by CY5PR22CA0048.outlook.office365.com
 (2603:10b6:930:1d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/43] drm/amdgpu/mes12.1: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:32 -0400
Message-ID: <20260615235645.737189-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CY3PR12MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: bb655c4c-f5cb-4106-c758-08decb39d244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DcRfEvGebjExev+PDAQJMMN+9E6ntdHYxNefjBie5rbdOvou4tWmpRc3wd1VepnvVHuIXrqt+u9Ekzk26LEtgdLYxA6QYcVH00F2ALH74G/Z+oJB3aT0o2DB4+JBHVAs+NdgbPyLO/4wF1rbCg5uo4lf7RsnHh4OMTLB4SvzI9QSyCbI7+9hAIKC+xNO+89lynJrzEl99VjqPzGAOHqT3MiRPU/Cwh8mxtjq96Xt//2vsIwu7xnADDADOhl2ESFr5RQvU1YSad7m7N0xzk3Q2tCXlxC8dA1noMls+AKQUkJfVXdWuYQC5NKDbDJd9Vl6iILj5JlDNJCqg2cLCJ+9C+ffP3pe8EpIiKLFtg1KJakPRZCJADmr+BYV+kQ3dRodni5IMv3R1XlrHGriX4oVg2sYwg16bHZkmgyb9xge03eQnORxXs2cD3ZIRk/2HXizxRui6BRhBEP7YLMKU9RYBTfksNTN0PnUKRwrDYEYAyTm2SO4l7gRqfvE09+eMbelytKNbJtEV5ImptcwQ+o4LHmjicSkkz9qEw5HZJujLw3uMkeN/XfI4jLwBd3PWMnaXPqwyQxeE3DSsjzl6yXztEEgYGNl9RKRTDlZX1+YRWADgc1lIMGIc1uxmVjiug5Wsu0CNfp6XPL3KFn0CNOXLcgjz3ZGcKzrsgLPK7SaYOpF31wELYckPP+tsgLz5eEKT/CHXHBAp3T9LJdbLxDE1aW61n/igFYTscus02YoKqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0IyWifBMNUtCa/PqKVO9n3U0eGh6/wFSjupiukN1QAW1pSGWOrFFJeaB2G8hrWty2qt5Y+orJLeVRJyXYw5pHEzPLYJDrGn53lrTp7cP00vBTd4UoMrCpvjwwSr6OfhZo/ty9DR8K9o5CnppCqt1GyCr7NDDQR20qcW7hxCdnHnNi1PxLgXwhpbIyrwTNsptFp+jc2DdOnEqDwXSnmx7O29lIVWyKaTpkVQCd9THvWHCgZv83Nv/iUAA+Pv1/HoaRc5YvIsxKPSReKCx4DvoHa6OGrjuJevOQyHBA137EmBbiw1MD4BwnlAOSe2ySkSGboODnLfKfr8B3s6oKJX6B4mZa8WCh0fxCFgH512P6BpqY9mkqYINa57V+ClwEWqvk78NEhZBCNtEXDlX10VUEeiRHHsrSK4bzv+kpv6mYqqKMNDj8/4T7Z1KCHgdrm+s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:13.4166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb655c4c-f5cb-4106-c758-08decb39d244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9606
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 8007a6e693055..12a2043f22c7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -62,7 +62,7 @@ static void mes_v12_1_ring_set_wptr(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG();
+		dev_warn(adev->dev, "mes_v12_1_ring_set_wptr() requires doorbell!\n");
 	}
 }
 
@@ -73,12 +73,16 @@ static u64 mes_v12_1_ring_get_rptr(struct amdgpu_ring *ring)
 
 static u64 mes_v12_1_ring_get_wptr(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "mes_v12_1_ring_get_wptr() requires doorbell!\n");
+		wptr = 0;
+
+	}
 	return wptr;
 }
 
@@ -279,7 +283,7 @@ static int convert_to_mes_queue_type(int queue_type)
 	else if (queue_type == AMDGPU_RING_TYPE_MES)
 		return MES_QUEUE_TYPE_SCHQ;
 	else
-		BUG();
+		WARN(1, "Invalid queue type %d\n", queue_type);
 	return -1;
 }
 
-- 
2.54.0

