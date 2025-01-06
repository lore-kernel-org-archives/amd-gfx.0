Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9762E77198
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075E210E9F2;
	Mon,  6 Jan 2025 20:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wApgre6m";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE8210E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAEZkJAMTRV59ZRtYsZ32AMHvYIGQcZiQxMawnrsICEIh1lIPjgm9NlYETCQnMV0dYAMU259qB6URk0l9ujtSk1d3WAyx3066QR8plppfMih9dCAKdMCxYV2FpEjrs25S0Dtwyc9Bk1YwhgaGMDozE0wp3IcTMZn8pQwFieGodFBJ+h+dCsLvSb92JwpFeZwgFGtazygoRTxraZfPLUeepvniYYbb3d2d8TCR02BPKUvm7iVmKup1pkC+ymM3M5MmvQA8ON4h5tUpp/tr5ISNr4K4TK+8GbJybyE3vz0jjZQcsFUAAjfiHrH2JVJXtATLpkSHivGbSFs//pItTHEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmAYK8zrgKsFoqofiL1g3SMyQCLdj5sVo12gZZx6zkk=;
 b=WBleOxkL8eAd4NmVPk/NTGLiE8WjnHISHKsG2BK4hu//1FM7Ew9Zbqc44/85TJGxaiF6T05nLL49iK/me0xibbcQmUeZ+dopCxPZpuKq5iNBy3gor06kMFlDrOlmZivH7aVY2sGNpZ68m3dNAoVg7dZRzJxNtY9W6wlPFEEW8lIoK50DC3O81brmICLcKpnyqwlxBUt/ro3POzf147U6jan64kCw2ycpnFXz871/PdJMZmsLEn119fNSSnSzZqaLJkl2LM2nU7BSLZL+3J1QhmOlPErFQcy1mUPxZpAc/MuDkGNJgPzxRsVcnfSkFus6sUJRR3WSbOL3Jp6wfd84pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmAYK8zrgKsFoqofiL1g3SMyQCLdj5sVo12gZZx6zkk=;
 b=wApgre6mSsKbd3fbl2JKMeI/yQvsMuQkDH3C1x5+sRxgInjbR0v+OIiJMTmxb1BS9EGCmt3cE+9rUXJWJ2stO9g01lM47nGhwrLrbqu2TR2lxAQYF8O56jjBu7znNu2WDcHxWppQsq5pW1Oy71GMbQuIFKfl4XR2s0XEB+/9i78=
Received: from CH0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:610:33::16)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 20:33:28 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::f1) by CH0PR08CA0011.outlook.office365.com
 (2603:10b6:610:33::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Mon,
 6 Jan 2025 20:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/10] drm/amd/display/dc: add a new helper to fetch the OEM
 ddc_service
Date: Mon, 6 Jan 2025 15:33:03 -0500
Message-ID: <20250106203310.3349585-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6aba0a-819d-49ef-6997-08dd2e91609f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F7U9P4G8wyMMXilaw8TM2sMUd/DNGshV+TtMBYoHPT7v2CVcXmKWGztVYVV0?=
 =?us-ascii?Q?MACbFMC+lZ43uCq3dxQyVOPhmHGsU0/zTPgAVAsto2hAkvtSBCk885TWPJLE?=
 =?us-ascii?Q?uWaclKEjl4bimBx6GR9EP6tkGSLpYTCEO5X4uDd/AUslc3zmB3hvdpm/69po?=
 =?us-ascii?Q?E62OmG3v2L5m3dCmTehiT7YZJsyCgCtyhrHxLqFAmevvfa4iLpwmehvaH5rv?=
 =?us-ascii?Q?wCd+BoiBGHGCMuVbvYm2v8qjQHS4sL/qcJUzgfP2IuYjXRfpKDgG6QZYL7Cz?=
 =?us-ascii?Q?uenT5VK22evZDzy6Zx3j5mQW9ApOJ6QzWhJai7aoiy1UepYiS3svL/bEpynS?=
 =?us-ascii?Q?isvnOIVQpatXQ4o2N477BUzjq8IiVTc1yDAUdruZ/Ds7Wo+1wkNrQ8WydNVs?=
 =?us-ascii?Q?HgrvESFW1iZ0NacHadnB4grPZ7adKa3Ht7lH3/24DsX2O/eIp0zHwePSRRC1?=
 =?us-ascii?Q?hMZv7gRDBql3I/gO9OAvE8DnWBG2K7okUA5AhKPLsZuHhpZ/BYNhhRJIatK6?=
 =?us-ascii?Q?cnL7jhZ2uEqwoZeUlaI/aVpL5MteWfnBXd3FMjJfTNB6Tl9zskRP7s/OZe6O?=
 =?us-ascii?Q?eNOQRTOIWdtIFeyIj9VUIPp5FXgQ9D3Ljx1uZIWiub1Y+lg0vmt6uCbQfmEZ?=
 =?us-ascii?Q?SoOStkfnKukMIDjQNw5nUIEIP0vKYfXt26HMdtMk+zjGvnK32hwKxaZQWBmb?=
 =?us-ascii?Q?aufqIXI2VR6CuE05r+UzG9xl+GJEoQVoL3H6oEhIx8DDQGEH4rq7nC9iz+3Y?=
 =?us-ascii?Q?YCXtoEieU24tgICs7xtQurfO3u6s9V9W5+j71JVC21XjWMPW0S14Wi8PgFhH?=
 =?us-ascii?Q?2CqMom/WnARan8mXiCdaIS/MINj+FWEUrnHtz+SHDsiectomF4kV6GgihuYz?=
 =?us-ascii?Q?tIQxLtnyHrzbqflcQgNTxvc2OgRoGPspBfF01STESZ/lJ9FZTKkPxIn25AT0?=
 =?us-ascii?Q?8+XpUd45xM3OfApqEMBZkSuHQ2bRkPGtToY3OSR/jzHy8tREbOaXY6533rvx?=
 =?us-ascii?Q?lYDq4on1R3pzAASNQ6or2SuAkYWpcqpUH3fc8U7g0WRUm9jnhvdxTBQHAPse?=
 =?us-ascii?Q?lpSPg0UMOo/IDuXOaEhRY7YtTDzNBI4qvY3U+BNU0lE9gFC2TANcgMCNoQwb?=
 =?us-ascii?Q?u/+7X3p61MVGErmab7+ooUvWft2BO7zzYA+PIy8Jssw0i3l+5x+64jCDeEjM?=
 =?us-ascii?Q?kZV+NMxdGGvdgQjlr4iYYYs1YFbedxyxqbHJ9lB0gxHL5xIblVwJ48AfMx2x?=
 =?us-ascii?Q?kQ1g2VYkDdX+x5cbv73Lz0EcOSM0OY6lDKv+FSPnn95pFmspXo46I+IcC7zU?=
 =?us-ascii?Q?aXF2vLEcJWYyIeMjFv1z31SRC7Xk7eAb2IPrgjZvwmiuDWos0cvdnVaeoN8R?=
 =?us-ascii?Q?Z36FR6MSAXhLL6+bSuEQfXFaARwhwmTS4AEcy7vrc9SXJErY4YVUpwc4jub/?=
 =?us-ascii?Q?bx8E73i1XJRh6ulCUQOyTQip879dHwg5c0vfOph5TUTY0cH1ckafl9B3vcva?=
 =?us-ascii?Q?imPMVrQeUp4X2go=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:28.1736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6aba0a-819d-49ef-6997-08dd2e91609f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
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

This is the i2c bus used by OEMs for board specific i2c features
like RGB.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h                   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 457d60eeb486c..13636eb4ec3f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -142,6 +142,12 @@ bool dc_link_update_dsc_config(struct pipe_ctx *pipe_ctx)
 	return link->dc->link_srv->update_dsc_config(pipe_ctx);
 }
 
+struct ddc_service *
+dc_get_oem_i2c_device(struct dc *dc)
+{
+	return dc->res_pool->oem_device;
+}
+
 bool dc_is_oem_i2c_device_present(
 	struct dc *dc,
 	size_t slave_address)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8c6347413038d..47fde4f09f27b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1945,6 +1945,9 @@ int dc_link_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result);
 
+struct ddc_service *
+dc_get_oem_i2c_device(struct dc *dc);
+
 bool dc_is_oem_i2c_device_present(
 	struct dc *dc,
 	size_t slave_address
-- 
2.47.1

