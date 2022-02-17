Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19207C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 17:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9E310E6F5;
	Thu, 17 Feb 2022 17:08:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBAA10E6F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 17:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh87l2yE0NGFVHgFVWsGeFWioikGblOshGuZx/0RxYhWNSWmuq7jcfVU4g0DvZJGIoLNsFvLBBsZf/Y84pL98xgzus1elieQ5LmPZRacW3QuMVQ9+PCjvLGJOJCiO2Xl6EEnvZrMiaMse46aCUojSobw8kLhXeK5cTqfBBzFZn6K6CixasA+bcJAVkEpvg4bgn7gyUbL9bMC+Xshjcy+nHdTm9qLma6ZoJQrxnpx7kZNPDkKFx5ZW06N6SSMwfSLO3avZMnH1mfDI2GqdDAJ+/R5+6bOSNMcn+ppgwKiQtu8j6/LTYgs3NtonRaoXWMNgyr4zlQuPro8SUlycWZJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRWjP2hU9hW+3n+Z2Awg63XeEapM6bJoPaJ4wW6FEOU=;
 b=ZAcXLiCnmw5ATqIDb8Nlcz/RWVExEKr0xIR8mpNof9vi9IFLexpypz0ydraURIIqB/TroNlmOIQiD7/s42LgLi4sxwuUO2nLR5gZ+OYvW6eXKPAWYgOh7wwWrlrv04RKAQWi/UIzeZ42lYtYvgoJZdN1oAAPbXrFoo8drYKJmbS/dtgECBuq+YPagFhB3pSFG+/zUCNocjAi25f60N0duR8/NphDoBhHDIswqTioQS1XV1+PiJpILVak2rzv3GM7qSBqUMGc5IIvBgVa+DkgHQ9tHibuBfNQ3+dNiom4cGope+K0vb1gfgzxMIuRQQBYzSXmHXOtJGUjJHwBZzFfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRWjP2hU9hW+3n+Z2Awg63XeEapM6bJoPaJ4wW6FEOU=;
 b=QJK68uJ9kg6PvxQ7Dqr4yYfiwovXQraKdzh1SEBoDgLx4/uMwatQVkV4aiUvSoIg132Ri1MMbfEYr6a+23HLzPjJriYltLthvqMGZry53rJpSNzS1mr5yfCQafX3cpQXb6rjPpNPpU5h3KgXuumYNe44QCei+bheM5bEHPYFoGU=
Received: from CO2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:104:2::18)
 by MWHPR1201MB2509.namprd12.prod.outlook.com (2603:10b6:300:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 17:07:56 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::d6) by CO2PR18CA0050.outlook.office365.com
 (2603:10b6:104:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Thu, 17 Feb 2022 17:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 17:07:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 11:07:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support for psp 13.0.5
Date: Thu, 17 Feb 2022 12:07:35 -0500
Message-ID: <20220217170735.298254-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cecdc6d-7a6c-4323-e52d-08d9f2380ade
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2509:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2509AE62169CA71BC28A077FF7369@MWHPR1201MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97MBxzITl3MWLLoDvjnMDAARVxzbyDlmkZ1245I0CA3l3zX7cqN5LO/K4HqPgBWcKRaf5aOIO8vDcZsxG+/r+vraPUobDjZcAEomIm+hkZoeTGSfBuNH2QrYR8EOYFHHmbMSLCOEQMH6eG1RI6Ky7rmtCZddrhcHSoWlU40Ix0PZMHuA4jg8pom8S0eTQWCxNUBbPVmCwDlkAKWoL3eJtzQ2nJrbZsD408fjSSoS5Bjd53OpEgT7sYY2HlpyzJTSvJq/0quQ9YeiNEJwXJJAFwXmkQNQxOxnfRJBLlF7Z5A2mB7NBo5JAfexZQvUoPkL/1IWgPpp54NSrKB3DQGNU44rcp/mHRQxjg8fXL/M+hoD6pX55HvPKfeJzxyz6jxVBgIIRemjM0EJtFuNnAi3wkmK+tfLYiDGnjD9QVr6Wo6m/xpj/9sUm1lVEbX4X4GD+F1sYbKyklhuMzejclIAkhKTrr+NJDUhMsJKv9SK1Nag/9Hzn7d35qyPhTkH7aL+aGRiXS+oAmJ9J+DY+E/DaOU+efZbZWehO2mBthCyrV66wMx1Wo9fNw7/tJqS+nPDx2lnUxXdy691zWH/uDn/Z+E0KMgsiu9vj6w7Bk7z8f3JtERgT29zSh46TwqxTuR8gRnwOgFifGl0gSUf4bfgxW/BxXwI/rwFscXd20JQw3N5e1DtYSah57gat7cSGFYLO1Wu6wQOGtQjSXURErm6sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(70206006)(70586007)(36756003)(8676002)(16526019)(2616005)(86362001)(81166007)(356005)(316002)(1076003)(6916009)(54906003)(8936002)(186003)(26005)(47076005)(7696005)(36860700001)(40460700003)(336012)(426003)(6666004)(83380400001)(82310400004)(508600001)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 17:07:56.2387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cecdc6d-7a6c-4323-e52d-08d9f2380ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2509
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

Enabl psp support for psp 13.0.5.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2ca94e2c54f1..e07cd65a4d28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1297,6 +1297,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index ecbdbe3ea4aa..94bfe502b55e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -133,6 +133,7 @@ static int psp_early_init(void *handle)
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 17160849a811..2c6070b90dcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -34,6 +34,9 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_5_asd.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_5_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
@@ -58,6 +61,9 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 3):
 		chip_name = "yellow_carp";
 		break;
+	case IP_VERSION(13, 0, 5):
+		chip_name = "psp_13_0_5";
+		break;
 	case IP_VERSION(13, 0, 8):
 		chip_name = "psp_13_0_8";
 		break;
@@ -75,6 +81,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
-- 
2.35.1

