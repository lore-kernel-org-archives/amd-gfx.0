Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF02D5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA48D10E893;
	Tue, 16 Dec 2025 09:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0NSsMHon";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F4410E8D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ac1ITCx4mHJ5XeH26Iav89CpXtpytPI6Lf8VhrC9NVahmqolUWbsyRWX4WtPJx9BPE7PuuRk6SNvCXSkTsMStUYqJD1ZKVECF563z8lSu8+qW6zOIKPODOWwEKQ7dhk9sS6OM4tPy9QdJWSo7Z0Zuq+XPzqt1DbYFLkrAyziX89OuHCveTffYyh98wX1PGoIGV29jHn+SnxvvdHukdME7LexcXfJKEjw+Ir8BJ8w9x/0CxAuYSgzBRC65yQMiIhxjnM7m7JpEigRf5AJpgEBm0EUGIP6KHKJFi8akiTt6pyTOtxSFRRBh3fdvmhtWNQONVYhjTa8+JSG1DCjFiXM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RwGhIT1dEwHor/W5paNzv/qpinTLODOGU6kg/2w17k=;
 b=rG/c9xAiEnhg9uckMvUaUKhILtGoCz/w8LDY9UCw+up+GRqDWorVCohmh/jqvNpNht2fOs9k4tuYGX5xokTmvIwf3MDnHWDHG23fmqlKlTvbuwKUZtHZXWXINx5KyDqaEOk4xeeOstY78kEBqCDanR3TKpBqTPboy5Ll3xPTpK3AUtvC7l2acwFVqPDZvD+dq+niakt8lTEHauRRxeAdHcT63Z/4+RZyq/6NmYllGpf2GWLL78zHcvSp77ieIA8BXHMcnhwlpCa3N6P9/m/TDefuqAwG0Gq6M4uP5VYuQUqclGB/le5nyy16Yd5HTFM1nIN4oBlWOx4jbSpmRrtILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RwGhIT1dEwHor/W5paNzv/qpinTLODOGU6kg/2w17k=;
 b=0NSsMHonSdBPPZakiu9QuQGz2h6HtXnOsKfXwYeID0X6gqiXY6Z4B6ojOSeUqxsKEuuG9g0JNq2GWFO2951Rfboes3pEOhvjc/Bmp9mRWZD7IAzBI29pNP1TofraoUMo73USfp/hoQ5BV8GNGwVXhxeXVMi8zPBMOQqBJVuYo0s=
Received: from DS7P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::32) by
 DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 09:58:21 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:2e:cafe::f8) by DS7P222CA0026.outlook.office365.com
 (2603:10b6:8:2e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:58:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:20 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:58:17 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 14/16] drm/amd/display: Check NULL before calling
 dac_load_detection
Date: Tue, 16 Dec 2025 17:56:14 +0800
Message-ID: <20251216095723.39018-15-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d10cc8-be42-4088-eb13-08de3c89a4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Mr/YJ6+pm52gVGwlQc8za9gGRXmBVRIlu1RdgAVt93iJp1TAJBfavS6bJau?=
 =?us-ascii?Q?g4QE9ujcX58Leq8zAoAA+aDkvIrSK8XMgS1G9LrLQL/6PRjWziTFXl/eadCb?=
 =?us-ascii?Q?XSO0p7Ca2U/auf5SF7l1+TzHa0zBLjrVciyFe5uMia8rSOjTULhIyKX8W7aW?=
 =?us-ascii?Q?CzdRI7QgbcclhpKwtotDsFxxHHsjz8v7UC9RU35Hv1RWugRdjfG+o3Qjj+dr?=
 =?us-ascii?Q?CL1ub9TSOv4y+ZqUFaZ0NdndHZGyH/Kz3rp9je2iYuronX0cjLJlZdbwDOkq?=
 =?us-ascii?Q?oEBb80zfyATpDg7KxLhj2+/rmuNTzV0eZTFYveoY+Z2VGblMC60m+eLsvoNe?=
 =?us-ascii?Q?FAqq03f+/+762CKvq733BeoqmYrDWU6vDLJpE591tOAGrxage6F/J7+X/RrC?=
 =?us-ascii?Q?zJmVaNE7Yrg/7U4xDSeW8kM32+hftiDuNr2aFgaHfP0qUyKym8Iw0K9bEsoj?=
 =?us-ascii?Q?3Ex67PigNJGl0pM1YPikW5kZOFetU0MvJ1xbptW0BPmzhFVDvNJciD3k6NFG?=
 =?us-ascii?Q?JcPUbaWe/uzzGk5Bf8DfsLV/rar4ih6OhXUdzcNGiwCTxYYeb2ozdN4SAfMr?=
 =?us-ascii?Q?Sry47p9rArqhbTnIWjLEOCkijvXKMS8dMXJzz1tprsbUTWzsAGEdUTZKOuOb?=
 =?us-ascii?Q?QiwHKPXUQmhGVbKq00RkpNoos5o72uk2nufSaW9MIaEIQkCiXj4ArWWWLHJx?=
 =?us-ascii?Q?XAQ5NG+Sf57Jr9wpvEtDdP+1okAcNjbV+u97W4P8x4Nke8pZ5bVcOh1Z6czX?=
 =?us-ascii?Q?TmPQoJwY9kl0vGWCvllMsmDhxOY66W/9I2/ayDE5Cqk8oKv4Qff+jSTHnQwY?=
 =?us-ascii?Q?NhgroqfomOow4c932TiJ8diN1OtpsSm/hT2URxrlYw7ZqrQY47KyQxiiKcu4?=
 =?us-ascii?Q?/iSIhuepr2CtkE8llWmBjjoP3TqZkZeqDpWU5GXHNCnif/37BF7j5RmTgdzt?=
 =?us-ascii?Q?yiMMqs6IvU0fweAcBWYLGrQnU5CCLqnBfhQtp1QBAFjuw54BqKc3rybCLjH1?=
 =?us-ascii?Q?3nU23r4tbdvWq5isic7bHuu+Q1LgEI68FMPPxLaMxc08RgMI6nsZpat3MMqh?=
 =?us-ascii?Q?FKD0UBYvriVQhy6EVSNRE1cZ6zP3sK3fUKPpeD02R598GEkzYvbf0uDcIsIj?=
 =?us-ascii?Q?jlIC66r7NAl6He7yKw96AbmZMR6v4L+H8zfkexZNRlHlVW4omSEFwNfhCiuk?=
 =?us-ascii?Q?Y2vm8Z54R2XdfRcQ6ZnVcBV8b4M3YvnYQFlXeK6R3mtGxqJsk3pirWlthvvf?=
 =?us-ascii?Q?6b2z1FYeoWCiOUoIF6MeG/iZkkUItnLquntibtzn70iyIe91p83eOxj06Fg9?=
 =?us-ascii?Q?7Nyg5NJtXzwAFIPdSmMeJIfPqL0vKqMiYJYulm0eQzCGQfAh8vV5tflzIHs1?=
 =?us-ascii?Q?BJyQz3qOgf4oIJC34q1vVSQdpdkF9ZDhaI+N8W24wpafVmeMGns72rvSJxKD?=
 =?us-ascii?Q?g9nseC0jCwvyDM+llx6IvoLAhSG8ejylS/+21IHg5xzyYipR0nZ8iA0n5AwK?=
 =?us-ascii?Q?d8E9GkHOVtal04S7UkWLQjx5SD3WrJ06MB//TZv/sM9Zbrv3ZSB5exOShUhP?=
 =?us-ascii?Q?yUbwUl7me2ZEMlMY7x8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:58:20.8621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d10cc8-be42-4088-eb13-08de3c89a4f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

dac_load_detection can be NULL in some scenario, so checking it before
calling.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index af1b456ac94e..56f27a6d2874 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -934,7 +934,7 @@ static bool link_detect_dac_load_detect(struct dc_link *link)
 	struct link_encoder *link_enc = link->link_enc;
 	enum engine_id engine_id = link_enc->preferred_engine;
 	enum dal_device_type device_type = DEVICE_TYPE_CRT;
-	enum bp_result bp_result;
+	enum bp_result bp_result = BP_RESULT_UNSUPPORTED;
 	uint32_t enum_id;
 
 	switch (engine_id) {
@@ -948,7 +948,9 @@ static bool link_detect_dac_load_detect(struct dc_link *link)
 		break;
 	}
 
-	bp_result = bios->funcs->dac_load_detection(bios, engine_id, device_type, enum_id);
+	if (bios->funcs->dac_load_detection)
+		bp_result = bios->funcs->dac_load_detection(bios, engine_id, device_type, enum_id);
+
 	return bp_result == BP_RESULT_OK;
 }
 
-- 
2.43.0

