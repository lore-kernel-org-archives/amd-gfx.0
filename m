Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817D0C36018
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 17:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275B210E4B2;
	Mon,  7 Apr 2025 17:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lJSNb2zo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AEAF10E4B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 17:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7C+0I76wcZh7WoU3ZBOC0PyyY016xFuH3mLgUrqiGm+F+l9iWNniALGf4jf6UqgPDAjCbK4LntC50XJNzCZoH2aQhHPk5zL0mm45S0v65exko+NLMCJn812N4VkrYVGbafYrL9SpRR6kiKWlkdoSFHlD1k2ohuAy4D0014GlPscWCBndsJh2rzvvYL5n4fr9YsGCLX5xO9CQA1V/o4qx5ZCT3ussAQhNieZnN1odXrmQMlIwRbSaxnJV0+d5Fhjj+HwNih16fqB5h1GOfES7kIbQUut68BLwpq0A3303UamoV9XQv3wj5XCNjVWmo/N1GFbq9kTGiCVWnpg46iyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEX84ymH41FDTd/cMpZjsZzzC7KN4vZL++tmUnrwqeU=;
 b=mjWN2cFZXgFtnkAoLRRkH/SaNDWWrd9FuSZMcjjFHbtCB73jKuZn679RRrdAijLHTYeZoHPPdWrSS48LOgE+W04mA6YxPIuzo2n+g4kdy+ZLfGHsHEb1s4ORY5JBz3IIf4C0Rbs0anl0JgS0SKa0yN/6yuDc3ag2GIhjG3EexvRHkfLPk2LqZ/S7p1t1iIgeFLDRwiHGOthegPqwbYImfwIPQazS0AZk9zI5h2ne3GH4/liocxeZQxiyDRJ2TmJRJW8S7gsDV1nitNz9RmAf+nIiOeiwbqC6fKt25KwsKZO8Zf3OrGVV3knEB2IHsMGo/gp8o6ezosNnETlgU1hrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEX84ymH41FDTd/cMpZjsZzzC7KN4vZL++tmUnrwqeU=;
 b=lJSNb2zoupcyZFVvCBAdx3Jmug6Fp33fxhXILwvp7osAQjUQetY2VOGUDfQ7ihPt8xUNEU2/yAA9r8fcZBKJUQmtyypDCFOBR8D7A+9H+cP05NW8LEYREKAq3hImyrUmhFVUvLGnJZuc4EpZTXEvQ2SOq3q6wNHphmWHIfqFTdk=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 17:14:00 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::d5) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Mon,
 7 Apr 2025 17:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 17:13:59 +0000
Received: from dell-1e707-d05-15.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Apr 2025 12:13:58 -0500
From: Masha Grinman <masha.grinman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Masha Grinman <Masha.Grinman@amd.com>, Masha Grinman
 <masha.grinman@amd.com>
Subject: [PATCH] drm/amdgpu: Move read of snoop register from guest to host
Date: Mon, 7 Apr 2025 12:13:44 -0500
Message-ID: <20250407171344.234402-1-masha.grinman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 9335ef8f-d15e-41a1-a64c-08dd75f79650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZALntUqTI7fEcayHfnco7DhiK0oUs1br8yhYj6xCQLpaCRN+9YeXASQ4uYcX?=
 =?us-ascii?Q?ySPQOs4M6x6cR0OecITy4R3LQI6TrCaX+Uq3SHQhJwevKAuU6sXetWgbn6kw?=
 =?us-ascii?Q?ae5oQ/WUQMAzcLy8W/AE3enhzZSS2KX5pwvF630RHrA4ZKltMCj+vgxquGbB?=
 =?us-ascii?Q?+SmDX41UA9G8qZnUMJh2yo2CyPNXxAVTC/ZZyzqo64CLgt7qvZMmt1ppnuC7?=
 =?us-ascii?Q?9NZfkBqIxC26d92KgEm4inp1s2BvVD6D5IrNG34v2/dt3AjNGDsvWDeqqiVj?=
 =?us-ascii?Q?mOQXir9UnJFES15SY/wJ102WOZrAyxxOV3JaKivZekwNyJbkCeEPcWuD5nxi?=
 =?us-ascii?Q?pqS3WGUrKVBc/3krDe/bfMDMXDeiex2SzRH3UYaAmoowqr/2UhbErjcZ+Aac?=
 =?us-ascii?Q?06eeQfAUzK5r9QvPjZSMQ+6hTSnL9oQBjawYoMFkDvDaq9vt4P4PrElEabEF?=
 =?us-ascii?Q?2UfSQ77JtyQaAfiu2/evI/xrF2bE29Im6PM6rmVMfj0Reqg3nADbagBd3T3y?=
 =?us-ascii?Q?/LalLZc7UP7dy7t3YB0Olu1+B2cWvNAZVzvPKbGuDPA2ZNNm20yHAEfEpoGB?=
 =?us-ascii?Q?nnfYYCrf05A5kAl9NuuzuKPjngGdzFr+qaewqByobOyVScCgvwUtCLQCk9D2?=
 =?us-ascii?Q?4ISR8jk80dg+xxcgbhqIAvUB8Kkk0S9sHf2VJLyGSxXJnn4+wVG/ibmjuGzZ?=
 =?us-ascii?Q?AuakcCjh3ZkXv3x9JTnk17Hcb/FQFLL6t3lMWMjYyhoGP3IHMNSrSjx1b9EM?=
 =?us-ascii?Q?0/C5r0PFw+6BjTMlxDMY8DTF/Mjs9vqq5eFqXxs7MSIy0NAszRsXkv2Iprdu?=
 =?us-ascii?Q?V5t3ZNHdFfL4IJXY/MVqfmakBSxluYIlB9B48u2uI1mPyWpn7MWEwmGd67QC?=
 =?us-ascii?Q?A4oWMe6xhShXbzFGaNh3+SzO9Vz5txReTEElBdZJ+P7o73FLnTOSD3E0xiWm?=
 =?us-ascii?Q?6dwAKZJOpVKpfabNSGb2N3BX/IBZJ69nvkSB9r8M87b+9fc2Tnko/bOJwp3m?=
 =?us-ascii?Q?AhuRCrvX3eItyhc0T+iC+xm/ZA0sD80I6kBshql2Q7Yl3jEedGkHG7Ykea0p?=
 =?us-ascii?Q?OdHq+Dp7hAOwZ1pHAvtlkJ6sAwT8q6hLUjY9BTXsCJ0vrcKC/sWH/Zlbmy/3?=
 =?us-ascii?Q?LS5Pt4KitHeu/kHdW2nNInEPZVpSnaUPQAGUN1o5nZLR11OFw1SFLKzZcnW2?=
 =?us-ascii?Q?1w8TJpkgyM1l3XNWLATwrUWQFu9S/2zE2NvW8Z7KUHpO+1KTp/iEREyAoCva?=
 =?us-ascii?Q?zo+9mt4qRwhloS+hjUx8oE3ojsMie/fR7WU3BHxrnmQKDY8CHCCc5GkU5QFN?=
 =?us-ascii?Q?as6gooHv2ALJqrMrUsdgaj2qq+UsvkLiZRUv1Jgdie+PHEg0Nt05OWg4LytW?=
 =?us-ascii?Q?jLMGgrfdpDmawCgyKRF8W5JZglPD9ZjlXfGOfuH/IhjxUspp+3JWpS7FZyk6?=
 =?us-ascii?Q?Ke5Qwy6RVxJrawtxjBhMQxmS5pY9gkK/7ZEhTzfsLjeabbpz8yRBLiW4Rwcd?=
 =?us-ascii?Q?WzQPHNWkaSfT/bw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:13:59.4468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9335ef8f-d15e-41a1-a64c-08dd75f79650
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
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

From: Masha Grinman <Masha.Grinman@amd.com>

Guest is reading/writing to snoop register which is a security violation
We moved the code to the host driver
And also added a validation on the guest side to check if it's guestwq

Change-Id: I1d5773ffa6187a961994b3403d4cde5b1641369f
Signed-off-by: Masha Grinman <masha.grinman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index a54e7b929295..6dc3896fd61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -221,6 +221,9 @@ static void mmhub_v1_8_init_snoop_override_regs(struct amdgpu_device *adev)
 	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
 			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
 
+	if (amdgpu_sriov_vf(adev))
+                return;
+
 	inst_mask = adev->aid_mask;
 	for_each_inst(i, inst_mask) {
 		for (j = 0; j < 5; j++) { /* DAGB instances */
-- 
2.34.1

