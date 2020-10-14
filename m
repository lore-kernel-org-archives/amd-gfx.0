Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE1C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2CF2072C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1iaYqPES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2CF2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C2A6EA1C;
	Wed, 14 Oct 2020 07:04:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC346EA1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 07:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJJW+cUEQAz6HiPZDJHY/40Ezgi3o1kp29eNRh18rnJf9BedhA2yjCLlol0j7XtkmOP/3wssiORyUSdRspyN5YZPp7oQjATnrWubBVO/xhKdRIPT7HT+TKasG/f0wYOSCJ6ut2OvpgUBwYWQkfChuegsEbHnKjFjrkMTxNFNnbKJ9PQ8gZK3e+ybdAq618SU0ecqORDijq/uSPnsbAIkwEgBmtSL1aLPRhVk3T+522DYnR1bZvPLx37GLsmuEUu3V0p//7kXPDA9f0xPAjh3AE8UEUxARvV5yv0mYywFRu41UaBaKhlNhv7D5ZGCuoPm7evqfTUnYk6XfqdisTz25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQKDWcDF/VRx3/FyL6tylz5Ra+vJbGhlFIofZ79kqRo=;
 b=TfHbKCp31z+etiBckVRWXRUgfCAvq9E6lYLK99tSe8uk7hI3UbQps3qmrnrm4AV8yu0gr3JZ4I2ZnU3bm8eeilOrAYz1dnntzgFq3Z6MX8yoCx32NXPepQDEQiIefvaShR5X/Eqp0G+gq0VjXsNbZzApkqZplA4m3dmdN/7TfkU7JcFEWSmSwf+r0dQ3cjFncviYmRN8CKgm/eORz2T/t83vLv3t5/1T4PzHWIQNODQcqo29wauOqh2jyCaqG1ONCh/168ysu6Ipl0fV20m+q7NI45lRZoe5oJ2FDPx6hGlg91vY1cbolhqBEZF5NArkrLj0lebhpWc7sM12JgPnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQKDWcDF/VRx3/FyL6tylz5Ra+vJbGhlFIofZ79kqRo=;
 b=1iaYqPESase/3ItyXMViarGoS84orH9iHgbrl0wH/mufR7MoqYlQEj9vetLlAV6NLwe5EVxnoe/3ViMINzTjlS9ceE09D8k4J0j6Nhsk4gBrpstgML2Rchnoax5OQq7Lo9DWZWiNORanfr+My9buqQ6a0V8MpBEBEBOWuGQZWkQ=
Received: from DM5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:3:d4::17) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23; Wed, 14 Oct 2020 07:04:38 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::45) by DM5PR05CA0007.outlook.office365.com
 (2603:10b6:3:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.13 via Frontend
 Transport; Wed, 14 Oct 2020 07:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 07:04:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 02:04:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 02:04:37 -0500
Received: from yifan-AX370-Gaming-5.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 14 Oct 2020 02:04:35 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: setup system context in dm_init
Date: Wed, 14 Oct 2020 15:04:30 +0800
Message-ID: <20201014070431.32207-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dbfbe33-121e-4f14-9baf-08d8700f6a79
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803F6EAC68676A51524E798C1050@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSMs8LJHLLWcGD7DZRD4lDs2RSatr42tOlK8jHMbzogUCZJiwFkzKHtidsvuIoYJgW6HuSt+zU+YDV0IRInLQhctCUbQ9sNhlytXNnopGNo7Rx1NytDkeCN76ZzcGSYGt4+Y3HW3+RJeYM5miYwoptEsaMcXKxWVMtZv3NsnCKMxF2StXNnMRTEOC8L8WXPB4oHBKgWxPA5VPn0+llevGxSvX9xYmZMuYyAQ5qOWLX8H0o8+UTLYygNzGYLb6QASSMuUgrVlPBzG03UE24K3m3mermpT0HdtccxpixODdrP7ac429YtRdPHQeUSUDnDmcAi9A+YvJJbJEN9dS8rulVquEUIY0WtwhYIUzkDYn4xXHrZ+RAmDRBGRvJrwwMDLiRkreVGVnBF2Q3mA5pYhoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(316002)(70586007)(4326008)(6916009)(54906003)(186003)(7696005)(6666004)(478600001)(70206006)(86362001)(26005)(82740400003)(356005)(82310400003)(8936002)(5660300002)(426003)(36756003)(336012)(8676002)(1076003)(81166007)(2616005)(47076004)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:04:38.5080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbfbe33-121e-4f14-9baf-08d8700f6a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: sunpeng.li@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: I831a5ade8b87c23d21a63d08cc4d338468769e2b
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3cf4e08931bb..aaff8800c7a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -887,12 +887,67 @@ static void amdgpu_check_debugfs_connector_property_change(struct amdgpu_device
 	}
 }
 
+static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
+{
+	uint64_t pt_base;
+	uint32_t logical_addr_low;
+	uint32_t logical_addr_high;
+	uint32_t agp_base, agp_bot, agp_top;
+	PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
+
+	logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
+	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+		/*
+		 * Raven2 has a HW issue that it is unable to use the vram which
+		 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
+		 * workaround that increase system aperture high address (add 1)
+		 * to get rid of the VM fault and hardware hang.
+		 */
+		logical_addr_high = max((adev->gmc.fb_end >> 18) + 0x1, adev->gmc.agp_end >> 18);
+	else
+		logical_addr_high = max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18;
+
+	agp_base = 0;
+	agp_bot = adev->gmc.agp_start >> 24;
+	agp_top = adev->gmc.agp_end >> 24;
+
+
+	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) & 0xF;
+	page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
+	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44) & 0xF;
+	page_table_end.low_part = (u32)(adev->gmc.gart_end >> 12);
+	page_table_base.high_part = upper_32_bits(pt_base) & 0xF;
+	page_table_base.low_part = lower_32_bits(pt_base);
+
+	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
+	pa_config->system_aperture.end_addr = (uint64_t)logical_addr_high << 18;
+
+	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24 ;
+	pa_config->system_aperture.agp_bot = (uint64_t)agp_bot << 24;
+	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
+
+	pa_config->system_aperture.fb_base = adev->gmc.fb_start;
+	pa_config->system_aperture.fb_offset = adev->gmc.aper_base;
+	pa_config->system_aperture.fb_top = adev->gmc.fb_end;
+
+	pa_config->gart_config.page_table_start_addr = page_table_start.quad_part << 12;
+	pa_config->gart_config.page_table_end_addr = page_table_end.quad_part << 12;
+	pa_config->gart_config.page_table_base_addr = page_table_base.quad_part;
+
+	pa_config->is_hvm_enabled = 0;
+
+}
+
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dc_callback_init init_params;
 #endif
+	struct dc_phy_addr_space_config pa_config;
 	int r;
 
 	adev->dm.ddev = adev_to_drm(adev);
@@ -1040,6 +1095,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		goto error;
 	}
 
+	mmhub_read_system_context(adev, &pa_config);
+
+	// Call the DC init_memory func
+	dc_setup_system_context(adev->dm.dc, &pa_config);
+
+
 	DRM_DEBUG_DRIVER("KMS initialized.\n");
 
 	return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
