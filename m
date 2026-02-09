Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8865E81BC0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6211310E3DF;
	Mon,  9 Feb 2026 13:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ijLZOlXq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA4310E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkeAw/J9V+/cf/oxd2ulkvZG7I8sNzFAnYBppSpEH48Wp39FGnTKcPDlYdhaY/f67/XI/VG6NVgw26R4IxHI+oovbrOu7dGtrB4B+zqysHqu9+Y4I+wFIgwAexoemYmwO1Au95STmw3i8DVRqyaxtIXEtTGk7x3VAUuSgJe9c4Uq8wnjRn0hSf6zFMl1d8aSZz2ObEOcYqCzMOKzoX0qIWqb5pTwYEseRpBKyr7z4EoX6ujQlFJDer7Gsv3GF5ag30FauPqarZYqauMQ5mcPWaKt7lxftKlL9/YYFRL8UvrvInyG7KfZ7sKduOEjcIV2nEi9Yznc1gQ21jlOWV94bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=OcEYvUq7EDP8pM+O5659FHhGzkXhmErCVAnHGvjqFekQwV3pSpKlVp72frkkn4I9dCimxlx/WgynABpW2w7/DTq2xZYHxyfqyBfKVzcQWuiZI9/9agyYiOzzEy1tLSneEmPemlq5AOmBmXavQ1nQ8b8EAfSCKTOvF4sCoNDkhShCGGbAKGbWqQYo7prIDHAwDqt6XVqLKK1kZQcBq0FCwCA1GFoZIP3d/xvWp0MpE8ej8nQuDwDsrgsV+YJCmUtzHgZYgB9cwmSnYp1MZ5NlrSnGdGRgGnHMvrRjD5yZ1Q6XwhfgMvb7eo0p/vSR3JoGfCLMS6G9jqrfB58D0t9hIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=ijLZOlXq4nr6Tou5xJkbZY9y6koZqwYudLam1BAhuKajhL+piAE+y57qKdRl5613f+Pzc/7gXTK6wyrr0HaXxtosnQJZkW/gmpw2urOGwP0SR5DccYzSSiTMAS+GKawDLZSfbqbz/vMK/vD0YfhFDVFqAYyrJ+ermxC6Li/hYJo=
Received: from CH5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:1f1::7)
 by LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 13:04:39 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::bc) by CH5PR03CA0006.outlook.office365.com
 (2603:10b6:610:1f1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:38 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:36 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 02/11] drm/amd/swsmu: Add new param regs for SMU15
Date: Mon, 9 Feb 2026 13:04:04 +0000
Message-ID: <20260209130413.118291-2-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: ea90a6e0-1558-4e6e-e648-08de67dbc83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yye/dFtnPRFCCn+AK/g8puCRykVxqJ+PC3Kys6nxJXbjf8OxIvtggR7oqIjG?=
 =?us-ascii?Q?wKkW/22JP2vFEgMVclCNkfiz/oXaIOEzE1hskd209H+t10eu9TAUygVqlpeO?=
 =?us-ascii?Q?uPJvIHQ6MkDC5o2d5LsOjDMBhOrNNMiS4DiPxWbEGgt8OT55WfGEzuzs6yO4?=
 =?us-ascii?Q?QM0PDBZ4fkfxdbgunrVTEBjZeYL1/q2DKmE1T6YivQ+vXqPWuJv1LfT0DacS?=
 =?us-ascii?Q?/YNIy8Q9XHqszTXNoiwUiij0+ohFo9jTrIVuJ6V50yUkKwMkpZG1uW4Hc+ri?=
 =?us-ascii?Q?kvSBU3qg5dOqfHZDiCTrB88bTyDct/BKyTN010dok7IpEgSIo4ytPIOpr6t0?=
 =?us-ascii?Q?7+Fwlqw61TwwvUWuJJD7DStelutLfjVa5ABZfa0ldRo+UQGVowHDR7BZk/2H?=
 =?us-ascii?Q?F4RxP7IHpLjjI6W2KCEqC+ukOg0D1Lrv4185t0S4jSTlhJ6AY3bw+Lvy/e0W?=
 =?us-ascii?Q?x/bV3N/nSs+YuSOoTDy7JJXd0E2ZPthb2M7c5kmvv8Fusf/9P6xsrC2kGcMO?=
 =?us-ascii?Q?dPbjfpdQnMWpjwAt6db3JGhfgt24UYByB7ePIwx4ZE2YVCpaAkXNioASbz5X?=
 =?us-ascii?Q?7AlAMXhLBIVT0Bkphe8+M2Ms8IKuBqQ+ly1lPtaNgxCFgQCimFcx/MPLOh9W?=
 =?us-ascii?Q?pRI8Fk/7u7ydWCY1KN85P4eTeWP6r5aqxfLL1GsH3Q5pqrDmmS5HLeftPiDf?=
 =?us-ascii?Q?Aasohk6Pc5vVY6U1JabToDkrEupRQg2Tl+LTRwZltYJGjaj/0vFSjuzT1B7y?=
 =?us-ascii?Q?0hsRGiu+SBAQuvHDlseXkfDuu7BgJ4gs0Er2Da4Pg06M51wU6fjvtMIjtih6?=
 =?us-ascii?Q?e1zEvquZDVhRCCcyrN835yvAr0NAmxj6h7hP7BI5Ap9ylmciJvW7dK3U7KZL?=
 =?us-ascii?Q?OpOHNHoXZNJHrjGfpsvJhyY/+30iyQPxyPsMbDxhv2G6Y6LuxrTdESJO3Nw7?=
 =?us-ascii?Q?gBus3S3fFEQDoewjt7jz3BQF8w5zl+Gmk7YCEGsENIa2qezmAKaTa0robkTD?=
 =?us-ascii?Q?vg/LjD6SfJ07c86TU8rGhEnxH5H4oneR9vLX7GxrqeTrnaFVQvR45ntqr5J0?=
 =?us-ascii?Q?235L+wVwmAS/GLB71jBdojGbtGMYo4Lr97OvNKhrEkh6CS/e7suRX+7gB97n?=
 =?us-ascii?Q?37QLGvMjMaEnZwIB1upMGhcfbKtqGatAXv2gw78x0+g9cL8mSsVuD+/77TLw?=
 =?us-ascii?Q?Phpm7Ol4qpAaAhQz6q2NNkvgfwi7T+MtKAFz+dH0jD1RtkvIH1gmAh8yiocC?=
 =?us-ascii?Q?n/Dv2qrVPj8BKNAlvUd4fb9KeS0ymRhyqEIz8yKgfrdBukVAUHwjbW2j6y4e?=
 =?us-ascii?Q?lbFrh6l/JNa4LL3LkNOhSDHNQvPf5rgatjqyYTj/ia9Ix5b/QuvAMQkSdXaR?=
 =?us-ascii?Q?aNkyCDO3FvfZSVLOhod/gfs8vtHnr+6owvvRWWWbfDHd0oonEwZYIG7DmWLI?=
 =?us-ascii?Q?YwGGUM/Y7IkRGrCIbgUL/p2ra2k4x6K2s2Kp1mZi+0GqA2JLh0McoNk5tu7H?=
 =?us-ascii?Q?wPeDeOd+YzDgc+upGbpGonnhfJi8assc+I0jqgJAcYd1iR6unxBRdKaLDCfd?=
 =?us-ascii?Q?+JlbZ2ZUTHbWaYGZz7apuUmuv6TF9dBxLA0SRsh9woMfOgkgVAllIZvngzOE?=
 =?us-ascii?Q?AlhMPUrz1s0L5B9lihKj3GV/3f2VTzcxphiJvqaaT2CKLbfRoCLegtNltc4M?=
 =?us-ascii?Q?SvmwzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mXToCqWABogyODtKTvaaLLjrlzKiFM8it5VVi/PFnkZBJNeDzj/6JIq/BkUYXqrQWupIx2psLf/C0hTR5s5C/AKfSxXHujG2ayNSW7qz+qdxrLGhV8WqCA5gYLw5RKNnUhq+4N1NGh/t0Wys6l9OK2EUQzd0Gt3RP/kEhVV5xa/3ur5deCg5tokp9B+/LcVvcraHbsxa22PHvuHyi8PCfY+SjM3Nfo6A2A3MfsUMDkRL6KmPgpYLlnegvn9TPpuwsva436XpnVd7IR5GGCKnDDOksRbE2E38rYeBwNshqzNpbh9dtTo9FrWeOAkjhPbDGfEgMp3kaGAp8NwIdrUPZb3CTzf4TCzRXTm8t6fjF4O55pD+e4Qn0WF2WkUNEoNvpQg7rwWHHGNruo0TpOtkPd2Y993j9lYREZfHWbM1wqvif/D5nF2quW9gnLnh1hZn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:38.7722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea90a6e0-1558-4e6e-e648-08de67dbc83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828
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

