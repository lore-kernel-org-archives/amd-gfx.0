Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF77C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 08:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42A811B924;
	Thu, 30 May 2024 08:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mmeKRowh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107BA11B924
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 08:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S53D9+XO0kElPGnkQpANebnOC244u3q27GUfGXnvWgj3gdYoEwyZUrjEUHDa24xUl96sEYHeFF6DwNz60MwA/Qhy2z/Cw9/uaHbbCxZtS0+rSLF8nhPjSRF61KSAAA7FMx0oc59Lr9DdppX28prQXS8LkqAs5lY4iXOKQ7lAiE8grlwMxZj/MUK4tm7Zsl8VdtXqxF6VcoI3Zi6/Z5Dwm0ZsclLdn46QXZCJX7OqI/T0B2n141oUoXBfT3A3J2NUm884Zo6bnzQdzW5HJjBa9ivXb/xnBHmu2klF5KffnQ8PtxkisdMMLBluVVOS3Kz/Uh28mNJUrD/UZsYPx0QJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovs2sgc9KzeZbC2dbLN0bvz+Yyr8mU3FKJKIYwJl5sw=;
 b=WZ+uukj7HBx0j83JY+rwwjAfU3eH7CqH2g6gPeb8OKNAdrfRixpUkOomkplWFdFDBF4envlEwyiryEZM4i+6shTaKFZbGNxn0mlWip8gtOLthrTVRDh1n0OA+ISgvn6lm1I6OYqyG2ykPKFmwqAQYO5bQ4kSeSRRzBE7ysM4Ci8GQSKrm7Y8c1dWJl/dNLbHlrYNqpr/pY83FCOusdHKaPOol4TCP45WrQOGpFsRbd4SkAAYYOdH8FZq5QFVOsCw1B+Dio1qR0I91aHJIIx6hgM2ATQ9Fbk8XEQDizM5uVG9+jkDp8RtQ0Zcn7a8t5iFd3DkPvNpRbX5aL+TBkzJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovs2sgc9KzeZbC2dbLN0bvz+Yyr8mU3FKJKIYwJl5sw=;
 b=mmeKRowhmm8MhL4NkFLB7oyIaW4pP+839QBRm+0z9HbadL0pDhwvbTy7/hNCVpk2RnThKz9KZG4nYdEkOW6H1JrVnWkC2W6YYp/szfh1sxS1ie2vviZkhyRFI/Jxv+DYdRVX85n+Wtf1WdG15R3hIDNdMx3j8iDMiro2LrzrBM4=
Received: from CH2PR05CA0070.namprd05.prod.outlook.com (2603:10b6:610:38::47)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 08:41:07 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::53) by CH2PR05CA0070.outlook.office365.com
 (2603:10b6:610:38::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 08:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 08:41:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 03:41:05 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.35 via Frontend Transport; Thu, 30 May 2024 03:41:04
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update programming for boot error reporting
Date: Thu, 30 May 2024 16:40:58 +0800
Message-ID: <20240530084058.8512-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b1e40d-ec1b-4b49-1477-08dc80843f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?itAEPeSYoWoc6bpwlfo4VDdtiTaRfbNw6lTG1IHn6qsHf1OU+FqieuaMXxC3?=
 =?us-ascii?Q?K5YvevXbBjVgAKQX7wRepNzmE30I9aMxwUZM/YqD+xMoaCdor6cyVS1tcPdX?=
 =?us-ascii?Q?YcDdLcZ2ygrS6mCAS/QjA/A226/arMzzNCx3RSJBU0Eyo3lL9sGGOyQrhuyt?=
 =?us-ascii?Q?6aK7AqJcDlwZ4YwxrJld6IolZ38bp25Vw4f5vOebeUBjN2eo2EO1j7N0ZceW?=
 =?us-ascii?Q?a0VBZB8xpc8zpCfACYCk4HcVYrT6BEIFmeebN2FUsMqSWkvP+I5H4SeQHkLB?=
 =?us-ascii?Q?FAX10DSuAEi08rVg+BBvgW0v3AxvQa2WUPLniX3X52RDT1DnUgbk2/Uqc1cL?=
 =?us-ascii?Q?I0wCy0dq5oyIeOs3P9kYiRXxHAx7R04xH9PwNs7skdN1lsrYTxr6fObTEDc7?=
 =?us-ascii?Q?x2r8PC0ZYflVvLk5kh2L+nSp2y+V0ZlxCFXHl6vHXfwcTnWc1DloB6cA0JGi?=
 =?us-ascii?Q?et6wBis0dBTK/EZIpwkHTUvSKv8gTkSHLn0cyZVDhQ8BCmCzw3uGO3cyzOdr?=
 =?us-ascii?Q?1Ono1g+kXYV6ZQK4VSQG21StUX7vRWfiDZ8w3W7S3s7sg1f8LNVu7p1k/r6K?=
 =?us-ascii?Q?mLaiITDzh/zJDt5rnberzfF3hUSX3H7+uVPaMpVmE4RnEC5kmep4+Pr3b3fk?=
 =?us-ascii?Q?UANMei3+eeSta55jCvVqhTvgRKzlJd9i+rc/wR0B3MYNbNXpZNwa6csOREda?=
 =?us-ascii?Q?whebG1msI0kNYnmFwQmIbZeqGgMN2AEJOlg6xOwlwh1lj+/8O0YKb5VcVIZa?=
 =?us-ascii?Q?MZmYaUiWP2zM5bhVtDM0SFhGrlAeyICp6UOuxVdD6izEzljgFsMeO7rKE7gV?=
 =?us-ascii?Q?4VtEYpAUH3O6Y6VkXvLwlvBhF/HrwV+tlYFQZiOliRtKdG5iDJr0ukfAOg1X?=
 =?us-ascii?Q?JFcq79ES2M9qzAiF0IAIx1UObuJ/7JRN+K+85wdcc5tZo9wJKJYbgTYj4obS?=
 =?us-ascii?Q?55vPGYJjszq9CicitGYZcoujMHSCoH5guwluwfR2NtZzx2LkQVLv3HNjxFJT?=
 =?us-ascii?Q?kEscnOkVU7QJhATBW97avno5RUgYu8GhvlgUKG40+lXa4LT5WbdinhYZZPJH?=
 =?us-ascii?Q?r+fqofnVHhW8S5MLMqPfSabFccqMUtlYjn2p/og534+beQyUbb5pgDJk/HwS?=
 =?us-ascii?Q?bYVAkew5x11KM/axA5LHB/pmHe1i57BpQNptkwXUzktczkdEQNT3H0HZ19Qu?=
 =?us-ascii?Q?DebvaldTt7ctmhU/+5bu89Q98P5khGwzmvG2M/TrUrL141LajdUD1C4pVK2B?=
 =?us-ascii?Q?DZ5gDePUE9ea2UNYDHIhyP/X8K5bzE6HTGmseHJW9ZRfQCs+32KLRzXu0S2Z?=
 =?us-ascii?Q?A/2It72OONHbwBcys2owj40VJUgYSVm75yvhDVEMJ+My+9oQm/NxwuFuOmrh?=
 =?us-ascii?Q?1OBubVoBg8pPrB8K4qV3kFJVCaU/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:41:06.5409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b1e40d-ec1b-4b49-1477-08dc80843f55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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

AMDGPU_RAS_GPU_ERR_BOOT_STATUS field is no longer valid.
The polling sequence is also simplifed according to
the latest firmware change.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 99 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 +-
 2 files changed, 46 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index eedf2b613ac2..2c338d39cd45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4416,64 +4416,74 @@ int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
 #define mmMP0_SMN_C2PMSG_92	0x1609C
 #define mmMP0_SMN_C2PMSG_126	0x160BE
 static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
-						 u32 instance, u32 boot_error)
+						 u32 instance)
 {
 	u32 socket_id, aid_id, hbm_id;
-	u32 reg_data;
+	u32 fw_status;
+	u32 boot_error;
 	u64 reg_addr;
 
-	socket_id = AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
-	aid_id = AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
-	hbm_id = AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
-
 	/* The pattern for smn addressing in other SOC could be different from
 	 * the one for aqua_vanjaram. We should revisit the code if the pattern
 	 * is changed. In such case, replace the aqua_vanjaram implementation
 	 * with more common helper */
 	reg_addr = (mmMP0_SMN_C2PMSG_92 << 2) +
 		   aqua_vanjaram_encode_ext_smn_addressing(instance);
+	fw_status = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
+
+	reg_addr = (mmMP0_SMN_C2PMSG_126 << 2) +
+		   aqua_vanjaram_encode_ext_smn_addressing(instance);
+	boot_error = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
 
-	reg_data = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
-	dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw status is 0x%x\n",
-		socket_id, aid_id, reg_data);
+	socket_id = AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
+	aid_id = AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
+	hbm_id = AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
 
 	if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
-		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory training failed\n",
-			 socket_id, aid_id, hbm_id);
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, memory training failed\n",
+			 socket_id, aid_id, hbm_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
-		dev_info(adev->dev, "socket: %d, aid: %d, firmware load failed at boot time\n",
-			 socket_id, aid_id);
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, fw_status: 0x%x, firmware load failed at boot time\n",
+			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
-		dev_info(adev->dev, "socket: %d, aid: %d, wafl link training failed\n",
-			 socket_id, aid_id);
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, fw_status: 0x%x, wafl link training failed\n",
+			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
-		dev_info(adev->dev, "socket: %d, aid: %d, xgmi link training failed\n",
-			 socket_id, aid_id);
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, fw_status: 0x%x, xgmi link training failed\n",
+			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
-		dev_info(adev->dev, "socket: %d, aid: %d, usr cp link training failed\n",
-			 socket_id, aid_id);
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, fw_status: 0x%x, usr cp link training failed\n",
+			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
-		dev_info(adev->dev, "socket: %d, aid: %d, usr dp link training failed\n",
-			 socket_id, aid_id);
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, fw_status: 0x%x, usr dp link training failed\n",
+			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
-		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm memory test failed\n",
-			 socket_id, aid_id, hbm_id);
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, hbm memory test failed\n",
+			 socket_id, aid_id, hbm_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
-		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm bist test failed\n",
-			 socket_id, aid_id, hbm_id);
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, hbm bist test failed\n",
+			 socket_id, aid_id, hbm_id, fw_status);
 }
 
-static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
-					     u32 instance, u32 *boot_error)
+static bool amdgpu_ras_boot_error_detected(struct amdgpu_device *adev,
+					   u32 instance)
 {
-	u32 reg_addr;
+	u64 reg_addr;
 	u32 reg_data;
 	int retry_loop;
 
@@ -4482,41 +4492,22 @@ static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
 
 	for (retry_loop = 0; retry_loop < AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT; retry_loop++) {
 		reg_data = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
-		if ((reg_data & AMDGPU_RAS_BOOT_STATUS_MASK) == AMDGPU_RAS_BOOT_STEADY_STATUS) {
-			*boot_error = AMDGPU_RAS_BOOT_SUCEESS;
-			return 0;
-		}
-		msleep(1);
-	}
-
-	/* The pattern for smn addressing in other SOC could be different from
-	 * the one for aqua_vanjaram. We should revisit the code if the pattern
-	 * is changed. In such case, replace the aqua_vanjaram implementation
-	 * with more common helper */
-	reg_addr = (mmMP0_SMN_C2PMSG_126 << 2) +
-		   aqua_vanjaram_encode_ext_smn_addressing(instance);
-
-	for (retry_loop = 0; retry_loop < AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT; retry_loop++) {
-		reg_data = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
-		if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
-			*boot_error = reg_data;
-			return 0;
-		}
-		msleep(1);
+		if ((reg_data & AMDGPU_RAS_BOOT_STATUS_MASK) == AMDGPU_RAS_BOOT_STEADY_STATUS)
+			return false;
+		else
+			msleep(1);
 	}
 
-	*boot_error = reg_data;
-	return -ETIME;
+	return true;
 }
 
 void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances)
 {
-	u32 boot_error = 0;
 	u32 i;
 
 	for (i = 0; i < num_instances; i++) {
-		if (amdgpu_ras_wait_for_boot_complete(adev, i, &boot_error))
-			amdgpu_ras_boot_time_error_reporting(adev, i, boot_error);
+		if (amdgpu_ras_boot_error_detected(adev, i))
+			amdgpu_ras_boot_time_error_reporting(adev, i);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7021c4a66fb5..d0a125743d3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -47,12 +47,10 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)			AMDGPU_GET_REG_FIELD(x, 10, 8)
 #define AMDGPU_RAS_GPU_ERR_AID_ID(x)			AMDGPU_GET_REG_FIELD(x, 12, 11)
 #define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 14, 13)
-#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)		AMDGPU_GET_REG_FIELD(x, 31, 31)
 
-#define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT	1000
+#define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT	100
 #define AMDGPU_RAS_BOOT_STEADY_STATUS		0xBA
 #define AMDGPU_RAS_BOOT_STATUS_MASK		0xFF
-#define AMDGPU_RAS_BOOT_SUCEESS			0x80000000
 
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
 /* position of instance value in sub_block_index of
-- 
2.17.1

