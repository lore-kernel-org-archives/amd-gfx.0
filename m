Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C3FC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 22:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D69510E931;
	Wed, 21 Sep 2022 22:30:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92AD10E52F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 22:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqHk8p56MDCQ4P9Yln6ZLXOTUCW2bnPArAFOJDcqOaW0/QcEWykvUAk4vobHTZwZv2Jy+aWmomiuBH4AKWL579BCP1M/ZGdilgqiqkH3NNWTqbSrS/wm+p6mkxQXxrt0koK3ZxkWO4mmbgyF8qjucmfHeBfBkkggY3SCDNi2N6jNoa0JKDjqwfdlnquwMXqHGjIWhWC8MXVMvyrlu8iP2H1gC4E7xW9dP6FSiNKhsW4rMOaqeGxbR6MeXTHh1Bc7Doo/FOGuRQKFtMw2LiyhTWXukWyT/p1dGixV+fpcCENM8grP5+Q4k9n6qKCAGEPd+DkTKj5GJ0FWnKTAEtTPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPN/iUwhK9owOLWRKDakOtVbaIHUqTS8cwXi3NFAuOM=;
 b=LBOng2NQaTR1l7J7Uon8VedF+irRvvZdj+QcF/s0UOO1sS11E08MV1aHswlGtQojeGcOaRnSMeb/n8z0b/I8f9PhjEgT6GTOP/DBkQNiPrYIXMwZLJNZOAwJUjyk3fd2fFvYzluiyxkYl2rYe2uLmzKn8oI2su1r7JTm8X4OWQp87lif/Fsfbxx4Da1DnXj9hv7rf/P2F4R4JTevSbCVw9YCWIJb/8nl/0ogMBjaLNfg/AbnS6MiQf6Remzi32BzE9ICtrz1hFDrTe1mPYEtxvDlVU4fGULzp1/q9kHFMIAOtSt83LW1/kA9siW6yNf4EU/PfFdXIPznlC9MtKcmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPN/iUwhK9owOLWRKDakOtVbaIHUqTS8cwXi3NFAuOM=;
 b=y0kHvyo2LDtobpb05yNvy7yYkvDrAzKUymetuzJnxP4hVUe9kBptPMe5XZApNOR7SK0mPrJ7N87lTIQ5QBSV/Hj5c/U8l8uS7KoIr4r6BILKj08CVhsyIgF49t3muD+yZ6rNivBjRb5Ekeaz5t3dKQWrS+Qe27RvTCCpKBuGnhA=
Received: from DM6PR06CA0034.namprd06.prod.outlook.com (2603:10b6:5:120::47)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 22:30:16 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::22) by DM6PR06CA0034.outlook.office365.com
 (2603:10b6:5:120::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Wed, 21 Sep 2022 22:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 22:30:15 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 17:30:15 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Date: Wed, 21 Sep 2022 18:29:51 -0400
Message-ID: <20220921222951.677177-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 87af8542-8c68-42ae-5db9-08da9c20db50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeCQS/wYjz0roxFOnv7zBZcvcoQkPoqVWkrtZlwIOSWB8OELo/mG+Cq/Rh/ZYN79xUqvkrvW7AC9y1yIE/WLGdt6xRxvKGkn4nvnjWtwsL9a+mNjHh2DC7XYgOrCKCGxQEnzCD5m6v4gJSKbYhGFWAl/bM2Oc315+0HGoi/3yBvIoHW5EghlPTznFU0Yv8RxxQXP+Ux0ExhPKyZ7aowInZUeytztFowXfsgPbEAop/pwcs5BRZ39RhtJa9SzoJXQrM1sOoDry6s0uTeSbFF8PwJ9/BzGDQwxEIIN6qM9x4CZDhImR84XEDvuM2EOGcG65S0L0c9YuYsW/TUjiiLgk6zLJFjmeahjZ7u8Ckqu47HlyfPAnUl9zxa5qDXPt0V84aqTFKUUx45O5Jy+boSyz9CqWK2+hGyrdLdzjrEbTlh5szDCCCsN0pX0ciWm2UCKXLMJaxZj3YdnyotfFT09RGCVZY2PJQcZLaUUEgPOQQLXe/oRsMH3IOEC4hz6aRJhq0HW1SX9n0HxY4fXVlIrXMFszk6MJz7NFFu+XX+XIFMgPfC5OEduWYO9i4gLDX4XHUCL4NIHrRdDi3Lh505zBzfnDAhdpRAwLO6bpX/9VDXtJv47oas1+2gADWocGSHLMePBbW5OAyQUVAYg/RiYrdGAcs1FQc0QSscT9G1R4jGnt4e6H+OII9HwSOcf4WMEsBgoNTHrcnlzGzMyMC/D1CV5W0ugQDDrUopqwpU7ZgXjhaNNbNHIy3PrwWhC+uvAAbFV8Nq32w9MrG3s4rkEMzPVp8Rg8yGC+glYy3fy/Fu/tk4XgZBliFj/+M31Um59
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(336012)(2616005)(47076005)(16526019)(186003)(83380400001)(426003)(7696005)(26005)(40480700001)(40460700003)(5660300002)(4326008)(70586007)(356005)(8676002)(6666004)(70206006)(478600001)(36756003)(82740400003)(41300700001)(81166007)(82310400005)(36860700001)(86362001)(316002)(1076003)(8936002)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 22:30:15.7772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87af8542-8c68-42ae-5db9-08da9c20db50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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
Cc: Ellis Michael <ellis@ellismichael.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was fixed in initialize_cpsch before, but not in initialize_nocpsch.
Factor sdma bitmap initialization into a helper function to apply the
correct implementation in both cases without duplicating it.

Reported-by: Ellis Michael <ellis@ellismichael.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 41 ++++++++-----------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e83725a28106..f88ec6a11ad2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1240,6 +1240,20 @@ static void init_interrupts(struct device_queue_manager *dqm)
 			dqm->dev->kfd2kgd->init_interrupts(dqm->dev->adev, i);
 }
 
+static void init_sdma_bitmaps(struct device_queue_manager *dqm)
+{
+	uint64_t num_sdma_queues = get_num_sdma_queues(dqm);
+	uint64_t num_xgmi_sdma_queues = get_num_xgmi_sdma_queues(dqm);
+
+	if (num_sdma_queues)
+		dqm->sdma_bitmap = GENMASK_ULL(num_sdma_queues-1, 0);
+	if (num_xgmi_sdma_queues)
+		dqm->xgmi_sdma_bitmap = GENMASK_ULL(num_xgmi_sdma_queues-1, 0);
+
+	dqm->sdma_bitmap &= ~get_reserved_sdma_queues_bitmap(dqm);
+	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
+}
+
 static int initialize_nocpsch(struct device_queue_manager *dqm)
 {
 	int pipe, queue;
@@ -1268,11 +1282,7 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
 
 	memset(dqm->vmid_pasid, 0, sizeof(dqm->vmid_pasid));
 
-	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
-	dqm->sdma_bitmap &= ~(get_reserved_sdma_queues_bitmap(dqm));
-	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
-
-	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
+	init_sdma_bitmaps(dqm);
 
 	return 0;
 }
@@ -1450,9 +1460,6 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 
 static int initialize_cpsch(struct device_queue_manager *dqm)
 {
-	uint64_t num_sdma_queues;
-	uint64_t num_xgmi_sdma_queues;
-
 	pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
 
 	mutex_init(&dqm->lock_hidden);
@@ -1461,24 +1468,10 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	dqm->active_cp_queue_count = 0;
 	dqm->gws_queue_count = 0;
 	dqm->active_runlist = false;
-
-	num_sdma_queues = get_num_sdma_queues(dqm);
-	if (num_sdma_queues >= BITS_PER_TYPE(dqm->sdma_bitmap))
-		dqm->sdma_bitmap = ULLONG_MAX;
-	else
-		dqm->sdma_bitmap = (BIT_ULL(num_sdma_queues) - 1);
-
-	dqm->sdma_bitmap &= ~(get_reserved_sdma_queues_bitmap(dqm));
-	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
-
-	num_xgmi_sdma_queues = get_num_xgmi_sdma_queues(dqm);
-	if (num_xgmi_sdma_queues >= BITS_PER_TYPE(dqm->xgmi_sdma_bitmap))
-		dqm->xgmi_sdma_bitmap = ULLONG_MAX;
-	else
-		dqm->xgmi_sdma_bitmap = (BIT_ULL(num_xgmi_sdma_queues) - 1);
-
 	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
 
+	init_sdma_bitmaps(dqm);
+
 	return 0;
 }
 
-- 
2.32.0

