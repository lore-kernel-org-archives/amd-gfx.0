Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B25C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7201010E450;
	Wed, 30 Jul 2025 19:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NU2TKVpa";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D9E10E450
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbWazfzUMbGg8Owo2nslvKJCwnma3dRR/J4cKJhq15yAfKnmqYe8p9AcNZ7vWAvUhPMzXX7l5Yi8fd7JIec0rjP3mYaK3WX++kkOEI9hCUhoOcFi6tzMGccDxcO4EmOlcmqr5nJg2hzx5cF1nFLE2MIEHn7SZ8FkhVwBMUqFB07MMXbnjTqEp+tvPfi9HYRXUiRNySXFlbpYGyKE2/Q5F8h8fON0smhK+Bvu0+VQYVXF5IsM1/RHmtFI9IZ0zklXCqsIZFwGFTZV1CL2TcwGDewsYzmkhPzapYsFoqSoVMAnG7nDxI1gbiOfEHCik1ZN5ay5LO4GEK/TQrMTbsiM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCzc92Dv4mvuS38Lh6X8M+FoK7MPiAS3L+G4625w28E=;
 b=DioZiMkbQJWNjQv8//A8Sw5E7vLQq0t5tvrnb1gmvLxPa1QRY4JZZwRaBvoK/tJb+9+bdkzhdO1adWzg1ys8lhogl8CqA2XIoRTgv9jZc3/REc5whxCJGAHmSUeYXprlKDR7FCkJ67qjBP6CbuI1qwn5I+1REZkguhdGlV/wPOfb1VBhsJfIOvSX98cMKtCnrATOlq4gSaUZDMwktlZ0pdAU9erOLueYzF5yXkHhNOwvIXcy3Odo7KuAdH4nSzSuCuM0Ld9jJQZwbkE8Ou6uBpfR90svfxKmasJHtKvpo4/E5N2Sn+GORc7CxB0MyXK5g4QDxbCecEPqoHTqQ3ezqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCzc92Dv4mvuS38Lh6X8M+FoK7MPiAS3L+G4625w28E=;
 b=NU2TKVpayysNeOkYu0iWWtvkt88XHJDsslt9AMjrFayfQeFCEPqIJVPw6sjBTRm0CdGAjOKloGMI0Rlu+3UzDtk3NcfZzPXnTP9kuFJbBKDaWxNGNAOgg4yk3QjKmyFy+0ZvbYCceza+zwkDSKaaKgS7whPLMxvonL5xE/sf7OI=
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:00:45 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::c2) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:00:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:42 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:00:41 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Duncan Ma <Duncan.Ma@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 02/12] drm/amd/display: Adjust AUX-less ALPM setting
Date: Wed, 30 Jul 2025 14:58:53 -0400
Message-ID: <20250730185903.1023256-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1be89c-983e-4833-571f-08ddcf9b62b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lMa5qlhN9cheQq/Nb10n8BlpBO2hMVJC1yu398M07N72sWflkTiDQrlbWTOm?=
 =?us-ascii?Q?5Y4uzzuFgORH1h7G1ICZU1NmGT4RxWZKIFZ3aag5vNkOMVWohDfk9mX7IEjV?=
 =?us-ascii?Q?gki8qLEk/nXYlGGLcswA8c4umPnRPKutkYDJN4i0yErZNJTXqFEHHlLSEYOF?=
 =?us-ascii?Q?TaMSbDbsYLWkOmIzOCgkaewFZWUQBMaoyXh0+90PSovcEmSK+B0izsmD1Cks?=
 =?us-ascii?Q?v5mihse7nevCYjQQjECU6PYSy2Xwc6Qr4tC+3K9BijfFke7x8mmGvJh/0Tkp?=
 =?us-ascii?Q?iaazf5L523Hz6QeOpu9cgPf61GqwuWipZn49OVlW80GQy5l/OJLlH6wZFyXQ?=
 =?us-ascii?Q?2QuI7QSvfxczbLJiOoRJQPoDTCzByLk9NhlPIYAZCGpaRrWmMPrTXTt/ZP2w?=
 =?us-ascii?Q?TSwh675ewkfLPlmP7mUGHZwci1T+xbTvoTKS0z7W5N4vkRfRbNly7ZDl1XaX?=
 =?us-ascii?Q?aqM0fEEEwJ4WFXHGbthtCAHNCoam/SITkgL2ibTwJtfl68MpxECFaytvaLik?=
 =?us-ascii?Q?pV0H8V/H4vQv3JRu8dRSECP9k7hkdsvCPcEIUNhs7qWktbkHPSG8AgAhPi9k?=
 =?us-ascii?Q?A3BfBqbs32kp6TUML3qA8NylGZFXehciGUvRyEIR2Zf4loID1EuFybhquUtR?=
 =?us-ascii?Q?wGKHN6w5r/IlS8/6sig/+/S0jO4W92hsVZBncLN9R2p3vr2qIRNzWpM9qfDu?=
 =?us-ascii?Q?VzqFs/i2Z+zjY0og9QIoLSFxRmHJQTKYs4NGIYhr0Fem8Ch3+oZvY/jNcGxY?=
 =?us-ascii?Q?aVlOw3fyyzpeOnxbEdBHCnFXj4vOPlFW0M+qC5VXRlHCfleoF9UbCAmZcskO?=
 =?us-ascii?Q?sEMO9kMWnlj0sLn83UBJr+ttEqBHJOAXJ0BqfPZxhBVFxSRh8PNQtjplhtko?=
 =?us-ascii?Q?iwCijHsCnPqTz2mQjnxYrUKKU9/5/pps8NHu1gq+Yv2/GEV95XQx3PmFWsGO?=
 =?us-ascii?Q?oWpS+/sKfI1oqXbJfeioDh7PEr8WkQ37fy0r5BlZ+N9duQFaKQUCc+r6TYcp?=
 =?us-ascii?Q?xbCvWSDWVTBxcc5s5p+0nVtngGVOqfNCgNjwuf4kltcHAy9HYiOwN6w5W2oB?=
 =?us-ascii?Q?Evvv5dndmH5STjlYKuEExaeIEQdigpqvn7m5Q0t6nUpSUx88kZaaKHP99+Zq?=
 =?us-ascii?Q?jNKAVNwJJ+TButIFRX26Zavmagm+KE9bVFnXxWKrl0EZnExXkEQnABU4qzvw?=
 =?us-ascii?Q?BbSCt5Rh9LIiKLlIpFBf7EI5QPxZ7cq3+JrjoWormwctJyH7fSNGJTpm/tgJ?=
 =?us-ascii?Q?IXJkFB70+q07PUnOZZc6bQWelhyxH3BtoLWDgoaLRScH/7eYMJ0jHJhwygQg?=
 =?us-ascii?Q?c7RxUzq9uPS7qs2cFXfgU+XqaMCFcmL3FE1FsxBge6QPTjX7SKuSqK7Tjr6x?=
 =?us-ascii?Q?+VTRfsKzd7qzGfVQboQP3P9U0VAaav/QhJnWN1jA7Wxy/3poJXFsWPv4KrUE?=
 =?us-ascii?Q?KbiZemAdVEIZd9lzrW6LWTiVnEzEuWBqKy8c0gxLriySFcfez9rRsn5LObRo?=
 =?us-ascii?Q?qWr4b0tsKr3E6EOzuYXDuCJw9mRZMEEnYD6i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:00:43.9107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1be89c-983e-4833-571f-08ddcf9b62b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664
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

From: Duncan Ma <Duncan.Ma@amd.com>

[Why & How]
Change ACDS period to support LTTPR.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Duncan Ma <Duncan.Ma@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index be714cbf6615..2c3e2945124a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1046,7 +1046,7 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 
 		if (link->replay_settings.config.alpm_mode == DC_ALPM_AUXLESS) {
 			alpm_config.bits.ALPM_MODE_SEL = 1;
-			alpm_config.bits.ACDS_PERIOD_DURATION = 1;
+			alpm_config.bits.ACDS_PERIOD_DURATION = 0;
 		}
 
 		dm_helpers_dp_write_dpcd(
-- 
2.34.1

