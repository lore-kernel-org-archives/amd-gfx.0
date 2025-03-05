Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0626C282D3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 06:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4866E10E6F6;
	Wed,  5 Mar 2025 06:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZOW2fZBr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C7010E6F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 06:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsMd2epiAO+9xSfH2p3gVxl39n7VuTBgEHsPctuKUViiy0MmivJgxFztoPFj7DKhbv6qckhTi+oD/QeB2gA9KGVrBkO0YrtGB9dQh//jM4CTy3SdNr6gMzkWxu24WCCgKd1JankjrClGg+IMs+C+xmIbjfO2uOtZB3sKbIXFM7YuD5K0RrmgMglkrN8JP12p7Apv5fDzn0iS9pc3AK4HIzkmAAJoL67YNNAvteTDqBXpoAG+7tEI+Nm0NJ/Hltd2tG5ASomxsbEBLlLGH7tUUXNk8eSBqDoNUbzIEN39Wco90g4jOP2y6EgpMvDWe9HZD2p1m6F43yCfJ2gCuGnfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS5cL45j9hXOm14S0xusxLSbI1uo8wJSfzR1ICEIIrs=;
 b=KM7wMT3nP+/sTgxicRZjyPpOWSP44cBB3ui0fGmMkgwbsKDYbqXlouUGj9OQLKzliNN9+BDCTfiyqTj2xOChw5BEhuZtQ7nmd0W1tddTGqqEs7Yk551wZUEm3X4iYNdxNyCEl4dH1pE6wU+zyiFz3jpF6JHXc+lKAx0vPwudxXoBXAfOojysttfMcpcyXSzdwDhosmLFOwGMNgqftduUtdOO0lv+xi9UM3DzPsP6Rtn9hZCT7/RMtZiXRj7XiME/eMJeXHybKZK1l2GZMnIL6kaWJOrsbigrtzxkDKe9WLK584zcB949HSL21wG7ZJFOwbZlENOPRI3tOKsVNrmcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS5cL45j9hXOm14S0xusxLSbI1uo8wJSfzR1ICEIIrs=;
 b=ZOW2fZBrPKgixQlNSRiXN/b/hoEbnEoGYFIuNX4GJ9zloscKAInc+nBzlR9ju25zMjKvKmfIQycEvYmrTYn6i4wgb+2pXtDRlL9KjyS0ly0YdGLShqYfLi8d+5FY9ZxLomVi91m3eKCmvszUMRkiqvMiQsNIXNk1Wlw/c5NuDm0=
Received: from SN7PR04CA0231.namprd04.prod.outlook.com (2603:10b6:806:127::26)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 06:44:58 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::c2) by SN7PR04CA0231.outlook.office365.com
 (2603:10b6:806:127::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 06:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 06:44:56 +0000
Received: from codemachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 00:44:54 -0600
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <le.ma@amd.com>, <Hawking.Zhang@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix the gb_addr_config_fields init value
 mismatch
Date: Wed, 5 Mar 2025 14:44:35 +0800
Message-ID: <20250305064435.3658987-2-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305064435.3658987-1-shiwu.zhang@amd.com>
References: <20250305064435.3658987-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 6484ea14-13cc-4545-0acd-08dd5bb13e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OZLd9/Z6b13aWJXT7ikWSJK9P9pABxESerGN4+MNy5pWcR+LQCHHppj4kC7K?=
 =?us-ascii?Q?mcIeJI3Z+FXGUYaxlYycjGROcjy+jbj6zyoaHk0DYvMDWTLqb5G12qpg2ANO?=
 =?us-ascii?Q?PfmB3k9RnaEFzb4i3v3wSm8vjNmfo2Asi79buYcTGI2Bt/7ihzL7Rg5Jb2rp?=
 =?us-ascii?Q?z6KmYpTCKE6UZvi/0s5bPS7YjZC3Xu/2AZgx76ygaUae7e5kUanI90y4uXfv?=
 =?us-ascii?Q?l4lykym1DKY/elcZ5/MwRbC9cfjHdd+8WhfqMezV1TzFdySELsuNMUqFE5II?=
 =?us-ascii?Q?8F+2z4teyYPy6nCjzmHSO5StTTQoMckqik1r2m6YeOG9amBgrlm2XrrgBLZP?=
 =?us-ascii?Q?J0YuIgwdcjGXbb2x+mcMw2Uv2TPxIviVlWjFZ5t99wc8YWuB6j9lAGFIkAgi?=
 =?us-ascii?Q?wyf7eoS9kIWTE2Ott1nwHuMvXMVoN5S1qZaGF6HYj+xGXl+7Tnb8boehy6Uu?=
 =?us-ascii?Q?Kp5Pgd/LN88Dul9C/ITOu81rodcscvR94pFptc2hz4RT1sh5aNNAlhkaMUF7?=
 =?us-ascii?Q?ZtUC2WYNANjClS7DQdvHu42+luajPK4J+qVIMgZww/fTo7UhHNkZyRhVLdPY?=
 =?us-ascii?Q?8b4tazvEb0WifvA1LZsC2kDPlut2N4qAaTO2R9M2e6uYO+yZ7dFWLj7uuesA?=
 =?us-ascii?Q?PzwBM9k8fymE/+WOYJjgWvguVgQDZeunBasxF2N/BzdAzQWT25W7Q9polsvq?=
 =?us-ascii?Q?JFOzRIc+wfN7VdAxYlUGBgEE18d+PaQJtkO7yUdg5Fkmca6Z7mm+u8NIa4l2?=
 =?us-ascii?Q?SL5cwWMlk0ykS09PsdH4oNoEpkzvUKwjVPKKzSZEpGNxPvz8fr+z4ecJXiRJ?=
 =?us-ascii?Q?MZC4R9M2qQO8z7jf78HDZOLnbrtlZPul+Rm1EGdcuHgjt5ycxkonoSWN7eVn?=
 =?us-ascii?Q?ayqnJhuJ0TUaSnpKSj/Heafxf6AZqJ8I1mBURE/tI319fafo4byRkn1PNiVB?=
 =?us-ascii?Q?2YQkElYgxsZmb+04Qk2lQ/VioQ3cF88rruZVq+5sQCO/Q3jMgz9TVBjlZuPG?=
 =?us-ascii?Q?2WF6OU/gLoCk1F8EfqyQIaHpRccTMY+MAfV0I/pcg89fpUvZR58RBqleTxU8?=
 =?us-ascii?Q?Cq/2BtM9THrfM6YTbiacSYAJ1kkSR4+GEOvg7vftkCulZ16ln4NSPQuViYs6?=
 =?us-ascii?Q?wV0YlwnvZLkXcPvter7V7bBD6cIsIOMJb7UgcovpBAR+Qc3BVCM1bkUN9U/B?=
 =?us-ascii?Q?PohV87OcekBt2PNFmyBz+/Uve8yAADNAjxS0w0FLOWDKHrfATDOgne0atz4i?=
 =?us-ascii?Q?9iacBjIWIIfRDcoST9tTMImrG/QhofYZu69ewo3gzGxcW4hgO6kJB5pLXljv?=
 =?us-ascii?Q?fsn81iwTyXCiVB35kQczdA1MQu8lIBAD0bMZi4EOU+Y+bGdJjF/Rqjo7gPFe?=
 =?us-ascii?Q?ctfEfvTlyAIrdwuhCGh4yaxWSNkBq8VdzopJ+UqfZ2GdUc8VKJHUa/EwfTYv?=
 =?us-ascii?Q?a88FOOreYxCg63PC4pPVss8b2Wo4+JYF9+bwYTNXolzo2xDE04n8X6W0sSxp?=
 =?us-ascii?Q?65mnz6NG29z7SXc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 06:44:56.6044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6484ea14-13cc-4545-0acd-08dd5bb13e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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

For gfx_v9_4_3 specifically, before regGB_ADDR_CONFIG is overwritten
in gfx hw_init it is read out to popluate the gb_addr_config_fields
in the sw_init stage, which causes mismatch.

Fix it temporarily by using the golden value in sw_init as well.
The final fix should be by vBIOS/IFWI.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2705f0cdd6da..af9b784eb78d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -918,8 +918,6 @@ static const struct aca_info gfx_v9_4_3_aca_info = {
 
 static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 {
-	u32 gb_addr_config;
-
 	adev->gfx.funcs = &gfx_v9_4_3_gfx_funcs;
 	adev->gfx.ras = &gfx_v9_4_3_ras;
 
@@ -928,9 +926,7 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 	adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
 	adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
 	adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
-	gb_addr_config = RREG32_SOC15(GC, GET_INST(GC, 0), regGB_ADDR_CONFIG);
-
-	adev->gfx.config.gb_addr_config = gb_addr_config;
+	adev->gfx.config.gb_addr_config = GOLDEN_GB_ADDR_CONFIG;
 
 	adev->gfx.config.gb_addr_config_fields.num_pipes = 1 <<
 			REG_GET_FIELD(
-- 
2.34.1

