Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE80F94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B3110E25C;
	Wed, 22 Apr 2026 03:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zZKgpwca";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073BD10E25C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6bE5hUoDvB9MrXFQoK+u9SiAUv8onyzqiN8oEA27t5lGhg8my1JnzjdcYX5gz1Z8otlDVD9IVUBskYeFNQyijZBDE2sDfru3cNQbP6SCwkx6vbQvLu1mSOYom4FfWopz148haR6TEm36raScPHqy/EdxTkrNwZXo2EvBEa+pwl4uzrUb8MiI4/MX2/FUP33Cuhtlp4V0k0LMyxzLsDoNRlApgRlho3X+pydit4WFI0e2dod5A7ZS5YcmvntlYJfstOkJKyO9cDKcsoD8tWBpANSyW4EPdH8MK8ZKeOy6DjWXJxNMnSbS2i+g3Vpkj6wYsfEo7Qz/zEoF/U3pSvsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q711FlyfHLVxY100vVlctgiXJbOvSTIJTGjSjdC3BJI=;
 b=LYZni2fcU7ebiKMhc83Ubp7Bj6pcPc6W9IwxhjSoYalQFZvmdNY/qDaaTfuYbPnCG+727x+ubykYTMimtR/adPaxlFzvhAaFzP8InCnrnVSIQKBfJKdlFA4kqzUf/XrDO9Cb7QP6iyiDdDWMbhsXlwrtHzd6ghFqmQDDpahk6DsVQ6QBv/H+YF59i+TwoCnL2G5LgqFmpiR5opZEfzKGtXqaMnO271EImJhTzrlp2KFyBlPmK12Wt+Jg52dhDhWCisphQNC+QU+vjB38rXRalBVlvh9A49btywyMKodmUa5TGIygF3Jnx7oROfG/NqY8Yl2fHKVVrHBnx/febznEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q711FlyfHLVxY100vVlctgiXJbOvSTIJTGjSjdC3BJI=;
 b=zZKgpwcawUv5mlJOHm3M9EIW0Lim0UEYkn3vn4LK0FCnMpR/fnlwbXX96wMRDjY+kLJfEps03qzxr35p05BYrNr44AAh2s5sDapONhzqfPaffa8MKSbRwpDyynwjJBpPfONl2fVP55UoVgeVmFCIwwYK2zwQ/kKul+zdAVbos08=
Received: from PH8P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::27)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 03:57:13 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::6b) by PH8P222CA0017.outlook.office365.com
 (2603:10b6:510:2d7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:57:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:57:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:57:05 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:57:02 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Leo Chen
 <leo.chen@amd.com>
Subject: [PATCH 11/14] drm/amd/display: Disable hpo power gate
Date: Wed, 22 Apr 2026 11:52:49 +0800
Message-ID: <20260422035611.1870316-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 36aded47-48b9-48fc-ab41-08dea0233c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VkbnKWToSX22OURev6gI9quw2knulKzFowc6FCPX4JjObBBY2YP1DQCjVeb7rmremex6+HU8mySr2cjcTDUdMhFNOh0dV0ZAuDFxRVTX3rbmqIKyVOGTnmGR3+mZn6pMvGQ+/aKqwp2+FpiVySKWEkr2doqP9sQTLijbD2tXoGfu2DLkFRiXvED0hR546X25XbU0NUcyuoCSG8aS8K3r/RYQ87QJKC5ziQmBNXnPQBenjs7p3qlXpVE0K+6nxm4leL/6atg2tqiTQJ8BymMn2+v4U1Uld5mlEHxRJA/a3LaeR0eSfvQKuDbnTpLX3io6zH1sJVsB6ec1IyfhCoumvbt8tHXkp++yQlh4wDjT8S44UP8PAnKTwN8TCq+dIxwCyKayEmDmRg6uV/le5KWSdoNxKgNZLCuDuTj6DTeCCqAx/IDje7hKkelw2hvjLS4E3tnCElh9qSGQG4zswa+brA2ZZVJm+UFy186b2bNmCFNFqn2MU3YucTTomhi0TljOkR8sdZjDq5T3oMCiEdF3ROo6Jg3jK4Z+I2I7FuGOl3kBneD2HwCDAkVO3oTSbiCkaLOG7DUNcT/ozUAiZzUZQE4+LKES3RlNV/wlAKTNrKLb9W95O6L97BhDndJFu2osnrSpWyj3Zt3o/tw+KN3MgbGpUUuXOUlktV41yn7KpqvsjRow/zQoQc7/nxT+QJ6DNJLPgxH29SQOkPItPZlbmpbp/0rjBNnblTaDP1OQpUUbHkb4+JhzuIr27aMqUbroV1Arz52qNdajHwRS5RfVvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mkc4QdskeWXMUsI9cQfOH2TZQPpWD0WfiKjvJJG0CDyS53pb7yzqLsypfsrr3a8PlVf67E4O+ZzSqfGUNFrqXNMj+i7eHkvkbDgJZeqEbJcGf5OMAwc2iK58uQo8EkQIWvOSTLPUX1G4drrEYnGKKTBK5U9yTy6z5epDkQjJb8np/UjJvtW904tGRSoGlz/VPSwFvgpB18HotulBVyptVLlbI+nkw5QNe3jlRiYC92Ywtvo34b2Q6r8xTZtqNYZpY5u9c9u572Y06Ls+/sU8DGlZ1XQMuaEynZ7G4EfSsKf6mVw1CRUgrrMKsFtHeV6hgfItAP/lmLX8uDa5CCQ1/AEVX1mM/LrlnpwmQBt78vLrWYvCf+eZLK/LqYdT/iQzU5AGC19ZuJJclUZ8kRHsWm5Yakcaz2qxoq2XFmfiOYcwkvkCp9RSi+P3OZyYUbiQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:57:13.0114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aded47-48b9-48fc-ab41-08dea0233c68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
Disable HPO power gate temporarily.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index acd76269abb4..ce26816b3e65 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -700,6 +700,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_optc_power_gate = false,
 	.disable_dsc_power_gate = false,
 	.disable_dio_power_gate = true,
+	.disable_hpo_power_gate = true,
 	.pipe_split_policy = MPC_SPLIT_AVOID,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
-- 
2.43.0

