Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5043C369D5
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Apr 2025 07:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C3A10E361;
	Sun, 27 Apr 2025 07:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IGvtEC58";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D932010E0C7
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Apr 2025 07:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVuXpLxtFcFlMLsLTN1lfl0yEdjuSbamtw9lik25cLuescuqyHIU/Qzxmc7lS+XB5HJdlnezllAwP+tK88JkijxjCEBhIqQS3vc5xjGhaE7wTtznXwS/TdAXgyvl/+iSto1icjM8TQuD+j4S5uwFdtY9GFl7YowgerpGbyLlp7Ze/XbOjbI4t8xHL/AKwMvMv4zXNOSM0m+RbIB+QOC7a3GxIaIK1MSXPzNmLLltZisukJV6YH20/L1chIrVJPqZ8B5wrcCEEjs5fCmY3hktJv82ekAdFf29mKXaAJms5rkuWGx6TtljQ5C8V2MBfPr/FMCi7FXZR3Aso2m+2fVKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCug5+p/4qwW4JfZKQBCylJ/lZNEOxFAVk9Z3e72Sdk=;
 b=s01S/I10LBiG9IQHgyMfqzxpoYttKnbZX6dVpjguvdxrmXQ1sohqx+a+2CGQUeuldhodCgUO51z53t2v83nO14N2kPG4fq9xMYzHFTPxOCV4jD15V7Bjire6xdNIwRTP9l64Q9iNLEM+zSGV8aVUspt2hVgcH//QWp0taIkk0rN7SDhr+jf0lG69ah2hPQtexThThBSu6JNwJeymgzFHM+qNXY/zGzXSB/SfiXIP6IAlm76UQ7PbrrM9h1mvUSG9ChlT9UTCuMS6rZ3/GQ+2m/CeNsEetX5wDsAP1XeZOHJ4aGd0AOu8ki0iEjfBahSUrFZPbmHfdupv3DBgL0hYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCug5+p/4qwW4JfZKQBCylJ/lZNEOxFAVk9Z3e72Sdk=;
 b=IGvtEC58jMgu3sJ39zMiJiiG0Xd1lureG0yNt5V6G33tDEELBTl33KvxfxYT2SVfb6vuN33aPymdLPe+wz27VIiVK79qXgaySeYElb59t05Nr9JfFhPnAiCZ2sWr3RgTAIg2anYFwc/Y7uTDGa2OU67kZVCLmIiGaWw25m1WKnc=
Received: from BLAPR03CA0142.namprd03.prod.outlook.com (2603:10b6:208:32e::27)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 27 Apr
 2025 07:14:13 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::6) by BLAPR03CA0142.outlook.office365.com
 (2603:10b6:208:32e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sun,
 27 Apr 2025 07:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 07:14:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Apr
 2025 02:14:11 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: fix the eviction fence dereference
Date: Sun, 27 Apr 2025 15:14:00 +0800
Message-ID: <20250427071401.4047874-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427071401.4047874-1-Prike.Liang@amd.com>
References: <20250427071401.4047874-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 981bc9ad-bbe6-4414-9b08-08dd855b1cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U8DYii58yOsPr9wdyG5D8ykY3UMutoRXxS/9RZxGVQ3NfPEYY3GtOxCEH815?=
 =?us-ascii?Q?eef/tyU9rOqg89yyU/UrvGXb3HnH4RLhMRc2Wku1u+InIwkxDTxMTfv294PQ?=
 =?us-ascii?Q?vBtW4NiG+MiowLbdmK9aigsXwI8YL3BzPwD20zeBLDec5hD16jYTZFxWF+YY?=
 =?us-ascii?Q?w0wRi1CVT7+UiPLUdRNMgkzSQ/pxcODwTmi7gHfw3hmmPldMBfm/7pgrLb+c?=
 =?us-ascii?Q?zt6YJkY55No2PeytQD+59arvoHymuWFVBChJal2PRmcm1vR/JaQuZ1RY9Ymz?=
 =?us-ascii?Q?vVTkfxH3lz1VnfIeDPt8Q1Jx/1xiAS8SSSU0ppU/VM0F0G2+fPnw6zU4F+rb?=
 =?us-ascii?Q?ytrYZrpEfEOY0w329xNtoGjaOWqAUwtmPKjIU/XakN7At8vESwHxPvAFqZpz?=
 =?us-ascii?Q?avCtLFdO0PtrvIVhGl28cXL3Mol8TwUL5k0ZiP8RdnJUFdmOd8YpdFcsxwqI?=
 =?us-ascii?Q?FT34fV374KHaHH0v8XpntsUWwbnWopF0M58vgiLKo4ShuLtyTdZLOWtbp/8f?=
 =?us-ascii?Q?fm4HX/amp8rhHsuxZTDhfrUwRJzZj3DZPTove2hEB/Uz0UF036E3KVvOmb1o?=
 =?us-ascii?Q?6Onk7UHxDU4oV9FY5Z6f4NQ9oxNuz/QB8DMWbA5st8fwip9MzUDAqS18oq2h?=
 =?us-ascii?Q?phZ0Lz+ePyVOqGXlfXR1V8vtWabN0PCjvKGaWRSnRZDpKxSRBg87QZ/rciNt?=
 =?us-ascii?Q?z67OMPzAE+rCHkElzXL/Q7TQ9OZWp+41yJWY8NMBao2+mnyckQP4jAhPNBZx?=
 =?us-ascii?Q?8J41A0RLAPXp2yOW1K61rSpniU5WJKqoYfzpNA3pTDO6dtC5XrcOUF9QUcjZ?=
 =?us-ascii?Q?Krit2jdWKbR3Z1053cgFmHnxbm9v5hRJMSv6YkZqgB/hMlvSdzAspPoePXFo?=
 =?us-ascii?Q?3nylPnJKtWBxTC/THxAQWoa5PBm88gT45s1TCmMzNzgdfH2/wCffcA7pl4Yw?=
 =?us-ascii?Q?2kYR4JojOChQ8AIwzJfXB2pIRox9vng5EokmvhpKcGC/9YnncSqsu+r1LuQj?=
 =?us-ascii?Q?eOC/h6ghaD0snB47nTWZeCKsqNRf2PezPppgLeFRdmAxyU3+bOcU3NllboJv?=
 =?us-ascii?Q?cHAXQOIda9Tf2C2dqzu+HQ6VZluRsCd8dy2XNXRLsCl8svX+X5xfc1hDtxx1?=
 =?us-ascii?Q?rx3WxmS2bGTPb4Am6jYP5ZWSeS5apfA6DTD8bsxqLZwqZpbAjQyQjIbzD2ZB?=
 =?us-ascii?Q?JvY3jf7mlL/EFC/gKj68kUjrhK58QaIr9XD4NK2fr9vsT2hzmPqgcaDe/FmF?=
 =?us-ascii?Q?jpRKP6C76p03kLQDHP1Y7IkAIVTHxI76RTnhoVfVhVu00OHYrn1q961caGU4?=
 =?us-ascii?Q?wDtuYviJdj2RBGUqcr3jMLPTJfEtatA7ktLVyZCCOfGUs8FkrwreRATrVzqO?=
 =?us-ascii?Q?hcW2byd/3XXSedRWXzvudN3XiTyTe7qdEFordR7vS8M6xd10dZlxNXm6sBZi?=
 =?us-ascii?Q?JQs+TYuhXTKBkrF8Gzij0irIpG9SzPG7UAM3VMhz8nELmi9u/5/Ydz26zvWo?=
 =?us-ascii?Q?pOm1Lo4YG9Gh15xRdvMRl+V+u4TPvoJ4ZhF4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 07:14:13.0476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981bc9ad-bbe6-4414-9b08-08dd855b1cf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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

The dma_resv_add_fence() already refers to the added fence.
So when attaching the evciton fence to the gem bo, it needn't
refer to it anymore.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 6c9b2b43a929..7a5f02ef45a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -189,7 +189,6 @@ void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
 int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 				 struct amdgpu_bo *bo)
 {
-	struct dma_fence *ef;
 	struct amdgpu_eviction_fence *ev_fence;
 	struct dma_resv *resv = bo->tbo.base.resv;
 	int ret;
@@ -205,10 +204,8 @@ int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 
 	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
-	if (ev_fence) {
-		ef = dma_fence_get(&ev_fence->base);
-		dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
-	}
+	if (ev_fence)
+		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
 	spin_unlock(&evf_mgr->ev_fence_lock);
 
 	return 0;
-- 
2.34.1

