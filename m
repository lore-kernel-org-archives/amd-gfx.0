Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18E9C54E60
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 10:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0A010F96F;
	Tue, 19 Mar 2024 10:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhxYpS5k";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BF410F96F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 10:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H23J63qOL195Ta3utatzv2bn87A0LRngPp1gqTIBAOJY83lOo1WyT3iJ2tfvr37RLA3W1dReEBBvpQXThyCGm9Ymjpu+RpsSCuAF4Dpx0P7OPDyg0/1gOhklZb2fGRiL9cUDvZe4O73uzc1rn5htmqQw6J+6F2V3ZqGNnPhI7C8gdvCV59s/uA3hr+nzgdyEN+sEVV/zWstm2e+Pp8Gr2kEpvIORy9cGLZARx6pW/HT8rVuDTMoHZeq3NDwi8BPXeNejImcrhHCdcGf7l8yHAo1YNfknCmTaf0++pXmEwXkNnNRiVJAouxJpPwsJUD4wj+0Bd1ToVbXKSIckpuNVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAPT8/LXa1h0wV5mmnZ71jGSJHGZpS1XTYEQyBU4WpU=;
 b=clHtTiDG4zjUVqcPZlGg+QUbPEVhwM346MEeIPgtIBhaKRTyP12NmeSjyKRJE9V4eDuWM5cyHJhk9SyceEGb4Xs39WpKGOqeC+ENdhUC2SqtFlDuOrdkChpSoeIMx0RJi1JL3Xz5VMRiFDZLiCENporeo3/Snn3/Co2auRlEt1R/JtdiCLtLSX9JCfRw533oLSUWZFtfQRukA7A+7Xp7v9qHREqrcpFLi/xtKBU/1K/Deq0hp7kURD7MbuBH8xoK6KiN5Xc4cwaBjGYHBbl+YI/N5G2tkBrTz5jG0NPEQsP2Eeh2p2WUAGacVp8yGXb1FUmqr0ArkKNkpUpLsHv8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAPT8/LXa1h0wV5mmnZ71jGSJHGZpS1XTYEQyBU4WpU=;
 b=mhxYpS5keRrsoUUfR7KT7meYIYQxIBkUYhH0RAOvc45GwrK3oTOyV5N5EBAU9LaG8pjG2EocywBls2MEgYyrTA1ilz0h1KybqHaLTHKW0ollN9x3PtMMtkURAMGtkx9cZn0HVSUbNgaZxp+gvdJ5w8rN0JWcQ1OPp01/2y595eU=
Received: from MW4PR04CA0271.namprd04.prod.outlook.com (2603:10b6:303:89::6)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 10:15:21 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::9f) by MW4PR04CA0271.outlook.office365.com
 (2603:10b6:303:89::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 19 Mar 2024 10:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 10:15:20 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 05:15:18 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Don't use OD table on Arcturus
Date: Tue, 19 Mar 2024 18:15:01 +0800
Message-ID: <20240319101501.2567966-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5f8cc1-fa1c-4185-718f-08dc47fd7bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQ1meiSp7faTjGYtGCG1HK3kL8TsqqE4O4HWogKcg6t/EuyZl3uoEO6Gz788xyQ9MEStz30WNt9quaLJ50gsS767V1qsrcJR/F/jII70Vju4CxDyoPxW2SqOz2wByNPRK6FAZXMpA/+4Rw25M9kGEOvb3WBT0MeWDOECoGJcwDbASog9ttAqc3nvsjZFxXgdfdWQX9tHuJNgrWuTr1ftAguD4ouOYein5MZqS17HFUra5OvSgX3Px/w/g36uOJeubua6vEDQ7sXXjaOHPM5ZkIa1EmLjRiWx/5eMXd/hQCv7V00fmgmY2j85ipf4I4eSoTFyt6E/Ob9G976O8S/u33P2T+yC03tnxhYr/17RfeZAmc9ijileyFADh0XMY/ty3CRyCSSi5HyBHAPcbmTWXj02QU/0BMdjK7+5XUFnys7+GIUOSfTQ+R4fZRa135t80TYx7ib5g29plK27dQEvl1C3ebNWOZaXCLeSp/YEIsteYYvVPwAopXUznxbVMFunDGj2Zn4eG4AAP4To9ia00ojyJYCK92il9suKJvx6kFVal+7n/SUHOlIL5iFOqxlbMBIfAAqzjApPcM0HrznQ+tOu4Vt7yUU6DHweCXsO4A67cJ98cTU+Gjb9ExEfIWErXykpzNzCvveeCsVLMeNp/2j8NaqEeD4pY/GFIYwta3JHJH+uvqhVj7SyR9RHP7ibz2Z3jw0uz0jljYlAVh1rYHWQMU3I8O9hJy7R4ZFoZWPM5ZE9rFvqaa4NX7KC/UdE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 10:15:20.6581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5f8cc1-fa1c-4185-718f-08dc47fd7bbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

OD is not supported on Arcturus, so the OD table
should not be used.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 33 +++----------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a58708bcda89..dc3a5d863a04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1289,11 +1289,8 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 					uint32_t *max_power_limit,
 					uint32_t *min_power_limit)
 {
-	struct smu_11_0_powerplay_table *powerplay_table =
-		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
-	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
+	uint32_t power_limit;
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
 		/* the last hope to figure out the ppt limit */
@@ -1309,30 +1306,10 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 		*current_power_limit = power_limit;
 	if (default_power_limit)
 		*default_power_limit = power_limit;
-
-	if (powerplay_table) {
-		if (smu->od_enabled &&
-				od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {
-			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-		} else if (od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {
-			od_percent_upper = 0;
-			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-		}
-	}
-
-	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
-							od_percent_upper, od_percent_lower, power_limit);
-
-	if (max_power_limit) {
-		*max_power_limit = power_limit * (100 + od_percent_upper);
-		*max_power_limit /= 100;
-	}
-
-	if (min_power_limit) {
-		*min_power_limit = power_limit * (100 - od_percent_lower);
-		*min_power_limit /= 100;
-	}
+	if (max_power_limit)
+		*max_power_limit = power_limit;
+	if (min_power_limit)
+		*min_power_limit = power_limit;
 
 	return 0;
 }
-- 
2.34.1

