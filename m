Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BDEC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 17:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D427010E944;
	Thu,  7 Dec 2023 17:41:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CAC10E944
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 17:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kltyJWsorRn77NKI9gZfvdEA3vOl/2KqmAR1t+mel6xjeOeYoZFH7EXVeHla23Z0Y4vj8S6T+Go1yPCFXim9U6Cr/+cyT2Pi6sUYypOFUNrGIvF5odomIuBT7W03Qa+Q5v4ndtKa0Lylpf/iyOfuLIKBmJGCTiqt8Mb+7sCQdEaoEy1ucJmaPTpBhbKl6euMGE52NC63oUmmPnT6Avwg3c/9/P3iaJDMrY+517BQQQImXhxjdi22jHtvMGrcJuXwQBq/eSZQNGxwJCGxVQ6xg/xg39JtkH3k2G7amKpGU2hOQ7vFQoE0L/MQiUdLPOXSzXKNIhHqGLKWm4HBLpyE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyALNXo1banNm9NjGJtObpu/SWHz7AOucOvZRvmDQx8=;
 b=Qt+yu1LBHEEEtjw/AITA3IMnKezm7Hxo/tNNTnhdvPK0NRoiMJC/5cdxYAjVFEDW+ScauYUKxvanJ31uLMScA8gty6jD3zFSksBRD0kFjoHr0KtmKljpUlhGUkxAbVD+isaHG9jGsyvowF9vkPrN/Lw3IUu+d+RY31F9p4faScm1B9vuWb+GcgYOTa5ztzTZodbs2WTHapSkpY5ZOi9UspkqtU+qMaOesM0SBSLsw4rV6j0mXry7F8CNc2J0y/8ig2wAEp9Z5FCGtQ3t+Vg7jw1huHZ6odCMjrBAX5kpnq4kAetWIw9dIk+9xg0XqN51lx4gkkdgNR2rMlal2jeeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyALNXo1banNm9NjGJtObpu/SWHz7AOucOvZRvmDQx8=;
 b=5Fy740TBM0BAZnTPmfJSnS8dvnnO7Sdgy4lkohI32+TAXXNzIbrg6BISfcCqkquLI2XMleRB7TDLc1xszkff46brfn/1pj6cTCV38Ip+IeVLO9StZpZHJ2DO8z+Whh++8j5QV5bMsI0NyZ0igVufKMSjXTj7z6GWFmOtB8PvD5E=
Received: from SJ0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:a03:331::11)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.37; Thu, 7 Dec 2023 17:41:15 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::59) by SJ0PR03CA0066.outlook.office365.com
 (2603:10b6:a03:331::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 17:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 17:41:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 11:41:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: add new INFO IOCTL query for input power
Date: Thu, 7 Dec 2023 12:40:42 -0500
Message-ID: <20231207174043.395159-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207174043.395159-1-alexander.deucher@amd.com>
References: <20231207174043.395159-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 9426b95a-202e-4f92-f593-08dbf74bb5b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81J+aPzaV7yYL5zYOKIEsKh+KkIQoZ2Qhz72d+yC2rNL0Qkjvi/n9M17gh1YVhHdpwSVcWHBkUmlNAbSGV2kNRAn19OB0NwJv0QFelmGinm+njr8qB8R1Zpq890jj8NfTLFA4doyRAEL0vEKcJ1b53zRZDH+oNTSXEi1azFDo12TOQC5EqFrVb15fko5y1IN7Isf+4Rq8aQLT3uuXhv7FBexGJ5VBkTVGJ0zK+pan6WxugJWXAr102PKMl+iaTMftxccT6nZu2Q+DVh0Vqww9jK7CWWL8IWjvWmDyGuzEgFhBH+rQxABLOyIJTsobb3nM6QqJYs1OwX+pIqg4PDMH/GGid/pY4ycMtXe2sj3k+iAdqKKKxCdfFZrOvhuBC2DqQQXMOl63GrINMXbmA2dkPheO6c8eNAhfCPBhaKLbfeUJq1F7iTDUkqR1Vo0qbKGAmJ2rfw9fv4w+7KZLSm9x6iTK9ldAAA3nrh23rzd4OnjDAMwuSmDNvErx3HvFM4wlDZEfNt+PTAfH15/In+pOf7v2YA9amvOtaB+4Y1UqWZ8knegT3vVACxT61ktGkKQwEJNzS36O22hiCfqlNZdyIdi8ubWNLiWSvMegyKIicnXehp8SZlSEJ1UMSYsbgI1Jv+i3t/gPaXAkZAv6gFyrR17CzqfYqrX17KYmb/qzmoWej6a9VZJBwnpaCoal1WNGu+EI5p2gmd/tf/uJj8i7AfGKpjBtgN6V5kRGR3kUMaCnNEruGT75gYujm6pnoOE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(7696005)(426003)(83380400001)(40460700003)(6666004)(1076003)(2616005)(26005)(16526019)(336012)(70586007)(316002)(6916009)(70206006)(40480700001)(5660300002)(2906002)(8676002)(86362001)(8936002)(36756003)(4326008)(41300700001)(966005)(81166007)(478600001)(82740400003)(356005)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 17:41:14.5121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9426b95a-202e-4f92-f593-08dbf74bb5b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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

Some chips provide both average and input power.  Previously
we just exposed average power, add a new query for input
power.

Example userspace:
https://github.com/Umio-Yasuno/libdrm-amdgpu-sys-rs/tree/input_power

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bf4f48fe438d..48496bb585c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1114,6 +1114,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			}
 			ui32 >>= 8;
 			break;
+		case AMDGPU_INFO_SENSOR_GPU_INPUT_POWER:
+			/* get input GPU power */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			ui32 >>= 8;
+			break;
 		case AMDGPU_INFO_SENSOR_VDDNB:
 			/* get VDDNB in millivolts */
 			if (amdgpu_dpm_read_sensor(adev,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ad21c613fec8..96e32dafd4f0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -865,6 +865,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 	#define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_SCLK			0xa
 	/* Subquery id: Query GPU peak pstate memory clock */
 	#define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_MCLK			0xb
+	/* Subquery id: Query input GPU power	*/
+	#define AMDGPU_INFO_SENSOR_GPU_INPUT_POWER	0xc
 /* Number of VRAM page faults on CPU access. */
 #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS	0x1E
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
-- 
2.42.0

