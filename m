Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB20DE8FDA0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Dec 2025 08:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCD410E209;
	Fri, 26 Dec 2025 08:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ws6H0QXr";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846AD10E209
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Dec 2025 08:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQOs4Zygnd/JDFVIQqF/uk48P6G2ecZz3RLrs/6QiO7FxR2tOFU/egjAMOgh7Ztvvo+MQmxn+RHtRy00EcnMdzy+fRLwAk8WdSroZjX4qfw+5dvQ3J0x6ejsC9AN4N44x6mMZGH+65vu+9Du2RiG6DfhZcy0C/ew+q9R0viE5mEvShDy6Qdi3J8IiX33GUxkJmLMkvw4eIHWrAJga+ukjD8nGnZ5OGCGPhor2KsUfZ1HXnlc/cZAZhscFnw9aXIQqGDivut8N9oL9NK8Oux9f7fxchCRr4rFd/Ywv363nrg94TVc7KflscBBn3vd8ZgC/Aqcul+xJwze9c1c2zXoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxRv2xyqYVSZKWdizX9bCwMGjV9ZYBtilsfm64PQyZM=;
 b=eMQiTHb/BH44yFpiYWZfummTEqRoSH0A3+SOIugfKYFBXC6kho54tbwXZsxh5uy2oHCtbpuudxDWgRnLv3x/lbQGF8Hyq7aVvkEcB3hoODY+xZLbrxWHK/LxDL+Y7u24ZDTiBkZd94/37atLn9s0MkrtoPXb+rxS3YLj0wTH5U7VQsPtXbjCxDDYgRAakRMO2wWRNzXM70jcG8QmDeti5+drG9jSA+nckrHIMee5Vc88THrJrMerydzW3AA9hLTwM3DlhYxfXb9AhlV9EiJbMCalopYkzSEeURHo478cQjPBC4iIa4gPBwaWEjHj68c5If67OYAeQSMl7/hHrOuF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxRv2xyqYVSZKWdizX9bCwMGjV9ZYBtilsfm64PQyZM=;
 b=Ws6H0QXrvagV+LwpHOvWMyktSsmmxhtpvgdFLTOJ2MV0DoK6y5xS2Yw71zLsQ30y63I8TdKM0JosyHHlGCudm8hGzOFXAZAh0hQwcIMEExg9TyFnwRV5t8aewndUIP07jRyeNBz7u6WvgsW+VzkpQ7s6F6E+LJGJZxo2xncBggM=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 08:18:24 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::4f) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.12 via Frontend Transport; Fri,
 26 Dec 2025 08:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Fri, 26 Dec 2025 08:18:24 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 26 Dec 2025 02:18:21 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amd/pm: Disable MMIO access during SMU Mode 1 reset
Date: Fri, 26 Dec 2025 16:18:00 +0800
Message-ID: <20251226081800.2475186-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7054d4-ac65-4f92-fc3c-08de44575708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pT2T7EhDd5ZpPH638ZZm+SfooGxf/kT/uTLxX/cgIvfw42hy2n4C2lPvBiqD?=
 =?us-ascii?Q?nx1DxD7lKFSYNGH5XbZ2aXTal5Murh+pLGzSO8ZSI4bcMS4S9qFx8LZMLxkJ?=
 =?us-ascii?Q?stlDg318DZ1fA2FUe26TQwzUfr+3XECkBy8Z/ppPL4SaN2q095gO4fy03gDX?=
 =?us-ascii?Q?Pot+d+d5mqdLgtrUGS1GC3xwScduc9UvCt1XKsTuNSnQPnw33IWoYxO8N8lO?=
 =?us-ascii?Q?hn3PySW6aU58TOOtqIhAr+XK0dYwwFRkh69H2arTnd08+0PLXDFRcuQPSvSe?=
 =?us-ascii?Q?zV7T4G164/TGmy7K7yFxGiYyQZD3TGbv/aZqe3y2nBzqAcq6YS4NQX5cJvjd?=
 =?us-ascii?Q?z7LsCZ1KA6ARcju70sxY6XdXydKYZPlyekumWaKu2owqS942iX+Zsi8It4CZ?=
 =?us-ascii?Q?Lo7E8D3pQCWDIIwOt6nN7mULjt0SVmHnQQsp1b+iNl4Q17s4/ZpmheZa4Knk?=
 =?us-ascii?Q?+70Ma7y9VTzN9D51QtIPHHyB5RzM4BTkoPaf6MLuQJ+10FeJ35lmHBAvKumb?=
 =?us-ascii?Q?fVDOthP/AmLTXPJi/5p1DgZz6QxM3RW3EKNYq5N6v5szK1pUfcEOQw0lj163?=
 =?us-ascii?Q?L2JM/Hr+tTOK0tBqGyUWbphZ2JBS+2gBzKffFEw9/kCzPiaBEctueoXrWizu?=
 =?us-ascii?Q?zc/VWnb18YAbglKQ8dUSRDqB8ZbO6ia+MOK1ctKFcGboQ/IfCWHQo4Nan2CH?=
 =?us-ascii?Q?lKAFAhauo5GV9uIgQXlByp7Dx9riO8v7IJc3TFzTSVCeIoibL/J9nDWcOpXC?=
 =?us-ascii?Q?zfJzrI1sYGYHCGgaNtIDp1MhZT8hC31TlJnX+q6bElwL5NsFrQ3SrE9PlGRj?=
 =?us-ascii?Q?T8PKFI2mQ/s/qN45cIcVxh4k6LLUfPjyh3s0gSrO8ZIx/Frg3sMkv+2AbNpQ?=
 =?us-ascii?Q?NEIn6U9U7AxxQuy8M8kF9dX44+yd6L14umcKJh46JzrOUUSR/ZdYMqu1y+NL?=
 =?us-ascii?Q?IKdInQ5yYQ/NOf8rHOyuLQrpWAQHZH4Y1fqZy0UoH8r7DnPQ3oJJ30BAEJQB?=
 =?us-ascii?Q?ByTMqGz81aTMqPUsiG11ZpUbHV9eFWpEKla95uXwSsI59lqUDE+r1RDhqL5O?=
 =?us-ascii?Q?N9DSW2fg+kOfKVkL24cMmvQSz+DQmsT0LV8Jim7XJu2ETmAn+ZLgg+Pe1XIP?=
 =?us-ascii?Q?GG5ijUEjjLRnyHqsd/UhMonkseecupkcQqJfFRMV+U0oA5H+Z9vnREMSOUnW?=
 =?us-ascii?Q?X97QGsJH56Bz2iFqbJ1p6vlPaP2/vrwqyRoIKgKcA4suVfmH2AnosKmWXdH1?=
 =?us-ascii?Q?uCeYr0w14RJSscUfmFFqRE63+qhN0DVcWqU6gW3elZELheU1DtKZQIZilAyG?=
 =?us-ascii?Q?CSoLGUVA8xnWVYQQyiQhEKM97u7unBMMMtv/olTQKyym4Px59+RAa/znrO7w?=
 =?us-ascii?Q?sAiWAKd2BTX1pKEjcllNgjm15mV7xY14vJ/V6oPc8Tb6xSSlVe5115xoCh3I?=
 =?us-ascii?Q?xAvc4UCAqHC1YeNmKo5vdFYBrlsgT8GgYwNdQmV/Qdh/M00W264k7Efa1qEe?=
 =?us-ascii?Q?jVRFtaOSA+MJkOD4ye6ByJHSw48/IGa3l9aam32bf66U6u2dXZAT3+tuLgOE?=
 =?us-ascii?Q?rUOX3/pL+7PexRqMGuM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 08:18:24.4907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7054d4-ac65-4f92-fc3c-08de44575708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

During Mode 1 reset, the ASIC undergoes a reset cycle and becomes
temporarily inaccessible via PCIe. Any attempt to access MMIO registers
during this window (e.g., from interrupt handlers or other driver threads)
can result in uncompleted PCIe transactions, leading to NMI panics or
system hangs.

To prevent this, set the `no_hw_access` flag to true immediately after
triggering the reset. This signals other driver components to skip
register accesses while the device is offline.

A memory barrier `smp_mb()` is added to ensure the flag update is
globally visible to all cores before the driver enters the sleep/wait
state.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 7 ++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 9 +++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 824c5489ec85..75b1b78c0437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5776,6 +5776,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	if (ret)
 		goto mode1_reset_failed;
 
+	/* enable mmio access after mode 1 reset completed */
+	adev->no_hw_access = false;
+
 	amdgpu_device_load_pci_state(adev->pdev);
 	ret = amdgpu_psp_wait_for_bootloader(adev);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 8e35d501e81d..dcb169b25916 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2850,8 +2850,13 @@ static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
 		break;
 	}
 
-	if (!ret)
+	if (!ret) {
+		/* disable mmio access while doing mode 1 reset*/
+		smu->adev->no_hw_access = true;
+		/* ensure no_hw_access is globally visible before any MMIO */
+		smp_mb();
 		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index af1bc7b4350b..b1016debdf06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2069,10 +2069,15 @@ static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
 
 	ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
 	if (!ret) {
-		if (amdgpu_emu_mode == 1)
+		if (amdgpu_emu_mode == 1) {
 			msleep(50000);
-		else
+		} else {
+			/* disable mmio access while doing mode 1 reset*/
+			smu->adev->no_hw_access = true;
+			/* ensure no_hw_access is globally visible before any MMIO */
+			smp_mb();
 			msleep(1000);
+		}
 	}
 
 	return ret;
-- 
2.34.1

