Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AB606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=be/KyQEN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A8110F8EA;
	Wed, 11 Nov 2026 01:44:12 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B752D10F8ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hROaKMCuR4YjPkrqoihkBK92WtRSY0Qbyg3krZZFvMa3xYYQmYz84q0zxX/j4bUXOGJ24xQeMs6D/oULTN3l0mXV0MjS1hrj88VpYlguq8MtPiQ6+b7G//hRsamqS7bhL4rvintvpGss37XGev0k5zs4hXeas2hCXjCmnwvEfU5ut/xaTm716g8EAsPrfK8Ds2XJhS4uXOh0p9E8EZRmsEGY7tx9IBq/Z0rgRRU1MdSgM8yVTjJZ7XgX9sISDK9mNjS/P+OvqjvW8VTxY6GSZ2nFBBt1hEIkAgT2P+v5UTjo/BdPmuSv7tEISTFh/V8HNFAyogxzWxPPTvQBz7+gDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cjp/F+orUjFSyAWxUzfkAOYhP1O3NC0S6kVQKfGDFM=;
 b=UC0MUoPOrKUOAoees8G+hFwugCEWdUPsB0BXSNj/mx0lKa9viiOYqNlH3CLT2DEBlXbMVlEqxYzx2GK1tAHDnEdVcuOq0clM9jkDR1oFiucoT5LpL5uyW9OVGbVYFnpLonrUVDMoWh6z5X0vHgh/33iDMLdIFOw4P8N/qkZA5X3+vtA8G3k9SoTcgNqzK1aqYTk+ExK/eIhCCz2ilVBQNvVF6dLPSQw18tkrFA0fZoqXNl80rOXCOCGGT94RaOhwgFAhGUxYVJ0w/4qdKGl+eXxu51b86GotqPBuptM+nsvMxw6JS8ZnLFM2+6etYxBjOIARnRYPaKpkZXHgtunaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cjp/F+orUjFSyAWxUzfkAOYhP1O3NC0S6kVQKfGDFM=;
 b=be/KyQENtZ1eoEZJM56YiEIHVwFt7sD8Xm8pj1Hm6Knxplj0Dxo1IiQawSVOmWPqAnNyw4mGquGJIXa6xkvZB2fHDTxsS8cBFX8pQjccrpeJ0v/XVdqHMv+6Z6LL7SFp1jRDNTtyKGoT7ovRlRHGnXLB8MM007R++kGzX71DBrM=
Received: from CYZPR12CA0016.namprd12.prod.outlook.com (2603:10b6:930:8b::29)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:44:03 +0000
Received: from EA8PEPF0000000C.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::4b) by CYZPR12CA0016.outlook.office365.com
 (2603:10b6:930:8b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:44:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000C.mail.protection.outlook.com (10.167.249.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:44:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:01 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:58 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 56/74] drm/amd/display: Use soc_bb hostvm fraction instead of
 hardcoded value
Date: Wed, 11 Nov 2026 09:29:02 +0800
Message-ID: <20261111014100.3596072-57-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000C:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 43961064-bf28-4fe7-b606-08df3f95439b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|11063799006|56012099006|5023799004|261021123027099003|261009223327099003|261009221227099003|261021121427099003|261009221727099003|261009223027099003|261009220027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: zij0JicO0cjo0fwSlLv14Xh851KWA3/QzQwVODT0yGZMyav+6fh0PMYeV4lupg8+jiqnn8+K0oJ85HIAmmDS8O9TN6445T6Pu0EzXp+cFZOnTIY4ogD9s27pUirh6K4rW6RzOL6CzNyVHBFu9we/hNg5H7kp1p4/1cG000xEOnuqY9TXyKFa4C/fn0jFXhd0qBFzltFeewhExZH/Q493vmyoPHqo2cjS4LLWRMDWBC95XCK3dJImfxTy3TwWut6TrcLa7CnrZyJUT7BsrnOgzD9scdOtReV5effH8xc5rmIkBrZwq1Uy8xBI2hqb0Gt2fBP7CbML5msFxHoJOxkRbnS47HjekSSV3jTHBf6as94VUNbiwovOIGWvVL+seoX/bJqeUi56ib+c6m8Or/XaNIRsSeK0d8ixSDLc0w5fcsBouvVQELKBdqFWnAYm3hw/h+xSOyvzhQE3WxJgH7K3PFkOZClj6w3TM42BQjrU4LgoDRB6R0f9v9YdIIi5LLwA+G7co2Xc7H0lshYD1iyD3lLI2WVK5j8Li3bPOxXQh15jZrzvQ8mux6vx2FbMIVOZzaOSJAbWHd38cKk4BFcpmJi7wtps9DvNVnVleq5tQ1Wg7IXl3q+PxRE/6TBjk0+bGeC+gaFjvSM+we4ZmKpDVX9IiVjzqCv/aH86uP9DPZymClWHCu7hMoz2lZ5m2KqOGRf8mibUWEOmpI+f0kXWuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(5023799004)(261021123027099003)(261009223327099003)(261009221227099003)(261021121427099003)(261009221727099003)(261009223027099003)(261009220027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L+UfOG42KQ3l3SnBpw7IIJ3BOPVRNkQZRcw4gWPHTPzd0p4vb5HDWpA3mel583sqaUWIHBoo2PKZkP4CGFtETxvZkmD0CMcfue4aFHM1vEyZ3YSN4T3kgxD0iTN84rQqIY1HN8p9e5mufn2JltTcVFapvIm++U8HGO7tdoKwghfYSPOFwLMEagiXt9VJykPViEEbokn94RNNljwk0OJQ206KtWZaT9NgY2oBqzsZKGl++og1nlJkNbejCu5T5Skkg8P5gHLPRVLQuhLtRZmJwXR8MEr4g+jpuL+OHYsiY2cMT7eswN6sC7iWGvtDr21qvQIpm7Th/CpH8lnNRXCWot/964YOvWtYiIfa5yCNe4f6YmMZ9V1196XvVUO5w9obisXDP4xTWtluBaNYRb+S0mPpbRP8Brk3CW8dcjF8D45m7NQ496SniPTWqWjKYy3E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:44:02.5506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43961064-bf28-4fe7-b606-08df3f95439b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
soc_bb->hostvm_inefficiency_fraction value should be used instead of
a fixed value

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 2ca3a603615e..157b579073b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -2664,7 +2664,7 @@ void dcn6_ms_calculate_hostvm_inefficiency_factor(
 			ip->remote_iommu_outstanding_translations,
 			soc_bb->max_outstanding_reqs,
 			1.0,
-			0.5);
+			soc_bb->hostvm_inefficiency_fraction);
 
 	DML_LOG_DEBUG_DOUBLE(outputs->HostVMInefficiencyFactorPrefetch);
 	DML_LOG_DEBUG_DOUBLE(outputs->HostVMInefficiencyFactor);
-- 
2.43.0

