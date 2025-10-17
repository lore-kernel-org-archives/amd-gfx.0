Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21482CCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 07:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD55B10EB38;
	Fri, 17 Oct 2025 07:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oIifK58i";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A5210EB3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 07:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7TXgmImy2wi16i2KDKzOlxnv1NK6LkwQ/7v9NomL3mvo01o5509ncy7dZBYTi3T8Lkj6haiYB+HAfW2zZH+8nRfU0P9yirQQcaR8S/3cMTzJ/LPwNxQSxpDoVWY98zDbPiUGEIE2XS8C3F8BFLeYC86NfRBXNsOmHQtOQlGGLvMp6HIGlixAAeBq/JC3+0Pb0pWDQ4icDz7CbJwmh1ksqpv3s2YkCNJwy7sFnSJpkyGd2cSQrz3LneXEnGbW76AJ1HKX3M9mkzBkHkH5U2uOI+hWmM1N8ZlJCLD6uCnNkd9NOdmHX552iJEA7DE4Wk2bsk6h9TJzqWteq/zetRTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeqUopchoB/kzd9/m9SwMkJOqlb37jxYoPtnK/usgUQ=;
 b=eCyVVRPktgA8vwZyxaT5jVTfmPpCoSxoaFKGx0Og+LDhamBPCYMl9XbVpSChqiRcjIOhORqmFOgvQWpmxGhPmoc8o1/PUI6ImEW6FgTl1iGjWMc4KeGORNIIWUdpyVYWDKWxNztlLOOqFQ5Z5XyMVJlVqIcal1uObuvGLipH2LNhoYe5t8s0aRFOT5ubJesthCdOfIpq3RGg4fzehsJB4SNixbgdlKq4xxymePgYP6FmyGGy5VdmMOqu6Ve2XvLQFc9Ni+2Y0Vvq57zDjXUwRZinbcv3W2vnjzSJ4k2fYosVkPDxwEtQULsnXnKeDZXvjw5PNWhfjHtYC7vj+7EqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeqUopchoB/kzd9/m9SwMkJOqlb37jxYoPtnK/usgUQ=;
 b=oIifK58iJUXr4OkOa9uW+FFi+xaDCJkFg6k2qYmF7C6hQY0/t86huty2nFRZQhXjg+qsonJltBsFAsAxY3lkxOCZbT6VG2grVnwzV30LEUi5PU6jCyX+kWKlq4/xFtW6noZ6Go6IolW0zGpWl/6lC5/31tzyTeT19tiSX/Y4Cbs=
Received: from BN8PR04CA0017.namprd04.prod.outlook.com (2603:10b6:408:70::30)
 by BN7PPF0D2C72F0D.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 07:52:40 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::4c) by BN8PR04CA0017.outlook.office365.com
 (2603:10b6:408:70::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 07:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 07:52:39 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 00:52:36 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/5] drm/amd/ras: Update ras command context structure name
Date: Fri, 17 Oct 2025 15:51:27 +0800
Message-ID: <20251017075131.23939-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|BN7PPF0D2C72F0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 98740e9a-fdc7-4476-5641-08de0d522500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MwIdKgSNNLXJEMXuXG0n9ruK5hNWbR64BFKhBz3I4J97It1Xq8cH0qMbuvBS?=
 =?us-ascii?Q?smnaCDawPO1taS9eKcyvXm3rde0DYDZ1mgIXGFBxYs+hrY2sxP9dV06Va26j?=
 =?us-ascii?Q?j2OtGUBcbHXetbH7OfFv1NDy4gqLSZ+iICi+8oS3nwe74B8AFgZc+nriErfe?=
 =?us-ascii?Q?feLNIMPFzozlbORbj7iyZnJymBn8+07Kv0+tezTrH/CIbySn7IfrivjUscug?=
 =?us-ascii?Q?WK2CJ7qgvG7wYOGthC9P7MqNaojPczfwBWjrinWFFSlPngwIVZID19lTkNbP?=
 =?us-ascii?Q?O1I80p+VvR1p5m5226p3js5Tky1C5Hn5k/emrL3JBLmdI+dWvmoHQCFLgS+8?=
 =?us-ascii?Q?ZPHaaHycVFHUJvTekGiNuvazYHjKPf0oNw5w4aQyvti82/i1CoJYBRn58Vwv?=
 =?us-ascii?Q?c+ZRTipRVAmD7VRBOKWPPVIVU5FEtoalSRa+h+lxbbEQ0bSdDVo6KFwQhCAs?=
 =?us-ascii?Q?fYIYCBDMCu3dUjq6x5jAp8JARTIEEbUloW78WogX7aoMPpeiYrK+juW7YE28?=
 =?us-ascii?Q?xrkKPkhdprYDLyRQKCbfemSUyZLw0kODsA24vAONTGBlmbPDb38icEzJpFx9?=
 =?us-ascii?Q?I8dDk9d02aUZbDjfS+nOh7Eqao2GytADfsUj9akhHM3VWAUkV7FD8VFD40dE?=
 =?us-ascii?Q?8LSMaO4zr709zIrGz09v8WcfAuDItH55hXUKKaNYnoecsMAxRHrIVOy0j2jO?=
 =?us-ascii?Q?HaCMDdKjdLzSRhWbWAUZH64wH5rFH6HGDSMnkOz7uTA22ujM0HzZ+CSi58m2?=
 =?us-ascii?Q?nMbFTVWp4/bA03VFPi8Nlz/8ZYxonsRvvPiqVi8i/8iQZkEBpBmbHN9hv9kJ?=
 =?us-ascii?Q?kYakhbpri1TvbxBeHzpi/9PZMhckTSc9DF0f06wCk8xIu3ZDo3kqsEz9mik/?=
 =?us-ascii?Q?wdxdFT6sP3BjIO8g+VIFEGIP2qxOiA0Frz9hXiHfAMYPSMkk5urs+By/qC2A?=
 =?us-ascii?Q?x1kFlvBWSeQWisoL+1t8mhjWuAb9PZwyiRm0juct+xA1vD6NmlAHYz2gY5aD?=
 =?us-ascii?Q?kNFBpDnmIlhdeObUJmbpMhGou0RLHgGIfxhHQbeEFyjjOyVlHCkpst5KKzgn?=
 =?us-ascii?Q?mqCB/naxQh5BqyzYGaueIOMBsNPBBYIDXwHR/d/DMkPzChbejVQfgMpdtv1G?=
 =?us-ascii?Q?R4lm8rGV/+IsrlBaHbcsWCAYWjKpH2sd/2ywWGn+nEa1XSua3sQ6H1Dr4Grq?=
 =?us-ascii?Q?/k1yNs0Ky1TJ0V0It0KH8cbWDsXqMiE30uSd5DWsg8NWco+1X3ToSMs7RJAT?=
 =?us-ascii?Q?Ei42r/3qzahVrpVtizWdQWnZgkLlr5XSTpbKJteKGs7BTEfqBcFA7gXJtDPl?=
 =?us-ascii?Q?pjcRakgzAHCqE4dTQRAG9ubYWpORklO+SMoyLe8y41bY197Bw1kRyC7uGVEB?=
 =?us-ascii?Q?VayMc3k8CCXVpC+2wJI69Udqdi1E6v7yE/fxQ0RYNZquZPHk53y+MCQW5kDF?=
 =?us-ascii?Q?ehsCb0ju3vlpq+hZS1To4W3Un4vv7jgOLS1Oy1ORCveWpWcdsLzEIdH+dcd8?=
 =?us-ascii?Q?reHd+IQjVf3mm8kcjkxRKiK3H9x3GVVC+fKomdzjUynNz1+DJ+R/ELQCikGI?=
 =?us-ascii?Q?1qfshT7HTji7hW64FSk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 07:52:39.2005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98740e9a-fdc7-4476-5641-08de0d522500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D2C72F0D
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

According to the actual usage of this structure,
it is more appropriate to call it context, the
structure name with ioctl is easy to cause
misunderstanding.

V2:
  Update commit message content.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 14 ++++++-------
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h  |  2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c     | 20 +++++++++----------
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h     |  8 ++++----
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index 4706e737969a..6a281ad8e255 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -37,7 +37,7 @@
 #define AMDGPU_RAS_TYPE_VF       0x3
 
 static int amdgpu_ras_query_interface_info(struct ras_core_context *ras_core,
-			struct ras_cmd_ioctl *cmd)
+			struct ras_cmd_ctx *cmd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 	struct ras_query_interface_info_rsp *output_data =
@@ -77,7 +77,7 @@ static struct ras_core_context *ras_cmd_get_ras_core(uint64_t dev_handle)
 }
 
 static int amdgpu_ras_get_devices_info(struct ras_core_context *ras_core,
-			struct ras_cmd_ioctl *cmd)
+			struct ras_cmd_ctx *cmd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 	struct ras_cmd_devices_info_rsp *output_data =
@@ -146,7 +146,7 @@ static uint64_t local_addr_to_xgmi_global_addr(struct ras_core_context *ras_core
 }
 
 static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
-			struct ras_cmd_ioctl *cmd, void *data)
+			struct ras_cmd_ctx *cmd, void *data)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 	struct ras_cmd_inject_error_req *req =
@@ -189,7 +189,7 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 }
 
 static int amdgpu_ras_get_ras_safe_fb_addr_ranges(struct ras_core_context *ras_core,
-	struct ras_cmd_ioctl *cmd, void *data)
+	struct ras_cmd_ctx *cmd, void *data)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 	struct ras_cmd_dev_handle *input_data =
@@ -259,7 +259,7 @@ static int ras_translate_fb_address(struct ras_core_context *ras_core,
 }
 
 static int amdgpu_ras_translate_fb_address(struct ras_core_context *ras_core,
-				struct ras_cmd_ioctl *cmd, void *data)
+				struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_translate_fb_address_req *req_buff =
 			(struct ras_cmd_translate_fb_address_req *)cmd->input_buff_raw;
@@ -291,7 +291,7 @@ static struct ras_cmd_func_map amdgpu_ras_cmd_maps[] = {
 	{RAS_CMD__TRANSLATE_FB_ADDRESS, amdgpu_ras_translate_fb_address},
 };
 
-int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ioctl *cmd, void *data)
+int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_func_map *ras_cmd = NULL;
 	int i, res;
@@ -314,7 +314,7 @@ int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ioct
 int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
 			uint8_t *cmd_buf, uint32_t buf_size)
 {
-	struct ras_cmd_ioctl *cmd = (struct ras_cmd_ioctl *)cmd_buf;
+	struct ras_cmd_ctx *cmd = (struct ras_cmd_ctx *)cmd_buf;
 	struct ras_core_context *cmd_core = NULL;
 	struct ras_cmd_dev_handle *cmd_handle = NULL;
 	int timeout = 60;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
index 7017198f1bac..73832c28cb55 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
@@ -48,7 +48,7 @@ struct ras_cmd_translate_memory_fd_rsp {
 };
 
 int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core,
-		struct ras_cmd_ioctl *cmd, void *data);
+		struct ras_cmd_ctx *cmd, void *data);
 int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
 			uint8_t *cmd_buf, uint32_t buf_size);
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 6fe3b115986c..94e6d7420d94 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -43,7 +43,7 @@ static int ras_cmd_remove_device(struct ras_core_context *ras_core)
 }
 
 static int ras_get_block_ecc_info(struct ras_core_context *ras_core,
-				struct ras_cmd_ioctl *cmd, void *data)
+				struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_block_ecc_info_req *input_data =
 			(struct ras_cmd_block_ecc_info_req *)cmd->input_buff_raw;
@@ -119,7 +119,7 @@ static int ras_cmd_get_group_bad_pages(struct ras_core_context *ras_core,
 }
 
 static int ras_cmd_get_bad_pages(struct ras_core_context *ras_core,
-				struct ras_cmd_ioctl *cmd, void *data)
+				struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_bad_pages_info_req *input_data =
 			(struct ras_cmd_bad_pages_info_req *)cmd->input_buff_raw;
@@ -141,7 +141,7 @@ static int ras_cmd_get_bad_pages(struct ras_core_context *ras_core,
 }
 
 static int ras_cmd_clear_bad_page_info(struct ras_core_context *ras_core,
-				struct ras_cmd_ioctl *cmd, void *data)
+				struct ras_cmd_ctx *cmd, void *data)
 {
 	if (cmd->input_size != sizeof(struct ras_cmd_dev_handle))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
@@ -156,7 +156,7 @@ static int ras_cmd_clear_bad_page_info(struct ras_core_context *ras_core,
 }
 
 static int ras_cmd_reset_all_error_counts(struct ras_core_context *ras_core,
-				struct ras_cmd_ioctl *cmd, void *data)
+				struct ras_cmd_ctx *cmd, void *data)
 {
 	if (cmd->input_size != sizeof(struct ras_cmd_dev_handle))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
@@ -171,7 +171,7 @@ static int ras_cmd_reset_all_error_counts(struct ras_core_context *ras_core,
 }
 
 static int ras_cmd_get_cper_snapshot(struct ras_core_context *ras_core,
-			struct ras_cmd_ioctl *cmd, void *data)
+			struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_cper_snapshot_rsp *output_data =
 			(struct ras_cmd_cper_snapshot_rsp *)cmd->output_buff_raw;
@@ -193,7 +193,7 @@ static int ras_cmd_get_cper_snapshot(struct ras_core_context *ras_core,
 }
 
 static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
-			struct ras_cmd_ioctl *cmd, void *data)
+			struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_cper_record_req *req =
 			(struct ras_cmd_cper_record_req *)cmd->input_buff_raw;
@@ -253,7 +253,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 }
 
 static int ras_cmd_get_batch_trace_snapshot(struct ras_core_context *ras_core,
-	struct ras_cmd_ioctl *cmd, void *data)
+	struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_batch_trace_snapshot_rsp *rsp =
 			(struct ras_cmd_batch_trace_snapshot_rsp *)cmd->output_buff_raw;
@@ -275,7 +275,7 @@ static int ras_cmd_get_batch_trace_snapshot(struct ras_core_context *ras_core,
 }
 
 static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
-	struct ras_cmd_ioctl *cmd, void *data)
+	struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_batch_trace_record_req *input_data =
 			(struct ras_cmd_batch_trace_record_req *)cmd->input_buff_raw;
@@ -400,7 +400,7 @@ static enum ras_ta_error_type __get_ras_ta_err_type(enum ras_ecc_err_type error)
 }
 
 static int ras_cmd_inject_error(struct ras_core_context *ras_core,
-			struct ras_cmd_ioctl *cmd, void *data)
+			struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_inject_error_req *req =
 		(struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
@@ -441,7 +441,7 @@ static struct ras_cmd_func_map ras_cmd_maps[] = {
 };
 
 int rascore_handle_cmd(struct ras_core_context *ras_core,
-		struct ras_cmd_ioctl *cmd, void *data)
+		struct ras_cmd_ctx *cmd, void *data)
 {
 	struct ras_cmd_func_map *ras_cmd = NULL;
 	int i;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index 6df8c70f5ad8..751ed50b9584 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -101,7 +101,7 @@ enum ras_error_type {
 };
 
 struct ras_core_context;
-struct ras_cmd_ioctl;
+struct ras_cmd_ctx;
 
 struct ras_cmd_mgr {
 	struct list_head head;
@@ -112,7 +112,7 @@ struct ras_cmd_mgr {
 struct ras_cmd_func_map {
 	uint32_t cmd_id;
 	int (*func)(struct ras_core_context *ras_core,
-			struct ras_cmd_ioctl *cmd, void *data);
+			struct ras_cmd_ctx *cmd, void *data);
 };
 
 struct ras_device_bdf {
@@ -133,7 +133,7 @@ struct ras_cmd_param {
 };
 
 #pragma pack(push, 8)
-struct ras_cmd_ioctl {
+struct ras_cmd_ctx {
 	uint32_t magic;
 	union {
 		struct {
@@ -414,7 +414,7 @@ struct ras_cmd_batch_trace_record_rsp {
 
 int ras_cmd_init(struct ras_core_context *ras_core);
 int ras_cmd_fini(struct ras_core_context *ras_core);
-int rascore_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ioctl *cmd, void *data);
+int rascore_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx *cmd, void *data);
 uint64_t ras_cmd_get_dev_handle(struct ras_core_context *ras_core);
 int ras_cmd_query_interface_info(struct ras_core_context *ras_core,
 	struct ras_query_interface_info_rsp *rsp);
-- 
2.34.1

