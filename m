Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8559ACD6E78
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1953C112856;
	Thu,  4 Jun 2026 14:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZjcNqHPj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C32112853
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha9+MahUVzoZIjCIpjYafibGy+6xd89KJhXqpuirsiaB7FA+Q8ZWepiz/xwXOWm0lHWNt9PxvsIroE8RSWWDxELZF5vODzkwfpjpzAvNxmfhYaQQPoAkrvtFCAuQkKI7CHxhS+xwmhR6kuura51qXeXl/tBY/mvp0VsuQ12h2keA86BTI6O0gFCYhKzYxKKRm4kup504ZpEmoBQndwrBCwAufwSn+BuO7i5YqR4uZp0KlUldoxSAmjt2SNCXn4pEuk0A3qZM2M5N3J/2xB8TWzpsxXoSbX0txZ3sybN51qJiLg4n3itFGXYEVB8x0IMW52UN7KpYqNZDwgmCxjzDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYJbym7sYvdyY5PMK297kpeidRsVkTndC61mV46DZ+8=;
 b=fbDX4lv72IpSEJesto92QjifqZy6ohr0CCwAlFW1q+ObDNr8J6aNaoOJK8HqP9NHpseKsmK1wjpy5aGx/zP5/n4ZJ8fQ5/2NyMHGUyKgnWUTxMwQoMnUB2N34GyPBpOeyx36+yOwEgJxoB86/XnqlzB2If9WA5VYlqF8xLMq+rusnclBzYQgac5H1gXj7J0gtV8RJoAGk1Ak6DMQR+rRPOPjV5FE/4oRcwpTU3DqxpT73NwOG0sqZdR446j2/+9EXgBnVtqzLOWr/e9J707XBe8ZDjsUHFP6v7FzqI86EruVPY378dz5VqZLQoQPlzSX0Lg+DyyiKezqkdyrYcN9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYJbym7sYvdyY5PMK297kpeidRsVkTndC61mV46DZ+8=;
 b=ZjcNqHPjJEaRlfYaY3N6P6Cw6jneeDHySzy4QnDI9KTzIgPYnMoFhsJRrab8OfR3sGJzaYjp9y75By2iNSdJwB1N80OqGDsgHkGxVRl/pZAG3Mc3vgDqNR6HO86HI3L2hyA0GUdtN003xnCc2OI1mXwgiLPN0KYKJbhG/Rc5ekY=
Received: from BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:31 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::67) by BL1PR13CA0387.outlook.office365.com
 (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 07:55:11 -0700
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:11 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 24/24] drm/amd/display: Promote DC to 3.2.385
Date: Thu, 4 Jun 2026 10:52:18 -0400
Message-ID: <20260604145428.809959-25-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 637e54e9-4c52-4557-84f7-08dec24952fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: s0jGC1acAFWpUj+ACyWar/vGlDIWpO7NJs7VEFBx0TMzH3/yCc2UiKU1PSCydAuQpmFUJatGnRQEeb1qEXK3KO/FU3YbI4aV+9CouQIPkagzAGbvVZGbK49c6SUk8W/sO0gXYdSjmXtXkPQdH1RBp2okOSJ3f9WLYbHl1C3Cv5Cz2znFPKFIGxU65fxV+xrhQjUPCq+KOz6AaOwnecV3i289TsNftNvXDma7eRlwdJkNLszUD8rbVvFO5eDDBQ0blPYwVNFmIEuZpBuOjYCaVhPJgCA7FRxVkqZ8PPo9Pyt2qoSSzmuOTAgqjTGx4pS5dZpgQo1WNMpGb6Ki/zZPw53wa4i/8VpJZRqlDShLj9qAm/RIlixQ9azR9uNLhGVc+cZorjBvagFhp1SqRsJG/zYmTKq5VcZTFosIOSRkO0g6A/lJCRT0oX3Aui4yQRlhlZWFeBU2Mhcur1otnkGhLiDUwKoSBx1IydGVe+KQ1oDHmlxXGiXDJxHiZvJp5dEqdGhD+y+mDYrulRKSDu3eU+TjXguv+Y/9aNw4MZ9q4PJKX1fA1bzKEjE2eSYAd9eI+sRUBOMgnRA3U8PzorUgbz0J+FCtyXU8TYnRNDmVXfCf8M5z6JibW3muqH3gK6X4FhudDW2Xd965NLqSWyjH8jvTk4pBH/YsLq1Lr6v2zIsqgCLpwaE6PDkOg18Z6ci6PGYz1qukzERJUSsbyE5lmrg4u5FwK2RDTID4MXaKK4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D2+ikwVPmJI/2UoPkJuYeqqZnm0zuT+x4ZNFVpcZmumY9ZnqTXb5vwcCwfNmp2empNyhaPYd6U9CqqliqzDNXJNOKfaYi89GpfUrHcFBR3O4RacbAToQo58uBsyqvdWJFZF410QM7do6w7UgXjKx3KBxLBMRcXvqIRBzGGtExmLemQEPm6kwafAlQATLC+RwLS6hZkfhNcoXXR9u647IhvVqyO0RGnVkHAKOpm7Ib6vfhlOheBzc2J+sGnB3+Al2Dne4Rpgys4twsUBbONKiUicL8z2gKElZmtnPCxmbCYG/Tv1ffMFf+N/PlYq8u0+a1n5nEY6BP5z70g2+L0p85TD7c2igB4G8q8UJLSBz2TM6EPrI2nW48yU+9EstaMQWzcqA02Z8BIikto0H1PeEYGLLcMV3b95oThMqKS9fNtyeRBHwpaB/JX8IxEqp4AvZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:31.3374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 637e54e9-4c52-4557-84f7-08dec24952fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary:

  * Display connectivity & HPD:
    - Retry link detection on resume, boot, and hotplug
    - Refactor HPD RX to use handle_hpd_irq_helper with detect reason
    - Always create delayed HPD work queue
    - Restore periodic detection for DCN35

  * DCN42B support:
    - Fix DCN42B version detection
    - Add DCN42B to dml21_translation_helper

  * KUnit testing infrastructure:
    - Add KUnit tests for amdgpu_dm_pp_smu, amdgpu_dm_mst_types,
      and writeback connector
    - Extract HDCP and DPRX CRC transition helpers for KUnit
    - Export symbols for KUnit test modules
    - Enable warnings as errors for KUnit tests

  * Fixes & cleanups:
    - Fix compressed buffer config routine waiting time
    - Fix incorrect logic in CRC source handling
    - Fix writeback format loop and variable init
    - Fix max dispclk_khz/dppclk_khz double 1000
    - Remove duplicate pp_rn_set_wm_ranges
    - Remove dead code in dm_dp_mst_get_modes
    - Remove redundant code in amdgpu_dm_replay
    - Skip PHY SSC reduction on some 8K panels
    - Temp disable repeater FGCG as workaround
    - Deprecate DMUB register offload functionality
    - TEST_HARNESS FSN could be 0

  * Firmware:
    - DMUB FW promotion to 0.1.62.0

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d74776802418..b8ac462a676a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -65,7 +65,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.384"
+#define DC_VER "3.2.385"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.54.0

