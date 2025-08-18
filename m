Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDF2CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 20:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9555C10E4C4;
	Mon, 18 Aug 2025 20:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pZaEZgH/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E5EB10E4C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 20:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyH1Kl6sRg5+wPb/7GHfrXQpQI88ununldx90C85Q1DBR2zANtRt9CILcNjSQpSvfXkaj9KiRdqzk62EMLHuGAPD2WzsMyTrigkSjGU+kLYGO1AtJlZRCYH0u/EeLPjp9t5IL3pYNZ3lsR7/+m2nZ4CQ1IPikOg+Yu463v3IfSvwDjh/jFWupxMM1rWOS7JOscvxbiecRZH2Zklasj5p6GLDsA6Eg/XVmzS2WL3YcXKt5eabTXHboaNeiBAgCETwhZuRIoRyDMT1yJcaS7vveAJHPPipVcYE9o3jWycXlID0rHtWk/qrF+li+4rG6u8AMVynzks3u7g6pN76gM9KjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdIanORQxGel8ck9YZDUnpTdJWGjZbIuTWl/qD6NGGc=;
 b=rBLA1Nb7dfPTeaRB7XpHGfLHrhAaX6c5O8iFjjrPSLLRCruu08RZ7HW5nHFxb/ddUGrMegfVe0KJS8PT2CXTDM9icbrLiYshjsE304Brf9zdlBVEKdGZ8YycPsW2ipVM4Sf0HH69JZI9HiMZjeT8LWbDfQZlo4hE/Efzm9ZqReoUwP9BiGp9T8WOlKnh1QkCn83tyX1DUqkQDDQ+WR/x1carFGueBTNM6JXgOMaZweeJlsO+KsWxYDxbjsbURBoQsYBE/rez9VfNp9SpegYRnLrBcSdm1d2Dahum++bR3OsJw0iJo3LekZaZNXQft0wYFx9zwy8U51Hrgs+xHNVDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdIanORQxGel8ck9YZDUnpTdJWGjZbIuTWl/qD6NGGc=;
 b=pZaEZgH/GLd0xG8Cm7SVmKuTCLdxRjJDJsQgsd7XRehjapme2VMu5FQBlhuwgW72N5eb0ASUbmNaDUQl5jKLFwDyw4PxnexqLc2GbrVAdnnqyPuAtcyeahS7J7zBT0l+ncZ+G/q9W6tc/lV+f6lUrCJ2oWIbz+exHLDagEQgEiI=
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 20:05:11 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::77) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 20:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 20:05:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 15:05:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: don't enable SMU on cyan skillfish
Date: Mon, 18 Aug 2025 16:04:45 -0400
Message-ID: <20250818200445.437007-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818200445.437007-1-alexander.deucher@amd.com>
References: <20250818200445.437007-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0addbccd-aed8-42e9-99b7-08ddde928995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e5JSvGDLHb64kpxMkGK1295IP0AwAmiO/Trjs3OEMpnFDoK+WuFYIEkBnJw9?=
 =?us-ascii?Q?KpRFcOCTRqmZeFWLy/wClgK1/4tmWzLhkFmVqJTMRECizbMqL6wuQvFC18oo?=
 =?us-ascii?Q?htb2Mp6t/yZVW/mEQxNO36pEWdRnSmZlJ2EPini8vpABLkX6mejp2K9u90Bn?=
 =?us-ascii?Q?QlDBT/bi3iUbJV031C92AS4Dw/xbkVQRvVOeIU8mmGl01NwyYgRY4v6mwdQ3?=
 =?us-ascii?Q?qOFxm4oAvpfirooXAcACHuvhaerDiE/KvD31Efh6jyFzZorf31MRW2JDwG65?=
 =?us-ascii?Q?QuP62Hg72LwGe3Yuhs5gJ7I+gYkezngpJazRXAfI82us8+ALUkLrW+TUuVQD?=
 =?us-ascii?Q?fAYbbmNXHfjQF8fKep6GaFsnCtX90wc27LFYD0uEsRdwv1rpQSTc9HIg6bY0?=
 =?us-ascii?Q?ixzqN57B/deOdjL35w55HNSqQMHSFkcnQlD5CfbQ0C1dsX3XuY9gpQpLfFmW?=
 =?us-ascii?Q?iYSiCFpA2gucdf6ya6K5FXIiPKUHWsnXs0STmqodMc27YQDLGl41ADipHk9R?=
 =?us-ascii?Q?DoTGwokk1UCwsiIQ21gucUmF1Ay29t+JWse4xHRQaUex4vXr3lkuF1stQT+m?=
 =?us-ascii?Q?DVGb+BKUIP6nZuPQj5MEAz3AQFV91nYyTdO/69DMavP6QX4I09uFq0WuH11n?=
 =?us-ascii?Q?4d/x90RAvfP2Ep+MnjynVrL+Xx9Y1buVnFRze40m2WxGCpMm1x/J3GvUus9r?=
 =?us-ascii?Q?DSuQ9ET0BGML024H5lLzd/dQN56ADhp6xmjZbfdiHymIDILB9k2xQtMhkKoa?=
 =?us-ascii?Q?QSJqT82DQ3LFo5eGdwHktO0Ddb1bl/fnHvQPJPA6IG3nF+M/X45g0frFEs4F?=
 =?us-ascii?Q?n7LflYM9B+BUcWuz6ILHO7v4Q8EM3gti0CXfQ+9h8ZwJLjY82l2BwbE7P3T3?=
 =?us-ascii?Q?Ro35D4p3EQ7UbXHRBa0bO5VvNAO6Nh/O7Vh6VrsWLUVIgtLf+W34lgTQsgkH?=
 =?us-ascii?Q?qzy3jpc+7wmE4eWgdC4EiRhuNk4M3ukYicNtDHFaxxozcbL2Wm1ITUwzhi6W?=
 =?us-ascii?Q?oNKeoDsD9V5S6l0CSX6wVbY5PgsRqAahklLeH/WctLJqqw7vABYsrv3HXZrx?=
 =?us-ascii?Q?hP0VPl+lXhXEhivdiN3stkm3GyqERFt67QkxHiY9i0CVEUgSTWMXg0E97U77?=
 =?us-ascii?Q?+14oSFPK7WXO3dDIwO52qcEWBdVpqox/ICO2dRAz3LIsT+DhhFrkvgmFMJCD?=
 =?us-ascii?Q?vAHowXy+0R/vOkryb66j93G4R+ETFJHLN2nP3K2bgP+vAo/0K5CQNoJ3yhda?=
 =?us-ascii?Q?im3k7yvaOokk0MNcD528qpv8O8R752DQaZq5bni+RJDS7Lai3idGGHp3u3VV?=
 =?us-ascii?Q?VdY1c691kI0Y96kFU985PfKenoIDhf4rUduYPJijPBFZhngzNIm52elF+v8B?=
 =?us-ascii?Q?1lOZ22PePJCgq1T0Qy5VbQLFcCB0gOeDrbn8PIflXuPSN1iAJ0BPcbl+05im?=
 =?us-ascii?Q?H8583PgBJSDU08NIVpf/7DXRAzZ3TJ6/oCPeqYOG7BdSHiXMxq2OQNc2MJd4?=
 =?us-ascii?Q?nOx/uB9PIBBeLtHaBJ2sQWdtGXxAKKDs8tOn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:05:11.0013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0addbccd-aed8-42e9-99b7-08ddde928995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
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

Cyan skillfish uses different SMU firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 38c4ebc063db2..73401f0aeb346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2124,7 +2124,6 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 5):
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 7):
-	case IP_VERSION(11, 0, 8):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
@@ -2132,6 +2131,10 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		break;
+	case IP_VERSION(11, 0, 8):
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
 		amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
-- 
2.50.1

