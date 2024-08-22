Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B28C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 04:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5A110E02A;
	Thu, 22 Aug 2024 04:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vIN+Yup8";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5837D10E02A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 04:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4wxqmOQv+5cEGPnQM5k8chAXp7xQamBpfLPeJ6eFMsKP0LaeIWDqzYT8wBC9koKs4Fi9cVyAvYHH6Gav+DE/8LG4q6IZmpjkLaE34iUGpQr5/LfXAWelbmhVfWgvdNKztc1tmd8eErPqk4Hv0Z2BQa+E02Jn62NXLnNL3B3QB4qk3QBDvu9oWBWK/4Q92o9ATPsYPZ0Y6dqcRr+oQBJk9bMXIEVvHSQkc+wVA8Lz0mU0pzN5a8qVi52kcV0wnBzgbNvwWLKlTBBDhGY+yIQLPLmUPwUPoEoXURrzxssQuKnSlBQVc1QO66+g3i47ZwimCKTqS84vVBRC+yOko7o8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zMZNaYD6z8Bt9e/GV4x8CDH0IAXuCZDgLK7nmtyCJE=;
 b=peTvG3Il3gNbtvhbFRVO5JfRHqIDWY5HIY6n/YgDLLvbZOmK66jIevrJQ6lSVzCTCMYWdHg5taUjyh/YL2qMijvib8I4rEXUlgyJkzINO2qWKIrBkSHh+/z8lMeYKYTzAk+Ayu8XXv4w277GtsZJXyQeaTddA30XLQOz238WS0mZU7u9Cfs/Zh6MB8c0CPwl20/Py75H88XzNf+9Nds0f01UNyVoyb6vKAZaPyUXLJ5rcLQtv2WthhMvj/VuEA6bkkbeP/1SGih5XRqNh4TEoYvm5ND8ynI1xvElyW2m/mB9s8Uduaj4GCZkeehrXEI/wuWLUYYMXriaWZR4B+mS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zMZNaYD6z8Bt9e/GV4x8CDH0IAXuCZDgLK7nmtyCJE=;
 b=vIN+Yup8xs1sP9Mmr+9OL0QB/N0+bMLe0hT/uD9Je9iml605kjCaFnR9JqCuWU4FDW7q7xuRogUWC6Q8EsCdWQy5wnSwaKJ3zoTpHpBGLXahPRBJJFLnkDva2tR4IJdtm4vC+pioI5rOijFB/kDG3kimZLSl6WJso/F/kuDitLo=
Received: from CH0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:610:e5::21)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 04:22:03 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::a7) by CH0PR03CA0256.outlook.office365.com
 (2603:10b6:610:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 04:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 04:22:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 23:21:57 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add support for new P2S table revision
Date: Thu, 22 Aug 2024 09:50:50 +0530
Message-ID: <20240822042050.1812745-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: b4658b3d-a677-4333-40f1-08dcc261f9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YnYIwjBmwzX2+W1IG97BoxWVG8pdkF/tjKfE4GJJR0dIZztiqfNP/bnn+IjU?=
 =?us-ascii?Q?GWi+HcuCRMtddNoE6DnhISqrHmdb1M1DVEEVGpPEIC0yJrBVcGSDJj+NlhpK?=
 =?us-ascii?Q?bqilLenpUbBP2yzx5BaotjenVuJ48PvQB0lwAgIQbhOPP/OQOmfItTYtxr9O?=
 =?us-ascii?Q?mVWqCKE36SWN5kETjQaJQQd2aF5uFnwCJ7AGx/A4ESR+c345NlW0o8Fh+z96?=
 =?us-ascii?Q?LMypld1DpePAFyafrW1teOkx4PR+WJzzIt1We/IQsOrxTUXIAtK61unA5S05?=
 =?us-ascii?Q?iR+U7BlJ5GZW8qOpZALt1JMWKB+vttQ+Otj6OylyKCVyAx1Erb4pIfWzeTnb?=
 =?us-ascii?Q?jNH4jwbxt2OFgJX4pc1lEESMfTsdhNO7r5zpO7zg/eNfM/9M+pMM+W9oiO9Y?=
 =?us-ascii?Q?/EcZNOkxG/bLPtJVfcjEJSA+rTnNCOdvqYcJoLkwoS6vMZxsgciSHDv6kxRg?=
 =?us-ascii?Q?paN+wWBlkQ6BC3ra0ZdwB4AKSFRXLL5zimxHXcKKOSUW74aaHP85dfuOWprh?=
 =?us-ascii?Q?JGi6NT5VhVyTJdGWPjy5z52pG+xQ72n1ndkE299zB98HopAIEGr1TEqLD7VU?=
 =?us-ascii?Q?c9ZDqrevPx9MQiAr0d3MJ+kv6R2u1ydFxfHkPG8BBjcYmHZUTFFUwW2HnD+9?=
 =?us-ascii?Q?BVVEoAsfIO8lCx9Aykjdj3kM+NDLRqj2zISh/JEw+BkDEGqy4f1XCp4YbGHH?=
 =?us-ascii?Q?e0OzI/cMeMBLEYC95VPIULjNNk5jNJvewWQkWUGreB/YBYYTEubzOhk0x30f?=
 =?us-ascii?Q?CpEXYigj+vIv01KhIp9RR+9PkCf0gb1BKIF27X7DtVt8lBN8yq9yXMh15sXE?=
 =?us-ascii?Q?tPalguFKhKPO7pKl0HI5OGfJx3kcP2CfRW+X1h0IXbUEFozRSyT6nuL00sa3?=
 =?us-ascii?Q?lGzq4Xmc/kGZt6d/HAt3j1RV3pvy0J7hXz2+sLbZFHaOjtLV5SueVQOXV/Fg?=
 =?us-ascii?Q?bD9KPC6YKDgdilVxqNXNgceNquhuYsvUAVVAZPgtnyv1jSqWheICgElPXnyT?=
 =?us-ascii?Q?PebStit+U8JUTG0u59kLqSVwNYnSRKNpPWnAn0roZPwJKzwo17dxDn5zd9af?=
 =?us-ascii?Q?ITFIJ5KmnI29d1H803f+nIqhLHVfKmB+0ZO8YQ7Vu7JyjgN80ratu+UNaA35?=
 =?us-ascii?Q?znzHiGrbEzOi1yXF+FxVKs1vNzJqA+XsqGbngoIEVHBsvapJU1AfhUXPmy9u?=
 =?us-ascii?Q?jvuDjvDk9fIJiDLNT04hOLIKl1pXdkjWaiqw+4ILOKelmweP59qpGnd8BPLn?=
 =?us-ascii?Q?fgmXHeDg3h8U106BlVshElVHN4Q8oRcMD210EJfMYwQzjuAy5S5TlxXnv89l?=
 =?us-ascii?Q?Uc8tYOG5LETdJ1wP1hxe2ulTvgyXEekdjmJjEipNXT9Dgujabk9+WyT33o4x?=
 =?us-ascii?Q?nxXVjb26QKAkVCV+m80sTO1Udkn3UdXc/yeK4CcjMH3sxfwYunQTWqH5m9Sb?=
 =?us-ascii?Q?ZWrpQjioSCLKqSSVVoQVYvXhrJ+J/+pU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 04:22:03.5221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4658b3d-a677-4333-40f1-08dcc261f9a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
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

Add p2s table support for a new revision of SMUv13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7cea0862dcbb..ece1ffc1e56d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -121,6 +121,7 @@ struct mca_ras_info {
 
 #define P2S_TABLE_ID_A 0x50325341
 #define P2S_TABLE_ID_X 0x50325358
+#define P2S_TABLE_ID_3 0x50325303
 
 // clang-format off
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
@@ -279,14 +280,18 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t p2s_table_id = P2S_TABLE_ID_A;
 	int ret = 0, i, p2stable_count;
+	int var = (adev->pdev->device & 0xF);
 	char ucode_prefix[15];
 
 	/* No need to load P2S tables in IOV mode */
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (!(adev->flags & AMD_IS_APU))
+	if (!(adev->flags & AMD_IS_APU)) {
 		p2s_table_id = P2S_TABLE_ID_X;
+		if (var == 0x5)
+			p2s_table_id = P2S_TABLE_ID_3;
+	}
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
-- 
2.25.1

