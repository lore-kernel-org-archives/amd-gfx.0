Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E16D41C00
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 05:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBA010E682;
	Wed, 13 Nov 2024 05:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oumJLEnZ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59B010E682
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 05:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzKgX96TDnoY+6CDp/qQgFHtVNY8wTvrNorcbThti5JiqeB937Jv1NGm+3WhBpZTEzXo2sNEsQmOsv/3oDL71ZeRCorSuxoA7EdmDSQn+hI0LlmZZdQzF8e79pE7XiiIpcCvHuTcmTLttWjkbA4W2PZV3L0xcI56G4CxRnMpTw8BBMrsTlSd1qhP5JnraH+zSEYgs3CXGuIunsL+PlXnpTB0XljsxhAfbNYTTgYDWun4/aU1VxYXlu4IYIsdYymNs36GMxZfxLzGS1SG082uxIrwfJNj5w8C+XYVr+EKorlrm9Y9vhCR657pKavG9cx/YB4sOT4GBipYAbAQpAFXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmYZ5n4/dONHFZBdzqShcax0kl86eFZqn3uTcyKVquc=;
 b=iuwXlG2jZ14pCys/UEE0sWRS70M65P8I6uBw6kWDa6eO8VGJxZOC+i1p6OqL8NNxaNfzRN6849AqaroXJ5cD8LAefzRidY6Rw5TDq9mrWpJmdxYRxEmivutPtceqd/LLB1M1+Mvl5prc3yG8Gghl66vAF/f8rCOfCcXGvs8KzZZ8WuDAQZZRASe2+HOUgZ2jE26whxY0DluTvw9tlSsXMlJez/Ze7xUhqK6v9H0BM/G0mRLFf2OdennjS/NGLR6P0rpSD5Heij4PZ2EpztKfrxrh5N+RhHHyIFdJs3DyXsLPEgdTlLTlr9xI9/WAqztSkmc/NgnWHURg7GoxCnfzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmYZ5n4/dONHFZBdzqShcax0kl86eFZqn3uTcyKVquc=;
 b=oumJLEnZCrD5YQeCkDIK5dh4TsX0DY/z94e4C9giZdEaBl6M7/7j1QqsGnXRtH8aWeCmqCA7Lb5OdE1eUSsUeJ2zdEq9eyuYDQnpJOaxEVCtnRQMQyIiVMV6nbKSJCxeE2i7t6c6kXDMfOvVXu0A3q5CnybleQG8BYJ1yZYRe0A=
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 05:33:51 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::23) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 05:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 05:33:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 23:32:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 23:32:28 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 12 Nov 2024 23:32:21 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH V2] drm/admgpu: fix vcn reset sysfs warning
Date: Wed, 13 Nov 2024 13:32:21 +0800
Message-ID: <20241113053221.1992865-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cecdff6-280b-423b-0488-08dd03a4bfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FP/ITqyhFBFcX9wKIcMBziZ//lR3fiTNqn8yPz+rQg1m+Jfizj6CM8giUQPm?=
 =?us-ascii?Q?U/3DiBTwMenNLRv0h5MQ1hY1wlwcchFhHsDiBVUI1xfbQ54hYspASPQchtAm?=
 =?us-ascii?Q?CrYU/OclzotkduiBoBPhzcK9c7VkZs+z5e6QAMYcIPLPgCqTO8l3xHoMI+X4?=
 =?us-ascii?Q?pP3NkPVgrU0ZfTCSQaB3AcHxLyYvVh5oqVaxTqhP+3PhufyAProAJv0fzjWB?=
 =?us-ascii?Q?R0xOIboT1WtAHEEwzA5yGc2iqcJg2DmWg1EcZF9ZN8ntx/iIwhXsfbpEq9BH?=
 =?us-ascii?Q?sKEwdqoSjWRqGFEL5PVM0GF8fOk2NUJPvxs20pCjv5zBkDBJfvAFawCmeJsa?=
 =?us-ascii?Q?XawdF8tjKL0AvbFJuaGNVlLFdWUv4WO9MAGkIdmh+U0ec0EkJgJSBwVOX3pc?=
 =?us-ascii?Q?ehO1YT84Yws6GVwF2ihZ8WoNBEN/zMTiKP5iqvUZZFkiXLYYAR71Xc3g2jpN?=
 =?us-ascii?Q?23molVuAZ6LJCTa5vsjdBDeOguLvB8tBUY2Qd4ggjgOw+xXz4Ccsf5WPmX8O?=
 =?us-ascii?Q?w8zLkS43wb+VMgV6iILfPRFB2SIbhKnDW5wNwKf7yJg+3mgir1DODqfBqTpB?=
 =?us-ascii?Q?XepHYbItvL/c9wf3WyXg9z+z0Ut+TX9gtHQVrmsGCIq89LQ4oi+GA/26Lsdy?=
 =?us-ascii?Q?FvVeLfX63km0E3U+i6tql5iecXTOSCR2da3QlXcZuDa4iXBKAuCFvkNl6nM0?=
 =?us-ascii?Q?0mGsJC18ouVppjW8REfWsauJrok1I9t2qy4K3aPaW6G68FR8CCrVSISSqIVt?=
 =?us-ascii?Q?CghCc33CHBBdv3Hhfgz+96fRvkucnUYIGFAtLEmKQojm7qPmpUwpavMTy42T?=
 =?us-ascii?Q?gTEIBg0J3J4hhvhrg+SlbwYid2pr8G9CCLtA6ZaOmGpIVJo4QX7XU7DtAeJm?=
 =?us-ascii?Q?jciGNzfWUpzTmfI1Cu/LE+ce4SwpITgr0qsRKGS7W5EnhyA03fxAMn5Ypo7H?=
 =?us-ascii?Q?ds/cirYkRGArkWfHpOV6GNvePSk0Hn+y7PPdWBfBbb0EOz6OU3rq72Uz2eLV?=
 =?us-ascii?Q?QcC08JM6pPsBTlZBcJIt+jQWVRHWE2MpzQ0YV/Ioq7qLIFro9Vi9xEZt+Goa?=
 =?us-ascii?Q?CR04mCFzVH8kbUHUM/DN0JjkrkzqsDeV7ZbWzl39D2jZh89OrzGXyz71F9jS?=
 =?us-ascii?Q?uYyTs5rigjDPDKbiNecwtRdUpR2DNWJ6/vY8xKf+cxzFlArJoT4saXPDp07q?=
 =?us-ascii?Q?GrDEYGbzKjPPuCiYUyRujVLoXYWucjSsOmMdZOEw8Esmt/K78vYvCUjSfTHS?=
 =?us-ascii?Q?7pejEAd15Ip3jfSa0WAld8crdSz/3BwlY1kuRaDAkuQNjtJ3VdVgihjARTM4?=
 =?us-ascii?Q?Kx4DiaGSA0032HIabhJIpNrDTN7Qy6HujqtHb3Bs83ymSkCBReoSSHU6Swj/?=
 =?us-ascii?Q?/vg6fyzwJ5isfg/Veicb6kei6xCd4/0+c6oHrgdn+wSaMjJTiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 05:33:47.9784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cecdff6-280b-423b-0488-08dd03a4bfb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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

sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.0/vcn_reset_mask'
[  562.443738] CPU: 13 PID: 4888 Comm: modprobe Tainted: G            E      6.10.0+ #51
[  562.443740] Hardware name: AMD Splinter/Splinter-RPL, BIOS VS2683299N.FD 05/10/2023
[  562.443741] Call Trace:
[  562.443743]  <TASK>
[  562.443746]  dump_stack_lvl+0x70/0x90
[  562.443751]  dump_stack+0x14/0x20
[  562.443753]  sysfs_warn_dup+0x60/0x80
[  562.443757]  sysfs_add_file_mode_ns+0x126/0x130
[  562.443760]  sysfs_create_file_ns+0x68/0xa0
[  562.443762]  device_create_file+0x46/0x90
[  562.443766]  amdgpu_vcn_sysfs_reset_mask_init+0x1c/0x30 [amdgpu]
[  562.443991]  vcn_v4_0_3_sw_init+0x270/0x3e0 [amdgpu]
[  562.444120]  amdgpu_device_init+0x1a0e/0x35a0 [amdgpu]
[  562.444227]  ? srso_alias_return_thunk+0x5/0xfbef5
[  562.444230]  ? pci_read_config_word+0x2d/0x50
[  562.444235]  amdgpu_driver_load_kms+0x1e/0xc0 [amdgpu]
[  562.444340]  amdgpu_pci_probe+0x1c3/0x660 [amdgpu]
[  562.444451]  local_pci_probe+0x4c/0xb0

For multiple vcn instances, to avoid creating reset sysfs multiple times,
add the instance paramter in reset mask init.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 ++--
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 25f490ad3a85..1d4eda649845 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1295,11 +1295,11 @@ static ssize_t amdgpu_get_vcn_reset_mask(struct device *dev,
 static DEVICE_ATTR(vcn_reset_mask, 0444,
 		   amdgpu_get_vcn_reset_mask, NULL);
 
-int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int inst)
 {
 	int r = 0;
 
-	if (adev->vcn.num_vcn_inst) {
+	if (inst == 0) {
 		r = device_create_file(adev->dev, &dev_attr_vcn_reset_mask);
 		if (r)
 			return r;
@@ -1308,12 +1308,12 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 	return r;
 }
 
-void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int inst)
 {
 	int idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		if (adev->vcn.num_vcn_inst)
+		if (inst == 0)
 			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 7ff4ae2a0432..9b10044c61a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -519,7 +519,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
 int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
-void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int inst);
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int inst);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 59f83409d323..109b27904984 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -250,11 +250,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	if (inst == 0) {
-		r = amdgpu_vcn_sysfs_reset_mask_init(adev);
-		if (r)
-			return r;
-	}
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
+	if (r)
+		return r;
 
 	return 0;
 }
@@ -292,7 +290,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e9b869f373c9..ef3dfd44a022 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -217,7 +217,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
 	if (r)
 		return r;
 
@@ -254,7 +254,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 96ec01cffea3..8f9c19c68d88 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -186,7 +186,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
 	if (r)
 		return r;
 
@@ -223,7 +223,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
-- 
2.25.1

