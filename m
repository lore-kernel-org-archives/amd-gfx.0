Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3B5D49205
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 10:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B98910E491;
	Mon, 18 Nov 2024 10:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aA7OMmdU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F5F10E491
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 10:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWj0wvivvLccBeZQaTQvtevMVgRC/dQb7y0+jK0J/PSdk3vBbA+fyOg+7bvkJaidNuXWqKSYlsEkpz0h78jNLpscnlC2wseWkKA72hh1qqloqmDOgw+A3yYgRpj/3nKwxHegYY3+ZZeuFHJa4LONXNVmN2DpP16/QMsGU8YT6VSf2VsJLbUfNERv6sJl9KaAuDaVMuHgUA9AcEn7rlzkTGmPdMl5MbLEWGdtO6UTy8HSnQbieTs5menxAi/MZNHuCyG3XCD6YzW82QIY5KpMf+Q6U07dXZoYDH/88CMbHSp6DY6MqkAW94+fARkvsk/31pypqkgs+R5llaMctFa8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KD8QXFyv4Lm5l1wsw01cEyk0075RbzAMTAFLr+sagr0=;
 b=cr8fjuw2wrsmikj83JykvYQOMokH0VukedeWQt0MFOC/piQ8mdO1hWMdkeeb2uEYFqnXL3egEmPM2gs1rqs9XqZyjqXTywFQJhaUtY3AwwMGuLAc9avGKBF5IJ5uADAfIu2K6j3IGLjzuOwLnOOo2ClnW5XKgkVBmp3jRkac4TKtH/wLJAu2qj9qnTQ89L6KRef3PzdSXlPcbjAgHkRxWXprf4sGLC7I2b7x90BczhA62B4uFGzwINM2YyJlDclTubVU2GC2rjeAlo2TpuHfuVxXbU8cmdBBq09JpSn9pEzMry6nvM9Jr7oUTdPcbC/kxM1r7Hy3QZJmTQvcv7fLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD8QXFyv4Lm5l1wsw01cEyk0075RbzAMTAFLr+sagr0=;
 b=aA7OMmdU5S/+Ao51jETL3fyXoYapRY5q8hS4ZNZ3WTqc0ICzaBAHBV1ywgSHqP6RVr5DofVTWtasb75s3eBbJ5ngvPT0l6y1f9NcFnLWFjm+fr6iZX9+XXtQ6CkcM4SyOpfDHtCtNXQEqY56TwGmgOoRf5wk1LrjXWQfybxrYXI=
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 10:15:26 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::51) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 10:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 10:15:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:12:22 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 04:12:21 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shikang Fan <shikang.fan@amd.com>, Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdgpu: Check fence emitted count to identify bad jobs
Date: Mon, 18 Nov 2024 18:10:14 +0800
Message-ID: <20241118101013.917462-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: shikang.fan@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: a6beb4f2-57fc-405b-da27-08dd07b9ebc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B/xnzbp93yjRSRXJJg4A1ETEX7G3KksH1POb6YMW9UCx3quhBojdvI6XJzkc?=
 =?us-ascii?Q?txdD3upVTmfJfjMANOoE22yGo2mCEnrzq9y6ahttdBRerY3tehYjp8VFgzrp?=
 =?us-ascii?Q?MX7QxTmmUsbFO4xV5NFC6rv6UonZ0pN2hoPlAzTo6PboLx/hVDgzWsugn+cN?=
 =?us-ascii?Q?mrYYcI6bmcwuRnlt865yFljvyfGCO1kdzQsjB0nqwsZY/x8tREvxlIMGb9UQ?=
 =?us-ascii?Q?sbLiUq6XvVHkXH1vntsDGRXohZmLn58Zlf07+ipoLTe+UxY+LUUDhBduiULp?=
 =?us-ascii?Q?CZbsdLnS/I9ev0prkM9h4lhfq8PO3Ppmiw5EwbbUKYGewaw7vF6u5QsSwY//?=
 =?us-ascii?Q?8WWtRTpBO58NiPK4GA25eOakQhDArXuL4i+LhkbyqYcr2F1CLIhcSyAvzJEv?=
 =?us-ascii?Q?/kVfWs84LoXF5toGOCIYJD6LRGujwln8HODFUkFojmWDcTQJ0HeoYNMObdTh?=
 =?us-ascii?Q?8FFvTex+Ea8e7JlSiqyHc2ZqFIsSNurqTe+lRp8sWzZpSn0eSMPn4DZztidQ?=
 =?us-ascii?Q?43W2iFgTUhqurE7GjTNTQiz0pLTB62eS26LfMXOMCYAl6tZqG4igGFLBSAyU?=
 =?us-ascii?Q?bJTfp/z1vlk76l28QEzDeMdBVgvl3ZMEDWBaBp+ieedOQhyUaSoM9YCLx1Eb?=
 =?us-ascii?Q?YsAdhAFCa9IBdzyLU0qOb0wX0qd/fBZFfzVpBPNkx+xSYZwnzoJmuRtd/Zlf?=
 =?us-ascii?Q?uj6lp0bts8f6ymA0tNOneql6DqjegpLSjC/Vg3vx3qj7GLEzwnK2tQrKA/d+?=
 =?us-ascii?Q?BBLOWmJxg/eiiuDaydhp4g8mv5En48UBdMTCJJ9Qm7YyCPrIyPGQYspdZyl0?=
 =?us-ascii?Q?HRMDjXk66j2jevyG8EPGG4M9jdevHOsN9x8yDJ/z5mgCPHXOCvCCcXYA4Zs5?=
 =?us-ascii?Q?YSRZ8mDR3BcULgWM7/ALXCCDkRb0XfwyntGRpPPcPOnJ1coK1CWieeRZF7BW?=
 =?us-ascii?Q?nrXMCaIpRbayF7DqZy+7N/lQ8llBo4I6odfg+iZpm1LzRRQgueKTqKiEeCPr?=
 =?us-ascii?Q?8ms55TGcfvuWAntYLOajv8o9PYOU+cjnr963v+FQbfsJrwRCGd0eME3WJGJu?=
 =?us-ascii?Q?Rcqn66zNI2bCGs2Sv4TTDw+9aUK2vc4NOx97Aj3+NQWmug7qTxH4mkLdUM+E?=
 =?us-ascii?Q?Mu9dT4jGnjmAb6WR+z9ZQhQSOHIufa4Cxy1qZcnG6SJkqxs32qE4lgkrXRdm?=
 =?us-ascii?Q?bkdw0TUgqARF2EbFexupuKOcjSM9bncTxRxmx2MS+BK4SA1TCUNOt2CvdHF2?=
 =?us-ascii?Q?dHesv9wDQmrPCSBDQZF8LFebKevKY3Slcjs2uXga9x/Cupcyr1rrC4GLsu6W?=
 =?us-ascii?Q?pUegumPrO/gwZDZeDRIO91RUh/imVeBMT0SckIvuFvBV0lNV6JG/FNSN1FnV?=
 =?us-ascii?Q?re8WJH4l4Kv6QzeTUOt4IX9s0u8y1jUQH3DB35Mw2KrINIfHzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:15:26.1588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6beb4f2-57fc-405b-da27-08dd07b9ebc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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

In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
guest driver, there is a small chance that there is no job running on hw
but the driver has not updated the pending list yet, causing the driver
not respond the FLR request. Modify the has_job_running function to
make sure if there is still running job.

v2: Use amdgpu_fence_count_emitted to determine job running status.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3ca911e55d6..ea756eacebdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -100,6 +100,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
 #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
+#define AMDGPU_PENDING_JOB_TIMEOUT	(1000000)
 
 static const struct drm_driver amdgpu_kms_driver;
 
@@ -5222,15 +5223,19 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_device_has_job_running - check if there is any job in mirror list
+ * amdgpu_device_has_job_running - check if there is any unfinished job
  *
  * @adev: amdgpu_device pointer
  *
- * check if there is any job in mirror list
+ * check if there is any job running on the device when guest driver receives
+ * FLR notification from host driver. If there are still jobs running and not
+ * signaled after 1s, the hardware is most likely hung already, then the guest
+ * driver will not respond the FLR reset. Instead, let the job hit the timeout
+ * and guest driver then issue the reset request.
  */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
-	int i;
+	int i, j;
 	struct drm_sched_job *job;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -5239,11 +5244,12 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
-		spin_lock(&ring->sched.job_list_lock);
-		job = list_first_entry_or_null(&ring->sched.pending_list,
-					       struct drm_sched_job, list);
-		spin_unlock(&ring->sched.job_list_lock);
-		if (job)
+		for (j = 0; j < AMDGPU_PENDING_JOB_TIMEOUT; j++) {
+			if (!amdgpu_fence_count_emitted(ring))
+				break;
+			udelay(1);
+		}
+		if (j == AMDGPU_PENDING_JOB_TIMEOUT)
 			return true;
 	}
 	return false;
-- 
2.34.1

