Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82420D0E6EC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA2710E42A;
	Tue, 25 Nov 2025 15:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qYo97Szb";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D35B10E42A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:09:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7RJL7CmIbzwGb+8hzTPvnfDtlH0POrV/MCuvI4gsaKFIdrsbXuwtVWJFoRNb1AyjQvkIDTyeIZ+7TPmk30pzrmcqwKEtihzbgEeSUrdxBq9JAfd9Put0zadSZOD9V/EhOrqtIUcBpFSlEIPFILbHbKgilKGWh9lf4EV9iA57hDq4PK3m6E/IstIN8U5qgWpma/LhHOCcb0GurTAOJ78/uSLHtuDop2y6nE98ovflNFjrgmpw4PnPqeKtwvKSZShsIu9OZB9YXJTfhbhDjPe0aMRMK/CAkDJRK2+Wd2HTaxhhX28Qk9/v3Bc9kI+GxTcnXWo81asamIoHCBg0Dcu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPTlTBDaeJNq+WiYPwMrnnL4gftglZAtfpgqmPz2tGg=;
 b=Ot9fXtZBw8AWS94bMtXtOe7bRVxS7098URyeevkRTo+ou/GQ1tbYwqHFb+ZJn6v9dcbJiZJdLzPbGo7xAiK4Jud6iZolFApKqZj6vpygwbTgoxOboGna351qxmCTFcyFe1++hNwjnOXiqPyyWI7fwhOplt9Pf1fnb5OBcOPP1Fqk6IPBHTfFbDtXiH+TshykyvK9D0niKViiXUmUNnTDVdK2xrxbZkeWDW4qLyI/636KFAaWCuLqlG4Dl1xGk8h+dtAoLrhVgtWCXIV8whkNTMGhmKAM8NAj2s8C1YdxeigDcz23Ly5D46EXRsljXjT4UAjMFVpNEbuZCyPHWmxgtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPTlTBDaeJNq+WiYPwMrnnL4gftglZAtfpgqmPz2tGg=;
 b=qYo97SzbHfkocePChcYzpOqgZRyfdQTzK3+IBadQXcxD1p08NmcI5BmFjyUBxkPoIpE/xuL5Ni59hnv7XiyTofY1twvgJdE3p67LpRMpCSIlDYf01KrVIDVBXExF9SelGElOweOb0x87TAUhs6b4HOpqhzahoZutwnk9mijXR2c=
Received: from BN1PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:e1::33)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:09:45 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::42) by BN1PR12CA0028.outlook.office365.com
 (2603:10b6:408:e1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 15:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:09:45 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:09:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Michael Chen <michael.chen@amd.com>, Jack Xiao <Jack.Xiao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12_1: set multi-xcc mes log address
Date: Tue, 25 Nov 2025 10:09:31 -0500
Message-ID: <20251125150931.2046618-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125150931.2046618-1-alexander.deucher@amd.com>
References: <20251125150931.2046618-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 3227b941-31b4-4181-6801-08de2c34ab60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jSGrVO/KlFFMjNTM/DVW45OUmYFrdNjKJOaxyrN34LxoSYnRgeEjJRnQh4ux?=
 =?us-ascii?Q?6gc7+OZ9sLf/hfDNLgYg1OPJydN+VT/EUv5QNQKxVoWCN93MrPxdWW4wHeK2?=
 =?us-ascii?Q?+fgMyP1lC11j45xonRcoo7Nm1JJNVhIUNzIF1d7dZynjpz9ArQ1QopybI7oX?=
 =?us-ascii?Q?eLACD7L5HuCfCSfzO+mTGXtKe5X6aURNwzKZoEMCKqTOtnxvGhJTql1ckCXK?=
 =?us-ascii?Q?tNVKqBwUmw5hC7nGt+Ews49zQ/VoyJUQ2hYcPYIeNMf86kLNg+78X5vJFYXM?=
 =?us-ascii?Q?+k25eG9lrvwQ/H0Vk+wR1KOQyMX5+jwXLNAoxxpVdmDreqVOMsYjFdOZlbDf?=
 =?us-ascii?Q?z0/H85YNUlPfB5Fv+NeuvH9jOCR4LLR9Vn/ckqN0e+JcB+HTfqmNGf6heE40?=
 =?us-ascii?Q?4ZxoKvGPvDBoiy1FTyvDLnVLS1Nlsai8IaJkHaLUxfkDl9xUy7HngcMkE6xm?=
 =?us-ascii?Q?2FjgqI2InCfaQL6uRd2V/DvuCXiTkp2ZXs8ISK7mLcA49iDBHxSAvS+V6xNP?=
 =?us-ascii?Q?g2COpDikZUzzm6mhw5XA2QlJMhfi46KoT4YW3fD/CAG5fiYpz5LjNGxh8PKA?=
 =?us-ascii?Q?c32PptzVLVwzuVqDKzgP76XtDiuo556XTPo9n+CqjKxDF7Yud5R8uR4IkzYv?=
 =?us-ascii?Q?1uCveUO0z1K5Z0HdBrOyQjQ6mAaka6AurmWVlvUzQvnM1vOhntRTeRQE9dXg?=
 =?us-ascii?Q?WjWeOk3MDFX44xwGGE1dXvCoKpvPKXw13sBdQ0n+5af0ai3XVkDqFGPGuGwX?=
 =?us-ascii?Q?bshGoN6ZJlEAbxIhdrdRt1HUb7e4ncyQzlyWm+Wt3DwlnO4RqOwUbA/5Y9ED?=
 =?us-ascii?Q?Q4ouoxcDMdByK3etxwO8SbHp0a0RflMjkuuLG+zxcfQPbhrwfRuTp53EJivQ?=
 =?us-ascii?Q?7QlOpPxC+1oCk1gkbNViySZEggy0M2PoNAuiyzAWtrGVMRAxFcciW0kj76pj?=
 =?us-ascii?Q?HkQpZ0aW0sbH5ARHM7OtKud7XHWkSEZ4YfVWA4zKxJox8T7xRYELk0tDFbTY?=
 =?us-ascii?Q?sjmpiOqdpTPEir8/aQGVXJz583Ykt4kSpo77TyWrXufZCLhdJEW10UHVhXRi?=
 =?us-ascii?Q?90BKUy2vBJyIEXjZlOO1WkzJQbEqmTW/KjAlQHVC9H7BGZxZ6aFhJk4kkCVZ?=
 =?us-ascii?Q?lzTSN8YSA8f8OPi9TW2QF7T8o3JrBVQMeIsBZuVwB5F+5zaPCg8xx3vV3otD?=
 =?us-ascii?Q?rKI4RW+P/4YrCJHTG4okP8Q/oXnhnNMwrKYVP71/73kxSNlzFoZ4fcLZsodD?=
 =?us-ascii?Q?z+pRcZ61apVqJL3h+aW6waGOzqnECUKW2fKPgtIGen1er9KFIIY3qNWgSqUW?=
 =?us-ascii?Q?o5m90pp0d2YMqGZF2sWKNKptpajXVFGylKKQKu2vACyEiq4NO/cj2LD6SDHQ?=
 =?us-ascii?Q?OwMA9HemE30uhOOe7p6QmOAy6L5SxTuOwA3M8K+/8/8QjbEX8fiZx8+cxCyK?=
 =?us-ascii?Q?x2ts6vFgX7+Ol7/yNupIwjuDfb/orNQtqeUNq0YR9EEfk9w9vkpFL9CpZ7Dm?=
 =?us-ascii?Q?pfdhaUhRFCdhZlOd7gotFPyWsswsHHIqr+91ujthu0jYYeV/m9Vlsdvtrofa?=
 =?us-ascii?Q?u71H+zs2QdNESUVIht4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:09:45.7891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3227b941-31b4-4181-6801-08de2c34ab60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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

From: Michael Chen <michael.chen@amd.com>

Set mes event log address based on xcc id and pipe.

Signed-off-by: Michael Chen <michael.chen@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index b12a1256989b7..466339ef016c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -708,7 +708,7 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
-			mes->event_log_gpu_addr + pipe * AMDGPU_MES_LOG_BUFFER_SIZE;
+			mes->event_log_gpu_addr + MES_PIPE_INST(xcc_id, pipe) * AMDGPU_MES_LOG_BUFFER_SIZE;
 	}
 
 	if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
-- 
2.51.1

