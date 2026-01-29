Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4461D73E89
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDC610E8B5;
	Thu, 29 Jan 2026 20:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ongfShdw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012F810E303
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY8lFFf8W1S2sjUIWbF31gAIQtwoYOpk8zXDGkaWwVQ4SDEaLZYQH6ArvMg/4aLrQdsnMBTeyLwgixgrWg74IjA0CKv+LBd4OKaBe5ukyagrrbf538A1nRRDq7+q4Lv49A5PO/u4ObV4sl7WxDOfNyg3zsKXcP0RYT6ArYOFhqYJvy/d0WPbpvGwflUIe+UIqJK+XSqrUHAQmjuUxUIaxJu/9cTp64yz04iLnN1ULh/NIue5I8/ZEG5HWDqqr2GKDq+IXfjyXAg8Qm7foUhiz+UoM+u+KewYpdNJZhLZt8Sy3gM8zhh7AGYzqamWedlDTp35OaZ0PWLMmEZzCTOWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hShLt3s7nbN08ffRalVlkPEcEq6HXZTQZRHlYfMfA4Y=;
 b=q4AmqdxFZaU9JypCwEfY5cXDEAj1am/7Vm/fyP63uM3QXDeaXFUyceoglAbP/t9SEUtmbxx5wJEnVdK5ylugR8C4qRkFoVPJHjMvtCmVbJQ2Mmzxw8YtnGb0du0jIeNyI29yjI9PcQMQbR8BDqgFNeGZ50nSTySm0DeMnXZaHX6eAqEYl+LxwDxlvNYF/3fzWu1lUqq0SbGES7KsV1qfTrTEwAJ0+xUVxWcYc+H7lX5M3hh+VWbnWIWnk0W4wpIfhyeOiRSOoPNBZub7KxtkRfSH3dy0UK/+PxoEPEGip2fti0jiRFUY8TxUgQCr4XckUPON/5BK4r81qM1jxB4X5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hShLt3s7nbN08ffRalVlkPEcEq6HXZTQZRHlYfMfA4Y=;
 b=ongfShdwRX/UlR62TPaXwjiy+itx2bD6KwqJNa46JjAEDqo53sSSEcccN3PcbGctoPeeTtrGaNWM0TkLBO+u/2WMQkOCCiOhCbp9t2qdWuhIAR73Zqq/eILfIDxY/XHy5sJSLMzedKqRcGoxZ1mhVYAs28DiaKEmEjXeNR3rot0=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 20:37:58 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::2c) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:54 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:53 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/12] drm/amdgpu: plumb timedout fence through to force
 completion
Date: Thu, 29 Jan 2026 15:37:26 -0500
Message-ID: <20260129203731.21506-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 70df5a19-6946-46ae-53a4-08de5f764955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3I2V1V0V0U4YWFuRFNqT2thaTNhZmVoMXBtd2RGS0l4Z25WV0YzbzJDTnpo?=
 =?utf-8?B?Q0puR2ZTc05kd2FLektyRnNOcnY3enB4SEl4ZENQR0pyYUtINW9Hd3NvQlNZ?=
 =?utf-8?B?c2U0Q3FQcVlWeTFBTmJxQThiUTF6WmJvbm94SUFiN1ZQakFhVGZweElCaEJv?=
 =?utf-8?B?ZHRhMnQxYkVYcW9hTmJNYkQ2bDJiTVo5OWNXdzk0dklSU0JLLzY0ZDZEc0I0?=
 =?utf-8?B?NFVQaS9ZSjljaTJzcVNVRW0zeWs2UTJFVlE3NFAzVFQ3MnBGOGJZdkZianlC?=
 =?utf-8?B?RDZIL3V3OVhJNWkyMnNCYk1YNW9IZVloUGoxQzhNTVBBZHBoUHRHcERsT3BF?=
 =?utf-8?B?aTdsdEMvOUtnSEI3SjZtSEdKZWI1Z0x0ZzgxYitLK0ZxNlV2Y1BHSkZ6aGl4?=
 =?utf-8?B?QWRiR1MyV1d5K3ZQRGQ2UUc1WU15SEFXeld2WUJzUWlrM1FwNHBJY0s3eWt3?=
 =?utf-8?B?UisvVTJrRnlwQmVhQlJjVFBVR3N4eUdoa01wdnVtZ3N6cUFMbGN3bUw5OW9D?=
 =?utf-8?B?aWxxUDI4cGdDeUh2cnRLSlgweXgyZEY3N1MzUWJWVkxyM2ZSY2FjTjNsVVBT?=
 =?utf-8?B?L1FZRWlJc1hpMmZ2REQ4TTdGamRnZjkya20xWFRySGZsZWlaZGY5WDIvSDlC?=
 =?utf-8?B?Qm1aZFpNNWxBNnFFNVZ1TG4xSjQ1UklLbEtWRThXbnRIVStrbzVmeUtrWndD?=
 =?utf-8?B?cXpzeFVtZWVwQ3E2eUxMN05WNmRCMGZpVUJhS2xlQ0lYZkxKTGlyMkdEOWtS?=
 =?utf-8?B?Y0tLZGxkZGxlZVBXeWk5R01EcGY4b2RQZzFPM3ZmZ0pORHFNejNhQytjeHQ0?=
 =?utf-8?B?WXMxeHJscG1oOU52TExlcWF1QU9oNkZsc041bmpueTlpV3ljYWdGZFVaMWZB?=
 =?utf-8?B?SDlaTUx1WmVnTEFDQTVBSWlpQ1hRbFpmNEwxZ0JQNUtEemFyVDlrSWFqMGQ2?=
 =?utf-8?B?dW5kSUs4U1NjWW1rdFBCa1k3d1I3VFA0MXJSNTM4bms2djZaM0V3cHo5ZndS?=
 =?utf-8?B?bmg2WTE3VnNQV3lJZStTVXNmaWwvMm9IbHpvdmV4a0pqTmNYRDh4MmdaZGJV?=
 =?utf-8?B?Y3cxd3BqYnZEYWRud2JLemxhdnRmNGNNNUV5cVVQMVkxMlJvRlR0YjlPT2JT?=
 =?utf-8?B?Q3BtbmNVN2NkOFcwd1E1VHhETlhUOHB1c3llcWVmMW5QOWh0aU5aSGNGMjFx?=
 =?utf-8?B?ZUJjSFdwd0hkZXNJYktuZkcyRHhLZ1RwbTh3ZzNROUV1UE9GZWJXUGgwTnFT?=
 =?utf-8?B?aXBhQWNuV0FtZE1NV3hjeWNkMmtzM0ZZSHh1ME51YThFVlB3YWM5MkdYaDZB?=
 =?utf-8?B?UFZTUGl3UnlDR0dZMHFRSzJ6Rjd6bXlLaW9jM3E4VVcwK3JESHlWcEtna3Fy?=
 =?utf-8?B?U3pROEpPY2RKci9kTk5UeTNQQ1dBVFg0emJ6NXpaaU5JdmpLOE9BRG1ON0FQ?=
 =?utf-8?B?cWJ3VSthcWRLN3Uwdm9WWVdBSG1SZFdDQ3NJY3ZIMnl5R2xlOTB5ZU9yQUkv?=
 =?utf-8?B?a0xYR1VHRFJZVzBxd3ozS2NPYmNpMWM5M1NNMkVsV1p2VmtzWldMS0lMSHFB?=
 =?utf-8?B?d3daSEI2U3VKNTBEVFJHQVo2ZFVCZ0FjNWh5TnM5dWdDeXR6bkluNllyNTd4?=
 =?utf-8?B?TDNuYUZhaU5CLzhMa3AxYWNWRVVyTDZCRzIvdDFjZlR6OGtBYnVuWkcwRFlo?=
 =?utf-8?B?Ny8wdm1RMUdaK1RONmJ6WVZWSkl2aTJCSW42ZmV1cDJ1NzFualcxb2VXVUhL?=
 =?utf-8?B?TGcvTmJmYWt3WkpoQlZPcGxzeHBCVC9FeXNBS1UwdjBueGFyeUk4VTRXSTRL?=
 =?utf-8?B?bEZ4RHhyK3RpdGVoSHFZYTN4NXZzNVlKcEFqTVBzTlJZNU9pQUZSTXU4dkhx?=
 =?utf-8?B?SUNlYVVyQWR5aTVJUFhybG8rNVR6WW8zZHByZ2M3b1owRmh3Wklxd3VrdFdw?=
 =?utf-8?B?TUk3S0Y4OWxVY0RrdHNCK0t5dXE4YzNCOEYzR0tMN2ZKTzlXejErOWx1b3l0?=
 =?utf-8?B?dHNpZ1dCai90d0tGWE1IRWttcndzaUhPaDdqeTBjUUQrOEhMNm00T0dDbjlz?=
 =?utf-8?B?enJvbmFMekJ0bjN0MWxTY3hLQjBrSUwyN1U5YzJyOVBvTjVCeHJoV01id1Rl?=
 =?utf-8?B?ZWNLcTBscDRQOWd0UXh5RmdwM1djcVFCSkIwOFA3YjhzZFpoeXRmYXM0L011?=
 =?utf-8?B?K2N5dEV4bGVNNEI4WmE1YTZpOFdXTHlZUUluSXBFYUdHY3hVMmtFOFNQRTI3?=
 =?utf-8?B?eWZqNFN5MTEwRG90c2pkc1hGWW5nPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: THd+qmwDtmzNxp71dyrf/fPA/hs4g/W4WjFK49w46QRNGslCIKJfXDvNLDrdBzy0peCUw75JB1jiuOON3oxWCnIFmLYKsy6/WMda7SuET5+BlzFM8ekv1N/BD0p83XKpDLq1K+53q1X2alu0Cf54+nUaaQGUMQHbGgXUs8+/xhcn/2ySpTzKebgMZom7YoerPK/0ORSoDze37S+BTH3hQoveVlZcdD+CO08A/J4LwVpzd0mToq1u3TR1sSAUmj86LiHIra41vXMYawzOQf4tj3JpbW9X/tjjpnKQn+LyaHRORznwnwu6soP+1Xir5LeIWzSX2iJIOgOSzptBDAu3DDwBwzJB9mMSl13T99EIYK1/XvJ+dKuo1JOfYFhL6JNWe1FHCarx2LcRBMc0SEXwoiB2K75hbjNhd+Ruhpa850auc5nQtxPxRrx095Xf07c0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:57.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70df5a19-6946-46ae-53a4-08de5f764955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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

When we do a full adapter reset, if we know the timedout fence
mark the fence with -ETIME rather than -ECANCELED so it
gets properly handled by userspace.

v2: rebase

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  6 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 28 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 21 ++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |  2 +-
 9 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aeb90708f2293..663d115ab169c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1936,7 +1936,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		/* swap out the old fences */
 		amdgpu_ib_preempt_fences_swap(ring, fences);
 
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		/* resubmit unfinished jobs */
 		amdgpu_ib_preempt_job_recovery(&ring->sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 376b7c4dbdaff..57fffcbe76f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5795,6 +5795,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 {
 	int i, r = 0;
 	struct amdgpu_job *job = NULL;
+	struct dma_fence *fence = NULL;
 	struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -5807,6 +5808,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, true);
 
+	if (job)
+		fence = &job->hw_fence->base;
+
 	/* block all schedulers and reset given job's ring */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -5815,7 +5819,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			continue;
 
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, fence);
 	}
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1054d66c54fac..3c38bf58fd3f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -567,7 +567,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 			r = -ENODEV;
 		/* no need to trigger GPU reset as we are unloading */
 		if (r)
-			amdgpu_fence_driver_force_completion(ring);
+			amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
 		    ring->fence_drv.irq_src &&
@@ -682,16 +682,34 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
  * amdgpu_fence_driver_force_completion - force signal latest fence of ring
  *
  * @ring: fence of the ring to signal
+ * @timedout_fence: fence of the timedout job
  *
  */
-void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
+void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
+					  struct dma_fence *timedout_fence)
 {
-	amdgpu_fence_driver_set_error(ring, -ECANCELED);
+	struct amdgpu_fence_driver *drv = &ring->fence_drv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	for (unsigned int i = 0; i <= drv->num_fences_mask; ++i) {
+		struct dma_fence *fence;
+
+		fence = rcu_dereference_protected(drv->fences[i],
+						  lockdep_is_held(&drv->lock));
+		if (fence && !dma_fence_is_signaled_locked(fence)) {
+			if (fence == timedout_fence)
+				dma_fence_set_error(fence, -ETIME);
+			else
+				dma_fence_set_error(fence, -ECANCELED);
+		}
+	}
+	spin_unlock_irqrestore(&drv->lock, flags);
+
 	amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
 	amdgpu_fence_process(ring);
 }
 
-
 /*
  * Kernel queue reset handling
  *
@@ -752,7 +770,7 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 
 	if (reemitted) {
 		/* if we've already reemitted once then just cancel everything */
-		amdgpu_fence_driver_force_completion(af->ring);
+		amdgpu_fence_driver_force_completion(af->ring, &af->base);
 		af->ring->ring_backup_entries_to_copy = 0;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 86a788d476957..ce095427611fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -160,7 +160,8 @@ struct amdgpu_fence {
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
-void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
+					  struct dma_fence *timedout_fence);
 void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8b8a04138711c..c270a40de5e5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -597,10 +597,10 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 * to be submitted to the queues after the reset is complete.
 		 */
 		if (!ret) {
-			amdgpu_fence_driver_force_completion(gfx_ring);
+			amdgpu_fence_driver_force_completion(gfx_ring, NULL);
 			drm_sched_wqueue_start(&gfx_ring->sched);
 			if (adev->sdma.has_page_queue) {
-				amdgpu_fence_driver_force_completion(page_ring);
+				amdgpu_fence_driver_force_completion(page_ring, NULL);
 				drm_sched_wqueue_start(&page_ring->sched);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 9d5cca7da1d9e..3a3bc0d370fa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -512,7 +512,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 			/* to restore uvd fence seq */
-			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring);
+			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
 		}
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 75ae9b429420e..d22c8980fa42b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1482,15 +1482,16 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 /**
  * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @adev: Pointer to the AMDGPU device
- * @instance_id: VCN engine instance to reset
+ * @ring: Pointer to the VCN ring
+ * @timedout_fence: fence that timed out
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
-				   uint32_t instance_id)
+static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
+				   struct amdgpu_fence *timedout_fence)
 {
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
 	mutex_lock(&vinst->engine_reset_mutex);
@@ -1514,9 +1515,13 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
 		if (r)
 			goto unlock;
 	}
-	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec,
+					     (&vinst->ring_dec == ring) ?
+					     &timedout_fence->base : NULL);
 	for (i = 0; i < vinst->num_enc_rings; i++)
-		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i],
+						     (&vinst->ring_enc[i] == ring) ?
+						     &timedout_fence->base : NULL);
 
 	/* Restart the scheduler's work queue for the dec and enc rings
 	 * if they were stopped by this function. This allows new tasks
@@ -1552,7 +1557,7 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		return -EINVAL;
 
-	return amdgpu_vcn_reset_engine(adev, ring->me);
+	return amdgpu_vcn_reset_engine(ring, timedout_fence);
 }
 
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e78526a4e521e..a6aa72ec8fb19 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1669,7 +1669,7 @@ static int vcn_v4_0_3_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst[inst].ring_dec[i];
 		/* Force completion of any remaining jobs */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (ring->use_doorbell)
 			WREG32_SOC15_OFFSET(
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c28c6aff17aaa..100ea1a914b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1332,7 +1332,7 @@ static int vcn_v5_0_1_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst[inst].ring_dec[i];
 		/* Force completion of any remaining jobs */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (ring->use_doorbell)
 			WREG32_SOC15_OFFSET(
-- 
2.52.0

