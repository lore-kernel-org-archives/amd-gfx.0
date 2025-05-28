Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3300CC54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37DB10E56C;
	Wed, 28 May 2025 02:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xb/KYtfL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEB110E56C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcSlNg6giPZrFjaHTq84Ymx1+V2M9M+i0bo+RZKmae3YC2pz9awrfB6vrXdaSAQ1ejJ4j378iTbLV7tZdJlmjU/Dw5JBFbllKVj+fAxv+QStuU3Z1uBeEruP9RzTPPKI41n1RFdWuBYrFFsP1c45+VDvyzdRBRo8b/lkoSKZJ0Nu56nyCP0nudC5XGk0IxKCGrAXrUrBQOncvcXu/j9JEA9Ddj6seVHxFo88FEmDakF/OGyLIY6PVjsDsUmlYZPKd2sZSf8JhWsZ92nda48n6e274+ppDi8n+aJOlcq2wjYlyHl0TUuGC7S+QTp3+XEevs/kWK+nWMQlXSNl5ytmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG/ijGVDSrMx7Hc7Ebu1J5AafrZGqcwKbqW0E37gEcs=;
 b=LLreXNvdnWGJ1nRBgEi9zBaEluMXekzgiyY0T6j62zJ35BOd2QlpHWhsqaAhNC/QYFt6goYkFCitG+2ltHiPNo9ErYcZ3DtCohu6B6SH4afv8iY0TYkkKc6J+X4IwjfcBCcvMeL205yBfFfTn+4nD74KVvJ465AbiFYkbS2eVqkRVv9N13yjRIaW9oMlKVArxIuxDklh8XiItmcMRl8gx16DINVQ8q/THyA5/2QBiANEIH9O8eMNP/uFfo+QD/fb8ck2Uk2p2QSdAe6pvRQ6W0MKdBeSn2zJAka7ja7yMRMrWN1xrYQHCPvpkuzVROySmZarQMHPaLivfj/yquN16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG/ijGVDSrMx7Hc7Ebu1J5AafrZGqcwKbqW0E37gEcs=;
 b=Xb/KYtfLo9kaVsMz3FaSw7hCpbloH0wYC2FajSBXpWN1P12xHdTEJfvI+I/oBUjQVCS3Fh+v85lA2t9oIavBi0BOiHmRawvc2hJZcNYoUDtMxfG6MBUTYafdNTVuavnLB1YlwsBYQiKsXrrMtWwOlu6HXqApYhVM2jJ2hpbnq/0=
Received: from CH2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:20::35)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 28 May
 2025 02:54:22 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::e2) by CH2PR07CA0022.outlook.office365.com
 (2603:10b6:610:20::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:54:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:20 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:54:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 23/24] drm/amd/display: Fix default DC and AC levels
Date: Wed, 28 May 2025 10:49:18 +0800
Message-ID: <20250528025204.79578-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 99934078-64e5-4e2e-3c81-08dd9d92f29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EskT16psUmP7w7G1mlr++zYujHMpRGWrp1ZWwaEjPnx1VRYLMZ8wDP/MmNMv?=
 =?us-ascii?Q?FK0TUa6aMwpFPo2bKFlQvPatS2z1q3nlpc7S9u976uNw2IOvu2TFQM8uR7qa?=
 =?us-ascii?Q?3OgR1d7jArTkT2/6T/0KGKOVRM5WzvBT+71l+FovABYrfYzTGMTJM5D5HZRa?=
 =?us-ascii?Q?JtKofXCyjVQEkUDXrLccNrYSf8DRCvqkifB9YuHfg1c5SJlXk9jbjiTKwn7d?=
 =?us-ascii?Q?1gjxYbELmrwbjA7Y04DWzmgBZTmPCWev+Cp0BRnMWYQzctB6rkdXg0kIBPDq?=
 =?us-ascii?Q?HIopGnPKmlXUuaWN/qXSK5Gau4eApZCtFdcEt8DTJBg0C1M2d4KRu/4iizaX?=
 =?us-ascii?Q?1Wm0EGJYW2h0+GlQaMtInfg9KRAYf4sB1XSVE9d3ZAVvkZhCLiCu6af2XsV+?=
 =?us-ascii?Q?4UrqQFuzsn9MYAbrCcYeJ2S6M9jfoTFp2GzbM/XgetTAfdqZY57vAFT9tGMw?=
 =?us-ascii?Q?lEpDyfam4/3kuXEAkP9ZkEI2GbJmXE9Z6qmd18MhB45FlntDmxY3A8gjl2C2?=
 =?us-ascii?Q?1nCA8V0JhwV3PyoNNPL8kQ37b2NU0NEHEvVABhIwuUoM4GkjDmIyYV2wTD6B?=
 =?us-ascii?Q?Ax6VXUoLW45CC8tNlSCF3K0X5vF75VyLU+pMdMQHwwqQuUajWi1GAdpuGoC0?=
 =?us-ascii?Q?llwuEHczdHkNPgnEqdeb85b+vAQNf/iO85HwTOx0Vjwhp5HqRhgdzcdfBTQz?=
 =?us-ascii?Q?Y+KaImPDZ/F4WheOjqxLQ4fIgqa8Cj1PVGjC+WpkuMGpduRnUctKjso2ljWy?=
 =?us-ascii?Q?VcUbeCdnTYBiI9aHQbKLvtflyU9yVppbdoz0HsF7mVcaEPOQFngFmDnSoqxs?=
 =?us-ascii?Q?5uROrfZ7sI63fwetN1dmOgX1GNnugHlqzKfsHs6YcI+qzTrZ0ul+OZrP0bod?=
 =?us-ascii?Q?wG8TG0DmDWRUFV4F/6en1pxCbwv8zHuf6Ni2IHYGEqFvQnPNBpA6J4EJjnSr?=
 =?us-ascii?Q?/gRwHm1Rk+f2rN0sQzdrei2Rgf1LweHnI1YbG+OLgT9Qrbok3UrNdPp6RkCl?=
 =?us-ascii?Q?X9Lq12lmcyoRZETMH6tnMmxc70aGayyQJKm9mGSYG0xbxpwisOP2gyuEHaDP?=
 =?us-ascii?Q?pOViPjr0vm5yPbFyD8bScHNv05V5HUQHsSNcjcLxVc5CThAXebtkgS0iQQ3J?=
 =?us-ascii?Q?G2BrE/TxJHsbSPwyJYnNBstRvitP0ffelrtdBI+HHvFMYWGGYcrXGe8o1k8v?=
 =?us-ascii?Q?2u2XjCu5n9jVyFJ8qAidUE++Qnjw4j7HQQeTgc8HOjqrYGAn0ovC2QmMQsXQ?=
 =?us-ascii?Q?27jj3RCCfV17t9GJan6dlNY0O9UJ2EG5T/g+QktKlm/yAZRZU7ImWyS/A05O?=
 =?us-ascii?Q?AUzmtIbEW1hc+ZpBVqiK5DIIEii0ZTBLQJxPmOj4emMccg7i5LQMAwfS/l24?=
 =?us-ascii?Q?s7C70x1SyfFmpWXm6CZGBrUjjBWzXpHSiwKvCSw7HWVTv77vzLUpUXsEVTfo?=
 =?us-ascii?Q?N7NdtzOBCb4J7W5R0LgpiSLRTqRluV0scr3WA0YfE9Nb7gs97FOQzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:54:21.7121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99934078-64e5-4e2e-3c81-08dd9d92f29d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
DC and AC levels are advertised in a percentage, not a luminance.

[How]
Scale DC and AC levels to supported values.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4221

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d9a339d12eb..78816712afbb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4926,9 +4926,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	amdgpu_acpi_get_backlight_caps(&caps);
 	if (caps.caps_valid && get_brightness_range(&caps, &min, &max)) {
 		if (power_supply_is_system_supplied() > 0)
-			props.brightness = caps.ac_level;
+			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps.ac_level, 100);
 		else
-			props.brightness = caps.dc_level;
+			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps.dc_level, 100);
 		/* min is zero, so max needs to be adjusted */
 		props.max_brightness = max - min;
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
-- 
2.43.0

