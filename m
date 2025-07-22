Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7FEC87FCD
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91FF10E734;
	Tue, 22 Jul 2025 22:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fpOLrb6+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E30910E725
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aphnIq+dSccTY3TqhN9FFE94kRN/GvBWAEN1+QJP65c5OTxeGjAII7Fi7t0vhfJlyEvLdgo0hj/tt3RHjHUDJEsi4UHjQddASmap6eKG2Tt35LInHsqfZMKL938hle1TH+4jNPsnIxLr/VmabTrQhgm96v0rzVaci5rcl7YTiuZ7M7F3jKgp0mUeixUfZ/yGCf9EpF4GnrOOSRVIPFYsDtGl67DZ+BMWHZMEumYbsOJ9Hoam+bR3BVuWNx4fhWpRTDAwKXtVQZ+Z24DoPBk2fUCGZs8op+4OsaUnTjhe8rQ7qmM6LnccvtxFCpGIXKFCeA7jYfZaXkX6rQr6Nw3IGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zduuV8iVj06K03ViQO+72snRIxeWn9bz4Y69GVHLa3w=;
 b=m9eLqbcXzYtoPAobpheNYooHNUbbyVsv6aenEhyFa+7V0UFGIQBKox5hVn8eX4XNPh5q4U0S6fsVOrt4EqR2PDZgMHwvSET0oxjUrRM3jAOc279pBa1ntsgjATfDjDbXju5P3s6c5bmGg5Jzcz6/qrjqdUKrquNVxI5HMvxvLlBj/0r3BX+fJsxxxmXhHOWy7gy97n/Fy4KtnkApIoXl81i6gqGq85ni3EzDsVN0bjH6dKa8n4hI0UZkKKwx8txR56pv6+k3kpSUgM7emhOW+dT1he0ZDtZNiVDkje0tplzNnFPuHhJvNE7nHSv6VXRsJyaAi8XYnIVpUa9HIMQuvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zduuV8iVj06K03ViQO+72snRIxeWn9bz4Y69GVHLa3w=;
 b=fpOLrb6+u3zgJhCRbAFauxDoq6pcMyKvbzooz9JoOryfZ5iG4ChDGSav6dGcBpSI8opKcGSJ9mjqlfNI5palTvADeYQ1nrkMrbxX5Vg0yiMBAivGpeAnJ861ptf3A6ItoXZPVRV4+/h3Z4IB9HgD/SB4KMBXZiMGtf6L5KmQnsU=
Received: from MN2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:c0::34)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 22 Jul
 2025 22:39:28 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::6a) by MN2PR05CA0021.outlook.office365.com
 (2603:10b6:208:c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:27 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:26 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 11/25] drm/amd/display: Avoid configuring PSR granularity if
 PSR-SU not supported
Date: Tue, 22 Jul 2025 18:36:17 -0400
Message-ID: <20250722223911.2655505-12-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e6f9fb-af58-4bb2-949c-08ddc9709e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ADRPsO4oRsa1pyMikM3yJ9HGIn5CKgjGXwuWmQuseh8f3c4VoudoSPElMxT2?=
 =?us-ascii?Q?U26+xIj2FBEGqTmegDlgs1YiGDfezALQsLuAnfryt2nOjbCLtlC/KI+S8B6S?=
 =?us-ascii?Q?6dm45Ue2eyjfrwzDDeBpNx2Uumoryc0gz5OQYpAGbr3aD1Ww7deGIVYprjlU?=
 =?us-ascii?Q?y4w3icAfe9EctT7wpQXO9saBV/zIqZJaw0IDn7yZ0MYjSv5VnOr2GpbolI0n?=
 =?us-ascii?Q?nrCsxhzf9TuU9AEapAuC5prVJyFyfd7wLRlF+ivkHwNTGSuCDLzeTdkY43VQ?=
 =?us-ascii?Q?SHq0P4eBGoiX6rydet+yXY0zv4azQPV2PkOkXbiHJsIuVD6FwxVpkT7/4IE6?=
 =?us-ascii?Q?nOMq81GtcTWsMkgafHMgKu3/l08Y/a/itkOftnFs21QW5ie8opqWJdn+XZVr?=
 =?us-ascii?Q?xG3LeaXDD7tvD/d4+XG4/2tBWI6Sao8qqwAQhRGxKsWMeU7sZzH+yKJyf5bT?=
 =?us-ascii?Q?38oaiWUWHw1hKDQScm5tlvI6woS94V/Wpb1drh/NeWGQUMYvrxPRYJvSkI2D?=
 =?us-ascii?Q?fnK/YDtN2TbpYepdkwXLTXFJt1wBML9o7sZsq8r9IBCf4Je7eowkI4TI2k+i?=
 =?us-ascii?Q?VK4j2eMOgAE9FsKatMhxesyEslYodxPdX9R4IFlkiw8odMESCqN+9vmXW0aG?=
 =?us-ascii?Q?r6lGUpxNv9mB+7RNSXFSpqskoRa/ADQMs3lWQm3cAUckhI1Vz+OYflkD0YkK?=
 =?us-ascii?Q?J5V487pvTVCWqYUwjTDnMaTKRKWkxJZ8vsdRUHz6ku/mr4H4orUKENT3POlz?=
 =?us-ascii?Q?hdzIfQyFKgdLvFNiC747XLBPHeWQ+9EbGTRuSgDBN5Fh0libPVld1AZ+ilRB?=
 =?us-ascii?Q?OZl107S9m9lqqPnvpN2fi6FW/4QZSedo6Wlcay2Axry/bWBE5sMJx7WbUTto?=
 =?us-ascii?Q?kcOE1Wym+hcsx6rr1kk6bq04IurE0AKIvkYls5niQ1rixmDnCemGjRdsQKWs?=
 =?us-ascii?Q?Y4afDgBi0ppyxLuYF1y1IQZGz0sCO0fPMngversyunnmh5t5+KOR1/um675L?=
 =?us-ascii?Q?w6L+zBIT1FAZy+wy3vEAqx6UHa9u0mToi076E1oN92+8KEnKQ/3AdaBUwvKT?=
 =?us-ascii?Q?kCeYuF+ZyNurpxB7FAilzRq+pasBIZWwPjmPgFgZMaGjUgUQkeGic/0Fb4mV?=
 =?us-ascii?Q?GwTSZ0ERFpYlLD7P/GapUufBq/N+K6mZOCDZ+qkLxwxHPDxHEOJ2LhcGrj4b?=
 =?us-ascii?Q?yBR9VuY/k9djGzpQTmnHzvo9xxznXWv9tuEPhDcnBoKQiHP0ELNOMkWd6yPE?=
 =?us-ascii?Q?Kr3dJwtVPdR315KsVw2lWhElqXUiBOw7pe6VihXTmS/5q/TGRQQYI4WWCCvA?=
 =?us-ascii?Q?YBsErUGU6RxWy84ouJUNmdAPkmmPzp+OdDJzSff68R/eQeHSbEGsFYcCjo1c?=
 =?us-ascii?Q?vRZN66PbktXRO1DZBcwwvdrRWpP5Z6YpxqHOk0SuDNF06ElZbzh1+GCMmqoA?=
 =?us-ascii?Q?o75mJsjC2dXcFTDLVfikmcvxgXx93VqI1aOnX/HNvJJ0wWQ8YWKt1bbRzQu0?=
 =?us-ascii?Q?wQsuyV6Tg1gn+Xexge2LQrAOXbUmdiayUl7x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:28.2771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e6f9fb-af58-4bb2-949c-08ddc9709e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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
If PSR-SU is disabled on the link, then configuring su_y granularity in
mod_power_calc_psr_configs() can lead to assertions in
psr_su_set_dsc_slice_height().

[How]
Check the PSR version in amdgpu_dm_link_setup_psr() to determine whether
or not to configure granularity.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index d5a3768bf002..fd491b7a3cd7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -119,8 +119,10 @@ bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 		psr_config.allow_multi_disp_optimizations =
 			(amdgpu_dc_feature_mask & DC_PSR_ALLOW_MULTI_DISP_OPT);
 
-		if (!psr_su_set_dsc_slice_height(dc, link, stream, &psr_config))
-			return false;
+		if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
+			if (!psr_su_set_dsc_slice_height(dc, link, stream, &psr_config))
+				return false;
+		}
 
 		ret = dc_link_setup_psr(link, stream, &psr_config, &psr_context);
 
-- 
2.43.0

