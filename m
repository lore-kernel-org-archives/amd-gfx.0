Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE20C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623C610EC4A;
	Wed, 29 Mar 2023 20:18:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBAF310EBE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7oPalLl95t6P+cO5xkQsGMzM7mb3iPm4yNzsc4TKEliSBsNuRqHzTBiQGKQXsGwyZn184gFTlc5DsjQSsqjZZYHuehIgbazXlGNN/XJHadXwP1APDqm3Fx0I/QN9BFNe8bSUm0S6s2eNDXWA6CUjNGxkWsnRZtG9/a0GdCFvCOLD75NaFvyxUfe1+nyW8RTH7ss9pdmVY9LqbFR0ZGpqEwq5ViNM69CBMSOkjVCPTEJmGXiiMwDPIdUVuaJBw503/CN3h56SZOU9sI3BlsO+a/qY9j5LwYPDoqg52Za+8InIDm2tMS76ZG5X3k+EmK1zAbgzdog6ZhR10uuBpBIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWxDi1YxWUZjAzjtqOMxS0KysddrYwBasLNpyLK/7UQ=;
 b=hm7AHtyGuFnjziEHK/qoi44fVZsbHPSgNifrfp3MtOHcULiJ+7XKUeqmIQFkz7J5v7YWlBPO9STi8kp0qXjGVc5ouPSBZ4GC/Yd4kcQfuoFu3raADN25MsMQJkX2AIG/vasKWD786MHIpbvpsbEZyaaKtw4UWnk21H7035yNYBTgFpWDZ8zQf8s9Mx8P4C9ozAqpdPytC2tjx2T6f+LOKefQYiZuzNzkEaCm7gbjJM3dtFcE6xZewwjDuKdVK4g2QKmS85uihUEXrLDmgBo4GUVlDamlL0bLQ0wtK43lzaqkSV1G67opVgCgBMfgc3Pl/wRZUNpmRUXh98AAof0Xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWxDi1YxWUZjAzjtqOMxS0KysddrYwBasLNpyLK/7UQ=;
 b=ifu+ZCrdkulOCsjfy6PzOaVWvO+/A9Q5gt4Ny1U6LMqaYD3YwA8ZBizFnoJjpzCRonyHyhs37ehhQ8kLIg1zkVIsGsdRIC9af9UWbNFmjfPS9oZ0VOwncozRCkw4F4rW7ty7gCdZ/pRhWFMxfX5GqIlRaWFVsz9i4qR2MjqsgTQ=
Received: from BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) by CH2PR12MB4859.namprd12.prod.outlook.com
 (2603:10b6:610:62::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:18:01 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::24) by BL0PR1501CA0015.outlook.office365.com
 (2603:10b6:207:17::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:18:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:18:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: Use SDMA instance table for aqua vanjaram
Date: Wed, 29 Mar 2023 16:17:43 -0400
Message-ID: <20230329201744.1982926-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201744.1982926-1-alexander.deucher@amd.com>
References: <20230329201744.1982926-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|CH2PR12MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bbb66f-4bf5-45d8-aceb-08db3092b206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwE+EXVET8tnu1ybHcHeDSbujYNzc7JJDSXJhQtksmZGmVH7w5Bd1MvVO7slEMY97MQ4kWgLhqAp/VXJiUS7qeMinykvycDLEakumGmQ1zj/ckFLSFlUzXJbmuUyrGEdUHV/pTNthbB5jOQNaUacGRwkW9JtBQkSPg5bRaH/YyeTC0cO+44M1y6Jzq35IyNwo3pkcafmj1sgIVPP3i+SnshJEfuOnBiFYrQUQ9f1+f/764Hzf8WwCkaA6OJx0ivcTMq3XtiFiaJCLSvBuyRn9Gvv/LjAwaFr6lzCH4tYiOxSeeIo2jzvC5Wea709zFPlGteHZWgnbKODoHGnchneVO9BpkUIHwtudAzi/Xm2Ny+xfJQE/hS+CSMhTh5e2Ca7tkj3JrqhMUXtnyU1738dCKsyJYJUtCDwbW9bO3AaDQ2oJu7NZZ9BYTWLiYc84JwK87IdvHjAfQXaM7zHNHZEWMSnWdlWAlfJ7dBejZKUVkZsRI4ax8pU/cYEvgjcKjXTty4UheReQH6k9NEtn+81a7bWyqRIjdfEUG0Cx9ESiwDbpNQlc4VPWHP/fOlZZmcYmZsurAV4iIjRSOn7sGZAL3sx+97mN0Ozrm7cg5b7LtWc+ob8/Wwln46YxiZ8z/+HtcXfP8sOiejJixXzek57gvyPiipTwxqJ+5njyigksVVeZDgauWYZVqy4RJWlhoptCLL+/oi4rKJHHHb107caJwdziZw5cIKbrBiexrx1AnI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(1076003)(26005)(6666004)(83380400001)(81166007)(86362001)(8936002)(356005)(186003)(2616005)(16526019)(336012)(426003)(47076005)(7696005)(2906002)(82310400005)(40460700003)(5660300002)(82740400003)(478600001)(40480700001)(4326008)(70206006)(70586007)(316002)(36756003)(8676002)(41300700001)(54906003)(6916009)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:18:01.2728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bbb66f-4bf5-45d8-aceb-08db3092b206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

For aqua vanjaram, add mapping for logical to physical
instances.

v2:
	Register accesses on bare metal should be based on physical
instance. Use GET_INST() to get physical instance.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 5a1511a22367..12379c374457 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -59,6 +59,7 @@ static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev,
 
 	switch (block) {
 	case GC_HWIP:
+	case SDMA0_HWIP:
 		dev_inst = adev->ip_map.dev_inst[block][inst];
 		break;
 	default:
@@ -73,7 +74,7 @@ static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev,
 
 void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev)
 {
-	int xcc_mask;
+	int xcc_mask, sdma_mask;
 	int l, i;
 
 	/* Map GC instances */
@@ -87,5 +88,15 @@ void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev)
 	for (; l < HWIP_MAX_INSTANCE; l++)
 		adev->ip_map.dev_inst[GC_HWIP][l] = -1;
 
+	l = 0;
+	sdma_mask = adev->sdma.sdma_mask;
+	while (sdma_mask) {
+		i = ffs(sdma_mask) - 1;
+		adev->ip_map.dev_inst[SDMA0_HWIP][l++] = i;
+		sdma_mask &= ~(1 << i);
+	}
+	for (; l < HWIP_MAX_INSTANCE; l++)
+		adev->ip_map.dev_inst[SDMA0_HWIP][l] = -1;
+
 	adev->ip_map.logical_to_dev_inst = aqua_vanjaram_logical_to_dev_inst;
 }
-- 
2.39.2

