Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924BDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 21:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2148710E666;
	Mon, 24 Jan 2022 21:12:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7814D10E666
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 21:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzaV59oTR6/SFg8imXaou+Yd/f6U9EwThzQy8QqrhlkKQCPpu0xrEc2rzXFtcsJoTy+9XP5j5CUr4M9K8fmNSmN0JrniCiKt+4lKOAs9JaZ9Jx9BRVCe2Ije/ePjzDMWfUpgoLh5kl/92CyNHgKfxd6qMlo8mCa7251TQ5Uqfec4Pqe9knnMXtFIF2COiWddcanz+bIHg0icHHFdKCaQ8kUSCAPWLLwXJCISvPdz1qHW9k+ngyamtEFZwxapsNCU9MQJycrvAUCOGZnwfgBYEcj2dIzcRn/dQ0WD1ySkfnoIIC8jcJGiUWzAtVqEHZc09ycmCyVjYB5o3G7Mxd/H8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOkNgQPejBZ0VrrNs+YK4Kubiw+TqycfAvlXQ4x3H78=;
 b=K2oaTBm6Cw3EvjfwKMzTOgXHEUGU6yQHvG3yliTNPeG0ezaItKxppWojmddCyIJWBYXbbPN29sS3+x5CQCmlTNDuXTDEu2Lp9r7emwLYH7HBsbMijKjvbsR8cSjFS7hDpKkAVxrBdhzjV4ZJSeutKq1jXAuuq4OW6XELTi9LOTIoqVurwGJKmbrRH2tE9pe3/bRf5Q7sG62EielMOtic2U/EY2baxOtodprG1xwVv1zAdHLU3NOung7um7pcQjYpg/jUlJRBMCBH2aGtowxwbiUojDaFxdRwf3fVOOwrb9IO9CIJinU4AScTHJoPHpPd5yeCcYsmqWyft0DGSdvrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOkNgQPejBZ0VrrNs+YK4Kubiw+TqycfAvlXQ4x3H78=;
 b=hC7KmhPCbkFKudV93b2BMaYFdXVTsdknLRTHjAYjyUojtIU86PAnOWhshWFvVLbmwRhMJtBQViXZv9c/erNhcSMHZXI/mZUkw7hfGB6UbSdzniMCa1ibersmWe8xlmusbvROfDsYIR7UggF+W8WP0tpDcebFOO+C36wn3kjV3cA=
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 21:12:44 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::dc) by DM6PR17CA0034.outlook.office365.com
 (2603:10b6:5:1b3::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Mon, 24 Jan 2022 21:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 21:12:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 15:12:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/smu11.5: restore cclks in
 vangogh_set_performance_level
Date: Mon, 24 Jan 2022 16:12:30 -0500
Message-ID: <20220124211230.1635105-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28b5c497-d2a5-4be7-d3ee-08d9df7e4341
X-MS-TrafficTypeDiagnostic: BY5PR12MB3666:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB36663F9917D29C8E9EEC9594F75E9@BY5PR12MB3666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Nn11rPOI6dgJVSbf+/DmHux7tmBq47/xvQ/ewo8ZSIvSp1G0eTv4ZU86sSx/140MhMG0Zh3FlurnlwaguCqlf8k7sCtZuLtoqSmxp4oxqOC3sQcz9XU87lDqiMPhCadOuVWvZKkKpi+FLoyHFnm0NKIEH6WEnLS+dVisVOwp4/BPr44GGGqKK91du27UBXHXdCHWtsek5Am5ZESwe7zqsl/lPNb6TnPV+cBQT8ZyftZNkdSFUI0O4Tns79BqEZQl97sZoEcb3mclVUT1h/2pRre06AlF9IhcJR85JD3EzBhENrVlbyetK2q04HgjLibW9RqTT0uXDeZvXReludPuLo9HGJXbNR6bEBAMwtbwlTislegAVW3h0BJDrK3jsBiPCJp5G4fUVPAfUeWkbW33T0O901DZ6ON0APB+Q9r9lOwfEQXmq/MuDUK2uJmwawBYKsyoCZyxErNq2D2ceIum3JDmfYQFhCFzVpkhvfUob1FsQH8lWcl33z8F05cO78RMIIXmXPkGUluUsj7OTpEh0ExfCDSpZGRvcxAkDkaewHQyVxH4dPPU7CwTZNCTW0vPnfgfM1F1aqe0bt/jkhTDdPFl/YoyLu4B4RjvI+wzZKiZrHEp6vexPa7bHIkf8yhHWY4FrrGHz1FgkRvfKFt29jVt8WcsyjjMr00DxkQ90xnHTmBm8vn33s4v7u29BDnDivnpnUWW7gZU8a8mXium0cYHViDlUmsR+iumvxCU/Rs8A1uVlQTXWuL/UA6qSAge4HT2YWGYIDn8SlHJJFMD4NLo48b6uqAQbqoLVYfpg4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(508600001)(336012)(36860700001)(186003)(2906002)(6666004)(70206006)(70586007)(5660300002)(356005)(426003)(81166007)(6916009)(83380400001)(1076003)(26005)(316002)(16526019)(8936002)(47076005)(8676002)(7696005)(2616005)(86362001)(36756003)(40460700003)(82310400004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 21:12:43.6115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b5c497-d2a5-4be7-d3ee-08d9df7e4341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When we disable manual clock setting, we need to restore the cclks
as well as the gfxclk.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 721027917f81..9a89b768c01b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1388,7 +1388,7 @@ static int vangogh_set_peak_clock_by_device(struct smu_context *smu)
 static int vangogh_set_performance_level(struct smu_context *smu,
 					enum amd_dpm_forced_level level)
 {
-	int ret = 0;
+	int ret = 0, i;
 	uint32_t soc_mask, mclk_mask, fclk_mask;
 	uint32_t vclk_mask = 0, dclk_mask = 0;
 
@@ -1482,6 +1482,24 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	if (smu->adev->pm.fw_version >= 0x43f1b00) {
+		for (i = 0; i < smu->cpu_core_num; i++) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+							      ((i << 20)
+							       | smu->cpu_actual_soft_min_freq),
+							      NULL);
+			if (ret)
+				return ret;
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
+							      ((i << 20)
+							       | smu->cpu_actual_soft_max_freq),
+							      NULL);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return ret;
 }
 
-- 
2.34.1

