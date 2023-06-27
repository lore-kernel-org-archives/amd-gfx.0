Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA16EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 04:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7772A10E284;
	Tue, 27 Jun 2023 04:48:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A7610E271
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 04:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0so3jeEYRjV5E28tSVDkTxCUh5LWde73uq5zCRHFKNzZeUpSWadoNp7w7uAPuF4zAXbeOlHFqjjmDPkpE0Y4MMi4ZV58Nz/za7hkArhGEMKaLaKOYozEtsAqE/RjYm+uh5k4UoDnCRESGaQ6lm/JxfFl7Fwvuz+14g4zMUgpo0Sv0eZ6pz0wVWuGDs39xGplwLLhT9ENRi+XqB+sIZPPzraUZIbLhfXZFcC3V9a/rcJQR2hdWY2TpEq0Zc0NMVjq1C6YYAgMrI+1wId3VseS//wMj8DCaOm/3bhz6WCLKn9h+C8MTj0Fov4ASSOFaSkxQUUeyeaTAmqsJtBrAGxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqV+CEq2tdWyqLWOu6hugfCvWhA3Nh978TRSnkxvzwY=;
 b=Pv+0kcwsIZCDEVM05fkf8gwyEyC8nxDDOtUJc/8AbYLNtV5a4x+plA4CFYZ6IazkRckhNYKoIWCQ15TSBMgbOk9f0fhiwokX93UkPZJ6gQAiaDNy7rwm7S4GeXmpf75WwW9v2g/r62euY3bVQFNO4qYkHuJynttsBwxuJfXxwweCWuw9br8CbSrFaazsj4jOwPVaHwE37UryCKyDciIcFtfIIDr3NJiSCokyH7GXtgNyGdz7C6eH/7/sC8OTCa35/ZJJahJyjOzyNz8EhSWzEniP7kuApHB8Tjw2CLWtZOkmNqZEDqUB90Oe+M8s8V6s6MUsUMiDbOvXc0pc1sJDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqV+CEq2tdWyqLWOu6hugfCvWhA3Nh978TRSnkxvzwY=;
 b=sIdsB0j1IghSLiUXeYGmRmbGKsNbt+he/kAdIcEUqAfh0qfXJBAIFhYKgLXrdxYJkSAWDSk3lR+eH8PkdVX0tzkG6wsfg1JaaEwFN/EYxqs/b5Q0/V61jHESXwVCVgyPiDcLS99Ut/yRNI94/gGldSluzja4QUBCgBY1IkJwq4c=
Received: from BN9PR03CA0930.namprd03.prod.outlook.com (2603:10b6:408:107::35)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 04:48:50 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::1d) by BN9PR03CA0930.outlook.office365.com
 (2603:10b6:408:107::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Tue, 27 Jun 2023 04:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 04:48:49 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 23:48:48 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: extract a PSP function to execute IP FW
 loading commands
Date: Tue, 27 Jun 2023 12:48:32 +0800
Message-ID: <20230627044833.3668402-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 63542eb7-c890-4a5d-52d4-08db76c9cc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBn0x+xvZLtA0XG3UD3ac37ucJ2YOD/I3l2X5kPSxDsArNTfIZ98Q1pQt+qjParGnG/uP1n3o+oFOU9eGvbVEJYFyHenup/qfcLUbXlUxCsE7bamArzTR8bpYe/1zxrZscZQtSCMCnFFub75Px1dEURLmBgt4dDN90xB/GF8icqWpVRAkVDrt0WlU/5LIhEtT1sQwczgSkMSwU9WIDHIfAINht6/RqVjGJ/cxEaDvU94hMLC5tnrNv9yWLRAfhqlA1IWIGrdd2WQRtxm3Oy6sXLEeIUzSL1bvGEguNQiHse6bIcQ7iJksKSMzwtcsahVEijMaNg4EegRAP85VFQJA3hBGqm1JpqglYwo5/0ZZs+491RgceU8OaW/yWU4u0C+P1KLkfrPmk1qXb5hGO04E8KrTtBLqV8jBTh0BU++Rv5+yy4tanQuPkpIlFg625wKuCS4RlQIN19QPqu7bUT5HykrnpYwWKp4MdDhFUCzSk+hq8pPC+V5G0qcFUgLEnn7U6cfiLcAqGCO7A7BpuNVmQfoQxSkrc/UWOgJHKwTZHQSuh9fd9RDCITq4bFI9AGAMzU8kblUXvyevrSrvnPUbfTfjToGTPfwAkoFBQ/n52KFo1dtXQ00aFmXycTb1A+rAeK1+cxO5MAzR2QBdfyhMhxwmxgVfPdtIPPdbddvumjS4ZdmOubg4yp87UM7p7HUd5t5YoAQfN1TTGRbRYsWLurEQ81xUa8SRo0Qz4aljPtoBshD0F1c9GALJ70HlZVLhUziiVxHCaBIyuoVlrru0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(82310400005)(36756003)(47076005)(7696005)(6666004)(478600001)(2616005)(426003)(83380400001)(336012)(26005)(186003)(1076003)(16526019)(2906002)(5660300002)(40460700003)(70206006)(356005)(6916009)(81166007)(316002)(70586007)(82740400003)(40480700001)(8676002)(86362001)(8936002)(41300700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 04:48:49.2940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63542eb7-c890-4a5d-52d4-08db76c9cc6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
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

This function is more general and easy to use by more clients.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 29 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 +++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a33c155dddcf..a1cb541f315f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2445,6 +2445,35 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
 	return ret;
 }
 
+int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
+				   struct amdgpu_firmware_info *ucode,
+				   uint32_t ucode_id,
+				   uint64_t cmd_buf_gpu_addr,
+				   int cmd_buf_size)
+{
+	struct amdgpu_firmware_info fw_info = {
+		.ucode_id = ucode_id,
+		.mc_addr = cmd_buf_gpu_addr,
+		.ucode_size = cmd_buf_size,
+	};
+	struct psp_context *psp = &adev->psp;
+	struct psp_gfx_cmd_resp *cmd =
+		acquire_psp_cmd_buf(psp);
+	int ret;
+
+	if (!ucode)
+		ucode = &fw_info;
+
+	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
+	if (!ret)
+		ret = psp_cmd_submit_buf(psp, ucode, cmd,
+					 psp->fence_buf_mc_addr);
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 static int psp_execute_non_psp_fw_load(struct psp_context *psp,
 				  struct amdgpu_firmware_info *ucode)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 4847aacdf9dc..bd324fed6237 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -462,6 +462,12 @@ int psp_gpu_reset(struct amdgpu_device *adev);
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size);
 
+int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
+				   struct amdgpu_firmware_info *ucode,
+				   uint32_t ucode_id,
+				   uint64_t cmd_buf_gpu_addr,
+				   int cmd_buf_size);
+
 int psp_ta_init_shared_buf(struct psp_context *psp,
 				  struct ta_mem_context *mem_ctx);
 void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx);
-- 
2.25.1

