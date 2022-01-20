Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC9DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 03:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036D210E237;
	Thu, 20 Jan 2022 03:19:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5316310E2A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 03:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZt7gsHCf3G3ONOVNa3iLd0Fdue+6lO98Z0XwrUFyruay6sCOi12cpILvIXhCljy9eNN6lrIQLICleFeQGjUy0AowNa9xaZWq7xtnBy95gv4fad0/EXW6e3C5qBNJEkWcFWQwo028EDGuFb575BG79fIyBW479Fdi4pepKLhc/8r2yMDvdPy/d+TaZ4VE7TNfrP4eiIEJNYcp/ShtiHRzoTZoIUKkeHpUaEktfXV2eqbPA8ICOkTTc83SvM6BuzO7Alii4ReUuNLVRxOV2osYR4c5ntZyChJwXivpkbOgOuDIrQpE1xXsM8Huh+7btvDgK/T1mqd/X0I0MlyNFHTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMqPJhey6pvrPFg0Vi0OIHwlxt/mEEPsemzOk2zlEGE=;
 b=Za8NioCIGyiaQmQNgaqIktLKfUz6AjfCkAKaNvWMRo2CnOZ21c0SA0VqGOKfUAtUqvpb/sAE5NYpvoEYH3SQCOsEj8dOVePBlCoj0FfQKVFOx+MfQbvuI+AeQPfPI3Rqv/xc5G23oyMKUllAllfm5pg6b4G8GN7uNbCnva7vsqSQGEWvNhaTFyBFfP3DSjLZKpZ8nKhArzZiNwzhiPCYbh//Dqq3UK7/K7w5zZPdnZKoLk84AQnAG6gO45J6gKmFs+aP6hL4Nf+ljvx8mtShY6rI5Kx5qSFNLjIJUpycs0RpgFrdUhXl6FpinUD+JASNjvB+sMgK6sRTOS6MLyN3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMqPJhey6pvrPFg0Vi0OIHwlxt/mEEPsemzOk2zlEGE=;
 b=nz9ARNy+6hnvKk+/WFO6VtQFwqzlJHtxUi/XxYWrSeYHpx97uHes3UynLqVyPiEXBTeYOeozy0e5X3rq2aegVFHVdieVAWo32PV/r4AejFtI+VAL2M/NPgNkRR3L9J0/iKj3jwpM1LC3FAbDSPqB+uBmmo/ilcmalc+gpJJiWrU=
Received: from MWHPR12CA0035.namprd12.prod.outlook.com (2603:10b6:301:2::21)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 03:19:24 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::91) by MWHPR12CA0035.outlook.office365.com
 (2603:10b6:301:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Thu, 20 Jan 2022 03:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 03:19:23 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 21:19:21 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Date: Thu, 20 Jan 2022 11:18:49 +0800
Message-ID: <20220120031850.350206-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 897e0197-e182-49d0-35f4-08d9dbc3a879
X-MS-TrafficTypeDiagnostic: DM5PR12MB1433:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1433DCE94733E6D974AC36DEFC5A9@DM5PR12MB1433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZFpAzziRyY8OiCilsyuaQKMXy8bymps44yUoWddQ9sMhDMmMM9YhUDdBObXCABawGF1LZ2qiv9PKEzuKi4WNXBYwQDvOlTvJQvAiUSiU1GREJoucPK/QW/WXYCHzT65B7s33cUHWH3uEmbroWD7hUCpSwaetCIhdJshVVEurh7qeLGsMKQLS/TtIqS23yZSX5n0Kf/+5TYAzLG1Vb7dkz4SzxolvmkfVnG6fRYQjJboSiGoc2igHwGCs5KVjsshYBR5wtAdOYy34ZIOsNc6/mm7cWD+H7CIkCPwBfFTHIROp7isWhtio+RXcq3tgLkIxmSqaLhh6Y20gRvLHnq4IW+2VlWe6ZgJ8NbnVpEpMjN6EKd0UXOI6kbwtuwk5/d8jUZBrQVS8SOxNgJDMFunGKDPplU7MmesXZlM1INTVWIsYDJzgZaNZpKAfgp3DqVXb1eBlZthghLQi0sqr65pu+4it7UCfGpnzG0njiExlEn62FXmyae1OCAk5mAypfyVY/03cA1QR1v7bHzxy84UJler/uP82p+6tfUtQ+uxaScwKHqYelRcEGKnPprWKuhil9KKY1wK//sH7jSs/iOkeyTN1kgUyn7L/Q1KwKxTo+/DJTXwxrV1tBPBTpXxCg8rr/iTFD4rrky3ytV1jiEhj780eXjKeXe5GvTzjVTfVz/0BOZ/yrs1RK3o1VnlhLsntGQffUCtbC8YQKCjf9wrAVztBVMZVdiDGEZm3Jnj3M58HENh0nYVJcb+JMK12RGRCdehBOaGZGT4y6alMUCKCwdQ2BPj7Z57KAYggzfLul1hKXlk4d+yEakXSGFe5ghMxei0m2Ss3PtwNxTtalHQcijbTWS62laJu47Cky205JU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(83380400001)(70586007)(26005)(36756003)(1076003)(7696005)(5660300002)(4326008)(54906003)(316002)(6666004)(508600001)(356005)(186003)(16526019)(81166007)(70206006)(336012)(8676002)(36860700001)(86362001)(426003)(6916009)(47076005)(40460700001)(2616005)(2906002)(82310400004)(8936002)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 03:19:23.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897e0197-e182-49d0-35f4-08d9dbc3a879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move xgmi ras initialization from .late_init to .early_init, which let
xgmi ras can be initialized only once.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 ++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  5 +++++
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3483a82f5734..788c0257832d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -436,6 +436,16 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 	} while (fault->timestamp < tmp);
 }
 
+int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.ras = &xgmi_ras;
+		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
+	}
+
+	return 0;
+}
+
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -452,11 +462,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (!adev->gmc.xgmi.connected_to_cpu) {
-		adev->gmc.xgmi.ras = &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-	}
-
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
 		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0001631cfedb..ac4c0e50b45c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -318,6 +318,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
 			      uint16_t pasid, uint64_t timestamp);
 void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 				     uint16_t pasid);
+int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 4f8d356f8432..7a6ad5d467b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -719,6 +719,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 
 static int gmc_v10_0_early_init(void *handle)
 {
+	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	gmc_v10_0_set_mmhub_funcs(adev);
@@ -734,6 +735,10 @@ static int gmc_v10_0_early_init(void *handle)
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 
+	r = amdgpu_gmc_ras_early_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c76ffd1a70cd..3cdd3d459d51 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1318,6 +1318,7 @@ static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
 
 static int gmc_v9_0_early_init(void *handle)
 {
+	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	/* ARCT and VEGA20 don't have XGMI defined in their IP discovery tables */
@@ -1347,6 +1348,10 @@ static int gmc_v9_0_early_init(void *handle)
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 
+	r = amdgpu_gmc_ras_early_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
-- 
2.25.1

