Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BB3C982D6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5139510ED1E;
	Wed, 16 Sep 2026 17:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wByII3cJ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237C610ECD0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMSM9KHYWUixBaUpKxPASjCLJTAVrKyFY+l9EA6qcY7AS+L9mlaCE2ZTzog2SHJvZeFaTZ46v/ybSfi316J0PS2pRTiCtf1sa574BIy74wWzbbqHYHJAennGlu9DehG5pqHtgOl+5gM2/iMUVjcQL3gNXGruD8umeOYSz3kw2GKyVYQNi5zLMGETUOpmLgkFB6S1gQ7tpQyuifBeft2ndic8ILpNGOr5hawE/dNt+TeBe3p3SLl9TzuXGNjs8j2xuyehzgBN0X1zxpZTqYFu5N4SAVsdc1+pmbCQ4ZSkBZ4dE4zqppCVu7SLsQo1HR06wlRg9UyQkfidQ5WM65KA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0Hpoog6Mo/o46rPYOLollzor+tKer43xGpx3Ku+pUU=;
 b=Jshb7QtJJX3onL5dwpSlb5hiPpNp+LJcZHvNlWaVToR7EWsOCz1MtbrEVp4rENb1msRp6bKJ4euSzJ4QtV0cOgZQC5LlSZmr0LnqGw2I/BLTESAqDahISMxCBWL2aTm9RcgMNbIfgB/jYsqzf19HGGE/+6ecCZGDqlzQx8PwbGAzlghJNTyBSd51fqsBoVEwJMUFkCn6kQKh4ruBzG11pFUzdwK9jD/3q0TgMKZfT1V9g5R+L6cIU8yzm5VvvXVj/FVuH6Dj8/jp1qW5TQGM3Iq2kIn5L1ebpKPaLKLpBK09luM7RJN5rhnq8ohDdodnr60PqpnYqFWKgtbe5W+SHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0Hpoog6Mo/o46rPYOLollzor+tKer43xGpx3Ku+pUU=;
 b=wByII3cJmnsGg5ZXE8GKaQ2bhlB9/SRY2vJhB6GTKGfxewfjbSaBCH2I6g4zzyyXDX+P+2xKAe13huVIsBkeWekuEMHXuUmiBm8y/4I4+tsTzUuUCcfmaAb1Q1GYf1W700uGYebDwCovzOFfr7LJUuI6WZxD43GBUUv6cNCMFQM=
Received: from CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:06 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::7d) by CH2PR10CA0014.outlook.office365.com
 (2603:10b6:610:4c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 17:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:05 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:53 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 51/64] drm/amd/display: Fix KUnit writeback warnings
Date: Wed, 16 Sep 2026 13:52:06 -0400
Message-ID: <20260916175301.368306-52-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 6702ee73-ecb7-4313-cdee-08df141b5c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hgwExJRNtxWLQq6c02JxO2aiIRdUgPK7j3pXrKK3V0VoW68BgI9OMGYx7eUhQLAnJaBiG6xVw+Mn7L4RbkYY1SD3aHKXg77YmbvBCeORfIq5lMdtQgXYzZjiJEPMRc2PWDuybVJPbszKe5c6CXgeGpYRzDoLLCbJjUkN+PHWM6vLEd29UAzgoMTrGy8n7oJTOto7MX2I7zEmawVDsmiRjMci/ztHZpliDc6mxJkNPAaE9ALjOrkDjienfwZTgu6Z1+8sCDgM1P67yYO9PnToaIIRQteGsXrFYVGKtUlJL/cDKnqz/DNTdVbXR7GBaHCvS0VRa4fJji3DSLwM9cZx1dk3xARqVb9rEgXFPn8tWNfL7pTixKCgPE/aFfiwhEpQsabYqlVXmdvarXzgoGudmadkawBz3LRELhKexfX9SxRdKQ9HsX9DWyHe9d5Vh9O30GGtY12TBb+oM/q51EtE33UO1nAlgWHJoT2TdnKN2yJL7x/28dJuFj0aDSC1sfzrdsVDxCTB2+mmCAmMmR0EJBI62xFPtVyFMDQ1rTCa1/KO8j6VUYeO0Y5DDEiJQMQ+M5Ge4jTM9D9hGqdIuLBxch1aXe7bwkj/qbBpymybZdxkDjcYRLySuCoditi4sM94G2H4mCkN+noCcxk+6uKlgDTLVbTrip+6IVGvaeg4QPvvJ2+jDNI+yIzpX94diQp4z77bzZnChvUWt3Y5b24BGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gKJQZqkeQdYgaEc2QZNnRgdXwfPBa3gM0RpnJ2GzBemNPWoOxoZ3CgVegLrOzyFOYZXG/Fw+WTj2v6IB/zPhKdQu1AsXZiT6M0n6MiWjkJlJ3v93s6mm4elXvga/mLhLAfW2TzToiRyk6w4tiIG1SBTfsOu+TcnaP18Zho9JXA+Kw4COXtjD5xkB8ZXGev37nPMShwee0GR6bEC0Gh5scKFOyP+UAlVS7inn38jO1EdoEeR9eO2002UGvRHVABneig+f1SU9vFqjTxUt32Is9Xb8v8umIvCqsFd4dAVU701YHx5PzDAyT9tbozz9GDMEb8IxAT3OA0CDz5uKtL0NeIjrVQY9yWHVLfqvvAj3b0T6Bs0k1PUFseo9x5hUHDjFAdKKIByIeEV8LmqfvJTH6cjPQ1hlHb5bc2rFhw5aFJCNrCCjJvI7jLTagIYxWx0R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:05.9551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6702ee73-ecb7-4313-cdee-08df141b5c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
Writeback mode tests call drm_mode_probed_add without holding
mode_config.mutex, producing a warning for every generated mode.

[HOW]
Hold the mutex around writeback mode enumeration and release it before
checking the returned count or inspecting the generated modes.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index 03036f906385..4bc033fdfa97 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -418,7 +418,9 @@ static void dm_test_wb_get_modes_returns_modes(struct kunit *test)
 	drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
 			    DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 
+	mutex_lock(&drm->mode_config.mutex);
 	count = amdgpu_dm_wb_connector_get_modes(connector);
+	mutex_unlock(&drm->mode_config.mutex);
 
 	/* drm_add_modes_noedid should return at least one mode */
 	KUNIT_EXPECT_GT(test, count, 0);
@@ -453,7 +455,9 @@ static void dm_test_wb_get_modes_bounded_by_max(struct kunit *test)
 	drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
 			    DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 
+	mutex_lock(&drm->mode_config.mutex);
 	amdgpu_dm_wb_connector_get_modes(connector);
+	mutex_unlock(&drm->mode_config.mutex);
 
 	/* All modes must fit within 3840x2160 */
 	list_for_each_entry(mode, &connector->probed_modes, head) {
-- 
2.55.0

