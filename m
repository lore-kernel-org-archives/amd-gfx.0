Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B948606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=COsU1FuU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E571911274E;
	Thu, 22 Oct 2026 15:32:19 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43EFC112742
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 15:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2lSPns3iN0smpviaaxrrm8QoETEkZcAwgQ5tHpDnEenzcgAfwQAaPWyyXZdGNKByCbsNQZ7Abe2d5gN8lHk8ajCucrjxpOyz66+pEKBY+23/QhwhiMxtwXxDP6nN73xHP/D1HTCMXurC9VD5OnUCeQonrgMlQmqyuWD7L2eCGCOR+ply8ROv4jLQ+jvLOy4RS3PC+PkJba6UiO9cjnEaNNGyjCprFyabbTKKgRv/SLEvfZT5CsT/eigk/D5f78GzrAlXJjQjk+sPZusgnsr+z+0JLXkFNG48OwPK+vX+hLWkhxSuc6h+oyBMre4sD67kB5ttUf40FgEWx0+Zm1KRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPJRTv3PrLqf7ROSDVawwggzexqGP7LXX5WoDV3TKFY=;
 b=iZ0GL2WLaDXtiAkIxSbvwSJFxtEVvTrDPF9G3QliNTDjp9Uq1M8/NOjG/H87YCzA/m+Pa5bYJSYn9nVu+EzYKFAt+kx9Nqv2cWhjyE8hp6c6912jiTFqiipi+WCtida5O2otmcElT1DTgZq5A9GS+DsGX8oUhP5Q9/qLpjL6Hqc/MIMqQKME9RpLjNWmg3QMJtqmrHLiG8kwgcPa2YQiS3yK2Oci6fJ28rpg6DjjaGxniKPjdV5i75o/6oRJV7ophXAneWXNsh5ZB2KFrhwBCAFwJ3QcdbTOCAx+Z9Jd1C+hmtPIUd5s6JsKtjyYKZn4IrUBLqtUzfnWY2bhGqMXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPJRTv3PrLqf7ROSDVawwggzexqGP7LXX5WoDV3TKFY=;
 b=COsU1FuU7HEN9qzhdV022tx82ZrrIFH1ZT2WzjQiADRroRkzWPVG0J30WQlmP5gLTBuiiKUD8gUnSOp7kKkeifzgNFU7wQhh5VTSp0H3Ke3kxvZfSvIjgTe38PTYax/aAflSOBKeVqnoqxLpHhNcZX6jJ3uQIp2A+melDC69eCw=
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:32:00 +0000
Received: from MW2PEPF00014678.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::86) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 15:32:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW2PEPF00014678.mail.protection.outlook.com (10.167.249.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 15:32:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 10:31:48 -0500
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 10:31:45 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Chenglei.Xie@amd.com>, <Zhigang.Luo@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture is
 missing
Date: Thu, 22 Oct 2026 11:31:32 -0400
Message-ID: <20261022153132.211631-2-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022153132.211631-1-Chenglei.Xie@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014678:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fcfa9f-8696-4bfe-4ee9-08df30519d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|10067099003|56012099006|261021121427099003|6133799003|18002099003|22082099003|261021123027099003|11063799006;
X-Microsoft-Antispam-Message-Info: zWk+phe/DqAfsQDr2KlvyU9N++s+2F8nQ2EB8DpeJ2fv6kYztiVTBVW14DrG5niaRE4yphMbVi2XBP42nhneLYeaVbp89hiWDLJtcEg3d/rkzji9rAEnbKjvvOT/sz6McIIu6DOuQfsrlH2FPbGyojtoH9Ck9ZpkTDK0t7F95X3Mb9B15I+TbrATq8DmRSRZmsn5FoFl7pUhxV97dM0ZHaYAEOUfF+5lOKMQxIWCdpkkKySH8XmIQLhh95/kk7jfX6QBzzlf0od68ySeuEDwQPc7Qy0cEESA/UbQcFfVueuwn4LSG+K17eIyeOlevd2UqHfjPEYkSy6KPAbeqhEP8H7UvggFRIHstAv5Zj4G9qW7DtJkfrm0BCBWom19gS9buTa5PRYpxY++5nOVyE6a/N7KM4avuAaxQbmQkjFJJreXbf/rZ5PO7IRy33yrQuRj/VpvxqCYUGkwokz7/zTCsfX/2IdEVejEKL/cVy4pT3cMzmHPCMt6hH6OzMu64GnbxruUpNWVBhA6cOicfY4NtTGYIO6cVLr5OBbqvCMpZuBVLJviZVmtmerrmfXzsNAdXitorXNt7me7SBrzZufD48lcf7lYDRo/8U0t5zPIB/rUnGs7sm35yi1iawv5HfUt88zzbXxnYNp40tYWqIvOoQWMCPDD34JfDQp/6OYa/e/gOQOzh5UseQhPBKbAGkjv2BGX5wp3yRkDsPCA4pfbgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(10067099003)(56012099006)(261021121427099003)(6133799003)(18002099003)(22082099003)(261021123027099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 48fKmKyi3DfQbx27BUAuoCBGWPG2b6C5jnfP34gebauZt7LRnjA6d36dbPcJeF7yA3GhZk38haFk1Ojz4T12gDaQsacG3eefZ6ZuyDlY/B2JC4zjKe/x9umU7pPu7r4OTPCGNxMuU9ir5JyTDvsjPOvVwWPHezo3hapVqWAUPijdFdH2ChqZyw6cJ3MEFdYbvUu7URx1POS2gYqJ0gCwl8Xzgt5kSrYw/G7JUhHVGiBTFGYvzNiroR0UDqTff+hL14MqnELkdL5hByjEVAazq15AveYAiW2hiHLDMS/afPevURnyQYlRUck01cNABMFbRRtF+5anTICKL4fdHr63tAoWlSFdaT2j85P2nlwXTi3FkaPFc4I1G3IcNLvH488igBLdoiZiBYiSM5I1FGbs6sKGCa5t4MokARUEPfloIWDXxuTKITOeYZww45+zgZJh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:32:00.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fcfa9f-8696-4bfe-4ee9-08df30519d93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014678.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init()
resolves the VF HBM aperture from the SRAT. When that lookup fails the
code returned -ENOENT, which the early init loop treats as the GMC block
being absent. The probe then keeps going without a memory controller and
only dies much later with -ENOMEM, far from the real cause.

Return -ENODEV instead so the early init loop aborts this GPU probe at the
point it actually failed. Other GPUs probe independently and are not
affected.

Aborting here also exposes a second problem. On a legacy host the VF takes
exclusive GPU access at the start of early init, and every error path
returned directly without giving it back. The host then waited for a
release that never came, timed out, and recovered the VF with an FLR.
Route the post-acquisition failures through a common err_release_full_gpu
label that releases full GPU access before returning.

early init also fails before the CP scheduler is programmed, so the host
treats the VF as not active once it sees the release. Clear
AMDGPU_SRIOV_CAPS_RUNTIME and drop adev->virt.ops at the same label so the
later fini path does not send a REQ_GPU_FINI that the host will never
answer.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 11 ++++-
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5069042b5279..10002b78c69d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 		r = amdgpu_virt_init_critical_region(adev);
 		if (r)
-			return r;
+			goto err_release_full_gpu;
 	}
 
 	switch (adev->asic_type) {
@@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->family = AMDGPU_FAMILY_SI;
 		r = si_set_ip_blocks(adev);
 		if (r)
-			return r;
+			goto err_release_full_gpu;
 		break;
 #endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
@@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 		r = cik_set_ip_blocks(adev);
 		if (r)
-			return r;
+			goto err_release_full_gpu;
 		break;
 #endif
 	case CHIP_TOPAZ:
@@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 		r = vi_set_ip_blocks(adev);
 		if (r)
-			return r;
+			goto err_release_full_gpu;
 		break;
 	default:
 		r = amdgpu_discovery_set_ip_blocks(adev);
 		if (r) {
 			adev->num_ip_blocks = 0;
-			return r;
+			goto err_release_full_gpu;
 		}
 		break;
 	}
@@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
 	    !amdgpu_device_get_rev_id(adev)) {
 		dev_err(adev->dev, "Unsupported A0 hardware\n");
-		return -ENODEV;	/* device unsupported - no device error */
+		r = -ENODEV;	/* device unsupported - no device error */
+		goto err_release_full_gpu;
 	}
 
 	if (amdgpu_has_atpx() &&
@@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
 			r = amdgpu_device_parse_gpu_info_fw(adev);
 			if (r)
-				return r;
+				goto err_release_full_gpu;
 
 			bios_flags = amdgpu_device_get_vbios_flags(adev);
 			skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
@@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			if (!skip_bios) {
 				bool optional =
 					!!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
-				if (!amdgpu_get_bios(adev) && !optional)
-					return -EINVAL;
+				if (!amdgpu_get_bios(adev) && !optional) {
+					r = -EINVAL;
+					goto err_release_full_gpu;
+				}
 
 				if (optional && !adev->bios)
 					dev_info(
@@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 							adev,
 							AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
 							0, 0);
-						return r;
+						goto err_release_full_gpu;
 					}
 				}
 			}
@@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 		}
 	}
-	if (!total)
-		return -ENODEV;
+	if (!total) {
+		r = -ENODEV;
+		goto err_release_full_gpu;
+	}
 
 	/* Request full GPU access only for the remaining SR-IOV init work. */
 	if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
-			return r;
+			goto err_release_full_gpu;
 	}
 
 	if (adev->gmc.xgmi.supported)
@@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_smu_early_init(adev);
 
 	return 0;
+
+err_release_full_gpu:
+	/*
+	 * Release the exclusive access acquired above so the host completes the
+	 * handshake instead of timing out and FLR'ing the VF.
+	 */
+	if (amdgpu_sriov_vf(adev) && early_full_gpu_access)
+		amdgpu_virt_release_full_gpu(adev, true);
+
+	/* Don't send request since VF is inactive. */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
+		adev->virt.ops = NULL;
+	}
+
+	return r;
 }
 
 static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cd276a138e10..5c6a20e42000 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
 							&aper_size);
-		if (r)
-			return r;
+		if (r) {
+			/*
+			 * An SPM VF has no FB BAR0; without the HBM aperture
+			 * from the SRAT this GPU cannot init, so fail its probe.
+			 */
+			dev_err(adev->dev,
+				"SPM VF: no HBM aperture in SRAT (%d)\n", r);
+			return -ENODEV;
+		}
 
 		adev->gmc.aper_base = aper_base;
 		adev->gmc.aper_size = aper_size;
-- 
2.34.1

