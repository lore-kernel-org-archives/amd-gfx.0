Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7CAEE20A0
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D510210E72A;
	Fri,  6 Feb 2026 13:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HLSKMYoJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B54F10E72A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBJTRQATWPeuaJoAu9PiEi5aUzRx9ODFAGNTY4lAaZCGzG0aq4n5f3ixFPyqnYo0qQbb4TzTzzu5NwXwYvL6QHrLz4QFqqVa9YDon+6tmT2tv1M5CNh8Rh0sWFaJ9IZ+ApNN+DL5Vx4a1Pgzh2MJQnlHeEUe+nBea10iD8wyrjNaXxCwEqTq3FdZFuDVg5WGF0+uUT8FKnUDJSQJtx4QE0OYd9PfsRXZ6nOQHwZ9X3PiYAtd/A6XBHTHNhXRehS+djBkHqTprWmRAGO32i7dhhCidScamtx1sJVZaUTRqwnEyGeTt8Snxz0F1TD7MHf9F0PEfgfzpVK7NoFcbzqRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M95GMa6pWAPH1hpTdkGwox0ADIdnskB0WJ58M5g+BoE=;
 b=UIyjCM913n14COgu4nGk+k+zNUF7NZTNEieHXVWZA+lai4bXtUmKlmqA9ObOBPtTqszIwkV1Rwo63rntCaJuIrWAUgmGSSj0iyBuNk+3Ql6kwpk/+Ir79ugewFNZf/7qdP23Szs7jdHAgnBZlk64Q1O10IbbwDbfmcCmsLIV2/GZII7bkWdcWe6xzlRRbMb95guzJ001uF4zdp23hXCReLYRhmLU36C1gJli0+pevyVOErc/2FUkSjT/uImUgvyvLHlJ0nLlXuRQgY4M2RAZC/utQjuS8NzAvNFhUf1f3fjw3idYX+Zy0lJS5w2wv105PfU8Cloj2DlzourSRdtYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M95GMa6pWAPH1hpTdkGwox0ADIdnskB0WJ58M5g+BoE=;
 b=HLSKMYoJv0sB/acillTSfZsG6WhyPs8Xe/XYZ6B3D6I+mgvqdPJDYicC3jZQ+vSTwyo+sz29VrPxOGa0LO3WLErYyeSw5SDVJpFK6TKfqNshoWQDp4G8o6r0l2wDkS9eDvp1C6dapgzbLdV4ytLMR1TO+lgZZYo4rIhdi9/obEs=
Received: from SN7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::34)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 13:36:37 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::a7) by SN7P222CA0009.outlook.office365.com
 (2603:10b6:806:124::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:36 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:34 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 08/11] drm/amd: Drop MALL
Date: Fri, 6 Feb 2026 13:36:04 +0000
Message-ID: <20260206133607.91047-8-Pratik.Vishwakarma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d387e6-60a0-4711-df6e-08de6584c03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BxlzxMMN6/ZZQWUs5QO0p0tfwtS7WYrXRDnsPtjFn3FBYt1y9KWwZ320zvg+?=
 =?us-ascii?Q?0abCvUF6sm1HZN3HTodyKGXJVyF4pz8WcYDhHQ6Z7V3gKAq6+BOMwxq8LcbQ?=
 =?us-ascii?Q?wY8JLfkMxMX6QpX29xaeWBKHxs5ALeSQyA9fS7soOVRRHEma4depeItERZZM?=
 =?us-ascii?Q?0Gjk/an0QnnSfGn8uZ5lsV/BwduWBDmxQeaMireZUlLHJJ0fTltNBcg5fIWs?=
 =?us-ascii?Q?PBXM3kA0NWV5AqcTzP1nhvfqPnZIVlSn/MiteGsqtD2amyn8wlXPde2N/i/5?=
 =?us-ascii?Q?YyD7hj3ATA2REFZ+0TT1YkYHP+mVCdhjEcMsP3au6YmG2QjL38GTSpEn2f76?=
 =?us-ascii?Q?DKnXwld7Y743bjjlXK2Dv6UJn5eupmWpI+InuPZ5C2iBtGo5JbYIMz5kx4yf?=
 =?us-ascii?Q?2MHF/8KtNxV64rcXBIj2e/nWKErweDTDZpWANh95LQy0vCOtWyOcT/gX0EFt?=
 =?us-ascii?Q?Kaz01TCOj9ScRHtsaf4LcZg2ebOPeNOto5UqAl3avRXauWR/GEynwjUx2gOg?=
 =?us-ascii?Q?hCPOKfCC5bpy7VH+tiB0ecjae5xbqbYIAAq22iUH7in6geHcmTxc2a9b2Rvh?=
 =?us-ascii?Q?8duXZBtGqYXgXin1BYyzfS3x0fJN4LPS3CvTXT5r0cLWO3CPzBWfe6C7WUHp?=
 =?us-ascii?Q?EpNuhx5cEzNfbJtfjIZstc3Ep07zjCEEhuHm/rpMGsoeyI1gtn8USbUdM/Yh?=
 =?us-ascii?Q?c+ZUmPHlA5TxEHDHvDQGBQdcofkVow/jcOnyGWYnY2mWHw1BL1w8c5z1QsEJ?=
 =?us-ascii?Q?I35RY4OGxGYhdaWD0Z28s9vmqaGk88KpednC6XKGIOB+Y/0oG/r9GDi3t9l0?=
 =?us-ascii?Q?Q16pYkE0TCWVIlZBSFiklZ1Qt+a/6sDT5jk9N3SIPRvmOPCIWDT5aztvmLD9?=
 =?us-ascii?Q?e8NRsSHnTvLtmRbEysx5p/x3040wiaXUGTeZAvxmgtJpiaX1Maqm2I1eOeXj?=
 =?us-ascii?Q?BKVCP4fHNc8z3l2wLMoLtckHHPv9Xu23d6KQInT/zcXDZmVL/GMTMN9hQvcf?=
 =?us-ascii?Q?VzfgDjHNXzSI/ZdOatGxQIzxiGvFSW38Ne63D34ySZ1TUoxuL4uH4GPerAc5?=
 =?us-ascii?Q?1VJB5PGC9Oj/ctZtSlP1vqsaABvnhNtEKJAvUbQSYIuMmuIfTtrDGZFgj9+e?=
 =?us-ascii?Q?J/JUdoC8hK1WWkJvNh+4LW/KBf/hKaagBio/igVF5BQbM/IqqyXGMTXXFeU2?=
 =?us-ascii?Q?HasJKIlZ5p/IpMjjiSY9/65z5HQMMKEzWwNtMWCKxmphlgzg9y6laHfnW/h0?=
 =?us-ascii?Q?V0IO7PrRYec3VBXtGZNtb9QyV2ahr9LKDonmyAlm4UjLLuZPu3tmK+JEUwgd?=
 =?us-ascii?Q?S9eR24EzSx7joxSXY4iTlkzkZn7HxpxdcrkuNbVMU1PtN+VU2ORiiN7768Z5?=
 =?us-ascii?Q?l2YfPDFBtqlrGRmVFNytWyFOGINDZ84mMeV5clIikrrFEkVxqyvoT7LHf4c2?=
 =?us-ascii?Q?xZIS9QPek6OP0eA4bTRKRXkG9SVE/PhBorxwL+sWWcQ91HWzmu05a/YF+5Lw?=
 =?us-ascii?Q?YQBF9vVPcfhY65q6fSWS8pBEoA5wITFkhQP8ciIAGnw27vXlehhLZmXQ4gV+?=
 =?us-ascii?Q?gBePUNzp7jO3b6e2a5xt/lXSG/o16Wx/x9tlK1Z/3Or/AHMA+ndq7iN2H+I0?=
 =?us-ascii?Q?pFHNJekQ4w/JylFT/YwipDSWp0St8gZJ8qhC5ZQEZC9pCEaDMRBjw1PkXX1Z?=
 =?us-ascii?Q?mzsVLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ep60hq+dPhXM/xz8/LM5+9pFYUxZpBa0KHkAg+jKTzMbKpYikgrB6Mv5wvDgFGCLrFabwQsiqrHaQKrl+b61ol9jXGzXjY6FkQ41aFU0nZ6ldAYsPq3O6QolsVQjmua4ibgoHrHQmpxGXi9AR8w0Li1ix4PFKSXkak1CBCxrhbPEhm77c3DHs8bhWPeh/WeUxKrxEetkoz/VBgr+HG0XYdeInqY486ynw90MCVpgBbyGsVSwxIuH3mOyodOqwv5vLqfKRFFahiiLHdN8rXF7mZ+oNBojndBGLOx0hE/F6XBIzml1PdrEA82XOXD+2g9CkcjyvFreS4E0aV471a3jkPo/KG9wUV09nntlP1gGly/s78UFWkJa8EWuxd5yiAm1ijw8vie0hiWIW5rQ/Ke3Za3ja0TeOBH3RauuGf9zxP+qsI8k72sCCVhzd7138DkV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:36.7714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d387e6-60a0-4711-df6e-08de6584c03a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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
index ba90626e5447..0a5f25c8e4bb 100644
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

