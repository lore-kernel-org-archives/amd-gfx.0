Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D61EE208F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF6D10E083;
	Fri,  6 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y0pWmJsb";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEB110E083
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kF/vW2AhPqHmPKmNXzrC49gmojxH4qJWumik1VNZ1fhSJoaCnArFKDY3u0Xut4q2Lg4qLdOKqqkuXPhFjb4QJQ95cJ0qdBhT+AnNWpt0SG5wHw+jpvyrfmuq1AdItrOPLrHyQJzTPKLuft1n4e+itpeXlJNTJXI00pnRTJi8G6ZNF0Cz0FtUfs8bOoMyn2MzN6YsXPSrS3LX6XplT2Duo0KHZBjMXzNhpm0LNvWu7ajzBLo4i3J9goM2AwNbTuKr0sT8wshh4e6EhhhBZWYH6hTvWg0tOMjaDIoFbwdXDLzokkq50a1eEcxq35cvDV4TpSdnT7cEmwAjLn74LOrsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=GmmNPx17HejqBSx6GHaw2ftgCcECbBQQjCoS294eDUYWOZ8Ik1HDKXSxj+s6xWi1zIwuwSOOEGvEVs+5B/h1yugNsWfRdzkL29gdmajtKap9rl7DbMuY9nPSqkMulnEIf2/2PoIEOpRir/xIIYPZ7gNTW7QaWBwAh3i2vHtxoMj59kf/BN6sKYsixurhcw9OdXSctBaKthsD3DPVqbrAVW6NVrqhQ/eH8tiXLgk6m8n4MOeIcN4v7qQOzun/2UNyxmYOdVfCXMqyas+PectZ5XG9cnOsoB+99U8fQgnMptk00WmLGbZtI1TDHm4bqtb380F7sKaRCtIzeIViZvRhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=Y0pWmJsbokERw5rcHV0/zaQRucqaJ9FMTzfXteTijoK3qETRcjNh/f9jEdGOrh2i8L+qZnWhdYqgNF3h0KBkaHNC8DSPmgqrvNIR79xBOZLKaREAvkVMZMs4nbQbpDSLTWrpHMAw2A4+8CETs6GlVBbLlhA+A+utftNfc2X/tuU=
Received: from MN2PR01CA0033.prod.exchangelabs.com (2603:10b6:208:10c::46) by
 SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 11:25:12 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::6e) by MN2PR01CA0033.outlook.office365.com
 (2603:10b6:208:10c::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 11:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:12 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:07 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 02/11] drm/amd/swsmu: Add new param regs for SMU15
Date: Fri, 6 Feb 2026 11:24:40 +0000
Message-ID: <20260206112449.45381-2-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa2867c-5747-462f-11fd-08de657264de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4c5u3yM9qA5IsbKuZ7dEMVgh89XQAEZ4KFSgcUut289zPcOia5P4N78VzpRa?=
 =?us-ascii?Q?kHufkZSxhvp45Ya8TB6ccEqrHe/eJombgWOvnmSbBdBzhwm0mMyt4ZRBXBIY?=
 =?us-ascii?Q?SAqR6cEtIfC+MyimxPQjrmrkFWlopDM2yTZ1Pc9qbRc90dviCaJng2RZRjSQ?=
 =?us-ascii?Q?BWDiqCNbKLSDkBIRyV4cGxIEbqnjUeGHcVJnb/XtGHnNSZxOn6j+DCPnrs7j?=
 =?us-ascii?Q?da4ylp/sLmcoBRdEE2KcF9nr4nKTaZDrkpUgVYPeZ+fTZCGw77SLbAs9fCIr?=
 =?us-ascii?Q?1M6jO8rOrD12XzNsO8nLGupCmU2FE9SvhzeJoh5CdPRrDW8VCS5cogsWT/cx?=
 =?us-ascii?Q?bUVldoavfWtj0NcGFFffTeG1cz68Hn+Ac0evV4Q/kc/k5oJ5081D5Q9QK3Vh?=
 =?us-ascii?Q?lBMf4pVyIR+AyJcWvuvN760Fsd2Bmzz0CsEmFaOiFkBRXOfn56bMq7xfeGdS?=
 =?us-ascii?Q?otOSr37Junjr9TYaFG/pSIxOCVUqWoq6MQBpaHAw0WlFuZRzfxa2UaB5s/IW?=
 =?us-ascii?Q?gXjxdolrObzxIS5tT8/WevT4v3e45fxh5aGAZvk1N1hnDU5p8W0f4QGJAo6A?=
 =?us-ascii?Q?5MmA5GP/lt1IXOrbF1IL43tuAIOtqKUiR+lCmCyfN8dWMDAOu8k33bmTaAME?=
 =?us-ascii?Q?0ERcw0qL9HFtRCvoSUrHxyOQ/F5VmAGl/XqpV8w4cjGaSGmDkRhQbMbJtshD?=
 =?us-ascii?Q?TWKiyqqKcHJWVdrQZwZ3eO1sXlZKJJcM5FdkZMpNM8U38g3GMDH4rhI/q1TW?=
 =?us-ascii?Q?nVSsNF6YR1z5IQHnczzTmMPOjbisagHFwN+jZt/xTy9tzpq03Oim6aFR+Lh1?=
 =?us-ascii?Q?TcXU3WXEBDhxyGjkGYT0XzXp1VCZVRHdCFUEEw6O80WW3SYQVlWUsxSI6C0G?=
 =?us-ascii?Q?TjU2wuTJKAbFjCEDtxoCuFPYoDaERYW9mdvGz9OD8Ck+zvfHKWLcaVaNeISU?=
 =?us-ascii?Q?GfIVTitLiGKRd3NerNpnCEDzj8InePEzc98cVylNkPPi+Ct+bbs1lhLaVQlV?=
 =?us-ascii?Q?GLATK+6BWbqPSzixIRa4VcwA5H3dekbjKe7egWqxUCdCYDSSDCAYnrPFE4DX?=
 =?us-ascii?Q?zRzOgWxt9hpSVCNR64SP7bwekoSicWqxRXOOF/5J5nNjhHCiIAmVEFxAL2X0?=
 =?us-ascii?Q?EzxKT+2aTirfUDhfntb3CpqTxc6bDW8jzxCSY+jsDE4vAfHPoRjygSAelsdM?=
 =?us-ascii?Q?iI4QHgRqfqfy8apNrgkIGRLv284W7OqR8k2NFOA0HCMYhf+0vA2m3Ruqod/S?=
 =?us-ascii?Q?t1mJ64ojP8lVrID816AxwcgRuxra+HUbaRYW8yII2DwIBLZkNUQl90O64d0e?=
 =?us-ascii?Q?N2l9wypV+tSJWadYXSWBEBWSDfm25BttQHd4n01TFOzRhizDFaoszBb0/bxt?=
 =?us-ascii?Q?h8yNzqr7e8/v/Mv21udfzTf/pO0qsOMwWPWZhWZlDZnRaI+j/fZPIkUb+Ewc?=
 =?us-ascii?Q?BRCwqPM88DP0gOO10YgYJLpSpIJzE4WzdDh4DXyOzWOjvxTa8mVpz+QGb3db?=
 =?us-ascii?Q?UMq/illNf9D3F4ZIxb8O+0E0Yjs0I7eoeMUEqblnP/S62c06MJ9TJfGQaBe7?=
 =?us-ascii?Q?5m0xXUTSerq54Ta63tbhH0sdB3xSi8AN6S0b3+zLJmY8nzDZNBZrlyGwDpZD?=
 =?us-ascii?Q?UUIkBA/U+QlHiXDxuLBeV3HKFW3+i/WpriRxP8ZgQ7YkK8MaTwM1F1MJlAVf?=
 =?us-ascii?Q?JXApBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c5zqeOH3l7DQofVwIMITQV0msqIVdaNNwu2bPE7Mvfbq439J3UjryRlvtQngywDrivRkQ/2zJ4kdKqtNUyhb4bo0XJXSwiGBhMhGRj29I00r1y4Ri/3rCNKe1WaxsCJIitobsaLBL27SXYQLdKOZKedTzUl7DW7/Z3kqup1LU0wkj9JXNslDKZmoaGcCCE5jgD6Nou/lHaxx+iflGJG0+G51TO1KKuYhsnLhXd69yOpRbVWkOL/4TaCCJsMEqODJSeZoOMVfCq93Z7Sq9sNWKo8+z1QBd3kaJw3tUDL3QIPhCf/7Al5FZZddSde2MIupbVUD3g/4MuT4PG7AwB2wayB5sADAtyumgNuStkaSu4siw3ZcXiAICXk+Boq/pDFSfj/R6N8C7K4nLd3e6q9JWY8BOyFZJHIyLyeEkZ99bBQX7ZmYnskJ+B+fPMym3sDt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:12.5768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa2867c-5747-462f-11fd-08de657264de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
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

Some SMU messages have changed to multi reg read/write
Initialize during smu_early_init

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index c3f22844ba2f..d58b0bc2bf78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -52,6 +52,12 @@
 #define mmMP1_SMN_C2PMSG_32			0x0060
 #define mmMP1_SMN_C2PMSG_32_BASE_IDX		    1
 
+#define mmMP1_SMN_C2PMSG_33                   0x0061
+#define mmMP1_SMN_C2PMSG_33_BASE_IDX                  1
+
+#define mmMP1_SMN_C2PMSG_34                   0x0062
+#define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
+
 /* MALLPowerController message arguments (Defines for the Cache mode control) */
 #define SMU_MALL_PMFW_CONTROL 0
 #define SMU_MALL_DRIVER_CONTROL 1
@@ -1347,7 +1353,9 @@ static void smu_v15_0_0_init_msg_ctl(struct smu_context *smu)
 	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_30);
 	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
 	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_32);
-	ctl->config.num_arg_regs = 1;
+	ctl->config.arg_regs[1] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_33);
+	ctl->config.arg_regs[2] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_34);
+	ctl->config.num_arg_regs = 3;
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = smu_v15_0_0_message_map;
-- 
2.43.0

