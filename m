Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B9BCD6E5D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 19:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868A010F41A;
	Tue,  2 Jun 2026 19:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JVWZcl0t";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3168110F2D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 19:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9ywwIrrq+MMDBlmz/14dU7GzsSB4kZ4y0G78fKlj8hARzl0iTXCDiKM/a4j/NJ+70YeGyYHglHkDPL9z8NgbaoXI4ezeBwE+nWIKy7lQWpw0hOSgNh2HIabVYiSjUwxu+JXoxIDl4nCYACkTxGNmzP22j67bXuVAsVssdwoNSlHpODk8Rmqe3KJkxP2mIfJinxxGgYI2fMH4KYVd7CGOhgkOXFkBAQzd62hlWG3mVZ5CxzWmhVrKueCMdtl1mDpCaH5MAIKhs6gJUJ+HD0iijwe3isZgCBJoRzchg5E1l5Zloux5ZnD/90EMSd4ayCXHhJQxVuyFv3JRicrpFrqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QB79f3FOpUC0JAAAEo6Iqc6NLvTj2QQtfonsjuUSQY=;
 b=s9fagc+UkhSEx49lqkmDXcRNVVCQZ0MGe4VahFwFrxW0Tw7xEj+ydzUQ2YMePQvfO+vENQfvlmtctCNbY6N0a8/tWFusknC8o8jrogyATyAZ3Ywjp2reCO7ht2gfRLDk0Vm7BD/JvYvMwf6Ut6Xa1g2c4BCYlIG/JnEMxwgsiG2ch+oNyH6u+jfhgG1CJNgaQNT50RorZDSrjPGRTNytL+IoPb+po0rsyjewxNnbN2a0m7a9Fa4K8UySeriKXY3IRBj8eJkHUs+I4r+LPbh2rAl6sCdgQyo7QLx4B4TFElX5fAZTQXrGEu+v+EqlPVcMKiPfFb1IpkiGEHRtxvZIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QB79f3FOpUC0JAAAEo6Iqc6NLvTj2QQtfonsjuUSQY=;
 b=JVWZcl0tx+HbCbP97+7AOJT5lFjfP92w89dPEIVggqHW/Nk83tp5klN7LgedSfzFDTrovAEYIueZ05iF9REgr0xaWbK1q5lZEMHFx//HJmKQGy0C9VVg27XxrrLMzkc+7vx9N6xwqQ/T6L1zNErATPbWB1Qm8ZHGe1Gjmo/YleU=
Received: from PH7P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::11)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 19:21:53 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::6b) by PH7P221CA0015.outlook.office365.com
 (2603:10b6:510:32a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 19:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 19:21:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 14:21:52 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 2 Jun 2026 14:21:52 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <alex.hung@amd.com>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <aurabindo.pillai@amd.com>
Subject: [PATCH 1/2] drm/amd/display: widen dc_hdmi_frl_flags.force_frl_rate
 to unsigned int
Date: Tue, 2 Jun 2026 15:21:51 -0400
Message-ID: <20260602192152.4173277-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: d13ed551-5d49-48b2-88a2-08dec0dc3405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 3VDNUKzgRTWhuXUNoL1eMSdZ2vni4P6QDleoGNw3Yg+3xFH36zziyZ1MVdRwvccXsLfFtHbBFVLBGTcLRCaoegL55xq/c2eP77IrTPKQ3Qo97fFGOuPtcNLojMDN+QpD/qlJiGimhWFMgVVGwxA/6KJhks2ROCvUSy2jOMbBsko0Bz6EnpzU96foC765eTgn4XrL2ZzAPhVkKM28oktFhzwKPgWMV37gdjHZEgIjW9GIP5waODQSCm3os6YhowewDzO9XD4v8n6fe0RHIqRF9I++b/ngLY1ZtspnEX2l0ZtgnEXquirmc9H7eRaPAoflsJVDZG4ppT0DxpqCfgkD6zx6mNWIm2tOM3raJrwsMpNlX92i4HruIY4qO2MT+yAcK4WtOO7agoiHLbh1mdxgAV4HBs0+MapE9rskjjN34xkYd0Pr7BLOZTs3ednsFyxHIr3Rjn8gD5T1oCARlq7rS2cAtWQEnF7y882tU4cM/eZbPfeXSzVEvFheAcl1QFpP+AIWCDZHCqSd0byIaMESjePTmWl9tkZo+8l0B1CVpT+9McxmNIQfCAlfWmQETktk4AMGCfcebopvQ716/heQNtZE/H9kHDeo2FracS7zAxELKC3k/1ksmvYZH/JJ/vhALU+ZFYhN8aED2pY5zoQZJJvoAwcrBZH2qZW4v3KBbEuaSuV/fy6k7ay/tKDf4mGHJ9dA2fpaqaAfxIsHNKUuOMiL7XTemaeOttXbL5AZ6tQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b/RDIM+RVZPVWZydErrKo6SAp7Nd6PqxlVym52X41cx9LUq+jbdxma2UNFh5z0zdZmk4pSg1V4DAjJBcGcA6uVhafCMwqv9CLsIVQbQVl5ObS3CJhRGNkN9CuXlnB1/pzWY1Y6FkG4Y+W+HvN8beNyjojRLhdujhquopXLTfEW5ty5fjxuJR90LZEY76jzeV9BDK1lfsfGZXd0h3Omx+915V4m908Ue8QUJpTuonmnnZ7wAelNxlgy7+Vj7x2T/V4rHPoAecn8VypOFeAqBUt1DwiCo+9eUI0g1XWxYZszmTEJar/64v6g1snm+pjm+T3l01mhuDHR8Ivzb4yVOC5y59N59KaToaW5DqVjZdpiYsF9H7ujgBpuZqVnv1O+JNvfoQR9acQznZFHsl74XBvwEt4p+qoIGnQkbPd0CD5CyO/HydK5zpS49NadWiyTVv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:21:53.0275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13ed551-5d49-48b2-88a2-08dec0dc3405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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

dc_hdmi_frl_flags.force_frl_rate mirrors dc_debug_options.force_frl_rate,
which was just widened to unsigned int. Match the type here too so the
assignment in link_hdmi_frl.c does not narrow from unsigned to signed.

All call sites in link_hdmi_frl.c only compare the value against 0, 0xF,
or an hdmi_frl_link_rate enum whose values are non-negative, so the
change is behaviour-preserving and does not introduce sign-compare
warnings.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
index 0da03eb794aa..eb6e7f4043fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -266,7 +266,7 @@ struct dc_hdmi_frl_link_settings {
 };
 
 struct dc_hdmi_frl_flags {
-	int  force_frl_rate;
+	unsigned int force_frl_rate;
 	bool ignore_ffe;
 	int  select_ffe;
 	int  limit_ffe;
-- 
2.54.0

