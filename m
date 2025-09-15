Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49B9CAC59A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FF810E4BA;
	Mon, 15 Sep 2025 13:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zF+A2yx3";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413A810E4B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFJNBPlV83/qSR+/9wbu5YtllVz0mpHiRAMzhfn03yKzrB0y9gyoNugDCWLgkfnLxEyMQPJWwflpXRGWRR/JIE0g8WjVeK+mlwjctZyZP9a9FmHD3+vP9Sm16NUt7g7q+VdO81LYrKtRinGAP23rQXtmmFFmxIM++X1qlCI9aSwJrJlGIM9pqnbUnpus9ZVVTwthwiMJCtd+0eub0GD47dC2G1GZ9OWH+/2Wfj9kK3gGUIWoUG3jonFG+6uwJg1sU56eAvFd+tHB4/P4sTxgjAqIsLuwYib5qD27tVsH4wHlbIBmvA6S9qRWAqMLSjeYv0kpIqWNhefpWz8P6HgSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpgM45ajqApsQnVSiR3QCHMoceYa0UtyMI62NIaVzCE=;
 b=BZ1lgUCsURm+Eg/oJAvtBxnQLjYZMLr4TfQTlcf7o+4EpGJawKUTDjvu9JcADVVQCedV9CKH1HBOfLwBhBsycDmEIwpHYOCKzjZo4SUkrqz4c6sFM1hr5LrB7Nma8nsJiE5Gkq05lQdIaQ0lhYMmMx30KxyEvtnc9kN+WkIIaTYNwMVyuGQeJ1p1WWHe+XWhCRDJjRz5Q0tkQFbzcXdSyTtxSXsUgaV5m2YTeFlkSKv792fQ/v1Rp+aKa9BeLnkceRgG1nY924GYrYv4x8Bh9rT038uuWqh+dvX8v5O+c0Uzq/VARVBsYC5mCyla2dcrBzyDLdfN73sYnSWwg5YuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpgM45ajqApsQnVSiR3QCHMoceYa0UtyMI62NIaVzCE=;
 b=zF+A2yx3YhS8htc3XG55ux87b4ygr7XkGd/VKzOlYtW8AGpVe9dD9Pu44Bkf6IwiLoBA8aJjllltJ466cAplHLRmw7FsIHuEqpXrWKKSBujaIzDtsPRRj+GLl/dHLgZvyOZgvJ8tx/FFBYAzXwyKl4k6/WQg5QwrmgBeWW7ywoc=
Received: from BYAPR08CA0031.namprd08.prod.outlook.com (2603:10b6:a03:100::44)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:32:14 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::57) by BYAPR08CA0031.outlook.office365.com
 (2603:10b6:a03:100::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:32:13 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:32:13 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/sdma4.0: adjust SDMA limits
Date: Mon, 15 Sep 2025 09:31:57 -0400
Message-ID: <20250915133201.3547033-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 2851656f-70a0-4b99-34e2-08ddf45c480d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aDrHkTyAd3T+Qbxz6ZGswakemqTDfbDGTMnqLYM/InTMCS6yikaYT18TsJLn?=
 =?us-ascii?Q?qd3BKe/oDdPw2us9aW3gLcjSNGKdzqJtbN+S5SgfWyK2u/uKKIxiGsLVhoiK?=
 =?us-ascii?Q?KsMtSUmQYu7WUYfdDinoai+RGQ5wVZvEzOC6+p8/2lxtLMHe9qXxIDELuJkc?=
 =?us-ascii?Q?HqIZOIZk85vc8Ei2xCmi05kKD5X3ZajXdnhIJawfFkPhS7LOxnvwZXsmfoRu?=
 =?us-ascii?Q?p3I0LuSXimqRoBLvbf5ZmMuGGcLoddC+64QyLx19Tm8vVUITECcwDUhXO3RB?=
 =?us-ascii?Q?9aeWr4kvK4WFUaNezM/HLrAY8dMEl0Ewl/ZWmtTYXJ2ZEeVQuWH+NqSuYqjm?=
 =?us-ascii?Q?PEAgawZtSQMpWWXd0E+YSO3dcgNZX/cfNtgFMRqkbYzDhphj1521ZTFUKkJC?=
 =?us-ascii?Q?P+Oz6Fdf+uWjugdM7H+IVQeBCdRQ20RiyKjMgZ8sG3GlVxSYaXgHeC91LtTt?=
 =?us-ascii?Q?FXPY1ep8OVYFZQVkcS64aytyNB8Uh9641ZZfoLoAys/IBN1Zy8UysliqhyL8?=
 =?us-ascii?Q?46Nm2lggFjjNcD6nXmsy+uVcPSsXTMpfoZ7y5RQYyyUysnoqixQ3zuRSPL7t?=
 =?us-ascii?Q?/AVoJDGPAGlKlYRV9VxXrhuA2DzP7zsvD+SFG5VKS1V3PYM/Og6Ns1YFJGzY?=
 =?us-ascii?Q?KahWMy4YV+UpvKpa9aDXHI7JHVQHYrm3Ct5MHLNRHmdsuKjJQVF2wCi15Kyh?=
 =?us-ascii?Q?w6wh51Lg7wMbzfp+vBriLuC3iYFi+FW0QDkjV5WVb4fVctDrRCqFoIP3iYdz?=
 =?us-ascii?Q?6uEjGva5Jvof7b4i1k08rr8BHxVbnsuk57KSi9pOe8j0bn4lgwUY4EFEvP56?=
 =?us-ascii?Q?4esHr1Su5IKp5yAgyS04Ht3yCFzZZYJ4y4OmG2xtDaYf0HXjNRqXBpdYsNmb?=
 =?us-ascii?Q?vgyNO0lCT/QqJYe/+/TzJGAMOAkzEirG3v4ccmLWNRk2Msg1St2TqygWeA9t?=
 =?us-ascii?Q?oLaSztFeSKnko+YvkUhy8zRWnl9taHd83KjhRxzeEfBpSVXBN7oZ/i1JIZga?=
 =?us-ascii?Q?igqTzZVFF0Tdu7md5IW65139oAXUZ15aJ6U+FcgRkxGvvbXZ4g3jmGSwmZbq?=
 =?us-ascii?Q?TsvC+BJDUVNFcUMgUJgl72EiTIdgSK+j4AWXASf90GumZrUmZ2pPvGOAWx96?=
 =?us-ascii?Q?4Ne/ZMoOb5iL2+1h6ASS5T8Y5ytnZQE0JMeuJ3iNdMxKv55F3AMxzozoj6j8?=
 =?us-ascii?Q?ILotkel2WfSVg3utMzedaQjYsuJ4X+0wRoaYGrI0AhD2yJjdCWgL/QlxvZYh?=
 =?us-ascii?Q?BCOhHs0R4xYoKS7YFSiSXYE1pV44MTMYPqlv4TpLUJeXeTOTvrowYOXfWMpW?=
 =?us-ascii?Q?7O8shTRaPd2Fd10TLPtZ8odUlm5DWWW335SSdU6FZLQrWPAvEMgD31OJvGiv?=
 =?us-ascii?Q?5YqD9DI9gqEwatUgEMUvjoVLSk1Xzgu8cJjKiK6QNkWDsJu0MA4lLN9KZaPt?=
 =?us-ascii?Q?PUB7VoEsit8Kico858MUr1AcXYUbboAB99vFBo7eE1Kfua5QWy0sFolOAEiJ?=
 =?us-ascii?Q?PAdLwvv7Qw76VgCyA43fCb1ERB830gqVDixy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:32:13.8135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2851656f-70a0-4b99-34e2-08ddf45c480d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

SDMA 4.4.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f38004e6064e5..627c4bef443b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2597,18 +2597,31 @@ static void sdma_v4_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v4_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 22,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 22,
+	.fill_num_dw = 5,
+	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
+};
+
+static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
+	.copy_max_bytes = 1 << 30,
+	.copy_num_dw = 7,
+	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
+
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
 };
 
 static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
+	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
+		adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
+	else
+		adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
 	if (adev->sdma.has_page_queue)
 		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
 	else
-- 
2.51.0

