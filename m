Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4535C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B17D10E2DD;
	Tue, 14 May 2024 06:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wXKBsNhu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E3310E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4RUS37WeObCusD64JxUY5vGK3DicYPOdOA1yTR+nmK2KhypAAqLXTK8GyWOCB9/youEzvPQ1Z541t0/MBmNaga/z8eDJHClS8xR/PkxjUufydHfS7qWFA8vun9QGg9A2XB1zCk6JxkQ4hCir90WS7yu+q4XNy9N84EEgEpr3z/QfgfRm5wauEGk1Ss2qezdhlunf8dYiT9Qw/uAOxZlVm8FOXsaTmCnsM+Q8Wqt0Du7VLO3cRZZAnXJrxdS0Lb4Gqp29iVr7Ay+pPFJQs+ogAMi7k7waehTG23PqhXZ5vW4+DaZGUnqObEAK7SBFRogRJ9nOvOOqlMVW6dgKp5hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY2C+2hK2FJ/uw3w0Xs+PFVZ0pcL9GmjRxmAF55VAkQ=;
 b=oWKRzjY1RR81LgeAAhKfwCqVDIy+NgOEDw0CxulIl4gc/m2oD2VOXQrQdvOlPwpLTGl4w4CJXdNrRNsvXX6MCvrKvLcaxnwoBMzeSs2Qm2UVdr7RP7R/NRdbyK0QxQa2eyPeQPVO9y/ME8dqYAipH6uuPA7tlJv3lM8Mn0pG+++1d4MMlvr2V4Gk9VJH6TWF5kjAe+HHntOFS7DqhbrMtrNm8xbJhH/9KxwNqTlKN/tcBTrFvvj3O7SZptiCmceTRw1RFI/cdc3hVQWnq8GlC/bDoGM5Iz+Zeihm7A5MzRDmHQkIfOc+Jn+n5RZ/IQhv3Qx2My9QbbpLt9jbSdtnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY2C+2hK2FJ/uw3w0Xs+PFVZ0pcL9GmjRxmAF55VAkQ=;
 b=wXKBsNhuDuDm7CTnOeHsBydOT12OgApxhaIM2nG4ZeRo71x/9tfMEOWLCC0N1EN4g5KjkuRzVg1E6+JUsfTFM5HDOzNj9kQUJ8ef83oSQ30V7CKfR3915S6p/gZ4cLnPqhgTe94pDb2Sur7IttdHG9YB/cxuFqRgG6gBu79mtnw=
Received: from BN9PR03CA0446.namprd03.prod.outlook.com (2603:10b6:408:113::31)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:58:10 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::d9) by BN9PR03CA0446.outlook.office365.com
 (2603:10b6:408:113::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 06:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 06:58:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:58:09 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 01:58:07 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH 2/2 v2] drm/amd/pm: check specific index for aldebaran
Date: Tue, 14 May 2024 14:58:07 +0800
Message-ID: <20240514065807.3651928-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: e671477c-4fd2-4d21-86e7-08dc73e33749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DSK0wd1QZjBoaNXMbUoqT1p+uPiU0VwfzpZmP9P3Hm8N1+A9EmBmebTe0oy2?=
 =?us-ascii?Q?pG9EwkvCKq54LwMnq03GqopCGyhNWFrzOg793GvJ/aRYnO/xMUdDm/H4WP1n?=
 =?us-ascii?Q?s3LP+VMFPMuaipwHyVUcN3nNi1LudHiH0rQkqCvq2yS5xK945DXHZ3TxOGjP?=
 =?us-ascii?Q?bDu8kL6Xg2BjcNuW+4hxyNBomU7NyWR/5Wlt5m0iSYvmIYLqHWmzHpThodEL?=
 =?us-ascii?Q?IOjIKS3Mc9Nax64R0QgS7ChTRGin+Lc37hz3ZFhknfRfW0BhInCZpLFAMUWV?=
 =?us-ascii?Q?HzmAxjJ4uxbR5CPSgDYKCoUsROsZEPDv3pRWiMWaVegVTCUt9C5iflXwIfub?=
 =?us-ascii?Q?UeuX+xiAQ79YtOgh32Rqt1GARcHaALwGNw5VThBkjM9WYuFo5F21ussSk66F?=
 =?us-ascii?Q?soBazV22fW28U189W59zuTHjn+FZmnZVE/w3FAuOFpeYlfBeGLEHf1ydECKG?=
 =?us-ascii?Q?WI1daFR4MPN34Yo6k/SOVhDO2XlLKLeKJAMwPgifbQc8A88u2kRQJIcS7d4G?=
 =?us-ascii?Q?qv103x1b9XR6gjqn9ZMoBjWxq2lRDDEagEljPaIA9916oDi8lIfmSERnBPYf?=
 =?us-ascii?Q?bgVGhHpIlqtlpe4ivvTzu2MkDChuoQ1tmN2ySASEia/Yqt12VInr0gMPldiG?=
 =?us-ascii?Q?uIk6fzqDzxTuLwLK1yxJgFwoP7kOWnKBjCsuGAqm9wNzkSEGB2+Mipp9gX7n?=
 =?us-ascii?Q?btfIgnNg4SQRohxjwNPHywsdRASPjLBh84FIWIlXhYJmLuBc+U3s9TSwWP3D?=
 =?us-ascii?Q?ks36VkNbn0DmNLplkqQ5PaTsBBZexiFuih5++FeD5Argx+9j2OMzpXzx7zxF?=
 =?us-ascii?Q?JC9aujdWV2b0eHwIUmkFUcySIF9UeLDJZWIVEvcpvi8p40sTSuVSEVkUSWi9?=
 =?us-ascii?Q?E68pPk3xBL0GRwAmRmb3ba/wF25rCzJ3J0XV3cjbjDycrA9pQoZwnmYyDhHL?=
 =?us-ascii?Q?upEwMBKVmNznJkAxcVfEBDufnHhGXhLvvcp3kKhoivG22Qq0mzs9MWse8zmd?=
 =?us-ascii?Q?VdcA7yjOe/5iF2GgdMJGD21yb1R2zPZLEQNV7yAM/YEF9HpOSZqn6PJLUssC?=
 =?us-ascii?Q?QIxwm/U1+qnSwpWyqQRYz7vJVOr6MWZJjrb4IcpwxSp+hh3w9kocroqTtmYH?=
 =?us-ascii?Q?iKsRJ6ejxjB91Ck1/mWEXeds4qQeHO5wWAPkF1MkkWcyffIF9h1oPD9NwPtD?=
 =?us-ascii?Q?W5Tjia2ZimElHVdngRQcu2MCvd7s9LEy8FQ4GT3L3LjELA6PGnvHXLvcoJL3?=
 =?us-ascii?Q?Db/cor9keZRE1vd0Hmv7w1BhUOqbZUHzLav9bZRoqy3jaTKie1WpyuhTvzhd?=
 =?us-ascii?Q?uCQpW5sBROfgVAwkTF4bIQGpyIrep3pUPaP8cZsL+7H1g2+7lXKidcra8wLp?=
 =?us-ascii?Q?w9pqJ7GLkvEc7GdmJ2lWV2PuwfJ5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:58:10.1322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e671477c-4fd2-4d21-86e7-08dc73e33749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
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
index a22eb6bbb05e..d671314c46c8 100644
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
+		ret = smu_cmn_send_smc_msg_with_param(smu, PPSMC_MSG_GfxDriverReset,
+								SMU_RESET_MODE_2, NULL);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
+			goto out;
+		}
 		/* This is similar to FLR, wait till max FLR timeout */
 		msleep(100);
 		dev_dbg(smu->adev->dev, "restore config space...\n");
-- 
2.25.1

