Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C90C02185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 01:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336EB10E49F;
	Wed, 15 Jan 2025 01:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ANWV8uIy";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FB410E49F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 01:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZfsa6Lm4h+Ymh7xkBL8oX+9NfK1zVnnMjWd8ERxrsmBcZDCNUPyAdlZFe29iUHIkUaPcMvmYLWMSfrwG/IJK38Zgz2uDp0vtdrP6/Xx1VbpaKAy7CT+odL4nUEkZXMx2h3+oJ2C6NvtmNhcKDFgDMuRTLfL3X7V7xZ+SqU8Hy08eOAB4slRjb1arFu12CslsWOmOICjsCYC2pMReDib5YBSEPICw4B9L2hoz9arEbIN5ZKSAkc7n5Cu5y36AUll67GaMVlHSh/qkxIzVJCK+EeRdPg01OlLlCSLkDwefPaqzwCamkdwBA253vey1kzdRvqAgAXle5rqpIr6URZnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE27SnwHy+CHBJ6lMwNHQ+L6y4DITA4x0SAJmOEUts0=;
 b=yTYXqgiCnNZskkGkdCgEXcQ83hih71jzieH3N18sC7EPCxqlhvkIDlM6NcVH/DFMEyP7ZObLgtTwvUNhu2BN91kNNG7KRZ1mYJPVJDgmFHHs4a6j8OOMvgcmNfnj8OtyKSlL8bHqBWmKu0q4Kj0+M1rSvJZmX2RTxbMgZkQ/YSSMTxQqoPX2gpJF813r0XaKYFi6KPStf+0m6dhJaBfIrWvPGVu8Iu5tkpL/02almOjmfN7gEYclThDtf6MNZN5KIycdyvxRsd4phdkPjLyDa4ZgKV17X5SeuXW8A1tPj6DD5RORVLno4yp4FH2iCvCBDAG4pneQJoVSI6aQqBRDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE27SnwHy+CHBJ6lMwNHQ+L6y4DITA4x0SAJmOEUts0=;
 b=ANWV8uIyn2l7v0nYfEUUQFDR6QTFznJ7XggwtiuxjRe0dX1AcYY5qaFZEmVilTuucTcZxTpri8RAyUHuqXHDWt1DjQ4B+x2qgUOOQDL/AiOPGssQUgs9JvqXhX4kdXJWto3RcjtDLzpzidNwjnAUp80+DwatXXrWKp9O6X4zxfU=
Received: from CY5PR15CA0073.namprd15.prod.outlook.com (2603:10b6:930:18::21)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:41:16 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::50) by CY5PR15CA0073.outlook.office365.com
 (2603:10b6:930:18::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 01:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 01:41:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 19:41:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 19:40:54 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 14 Jan 2025 19:40:48 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/3] revert "drm/amdgpu/pm: Implement SDMA queue reset for
 different asic"
Date: Wed, 15 Jan 2025 09:40:34 +0800
Message-ID: <20250115014035.3681642-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115014035.3681642-1-jesse.zhang@amd.com>
References: <20250115014035.3681642-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb1f18f-4b9c-4685-27a9-08dd3505b353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lckIebsOM74eN4tXKML92ImHG0NdKB+W0A3AUnqqVUo6CTc76C1wACv8pevI?=
 =?us-ascii?Q?JScDIVN3/we8glMBRSy8/rQRxUIe/guswVAg2RqTUQ4j0Bs7qHkpO87YrFlO?=
 =?us-ascii?Q?r9VFNDVrnxdFEzCASdRFwhvLFB7nq4az2xwO+aCEPvriQ/DPgNHgDqecSXNq?=
 =?us-ascii?Q?L6nJ8rmHlb/8LKSBM3vMEMdhA51pRfjooxMtCcgbT1in1QlQAS/ijSEnZSsB?=
 =?us-ascii?Q?VW5OuevKQCLlv00oWAoGIa34MW9wG1Jyb1w7/Pc4gmvgM3XOjlSHoTiFS5FT?=
 =?us-ascii?Q?Bok3ysNW/MwqfkOiGMKyWNsugHubzcvX8xCZ1setNk86yABGJHw+muxrsN7C?=
 =?us-ascii?Q?BVVSCLr99v91i0Bj2sCY0NavQ6lWV1TkY4Nqa28TG7Mto0dlZfQBGDuOAWur?=
 =?us-ascii?Q?YCcTeb9inKUzQaKuAwIZRARhFOXs6ZWQhBWDSO0MfhSfgEgoIk/VLvC7+U+9?=
 =?us-ascii?Q?pjx+jEWebh++yZddgG80uloWDyQfZObLRkcwQ2Avke0PBdX0iyxUDr7CLNKR?=
 =?us-ascii?Q?nWRkXqxA5YH0T6/q9USS5UVZgAizFlvB4nIgxM8VO5fOLnoakx0CeQK8hFB+?=
 =?us-ascii?Q?azSdtD0FuzBu2ymn8Q7/By2MzxOXLcJJqj0t7dYgBCEKV2fthEn7UTJFACR1?=
 =?us-ascii?Q?KUVN4fwAtCkCTJ5lTwvr6pFpv853i5viz8F4m6aKMdF2QVXJdzJU0s2Pep6c?=
 =?us-ascii?Q?rT/8ABlcUJ1ulEk9lwLhw+tafyC/ZicsuyMzGra6VHT8OjL103OG0qFg6IL9?=
 =?us-ascii?Q?CCXfUp9GB88eYv+eKjr6uAeF/OTObnluBcYGAkCiTwdLHpfg0fHa7tM6HUOz?=
 =?us-ascii?Q?c1jFXNgU9/ebYxA6ZUAF+S/SfwYJLQYgypSKLS0cgViJGR3Ry1O/rmrFfWSb?=
 =?us-ascii?Q?oLCJfbFxYbQFnig2KPMlF+qA6g4rJoUzjFiKegH7xb5iGTjvLPWg2uT4w+rt?=
 =?us-ascii?Q?5yofbcqrk7V0ZBv36in6Ggd/sAVCsu4YXaeituImwTuwYtXHKB4jseHwFJG0?=
 =?us-ascii?Q?OyieevCRdQhjnih3lvONVaVzi5fzzWNU/6OMGg1W6/DdK6RQm2ZXBhRQIOZv?=
 =?us-ascii?Q?1el95bGbOsgFYM4KHHbsrz58sbzLl9Ld9XmNDCRz083wlBWi5P35nNUFQ7fc?=
 =?us-ascii?Q?/qLLLkPNqm3y9ajW0psEz9GCgLayqVArUcdJ4jkOfH32m9S1XjSH3s6Lsy54?=
 =?us-ascii?Q?a2Atawgga3yKGBqXH4ZnmLeJh+uXieJSOiM70chaCKsFVQeEe63fAfvR0PCY?=
 =?us-ascii?Q?Q04o3vjaZWTjGB2+9PwdTy52Y02YlhiMoFOQw4WF+D/J99xpxfI0ZDWJJQBy?=
 =?us-ascii?Q?u8IPSDsEbfVak9V7J86F4ra77/JxwJWEvj6N8U2BsI2SaEhDWE9Xv5Yy8ONj?=
 =?us-ascii?Q?mPKc4zmOWufXzzLURgO7smz4RDRQYZ5ewHVqsXKk4mlT/fEDqiXbf9fHzppq?=
 =?us-ascii?Q?eL5gCs0lITiVdEK2rFgPil3IfUMxYicmBEucN57zq7ooV99P8SsWW3CA1LLu?=
 =?us-ascii?Q?X1yztXa2qshjiAM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 01:41:15.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb1f18f-4b9c-4685-27a9-08dd3505b353
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

pmfw unified PPSMC_MSG_ResetSDMA definitions for different devices.
PPSMC_MSG_ResetSDMA2 is not needed.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 30 +++++--------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ec339d17499..650aa9d0548a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2743,31 +2743,17 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 
 static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
-	uint32_t smu_program;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	smu_program = (smu->smc_fw_version >> 24) & 0xff;
-	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
-	case IP_VERSION(13, 0, 6):
-		if (((smu_program == 7) && (smu->smc_fw_version > 0x07550700)) ||
-			((smu_program == 0) && (smu->smc_fw_version > 0x00557700)))
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_ResetSDMA, inst_mask, NULL);
-		else if ((smu_program == 4) &&
-			(smu->smc_fw_version > 0x4556e6c))
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
-		break;
-	case IP_VERSION(13, 0, 14):
-		if ((smu_program == 5) &&
-			(smu->smc_fw_version > 0x05550f00))
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
-		break;
-	default:
-		break;
-	}
+	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
+	if ((adev->flags & AMD_IS_APU) ||
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
+	    smu->smc_fw_version < 0x00557900)
+		return 0;
 
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_ResetSDMA, inst_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"failed to send ResetSDMA event with mask 0x%x\n",
-- 
2.25.1

