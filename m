Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB9AC27C53
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB9910E602;
	Fri, 31 May 2024 16:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bm3IsDKW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80EB510E57F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU1qgl1ExhKizSie02Nz6Cacz6nyJ7yN3Lja3R2wMVDHX7Qh20EEQwZ6eDcAoz7RQet3Oyk2YtXLXiy7zN+uzU/xkLKiKedJuwmn99VMxyrcJ1Y8mWF5VP0uLxpGVldhMm2iIjztoNwnks+HrO1ynCLs0U0xtDCjHO722claX2M4/EbyfRD9SotBk38VS6ARdKzbJaNGPwO2i7LDT//1vma35hdjXEwbYOu9qGKnjsslAbjnwXVEKIJ8TjUXTha/0KJYnE9OeEemlzUCgTXyMSJFkVsRpRI3shsT/bHaabaG2eAK3ysyEvFCKcLdP04u8YalGVEL2FH3Eo+jYVd3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYtw1NgfsINe/AKWI8977W9XZC744K019VJ/K+TCNZE=;
 b=TaY6zsO1w8fLOWI29mdUlXx+lB1Y6to91IZxP5hflFOAlIUvHgRNPFE223oFwQ4qpTrIbe4Or9huLyCSq6sTVggwmWQgPIlQ28FDJCea0tChW25KFwNRmLtbt3UoF8hu/NtcrIw8YBWdiyhRGphmtbcw9p0RAeEGHKv9HVkNEzehm8Pd1bB/HmXNIeqMtMwpICW/SlqVvxgwNG9X82gR8qVzy5Akfr015C1N8D78kdpxrH6IPaQzuWn5EJyotRZEqqlDH9ZizgEqEly8EsESv6W2Ngm3FsGI2Ji7W4OP3eGuiA+SACBmWcQdplO9Il8mAV3c0v8RCNzd8Cb3hu2NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYtw1NgfsINe/AKWI8977W9XZC744K019VJ/K+TCNZE=;
 b=Bm3IsDKWrFDILNkb4/oIdR7tLOMadFYwUAlBKnyGnjnOhrhqs76hPNkDiT6pohbmYcKtIjZjeq+2f5VySKJiBafu5M+FpXSrdJzxUf+eE7mMGykvvDqac4E2YLJgLa2VSB5U27kXVD3t6O3QdW2NGbyzaqJUly0JEz/GQTpiG6Y=
Received: from PH7PR10CA0003.namprd10.prod.outlook.com (2603:10b6:510:23d::24)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 16:52:55 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::5b) by PH7PR10CA0003.outlook.office365.com
 (2603:10b6:510:23d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 16:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:54 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:49 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 30/32] drm/amd/display: Increase MAX_LINKS by 2
Date: Fri, 31 May 2024 12:51:43 -0400
Message-ID: <20240531165145.1874966-31-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 833d4c23-b586-4586-b062-08dc81921df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G8SSRiQ/r/zVdKnjO/rHLUekHhEGxXZ/qlRPCToSU1rZ+AEgml7qu1oUCiOD?=
 =?us-ascii?Q?yoZJAHSds0Pch/iyht4RqMspTr2fZuwRI2m+8J2/zW+6/THDIMQFlNhVqz7B?=
 =?us-ascii?Q?5PVrFC6KdBhWOrsoKF7vU2BSN7eMwgNaE+rpmbmNkGekBqkNka70480AonGD?=
 =?us-ascii?Q?sioODKoEEx6GJKSlVUrJGB9LKL/KqodIdmFdJWmk7HM/49nEI4koi/cbNi6n?=
 =?us-ascii?Q?6itxL/0adESY/yQgB9pefQdJpZN8m+z/GI7U6R6w4ZwbPIci3/HyBbzQLKdN?=
 =?us-ascii?Q?JLIpR4O6BNLITHXewXGfzxV3SEKG4V90Wj7e9/G2kK6701vdo6vX6rDw03JF?=
 =?us-ascii?Q?o8r232+cH6FQGT+cC2pH1ZnM2aHdUbzZoonjPPPXCqZ9pJ99Gg0QQaUSp4wB?=
 =?us-ascii?Q?EBC7iIJ+fOMEZs5M4OE6t2Dzvk2RA1L1K1e5svHycct3FrR364Mw5TIoUSDW?=
 =?us-ascii?Q?tvYhbSxugdCy88Bm6PT1aJj4jQYyqBDymm3VVyNeISWxX5A9/LFL+fLEZbBZ?=
 =?us-ascii?Q?YrXDpj7nCtMmcgr5yEthGz696BQ+P9jXo1100TGJlRWrxZUr6mROM8Jfsk8T?=
 =?us-ascii?Q?iGwfbpjZtcZyYg5Q9hpErNyb0SeWTBuIyWdbyRA0S8qfJ0umQQQ/D3JovqkS?=
 =?us-ascii?Q?hEolsVZgpKgiavbKs4LPO3xzmL1NEWUkBBLSCmtAMqYDnEBk8VTRSjXp6dO7?=
 =?us-ascii?Q?eGDHe8WyLpGQ1UXnMMZvO4IlewYTZrcbiJtoaM/0EWxgTQLLBQ60oq/Sz1vD?=
 =?us-ascii?Q?FKYdJKj0fScOU4Zf1PNlDI2iR/CaEaC7yvyyCWaVmMQRULS2pr16+NNOojeO?=
 =?us-ascii?Q?NQGdLG0SA00dtYQT3WJFlxp02qysju+YnXtntgrDUuwYyC5mUemO+rq4rYD8?=
 =?us-ascii?Q?uc/doJTn52F3NQdulQLdSNhw/LHn2Ig0GEU7b3Cs2bByxb6IhkDJE7hfnIdD?=
 =?us-ascii?Q?GWAe7Kst0kt2rmXKg9ToOyq2SHaI0zv7T7KUR4mMmWMK1Ek/qjyFjbW8zQFw?=
 =?us-ascii?Q?unvADbqKWJUQCrm73rSUaBDudBzEItENXlUJ87aqA1CuB5BnQ+KxG9BMNJXX?=
 =?us-ascii?Q?yX88a54Je4IsRVzV2e53wCNmEjEhLcVxl3yfr72UIr5fK7UeUzx8Y+ndcUz+?=
 =?us-ascii?Q?IaiIM4RhSSH2UjOLLzdUxxuKk4bkLN4MoC5DlrRnaJB+Nzygr7y5bOiSzdYb?=
 =?us-ascii?Q?jkA41BAGncdQ1/hd9o/P164dW4zcn2z4QqlXrGIMheMlx3/pvaYl1Qqar7+w?=
 =?us-ascii?Q?5mnQj7VazouqMqfKd52YKFX5QHKTDNNLfuai29sq8hheWAiIhvPd/H4f9FaD?=
 =?us-ascii?Q?8IBvZOWCrjTH6Z+i5NcHStCEh/jRZWQGoFWEzWw3FoO0xQkQvuZvbZCDpVTL?=
 =?us-ascii?Q?ADDtoB/PAQ8xW7cbusyzHxjJnG8I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:54.6523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 833d4c23-b586-4586-b062-08dc81921df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

From: Alex Hung <alex.hung@amd.com>

Two additional virtual links are created and thus increasing size
for dc->links by two.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index c80ebb407add..27bba47186e9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -44,7 +44,7 @@
  */
 #define MAX_PIPES 6
 #define MAX_PHANTOM_PIPES (MAX_PIPES / 2)
-#define MAX_LINKS (MAX_PIPES * 2)
+#define MAX_LINKS (MAX_PIPES * 2 +2)
 #define MAX_DIG_LINK_ENCODERS 7
 #define MAX_DWB_PIPES	1
 #define MAX_HPO_DP2_ENCODERS	4
-- 
2.34.1

