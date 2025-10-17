Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7185CCD184
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 07:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C23B10EB3C;
	Fri, 17 Oct 2025 07:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ftwxlTmn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B471410EB38
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 07:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzXMPneoh39cGHey5ROjZ7UV02YevtJYw7rOhEmlQ1JxCR+bR63/zLBFASJnqibc+oLGHOTdyrzo9B5HXPWngmez/GtuQGuPZaDfHyIVTiJbh4DfNvs91gNv1cV7pXXX2gbzbH8jiXleUGCH4eRyT/7NbmjZ76bTNs3GdLN2ObRdoQxXoKNrt3lrw3gxopd9zvaKgvTZAg2Qg8IMkvsLmEMhSF11rlDemYSKtsLDmRZKjeIRb75rJRH7A8RYjD3wQWh18nrCvbAXKYoHTRuSELrs4RL6nl3K2cxzJkM58oEAVdNA+q062b6Bb3+XAL7yNjE4eG2CfvF70leUDE1aQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C2zb1K9sEn8Hja8nq3/cGLHcws5XXcIPXWwqafFtEM=;
 b=Se1QYSxYqXWYndjF5lntgM1gM/Tiwn/hg5FNita+UQJUdoGwMmrHHxKiC6RGPhr6i6Bw/edhSkgmZ+0GrxqrxBYBYxDeVOpf1t931I+Q5uh+k2+4gCwXjoOC3pBC24gC/yudlc14Ypvux13sEFyPITd17d0Rmx0j8IaodxxzTyRX4gcTqD2A+Y8GCECwJT2hx0Etg9yPtsa5HYlry0h1YIa5B+Z2aJNQmaZ7tDC1J2dGhuhpgAd/8w5goXGzIvi4CnphFPtgJNVFlwhf67mqlgWBtKuVixiqna/rLSHpD2Gma3KNQ7lKdpN+4akQCXAayLEixc4NJ9MGKH6hre2ztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C2zb1K9sEn8Hja8nq3/cGLHcws5XXcIPXWwqafFtEM=;
 b=ftwxlTmn7HK8UZfyn+cl2MKM1oqwlIB71gUz/iaITAn2Tx0AhXf32koHDF3/QnA/jl4KilfB0oo7uES63jOvzm+Rlqed6cAhp/GaGk61/KyD/H7XPv2RF543iy+/tQSacROUYAgJmwehjSr+LnPUvO7Tm6aBdHiEn3RrWuGye3U=
Received: from BL1P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::9)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 07:52:42 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::86) by BL1P221CA0003.outlook.office365.com
 (2603:10b6:208:2c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 07:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 07:52:41 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 00:52:39 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/5] drm/amd/ras: Update function and remove redundant code
Date: Fri, 17 Oct 2025 15:51:28 +0800
Message-ID: <20251017075131.23939-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017075131.23939-1-YiPeng.Chai@amd.com>
References: <20251017075131.23939-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab96385-171f-4fe4-3c49-08de0d52266a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yv3DQc7PKyUXtW0V5hzA6Z+ZY9d6Pz5Jh1NiXf1SYaDZ/DETxsH0FgjO6As+?=
 =?us-ascii?Q?4tU3L30UsBfMOVtFGyNbZHIKms1HEfG0262+83P0orqMlrdcccWhhWeEa8Wj?=
 =?us-ascii?Q?THfJV6XvHdN7hdCPypES3/q96ql+RZqWKUrz+tUF7zlXe0L7GCP3iDyhmiYT?=
 =?us-ascii?Q?YAqxfHpwkkm+uob64j9eAV5K+lcMZ8NjV5ZOK1w5NWUDWr9GXQH0yfHXPWd7?=
 =?us-ascii?Q?s4BdyKf0a5Jhn/cV7++O/WXgYPLmYQvSExiWQZ1uVfSvVS/7plV0OQMOlHlj?=
 =?us-ascii?Q?wgNCrqRsvlSlwnXq3t79V4/G7/FGpRmbhi4z8Zdh6CyX2uMx3nmOeIZu7gWh?=
 =?us-ascii?Q?8Fca4eXM8+TERIdRu9MBV85IXIilp/1abuQxSMH9gnqyuOIc2Hbv+3ON2hnw?=
 =?us-ascii?Q?/+HjuQDtHHyQapwqr42ovHBVttiGFfw4Tg3V+tZrP5p1LQsSWMM4bpFVN4i/?=
 =?us-ascii?Q?i6/xIFAb72tTW35HN6tMfNib84ZNpxoHI8gltHJku2r5gkf5s/VEeTuRQ1O8?=
 =?us-ascii?Q?L17An5PWHFRhOQYWkf8U98SYhLwQxFWFITvKvGKyMLEWW+c5VKfj3/G4pJqQ?=
 =?us-ascii?Q?axXd/abdq8hPKu3m8xJ3r5ydC39h2n53O1OkDFi4YcwSVVdUkP8cqAYfLbD+?=
 =?us-ascii?Q?GhYXyZDkdX/H/dlhZvW155SfcqtISDULFMMcVodWwpiuFa6bVSLCx1NZwGm5?=
 =?us-ascii?Q?QMosd7BNoo/rsIMjwL5TKhKWMeZUPf8WcUKYqOg9fHf73t/P/CcAQ7+vNhxe?=
 =?us-ascii?Q?1UHypQvEkc6lmXkWwZI4NmGl8kfwPr5VYwCMWSgmvX1xyWoKib7o0+shra8W?=
 =?us-ascii?Q?jj5yxVzXc4MLKbVJ8FlgcDt4HL4yMR6huRhJMbvCak8uDAMsPUsAvw/uX1se?=
 =?us-ascii?Q?x+6jWPTSqA6Dak+otHe/F7uRFfbXDd6F+sGBHuMVkwFEu5APDS/unYgrJA55?=
 =?us-ascii?Q?FcxJMYQ3KruZXtrYZ2pvzbkyY2jYNg9mxtKn2/IxzdKkfx2SAj9dePK6dFdQ?=
 =?us-ascii?Q?THtF945ymyAqmVntAdn1lMqr4e2eJo1Zs+WOf5UC0/Cw/94pNYjCj43UZ6/A?=
 =?us-ascii?Q?HHPtjAHQb1zb8dK6xpP/DgM/E29lX5Mg7gMekrGMgjrNK237NDD6JRP15FV/?=
 =?us-ascii?Q?YV5Wg7CLC5x2S32w/kjw+da+9kCQxPNnPZW7RdtJDPXOHFT/m3SjE8PgXvRI?=
 =?us-ascii?Q?ec9kiPO7DSILLt5u/jSyzguUI2+MuX3uV80ZBhlp2eJXl7PQFthpj8rupw7g?=
 =?us-ascii?Q?ayZyhQKB6A1qYXE96vwSNpMGl/HlJhJ96E8sL2ukGSq8v5KxGBvkdxx81VPD?=
 =?us-ascii?Q?de6XLqFyup+YngcSKOcyusEPHak59PdHruKOopbVnwYmvSlqSevxZQhrJL9G?=
 =?us-ascii?Q?A/2y2aG389nfT2OrhAn816CuNKB4Un+iWXqdKZBE/6Qh0xCGSVvCX75LdrWc?=
 =?us-ascii?Q?fwNMjF79zqvbtnNXf6Q8CJglmQjJCY60MwciBHjsv4LJjbNuR+aZPDN5ihte?=
 =?us-ascii?Q?DVDwjummgD0LzM9KUSvJgWmi6e1XITBLcUw7MnDOtPOUhOJ3nC/fWoLdM42P?=
 =?us-ascii?Q?pjC01/eRc5M+vzxyDjU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 07:52:41.5723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab96385-171f-4fe4-3c49-08de0d52266a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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

Update function and remove redundant code:
1. Update function to prepare for internal use.
2. Remove unused function code previously prepared
   for ioctl.

V2:
  Update commit message content.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 110 +++---------------
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h  |   3 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  31 +++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |   3 +
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h     |   3 +-
 5 files changed, 53 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index 6a281ad8e255..78419b7f7729 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -36,67 +36,6 @@
 #define AMDGPU_RAS_TYPE_AMDGPU   0x2
 #define AMDGPU_RAS_TYPE_VF       0x3
 
-static int amdgpu_ras_query_interface_info(struct ras_core_context *ras_core,
-			struct ras_cmd_ctx *cmd)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	struct ras_query_interface_info_rsp *output_data =
-		(struct ras_query_interface_info_rsp *)cmd->output_buff_raw;
-	int ret;
-
-	if (cmd->input_size != sizeof(struct ras_query_interface_info_req))
-		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
-
-	ret = ras_cmd_query_interface_info(ras_core, output_data);
-	if (!ret) {
-		output_data->plat_major_ver = 0;
-		output_data->plat_minor_ver = 0;
-
-		output_data->interface_type = amdgpu_sriov_vf(adev) ?
-			RAS_CMD_INTERFACE_TYPE_VF : RAS_CMD_INTERFACE_TYPE_AMDGPU;
-
-		cmd->output_size = sizeof(struct ras_query_interface_info_rsp);
-	}
-
-	return ret;
-}
-
-static struct ras_core_context *ras_cmd_get_ras_core(uint64_t dev_handle)
-{
-	struct ras_core_context *ras_core;
-
-	if (!dev_handle || (dev_handle == RAS_CMD_DEV_HANDLE_MAGIC))
-		return NULL;
-
-	ras_core = (struct ras_core_context *)(uintptr_t)(dev_handle ^ RAS_CMD_DEV_HANDLE_MAGIC);
-
-	if (ras_cmd_get_dev_handle(ras_core) == dev_handle)
-		return ras_core;
-
-	return NULL;
-}
-
-static int amdgpu_ras_get_devices_info(struct ras_core_context *ras_core,
-			struct ras_cmd_ctx *cmd)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	struct ras_cmd_devices_info_rsp *output_data =
-			(struct ras_cmd_devices_info_rsp *)cmd->output_buff_raw;
-	struct ras_cmd_dev_info *dev_info;
-
-	dev_info = &output_data->devs[0];
-	dev_info->dev_handle = ras_cmd_get_dev_handle(ras_core);
-	dev_info->oam_id = adev->smuio.funcs->get_socket_id(adev);
-	dev_info->ecc_enabled = 1;
-	dev_info->ecc_supported = 1;
-
-	output_data->dev_num = 1;
-	output_data->version = 0;
-	cmd->output_size = sizeof(struct ras_cmd_devices_info_rsp);
-
-	return 0;
-}
-
 static int amdgpu_ras_trigger_error_prepare(struct ras_core_context *ras_core,
 			struct ras_cmd_inject_error_req *block_info)
 {
@@ -311,51 +250,34 @@ int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx
 	return res;
 }
 
-int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
-			uint8_t *cmd_buf, uint32_t buf_size)
+int amdgpu_ras_submit_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx *cmd)
 {
-	struct ras_cmd_ctx *cmd = (struct ras_cmd_ctx *)cmd_buf;
-	struct ras_core_context *cmd_core = NULL;
-	struct ras_cmd_dev_handle *cmd_handle = NULL;
+	struct ras_core_context *cmd_core = ras_core;
 	int timeout = 60;
 	int res;
 
 	cmd->cmd_res = RAS_CMD__ERROR_INVALID_CMD;
 	cmd->output_size = 0;
 
-	if (!ras_core_is_enabled(ras_core))
+	if (!ras_core_is_enabled(cmd_core))
 		return RAS_CMD__ERROR_ACCESS_DENIED;
 
-	if (cmd->cmd_id == RAS_CMD__QUERY_INTERFACE_INFO) {
-		cmd->cmd_res = amdgpu_ras_query_interface_info(ras_core, cmd);
-	} else if (cmd->cmd_id == RAS_CMD__GET_DEVICES_INFO) {
-		cmd->cmd_res = amdgpu_ras_get_devices_info(ras_core, cmd);
-	} else {
-		cmd_handle = (struct ras_cmd_dev_handle *)cmd->input_buff_raw;
-		cmd_core = ras_cmd_get_ras_core(cmd_handle->dev_handle);
-		if (!cmd_core)
-			return RAS_CMD__ERROR_INVALID_INPUT_DATA;
-
-		while (ras_core_gpu_in_reset(cmd_core)) {
-			msleep(1000);
-			if (!timeout--)
-				return RAS_CMD__ERROR_TIMEOUT;
-		}
-
-
-		if (!ras_core_is_enabled(cmd_core))
-			return RAS_CMD__ERROR_ACCESS_DENIED;
+	while (ras_core_gpu_in_reset(cmd_core)) {
+		msleep(1000);
+		if (!timeout--)
+			return RAS_CMD__ERROR_TIMEOUT;
+	}
 
-		res = amdgpu_ras_handle_cmd(cmd_core, cmd, NULL);
-		if (res == RAS_CMD__ERROR_UKNOWN_CMD)
-			res = rascore_handle_cmd(cmd_core, cmd, NULL);
+	res = amdgpu_ras_handle_cmd(cmd_core, cmd, NULL);
+	if (res == RAS_CMD__ERROR_UKNOWN_CMD)
+		res = rascore_handle_cmd(cmd_core, cmd, NULL);
 
-		cmd->cmd_res = res;
-	}
+	cmd->cmd_res = res;
 
-	if ((cmd->cmd_res == RAS_CMD__SUCCESS) &&
-	    ((cmd->output_size + sizeof(*cmd)) > buf_size)) {
-		RAS_INFO("Insufficient command buffer size 0x%x!\n", buf_size);
+	if (cmd->output_size > cmd->output_buf_size) {
+		RAS_DEV_ERR(cmd_core->dev,
+			"Output size 0x%x exceeds output buffer size 0x%x!\n",
+			cmd->output_size, cmd->output_buf_size);
 		return RAS_CMD__SUCCESS_EXEED_BUFFER;
 	}
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
index 73832c28cb55..5973b156cc85 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
@@ -49,7 +49,6 @@ struct ras_cmd_translate_memory_fd_rsp {
 
 int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core,
 		struct ras_cmd_ctx *cmd, void *data);
-int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
-			uint8_t *cmd_buf, uint32_t buf_size);
+int amdgpu_ras_submit_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx *cmd);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 13c207c8a843..8007e49951d8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -578,3 +578,34 @@ bool amdgpu_ras_mgr_is_rma(struct amdgpu_device *adev)
 
 	return ras_core_gpu_is_rma(ras_mgr->ras_core);
 }
+
+int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
+			uint32_t cmd_id, void *input, uint32_t input_size,
+			void *output, uint32_t out_size)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct ras_cmd_ctx *cmd_ctx;
+	uint32_t ctx_buf_size = PAGE_SIZE;
+	int ret;
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return -EPERM;
+
+	cmd_ctx = kzalloc(ctx_buf_size, GFP_KERNEL);
+	if (!cmd_ctx)
+		return -ENOMEM;
+
+	cmd_ctx->cmd_id = cmd_id;
+
+	memcpy(cmd_ctx->input_buff_raw, input, input_size);
+	cmd_ctx->input_size = input_size;
+	cmd_ctx->output_buf_size = ctx_buf_size - sizeof(*cmd_ctx);
+
+	ret = amdgpu_ras_submit_cmd(ras_mgr->ras_core, cmd_ctx);
+	if (!ret && !cmd_ctx->cmd_res && output && (out_size == cmd_ctx->output_size))
+		memcpy(output, cmd_ctx->output_buff_raw, cmd_ctx->output_size);
+
+	kfree(cmd_ctx);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 814b65ef1c62..42f190a8feb9 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -72,4 +72,7 @@ int amdgpu_ras_mgr_get_curr_nps_mode(struct amdgpu_device *adev, uint32_t *nps_m
 bool amdgpu_ras_mgr_check_retired_addr(struct amdgpu_device *adev,
 			uint64_t addr);
 bool amdgpu_ras_mgr_is_rma(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
+		uint32_t cmd_id, void *input, uint32_t input_size,
+		void *output, uint32_t out_size);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index 751ed50b9584..48a0715eb821 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -153,7 +153,8 @@ struct ras_cmd_ctx {
 	uint32_t cmd_res;
 	uint32_t input_size;
 	uint32_t output_size;
-	uint32_t reserved[6];
+	uint32_t output_buf_size;
+	uint32_t reserved[5];
 	uint8_t  input_buff_raw[RAS_CMD_MAX_IN_SIZE];
 	uint8_t  output_buff_raw[];
 };
-- 
2.34.1

