Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345F1C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDB110E56F;
	Tue, 25 Feb 2025 06:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gb4+gAto";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446B910E574
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsXPQeGMD/oVThQ0UlQ1IjW9Iu0JESbWcKU4UhvSnfQ/fup1I/xCXq+fmwdqhdxNPEDE4smrvC2wzm31RL30cRQ86ivsracypbYgdMIeZsYWvKfiOkd6UL+gHNJk+CdutS8CHa6OvttN6xvk75qRZ5SfoghMm7ufn2pNUUyZTkWASOVe7cVwlTZqd18KGn5b4xKrBQVeynrmfnk1bvjQwvn6bb3HuT6Z9uXmQmvrj/6TV0PP2BltrJjRpaRAl9SnXah5qelB9tZTqb5+aIEG9cC7yoGwl0DnB6z7XRaIfdYWN+6IEvs8lzECLIiUQ6ARY52ObafZtlti2EWl8q1Nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ql42oOPNvooQ0kZGxoZJFQfpQU1rAng4zIXniYpSDY=;
 b=xkiTH9/7cLvAXPJZ2VAXlRdzmaLlDgRPSCoKcO3Z1kzryT1pPK5C6hLCmPmsPW0urxmdQtl+m2dcSHnC9H0ylbYuWt7NTATmgu43sks82nxyA+7kUlj4/5ratkKKB+aq4FrYr1AqnKCYgdK96DOyhS/3Usw11U0OPs/pRBK3oCek/lVQuLRf9BsvJk45Drd3NOgg5+1GolOlVIbNCVmrjP0+gslMPvJ2K9PxgGqZLWj07+Rpmiq0w+IG3vhOi1DEu8237+eqiaKSJowVVrL7RwpOxvlDRfKzoYc9lcy4Wpyuvtd0T3IZJpQ6SGziHqNMCOSLdBh4PKFVmao+1ryjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ql42oOPNvooQ0kZGxoZJFQfpQU1rAng4zIXniYpSDY=;
 b=gb4+gAtoxqxV63rBSi87YKuXCZdTrmyrZpgSx1YZqxuBMRsIHcGrsSgwVOeK/9hV0t6wrvRhEjRBwfaGM67UuSo6PU28hJdAj7PerDYpU8O+yixnr/BOBmO5D9myM+Wm7xliq5YFBgooMWoFz8I6F4SV8fOlIMEScplewQ+P87k=
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:38:37 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::b2) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 06:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:36 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:31 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 25/27] drm/amd/display: Use scoped guards for
 handle_hpd_irq_helper()
Date: Tue, 25 Feb 2025 14:36:08 +0800
Message-ID: <20250225063610.631461-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: c66adde3-8b3f-4676-13c3-08dd556708e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uS9gK/WC6DRCcWWtMK95kZ2onOKZaYo0BjN6/55umojLRhSaXK3Eja05KKcT?=
 =?us-ascii?Q?oV4xLKiocYMMJReDTi6CV/ljWLnjyhlZXLegWN6AKG2OKTHV0ZogjdDw9pPg?=
 =?us-ascii?Q?JdbtNnDoo5FqG6h7LO3Q74bzFGMtci6+YJHr5VoAgLDs31XJuzIJI9ydG1Aq?=
 =?us-ascii?Q?EsDv/4R3i02ov+GcJ8L3bEAycqrfk1s5BttZS7qhmo3tFSkB4B2WAJ46bRSk?=
 =?us-ascii?Q?DEHIj6w1ugdEvAXFE5H/7Polt9TjiHBRl5NVMgSpFHZp4rkhFbg6Ae3V5rZZ?=
 =?us-ascii?Q?sQgELgo4mclKgr+npHirwDqdeHZqep13YgPusrXXgCzWbsvGDHy1TTz6gvrl?=
 =?us-ascii?Q?XrTVV934Y/59TxqEG+5sjnvNfiOZTFMArP/ZbP3upSoEr/N9qs/AlCAwoXBH?=
 =?us-ascii?Q?DoG9FyTrI9dPICH5MJiCpk5w7Nqax7HDuVDWb9G8EqYME+WvDlErg61/yNW/?=
 =?us-ascii?Q?8Bwnj2oiEd5Cjtn17hmQrRBwxOhigbvyQjkIJba+3R6dB2OtaCGE9+vj4w02?=
 =?us-ascii?Q?unLYtTAjNh+MfO0++KF4sLpg14QRDJzsQtzcbghdHS9mS24hsd/l3DW32i8u?=
 =?us-ascii?Q?FzoL4Jw3FTp/BWyPynArRZmpqfnzVhIsVM/Uo9bdFvyzzKVhf5k1h6f8dxYN?=
 =?us-ascii?Q?K7/zr246Fqzs9thJmttE7I5sN1WnxXNy3kJmtbM18Qm5xbORuVWHsB/A3wcR?=
 =?us-ascii?Q?J//e/FUVYQZeUtRDOeQogNHNSiqGHsHFX+E+JTm+FFwKNK8sjgFs5e4rZz0M?=
 =?us-ascii?Q?A/8y4c+J1Bw97BMA5KTiabDkTPc+6pDFVjxrrAQXaibXZKQzNuB/i/Bgimt8?=
 =?us-ascii?Q?45dCzJb6xdUd+aVJ7zYxii+dOgamQ646oMb4gy9a+hUx9tnmF9Ebj/ja8rxr?=
 =?us-ascii?Q?w2Su26Tj83VbVyqg9+hCNW4u8nFfGPmT41x/hBUp1zmRnEXnPmsUGKD8iqkK?=
 =?us-ascii?Q?W+e90yat1xu3ieMyS0KUH840BrXhK/zYb3HvgS+FCNbe0Z+R60k73eq1zUwC?=
 =?us-ascii?Q?Z/X/P2aS1zDY7OSfAbK5sZmmEiWpH8tBH8LCihNQwHW7C8ERjbi/M7pMkM4L?=
 =?us-ascii?Q?+jCyoNDBvpzpLwveEZrHkR/LHFfTG5KOCnLAY071JkA6Ffhv9WJimRkLeaJk?=
 =?us-ascii?Q?m4MfqVd6pejdhLh949OlfisTU4hXaId0lOiR4koBSR2B9xawUtXdwuMRsNGF?=
 =?us-ascii?Q?Rey7IqkAUIr+Bx4rASXRIe5VgmrWdTt9r+uvqXEjLesblu1vOP/x4YOlIRCR?=
 =?us-ascii?Q?4vszN2T3FE/3nRRrf1tIXrf5LUcaTTQc1pbbtvY57QsbAy9Pr/kXIu3Rifye?=
 =?us-ascii?Q?9bmejbrBChU32BhdMHT30elS7nJh2d8BpTmBNBw7shPlbie6xHpKX7pDzqbn?=
 =?us-ascii?Q?7uK9nqM5rGCASMBXBlBgnotaYszmETf/J7BovueaSwX/Zu5BsPRVAwxGYwGW?=
 =?us-ascii?Q?wknlooL5ucDk1cBBr43tTscu+Mchna5olyNq5ermDypUZnIJGPOtLGzLr6Ed?=
 =?us-ascii?Q?Lo/zEcMYhToveRk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:37.3851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66adde3-8b3f-4676-13c3-08dd556708e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
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

From: Mario Limonciello <mario.limonciello@amd.com>

Scoped guards will release the mutex when they go out of scope.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b6fae48a9599..03b6f31fd792 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3805,7 +3805,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	 * In case of failure or MST no need to update connector status or notify the OS
 	 * since (for MST case) MST does this in its own context.
 	 */
-	mutex_lock(&aconnector->hpd_lock);
+	guard(mutex)(&aconnector->hpd_lock);
 
 	if (adev->dm.hdcp_workqueue) {
 		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
@@ -3829,10 +3829,10 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else {
-		mutex_lock(&adev->dm.dc_lock);
-		dc_exit_ips_for_hw_access(dc);
-		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
-		mutex_unlock(&adev->dm.dc_lock);
+		scoped_guard(mutex, &adev->dm.dc_lock) {
+			dc_exit_ips_for_hw_access(dc);
+			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+		}
 		if (ret) {
 			amdgpu_dm_update_connector_after_detect(aconnector);
 
@@ -3844,8 +3844,6 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 				drm_kms_helper_connector_hotplug_event(connector);
 		}
 	}
-	mutex_unlock(&aconnector->hpd_lock);
-
 }
 
 static void handle_hpd_irq(void *param)
-- 
2.37.3

