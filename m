Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958D7C54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 06:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2220D10EF5C;
	Fri, 22 Mar 2024 06:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yyOwoXxP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6B310EF5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 06:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj8qbw63ru2vYznqvOw+rwvoPcxYebzbyiqbG0rwdtgkleU6BAHsgFRKUbfXl001q1uOMVORx1u2/Dy4iLdfFWmrBES/ob6bpFGYFwfJNaSt350TfFNr7RL1V+WJY8TLkzyQGhgM65qnj9QWWqXOMgirMEXbu+tFrUOPu4ME+xj6pQjw+kcohYeAL6DiEMgjAj+al1CqNAvsVZFJf2rrWEafdWPdrP/Z6PReldA6ZtnFGmIlBC550gSAZDi7dL45xiyCu07ufaQYeO6fO6QyV34kPuK5zSztwV9r8em6yQ2WiQv7pN2oYXnFVOAdR50v2zl4bSVjofr2PGC2KskMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo5cPNw6AGOU1QBm6REnYP5WlO6kRH/ZcPEactTfN1g=;
 b=nzAsB6cD3shXouSzzMPsjVNrTG3lFuoW1KjFZyjUfc8BECAewK7OK6Gz6Hfpr1tzKoBk2j3Rp+c7oxN7Wy8kX+Oah66ogViQcmVDz0qHG45d/WZIpmHR6H4jmlfe6GjZyJcQqs4nEro+ooRiHeQkWHABNixwsYDj7DJuF494t70o1hy5aMzkFA7OwoW4ltlrU/sAwSyXNB3q++vQ81hme43I766pWLYhcpJ3mDq2CSE+KB6vkhW0wpippcZ+z69lrp9C6Nd/uGdaKhrrv0AvgPnfEX7D8gk6DFooEO5yssqmYtG9vax2HBcFnVFzMGAmqBO9Hn7TY/49rvLq4g4rAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo5cPNw6AGOU1QBm6REnYP5WlO6kRH/ZcPEactTfN1g=;
 b=yyOwoXxPsxT6dY36HoOUUeO8TcXYhbl07pNdhCu0L8jEARsVUSCQwuAUDVBH1nm5Ga1s8E/nivZ1YDPrJU3+2yiaaSVdqVnFzSuIYDNJHmey29VIaQ96ICmu+sESc8LgiXGboSLJCfAN2uEAsXNMl8h6yTY07im2H+jXJmj/9fo=
Received: from PH7PR13CA0013.namprd13.prod.outlook.com (2603:10b6:510:174::11)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Fri, 22 Mar
 2024 06:24:19 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::fb) by PH7PR13CA0013.outlook.office365.com
 (2603:10b6:510:174::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Fri, 22 Mar 2024 06:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 06:24:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 01:24:15 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix truncation issues in gfx_v9_0.c
Date: Fri, 22 Mar 2024 11:54:02 +0530
Message-ID: <20240322062402.4103007-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 52adbe54-803f-4f03-dc21-08dc4a38b4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TSYjxRUzpqxeOepSUes7a6rRD3SHr0F9s005PauPSaKaAE8dvEHqQ5ZuaFZam7pHST0/CHDkk1ryaF8L+Gf/2+h69r1NliFpQiMX7+N2Dy80K528asqknNYlhcN3mlG79ca7QGdKl+t1i3FuslgSk5ZIgw83gWPejqqP6ksRgk3GVXXUCUcSf1fK9mk9Cg9AePb2xDtfGtz7i+wiH1T6MpV/cTg4aiOjHQOzNS3Ce4m/TxmeU8g3b86ByGboV6I4SuKm8/RLimrbQW5zJjZhkYRMO1O/eAtbtCw8ZQ27+JdaelfO9Ql/TWGDoCYEB6Unb2y3e5cdrEUAR5uSh+avSEqqESeOu6f9x9lb5sex2Fi216ku/c2XEEirR1Qlc7TsFR9XIpSQXs+Oq1qcDAjv8tucopBTzrTl67B/nf/TFwxfes+TqhnKug8DbEwzINTzqc2NrYXuIU8BZiWl/CSpHeSpDdLP4UxRwIsFIr8/hJB8BX3Hm+zeuodG9xYDCy9CpnCX6wbbgGD5wc5QI325vTadflf9s8fRwFvVGiweGWK6vhzicV5izm6Tiob8BIL3hKc3phCOcH45DfCjI5fAFGynePPW7ezaAYF3NAeFbeKk19qxbdOZf4v7xcHWrClsj6kpJd1OzMOtVohHkMyn5NJ9gAhE4KjerE/dGldBOVFcR68UT8quNSkrwWApfj1HEdqkPPELO20vNofQR4v+7gfGRr/XPjNw8KbKkxTAWUjJfL6SFytE02E0CkptTEc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:24:18.9675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52adbe54-803f-4f03-dc21-08dc4a38b4bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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

The size of fw_name is increased to ensure that it can accommodate
the maximum possible size of the string being written into it.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: In function ‘gfx_v9_0_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1255:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1255 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
      |                                                    ^~
......
 1393 |                 r = gfx_v9_0_init_cp_gfx_microcode(adev, ucode_prefix);
      |                                                          ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1255:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
 1255 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1261:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1261 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
      |                                                    ^~
......
 1393 |                 r = gfx_v9_0_init_cp_gfx_microcode(adev, ucode_prefix);
      |                                                          ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1261:9: note: ‘snprintf’ output between 15 and 44 bytes into a destination of size 30
 1261 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1267:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1267 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
      |                                                    ^~
......
 1393 |                 r = gfx_v9_0_init_cp_gfx_microcode(adev, ucode_prefix);
      |                                                          ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1267:9: note: ‘snprintf’ output between 15 and 44 bytes into a destination of size 30
 1267 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1303:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1303 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc_am4.bin", chip_name);
      |                                                            ^~
......
 1398 |         r = gfx_v9_0_init_rlc_microcode(adev, ucode_prefix);
      |                                               ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1303:17: note: ‘snprintf’ output between 20 and 49 bytes into a destination of size 30
 1303 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc_am4.bin", chip_name);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1309:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1309 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_kicker_rlc.bin", chip_name);
      |                                                            ^~
......
 1398 |         r = gfx_v9_0_init_rlc_microcode(adev, ucode_prefix);
      |                                               ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1309:17: note: ‘snprintf’ output between 23 and 52 bytes into a destination of size 30
 1309 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_kicker_rlc.bin", chip_name);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1311:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1311 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
      |                                                            ^~
......
 1398 |         r = gfx_v9_0_init_rlc_microcode(adev, ucode_prefix);
      |                                               ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1311:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
 1311 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1344:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1344 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
      |                                                            ^~
......
 1402 |         r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
      |                                                      ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1344:17: note: ‘snprintf’ output between 20 and 49 bytes into a destination of size 30
 1344 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1346:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1346 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
      |                                                            ^~
......
 1402 |         r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
      |                                                      ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1346:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
 1346 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1356:68: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1356 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
      |                                                                    ^~
......
 1402 |         r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
      |                                                      ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1356:25: note: ‘snprintf’ output between 21 and 50 bytes into a destination of size 30
 1356 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1358:68: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
 1358 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
      |                                                                    ^~
......
 1402 |         r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
      |                                                      ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1358:25: note: ‘snprintf’ output between 17 and 46 bytes into a destination of size 30
 1358 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6f97a6d0e6d0..71b555993b7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1249,7 +1249,7 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 					  char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[50];
 	int err;
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
@@ -1282,7 +1282,7 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 				       char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[53];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
@@ -1337,7 +1337,7 @@ static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 					      char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[50];
 	int err;
 
 	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
-- 
2.34.1

