Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6009CEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 03:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B5810E0A3;
	Mon, 10 Jul 2023 03:10:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01FE10E0A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 03:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLxIAoi2cP6iihsyvHik2dmrxJMak/L4CbEZ6S8fjovNTHcxX4i/puulNW4H05WVmWuQfAqVibkQoh6DC2mFV5Tl/EeERnuV8gmUjmjP25IEjLLxyFQdjVaMV+LPmVC8FD1MupMNApGLrw7+bdbZhMqyxUdZYoRNsjddavpWhwoyRR00fC+x5J77uso/RKoKxBpgYJpfE0Hrm47ZChWNAyl0rGs1abtkkvZJaSMOsYqR4p1uuCjP3bbe2FmxcteimjiS7gujmwqGXnGqu5v98gC+SK82c2Q0Tv+oJrZOeATuMN48wMKKSguixxlOrSeVBvs4j4lU5WMLdLu0irfDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZmHSox6xJYTNEGhADegfkAb/S5YOBoJ8YrvWa7ekHM=;
 b=CHTl/40zUATLdrb5EvlP1OqjjZ2P/AkuSKlo3zYQRx4bDVpxNdR65dRjUwH8DMFrtDohQYNhbevIfWg1tzv9Q1ZpPFp7ZYHn3aVCJR5akMFmB7/SJMHiGNBdiarQZYCiP5+5PZfLk8hu83s/iyg8sH1ODHHQdPO/9zSdqzG89PvD06NPRJruS6paHZBz6arvoPkehxhoaWEp/ijzFc8moCzF46t5oRJqUYLEUZAYld3FmAnVy9AakVkVfH1WxsNBUwwO0llEpRl4Vgm+05Eztey9JkaeFnhPlzUKbH9umd7TkjlAJNZeiyEek7rcaoDoKYVWbT87AR/qSCmkOZ8H+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZmHSox6xJYTNEGhADegfkAb/S5YOBoJ8YrvWa7ekHM=;
 b=Crwi9iB5js8dc0qgym4uHtNaE/5e8tDAWG8dQduDI21jTT1bwi0dpZPND8dP69y68VGOtseGn5aTFiR/MTrXJmiPoN0gBwE2IqxVJE7WaE9O1UQOzN8vYtQ79KIM0iIf2AD3yrISvbulWAA/YyZiWcRv0BC3XVytTErAnZv/8XU=
Received: from MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 03:10:53 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::e0) by MW4PR03CA0139.outlook.office365.com
 (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 03:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 03:10:52 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 22:10:38 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: use psp_execute_load_ip_fw instead
Date: Mon, 10 Jul 2023 11:10:04 +0800
Message-ID: <20230710031004.1106582-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710031004.1106582-1-Lang.Yu@amd.com>
References: <20230710031004.1106582-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e606233-cfdd-4139-54bd-08db80f3454e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0h+aOZcWmvmM6RUZpd50DvMY93nDVsXwN+EX0IpzdkPWSIvUx/8COBDK2GTszK3NdN8wJBpx6weXAMiZAr24meIJDxGkUdvOfL6NaKZZ3WuQiurqxc9kKzRsM78pxF4eZTZdhHT3GQNP5xKMtaARlea4ZuD+EAs14SKo5dx0RmdG7s76EuVh4Krz243IB4l4HPUiMPn5Txl8430DZYJHpRL2kbb1Vje/UMldZqjtysjTX87YRk5oY4iutmJzGccP/s3N6phQ/Pu9nFv8yu9QG5WueYgqTvAE/zhQ40JPfmGYuZI4fOqMb4cB89TppkL9r9KWAfMdx/F8FjIeui2VT+K5GdEUgyWQhcoNfzaaxubw3A0e+HV9BL40Nogn8rQOAVabGipH7q12WbdvqmA7+KLIIftOAiqJuE5YGkC86JXD2cvXXJHquxzcIFig/ZOynbm4xahNmiHd+VmFkwNdGo7qhLYntdHmEOFc2IvpgzfbqK9IrCNshkAXF/Ckh3EGP8IzzHUQfV4FUKiF6/I9X9/KMePigNJMFtgteb7R/MlzDkci1ZoiR9mmOrXjRk/guLid6txkmTqmLiPBPdmc+x2tld71hNOCoIXqeeBXY/Rc84ymfeNHk8P4NrxNqHmnbcH/vWhPT6GMPlVRcgLGjUKDGEPLenQqBASgqxqInxsFN9KOt/p/rdSG7BONG13/bs1JyRef45d+E1yDwEyAS2HZEGNAE9kXwSHSMTBQiqoj82AHwSdjBsM4RdG9VrfM6xDYYqa3qBjtiK5VkuVQyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(186003)(16526019)(26005)(2616005)(1076003)(36860700001)(336012)(426003)(83380400001)(47076005)(41300700001)(4326008)(6916009)(2906002)(316002)(5660300002)(8676002)(8936002)(478600001)(7696005)(6666004)(70206006)(70586007)(54906003)(40480700001)(36756003)(81166007)(356005)(82740400003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 03:10:52.9508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e606233-cfdd-4139-54bd-08db80f3454e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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
Cc: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the old ones with psp_execute_load_ip_fw.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 -------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +---
 9 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a1a4408e524d..1b4d5f04d968 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2920,19 +2920,6 @@ int psp_rlc_autoload_start(struct psp_context *psp)
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
-	return psp_execute_ip_fw_load(&adev->psp, &ucode);
-}
-
 int psp_ring_cmd_submit(struct psp_context *psp,
 			uint64_t cmd_buf_mc_addr,
 			uint64_t fence_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index efb3972bfebd..c3203de4a007 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -466,8 +466,6 @@ int psp_execute_ip_fw_load(struct psp_context *psp,
 			   struct amdgpu_firmware_info *ucode);
 
 int psp_gpu_reset(struct amdgpu_device *adev);
-int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
-			uint64_t cmd_gpu_addr, int cmd_size);
 
 int psp_ta_init_shared_buf(struct psp_context *psp,
 				  struct ta_mem_context *mem_ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d37ebd4402ef..4e1256af80b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1257,3 +1257,18 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
+			       enum AMDGPU_UCODE_ID ucode_id)
+{
+	struct amdgpu_firmware_info ucode = {
+		.ucode_id = (ucode_id ? ucode_id :
+			    (inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM :
+					AMDGPU_UCODE_ID_VCN0_RAM)),
+		.mc_addr = adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+		.ucode_size = ((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
+			      (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr),
+	};
+
+	return psp_execute_ip_fw_load(&adev->psp, &ucode);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 92d5534df5f4..1f1d7dc94f90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -414,4 +414,7 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
 			struct ras_common_if *ras_block);
 int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
+int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
+			       enum AMDGPU_UCODE_ID ucode_id);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c975aed2f6c7..18794394c5a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -881,9 +881,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
-				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
-					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, 0, 0);
 
 	/* force RBC into idle state */
 	rb_bufsz = order_base_2(ring->ring_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index bb1875f926f1..6fbea38f4d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -912,9 +912,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
 
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c8f63b3c6f69..b76ba21b5a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1037,9 +1037,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
 
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d96ff4acae35..e8c02ae10163 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -993,9 +993,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5d67b8b8a3d6..550ac040b4be 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -778,9 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
-			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
-				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
-- 
2.25.1

