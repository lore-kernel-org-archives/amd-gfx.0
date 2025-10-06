Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBA5CCD184
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 16:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D85F10E422;
	Mon,  6 Oct 2025 16:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B30t5s8N";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013068.outbound.protection.outlook.com
 [40.93.196.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E463710E413
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 16:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7WYck/WwiR9FwsyTqz6psIHF0EEy8QCH96w7HW+eHGO2nRsZb7ZlnXYtuPzjJPMLPs0g0iQRcgS3e0MJg85GebYinGD9fCPPDKIhbpgtoeTJtzS3ebqMpRLpjfG/yfvCtlNt1SwljnkeEy8jg7qJKwCis5LyUuYhpN1+eKOUTfCZYBpzZvio1rcm3u6/CEqgKL8yq/URih2Mf7uXSXUmcp/1Ctf+LmdKRcyD7H5TK1g9j6kCCi5Mr+9FPHXS+ZukXI+9in/clQ4YtXd/Tvz/82K3hFD+LxddQq9d4Ub174oaQ3+SqXTDXCi9eVDboR7ujdoZPMjOBWg5u7ewfMY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxA4w/zTI9hvpu3IZRmNQ9RF8bgBVRfmNQkMjtwtG1s=;
 b=tBaZIm2rHxDr7OMxVm4extCOZw9uk92/8GBY1ediYQADUu1PsklnfKIUL2OLZLCIYx+iBjxLPa3PyKfaMrCRj6dqwCAmGaqQv8vq9fPFyg92fGUUgY8GJOu7WWIyLrh4oIj9AKV0eN8cacF4mR9w1sA2mEN/7a/57dBkRVi8HAYmT7K9gTilNeBgF8VnAfQrX89qTSVbiey2q/fKJnj4cpIsXxG1JmkKxKD+54CS1T8tkoa2QVNnl2mX21k2dLkdnynV1fU42RIHMbtG8OA8SunYJG7wP8ETqzlrZEjHYh7o3jELSpF3fDWsNfWqjnk6DUsaRcRL83Ay+N3qxMJ6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxA4w/zTI9hvpu3IZRmNQ9RF8bgBVRfmNQkMjtwtG1s=;
 b=B30t5s8NHeR+jf2VTcazY1Fg12BhSz4g3EhYf56AI/o+wFhz0oF5eajMeC2Ec2QNMBYNx686pyekChJ/CJS3qlublmjUi8WVyoxmTb3PO3ry+yQXSwt7gnP2KHo6d96//SabPY1wcnunuSZ1+fMed4RHRH8fQm0gMLpihmS7TCw=
Received: from CY5PR19CA0016.namprd19.prod.outlook.com (2603:10b6:930:15::9)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:31:54 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::b) by CY5PR19CA0016.outlook.office365.com
 (2603:10b6:930:15::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 16:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 16:31:54 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 09:31:53 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2 1/5] drm/amd: Remove some unncessary header includes
Date: Mon, 6 Oct 2025 11:31:34 -0500
Message-ID: <20251006163138.17489-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006163138.17489-1-mario.limonciello@amd.com>
References: <20251006163138.17489-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 644c88e2-99ed-4737-e924-08de04f5dc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kUCFzM03EXUq1vcKLx7sCAFbRpRaNff+bMltESmxcV4t6I5Pbt2djgorVmjE?=
 =?us-ascii?Q?7l5QCHv0tBhAFqV5j9XHnzjjKFGfvo3fgQaeIR14D/+yTzZXIP6gg+zafyX+?=
 =?us-ascii?Q?1mMHnXwyf4M61YoJWFPppXEySRTehb7jmm09PdxW64r4dEQN0HBMsrlXy2we?=
 =?us-ascii?Q?na/9ubOOL362JG/eAvrvjecE6E0zEqtDHuEs0Vjs0gbKZJAtimH778gdZZIv?=
 =?us-ascii?Q?3v62e7UlnoQi8dBm/4NAYjQ1YCcVFD9BKgUG9OfV9/lEP2reCL7QYdFA2C5Q?=
 =?us-ascii?Q?kMDjIsYjzGWdx1bcLsOgk1QRXJo2CYolnopE3BasyTGXutJJqUUS+kcL6URQ?=
 =?us-ascii?Q?qffsONwht+ghjjizSDgsOTiBTBWTszYpvfWYnXECP3Gvwh51Ksi3MPhbstgf?=
 =?us-ascii?Q?i/2iq4qu0lS9ohnDJ4MGSShx/sj5wA28euWB2WLxhsOKZtBvDZdt4I9lnAzH?=
 =?us-ascii?Q?cRb0QMpChk6vqHuxk3lye4+25Nsl/eyKyDCHInYeSqOCZsAHIvvIKDlZSJNT?=
 =?us-ascii?Q?Xa2sPo8s4XFqBC0glmmPVqs4xjaYzSzF3ioo0mCKg62JvTvSTKpcTvNYKDMr?=
 =?us-ascii?Q?ffodprDOuQG5NUUUlfTS4w+kaKP1Uwt7Wi8DDP5bS0LbxF+PXjGJZRkkbMpl?=
 =?us-ascii?Q?lA77zofRIgixPtJIlLvT7Z9AFtRSIh+k1I8gJxnVWaKeltcoRZT12ENJJgk9?=
 =?us-ascii?Q?B5lC6e2NjHyNZQrsYWckFRDho4MONScT07Y+yOJtQto9BE5QGsDz5mgGvZwP?=
 =?us-ascii?Q?KKH/9cFyNBJu5CrQO3KMJlUUDQGWivv9RZd9fg75k6dr0YvBPPrViS77m1jh?=
 =?us-ascii?Q?F2ubo2hOhOmEthGIA+n73S2rPmJlP8o/GmSazF75e58moYo/Ndnb5MHy0iDG?=
 =?us-ascii?Q?uLnqlir1gDaVQyZqNEc6FFtptNKaFjRX6n4l5PH+nY1rGP2TJYOIZ3oDyEVw?=
 =?us-ascii?Q?vIrHJJNQTGPY3zl1StP7bB/K54zDccgl2MDlX/O8vsaZWZlWuojOEAUHPGmG?=
 =?us-ascii?Q?5OGDfYeF8JmbiLeIsy0iJYrQXd1+jZ68Jy8LlXEZMlSWKOyq2uXLlL/B4PnS?=
 =?us-ascii?Q?4wUQow6evrkE33rgoYyiFvZerfZ0FMBctopifHWQU5GZSwUZKpVaGc1UkfSW?=
 =?us-ascii?Q?qNWWyAXTQfp6Yl7EEPXjFgO/V6UvWJbRxFaxwl+f4p+wJ3gIf3hv0SYhA/vu?=
 =?us-ascii?Q?T1ho7PPJRVk43/iZ5g2P8w0jvEPq5jhSZc3WEnInVww8rV6QLluiRuw4r1+2?=
 =?us-ascii?Q?HbGkMAHmXINNPp6o+3rcHKwXsRrKoI2HDW358fAhlenYCPdwT/14H/XWKrNL?=
 =?us-ascii?Q?NT0el7/lnowtLvBd/zxQQWAmw2Sm6rPJ6DvqjbM94o2uFx6kgPqRoA4gDEsg?=
 =?us-ascii?Q?KzzrM3FOVkY2PDBbVSpEVzBwEywCRSC/xc0Bbf4avkGcdvn+/2td+1oLs+wJ?=
 =?us-ascii?Q?hrFNbijdPV50T5G6jNucmEGgKAqPZmLl1XZEmMnvjPkbYr+o9PQEfrGEw5Zc?=
 =?us-ascii?Q?YxCN3cCo1Ufx4cLDMIWTVPb6Mf+jXaX/ZELm1GWcC0ocVsnUiU2WZpnVzRrj?=
 =?us-ascii?Q?y19gUe6x/HW2YV9pSik=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:31:54.1301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 644c88e2-99ed-4737-e924-08de04f5dc44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
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

Unnecessary headers can slow down the build, drop em.

No intended functional changes.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 554492dfa3c0..fb595a70bbd1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-#include "pp_debug.h"
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/gfp.h>
@@ -28,12 +27,10 @@
 #include <linux/firmware.h>
 #include <linux/reboot.h>
 #include "amd_shared.h"
-#include "amd_powerplay.h"
 #include "power_state.h"
 #include "amdgpu.h"
 #include "hwmgr.h"
 #include "amdgpu_dpm_internal.h"
-#include "amdgpu_display.h"
 
 static const struct amd_pm_funcs pp_dpm_funcs;
 
-- 
2.51.0

