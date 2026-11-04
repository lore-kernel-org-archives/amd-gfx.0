Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172B606AAE6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=482zpetR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C8E410FC76;
	Wed,  4 Nov 2026 16:23:40 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB4210FC76
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 16:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfRpABrcQ+OQ4k1DfuEeRJXDv29qtvQLNQKnOPYbXSngX7Hrcmd/5+xjuwnhZG5qOjplEOwMxEQujaI7qpNadvIJjnA1fbYxXmHUPbJdQyrG86fMemuLtBWj00ozibrLHc29rLwjdN8RuxFWTajy5/VxsGNif9FuClmYHaY4Own8kuCCiZVnuks9fhSiM9x47fV/74+pC4hdZJ8YFh7VLFwsy9arXpwVE2qMvwkTw1Fi2qQ0GRtfQpqyw4Uh4TBwKLn/aGPuUHCu3RS7u1KZPPSHqd9a7RW1BxJzbMJIlNaya9rRFKdDTmFGDH3xOzYpv5B57vJoVIeaavm7jXXgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnmjfTlw9T1rpsh65xjQViWGos3/LCNBYfDMnsjQuB4=;
 b=Xv72uA4p0zWzTzhgeutV3ENYnyZ5Sh00ggD+KovG7hRn2X7tPfqObsBgbSxJaOp2Gid7p/ZEa0X/3A2QyQtJzU6c2yaUhAgGhCNvwCIzanyodLqzZziGOw31TuX5KuC4L4JAmuaeIxoy3OlSDtACg8EvB3RIHXp7BAaxj+DZoCzcnRI8b8NjvoYLTLPsjM79qJc9viSjBIi+krLC7IXkd6LptdQHQAsMCUgFYJp5DkDzQyH3aP6Rus5uo1cBIoJoRok6NqBMmkC4Uj8EvtqplzYp0l2tRIUmoJfDjoDh8oYAdhIaURlpDBKZYawTGHlipUR8CEFzLNj/4f+e2vUV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnmjfTlw9T1rpsh65xjQViWGos3/LCNBYfDMnsjQuB4=;
 b=482zpetRRTLBoEUPXNrB16eCOkh8XAtZLzlOiW8TbzItMImy5QUZK6zFS/b23a2dehnsHjoXP7EAJ4bLhmvpv2CR3AYijOh6JfaRqCi6DVYSUb5BJsE1yqsTf/6Y+tE2TLa7pEyFktxQaBrhvRT8aG7ayBF7zJJOUJ1y3bVi9Vk=
Received: from MN2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:208:236::20)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:23:29 +0000
Received: from BN3PEPF00022BC5.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::25) by MN2PR05CA0051.outlook.office365.com
 (2603:10b6:208:236::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Wed, 4
 Nov 2026 16:23:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC5.mail.protection.outlook.com (10.167.248.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:23:28 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 10:23:27 -0600
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Victor.Skvortsov@amd.com>, <Zhigang.Luo@amd.com>,
 <Chenglei.Xie@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture is
 missing
Date: Wed, 4 Nov 2026 11:23:21 -0500
Message-ID: <20261104162321.75300-2-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104162321.75300-1-Chenglei.Xie@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261104162321.75300-1-Chenglei.Xie@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC5:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 207c023d-fa5c-48aa-9bf0-08df3a8ff5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|4143699003|261021123027099003|56012099006|261009223027099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261102123227099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: EgV53jOvIGk7d8OBec4LCP0+FDao0ixOR0e/dZYRgCbsfMLMoJ2sBcaTLZcbf2SB2i1yMwbzpoEnGeXiG6wWFxyKaPwyoWWGCqAX80uETb/VfFVpRIubzrDJyWHaKYhYT0agA4PDUSc6H2LjwQJLBEsYIbmsZ2DEXS8KG2cYXm2zeqBehZdejhtvFZkpOT4n8ByiQBQ0yCDZNoMlIrPbwvLCES0vhMslCDXK6kvMdqev7rcyxs0dnRKN8sqpX87Losu9jqxH3fOuIe5Yy6C4vABVwK/x/AIQbGsfow4ppnYXiq24v0r160aSlapor5FFwYklZ/dBD9fXu8yr2Kc2Ihs4q5uxks26PwV8zteRTYGmvZwYf9jv9loLfllIRdoE+DU+9LGx6ynhamh8wuhxTFGJCZkpmQeJPfrn2kGjJMcGh8z69ytAcywO0sVer1NA24rSSbk83xBUgfJfyqsvEevkwB4l7whGTmqmgXs9ZRvIy7sEZzdjaegTls3uBeu/xsxMV5X4mttvSHvSzywFUZZNr60V/SQ008JeSvrOcENTdTOWu4/8jvaEzRFP+xr3Vj0vopfg06l7A79epXM3yYofumvxwyMbouDyjYAOVL4K3xdcMUXF0yyoB2h+sX75B4HboGfrmGEIkECA0pgkJEBn6C5/i1R2VNtRaAKTRiwM/DYomXTSjmMI+MxOX+wgs7/u4Ax1nOtM8RdJ8VY1vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(4143699003)(261021123027099003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261102123227099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PtVl15TT6OubSpCCR86NItCC7fZYn3n3/0fa0869Kh0jgy1S07XbtPGTLZkaK3DoVTkMjILolaEFJOUGZQNxcTUOe+Zfl7401eZud+cONqAn58pV43+cAx4UunVh+88cvIGkv4y+DvvAZXLXyHDUMTKu0BJIMnbCUZ0Ky1hnNH6BOCwd6LAOdpCWHbL/JxipMRYH+0Js78dUmOs15nc2J48RteRn//BIvov1gz/vQWGjmqyAUvoJ8q74baixo/TQuGRDii4afmVC9zu+8G/4ktz1vab9TSEm3aWPpUAJ9lC7zKTEUAhFpQLOkgKFa3jxC9PpHitYnoOYObiRJqIrriQkjBpGusAZ9FouDmUyDk3alhFmOsHWZZzXIXsfZr7MWoZkKTznoFTo8vV0N3nA1xRYCRsQehGzvgIVGIm4gRlhwj7pVeOOPbqlv6/pBekS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:23:28.9853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207c023d-fa5c-48aa-9bf0-08df3a8ff5e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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

An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACPI
SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat()
returns -ENOENT, which the early init IP loop treats as the GMC block
being absent. Init keeps going and dies later with a confusing -ENOMEM
instead of the real cause.

Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the
point where the aperture is actually missing.

On a legacy host the VF already holds exclusive GPU access at this point,
and the early init error paths returned directly without releasing it, so
the host timed out and FLR'd the VF. Route these failures through a new
err_release_full_gpu label that releases the access the host is waiting on.

Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and drop
adev->virt.ops, and call it from the same label, so the later fini path
does not send a REQ_GPU_FINI that the host will never answer.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
v3: Route the initial full GPU access request failure through the
    err_release_full_gpu label too, and gate the release on a new
    full_access_held flag so both acquire failures are handled the same
    way, per review.
v2: Move the runtime cap and virt ops clearing into a new
    amdgpu_virt_deactivate() helper and call it from the label. Drop the
    redundant SRAT error log already emitted by
    amdgpu_acpi_find_gpu_memory_in_srat().

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 55 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 ++-
 4 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3ced5c18daaa..a0b9cff01bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1977,7 +1977,7 @@ static void amdgpu_device_init_pcie_links(struct amdgpu_device *adev)
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
-	bool total, skip_bios, early_full_gpu_access = false;
+	bool total, skip_bios, early_full_gpu_access = false, full_access_held = false;
 	uint32_t bios_flags;
 	int i, r;
 
@@ -1994,12 +1994,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (early_full_gpu_access) {
 			r = amdgpu_virt_request_full_gpu(adev, true);
 			if (r)
-				return r;
+				goto err_release_full_gpu;
+			full_access_held = true;
 		}
 
 		r = amdgpu_virt_init_critical_region(adev);
 		if (r)
-			return r;
+			goto err_release_full_gpu;
 	}
 
 	switch (adev->asic_type) {
@@ -2012,7 +2013,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->family = AMDGPU_FAMILY_SI;
 		r = si_set_ip_blocks(adev);
 		if (r)
-			return r;
+			goto err_release_full_gpu;
 		break;
 #endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
@@ -2028,7 +2029,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 		r = cik_set_ip_blocks(adev);
 		if (r)
-			return r;
+			goto err_release_full_gpu;
 		break;
 #endif
 	case CHIP_TOPAZ:
@@ -2047,13 +2048,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
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
@@ -2062,7 +2063,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
 	    !amdgpu_device_get_rev_id(adev)) {
 		dev_err(adev->dev, "Unsupported A0 hardware\n");
-		return -ENODEV;	/* device unsupported - no device error */
+		r = -ENODEV;	/* device unsupported - no device error */
+		goto err_release_full_gpu;
 	}
 
 	if (amdgpu_has_atpx() &&
@@ -2123,7 +2125,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
 			r = amdgpu_device_parse_gpu_info_fw(adev);
 			if (r)
-				return r;
+				goto err_release_full_gpu;
 
 			bios_flags = amdgpu_device_get_vbios_flags(adev);
 			skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
@@ -2131,8 +2133,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
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
@@ -2148,7 +2152,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 							adev,
 							AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
 							0, 0);
-						return r;
+						goto err_release_full_gpu;
 					}
 				}
 			}
@@ -2159,14 +2163,17 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
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
+		full_access_held = true;
 	}
 
 	if (adev->gmc.xgmi.supported)
@@ -2184,6 +2191,24 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_smu_early_init(adev);
 
 	return 0;
+
+err_release_full_gpu:
+	if (amdgpu_sriov_vf(adev)) {
+		/*
+		 * Release the access the host is waiting on so it finishes the
+		 * handshake instead of timing out and FLR'ing the VF.
+		 */
+		if (full_access_held)
+			amdgpu_virt_release_full_gpu(adev, true);
+
+		/*
+		 * Mark the VF inactive so the later fini path does not send a
+		 * request the host will never answer.
+		 */
+		amdgpu_virt_deactivate(adev);
+	}
+
+	return r;
 }
 
 static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 576a818db522..a4dd0299fe11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init)
 	return 0;
 }
 
+/*
+ * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed init
+ *
+ * Clear the runtime capability and drop the virt ops so the teardown path
+ * does not issue host handshakes the host will never answer.
+ */
+void amdgpu_virt_deactivate(struct amdgpu_device *adev)
+{
+	adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
+	adev->virt.ops = NULL;
+}
+
 /**
  * amdgpu_virt_reset_gpu() - reset gpu
  * @adev:	amdgpu device.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 3971bcc1ed11..3520af170278 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
+void amdgpu_virt_deactivate(struct amdgpu_device *adev);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
 void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
 int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cd276a138e10..3bb13cfed92f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
 							&aper_size);
+		/*
+		 * An SPM VF has no FB BAR0 and cannot init without the HBM
+		 * aperture from the SRAT. Abort this GPU probe instead of
+		 * limping on as if the GMC block were absent.
+		 */
 		if (r)
-			return r;
+			return -ENODEV;
 
 		adev->gmc.aper_base = aper_base;
 		adev->gmc.aper_size = aper_size;
-- 
2.34.1

