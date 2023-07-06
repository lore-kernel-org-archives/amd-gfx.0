Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1031EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D54510E4A1;
	Thu,  6 Jul 2023 18:55:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC6F10E49F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0szHSpgz/kFt+XV8anEpx8HLxeGTz5Hw3noM7I8B5gCb/SCMjiImnoCNz4ZIDVcjluyCjFpVuj33+EbtqquoqBvevxCaZaWClUwLDpg70RUaSmHZtYz3+Ak3U7yj85XfQ2gAcZuS4YtrQzV+ogLW7dE62BHidIihTLcKbKMcPl34wHKOV9fzhtArHkRl9/O4PcOOcssoGF+DgSI4xdKvhzZCb+Rne8/L6vKBE/jIH4IUmK51r5ZOGEBAKjcAJvyeo1gyMf+HE5YGSpPjy0NLn8F1OPnQxUxCs0r9e94dAGm43zVDCRsa4FPSz+Df711qf8jJSZqx9g4B3kIZyyMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+caU9kN+zTZWmnwRGHiisZpL31Ou0XyBT4codyVYjPo=;
 b=cSJt6z5SVyH+nTVkH/Kqe+4ZjSZ/E6p8ezd+g2ZVIt5ADhkEB+JRkdX+Ik1hzr3LxPqzul1fSe8jopf8c+DdaDKQ9Ev09wf/vjeNNhceK7V/187y/j5y65oLovewcIlz8+0mohEovwJW2m0TPIFNaWDjaEUsg9lqNIJuBAHGoP7JvumkRkLNVEb2SY8uhoZSNPsU/YwcngR9L36R4d9iOwfndc0bvEw3xlQA0m3F8rsNYm2Xzr7kVd+Xincu3TL44aSOXv8Rptj/sZD4KBF0qIOhOkoErtVLoHiiOz+c6vqy4ZkbkzjjZ+MSBrsfkL5Q+yqLWZeCNyMCFPMUjHR7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+caU9kN+zTZWmnwRGHiisZpL31Ou0XyBT4codyVYjPo=;
 b=3rLrPNouzT9R6uZKbY0w80jQiGcibCuh+X9+8z8hsPsy/ZgVuIJPyDqWTnY3005hj3Z8XffIxmo8QF0rlNQvsNs10XetDTdf7w3sotm9zGlP7l/zxW+GiRcnk0abgwpyFOkkedcyRfG/j7g6a9wp63xIyJYxewGMpjEzkX5eX5A=
Received: from BN8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:408:c0::28)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:55:17 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::17) by BN8PR15CA0015.outlook.office365.com
 (2603:10b6:408:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 18:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:55:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 13:55:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gfx9: move update_spm_vmid() out of rlc_init()
Date: Thu, 6 Jul 2023 14:55:00 -0400
Message-ID: <20230706185501.7471-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6febb0e1-2932-45bc-5aae-08db7e528a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iM3YpN/Hyt6TJQZtPjhK0Jr676cg3gIntVcNjSAFiMA/atsJRmyy7G21wGn4seKPHQQkE9g8OVxANDrN0jvfcmOCpBaF4WiljaK/cFV/qCscrTyCsbo20on/aSCOIbiWDMUdRSvjNi64gcTfuubz7M8WfMRq+CVc8AgCNPXmTiOgv6wGGDelFWhBEMCq1v+04f2vse5OP+vkae38VXreVkGYfx5jQ+TMND51cUe4gIHD9vklZfmHid97EtvLTGFcJV+TDc6VAkvZpzOCwwIKeSuAyQFbsAmTfibbnr9wvPHZAymPwbDglYU/CWOdHq8jqY2h/+N1MJi18LbZ2/7AF6y2VKrCOPgfwBrzPyZulpE6p9BD0/+xMVhbEimAhfM1V0G8KKbhWeuUcgizVQx0qFzLOr3LtDgBt5/jZitFIk8Ri9m0hMXA2udF+mUhLrS55jNHi04U30SrH454eCW18bkjr+qFtAggXedqte3aSvseW7JH6zykAA6969gf0BvYgSpcDsH6/+qkjadSL8qXVoFm9rCpswlsqp3PRvWCsY9Cy1n2sUqVlC5P2oYhY11s5lzAuJdK8pSPpdHq7fN63O9nbhWWehA5CW69tMpWBZ+30zFe7nOfT5idb8HdeRPO3uqvbr2DTZ5q/CbQfRZw/0rOTaDOThvvLPMAqdVv8OCSiG9Fd5V9eQt65YTzML3XFkjlZqVVSvxf0x+37vKIwnWBKmwW9T7ilhiJcbj9la9YeIAEa577QM9zLVwEVb7MN1CIY2X2ynZlU+z12spWWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(4326008)(40480700001)(40460700003)(81166007)(356005)(82740400003)(7696005)(41300700001)(6666004)(8936002)(8676002)(2616005)(70206006)(316002)(6916009)(70586007)(336012)(36860700001)(426003)(478600001)(186003)(83380400001)(47076005)(16526019)(26005)(1076003)(86362001)(2906002)(15650500001)(82310400005)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:55:17.4731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6febb0e1-2932-45bc-5aae-08db7e528a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

rlc_init() is part of sw_init() so it should not touch hardware.
Additionally, calling the rlc update_spm_vmid() callback
directly invokes a gfx on/off cycle which could result in
powergating being enabled before hw init is complete.  Split
update_spm_vmid() into an internal implementation for local
use without gfxoff interaction and then the rlc callback
which includes gfxoff handling.  lbpw_init also touches
hardware so mvoe that to rlc_resume as well.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 34 ++++++++++++---------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d654bdd2037c9..7d992e4730db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -762,6 +762,8 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if, uint32_t instance_mask);
 static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev);
+static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
+					      unsigned vmid);
 
 static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -1669,22 +1671,6 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(9, 2, 2):
-	case IP_VERSION(9, 1, 0):
-		gfx_v9_0_init_lbpw(adev);
-		break;
-	case IP_VERSION(9, 4, 0):
-		gfx_v9_4_init_lbpw(adev);
-		break;
-	default:
-		break;
-	}
-
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
-
 	return 0;
 }
 
@@ -2944,12 +2930,14 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 2, 2):
 	case IP_VERSION(9, 1, 0):
+		gfx_v9_0_init_lbpw(adev);
 		if (amdgpu_lbpw == 0)
 			gfx_v9_0_enable_lbpw(adev, false);
 		else
 			gfx_v9_0_enable_lbpw(adev, true);
 		break;
 	case IP_VERSION(9, 4, 0):
+		gfx_v9_4_init_lbpw(adev);
 		if (amdgpu_lbpw > 0)
 			gfx_v9_0_enable_lbpw(adev, true);
 		else
@@ -2959,6 +2947,8 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
 		break;
 	}
 
+	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
+
 	adev->gfx.rlc.funcs->start(adev);
 
 	return 0;
@@ -4883,12 +4873,11 @@ static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
+					      unsigned vmid)
 {
 	u32 reg, data;
 
-	amdgpu_gfx_off_ctrl(adev, false);
-
 	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
@@ -4902,6 +4891,13 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+}
+
+static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	gfx_v9_0_update_spm_vmid_internal(adev, vmid);
 
 	amdgpu_gfx_off_ctrl(adev, true);
 }
-- 
2.41.0

