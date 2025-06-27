Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807B5C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60A710E936;
	Fri, 27 Jun 2025 03:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VJ68yCQd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF5710E938
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vob8Kha/82MaYBch1VZ4C3iHWK67pMV+5mCZGkjwDZfk12n0eNiVMPj4Uj8VW5IVEvleRnouENI6/mVHdmgLRa2BWIjb1bBPDxBYXz5m2OrZujHutjQWI4UYIGWMwKA8Za+opf/1dUOIDiwlsS+pENq8CJ3DKrJAf04qOpXrCsKDCEwuWLpONWzRwzIbhKbE5V/9z2uAAIuUeRjVV5sjscwZbMM/kwzkD3rfecPX5FP5U+2zgVHkX31sbpU7/KiOUevVwLVSVTRet+/XGfUmDOwKZJVdVlhUHlRhtPbNRu6cMEsp1+J4vm6sG3FXLMtIVnMH9aIfoIa2hATLepTpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICUlD5sv6RBWEVruI79i9Dx6KOxCCQm2i4uoNmqEJTA=;
 b=SbgyrYlWctGqr6ONIfnnDfqbyyEEmksu7oRbg8aV7SXyK0DfyRwEY+ehrn7PoFxTgmD8PvdJHzxuzmjY1OWlYh0WaSRYbfJYU75G/6jHob+5Pjnron3CbXetuyJlzKkOF2+WonfxjwwQVRDZJ/XkL1RasS32HqUBR7/crZzbAOOAin9GeUyNtnw6JHfqRRT0y50UujedVYDSiraCQQVd1UJwfcFw/aInYeIX6QpBdY5GXMfb9+g15q1FmA3F7svMxSTT+s7JdodardTzoYinrTsJaoocHv9tk1pdN+7beLo9CL9QS6+hTNXxc9eIaepFk91yoLD5x+iIlVbViitPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICUlD5sv6RBWEVruI79i9Dx6KOxCCQm2i4uoNmqEJTA=;
 b=VJ68yCQdVaGeu913W6EU1mnkWDFRZ2RHBc6uqm6xuc+8cs2FgO966POWLWsEN3DXasm0FO4WYTYhr6oUL/uCwOMX3JRfXtkYKGkEjQh9RjAlROiJMlxvWOKCY02SnTLrnDeLvNcxym2MHX1KyF8yPxiUs7wjQn5n2/Q/v/p3mKo=
Received: from MN2PR15CA0056.namprd15.prod.outlook.com (2603:10b6:208:237::25)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 03:40:22 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::1f) by MN2PR15CA0056.outlook.office365.com
 (2603:10b6:208:237::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 03:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/33] drm/amdgpu/gfx10: fix KGQ reset sequence
Date: Thu, 26 Jun 2025 23:39:30 -0400
Message-ID: <20250627034002.5590-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ec3992-d7e6-472d-b95d-08ddb52c5840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DHLkkxFyVs8j9l/h7L8P/XJM4BVf+81F42FSgL6v+Wa68VkpprKngm2pfUiK?=
 =?us-ascii?Q?zslM1HT9ZXdi2FifvWXG/th49J5lbM4sCGrhhVlZBQyYm6zTLxZGD+8VUkar?=
 =?us-ascii?Q?4XtooBuTzmqjxDFqZx01E4jfPg0a9jthzEI6243FzVOWW2l/rncYAihibQNd?=
 =?us-ascii?Q?tRa+7+onIYg/uz+aveo9854WlJicGcEVUKLdGnpVNoKpdtAeegNe2P2cWclK?=
 =?us-ascii?Q?D9Kk+AgrH2b5+6DldbGOUol+jvlNDoo+2eXXlv5BrrLz9HL2e01k54uh80uG?=
 =?us-ascii?Q?M+zFES1Kf3m61ZeeTJDuagnBhh5KqRq6SWqsLTiVItmbfcKVBADjNaf9yo87?=
 =?us-ascii?Q?5u2GTdn0EOafRPZsoPMOKZYVq9ZSPaV2+9YYXIZlImLGMvbpcofwKnHsOXgF?=
 =?us-ascii?Q?HaXxIUPgJ9yB8PaN1D4SP3o+wOKX1I+IFt7wgWpWeCPkd9j4DFpKPqAFBtJ7?=
 =?us-ascii?Q?4HX5SYOPjkOf3HKUwsrzLjxH/iZaEKz7fIDMNsfbmlU4l3oCoTmjQCrMywby?=
 =?us-ascii?Q?FzHxQDjYIf7olIJu66rQm+9AblAzp27R6kOpFZC/76Qt84wtsjEnRU2X/d/f?=
 =?us-ascii?Q?t4f2UlH8PRO3PRci6r28vGXIp8tdWL5sjmRp9hW8MuYDSqYuJ2fR1tSgxMuA?=
 =?us-ascii?Q?uM175n6bU1EGSYS7B0aoW0MJf7c5pXC2yY4jeoQiUIKZmCPiX7kbK9P+Xdsq?=
 =?us-ascii?Q?brPYO0KxODLEut73ga8sdDApPyyEj2hsFrvRAIOV/863NCXHoEqGkvu/oSqP?=
 =?us-ascii?Q?nVd9xvq9R0dkw1LjX69iU6OCnFtfKXQM5rmFSuAwwpV3VBM1m8dB7/12PK/s?=
 =?us-ascii?Q?shgeL7Wh557FFbF1mAiKMOTewfopbWGlFe3MKaOqvPZXmH3aeuu4NMdoKvsL?=
 =?us-ascii?Q?/ycKB0dGAFN4VomyDJblGT/p0QwEELKb/fa+1ctcH8QzfZbV3oJXgrZNbGeb?=
 =?us-ascii?Q?CX+SH8fk4NsrfoNLhptezWgezesYmYQrzTqhgW2sUX1zaUQWcuSrhirjYYEj?=
 =?us-ascii?Q?GEBt00kZJWSETJGYOZMygMytkqcGbsWk+/SKYpfEAOsF1U09GJylRcTElQ6H?=
 =?us-ascii?Q?EPBqjFfkIhwe0X6zOXKZlzU25hw7Mrw1ntRv7WI5n1CrUNwCX5GtlYxQgmyk?=
 =?us-ascii?Q?MU7Hj8JvoyvjBMvDpFoan7xqU9izTpB+GThQuYnhvvivZAwtxNP1gVUNxOiZ?=
 =?us-ascii?Q?pXi53rI1rgp0PBFs7cmtPR3R2IcaGgWd7quMBGeJTHRN2vgXOXACbnYbF0MM?=
 =?us-ascii?Q?PQPHlahD+3yuOxzJArN7ulCmN5aWHBGxUReb91sb6/PvngGsPMOfBjHbqPoL?=
 =?us-ascii?Q?ErAclp21W3kQsXwfGe/Hw320g7VodWmt+3XBDsIYQkRTUMTB87cph3gdYlxu?=
 =?us-ascii?Q?KgQaZuyBI0KvEjRFDuFrcr3yygwf4ENFyRRcb9LgaAhUkJkwIQWlkzrDCmO0?=
 =?us-ascii?Q?RgC+cp2MqVLL+C4ToLWlCvNXL1pLU8eDoERWQl5abQGhoVmU8RcwJXasaks2?=
 =?us-ascii?Q?Wbl1WLvmI0zp3R2TiOqjJVzyUQW0cV8zcPlp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:21.9862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ec3992-d7e6-472d-b95d-08ddb52c5840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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

Need to reinit the ring before remapping it and all of
the KIQ handling needs to be within the kiq lock.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8c377ecbb8a75..5e099b5dc9a3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9544,7 +9544,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
-	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
+	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		return -ENOMEM;
 	}
@@ -9564,12 +9564,9 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 			       0, 1, 0x20);
 	gfx_v10_0_ring_emit_reg_wait(kiq_ring,
 				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
-	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9579,6 +9576,19 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+	kiq->pmf->kiq_map_queues(kiq_ring, ring);
+	amdgpu_ring_commit(kiq_ring);
+	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	if (r)
+		return r;
+
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-- 
2.50.0

