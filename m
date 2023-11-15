Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9389C47072
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 03:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5856B10E38A;
	Wed, 15 Nov 2023 03:04:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F9D10E38A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 03:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPF+KcAok9/3VrjIMbHMbhOCqsac+E/3w0Yet95GJpPeN+oE0Vf1ckd1lR0l70Uk70C6bH0jqJximAKpM7/HTwlt7NINHE+T3GIDo7eLzs6wSV5+51H7345W6lvzF3mQABeaVZ308Xjzdh41dmIrJLd81CHniZQquZCYEX7uQPtq3vs6P1fL+opwt9dmWBN9iDLMxo/gZBE5Y6/LNG3q+PY9LQ+O/azrGZ46fc72Iyh2VpiUzu9sBBheuZRh8cOHGFIAnQXHuLLhcjT/xd3sx53qEZweHMTh8qnCiOgcyFGX+dN+cSI6ShoFY6bprmYaEBDP2s9Zm/6q0FMZ/962LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X0OQSJuVTFZMl6PyC09bxIqRzEiYIQhC23NUIyC91Q=;
 b=lXY59rPy9BXObOTcSGQqXsGlvXhAzx/fhUUkUwLrBpzVer0lj6RxrlWdCHYkLdyj2cxv+xv+NTEO4hlbJymK8muavTL50netLlq2zfsV0w843AzVDYg/pB9dtMneGbcIrHBa1LLj46o4ggPxKPLdzPagCnH+xuwi3t8t6j1Ec3AEG5CO4DFurUrhMyvvVlLofJ3C8YZb/8r5Z50VlG84vuMMb7uUZpfO0omVivwqcNLUHN3/tOMx4zPZ1F3u/cISPJL98V1Z4pHrSgj5G1PRc7ieNi90TQgl2s0mRA7DPZynWAP4etDi4iu4Ssv+rbSf2LTLt9sd/su2m2/gUwZN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X0OQSJuVTFZMl6PyC09bxIqRzEiYIQhC23NUIyC91Q=;
 b=1RcQP6spnkmT903+CVcemcIXX/5iC9MtvMw+vy179h8OkSL+QM53mu9N8KGKjtB6w4l4We8v7pZv6159agzPImNc+6mzO7/srAK+rwUfxzXFN9jy9ZBDQD1WRHwsUb2IlnnB9rAbOKL0nb+HFXI/zSLrW+Pm5Ronww4f5FcXWJc=
Received: from DS7PR03CA0207.namprd03.prod.outlook.com (2603:10b6:5:3b6::32)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 03:04:45 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::21) by DS7PR03CA0207.outlook.office365.com
 (2603:10b6:5:3b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 03:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 03:04:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 21:04:42 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Don't send unload message for reset
Date: Wed, 15 Nov 2023 08:34:25 +0530
Message-ID: <20231115030425.613561-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fecd508-0643-4734-8d81-08dbe5879ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTIps1js3txDeKWG/3hpwIaeLGUTPehJEKKTC0UvqSMbEHMDa06jffFmTTopKkvLUdJ3C4suTSIYbl+niUFxLhEpppClDN3zL5VBa9jN8jKg9b7zCLv3yPzX7fb6gUKTvc3slNUntx9CNBazBRGuCqpoB3NgqtO3NjVX2lmFYXwylSL2sTPrVVKZcCduT2MdBgYZOa6uoQ6QqfxqEm9iY3HG81BWxbfsdLzVLrrxK0KwSBwnXjiz47C05Bgbgo5QikVFRGee9+tpdbYNUqSphtQLN1FpgxIzoLtOoUcpV5krfMN8fY6zVXKheluOTh+cgr29yJgphJOeoWK64kgybR9OnahgPnTux50eA0QY604ceAgG9CL5qKySa3g7Nfb48pIjooTLotTtNw0ZF51JuV5gOgxy0vsU+TWjtOOet+14wdVwkbfduuL61mI4M3ibgZVi/etsE4aC3vB2w97p6KbvCiKNQpykp3zD2IzfOhPKCZyTtDiIJrXtlGkZ9cNafdTGM9rx+oWlfWy+zKHTi3BAV1f313jS0GHLWkncWRp21uQT8ApDFIZHbYkT7RaV1DqEutvSK70PNlaoTgHdzHU3glEpuYXUR0N3bGXFG90L7xWCS5pmx3Yibo6JylbpxLZEJgyUHNqutDrAqYG1dfAu4o2dUYMmwRDXs7bsb0/s9C1nYx5HfsV/1pmovTyyo+TvsCPBD23IID+NEwBh47oawrOwjRPS2FuDCJe2pCgUPcBFlFxjV9EEYpGJ60yWgUdtDXBFoy15MoqitUUZEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(478600001)(36756003)(81166007)(6666004)(426003)(356005)(336012)(7696005)(47076005)(6916009)(316002)(70586007)(54906003)(70206006)(41300700001)(40480700001)(83380400001)(44832011)(8676002)(4326008)(8936002)(40460700003)(16526019)(5660300002)(86362001)(4744005)(82740400003)(2616005)(2906002)(26005)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 03:04:45.0301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fecd508-0643-4734-8d81-08dbe5879ed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, kevinyang.wang@amd.com,
 Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to notify about unload during reset. Also remove the FW version
check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b51cd9e50e64..d431553ad8b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1500,7 +1500,7 @@ static int smu_v13_0_6_register_irq_handler(struct smu_context *smu)
 
 static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 {
-	if (smu->smc_fw_version <= 0x553500)
+	if (amdgpu_in_reset(smu->adev))
 		return 0;
 
 	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
-- 
2.25.1

