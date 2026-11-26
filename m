Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB195606A69A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uAoA0ugT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04335112246;
	Thu, 26 Nov 2026 09:36:43 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B02F112245
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB1VMbWoPFHHpPI20h92KDqzvIzqkaGJdRgtf5LLPAkXbVO8IkGSJemKo7Gk4rQKmnRVIF+h2fdkceh5iRJF+4E0rTJTCfNV1NbsPTvFWaS+2bRmYhpqYDrwJ4E6768zbyRhN1nyu2C9Yifwb2Nq5U3L300NykCtEJmqAF7Kx6M1aPlFHNhbx3SDDnhBN+qRGgxCgGqjvFiBc7wqPfVFWXSIRqv2P24Ba7gmwyZiBd4xvriCw029UxFsQvY0QXatLQ/5J9Vd67nEJ+NPT4r9PwPkbKsH91WJXkd6HGnXjcSGYf4YRLqQLxeESbDOdp6aPZXTps55gYHI81L3c0MevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycwEIOdvspGHMSqXdA+KRDS8Tb4jJ31Qv/yImn6yCho=;
 b=T82C5t4+qURgxkaXX079T30xXjlKLGX+FU3atlzbO7KutRNEDcYfvkKNHlJQmHLBrwrrkTtbmZhRcj5hk/xE0Yx4c5mHiSf4NGPd8Lz3sh+fqMFXbbzuhL7e40GtDTX83VkP7jW1jdfqbDjtdD0ASxX40MB9ehLXQ5p6xuVnBwLEZE6DiqtKFB7bnDWj2XsCjU+22xAnAVakJEj+xlCK67Ym3QiEsu5fgBLTFx/jv5PKOAuihxCpivXXdpApT+IV/DWWJg/07rm2Ipr0djk6nQf1eZHCsurCR5gQWp9DeEGzk/sG11l5Zs6op0TZx0h3r0RxqxstQVfk4AiAs46cbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycwEIOdvspGHMSqXdA+KRDS8Tb4jJ31Qv/yImn6yCho=;
 b=uAoA0ugT4dpVnNCQbFQBIjpRB3npTM1t5NHAUpkBkI2IhZVIMBnHUHL8zSCWhpnHNU/UyiKeTudujfqWcCJF2zw9lupFFgV9+A7Pc8SanwHVfFX5cVKXzgVbwThLKcpCG/VL/0Yo193M+IlyOcOz3FVhYOVXBGA5cS8/jqKGQ6k=
Received: from DS1PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:458::12)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:28 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:8:458:cafe::65) by DS1PR06CA0006.outlook.office365.com
 (2603:10b6:8:458::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 26 Nov 2026 09:34:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 26 Nov 2026 09:34:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:27 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:25 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 02/15] drm/amdgpu/ring: During multi-queue reset,
 only call begin helper if needed
Date: Thu, 26 Nov 2026 17:33:38 +0800
Message-ID: <20261126093417.192538-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 257c9d8d-90d4-4e31-b247-08df4ba077a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|261022105027099003|261021123027099003|261026140227099003|261026121527099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5X/yhk7xDPaZwlbV5SPxq8yJtv/i2os/tUjcYhFKc1DsiEJ7zqyvChWuvHa4+mTAwy9nGu4S8rVMIGn4J+iVTQTnaSmqtm/0dwcDGwIaBXiMyj/lFAIIKZIwy/1DGY5PtWUaa1NUaQdJxvWNjjatjQdiElFWJoBHvOvSSCNTt8tVJvCcrjVF+4qtxRmq2EvoKt8iPLlU9YBeWZ1X50DGtveooz2PHAWMSZJyIDKmMdbNb+EuBN2R3Li3BzQBHtjmQ4K2QE1Ywqkc2GLMhIZ9tdJ3JORL3PvwP+MT1+/tIaBetklTGycrCrji95+K/fqc9pmvYccErb1fFKclDx9u3votsh6gyICxU7Bvc6WR3pETSXlgIUp9J1mwPI41cOqjp2UdZfTi4os0Htz7BeQRfcW4Re8l38QVkTkyXlQqtbUCpXRcYGv337/VQwjWVS+e8WXSHmWLpjsLQdEdkNvZpPmMrAD4kG2mvX+GakITW8rnXz/SfmLaykHvqTYwyPJvdBTHBq6xi3T24RWdWrpUrdS+kz2rfZLPsfz0oVQy/JLTmDoqGvHCCCsAsoNCIa1LQAL6zwP7MZeEE1UBlUx755XI0YVrwfkwaM1F0dpCh1GG8FeNiLxb6UnXNWxvMSqEO0ml0LiZiYdQSXzKNoeKneyWG9/yC8VXeD6GKFU9lcnCtSema/18qY+ZR+eGCejGOghYLPXW4uA5AkNU3fYbMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bs/Eo/V/Y/6lYBN/iJxE8h2HExpBEWvgIaMsAkGGlv99PC7C0p8NfG36qptCgMVoyW5IbrnP5SmWxzvmxmucjm4l5p62Mpk+F7rz+rg0wtFGPPEH4K2H1kUgpCE6go8suRKSuJicEvxv7mn0oTRIcHbA0txAWUHQjq9LnQ5oeFrxYPNVhj+VL62q/zSQw9vpNXCFechThCHS8ExbpVvMktZG+LV3KeIbTMOAeV49gmNqadeYxAYhhSLpDY/lWINJVEOHBYkJVLvyzAhfeoE5tL0x74Yx+V7YJE24g9GnPrG23vDMbYAKxNuEnRXQB+8IC6LSNxsV2OraK3OaVFCiJoMrrnaC90HhKVWLKb+/++Y0wRTB6N/fxQBWXuOxO8kHZtCZypCqWbXl86B05nqcyyvAxfgR5JQ1++6VDr4+TzBapHT0W6at7ruYfdmuYL3Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:28.3438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257c9d8d-90d4-4e31-b247-08df4ba077a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

From: Timur Kristóf <timur.kristof@gmail.com>

This is necessary to make soft reset work after a failed queue
reset. Otherwise the ring reset begin helper would clear out
the guilty fence and the backed up ring contents.

v2: skip the begin helper only for the guilty ring already backed up by
    the failed ring reset, and keep backing up the other rings (Jesse).

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index be91143d9aed..40cf8342eee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -1036,8 +1036,10 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
 		 * Backup current contents of the ring.
 		 * The helper takes care to only reemit unsignalled fences
 		 * so we don't have to worry about that here.
+		 * A failed ring reset of the same job already backed it up.
 		 */
-		amdgpu_ring_reset_helper_begin(ring, ring_guilty_fence);
+		if (ring != guilty_ring || ring->guilty_fence != guilty_fence)
+			amdgpu_ring_reset_helper_begin(ring, ring_guilty_fence);
 	}
 }
 
-- 
2.50.1

