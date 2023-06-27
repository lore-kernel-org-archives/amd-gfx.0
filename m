Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D2EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 00:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837E710E26E;
	Tue, 27 Jun 2023 00:43:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C106510E26E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 00:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgjVP0HGyakM3YjIPoMgYAPHHnNx+IgUHOGpnbZeUXR9x5kl4H0+AF05dBIT8v/C06KKNwkTsTVCq+ZHScpQU6IyidwaC4PE09VapgeqpZ/CFZGYAIcaFMUP/CwZ1a2Vr1M6pOoFKvczPMSyLxJRPSdBpKyqOdFa3swVjd+3Ut2nj8B0yHN/OmAjHA+mPekQwJpHB+9On2ZxJe+8xDuremrSu5/gA3E3U9BnBR84g/pEE+My/IHTMZlEOag12ahKqEVCRiTJ25Fb7/3rc1suw4Y0ekOM5UkK0xQSoDutxMjj44v8WX2TKp7m7MsgNcd46jEWG7iUwYIrGlGL13PPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOTYbjKlPnILutfYHdjpmh/pqSA61Xy6CuR2d3VRuVw=;
 b=aoYP7W5ntgSo5WLhSm/KvntE/WsaXzs12vFLEsXw6r5jLnYLgeligP4JzHX7sI+9C/TDKxpR3cbu42PRViLlkOrbXg8EDnSQZI1q1FhXTeaIbeD/pHzvfQuyYWfw7Tcrnv/0FcmqjBrWiFjLVqP4K+QuKudiurWgNRdRLFdsugwfljCmDpTqkwRKyYh/loisTMitBh0DzTmFcve+SP43N1tf2nCnvgQq/8j5xMkSa0s1NCu0biviy/4CCutC8/+K7iYu/2jqiMgQUPT38rjakNhzc/ge5ZbhG3+ABdKIjc76Ta1A9an6mrytZ/7ejLNO+t3/VYMLER5dzLemuNOQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOTYbjKlPnILutfYHdjpmh/pqSA61Xy6CuR2d3VRuVw=;
 b=zBod1ZlRTFmq1Q2wiBwnETxIEd/mZunKCi2yO+ngbR6VJokbo20rcRoIHPjPZO28HZe7ebEKHH5mNo57y0KzPkxiyru4k0lQ3MI7pSP5N/VsvKJtdrKihmWcnTkz7j4ncE+ktVuQjl8vXOJqWekNOR2Xq/rvECkXUs3vm5ImgWA=
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 27 Jun
 2023 00:43:15 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::3f) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Tue, 27 Jun 2023 00:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 00:43:14 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 19:43:11 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: rename psp_update_vcn_sram to a common name
Date: Tue, 27 Jun 2023 08:42:51 +0800
Message-ID: <20230627004251.3521493-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 56de2c34-2ef4-4093-da60-08db76a77e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6rd1FczhyfR0fmKwy/RYKsbvU6jtq2wP3s7Ntp8vL6YLwVL+bRdhdIwQ3UhT13fluJrU0sFIa6FDZSXyrFBDcqxTXzPv7sdLGTWfwhCKTRdoO/j8ptj2+5rgd3sDiWVutVtzUmwMZjiWgYWAl0wzOf9QlqhJ98PBQfwHCitsl6jASpBOHFHzeLez6cYzCjgYJp9at8D+1odIgmUk4+C7/qBt4NfNAKU/7scNcj1t727QCFq8nFYsJT6zZbmomO0tCUBYtvU2ZUpiLRN12+SJrkzZYQ+K9Gotnn5fQqjzTnnnLdad9v2081PbYFje1x94aOQPnsMegv5JDUshMqluz2QZYYQP4cVANAHDybFrwpmBY2VPf7fGOlxUKX3Xs2Ckg58uhGSsFzMILbMWVvx5KNl2+j2r9px/yWUKZJCcisveuy4vb84of9e4MQKF41BgWgKeyrFBND6rrxFVfYafujrnlq383ZVExWSOw1CvkzyTjAPq9R4FUlTB+P1/I4NsZ6WfzGjUCz/ajDliQVuVz6dW8zs9sQvff3KzslCByYty62WT/sXjmNJb4v8P+u73XUqe5yOusBkCnjwImtDh1//uugjJ6N5PjZreZaWikl9kS0t7j6AlfomTbQbJE6Y+JKmMs3sVDjvuarL+ng/jLL1tSR/0uV3y2NTUrl3kFKcr288eJ0DyjHpydgaLcxvvBaSptnzOeUK1BH/dfg8niaKHPQQqKSyNjuxU0yDoZUrNRJs2LwSFX7V1CpDs94ylaKr54eRU+9VvOIHUirVPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(36860700001)(40460700003)(36756003)(356005)(5660300002)(70206006)(86362001)(41300700001)(6916009)(8936002)(8676002)(40480700001)(81166007)(4326008)(70586007)(316002)(82740400003)(478600001)(47076005)(1076003)(2906002)(186003)(16526019)(426003)(26005)(7696005)(336012)(83380400001)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 00:43:14.9041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56de2c34-2ef4-4093-da60-08db76a77e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
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

Rename psp_update_vcn_sram to psp_execute_ucode_loading
so that other clients can feel free to use it.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  5 +++--
 7 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index aa69269169a1..33f8b8389979 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2931,15 +2931,16 @@ int psp_rlc_autoload_start(struct psp_context *psp)
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
+int psp_execute_ucode_loading(struct amdgpu_device *adev,
+			      enum AMDGPU_UCODE_ID ucode_id,
+			      uint64_t ucode_gpu_addr,
+			      int ucode_size)
+{
+	struct amdgpu_firmware_info ucode = {
+		.ucode_id = ucode_id,
+		.mc_addr = ucode_gpu_addr,
+		.ucode_size = ucode_size,
+	};
 
 	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2cae0b1a0b8a..93849db18696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -459,8 +459,11 @@ extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_inde
 			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
 
 int psp_gpu_reset(struct amdgpu_device *adev);
-int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
-			uint64_t cmd_gpu_addr, int cmd_size);
+
+int psp_execute_ucode_loading(struct amdgpu_device *adev,
+			      enum AMDGPU_UCODE_ID ucode_id,
+			      uint64_t ucode_gpu_addr,
+			      int ucode_size);
 
 int psp_ta_init_shared_buf(struct psp_context *psp,
 				  struct ta_mem_context *mem_ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c975aed2f6c7..e89b1e760000 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -881,9 +881,10 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
-				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
-					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
+		psp_execute_ucode_loading(adev, AMDGPU_UCODE_ID_VCN0_RAM,
+			adev->vcn.inst->dpg_sram_gpu_addr,
+			(uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
+				   (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
 
 	/* force RBC into idle state */
 	rb_bufsz = order_base_2(ring->ring_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index bb1875f926f1..e5df190a79a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -912,9 +912,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		psp_execute_ucode_loading(adev,
+			inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
+			adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
+				   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
 
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c8f63b3c6f69..aa3d7439cd34 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1037,9 +1037,11 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+		psp_execute_ucode_loading(adev,
+			inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
+			adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
 			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+			(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
 
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 2db73a964031..d0867526e477 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -993,9 +993,11 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+		psp_execute_ucode_loading(adev,
+			inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
+			adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
 			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+				   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5d67b8b8a3d6..221a10f0316f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -778,9 +778,10 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+		psp_execute_ucode_loading(adev, AMDGPU_UCODE_ID_VCN0_RAM,
+			adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
 			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+				   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
-- 
2.25.1

