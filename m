Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE014C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E8010E8A4;
	Thu, 25 Jul 2024 18:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="omM+K84N";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA8210E8A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYQM56396nK2hefomK2YwB8MZ6oHQjM+4E44HjCDc+SGVsv520hdsE7ijK2+HfXywT0+OTtwPavorHParDiEU2F9lXxPOemI69AOwkZeTVardPiKzHrFE+ZxwT0D5FcQuv1hu22pHi7WBQZkOBEQi3gMjxRoD01hOU0ZBbmSZDw4eoVOAWhRv2Z02NWQvtN/PgCBoLEhxBO2yUUBEa2qmU5G19Ud+PgfcN0HrswQBT5xsbO1WkkkLneRwHJy7hAtrWAgpx5NFoI+eyj/Y+frG+P88ugutCtaP0DNqXxrYatuTn0GXtWX6ajgy2O7c9R3S6df2IsqYUBkwKtycQyqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XKLmA7lF7ep+nLdM20sj2MpU3Mg3b2wAYbpg1Pt3z4=;
 b=lTqu3Fa10aRz+NPcTlEelejOqlSDXLdQT6uaxU2hDXJ8NqhuPcfYoAZldpz2uy2nszVrmZUHwgh+cb7un8fPSzlh4eN7yqI5wj8qzzeClqY6AQ+rArJHR8ltgOr8hp9mHIQmHkePwzG0pp1Wu81dN6YdAZUk/6dB06fQfBL+NGL98WZRQhVseFF3BxIKngbvTD9RZFy7zocFHxvR2CfSj7ZeBcXCaJyIdp9MZwtk9+lc283NIy2yM/sltRuj5zKeFZGRRMnbszHGf7M1MYfHYK8mcKgFI0OqTFRh+2DzkbuiQymOIGUoQK7QSDBNjxhb34cMyHxkriUgpKuBF3pk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XKLmA7lF7ep+nLdM20sj2MpU3Mg3b2wAYbpg1Pt3z4=;
 b=omM+K84NAX3DHWXrubEwUN4raD/hvMhEwLl+9+eWVhQ/UC2EWhmJTd8c/PSSkZkcLaHPrgmGC6dzNG7T7/960g8GI5a2CG/+GMNGgSBZ//EK3Z1JahxMSwuJ0xBVLKfF9o6Qtq/qy9l5HcUmGxsmixfOCiNBemooWQ96TAtlhfk=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:03:59 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::bc) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:58 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Sun peng Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 13/39] drm/amd/display: Add a missing PSR state
Date: Thu, 25 Jul 2024 12:00:57 -0600
Message-ID: <20240725180309.105968-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c6e499-a861-4cab-1dfa-08dcacd42860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rg7CSkImxtTZLXy0kx9SsWB8ceaAJ8maVDzC7Dqe8npyEtLTuDaj7WhekOLh?=
 =?us-ascii?Q?SRy8r8LmB8HDeWUen1kWnt+ElUiOupCubMs4hxN4vHHNj0E0Aw09C/FdoGar?=
 =?us-ascii?Q?TzrxLS+/ElPBOBaZHj+H8EzlqpZrMiTuONesTLQDzQRjqUl6FQ7o30DtYfhA?=
 =?us-ascii?Q?jmlmWxPDbsZR8LsljyTltNJPag3j6hWBikbxKlzJTJNPwTX5/pR3m2M5de5Z?=
 =?us-ascii?Q?kCyJXWtyxMDdjx5U9u4mRjN482Tm2A7wc4NzvEBmvJIl697LP8xcEErkbbM/?=
 =?us-ascii?Q?Q6wkaD1iBybs0IUCOHD0/qWVIuYFHe5KZudc1fpegXaJQe6OvX/I8V1Xfua1?=
 =?us-ascii?Q?SqRg2fkVmk6UpSPvdtc2nPYJPAZDwRQYot2QMKSXoTAJSbjOZSY8NeDvuYmR?=
 =?us-ascii?Q?W9jm3Td0y/Mozbb0awgdHnIMh0gmXN/rQDLmhPU43vmL/YGMA/lVFkXZWYTj?=
 =?us-ascii?Q?idf7KkA/CEwJ2IXXcuW1CmVjtI5vrfHNPPQxN7qApFPDPZ5W/bzIccT1LEIT?=
 =?us-ascii?Q?vLnhn81Y1tx/YQa8K909ljybVRf3jmV4nnqUZdHtkTh2iMnGqwNzNxLscEM7?=
 =?us-ascii?Q?8DPRMPHdCeZPOZdBIrGaAfa+LLV87L72iSjnn/uE0vQbs/lneWXLdDyJclxI?=
 =?us-ascii?Q?AMRs1FPq3kmkucUu35sJ2Rb0gLE6jeDstKOPDuZ7AsF4yVfdY01rGQDZHe3E?=
 =?us-ascii?Q?dHaqRKh/TwVieA2x3R3z3ayoK6sFGXoICOtzsIi74QlYlWXsBlz6YpUYOayn?=
 =?us-ascii?Q?OQHpZ7Tg/gQdIXdutFnEcLlQW0qarnuzWeTiwIhxTBdbbLFCOAyM01o3K4qj?=
 =?us-ascii?Q?FwtVvvk4lbUHLu50Eh6zKZ4HfDshGBwd3VMEcVhdFOxM5/+ntSAKKTOLt27I?=
 =?us-ascii?Q?FGkAwa1MieA7gXMgql2rv7jNaGxGnqDjxb6q3m0We6L1Lp8/+YnZFH7y+sdz?=
 =?us-ascii?Q?MwWRqR/uOmeCZb6zCXSy7xAZKMtVcHLJNsccbpZp2WGJ1kAHdqaY9rFPWrFU?=
 =?us-ascii?Q?fVG7C8Szo5w8zqlWTUcUjejkzJb3dTMwTyqmdGMZ6ozZqJFjv42qBP/po1Oq?=
 =?us-ascii?Q?RVooyfylE+7fKYG9O3wItj5+xnQZj6qu7HuyexL06ud954IO3cRQZtNLAHMt?=
 =?us-ascii?Q?/t88j1T2Ek94rQQR9LyRSbGsPzrgmt2hrtMtCFZDku3QooWRgfVUgaVLtNnz?=
 =?us-ascii?Q?4Jsaqc0DGcUL4F4SArBMUYo9ql9lYkTOmAVltOpTzOcPxOnwey5NFtVl6qAN?=
 =?us-ascii?Q?NEPyiaYDCWVVHGwowmSmQfH5gPLDV90h1qwbP932NgDbJWA2ofUw8FVWW9JX?=
 =?us-ascii?Q?RVayiqN2md4I0wtlHsAAjN5FELXi4jI3oGIuL4Yyr7PkVPQfcmDFJ0dhdoHp?=
 =?us-ascii?Q?B0UbjPRBr3FmLVlKh+oc2KzSXwlQZPLI471s9A7sAzFzUqhfrfcFOxYIlAqi?=
 =?us-ascii?Q?6EPdtX3HLMBoJuFcHw4/AmjwBzQJ1me0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:58.7856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c6e499-a861-4cab-1dfa-08dcacd42860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why & How]
Add a missing PSR state to make the dmub_psr_get_state() return a
correct PSR state.

Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c550e8997033..97279b080f3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -590,6 +590,7 @@ enum dc_psr_state {
 	PSR_STATE5c,
 	PSR_STATE_HWLOCK_MGR,
 	PSR_STATE_POLLVUPDATE,
+	PSR_STATE_RELEASE_HWLOCK_MGR_FULL_FRAME,
 	PSR_STATE_INVALID = 0xFF
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 0f3d15126a1e..cae18f8c1c9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -94,6 +94,8 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 		state = PSR_STATE_HWLOCK_MGR;
 	else if (raw_state == 0x61)
 		state = PSR_STATE_POLLVUPDATE;
+	else if (raw_state == 0x62)
+		state = PSR_STATE_RELEASE_HWLOCK_MGR_FULL_FRAME;
 	else
 		state = PSR_STATE_INVALID;
 
-- 
2.43.0

