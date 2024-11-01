Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639FAE6B27C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B365510E9C0;
	Fri,  1 Nov 2024 13:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="461fdjzD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D09D10E166
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kff6RadyI7/H7l44e0WormchePoVpVhHIB6BsKrFT5gBt19x673klTJyvfp0fJrtwJ6kanvQnkeQHPqO3AqZR3yJDQyFgdojdzfpg7MDUqCqMworntWmmbnI2dBseYPw0XvHOHOQo/qlOiQ+9HOsA+05aOjTcCbSRKBhmyVW1gS+lJrAbwb0V4pOY3Y47aI5jatXBn6sqfWMUW8dSn3W0GI9JCU5/ps4+ZOJWAIilo4eTGNedv5T183hsehcixdojsPImORLN71rs92U1w7SGnM1d5oW3IzLHozobqoZ9lo5JFY+y/xlWCpW3C0bg5xQhRzb9786kb3d3efMJBacxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z81Zwm6avLjV5HKcQTCBQ07tCpy3/B5TtI4ehwu1oRc=;
 b=Ra0c2IQNBe1qFFNa9NRkii88/hEFyTbkdC4zGOpzPTVumjnwBCRTPaNUR/jpbTrIccrvg0Qx8d+QoXSNSexxprn5vFOHinx80OptXXvEuvbL6y4VGMy/qLZm8aCLjI8NKlauw5UTmCTgfRN7KYyv9icLKWWFpObjILDHtlStSuQdNreGfyuVgOKt/3CMNwzdjup+GurRy1vO+hZxPQtqswEdNyGDl6bZw9BflJ4IclhE1NG2kO9LtLXq0dZWuPGBQKBDFjFXcR2wWM5LLmtZ/6KUD/XDJntuvSxOuott22V3X8bUW8NG72YNsCAAbA3wphpfoxNTbFFAoDuceehgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z81Zwm6avLjV5HKcQTCBQ07tCpy3/B5TtI4ehwu1oRc=;
 b=461fdjzDp/Q9d4Xh8eepSAwjNVCFAkyNUjQ80lQTSl4aGymjdT8t1KoblzCbNZmiWjAq0UG+zPhHzMpiQDweGzKXvaMb5sILB0F8DirZ6kkQbho20JtPR2o3+Z6Xt4OqiID/An6outB2GAWEdw1fbYmIsekVIGWKX95gUFPiBFk=
Received: from BN0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:e4::13)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 13:50:05 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::42) by BN0PR02CA0008.outlook.office365.com
 (2603:10b6:408:e4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:05 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:03 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 01/17] drm/amd/display: Do Not Fallback To SW Cursor If HW
 Cursor Required
Date: Fri, 1 Nov 2024 09:49:24 -0400
Message-ID: <20241101134940.1426653-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: df185f8e-4e5a-4b6b-c4b6-08dcfa7c177b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vQe9FiECj89vY8JFlQNAceBQ+nCUhV3cMTgj9G9PltPUCPHUb0JLRHNvUjiV?=
 =?us-ascii?Q?icd+gs1XyfKKUJBqIWGa8KV620c6iFOyUvtss8o2YXCTYhLphwk5AI4Xs5zL?=
 =?us-ascii?Q?GASfmgvoYXBGD1WBDmogeYApiFFwThGgT7qGE3DP9Q+5PIA4Fq6tfNCz58y/?=
 =?us-ascii?Q?Cc58eOvp5SoYpRxzISHqH1lgUzm0s7CSVaz8aLSO2lZcM+8J7bEWWbNuHaBQ?=
 =?us-ascii?Q?U9eEVjhtyhKGtUliS+/wh1i46zS4gwk4Ly0OfAZPl4bRL7Ly2tAjR4mIdJ5u?=
 =?us-ascii?Q?JjwFgBs6zNo7Ue4iQnHY7Rx7MBaqA3ncR6ggoFbuO68NNYtTeoEgozgIWGOq?=
 =?us-ascii?Q?ZN6DDxanVdJRSap9GvQ9BKbrZYXrcOqn9W+rbMhXyL3q4Fa/NAG+XuJvqfgp?=
 =?us-ascii?Q?33oktHDvKliqBVi46bKCDc6pOuXCpO7DzilBop/2y5jqVKwbEDonUK6JenAD?=
 =?us-ascii?Q?XzEpi3/2LLdrGm1uDe7FOTe5XTvBfhZl1U2jyL1luY7Zl7YpbrKuCRwgFhVo?=
 =?us-ascii?Q?R804MOQdI0kbGyn3w7VkPT65C1kTvu1rKwn7VHZdcdqVPzmhuSZVCLD7eqXM?=
 =?us-ascii?Q?8phppSx5VxQreJ5Dl6gCIRN5ewc5b+l8l70XLGZM7lzDfbD0J/bB0mdEN3Uv?=
 =?us-ascii?Q?J4J4LY1Jag3wcJ3Twhwat3cSPmwsbIJLJuNKA4G0xRU8Oq1XXQjG6GXtEtvD?=
 =?us-ascii?Q?kynJytqNZSFCTiHDo799ToiLCn2VHNpiHQuBT6iAF1hYrQURMxYX6bvbx4Zh?=
 =?us-ascii?Q?utGFlhSxnRGx2aE/hpoq2IEDjUyowdcKKYW453m7fVHZdr7INnZlDLO3jPUl?=
 =?us-ascii?Q?4EHr4zvw3dY9ucH6/RPq3Re5jd77QG0+hOof09YGhtrz1xe5o6MEJpp1BldF?=
 =?us-ascii?Q?wUwCy46wIHuJuDsZV16YXFDW4ir/yiGRgFTF6ehldsE3ukP3a0IlbmM5txPE?=
 =?us-ascii?Q?R7YqSgidtUJejEV82OKsOwW2mdqrji5dZZfoDZjmR5E0DCkZBf6k/P2oSlme?=
 =?us-ascii?Q?MU86FxJn2wFbtrVnRibmInXp180L1705LO3fefqeXsLi/ej+9ewgAOlSXc2h?=
 =?us-ascii?Q?rVmtwNiwPX/gPFjsap4rD6prBVV2KbFTaRn4xr6mbnoVMgGk3wW9KNKRpfzW?=
 =?us-ascii?Q?2ZjNaF/RE1o28LshCBYq1Bod1dW+krJlqCk3nji1QTpk11ANNESGDzLmYThD?=
 =?us-ascii?Q?TxwfL46J/It+KfMplSkX+icfeQvN5stzHLFb+FyqeOYbjO9xaXflG2/Dix88?=
 =?us-ascii?Q?3zSKtwvdmxfvOTkpiPCL2hhSrUQx6wQwG8h2ex11+dgtHIPVie1per+SvO8n?=
 =?us-ascii?Q?F0qNxCfYXb6fWlRnsfkYTx5PGMZpQ0kcA8Z02179kM+1dYFTNULOCLTCf8ce?=
 =?us-ascii?Q?Z0zbcHI2KTtf7PoFScTS4pb802ouZU02/GNrydS+u9S0z8Jkpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:05.6018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df185f8e-4e5a-4b6b-c4b6-08dcfa7c177b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Tearing can occur if there is a flip immediate plane and SW cursor.
check_subvp_sw_cursor_fallback_req falls back to SW cursor if the
stream has the potential to use subVP.
Check for fallback not needed if HW cursor is required.
e.g. Fullscreen gaming

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index b000bf39762f..aca2821d546b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -290,7 +290,9 @@ bool dc_stream_set_cursor_attributes(
 	 * 2. If not subvp high refresh, for single display cases, if resolution is >= 5K and refresh rate < 120hz
 	 * 3. If not subvp high refresh, for multi display cases, if resolution is >= 4K and refresh rate < 120hz
 	 */
-	if (dc->debug.allow_sw_cursor_fallback && attributes->height * attributes->width * 4 > 16384) {
+	if (dc->debug.allow_sw_cursor_fallback &&
+		attributes->height * attributes->width * 4 > 16384 &&
+		!stream->hw_cursor_req) {
 		if (check_subvp_sw_cursor_fallback_req(dc, stream))
 			return false;
 	}
-- 
2.34.1

