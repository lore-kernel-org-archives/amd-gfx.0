Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF8AC77B60
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C99A10E720;
	Mon, 27 Mar 2023 19:36:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E26710E71F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjMO2du50ePxSzws1uT4fuZF8fs/52IYEQxLrnNC3iScOfVha9Kwe2z760PyFsY9qbAy1eIZVYYsranYHQp7e7G+EX596WJE7PQHY4mBH9YFJ1GBzCjMCjGMHsYXOtL5X6dusFcNTAfEDxqHlHjqctn0CEUB97AKSN/iQyk8lKtX86G4gvELU2OhJ1VWUWhVXXLEDRm+cFz8M3HeH0gyv21nLnc9uY1SPlGPgKwd0JKmkJvYlsWiVRAJGx1OkeuLtNdeuiG6+bPCq20UfkOKna2TFCtWh+aYemYWWfRpWxIAsBXi9SgU4cAF8Y1jKPgdc3NLJAmUWNvzMS+VAIWkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmwtzIRpwa3o59MBRHFgtVKzG/JhN8whEaLDWGL4IWI=;
 b=GffMeNflQTRSaTDv5nDScSP8t7oKZ9VIjqe84Vx+EldIRQMGohQvR/aw74aetlT+veJl2r9BwTVUuCIisuZ2duMhuorAZGl7E/Dabj+C7YzM9VZPWIdQ0IcIRdPebWuHuuxJB9YSyLauV+0XC42VFyJZMOQ4bSTo1zDAun6j2TjVqNSYvBVNPrm8YquQ/ybbAhZAnIf6buwJg+w19JKGw+uutNTs1XjnpVloXxML5O45rytyxcPc7LVMf/JNBmW1vzRnZbYsbwYnIrEvB1oHdDEkbAK8JvHLNMJUs3DE3j/Nql3fctc8LqnyyiD5AkQ3GArw/+9lWUsURr68rjMlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmwtzIRpwa3o59MBRHFgtVKzG/JhN8whEaLDWGL4IWI=;
 b=cVUDjodvxaPgQx/WZuK6jeFYNiG/KWI9Wx6GyXVrcslnBtdLGBlnXqUZDjGoUeEaa5AOt4lrxcycFwSXB7GaeLdooubtZrsUOieo5Lkuj44RoMFQYc2BLPIRU2YMTcZP4FloM6RBAxxyr4O1JypaECcLX8qkWQOT2pcl4bHKlwg=
Received: from BN8PR15CA0066.namprd15.prod.outlook.com (2603:10b6:408:80::43)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:27 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::9e) by BN8PR15CA0066.outlook.office365.com
 (2603:10b6:408:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/28] drm/amdgpu: add xcc index argument to gfx v9_4_3
 functions
Date: Mon, 27 Mar 2023 15:35:44 -0400
Message-ID: <20230327193602.7901-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 0845d36d-fab2-4127-b63a-08db2efa8eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDifozX+SP1Lqilr02Ce8jBrQpyg3myqG7M+xuPskpr0DbnF1QkcnC49F9bocdDkgpUfeFL2w223MYoBYsVHm2FTRR0Vf/FRFIwudujePPSOqsI56p3doB/HyADt2aN4un9Rj2JqKaA/mUUn3MZu7oaZqiIj1bSd4hURWVAd1It/uqE7fbiYdXCtvB1trrwvePEPBRlzpH+36qmo0OgfJoMo3zM4M9pQpIIEYlRxyIyZpew2TmQ+GEu3BzECuHkmhEvJ/aNkfCNmWowB95DF8jkxOX/7ZKWiNRu31M4yARn5NrnBvhymrg7eSWQxuVVTrHOOTRCEGSFncaP9dwW1oooqZY+Tm7hdtYul78djC3H4FU13JKyqjy51PTqLrKDjkbI777RXKaFOCG4DqZjRpTcgzVMvZsyNQJ5O0gJJGQFmHJ+cwUHGFMAJK9r3E2RClN9nwCvq/Kp5rstIX0AX5JAdpToEHmLoQqk8p2/HpJG+f6gy1VMbrKqCygDwE+16XTwhnu17n6LBXEEkp+ZMy484mqeTc1x5fGsznnrrDim2ZCpNeeIJzamlfLdplvQly5J+e0GPOezsAeR46oAJW7i1UlFgulO0dDE31flmLRb+1cjVkNJlJvHZ8YnfYXcNy3yR4nDes2i0C62MW15LgrjK8dWuVng0SnaroM7SZFl2WQN8m7VFPqOHZnakOs7hyp2HQxG4J6T1h7RZFms0gQNc4fQnSAUVDL1h9vYEILg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(2906002)(47076005)(426003)(83380400001)(336012)(5660300002)(8936002)(82740400003)(356005)(36756003)(40480700001)(81166007)(86362001)(82310400005)(40460700003)(36860700001)(316002)(1076003)(6916009)(54906003)(8676002)(4326008)(70206006)(70586007)(186003)(26005)(16526019)(7696005)(478600001)(41300700001)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:27.3654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0845d36d-fab2-4127-b63a-08db2efa8eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Change those v9_4_3 interfaces which are exposed in gfx_v9_0.c.
For some active single-xcc emu models, the code path in
gfx_v9_0.c is better to keep reserved for a while.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 160b7f358c88..773c139a1f10 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1069,13 +1069,13 @@ static void gfx_v9_4_3_init_pg(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
-void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev)
+void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 
-	data = RREG32_SOC15(GC, 0, regCPC_PSP_DEBUG);
+	data = RREG32_SOC15(GC, xcc_id, regCPC_PSP_DEBUG);
 	data |= CPC_PSP_DEBUG__UTCL2IUGPAOVERRIDE_MASK;
-	WREG32_SOC15(GC, 0, regCPC_PSP_DEBUG, data);
+	WREG32_SOC15(GC, xcc_id, regCPC_PSP_DEBUG, data);
 }
 
 static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
@@ -1178,19 +1178,19 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 }
 
 static void gfx_v9_4_3_enable_gui_idle_interrupt(struct amdgpu_device *adev,
-					       bool enable)
+						 bool enable, int xcc_id)
 {
 	u32 tmp;
 
 	/* These interrupts should be enabled to drive DS clock */
 
-	tmp= RREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0);
+	tmp= RREG32_SOC15(GC, xcc_id, regCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
 
-	WREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0, tmp);
+	WREG32_SOC15(GC, xcc_id, regCP_INT_CNTL_RING0, tmp);
 }
 
 static void gfx_v9_4_3_rlc_stop(struct amdgpu_device *adev)
@@ -1199,7 +1199,7 @@ static void gfx_v9_4_3_rlc_stop(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->gfx.num_xcd; i++) {
 		WREG32_FIELD15_PREREG(GC, i, RLC_CNTL, RLC_ENABLE_F32, 0);
-		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false);
+		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false, i);
 		gfx_v9_4_3_wait_for_rlc_serdes(adev, i);
 	}
 }
@@ -1229,7 +1229,7 @@ static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
 
 		/* carrizo do enable cp interrupt after cp inited */
 		if (!(adev->flags & AMD_IS_APU)) {
-			gfx_v9_4_3_enable_gui_idle_interrupt(adev, true);
+			gfx_v9_4_3_enable_gui_idle_interrupt(adev, true, i);
 			udelay(50);
 		}
 
@@ -1866,10 +1866,10 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 
 	for (i = 0; i < adev->gfx.num_xcd; i++) {
-		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false);
+		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false, i);
 
 		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-			gfx_v9_4_3_disable_gpa_mode(adev);
+			gfx_v9_4_3_disable_gpa_mode(adev, i);
 
 			r = gfx_v9_4_3_cp_compute_load_microcode(adev, i);
 			if (r)
@@ -1889,7 +1889,7 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 			amdgpu_ring_test_helper(ring);
 		}
 
-		gfx_v9_4_3_enable_gui_idle_interrupt(adev, true);
+		gfx_v9_4_3_enable_gui_idle_interrupt(adev, true, i);
 	}
 
 	return 0;
-- 
2.39.2

