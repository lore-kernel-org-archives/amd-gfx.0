Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89635C7EE2D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D0810E50A;
	Thu, 18 May 2023 10:53:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0951410E50B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf0QUPxIjf0WhfOHO+yO+9u1FhUBx27DPMauo3DzfEE7+JlO/LMqfMbxrGgRHnMJtdpc2BdtCfsjuA8hLni08D4tccZ5XTRcpliDzqnw5hLRg7xGMUPvdhpmGBacCNrMSwVnkOLdJVWk+NjchWodh5UBVFHX0GtFNgpoex7R6urgHsWyX5tC0BPPKttuuCHXgXujsMV4JhEl8XXOYrcNWfJ6eqys8W0UfcNZ1sEUVIQp66WHRWcmZFzVhK0OGAJFEzX3IPWXZQqPe6/TeWz+g99lUEPO38Af9hHTGtv4DwptPM7HxWiQ6PGIAx8ERAz7GZ4/uvLMopL+QsAMbVzSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eC+GW2ppmJX/ZLGSY0LaemSOzgg902r+5sJJswTf3qI=;
 b=HsaI/Mk3PhP23NbMM+s4DapGhItg3T5R1ID+6FUNmaYFo0cREPPqQMm7UeLawnCWFFSaIoe+y5tonySPvRcOlmnhlmm397/6ZfHxy3gZEJeUDH6RK5q0a+mjcOwYYzMB4DMTw75OXMWQcZoPjkT1up9xa3HNKfAhvfkspZW5oFoRWGdBcUB41HjSfdG0/Lhy/3NxOjtWBjhPPMnHP1osAGgodsW6um28bCUmWSbj4kzROmmIzxjFQd9/VuyJGGXGfZHToHpfvDAtPKynNObc6NqhuSLBrlbY7yEPwgU4u5dkPzn3tI7Y/ymiwlrQmv0UCCI+gzOqJ3v9to3MSo1dFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC+GW2ppmJX/ZLGSY0LaemSOzgg902r+5sJJswTf3qI=;
 b=vORmaCCI0B87iktewjSGaATcJMcXXv1xpGKKF44+FPeunIIXXfMqFLEV5gSnAIuNXkwwTf63f8yW/xrFk3LioIFh3gmOiU1b/jP3p3crqNpwCoc4GVR+7x5ys+6oIH3jQCgm7xqavjHM0y3vijlppK5o9u5SeHHtgC5ZAFGh8ms=
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 10:53:50 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::26) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 10:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 10:53:49 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:48 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: Use single copy per SDMA instance type (v2)
Date: Thu, 18 May 2023 18:53:23 +0800
Message-ID: <20230518105325.15609-7-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518105325.15609-1-shiwu.zhang@amd.com>
References: <20230518105325.15609-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff640f8-096f-4e86-cc58-08db578e2995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f80lVTQ31ZrF4AHkVpZiRevB91ktt5UAtSAchH5Og6+SJBqxtDczeau2cjq+NdZ/gaiU1V1ci24Be+c2+c0VvsIcquqfKieC8ErUf+v/JSArwWj0PLIBYA/zz0ZP50ptxsB3otJtUVRHIy07Cg3tdYn1HR+MdIbBS3shGeTgliS8pnBGRe7GxxhXd1wMaFS4gPjTqwrzsayMPKCamNsLoztxRS1L1IgOEfdB3FpoXgsY+ffZ2WkYHt8zBLwPhXsFfz0G9/i5ETtWLP9PgWi8mtt+1aHQxqijuSP4M+ootMzdwKMkydFDoh7Al9IutzzIo9eYFn7hGmI/6wVUWu3waFoEGu/qu7x3lC1A+AHmstFy9iqqVlJciHubvDXaFojPV+Lzb8kQKkWxe0A8ET++2SGsHwCcm9OhVijTvwY9kfxxK31zegdCKSQ4VRouWS3G2ZGNgH0oKOo5LjYjiuIqz5Fjpulz5x1Zl1V0ybnTT6/nBy1dF3kdaYKcp+L077wo1tq66RbMvgnRVCBYkv3chvfr37onJeJFd56lc6TqveTS/+ApDSjvMSI0ZSt6Pcmk5eZZ02Q8SYxXL2MQJ3fim1UkHvjo6BRIYDkd2cHq52Yj7eXsCruoCpU5fXp9Hd0ZSNgq3w3xdECTX189ZTrv4LQAFYSSIrzRdivK2mwFY3igCubsUsgs6Gyx+BJbIm8i+rA4Tq0C/GAg2IyA8eJftHpvJC8CdcpaeVrkhUMd82shTw+CNMOATsk63QGQc+8MykT7gq+M+HfEXBJ5M6C05A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(40460700003)(41300700001)(426003)(36860700001)(2906002)(2616005)(336012)(36756003)(47076005)(86362001)(82310400005)(81166007)(356005)(82740400003)(1076003)(186003)(26005)(44832011)(8936002)(8676002)(40480700001)(16526019)(70586007)(70206006)(6666004)(478600001)(7696005)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:49.6306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff640f8-096f-4e86-cc58-08db578e2995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
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

From: Lijo Lazar <lijo.lazar@amd.com>

v1: Only single copy per instance type is required for PSP. All instance types
use the same firmware copy. (Lijo)

v2: Apply the change into amdgpu_sdma_init_microcode() due to rebase. (Morris)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 231ca06bc9c7..1797b45d0b55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -252,6 +252,13 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 				if (!duplicate && (instance != i))
 					continue;
 				else {
+					/* Use a single copy per SDMA firmware type. PSP uses the same instance for all
+					 * groups of SDMAs */
+					if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 4, 2) &&
+					    adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
+					    adev->sdma.num_inst_per_aid == i) {
+						break;
+					}
 					info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SDMA0 + i];
 					info->ucode_id = AMDGPU_UCODE_ID_SDMA0 + i;
 					info->fw = adev->sdma.instance[i].fw;
-- 
2.17.1

