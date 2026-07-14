Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908FC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 12:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3802D10E05A;
	Tue, 14 Jul 2026 12:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="05yyqWXe";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114DD10E05A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 12:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT3rTpeG+x9u0bQS+AQSHITxQEmTCU5DaxBwrJlhLQ7b6yIE5hQVnPwgKpkOX77wus+9B5273hsMiMuFxoMMkqjtXp5lsSWxFEuaCKGs8MrGibY9xaq8STFr9+X4/hwZvnBE2LKDz1ZB4kkMIAB52w8s2+MoTBhYJaZJv9IhC07cYnDJDWHhnNp8MiQBqhILUYobXh0Bhh8R4yq0tczZZSGsFt0b3ivIZBUHZVyzQjfkv+xee8cZ+tkqh83KimMDwQjYjZ2taKIEE6tU8hLHWZ9vPzfvnsWvONbntrAWIbxwGf0lJ6nMDV1Xg/pcgP2DZ5kYlrzDYdaQUkuUON1SfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jWeVm+VHEHHG4+/5zQ/vi7GL97DiccP8hwMNT+ai2o=;
 b=aIDFLPv5iT5rujFOv+K4hr/HFOBtRv4A/wm5YtJ9GriWeGM19LB4TDtz0XBCM91ajsC0F+NvN5FxM5GxLT7/t28aa/Hn4Vs4D2gBWgiTyVYNpvW6G4AiqCnUltDZ7PQqw+GUXZFM8u8PgO+bMqvVqPL28/kmGKf6q3rE4KYePoWvm14tdpJ5p976Cpu2LHVY5V7lt8lEdMR1BnNpf0a7K+BUyzyyfEB5eJwgh3ElDdQXiBdUIxeMgmSD8Zlmarp0uvG6rpNrBlXzVPs4eV6lqpQ7vTAPH8s7Fk4B6AQmg6JHESjp02BjhklWNWbn3ovekLNPS9Uxw4m7FKd8FX8kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jWeVm+VHEHHG4+/5zQ/vi7GL97DiccP8hwMNT+ai2o=;
 b=05yyqWXeHFDChfaS71mJqf8pj7/+UwksJtk6dbsdSXOXAX/AE7nR5MwS4l+fy7QKblLJXFiTj+KaOVBhVl+Zi66BM7DUWKfkx7LxtZbP+OCCJtu/ciZwIiqjWna8XEZvO+kID7j7f8hI7JD8fisE2zmsx2rR+1MN1Oeo4h6I2nw=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 12:38:17 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::96) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.20 via Frontend Transport; Tue,
 14 Jul 2026 12:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:38:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 07:38:13 -0500
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 05:37:50 -0700
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, <Lijo.Lazar@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init
Date: Tue, 14 Jul 2026 20:37:21 +0800
Message-ID: <20260714123721.105472-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: f1197273-348e-452a-b1bb-08dee1a4c72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 5KzYrqskGNJoJcJNhvMnEg4qQ9nkH+tC8KxG6TyyM7vwNA/4cVhe2NehB2jBsifyFlJPHvy3DPFb+uExZRos76USXLLMF2SSHrg758VZItP+blNm+bz9wyx0Ryof8eQxoKt8q/X3sE1ffjjIs1POsQfewb/ESNYvyMCgWdSMYtjwYxGOWr3Fl2B01mQ+eyZjgPbhUa9pCLUwZa6MDaubu/LpMHuK19ifx9M+5cK3iqswYuicoH1Zoklr685eSMdmgbjXrilUtlJv/0S0emGRHKBKnfTJqhqNcUxv4cDQsMR3eHzmY778ZyHX2zeTiGFOWr97FjsLSeyIAohG8BWLdTuc7oUKCyOLMly66UFrzRhAtWwGT0+X7nZmYdOPc1R1rj3YPFtkXyCxgPTdexTjygGBFlmJWEwtWtava+BhddlSXD3JmZl2RNgBoCtN9T36Qjvnv/8MN8bwJkdApY7aC5gw2kuHSDv0pmJgjjqhyQf1zKMbxAayU+buhrFgmho5F2xXHMahG5vVut4DGis1vmfq101N1NtwMa87E+F1O9t0BgvbtYZs3eWOcsipQBCzcF1JQb+K8lPzSbYtrtkNrfsqRvm0W+nRVYMPkyQXpKubIFPWdqAndOgrFpe/+qSqzRZU6fj8962oPd0TFbY1qmGp8LTIm9d+PTdByZIL7tUt/f4CDYg3qt/g9nRFfr2MfBvRaAMWRe5RBnHBB4mxbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sHmyE+c4f9x3MO9B9WW/j+nXx8qDiBCuOzT0/lIjLyqTixGaY9iwyc1rjROYG68pKSGWPWKUPt3meUv9MKgy7v08w/LHohVRTA1/P+isTQGwvUlAH+7Szk0JeYXdQF3qdfoVPT5qa41ZarVcy1FQcyzPW2+3VoAvuIP9DmizcLfEOjUFhqty5YSk30EX9m+USx0OZwbK7YOtTYA0a9HcggPtu6wIc+VuqGsneyy2DCHxIeIueQSTVqRAhfFq4r4zTKDxDoZk9izIJ1G5GPWpsVx1Xo783LQwZNd2snCzt7lGzx0Hmsn4z5PSSZKU2N8Qbs8HCoBUYEKrO8lbHFLq1RfsHwn1dpVvIR5f1eNOd6qUagmzaouUwY+rz0matGyjJXAYGO5aJvhbc649gT8NDzr/m4pgiEH5s5lWnC5Ra5pqbETszzfyWSoPwqb0TgN0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:38:16.5093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1197273-348e-452a-b1bb-08dee1a4c72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The XGMI reset-on-init path can run while the device is still at the
minimal init level, such as during an NPS memory partition switch. In
that flow the normal RAS IP block hw_init is skipped, so unified RAS
is not enabled when the early CPER initialization is attempted, leaving
CPER disabled for the rest of the device's lifetime.

Resume RAS after the XGMI reset-on-init completes. Once the RAS manager
resume succeeds, the RAS resume wrapper performs deferred CPER
initialization, keeping the path a no-op for devices where CPER was
already initialized.

Keep the deferred CPER retry and its debugfs registration together in
the CPER helper. The normal debugfs ring walk skips the CPER ring until
CPER is enabled, so the ring debugfs entry is created either by the
deferred helper when debugfs is already available or by the normal
debugfs walk.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c    | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    |  5 ++++-
 6 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 6fb129025761..0af8b7be326e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -498,6 +498,25 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_cper_deferred_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (adev->cper.enabled)
+		return 0;
+
+	r = amdgpu_cper_init(adev);
+	if (r || !adev->cper.enabled)
+		return r;
+
+#if defined(CONFIG_DEBUG_FS)
+	if (adev_to_drm(adev)->primary->debugfs_root)
+		amdgpu_debugfs_ring_init(adev, &adev->cper.ring_buf);
+#endif
+
+	return 0;
+}
+
 int amdgpu_cper_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index d12c98077d9d..eea30be91b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -92,6 +92,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev);
 void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
 			void *src, int count);
 int amdgpu_cper_init(struct amdgpu_device *adev);
+int amdgpu_cper_deferred_init(struct amdgpu_device *adev);
 int amdgpu_cper_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3d1ede5f8de2..fd349eed820f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2184,6 +2184,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 		if (!ring)
 			continue;
+		if (ring == &adev->cper.ring_buf && !adev->cper.enabled)
+			continue;
 
 		amdgpu_debugfs_ring_init(adev, ring);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0eb440e4ca1a..8bf3fd015a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5002,7 +5002,13 @@ void amdgpu_ras_post_reset(struct amdgpu_device *adev,
 	}
 }
 
-void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
+int amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
 {
-	amdgpu_ras_mgr_resume_after_reset(adev);
+	int r;
+
+	r = amdgpu_ras_mgr_resume_after_reset(adev);
+	if (r)
+		return r;
+
+	return amdgpu_cper_deferred_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 23bff7a0f35b..c53f911d5729 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -980,5 +980,5 @@ void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
 					  struct list_head *device_list);
 void amdgpu_ras_post_reset(struct amdgpu_device *adev,
 					  struct list_head *device_list);
-void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
+int amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index b265b68e0f37..87cefa1e22bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1399,7 +1399,10 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
 		 * no-op for any other reset path where RAS is already
 		 * initialized, and for non-uniras devices.
 		 */
-		amdgpu_ras_resume_after_reset(tmp_adev);
+		r = amdgpu_ras_resume_after_reset(tmp_adev);
+		if (r)
+			dev_err(tmp_adev->dev,
+				"failed to resume RAS after XGMI reset-on-init\n");
 	}
 }
 
-- 
2.34.1

