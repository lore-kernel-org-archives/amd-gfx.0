Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C40C3600E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF4410E657;
	Wed, 26 Mar 2025 08:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RXdVOy1B";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4693B10E64E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vwvs9xChtJWW1oqRT8ZGyhDIVUJ87NBEsDoS2ZIJ7xtkKhL1gqADiuMwPTtPZVarlcFwFy46jd0zFiXnCDkDOQ2zlods5cHiKfZLzBYDOFTtokSI9b1yIYNlXBVoeTVS96QrA952HnRWwfoesh46rZ5v+nqRCQEdjgsTzUygCMYNbUwc3jAhaP97i9OJ8y6xg1sghhJb+V5rLpWKyjNB8ljYq969717gDCbJTE0uD3ZluW0VW7T8QWpCqyxklPpgv9d6K5Rc8HjpIWby116GlaXkjV6wN4R6nght43woVJpDtDyz+ZxJebKzpL8Z2Hq9MsCHjPtQxl2hlx6BgGm9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2Be1206Fk9rlPlEfmigsq0HcXFH/5hRknvcz5Ec+ik=;
 b=MxqLjX6NJ6IH18FFe6/YhPbxHhzMOPiB4Ptp9k4WYL48y+pCgFMSzZ+4pHeCUIhASDNxdf6yDhc3gyGzzuMHwE9n2B+PlbiWwbIS8nsf6ajDxiWB0nJ/d9ENdINR3/zGLMt4vvZpz0GKLsKjFs/cokyGfCgOn+9YVEDWFSR4XfTfrFP2wRZR/Xq/Eiw0lxiEFHoIaauSDaErST9d1D5kK9tz+OSPGO/Y37MyGck3/xOLrTzpthpm/YmPcMEAEvR9K3GvR8rK4jsOm1jz2qA7U+5ROIiCcDrqTr+81qZI/x+/bi7PU6ty9EHLORz4AyaMHjXn0CxgYN/PuAhS54q3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Be1206Fk9rlPlEfmigsq0HcXFH/5hRknvcz5Ec+ik=;
 b=RXdVOy1B7TBt2wbT4B3J13qXBgMtEcHhd5gvhHC/GrzaHIm+MrnNs8K9E0RPKgx/pjJ/+8XEDW2PnA7MgJnev7ydIkkyrHR2ttuSo+ZIJcw+Iuk36TcG50zRZLpToK2278KxbzoCBQuEZDt+hFRbkqnBzMMcCKGwAWRoQvbgRLo=
Received: from DM6PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:333::24)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 08:14:19 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::e7) by DM6PR03CA0091.outlook.office365.com
 (2603:10b6:5:333::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 08:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 08:14:18 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 03:14:15 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amd/pm: Update smu metrics table for smu_v13_0_6
Date: Wed, 26 Mar 2025 16:13:56 +0800
Message-ID: <20250326081400.1305136-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250326081400.1305136-1-asad.kamal@amd.com>
References: <20250326081400.1305136-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 527f939e-427e-45d2-d981-08dd6c3e34b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+awc4NxPW9LgQuzZmKtBP2QJjkVwvf5soXqY0Iu5egwEBCkwJvjEyRSe8EB3?=
 =?us-ascii?Q?t17rtViR/Dznib/zaBnuuZJb9oaXrz64YR/iSgSl+1lsBxaeJmd1ox4lbIz7?=
 =?us-ascii?Q?fAXl0F6MNSvyCjBxQa1iKGrCXnUZfBym8yWsYfmdo5t4N7/aIj4aYiy0Bof8?=
 =?us-ascii?Q?4qJ6Pnx2GLeKYVn7hzkOgDN+YfNDZvJuoCiDyGfho2oyvySQuHV3vb6SqNpr?=
 =?us-ascii?Q?LHlYmET0RTFiHbOh6THcKYhr9MGl8gEiK+/YZaSQqFlE8h8mFbTwVv6bGSHn?=
 =?us-ascii?Q?ac4yGO6afxd6rEgJ8iwlEfxLYhr7+snNZuRquo8u1ELanYBy05Q936bkHx3r?=
 =?us-ascii?Q?akgldOb02eSmd1bRWBn7rtYotZyk2hnm8rXC/TfYcxiYu0uuf4jpmuGhcQX7?=
 =?us-ascii?Q?e3HANWxZncaJT086+Sne8luu0H2VQ/+ISNODjBB309XixLVxieKvkamINodt?=
 =?us-ascii?Q?KexBKjUh1MC3T685RxSHSENEXy7JBWdxVs8uOpbys0Xj1o6g/sTkyqoGFNQ7?=
 =?us-ascii?Q?+w673QGkNykailkkbEV52YzL4vTtSN6tD27SlRo5mwBWxJ9GRhc8xJlS4NkZ?=
 =?us-ascii?Q?2/XRA+pCUV7Psw+uk3O6yLA2FlnEp1LTsNYUFkirOUntjxZylsDr4R17A8to?=
 =?us-ascii?Q?bA6xl4KKSzenNagNLfL++QFVG21MU7ePtE52xl1HB4JTQj7Mp8xs4ssaW3x7?=
 =?us-ascii?Q?wk8zAdJETC6Az76X58jfONTcmufsqF9TSjf2nsZ6XHYwnSmUinipSqmp5sX2?=
 =?us-ascii?Q?7giDyN2GKymvD+ed2gF+D3pKNbSvzUOTi5xtG9lL8ODrGXpJrT7P3r4KvgUV?=
 =?us-ascii?Q?7PnI7T3guND0CpgYDJm3j3FIRndJ1jnZyeADdABVOcGBD+OxSwPxDshgknpE?=
 =?us-ascii?Q?6Sg9e4glUkDUBF47wFcgNFLqxLK86cvzycdY093DvDsD6yPtdk+43kDZdCDQ?=
 =?us-ascii?Q?15wWPH0EoAM/TakAD6EfQzYfw6/hU/lOxBjXUfDpbcZjmyQknWt/DSmKNFh9?=
 =?us-ascii?Q?jEmo1bXabHq1M7m17ZEKv1CJ8g/SYufSR2uDHGaH15QtLX8rCw61rDOjXrZt?=
 =?us-ascii?Q?logGtYZl3ldH5rG3rEzqOd5tBiZjcmLvwkDV0qMzF/YM8ldi9EOrKLJiDxSj?=
 =?us-ascii?Q?Bjh92hRhD48PaI+RUf1FkcclfJM1vJwFAU0RlI3MVJWw0D31l3QyZmgGQNSv?=
 =?us-ascii?Q?AMwmGUFMbrn0i5ueTqCnN0+4879iCP9kRVuYabgXOXgK5E/WIu+Pi+c4Ftrf?=
 =?us-ascii?Q?EE3KzlGwo8XV48zqUuXWRXPV+0NrxWlLnNcJ9N76QE1dAV1aKl0tSrzhNrN8?=
 =?us-ascii?Q?Dtxek0pOZ3A/0r6GUFBrxpstBxzMCECEDHmejhxY7rvNnx0aBgwxtXWnQnbK?=
 =?us-ascii?Q?Oq6Aug/ls9DdfJcosMWVkt27E5pT/0/WWx7d++HnBunuf6dc+oqNFa+FGQz4?=
 =?us-ascii?Q?nOGUT/yWe+7j55resg7WFn0yphPGYfCmPaZ1ofhj3NFP1VI2zMWgZJN8mN61?=
 =?us-ascii?Q?+2nLxdcFM7wnPsk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:14:18.3283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527f939e-427e-45d2-d981-08dd6c3e34b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
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

Update smu metrics table to vesrion 0x10 for smu_v13_0_6

v2: Host metrics support removal moved to separate patch (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index f8ed45857878..d26f35119a12 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -127,7 +127,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0xF
+#define SMU_METRICS_TABLE_VERSION 0x10
 
 // Unified metrics table for smu_v13_0_6
 typedef struct __attribute__((packed, aligned(4))) {
@@ -241,7 +241,10 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is accumulated
 
   //Total App Clock Counter
-  uint64_t GfxclkBelowHostLimitAcc[8];
+  uint64_t GfxclkBelowHostLimitPptAcc[8];
+  uint64_t GfxclkBelowHostLimitThmAcc[8];
+  uint64_t GfxclkBelowHostLimitTotalAcc[8];
+  uint64_t GfxclkLowUtilizationAcc[8];
 } MetricsTableV0_t;
 
 // Metrics table for smu_v13_0_6 APUS
-- 
2.46.0

