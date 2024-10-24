Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759E0CE8E68
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCCC10E911;
	Thu, 24 Oct 2024 12:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q2rhcB1R";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF27310E911
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 12:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOR+YYrSp09ctR+oW7MRKyjz8BVrUzY/IC35mU9OMZCsKRNifybrfPq6MsBlxUVqOb7sc8JnoNBQabdfq9vLzi/qSwThxnrVuM8L6cEBfhWuTPuSCQMUE4CraEXqZin6ZXpXzS4OgOfGrEd1EBWlcZbRG/l/oVnX4C1iMRGE6O17HEpWk8bW846MFVT1wdC0Fx5EMo2lcdsaYfNE/PU/wKW187qZ/e/y2fMrhqkU7ptYcL6BKwKb5yUe7kjz5g8cCCNFnkVYWvMUfHXSxsXjzUx9+p6Z0TAKlOg2Wyt2KzNTuLc73KZVPBOFuH0tbBr1CYLa+YoBmF2hOaZvbyjt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blY8fYa8yz1xtFI6TIBhRxoyhL7a/KSPsgzjmY6xokg=;
 b=GIMA9ZJNjiqqdJ43urUmgXU9gmZ/5QwnykH0yeHO4mXWvd/3OMNza6zEYyAMr6GHZl+Ru/wkOw+ovj6bely41Ngmu7kBmoLylrXPUAomnVQXy7HqbTnBTXaxERWylVrXnCdEaevPt6UId3DOAkSFRnV/bt/3w50Zo6+WRhyJThQP/TTfTKpWEAFUC7G9HdX9tXbekLBi/fkBGTWaIS89sR2htV/9EPsr2eCya4wdJ/0hvpIy+ScFIlDHtLbRlVd/5EAAM+S1m4Hxc2EgqDZsXmlTwxt7omdVED57ANaGz3AEpo9ugVgOuRocft+h6xO5I+30y1e733a9P4+b0rtXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blY8fYa8yz1xtFI6TIBhRxoyhL7a/KSPsgzjmY6xokg=;
 b=q2rhcB1RVfxod/Pmv1y7fJr32if8B8zEPP0UnTh20Mz3MPY3gMqfB9F36LaHQZGxgIX8dOhQAequTdAYtnwpiGS6nHDzsTuxHNHGAfPoYf7ayYQBt6fTlUxKe9QOuFhAL6TxRTnLBpniAnDrgJAi4U7O8Ra4VX8K8GhYeLPpjzg=
Received: from SN7PR04CA0073.namprd04.prod.outlook.com (2603:10b6:806:121::18)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 24 Oct
 2024 12:11:04 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::a) by SN7PR04CA0073.outlook.office365.com
 (2603:10b6:806:121::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 12:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 12:11:04 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 07:11:02 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add userq specific kernel config for fence
 ioctls
Date: Thu, 24 Oct 2024 17:40:26 +0530
Message-ID: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 5249a5e1-c3c3-4a08-95ae-08dcf424eed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pcZyvQ5VcIUyWaK+jP4a0akr4AWPfdEFdcIoqnQQgPhHK0wTdoJBUo61NCo1?=
 =?us-ascii?Q?54EcOFsJutKgTFoSBtUBU/NVqT3+4WVQbNKrnnHT1GqylfFtIyKYx57Ig+pb?=
 =?us-ascii?Q?7y/4K4kxAVYSn/8sTgZa1BaL5pCYQ2ACwck/bMprw5kvGcO1ZIKzs5z1+khj?=
 =?us-ascii?Q?pcVSzS2k3RDSYQl9Mma0hMtRHpEZkGdZPJow+eEUoXbVxKNqHbYGNUH9TsoN?=
 =?us-ascii?Q?hTdYHia9ScAlSuWALkjjmgqrH9OdzWIpORLIH4MH4HTNigkE3+K5Kn41KvC8?=
 =?us-ascii?Q?uMn90R2Ewl9CnM8OegAZQaAeR+7RtOCTLd5AZ/+0ldzHuXgjeVCPf8azS5Sw?=
 =?us-ascii?Q?6hC5bFDvIjts9YX5FtedszswFVNI5//1BDNSUZah2jEHG3m4ttMN2uxPW2Zo?=
 =?us-ascii?Q?inLZfFcC6XrKQS+ZrcTSfA6haXURmWA5kyswa5zyYLdg08K7dXLq9KDA57Qg?=
 =?us-ascii?Q?bg4wmpeoWpkGCIfu7vtNPoT1qJgSMHbhtzxGweq2UDe/SQ4vhTqa1gRYU1jx?=
 =?us-ascii?Q?fEfvSYTudttenQmj+uvVr0G6X4zCNfNfEOUWljWTtRfGygQeOGWz2TLoPS2i?=
 =?us-ascii?Q?D9yAYHOVLBTO3uZOkKqrViQUW7Oqk2UAC0+pf5EtSUd7fRZQQrRti1r4BcVz?=
 =?us-ascii?Q?6g0rsMqLCpE5TeEpGZgEQkOCkPRpGPT7gbKMsiDE8Q0naZQEzBESgHPRB0C9?=
 =?us-ascii?Q?eb0RYTKwqIvfrr1pTrorKUGxSPbKmn/Yuh2fRFKCgdv0RVTQBDtfi676NJt3?=
 =?us-ascii?Q?lk3Kbcnr/OQO4uOaHyNgUPbsUGBQwk79xoz5SjF1gkNBKAOHkcJoxyfiodLR?=
 =?us-ascii?Q?Bcr3ZJ3nUOGDk5daWYF+7id1qfCEFuFF3/urIVwUrrEbfCnEUXrbxqXqicL9?=
 =?us-ascii?Q?RPKmUeiBUSvB4uYUtPNyJ+gdcj5WATV4przAAO3yclQtRGMCSkYiueFONZ5V?=
 =?us-ascii?Q?M6/N0yjee63JGLs+aKu1R2cfbcevjdlQP7R0sxca+kNBsE8pk6LwxC9i1JXn?=
 =?us-ascii?Q?PUjKwuikXVCnfZZD7li/WTmn+VKZJ2DkQKlT+iHvvRSpqkNnYcrSD9IYjUoE?=
 =?us-ascii?Q?e2hTJemIvq8Y0CtRiHh4U2iapSV1itMsbyAxvLcXagsUmTS0RjzPlSpEnLSe?=
 =?us-ascii?Q?HMr5f/X+j+nF6z9V0Jf1xZZmpyQz0JySxg9sSsnlZVkqxC3/oL28rCMy/VvD?=
 =?us-ascii?Q?Ne2qgNkId8nBC/yoSWYrmCbQ33n4pPF+45zTrp6KeFCUkebQyIeBiqdK9K91?=
 =?us-ascii?Q?hYncOlQa/Phf9PBU/d3GAI68YSkokwXVXSamNTIlh3LkcLjAnxSopfueoCN5?=
 =?us-ascii?Q?eRA1t4QoBNEoO1jKIwH5AA8Hlp1br9oc2ha7b01mx2/9GytBz1/AB99O4ve2?=
 =?us-ascii?Q?VU4Z3e1h4OmkrBnmsb1p8tOqc87NtibTuQHfFhH9H4WUWT0ORg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 12:11:04.2001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5249a5e1-c3c3-4a08-95ae-08dcf424eed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

Keep the user queue fence signal and wait IOCTLs in the
kernel config CONFIG_DRM_AMDGPU_NAVI3X_USERQ.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 70cb3b794a8a..04eb6611d19b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2971,9 +2971,11 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_sync;
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	r = amdgpu_fence_slab_init();
 	if (r)
 		goto error_fence;
+#endif
 
 	r = amdgpu_userq_fence_slab_init();
 	if (r)
@@ -3003,7 +3005,9 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	amdgpu_fence_slab_fini();
+#endif
 	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 279dece6f6d7..bec53776fe5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -318,6 +318,7 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.release = amdgpu_userq_fence_release,
 };
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 /**
  * amdgpu_userq_fence_read_wptr - Read the userq wptr value
  *
@@ -502,7 +503,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
+#else
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	return 0;
+}
+#endif
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
@@ -797,3 +806,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
+#else
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	return 0;
+}
+#endif
-- 
2.34.1

