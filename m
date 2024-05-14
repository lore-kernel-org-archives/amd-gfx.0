Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1176BC25B79
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 09:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A44B10E504;
	Tue, 14 May 2024 09:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sL/S+mOU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E841210E504
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 09:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzqm7LHtXXbepGeeAslhj9u8+TopiZqymBNHbKQ0Csdyf/yb9Y9+ExxpFwyFpDo0insFwxl0UOQn3p5bYg4kkEIGvKC9I/OGO9Hf/Q9BtIImlnF5eus1GUeWvfE8CJnU83xjyaUPNP5fHTxfl41SHBx9MnWVisPC2+4OF0e53nH1bR/u93YT4fV87UG8/dQJhC7HMcF0Zbz1QgxAK/Id6PeE5YaqRHCAuQSwsxLvt0ysrWYyie8gNlYlPNGHW1zP6mVJxNBkpgPkWNL7rsZ5WQYVCLACWMzGecNrkf2rH/Buu2CQMVCjOQtse+xjxuxoc1TYZ39N60GCmtoElLXcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAvRrjLMvECfK5A7Sv2eMhoUyaqH4JO0IOvR9MC0Iq4=;
 b=hD48a7G3sbMUn5TcUox/AbmLN1IgkJSb8zBUhhGa6lJIdzu6Cj5glPPxPymc7LEDrA4Cgc9CqgaAFi87BBu6N3egoqY68vAIL+ZkqJMdthUxVHB43G0gI4Kp1PK5fkCETm4/kSjitHyrBzsHuD6sB6agJKSVRVK+0l+dtHvORjZXAx0VRa23G5cetDrI9uzONgvsl6MWA91Txn9/vAdrkTqypMZhFQ5O5Wk3dSNiLv3U/axIkMEd1f8yyn7rd0W6JoEvIWR+58UdDdJv5SgXIRFgcJM7tjSs4UglASV9ac6msR5tNdkEEOuuilAqzcjjsEi4QhPAuvZGmvTWwYl17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAvRrjLMvECfK5A7Sv2eMhoUyaqH4JO0IOvR9MC0Iq4=;
 b=sL/S+mOUbmepc9mhugBYTFhSmz+gaykSmmqncw+3fJ4qajNe1it+Wjb7/fJGuK4BRcb/PCVpFbXKwZA6CTBxr0GPtQ4GOdx8o8gQOBZDothBBVZVITU2KUduSN27QimxH0NsgumVLqEa38ASSm3B4b3RzCdjS1LxVfiRaHUBx+c=
Received: from CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::19)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Tue, 14 May
 2024 09:06:10 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::3) by CH5P220CA0021.outlook.office365.com
 (2603:10b6:610:1ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Tue, 14 May 2024 09:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 09:06:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 04:06:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 04:06:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 04:06:07 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: check specific index for aldebaran
Date: Tue, 14 May 2024 17:06:06 +0800
Message-ID: <20240514090606.3656159-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fba202-566f-440c-5027-08dc73f518d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oJMPr5o9+8h3jLr6M1nAmGG8nlZnIMqWUaODjTZ/7dCPVhwSiqI7QLmL0UYL?=
 =?us-ascii?Q?g6/cgTXA1P2iMHj+ZM/yt6/I7ds06WsAPyCYA3nxpBhmKLztohEtg0lpZjX7?=
 =?us-ascii?Q?w5EJU5OBMAVgbdweHZV4+cHd6BM4e6XN7e2hRlZ9T5iWIiXdKb225joWcK/f?=
 =?us-ascii?Q?kkbwJiBMFbzyikR/pcIeuQBJNotg+28fXgKMnBhio91RBxElvQIOoIYuYphS?=
 =?us-ascii?Q?6AYkbmhtJRt/zgIEyXBQUjkKtJZgb6FyRa6zu7C/r2cjnVweOny3Jluo0wnL?=
 =?us-ascii?Q?z9AJ3iq92ZMssMcqJbCyVh5b/6Xt8Piu23Avcog52oFYsX/d5Tz0Lb07R2O/?=
 =?us-ascii?Q?GtN+R0zT1/MFmubIqdTN8gdaEj7D1hDZI1y0WFlTdZnWbngJ/4q9FiQFh3qE?=
 =?us-ascii?Q?7aquUeRUdyiYJEc4Zt9eG7oJMgs2c8Cv8QouBysPGMaZ4E42ms/oyFmQlvgU?=
 =?us-ascii?Q?25JTYWqc4VPDd0lSRS0/0Pm3eO3dq8YGrc2/A28FAOg5itvHRmqJs6/QBxun?=
 =?us-ascii?Q?0xZ848uKYnkTZxtrIQ6ciygKXLfqU/m6mMitP3sTBYHAFYSdVjkWW2ulJ7Uw?=
 =?us-ascii?Q?F3HUebyH27mB538WV9FXRTerlVOfcowriPB5cEGqhXVXDsWcZYSZNZTDzxn2?=
 =?us-ascii?Q?2gcCi4EfCauvRKiMYX2sfcrKp6pdas+bTjrhy8dHCq/d4l/MTuYYU6gGHHz7?=
 =?us-ascii?Q?kaiKbvRwKi/cMs+bRmyROhxDhCBoXIwt15KKgOi5hGE+tUbTj898U9q8Dbj8?=
 =?us-ascii?Q?KkK32LQTj5YeyfW8s6P/EopKX91YSdNEnDEGpOvVAd6S2+3YuFC9LRnR2hgL?=
 =?us-ascii?Q?GXCLAMW9fsQi0KqvdyudZB4ST9oLs48yAW+lY4yqRy8n/rzb2HM0ssjCq3it?=
 =?us-ascii?Q?7aNzv/r540L1rx7pUIylYXgdjsm2iBK++qg6ulRdPooId3b/DqVywNAN8NMD?=
 =?us-ascii?Q?Q1M3ZLICs0KFFEFI1KDUPCsiKTWWITwAFkunBCcAn18zqhHdXhdnCjcAnIKM?=
 =?us-ascii?Q?OnQrZG1y03/JLhMBZCBR23+6xl5v5SAJxJopccaPfLQR4jgG78e29BvsXJlj?=
 =?us-ascii?Q?c9HoCTrpyHzPHsWkh3sRsj3xkU7F6m2lzKR3nekN7+iI/4DnVredsj5MCrl/?=
 =?us-ascii?Q?vJwoEb1eXnP9Ae/NaFLVxv/EFZ51nXiDJjEyE1X5Ho0rF0ObAU6VAIMiL2o0?=
 =?us-ascii?Q?K3Gno9FGVFaZhRC5qh/jGCVmadI0W9XB6o6nldoOqQo64OYHit+R5M/otX3K?=
 =?us-ascii?Q?LLkTwBlpsm8yjtLx5utsV+/tk9uU9YwKio7E5zU5GuttgsUWbyn412NN5b6M?=
 =?us-ascii?Q?8OucbIFH4IGnLM7+ZuzqYFit+/17cwrGYpQpNHRX7NBFIfMGcrlpEDuWY+1W?=
 =?us-ascii?Q?rObWNGI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 09:06:09.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fba202-566f-440c-5027-08dc73f518d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

To avoid warning problems, drop index and
use PPSMC_MSG_GfxDriverReset instead of index for aldebaran.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a22eb6bbb05e..2fc4ba036afe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1880,17 +1880,18 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0 )
-		return -EINVAL;
 	mutex_lock(&smu->message_lock);
 	if (smu->smc_fw_version >= 0x00441400) {
-		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
+		ret = smu_cmn_send_msg_without_waiting(smu, PPSMC_MSG_GfxDriverReset,
+								SMU_RESET_MODE_2);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
+			goto out;
+		}
 		/* This is similar to FLR, wait till max FLR timeout */
 		msleep(100);
 		dev_dbg(smu->adev->dev, "restore config space...\n");
-- 
2.25.1

