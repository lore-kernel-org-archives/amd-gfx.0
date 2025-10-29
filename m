Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7DFCCF9EA
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF9010E6EA;
	Wed, 29 Oct 2025 03:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLTRjxC0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F65F10E6EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G32KO+uWma5q5bTRY6L3Rmn0m8n9F/dVY44d3UGDtirvDOZU7mqjQz5gnDTkqMUM3tET6M6fBabwye5hCUIaI0iLVuDBhWkC7zwOPyTrLMZ9zlkqRBh+kzTYFvn3YqSL5QhHhGVEldVIlF9r8sBySoCw/tyc1ZisR6pAyNuymH9sIcgrTnQw6u1vfa5VwsZld5qxu7YJWTfAO2mdWg2Z85zn6aARABqxJVsGb6yrZRTmb2qrZP7TnqRpgMMOjSh1d/UwjMksajFI3kMTstziHV4cxtk/xzqPZ902bI4egaxq5PGUFGHcsunk8aGjnPwa7iVg01HVM/PUsV1tR2FKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/poaLvWq31ew1yWdCDXA5u5COkKboyf0C0CxR4s1SA=;
 b=ZOUHUHRGi9aIRfnVYquAVgOp3gsR0taRSKFPOOF7GFc45OVNiGslMxVX9luuvjeerXLWiWXhw19nPj/LU5olOprUG+Rr9Y7QyQea+8Vym7sCEOu4Ojoc6/TBvoBR0LI9A1zf4QIbeGp7eWXEzc2T9cdrgbu6A3lSjV1bWXX8mIPSxWzmxfVXoRAHqIP4ah1vqu7dBqNyUAKac8IDunJLOn3Kt+oAryUOo+odxb07PnJvZuDFmMePbtAkQHfDtgcdHy77SEoNU1pnkcvH9nlxQZrT6JD0qvB56I3VZ4PXzxkPa4cZ7vjACZLTSt6ZCjmigqpO/yKZoVplquGCAY5DHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/poaLvWq31ew1yWdCDXA5u5COkKboyf0C0CxR4s1SA=;
 b=FLTRjxC051OC1okovj4fzbfKiiAFpvRihtzLsIPttTYrNBN9C8ScS7cJGDUKAPItWqTbWbJJRo2CLh4/snAUWPc26JDSf7L/odSI+7u9kbTMbmF9J4VKF/zdeSvJsR9DdFmD+TycsLOSNlmmwhfoZPUBD45d49nr8ejEAzKgJJw=
Received: from BY5PR20CA0033.namprd20.prod.outlook.com (2603:10b6:a03:1f4::46)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 03:11:41 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::20) by BY5PR20CA0033.outlook.office365.com
 (2603:10b6:a03:1f4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Wed,
 29 Oct 2025 03:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:11:30 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:11:22 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/13] drm/amd/display: Revert DCN4 max buffered cursor size
 to 64
Date: Wed, 29 Oct 2025 11:02:57 +0800
Message-ID: <20251029030935.2785560-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 664155f8-a9af-45b8-874a-08de1698e187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cKknb1qkGpAK1EvT2PCQfzYW6JRjIilxSX2+F2YHWGnkD3nXE4GtrgyHMHyt?=
 =?us-ascii?Q?hIpw8rfL1oatMKu1tYqIWAc0I4CK9t04NwNL/gWwVI6Nti4UCNP1gLXRjgFd?=
 =?us-ascii?Q?19johD8v7i8IHdVGyf5sadzkRlERqxx6rRyVm4AW10oqktU+TfRXhR5kY1XN?=
 =?us-ascii?Q?Ubku4+NrYORQEkrzfpW9yB5DCtRvacQblEf3DWCJ24YBFurNHYK5FZwLxFEL?=
 =?us-ascii?Q?O92vDCLOMX0V3MYkwW72RIEBVNV9D8VOiTOxtXGitKUaHwqR8X0xVWBBcAZ8?=
 =?us-ascii?Q?4pRRt6bsmvPx0790jhZL/c5toXd9aEQaGT5ZqbRWM1TEMESmAjtaRoSL77J8?=
 =?us-ascii?Q?/n4qjO0wwxZKIW9UUuPjtdOUvAnFDbmdOS+yoEI3l22SK6bVymV2lRjMtYXN?=
 =?us-ascii?Q?x30emfcNuWlz88w7FOw2IJGZtOUTzNNZmhmT22LJr2pWZDTQ+hz3nCEqjpjR?=
 =?us-ascii?Q?PqYgbJDfYBXes9Zpnf/sjfGRzcGa+9KIzlWg17N16wYnDZpv9brrbqhLjjnh?=
 =?us-ascii?Q?ihybWdKp5C5Tg9mGoq23FdKslFktVQUjio2wDm/HUHBSWkSUbeioa9o7b9zA?=
 =?us-ascii?Q?6czeVuagkxlNdw6YnZ5xVHD+oAEIHDK4w3D+79OzzbOGqmQ06hW8xakI/k5W?=
 =?us-ascii?Q?KU2607+7hAp6E0CZaU7loX4mBcv2XujanX+WPu1jxxDxUZucqcPaWCLnAQmC?=
 =?us-ascii?Q?GujJ/aDfa7YnU04DP4nThCKI69zRLtJMp+BtDKYqnlBiys1jfK/ethyQn8DE?=
 =?us-ascii?Q?+1ZI12cb/hrXZide6Kozxr7p/HZI8chT0oqwYseixtMmwk8TG85p2OrC71oC?=
 =?us-ascii?Q?Ni66qWDIZIZlPmy8xLMfUoTax2LipLbAkLB+kdXCWHCzPOKUrZVgwBTq0l5X?=
 =?us-ascii?Q?6b6mfpWjN91hNdn7tifcqZeu2F0l6szkIu98OtfODjmH69JkLp9TSp6ZqWLs?=
 =?us-ascii?Q?FGN/I2LunJ6Xa+f/mOczy1g4KeHfh8a62Vym6FMLgvrQJtW0uWHPNX7YaN0P?=
 =?us-ascii?Q?Unbf0Yc0x+6S6QVF7ZhPWS07LNxxYZ//9S/X1FqD4lOaOyu3cbu78mnuU+aX?=
 =?us-ascii?Q?xPQ/aLfcdqEXlB/ymb3POH48Rh4OGZs8jA3IcFfkV83JUs6tyVCNs/SikZWp?=
 =?us-ascii?Q?dlUJQoePDNEjPKPdWKzTywQVUwfO2vKLIAXmn0Xd7egBonpfxLPOpr2D3v/7?=
 =?us-ascii?Q?OkXqVP/f+zCOQnxrqmgWb1Gvs4Kww3sxZo4wSzK9Me6YEoDmqLKbxe6vPlK5?=
 =?us-ascii?Q?YsQaFkks7X3pZLy/jwwihRil57AWikJgnwyxtzmx8rh6tFT+KobibxadJ2hM?=
 =?us-ascii?Q?FGdFE0hAEFRHALakYUCdWpFRbXL9lwC/yFBAZwhHWGMLbgkv35TlrdeU5twD?=
 =?us-ascii?Q?2FFu0yOi4FheyBKkXIqsnx2SXCH2chbjmejgcAPF4BYip5G1tprAL0CLulH9?=
 =?us-ascii?Q?/qPy0Pes1aXYetZ0hir4bYfd6is0f0S4/6Uc3BWNvvjN7MXBiWwhVZ/BxOSu?=
 =?us-ascii?Q?fSriDLoJI27CIv505ibnI8jEAGNOq/z+7yZ50WEMnnIAyFwE7w/bRB2DINat?=
 =?us-ascii?Q?1EkH+/ruzXR0Ye7F1uw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:40.6434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664155f8-a9af-45b8-874a-08de1698e187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

[Why & How]
The buffered cursor cap is expressed assuming a square cursor, and usage
of the cursor buffer is limited by the request size. For greater than 32
pixels, the request size is fixed at 256 bytes, so the maximum width
must be floored to the nearest 256th byte. At 4bpp this means even with
24kB DCN4 can only hold a 64x64 cursor in the buffer as even 65 pixels
would require 512 bytes per line instead of 256.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 81e64e17d0cb..a9ebd15b9783 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2200,7 +2200,8 @@ static bool dcn32_resource_construct(
 	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a applied by default*/
 	/* TODO: Bring max_cursor_size back to 256 after subvp cursor corruption is fixed*/
 	dc->caps.max_cursor_size = 64;
-	dc->caps.max_buffered_cursor_size = 64; // sqrt(16 * 1024 / 4)
+	/* floor(sqrt(buf_size_bytes / bpp ) * bpp, fixed_req_size) / bpp = max_width */
+	dc->caps.max_buffered_cursor_size = 64; // floor(sqrt(16 * 1024 / 4) * 4, 256) / 4 = 64
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.mall_size_per_mem_channel = 4;
-- 
2.43.0

