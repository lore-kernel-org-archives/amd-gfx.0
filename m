Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471BECA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD2D10E7F5;
	Wed, 20 Aug 2025 20:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tLKd15sY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA35C10E7ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tawNblUGrHefE+ts1WW5StZB47BHppIMXzXBrYiYoIbCFz4tAjrYVKAETZ1/tG5A0942vgEr0XlOpF6vTvk5hskzM+IFnYMvWjV5G5adfIG5OKCd/VmbZ9rh7jvgDHjrdT88PKUvplt40vuYTNHipKqHHefwdxm58TWCDH+3SfiugR7Xqd7KRl1Sn1armmLaF0yvrKk5ahBjhKjP3Htkm3y7zVCPPQXIX7JnSltMRc3TTdHHLfs+heORklffI5yuTFQyk6GyZS1A9klctU+SX0PCa4VXWoqZBEYDyqCKQqmTXYT9n8MjdTLTL0XeB69wyeFQyTfhap7CWLFNjwJn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7wP08FVHb/jxF+tSCsVRRMYdLeo2ymVVd6yVEJCRiQ=;
 b=gerqMtNJUx+wOlao2JkziHskB+GM/vr98f/jwjbCppAQzXWitjURn00P3b830davb4OSJE9npnggr0jI9BHLkV9ieU/LI8G/WRcwxLpm/zTyRUNMaNBSZNikdagd/+Topw90bYw/DuztxU0ZXJd4U8bsr06z1UXP3atHfZmmhe8EhMpEEGSatJtx/jwL0fkKr3y7lXbUYnfdbJIaHY0BCGTffqJ5KRHlm16lfZQbGOHAy3WenxtKUQgDR5+al7iEPKThC9MJAG4KCQWa+AKuE83aOFks4HKV7W2WOgvxZgQHaQ8VGn4w0OI2cBzvTQNCUSDo5WbQbiUaPUf77/0iGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7wP08FVHb/jxF+tSCsVRRMYdLeo2ymVVd6yVEJCRiQ=;
 b=tLKd15sY1MepOxjgHCvCyAWJIWaxdNP3vslbAFebcGbjX2U9tvnZ7Hh9lfOUFvLOxo738kj9Js/Zopy465zLnfYY7K9m2bF37RCitTFIMNQ2H0ui343GhLAZCDzJj7PX4aFqTs17CvcBHFymM4KXDJVqC00/UPHYiJ/OuEQ7nPY=
Received: from DM6PR06CA0044.namprd06.prod.outlook.com (2603:10b6:5:54::21) by
 SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 20:21:13 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::11) by DM6PR06CA0044.outlook.office365.com
 (2603:10b6:5:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:10 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Wenjing Liu
 <Wenjing.Liu@amd.com>
Subject: [PATCH 10/12] drm/amd/display: Consider sink max slice width
 limitation for dsc
Date: Wed, 20 Aug 2025 16:20:00 -0400
Message-ID: <20250820202103.1122706-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: f08068b5-83ef-4cee-0ca9-08dde0271bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3m8K5OYSTnEpQrenPvI8e9JzNOupxyppvLk8R9DY5CmZfz8SyE/I1IdVaePN?=
 =?us-ascii?Q?pXlVzsDxR/KSSck4RXiBnUYiBXyINTF7GrvaaHORGJpzH4LQy46VZxJ2Ig1I?=
 =?us-ascii?Q?6zP7YJpN3U466ICf7HlvZ2zKZgPjxC01BSZAYjnM0/yV6u+7gWy+PO8TF3oT?=
 =?us-ascii?Q?IJmawR/43E6SBQA8VxqGfUjMp/gxuLjq5xcBoGa7FZvE1AYcaOw8UoKA3UFC?=
 =?us-ascii?Q?fmbsVWCgnDzuCiXAHoYoNgQQ+z9cQz1mvMqVGWTRQ4Sv4v8qGKjdGfcM4X2H?=
 =?us-ascii?Q?tkXyAHlyyrEplq5+OMhFT53LKyCfTpuOidpGXD/PjhnQybb7J9o6mP+R1xp4?=
 =?us-ascii?Q?ldkUhUWPzMcKor+ci5kqB3xXNW8lVYXHBZ0I0ouZix914pyE+rkPRpHS7j15?=
 =?us-ascii?Q?PPu8UriqK67zMc+vXcB03bGoPyFCC+Tz7R54NJbzsEtCZ3tEXbuBaEe/OVbp?=
 =?us-ascii?Q?nQHLRO868d4aHqsiKScgl2vUclU/SRyIbDQuXyDdhYt/NvtEwCslysquO93F?=
 =?us-ascii?Q?8VmoTCzXfdiJXb9YQyal8vWcsmNFXXE9Ur57HdbeIuaYv6yQrsaQxV2qdNYO?=
 =?us-ascii?Q?cwelCrHDT3MS0t1Mk+Cnu+n0ueCVYtWVEbH3RYlQRwyp69dZ29k0U7VmYyi8?=
 =?us-ascii?Q?tbTuUwN62Utn9i1d3fcq3JJHYrapyMXEXwetIqqpl4zMsQ8WJfju2rDQA4Ie?=
 =?us-ascii?Q?X4GtF4Z6EfmiBpjr7CzbbTMSvMe/1Uy2wkY7e35ZKBafUJ5B13pyYVqCIfCm?=
 =?us-ascii?Q?mrtCAaxvPJxTEYyxCCEjahmkdWf4JK76+PPcAxw9Yd9MW5Z84HG74YEMjs/0?=
 =?us-ascii?Q?3Co/oF++W+z/8Q4HItimT8N3YofqNjNxM0dR6lRXmTiiuTiCketNwgmDUOgc?=
 =?us-ascii?Q?Cb3sp81Y1VD3HhAJ5SQ0KFi0DTW9yLqY7BbgMUmJaeVmiy89nmVacRqTcX+G?=
 =?us-ascii?Q?ejSSWC7ULmRClQ4zeR9xSB0D5dQfe7UvbHEbOnwED7PuHvBMQ8qtVGoRtG7C?=
 =?us-ascii?Q?nxNdXdQlqednUiHiZW7pfVdp58mDHvBIy3g9BxL15XP/IBOIw7tOyZ+D6NhF?=
 =?us-ascii?Q?cYVfyDGVmCz3B2w8Loqx5cxovYY22u9MMbv9isG8t3F8MMz70DCGAYlxWqH9?=
 =?us-ascii?Q?OYiZJftIVjEiX8QJ8L76M1AL8V6I+4WZgizK6h87FRIGKFis++X5sSOrun7j?=
 =?us-ascii?Q?jvNkKaozLzH5svXu4MYdlX1DNl1Srbi16esg4nondWMaLqVPqYQrZqbUgmhS?=
 =?us-ascii?Q?2El4xviOY3fWdt5hp3hsSeZOQBlQxm5LaiO0ttNDTPCdBMzeCi9NNErMwr+v?=
 =?us-ascii?Q?gztHZOJ5Uh0H5HnDReo+NgYJJi9W5zaDdrAdNCwV5RQpLAdpopHf4v+GNei2?=
 =?us-ascii?Q?eH/qpawye7lkSmSZZ4X/kiVkbE9CNLHVl7TyLLqhkejFPutSqrkCtKSGxVUD?=
 =?us-ascii?Q?VEeSzfGPCotbN8Jzbj7cudehMasXVNOCKKEei/8L2Mnbfm8g8+C55v8HNaoV?=
 =?us-ascii?Q?3+Ipw72uktGAdX4HDJgl/zbzUkvHbOKCOg/V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:12.8791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f08068b5-83ef-4cee-0ca9-08dde0271bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
The sink max slice width limitation should be considered for DSC, but
was removed in "refactor DSC cap calculations".
This patch adds it back and takes the valid minimum between the sink and
source.

Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 1f53a9f0c0ac..e4144b244332 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -1157,6 +1157,11 @@ static bool setup_dsc_config(
 	if (!is_dsc_possible)
 		goto done;
 
+	/* increase miniumum slice count to meet sink slice width limitations */
+	min_slices_h = dc_fixpt_ceil(dc_fixpt_max(
+			dc_fixpt_div_int(dc_fixpt_from_int(pic_width), dsc_common_caps.max_slice_width), // sink min
+			dc_fixpt_from_int(min_slices_h))); // source min
+
 	min_slices_h = fit_num_slices_up(dsc_common_caps.slice_caps, min_slices_h);
 
 	/* increase minimum slice count to meet sink throughput limitations */
-- 
2.50.1

