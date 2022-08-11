Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12A3C19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 04:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756599BB57;
	Thu, 11 Aug 2022 04:59:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6F9A10F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 04:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KttWdkE29pFehuoomjIG1P9yRKPd/J2g9YeC1gbpFrwGnEpkf8F/JsJO39h6GJjLC2mvgZkw05RjApGfGr6Gyv1aUNl/IXVRk9C5GbUl6EgBHZ9My995yiLZMwHTQ+Si3MrdXr1niqwbv8wL4Xy6+c+Q1Uyc64ZZWWKjgCt8DzBzkpFWKmPgl/yvYs4LYtatUi7t1A0z5/15Oxw1nZHexTpunDhOlx5jPaEiwuzU2f53gKo5n0l+CK3JlmE63tHqDCqHmhDJjxawIr5QG0XHfxURuCtiSiY0VpbrnH2ZNkAIL5DQKntZgkSBnd+SGsjK7DElubjVo8iE/WZWyT6Wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwsXirD7wraXjtggXLi7/rSlG2i22KXmPJTUF8q8lhM=;
 b=Vtyyd0sL1KnTCJE3g4auo54dqLB0OeV2FdCR7lu+1vLbFkac8bbjOCJaKUgTgpBeGFOZBIQpvCEC+0xsTRN22FCMtfnNIXb9UR8F1w6JN+Zv9HNzsKF9AWBq/5XOBQvKgDu/TehQFc/840IeDq2ULXyTBSSuqYRMMPoGWxOgyvulImJ7k2RhxKO6L9uDEOO2+cQHlEU3AsGqCec9BXHfyG/EIjFBoQ9iQlB+dmWYJg6kasmtZYEUmgKGybJUPU/imszy4pJWHi+6H0pEphxTALtpo+3gndmHGj+6YvW1DtvUHqDjk2l1rCvokbBCnJzLFqbUiXLa/HaYy938PTygkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwsXirD7wraXjtggXLi7/rSlG2i22KXmPJTUF8q8lhM=;
 b=n7gLYDBcTFtMqk3o2sN7daZ10syZL8MW34ys3OKUevr2LGDeAxpWKe5b2oOwGsxNXRp0XC/wptuStp6Hcv+cYmDZvZIQaqKrcUOoTNRyXuE7yAe5c4KM1RZuh7UHXq1Ih/BDJkYzTsigLCWM2SGMhOAGiyXBkkPWRuYcmfF1gYU=
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 04:58:46 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::9e) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 04:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 04:58:45 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 23:58:43 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: add ATHUB IP v3.0.1 Clock Gating support
Date: Thu, 11 Aug 2022 12:58:01 +0800
Message-ID: <20220811045804.3750344-4-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811045804.3750344-1-tim.huang@amd.com>
References: <20220811045804.3750344-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53101717-3eb2-4025-db02-08da7b562bd9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBf8ki+nUUTTdzsCCU4Du15pZXbWxr1RpnezPBHnDKs+OZPfrgZr7LrmZisoGMn2jKBAlZ8hH7n5eMbhrnEYJOArYCGeXoQ+GvHb7erh3QBpcmDRUFcA72qJE8JFI58reC6ckJ5CV6NvuZ378H7tQ91+SqLUSraXKzHk9R8Hr9PxQoJveliJ1Tbsc/S7AAW4tk2lW2eiTOfDq2P7UNYk8d/JI0OQdeqgM2EgGtULaCVYCshkHJNSJgZLAt6fgqMtQ+3IXZ2BN/+7msqo6jHn2bcKRZzaxUVajPkPzREUZmMjnODJXmaqTwKn+E5ohs0t5BBtDXPFPc6CpzTliThcPSlsL0ToOR0hlVrkNNLlERg8ge+GzdgDDJL/5FLbCTMBKmxDAPSdXIcAArcVemkSueZEwGCwfvLjMIrkjyuFQ6WVmxEeVLXlO1xOwoSQ/F7JwnXi+gHKGDbR7h+kiY572xy0YWsXk9tY9N23rytXy+JF6sbOiZodK9GMyEOooldgTw7/DRd4WpxGrMi+UGWRkHWADusCdMGij8kuWxbuYoGAWZDPM06ct/iXLKCKMWHhQShzMGl7AsiqLIz+GH5oLIyuZlpjEqLpuPXVG5EYVo4+0v9a68ArluZKBtk9zBOlAvg7z/TZ9rACJkYCGz+xYtzJnmRzcpiLFvO0I1c98x//ygwBxdwdTU9TfTZZEQpe3Uf7SRSdrlm4YNmQpES+X8kZQGOr3ITpXcAP4X9ifNHxJh/i6Pa9dJD9bMCIxqyDqNJKCFSdeKXc0P+2eiAlSDyuDpLmraxqGU+dxDrt41oNmPtiMY4aa/VlVFpvZu8jLIu8sfUFxT4FwHfAL5btyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(40470700004)(82310400005)(40480700001)(8936002)(5660300002)(316002)(478600001)(54906003)(70586007)(70206006)(6916009)(36756003)(41300700001)(8676002)(4326008)(356005)(26005)(83380400001)(36860700001)(81166007)(82740400003)(7696005)(6666004)(186003)(16526019)(1076003)(2616005)(2906002)(40460700003)(44832011)(336012)(47076005)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 04:58:45.6948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53101717-3eb2-4025-db02-08da7b562bd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ATHUB IP v3.0.1 in athub_v3_0_set_clockgating.

The regATHUB_MISC_CNTL has different offset for ATHUB IP v3.0.1,
so need to add IP version checking to use the right REG offset.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 42 ++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
index 33a8a7365aef..f0e235f98afb 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -28,13 +28,44 @@
 #include "navi10_enum.h"
 #include "soc15_common.h"
 
+#define regATHUB_MISC_CNTL_V3_0_1			0x00d7
+#define regATHUB_MISC_CNTL_V3_0_1_BASE_IDX		0
+
+
+static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	switch (adev->ip_versions[ATHUB_HWIP][0]) {
+	case IP_VERSION(3, 0, 1):
+		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1);
+		break;
+	default:
+		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
+		break;
+	}
+	return data;
+}
+
+static void athub_v3_0_set_cg_cntl(struct amdgpu_device *adev, uint32_t data)
+{
+	switch (adev->ip_versions[ATHUB_HWIP][0]) {
+	case IP_VERSION(3, 0, 1):
+		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, data);
+		break;
+	default:
+		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
+		break;
+	}
+}
+
 static void
 athub_v3_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
 	uint32_t def, data;
 
-	def = data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
+	def = data = athub_v3_0_get_cg_cntl(adev);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ATHUB_MGCG))
 		data |= ATHUB_MISC_CNTL__CG_ENABLE_MASK;
@@ -42,7 +73,7 @@ athub_v3_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 		data &= ~ATHUB_MISC_CNTL__CG_ENABLE_MASK;
 
 	if (def != data)
-		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
+		athub_v3_0_set_cg_cntl(adev, data);
 }
 
 static void
@@ -51,7 +82,7 @@ athub_v3_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
 {
 	uint32_t def, data;
 
-	def = data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
+	def = data = athub_v3_0_get_cg_cntl(adev);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ATHUB_LS))
 		data |= ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
@@ -59,7 +90,7 @@ athub_v3_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
 		data &= ~ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
 
 	if (def != data)
-		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
+		athub_v3_0_set_cg_cntl(adev, data);
 }
 
 int athub_v3_0_set_clockgating(struct amdgpu_device *adev,
@@ -70,6 +101,7 @@ int athub_v3_0_set_clockgating(struct amdgpu_device *adev,
 
 	switch (adev->ip_versions[ATHUB_HWIP][0]) {
 	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 0, 1):
 	case IP_VERSION(3, 0, 2):
 		athub_v3_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -88,7 +120,7 @@ void athub_v3_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 	int data;
 
 	/* AMD_CG_SUPPORT_ATHUB_MGCG */
-	data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
+	data = athub_v3_0_get_cg_cntl(adev);
 	if (data & ATHUB_MISC_CNTL__CG_ENABLE_MASK)
 		*flags |= AMD_CG_SUPPORT_ATHUB_MGCG;
 
-- 
2.25.1

