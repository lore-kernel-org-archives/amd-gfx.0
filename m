Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6F3C98321
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC7410F725;
	Thu, 24 Sep 2026 18:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="srMfLklA";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF47610F725
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhcS8RoboR00JPWjZ7njSvP4mSOdU8bnOOx4XZmdd/DpBjL/zdivKQJRrY+eJlUhoRtChJ/k2eRPMUFYglysAGi+0ORMKxVUpo8Az8C++QPScYZHgLBlDUS2JE3cfYjjLcYwEWLlK8hAprf0jJuMSUvwFZyAaKRbKGAF9jC88/YC4jknP6z0Z3gncanrjIs3yHuWCWjgdvdZy2KgfYWkeoBPuFQuZLT1wD12zvla50veD/SsYn43Uw71itWS75di5Qzlk786ExiCtUCIH+H9aAAQ+jHgalSRCxpoNwhmspXBQz/jFurK2dxFIG7Q3dfs71QSTo8tB9OCyoYWUsufXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ5G+c3ezvSVWMew7oahPZWBNP5Mwyh5Wv+PKBVXKRs=;
 b=JIzT0pkzHZNe74/yevPb87VG5VVLZsSjeATQ7cGvk46E5ktgDudpIAzsPNKHjyWMCpXFU+n8EtJPVTSqBcXrZth5wv/CrZWqkXxyDAWpW2ubhUR0eLRQTThoDQlboSROtewYu7gczQv4zNfgfwkOhHKCYtQSPOgCBWSucqp8lgj6y5PixEngyAZoOGJa27l56jPHLK5YYyqSA2gf/aVXtv+ynSJVDH/bRnkpzvjKhy5Z2+erts0DJMwgw4ehjxoKvzLDRboDkmizomoi7i9ge2N4gCT36+AbvKYtLnnpN1s6vwkCEXuov1ezRDRFgz174Cszsp5nfWzopFhozVF/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ5G+c3ezvSVWMew7oahPZWBNP5Mwyh5Wv+PKBVXKRs=;
 b=srMfLklAbtBvMOhRdAkjUOmWoa1dRF4+RaziVhwNdH0SIUxOvm1DL87kCI9qeYhs90Fmx/b9jU2HqVVM+UZ0YjUn7EWKWX3sSj+5oPCzEG0rZIj5Kj8gk13DoaA0ph9kb2JP32+vJbYwmh9dms3YfrK2mSk5PzXlVtASZYweVU0=
Received: from SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::32)
 by LV0PR12MB720236.namprd12.prod.outlook.com (2603:10b6:408:3e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:19 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::2d) by SJ0P220CA0024.outlook.office365.com
 (2603:10b6:a03:41b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:18 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:06 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Fudongwang <Fudong.Wang@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 08/34] drm/amd/display: Change default SR z8 exit/enter value
Date: Thu, 24 Sep 2026 14:45:21 -0400
Message-ID: <20260924184824.596894-9-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|LV0PR12MB720236:EE_
X-MS-Office365-Filtering-Correlation-Id: 556d759c-07cb-4a3a-a702-08df1a6c1ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8pp4N36xy/iCWQd/k9ervQl6k8HSEITdTMyf2esUjCHCTnnjERMyGzQUIXsv92p4B0hgMaDsrx1kdcAhg+OhgWWdVO9VV80A6AHP3k/aK5MgIqvB5ri2EcyxdjTebRh21kS95WqJ2xNaCiVZr5KinzVNM7jfuKq23EagdcdcOK7hAyYVITFXUEyY1HWbN8gpYcnmAtHGL4uwq7uR6dP+oU5XOKok5CFJiMHuumCmXzYDxpAuJjxZU+6SMf0mQilJvTfI9tXYnDyxywYPYFdH6XTpqx6JfJ6F/45BL8P1LbhFmR98nexDhUVALrlPfdqPVys4oLsmhS/PNroT6lK4+IW5ES3TXc2yDJqzYGYVSeqUVSheEp0juddOOAMTCDfJkCgjw4aludB5ldBA39JOHJsrriVThOuV9nJeuptpAfDqp6pIR0kGcuI2dGPe1ygbnrOu7prrm+RDZV81C7c5wrwlib1e2Jhf48DfJgZZqzdpMjjFQ3bUbSaWADPFuExNg5Xu7JAUyBh8jT3Po2Sk8lxiLUp2f19MvbU69QtwTJFFS+H+S2Q16ClU6+7nH7PLXYt0JxPNrQFcR4YXzCLSip0sNp/uBh/z7M0mp7jG75o1zdwGjPMowKX+LOE6qESIUmvI+DaTbhe31UcZi9tgjYwgATgDuUv2B9LX96UCNYiZp8m/Z2wd43ZgLOPN1eV7DdWN8744OQoKgv4SMOumdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S7JXlrNw03ogqup8bvFN8ZquZG/uV73gXW10EFPtPXjXpMCGNCRAkz0/dtrdMrV0A6N2Esq2MtWd5bT4EOmcSfIhRGdQLdmsOkaH4HsbWSFHldEni0jEKbU0cFJQjrhsHABGPe/RhlsM8PhmQpvZ4bX3JGOHnqIgRipUOC9e/s8RX9UmnyPDjHnpRfcTy8m4/dSOCz1RlpS2MjdOHe3frJ/MTljd0e4edUbQO+GL4Wdrt3CCV755NooUXsTPb3elAcNNDp5NPzQsxEJ7VTwuIp+b5rDjD6dY0oG9p5cJk5aiK5pcCU9h8AFMgv0jB9ePSuyJwzsE1QT1Bh/tOMUW4v9cOaDa4Ore7BEFuXVGly56ShN8jVK9y67UGA0dxhsVFnRzFz2Cpzrg3mHh2wU8/PQZy17ZOPH6lM0u0bQoXLPQbDyDEkQ5Y7lBSBkXepP6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:18.6222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 556d759c-07cb-4a3a-a702-08df1a6c1ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB720236
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

From: Fudongwang <Fudong.Wang@amd.com>

[WHY+HOW]
According to HW, change default z8 enter/exist for dcn314.
SR Z8 exit = 268, change to 390.
SR Z8 enter = 393, change to 601.

Signed-off-by: Fudongwang <Fudong.Wang@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 2f9ae79da731..1854137d5b9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -150,8 +150,8 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 16.5,
 	.sr_enter_plus_exit_time_us = 18.5,
-	.sr_exit_z8_time_us = 268.0,
-	.sr_enter_plus_exit_z8_time_us = 393.0,
+	.sr_exit_z8_time_us = 390.0,
+	.sr_enter_plus_exit_z8_time_us = 601.0,
 	.writeback_latency_us = 12.0,
 	.dram_channel_width_bytes = 4,
 	.round_trip_ping_latency_dcfclk_cycles = 106,
-- 
2.53.0

