Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E78C44501
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B42210EAAB;
	Mon,  6 Jul 2026 20:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8tKJqnC";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B4E10EAB0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZgisekw+G4DinqECmA++RbtPnNpIa5zgRPXnW9DWyr+oPXp5foxUqec3kv+wGtefDGQS2ELvhvr+CZuRPHrevASH/X5tSq2j4wGoKGcb3I6eI0vfEhPzQlxVMHkh3i5BTP7NVdWCFmxK1ZAge1ZwDo+4V+NsAhIo2514PPuMV4cE3RJx7sshi002dByoZFNh4hMgAitijO72XXhu9zBNKNAcqgS5zKUQoEFyzoMDpIVT4OteBMoX7zo+yhT7CjvjnAgZgzQONfh2U3KkyxSsEEEGEPxG+JY3SXU+Pbz1FKLMxzZUcGuivXIh4jNOIDaj6I/VH4BfWZv45+3ssfjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A8QGpNx+D9FWD+Lfwvrpsd7w/EsVYuthnrgz1E6jUU=;
 b=ZZdIWWnUPhez1ZszzgSiFPn1JXHabswwAL7pyPAVi68NyRkSoqV7l1vXmRmGzwrgtpXvkn2ZRdLGY/OkqEW+u076Ayr7AgI5rKIECJ2WivOi/xjpTa1U8NeENn7/qT6Gf+XWp5r3fdSDHshACapBGWTCAx4T5L7bOoR+nr5vl9hObwnnyTqxgj2lHUUfzgpKiXhFVTtSJiytffHxgm1csQQxI2xKb2cdfR+rMPzVkO0LOIXTPBBLxo23h99l22WYsztbVL6N7UcXLdmywjf6R76pLPp8HDfIDcv+/3BifHWHUH4YGJv12p00EaDyiko0IsoOUxGkUQ+bC03a65CbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A8QGpNx+D9FWD+Lfwvrpsd7w/EsVYuthnrgz1E6jUU=;
 b=D8tKJqnCK+zwpn4in7ECBM1KOs6y5b2BzoBvtj1E7jnD8bGuv1Hzsc225dIktZ0yfZe6yYZbT59l81f06L0tiRRh6jwqDrZtDNtdoaR5aWUhX3xXK4Mp3h0bSd5gowM0HmgE3ruPBjRrx8g8lprH/x+s8Mt6NhIQ6x9URYAmHDg=
Received: from BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25)
 by BN7PPFD91879A44.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 20:06:12 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::af) by BY3PR04CA0020.outlook.office365.com
 (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 20:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 20:06:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 13:06:11 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 15:06:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu/sdma6: don't do MMIO in MQD init
Date: Mon, 6 Jul 2026 16:05:58 -0400
Message-ID: <20260706200600.15071-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706200600.15071-1-alexander.deucher@amd.com>
References: <20260706200600.15071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|BN7PPFD91879A44:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d7cde1-bb69-4bab-526b-08dedb9a06a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: juO9Bl+or3TVyc5kDJgQ1Pg3ovDBdvfL8dF41yyk2TAv25c/GcP+uMDm+X7Sm51rjbY2mo23aIgexnvj71zNi+ygzUlpbAfYrYGihZyUYQ1Di3g7qRWrtUsuUgW/EUgwHDyZhp8qIiuKF22HA+QGmjw7V7u+PSRFE/CFq1FA9vfZb2JfIUZ9apatLTrxkRZqF5V5sw+4sRv19MJ0W9/DYk9rvEn7wosjSc93kenaYi/Z+R3YvkcheWrW8JlmewGj1rIScw6ltiZxEYtABLqruBhqoC6C1ZARXVMhcaujc/wj4DOzn+vPS0d5dqOs27o7RyOg4IizAEYtiBuO0vOlG2qD0moMoDPFj/0PUjZypnu4+YyS+sGGBdwEuirpnRlawOuGMZMOCwolY0L3zmtuIwTnwprqMyJG42+m7Za/gMesCQoQpgCCFbH7dhePUvc/vZ5S28HIxyT4i5O9x3pVdxGuIgy+2eYmScNhjpw82hOYsQUH655Gz2ZlMdFH07EeMthn1n+b9v2Z8MWLrhbF597YI9jo4Gyg117DNU0jsU9ls4W+tncq2D1ZSUHuVQCsrZ2E72ecONRZ1HbNaOhFYrKZFFzxp8xvSDdOFTWDZ1muI+ygj9QOhDfI5vpnVgVbVQ5eSkVBHD1jaCOu77RmGICuyh7SpFNFBDELtbBuFBOTrwH1/zO9FJaR4GHXxdAOXVHoZgxaNhXtRCJP+lxpRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /jKHpIsEOeF2yjG+oZ9ENFggb/uqyjhNCULUzQHCndC4/eN1Gb2RPxXUxUupVxGfmUXLC03q7zWEQOQXG9l/vOTKk9TEeLy92HMpNtfmPucIlf23R3irSLgA0VG+HzLwNHJOMel05swEzpPTHo0DdY0TTUFfezrAj2On3VhH02GN+6STaoBtAj6OmAYjPCxV9fdKMDCGXMVDWQdJml5veYVwTfeSXWp9injlC+ZS8PSLaHi190goTQWc5SvnkHKrxOsvrJbjLpdntiUjdTjU7EbM3nCSamDzi6I0gZMrWr0fD/aRk9hBCH621P+25yR6GLFqGEjWKQYNGrwqqfX7YUsBW9efQKWB4WJg4stftIRngCPvTtaZr8MzC4EnAHIx3kSVavgMMiX2Y95f9l6DoyAlOi/p9dkLgnI4ISdSGX+PrgJXv8y0IbkJbJX4HHKX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:06:11.4848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d7cde1-bb69-4bab-526b-08dedb9a06a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD91879A44
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

There's no need to read the register, just use the default
value.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index cf3d2997fff88..51e7c825b8bfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -860,8 +860,7 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, 0,
-							regSDMA0_QUEUE0_IB_CNTL));
+	m->sdmax_rlcx_ib_cntl = regSDMA0_QUEUE0_IB_CNTL_DEFAULT;
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.54.0

