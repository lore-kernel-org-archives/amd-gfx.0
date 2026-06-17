Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0665CD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 10:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C1F10EF90;
	Wed, 17 Jun 2026 10:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBoSkKXE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778F110EF86
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 10:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmXoTNBlpvXhEQZEfPDLZ4G8AqymyOec5VzlyMyRs1YkLdttFK6aH0834FuSvWQ0uv3cQ3LDYaP0mRjnDwyDspN57mpuehg7p6iP8iA1d/J4Sd5G5IYO2JwUPCfdcqzSiW5Y8yYTaSB0nNQodprvylSY2YFc1cW4ncNFq7e1J/FXsowr46MqCdvgxdaYUFcb6Qt1rxoEK2wuSvHB3JL2cRfcgsUmEX43jk+jZiQZJOtvrvb9GzijGtfWUVduEivpVLB28Dr9PTgfz6+dVRROVb7Uxd5V9cCLe3jXe1xP9b+ZnsaWB7xrR2vl1NZYBU+14MD3JNPBw9TnbBdGVf2+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owLF2fj7v7YYw5geXfrUUK4oD09JZeTVi/pPk3rsP0M=;
 b=AHrbYUoXaivw/k7uOR5uUjFEowVG59y76LmT/yq90FhLPCpMIPkscBtiDkU1m8HY7R9zgZvjmzMm3gyCAl0lBcKQV9hDYJR4dAO9/Gdb1gknL73yFQRbg05lGSNz0IA2B+P45smdtmN3ZqPZD1V8YFECEkU9BFsX0HCbqh2iF22n9unsw7xUp6Ft06EJm0vMcMjhfJl2e5ePFB8bjRzY39VODE7QL+3NgraK6AM99mfAC7q2YVSFIzZpTKxDYwYK3X/pEC1jrYC/fye66O63QyBgYGdw2JleGGGn3o8i2BEu3MI8AOLIUDh6hQcnSekBGg/s+NoYEd/Azoi13825Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owLF2fj7v7YYw5geXfrUUK4oD09JZeTVi/pPk3rsP0M=;
 b=MBoSkKXEWTU1vUXUe3v/RQAoymz+JTpbbRxm3aloRI2g9Fox6UTcg5mAEP1NvQSmD/p0BW7932DaEuxciIpF2DJVWvzHzCiRD753qyyJ8eo07KRFSQ95TnvP3B4iFPUbIJ2MA9cEiNBm1zSiBbsGHMeUZLdUi2tjfugOeMxg6Fk=
Received: from CH0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:610:e6::32)
 by DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 17 Jun
 2026 10:29:00 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::29) by CH0PR03CA0297.outlook.office365.com
 (2603:10b6:610:e6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:28:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:28:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 03:28:59 -0700
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 05:28:56 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 0/4] drm/amd/pm: smu_v14_0_0: DPM clock fixes for Strix Halo
Date: Wed, 17 Jun 2026 15:58:56 +0530
Message-ID: <20260617102856.12515-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8528f7-3035-4601-adb4-08decc5b3eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Q1gPukbM7dEJVep8qpolWVBowF9SThZ7Qy1cuJcCTj6gPjx4i9az8+dJnixriCYyWWP/3wvXJ5Wm35hGw5aTXXlF4Yot1LtXc1fuFZYK1kZcfqUaI6Ul6DwB0HYlSo0yhZOaShivlZ7lVot7F6D7FKtwhX5JZnoko/hyi4iFi4e+Uh2auLBOsK/1qLtU9Q05kg1cTO7s2enh8eDfffdhnvO2wFMGKldo+X8NY2RmET5R9BX9BoBmgbIP+9ehixtcfbALfr3hqOQDJ4RhiMZlbF+EekoxDpuLuoZ0hLNakfUiAPAQD8/HJTxPi+Z+99WrkoqfDmSDKgefQ7JOSJaMeB7x8tTPXL6wXLgqyIP6r+MIPSSSb8earrn8VZ2EN+9H0U6U2bq+qeU/GsJc0E8geL2zp1M4BNSLwxYdPWScHk8Gkm5Z+YNzdDIihNEu+A/qV1vSqDdAqqSYyB0FzhpOZTYbi1+mNbjegtuU07RJSQ90jk6bOe1m8jgX2WcGbjysy6nGmhveYJGLppbEGt2OtGQESllG5I3GMPJamyPZ1FZAS1WWvlNtVAjUDpSGfWYBFweE2rjc3Atpa8SYRjCpKWXMuNaJmoZTTNV9NltTAlQ1oKzgsTPSZbdltQ6t7CEHLCV5XT4Ap6WFr+VjVo/oxneQtQtXkRpZecbQ94bYiV4Z3GPHXTbQH9sPf7NewqqRlwV+8MTz4p9ipFE3B3l9te7YkLNob4zesOdWtzczKxs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MwgjOiczFWGWPWlwBpit3uxvkexgZCCpXzXc8tl85iQv/cEsNe8YH8S1i0H2jkRMWlzw13ZcN5S/7Sf1Ziaiog7hvPaUHB7XAXR8nhM4nGLyifhRsmFjXRpvGVhdwnXPv5KretP7CN67Qh7f3teF2PoFL4IaECk8V8HKwdKfH63isSy0e6in7WZdFBe2vPteVgeoVhytlIZRrvfgmHtpEW09uJKs26ZX8nBA10hSjlsIcL7RJiT/2Y3HDBv4gyVypOXJBfIvefsMfu4spdVuLby3VMdrGy4MbuMB7quO8HDRuvibmFeNcfXpKauOl05IzyG1KjqxsBrraXhn+woWXptz7rfMdGVlME7tnQx829mIE9HQqofiEMh+qHlOqS2wyEMe6sGzaQp3JXe+EzJCp3Vi1gpeZ35aEgjyMVxv4+8+HoxGQmn8mQV4L56y2wBO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:28:59.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8528f7-3035-4601-adb4-08decc5b3eba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150
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

This series fixes DPM clock reporting issues on SMU v14.0.x APUs
(Strix Halo / GC 11.5.x / SMU 14.0.1):

1. Introduce smu_v14_0_0_find_clk_level() helper and fix DCLK metric
   reporting by looking up the VCLK DPM level index
2. Expose vclk/dclk DPM sysfs entries for IP_VERSION(11,5,1)
3. Add SMU_DCEFCLK support in DPM frequency queries
4. Use the shared helper in emit_clk_levels for closest-match DPM
   level marking

v5:
- Extract smu_v14_0_0_find_clk_level() helper used by both DCLK
  metric lookup (patch 1) and emit_clk_levels (patch 4) per Lijo's
  review feedback on v4

v4:
- Drop early-break optimisation (Lijo)
- Drop explicit count guard; rely on for-loop (Lijo)
- Add Reviewed-by: Lijo Lazar on patch 4

v3:
- Add closest-match DPM fallback (patch 4) for MCLK/FCLK marker
- Reverse DPM index for SMU_MCLK
- Add SMU_DCEFCLK support (patch 3)

v2:
- Split IP_VERSION(11,5,1) whitelists to a separate patch

Priya Hosur (4):
  drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting via VCLK level
    index
  drm/amd/pm: add IP_VERSION(11,5,1) to vclk/dclk DPM sysfs whitelists
  drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in DPM frequency
    queries
  drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM level marking

 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   8 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 105 +++++++++++++++++-
 2 files changed, 106 insertions(+), 7 deletions(-)

-- 
2.43.0

