Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE447C7EE30
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 03:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1551510E04E;
	Mon, 30 Jun 2025 03:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="amkLqtWj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5025510E04E
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 03:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjdjEXCoM/Ys9rNZqfHAfFLo5a7P2RWfg0we+wf52ZPxL+e6azLm4FpaCDf9Og6ZtlrzeoCOKAS7C7kDL2iNZsmAgP47J8LwIhu21G1HUUC102ciHRJ1xu2p2HrBtGctzugDS9sa1CzvVWT0R3qViitmQoxcG8w0fRMgrWxkLyDAOI6518yaBhLyM2BYOiPuUzWgo37bqvXYRLYszwS4YCgI5c+UwwksMuvEfOhxpi/OcDwTPQXqm0KM0DeDvCO11cBPDxQObvNO7ftlIbMTN6OIfL+0SeAsyoKSTgGDiZbUD7xFH4YGa3m7oimX0ZI9CmZzrni2zSLeLgXX2/cN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS9wOKIsHGds6DB5LtZ3llFwOLnd2g/x2Uycy9L8uZE=;
 b=dbYpm9gdTthNxJZLShxY4rW9NDF1TlQTAFj2tDZb+7CbPT9DA4/KQR7DfVW0y+4uOk04I1bcBpWkPjK8ClEq92JfNb2HaKddR2nrodBv2dJYXa5uHkfXT8Np/B3UZPm0avVZOY/CHCKHKebGpojXuwj6Bxc2Zvba+RJ1NJu78A3uPbOQxn6OoxG/7K7icyWv2RX+9C0/mHwGEiIiH3hPO7he2M4zJGf7/8ZXskOHXYMQaF8qt2Ad78badLt4pXPoHkfUgOwvuaKn0FIaXRepSMXU2hpThzOTIpFMDz2eTvNWPPTKKIxn5JbcSP61QqaDeeyk1nmGeSceUx+wx8+MHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS9wOKIsHGds6DB5LtZ3llFwOLnd2g/x2Uycy9L8uZE=;
 b=amkLqtWjfXYOsA/+Aw7liFabRRARWEzhFfSwEsBzkh9RMyUgg+ihwUrtcT7C4//awq6nRIGTQhxxUYdgZ0xsPn1e+vv0XDfTjkoa7IfJoUf2DrXKAYYf/dWEN2kxShCsn6FGKyuWfpaGB+2tCby2YaqIf0XbWJfg6usbEUNfAdA=
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 03:02:25 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::4c) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.17 via Frontend Transport; Mon,
 30 Jun 2025 03:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 03:02:25 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 29 Jun
 2025 22:02:23 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>, 
 kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Fix code style issue
Date: Mon, 30 Jun 2025 11:02:14 +0800
Message-ID: <20250630030214.282854-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 462be6cb-09d1-4022-2329-08ddb7828a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bGqBUKkCbfqdgtQdUWO74JNQgqbq06nOlTiWQEClThYUqYgjI+LnuHO5wOUP?=
 =?us-ascii?Q?EUHKV1BDAKPMP0JJWz0ZQHulXL5zCGoBIOr5BUF5EhT83LJAa6wmGwwRblDO?=
 =?us-ascii?Q?JW8nzsEBAaWQCeF/AcQDM0rVALKBeKCa7bYaJSnEFLrx46jxkOw8DW7tb/KO?=
 =?us-ascii?Q?IcoBilh1yANDPW5gNWJNrjCZCMfjuEEklzrx65OeaZvF5fypPWRloHpMu0vr?=
 =?us-ascii?Q?nlKzquQYy/j96/rcAqQRcr5n1YrCh5iBOhoCHaeCchgeFXiL2/taF0EAScyX?=
 =?us-ascii?Q?pPI+U9IHZMO3Q1fvG8aPyxz4d+8Ar1uoZGxMTNiJhJynkmVXhSefTKzTMVL9?=
 =?us-ascii?Q?Z0r6/j04gLyQT63XJwVzmuXqpm6zt5gbyFsUvBVueMF795xMJ+B/l9tExTmP?=
 =?us-ascii?Q?FjFclM/pAZ1sSN/fWgyYZ4Gtx5uIbHigBiJy5f6sC2LffXzlog5puzG00ZE0?=
 =?us-ascii?Q?Q6fzYKigS4Ok5YLENskMnv3u5Kp26SAKttZqPg7YvJfYzvZ8QshIswGwNiNo?=
 =?us-ascii?Q?XBSXdekWWR2a/ZXHk6UhHKLzhg9U48UWqpKbdDRZTCU82oEqDcREudWlxun4?=
 =?us-ascii?Q?UGJaoFGsCdGEB2O65W5dYlSAWvVbQx7NQzG9tGa4eVrx78I+Xb0iXMiKGCcg?=
 =?us-ascii?Q?krlRIT6lONYpGglIjP07/bsjv476xu+Z2OGT/G/KLIDtyEsi4mA7aTssKgQL?=
 =?us-ascii?Q?6fK5cXhFZYAol1meOtEAk801QriinC6AkqmhIHGXwgvFQ5TcX3CG5ChNfxhZ?=
 =?us-ascii?Q?MtsvJ0tDaK8p4mrhsCYK37pI6wFCc1zIHrAOmhlHb+RW43eqvNhtG4qbeWj5?=
 =?us-ascii?Q?QwajFus57DzQmJTFXh7r18o++LGlTfux92Pi3cLu6uH3ZNT/wSIFaMzjD9GZ?=
 =?us-ascii?Q?Tbbj57ZaApErhS/aShPDs5+QZACMd4tJ3HYQtOTK+y3df79hm6mu7q40/0HY?=
 =?us-ascii?Q?nRXAEuxOMzwXaWVgAmXIi7S2lyuhwXtE/CYKUq+nSHiZYTbYxeZ4S+J7tDZM?=
 =?us-ascii?Q?9v9bb65Hk9P1POkGJMZsDntYY2IaLvdLP9OAXFeZx3JMfG5ynp9cmRmBuNny?=
 =?us-ascii?Q?3L2XZvY8EJs8YA03tsXEOrV4WBSPimvIQxDWmSR9kj6t9GMB1Z+xlKPF7wy7?=
 =?us-ascii?Q?tXqyx+x9AW21Oz45FVDAHQINsdemprIeVHFUlz9m2G0ct4wGl3e5lRSxH6Y3?=
 =?us-ascii?Q?SFJ14GE+swA85R17oYo1h4e0TL5IFpgx6i6yZCAt2bf+btsIDVzCNPOEJx3F?=
 =?us-ascii?Q?bowshZqRs9/cMRV6BgS0z7UHqeV09OzcxG9rGtimXFiPKH0Y1te27K+ijSbH?=
 =?us-ascii?Q?dBCiUZVATBQ701PgF9CGVmXZsVwFkPQujWUMC0+0S+VlcEhw58xdaSDyX0Xt?=
 =?us-ascii?Q?yYn+TID7gMBYIJ0pDaipLaV+P/3FFb36h21xmOugnMLFPzY4fy3yA7SFNdYG?=
 =?us-ascii?Q?HdhfsI2TjSAkfD9FUZHXOoXsI1/XZK0Gr5aipy//i09HtGRbCC60y541fxRs?=
 =?us-ascii?Q?lJLgA2Im15hQ0D/tOBSDrw23Vbo2jC8yLPYf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 03:02:25.1216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462be6cb-09d1-4022-2329-08ddb7828a61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6088:8-9: Unneeded variable: "r". Return "0" on line 6141

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506281925.HHIpXiO7-lkp@intel.com/

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f13439404760..a9e8ac63a514 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6143,14 +6143,14 @@ static void amdgpu_device_recovery_put_reset_lock(struct amdgpu_device *adev,
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
 }
 
-static int amdgpu_device_halt_activities(
+static void amdgpu_device_halt_activities(
 	struct amdgpu_device *adev, struct amdgpu_job *job,
 	struct amdgpu_reset_context *reset_context,
 	struct list_head *device_list, struct amdgpu_hive_info *hive,
 	bool need_emergency_restart)
 {
 	struct amdgpu_device *tmp_adev = NULL;
-	int i, r = 0;
+	int i;
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
@@ -6202,8 +6202,6 @@ static int amdgpu_device_halt_activities(
 		}
 		atomic_inc(&tmp_adev->gpu_reset_counter);
 	}
-
-	return r;
 }
 
 static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
@@ -6414,11 +6412,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
-	r = amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
+	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 					 hive, need_emergency_restart);
-	if (r)
-		goto reset_unlock;
-
 	if (need_emergency_restart)
 		goto skip_sched_resume;
 	/*
@@ -6830,7 +6825,6 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 	struct amdgpu_reset_context reset_context;
 	struct list_head device_list;
-	int r = 0;
 
 	dev_info(adev->dev, "PCI error: detected callback!!\n");
 
@@ -6857,14 +6851,12 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 		amdgpu_device_recovery_prepare(adev, &device_list, hive);
 		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
-		r = amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
-					 hive, false);
+		amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
+					      hive, false);
 		if (hive) {
 			mutex_unlock(&hive->hive_lock);
 			amdgpu_put_xgmi_hive(hive);
 		}
-		if (r)
-			return PCI_ERS_RESULT_DISCONNECT;
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		/* Permanent error, prepare for device removal */
-- 
2.34.1

