Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B3DC369B8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 03:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5151A10E32F;
	Tue, 15 Apr 2025 03:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="URz5VUy2";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C7610E32F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 03:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBi3R1lpj2KrG2NL8LF2Afj4ANfexwaK10c8KN+Dz8XevCvy2RDALWWIjeT+iTboofbW9F7JAnpbHDheEDRNefLZ1TKThNQhrCy00m1XGugIcr+cNIlLjXf3sBDIFcnhKrNYw0/6VDqDwtV0psj2uaKT8xsYy4hZcHwsjBlXn8GXohuQ3pigWeFmy6N0CWVSm1h6TVHkv8lqU+Qd0O6UOlZsRZInN1krT2vmOJIQJIXhrCnX97yNCgbUMpwuz8H4c1GQXc68NYAxgkOngCLnB49iRNskwBta+VKtY+VN1z9TvNPwYLpRUFTZQ4CIXVLrUJLGU6lUECd3Ac+9aBfhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vYZ61+nRF05payN4j5GZc3l5gXbFHqKKa5n66fCzpk=;
 b=aiS41qvYIv67myscuZyP9kQOmp9P4qPocTOlAuwAisnqcaa44EWJ6M4o7/Q2hp+X3SBIEFNcNeQtt4eVtnq0juHX8LjY8+uBTGRo8ctw2ls++DSwJ/X14GJ6Rq/F6LcRPPfzXmrrM/4V+2c5dWMYW0QD/v5/+9DATUzlpuSLY9Vu46LflmyLZwfeZklfaLS8umZ8OEXaQpyNpkc5yfGtdXiynDH7+suz1IoH4d5U7wHB5CZxPMQv6phLC5DyDFpM+8p7uhscXeTqXBUlqvpMGjPehgUzWfEIpFYq2F/m9ZVutIEmV4HrksMz8zwsd5C2gfVcANPj0NECMVaF2KGX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vYZ61+nRF05payN4j5GZc3l5gXbFHqKKa5n66fCzpk=;
 b=URz5VUy2MOA0FegZCuUxWyFOXM7H1xqdysuW2z+uxBdGIGpW8F7pLhqbkFTUHeqlLnJ+cjYtR45WWgPd0Tt8LmdwJon46lNNCmLjmvN5/OeZzxSqjeYi8gU1asmVl9JtNX7dAypvy4St+M5nJ9ARQfdKNu7W3Vz6qpyFqV2MdFc=
Received: from BN1PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:e0::14)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 03:49:23 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::40) by BN1PR10CA0009.outlook.office365.com
 (2603:10b6:408:e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 03:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.4 via Frontend Transport; Tue, 15 Apr 2025 03:49:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 22:49:20 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Enable host limit metrics support
Date: Tue, 15 Apr 2025 11:49:06 +0800
Message-ID: <20250415034907.106855-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 3366f47d-31da-4c9a-e9b0-08dd7bd0827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tD9hzakOqdp/fJYieFSU8FIRZtQVhvBxheOAE/BeeqLf6kLElITV1zZSrkFp?=
 =?us-ascii?Q?lorxSDrBkqDY8fdnemu/YQr4/FMEQjicYC0Cv7o1wlnS4rX0SlhLT+MCKFsv?=
 =?us-ascii?Q?qWm9gauRURezDAluo7/T2RMt0/0+vOX8UN5UDiO6dlNatFDWahRyc/uqHO4H?=
 =?us-ascii?Q?AJt2l9Z2mToSo2AkTsWaXS05n5KyZ1nEcLZhsClvcoNlA1tASeaGhl3tlxWE?=
 =?us-ascii?Q?wBKP1iLKPvNMBNqDU03+aAhs6mOzJ4Wu3u9MstOmNe2taTaiwaCB08Pbv0zW?=
 =?us-ascii?Q?27qfWs/tNuFz92Y5MLAPpEXf1TKDKjzOcuziaNSACKnvUwzhh7CJOeul/B90?=
 =?us-ascii?Q?coC8mFYK3rZTAFnC85WTlCSLlmR30LXANK4nVrVpTHfGJPxU4/psdPSZQfqY?=
 =?us-ascii?Q?MBD97W0GuqNElylC7p419EdZgxYqSftWXjpPV1+nlLFII7Tlvng1y2xnJmLm?=
 =?us-ascii?Q?uA6bGUUOvMPhbaqSXyUgRtLXuvYiqC5ocWr64mb4UhO+3Si22+Jtrupd+lrg?=
 =?us-ascii?Q?ZaX5CPcDyhzxWQMcwCY0eHn3LfHlA0bxDCwsKyC/nYc7vFZXCoumOsdzWziC?=
 =?us-ascii?Q?2NiyfIrNTmjeuC3cNSTqeFBD9F7JRnmFFtlTCTGB8zJQeaqk3ijOu5ywj07r?=
 =?us-ascii?Q?N0OOYL9d9GsKHD9HhlgrAkREywsIacTx5ILjcclQ6NUl51WHUVD/0+7X47bz?=
 =?us-ascii?Q?WbPpRuJ8159Xkqa9xbVnyy8pFxxxzBZqnXGKE/3A5eHoywUBl008jYqNvsz8?=
 =?us-ascii?Q?5Xt17oNZwJM0UlrfYQzdKHeUjBVpze3ZrAOt7VActTyhxycmsQZu0Fk5+mXp?=
 =?us-ascii?Q?OiSPwosHb6bKQfBuYE4gjVpK4TScLMb8hstUs3ckqJs0bvF6wlcWKtMIj7C+?=
 =?us-ascii?Q?QJro9T3eTCBnVo9gwjfNyYgZoyM2B33IOHI77MDy73eiqO8ENSOgM1uRl0f+?=
 =?us-ascii?Q?+o/2Tad8HFHuknIy8B/lf7ThD9aZJvhHleyzQEeZDon5NZ2Q7oe2DAcIc4F9?=
 =?us-ascii?Q?FahNNhvwCrLADU1L2wV4BYw0Wpblc0zFhAz+rbCPkzasLvtcI3XIee1/ZnyO?=
 =?us-ascii?Q?Fa8OtpvA8u7FeUM7XRsKA3IvgbU77gsx81SYtnPNCFIZGLB5tviUkJ9IAPvv?=
 =?us-ascii?Q?r3Hhp6V3TeJlPAjOeOahQy42NL8riZZpSQt1RW9pD1O7osLDfBNyKKMzObge?=
 =?us-ascii?Q?a6J2itpigHc8YnNqbH4pve+TYkKxWRlNykSeEJLST4WgvHVy4dEpsJViP1qa?=
 =?us-ascii?Q?28S0TzEDQOJXGlsf3hb2blOLefUBzF+S2FM5vbRdSi29QSp/BIAzw48DCxiy?=
 =?us-ascii?Q?rWPXh/45c/P8XqOuFZRtvBpdPlklyPlU+3KHoQJHZTrSIkEFzV6aaY42T3yj?=
 =?us-ascii?Q?6eCFDy3qUHcK930hSN6gzIaMxwCR0eBbs9gpolZU24F4xIUVhXGw44iDF8Sf?=
 =?us-ascii?Q?XSItKMcKEry+/1STNdPW1efasrjCZlNtHDBZATxWTd6fuYiHME79NT3/ZSFo?=
 =?us-ascii?Q?Pl4J3Bxfi73Qy4nIjTtUIbRWdeHi8cH1jDl8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:49:22.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3366f47d-31da-4c9a-e9b0-08dd7bd0827f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

Enable host limit metrics support for smuv_13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 34ffaa0cfeeb..3f61c94ea2f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -386,6 +386,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 			smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
 		if (fw_ver < 0x00555600)
 			smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
+		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
+		    (pgm == 0 && fw_ver >= 0x00557E00))
+			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
-- 
2.46.0

