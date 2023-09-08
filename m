Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9564BEE57E5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 08:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D5F10E883;
	Fri,  8 Sep 2023 08:47:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2A810E883
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 08:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPSqTEQxkd/AJU4Eyb37LNXbB2CEvwSrp9JnZKj1MCrqkCBmtFDa2Ex/1tls3JuYWIG2bEyLeOpYnd2qXFMcu46fbXSnPNj8CdkByk9AVgFGCd2tHKc4+qSVV+Dnh7XcPmAdgAHs+qIvmPTKfBc8nDRk8tClJwd5KGXepmCbw+4xPTIqExcl/+l5icyYB4MhwU9jg6l0TAakokB5juOFui4kyluFoQjS/5rrHAULTaH34Pd3swr5SSeA8m/3qi2/xjryy4OYV/TiV0NUA5RJFdFLlMeX77wCcgIRK2ZpM1dtYzwlkk/6XB8kGdwJY0QJEE2lQJeo4kCyrVvslG0qCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxEmoGAE3BAKQQzitswmPZcrNU3e56Odoy9/0JV0mqE=;
 b=B2ecJAdfiyCRCtHC4oYl/n4K0wRCEEFTvBkfPeC++PVyjrTwTqWXwr/3MHfKK4b0kXkKg/obX0gN2eq9dmHuthjregyvoNlH5CRG5z5YJCyQ1udTfyWmfzNegQuTNesiN8TOq3Uqw3Zx2+sGkhjxJFYLelYtOhuPxCKFGpI53ZpaPC+SHJDKwXoLXcEGSDgZtY3cpe8Xz4zPLJZ5/EFAfCH6WQuMEgf73oLDYYrRMzx034MIVgYMwL0Rj8BFw/1rTOpQRAsuPFfhSbZWOa+fk9TwxbUv6g6kMYQLv+zQh1ytnviY9yWxYEzVTjaiQKZKfWc6UUj5mG4hj+N5iM0KZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxEmoGAE3BAKQQzitswmPZcrNU3e56Odoy9/0JV0mqE=;
 b=JzwBmw8oC4tG6M71FYHo/e9/uKTNqmoMb9U4S7kQ3MV3Rh2cxG+w84Ri2eWUbRtWoje8uHY83flu5CdzckBZHn/a32/KKwqyuVPeEKVG6J9SZxkchxUDc+B3cfSlsIE7Jra3Xnxed8J4w5eqHR/iyfMiixUzeuly8oTzq4YvUuQ=
Received: from CY5P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::38) by
 CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Fri, 8 Sep 2023 08:46:58 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::18) by CY5P221CA0026.outlook.office365.com
 (2603:10b6:930:b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 08:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 08:46:58 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 03:46:56 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix the white screen issue when >= 64GB DRAM
Date: Fri, 8 Sep 2023 16:46:39 +0800
Message-ID: <20230908084639.113840-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf0dd9d-ac50-4ac4-4bcb-08dbb04829c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbbN0A3KXPlHBqUaxgBtnbZ0IUBT9BA0eg0OwgyRhXqgMmKxxmQHCBN+k1S/v+Xeu5aLA+SL71Upye4kiLezmfv0tVeNEjiDzE2762KfEGAQx+Q3GIWiwHyPeOBFTu7nGGUvJTPFTgW/AJL5/XY4/bQnY215aG/V9OgijX+QXqcLYyog3hczzkQjJeKae6fslwZjAg4dp4CNEu3yqnaDJvvAtwt0s6kry8BBBRF3Bgj//36AV5PSIs5DZswSntv2qA7kbdnh4F2A9UVuVu9i2//XKIgrHU+0e4MvDfU35f8f2yOfaW8Hki2SRNRHetVwHUzzkFBomK0/es+oKPSvwRrx3XNnxu22sEalv+2q9V0tUhY36soCUv9uVjTapsIdjgbRxc4CEPEtyu1RAuhHp9M9R2ig+dEaayFKhX+DYkSZBDstu3y3uXV70LuDav/klyt8VWfDLe2LJznP3ORPo83HAYQVNmHUC9/7El2FnSjOYLMYiwWhbxBuj/vmRB0PMMTNirx7Ngh83kzf5mzTqF5Nn3AD8NjTWhVAGit1jt9kJ+ree6QY7hT5KNF+/P0+nLKEmCWrf/drtoSNUTTzNh+xWtRdGoG+qXntyQ8pi3BZ1Na89maeQ/Z6eTJSGTMBqEXTaFcqmTiNcZqZ0IFeKZwNtEPIJ2DiuF/vjZYEhWAuAaCkkRlYOj5V7Gf1SsJnoT4l+ibcDJa5EX0wVpzQgHuUMCZu0yzknS6Eho0Qp4wPC9T6uSqIpzQnOC62hNuVuqZn98IizLIgUZDCEbHHcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(81166007)(356005)(7696005)(6666004)(40460700003)(86362001)(36756003)(36860700001)(82740400003)(40480700001)(47076005)(2616005)(26005)(2906002)(16526019)(426003)(336012)(478600001)(83380400001)(1076003)(70586007)(70206006)(8676002)(4326008)(8936002)(5660300002)(54906003)(6916009)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 08:46:58.6762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf0dd9d-ac50-4ac4-4bcb-08dbb04829c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dropping bit 31:4 of paget table base is wrong, it makes page table
base points to wrong address if phys addr is beyond 64GB; dropping
page_table_start/end bit 31:4 is unnecessary since dcn20_vmid_setup
will do that.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1bb1a394f55f..f8bf04fcceac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1283,11 +1283,11 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) & 0xF;
+	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44);
 	page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
-	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44) & 0xF;
+	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44);
 	page_table_end.low_part = (u32)(adev->gmc.gart_end >> 12);
-	page_table_base.high_part = upper_32_bits(pt_base) & 0xF;
+	page_table_base.high_part = upper_32_bits(pt_base);
 	page_table_base.low_part = lower_32_bits(pt_base);
 
 	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
-- 
2.37.3

