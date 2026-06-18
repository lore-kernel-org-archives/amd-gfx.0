Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59CACD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BE910F051;
	Thu, 18 Jun 2026 05:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1N9WG/++";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2910110F051
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm7tDi0rQSlL3pyiM7Qk8/IXkA1LySXnWm81G9vQb/PWa6s6EsazQWSHRYCnYrFQDln2+LJ4pXrdbm10qymA/R2E6lsHTDoZKew+LDVm2wItP1i8ddjF2nZ4CBebAJoRKv+8dw3ba43IIzZQ6gfqDog0fI8phHOve13r2p8H22Ung7EvXvXUpc6aQUtX+rkKa4Ic8oRj/Qm9fTkNCi70fP8aQztmU3bMagxy2tkvp36dz7wfCn5WtFVH/rCQarjTUfCJMtQRCi6reFzKPOz7Jvw/2YR8puPymZzIefOd2UtJX1T4ZIzZiHs3vFi4O4ull6maIWLyo9aDNTaggB1TNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfBEjRwEmoKpFbW01e+ZgyAQCh4tmOV7hJHnwUwfrsQ=;
 b=d989ZDs9R4STPjgvF1MVltuYcLN40qfxlYpdk6DOnlOWYn8IjGTqlTNh1xfQRYq97u24tp4rp4A5RaoQ2DtPKi9WDvX2CVOe0rwodvjFx0wRXqraonCnik9CXjF7S8BOaHQOJtOeICNsoM2Gw/Tu3vWXIx2Cn4ReJizLHGLfV834o+JIsUpYJ0G3z+u1XjtO8al0wmpW5rRwLxMiOldTS76p/9wMawzM06VboRoTZMzd1kPWIEZGMEsGw6YYOO2jQL1pWNCWplaUNiFLjVG+jkUDV94ZzXEHymg76ZABNQzmRLTQdV2Tbx837UgiS23X5qWQQ/zp+3enJ6qCDlKj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfBEjRwEmoKpFbW01e+ZgyAQCh4tmOV7hJHnwUwfrsQ=;
 b=1N9WG/++C9Z/3zOvzCr2ABDA2Jq8vHFaUOGmg7D0mqCf8bvBkSOLBibDHKpGY5g7obS3sKGZI7PvNY9xLLCzJ/AJmQ2mWIDjRAsTvxJdnTeyRK7bhh1QrWNbU181Jl3oomO37lk/56mJ4cQVZfWK1pSpkXkd85oRWWg0GFxpZ+k=
Received: from BL1PR13CA0218.namprd13.prod.outlook.com (2603:10b6:208:2bf::13)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 05:15:22 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::b) by BL1PR13CA0218.outlook.office365.com
 (2603:10b6:208:2bf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 05:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Thu, 18 Jun 2026 05:15:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 00:15:19 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: validate XCP topology counts before division
Date: Thu, 18 Jun 2026 13:12:05 +0800
Message-ID: <20260618051205.3130057-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd553e2-683a-4ba3-027a-08deccf89921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aaDDodTmxpb0uBy+jz2D5lVLW3luVu045/j9412egXR0DffGWvLxqdc5X5VFRQzfBvJFmiTgD4u/JrjtCfJY417Pa1Q8Jmy1RxVtCm1Atw55ymNY2LZbQLa745zi12r2C20j1kBscYq8WoIgivfcX43fk1Oojet8VrT+Ymgs4WO2TtULeaWQV3IXHuxwxJCwDkW/qCnhlJ574Oii57UNeM0/JWUlROaWyXLkceI/+Rhh7SooPQRVtApAjOoyinJkPA0XjyAwQ+EQCnH42TIuBp2+xZmi3BiffEG5w+ByqZALdc5xlwUCuJvykTTPUxJLqJkmvMw2UvsMutU7PLeIyxxnYvOgs81sfnPQEEjFKtK4iK38c61PMWW4ROVxuXz1EqAPQbVvh/Zud0iizlRlLL1YG6CmhIjUk56VLIPI1neSwTjF/MJwzcPfkoWphMwb4rH/8CC1flureSi8iV8/uNpbHV5ZgJVgc3PXTlT9lLLVOmbat6XhZaDvLM6nufV1SLkn1KH5T9jtR6gGZqC9BXGNHbYxSa2zNf1Da9AxBjEEfQvQF24DSLD3pgm2NuiRoGMKdDQqJyAkwxuy/UtU43r6DkJs6PJPmw/P3RW1lLU2N+UFx1JoTU6fHHUsiP1ujGMdqjQ3Xwd+j8lI4PcyzGZc5H+y1ntOGlcVV9agjcApybNSnTBSP1f+BDHOXm4C24GZQjbvPt79SQlX53D6+Rr0v+LY3Yru7uUPMz6zm2Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cn67BFe8smT9gCnOJ+GC8VaS+BNU2RED4QPsykkFacWu9QBbgwz3trzlryPorxsRGjXIr8H2/ubernLL8UKN9wQvTNR65nDgfF6070dHLpLfHo+S6hI3YtxV7dQJ8iO+5RofPGxfHmRiZX+iEvM1Ey4XIN93XXfyM918M3VWUw+2dsbc/Be4slozDjUTu1Esih/X63Dw4nmBakov047sLoQnEqWOCUDZTzbbPUUfJFBa/2Gm7ro3Vaji9+4arAExYZV3XR6PO7ZsWXmAzPNFU5CsP//+JTZJuVt/b9pASPm1LBgcghLJ4lqsuVK+66qGIPOqILkN86Aq5ImfbQtsqanAcPjwt4fpvIkKSoqgXLC63Wi89dJu2jKKHUacDQ1EoN1eAB5duqWjdMc5gWglA10E5BOMBw7o3ZQwbelu1BSVdjvJ5UQN78N4ARVy48Tx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:15:22.5803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd553e2-683a-4ba3-027a-08deccf89921
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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

In aqua_vanjaram_get_xcp_res_info(), max_res[i] can be zero.
When res_lt_xcp is true the code divides num_xcp by max_res[i],
causing a divide fault.

Skip the loop body for absent resources.

v2: Remove redundant checks (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 72ea37dbfea8..1c11cc280599 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -273,8 +273,10 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 	xcp_cfg->num_res = ARRAY_SIZE(max_res);
 
 	for (i = 0; i < xcp_cfg->num_res; i++) {
-		res_lt_xcp = max_res[i] < num_xcp;
 		xcp_cfg->xcp_res[i].id = i;
+		if (!max_res[i])
+			continue;
+		res_lt_xcp = max_res[i] < num_xcp;
 		xcp_cfg->xcp_res[i].num_inst =
 			res_lt_xcp ? 1 : max_res[i] / num_xcp;
 		xcp_cfg->xcp_res[i].num_inst =
-- 
2.46.0

