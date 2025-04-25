Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F5BC369D7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAFF210E892;
	Fri, 25 Apr 2025 07:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TRRH6i+O";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A423810E892
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 07:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVfnVfTH1hP+dMj36fTziHbW9DfreNLHhtiop11Uy9Ju3BfZ78qKW8vBuBqOjG25M/ZSL+DKPDKNcrVvYEgqZXbuNcvX4RFLQbsy8mdw6NUl2LC8A8gE3eaAvolkOJBScoh85dKp+4GxikrrUAOou6KlR/iCjHqWqT2M+RWI8E9ixujj759iHi0s3po3AjQsXy/PVy7tdFQOEcQ1URKpAgSJIGaOtLBy3loIynU58yuDzvBUCJEKBlgrOY4Z1U6u2KBzvp0F7ZKhW9AsO7SvjKW5qYqWKRfcsuVXg+SPXTTZgNoTJg3P4///1fikN75PaA3R8ragErEPNJ2YkWmRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNbA/oLajwOOGmztN0dXIokQ9DEUCIDi+0yAHSogvQ4=;
 b=K2av31jYPtKOPw+Ijq8cq+QswvQ89W3OqJ0EYNKKb/5HgIYGMLZaJR8qH+z5R8zurph09EtNs/yFy4EbtBBx+0zyDPxUtRa/3zIhmM/DwrCvYTZnEZWtHNfQnjH8sKcx0DqyB2wXRtouLzoO7vQqEmamSd7yM0POx6WNYYOedMYkkgoso+czmkcPwkE5MxaqoBhBkcFqRAjHsQJBV8oGRvkQTDDMe2sPnWq6R7fjYTjV7f3BEIiTIQ92wEJ6/z0qmAyu/GG/u50hnXbnsivfAT15M/VK5gpSBdMx0+l43iRNTkoQMkaI8IUCvDmKkGks75cjnIbL3ShaPUki3dpXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNbA/oLajwOOGmztN0dXIokQ9DEUCIDi+0yAHSogvQ4=;
 b=TRRH6i+O5fKNh3reOvMAaaxP1CGuh5DQDbEmH8Lxt4L7JKxU3K1glfnYPEKK6s+C6xZjL6XoAYvHGKTy5x8i3M+h9ReUGJg/2oIqbdJQrvC2U2oSbJhyt11C1Fi1BG8ZC5wC0Ncrpe2B/vvliYyo+ysW8gwW6VfqVOSWXoSNBIA=
Received: from SJ0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:a03:331::14)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Fri, 25 Apr
 2025 07:07:45 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::26) by SJ0PR03CA0069.outlook.office365.com
 (2603:10b6:a03:331::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Fri,
 25 Apr 2025 07:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 07:07:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 02:07:41 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix the eviction fence dereference
Date: Fri, 25 Apr 2025 15:07:29 +0800
Message-ID: <20250425070730.4033803-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425070730.4033803-1-Prike.Liang@amd.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a479d70-4d06-404f-b3d5-08dd83c7e0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CdMNhSA0KyU/K0rzvDfiGPl8rhFfHB0NeXSQUqppjvMnyo3DE/l1CIwcobi6?=
 =?us-ascii?Q?cz0j7fXdQgaQdZ+Yf27n1QyJ0HDv6l+99fgXzs5Q9VHKAeaQ2vzcPnh5AZaV?=
 =?us-ascii?Q?3WtEhnS/0VmzuwTZzQ2nqlnfFx9F0hymzJuXN2sxOPNTRw36hZIY4Zy4gAb2?=
 =?us-ascii?Q?cM7mg/4Vki7Qu1NraHEppj9bcSPV/mTrXRAa7CmJSetBzZbHRuJ9ewvRxPA8?=
 =?us-ascii?Q?a0F57VBL2/M+3Onz4AI7VsJSnyyYuoA0pbDferuZbc+aqlKYSVcDy9XiY+13?=
 =?us-ascii?Q?kwsnLgys3lszGD7c4VVukW3L6X03n3K9i2nzD1ceqaRHE8qFOT6wiRcAttIh?=
 =?us-ascii?Q?DKbviSG6qU4Z5FfBz2J2rjX47zy/SGgAD89yr9ULFlsl8hK7MfTdUAr6H5w7?=
 =?us-ascii?Q?IykRpX8NUV8gRdGz0CXbBjf6ZGiEA9XEqMqpUMbXIk9m3mIxj+kNkmLO7Bdz?=
 =?us-ascii?Q?8wqppZ2+fOF1qRCAi7RdPV1x2EJItHMI/o3sC4Bcnnkkq78kylDtBC1gv8b3?=
 =?us-ascii?Q?/bSnSYazw3uJWqVLs315a2eEjv3gDdM4xgZLQElKw9fiJqb88yXNG/1JvGwg?=
 =?us-ascii?Q?BGywgtV39ydQ1HrwlW2+kJhP8OrY98QXA2vGWSxdSgM11SCfoX+K1vTPyilt?=
 =?us-ascii?Q?BuMf+FoMZkX5Nj/OPoI1Peh1CjXGyl5vQdOwXeTB1iDx8Rk9xCsPDQiAPT1e?=
 =?us-ascii?Q?MP0FU9GOZp2zLtbmY6J/WDHYbz1hwKJtHBrsbJOKzaO1UJ2aIQllctcj/g7a?=
 =?us-ascii?Q?k0S/S9elqE5ERLkvn5b4eOaFDE8Xpkpca9CZKkDezMeoIduCbw1NJTW6or/D?=
 =?us-ascii?Q?4yHQCQvZXpztou+zYc2rAlUz/9zxjEKUUu4iGdh2nRt+jGbe5WCfTknYbH6F?=
 =?us-ascii?Q?Prg4ZAozkokI8kjsiHlTdf7oc4vaCTLT+K86qQeRpRvgEE7OZuUAlCvIiT8e?=
 =?us-ascii?Q?ABZcr0HihFt+0uELIq9vJiFncnF1bIw6H0BtRZKe1EjW9a0bH26oy/olCZKD?=
 =?us-ascii?Q?vLvXDW4uPBuPr3C0z2ZKuHWSqUUhtbOtFTn9eQhv06jh0RWBFNELoebjU6rM?=
 =?us-ascii?Q?aUO7VPVdJpvgSpHG/eqRAi+UPpOqEgQ1dPCWEPSmgI0FLodl/dUT2COBT2u8?=
 =?us-ascii?Q?D9Gq4GocNDXUDDkNlmSZJL7tVuBKHZFYGLBbuHM/lnH1go9upPZUVl8BP7j5?=
 =?us-ascii?Q?/cB9bYUpCG1S1M9vipxFWuwPjC++jpbnwACjNtLpO/xF7Ohu6r6VmMpgye+b?=
 =?us-ascii?Q?UWytK7OFEHTZPWOEgCqoZsggLmYE1UyhA6IqmHj+Kcu9LjETe6SEFRQD9P13?=
 =?us-ascii?Q?Lchmt8wyFZlmp2nDPpfyYwsmFYE28mKfa9V49m7Jkq8qhlzRzfO/z1vE6WWv?=
 =?us-ascii?Q?VSK57iqMDVGuuDc8yDEY8sk3sX9PIgIErH1XK7awV1jMxBYnBq2hYLpkAaUK?=
 =?us-ascii?Q?QMUeHKt5VXPDCFeUzwXO6hoHo/9b0QxfbCYlcJ/ylo0zVTS/qSHSduuWtEnN?=
 =?us-ascii?Q?FNX2uo8/TTg18Oy6a012COlmnthz4kE7TvPL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 07:07:45.0673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a479d70-4d06-404f-b3d5-08dd83c7e0f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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
index 610f447ede9b..d2271c10498d 100644
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

