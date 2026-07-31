Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AFFC55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E1F510F3E9;
	Fri, 31 Jul 2026 21:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kqCbzgnV";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010064.outbound.protection.outlook.com
 [52.101.193.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 911E710F3FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/ofMMlvUHnA/gdY9/syGtjq0lFJAZ3kayvrUj+XJTbk5YiT3irBFEWPYVoW+JjDcGoWAaASAvZJ/kbMuwhwPwBGR8sIrXylcrVN0aiu4fhSZJ0OMA/2Wu6HkdsANNqkkrEHOgKXAodN4s9yj+zfOi0C3efDfhDjYlVnfR17M8m0gFKlgTmiSgBPwA2htbIQ2wrHxAsAqETInvAAXh4tEELrFSQhZbc8G9hdzezilYHP5/rQEE+X9cRYvrLyP2/eN43rVPDWqyvO70H82ZNeoMOYMHXATVp3ifsVCljciPdtxqV5CkftY7On28ahD5e8ir2CP2xXQYB+ThDlVehZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFH3IKL4nM3gKy/fIxGtA+5osj1v6wI6Me0TWTJSm6o=;
 b=kpaXsnAVL4cWgZiFoOY0oN7ScETuP75bEKFpZxqloaUyDHrlpY+IGp/OSMzoh0G24GrnnOm2GD0FOLEFnjSFudj4UI8hRrUEuQcnHdheoH1DXm+CMR3haTFoPdKC4W+Oast0HtHReLIj/4EARl5JEtxEJbQnaGhLHQR9R8IDBY9qvqQ4yc7y7mciF0482UBwSOdbNJRXZCgRKWSnR9lxGOMzJeA4TqARk2/HybZbLbSdcnwjL12pqyXs2K3LEi+6ejElgXKDBYOkdw7//Ijhh+RXJLId3Rjo7P5nzO3jkJsPxQQ0GzGAkk7Xwust2sycwxuQV7d1UADeqbiTc0MZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFH3IKL4nM3gKy/fIxGtA+5osj1v6wI6Me0TWTJSm6o=;
 b=kqCbzgnVkFgjuwXaJJVN3XAEGjVUOkBFfHbNIIjB3asau407fdRHeMioc6VdZ09B1fyIKd+Q65CfinIq84fDqGSUGPyLa1E+4xeVDptnszeS6yKxqPKJhH6az265s4kWEww+5PSy6T6/mtbOKJFLnYbN0yoUCLTr2Vz1I/ijNBE=
Received: from CH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:32::21)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:54 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::a7) by CH0PR07CA0016.outlook.office365.com
 (2603:10b6:610:32::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:52 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:51 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sung-huai Wang <Danny.Wang@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 24/41] drm/amd/display: Increase fclk change latency on dcn351
Date: Fri, 31 Jul 2026 17:12:45 -0400
Message-ID: <20260731211302.3040343-25-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 6922433c-94ba-4cac-7e61-08deef48e812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|30052699003|376014|82310400026|36860700016|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X86RO9gi2QoMl1aZ6CLtcf/Pw3caW3QxSgE/sgcp6YKEwnlB6IvKYaPOSGRVuth2DfvTARbxKpurMT6iNaOwhMPHZGOCCsNJyqdZRIu4buFHT3MnJ2zG9E1P3Sio/WTuR7pp5dC9MkfSnbjwLnuDqSZmcbBt/SekuZoE9a87zB/Ee/hDblovHIVYA72YeIplvefle69c/bHXpYMyAoAwsCzinEa0fV8RON1U5hNaNQkt6JNY4YrIREat3psOgxPXoOsd6C9EATBz7ZK2UIlPAI+u2LK6SmrF/QfHzXsrySBsMVPuGslS+s92jWuow5ZpRpJE6WZpCagLyO3ymhTsiF46opWdRQp5O7Yj5vDFp629kv11yvI63pFbqv5+XUwtnFUKKMi7bqAqugIofr1T7gzIb3IW5sLFNpq0VBWXRaGAx1+JjZVn21VB4ysdTssop3BnfnURQ3oxmcVWzfHSPZgQxq3oVZJ/Xu/TeWJ+vu+i5tmZYDfs39PALyaSIwB0QCaFAda+K6CLNvuiKHZuVjGU+XyBY9jRX0POBJRY6bP/cGGoyDNyyLSm6JSyHLLm0Gn+z3OKYy+mBP5ni3VDimkKHHe+9BZHoExZ1OgQvO4mg1hlHt68Z+4FLPEO+uFUZlF6PBp82aOHSpzyzGhPID2pyXHKas0MAYe2Xo6p9+2L+h334W+TB2NM3MWliMIQe+5LC883PrDjbMBWCSDBDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(30052699003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0kfd/SBBcDGEOm11DEJEvJfnwAHD8ON2wg1FLkbLzERLU7yUMErIGvhljiBNC7FiOArsqAajf3c3Q0xvWRYCFrQP6ONeZE0smgJZpBMItB82jeqfPctsmXeSvvb3sccF1utElXxdXVBvfaJw/zBS/Zj/qWsDTzsJUf6HMZOSZKOhDu91mt8K5fyxdcUMDxi6aqqW7evmjlk8d9zhA6+W5eIIW+P8YebhIXlgAZS1/rXvbHzwCh3Dp1a0R3TKvKSvxsaKYBCXk6vHg+It5ZCpvL0Mo4loMYpu0C04wvxLjkVSAyg19ffv0dA9Axw1tIOXuPSuL6y6Znwcu7pzdzbNXQMQ3JNVwx9WTLbAnMFAANGjs2qbbtyi//v45BToCVk9+6a7HwR/aP5W/9kj7FdQ5WaQaj5/XVqolTCaMR4qucWRrHgPsVJo6YCeelu8vl7j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:54.3076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6922433c-94ba-4cac-7e61-08deef48e812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816
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

From: Sung-huai Wang <Danny.Wang@amd.com>

[Why]
fclk change latency is longer than expected on dcn351.

[How]
Increate fclk change latency from 24us to 32us.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Sung-huai Wang <Danny.Wang@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index 6552b26de845..0c5a2667d526 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -206,7 +206,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.sr_enter_plus_exit_time_us = 30.0,
 	.sr_exit_z8_time_us = 263.0,
 	.sr_enter_plus_exit_z8_time_us = 363.0,
-	.fclk_change_latency_us = 24.0,
+	.fclk_change_latency_us = 39.0,
 	.usr_retraining_latency_us = 2,
 	.writeback_latency_us = 12.0,
 
@@ -215,7 +215,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
 	.urgent_latency_vm_data_only_us = 4.0,
-	.dram_clock_change_latency_us = 34,
+	.dram_clock_change_latency_us = 39,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-- 
2.34.1

