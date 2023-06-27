Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C1DEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 04:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28FF10E279;
	Tue, 27 Jun 2023 04:48:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F64110E271
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 04:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgeI8EYYWdXIOr8DqfV65bz4IkHbPxq9uTO4YrrQdb8aFhA8ItvM+R6gPak8B1a1VJiZtgn/bNGC0eXJCYUyDfmyf9gaiD7wZBxdA5llFORLDz5s/pOuo+I6hlHj5g9HCQaQnvp0xglVsBS/cRZ7hiiHXW6+AMnqAuijz9y6tikp9wTU3l3IhIksmwd65ga342KanaLhtUy/ap3MjORbIN7ghdkU/OfpZgxf5FWF4yIJGz672/rz+3RnS5Ft0jYY9dgjCWkXgD514TaIw7GmzDV45Psra6c9Jh1P0+kGSQt32zjQxwfSZh0ch0D6yKOT3gzFv7mvrNyOhPYFSNsCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jzjrGTBmnTTkuwxC0ljPS2D/gxUh8CvcExbyN0iQ2A=;
 b=m9Qaz1Ia915YJSV6VqFgr6Z39SyfbrIghgGTYlnRuYTJWDdkfu1X0A477MeOBR5Ti6y8IhpEWB71T6LAf+kM0+1wdL/JZe+fQjuXzYa2pOO1jsfCXfRQjhVo7AxdTWrBumSJx4aPY80zKT+CxYRMC0HyCqSKsnqS8Cw91znQ9HUABOVh9desf1gj9HVvFzTB/cj33HS4h2aleMLgVbgzDKq0bq/RIhbvB/SoEqgM2kMS+9PBZ60OTldOZHO/j0EFlJjKbx9woyYQEIbs3VUblEkEKeL5pTRp+OwYmbeR5AZFuxcIbhhQXsxUNNroFwV89xmcOLaJ9+IcVGR45j4ulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jzjrGTBmnTTkuwxC0ljPS2D/gxUh8CvcExbyN0iQ2A=;
 b=4hVzZtWM2K1wEe8Ttkw2XtJYELPDd0B+LqAXhD6Rl9BnBW/dSVbziyc4KG4ZszrXbuh+V7s1gHex9Ehfyt8vfbv0yJqR1rHEdsL+qWZoDSjW/qwT4VYD4sWlUcFWfz+14LORJf0nozgW+iR7zkjHmUzELOdJYDCcDMnJL0a8V1w=
Received: from BN0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:e8::17)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 04:48:51 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::91) by BN0PR04CA0042.outlook.office365.com
 (2603:10b6:408:e8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Tue, 27 Jun 2023 04:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 04:48:50 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 23:48:49 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead
Date: Tue, 27 Jun 2023 12:48:33 +0800
Message-ID: <20230627044833.3668402-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627044833.3668402-1-Lang.Yu@amd.com>
References: <20230627044833.3668402-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5ac07f-fe93-448b-e274-08db76c9cd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Soi+PukJUIWgcGM0znAU4vzOoMtRlnlCbkZTkCqkIgBRqUw9OveqSE2298tUv8smyd0FaJUkBjdCxdIjwzNdV83k+CtGCqVx27m5+aSB3G0/ql2oVEzF+h9cbONBRUsYweZrSBfSU84bPa5XqMHr0C0LpeE1BkUAIb3E9bC2CXbhkRLr1kVzDjsamEFDv/atPH4g8H+LWfvSRHbj7CTb+7E3rzBS0Aj1+PQj8tyhDHtp6ogUSrdGtTWvQ5T1EZLA1GMSHPPKx2XmvW8DGCuoRyosTpwseZy25tg3TIKRwV4JFDCFwvrsJYP9U4E3Yd8UEPyvOIpidNAsQQCgESE29vvERulwhj/y8lrTUgT0g3AzIxKkgr2dWLc7W3x+6PU0O304nUz7lvugrOf+56s4s7nbSzQ3xZUrj68BiSP6iVr2rOD/KVSsGVjXJg/9naXJbwblx7wMqwL14xSiQlRqwd03BUmdtajeXswlQR4dFAJpNQBbl/PU0+okm6jZswg3l5Nh4+FqRUDYUNm8VLVmBSvoe41cKp06F6pUS3cULo593Aaqp7WM6aHvCvQsDel6aFg9qLfCW74HtdULRXPop09h0HAbop9wztk+zSBKHcn9ph609EOIrLPm/CH5A8pSX6v0MoS5q3/RR0+vfCt9/DHpUazm7jk1ZR5mrLLHIatfLbFKjCmDoXcR+ZfhMN+XiEE7aBMrBnuKYuVYE9OUCxVvPoO35zXwdLFhwyLI1+pSyYhxeegnR8bAubvt8GrXy1fkO/xyf1QYZrEr2PLJ3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(8676002)(70586007)(8936002)(70206006)(316002)(4326008)(16526019)(186003)(6916009)(336012)(1076003)(26005)(7696005)(2616005)(6666004)(41300700001)(40460700003)(82310400005)(2906002)(5660300002)(40480700001)(478600001)(82740400003)(81166007)(356005)(36756003)(86362001)(47076005)(36860700001)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 04:48:50.6411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5ac07f-fe93-448b-e274-08db76c9cd3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
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
Cc: Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the old ones with psp_execute_load_ip_fw_cmd_buf.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 31 ++++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  9 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +---
 9 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a1cb541f315f..b61963112118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2474,21 +2474,11 @@ int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
 	return ret;
 }
 
-static int psp_execute_non_psp_fw_load(struct psp_context *psp,
-				  struct amdgpu_firmware_info *ucode)
+static inline
+int psp_execute_non_psp_fw_load(struct psp_context *psp,
+				struct amdgpu_firmware_info *ucode)
 {
-	int ret = 0;
-	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
-
-	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
-	if (!ret) {
-		ret = psp_cmd_submit_buf(psp, ucode, cmd,
-					 psp->fence_buf_mc_addr);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_execute_load_ip_fw_cmd_buf(psp->adev, ucode, 0, 0, 0);
 }
 
 static int psp_load_smu_fw(struct psp_context *psp)
@@ -2946,19 +2936,6 @@ int psp_rlc_autoload_start(struct psp_context *psp)
 	return ret;
 }
 
-int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
-			uint64_t cmd_gpu_addr, int cmd_size)
-{
-	struct amdgpu_firmware_info ucode = {0};
-
-	ucode.ucode_id = inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM :
-		AMDGPU_UCODE_ID_VCN0_RAM;
-	ucode.mc_addr = cmd_gpu_addr;
-	ucode.ucode_size = cmd_size;
-
-	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
-}
-
 int psp_ring_cmd_submit(struct psp_context *psp,
 			uint64_t cmd_buf_mc_addr,
 			uint64_t fence_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index bd324fed6237..e49984a9d570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -459,8 +459,6 @@ extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_inde
 			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
 
 int psp_gpu_reset(struct amdgpu_device *adev);
-int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
-			uint64_t cmd_gpu_addr, int cmd_size);
 
 int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
 				   struct amdgpu_firmware_info *ucode,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d37ebd4402ef..1805cd042d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1257,3 +1257,12 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx)
+{
+	return psp_execute_load_ip_fw_cmd_buf(adev, NULL,
+		inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
+		adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+		(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
+			   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 92d5534df5f4..3ac5ad91ed08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -414,4 +414,6 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
 			struct ras_common_if *ras_block);
 int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
+int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c975aed2f6c7..74cd1522067c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -881,9 +881,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
-				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
-					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, 0);
 
 	/* force RBC into idle state */
 	rb_bufsz = order_base_2(ring->ring_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index bb1875f926f1..79d40203c952 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -912,9 +912,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, inst_idx);
 
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c8f63b3c6f69..9e1570648b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1037,9 +1037,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, inst_idx);
 
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 2db73a964031..4febc7629512 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -993,9 +993,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, inst_idx);
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5d67b8b8a3d6..ce8c766dcc73 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -778,9 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, inst_idx);
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
-- 
2.25.1

