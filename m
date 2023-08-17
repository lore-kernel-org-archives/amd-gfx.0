Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10293C3DA6C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B1B10E55F;
	Thu, 17 Aug 2023 18:11:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F58D10E545
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuTQpvClfKD1DOLGZMqz4W/W3yi8bcKVIoYLubZGhEk9yfrxdwT9Y/2PTItD9oZZAZ0bWTWYf6kbsUD0K1Pv8SEpHjIZHHpSm9h2U1GRZrKBXGfa5ghjv+3pQUO6gyYrRfZgwx7D5TRM2rRrUkuaLT4g/XLc+LFdmxQk1TFr7nz7/+QHU+fqL8AaDh8SgzInDANKC+jP0BSjz4zVcprlUSmsuKll3DNRl7y+eWEhGWEDgb/sEen/4oSAKfrHPMIYVnDr40at4myOQG8meUXF/0xMtDjho7TbACtvvtQm00tBIxfgIgv186XusBpDxD0gFImEJwVdcDiXin3d3YtRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGBMJpoH0Gxd5XHjXNronh4ZIW5qbvijFSiDSa8CEXE=;
 b=B3WxooMgL4ZD22AYCpeN+KlLqSAXGKCnZddDIFZ6rBWwWPvbN00B86oyBBsHHJANRE/TPvBB0nrzVen+3KXN0nsk4wnSzMUrRkKSeb6Fw0X5KNwaqg70PuZZ/X5MLd9ADdtsU3LAYuS6QdgrwKpDjYQBzGZ1+tKnXifqdburxd9tCSXF03e8k5etc0ZAjJKZpLEMC8Yn6qAuZdOq8aFCjNioVV/+zSFHJ2EzmODASB6Fz42kPD6bCxZr1gay4oWT5PbhXB0hjL9YHsXkfmidtY52GNaht2OzLH06vovxoryGpSwKUKJOyc274jFLXY/5bF+gz5lwG5dmclVs0eXFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGBMJpoH0Gxd5XHjXNronh4ZIW5qbvijFSiDSa8CEXE=;
 b=McNqaGpgsrp9W/iPgXz6kRNs6kKMmm3v9QY2ZkfZfiCNbc8n35Uq//+ZegBHQ/kd45jYZjBSKDM72/9id+dBfp5lBuK511SFoBN5fGzSEkcnnp7PzuWe0+aEECzh+l+z1FMu1S+BtuS851j98YiAx6x1oW5Qv/K0ICCOMBZhvSM=
Received: from SN1PR12CA0085.namprd12.prod.outlook.com (2603:10b6:802:21::20)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:11:42 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::af) by SN1PR12CA0085.outlook.office365.com
 (2603:10b6:802:21::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 18:11:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amdgpu/gfx11: initialize gfx11.5.0
Date: Thu, 17 Aug 2023 14:11:15 -0400
Message-ID: <20230817181122.1543473-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181122.1543473-1-alexander.deucher@amd.com>
References: <20230817181122.1543473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b546f34-64c9-4f9d-9b0a-08db9f4d6902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAs8vCz4tO2yOnVEVpUorcJ5S2UM95SEcp88nkFUldZilanmDxdhB2+P54o5pArGxwZrHk8jVwuuPGD+tPYXUi0HebD9MMvh3js0tjaRzu9VvT3j8CVfjOfLkcLVYoJnUhTTJExOoHPJE5fvK8BuR7HID191gsNNXwraEXov+wjmKpAkAj2K8hzZg3qTaiGJjK25QjJNU3C5mEVKGMlm2fOitMrsjA9f3iWygicBG9JQcEdWQ79JJ7ZRT1SebiS3ip7WRa3W//7XESzn6u+lo/asoLnvEMQwrnPsw5EbTOYArRUkFm1u3xLs05q11yh4AQRLbO43mzphZQhI+K9dzgwxDyJsUtksnHtipJaHjYlMrMJT8tsfMkbhIaU2kIXWQAXR+e4jhWMJnnC8OZp+ND1zTBaAdi26qeJa4nAFHZ/RLlGKGLbzigYP/q1Fopevc3prO2ildo5tpJ1EOQTZDqxXCj5gx82+sRPgDFsVIK/pf7iCRAAoPLSHJEsfonEWE98BWA+PPr5AC1VRsREwpz3K0MUSjdZRwWfSjwTF2dJHff5DxL+tkV8hmjYQgWYmeUTXrM50pqSM3GrKt+P2KKHiH5WXcVTbr3vqximjFYrdZnnxrjedzAshloKOdQQxiHHzgaZ/Sdg3/zOtRGjxnr6Va/xWXjgHlsO5CcfcWYl58lvcS1dvebS9MVnUkOHU34jHJcpKwXQXiW7SPHl+i98xMC6i7OHlcSfTL50gheKZbGlVZNJrO+vFC/bWb+AR0DYL37Qu6666ROTp9G1lUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(426003)(83380400001)(2906002)(336012)(36860700001)(70586007)(478600001)(70206006)(7696005)(54906003)(6916009)(316002)(6666004)(5660300002)(16526019)(2616005)(8936002)(41300700001)(4326008)(8676002)(26005)(1076003)(86362001)(36756003)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:42.5507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b546f34-64c9-4f9d-9b0a-08db9f4d6902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Initalize gfx 11.5.0 and set gfx hw configuration.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5c3db694afa8..25e93f6a8891 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -82,6 +82,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_4_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_0_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
 
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 {
@@ -876,6 +880,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1316,6 +1321,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -2563,7 +2569,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 		cp_status = RREG32_SOC15(GC, 0, regCP_STAT);
 
 		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 1) ||
-				adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 4))
+				adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 4) ||
+				adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 5, 0))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
-- 
2.41.0

