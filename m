Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0761C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 17:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A0410E146;
	Thu, 15 Aug 2024 17:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a91ekKiS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EC010E146
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 17:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAHSQWsunOCIWcWYICB+3ab+43jaWFyc9VA1EfMsJ8zxUEJ47q2/2y9OWvNPYKZpBP7mgBmNs1z39ttGQelbKlgX3w8FMbGTUvDeQeF4ZvxZFy24t8y2McoG6V4dgcpyZ4Qd3YIvnqCRKIDoF5CRWlRepIu+KMcYijuPUqohgyKW/dAWCeVquRvBZEhywX4K3OXq9C7thKcKGjSo29K8Mh6cacwoHktPOdNf8A0WYdsTFWYLe/MXW8QEALuae5g7SQYRMtXZluukpBna1BrUa+rZH3bL/5N2nzwTaU2vh7tXzIIwdIAPTmJzAYYRUXsb3bpjKVHxmBbWO7xODeUVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1Q5DREIelFE1vvGSJZANJCzkVSozVDiE0uubSshI7E=;
 b=d5eP+//GSTVdsrK6ZKM2DLDXdfufaoplpw7+tJP9Mzjc+dExxS+OGj1eFG0jT1H6g5Yr0NdBM9s9cOFP13CSHIx6BhZqFJ4dp9klwXtfBLk2U+zoidVrZq307a8AuLkG2aLK4ozvpvBjKTcpAaIn3e9jEv6LeXJ6D/3nDsuM01VyAEEn2YxlaCxNDoKb/U6FfwUD2GWVCFMAnQhXRfd40925jb48rABQoAGe9iwW96jrN6FgL3TvTwTLXTfiQ/oBamq9i4njkB9p6+dwC7JiwooU1Dosw5ng86brN6niSkz8eObJodsKXAahNgoGDvGWXKXG/FFcLBS1BVPI21XwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1Q5DREIelFE1vvGSJZANJCzkVSozVDiE0uubSshI7E=;
 b=a91ekKiSRaO4ygYwh2tetfpP6r253Wv1tSNd0LzwYvyc9b5+IvSuQYeSRnMcuNRBoUyY9htDg2h5Km33kJItJg72n6i59iEmLXWED0tsWXBRJ0PSrzZ1ejW5wlvSXRVWDIGfHyhLYfh25/gSXBpYPs2hA9344tq/Gp+PLP5Wibg=
Received: from SA0PR11CA0115.namprd11.prod.outlook.com (2603:10b6:806:d1::30)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 17:00:45 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::22) by SA0PR11CA0115.outlook.office365.com
 (2603:10b6:806:d1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Thu, 15 Aug 2024 17:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 17:00:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 12:00:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: return early in preempt_ib()
Date: Thu, 15 Aug 2024 13:00:29 -0400
Message-ID: <20240815170030.2582607-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a018449-94a6-494e-c5b6-08dcbd4bcdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VWhEZCROJmhvBRYbGPksiRh9MKbDQ6CY48DNRKoViSGKC4CYThONl/jaUC7t?=
 =?us-ascii?Q?h69Jx6PMugFiYeaFIkP8MTHFy0MTsfmzx0NL0epqJg+wLsKOWwd7ceJdHYBn?=
 =?us-ascii?Q?/T6n4Vtkq6H0SKfViqSJuNxgp4O2EcKXa22SiOCTXn76zNk6Oi4+E8ngNpxd?=
 =?us-ascii?Q?/L8sGTAUDw0IrT+vqIsIwgnd7UMg23bTeNf0gl8WW9i47BMl0hqJeRG8eV9N?=
 =?us-ascii?Q?fmRWMpmQ2jnuyUJsaCK9oK6hw/B66y843nCFqoA4xFQFjvtWs4HIZNUoruV7?=
 =?us-ascii?Q?vtlCIWyeYi8NcjxZxik+XrgJcEh3BQB6J7HR+De75Y0py8y1/KLeB5oO1f7n?=
 =?us-ascii?Q?FbL2BFCqIEe6uKdmhhP+L7I+v6PxLJDrPTi44AfNU6RuvA95z99MbDgUme+5?=
 =?us-ascii?Q?nm8lZ7z7U+eCJ17xlGvgLYysLmYiiu9Ik6+x+0SqgOOHuM+yB66iw3dVE4Hr?=
 =?us-ascii?Q?0TThh3VSeCuVAa643VtdF7LsRLvuE258uQ7Pxox7DVnz1VqSXpiaoP1ayHHj?=
 =?us-ascii?Q?nJ9uAZf8q5zoLcrw36tCV91j8OA/pQIvoBwfFTYry0sbJcjo50lSrm31VeV3?=
 =?us-ascii?Q?ue5Y31swK2BDYFS/yrIvIRHTuMchA5iiEiym3qRvbASfSc0gcYXnjX8wk+RV?=
 =?us-ascii?Q?3X32+lt097zx2EIpcVumRH5K9DRa2THiiOuvD5lKgaJnOgCm+r1XUTYK8j6g?=
 =?us-ascii?Q?dhOTSEHX/xtzQ73ctCOoJ6OnZskM8Y+BU/jb7TTF13TtqgWMuE9LfUe7w2iG?=
 =?us-ascii?Q?ZbSDe5/1x7NyB6I6pUYX6f1e9E28vj1jMpZY4eOkLk3eUvNllcyaRsLIGeg6?=
 =?us-ascii?Q?wIHoXk1BH459ae4br1831bWHoXN32a4UG1M3dR9eEeXHxYnfeREXc29oGjpj?=
 =?us-ascii?Q?w6MxvK6nkZRfl/d8WSn5tkDXIB/4jDjGsaAB/cSN3HiBWjeuLODycMCr9oee?=
 =?us-ascii?Q?D9d0/89CHTXYmAj7ShP/koZ0mixqrCpQvwGyiH0NBO6i0xQHDrC9m9e/epto?=
 =?us-ascii?Q?Pxm2YmLbnluR2DdGR0adgYAmV8T/2vY6+Eoca+fRM1eY/xopPsCHm5oUrBiN?=
 =?us-ascii?Q?92gAjULeVneTOYZ+ozGG5qohBVBDY6aivUkyQ0rpXS834TfQV2g1GL3dQgUO?=
 =?us-ascii?Q?BzTjJlns/VaxkNwq9PVc/R11RVOTdCRMzaT5j4s8qwA3IFpU33RDjqtq7fEf?=
 =?us-ascii?Q?6quoCcxlzeXT6X5hLZsIZF91L5CgL3ALYChWM2SWYbtdEDDnDQxMAwUeCnZQ?=
 =?us-ascii?Q?uev677/q03NVDs1q4UT8yWnmwSN1gB2B8skz28oxPZovGRxOUWUhLXN9SQ6f?=
 =?us-ascii?Q?r/oYQGMahYLVn6BH/QeqgNV86Myn90wirYHXwtUDabWoJH+3/suOv8jd43RG?=
 =?us-ascii?Q?ryXthB3l2Cs/ofhwoTE8iA4Q7Fr84F7is2jY5/MsQhtr92wmBCsNPKNTOgXr?=
 =?us-ascii?Q?V2Ri7WtSeSX9kBsFnor9/9cveFGoARpB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:00:45.2522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a018449-94a6-494e-c5b6-08dcbd4bcdd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

When MES is enabled KIQ is not available.  Return an error
when someone uses the debugfs preempt test interface in
that case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5685aee479df..5704ad25a49d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5924,6 +5924,9 @@ static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 
+	if (adev->enable_mes)
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-- 
2.46.0

