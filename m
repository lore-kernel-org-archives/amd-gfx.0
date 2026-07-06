Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B6EC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 01:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B0510E2AE;
	Mon,  6 Jul 2026 01:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="suuSg9n1";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F2110E2AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 01:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVeZpmhlLxs3CWgcsD2T11+dMfYaeUl0RjoRXimn7yDINlzY2aGYEySQgybDHutdTEsTrU5OixJUrlbPMnQt3IJDPNAQqyvXHx98qlMmkRWqJ2bT4EMULSBw0mLLcHsIJZsRh4wb/XA9ZmP3ALckRtISTQm/ApXU+315SntIgER8vIa8O2sze50K2ls4o2K+3sn254LAHcZQU52BhcBcxTlHJWuL/uzgAmTc39mF2N+WZReSu6dcliJI/tbrXdp+SZC5PEL18aen37hl7h2jP3IwJrf2BTlg3LKV2jaL2oq8ofjnkaLPFaTj4CBN+R/gRVtKxq3nCZQrDdcBtHF0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZxAkcBJBfjN3aB/1fZMenpUp82x1I0yXttZp4Pca/4=;
 b=Pmu3vjYauvcyDLdVB1E1ANBak+uKL+rYA7ylyn7SFVewIBfJfzi0OhzwCFh8JO/x6JaQQqJGk45loBfxue53GzyVIzugBGauk0gNfUpowjk4jje3X4+IIFO4uKYCh520+khBY+8Lq7BrlZb0IefGjEDwHnQX8pBhHMLy5bkeM1lkSEHQ2azAb1pfUTUyGvgDPd/f/See953UFResBThJ7eTSlpw6b8mTez9wuhk8SAa9FwCM8pWihHNu+F2du4KXT2hePHIc8Jk2viokSl8/rjL9a9CqMObOthYtDgYWsITrWXAmXRgY7y4sKwltrh2OrobdF7i1cKY01FCzl5gntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZxAkcBJBfjN3aB/1fZMenpUp82x1I0yXttZp4Pca/4=;
 b=suuSg9n1BDtLbIrnetabzzPKrjrqHf3kNfIaZfhIxE8KOXrPiXkRB1o8Ln+I04Zh/c6bo8RDnGLZxjSN/51Jcd5Ozne2zeANygOReSbpSrRcafBhZqh/LV2XDOf1STS9ABZuBfUfSsO2/WUGM4l2UcDJYsggTW+w4NzR5i6DVLk=
Received: from MN2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:208:23b::16)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 01:38:19 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::21) by MN2PR11CA0011.outlook.office365.com
 (2603:10b6:208:23b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 01:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 01:38:19 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 5 Jul
 2026 20:38:17 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu14 power limit range calculation
Date: Mon, 6 Jul 2026 09:38:07 +0800
Message-ID: <20260706013807.1051660-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b037f0c-b411-423f-54ef-08dedaff4220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: rgOgblhcrEEJR8ZryOFllZPBlKPcvSlY6eqHdBaXVrX+4O4S4hIpG7sMRuaBt5XkeSMB14+j5IP4m0nsdU0k8bwgKpeLlYQK0R3Hl3rM7vh9kmzMs+ZfsuzoeAb0A05xBmW46CkOZN2rlT8iRNgJj+KPH0uIi+orjjQoONsYc7FhGdw+rQbxie2rVxlLkllXNaszwP3Tg6zSHWjUAeEYfgPhAZ+9ShAhcoM2GuC0+aSr0K/7EzEyvAPT1spdKRm9C80U8+Nk9fRauGSnAdAkbRmbb6uvpxEDJ/lVpYgUlQwE3MHqiPO0wXmUO7a8r8AaGleNgjcP93zJgc5tR7ViHw2Abx7qVvt/0D+qAHGi5qhV+GYyX51zDLE7vCTChJ5/7rnjgMF2xhKtJyTGTrzm2qKd/At1Rs2len6k9EDFATFFSU+fsqWcn0zQr4SIwQqA/et1JpimbxOpwXoNorY3nJEysAOHXS0WVUmyo3mUL5dI9JkuGQin9sbaTELEoAReZRI+VyfojrCrCj8dGkTswSz86p8UTOPtlFn2ZkUX0rsBpVfDPJKWUO82j+zCHEEFmyKSzhQDOq0Gvm2WmD1972FvzGjQs/r0Nx1U+m9YQEnK6ICxqHF550RLay22SRwYDBOrNVtITT+sZ9GF5Gx2XPsYr1zfWYHwJWlgb645utOSC/osYk9ydvaJoFTbkwYdAr7mIv3fteja4rc6nUqCZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UvIZEGBY2eo0Q64HF70Rggh73U3DXsmvZoe7+D8PtyFjVUOn7HImG+0sJPPNHado2SY48vprQ9qWxK38wecTrLC0rABEJv+gA2dPNjAW0G5hIFWOA0E8dTg6ag4KblKzrv6FvWc8WC45cri9763g70vZ975Ke/oHa7nb5qlcRXzE5jDZNL6LSmWHDRnnwjI9UCPjQHNaUCd7tpwIgs4JsOHPHydJaoJHWhx3r3iydbzUbLNXOxYjeArImyDd4rxN2K/1v6wBcioTe0RbwCuvd1f4YYu3kUUd6G29mxB201xQoemm391A2EdgaA+iHs8AvNAJFuryvgvGFuflkRCAxgCDbVBiovrAskxAR0sK/i+XW+N1Et8TM/jgcUfac3eBCxkdY1h9iFFDoRTKxxuAVrGgRbhkcArMq6UPzO/+Bwv/k2o9exE9P7O9hQ+z9vZV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 01:38:19.3688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b037f0c-b411-423f-54ef-08dedaff4220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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

SMU14 derives the default PPT limit from SocketPowerLimitAc/Dc, but
MsgLimits.Power may expose a different firmware limit for the same PPT0
throttler. Using those values independently as fixed min/max bases can
report an incorrect configurable power range.

Keep the socket power limit as the default value and as the fallback for
current-limit queries. Calculate the reported range from both firmware
values instead, using the lower value as the minimum base and the higher
value as the maximum base before applying OD percentages.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index edc5140f6ab6..b8584a1e6bcc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1622,19 +1622,23 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 		table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	CustomSkuTable_t *skutable = &pptable->CustomSkuTable;
-	int16_t od_percent_upper = 0, od_percent_lower = 0;
+	uint32_t pp_limit = smu->adev->pm.ac_power ?
+		skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
+		skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
 	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
-	uint32_t power_limit;
+	uint32_t min_limit = min_t(uint32_t, pp_limit, msg_limit);
+	uint32_t max_limit = max_t(uint32_t, pp_limit, msg_limit);
+	int16_t od_percent_upper = 0, od_percent_lower = 0;
+	int ret;
 
-	if (smu_v14_0_get_current_power_limit(smu, &power_limit))
-		power_limit = smu->adev->pm.ac_power ?
-			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
-			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+	if (current_power_limit) {
+		ret = smu_v14_0_get_current_power_limit(smu, current_power_limit);
+		if (ret)
+			*current_power_limit = pp_limit;
+	}
 
-	if (current_power_limit)
-		*current_power_limit = power_limit;
 	if (default_power_limit)
-		*default_power_limit = power_limit;
+		*default_power_limit = pp_limit;
 
 	if (powerplay_table) {
 		if (smu->od_enabled &&
@@ -1648,15 +1652,15 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
-					od_percent_upper, od_percent_lower, power_limit);
+					od_percent_upper, od_percent_lower, pp_limit);
 
 	if (max_power_limit) {
-		*max_power_limit = msg_limit * (100 + od_percent_upper);
+		*max_power_limit = max_limit * (100 + od_percent_upper);
 		*max_power_limit /= 100;
 	}
 
 	if (min_power_limit) {
-		*min_power_limit = power_limit * (100 + od_percent_lower);
+		*min_power_limit = min_limit * (100 + od_percent_lower);
 		*min_power_limit /= 100;
 	}
 
-- 
2.47.3

