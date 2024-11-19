Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034BBD591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EFA10E5BC;
	Tue, 19 Nov 2024 06:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f9LLDssC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A79410E5BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGeFaNZ/VrWY1kk/8I8j/SEhEVYOm6FQkMI0knPEhwlW6COpH96IfxI0PsUbZHSRnFJYmjG4OquiuyXciDkVgbH/VDUFrIubG1YtiHVn+dL5BTCtPyoLPtTHMzr3UK1w2LlYExCvONEhXMnwcVQ/1r7NhY1JUsBLxmcDoESd9W0TAUhS4APYrZuedK8zjpZWNLflt1/oWtfezUOLT3f4vlD+HEbrKy/n/glVz4Zr+xepVMugxTN/2KY9HG3Hf7UmhgtMc66c9bdJHI0juwsH5o8TTJPqpu1dGxWd3JZZXTy2g+2bB9LZcQB1y15oFyT2Do/WCPoJwXt63ENUabQMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RNaLBf5leA3uQVvmKcooZr3Xa7CfPbWDx0DEjeFwcI=;
 b=VrBhsycg9nY6P/mlLeYkv0OlLuTEEWECHVz4YF1IIiCd533yQdIaCUDogq9cdJBjKaQrVy7yM9NU+NE97Kj6OUWU0Aewxmg25ObH1OrmC5vWfR12hb5lVgadk+KaJXzwOLApZTcr8Rm3JnB5GVHQZMyUBjIFRGR/8UfnojRxHWtHwS33Xuzy7nMtR+8S9njXg+qpah+hM4ydt1NICy4Fwg9SYDBPXbwOXH1gyhGPKTvgOhSyhRDeNojn3GZaFRFtOWe9cpIS2iJz5lNezWkapYHcYCAsuBUgO0kS/CRQBPhwud23vm7Fv0z1TXqe+BNeni9N7JohmLRM7YWgJICvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RNaLBf5leA3uQVvmKcooZr3Xa7CfPbWDx0DEjeFwcI=;
 b=f9LLDssCZ2QqTIHN2BMOpAyQ0BsuOiLT+DcYRKTUJbjw/dZniB1p4Bp43p2/eJzwAIBVjOzShFBTwrafY2ZrlchRQZuZQY0+GDj/jsHmvJBO0TwqhPS9/i4C5d6N9Wvzjorb4m10h6KVtNl2/Ab0lRn7r7H9biOYJJ/Ve6Oq/8A=
Received: from SJ0PR05CA0171.namprd05.prod.outlook.com (2603:10b6:a03:339::26)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:36:07 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::42) by SJ0PR05CA0171.outlook.office365.com
 (2603:10b6:a03:339::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:05 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 19 Nov 2024 00:36:04 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: disable pcie speed switching on Intel platform
 for smu v14.0.2/3
Date: Tue, 19 Nov 2024 14:36:01 +0800
Message-ID: <20241119063601.437225-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d51ee38-25fd-4242-af7b-08dd086472c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g127b9C6SNB1vPqxsfm9XeyKTvNl+kfg4/R+roYynqj3S11odTpEK0z/FWFO?=
 =?us-ascii?Q?SX86XhA9KIMTNDhfGZiZbvOaKqYkoDfRwyjSe3Oz1+XJCGQgNBlGR3hcq9MW?=
 =?us-ascii?Q?81upnTY9MBU7+CGrgT21KUerJZTR7olX/DzUhafqN6RuZkV9/X2Z+QrfgaXR?=
 =?us-ascii?Q?2Z/FeVcDsHCvN+c+3FN4TqbcAUflc+XnfS7VKsQJqcruHtdK4bDY8rxT3lmn?=
 =?us-ascii?Q?tqEROGnuYUiVMiRmB8JPXis/DmgSirK52xnDzA/4Yv5Sdu8pnpOJkqopfiFP?=
 =?us-ascii?Q?/CswyMR6EL9EMh4PU+T/bxBkmnVYa01fc6KDnOSBjuq4fY68UqEmbU3POkba?=
 =?us-ascii?Q?LNLgt6UTbYBhaa+3fpXw8jPZJwDdl6oDKQ3rHG66ZxdfzxMAivrOKLHtWjqL?=
 =?us-ascii?Q?MfMTyBpsDZBtD3334goUT+BVj+77ggpzN4M564GWcwLjSyh9l0+26HzORAzM?=
 =?us-ascii?Q?iS0oMDgEkPLysTRQkCRHIQYHGiJWqUNVVeOTvaH452LqYoSWW66E6BRym8Ma?=
 =?us-ascii?Q?N0ZUHxETmKF0WD37g4QHjNLFq9jgfxiaHzS2qpfzJQ0BJHB81XrONWcuWQ5Q?=
 =?us-ascii?Q?8h89ok5liBRkjGNgmL6fjuXbzjga+ov8N6d5N6hAkqQw6tATpWqz80vPLpBP?=
 =?us-ascii?Q?EZxLTCUKbPeoKcTuh4g0itYWgky9LCtdxZ/xKOceKgOzLbZekz35uqpu1QIY?=
 =?us-ascii?Q?pZsum/4QV4MvGz7PQ81NnEo27ZqJ+1Q7nL+iPx2CJEu4xTXFKRzh4uIqjB7v?=
 =?us-ascii?Q?QbIE2Ojq7fSjjnWC1GYoQd0sT31rea8/t+9H2mRFqz1uE1Iu4fjno1X5Rkf3?=
 =?us-ascii?Q?IJYa9CVnlnGQIL370WPx+XwrRSZEujx3mbEOK8HhhOxqJdlsDDlpZh/6rjWl?=
 =?us-ascii?Q?U6zjcsGMkaricJIl78ZFFzMKdNFjzt3hr0TRC1+/XdyQxwwGb786DhRD3Ixs?=
 =?us-ascii?Q?IGtEY5bdSdMJFqUdPjURjZ5ARQzkRkX++qk5lTTufRfG6v29GOJyflCXaoo/?=
 =?us-ascii?Q?B86wLtrWLRZdVrBr4L/PDjNOLJobS9bIkqZfG7HmkCGU1d+dO7QG4REc8mqJ?=
 =?us-ascii?Q?0+hx5mdzm2TmFMB3SNWwjYY06cYKvYNa8QozVEVJWAiBgbebZKDAFcDrzAEy?=
 =?us-ascii?Q?Dwy4AB7L2Tl/CvK4vWYkOBHaJBYHkWx/8DpBx/W14NLsR9Y0nlm3LGV2dT67?=
 =?us-ascii?Q?Jae2qVPfhzXj0Jy/b+lJJ0+31188S4u3q4PBc9p3/XaY8pzGIiGbT4HVXLOt?=
 =?us-ascii?Q?F1a0tOPoprwX2AhuVbwzt0QQyOxldQA5J2veNL1Ji5tCFUT9482DZzecP47u?=
 =?us-ascii?Q?55mOiVlTSUlhbA7Sd6iBL4oiIfBNDdiCLIi37XIgxcZcSiHG4zkicMMaJ7PS?=
 =?us-ascii?Q?LHUg8/Q0LCAVikh9CEOwtlPxOgWE3UwY3h7UlHmjEX+soTjo8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:07.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d51ee38-25fd-4242-af7b-08dd086472c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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

disable pcie speed switching on Intel platform for smu v14.0.2/3
based on Intel's requirement.
v2: align the setting with smu v13.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..342eabd08f0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1463,15 +1463,35 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 	struct smu_14_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_14_0_pcie_table *pcie_table =
 				&dpm_context->dpm_tables.pcie_table;
+	int num_of_levels = pcie_table->num_of_link_levels;
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+	if (!num_of_levels)
+		return 0;
+
+	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
+		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
+
+		if (pcie_table->pcie_lane[num_of_levels - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[num_of_levels - 1];
+
+		/* Force all levels to use the same settings */
+		for (i = 0; i < num_of_levels; i++) {
 			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
 			pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+	} else {
+		for (i = 0; i < num_of_levels; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] > pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+	}
 
+	for (i = 0; i < num_of_levels; i++) {
 		smu_pcie_arg = i << 16;
 		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 		smu_pcie_arg |= pcie_table->pcie_lane[i];
-- 
2.34.1

