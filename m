Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E422C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F33D10E5A7;
	Mon,  4 Aug 2025 15:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LN3ivJNF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1059610E5A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGFaDD7TKK1Ez1VpIfPv+PP3JdAdvUXY3ncBaRC44JogCxQ+Jr6U//TJiiwhGOoAx+wBiYlw2stDfUgm+7IM4U/SxGt9qogHF/LXkG3Ec4GZHJV9SSZni3IM4cuz19cmorvMOC/6U5SQYyCiJ+omo8fkHHX8Zda2sULuFR25gXZZprA6EgVlMq8gvtXDE6VW/9n3lJSdAjDgkXbAt99K//Zjd+g/ycVXX2rpX4f05HSYdHNZJzR89B9e5bdf/rjOKecPncvXvIHfLf7S5k6tfEv/XPFXO3XyBi+O8ehBYn6iM/WHENu87mHV5k7tqHnZ7tnvWXnXh0+dul9opELh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzaq3CWUF9dRxVVUk//M5KJ9HXPPVRNgmrsjCFT7erE=;
 b=jbzHeH4Q/rvmaOq7pSyFBiaANgws+2BFqHeLTIOO7+Mijq7e34jDLu2LXz8Z5ripFNSD6SDGW1mUajgUk18d5EAkiMuv3Ue6+bcPfgkMc7Z054YZwKsHozcqwuVNzwFRRuXlNuUVFtQoc71mDs2lDOJLNC6jeZIGK9B8rX6lvLaWSUoDHqiob9N82cCrfocY/n42o9HgUe5qNxIH1VASzIevOMh89nVb6B1Yh4UQ7ARMErZ8fK4T5rE9v+XM8QP0RWRVGg3gOE6vN1e76c4T65bday+KJspIU+bnahWswdN5JYAVaVVkEvHBPLuFrfXwEdDcRhPloMgWZnf/tFIaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzaq3CWUF9dRxVVUk//M5KJ9HXPPVRNgmrsjCFT7erE=;
 b=LN3ivJNF+xYA3wdgoTadkxa42hbbdArsPSwwmFwHSrlwBJVMvFMxBrr/CTRTUPy9LFBjEj6vhhlkgWb78PCrNPTz68Ajc8q64bqfWZyFyb8Nn7A3Qo8yRURXZTLZRJP0vXKsiS3LJE/3ZtZ2lD8HYQ6JEdzuKSBUehlChH1dTEA=
Received: from SCVP298CA0002.CHLP298.PROD.OUTLOOK.COM (2603:10d6:300:14e::12)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:43:26 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10d6:300:14e:cafe::fd) by SCVP298CA0002.outlook.office365.com
 (2603:10d6:300:14e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Mon,
 4 Aug 2025 15:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 15:43:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 10:43:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add missing vram lost check for LEGACY RESET
Date: Mon, 4 Aug 2025 11:43:08 -0400
Message-ID: <20250804154308.1173304-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 457ed3d3-7f23-4ac8-c150-08ddd36da66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C4RosCpwy39C6yJRgrX3q373lhUoli+6XnkgKF+reZoa9Lr1miIA9xjTCs6R?=
 =?us-ascii?Q?r4q7fYDTAGcOdAGXIjoLdbsF8yu7srFSxzYtM6wlolEUCuCRhUMH1/f79CH2?=
 =?us-ascii?Q?10wedIbZvPIr0lyFxBJ5PBB1g7OyyiiW+gjaxQBhTZN53GN8SdiZlQmXDh80?=
 =?us-ascii?Q?SOCT2Y+aSGPUa8SpCEpT4iyuGrk3mXspZUQTUA0tL81vm/oxGJP3MeYsINuw?=
 =?us-ascii?Q?YqTqMtOG9N+DO9yWyAMKkj+vVfyZS/Agp4CdWun5igBh2+Ui96BFAjZZxDjc?=
 =?us-ascii?Q?b5n5CkmWJR+A/uG+jQVA/POvy8xsTCZJ0iDW8Oo9DhsmODjHBUUZ9z+E7gAM?=
 =?us-ascii?Q?DQyOE10zBnqwMPQUXhWZlsUb5osT5WNqlPrD8aycX7Ew1/6Wzz+ziKfNelDx?=
 =?us-ascii?Q?3ATluTWGhV2DCN7nBMilQEWCYN9dI+iFaTVkEer0CHIMuOvZV3rO0SO5Ae0h?=
 =?us-ascii?Q?ZpxXF40eJ7PfHwHWwAcJ8MNrZUvegbmbwTeCBxwNg4j9F5HFjCJhWusv+SdB?=
 =?us-ascii?Q?8f+cRHpHGjYJ7aIiGABihfTsbHy1TwPQFWhXqSMkJFswbBcjNXUyx1IdUMsf?=
 =?us-ascii?Q?ytHMZ6ib4Uw5q9jseqp0vH1MCWGDG5vf97IR/Sx0fz79746lNZyJpSlRavj/?=
 =?us-ascii?Q?PW93FbvZfikEwm9C6fJKCX6k+y97PTUs1fKfeFIJZedQiOtTLsvcNq3dQJs1?=
 =?us-ascii?Q?x/50nq5RfTzZayY9Tie4osH+a8ZHc2Ys8xP5myYbYxCwxV1QiSSObpzKSudo?=
 =?us-ascii?Q?8RcKfB5jEgvsotNdThDLsYkBapNj0DkcARblhQWUJDVrjo2nUkzP/CJozg+x?=
 =?us-ascii?Q?hMF7lW10ptpmuSCug48iWw7YSrZE05QwlpqlIsB6urALbE3OxSzozy5p6mIT?=
 =?us-ascii?Q?T8f2ux07K2xxwmagw8soyWbSCF1GP5MkRxSdvJ99DnZl925rSewwVpjiIIgo?=
 =?us-ascii?Q?olPawnIUIuXRNUTTFp8PrImI0qaWqLniOJdYLqVY7Fwyxv1tIv6kpzs+wAZ3?=
 =?us-ascii?Q?zlf1jQiDUTuDWTVu71IxdOoEPfdEsBxGg1/spYRojtt5TfKiOE7m+ZtdsQ1y?=
 =?us-ascii?Q?tESlsDeFUEKj5f+r4JpvoFL5K4pT2PMDDPal2740xqptXAEgEqKd5V9p7+sf?=
 =?us-ascii?Q?SkBQkhjnU/JkPAYOFy+l0O6ApSYF4eEeopkVW0VMdL42oqu7T2OQ/GBZ6CI8?=
 =?us-ascii?Q?lmwBv72wtJmY91tm4vPn5D4bjoPqTsHdLzr83HBBpRx7tDRMFPM4fY83WQBW?=
 =?us-ascii?Q?0TkB9bLtJvXRbmmakE18oDbQfzftmokjv+mYbiJoy0+bNy4ggFJ+EA9lqIk1?=
 =?us-ascii?Q?xO+KC/ywX9/ZS2CeWLgMx+OlUusmJachaFCynXpIMJbWIWo1y0qy5NTRZ6QJ?=
 =?us-ascii?Q?JfqRscAweAWocqeOAy3q2375EnPsU7XugheayVXBTCwj+GtFQJXdEJgaobtx?=
 =?us-ascii?Q?a4dMXogQvsic0RbngpFKGsIcD3PgwMBLGk0v7nxh94XBflQJcRyCmQ/BSlSG?=
 =?us-ascii?Q?TNxlMIvihHwSH9bjgIcqhJbAdqRafRHzzPI9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:43:25.2030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457ed3d3-7f23-4ac8-c150-08ddd36da66a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
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

Legacy resets reset the memory controllers so VRAM contents
may be unreliable after reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3fb41c42cc051..6119302aa0661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3274,6 +3274,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 	 * always assumed to be lost.
 	 */
 	switch (amdgpu_asic_reset_method(adev)) {
+	case AMD_RESET_METHOD_LEGACY:
 	case AMD_RESET_METHOD_LINK:
 	case AMD_RESET_METHOD_BACO:
 	case AMD_RESET_METHOD_MODE1:
-- 
2.50.1

