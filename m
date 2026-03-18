Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AEE103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E42210E830;
	Wed, 18 Mar 2026 14:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0j1No3Bi";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012028.outbound.protection.outlook.com
 [40.107.200.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE6D10E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdSdzQniBQuz/t2Y13X5eCxKGeC7fV6na8ubaL6sITQws6I1cPKHr6JCw8xsdI/7fVKRpOGqab5QQ0DuiCNYMaWYSbXTV89764/p44++hqqzm3kRIiaZ7C+vddLhVKoy+2deOF2VG6i0VfIXeaaZpdTtresDnmE6IvgwQB4Yxeup2zJ5cWewDvrGMLScD5sEjBYumovV5B+7J0u0YXJMhNskLwQzO3zUJURbc4TWLMJWstbPMYxLDlqoLLgXjOGc0ZDwHJW39RSqoXeqLV/089vBm+E2YcOQYXxs/aUmh+k0jTZ/15DBmWpefBUemtBbrpnZWJPp4R0/VyAP6iIZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaIs2GC0EHuTHhzrk8LMykqXADQ29OOTpySJwBeFKas=;
 b=v8uBYzTb6uOBHrb/5fnmYnBmMq+vNQMsL2Kegg/6OYHPvNyKSDMXtRKMP8Afolx1qFTO3jsQ6HdYV5b0bQk9L7A6XsnvPAZJewJ83mEJ96i3d0AMGGSTR6afYbyBTNn3iPLY89liXoKqcXrKLKGuEj3ZJjGdVB3rn4yXtTOrsbQJ991m+ugtUTjhjPe1Y31YzfOw4hJ5sP4aCb89K6V5AOoGkwGAJ6J0h9HdJSlpipr/Z3l6Ldu4h7x2oSasHs7bXUtU9RQcuJOckXkLgD+Fnh+ppldHpt26rimfgoV8XZX80NpMLYy9yGaqLv4LUbSe1ep51lXW6MvmeUxleWqpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaIs2GC0EHuTHhzrk8LMykqXADQ29OOTpySJwBeFKas=;
 b=0j1No3BipeycbGoS1if6y84QQhkgC9MHDOCtsJISw1YHlZ/AtDDcXN4R81+rnW4WIiLktxZ2CKnlriKaVJfz60t0iuYkvbrw+5IojfbygOFXlBSygjYBapAJ/nqTr7kiarOheCNaMuS74W5XcMFq5O1GJg5lWnaRl2XJHse83ng=
Received: from BN0PR04CA0149.namprd04.prod.outlook.com (2603:10b6:408:ed::34)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:09:03 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::6e) by BN0PR04CA0149.outlook.office365.com
 (2603:10b6:408:ed::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:09:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:09:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:09:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/16] drm/amdgpu/gfx9: rework kernel queue priority handling
Date: Wed, 18 Mar 2026 10:08:31 -0400
Message-ID: <20260318140837.582776-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: e80166fe-587d-4ba1-019f-08de84f7e931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: sYDTKsFQN1of1LT4RXQnQ+OAcFhvzbXr04/2QaAG+GuEgsHTJyqoFRYWqJhfW/VPbQ51AqPh0ep+nE9pSdrSlE+i+GOWlIl1tUf7cfnn7T9ddscjX3DzfaLDhj6XM/9Kk5qgofJKeOYvpGfdcKlSGEJxk6cGr2LlCPiSEkYWpLUZPL1Asg3RkxW9QtnUpVpdpv4FfmdoMU9a2m8pDnzmbiFr/tyAaWxHyqYEPo7V+HCXzoI5plr74OIYgbMRbuQJgjHKgggk2B6SmYaooAtF25r49Rmapd5mmmZDlkzLkQfI6cdmoQq7SoezGGG0kBQ3n5OWQPkghsofMhMaKsHBxKzwgkXVqgCHMgNERX+Cj0Mlw7ekieHlhbPsJn6kC+k/XhzDKvdsBTM0AAurXSowIbLKgtuBvfcsy/7SP/hwq/4rAbSzEb+4/Vljj1+Jkb1h2tzEzdNjW8iMKzUMwInKj0pfsl3chGRmgKD3rQHTr4ey8XATnZFSSsd9X/HZNtJHblXYtFfYlCkdlBjVPsPPdpKHr3RZvPxLgvDaJ2BHBE4AUYmcbnmFm49/ZywtvrnQmZf+QZqv0/l0sztJFCn0tjk7GEBIM4l89w7cYveu1eyfg3Xgwmyvv0U1x0xGlkX9xfkiNwpWX0ElwedEVgWWZfjoCwhJhctfRCHZH/MlhdvoKzyXodtvlYBo+cqwLg9Dl8WMopQlgkUHNdhtsDq+7rNpjEDH5AMGv2Unh3YzXkvOCy+5/o/GtlbfUkql8A7o4keg0keynV6VJr6TpKUbBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L6kKrmbCTgwccTDz5ZI3Kt/RMoZ7tn+zsUI7M09NECuh9BdUX+IzT0JJ4hyNzRYZXeu0UqXw9NRitK3MbO3fadtIeJ5he320dxtTKY1pJtapgosP+F3Fl7uAUU7LldHjSrYTszNoHyvdFDOYE0KEtWElgDzGu44sf8+9xOgra26YisACJ/eLl8+PHVhLkkpqC8JmojdfiCGQ6PHKACJc3op/ef8cmmxwyhV6TsPLGbGunJAN8Ei7AvPS/hd8aN88npvdC2opgDrCIbiUHlYvNKfWj1r+Kh4AQuyzorgMF5NHkoe42bf4tho5FCz3lFLFk35m0wwro2sFMfjAwNwl/mZ0Eh90p8E6qmEM2MlUGmZUeB0YGj8rFcY7qogGBdrRJ3/wud+p3f6nmjLcZATkzg4uIyj150pVAZrrr7rLkJTehS+kZHmcPm11ZrEl831N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:03.6845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e80166fe-587d-4ba1-019f-08de84f7e931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693
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

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2eb32f92a77c4..aaf75c82b1bf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3670,7 +3670,10 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
-- 
2.53.0

