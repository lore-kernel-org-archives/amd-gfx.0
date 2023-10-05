Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BD0E93710
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 13:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E851310E3ED;
	Thu,  5 Oct 2023 13:50:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4494910E3ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 13:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9v5fQa3JgKiwzFpAro8eS7ZtxcWkXZwQV4jljKA0lE1Y1Pbb6v8S4qyF/7n3zuGVDmRf7rq25v84AL/piX6QOunoNQF9ZdC93vX9NL7w28WSYihKJVftKeLY96v6vmiI5/jiMtM04YDW68gfd0eoXZCVE2rAKXxZF01kfvuqNdmhIkf4G3s9vyOYKMen7YHJ7XnQX9tpy2qZLW5eDZhWinx8H8X5f3v1nWXWy4cMyh7+FzapTimewrtnKgCZ2oH0PqN7RDXJZNSebfUNt+WLrFRIF641fYP2vv7XVF4Pu3HrO+ouigm9MXqPPdz3ERfQOeud1RKHBPB8RUVGs8R2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTRmHsbhhBAxwyOyiUKsle0uf0kRJmTaS0AwGqLOadY=;
 b=cveNlL9blKHrhBvSiVV56P6kK2G2EWTCRjUiItjeLuyIB0UfuP6NBpkqjC6i8hqYeldGFLB/jAb2Zx5p7tlYb+reqh29dEj62B1K58ir8tzOwfVHzRAJwUXh7evluG/0p9G4xWWOTHAziS0MquO9tLhXbCz+wJXlsF7IGwkMwNVsxrdAlN3hroFv9jxlEZrx+CWneecJhYCeWMX8tlE4up/ucZZjjwllAfptwLl3mi2cU8Qh+SzI+0NIEKbh91gpnK+SvqLg2apwNyOH8daDqffkeXRlPuzqVzuu9ZvcATRmsfsHO9A4SoATotqQIHeczPNAq4szchwTIHE9RroNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTRmHsbhhBAxwyOyiUKsle0uf0kRJmTaS0AwGqLOadY=;
 b=2cqZg5tjjij8xi0bV5vxzMk0jfAJBab64BQlK1f/K70cUE7O4G4VPLdWCpUfg13CffKUWSkFMhTj0rwHpj5p9yOeoa6qacejmaSEdB5D1j02ji8ir8tXYajGw2yYGYstydDz7K0R0fx05lFG5BTUKDhmqM1ppVSvS3L6HMPV0xU=
Received: from MN2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:208:178::41)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 13:50:34 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::65) by MN2PR19CA0028.outlook.office365.com
 (2603:10b6:208:178::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37 via Frontend
 Transport; Thu, 5 Oct 2023 13:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 5 Oct 2023 13:50:34 +0000
Received: from ecarx-native.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 5 Oct 2023 08:50:28 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update ib start and size alignment
Date: Thu, 5 Oct 2023 09:49:06 -0400
Message-ID: <20231005134906.58141-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: cf786829-8f24-453a-6208-08dbc5aa0c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeGZz6lPBkOTcOzIE7QjgkaGbUsxFi01WRcrTDEuko/TsaDddYAWBD/mGubMgKAKZoTd5AfDvnoX1ylHa6YNW/ppsFbM4NDjfxR5dZA7TrHB3QmEqkXaZzo2rRyUNHNqYkCdLv29COzoL/tS7K/bYbkIZmQVmRE8ej43nSwOHmjxnWsdAmEGhoz6HaBFxvhP7IQmLYh7xhjIF19wajtn0VzaYKXtgjo4BVgHpv90iAOFs1kbP5YafajL3+Z/k42RODeSuxxs+hhnzULS1E8ZjNLblebQ09iLYjQ9yj+ymXIqYIXY8PgN3SFK61om6LZV3VtbtZ62cY+5dmLYOCKIo71oO6HrFcA+bwmBVndF3N3yBJ1j2fhVtAHLhFxXVfsSDNkBt5B1F8ZMqNwQLt1fGlXRqmdiPG0M0OyGUtzJx6xddMlJVTZEjcOPeJZG/rJRl/FsmSG8iyrScUZu02a1ie4dGFII9TBfbdmQVJWOA8k6U+f/4qfR0oev6FZWnqRzng1eiN+u3/6QINblOGcyRpPAXkGx0a4+xLQZt4TZf5yME3LicsU7JA+9g7gw4oIoZLhCjQV1v0sKeAx6muZYny3B0sTTJVzIf6UNOrYQP1p5XR4hq6M9QotYkM9Y4KPHr5gKrw+LiTHTRFtIaxdz7nCdGLryx16CLZ7yf1pbVD15DWZQ4ZdAkxSaXfcKossEiY/7ii3AZfo5AfWZQcQkXAuiXWvNEKvoZzCSP82sSNYytSTh02MgZxSkIyEBCSuenbJ+nzUvw2NcQlS+MXfYWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6666004)(478600001)(47076005)(36860700001)(426003)(86362001)(356005)(82740400003)(81166007)(2906002)(16526019)(15650500001)(2876002)(83380400001)(336012)(26005)(1076003)(2616005)(36756003)(70206006)(70586007)(6916009)(41300700001)(5660300002)(8936002)(316002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:50:34.1608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf786829-8f24-453a-6208-08dbc5aa0c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
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
Cc: Boyuan Zhang <boyuan.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Update IB starting address alignment and size alignment with correct values
for decode and encode IPs.

Decode IB starting address alignment: 256 bytes
Decode IB size alignment: 64 bytes
Encode IB starting address alignment: 256 bytes
Encode IB size alignment: 4 bytes

Also bump amdgpu driver version for this update.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e3471293846f..9e345d503a47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -113,9 +113,10 @@
  *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pipes_mask_hi
  *   3.53.0 - Support for GFX11 CP GFX shadowing
  *   3.54.0 - Add AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS support
+ *   3.55.0 - Update IB start address and size alignment for decode and encode
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	54
+#define KMS_DRIVER_MINOR	55
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 081bd28e2443..96db51765a6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -447,7 +447,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->uvd.inst[i].ring.sched.ready)
 				++num_rings;
 		}
-		ib_start_alignment = 64;
+		ib_start_alignment = 256;
 		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VCE:
@@ -455,8 +455,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		for (i = 0; i < adev->vce.num_rings; i++)
 			if (adev->vce.ring[i].sched.ready)
 				++num_rings;
-		ib_start_alignment = 4;
-		ib_size_alignment = 1;
+		ib_start_alignment = 256;
+		ib_size_alignment = 4;
 		break;
 	case AMDGPU_HW_IP_UVD_ENC:
 		type = AMD_IP_BLOCK_TYPE_UVD;
@@ -468,8 +468,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
 					++num_rings;
 		}
-		ib_start_alignment = 64;
-		ib_size_alignment = 64;
+		ib_start_alignment = 256;
+		ib_size_alignment = 4;
 		break;
 	case AMDGPU_HW_IP_VCN_DEC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
@@ -480,8 +480,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->vcn.inst[i].ring_dec.sched.ready)
 				++num_rings;
 		}
-		ib_start_alignment = 16;
-		ib_size_alignment = 16;
+		ib_start_alignment = 256;
+		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VCN_ENC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
@@ -493,8 +493,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
 					++num_rings;
 		}
-		ib_start_alignment = 64;
-		ib_size_alignment = 1;
+		ib_start_alignment = 256;
+		ib_size_alignment = 4;
 		break;
 	case AMDGPU_HW_IP_VCN_JPEG:
 		type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
@@ -508,8 +508,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				if (adev->jpeg.inst[i].ring_dec[j].sched.ready)
 					++num_rings;
 		}
-		ib_start_alignment = 16;
-		ib_size_alignment = 16;
+		ib_start_alignment = 256;
+		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VPE:
 		type = AMD_IP_BLOCK_TYPE_VPE;
-- 
2.34.1

