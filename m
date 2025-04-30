Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485DCC369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 02:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6786710E255;
	Wed, 30 Apr 2025 02:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T59qWpkE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E308A10E255
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 02:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9slQWgemSHxv2+2pUxWKTGW4JdAAce2AwklZF5n/Zuiw7CfPLlYLKPAWaPUvcLg4N3Iqf1JlAVoJLQoYk2lcKflOh8cWuY3QBy1JSBvn+oAxP+ltCCeROaUI0nrTImw/dhbKeXZ3VW1CZlWRw2ruybsgnwh3hBQgg6HOWletDtOfPf5oaCHivU21gcw/e1zOew5ltnufmMvZA9rt9immcq9hOCYn/xewG34WgAI+9AxwKNLinTluWybs9WsrUGk6E9H50kBRsE1vkd1eXdmibJwe/jS1urXMt2Kw+yxDr3Xp/1jaS/b+7H0qFa0K2pH5zlM1V6pcBDoDgLemWR3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B8hZyIwHPHBAqPfq8d1jtFb/nuNAYJhi4CIXrG3V3Y=;
 b=Z8Cssdh4pethY9xZvnWz7RTnaTx1su5ErZhoMMFNM6PTepGEwUjugAJXIQ89UYprCCe/EXsx9XyBmT7RN3c3/0V83Kjn6e1jJowInge8nGeBRPsRjMIYWNLJECGAEuzfIFGgZ9MknMknpehqx7bEXZCPA2chP8Zu6TLvamWgRo8IlugQq9xrhhRqobzk4ZN8H0PjNoyJOQpWIwkhgRp4NMvuuJOE7mG5qD80ki14AkdcDzUbHx19HeO49C6UD/pRsAC/8tO0TuJ0ck/vs61BboGIN5Lf/89hVbC4E4LScKlaxetYejUt/1TXOMXcYD/dvVn3FIwgLO+bZ909hO1lCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B8hZyIwHPHBAqPfq8d1jtFb/nuNAYJhi4CIXrG3V3Y=;
 b=T59qWpkERIZsfYaWgU2f8qSIEf7+3r9rFSf6zZrxkIW/wJeqsOD3Mf1sqBSWrgEPjEYtttfeNrEnt3BhjJzDDvud3Kni2FLt62rjJLk/hLM5RwaoWZ6UlqgjBqKGa4wTiF8cLEDXc5K9aACbs4fRPG7wlHeoWpuEDTkKsEcnOy8=
Received: from BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 30 Apr
 2025 02:41:06 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::c3) by BL1PR13CA0352.outlook.office365.com
 (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.12 via Frontend Transport; Wed,
 30 Apr 2025 02:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 02:41:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 21:41:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 1/5] drm/amdgpu: promote the implicit sync to the dependent
 read fences
Date: Wed, 30 Apr 2025 10:40:50 +0800
Message-ID: <20250430024054.4093239-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d397fd7-a441-4770-09b7-08dd87907500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YgrnjiBbPpfuY/dWzLK7M3K0ub/PExS/3Qu65Lz25ls45oaiSxgqt6sJqWE4?=
 =?us-ascii?Q?SdD5oWORvSL1M29kRy3q3ZnovzdStaNGL7GZzes/huYzIe38cIQFGnHHNFLD?=
 =?us-ascii?Q?WmmwCCivtqNbA7pRmZhPqpQB9dn1aCuKz0WYxx2goPCVp2thsrncI0e6tzmI?=
 =?us-ascii?Q?1qLA4XrdUWl+fbsm3f/i3ky2NjywYPupyg3mz4su3CjflGh5EIwpqYlaXp5Z?=
 =?us-ascii?Q?HonIOLQg+RsMgzbjc8sgKl3OCLZCRdj78HEab5dhNP0fdL2i+0cAX1LdayyM?=
 =?us-ascii?Q?u70EYG9oyP+4+rFWhadEiFzXG96OeSneAr4Kl/GxF/gol7wUCexkqTMuaxX3?=
 =?us-ascii?Q?UGIbIKPcP/WYaFmSOPRbN8kUMH9q0bv6D1mtkiXi3bbOPFPj2zajflXL3dnf?=
 =?us-ascii?Q?zdvZKnq87kiXSsNaWE3RBm13uKIefltVO4s9tSnLzcqBwCF/E2e9iTxvc5nx?=
 =?us-ascii?Q?7iagBmekmuFnlmJQROSi9xuEDkVRDOtfgfFUolJBX4vWwcgpq4FHyJhOHzsd?=
 =?us-ascii?Q?76OXUE//+BLrHqVoPoXy3qvCuOV3GguHwGeUvbaf/X3MltTWfKYZS4ew5M+c?=
 =?us-ascii?Q?WpDAV7Qvs55n3jUeUtmh+yQHIeA6xNIQ1tZqQn7XItkkT30h88Z5sMcxXImj?=
 =?us-ascii?Q?S9hT1zA+GB1GY5fC+qIjSiAE1M1Fn0oI3GrRPOkavBDy3ENjgQR8joy3xvm6?=
 =?us-ascii?Q?4GJzVB1Xc9z5OJuhdEUcar08uUvzYdCjG1jt9m4FImnq81ceV9wvrScvmnKB?=
 =?us-ascii?Q?m+HNtLp867G3wCFct/B6k9O+FZYgp0Bc1wStLb7lK5DYYe4LL7kn5AgDjwuX?=
 =?us-ascii?Q?FwKz9KDI654FlaWntE/YFF1EWs287XoG5hECJEB9fHtxlty5MclTajpYWnV5?=
 =?us-ascii?Q?8F+N6bZmhbqggEX8YSK5TTwX328MkmaiWnmu+Db8Bc39y2PfaHOPbD/vlxe8?=
 =?us-ascii?Q?jGqGhvgjgN/wyx3MiH9vbXEgwLVEGAyKEPoqytcxqsnbpGc3lhfdezleuQcm?=
 =?us-ascii?Q?BLZO2+2YMyLO8VPxsKEImS/rRnaFJnKb+cmtJfwcEo5G8JJMTL87v7Abqdcz?=
 =?us-ascii?Q?8lHlxI1Xxs1GeKwTQEu8s+28LAAfZ/wYlPQZDE0A90sZAiklV/a6tL7BIAwp?=
 =?us-ascii?Q?WSHXbkzzbdXTmJTQFzd1X17AAza+/hYxi+4QsuiBZmImSxMkvdGQW3ci2BNp?=
 =?us-ascii?Q?32mWinHryGERDq/MrjK6U8mlB9O8/zFl9YllAKqn0L3ukGRDRou7D0n8bCag?=
 =?us-ascii?Q?M/w2TbmUqwatH/f6LHr49IlGSGLRHLHv0xBLqvIhbcwdfoenq/WMK1T0E88n?=
 =?us-ascii?Q?QfSGG9P69KkfoKBbDI2b05N9RYbw9dm0MHxlyrbuNtwqYpnEoXer4vOrcLuq?=
 =?us-ascii?Q?b/AELYesUc63Oq6D3sltrXgytP3w+9IspjKG6KEUlF6u6UUvG9N00/oeO/04?=
 =?us-ascii?Q?fUke1eVIVDiutPLEM5sH/udLRhae24CimKcDq8ut67yYmYBHQ2CgSm6GV03q?=
 =?us-ascii?Q?TeokI1c9awDLKpYaknZcgovS0gQZhXWQW5df?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:41:06.4026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d397fd7-a441-4770-09b7-08dd87907500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777
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

The driver doesn't want to implicitly sync on the DMA_RESV_USAGE_BOOKKEEP
usage fences, and the BOOKEEP fences should be synced explicitly. So, as
the VM implicit syncing only need to return and sync the dependent read
fences.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 5576ed0b508f..d6ae9974c952 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 
 	if (resv == NULL)
 		return -EINVAL;
-
-	/* TODO: Use DMA_RESV_USAGE_READ here */
-	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
+	/* Implicitly sync only to KERNEL, WRITE and READ */
+	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
 		dma_fence_chain_for_each(f, f) {
 			struct dma_fence *tmp = dma_fence_chain_contained(f);
 
-- 
2.34.1

