Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C47C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D3A10E20F;
	Mon,  3 Jun 2024 01:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rDAcUEU9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0A010E20F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijFvC6zKekFb5rXPwp5OT3350p/mQc9cWX3D5HcXzsVh/Bia9/P5w2Nlfe6dXkRptxpak9TdMz0L0lUzVGtKjkBaP1goKUelBAhax5mTKb1wWncKHQn09LCYQVc1Ix2WToqTm9fphhosTscCg5u0MTLGlO2Me7LBizClJ3Px+9oTwCdzv+SJS+pLt52BTxNoEUUQdYtTdn0exWnEoCWjADz4akCZK1/OY6J2saAynsEVhnQmzREon/wBdPxwrtbkJHB0Bpya0ABj245jhz0nPcPhZeFPkJ/lykBQvkMiycLPag9TYTdBWhQTxTLH9WmEeKgAe6qTidTzpeiyKn0gAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qyu3UwWPNcu6/45Ozefst1Fie6cG1kLQOD1UEWDERE=;
 b=Ph93pw3VAoOKm9FLpL4J7Lt8lMqnl3SbIuKTLjueOwzQEyPHXVvg9XxqwgWwcD6zwi5i4BEU0ngj3rs4i9KH7X+Ce6tr7k3TaWURc/EyqX/5n9/eMwl/keG0dOA3/QoP9la3uI+4jQhYujYrmULaY9jt2Pc4R3SJOlAATNfoBf6I2gk70Msm4bQWrMAf/GamtdG8W6gPyxXsPMIeRA77F6PmbPCGeoE1Ur0dCFTjaOSOlGV3eU24L4Z3SMp3ifWpD+FsnatP+R+KhCGmK/8yvgKkEQ869IzvT4jtmbH508pjuHEYXqpd+5pDk6EepSMlGbqzmc+lu/oD23mgmSG1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qyu3UwWPNcu6/45Ozefst1Fie6cG1kLQOD1UEWDERE=;
 b=rDAcUEU9mzv618PQV+/geFjH+FR69EHKfc5kB3BmuVWfYrD5Hu1uqnq553K2d7GUU84HyKDkulmLZ8y+mXgxLTN+BKGclPlHu4Jm6ekNaJgktITetUJ1xINopvAd6d0nSc3epPcJaCS+E3kfrWS331G9UDazVCTSw7nyYlEtJ3g=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 01:43:05 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::65) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:43:00 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:58 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 13/18] drm/amdgpu: refine gfx7 firmware loading
Date: Mon, 3 Jun 2024 09:42:07 +0800
Message-ID: <20240603014212.1969546-14-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d48b430-63a0-491b-8b35-08dc836e8065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gP5iUYFSDv3zSh4J3YkD6JESwGM3lzhRyMVANGw/1xYh+B3unANIhHjwPhUZ?=
 =?us-ascii?Q?TN2jREfolf6YFxyJGIQX9zPJxtcFVZwh6EjTAGd+xqzXxWZWFHdN8Cal2zK8?=
 =?us-ascii?Q?IYPEIHL83Bi6c1Q+OIlGejhxzB8Xnxt9Ja+JtjNKndFKRwb82PXRKl8gRvMF?=
 =?us-ascii?Q?9tTl2QnazMQaH0tDK6AW5I3ivIpUilWaLL0YNdX/z1BAPXyjZa3N+yPQqbeJ?=
 =?us-ascii?Q?zo70RTPW7UfMTGIk+NPOSFqLMz2gGvRgYQx22rr5I5pOGrqLplfsQg9/VZKB?=
 =?us-ascii?Q?E5P97teRJ4ejderCQDTmrho2ZSh4KtMIZFkluEQIDc8d7Ywo37sXSmEcBbkP?=
 =?us-ascii?Q?s0x/k1DS2TwnA76zP5cqrHDeWeaqt2FMIfCm8WJazgf2w0oGqY1/AU3IvgAV?=
 =?us-ascii?Q?RtYe7d1KKQiuotyDE7Ly8ISkSko9jjYnXG2JRMvRd4V03weHXk0xlXbzEpUc?=
 =?us-ascii?Q?JpLVnuQRR5XzojdMM3S0vUvu2SfJbh5oRSo7X6SUioIETJjz/2eHY9YN3ye5?=
 =?us-ascii?Q?NkQfaESSUqCJ8LjxETr787h9SYHz9xs/9xJxVQgevynjSGcsfrS1T7Ed+2I/?=
 =?us-ascii?Q?K1LWe8JTMxDlIg6Pu0+s+/IMAYrMGiv93ArdME576YRsffuG5L6RdzF+CWid?=
 =?us-ascii?Q?f4vG+iEzgojv9EW/4CGsFDb4UyZBJVbCFG1FC8YALjQHk47wUMvA7+zVrCfe?=
 =?us-ascii?Q?H1viTOIYv2YecGDzGZGSgYJDwMEdqtye20frWa9C9zNJLU7iOAIG+ohcghS7?=
 =?us-ascii?Q?NO+qIMem7Wbbo0DzkhdDZJt4uxB/aw28cQHUOAEmzeV8iK1NScf6ie8c5J1t?=
 =?us-ascii?Q?CyRdBrPJQGkgnQRq1nGxKLrDAlqULkGr3V0hDaGjVvt8JbhV66jVzFbBtebM?=
 =?us-ascii?Q?NUh8xBTaCwgdgF0XwWiH3UGOG0AbhU3zG//r6EEUzVwC3TIcS0O4k7NI2zYa?=
 =?us-ascii?Q?3KZRU3/xW9hlyjOqGblCLiXrQEQEHqB9gLntxIgrPsYd8vL/6oPZtSe1Nc1W?=
 =?us-ascii?Q?3sHpJnzYk6t954v+Zt1YEUmKS/CtorUQz+ZNJDJgG1GhSBPZd0HdQQELifLr?=
 =?us-ascii?Q?1XksY27KXVaiuSjuwafbfnc1ijIQJ+7gH6RE/iL0l/5eWJE7dwRfij0NMSJy?=
 =?us-ascii?Q?A/OrNszY0OCbAiThNEeOxkRxIMKyla0CtE2aUddgEoftPdPWns33RBnVH9im?=
 =?us-ascii?Q?NOS30+QzcflpmEkUJchwVCV/1Uiu03RVE61QxQo76ePdA06V62iF/mB6tXhK?=
 =?us-ascii?Q?2/vddP3B6x4KEnLGWCoD5w9vrtyozGa5X17R5fYHnZ2kUNVDPfyZczhO7FrY?=
 =?us-ascii?Q?DRf0jPRFFcW7LcuRDw4PUYEHcvvo6cLcoWwvAdogYSOa+gXS5N0qBUm+SpHX?=
 =?us-ascii?Q?R3PX1Qzu3QI7RcpJYiLjvY4ChCsZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:43:00.2453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d48b430-63a0-491b-8b35-08dc836e8065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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

refine gfx7 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 8f19b6ae8d5b..d84589137df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -909,7 +909,6 @@ static void gfx_v7_0_free_microcode(struct amdgpu_device *adev)
 static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -934,38 +933,38 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 		BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
 
 	if (adev->asic_type == CHIP_KAVERI) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+					   "amdgpu/%s_mec2.bin", chip_name);
 		if (err)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   "amdgpu/%s_rlc.bin", chip_name);
 out:
 	if (err) {
-		pr_err("gfx7: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("gfx7: Failed to load firmware %s gfx firmware\n", chip_name);
 		gfx_v7_0_free_microcode(adev);
 	}
 	return err;
-- 
2.34.1

