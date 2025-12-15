Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9ADD5B85B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5745B10E4D8;
	Mon, 15 Dec 2025 18:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iazAbpL5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DDD10E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtBj3sfsFYopHNKQniwqfaiFRTLDzsa6PU387rWT00/I7hZOGUaA++w5pzTFkncFuisr8hQL5UoCa0mXKS/PdnaU7aSZTRlP47iNoxr/K4BX7HcySh4eLbXspQoZRixz1KxrqCDnPTRmNYARLhT1RRXb0+AddPHT9hLMAqY5gFWBSV6GTw1Bjo5HamSyxb2tDqumFOLP5cjEqZ0eEPGXH0d4u3WL7a4sT8QbcQaRgMhs7l2ypvQXHMXPfAJXAyu7MVaqzqzVY6iCYVBaZZrCo00IuIpFSI9bLN51zzyKwwcwP9u0zQLWhnvxyhEMcjuteW6MHtvRNV5fkoDMTfmvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5jvs6AF4103himvNG15JpS6eGmuIWtGqypsOqhq8jw=;
 b=M6wIobUOkyiIMJyksBcn4ZjxOJzPSebRSte2cBKBBevm9vuh3RHin3+166jEv5PvVya+ShZQut7hYQX6Y5EGi5cfM7njAXbJkaFFdWqNKXeV0vriwyTwdqSRE67WPLetVCoF+TfODhci0mqM22pjH6CMMtJrMI9wWUx9bgFEUa5SvSo0CzmPvDJ6b3ABV4q/lUqFPb8O26SWMZvDhBCAWldpPMY1QPm0bzzz9sPCSBEtZFuZK5oRKruRQ9ECraTLMUHtp6Se7Nvmobe6b0DgeFk8BfyyTxNETCNCIwW8hu71FFvBLjkJYGyBtAewZhwdoJ9MIAiAsOPvZKEwgL+0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5jvs6AF4103himvNG15JpS6eGmuIWtGqypsOqhq8jw=;
 b=iazAbpL5bjMscRaRMI3S1sh7I9sG1GQyKOKz2juX9e9fg/yvpzouCs2eD6KeEbMf5uQ8iGQh3VVJk8BvuaXoOrHxOrHFhteWVzUIGfUZcral4ud4OkmTtxG+36f97akXA0CMbNvhE0lxkk6lAkxy/JsW031/fDgHOfcafMF1mKE=
Received: from BL1PR13CA0225.namprd13.prod.outlook.com (2603:10b6:208:2bf::20)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:24 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c1) by BL1PR13CA0225.outlook.office365.com
 (2603:10b6:208:2bf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:24 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: adjust xcc_cp_resume function for gfx_v12_1
Date: Mon, 15 Dec 2025 13:15:54 -0500
Message-ID: <20251215181607.29132-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 7816a5bb-099a-4436-2446-08de3c060e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zo0fCEzL/D7rT39wmbytDuOxHwXQlTYbnbs7Rtea1cdUQTKncMVtrLENLYHY?=
 =?us-ascii?Q?LSdQqeGanaSRocoOguDV4wVCVd6UCoW2zQP1gos5Dzkf1AXtDIfwkR9jo7OY?=
 =?us-ascii?Q?Wp0ORXTVipNviUL/s6ewFhMa8O/ZIOoF4LXqNDz91KAAHPr9K61AjE6Q4zdr?=
 =?us-ascii?Q?5U9TdD7stn0rKqFYluGaNYnBvHbHG/McW/dp2gIJkWH5hgZBMvluqJNBlXic?=
 =?us-ascii?Q?F75SD2fHHtAOtTmfTT7RZcapWO1H5Th7YzgBdMy4NQlUe8QO9VxAK6pKjxI5?=
 =?us-ascii?Q?tJtLcbb4PRDyRuku9Qxe2MGhxz2sW73EiVdmtG0QVWzX+8vUmKcGa/YRb7BJ?=
 =?us-ascii?Q?ltoJxPYTRslsQ157FeqwxzXeticYL3OtwQWQOo8agv83C+U3+tM9rjYXHfX/?=
 =?us-ascii?Q?nQ86ZSZ1MNrDhZPiqB6f6bpoMtrzzublmw6RBGT/WHYGXFoYJx8onIESYHkP?=
 =?us-ascii?Q?d/f3vUACmHBmOL8MigfUB+X2lQ7FyLVFvdtGfbbNwP3TjDaawPuEPpXke6XA?=
 =?us-ascii?Q?HY/JgMYwXlqdvws0nV280h9SKFb0t/Ppf1E4077Ys7MTkybMgOofq0E94Len?=
 =?us-ascii?Q?N3qq/vHyswBitvLkwxV1MJ2OUYheERQol4bSJZ7CQ0gK48dRo2ASIbDwHfru?=
 =?us-ascii?Q?3vfBItGWCxv7BSH3Ilke/q6N9MAISPB3mfwi1RvDZi7D8BsCH+MFnwIua2HH?=
 =?us-ascii?Q?iSoTGNnAcYSWy/qG1ETJ2ozwq5TMAOLD95qvPE9BdM9Hm7e+5x/DJSclw4NE?=
 =?us-ascii?Q?jAVrz8eyZeErG8slzwatQLE75KOqCzhGhqEaSkNLkySaqChUWZk9+nRjlqwH?=
 =?us-ascii?Q?itm+L0Psp98JlXO4kZ6foMZSuYPV+RCoYEgOOqqCbSYkZJaBsG02C9wFTckG?=
 =?us-ascii?Q?6AABocnYkvPDyfszZXoGU9CQPOta1dhUs8hEfML3FGc1T77i7Zy3/AHyUk1F?=
 =?us-ascii?Q?m52nwMj4flEgG3+wiKtDGhTl5SQHv4O+hSObXJrGuT7yRc1YlWWQEG0yGieR?=
 =?us-ascii?Q?s2nX2VJhG6sZdbJyu7UGAC0jJYgP35e/SeplndevNZY2CmZWK480jWbKQ0xA?=
 =?us-ascii?Q?bZsXPcdZUpOjkFZIUqlYpAgiXyAbPEzpfmZ4LREys3d17zEroPytsWoxU/6c?=
 =?us-ascii?Q?2x51rAgWKFXks2Sdwp4ickFCQgqwN2cCFDhrK+YbDSEGA8yFb4Q4xtn5iMe1?=
 =?us-ascii?Q?H3RkAD3160EPd78lZaJHPhf8VQpLVXh6y43RclEqkr5cZBmUQ+yOXLuu3VY9?=
 =?us-ascii?Q?7UCxFEF2lrqalIVwLRlf4HJZH7yG8QtAVwfrgLKu2kC6KonS/rxGzmlpuvG+?=
 =?us-ascii?Q?ydTiiMvKBDpyt7VvPQb7UEYaGF/c4mxHNc6pGViHAwAjNEdqD9bDO+ESRNIq?=
 =?us-ascii?Q?XcSCOwiKLoK7ZTvgmfHjVEIBRgKO/BSTgnxsdP+ot19Y0ARclIdklLxqD7zM?=
 =?us-ascii?Q?lwTJbIG21UhHMkSNRxc4latR6Yg5Tgodh1b0g7c6K3U5jerqdjHLV8m0Xzly?=
 =?us-ascii?Q?FK9J6lkJNQxHeeyxMAaj1wusu4IzGQJDb1O4FIDiIkIOxN/v43eeAHEXmq67?=
 =?us-ascii?Q?08u5YctjjdEth/ZJw/A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:24.3552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7816a5bb-099a-4436-2446-08de3c060e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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

From: Likun Gao <Likun.Gao@amd.com>

Adjust gfx_v12_1_xcc_cp_resume function to program
cp resume per xcc_id (logic xcc number) to fix for
xcp_resume.
V2: Allocate compute microcode bo when sw init

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 244 ++++++++++++++-----------
 1 file changed, 135 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index c2b9311831646..c43f9a9fe662a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -89,6 +89,7 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
 					 bool enable, int xcc_id);
+static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
 
 static void gfx_v12_1_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 					uint64_t queue_mask)
@@ -1245,6 +1246,10 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 		r = gfx_v12_1_rlc_autoload_buffer_init(adev);
 		if (r)
 			return r;
+	} else if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		r = gfx_v12_1_init_cp_compute_microcode_bo(adev);
+		if (r)
+			return r;
 	}
 
 	r = gfx_v12_1_gpu_early_init(adev);
@@ -1919,15 +1924,13 @@ static void gfx_v12_1_xcc_cp_compute_enable(struct amdgpu_device *adev,
 	udelay(50);
 }
 
-static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *adev,
-							uint16_t xcc_mask)
+static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev)
 {
 	const struct gfx_firmware_header_v2_0 *mec_hdr;
 	const __le32 *fw_ucode, *fw_data;
-	u32 tmp, fw_ucode_size, fw_data_size;
-	u32 i, usec_timeout = 50000; /* Wait for 50 ms */
+	u32 fw_ucode_size, fw_data_size;
 	u32 *fw_ucode_ptr, *fw_data_ptr;
-	int r, xcc_id;
+	int i, r, xcc_id;
 
 	if (!adev->gfx.mec_fw)
 		return -EINVAL;
@@ -1943,120 +1946,140 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *ad
 				le32_to_cpu(mec_hdr->data_offset_bytes));
 	fw_data_size = le32_to_cpu(mec_hdr->data_size_bytes);
 
-	r = amdgpu_bo_create_reserved(adev, fw_ucode_size,
-				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->gfx.mec.mec_fw_obj,
-				      &adev->gfx.mec.mec_fw_gpu_addr,
-				      (void **)&fw_ucode_ptr);
-	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
-		gfx_v12_1_mec_fini(adev);
-		return r;
-	}
+	if (adev->gfx.mec.mec_fw_obj == NULL) {
+		r = amdgpu_bo_create_reserved(adev, fw_ucode_size,
+					      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+					      &adev->gfx.mec.mec_fw_obj,
+					      &adev->gfx.mec.mec_fw_gpu_addr,
+					      (void **)&fw_ucode_ptr);
+		if (r) {
+			dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
+			gfx_v12_1_mec_fini(adev);
+			return r;
+		}
 
-	r = amdgpu_bo_create_reserved(adev,
-				      ALIGN(fw_data_size, 64 * 1024) *
-				      adev->gfx.mec.num_pipe_per_mec * NUM_XCC(xcc_mask),
-				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->gfx.mec.mec_fw_data_obj,
-				      &adev->gfx.mec.mec_fw_data_gpu_addr,
-				      (void **)&fw_data_ptr);
-	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
-		gfx_v12_1_mec_fini(adev);
-		return r;
+		memcpy(fw_ucode_ptr, fw_ucode, fw_ucode_size);
+
+		amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
+		amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 	}
 
-	memcpy(fw_ucode_ptr, fw_ucode, fw_ucode_size);
-	for (xcc_id = 0; xcc_id < NUM_XCC(xcc_mask); xcc_id++) {
-		for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
-			u32 offset = (xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
-				     ALIGN(fw_data_size, 64 * 1024) / 4;
-			memcpy(fw_data_ptr + offset, fw_data, fw_data_size);
+	if (adev->gfx.mec.mec_fw_data_obj == NULL) {
+		r = amdgpu_bo_create_reserved(adev,
+					      ALIGN(fw_data_size, 64 * 1024) *
+					      adev->gfx.mec.num_pipe_per_mec * NUM_XCC(adev->gfx.xcc_mask),
+					      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+					      &adev->gfx.mec.mec_fw_data_obj,
+					      &adev->gfx.mec.mec_fw_data_gpu_addr,
+					      (void **)&fw_data_ptr);
+		if (r) {
+			dev_err(adev->dev, "(%d) failed to create mec fw data bo\n", r);
+			gfx_v12_1_mec_fini(adev);
+			return r;
+		}
+
+		for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
+			for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
+				u32 offset = (xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
+					     ALIGN(fw_data_size, 64 * 1024) / 4;
+				memcpy(fw_data_ptr + offset, fw_data, fw_data_size);
+			}
 		}
+
+		amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_data_obj);
+		amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_data_obj);
 	}
 
-	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
-	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_data_obj);
-	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
-	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_data_obj);
+	return 0;
+}
+
+static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *adev,
+							int xcc_id)
+{
+	const struct gfx_firmware_header_v2_0 *mec_hdr;
+	u32 fw_data_size;
+	u32 tmp, i, usec_timeout = 50000; /* Wait for 50 ms */
+
+	if (!adev->gfx.mec_fw)
+		return -EINVAL;
 
-	for (xcc_id = 0; xcc_id < NUM_XCC(xcc_mask); xcc_id++) {
-		gfx_v12_1_xcc_cp_compute_enable(adev, false, xcc_id);
+	mec_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.mec_fw->data;
+	fw_data_size = le32_to_cpu(mec_hdr->data_size_bytes);
 
-		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL);
-		tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, VMID, 0);
-		tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, EXE_DISABLE, 0);
-		tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL, tmp);
+	gfx_v12_1_xcc_cp_compute_enable(adev, false, xcc_id);
 
-		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_BASE_CNTL);
-		tmp = REG_SET_FIELD(tmp, CP_MEC_DC_BASE_CNTL, VMID, 0);
-		tmp = REG_SET_FIELD(tmp, CP_MEC_DC_BASE_CNTL, CACHE_POLICY, 0);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_BASE_CNTL, tmp);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, VMID, 0);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, EXE_DISABLE, 0);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL, tmp);
 
-		mutex_lock(&adev->srbm_mutex);
-		for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
-			soc_v1_0_grbm_select(adev, 1, i, 0, 0, GET_INST(GC, xcc_id));
-
-			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_MDBASE_LO,
-					lower_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
-									(xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
-									ALIGN(fw_data_size, 64 * 1024)));
-			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_MDBASE_HI,
-					upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
-									(xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
-									ALIGN(fw_data_size, 64 * 1024)));
-
-			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_LO,
-					lower_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
-			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_HI,
-					upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
-		}
-		mutex_unlock(&adev->srbm_mutex);
-		soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_BASE_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_DC_BASE_CNTL, VMID, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_DC_BASE_CNTL, CACHE_POLICY, 0);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_BASE_CNTL, tmp);
 
-		/* Trigger an invalidation of the L1 instruction caches */
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
+		soc_v1_0_grbm_select(adev, 1, i, 0, 0, GET_INST(GC, xcc_id));
+
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_MDBASE_LO,
+			     lower_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
+					   (xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
+					   ALIGN(fw_data_size, 64 * 1024)));
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_MDBASE_HI,
+			     upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
+					   (xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
+					   ALIGN(fw_data_size, 64 * 1024)));
+
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_LO,
+				lower_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_HI,
+				upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
+	}
+	mutex_unlock(&adev->srbm_mutex);
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
+
+	/* Trigger an invalidation of the L1 instruction caches */
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_DC_OP_CNTL, INVALIDATE_DCACHE, 1);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL, tmp);
+
+	/* Wait for invalidation complete */
+	for (i = 0; i < usec_timeout; i++) {
 		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL);
-		tmp = REG_SET_FIELD(tmp, CP_MEC_DC_OP_CNTL, INVALIDATE_DCACHE, 1);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL, tmp);
-
-		/* Wait for invalidation complete */
-		for (i = 0; i < usec_timeout; i++) {
-			tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL);
-			if (1 == REG_GET_FIELD(tmp, CP_MEC_DC_OP_CNTL,
-						INVALIDATE_DCACHE_COMPLETE))
-				break;
-			udelay(1);
-		}
+		if (1 == REG_GET_FIELD(tmp, CP_MEC_DC_OP_CNTL,
+				       INVALIDATE_DCACHE_COMPLETE))
+			break;
+		udelay(1);
+	}
 
-		if (i >= usec_timeout) {
-			dev_err(adev->dev, "failed to invalidate instruction cache\n");
-			return -EINVAL;
-		}
+	if (i >= usec_timeout) {
+		dev_err(adev->dev, "failed to invalidate data cache\n");
+		return -EINVAL;
+	}
 
-		/* Trigger an invalidation of the L1 instruction caches */
-		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL);
-		tmp = REG_SET_FIELD(tmp, CP_CPC_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL, tmp);
-
-		/* Wait for invalidation complete */
-		for (i = 0; i < usec_timeout; i++) {
-			tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL);
-			if (1 == REG_GET_FIELD(tmp, CP_CPC_IC_OP_CNTL,
-						INVALIDATE_CACHE_COMPLETE))
-				break;
-			udelay(1);
-		}
+	/* Trigger an invalidation of the L1 instruction caches */
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_OP_CNTL, INVALIDATE_CACHE, 1);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL, tmp);
 
-		if (i >= usec_timeout) {
-			dev_err(adev->dev, "failed to invalidate instruction cache\n");
-			return -EINVAL;
-		}
+	/* Wait for invalidation complete */
+	for (i = 0; i < usec_timeout; i++) {
+		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL);
+		if (1 == REG_GET_FIELD(tmp, CP_CPC_IC_OP_CNTL,
+				       INVALIDATE_CACHE_COMPLETE))
+			break;
+		udelay(1);
+	}
 
-		gfx_v12_1_xcc_set_mec_ucode_start_addr(adev, xcc_id);
+	if (i >= usec_timeout) {
+		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		return -EINVAL;
 	}
 
+	gfx_v12_1_xcc_set_mec_ucode_start_addr(adev, xcc_id);
+
 	return 0;
 }
 
@@ -2460,14 +2483,14 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 	int r, i, xcc_id;
 	struct amdgpu_ring *ring;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		/* legacy firmware loading */
-		r = gfx_v12_1_xcc_cp_compute_load_microcode_rs64(adev, xcc_mask);
-		if (r)
-			return r;
-	}
+	for_each_inst(xcc_id, xcc_mask) {
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			/* legacy firmware loading */
+			r = gfx_v12_1_xcc_cp_compute_load_microcode_rs64(adev, xcc_id);
+			if (r)
+				return r;
+		}
 
-	for (xcc_id = 0; xcc_id < NUM_XCC(xcc_mask); xcc_id++) {
 		if (!(adev->flags & AMD_IS_APU))
 			gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 
@@ -2500,6 +2523,7 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 static int gfx_v12_1_cp_resume(struct amdgpu_device *adev)
 {
 	int num_xcc, num_xcp, num_xcc_per_xcp;
+	uint16_t xcc_mask;
 	int r = 0;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
@@ -2531,7 +2555,9 @@ static int gfx_v12_1_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	return gfx_v12_1_xcc_cp_resume(adev, adev->gfx.xcc_mask);
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+
+	return gfx_v12_1_xcc_cp_resume(adev, xcc_mask);
 }
 
 static int gfx_v12_1_gfxhub_enable(struct amdgpu_device *adev)
-- 
2.52.0

