Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCB7E77198
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 12:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C88E10E66A;
	Mon,  6 Jan 2025 12:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzCES/5b";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A73B10E66A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 12:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEp5U43Yi6yTIyhNirTvJgw7Jt5SMBOc6NKXv3af/6hKcb+3yzPjrEbcxLeKOvzoEdwNFNyT/BDvmxAOijw0QwbqEZA19S2NegRY444mbfZ4Yw/NuY4wdjZifyJD3iXVtwduITXBtPAW60rmVXQJEoXR4c6MfGLPrj9E5rfP84V/qTPq9YS87vWAOxvWFzqM0Dzs63a25L/gze5E1d0wJAA0W3wzur7ttU9eWKBks3fkN1nQMvahA9YPTbI6YffxvnzAeM6SPX3vOhVeqn0IyXrVuB5jj03d46URNjCGV85W1/RuJYY2HokF+DppZ2egt992RMPUg6tcAPZrUlvxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrvODDOgSNoXLj3Mf6jTFUU7ws1b9NrQuWqTuYmFqkU=;
 b=kA4Y/8h+G3drez+OkaB98IbCKbF9xatoMkH33pOAsHkeelx47xTQ8dSvf/7bIi53CtQoyiH2VtoTs0jB3vND9uGKTNIVA9bo4J/xL9+lUMQK/iUbiGqqcDjR5lP5Pozk1SWFaUPNqaI1Yn/83uUlIj8MQpf9/v3JUH7pdu1UTraZ5EmuqUaxx/chCVxM264QkN0acpQPRCVpjPLEwhZNAYta4C2vdUF1PnkV0eN8gsRtahx7uSspVXAPtoWQGI9EvSiM7zBWqi4Fm73IYZvghjuj0yIyewfySExbhDNIsY8BJIvp2fXNYB6+LFeHle7aZLm7oDV8VYFeUL25NrLtzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrvODDOgSNoXLj3Mf6jTFUU7ws1b9NrQuWqTuYmFqkU=;
 b=QzCES/5btM6Rilvn7ixTOrEmLkVMAlOj1p7y1rU3HaxUt4P9G65Lv4tj405HIMVhOccNJ7VlUp2HelrZK5lkXeMW2C100SSE2MGEWeWbhqLGTfSWjddXawuvPF21dkj5QqygmJVIPEvabzQLSyWfIuT7vZ5AsISQVGdp7DmV/1k=
Received: from CH2PR20CA0013.namprd20.prod.outlook.com (2603:10b6:610:58::23)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 12:43:54 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::77) by CH2PR20CA0013.outlook.office365.com
 (2603:10b6:610:58::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 12:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 12:43:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 6 Jan 2025 06:43:51 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Added Debug Logging for Process Isolation
Date: Mon, 6 Jan 2025 18:13:30 +0530
Message-ID: <20250106124330.328941-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: f538b13a-9ae3-49bc-5287-08dd2e4fc785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|30052699003|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2tQbmVWNlJLdXBmOHN1di85UThTSnZrQ1BPbHlITTZHcS9jdWZwWkM2bkZX?=
 =?utf-8?B?aUdITzB5cDFjWWE1OHNvZXE5cXdsRU5iL3dHVG1IYnN2cmw4K2d6MFBLeE1w?=
 =?utf-8?B?aW9GQ2JpbFNVSzhGNmE5VVRXTDBZbVZnR2VZRm9adCt0WmhieUJOOHBCekxB?=
 =?utf-8?B?SVI0YVhSZVB0RlhZZDJrRlVzeDI2VkNUMWFKU1pPMG4xOFRSN0c3YXFLT2VR?=
 =?utf-8?B?MHEwM21LZ0gyeHAyWjl2dHplUy9GTHVveHYxSTdZcDJYcHozaG1nM0loUHVo?=
 =?utf-8?B?cytac3Rva3M3SW1KWmFBUCtPVEZ5bU44S1BSYlRDWC9VSVhkWXdaK1U2dm9u?=
 =?utf-8?B?VGFtL21IL2prTTRYbDJ0SWE2amZnNkNxL1g0SnkyMEJEUksrTUMrZWplTXNZ?=
 =?utf-8?B?ZWtQUkVyMTgxNTdHV2p4U1pvdnBHSEtCcnRXb09QUndEOCtQL3dxSkx1SVdU?=
 =?utf-8?B?dDFsMWpZYUhaK3JpTzNtWlFvZTE5ZG1kdURiZzZweTBOdWF1Zmw0aGVLdnFn?=
 =?utf-8?B?dTVEVStIV3NDcnNPVXJJRzdKTGpBRVlwNndmN2hEelN2NnZ0a0pRSjdzeHNY?=
 =?utf-8?B?ckpBNStrMlNOZ1J2K29rbG5IZU0wMUhySnpoQmVCNkhtMFJ2UlB2dW5ZcVYr?=
 =?utf-8?B?OVAvcjBETVJzd2NTWXZUWnlLTDhOSDEyREVKdEludFlpejlyVmR3U1hWWURw?=
 =?utf-8?B?bnJPVy9KKzV3cHRpSGtmMkpaZzd5KzdoV0FwdkJPMDJJUnhWSmN4aklVamtz?=
 =?utf-8?B?cmlPNVIvbUM4YmR2MXpNbm5rTE9rUHN5bDY5THU4UGxrUDR1Sy9iZUpSOG56?=
 =?utf-8?B?R1FERTV5NnM4RGFEVEFRVDlGQ2dieEU5NU1KcnlOUVFoYUlUSEhoZ1JRMkZo?=
 =?utf-8?B?ZlZxaUE1N3NRRlFyVjZtTTlrMXpMMVJSbzMzdzBOcEI2M2lRZjFGRVNKcGFa?=
 =?utf-8?B?cklZUGszaEREN0VqTGlKMUd1bnJuOXh5Y1BVK0UyL1JReFdPTDZhazFyWEta?=
 =?utf-8?B?OTBNMk16eWhxcFYxclAzTEdPMXNBRGpGanRxSUpKc3BWVTVaZlpYdTVEV3Ba?=
 =?utf-8?B?d01CTmErTU5ubFNjT1NtOUJYcVNVeWkvVk8zNUtCeTVTV3VHaXRPTnVadERy?=
 =?utf-8?B?L1pIUHpKV3l3YXN3S2NMdTl0bTRlTVV3UTFieGQ4dG5QV3NCZGZNdUV1cEVH?=
 =?utf-8?B?NUtBR01tUkx6WW5YWVhDWTNjY29MUzRlYzkwNE9jWWhCYnV2anhBOUV4ZWwy?=
 =?utf-8?B?S0lpWXROZTRRL0JYTXIyc0VVMTN2RjkvbytZK2RVZFNYdVlSU21WSGx6ZVQw?=
 =?utf-8?B?dE9VNTdoTjluWHdqaGFMZC9pdjdiZ3NQK0pXVkhHR3VjQVJwUjRTUnpSNnR2?=
 =?utf-8?B?bkFBcUFGZ0RiTkhtREJ0VkxCYURJd01Gd09xOVU0cGFrWW5weXdldVFUbmJi?=
 =?utf-8?B?YzltVkxXQXZXNHkwdGhaZEtWaGgwenVmb25aWWFQdnpHSWZranNqb21QdC81?=
 =?utf-8?B?Y0s1cElEa2xaeUtmRmpaOE1DVzFFU0xjb2hBNGpGT0xHLzFKY29YeWJKSFpB?=
 =?utf-8?B?elptajJTNm1Ic2dQU3RDSGdRNWdjelI5LzFaSFgraUQ1NGFRNUU2dGFMMUF4?=
 =?utf-8?B?eDMrckp1ekIrVkpnbjNVSzBNRUlQeHRFK3NBWStGUU9qeENFZnY3NVdSTDlM?=
 =?utf-8?B?QXJLblJYdm83aDhwdEEwNlVJYzBhZEdyQ1h4MzArSFdCcVB6dkVTdHdmYUVC?=
 =?utf-8?B?VmZ1VlRCaXFSdSt5bFd6a040SlRDVkFCRTYyTjNhb3FPTWI2TEtXeFhRMGF3?=
 =?utf-8?B?WnE1cWtFRUxRam5NTmYyMFBRbDgrUmJyVzdEVklaVHNzK09rREtSQTBPa0Ex?=
 =?utf-8?B?WDkybThLVDVuVUhBTEJySDlSK2FCSGVScG1JdWV3bCtiREV2U1JiMHNrQmdB?=
 =?utf-8?B?WkQxK0tScXRvYi9KN3dFM2NML0paMTYxNW5vZlAzZnRTWmMzSk1Ka1NYR1ZF?=
 =?utf-8?Q?LAUzZbFVheosj7L4KIWiEPD62VVju4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(30052699003)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 12:43:54.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f538b13a-9ae3-49bc-5287-08dd2e4fc785
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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

Added debug logging to provide insights into KGD/KFD scheduling, cleaner
shader emission, and isolation processes.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  5 ++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 89f7c89d1392..ef985a7bda1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1912,16 +1912,19 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 
 		adev->gfx.kfd_sch_req_count[idx]--;
 
+		dev_dbg(adev->dev, "%s: Enabling KFD scheduler for idx: %u\n", __func__, idx);
 		if (adev->gfx.kfd_sch_req_count[idx] == 0 &&
 		    adev->gfx.kfd_sch_inactive[idx]) {
 			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
 					      msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
 		}
 	} else {
+		dev_dbg(adev->dev, "%s: Disabling KFD scheduler for idx: %u\n", __func__, idx);
 		if (adev->gfx.kfd_sch_req_count[idx] == 0) {
 			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
 			if (!adev->gfx.kfd_sch_inactive[idx]) {
 				amdgpu_amdkfd_stop_sched(adev, idx);
+				dev_dbg(adev->dev, "%s: KFD stopped\n", __func__);
 				adev->gfx.kfd_sch_inactive[idx] = true;
 			}
 		}
@@ -1960,7 +1963,12 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 	if (idx >= MAX_XCP)
 		return;
 
+	dev_dbg(adev->dev, "%s: Starting enforce isolation handler for idx: %u\n",
+		__func__, idx);
+
 	mutex_lock(&adev->enforce_isolation_mutex);
+	dev_dbg(adev->dev, "%s: Processing fences for idx: %u. Checking GFX and Compute rings.\n",
+		__func__, idx);
 	for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i) {
 		if (isolation_work->xcp_id == adev->gfx.gfx_ring[i].xcp_id)
 			fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
@@ -1969,16 +1977,23 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 		if (isolation_work->xcp_id == adev->gfx.compute_ring[i].xcp_id)
 			fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
 	}
+	dev_dbg(adev->dev, "%s: Total fences processed for idx: %u: %u\n",
+		__func__, idx, fences);
 	if (fences) {
+		dev_dbg(adev->dev, "%s: Fences detected for idx: %u, scheduling delayed work\n",
+			__func__, idx);
 		/* we've already had our timeslice, so let's wrap this up */
 		schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
 				      msecs_to_jiffies(1));
 	} else {
+		dev_dbg(adev->dev, "%s: No fences detected for idx: %u, no delayed work scheduled\n",
+			__func__, idx);
 		/* Tell KFD to resume the runqueue */
 		if (adev->kfd.init_complete) {
 			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
 			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
 				amdgpu_amdkfd_start_sched(adev, idx);
+				dev_dbg(adev->dev, "%s: KFD started\n", __func__);
 				adev->gfx.kfd_sch_inactive[idx] = false;
 		}
 	}
@@ -2009,6 +2024,8 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
 		if (!adev->gfx.enforce_isolation_jiffies[idx]) {
 			adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
 			adev->gfx.enforce_isolation_time[idx] =	GFX_SLICE_PERIOD_MS;
+			dev_dbg(adev->dev, "%s: Initializing time slice for idx: %u. Setting start time and duration for fair GPU access between KGD and KFD. Initial jiffies: %lu, Time slice: %u ms\n",
+				__func__, idx, jiffies, GFX_SLICE_PERIOD_MS);
 		}
 		/* Make sure KFD gets a chance to run */
 		if (amdgpu_amdkfd_compute_active(adev, idx)) {
@@ -2020,19 +2037,28 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
 					wait = true;
 					/* reset the timer period */
 					adev->gfx.enforce_isolation_time[idx] =	GFX_SLICE_PERIOD_MS;
+					dev_dbg(adev->dev, "%s: Time slice expired for idx: %u. Allowing KGD to finish its work before KFD resumes. Resetting time slice to %u ms\n",
+						__func__, idx, GFX_SLICE_PERIOD_MS);
 				} else {
 					/* set the timer period to what's left in our time slice */
 					adev->gfx.enforce_isolation_time[idx] =
 						GFX_SLICE_PERIOD_MS - jiffies_to_msecs(cjiffies);
+					dev_dbg(adev->dev, "%s: Adjusting remaining time slice for idx: %u. KFD can use the GPU for %lu more ms\n",
+						__func__, idx,
+						adev->gfx.enforce_isolation_time[idx]);
 				}
 			} else {
 				/* if jiffies wrap around we will just wait a little longer */
 				adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
+				dev_dbg(adev->dev, "%s: Jiffies reset for idx: %u. Starting new time slice to ensure fair GPU access between KGD and KFD. New jiffies: %lu\n",
+					__func__, idx, jiffies);
 			}
 		} else {
 			/* if there is no KFD work, then set the full slice period */
 			adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
 			adev->gfx.enforce_isolation_time[idx] = GFX_SLICE_PERIOD_MS;
+			dev_dbg(adev->dev, "%s: No KFD work for idx: %u. Setting full slice period to %u ms\n",
+				__func__, idx, GFX_SLICE_PERIOD_MS);
 		}
 	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
@@ -2055,6 +2081,8 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	u32 idx;
 
+	dev_dbg(adev->dev, "%s: begin_use\n", __func__);
+
 	if (!adev->gfx.enable_cleaner_shader)
 		return;
 
@@ -2089,6 +2117,8 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	u32 idx;
 
+	dev_dbg(adev->dev, "%s: end_use\n", __func__);
+
 	if (!adev->gfx.enable_cleaner_shader)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c9c48b782ec1..06b527388402 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -688,8 +688,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	if (adev->gfx.enable_cleaner_shader &&
 	    ring->funcs->emit_cleaner_shader &&
-	    job->enforce_isolation)
+	    job->enforce_isolation) {
+		dev_dbg(ring->adev->dev, "%s: Emitting cleaner shader for ring: %s\n",
+			__func__, ring->name);
 		ring->funcs->emit_cleaner_shader(ring);
+	}
 
 	if (vm_flush_needed) {
 		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
-- 
2.34.1

