Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD81BC77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 12:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617A710ED35;
	Fri, 28 Apr 2023 12:42:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFEF610ED35
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 12:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW8S8HgZ634p2RngK5mLbRgc0MF1uhvpYzchTH92clDzz1VjLC1IvhWJOX13M3B321xxRvYmJnYnGUtL/xs19vtIEG1UciSb9d3bIeD88q5vDyf9Ru/1fqro5vQ9xid7aX0w8WmY43ThKmxbMbWcLdD3RfZ83DZUPqkEuHFrAlFgWTHprsfwS+ReI9MXqNjS04B0U93yzHt2iDpJrUxsxzDxshFVNppFTVdyqr063vfJGshm1AbknqMxB4icuXNtsaRNUjiBGiWWV8TCocsCTvOYvwZHWUeWBOo5pOcT/79zLI3FMxmrVn7y1pqs486QpR+sT/4Ig1qy+mpH9lr4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6CjK8X4SxP/7Rh7J+xKkNCTvkO71bKHz9UWSAvFSBk=;
 b=F8gNouLi1VcHtoZR28Q5FJS44fkZzBy8/Rm9lPzLXLCFw0trfV40ecKMBXPr4VWZiM+hHgZn2PawjiA4Upq7ikUcIGT/83NcZgK10Dv2f/KgAyOMPX+fBBmTh6b+VeTSPRggwY1uN9ve2FWCRqOzHopPf9lgb7aGkDIqGudIa9ex/ImH5HW6LmMDUYhVGZSAWNDhi5RO7wtf/yKEW966wvwgkIW9PH/DLeT7kxhIrD/VIUvEzYZJMNd7TMC+rJuyBWn25bxpzo+6m507V5zs7rCFR06dnHIt1M8Eeb+8HJXjbXHnQzABHSyfL/t0sORINJleqPN9AdoekzkjuLlBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6CjK8X4SxP/7Rh7J+xKkNCTvkO71bKHz9UWSAvFSBk=;
 b=d1lWO1JUmLL0b8BFfHwfzmzQQrs5lrlh8bp+mtJ7jgNAmYMKyeKQu+C7pPWp/T+4GBXdJAJld8x6R/4BKGoVoKGONYdhUdgn09GpQKBLM50l7ZAp1pTPNSKOhPANh76Cqz67Og1mBw/qr1lrOJJome8BPZE+Mj83JR1HEOvxsnY=
Received: from DS7PR03CA0172.namprd03.prod.outlook.com (2603:10b6:5:3b2::27)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 28 Apr
 2023 12:42:37 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::95) by DS7PR03CA0172.outlook.office365.com
 (2603:10b6:5:3b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 12:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.25 via Frontend Transport; Fri, 28 Apr 2023 12:42:37 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 07:42:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Fix style problems in amdgpu_psp.c
Date: Fri, 28 Apr 2023 18:12:19 +0530
Message-ID: <20230428124219.211145-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: abbef928-d655-480e-158b-08db47e60c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/KI1K5ksXpj7DDzo8uGu2CBdxf33G0Gq4KZ53BDGVjDo/KS5EXnUrhY1aEjE0H9YZhvnwFOzXxtHbV5G0GSWmfYtJP7+F6wNxHnxe1PQYlLe0NjI3W14EWbiF9myoy8Pjxfsoj+4ddHXWVoTxbN6dP3fxCauP948TOJ4vEEFHYh5HCdpRTdcr7brkY9Z4EhZ4pzOIhxwF1f0ChYnG5IRpH1aA1CvQHiS3D5or7LJ2G/9GdJnWl/MB4VMZpC0RrXOVuvtWS/FbA5QY7hL+gPjKdafC77cfEOJ4yeZzO4Mp+gwOAou53HM0+eFOJGYmW9NzKHtWBXjrhj95kWUdp6Lem0q0RJg6tSPrleFwE62YRSiFEKxIQr0qs7x9zxuD12CbFkSfdMTuYxZVQvK/ElPAZi1gp4t+sB5tsE6erJ3CwqqVvV0glZBmXktG7tl/k7twqoOw8Af4x2Xz0ZdE+E3a5rQPh+ULR2sU9ahJCclyx1qXJWO0qmpbtIkzJoesBpcYKiTyMTf8YmOB2YCqVs47+cZh5XYsDnQNXynGxjtU3drIgJMw2Ip+kOyvd20Bx6/to//zTxE2BY1VZOyTQDvtIJcvFGgA7KnWfUSEeLBS6egjktXyz3ZnvXbjZPbTbbml4luXQc4DJpSzVpvwkikDN/Iotook3u1lZZOeTn6kdvRW6G2EPIxy6ocxbu1KA3R9U3nl8AuUSCgWIR4PD9uksNfKGbzCpcp0CwxJMjYno=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(4326008)(2906002)(16526019)(316002)(110136005)(70586007)(54906003)(70206006)(6636002)(81166007)(8936002)(86362001)(41300700001)(36756003)(5660300002)(40480700001)(83380400001)(8676002)(356005)(82740400003)(82310400005)(7696005)(478600001)(336012)(2616005)(426003)(44832011)(40460700003)(26005)(36860700001)(1076003)(186003)(6666004)(66574015)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 12:42:37.2731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abbef928-d655-480e-158b-08db47e60c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following checkpatch warnings & error in amdgpu_psp.c

WARNING: Comparisons should place the constant on the right side of the test
WARNING: braces {} are not necessary for single statement blocks
WARNING: please, no space before tabs
WARNING: braces {} are not necessary for single statement blocks
ERROR: that open brace { should be on the previous line

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2: (Christian)
 - The casts to "void *" are completely superfluous in the first place.

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 51 ++++++++++---------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c58654a8b6c5..aa37b703c718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -411,7 +411,7 @@ static int psp_sw_init(void *handle)
 	if ((psp_get_runtime_db_entry(adev,
 				PSP_RUNTIME_ENTRY_TYPE_PPTABLE_ERR_STATUS,
 				&scpm_entry)) &&
-	    (SCPM_DISABLE != scpm_entry.scpm_status)) {
+	    (scpm_entry.scpm_status != SCPM_DISABLE)) {
 		adev->scpm_enabled = true;
 		adev->scpm_status = scpm_entry.scpm_status;
 	} else {
@@ -458,10 +458,9 @@ static int psp_sw_init(void *handle)
 
 	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
 	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7)) {
-		ret= psp_sysfs_init(adev);
-		if (ret) {
+		ret = psp_sysfs_init(adev);
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
@@ -645,7 +644,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	skip_unsupport = (psp->cmd_buf_mem->resp.status == TEE_ERROR_NOT_SUPPORTED ||
 		psp->cmd_buf_mem->resp.status == PSP_ERR_UNKNOWN_COMMAND) && amdgpu_sriov_vf(psp->adev);
 
-	memcpy((void*)&cmd->resp, (void*)&psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
+	memcpy(&cmd->resp, &psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
 
 	/* In some cases, psp response status is not 0 even there is no
 	 * problem while the command is submitted. Some version of PSP FW
@@ -830,7 +829,7 @@ static int psp_tmr_load(struct psp_context *psp)
 }
 
 static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
-				        struct psp_gfx_cmd_resp *cmd)
+					struct psp_gfx_cmd_resp *cmd)
 {
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_DESTROY_VMR;
@@ -1067,7 +1066,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     struct ta_context *context)
 {
 	cmd->cmd_id				= context->ta_load_type;
-	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	= lower_32_bits(ta_bin_mc);
+	cmd->cmd.cmd_load_ta.app_phy_addr_lo	= lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
 
@@ -1138,9 +1137,8 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 
 	context->resp_status = cmd->resp.status;
 
-	if (!ret) {
+	if (!ret)
 		context->session_id = cmd->resp.session_id;
-	}
 
 	release_psp_cmd_buf(psp);
 
@@ -1467,8 +1465,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_ras_intr_triggered())
 		return ret;
 
-	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER)
-	{
+	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER) {
 		DRM_WARN("RAS: Unsupported Interface");
 		return -EINVAL;
 	}
@@ -1478,8 +1475,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 			dev_warn(psp->adev->dev, "ECC switch disabled\n");
 
 			ras_cmd->ras_status = TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE;
-		}
-		else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
+		} else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
 			dev_warn(psp->adev->dev,
 				 "RAS internal register access blocked\n");
 
@@ -1575,11 +1571,10 @@ int psp_ras_initialize(struct psp_context *psp)
 				if (ret)
 					dev_warn(adev->dev, "PSP set boot config failed\n");
 				else
-					dev_warn(adev->dev, "GECC will be disabled in next boot cycle "
-						 "if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
+					dev_warn(adev->dev, "GECC will be disabled in next boot cycle if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
 			}
 		} else {
-			if (1 == boot_cfg) {
+			if (boot_cfg == 1) {
 				dev_info(adev->dev, "GECC is enabled\n");
 			} else {
 				/* enable GECC in next boot cycle if it is disabled
@@ -2365,7 +2360,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
 }
 
 static int psp_execute_non_psp_fw_load(struct psp_context *psp,
-			          struct amdgpu_firmware_info *ucode)
+				  struct amdgpu_firmware_info *ucode)
 {
 	int ret = 0;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
@@ -2404,9 +2399,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	     (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 4) ||
 	      adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 2)))) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
-		if (ret) {
+		if (ret)
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
-		}
 	}
 
 	ret = psp_execute_non_psp_fw_load(psp, ucode);
@@ -2716,9 +2710,8 @@ static int psp_suspend(void *handle)
 	}
 
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
-	if (ret) {
+	if (ret)
 		DRM_ERROR("PSP ring stop failed\n");
-	}
 
 out:
 	return ret;
@@ -2967,7 +2960,7 @@ static int parse_sos_bin_descriptor(struct psp_context *psp,
 		psp->sos.fw_version        = le32_to_cpu(desc->fw_version);
 		psp->sos.feature_version   = le32_to_cpu(desc->fw_version);
 		psp->sos.size_bytes        = le32_to_cpu(desc->size_bytes);
-		psp->sos.start_addr 	   = ucode_start_addr;
+		psp->sos.start_addr	   = ucode_start_addr;
 		break;
 	case PSP_FW_TYPE_PSP_SYS_DRV:
 		psp->sys.fw_version        = le32_to_cpu(desc->fw_version);
@@ -3491,7 +3484,7 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
 	drm_dev_exit(idx);
 }
 
-static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(usbc_pd_fw, 0644,
 		   psp_usbc_pd_fw_sysfs_read,
 		   psp_usbc_pd_fw_sysfs_write);
 
@@ -3674,8 +3667,7 @@ static void psp_sysfs_fini(struct amdgpu_device *adev)
 	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
 }
 
-const struct amdgpu_ip_block_version psp_v3_1_ip_block =
-{
+const struct amdgpu_ip_block_version psp_v3_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 3,
 	.minor = 1,
@@ -3683,8 +3675,7 @@ const struct amdgpu_ip_block_version psp_v3_1_ip_block =
 	.funcs = &psp_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version psp_v10_0_ip_block =
-{
+const struct amdgpu_ip_block_version psp_v10_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 10,
 	.minor = 0,
@@ -3692,8 +3683,7 @@ const struct amdgpu_ip_block_version psp_v10_0_ip_block =
 	.funcs = &psp_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version psp_v11_0_ip_block =
-{
+const struct amdgpu_ip_block_version psp_v11_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 11,
 	.minor = 0,
@@ -3709,8 +3699,7 @@ const struct amdgpu_ip_block_version psp_v11_0_8_ip_block = {
 	.funcs = &psp_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version psp_v12_0_ip_block =
-{
+const struct amdgpu_ip_block_version psp_v12_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 12,
 	.minor = 0,
-- 
2.25.1

