Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A85C5AD57
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA67810E36C;
	Fri, 20 Feb 2026 19:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4+SKdQIL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED61910E836
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4osOGH9au7PBq20VHZW7QzzCfGR1AdPvFVcEzooZ6nKlQEsVM2jvp1Fi+AuKQGbJcZbJy6qJowrf+aNBJ6RewsxzK0xEexgVSxlg1r1ng+d+WyRmZGw6FhRhPoQ/HNZIDHK0asvR7IjKozQOURvBlwuX3YunKO8N/i7dChgPAytIsCawyaBgenk8jhDr3ODK4Gt+KHvjDRF2Tnq9aYbz+XuMi0RexFa92bL7xEqD+bo7RGAM55ZyP922oy8Cy5J4S/xq8/TBv6M2rgf5GItYMnsD9y9P9QndooFLunFeP2X3v8yx2jeQYGl9ZDpTXMEMlEeXBNonRXyN9+WtUwVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7xiwh3YV1svEqqiu7aoS9uyn5jiyeIBtCFc7mWv3QU=;
 b=Sa8XZzW3qvAoo6gt+8jzhT2MWGOhiEsCcNmn6Sx0pnawaDQHu25/24JF9jzTyMFF2+qLPSn74XF7Y0vwmkHP0AqoCgJ4VVK25PTSc1i8d4JMYnUaohZcD5VVY3cUEm0694oAiWuV956m10bahfDQ8Fh4zWz+GbkkKAVhSeYGnyeK9v3T+wN6B88SOV4/qihQtyxumsPgvptsDVAjIcp/0KLCTkGbgZ/IGoyhbrGUowxfPSzkxR0GqdD2AHnXKMrStowu2ABiUVIFQzJ/8aAZrpswetoSkvmMoKksuNiI3GApexxEiNQP1mfEY7REoQbfhSgHwEvDQRsHD8tb0gK1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7xiwh3YV1svEqqiu7aoS9uyn5jiyeIBtCFc7mWv3QU=;
 b=4+SKdQILiM5YLJBNDw7G/pEUqBA342jhM42EH0V/cG/b+Sbeyteb2GES9wLs5XqblqdNThmNtvTovQZg5blZaelUgzkUfZ3y+cOmn6ZoJ6SeEhTMB5kXNn8D3wggoec1SHHGFSlOOY9pAabpD2W+ncoTDs2T11eRDRpWSLxunko=
Received: from PH8P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::33)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:23:10 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::5e) by PH8P221CA0020.outlook.office365.com
 (2603:10b6:510:2d8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:09 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:57 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3
Date: Fri, 20 Feb 2026 14:22:36 -0500
Message-ID: <20260220192236.3121556-17-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e9fb8e-fbaf-436c-bec5-08de70b57b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UpK1SkewTEdaflmsc2gpypCGss1m0pvnYkt5N7E8SitYft3pxksaIBUAhzWG?=
 =?us-ascii?Q?45Xesd5MOXVC0jK+D+ljqvyewpYpvGrTtAyNpv+RICaM5NTwS89fsk6JapOX?=
 =?us-ascii?Q?bMsJvbChZS80SVT3Ht1KE48BE5tqq4N8Hcz1+wedUu5E3jUwChch4bDJqndF?=
 =?us-ascii?Q?hrkdulgsrczOWjreXm/4eNSABlcfdVNK/y3FoPd9UW1PwCFPpLJRf4WSUeyO?=
 =?us-ascii?Q?FFSBE2dEsjthsSMVIoKq228ag8BnocOowt1Y4DC4wX2Kkh2MO3u+ox+GdBUQ?=
 =?us-ascii?Q?tZY6VV7iNziv1yyScQaUdmGKTywy0O/AIlkAKYgM+2NdMHU+tSQsGQ+1URDU?=
 =?us-ascii?Q?ca79HvCYrhUaIBMe7vMGMqOtpxhEBy2Dp+oa4dDrAQKAcoOUjvEv9vWk0JsF?=
 =?us-ascii?Q?Ilo8HKwzRBrwjyzk1Ji8zhIpnnp1uznOUZiPH8rbxWS/16VCsEGV+styIga/?=
 =?us-ascii?Q?6J/kfsJl7ldofoPUcM0o9OnOMVMUE93UOCKOkRY+n/D856EKtekLoRKop3+e?=
 =?us-ascii?Q?iHOWhTKjLTsVKFwccgy1/TVvHztDd40G+M6vaQ+0NFuEIuZC2bw4jMw9KfxI?=
 =?us-ascii?Q?sGlXfjNWyakXmRNE4ifydGOIHj0f/oIhF14TA2ET+C40QTbctofSSb+5Cv2U?=
 =?us-ascii?Q?2EJ+40Gv7njriDm0kD2/NeXEyofPIY0+yApCjU5gF1HoEaWhgop4eiF3GJGr?=
 =?us-ascii?Q?dRJykMGzkBbphohNAGGfUJGqpn7vNifBT5oXd7uPGJsA83b5Xv8kr2pGO2qn?=
 =?us-ascii?Q?mKz+P0bX2SUgQfGIiUPqXhy2WxnSGg+hlufH1TRMyvIKWWjhNSEqL54cZbeY?=
 =?us-ascii?Q?ngr7armnIzQ+C/ZZp41yiY+dwN3f4PH6ttqWozbeZRBPWSiJ/nh2TE0/nEt8?=
 =?us-ascii?Q?g7HKN1nu/jk94CheFwPFllO/ZN+L2FD93qMi8yjrUMllKekJ2YQBXyBl3Vp4?=
 =?us-ascii?Q?qHr55EfHbpGZI2ybfW4gjxerdNAF6C/YhN52UYDWj2gkSf/6HZ3UnqVBsaM3?=
 =?us-ascii?Q?amgu6bqB7naszBUZM4pk6XC6V1QgPg2WIHlzmHaTpD118skOcS8SrWBgK4cd?=
 =?us-ascii?Q?ungB1c2NdyQ6jhDPNKLqMmSIt1r5nXxKbfI9HaCEKbhKgfyj7EITPNw3NrnW?=
 =?us-ascii?Q?oFG/4PihOlr8Hcc90BsYoCSwhttXcTLPubuub7iCFbsUtpgmp6J92l0LFWp6?=
 =?us-ascii?Q?ZS+og8BPiSMgg1voHvFsEuZGkPeVwKcjs7/5uAa4xx7C5dBggz+avf4p+tV3?=
 =?us-ascii?Q?GN7TnPBVBgLePbIuG9dRiF13mpcQJywDh9eIZGrN5QRSq3UIMtqcBmE5dDai?=
 =?us-ascii?Q?++jVkkLhULcvl39DiaBkVxEeWATN8S+t7e5mQJpo3d6G1s8BqSjveuKte232?=
 =?us-ascii?Q?Ln5071bjxmg8A2zByl/t7P58N0tICUIbhrTRNAVR6j3dqGRLUUYdUSReThM5?=
 =?us-ascii?Q?MEXpx0ccKdSs74IHT1S2xJDRkdwD6FOxnlNK5FrJynVn2r4a6wpz0r/aXyc7?=
 =?us-ascii?Q?LqKTO8zV0Ysh8x4NuAAyfbRqdApsXltVWzv8uj2T1fQXX+/1wn4v9cXYWDnZ?=
 =?us-ascii?Q?9boRQ1w1Et4j3fXGd3SQxZabYEYPzDrp6lDoHn33L8M6Z9xSSSx+5fDK0kDU?=
 =?us-ascii?Q?ALmFoOlFj/A9mV57J1/wambx4bCYt2Ct5Z3xp0I7i0oxt8wslZDuJn/3HwQJ?=
 =?us-ascii?Q?PrUsPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: twQ+YzXYTesxrQUwT9gKG68npyB9i4BkHyOCjVrepXW2V9siKUp5Sf/5Cn375Af5HwyCQN51r43r9fKJnT2Y+NM6ki1QY35D6iUUGTGMbc4wWMoHIEnQV6A8eT3BjDGmuacK/os39lew95ryK1W9BEEyWYnjjI3oY7f3GgVclkTnDUw3kgBdw36KNGwKlwInxxS245qvjN+Q/dawnWwLddh25yKaiTTxG1FdaIYuTjfS9igRewMPz3G7uHPIq/exCjKODTMexi0GZvkQyZ2Of9HOuml06a7aJqJ4WZZNOgqOFK1/AQrFDYvCicecMoEb9UxlHZU9frb6pK2vtK9bvI7xr3NisrEDYryxngyfJPRmk2Zr99ZfdcSOjmwYpvFjzNbRbeQgyHPYqB4ip8weCmwQYxWQ5wmAy5mID919uroyCyn4337JYOv8s5js/Qg9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:09.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e9fb8e-fbaf-436c-bec5-08de70b57b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

with spm function interface and spm irq.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 194 ++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 44b07785bf9c..29fd5e2413da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -169,6 +169,8 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev,
+					      int xcc_id, unsigned int vmid);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 
@@ -1065,6 +1067,13 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
+	/* SPM */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+			      GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
+			      &adev->gfx.spm_irq);
+	if (r)
+		return r;
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
 	if (r)
@@ -1453,10 +1462,14 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+	int i, num_xcc;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
 
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, i, NULL, 0xf);
 	return 0;
 }
 
@@ -1631,14 +1644,15 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
 {
 	int r;
 
+	gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-		gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
 		/* legacy rlc firmware loading */
 		r = gfx_v9_4_3_xcc_rlc_load_microcode(adev, xcc_id);
 		if (r)
 			return r;
-		gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
 	}
+	gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, 0xf);
+	gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 	/* disable CG */
@@ -1666,28 +1680,38 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
-					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev,
+					      int xcc_id, unsigned int vmid)
 {
 	u32 reg, pre_data, data;
 
-	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL);
+	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
 		pre_data = RREG32_NO_KIQ(reg);
 	else
-		pre_data = RREG32(reg);
+		pre_data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
 
 	data =	pre_data & (~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK);
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
 	if (pre_data != data) {
 		if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev)) {
-			WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
+			WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
 		} else
-			WREG32_SOC15(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
 	}
 }
 
+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_ring *ring, unsigned int vmid)
+{
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, vmid);
+
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static const struct soc15_reg_rlcg rlcg_access_gc_9_4_3[] = {
 	{SOC15_REG_ENTRY(GC, 0, regGRBM_GFX_INDEX)},
 	{SOC15_REG_ENTRY(GC, 0, regSQ_IND_INDEX)},
@@ -2373,6 +2397,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i, num_xcc;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
@@ -2507,12 +2532,112 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
 				   (1 << (oa_size + oa_base)) - (1 << oa_base));
 }
 
+static void gfx_v9_4_3_spm_start(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_PERFMON_CNTL);
+	data |= RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_PERFMON_CNTL), data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
+
+	/* When SPM is reset, RLC automatically resets wptr to 0.
+	 * Manually reset rptr to match this.
+	 */
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), 0);
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_INT_CNTL), 1);
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
+	data |= RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK;
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
+}
+
+static void gfx_v9_4_3_spm_stop(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
+	data &= (~RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_STOP_COUNTING);
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
+
+	/* When SPM is reset, RLC automatically resets wptr to 0.
+	 * Manually reset rptr to match this.
+	 */
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), 0);
+}
+
+static void gfx_v9_4_3_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id,  u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), rptr);
+}
+
+static void gfx_v9_4_3_set_spm_perfmon_ring_buf(struct amdgpu_device *adev,
+					    int xcc_id, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
+			regRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0,
+				regRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits(gpu_addr));
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+				regRLC_SPM_PERFMON_RING_SIZE), size);
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+				regRLC_SPM_SEGMENT_THRESHOLD), 0x1);
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), 0);
+}
+
+static const struct spm_funcs gfx_v9_4_3_spm_funcs = {
+	.start = &gfx_v9_4_3_spm_start,
+	.stop = &gfx_v9_4_3_spm_stop,
+	.set_rdptr = &gfx_v9_4_3_spm_set_rdptr,
+	.set_spm_perfmon_ring_buf = &gfx_v9_4_3_set_spm_perfmon_ring_buf,
+	.set_spm_config_size = 30,
+};
+
+static void gfx_v9_4_3_set_spm_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.spmfuncs = &gfx_v9_4_3_spm_funcs;
+}
+
 static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
+	gfx_v9_4_3_set_spm_funcs(adev);
 	gfx_v9_4_3_set_kiq_pm4_funcs(adev);
 	gfx_v9_4_3_set_ring_funcs(adev);
 	gfx_v9_4_3_set_irq_funcs(adev);
@@ -2534,6 +2659,10 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -3404,6 +3533,41 @@ static void gfx_v9_4_3_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }
 
+static int gfx_v9_4_3_spm_set_interrupt_state(struct amdgpu_device *adev,
+					     struct amdgpu_irq_src *src,
+					     unsigned int type,
+					     enum amdgpu_interrupt_state state)
+{
+	int i, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
+		switch (state) {
+		case AMDGPU_IRQ_STATE_DISABLE:
+			WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CNTL, 0);
+			break;
+		case AMDGPU_IRQ_STATE_ENABLE:
+			WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CNTL, 1);
+			break;
+		default:
+			break;
+		}
+	}
+	return 0;
+}
+
+static int gfx_v9_4_3_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	int xcc_id;
+
+	xcc_id = gfx_v9_4_3_ih_to_xcc_inst(adev, entry->node_id);
+
+	amdgpu_rlc_spm_interrupt(adev, xcc_id);
+	return 0;
+}
+
 static void gfx_v9_4_3_emit_wave_limit_cs(struct amdgpu_ring *ring,
 					uint32_t pipe, bool enable)
 {
@@ -4831,11 +4995,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_funcs = {
 	.process = gfx_v9_4_3_priv_inst_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_spm_irq_funcs = {
+	.set = gfx_v9_4_3_spm_set_interrupt_state,
+	.process = gfx_v9_4_3_spm_irq,
+};
+
 static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev->gfx.eop_irq.funcs = &gfx_v9_4_3_eop_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v9_4_3_spm_irq_funcs;
+
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v9_4_3_priv_reg_irq_funcs;
 
-- 
2.34.1

