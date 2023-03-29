Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDA5C77B61
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3199510EB49;
	Wed, 29 Mar 2023 15:26:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21AF110EB34
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYiPktcHR5j40Ma3UnFZpwQizGag6Mjk9uaAZmUOzuFi0XPFZruIM0GFxi0WE6dIAo0NibWpJCUf34GQopdkHwBANWfCoCYuxm8tCo9vtNAjHjawX8sjOuSeVz8c5MB0GP35LVLroPISOVrjHQmcwiifqwljxTX80XdXsUt6ZYf592P2yq+UucSK07WpiP9AKWQGLM0Sb0ed1fD1yKLQZDr0ve884ho6EyGeRCB+gBGPtl7x1E5w68b1EyTLULTKUwnYkC4TkX4Dpsy4z3xeAFxfIAbNMwcwu3UqS9nQhEBu0ojinsig81a9aN7lAxXrdrrJxQMo9rL/UFd1b3/iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hpazb081GZq7uVg2fr2+sIlSSbx1wOblUHxjgV/nmo=;
 b=OriXh4AdH+QZuuwBzvDo4lDFN76QLUKVW87JRWlH6hC5CUHiTiwKvcIjcLHFT/5uOgHIR7TOlEslb6wC6oCh6ivksRd3oJyPqPLc9aOAtO8SlCCdkHCJwhlE2ooXicbAyETOXCXhxa+BSRyjoEpwDjPkRtRSflS8EJqMdaT/WZpJt1byJBhqyYDONHgd+hyTn4qoJ92Di5fKgMKcZJDsaSJtsxYLPIjcZSDNDNsoUXU6H3enb6+xTQYenkcjAnPPLPN5MsjGsRBS7cdMhxF8YPqMicv+vw3h3zdguo4NIP0+U0w8SFO1Hl6m6/uE9zfirgHYqnvEQbJZZl5meZXifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hpazb081GZq7uVg2fr2+sIlSSbx1wOblUHxjgV/nmo=;
 b=NRyIU12wl0Y5I3QGO/IBE4xIFL1GA5APa4+Ury207FuyKjVbzG4+P88GVZ/PS4657c+7uZYi7bvyuJkvS7fPvy0IZ0VZ33Xq36q9jSjmIvncpKSdBImpyIV/KU2xmzfaIWjqjPoXe72gw0/dhpRh0IXhLh3fcmB6YglFzdYvjuQ=
Received: from BL0PR02CA0141.namprd02.prod.outlook.com (2603:10b6:208:35::46)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 15:25:41 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::62) by BL0PR02CA0141.outlook.office365.com
 (2603:10b6:208:35::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amdgpu: bump driver version number for CP GFX shadow
Date: Wed, 29 Mar 2023 11:25:19 -0400
Message-ID: <20230329152521.1980681-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a120a4e-0443-4bbe-1979-08db3069db1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDETJuSNzEFKyazJZMdcfslAH9Ad+Rx4/AqZI4uZDiBlwSrnrpqjequ0QiW3TVq60iwBZxbhXdjlZ3RCfEzfMjNFsh5NBcmUXqq69Hb4hc2aLYp2tIniUrMaf0fzLatBSGfSLAY/fTpYJ4rtXO03Zm5ZI3s1a/i0pxIlW9yrXrRTphJcg6CSnmekh956Oh9jya2ecOElEPh4UDXp9tRJmPxXCPpv9nLKKZFJRwpGq054s8TFpyK3U+Am/MyeGu4Gd/v25sIq4HF9cKQyW8g9o4R0mNuKp4ydRr7010N2Laou7ODuUi0nolfrh32s5tKfWrQtteJucwQaq5fXaM/yYUHJ7AJx0fZkvpAtThIgwGSdEEDvPYQ1t8/cYHddB4fHspcnOBpp8YMQyNCBqz3MOiNVhzcb2ZYaI+vSczoAla/63x/pFpG8oNSvQFQ7w1C27kuU6wPLG7mlhlMo0LEqic0mk1NQK8TbQjyya1Xt7hoqeN509reRfMtd/We13NwZh62+flO/mqLPVWfTZMUQPnl5FM3p2WylIFBxa0SnPeFq5/E5TsYSWlXYZ8YKZ1jURz/OdaeMcpnGJ0g2By0wHYO1n88dYwZbX9iz1MPollYJ5xLTyEQawqihTgrwX2NEPgtvKLe3xTnvTVS1p7y0dbvPH11H+0arA2fsrSdgsInwQZh7JXPjy7uIEH0QpCqV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(86362001)(36756003)(82310400005)(356005)(40480700001)(186003)(40460700003)(336012)(966005)(26005)(426003)(70586007)(1076003)(2616005)(7696005)(4326008)(6666004)(47076005)(478600001)(6916009)(83380400001)(8676002)(36860700001)(16526019)(70206006)(316002)(4744005)(81166007)(8936002)(5660300002)(41300700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:40.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a120a4e-0443-4bbe-1979-08db3069db1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So UMDs can determine whether the kernel supports this.

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21986

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 917926c8dc5f..c35baee082e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -111,9 +111,10 @@
  *   3.52.0 - Add AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, add device_info fields:
  *            tcp_cache_size, num_sqc_per_wgp, sqc_data_cache_size, sqc_inst_cache_size,
  *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pipes_mask_hi
+ *   3.53.0 - Support for GFX11 CP GFX shadowing
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	52
+#define KMS_DRIVER_MINOR	53
 #define KMS_DRIVER_PATCHLEVEL	0
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
-- 
2.39.2

