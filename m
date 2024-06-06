Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1177BC27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E99110EAEA;
	Thu,  6 Jun 2024 21:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jEaDRxP2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF05310EAEA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJj2q77pOngZChw71T+jVm6/3S/XfUZYzKTGRqEyTcosdBsHUA/Wnh95svK2zbA36q45Sp/99GCxn5sm3jWR17BeGHzynT12e7UhU1/bK5AB+BeBiItMF0aBNJU5NkI6KoEX9i1wwLcUURnusjPwMTC8ktmgT8eZtkI2+NNBWhk9V/vgiRVyqWgUi6B8W9pZLdiYXfDSGZ1z/99DCpRB12wzzrm78F56qO9iH51gYs9Nhdr8JMBZA6HIPaOU5z/P6N21u5TSxh+TFplNT+yzO4EeS2Xf+u2ztC+OV5FM0FDOWGJhuDvkTnI8yR5K5A3/xDB/JYsZaZJKSfvwr7EcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DjOWmOvCESwZJKIQZfisq8OifLxAGb1iHDTo+Tru/Q=;
 b=coUaEztTCZWyTdLiB9HhfDjTCTJHebie2IyXHHhK6nLN5QDVPwuZY04H2V68TkMgNtS72cbsXen2MDUkAOu3U0sOerQ+K9MxbrH5Nmj2ehR3oMjcfwC9hh1D2+aUxP5UfZBTSuF0Z5s2AMPBHgi9FXewp1vMsNQY5Re6wgGq+9+ZZx1SBtUprCLK1tPLd8klz16Eq4bBLnNeLkRIX59lvJzMlh+qj43A/DEab00Q4dojlheM7X2G3ExMx1A0aBz/aVM+98nruFNa91/0Orf9tHcwjXBanE0TfmFNPpAec/No8lre7/YQtbWMKvN3WjS+XSkj8y9JsydwlNWyTsabnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DjOWmOvCESwZJKIQZfisq8OifLxAGb1iHDTo+Tru/Q=;
 b=jEaDRxP2qbiGKvv/DbZsWPyZcr34tnSXN17rcJmQQ4X3WUYUZqt/VN0ygB27fUdCiQ/NEP9ABxT/toWUWK4FnZS7pmZ0RTzhFNLX0Upba/D/k7Onnfr+VXelGAemHOD0KpfIBeUe4z2aa9g8qa6PNUIVeZGo3nARKeMWkfj/kPM=
Received: from MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:50 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::5f) by MN2PR15CA0043.outlook.office365.com
 (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:49 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:47 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Daniel Miess <daniel.miess@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 35/67] drm/amd/display: Change dram_clock_latency to 34us for
 dcn351
Date: Thu, 6 Jun 2024 17:56:00 -0400
Message-ID: <20240606215632.4061204-36-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: e67467c6-fe83-4cc0-3cd8-08dc8673b4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ibUxUD0JzCT+PfyszV8obcPsUtaw7VRNkmyWG81VtDChQCcuEEfkLrPqO0hT?=
 =?us-ascii?Q?iw3Z13m12Hfy+sTuk+DeG6uqeScAEyi+EHugbAvEhMJ1CLSvKDrAoiAI5Uvw?=
 =?us-ascii?Q?dQLj+YZAc0PLpuNfhAUY02qX2kxqsQSasmMdfH+m7SyTRMPTtgbxLUqm3qGu?=
 =?us-ascii?Q?f7c96pIrapu8V6Xp53Wjgbu4ExfViwXyo45mPXIQXKTnPNFenyDybq80+0Ku?=
 =?us-ascii?Q?CgKnQBhjjbwys5stlvpCKlJ67asxEa4netZxyz7KtKlr1lFUrpgEbrYIyxd+?=
 =?us-ascii?Q?8BebVAd46WLtS5BG6KegYwWNzH+PWh6w3EFb9IvAbEfWWKy9Jx2d2jDaMAA/?=
 =?us-ascii?Q?ao7x7UHNv2Gqag+JthEmHWSrzBT/VT9AvB8W9SCxD0n6ydQU7uWtm4F6s6+7?=
 =?us-ascii?Q?obSv79YwNYYTQRcDlrG3vg+/gASUQxXpZc+CMbUq4Qi67wdeiKY4LnQorefT?=
 =?us-ascii?Q?xFOof4ezyqRJvPubGDoBM6y17Z1Xf85fuxZ5fD4L2SRkBMx7lmZ6/Acwv19v?=
 =?us-ascii?Q?l6UHW2+wYpGlFxo6Ko0QjjV9ltkkmau0kbPcJ1g35NpkxcfKaU2gIIdnXEWz?=
 =?us-ascii?Q?OVVutENWzIPMd+fC/3inHtG6RzGs4lee/XfsJFCmh6oi1WFUUd39iOiFTirm?=
 =?us-ascii?Q?ub2V3kBulkrfZlfkYJHfQgBfTEN0skuOYa+xGvotNkmRLUDlbv5J0miVBHfi?=
 =?us-ascii?Q?BIeLTOOo4+yCn85uAbHoXiq8ycAIHDxPF39rkjMll8b84ZvEgyU0vfOIwxKa?=
 =?us-ascii?Q?kTuqCol0dJWZjMqn/IKG7SHTSRFBW8mP4+GsLweqtAKWvwGrN/B18zls9qtz?=
 =?us-ascii?Q?YpdYvsQGDPD6VK2NPFMh/IWt6A5IN4DM7OSSP7zMtCdG6IZKIHWxDRBXbzSf?=
 =?us-ascii?Q?kUsGuk6y92esepjPxk4aajfBBHGAog5JWnbfqXVbtZoYzR4sgl6ms3ph4Vg+?=
 =?us-ascii?Q?EgtL79YfvuzzBT+9Lou1ChItM+rFxD8IxVjFoYC5bg+xjwinzBt1IG/GjnXp?=
 =?us-ascii?Q?NBueONsWhaoA3qvmCRRz4Crn97+9PwERvIoFDQ1f9AA9t/wg+izykL9Y0IKr?=
 =?us-ascii?Q?H/bLRRKwdFUXOk4PGc0/q2tBMvOg0L7zgFDxDpJzRbanpoP6y9Tq0UP44A8/?=
 =?us-ascii?Q?r68Xvb5TJJXc6oxCxJnKwlYAEMHEGXj7mm52QBgzcVthcpkmeSBYAWpc6Ram?=
 =?us-ascii?Q?vNkPEXgbRJaupsPhEtkA6iNO8DMQc6g6AfDVFggoN+gXygzfAwcJPtcAX2O3?=
 =?us-ascii?Q?+7KuftY91E1L1fPtqtV2ENnYmTL5V9PeGILCIPv9wRLxAg0mrafC+TExdfbG?=
 =?us-ascii?Q?cZXKgLvq1tYeYbmxeDmRxxBibarRJVY/TQTMt7rFRPF3rG/cMgMXGtmVKsLa?=
 =?us-ascii?Q?ySPmeg/bNuhIyNRROTNvvoEQTzrP84KqwtyVNSwwNkp48T2lXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:49.5064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67467c6-fe83-4cc0-3cd8-08dc8673b4fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282
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

From: Daniel Miess <daniel.miess@amd.com>

[Why]
Intermittent underflow observed when using 4k144 display on
dcn351

[How]
Update dram_clock_change_latency_us from 11.72us to 34us

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index e4f333d4fb54..a201dbb743d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -215,7 +215,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
 	.urgent_latency_vm_data_only_us = 4.0,
-	.dram_clock_change_latency_us = 11.72,
+	.dram_clock_change_latency_us = 34,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-- 
2.34.1

