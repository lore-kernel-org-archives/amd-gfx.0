Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A82EE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC2610E7A2;
	Fri,  6 Feb 2026 14:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tyvViaOS";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF86B10E7A2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsVteZPlnJm08Xp+P7bSn5v2/6QPRSi3hgXyYpp3IE3YtWXfI0IHvnmyAUFYh/+vBHLnxR4vGDFev/nEBfHVTitxtSqL069HzOP3Vu/n1nlBpVYi5Mhey/qe5sZa+YQbhsV3LwyWyBKtuTEK3AQo0E0DM7Kd0qBaptNNggcK41Dd95dJ2K9QEL538+I/lUZspx+2ac8QN7M0a9LRMsSzWExqd55XKPTcHnd5K0MXHbBB5dYL8zuJlGbBFT1i4Yo0gSOC6TeUsFgUQ6wS3m6JWs6v3XLAeVErTBY1Hbu09yghQQdhDMXdnzSETcIkMxFuKljSBbfa+7NYpt5v3cuSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbmWQDH+7xuxzyY0GZmPYSXT4dI1brbCCjb5F34JiEQ=;
 b=a4c0uioq3wp6FbueGkv5C4Mjy/gsBn4ISGp5xgLbLVNU/ggcT4C5i626/Q23bDMc/umQejHx21yFT3xQA95iHw9YqwJIfEdSRX8GCphx2MaVx6gVpw3opyeG+Ifxhtp3akyJvhUudPxQqbEDTSOvRe4/+MrD837mNwSOJTnESBwII8ZB0110hJeocgDetDUKFMIVpTyU4c+WtGfeFYjCAH8ZkO1PgRyuCM+nSAx8uGv4llV8hmvqlfs2kXtKLSe3X7fy/XFEm3RKVJWB9K6qjP8K3Rz23udikIqFcVJrHZBkgFnXZoe0u0RpDlFHDsEosecm79l9782kxHuLPgT/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbmWQDH+7xuxzyY0GZmPYSXT4dI1brbCCjb5F34JiEQ=;
 b=tyvViaOSUDCoFN2tTqyYGbHQDS5Nvcyh+lgZDye8SNfXj0Ey5KJKen2muElGWHWYbAv8cGMMPkTAgKu2koo0JvyrTgArtDSJyfp/5MGdNxhIYbHmUpGhMcsXPd0yqFe9sMOI/Rb+BwYmyWgnhwRrk5nqPD7PNiBjueOybKv2mLM=
Received: from MN2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:208:23c::32)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 14:01:34 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::cf) by MN2PR18CA0027.outlook.office365.com
 (2603:10b6:208:23c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:34 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:32 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 08/11] drm/amd: Drop MALL
Date: Fri, 6 Feb 2026 14:00:45 +0000
Message-ID: <20260206140049.105294-8-Pratik.Vishwakarma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ced67e0-6392-4f3a-d3b8-08de65883d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/0AIcyMODHv570jgnAXFxsZ2dJGNr2nq7DS6sfUYMvkmgsRl02NWUpW7ST7F?=
 =?us-ascii?Q?E0Mz2zhsHQnIHTcJacWDRl7i7Cgm1GKBjzmEH5I9cnzbNe7jC8ObDp1yp9MY?=
 =?us-ascii?Q?PtgGwtKNCKPX04JautyniDjnDMZSkjjFteaUEgBZDXjtdp2pL6XuVo9BJixv?=
 =?us-ascii?Q?al3xKOvqyUm0fJVzKKxoj3123HRfC329UYQ7/tEYnl13kEPLp5Ry9DzFUHT/?=
 =?us-ascii?Q?gj3wujWmQHm+PCKZPxmlBfIvg6ZoU1vsHRyeps/eN90c/MfAS97rd15bhuPr?=
 =?us-ascii?Q?gpc8/sXB7l+YZrkaccLF9BpIHU0URHUtWa8PCrf4tANQsra1gcP7yV2Dy5KS?=
 =?us-ascii?Q?bM0TDID6yJbUw9dZE1HX1r8DWLkchTkDG2v3ofiMZN71AEVXFrUflNj/HLSA?=
 =?us-ascii?Q?WftFn8NgJMdgKoqAP4Oo5/UfQyWWEhWDb/ZMVjqQHLzJAjxG4FFMzgCkt7n3?=
 =?us-ascii?Q?t10ONWcwc4pMmwFA9vzsoxBCMFuccrgLNnv78hfwignCodn9sYOIjO0aklec?=
 =?us-ascii?Q?+aqlG7/3IyAmYX/1KFhZpypN/kfa4YluPuqzUWLDjuqkZbSpZ7qFwZmgGY+m?=
 =?us-ascii?Q?NZnthmVGnEVCuiFchQ3Avm++NT0xI8hMLCLHiLH9rpFT9z7vS1BVk0gMuk/8?=
 =?us-ascii?Q?AL/CtOG7+Hyjikhko8VeGSU2jE1fdbRXgOcBXw8k5iYF+XOJZI4WKSdaIsOt?=
 =?us-ascii?Q?k7vpPSOQB38/ZYP/ooaM31XTn0AU6i3Viqsw73YI5Qv2eu5FcrOut10YNiNx?=
 =?us-ascii?Q?fUeLs+cy6e5ncvIInowCMIoRCzC8ilhDCocGBxRJBTN3HXQzaqEYpKPiKfYX?=
 =?us-ascii?Q?kSgyRKMw/MYxDwVM6zMw7PoP1tttMANeEI/th3K/4P56tOwdMId2SXwYUx+Q?=
 =?us-ascii?Q?NKo2RjKqFa+wRvgHqWy5fjcwJP5zUZStomDq3AC5hWCvpNWHsyOAnpdrOogG?=
 =?us-ascii?Q?26KZ6QTKI0VaJnDmFKpSNBnOMjB4UYuOvsrl3wSb5G2IVnrUAZhVnUc+flMD?=
 =?us-ascii?Q?zZVn8Em6IVkid2FoFobkJowb9Pq3Mb1ZJo/6Qecu7x4rf3tk4+bEbsyqBQuO?=
 =?us-ascii?Q?J3ODiQ3yFkP0QqCLwmTwQinc5DHh9kN9AvTgUGPwK542xhDXOf0VFxafthnC?=
 =?us-ascii?Q?2bp6ZNfHx21Si7od/inkqYQbfSyALWYM03qnf3Mk6RhSxvbTsgz9CG5aLkzX?=
 =?us-ascii?Q?e1cwoy0Lt79NojP0SsQC4d7tB9yayXmNLorYnxNA3E0IyVvaq7O937inuYh1?=
 =?us-ascii?Q?wQJsoE3N4su51RmyD0PKMLDHuBD1eaJw1On14fBUGh7+kinrq676hR6V/nt2?=
 =?us-ascii?Q?LrdBt4fRPsVaJw8CYAyNkSoTZl8sx+rNTjqNtBL8Y9yC4Ci3b6+C1wPSmCfy?=
 =?us-ascii?Q?zlStt83In9h3hd5nGMQpGvcUcxnYeHQLkQ5QmHb9LLsdz8ejPXczGV3YcBRQ?=
 =?us-ascii?Q?x2+OAEZsd2a0n9QXnAYejWk4yRAxTnIAweCdQBmxbU5zcI9UfGMqVE5s7VX8?=
 =?us-ascii?Q?ekbwfMFrDaJ/YV9JP5drA2QELgKBk9l3RavRBsJmHPHfx5btDW2EWr3JuAcv?=
 =?us-ascii?Q?XokzV1vkLYUOaYmy9FNIICGVc+qob6fZ+ybx/QMcHDBhHrsnxAQZUwjVZDWA?=
 =?us-ascii?Q?u5Wa9P4PdIcObLY2ee3HDTW9WzEHMaCh+cbqroFkG1SizzttpwJUqttzpxwd?=
 =?us-ascii?Q?b2ElbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I3UAER3bxRCBRI8xcpFqJU8v63reLkt11F5jUW5h4DtHEEO+2chEBfaJTh7Mo5UQ3nwU6j//rBAzJmAa6lOKk8d5t0Gvd9ieKmlGZ6HGQ4MEBUQx4qq7sH1NBVGwZmh0mVM9mfMqbhp2wLVGon0YNcG4g3Ji6iWhvNuQAkMhaTmHhmkRhtzpB1BIIkwNYjtpuDXhMoP0Eq6pex2kEdiOFlARhgzo+g6nqNr6wXRoiNUp1P/4IS1CI357QTrv0mZN6kHQ1ydUEVRiFbIKwW5luR8CHfMVvA4cQJ2gt8pJhvKLOZbOX6kxw1LBjobkGuevweYtDaFHN31Dx7T3aH5mL7QhUJT3YIq7fUgG/J1aaeriqTDXBT3uYpVPg7Z3F7VBpyFONKfGhjnZxuUw0+zDHQYbCbEdlwMYc+GXXxGHK9kIOMUFql83Lh81cXHp7CJ+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:34.6900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ced67e0-6392-4f3a-d3b8-08de65883d0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

Not supported on SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 73fd2cce1c7f..9c2a4dafdd7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -58,19 +58,6 @@
 #define mmMP1_SMN_C2PMSG_34                   0x0062
 #define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
 
-/* MALLPowerController message arguments (Defines for the Cache mode control) */
-#define SMU_MALL_PMFW_CONTROL 0
-#define SMU_MALL_DRIVER_CONTROL 1
-
-/*
- * MALLPowerState message arguments
- * (Defines for the Allocate/Release Cache mode if in driver mode)
- */
-#define SMU_MALL_EXIT_PG 0
-#define SMU_MALL_ENTER_PG 1
-
-#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
-
 #define SMU_15_0_UMD_PSTATE_GFXCLK 700
 #define SMU_15_0_UMD_PSTATE_SOCCLK 678
 #define SMU_15_0_UMD_PSTATE_FCLK 1800
-- 
2.43.0

