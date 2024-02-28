Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CF8C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC9810E2AB;
	Wed, 28 Feb 2024 18:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnl3djtN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B5810E47F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEKLMo3/A2QvNIP6aNnj/T9ZH7kbKTAIS38u6wlG/rf0wYPuRVV2tWIXOnZuU5rTeJaVDqYr3uWa5asTo2RwwKYdQAy60l89cp1PvLSftsO130hL1HP/e/NQX+oPPrkbtIMAKWU7efAXUWwEchYIKDJcq/TL6wa6HNrT3l18fnSZTOePgj3ZA6JA/OAEgHWLbGjt8yTp9DnHpYxda5GYt4z3oJMTFYBInWiuCQO3lgScudZcebhOzj4wo7SGClbsAtmaZ/N5JdkZzVlaLehGbKDNWWkU+Rhn/XqjnAaRShFxE+P/3BUxy3EKPCBEcKVXdkgIHedoFdhKE9lk/Oa11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gURmaZSAwBC8KCN9zbKXaL46dG02BXhhRidFrsUY5EM=;
 b=a0tYO0QUfUPGjb+AsrUSRUDbLIdHp0XmLjxB+anaPDFLKmStr4FEVU1yh+QfUCqjHjfMnsp55OkIey5LKMIVW4FVT9Vs9psgfyzZbFLXUDgLSQRZjB8GiM6sybdQmzCGGnUmkDfmT0OuOk2Pvnqdgy/7Rc6hAZSqiRD9bw74IsWnnx4zpem+C+gu6SfXYfMISefR8Exnr224/ttGt8eOsbUv3Sgrp+NdQrfWg0moo+wQz5Hzqa68mFrk/Ptk76CVk2OZzhORZHUjPGxo8ZXgKeqwAbh3EKhT2FiAYvLgby9lE2lfVpIXVE4XvV9jylwyxTRAyPROOe6+5YtlldFVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gURmaZSAwBC8KCN9zbKXaL46dG02BXhhRidFrsUY5EM=;
 b=mnl3djtNDvoDCJIZTArDGaMQxwDTL6qrz4kdIODmTxE5kCrvrzyK/Yri6cGuKQpOQ/GMT20RUojE4Hfmizh9P2qHZDSIK4q21BemonwTHrL9aogrQ6T8f7nii/qvUJ3ECRn6AD0+hGGKUHDKKdMUGKLWceM76aHhyRDMbpRG5gE=
Received: from CH2PR12CA0007.namprd12.prod.outlook.com (2603:10b6:610:57::17)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:41:03 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:57:cafe::19) by CH2PR12CA0007.outlook.office365.com
 (2603:10b6:610:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 18:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:41:02 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:40:57 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Swapnil Patel
 <swapnil.patel@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Chaitanya
 Dhere" <chaitanya.dhere@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 01/34] drm/amd/display: Change default size for dummy plane in
 DML2
Date: Wed, 28 Feb 2024 11:39:07 -0700
Message-ID: <20240228183940.1883742-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aad0793-1e6c-4d18-95c4-08dc388cd0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUnaoN02Y47/4Fx0TeGaplQpSSCLVk37xc0zQyHrmQ11+DkTb4dmAKbWyuq2YSWPdWGzZpOGnozQ3HirMK3DfsUGEe0x6DLqNkjlSehyDFZqXgmry58nk/3apjV4H0wLH6qvkXgnn5BKblHE5gVD6ZCosaLyPyE54OoWB9gNS7ueNdpgt96Ga37P/u4gR8uP6uzkzU3n2e6EWcwhzqEB7b1uZcCxZZjSIJ53OXcsGQPp6YakAPlXIkGkGYtDG2Pd/4Zk03JU7NOfSm6J8sNzoq1c4bwjgxmrMUITATids3xXyOT9aFBaW1QAeKq0RE4OBL/0xYuSZJfgeKQfqpVJ04/zk43Y83EMgZ17+wto3Vh9O/ynfEHAAlHDNdd2G7xrL9Q+gddNstgZaEBplMK2dtVFEvjC43nYlVCkCCHqYryz+6HtHxfNp1LV01IGOd9gdYPIjKvlOv8Stqd7jc1tn55ZAVxyFGstnbd0SzR9fs3mugYg8rEbz+pV9lxAqaqK0NcMfwz7IusBu5Oa3cH9fPdUeSxZc7ESIAil2oniF+Lhy1zDXH/VNKBfM4m8bUy3M0GTKrE2nxXViAOu0X7NklAuVD6uYZ67YPSpGk+1McYAzQ+WL+T/rTeJGrGQjbJjA2ogYN1AVB0Ez1Ns81tQxo45AlLpcW7fIZu+imMdd7t0IsoowNb8RvOXy8yj2d2Ywxxd5N7+EUWxegzbnHy4GzzP52wRrq40AhI0MDMH/awBbeqbcoKWzwBzDvdBVMA7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:41:02.7991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aad0793-1e6c-4d18-95c4-08dc388cd0c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

From: Swapnil Patel <swapnil.patel@amd.com>

[WHY & HOW]
Currently, to map dc states into dml_display_cfg,
We create a dummy plane if the stream doesn't have any planes
attached to it. This dummy plane uses max addersable width height.
This results in certain mode validations failing when they shouldn't.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 1ba6933d2b36..17a58f41fc6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -824,13 +824,25 @@ static struct scaler_data get_scaler_data_for_plane(const struct dc_plane_state
 
 static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_stream_state *in)
 {
+	dml_uint_t width, height;
+
+	if (in->timing.h_addressable > 3840)
+		width = 3840;
+	else
+		width = in->timing.h_addressable;	// 4K max
+
+	if (in->timing.v_addressable > 2160)
+		height = 2160;
+	else
+		height = in->timing.v_addressable;	// 4K max
+
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
 
 	out->GPUVMMinPageSizeKBytes[location] = 256;
 
-	out->ViewportWidth[location] = in->timing.h_addressable;
-	out->ViewportHeight[location] = in->timing.v_addressable;
+	out->ViewportWidth[location] = width;
+	out->ViewportHeight[location] = height;
 	out->ViewportStationary[location] = false;
 	out->ViewportWidthChroma[location] = 0;
 	out->ViewportHeightChroma[location] = 0;
@@ -849,7 +861,7 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->HTapsChroma[location] = 0;
 	out->VTapsChroma[location] = 0;
 	out->SourceScan[location] = dml_rotation_0;
-	out->ScalerRecoutWidth[location] = in->timing.h_addressable;
+	out->ScalerRecoutWidth[location] = width;
 
 	out->LBBitPerPixel[location] = 57;
 
-- 
2.34.1

