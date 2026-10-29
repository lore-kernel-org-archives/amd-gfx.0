Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA46606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NfrR2ffl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8723710E4CE;
	Thu, 29 Oct 2026 18:07:13 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB0510E4CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 18:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB/31/bbRaX80X388OBT4O9gXeSHpucHn+bK+RZPLljR5lsok/L7cDn9QhKSoJClQzbCgycxpuLC8++XSnwj8VHjSPtJBFb2yx136/wrCTAcpoDL8ddarpSgOzHr9/lc3CYhFZXWvxvuf34/tQ//Rau0ax8spGnYpmo9wM55ua/v0a/1/ZLEDbIM7RabVuPOZRrTRuDp0aI+o8fIgezgm3psERDaGHxwIApigqMkpERBPxLyPZwXwZEtdQrwRKgJa+0Ss2h9KkyHAodpDFABTIFLWii1Hc0w3T+SJyk4+FcYZwvNSPkOxGMNhuy3swvFDQDEGyCTXdfS/8W4tGOtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxHlpB834BCb1LJUXke6HiDYJ0+1imBEJi+lVVFpru0=;
 b=T27K9Zn0MM4YQso93qv4AXRbzycqtrQMyE6hsYrEaL5vaNodxjnNo5wp9weqLQO+wgCvNlqW2Jc0O5QsymM03q9RePRbwm28MbGZvTDoGGJ9UzyFtC66s3eUH85UJODSeMV4ZF3xqwxq6gSALiPf1/Bw+QsucvQC7xgX0Ntg0ukfJ7xKbNLs2IJq5zlg+IHx8yqjfvMbaW0Q7zMZfjYvgeYkpX91ID5Nt1S5sZaVxlbesq/Tm2vFkWMsJ96k3ybXiaZGDb6xJ2l91pYqXgiHHegb1ANIDn2SxYvW07ROYH5D9kvJdQXnfH6PUwGmTLe3mP0JqdFkAIoRIfe/3h+4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxHlpB834BCb1LJUXke6HiDYJ0+1imBEJi+lVVFpru0=;
 b=NfrR2fflT69KaVQXYqq6cYHENLQC8XevunTi/X34WtbO8SeAcge9WfZySoGMRFQR6COyoI4Ppl+rulKG76aDBDMo6mMYOt9tf27yxMgholHBZRVhMhvXKDJfo4FtBJxDysnWFpeSolCDDZ/xhXZnGF8sz0gYUk0azvbbSsoFS8E=
Received: from DS1PR04CA0024.namprd04.prod.outlook.com (2603:10b6:8:243::18)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 18:07:00 +0000
Received: from CH7PEPF00000019.namprd21.prod.outlook.com
 (2603:10b6:8:243:cafe::7b) by DS1PR04CA0024.outlook.office365.com
 (2603:10b6:8:243::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Thu, 29
 Oct 2026 18:06:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000019.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 29 Oct 2026 18:06:59 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 13:06:58 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Victor.Skvortsov@amd.com>, <Zhigang.Luo@amd.com>,
 <Chenglei.Xie@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture is
 missing
Date: Thu, 29 Oct 2026 14:06:52 -0400
Message-ID: <20261029180652.213481-2-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029180652.213481-1-Chenglei.Xie@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-1-Chenglei.Xie@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000019:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc5ae7b-d60d-4704-06a0-08df35e76d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261021121427099003|261028144727099003|4143699003|11063799006|56012099006|261009223027099003|261026140227099003|10067099003|261026121527099003|261022105027099003|261021123027099003|261022075727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KdyzG0TZT51jk2ngOylHJhQnRkaaJmOWJ604UU+cmsmfVEn99Srte9gecznuQ1mxM8WQLljRHixfz+w+U5jcTtwOmXf8BVW4efn0aM/bOD9aU4i1HGoMCXX83cUEwIDi8UE6gbVIotPE+SuraAi+am2YXwVbQQEK+xfMwgcsBkT5NCEIDQHutJfhMQo2QAbq7meYJPxb5Cz3v30ChgSpbTMiIvVQ/SB0s7HoCKJ76peIbZCYKr2YTd9+eaObWZfRhAySl0S8WnuO1u5BOj46ztvYtOGZNT5eQKf63vU9xIdoQRHCafJnlSpaOBK1LbAsIr1wcgBdwIJyplGIv1G28KPD56tEtM3zdO2eMGtftFRoJQhaNffInc+F4+AzoCbKgbVBoRzFHI5f0xXedFFV2eyfLcLA98tbCdkrdVfSmR4wgiSQIfjpVRBi7GJLwrB1POA//FaOP2wZ09fKQ2RLTUEUATqpve8TOnLMsla/LYWLIqYR62FrYOUfB6vbwGrqElaBGvh/dRj3DLXbVAZ8gfg6b1TrZUjsy9cM7ujvQBAEwLroG0sNqmQWPl27lcXMbDcupqohxlwV60BO30ShhrvLRCSYRYzAcMaQpBdPQ/5R2fQpv4/DAPOCwwM/RSS6JIa4cRF8FXfG688Yg7bWW1QlU6SPDQr7ERWC5YvsPh2fJB0wGcayz6Z9OeeMEPNtu9IBz37ftWfF1j8W31w7ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261021121427099003)(261028144727099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(10067099003)(261026121527099003)(261022105027099003)(261021123027099003)(261022075727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4pyI2SfVodctUYEpYxw7Aur3kC6nAiNWP2mCg0gTcev2G2SpJWLAqF1266VfoTUH73L6Cu3gnF6p4jvsv/FXYYAC57RZUWiMB0H38dN8114GuR9kn+Y9ZyNsWpjrwc+VF8VYygOkvQ6VCwr4XxJRRqCI8QYy5NRkeypY7S1x0ErOqUFFjFCQvEFXSmKgshE1yBwKjOVR7ER217QrjZuo3q3LCa5RpSU469gFvbESpId6SGYXfDXYxuMUIGfPud9iDc6zZXjP/6qnYg8bhWQ1njzgBIugneOT0Iptu/lVSD0Xm0F6RlFL+fEXSCTKq2DmhUj92d5eKwR2Xp1+72dAYWFbEA7PRYHAX8FnSZGB5J36oBEjaGUctlxs0cbohaUwe1+dsPHDo3j4B1o7xMR1i5wjcJah0yqs7Z1uEo7EXBoM6XyV7E8m1h8Ut+a0xBbM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 18:06:59.7966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc5ae7b-d60d-4704-06a0-08df35e76d5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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
v2: Move the runtime cap and virt ops clearing into a new
    amdgpu_virt_deactivate() helper and call it from the label. Drop the
    redundant SRAT error log already emitted by
    amdgpu_acpi_find_gpu_memory_in_srat().

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 +++-
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3ced5c18daaa..3b6a3d86348c 100644
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
@@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_smu_early_init(adev);
 
 	return 0;
+
+err_release_full_gpu:
+	if (amdgpu_sriov_vf(adev)) {
+		/*
+		 * Release the access the host is waiting on so it finishes the
+		 * handshake instead of timing out and FLR'ing the VF.
+		 */
+		if (early_full_gpu_access)
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

