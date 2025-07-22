Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C656C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328A410E724;
	Tue, 22 Jul 2025 22:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3kPPkunO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0990510E722
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVkRb33G0ssyzgnYKmMS/2yrhSINJ8ExUnbK2K1FobWvQIRXagkbfmuVpe9DdqSonISkVL4nOUWJVhajSTpyF7p3oJq8tGZSPe57gkf9ScjhpCoL9Ajb6cjooxgiVsvv+wusjhnp4j0s3zNljkc1JND5/yYg9VF7oH2wYjaOv/E2GovdMaiQQZ7m0mDTCZ9JA0qP22KWmFAGIqug7RInEH4OeumnZ6AVAQLkeo5wWTaVT4LBPjGjmTBqLJeMdF5+7vTfQFJXjbgsqOJPOZvPsf/6uDOeqPOU9uv4OEBzivoG/nhVUNSA6ezIt3dsHQevmvwMu2Je81C8MHt2gsvNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wWwChqH14SZJ/eb6gIz0CP2JOlphuwtIL8/FejB+e0=;
 b=NJhNNSVhmi9NSThV+kfel18u/uba9X2e/s+v3HU+f0KgQEFM6a4EJ4WKoOWle1+frnbIyDplFjgHz7PNO5LQkyI2yY/4BMfvL4qp1FvHKoHvIpoKQNczwT63NoMOUdqF3aXXpdPrGi3poUftnvej/38xJMsRVWKSeSv7XDAdoeVzc6D8Z6WDc1IXQ1Avi6csy/JHSwbNlbmxrKSh8wkqV3vBSwtXABrDkDQfMr+CsNVg5fE8+8A3GgmQOIDdZgOYTFaijznItMYPuMKnlc3jLbRpcSAOam7k7eRjeQpIwDpnyjznXZDN9oHsC3HyUv0CgK9PtPZtNJ4m5gRjWPjO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wWwChqH14SZJ/eb6gIz0CP2JOlphuwtIL8/FejB+e0=;
 b=3kPPkunOYzMCKAObj3VG+P3r05kXXs1Nc0qwoGyRLCjW9l5F7x3ftcv862iZwlxYppkRiE5uOsEMwQonNEHJL4jjZ4/R/p0qi0JKJhCSupSkveZEyK2Q2aQWTeDaWAOnCYSWVYToulghnnnuNgyrWHmqWkQBzjizApouiME6vkM=
Received: from MN2PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:c0::27)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:39:25 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::7c) by MN2PR05CA0014.outlook.office365.com
 (2603:10b6:208:c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:24 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:18 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 06/25] drm/amd/display: Disable dsc_power_gate for dcn314 by
 default
Date: Tue, 22 Jul 2025 18:36:12 -0400
Message-ID: <20250722223911.2655505-7-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 58acc1b1-d44b-4043-475a-08ddc9709bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4GgDSit5tKLuAfcFk83KUI5gKqkcvKissH4lzQS1EHjGaYmVgJ1JjJqUrE0S?=
 =?us-ascii?Q?pD+HbdDuZtvV3Zm5qGtk/XqtxgvrbSJhLOtDibw6CKREo9yFaNsqQeYuTcKQ?=
 =?us-ascii?Q?bMdJxivsrNqq70Wz503arxc0Lz0W+AexyS7IWfOaX+rIWdzQuR2DyH8ZIGMN?=
 =?us-ascii?Q?VW5q6dFjunkmos4lsO+ZWjE5cCim/cftMh79lqWg1zkE1vm9SPfYob9kB175?=
 =?us-ascii?Q?Mur0PauTPTzXfJAgBTzz8Jnnqsm9T11NWjTre5ZHcImI1sPdURwpNiuhuvtx?=
 =?us-ascii?Q?jhdMo4j/HSuZzNSbEXFmJiLL7mRiKpheBLzlYWKuvAbpKKL+3ZI3zwU6Fswf?=
 =?us-ascii?Q?nJ2F1l9Vz8R6IvLI9pfhia3qdWJbX773WPuhliwx87PK3MIpzFd2S7srvT6x?=
 =?us-ascii?Q?Lz93/f6/le8HClGxFRpa6lEw81XRqgdKFCj/XgFha/SWOyBywoBcn2WwOeVR?=
 =?us-ascii?Q?OxRLRU+m2n5/ivY8aAsEBv5t3mgR0p8WoRv/qwWPj+z9UNca3ar4cM8xRc2m?=
 =?us-ascii?Q?K5Y6SGt7B4TnDvI7dhoBJc8q8eTDoJxycG1ML8DcUW2ZziGE+hOTndtMwyco?=
 =?us-ascii?Q?C8GuLMXIfatIZlUMCPNrL3C14jBOMK+BaWhDtsw+vb671qGe36nvTQDgtGa+?=
 =?us-ascii?Q?3NMVI4T2KbjzeZzs5ZPXiRORxh01rJPg2W89g+nXvLRS6RXU059Cli6VEJjR?=
 =?us-ascii?Q?AhERtQO3RbMwQlIuy/j7PS67pYr3KHljgXNb9o6ftHnVjl1/W9GfLE1nGRJT?=
 =?us-ascii?Q?DtlY0pvbCt9KRl0M3HQQEBuvJpMEx27rx9XtTd0tDwaXOcjaQI/MsdnLNFl5?=
 =?us-ascii?Q?pKAG7FRsU6Vq4mszAFZtW8LpzO8yw21OJC+1GTPIwNYFk0Ix3chSTHuaTK6G?=
 =?us-ascii?Q?RsQdFdigR5x68WkL/RKFuatueJHdO1yx/j9txUQ8w8DveEMAXklD/+2WQFOy?=
 =?us-ascii?Q?hanaw8+UgZGQUuhioUOa8OLFjyw6oUZv35YZXj88E92URCO2AyvIAAnMBPCi?=
 =?us-ascii?Q?vrKThKdD5jebGsj4+uUR6CKMwEWK4im5JtkBjV08eFAIjVBV6ZuZ6eFNrmSm?=
 =?us-ascii?Q?9eW+8pEEu6bM4FqPbEKQ4ezzce+kAt7zWQaV2e++ISz8YQBJFuuJrZNxQJ6X?=
 =?us-ascii?Q?gmuHrHSLi721pYfAfjm2Y9tXz36QASjQspRgtr0DwPzDMhrVnDNBL+Gu8/V0?=
 =?us-ascii?Q?uxNerNO8HY20kb6VaRHxLZZMTDV5VXSp63wr2WYjTIic3Ku/nqT045+CSFpx?=
 =?us-ascii?Q?GOn79DQ7SaqCcB2JdbebBfElTxHaPe8nFXM/Mj3cFspnJeNbDqRElQt43Zyu?=
 =?us-ascii?Q?o/0o7ukRQo7PGDHX1D8aFmoItUjolubvi0nL+Fu/Xwj9++9NspGqFJd2+gZx?=
 =?us-ascii?Q?onv45ZXAd8ZcnhJ1U7sktdzOLR8FsxK0Xip66NZETM/FSCQW8RBwpYg8Nrq5?=
 =?us-ascii?Q?5wTdTOt8yWfkh5R9UsfLoXK8bW5EJFXWzHwj6cimLR4AGpD+BMGRukimnzKQ?=
 =?us-ascii?Q?hqq1VCwIT1NSlX/5HhkTn6KHiNbNxJIby81G?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:24.4540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58acc1b1-d44b-4043-475a-08ddc9709bdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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

From: Roman Li <Roman.Li@amd.com>

[Why]
"REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line"
warnings seen after resuming from s2idle.
DCN314 has issues with DSC power gating that cause REG_WAIT timeouts
when attempting to power down DSC blocks.

[How]
Disable dsc_power_gate for dcn314 by default.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index de708fdc1e80..663c49cce4aa 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -926,6 +926,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.seamless_boot_odm_combine = true,
 	.enable_legacy_fast_update = true,
 	.using_dml2 = false,
+	.disable_dsc_power_gate = true,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.43.0

