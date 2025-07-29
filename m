Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E965C87FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 07:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA8410E1D1;
	Tue, 29 Jul 2025 07:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFKTl9h0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BA310E1D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 07:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ911CgmLxP42pfarmhpZpyHnHPwDSrQsAbDFFsn1vfSV++Jx6WQguo85JwPbSlLxr+X9JnhvCIISDavlUoTbum/mSpehMOAaP+5IVtflBpqrMj3qJ5WvUswackomwisN4Jj/hHR4mYSxcFEUScb6dB1OB/XRFKb8DXeEL7sQZ8PKK5xSSYIcMMmyCpvxxGHqhe4LRhNnhzlatssOe3SHalPjxyeL2qlfL0gY8FQ28rCGNRIEY2hTMFj2GlWeel/ApJP4E9gfHShl5bqf5r7Pnb6tsHqFWsqZ+7PsdmQCRBDBPeam0npV1elNHDlUjiXKxXm6lR2OFyp5Y3Qds4bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQBC0A5l80hHzGF6pPcqgAfp5QFhL8grF0M+0r2H2Cg=;
 b=wjnJbru4X1aTTW4ddD2WT160BnLnDS9JIRhYzfPSUAQ/SXsQk1mmy/jN7iWAxeJInyUWOwmo6jsVSKP6EiBDfXckWV2DQUn2xFhARgeT8sefYRQzn6WR31nE5/q6l/sN+rDC1X8gSPrKONRVGNnUYBG3RlfnSm1KdxwCSO4t9tf3AUvSQk3mgaPOFz0cXvRihPzV87dAFHSWQZx+JB2EFyGhCpghfmdwkXvmNnEODmvEehokTDjS0MzwGnDBGZ636tOZLO1PHdHGgNlxSeNTpG59LxqMXhAcuQwGZzceIVBeg7P1reFnx9XmCn/AkLY1TJN2VatKwMkkozkaWR92yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQBC0A5l80hHzGF6pPcqgAfp5QFhL8grF0M+0r2H2Cg=;
 b=YFKTl9h0siakWx6LR52rpjm42F6H6GTiDu3PaUzZRqLPe/ElwKF9m8Hm4qUka+NL/HwOcskcq/ec2HkReedp5vwWLCDLM+0pgYWo3szMJXN8prO+H5C4bhc5BOpiNzyPHV3bOlctGzkvC8KKxg/qfOmYkbO2jcwcGKruBrCjVs8=
Received: from BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::19)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 07:02:38 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:32c:cafe::69) by BLAP220CA0014.outlook.office365.com
 (2603:10b6:208:32c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.33 via Frontend Transport; Tue,
 29 Jul 2025 07:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 07:02:38 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 02:01:31 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Effective health check before reset
Date: Tue, 29 Jul 2025 15:01:17 +0800
Message-ID: <20250729070117.76523-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b605c5-b03f-4dc6-3612-08ddce6de738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2kGIUtWbKiuCenSeAyAtHwk8k8UGvMtAUvoGVkRu/ElbjALRvlIVu4h+CbUW?=
 =?us-ascii?Q?yX0N3FLSsBPnOc+5mrJH9ruV/oiYu02EOxV1dQbA8Fr4X4t6dmRlz7SMnZix?=
 =?us-ascii?Q?R5tWstOyZvTIfNbMg7cjg6o7hsyFjJuI1stmcIQP/dVVI4yWb6olSiUmJGhH?=
 =?us-ascii?Q?yKBu88AFGt0o2CZiseN8hsAmabh0+uGsNtf1w6r6NPw5M7t/VIsTsQtJI3Wt?=
 =?us-ascii?Q?US4FpIDqM5Wv4+Wa+DamHwzC8hRJlwUn9qhbgONH0T4Lj8EFr58Gpd6QSRik?=
 =?us-ascii?Q?Cjm0u5/cepYlsWu1xNECJeN3+8f8tNzJd9hvAtXNvTjAyvQPPTdRVq1XGyD9?=
 =?us-ascii?Q?bNYSulV1/2+nnOrT288xUwGhZ1jkyecMCRXxckmCuFuUqVqTliwm7xu4sJNE?=
 =?us-ascii?Q?SC1cfK/X/M2gpIQ+nDjqy3RtZBMZXqhOvT80POsDhZA7xH0VLGBeNI0Bq8Dl?=
 =?us-ascii?Q?LlNfrGPIH50n9qQizYq3CLUGu/TnAjhdxq04N8YbKgxFSE0pBMus03NNhMNA?=
 =?us-ascii?Q?AcmBMimUhJBKxxGO8qkD9MIEWIkB03ocQZM1RgF222XdrVICSqQ3sdIX1/0a?=
 =?us-ascii?Q?ZaC7k9+76R2qiQpPeIeudoic92SOrm7WJiojhWFyQsTBN8ZB0cLkL/W+iz6n?=
 =?us-ascii?Q?r0LW09k13CvWFCAzHxsh4DpV2lPGzqJaRRmR4Qrm4go3+UwtFcxJd4pr7P6C?=
 =?us-ascii?Q?wUnUTi1IR+413R4bWdEwo2X9zPTXGcw4ZbPT83hvftMPNp4/u4RnbSWAzhxg?=
 =?us-ascii?Q?OlD6xTWrsJzlghpVOWHyqu0U/hsM5WnTg14/aBPLHxlSArhifiIYqxt+9tM5?=
 =?us-ascii?Q?2f0kNjWkerhoCG4LAzbmUEcqycRFTsNyJT3Wdiu5+7Bxnd+lMFboM0ME8V+G?=
 =?us-ascii?Q?0fGVJGuU9RcglPTh9k0QV4skIJvPoMxr23dDGztm61i7FORnKvFuUfgyHoeM?=
 =?us-ascii?Q?PWFM0Y6FUiHVv38q6zFw0XLHGNk7h3ibGiYBgUQfXZitPZHJ5bqIMuTNcj6K?=
 =?us-ascii?Q?UfL11K67B1jSSx2EWUbiIrMcPiSdkH4kPeZQHv6TtN9jY6GiFI31hotBeKiW?=
 =?us-ascii?Q?sQ/5rKgWtIGNkHAVdiBwvnrlzFTN+I3r2dnJXMC7QBdBMp2Z3eZ6896kGJQb?=
 =?us-ascii?Q?46YzhFgy5yl92baB/8jcSA4tR299huDvIxQkfhA9HAJz5p1ICAQ+sUJZZBPd?=
 =?us-ascii?Q?qcJDqlhr1ldXcK1R3zYsHDGfrCse0p0ewzKmj10EtMSvtiBNCEh/EDuQXwZv?=
 =?us-ascii?Q?nMpMacEl2+HqRkyVi7I6yOYABPWUt//LjtPK0MXZNLNOoZ5V7vRit5I+nL8M?=
 =?us-ascii?Q?m7LC4O676DjjI5ZhQv7Xbwcu02etvadR9bh4JhCpQjzbbOh0KvfUYExp/uLN?=
 =?us-ascii?Q?8S/G33eOU1kYW6M18DGo6qDo4lZmyZrA2pK18oMUJL/pl839F53lU2LFVltu?=
 =?us-ascii?Q?26ee3ZiEUgP1kilSbLxk7qa2EArLVe3RV+gyEfy8/O4qE3R0JMb09Rhpr2LW?=
 =?us-ascii?Q?HNr2afwpU+qfIkjX63TaSaZ07BhmG8sy43l8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 07:02:38.2028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b605c5-b03f-4dc6-3612-08ddce6de738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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

Move amdgpu_device_health_check into amdgpu_device_gpu_recover to
ensure that if the device is present can be checked before reset

The reason is:
1.During the dpc event, the device where the dpc event occurs is not
present on the bus
2.When both dpc event and ATHUB event occur simultaneously,the dpc thread
holds the reset domain lock when detecting error,and the gpu recover thread
acquires the hive lock.  The device is simultaneously in the states of
amdgpu_ras_in_recovery and occurs_dpc,so gpu recover thread will not go to
amdgpu_device_health_check.  It waits for the reset domain lock held by the
dpc thread, but dpc thread has not released the reset domain lock.In the dpc
callback slot_reset,to obtain the hive lock, the hive lock is held by the
gpu recover thread at this time.So a deadlock occurred

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++---------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 343155f5375c..efe98ffb679a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6128,12 +6128,11 @@ static int amdgpu_device_health_check(struct list_head *device_list_handle)
 	return ret;
 }
 
-static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
+static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 					  struct list_head *device_list,
 					  struct amdgpu_hive_info *hive)
 {
 	struct amdgpu_device *tmp_adev = NULL;
-	int r;
 
 	/*
 	 * Build list of devices to reset.
@@ -6153,14 +6152,6 @@ static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 	} else {
 		list_add_tail(&adev->reset_list, device_list);
 	}
-
-	if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) {
-		r = amdgpu_device_health_check(device_list);
-		if (r)
-			return r;
-	}
-
-	return 0;
 }
 
 static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *adev,
@@ -6453,8 +6444,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	reset_context->hive = hive;
 	INIT_LIST_HEAD(&device_list);
 
-	if (amdgpu_device_recovery_prepare(adev, &device_list, hive))
-		goto end_reset;
+	amdgpu_device_recovery_prepare(adev, &device_list, hive);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		r = amdgpu_device_health_check(&device_list);
+		if (r)
+			goto end_reset;
+	}
 
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
@@ -6952,12 +6948,6 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	int r = 0, i;
 	u32 memsize;
 
-	/* PCI error slot reset should be skipped During RAS recovery */
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
-	    amdgpu_ras_in_recovery(adev))
-		return PCI_ERS_RESULT_RECOVERED;
-
 	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
 
 	memset(&reset_context, 0, sizeof(reset_context));
-- 
2.34.1

