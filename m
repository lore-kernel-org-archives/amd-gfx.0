Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242D7EE20A0
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A1C10E700;
	Fri,  6 Feb 2026 13:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ay7GKYjd";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A47510E700
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXItiHXgeVVIPiXD0pebe/MOYq2FpMADIIXuHbBnILGqbN8X3VfP7ceBNr+jozb7MTSPH8tRvpc6VNKG73xIfOv296CgmxMKEwz5RVhVpNLRiQDHnUSoT0kcpyBCz3LHEKcyd50+omXAQawteOlimmtKugqeNPr5T4bWwojiIUy90hALAx2HDga29Z9M4o+agzEQ7xuUkij8KycAWQjX8T6ckidWnwpERQ/875TNJsjhElD3tuXq4oIIM8sJXB6lEM/GWzmm42SrGmevbA14HxAKwciQp2RvbmV/er+swm65/4hY5pMj6+OzTN87Wnq84/D5aQWCtHW/Ji14Ui5C8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV4KsqJgBdWlN08GAm0OuB/bHgNBe4B6uuGT+++0MeM=;
 b=HdjUa5L7MYpTjQyedzAdepHJ9Ha30qKWoZ58U021ICLWFIBiL7v9tDhkKl3lLVT1MsCSFBS8pMYnwmpMbbnjhAwWORDjOGwYI7Zb1eiWAJIUXfxaCzOqWVrSBYXNIXqoi4tr+c+g/fUyhVOUqoQxIjR3e7JsR3g7epDuaSw9zwRB6gCPpR4NEmBuNXyXhp3Iv/hLHghatOGbTI/8x3OIvj3Ggw2xwqU5Lq2I51UmXm9zlfqqrZvTsqJbj6OOtiR6o/faqXxCzBDZO/RkADFwkipS3LsFb7lvhjrx2Fk2ysgOPGZ+r4CnbxyTfjsTdB2nSrRX2sNZh4dFQsyR44nCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV4KsqJgBdWlN08GAm0OuB/bHgNBe4B6uuGT+++0MeM=;
 b=Ay7GKYjdukjoAkQtVkOlmzWLlyt7g2oo3kL3rs/qEOhkdDtzN0lhI/3kiZSeJ03xTK8stVahgjCfhbsojHye08RidjW7sOk0cAG36DfoKdYblMXGcdWMlHmwqIrc4HhifpaYbd7qdDhzoGGto+HTklZUQ0/4fJjCNZb4ckoWD/s=
Received: from SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::7)
 by CH1PPFDB1826343.namprd12.prod.outlook.com (2603:10b6:61f:fc00::628) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 13:36:34 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::84) by SN7P222CA0022.outlook.office365.com
 (2603:10b6:806:124::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:34 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:32 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 07/11] drm/amdgpu: Drop unsupported function
Date: Fri, 6 Feb 2026 13:36:03 +0000
Message-ID: <20260206133607.91047-7-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CH1PPFDB1826343:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ae627c-84f2-4934-f664-08de6584beba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rGujStr4hxAjHmiHVvaiK6KQFsxC1vGUw9I9MdB4vFIw93jbr752Eu5x/JXu?=
 =?us-ascii?Q?iVgeOtjc4Q9HYurx5J4L4xALX7GKtaVTsTWqQIjcMe/wxOJNK/ipbr3qvFjF?=
 =?us-ascii?Q?ii+hYrgUE2SlJwLbLOLS42vsAEh3rkzHzBhSm8d81X3v2K93jGEmySCZy2Ol?=
 =?us-ascii?Q?9qcj2PKw6Dt76eGt2HapGrj5pKe5EV/D/Ld5UgosjS1adro4JLarLL0RbLlk?=
 =?us-ascii?Q?vJ6QyWguqX13ezC9H1rufTk1u8ljlKuhEAC8wQwAxRbf/qSeNqeXS+64ym4X?=
 =?us-ascii?Q?UgBhaD1zCkji5d0ZTudiS2q+NaeopsdzmzjfEBmiXJFM2FgwoOe+hqnLViwq?=
 =?us-ascii?Q?q1vyPb+aGhxYfplbRpt+eXE5TEo3QqIoUWcgLVmCmsWTK7/37EW/FSKhIlpY?=
 =?us-ascii?Q?d3kGbXEZAc4dJAenW7QjHC267hL9O+1YrIlUu9Eo3t+pZb30BFFlKlqffOcE?=
 =?us-ascii?Q?FlTtMl7coZ8jnOeVzisli49dU9+I3Tu6oyQU0AZ4f5hR+/5yCxxndM3oPBdc?=
 =?us-ascii?Q?8DMwQFbRHG/o7WfOaN8JreHDFLfiXVFtOSocuq7e7TKw7M/nc/KGdVwXOMra?=
 =?us-ascii?Q?6kNP85Q0pqpJ32eJLSolESqlvkEDbt1erWan7g+rG8ojD12noXE5eL0DYSFo?=
 =?us-ascii?Q?sQvQ9zjOwDQm7OeOOgdSfddmrRdYatpZLGwiGnH2iXqfNYaOvgRhIp54Jy+1?=
 =?us-ascii?Q?0qWpRemn3LTEs4SCMrAgniBi9CG1FecZ1P5yc9ALcrYkdqr4BrpxtVh7jLr7?=
 =?us-ascii?Q?cMJEIXjuXSpb6u+9R0Cc/UfU7rp8ANmUqjZaDfsxm5wIkRwhk4Qzdiq9FK85?=
 =?us-ascii?Q?oaeKWCVn3VFFjFYHelsROwHqdY4YGDx4FnqRE2tvJphXIaFM3vDWi3loiqmt?=
 =?us-ascii?Q?7/1ENOUUWE1JQPpzvX4p2FPL+kkJln0GdPsa4UanhfrHPD1vyNfMJgQP3hru?=
 =?us-ascii?Q?pX0Mm0lsWsEvUp+Zu9TI2IDK02/jDiDiTQwcxiFTqCmUo+7xsTUMOQRJEvLR?=
 =?us-ascii?Q?4Y479wOJE1RAeEK3sefv5d56Of2tZwD+SuPunV3gO9IciB7BNtIKbmrNIvwp?=
 =?us-ascii?Q?naT/o/YLvqVucZ4YiNTPKtH/kG3MK2Y7fwNwzTTlrWPGHkU2mqFShbPCUDXJ?=
 =?us-ascii?Q?A6mRpx3VM+j5ys6HoT6MQFHtJmJBKVYA3D8dEf/0yJeO9tt8lwvQ+C2585Q1?=
 =?us-ascii?Q?hzI1TNm1+5ugGa4xLTZgWKPgQdSotwzBbpRqRcW5cu+VRJIq4l4uocjF+cq7?=
 =?us-ascii?Q?MNGTJiHD8bN3Clw3iW00K5zSHcZYrEq9iqFJLciiqUWnFqwizb3D9sNPlKGi?=
 =?us-ascii?Q?hi0/RmS93x2DRDrG9yiUI57HKG6DArRuYN/tLBqsA38TWm0NJst+AHfRaHOU?=
 =?us-ascii?Q?PpTgXKqkcA3O4TgjlZ+N5I+MqcxgEOFjI320bCHdC1OJW1yZ9KwSRTuVL3mv?=
 =?us-ascii?Q?WA6lMBepszWXYDtld+ntAPXhRAiouseFK6dQETculkrISy3sHmx1pcoEuf05?=
 =?us-ascii?Q?6V3DYbPg3DBvMgzZOT50BukWVtIMdpupCPRkduKcG6g2vXmPB6VCjO4njK04?=
 =?us-ascii?Q?F/AMFAv9LpgT+sDbRfl2KdtvVD8rOWdMy07c0Ko9SRmS59Q9oFD/PjFFjyki?=
 =?us-ascii?Q?x1wZu73W5Yq5C06tb46h3ZBltDdyfCGjFvm2SKSgVPTENTUbTg9jtS33SfDR?=
 =?us-ascii?Q?EBfjZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nqlc/q99NEfAXztMTeNT2egaURsNQYpNMKfkPWUAQLSiEGt45kyMvrzIlUZN5xUw3i8gjKTcymKWC3ARKF/RTyIJsTRwC2NJU+3HKFLpzge4+jkEGcr901biwjILOEVB0M8/SkmaV15CBi2PF4/i9O1JmDMlqolVJt85lDONb8Bi486ys7Jv9ESaiTSMd/f7KeFXdAN9eKIZi6MG/CXthFj7BA4NzZAmT4kVaB+BFDlgS/w4Fp1R2LLTN0EXQz4HjFP/7q28j0IkgI4T0UDO0DFVsaRkg825tgqclJ9XepTN03060uBcpvX2EEJjlCaAbDIP+X/7clGCnSVrnYm3WGzizypF4jsfdCieq4lux0sbCWXTG6e+fXE4z9S9vDHzgiBz9rm7V72wRrfInf1OleVeJz0mUqDgRZnW4r7Xvs5G32jCsX6W31gws9UqFvTc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:34.2567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ae627c-84f2-4934-f664-08de6584beba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343
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

drop set_driver_table_location

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 0a8cafc84435..ba90626e5447 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1427,7 +1427,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
 	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
 	.mode2_reset = smu_v15_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_common_get_dpm_ultimate_freq,
-- 
2.43.0

