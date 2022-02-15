Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7F1C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 07:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BB410E3DE;
	Tue, 15 Feb 2022 07:42:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66EA10E3CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 07:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoB+4hm2gNZroCXyJQnr4rRLFN9leFUiE9xB39O1V7g0MiV71hCZmQIciKwUmlWm54NSa+8QG/ui8QrL5xT4Kog1ulrl9QrhI19EZfmkszsPyDoixp/1scCZ1JzamSB2DK+7NlNRrPtR9dad1Xh++/wpSEYt/8+aLfhVLtojp5EHJiG9YzMnmpVGoebpNtSnY/2DObsPDi/rN/VQUAkttryTib4dVFehVacYCngNbztHkxBsoRv2jO1cKebNKODTPfc14kBeIb+B4z7rsmqMMoL3V2vr5TSN1CfknKHQe4kEpuG3JZp3maipG5tz82Zh8LfLTk55LITioa1ngafdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVljcHnfhbX2zD2SkOpYUo3dnIDsbKGphGxicrCf8mQ=;
 b=oLVwaBJzbd/Z3F9817dBWxEgNNdxPLUp7QMACpy/2ovCNMvcsdk5j4HuT1Ul43RESsTF6tmeK3yiCXgVI1SPuf4DC7AYSvGziE/sxvVQJmflkXaaMw9DPZxa9NAxptIFSenOG+qZeiUJMfrosXy38CoLBc2IDnqacjwfHBFfrRR/gbzw9ykdM6AFFERJXqH3St47Mrft+SGsArxHS1FuGuLWKVHBlywaEJljGmlsfOecFvuqIEiuOBHnMLaLBSwuZqlpxbEUJby4blnOdQq2VzOyN4jQvpFzFKP4YCB6QGbz/Azv8oPeFJzXUtdscPfZC1LLvMTg211bhgmCvTNqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVljcHnfhbX2zD2SkOpYUo3dnIDsbKGphGxicrCf8mQ=;
 b=YdFdcHMOnNbRtXDKkPIRKitwZJmLfkPZAcucKvlNry0X78L66qUXXWAMR1Q2tWf3vBJsshuc/XwhPQivwgJEQ3diwoXAHw56XqLOX1SSU0Onc3NknQo91jupuymZzzZ/iNFjMLXUVokIRdq1KCbTYEq1vrmKZycx99/etR0l2/Q=
Received: from DS7PR03CA0177.namprd03.prod.outlook.com (2603:10b6:5:3b2::32)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 07:42:19 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::d5) by DS7PR03CA0177.outlook.office365.com
 (2603:10b6:5:3b2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Tue, 15 Feb 2022 07:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 07:42:18 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 01:42:15 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: define amdgpu_ras_late_init to call all ras
 blocks' .ras_late_init
Date: Tue, 15 Feb 2022 15:41:23 +0800
Message-ID: <20220215074124.3411761-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92a6d45c-32cb-400c-da6f-08d9f056b19c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4036:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB403651F6A0FBDBE644472563FC349@BY5PR12MB4036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KzlNfWsCmspKjG2KNtq0fU03xjVddSptI03Jh57UJgP7bWHBt67/l3UoVGYIhTOssJXxwxaKBFSbmU0HG5+Jl7oH10hL9yAA+unAKbqZxBCgYBU4fKCGImGUiuz73Z5tY3C3MhE/XoIPJJuo94FSA4reICsvMg1WlwfE5Uy6yjNJXadSsSYHqSMK5O8rDlRMqfUqBPdKHBvwvs6n0hng2v3PO7dSklSapuVf8TE9YmOtcvTM6CmfUvEt44GC4/5rTTPXQVSH+JfonnKsmd8LaJ5QK7DOAqZi1UyWBgWKdTjzlFYwKD2QbeaGowtCJtwfkAQ11nxaVXUCcm9bBheaUBf4SOhpmwDfqhKNJUJT00UHzhC4+rLlCxH4Fo6bZxqgvnQNOQNT2D6+t+8Jp2afGvviU+9d+0YqVh0F8ORSo8r/mnGGUdzAi3B4jqZ9B0NYlAZ3/dKCEiJEwKk0w8L7PtIzlGcMD1HlZ+oOFAGjdhyHVstRoCgmEE9m95aHoiJ95YU7A71OBuDWziuyNwZg6RaIibtEcG/61voaONAXczg9CCo5R6jf8q3j95MISj/PmvVFtCWRrCskLMsMSVRdkppwuZQ1cXAxZ3GG/K1NDeIIrztM6kIuqCsq8xB8R7hMk+rqnifzGbDXu91uX338zqRx3GpxHhgQblM+w9VkJ/TWWQcE0wRnyT74/lJNteQCcjKt2cAJEVzVfUO7BUQkKGBMf1mWUZMh2ZjfCSKC1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(47076005)(36860700001)(316002)(8936002)(26005)(8676002)(4326008)(70206006)(70586007)(1076003)(186003)(426003)(336012)(16526019)(83380400001)(2616005)(81166007)(86362001)(2906002)(82310400004)(5660300002)(6666004)(6916009)(40460700003)(54906003)(7696005)(356005)(508600001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 07:42:18.6555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a6d45c-32cb-400c-da6f-08d9f056b19c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

Define amdgpu_ras_late_init to call all ras blocks' .ras_late_init.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 44 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 18 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  6 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  5 +--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  6 +--
 7 files changed, 23 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a74a1b74a172..67ea23dbc618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2625,6 +2625,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
+	amdgpu_ras_late_init(adev);
+
 	amdgpu_ras_set_error_query_ready(adev, true);
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ebf4194b0699..49dd81c0db2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -449,50 +449,6 @@ int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev)
 
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
-	int r;
-
-	if (adev->umc.ras && adev->umc.ras->ras_block.ras_late_init) {
-		r = adev->umc.ras->ras_block.ras_late_init(adev, adev->umc.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_late_init) {
-		r = adev->mmhub.ras->ras_block.ras_late_init(adev, adev->mmhub.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
-		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, adev->gmc.xgmi.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_late_init) {
-		r = adev->hdp.ras->ras_block.ras_late_init(adev, adev->hdp.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->mca.mp0.ras && adev->mca.mp0.ras->ras_block.ras_late_init) {
-		r = adev->mca.mp0.ras->ras_block.ras_late_init(adev, adev->mca.mp0.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->mca.mp1.ras && adev->mca.mp1.ras->ras_block.ras_late_init) {
-		r = adev->mca.mp1.ras->ras_block.ras_late_init(adev, adev->mca.mp1.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->mca.mpio.ras && adev->mca.mpio.ras->ras_block.ras_late_init) {
-		r = adev->mca.mpio.ras->ras_block.ras_late_init(adev, adev->mca.mpio.ras_if);
-		if (r)
-			return r;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1aff88fcea76..6cb1e5d126d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2522,6 +2522,24 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 		amdgpu_ras_disable_all_features(adev, 1);
 }
 
+int amdgpu_ras_late_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_block_list *node, *tmp;
+	struct amdgpu_ras_block_object *obj;
+
+	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
+		if (!node->ras_obj) {
+			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
+			continue;
+		}
+		obj = node->ras_obj;
+		if (obj->ras_late_init)
+			obj->ras_late_init(adev, &obj->ras_comm);
+	}
+
+	return 0;
+}
+
 /* do some fini work before IP fini as dependence */
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 837d1b79a9cb..143a83043d7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -595,6 +595,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
 
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
+int amdgpu_ras_late_init(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev);
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index bb40ab83fc22..1997f129db9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4791,12 +4791,6 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_late_init) {
-		r = adev->gfx.ras->ras_block.ras_late_init(adev, adev->gfx.ras_if);
-		if (r)
-			return r;
-	}
-
 	if (adev->gfx.ras &&
 	    adev->gfx.ras->enable_watchdog_timer)
 		adev->gfx.ras->enable_watchdog_timer(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index af5a1c93861b..e26c39fcd336 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1894,10 +1894,7 @@ static int sdma_v4_0_late_init(void *handle)
 			adev->sdma.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 	}
 
-	if (adev->sdma.ras && adev->sdma.ras->ras_block.ras_late_init)
-		return adev->sdma.ras->ras_block.ras_late_init(adev, adev->sdma.ras_if);
-	else
-		return 0;
+	return 0;
 }
 
 static int sdma_v4_0_sw_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 464d635a0487..ba983398c9d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1186,15 +1186,11 @@ static int soc15_common_early_init(void *handle)
 static int soc15_common_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
-	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_late_init)
-		r = adev->nbio.ras->ras_block.ras_late_init(adev, adev->nbio.ras_if);
-
-	return r;
+	return 0;
 }
 
 static int soc15_common_sw_init(void *handle)
-- 
2.25.1

