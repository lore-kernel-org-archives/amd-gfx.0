Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2916C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4291510E0A2;
	Wed, 25 Jun 2025 04:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iI7ck/Rr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C4D10E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1QuNRbMpCFLI90RlDtuh+3Z33gwI/4bGFm+92Ucxwcjftlx9Uefb+jjSgDuDLzg9blwE4m+t/NqsiqOQ2QLeWCWFH92s9Ffs9sRv8lW4euGPUtJcgfpM1Hx+xkq+HGc2q1/eHrM52aQdSSu2KVdTrDIHpsreKDQ48Cbxx3MW1cil8GBXUAWJJANqphmObu3MqqusdaxDgEx4AneH+oazUHqzElDUV90xf8EIHD+66yl8bOuHAfTs1BRMl6bpsfp9KynLKuSMCydrDXXMEjqg34a/LgSNGBaSIAtlIkq+etYlFv0g0BArwDn75owLSBtlBUpxrKdHFkAubcQBHIoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAGkW8pbFkz1cFsPMD5BFTu9d6atnsH0bZvn0EapewE=;
 b=NVj6U61v5tjOTV/77vqkvXx2ql7p6HoXV6iKbMqqCscviQyR2+Y5wuyEOlYczgVk/P8JTMArtlBsBy30+PMj+bj2GFT7blV7jA3W8AjEdVbzwmGWOJ6CkfxjljK+iTYIuKAomeh0LtvBEi1n2rGu9+gs0QYxF6F3cu67otaV5qDzsWWW3H8b/2leNXfCO4L0EhKVSEPZDeVSwtBilfaqFgMRA5hY54Lj1cmXEAPPFA4GjMkPmIydFCBF76T6mZsY8kZoiVTZGa98KW7rynfuYyiLA1Nmt9y1HCHFS0//BrGn2tOww5cjfvW8i3owhl8dONZzAsht3exgmgSmTAv+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAGkW8pbFkz1cFsPMD5BFTu9d6atnsH0bZvn0EapewE=;
 b=iI7ck/RryB9E8tXTkb4v+krya/tGpWTvjKnjKiW7O+5Rz2N6EkmDaIvpahUsnG53X9WqnyrWTx1gprs2Q72C4RJu9gbfzRvMOy4Ggj8tcvVwBQTWgq2H2Nn5yZBludLYnBGfgawZTraUswdD2nU4YV48ck5Acj4+IFQ6cG6Vmt4=
Received: from DS7PR03CA0323.namprd03.prod.outlook.com (2603:10b6:8:2b::12) by
 SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 25 Jun
 2025 04:05:40 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::37) by DS7PR03CA0323.outlook.office365.com
 (2603:10b6:8:2b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Wed,
 25 Jun 2025 04:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:39 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:36 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 07/11] drm/amd/display: Don't allow OLED to go down to fully
 off
Date: Wed, 25 Jun 2025 12:02:25 +0800
Message-ID: <20250625040420.886013-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3689ad-079c-4478-a33f-08ddb39d8c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EAORPUU5j0ouAXKGY0iRDOSBgKR4gHcXB8elHDp1QCRIfKXbc2ITKXks+YRW?=
 =?us-ascii?Q?BFdCB8rid0VpJGSxZGblWVtisSEEUlS/VO7apyMwty6t3wyziqcbFhqdDY/G?=
 =?us-ascii?Q?Ud1t4NiGq43Jzz8n1yqq10Pu5HBYeIx55Zs8DYx22lhvcpplfjBpYPNVoIVm?=
 =?us-ascii?Q?oAJ+Friu2MLSV/KbSIksL42CBrJmBCrM2GlV+MH7HqKU66g1frLf/gSQpY9B?=
 =?us-ascii?Q?m4HZgK+6wZqZxbVScntjXsibNNBUucSkVz1E7VwISm5G1CXuk68FOVVVKC74?=
 =?us-ascii?Q?bFJNfhKxRL1ft+sG+K6TYgl0bzQf9JH0XNmfpSdpPT+1WH4MQto+WaA7WBhI?=
 =?us-ascii?Q?/umQlUvrzlTf8KRzLqRlsumT01N4pRrla2y2g96fEe7Zmkf0y66OWNS+OC78?=
 =?us-ascii?Q?PODovtb1q82aLO+pukTK83wTJvSvMyhVJwBF3zRjKQpd7yu/xru5nKxU7Ef/?=
 =?us-ascii?Q?pb9qGu7CI2ePqh/WsxEDN+TbeQxw6WprNvFt2xuPK6wLqbRAYYWobnpClUOT?=
 =?us-ascii?Q?UFdvN1rpzdoeCxivHmxlUsbWbB6y0JOZGSEUw2e8YONKFnQFUQasO9y0GznI?=
 =?us-ascii?Q?C33rsoZR4LuKl1+yHKVLBliP6PD1KvWRHuGeL0LU7QZtt7rF43G9jl1SyIZp?=
 =?us-ascii?Q?g+Slvkkdbuam+ZLP3RClMFOKz381USpY+2hq8lq9lEFXUykyIgMxwMbIt56h?=
 =?us-ascii?Q?S79hRGl1EYgV54Fx5wz+we7tCIJCn+okNa78uETQ/tCLeAdpmF0Snt4pI1P0?=
 =?us-ascii?Q?wd83bFrEOanOaUmxhxGUqqdzWh3qz8sC6CQa6srD072ShI9wJcbnmeBFcvQ0?=
 =?us-ascii?Q?3/vPHpraZ3oqe7O1P8uogpP4tOEnwtk7P5/eOQiy/X5pz7aOjcqN+Kx3OlKl?=
 =?us-ascii?Q?mNZEp5Ft+v0nPMwa8IeFgdvDp9PkkEYjbiuXmACH7rjbYb9O49tH1mi4gOv3?=
 =?us-ascii?Q?COup/ZL6cL7RkE5MPkANqKQSRQJ6NiiUDKztsi0UTasYPyolyYUTnbUjrgHI?=
 =?us-ascii?Q?0vYOOSA6MuXq5k3P85Tm7N8QXaKqiQ1cLl+jYK8EgAdwG0lIwiVI5mSJs/Xd?=
 =?us-ascii?Q?y4Yb4TQ0PAIuZoLMbNsx+0q97xKOqj0QnPhfOrJx19OFYUfl7pYHsfkX4u0H?=
 =?us-ascii?Q?IdilIvp2bmTlUF3TlFED+Y+Fi/YKW9uhGhUQQKLP9xU1CrA3WC9i93SKBA6p?=
 =?us-ascii?Q?bHrVkIuJWVuFkPUYCEMfkHl1FzItIU9yMIgLuFrqBz1MCzkDBYS876v5BRyg?=
 =?us-ascii?Q?3uO9big2g8Ks3SbTa7cwCsfuIm6e2K80b4e8G6N6JKPQDMDdO6iJhK4YpcNp?=
 =?us-ascii?Q?WiQMc5rpGvVsoiSkX2IX4fuCe0jBsLj2TqidQ77dA69L8Vbn7GaDwB14Togw?=
 =?us-ascii?Q?L+GDL3tib74Wb7W20gd5WI4kYkhIjLAGrqr1JvpQT9YxS+LgOR1n7pOAjUGi?=
 =?us-ascii?Q?kbtDy4mw+kErSp4fV4DZ3SxIUeTCo40zxV1Qec2cnAWz02Jx/TC+BQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:40.3964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3689ad-079c-4478-a33f-08ddb39d8c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798
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
OLED panels can be fully off, but this behavior is unexpected.

[How]
Ensure that minimum luminance is at least 1.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4338

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c380aeb66ddd..9f071a0bd03b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3644,13 +3644,15 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 
 	luminance_range = &conn_base->display_info.luminance_range;
 
-	if (luminance_range->max_luminance) {
-		caps->aux_min_input_signal = luminance_range->min_luminance;
+	if (luminance_range->max_luminance)
 		caps->aux_max_input_signal = luminance_range->max_luminance;
-	} else {
-		caps->aux_min_input_signal = 0;
+	else
 		caps->aux_max_input_signal = 512;
-	}
+
+	if (luminance_range->min_luminance)
+		caps->aux_min_input_signal = luminance_range->min_luminance;
+	else
+		caps->aux_min_input_signal = 1;
 
 	min_input_signal_override = drm_get_panel_min_brightness_quirk(aconnector->drm_edid);
 	if (min_input_signal_override >= 0)
-- 
2.43.0

