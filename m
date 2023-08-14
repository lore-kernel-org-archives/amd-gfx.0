Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8219C001DB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 14:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D5C10E10C;
	Mon, 14 Aug 2023 14:28:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9BE10E10C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 14:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk7NZlM7T2zc5LlJzEApmPrg74nxNBiWwQ5qTCFfMlt7ky9RDxfDOPbItj77cctCUpE7al/Q/amOZWZ68xOdErpOsEBDCVxgcsEI+sIcyEIeZSlykr7QJPRwXX2acNb6qyC3xxZ7uGpoBLMWWGKZ+f3J+0Qhdk8p3+Y0N0Pu3d64M3J3dKObfMVunbpYp6ro3wlIg7m6zZMbdrT2mw5GnwmQsdbRfBnGWhRbzxIchfbtFciMVMquM71m8cjcivpL204CDrDm3lEr8v8t3NaGUrypZuj3TFr0fFIbSzPl2WS+ndOi7FSeFpVpoCErYY2X6+rleXtIkLwPFKevucvYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jvw3wYiqKn/a96kVGZ8x26cRtWHcIrgK9+8D4hg6S2U=;
 b=DoaI6iyHce8nLfhvPLwP9UtnqU3nGLL1uQtqlGeMQqvtUQmL4RmkkPOFAtX6DdxrwnRw6qnRlJlRtkkg1mk1KRvnyLQFa7Mb3sX2QC61FxMYkdXYlDx3LOJoojtlxPdIEkMQ7WRaHHgM7aEF6GGuOx0PdTyxn/nIlY3W5qnUZQGokQPvCELW1iB0hr5IrqvrCmlWqszM9+RlvMu34hHbCzNEmEhUhSP7pu23gJf8h8YEqfND/Lk+IMg7t8BbU9oAmLBdHgYcAMtRuRKkZfce51TqOlP7/Y99a2MaAaC9nnaIDZiKaTlCvlFh4LuUFwIcH4QgwgKuSTGRvNZ1BLkSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvw3wYiqKn/a96kVGZ8x26cRtWHcIrgK9+8D4hg6S2U=;
 b=Z6AksaLdnZmNQTUQTxbBOjqXdltn8nJAxAi3OnYKsMKMHGCaDG2llnHOuWoLVlWP3ZZhWZKafRuMFcS7xiZBXSfxop7fu604MFG/pwoJcu/znsVBBW244IcfmDqnYefq9HMR3D5MKyzYAYP484AuNWYFAVEBX9Hr9uz5BbvnFJg=
Received: from DM5PR08CA0027.namprd08.prod.outlook.com (2603:10b6:4:60::16) by
 BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:27:56 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::c7) by DM5PR08CA0027.outlook.office365.com
 (2603:10b6:4:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:27:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 09:27:54 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove gfxoff check in GFX v9.4.3
Date: Mon, 14 Aug 2023 19:57:35 +0530
Message-ID: <20230814142735.677239-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 424b1ec4-999a-4b37-9265-08db9cd2a71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Fqs1OdYyvDsFEl2EzUX1eCrJuvU1CNHkcsca5tEzEdftior88DnU33Ui4BdtQctqgYj2TcuzeK9QGkEFtEqZND/VnTmjwKY95f0j1O/5yDSPMAV+69N2hU14jMUj3lcO6kur2ZtXfaHQbS/DcyMSKf18y5dijhANnM1g9LZpuXZbpQsIkf0s22pLdQhRQrnnk5GgquRfNJ/iaB2zD+en8WOboK1cHvZc2M9TYOUotyCwCRYFLDqgHjkyUlptZRmjXc5clqJb/S0qO1RkbDpHoYX8C52ecj71G3W2AGAnjVaqsC253K9V4GNzyW1jZ0/HtGyGTSwIzSBhhFgvGYP4z43ZvjNlb1zVnVy2wG+5gAN5a748W2/YgfUxs39hX0/q8o1cyo9LLnDhXgHaiAgxiSYvAsPKhe6IQqgETpF/Q6AB1WfRWPWVtGC3GuMNb/izcFvGLZG4JiMz7VIGQW0DMxX1+97tbgfBGD9KsAfJ85n1gRo/cf34aGM1wi2o+zU4xS5PxzIofNx+naVWSS4CLrTP+rpA9aeZN97M1eHqE7k2H/raCH8SgE1qkEqDiT/TJx24XgW3CxH85UkX4QbUpLYL0JmTJ/9vo8t4ApkUOT88upOsAgzMtoD7HuLD4b2zRDhMcUFU/khpJ6YHHs7lwBFxq6/SnL/ibSa40TUayCMOlWdXtqc/V0bHPT2C1f/cplV57iLfwkYY8F6gG+SHccv8yvfZ8SZiYqOxOD69iKbsM9QLTrGPEJ2y0qV+KD1+DhZQMKismpNcBX4MLdmSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(82310400008)(1800799006)(186006)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(82740400003)(356005)(81166007)(36756003)(86362001)(40460700003)(4744005)(6666004)(478600001)(44832011)(2906002)(7696005)(1076003)(2616005)(26005)(336012)(70206006)(426003)(83380400001)(16526019)(316002)(54906003)(41300700001)(70586007)(6916009)(5660300002)(8676002)(8936002)(4326008)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:27:56.2827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424b1ec4-999a-4b37-9265-08db9cd2a71e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFXOFF feature is not there for GFX 9.4.3 ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 564770c3875e..4bbe9c5ed87f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -337,13 +337,11 @@ static uint64_t gfx_v9_4_3_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
 	clock = (uint64_t)RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPU_CLOCK_COUNT_LSB) |
 		((uint64_t)RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
 
 	return clock;
 }
-- 
2.25.1

