Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8092D0BB6A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 07:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782B310E8C7;
	Thu, 24 Oct 2024 07:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xHwYOo90";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B9F10E8C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 07:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHgq2wLC7DxEx7Mrw7q0Rym0l077Hgpp3WuXnQeOYyHRnFD9ZoBhh4jw34dQfMkEHues8qXpJRpqGj5V/cgy2Dt0ivETJFAXmzndsPPXOtp9Vtv1n9Jo82PkncaBQaGcGoh8NiNLRDPCdLHMCNySE3i252UDa/tw1l8+HqbH/duz2Jc/Yob/wT4mVisngDQP3p2IghqxL+Qo4lVFkIXkDU3QHYnFAFEr8M0xjizEP+t+vTF6IImlLuoaA437e7zxcBeM/nnzvWHg68RBzSf3Uw6N2ILIY0CR0gnfgWlrJxBFwZX3yDNsR78s4KaDbYhObnxvA+wNSSq622qlRpipDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTkjOKQL666t8ehQYtJUgD4hrl2HCdHlE7zLXQRhuHU=;
 b=JsqV+hoF4yge1oup6ZTpEdRLJzyMkjEBf/5JasQVwfqSJTpXnBCdZXwOOpmRTb0d7zTIZ55xZtGHCymMR8xwjOCQAcf9QSgRAwQEBzuqkFVcoP5t+NQkTEBDBb500tHDsWGU+0154Fqb1TYNAytjsSEhXVru9AXO2NkOwfZbvFiCLmfvJCakX2ukkb8YiUlG5bAowk0Rf8oDyaoQl44LLiO2jSj0oFX5R2JVqAlep84X/u+Mg/2N72nmWeVKCkdvokXObAqwTf2MemCaIp30iKH6zHy7py6pNw375G/zYGIuAuj5y3aZ/d+171TEKaV4EeDXq+PrbgHJcasSkX6lBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTkjOKQL666t8ehQYtJUgD4hrl2HCdHlE7zLXQRhuHU=;
 b=xHwYOo90KudFBveN1/5Y8cpmQlQLh70p8Of8M4YlnM2zMD4bkQVKHAVBiAnNrDmuRaEj76rUffyH5PbtH7J/oUrmDpO6dmjFMKCsJXY7TuFyjKWrLaYiUIrHBklVVrnOnyF/Gn2HDh1tEKeQyGwt22fZMQMTErRVm3mmXbYEj/Y=
Received: from MN2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:208:e8::24)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Thu, 24 Oct
 2024 07:40:09 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::62) by MN2PR20CA0011.outlook.office365.com
 (2603:10b6:208:e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Thu, 24 Oct 2024 07:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:40:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 02:40:07 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 24 Oct 2024 02:40:01 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V3 5/5] drm/amdgpu: Add sysfs interface for jpeg reset mask
Date: Thu, 24 Oct 2024 15:39:33 +0800
Message-ID: <20241024073933.2709389-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024073933.2709389-1-jesse.zhang@amd.com>
References: <20241024073933.2709389-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb4d879-3ccf-4033-d64a-08dcf3ff15bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hvo3Vnia4k/bXFslr5WKEfv8YIbwHnSDPxwgdrBTKjIg3UDlk3j604BRD6OQ?=
 =?us-ascii?Q?0HvxY/4fowBChnPDxTNaR2+E/289j8+MgmQPIRJ+B/+/8+8MaGyUlIfPn+fF?=
 =?us-ascii?Q?PodenDUN7+q0EQ0J7jVvLnESkfFpJFhGyvYrfXwPzp9qrjdPX3wsalc/S+TR?=
 =?us-ascii?Q?NCMRrxcSNI39wE52UC6dXKxdbJDj2sq5J/njPW4HfVemwR8EgqQUF5F7MQ1/?=
 =?us-ascii?Q?1DauqZEqckzjgxh4v7mrsJSVxyrdTW7ze3EOwAmDTQpNiqYfksGIpy2GL3Qh?=
 =?us-ascii?Q?n/e3XBcHi7ev2dgFF7hHETZecmv0YZON9rciKqw2tijzQbPhSkAhmbNHCWsr?=
 =?us-ascii?Q?L/Ja44nXNhZ4HNyhCZ9O918DJmZAUXATcsWNSjogOllgJoHXHhiuqkHhIA/R?=
 =?us-ascii?Q?l15NanfdMK9jW66pRI71oyK9MX2NAMCWnR7JPRPrh82j6mO+yE2mfg2fX/oe?=
 =?us-ascii?Q?2PG1pnj2VWeVH+lORM1F8U6AP0kZ/tXLuJPxqqWbQuM+ckw5QinqlOQCfekB?=
 =?us-ascii?Q?Z7+aN3VTPPhwrd8JgpV2oSmhZysT+1iY+Q3RxKJRwoAhp1DYavcpz8tn5W81?=
 =?us-ascii?Q?exvbxz7zNSZm6pX1E0xZxySPmheMJQanYjvEQgNNR381h596J7YUHAoJDFg0?=
 =?us-ascii?Q?aKViWYfgJYXI4Dut/xfkZcWUmFwByYsGTwL9M373XWAT91g5m1ZTSYG3tI1E?=
 =?us-ascii?Q?iSF3yCooYm7WZA5a3a/cITtohwpDLcGYhbHVlNWPsuzmVb5+dsDYQBMzccKR?=
 =?us-ascii?Q?M4qB8A3PExAkJThlHPYM0VJJoVFeSSkJJxP7EHfT2HrXy9nqfuOPpe7YMWAy?=
 =?us-ascii?Q?eswrmJIMfjosryUZ594muatrpGjhhap46PEu2EW8JVtE3ScLk3JsrYsxuwXE?=
 =?us-ascii?Q?qua18uzoe6aKCIBi/JC1K4q7hdEWRVbhdrYPyeMPWyHpEVbZPj4mZY5GSXe/?=
 =?us-ascii?Q?u6zXyi2scP0vBbRNZZgj8rVdWEr/ZTk0xEW0+WTgTAxa615HBvw5HI4su46P?=
 =?us-ascii?Q?yxJxZvmYdV9vewoz0FW3Lw2/Z/yXoIJTn449LfG2Y5iUyXkdARGRkUzhNGJ9?=
 =?us-ascii?Q?WIfZz/PMgGxlvP5WetmAZAOuQAMzJjPfYzJ0u+I7daoaHbHygUmsLwtFNRXh?=
 =?us-ascii?Q?g+KPckDffvXMWl6ak5Ix4z0QKnJQatKZGdQCCVZRsO3TqMXbWu1EagBSyrCV?=
 =?us-ascii?Q?RaKGsAwzJUB4iw6h0IIzgtBtoso7LMrFinJraO85cepPZO7OcUqYinWEHsGT?=
 =?us-ascii?Q?f1PPGmmfnutSETEIF6Qa+DTF3aVIKL7q/OptQnTGuc21A+YsdLpwJ8J+bwzZ?=
 =?us-ascii?Q?UGIZjKKAzWbFK0K32q8rw1s+ulBs8j6KChm6jCxSHbFndE1C4HSpQc0rj0t8?=
 =?us-ascii?Q?f46AbyQofVBiuU9daygLs44HNV8d2rRWVA5IsayJ3JbVllPX5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:40:08.6115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb4d879-3ccf-4033-d64a-08dcf3ff15bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Add the sysfs interface for jpeg:
jpeg_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
    and print the strings in the order they are applied (Christian)

    check amdgpu_gpu_recovery  before creating sysfs file itself,
    and initialize supported_reset_types in IP version files (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  7 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  7 +++++
 6 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..f971ffdffce9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -415,3 +415,38 @@ void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_jpeg_sched_mask_fops);
 #endif
 }
+
+static ssize_t amdgpu_get_jpeg_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->jpeg.supported_reset);
+}
+
+static DEVICE_ATTR(jpeg_reset_mask, 0444,
+		   amdgpu_get_jpeg_reset_mask, NULL);
+
+int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->jpeg.num_jpeg_inst) {
+		r = device_create_file(adev->dev, &dev_attr_jpeg_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->jpeg.num_jpeg_inst)
+		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 819dc7a0af99..3eb4a4653fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -128,6 +128,7 @@ struct amdgpu_jpeg {
 	uint16_t inst_mask;
 	uint8_t num_inst_per_aid;
 	bool	indirect_sram;
+	uint32_t supported_reset;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
@@ -150,5 +151,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
 void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
+int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 20e1fe89c463..d1ee342d91e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -121,6 +121,12 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
 	r = amdgpu_jpeg_ras_sw_init(adev);
+	if (r)
+		return r;
+	/* TODO: Check the version that supports queue reset */
+	adev->jpeg.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
 
@@ -143,6 +149,7 @@ static int jpeg_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 2a53537db135..8c673fe71e5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -159,6 +159,13 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	/* TODO: Check the version that supports queue reset */
+	adev->jpeg.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -178,6 +185,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index ef2d4237925b..fc60b1e29f3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -153,6 +153,13 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->jpeg.inst[i].external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, i, regUVD_JPEG_PITCH);
 	}
 
+	/* TODO: Check the version that supports queue reset */
+	adev->jpeg.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -172,6 +179,7 @@ static int jpeg_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 7954a6fae464..7ef4389ea03e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -100,6 +100,12 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
+	/* TODO: Check the version that supports queue reset */
+	adev->jpeg.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -119,6 +125,7 @@ static int jpeg_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
-- 
2.25.1

