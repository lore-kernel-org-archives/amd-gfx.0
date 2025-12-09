Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D34D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F010B10E4A4;
	Tue,  9 Dec 2025 08:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QqvOcGKM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D3A10E4A4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpO6+dFzHFJBCF3IuTSJtuJnhbW6+H9iPOE+mtyzPjayfHYFFY+blA+JiYiYLO5q+js8Tvq5ao5tRXxM0XC86kOrwMBOicmQh5mgnuS7ANpf6tEtQN5xplVNG6Cl0assY6KaJyGkfFGUhV8PWXkwG6XjlHUgIL4Cpv19O4TKddckg8UeFcCp2caVii2lyaW9JF6GICSIE+c1TE3UBU6hBZYDjhJgVbg5aWWO8nnJmcE9OTZ4iECDYPDHaXlwYip4JDmbJbTnwfmBU1ih3LuYAADqGXL+i/8+UfT+/pfPfcoe1CCJ6a803Ub7ZKzu0qryxszfzhi8VlcyZ+CHt0UT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GpTUO8bnMvT1alBLt+yvJ0cfUNIZCimk5EqqecD3Ck=;
 b=XviLfO+Vz4+iOth5qd6b0WkBGV1paNqZynHdffeFWiJsNmM7SfQkuLt143eZNHDhoD8saYkGjACsDvq7uHDWj+HwltIX0SB94cnrBz8INXJueZcUiiw5h0BgZOYBOok6iKLT3Gy5IVIG3j6C6KtJ53SyamEsFuTjr5aneIbpetDqNQMUcq3jVsafwFy29lqSEH98a6FcdbX/ANrzAiMkCnP39s7yoLQR8JirToBahBwyoyaAPAK2RLxN1CnNCMd7woqveknwDrHHGCjL40nNgNe0MiiCI0CG7gPWd98+xRKwGMC9O2C9FTp285OVMmb9+22WXiM3SPtBkY6WkXL1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GpTUO8bnMvT1alBLt+yvJ0cfUNIZCimk5EqqecD3Ck=;
 b=QqvOcGKMUrcCgA0wr6pPdlD/RvmJ3sMLdPgHf/rQs12U8PSMf0ZS9xuZYKvNIOCEgV7+yiiKX6WOPsF7/zdHCgEyOPHOn/ujHJvOIYA5Re2sHCfBLfSQZM9oPOtMq+Hrk93ppWoWhrVIFUbgTL120hm9fMQac1NiLcvlZ+Fu+zk=
Received: from BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:57:27 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::79) by BY3PR04CA0005.outlook.office365.com
 (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:57:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Dec
 2025 02:57:26 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Dec
 2025 02:57:25 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:57:17 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, chunttso <ChunTao.Tso@amd.com>, Robin Chen
 <robin.chen@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 01/15] drm/amd/display: Replay Video Conferencing V2
Date: Tue, 9 Dec 2025 16:55:04 +0800
Message-ID: <20251209085702.293682-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4a5f9b-5479-423d-d604-08de3700fa0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YCfL8NmPLu9+hpgTBWKqvymJbhaXKCCXq5knMDkkJ74PTgrin8wspWkMgMxA?=
 =?us-ascii?Q?CS99jZQADKEGk2IJx+n/Z3Inq7o434Y2Q6IwgkEx6plUcmfVwnxrDaq3OGKR?=
 =?us-ascii?Q?06Yqy51aNOyIazCmjc+iGlNg5xO9oM9d61aeTZQoSZu9l+ObKqb59AhI7j3j?=
 =?us-ascii?Q?brWX1bMqgTDmxQNK9ui33vmTf+9XXfvqLyd3oBf7LEFJ0TY9kUvViPqDUUmN?=
 =?us-ascii?Q?TkgGXWvibFk/hV729Cg1cvS+sAaeut1aHDAd7YVL8AzmGcj7j7eHUJnkQvFL?=
 =?us-ascii?Q?wXjRdLGngy7rqVvAWK3aMwl4X6cor9wWAvOpJsAwmH3bWa2OnUv/OUmcf/Y6?=
 =?us-ascii?Q?GQPoSZ9ksSNHKRmh+L06Hyz4pnARuafjOJMFrK9qbm6ovGjAzZV5BoQIB7Rl?=
 =?us-ascii?Q?GdXOzIv8Jzm4PLlP3pJs6M9xXBvG5YqpHW3oGUR6d21/4mBhvZ1z1aJpokqj?=
 =?us-ascii?Q?PTnCddCzwOHZkCHd6YQB0/e/QUgUnZ+9yookfetl9e7ITQHEb8EXwnLoNtOf?=
 =?us-ascii?Q?qktoldhfv+YJCgcfbRyXBtLaqEx2CssyUl/wFTrYCMHiRKxJjkd26cB2ZGL3?=
 =?us-ascii?Q?JgQFtlUW7Yg42PpZp7YlhZwEzy/lp18RagKfnGTVMoSz7pIH/Qy/SaZcRef6?=
 =?us-ascii?Q?rC462EpAWrzIzd8YaTQ9SuRFxCZNcfDP6oKboafE7+Hb4rRwJqg9sV9yXE3W?=
 =?us-ascii?Q?jQc00iBHQugTzdr3NkcnNOOB5Df7Uuw8WlLyKK4qiIwP72gS4MwYc/Aq/VZ4?=
 =?us-ascii?Q?IpT8ppIHi1TV+MsYq9q6vhGbcv1bc/ltNYOWJeWpDD7/qO/PnVVaVhT7fjBW?=
 =?us-ascii?Q?nvoE1ZbUXGqname4T2coDI3PXtpY4GC/9HINIlHCg3t4RPe0IKRPMfDkCqBX?=
 =?us-ascii?Q?qBXfv3puvaqXzeTmMy5AZureBx26zxmf6bhS1WjL2JDKhdibJ12AzcPkah6c?=
 =?us-ascii?Q?lm2Hk4jcIa/cf/cl9zrv4JlYTMmf13CvXcyd4I4NyGA0eQeionmf3FW6XIs8?=
 =?us-ascii?Q?4EyWhuHHItaArTgUF5/v4MEs/DtU6q4SBBY3Iy/nFs+l9w7eo+WH320UDdOw?=
 =?us-ascii?Q?d7SqKOrB4DKAGZar13FDvtIFtlGw7uQQYqHcYfitYsKdCuWVJsI9b7Epptkz?=
 =?us-ascii?Q?pB2xrRP4WAmqkoGNXaN6MLSVJJFatnZtyJMcHa92C7gnHEwDi5eoc5iuCZEu?=
 =?us-ascii?Q?Ff9w9SiIz57EgmjBEI9rOEeNarg9cYwrYzbYMGMhXeslShc3yzM4eMnf2VDX?=
 =?us-ascii?Q?hNUs751cFL3pFHuIfobTRAenkEf0dt5k729Ry61DfrNCa2uafrlA0QkWx60Z?=
 =?us-ascii?Q?iv1FBNAfjBoGc7Yv+BIA9PKLuuyvjlMZQ1BW3TvQkMmn34C7bdyplS53iPMI?=
 =?us-ascii?Q?u1yLzEF1i8uAX506E7iH+EgHaXZX9bA4rEc1n68ot8Y4HPm5T410TxTAIfXf?=
 =?us-ascii?Q?X/W/iw3iiGiX4icpCQZI0oo76psKA9RviUZiTjdRHRG0qztNe/I/b80neACq?=
 =?us-ascii?Q?bpi8NXgFqoTR2ODL6kq2hNJx0+E/CDsIDC26foewOFoD9CytzfcE/jg7KYTK?=
 =?us-ascii?Q?NWvv0ctKDDkTadqFs+I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:57:26.6721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4a5f9b-5479-423d-d604-08de3700fa0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
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

From: chunttso <ChunTao.Tso@amd.com>

[WHY&HOW]
Add new coasting vtotal type and an union to optimize
the video conference for more power saving.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index f46039f64203..cf4bf0faf1cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1078,6 +1078,7 @@ enum replay_coasting_vtotal_type {
 	PR_COASTING_TYPE_STATIC,
 	PR_COASTING_TYPE_FULL_SCREEN_VIDEO,
 	PR_COASTING_TYPE_TEST_HARNESS,
+	PR_COASTING_TYPE_VIDEO_CONFERENCING_V2,
 	PR_COASTING_TYPE_NUM,
 };
 
@@ -1134,6 +1135,17 @@ union replay_low_refresh_rate_enable_options {
 	unsigned int raw;
 };
 
+union replay_optimization {
+	struct {
+		//BIT[0-3]: Replay Teams Optimization
+		unsigned int TEAMS_OPTIMIZATION_VER_1           :1;
+		unsigned int TEAMS_OPTIMIZATION_VER_2           :1;
+		unsigned int RESERVED_2_3                       :2;
+	} bits;
+
+	unsigned int raw;
+};
+
 struct replay_config {
 	/* Replay version */
 	enum dc_replay_version replay_version;
@@ -1171,6 +1183,8 @@ struct replay_config {
 	enum dc_alpm_mode alpm_mode;
 	/* Replay full screen only */
 	bool os_request_force_ffu;
+	/* Replay optimization */
+	union replay_optimization replay_optimization;
 };
 
 /* Replay feature flags*/
-- 
2.43.0

