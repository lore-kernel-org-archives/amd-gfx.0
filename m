Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD55C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 08:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB6410E79F;
	Thu, 12 Jun 2025 08:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bxjQoEzR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA0510E298
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 08:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqTacWFvgDBu1vcz+It007fC2VQD8bfjY3MvaX7jdLn+3ozqjD9BnCFrA4xXRkLJ+YxyPbz6p68I3sUybPaPZ4pWapitUCqxPNX6N7STCO/DQvNpGJ+o1oHd1Q9q10T2DCHJj5Z5BE/w731NUIBXLZUuMkZOW53Kn72njKUVxHZw7l6jdGd9Wxey7zilUOflu/oKW934rHfEsCHnwcbiV9wQG+OIXCTBbfs7x4GGWWffP2a0VHOm3yaZ72TrSsKvTB4HuYiI0QJBRb0yW6OSv1wOpfoK0w6YKtqf0Qu6EWXDmS6sVYZR0OrcQmXszKiyLWPJ51KFcYVIQLs0QCNI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnBvwF5iCRk5VHFZ/IAAjX2NBDpiOVmwhXVpIkrlIUc=;
 b=Ce57k3qzqieCnpJlzTregXyRJCOnHnb90FkFPw4xGV1TOHyi3lks52UQO0EGBGECmtf5+2xW6mVuB4g1t9aaWve8Q0ZRGFEKTUy6914WT2lJgx+GXhZc3mPVwBDbltN6XwFKCT4qhy4uQZlI4ksjs+XJMA+HZU6BPlfHVl9Jp37e+Rl6zA2xfipVIaYON1kybNvVKfJY8tDPhYiU1n2hAR5VOfSv0k+d6xT/S9GUEgq62I/3ELbYM629eLYO3rKXM1JAGjPHZXG7MYJywxbueD9DngQnZCQHaLcUhiz3yRgTcrAKv4q3h/vUnevqNqLt2+DXmd6DrAfkfmEM17I23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnBvwF5iCRk5VHFZ/IAAjX2NBDpiOVmwhXVpIkrlIUc=;
 b=bxjQoEzR5RMKsRo2xMAvmDGlVelWDrnGndrfGQ0qP+UgmhRLGcX7PJ8+IhV1pgABokfeIcZwlKN1gFV0WbcbGr4IGeSQahKvXrPSd8CagCfRYGavEbPghKx68y2p/aK2r8HWGpc7GF0ZjtTDnlrGtlLXNCaX3Xm1SWzTEUMMgl0=
Received: from BN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:ee::30)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Thu, 12 Jun
 2025 08:20:16 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::b0) by BN0PR04CA0025.outlook.office365.com
 (2603:10b6:408:ee::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Thu,
 12 Jun 2025 08:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 08:20:15 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Jun 2025 03:20:13 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: change usage definition of
 amdgpu_bad_page_threshold
Date: Thu, 12 Jun 2025 16:19:43 +0800
Message-ID: <20250612081943.183189-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 71647cd3-9f4e-4dd7-317b-08dda989f596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uXAtyaifeG0ahYT9rw+Llt0f+2zVhBYMGa78FMlL5KLsgxwXg09+ZMmhyp5N?=
 =?us-ascii?Q?P75tqHQ7Bd6ZSmB/HkPhngPsvqvWFfiJcQzgmlBPGfgGB7kr3XriRYlpTSrA?=
 =?us-ascii?Q?0ZCjxv4LdqS9wae4egXilAWnvbMepe8aSDfWGwCYjBa5na2quPCjyZDLUJP6?=
 =?us-ascii?Q?8lMON2MH3GoV2qXco9PFypS0+fiuh15HqEy+XUJlB3AFfdYZ7NcUDG0cH8+I?=
 =?us-ascii?Q?r9BRe5TC1F3z1gHCH8M3i0OdgQkXlI8TNYBDhv7HT87x+xiQzjYOXZoYSR2x?=
 =?us-ascii?Q?4KgCC9Vls0DysiW+dpcA8L8l3oCcvr0YFv1VDiZ13rYH+q1imcFoggvm8ded?=
 =?us-ascii?Q?4xwzyVJLoj1+EZppP13pTpN6wCYb/WHZRl1UQsBZIf9QPWMX3Ht3i3NAr+qL?=
 =?us-ascii?Q?L3IuiThn27jLF2+5o5KbPETtRqA+HneoXNmBwaVVsZmtAvBavSuao0VSiCq0?=
 =?us-ascii?Q?MdFx87KicgAS486PmQjTgvRUIUJS/OLL2WEajZYofIvTG7tezXbmd2yCwCvr?=
 =?us-ascii?Q?29kZkxZJr10FGS1CIpD5ckuYqynY+N39oRxIyF3MaEsxINu8ncyoOoPmHtYn?=
 =?us-ascii?Q?VWaNSz75wIrAVLlQloAvlLzXTmKNfRsGYVYcjl9WOk4C/ed00XZv2IzFKl1v?=
 =?us-ascii?Q?uus9tRNwFMlv1ZG0B/grKe5ptKjd5yKUsfQzsavdRBt3/JRxD0uhj2YDRD3r?=
 =?us-ascii?Q?F7GyP9g7w81E5hLECON2MJASANAfCtp1NZDwQeFA05BOkFwItJAAe3SmsvJG?=
 =?us-ascii?Q?nNwBxAYg3x0i9sCYbV2O2X0oNr8ca6ZcgsKAT1WSn3bTKvluS6+5hfGRJSYr?=
 =?us-ascii?Q?RWBImhe53WFZNc8U/CDRbz4RD445iYHJDxdOjB+0Qf0PE3RESEngtHGc2D8n?=
 =?us-ascii?Q?8joCL3txfodhqp3Lfhs4gmb9MYn8IdirbMA9uZpxS1n68V7kntzvpg9Hg5ES?=
 =?us-ascii?Q?X1YGmYONbo9Ud/moPPAaEPhOiS1C19QaO9hY8ltvHxgrruLjHFqAZmt6DuVh?=
 =?us-ascii?Q?kYUhbiESD1ZkUHBUpyVJG2IkLlYb6Qf/bSgxMoY/cZfLcDPEsu1pm0lWCHfq?=
 =?us-ascii?Q?EkBllQ7apoNdxMwxJioSTfy9Payodw9pBx6wj0SZlQhf/kKInkPXf207srfn?=
 =?us-ascii?Q?wkYa4mm6vAdIRtEvYbKZXPENEc3KS8KxNCXa9FYRr7TQx1k58Wc4GYTBXSZx?=
 =?us-ascii?Q?hbv19D9mbZeceW500jZpoGWAkGjr38pE15Mkeo6Dfx+Ln1dB4DHIHvRwYeJP?=
 =?us-ascii?Q?9n6VFkjHkWGS7VF2D4O2GQvEVFbKRXstCn+dHp8MKj15CFWx/tWyef4bWYKr?=
 =?us-ascii?Q?cl5wFssWTgRI2z8C8aj0SyfLCCycxzvNURj52PneSlzCqwjEP12kYu+aWgNX?=
 =?us-ascii?Q?mT66rMW/bb/bskM9F4w4DEO1PfHj90DX0QbQvBiXR7U+ZKbmJHgRIVVuMj64?=
 =?us-ascii?Q?Y4nrjlVFyB74p8VcMCpOCth98gFIMj7lRfBY2KKtkGPImaU7hR6RUv3+LHa6?=
 =?us-ascii?Q?1xk5ZVMyG4zaa/568c3eGgi8YanA6+Imy0lj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:20:15.1915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71647cd3-9f4e-4dd7-317b-08dda989f596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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

when amdgpu_bad_page_threshold == -1, driver won't write BADG and RMA
when amdgpu_bad_page_threshold == -2, driver will write BADG and RMA

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++-----------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9dfef13babfe..a1b97d516a27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3161,7 +3161,7 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	 *      which is intended for debugging purpose.
 	 * -2:  Threshold is determined by a formula
 	 *      that assumes 1 bad page per 100M of local memory.
-	 *      Driver will continue runtime services when threhold is reached.
+	 *      Driver will halt runtime services when this custom threshold is reached.
 	 * 0 < threshold < max number of bad page records in EEPROM,
 	 *      A user-defined threshold is set
 	 *      Driver will halt runtime services when this custom threshold is reached.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2ddedf476542..50a6e975addb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -568,8 +568,7 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 		if (con->eeprom_control.ras_num_bad_pages > con->bad_page_cnt_threshold)
 			dev_warn(adev->dev, "RAS records:%d exceed threshold:%d",
 				 con->eeprom_control.ras_num_bad_pages, con->bad_page_cnt_threshold);
-		if ((amdgpu_bad_page_threshold == -1) ||
-		    (amdgpu_bad_page_threshold == -2)) {
+		if (amdgpu_bad_page_threshold == -1) {
 			dev_warn(adev->dev,
 				 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures.\n");
 			return false;
@@ -763,18 +762,16 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		dev_warn(adev->dev,
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
-		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
-		if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1) {
-			control->tbl_rai.rma_status = GPU_RETIRED__ECC_REACH_THRESHOLD;
-			control->tbl_rai.health_percent = 0;
-		}
-
-		if ((amdgpu_bad_page_threshold != -1) &&
-		    (amdgpu_bad_page_threshold != -2))
+		if (amdgpu_bad_page_threshold != -1) {
+			control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
+			if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1) {
+				control->tbl_rai.rma_status = GPU_RETIRED__ECC_REACH_THRESHOLD;
+				control->tbl_rai.health_percent = 0;
+			}
 			ras->is_rma = true;
-
-		/* ignore the -ENOTSUPP return value */
-		amdgpu_dpm_send_rma_reason(adev);
+			/* ignore the -ENOTSUPP return value */
+			amdgpu_dpm_send_rma_reason(adev);
+		}
 	}
 
 	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
@@ -1508,8 +1505,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 			dev_warn(adev->dev,
 				"RAS records:%d exceed threshold:%d\n",
 				control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
-			if ((amdgpu_bad_page_threshold == -1) ||
-			    (amdgpu_bad_page_threshold == -2)) {
+			if ((amdgpu_bad_page_threshold == -1)) {
 				res = 0;
 				dev_warn(adev->dev,
 					 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
-- 
2.34.1

