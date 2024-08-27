Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BCFC54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5857C10E392;
	Tue, 27 Aug 2024 16:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bdbkzgAQ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695C610E391
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD0nifAbkFdlQpgPt9kKHHxTtPvrdiL1Decmu/3Ys2w0lG8VR2FBDOnapm1uSMNsuWm5AMeYrRRODzGrUiHu/rEQlELQwNEtQBXgfcByoTEftBS2v36C+vz093fyV0gaMCC1/D2CdJj+IRoPv7et7yAALcBsNtHRS4iHRiQtz5/RJBV9hARWCD8nIsJzk16oPFYzuqw2j8/4gJLXUwNx8uRorYNISEO0T45iovCFW2lDwpRqvMFR4gJJI7f/HMOoEWLIoECD9bp8v6k0aS/C1M3yMdOcOoeNj/zGD+x1VZ0tfw2AzFMFRh5BQhEZf2ZcdX+eunVm0WtIc8FIU5DYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4jRQrozbt4U3nFdNXNgvmSncm5Td3t/zIHmq8k7TtE=;
 b=bRV6GcIOfAldb3UVGm7km75yan+v2qLt5y1MynMsoi1jMs02lkWr5Wn8GPhkI/p+Y0857LZ4ULnkGo5mjJhAaolImiDiD+/xLKMhwxFOWlvnwIaYUkFGyvXN+zTUMELXl2gIp7m8ii2O8Kizz2TImhd4TOMaZfcNHctETESG7XW0Z4P1/LuVpmuLvcI4P/9YQBA+DafPWVWASLx/QNY3zvkpWBJpejTBpMKni/a3mJY49GbaZ/7N31c6swXnx8E9r8u/oaj0odQ7ApgDmAlJciNCiU9ei1ars6i3hcjRM20fOt85A1ShE3Cvibets6m8a00vU6F3gUVj80AhIQgMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4jRQrozbt4U3nFdNXNgvmSncm5Td3t/zIHmq8k7TtE=;
 b=bdbkzgAQC3/7FIwUi4zE0gbrnP2nP+7kEDiNPoyjSfPOLdn6u8yptjgwWymHEJYqJ8sFOj5aoOh3Q8K9OxW8EDC82Tlx69pcprb9TfV65/49+6S8bec/jamgsMQR0+WvFd7G5xftXU2EqeVECV4wcNjISY4saNdEnVFC8t4plhM=
Received: from BN9PR03CA0749.namprd03.prod.outlook.com (2603:10b6:408:110::34)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 16:41:08 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::6e) by BN9PR03CA0749.outlook.office365.com
 (2603:10b6:408:110::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:08 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:06 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 04/14] drm/amd/display: re-enable Dynamic ODM policy
Date: Tue, 27 Aug 2024 12:37:24 -0400
Message-ID: <20240827164045.167557-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d987b9-5787-4e6d-7a7e-08dcc6b70d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jjo6jcDaY5uLXtddMzJJdNLNM6XWyZ0p0zuxqjh18pLf7dDa/AfQP6JyguVL?=
 =?us-ascii?Q?1hrH3ZczzyUgYskBBPnFidzayQ7PKYoILGLKO+OmHw2Ll9P05tYTm+DhlM+N?=
 =?us-ascii?Q?F43MF6O7n2RaUAB4JtJwgD3UUGoxUXcufm3h9UZWUYAyVDz+OWGNnVw38cTQ?=
 =?us-ascii?Q?yP8dHzSE3B8ftxhZpSKGkp+/EZtTyWL84KCSd1RcTVPD5q0QuibPH4+RSk3/?=
 =?us-ascii?Q?Z7Y/yIV+gE9XiPjgU7U78aRKmFwdTkgV0KYPzwhRrchZlx6CEhHc3ttmaeq/?=
 =?us-ascii?Q?iTzRACSM/uEVedTeX9iz/WaegiUivzNbLLlhMgM7Hi7DX05CYQV1NWLrPi4H?=
 =?us-ascii?Q?VHfoiJGgcQYXrRcN/sEoYCx9Vcs5ustkyxBGNyx158TRlFwzEc8yM0me3aG0?=
 =?us-ascii?Q?e1z7FVbRVv+Uev9Ojd9QWKTNNwEhrS2q4jy9oVlrvFjJcbflUSaKpsuzfmxC?=
 =?us-ascii?Q?92xcjZfnqFIoItRzWTQ1ZN3iBvHKoBkVjKU1KqNYPGUNlNgmUL07ehbDhNip?=
 =?us-ascii?Q?l7/eOrOo2zlZR/eyorIL64Fk4xltBjC6Rylygnzp69hA8fJTRluMvwNq1GZS?=
 =?us-ascii?Q?WxrNvOua9mRgT3Ow3rOtCeQEupnBadxxqmzJ/AGBP/2hG7aNCcHUsYKsOfTQ?=
 =?us-ascii?Q?fkfDwjx/NCte/BK0QQZ5XErtENi4/tl9syk6PnUlx/sa+Z6hKeTlvb4jP8jP?=
 =?us-ascii?Q?DcBGgErBD7BEFOaSJjk/ahyvwdKb+oCZnecFdr3g+naOY2wEG7csPKvezP/A?=
 =?us-ascii?Q?/QDN50cs1ulYijC1FmwPu8XfvAPoKvNI3p1kATIbkNJ+OG/+UuyCgRb/l1LD?=
 =?us-ascii?Q?XfZkGF3d43PR/pxCKSyMbtsyTtgqRJbSFjVHpOTR5tv0clf+VRuKabomf2YM?=
 =?us-ascii?Q?2rwaBAm0IPikbSXM2pLkueU97ojCj6sR7pgWrXS8rERg7INF01/+NFJKGKez?=
 =?us-ascii?Q?uguZd3ngych40huPLm9l0uEijhg/kxazrnven7Vj6WTwehaFMD+qKGoI0CpN?=
 =?us-ascii?Q?76zUTgrerjafAskEHXlloYQUGXsjwzTjE3nkHielO4Oow0D2PJaJT/FBJj9X?=
 =?us-ascii?Q?ToZ+8F0odAuvOv0uzesrsCoIpP4InspQW8CziyF+ySJ02g8eXnuaNjtkuPUk?=
 =?us-ascii?Q?5qFZzymMifBN7snsvaLrbUyWSRgnxgkd/3Zx5a5nay8LWNWi/ZQkx+SegRwk?=
 =?us-ascii?Q?8pBL5+Mu9oxr7+Tl+1nueISRom+8kAwUgSD1lsQVPxTRYIX+XGO9qziDSDTz?=
 =?us-ascii?Q?SvR1JxkPYsE7O2HzCVeRQeCxCRd7bt0t2iZ/ohfBVQrc21BPyZumBjts5zqe?=
 =?us-ascii?Q?bBa/OudMlWz6aQL0l3uTMZcaRGfZilkvNIqQ1BVvwFIVipiPAESJRFnI+826?=
 =?us-ascii?Q?l4bYXmI1MUYFqlZHznMqd1g08cSwjGvVYd9ywfbD+O+HIkEZRbv4H5YqIdpa?=
 =?us-ascii?Q?KZ+N/Dmz+3YsrSPXV2AOIdDe/3zp+1DF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:08.2787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d987b9-5787-4e6d-7a7e-08dcc6b70d40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Previous disable ODM policy due to underflow issue with sharpener.
Issue is resolved after updating sharpening policy to apply to
both windowed and fullscreen video

[How]
Remove sharpness check disabling Dynamic ODM policy

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 86a877f9a2ec..b0d9aed0f265 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -514,8 +514,7 @@ static void populate_dml21_stream_overrides_from_stream_state(
 		break;
 	}
 	if (!stream->ctx->dc->debug.enable_single_display_2to1_odm_policy ||
-			stream->debug.force_odm_combine_segments > 0 ||
-			stream->ctx->dc->debug.force_sharpness > 1)
+			stream->debug.force_odm_combine_segments > 0)
 		stream_desc->overrides.disable_dynamic_odm = true;
 	stream_desc->overrides.disable_subvp = stream->ctx->dc->debug.force_disable_subvp || stream->hw_cursor_req;
 }
-- 
2.46.0

