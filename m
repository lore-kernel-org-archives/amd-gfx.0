Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3485EE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A6DC10E79A;
	Fri,  6 Feb 2026 14:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VXULGdb6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3190710E798
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0rjVK4dvr/YQyX49rhwlu2UtG3FVkCzRurIq1qdHklKJ3XGHs86ISeTTCv0GEfq8aRaqTjLc9tVxOzWyJDcxXkK97bhWB0HSVyY1IVazXWnuMJWRnMzpAB2PvDPasYQ1rVQcUMiZ+XLthktjS+yZSYHvfSLGkb7msuIJMSdG/1OcEIsCly40wA9wCf+mxov/bkoC4MDz8uqxTElJ8pVvREjz32mo7Brl5cHd22nOVfaSlG3QjPPQD0Oy7NEfqymj8ydVryDCdtTxbINf0MShohFBHiizwHg3ND72W5hF/5IrOaRjhv93O0jYhsIgWdFmO01LPXL6BCFTEbq6F57vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=k1z6CCbIlFzphdBMsfaUvbhQaHANKPdt8U9ldhTUzaJyJaV6QCpU4cWDcyFLvdZ4ndzjDbwBUK1TPheSiDSEegBfp6IWZhHDybC2iTHPK3BTaXCPD91OhByMMQlNz509evCUcOTJw5xMJXzMDxcpD4JGbHJOnTGf+F+3H+2aTAXggyysdI2ttNmIJabhH/AR8XFB8szWcJRw8G6eyb2mIJCCP9YJnNLDpQ6wY5ZuG9F/AOTcWR+xUPEZrxCMOwFcDCLJozyzKgIvp1jIqU1tc8DY193qpxEXmzE9S2ShfOqX5j6oSxcA9hawuyBG7DkxdjLaoJkwV8WrZPBNYIxICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=VXULGdb6awmXo73UHdEq1U3M/R3VXegoKfoGYWLGWU1bUpigU2GpODcEsftddtBriTumr+qON+oF12djeg7ZhVnVIjX2D5JZzYOCZMuPPzKNnqmdGCXrM/RZL6KlngEOfSgsKhUg4par/kBAJQCDITDWNqcKU61ffGt3vlAMB5g=
Received: from MN2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:208:23c::29)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:01:09 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::ec) by MN2PR18CA0024.outlook.office365.com
 (2603:10b6:208:23c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:08 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:05 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 02/11] drm/amd/swsmu: Add new param regs for SMU15
Date: Fri, 6 Feb 2026 14:00:39 +0000
Message-ID: <20260206140049.105294-2-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8316db-4c71-4d9e-1de9-08de65882dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+CjOurV1HEZKFUDBErB3+RUX8TWppKtXL+y1OcMNB9sBXpiFl+oOOolrHBxS?=
 =?us-ascii?Q?+hLyBlFdGbO5APNLQ+Ks59usxiVMA4Ujg379SHGhR8QnqOb2XftrLLDKDa+5?=
 =?us-ascii?Q?fO1hYJWND/gzx2b4F9fmiU+86FvR1nyALZO1CVemAl5ILSqj2QnNK639V2xC?=
 =?us-ascii?Q?fW9/l5XtC7b/N9s3Di2swfCQdlVd0wGJ5mV1oAR162n4f/j3dWOfdTK+tfK9?=
 =?us-ascii?Q?c3x8/cW8sNz5UJkPBWOgw2Q2tWBwKn+5673hJxcGVnHd7Q4TD0SIi+BzgFvn?=
 =?us-ascii?Q?M5l9aOCo0I9q7MpfKlWRDnCc2Iz7hXqOBYBalbCUSPGd6yJkbBWDcfTQztm2?=
 =?us-ascii?Q?RuLeN79mSoUuOCZoUPpJPiDUMKodcQT8sm35cT2S3iiz2yxY0NrHflsEzDJe?=
 =?us-ascii?Q?ZYwXCxrFVYrYo+WXVMuWPfUgXtenftIREHZhGuO4MFLub83iDVwtdQcCfg20?=
 =?us-ascii?Q?eRfsF+rHsteI/r1xFXWf1DJsOfBmFrD9/AHuOAfJXGWpf7n3i5Ma1Sdhjb6K?=
 =?us-ascii?Q?z5+Eu8TR8KWD6VgMLadqGcHmS5J1QbIpWgB6kRzj1FYi0PlNnSPgXfaABRip?=
 =?us-ascii?Q?X9sKWmQ8OpoMxfYo1/M9Yhph2uSuAqmEo8mF144GSboNNDo7m1GY99LATkxh?=
 =?us-ascii?Q?97Cqctn3QcG0u5Rf1QgDT9ubLQ5Wn6UOFQte1sjlvhBqEWCTcNdyGg3og8lR?=
 =?us-ascii?Q?yLXub/WE/wq0Sdwh5XEW88OC/8/DBcdQrV1GypNqvSqaiijoYGuzPW05b1SD?=
 =?us-ascii?Q?EW1eY9nVcHERkuX9wO9Bb96UIdJLvsc23JIr59j4qQKW3PIr9ukGynnZWMmk?=
 =?us-ascii?Q?sOzB3tdwqndrSuiSZmZfCDuwycM+6BUPXeEwLBgZkgy7d7qKXTuLpnpjERUk?=
 =?us-ascii?Q?+Bb5rVZB5CnoipOVcgA0KIn2uoIBWwfDRwX91z6FenQ6bD5+uJLuSgC8o8ud?=
 =?us-ascii?Q?n1fcHil1l8UZLFLpbq3DaBMgl4rhYnf4EXqEyB0p2MtTgj7rwqH/byDp1tDs?=
 =?us-ascii?Q?bUJ6fhQZOsmsZ5fLerJ3PMqeoF2dXlDnYIS9RDBCQlfrSSGYwHz4YShYSJZ8?=
 =?us-ascii?Q?D1HD31JB8qu5bcvHP5DGeI83AeLcHmByPMUJ1c+AswYIgCxEAPHHkP1y5M48?=
 =?us-ascii?Q?3ZhGHP8Gjuh+gDtgNT+Jmu6RomAePNLRh4k+0+8LXx1oxNRN/hZD+ARS5nhd?=
 =?us-ascii?Q?fTMY96UPpqDtaaiBTgNIvi6e0KJo+t9ZpPJ5tAADY8sWvx3sEEGy5JnMbxfD?=
 =?us-ascii?Q?JpfP0C3hA1LybHzmWvRyEL8udVqOXuhWRAlGXP68tLSxtRqfXANxfZSV3oQJ?=
 =?us-ascii?Q?MNLh0OSj1HbKIbxblj/hC9Gn8Dm9IpPcLuX3CzSbcdOtEfZqRnmL2uxNO6Kb?=
 =?us-ascii?Q?SviA3LXxpcst0O+dGwjTMEOxhdXQUmpTymMcOBFZyBLvLUV4kezRbgY9GSfA?=
 =?us-ascii?Q?xaMr9H0WCwt+Tq48p37xCHYmlQbw0MRBiysGK3nga1l2pi2+6Aib/pUpB1uU?=
 =?us-ascii?Q?p3ACnaGwtWFSxqILOVeR4NtNHGHGGrDV9RxIGvCFCZ4GYBNwdP2DP9O7M/HX?=
 =?us-ascii?Q?ZYi2Bpd5haBJVvi5vAowmXgePx2C+/IIV3HO4oQSjEzze9x60P+OtJNH8Mum?=
 =?us-ascii?Q?QQyXqlA3dxomVPmw8z3nAlmrT7B0eyoxF+KJOljLIeQcBYlUuC/rpWgupnBn?=
 =?us-ascii?Q?PqCnLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RLetSMIfPu/jKvuJz27QVFVVAxWbr5zfalv+ZCNWfMIo8drYCeQR9vbFfIRALayU0tIjERai8nqiFM4LA0YGMQmSYcC/QW1s7YB+wHbAb6ij45PYsOQri0VzKGhDCxHkAsbD3kH8lMb3XaRvj3ZS23ikJ2MpbLdGJolYzCFWQ3fIqkFyfTVl4ihXvh2FaqhIcHn8JFw6GOsA2WldymGgdhB71Fx4x2gCniTzC5R7Myuyy4q7k0Cp6hsvEuAH2Qr3Xr+rM75lc5J63g29qKXCN8Kx/O1PpH3QIQS0Up0OeRkjeZ+I5DrPJhVLnPhl/w6L0kBMi7TsF8Jh+vobzD5OPRavFfEzP8MuzNErANSDK0sS7ecPAMinqmTRdqXjGKEBLffrY3n7dxeZWaXmhjrwbMShTDJF4AQ3pK7nkkMB3GmRoCW0r8WoJajtjqRVTtlx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:08.9621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8316db-4c71-4d9e-1de9-08de65882dcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

