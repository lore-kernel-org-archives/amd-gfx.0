Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED69C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C2910EAB3;
	Fri, 21 Feb 2025 15:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JE3SuuIh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4885510EAB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5TyclF8LjODPKLDCxn4rUCo5OjgeZG+1hcG5PPtIwvmJiqIYe9JFJcAhJtRlhNGlnrXxILBT5QjdBX4nXRMCtbWzVJbbTxFugHq2K9QgzP+iJg9WLGabCjvTDS++afmW3w4YdcS/gj2kFP95CjLhXKj9Yd06eoF1KZfdaKpXu7GO8CUMRMxl1hmVHeZd4jxo2SDMaWoFYzF9LZpSDo6aUdbN5eiqaaLA/CDjq6O7oun7Sqbnc/PaEQsg5Rko0zyRnhip5bgPsQ7jlmrH+Ttr07sIdz3wdXk/ATYTTYqMzCcW5jtLPRIhPhjicINseZBJ8q9sYw6yaAjhNVH5anDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJU4Wj+PbnCcc4nNQMDVV84D/B7KdwDu2rWt/Tuv04s=;
 b=cAaFvBPfC4u5QtyWVQxtmRsR8d5NKr/twWQNa4oT8yRoBGg7dJYppZKLC56wmExRIA+FZ56av8dMb2nj/8xulm1Xoo5C0Dd5F2ingHKNmrK09dQf2qT86D7MOmeIKtDyGV7NW9dLKzvE/O27lMXFWM7Cu2Gr4hXSyetsPlkyvA9jjFkz36Bnwz+kDxwLUoN97yAAQ3G7qdLMgaSv97XAOmAIzv1ZzgDuQm147HWcLeB76kKAgisng5+qVJYg8DB/KjhLYRJ62FpvQAxZqfGgTUZUaad5ond2mpTBf8JFpwCUMiPcPpLu1VrgN0RjzhyWAxMd6ZtJMJzQ4u5/7XIPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJU4Wj+PbnCcc4nNQMDVV84D/B7KdwDu2rWt/Tuv04s=;
 b=JE3SuuIh2wNty/002+2Mum0hLAIT3P295QNpIMwhfil6C5HSnuuqy12wTKCHoVtOchLIuYd9/9VkuLjAIpQBEt6v4YCLr8LPlmjASe1KEGKVFbqmFB0xf+BS28rTJTgMRN1i2xp6GD4xafrU8cegW/Pcb0I8vUglBw+zJSXHPJ0=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 15:43:43 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::b2) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:43 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:37 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Apply DCN35 DML2 state policy for
 DCN36 too
Date: Fri, 21 Feb 2025 10:42:52 -0500
Message-ID: <20250221154312.1720736-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 02448186-0d30-4f34-91bd-08dd528e8577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kb8dOgvzFSVWFLIQxOibgN943cZAhun/o69Q7Fv26iPsK2CE+SmQhrRf0TY8?=
 =?us-ascii?Q?6+uGJj+QAX4S2PsHvgWxHHN611CdF0pJxYAbavX7MDx43hFEV0a6RRE0yA6Z?=
 =?us-ascii?Q?lGbxQyYPczpVJuu1RF1YJfSi7/YGkp9KodEYFokAlO2mQUGg+Pers6CGGGL1?=
 =?us-ascii?Q?I/30wr/+YgzM1V2adKVSmv0rmEP05ghQ4aF+B9pwZRaQiceJXrciUiuYudgz?=
 =?us-ascii?Q?0y36F6SKoGqS4KCjhRcUs/01TfGDxEr16siA464WsFiUleCeoI2JMPGbUfe9?=
 =?us-ascii?Q?2zQj3IHLxhpo5hyf0iUmO1CsYYEHKODb4djybS57U7K/yeu1pmogedeayCIt?=
 =?us-ascii?Q?RqL80RzfuGaNigEg0TBCKTmecqiZIPvivAwBbuJIupGXNheK8+35WklMR2e5?=
 =?us-ascii?Q?GXHHYw8NMDjMO72QeVdkv2P9epnGbWm0LaTXmUUR7fjAFk/NMI6YqaMCa7dB?=
 =?us-ascii?Q?aY7BS4lfcMo8YpsaZVHMOj5tfZEHdKhVqZGuttjy3IP03LBWFSjKAqa3SMv7?=
 =?us-ascii?Q?6D5VVXJIol1sCFWMmXCLYQoUAmddGJS9U8/bmNgQqqkUgNm2hWCHA3O7ssa+?=
 =?us-ascii?Q?KZqfvvzsic5tyArWP8MarGnMrJ1Ufj/fgvlNmYnLGedcwmAb219zUN4v9d3H?=
 =?us-ascii?Q?AQRFjOvFr4rwNjJvqOGdGyDARapkXPUXBXCxZ1+OdLF4YyAnktJI6Jc3tvpi?=
 =?us-ascii?Q?UKB6vMOsUqKj9ICLnArJhWMTXKP/bmUW/o0e4VTrw+6SHLs+SMfxrgLXnEBR?=
 =?us-ascii?Q?OP55kmcl+hZbBkEZ6rIKV3lk0GRzDSYlmooxqGVlU4kbI3Z7q9iFcf5v3ADU?=
 =?us-ascii?Q?tHv/IeDGESIDPdZc68K2Xm9QPhJFch/PGbRjdmtam6arhBnTgBnGCUCtMQXj?=
 =?us-ascii?Q?vACaDcxrrWV9TPIKCdlkw8mroi+XeATLnP8cQCjPqkUgDNo4fQjhQ+RzX3wK?=
 =?us-ascii?Q?QmrVNE/ejuw2BJj7rzZmBjYeJu8UxHS0rdIojqYJqvqL95cfHvX7BhETBfjY?=
 =?us-ascii?Q?qGkfd19bd9enPFdDPbw1FvkaVv0v+qfpiXfHQDmrKEDXHiK14yw+POw78ZuF?=
 =?us-ascii?Q?94pqVNqZTJP+fFPtRgVc3m1n7fxY4rD3NnHE0MFODzyQk7X+96KAL9BT67h8?=
 =?us-ascii?Q?eJmKmUvKHsKjJY/g/PGtQfUPcvfQD8eVEIzMFD0IZH4YgvC1YWFpuIx+rSS0?=
 =?us-ascii?Q?VcA282aiUPOnnj3CH1rkCz9ir4UVu3/iPhFv2TeyKXPYpE9SIIOwb4h0IAuo?=
 =?us-ascii?Q?obreNfWahyLS6+9F5nGQnf02u7dYZQ5qzK1Qis/W/VqkQe6Ol8okzygDjQGb?=
 =?us-ascii?Q?4YWp/taARUJTbpFhwEQdRw/fFBYRt5u0rs12LxY/+UmZrDWkg8a7p3NrzbiT?=
 =?us-ascii?Q?4ZQ6EZQ9qM0bZrBk9SbdDH7+bzmBkrK2sbUM4vfOxPC8CXGTZXP+G2C3Y4re?=
 =?us-ascii?Q?3+1c/1pz1YIIdK11QyfhknsiEw79FiijwCzv0ZA+0pT65rz5AR064OqXfiUI?=
 =?us-ascii?Q?boCLZKrStYfnHGQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:43.2955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02448186-0d30-4f34-91bd-08dd528e8577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DCN36 should inherit the same policy as DCN35 for DML2.

[How]
Add it to the list of checks in translation helper.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index f829d5ac7c8e..2061d43b92e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -557,6 +557,7 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 
 	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35 ||
+	    dml2->v20.dml_core_ctx.project == dml_project_dcn36 ||
 	    dml2->v20.dml_core_ctx.project == dml_project_dcn351) {
 		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0,
 			max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0, max_socclk_mhz = 0;
-- 
2.34.1

