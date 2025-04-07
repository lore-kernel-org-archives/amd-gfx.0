Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D57C3601E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 12:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 534CA10E0E8;
	Mon,  7 Apr 2025 12:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RFPGKycf";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809FE10E0E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 12:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIAHO8FzV0cDkQ1gkH7pE86sVurYPic0fV8e1PuF4h32GYIKDSwzYFfmjtCxUwYYIyrWt89r9GrlsG3po92EzWbWcfX/Q5rYwL9o8Dbjo3HmoPMy760XZXEVp8WGjp2kwtTJ0XmbLMMSVb4eK7rWyL9uGghPIJ6wQxORQjX7FSwKEZpo/dttjoIDzCpjfJ5zLsBzt/s4XUqB0FeqifcbU79Wm7ATcSFQU3JDpdWfF4Xn+MmZtgvj+qLrlv/w683mY5HQczYEt4gYYoE2nQBPQhG/dzKQ5SALbyJ3Hl0OV/urh1Hc5+qbgoW/PKuOQr5mZyqJUecS5T22KzzrcScEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9leGhyAz6j7oTNZksTvU8/0bqrRYjNoevnU9vI4jNa8=;
 b=n78sMyOxOEUnz5b9ddTLoQYqKC+Xf/Z3VolWKcupZtPOAZscagGe9WszlqanxdzRFeAQ3DOIAM3bBc1VCBBlRewbeC1PV0ebZiXKRRzY8uv98CoTNzXcP496UJfuZLcPggmTRdWHLuWvyuf503TbELPGGnPad7yURxJA+JyBcQmUi+zqbqEx9pJ6qX0tUexjoMll8pNJqcfooH6eRdoiDq7GoriW10bL/TFbaioHHC/9U9nCj+WTxjszBTfuRQjZiYJvGA4irnP1xg/AhoFSXVZoKa1YOPhVyXtE3ftT/zrkdjCD8zp52e73iX7coZ1VHn4Y7WSZ3JG8Z7O+fGdyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9leGhyAz6j7oTNZksTvU8/0bqrRYjNoevnU9vI4jNa8=;
 b=RFPGKycfBEromGn5ECisQcfHYG3yW3LHncjeg2+MAynxQ9aZzP0qZZEWFLmOW0gui6fPn4tgTjr6hiaJ8d2IMiYUuGQYXjKB24KOgWFA+aZlMG07xJcrnpCA0CjJXcGv73lDjYDwwSrQm4x5x28KdDWSOaVfOlH1R/W5DkZH+Fc=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Mon, 7 Apr
 2025 12:53:36 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::3c) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 12:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 12:53:35 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 07:53:34 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Add back JPEG to video caps for carrizo and newer
Date: Mon, 7 Apr 2025 14:53:21 +0200
Message-ID: <20250407125320.15770-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f37587-04fa-4040-eb4f-08dd75d335f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kGTnpjQfICiGypviHOPvy0N8cXv6HbBbgvqi8WcPdf/S7ECnC3yg6nhQWgAg?=
 =?us-ascii?Q?P3L9+5Fq1Gbhqtlr7f5PKo3s2K8MpOxWmYmgGXlG6dcd82ykjDoDvS6XomGb?=
 =?us-ascii?Q?y0y8lKs34dTEfoiUQCpWt8xjz1rkmzThf0KT+WzAw0jaSNpiILAsqm5vzbI4?=
 =?us-ascii?Q?n7DoI0dd09hpTfZjvok9fEyML71S2kPxwtBq5Xpvv8LEbUDNZo3vfTD/xYFH?=
 =?us-ascii?Q?1f+C0oNhb9Ea78FcGHKMls1FST5dJ7YYob/OgKGekKSsBihPhCLk01Kp5kG8?=
 =?us-ascii?Q?uNa4+655b4Nqzf5m12C7rQqk93btgN1hpA8PVjWujYGB9OU/9Dc94U9Ij5ij?=
 =?us-ascii?Q?9t9nS2MR1yDoZfkuI0CpluGAv1c/nHvvj/38uFwClWIcmm2iZAXe5VwfnpcT?=
 =?us-ascii?Q?+1W7vi5yNpbZpC2xSF2lVVBQPRM7K9YVZdBwdCm96PgHBLfzKZOVA0pXaW53?=
 =?us-ascii?Q?bq/SIRsnT0A19J8V05wbf+ca2RsMiC1HQSQX3c9l7djpadQIPnUPET648Shu?=
 =?us-ascii?Q?ETkjo2Fdx+PoWIFdIZ8tm1fNTEZZdhFAV7eUr48Yc6qv4voiKZ3ZoZWVlDxW?=
 =?us-ascii?Q?HzCfw3TTBfoDnL6nmeY5gVjkbR8dSTOvvKa2rlnNJcPUyLRnV1PrfxeyL1lC?=
 =?us-ascii?Q?wgP8RxKMSeo08V+wyQKFLdLs8OoFTrvRPeNxlgOKC7Ol8KJOcr+lkONeWF8N?=
 =?us-ascii?Q?/ieQht7rVI2qgTKYD5xnK3lW6UGA60YrPcYw5ANx6Gr8ugJ2Dx4p/zvo/ebz?=
 =?us-ascii?Q?S67rEwFjLkL6PILtMc/rdJUWMDG6NCSmTzzB2tXQ0VMlOWwEsLgV4tbCtsPq?=
 =?us-ascii?Q?9royu3tq+nx9OY/bkQfgg9vv7sbsDKMEh0HDp/8GOsr8Q6F4CCh1kc+fsAfN?=
 =?us-ascii?Q?bocyrLuSZKvP6AKO8sq51nMOz0q8EFFD9HxQyxkWfpNA863CYQ6P7qpdWxCz?=
 =?us-ascii?Q?ZTIBbuqJdYbWpwNjF4Dy6ROlpMavp4vVDtvxmu1NLDor+TzLNhO0R5rRdjcE?=
 =?us-ascii?Q?rTEyQP5867Lxk0nQ1uokVoOafT7ft4Ov3jK7fWb2sodeW/xBFsvn/5k5BD69?=
 =?us-ascii?Q?Y5+aZQho4+1ECgXTUVHY2WLAM8DVE6Zhw91yO9v4z2ki5PjmO4NGMLwlH/El?=
 =?us-ascii?Q?RA32ySqJ+v/BoKkf+w/zEmMcyCqLZpLOBXZE8rD+EWs5mRYbNuTQtqkfIj6f?=
 =?us-ascii?Q?VCKCjBUFiv4lNyIBG5NhlQwWy+Alz7JR3sq6qKxDRpLfcysTKZlWEr/JLvXD?=
 =?us-ascii?Q?RjWza//zMrCMz8u7OREsPZ6CGemOkmGL/SssE5LeN2N8q06cb6tbcaMyy45i?=
 =?us-ascii?Q?6Y5XlL6mMyLLITO/JFAAEgxqMSBQL3on+BKvA1NGuGcvzB2RDEPPgQ4gnBbq?=
 =?us-ascii?Q?1Jl5Py+LCySYb8Zp4z9JzrBzh+/KjoZu+3jI3DoAnjF120tolf77ZqAamEQA?=
 =?us-ascii?Q?Cj1msGYumgdu52X00ILlJO4SauOlvjtPh10+gZN+9ZhGrH5vndQwfl0PZn/y?=
 =?us-ascii?Q?TKBkjV6Xk38EWf4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 12:53:35.9505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f37587-04fa-4040-eb4f-08dd75d335f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
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

JPEG is not supported on Vega only.

Fixes: 6496b525cdea ("drm/amdgpu: Remove JPEG from vega and carrizo video caps")
Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 86d8bc10d90a..9b3510e53112 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -239,6 +239,13 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
 };
 
 static const struct amdgpu_video_codecs cz_video_codecs_decode =
-- 
2.43.0

