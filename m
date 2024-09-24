Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA566CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 06:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B62D10E4D5;
	Tue, 24 Sep 2024 06:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s16Avjvy";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A71910E4D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 06:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdQaBrZ2EH711r2xA1WoisP1j3gi0QBuzQs+sCyuELI89xWV77SID1Q5jxqB9cpjB3Etgp2E9OdkPVz9nqSUPAA2rLvLNGm1fUS9M1l3La6EfunoxGVkoOFkDEVQAThHOwLruuR/EI+BUg0gcbqyZb4fMDKrLKBj5GqNMtiB0OpYrQcI/8TNXqN1OEwNL60zNOlRShZdbt9pzi7rNartJaelNwb/XF1J45dcmmU75Vigqtf20qA1D6/kU8BAj7crs3dlRNFn8ZxgDRkVNHKTU5Rx/tvf44NsIJBHVb4n5/F9a290q5N9QeT3qg4NCmK3D1tZIVcXnPM92RQ3ox0vSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZyzjPWnB7VA7vSh0bJ3WO0LAlcSYq4zIYC1pfCQtZE=;
 b=j9co8vfD7FFGhIW8S3iscGNrU47uE2o0kyOQTd9agxG7PpmR8/FeQsn/Jn1teBoWGOXC85SYYxf1n+9iyua+/OAeqP6Og9ThKomVc/Efmnc+v2xLGuLdI+U1yKgZx0LWLmpw5y/UFRUI70QhOLwnXdGy+OqUIqRdt3/pykVBr/UN9YcmOVywZcY1PJii3J3uxWeOKUKIGUhjPfazZNV9snU+AOUypY61xcC1OH1OlDxTNEwQ6D2E8UtjvsQYDRSkV5d53y9/eHVH8nVz5lU+r+9e/1sjPjCQuq8LSUalRkVxHsq+n7SxuFUbjwimKfAQ+OCcHLRrxHNLnnTnKUT7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZyzjPWnB7VA7vSh0bJ3WO0LAlcSYq4zIYC1pfCQtZE=;
 b=s16AvjvyDRmmzePOy6kCbBktYqt3fPkuRC7Zd13ejHkoPoXJtv1DT5lcK0ogB1G708HD3867Mh6ZOUKs+zCdoMuRtAFXwtbSClsMfT0CnXboLrSWHv9nILRKkF7tdhr2/HU0bTUPypwVDt2ReDPxR6coi3dD3f4BZYsA0AZ+V+0=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:03:13 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::64) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Tue, 24 Sep 2024 06:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 06:03:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 01:03:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Vignesh.Chander@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Show current compute partition on VF
Date: Tue, 24 Sep 2024 11:32:50 +0530
Message-ID: <20240924060250.2678600-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924060250.2678600-1-lijo.lazar@amd.com>
References: <20240924060250.2678600-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 173dd74d-6bf7-4e3f-c474-08dcdc5e92dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RQmrhdiNnlGwxiV6vyWxMSySOZhSUdlt7ur0miPsBdKQ6Z0d0iNRbiBGEegN?=
 =?us-ascii?Q?1s9/b09DeVyL9RnSk7S6swadVJYXdha/AstCfBksnKchAlCyaG+05TDSDZdY?=
 =?us-ascii?Q?+l9RXzCgoBG5TUKTti2pJQEHX2iNFdrWGzKVzKhhj7+OTQUTK8VLr0U9j56p?=
 =?us-ascii?Q?1OkNWEiOp07myegnf7UBfCSmBL6F5St2r3X5fSlXXrEcIFwXbfljpsoA5lBk?=
 =?us-ascii?Q?5X6aQR5qz/e4Mip5xn7vQ9+7OqdHU13ZKpIPKk1B0LiS5mOcowcOBgQSHj/W?=
 =?us-ascii?Q?JYxt7obdsYGMQLkquMyyNGSDSkBPKEjl/IQO7xepmafSZWSMyGVOySDnZ79a?=
 =?us-ascii?Q?6gR2sH5ZrKVrNMUuuaD8+OlnxoJeyc7tyezPc/if8ZFJ/j+RNb9+MzGEPSJT?=
 =?us-ascii?Q?FORqPNPUxE4mTqFD7FydIe5ztDgkJ0T+Vd49e9l3R9mXpaIJ0EtJj6B0ZO+1?=
 =?us-ascii?Q?y7kGXwSRcWbCnupeuwkx5KnK87s+XbRtWmDY3UggzgotTtXHL8taKSpQksTO?=
 =?us-ascii?Q?BBve9o6rlO4cD5FN3VE7le5/AeW4qOgwmbTK9wTXKS3cctZv6fQr5ooGFoGi?=
 =?us-ascii?Q?3fIPe+8jImAeoWIHYnZoYk+idUqgHx+Cat0WRPCYuoG125FjDNEk2CWRjacP?=
 =?us-ascii?Q?9YmfnMn9E3BcLuAqRaZNhYNcHwjSpaSBnnblgIqPP8RAcsgiaF9Gsh7T3X48?=
 =?us-ascii?Q?ykbrLhtXjliKWeEMa4BN3t5B7iGQ4/boaCzahLtTfhacv0FJhZvLQH6jUfVz?=
 =?us-ascii?Q?8hIMhSabv/HZcUUDtzpHc8S4Opz/0XynBdRojO3HYiK6Qm4iexbM4IDaZmTB?=
 =?us-ascii?Q?2r0yIa8A8U2yWObw9dnN5xg4rzZB9wscHxLXs6gbTDhVqi/XuJh5Z2htxpCW?=
 =?us-ascii?Q?MNYZw/zcNihqBWhmHwlK1ro3hENbuVxyWmPasl2lpS3fjlsylIHNUSaViTve?=
 =?us-ascii?Q?rCbs//wWXrEXqnp7bDtK1A0XDHdIJ7+O7p1chnFv/KiSvgh/oPxO4vTtJsY2?=
 =?us-ascii?Q?gsHN44pE7PfDcM9z7ozheC14ja5U5lcekEoU8QOb73WRreCRIzmgp+20Ye3U?=
 =?us-ascii?Q?6QSApnvJPxov55JnV+ztBgavDHoEBUgjlV69fp7b2NHc6dXalOQHzLX6GcMa?=
 =?us-ascii?Q?m4eWzoUVHaYoh1xpsqOAeehpq5k5qlc/kL2Of/BhQDDHSI53Z/PoIvXNPcjJ?=
 =?us-ascii?Q?HU98TmNSmp29xZdUBQVSH2ZvDMnxVoOY5tjNlWxlydoLOAjL9HniV3tdeE61?=
 =?us-ascii?Q?WU9HPbjP42w9MHDda8H3WM8Z0ldABLFE8JD7D/egLQ+ejdcVGHQ0/CJl/7aP?=
 =?us-ascii?Q?ZgM4dCrCU6bnDMbqLHKo25aJdftthBfJ4/0I6HmVUnN0qI5DvaX6tHmevXnh?=
 =?us-ascii?Q?Xu+21l1RM7M6zaYYEAITgkToQcxkCQ2kUuauGIgONk3lyclzBOKnLd9aiS0X?=
 =?us-ascii?Q?5h/AIZIT2E1zO6UKEQ0wwAQ8LgSnvsfv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:03:12.7808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173dd74d-6bf7-4e3f-c474-08dcdc5e92dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
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

Enable sysfs node for current compute partition mode on VFs also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 29 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 299c4461b606..fdc9656efdd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1612,21 +1612,46 @@ static DEVICE_ATTR(available_compute_partition, 0444,
 
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	bool xcp_switch_supported;
 	int r;
 
+	if (!xcp_mgr)
+		return 0;
+
+	xcp_switch_supported =
+		(xcp_mgr->funcs && xcp_mgr->funcs->switch_partition_mode);
+
+	if (!xcp_switch_supported)
+		dev_attr_current_compute_partition.attr.mode &=
+			~(S_IWUSR | S_IWGRP | S_IWOTH);
+
 	r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
 	if (r)
 		return r;
 
-	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
+	if (xcp_switch_supported)
+		r = device_create_file(adev->dev,
+				       &dev_attr_available_compute_partition);
 
 	return r;
 }
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	bool xcp_switch_supported;
+
+	if (!xcp_mgr)
+		return;
+
+	xcp_switch_supported =
+		(xcp_mgr->funcs && xcp_mgr->funcs->switch_partition_mode);
 	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
-	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
+
+	if (xcp_switch_supported)
+		device_remove_file(adev->dev,
+				   &dev_attr_available_compute_partition);
 }
 
 int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c100845409f7..52322ca754c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1165,12 +1165,9 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-
-	if (!amdgpu_sriov_vf(adev)) {
-		r = amdgpu_gfx_sysfs_init(adev);
-		if (r)
-			return r;
-	}
+	r = amdgpu_gfx_sysfs_init(adev);
+	if (r)
+		return r;
 
 	gfx_v9_4_3_alloc_ip_dump(adev);
 
@@ -1201,8 +1198,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 	gfx_v9_4_3_mec_fini(adev);
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
-	if (!amdgpu_sriov_vf(adev))
-		amdgpu_gfx_sysfs_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
-- 
2.25.1

