Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB87C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB2E10EBE2;
	Wed, 29 Mar 2023 20:18:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B988010E3BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kljz6yYMktBFoSxuKO2e1XV5IZB0/u0ir5zK43ZaY+jX+s0nPvFbSpXPn58bQiXiBgglrVpJ1McToezMgwHTmmgvdZCK6LmzYSt6xflvQQIV0BDhlK1PNt2JBwuS2Z7a4j/rxnnAcY7t2gUrJN5UEZJmbUMzSHDmkTg6b7OXJ1ZrjPI8BUJ/7yfBVuE7qUNYy3vk9SIIrXtpHVrcSkAiMby8RQLjpPlrwWcZ6sQcLCzY1B8J46QozSmtIzFlcljJl6SuyeFXCnIs/5/ONvXcv8SHrA8qIksO34O05RVclJzev1ktnBYjnqydu5dnLhTVplgkcVUHjw8BCx2HS+YDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSzWP52QPacRJdz0RCY+UL8j+VfQZg8Qe5B2+7H7EGo=;
 b=FFmhRkJjeNnAKd1Np9uSJu08EWbQauZTWR035P/cL0YlMAp8M6SbohHVc26BrfKbKrKb5rc7h1Odb1XwaivqFhc70Ae1HyGZGXupf4ZSWRuH74MX6A6miBSH+NgcaSGcrqXu0Z+RVe64whoejXharioDHWOEpqvYTmrwc0g/JHOUJUQ3y/v4LpLoUcBnvs+aT+poeH1sXCEFBvpeSLJ/VvaY9BeK7dbaeR8h9eP3tpIGmj8H3djK+jMSH8o7sI4RjLuxU4OWiS2DQHxsruJlezREx0XUlP4zwHehaTRLzUcFFHOwKQ/4SVlYy6hxsPw5oUdEUGge0zv4kZpNCBLPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSzWP52QPacRJdz0RCY+UL8j+VfQZg8Qe5B2+7H7EGo=;
 b=s68j0589Es0ui+IVntXlaDAs0BV42OLPXKgI4nxhiVWTdWEmBt8VLvh/lyLa1UlAvqdodBJIFXUpkFfwmjECK3XXW4UcC4SHBYcc3+bpxmH9T5bjwbiCiMJ4I2ZviJp7RLvW84CdEtk2G/VybI5peXClUE/soqCv4UuKY/lmp28=
Received: from BL0PR1501CA0027.namprd15.prod.outlook.com
 (2603:10b6:207:17::40) by DS7PR12MB8274.namprd12.prod.outlook.com
 (2603:10b6:8:da::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 20:18:01 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::57) by BL0PR1501CA0027.outlook.office365.com
 (2603:10b6:207:17::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:18:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:18:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: switch to aqua_vanjaram_doorbell_index_init
Date: Wed, 29 Mar 2023 16:17:44 -0400
Message-ID: <20230329201744.1982926-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201744.1982926-1-alexander.deucher@amd.com>
References: <20230329201744.1982926-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: b415ce08-235b-495b-0cb1-08db3092b247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WamLC2Y1TRtaNVq4ysLdhPetMJ1hOMBXDjOcul5ieo7eYj8s95obQTL0yVTMhTCBdHcTgXtKhOnklmp+xoQF5VmD5ySf2vuDIhm7P4OpfAdv9vju8qKDCyW5ShAVRlO/Yk9fu6sYIEdQ3go+lwkhaIfiUqAk/S5HguFJjBzMwLC813j9a2l8qMWZDoXJfhiOXPltyC01XhU5Y4IQkD5fIWtcrv5guRTgxfB7E6qPu59HtdFWnt4nW6xTbRvKqX7ui3f8+k6L96ASbyE0EdnC907NFNNDGmEryNZ3nhmCM9x0oLrEa34zIWiIA0iJEsRk3gSFhm0OIodm/KFRFP3iYVUV9TM8DCDVJdLoIBMUIjHE7G/gNSruBHievNA3p80Ov8HYWVSc8pQr9tFDpidBz0Ma/rtCsapg6140kgNIpJM4WllDPrLUCzG10Xu0/IDmqKmEAVQsw7ajf0U7rLj0ovjQRv7jDFxAHw6adgNNu9nB/IunDh1UnOgFcBAR9GEg21FtdeUD3lu52XgQzwacPMZ9O6aPGIyaqEDtMTQl7kmfyWwehQaMDXLGz2eZ4lhFtDmwvj178zztndVAjkO52eXV0CXbPoU45ZDD6ZXbPChhn9ypKL1BqPkgMgyPSiVDgCvN7NSt4JAViDsxhusKCXmT6hGw9ZCUtr2PnSvzhi78kcqSSzZU32tf+EBPkyc2OD9X/Y4otchNAZNHKftfn9+KV/Qujs9+kkv6V2YuZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2906002)(336012)(83380400001)(426003)(2616005)(41300700001)(86362001)(36860700001)(36756003)(40460700003)(82740400003)(5660300002)(81166007)(356005)(40480700001)(478600001)(7696005)(8676002)(54906003)(6916009)(70206006)(70586007)(4326008)(16526019)(6666004)(186003)(82310400005)(1076003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:18:01.6947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b415ce08-235b-495b-0cb1-08db3092b247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

New doorbell index assignment is used by aqua_vanjaram.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 24 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index af47fafd2e77..6800a85c5966 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -861,6 +861,28 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.query_video_codecs = &soc15_query_video_codecs,
 };
 
+static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
+{
+	.read_disabled_bios = &soc15_read_disabled_bios,
+	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
+	.read_register = &soc15_read_register,
+	.reset = &soc15_asic_reset,
+	.reset_method = &soc15_asic_reset_method,
+	.set_vga_state = &soc15_vga_set_state,
+	.get_xclk = &soc15_get_xclk,
+	.set_uvd_clocks = &soc15_set_uvd_clocks,
+	.set_vce_clocks = &soc15_set_vce_clocks,
+	.get_config_memsize = &soc15_get_config_memsize,
+	.need_full_reset = &soc15_need_full_reset,
+	.init_doorbell_index = &aqua_vanjaram_doorbell_index_init,
+	.get_pcie_usage = &vega20_get_pcie_usage,
+	.need_reset_on_init = &soc15_need_reset_on_init,
+	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
+	.supports_baco = &soc15_supports_baco,
+	.pre_asic_init = &soc15_pre_asic_init,
+	.query_video_codecs = &soc15_query_video_codecs,
+};
+
 static int soc15_common_early_init(void *handle)
 {
 #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
@@ -1104,7 +1126,7 @@ static int soc15_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	case IP_VERSION(9, 4, 3):
-		adev->asic_funcs = &vega20_asic_funcs;
+		adev->asic_funcs = &aqua_vanjaram_asic_funcs;
 		adev->cg_flags =
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index d8a2a6c2c6e3..9cc2dda087c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -115,4 +115,5 @@ void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev);
 
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
+void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
 #endif
-- 
2.39.2

