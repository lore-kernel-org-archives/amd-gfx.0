Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB68D116E1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC1210E9E5;
	Fri, 25 Oct 2024 02:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZ4FCX/Q";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5036410E9D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdwMv8VVkrTdb+Yi1jZgIuEZf0gFxImL5lDuYIq+Mwj/JvwoZMfrJ5FJCaU1xdUAgaJYuBEpYzzQU5tnBQBnpGL8MJg4PNZ83ESLvsW1UaJdRDHfhYinnLI5KfFW42kTB0FOp6IZPnTJbCqxCrWwf9SosmGliRhdVFf2v0q/qHpykAsdhrNevlfaHZFhKdRf5j4hf+bqlpqvk1T1GYfqs/xgPA0UuQyhx5JcdjPMNPYLCUTZM18jFZoblxA2vI8HVlTVgBMos0yAz5hlVkb68X1sLYDy1Ki8LVd9D3r9OdeAzYtFNJ+nrXJKvC8hVEcuQZvQlN3KX4ueKnSa5SgBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+clK24X6tnO4rx9xSjPuhCDxYk6DM3f0pCCum/GFWf8=;
 b=pXlrUCMTHwg/R6ZIL5WQ6hQiV09ytt3nGdqdMfX63pZXE4DBq36mqpfa56R0iGYeeUi/t9zoQDSZwun+vixQjbWKgM8lhoB9FObp0xtlDMlJST8tcJVMMRHAbYdwcMIvsyqqPnl/4DCEg9cSba0CJGh2Vc/AwYdZLRbRttAeEyqoYthxvJEGXHIqvxdaq1W97ce4/sz4XFseWUGp7mNLveBNj9bWVFpDz3TBT+RsxYXSIJbmLPhzrX3iPqFBpWV6HAU6YliD2uaZ9w+4Yls5Yy0qzncbdx4QT3wnzIMSsC6aBlBBFt0uQ6+8P8i0QJRreuCb64qSgEbTgoBhB6jGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+clK24X6tnO4rx9xSjPuhCDxYk6DM3f0pCCum/GFWf8=;
 b=tZ4FCX/QolJMsetaaB4hDdV++YqF9fUTXow8zIsOcx2kmaOE/cV5lfhAn3t3qgK/lyY8PYde8RVsuEiSWj1aLpfS6VELR4VSLNFFqMdHCxAfWUb3x9lYn1OjNvmEQMNMx2xAZNCfquNMArbxuhH5F+WqXl0nLrcTuOpXNR+so/E=
Received: from CY5PR15CA0179.namprd15.prod.outlook.com (2603:10b6:930:81::27)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 02:36:19 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::2c) by CY5PR15CA0179.outlook.office365.com
 (2603:10b6:930:81::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:14 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 19/29] drm/amdgpu: set powergating state by vcn instance
Date: Thu, 24 Oct 2024 22:35:35 -0400
Message-ID: <20241025023545.465886-20-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 000fef38-8930-4fb3-cd0c-08dcf49dce9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWJGTEVhbVpoK1B0VHQreVU5WnFPb3dhcGVTV1F0Q3VoTU1GbkI1WktkNytZ?=
 =?utf-8?B?a2E2ZGpkZ0xVbVNYMDBGL2s0VFFSYy90ckFpMGdRM3psM3R6U1FoYTFaaUpX?=
 =?utf-8?B?VWlVZEF2TTVtRVlJaWdPdDJmTE1ZQ281OXIwSVdub0RkU0J3bVhFdzRsNElG?=
 =?utf-8?B?UXBpbEwxYnJsaHpOUEpMbzBuTHFHckVoZEg0UzA4LzQyWXFZUXdkOUlRQTQx?=
 =?utf-8?B?dGxDUWV2cGQweE1LdGdsdjZhb0FpWTd6b2pheVg5VkNUTG90U2VZYnhieGQ2?=
 =?utf-8?B?R1NaS1hmUnR2K29kZzlIaXZ6SDM5azRoczVRUm1ub0haRysvL0d5S285ckl5?=
 =?utf-8?B?SkdEbXBPMWtyd1BKUFRjUnlEOC9XYXJpMGtvV3BaNWEwQjIxa3ZEWXBCaWs2?=
 =?utf-8?B?Z0F6VVFPemV4UE5ka0V0YXZZNk5XVGY1MWF0MlR3UVFOc2JBc1REK2JPZ1FP?=
 =?utf-8?B?NnVsZ0xCd0JmaXVrSmtKWHpwUi9uMFhJVDBUbTBWOHhaVmdad0IrUStGQm9u?=
 =?utf-8?B?Nm1mSGhybzY4b0VnTWtvV2Y0aU9aMFRZMnd2R1hqQUdFV3Z0bUhTcHRDYUE0?=
 =?utf-8?B?c0pQTll0TE82bjY3MWVPdkpoL1JwZzFsWWtUblY5RlM3T3pnZkpxOXdkT2Nj?=
 =?utf-8?B?M3JoU3lRbWZHQ2JoMzlZMXVvWFBjalBiclFOMVFQOGVtWER5dm5CcVRuYTU4?=
 =?utf-8?B?d3NyMnY5U2VaRDVIRDdHMERVNDdXeVdEYW9WZEZGc2Q0K2Yza1lGcVVqTVRH?=
 =?utf-8?B?alZjeGhuMHFudjBsU2dsclMvTFgrZVlISHhJM2ZsS3VUUTlvcFpRZkptRktC?=
 =?utf-8?B?OGRwQzMxV2NYdWZ0V3hPWk90MXR0d20zSlQwOHhvUDBrejVTN3AxV3JtZzFh?=
 =?utf-8?B?OTVNNXlTYzI1b2V1QUpOQWd2UTBHL05WY0ltTUx2L0RYZFlnRXhiZkhva1pP?=
 =?utf-8?B?TkFZRERpZDFlbzVaZW9rc1RralpkUFdSTVVxTTI2bHNpOXBmZ3IvNmpYV3No?=
 =?utf-8?B?UG1xOGZxbUZRVGdtVnVneWo0NzZwZWdoL1lWcTR0bGIrUGZTRUtiK2h0cEFX?=
 =?utf-8?B?OHZwVE5DczdQYTBlbzJVU3orNURUVjNVdnAwNjRoR3phZ2tNSVl1bnBaeTBy?=
 =?utf-8?B?K3QycGYwME56dmdhZUZHWExxMkM5U3R0bVFBZi9IT3kwbFJ3VkZNSWpHVGdp?=
 =?utf-8?B?TnJSbFY0ekF5S0xJM1hjTzZUYlcrV0NNelpkRjV3UFdxM3FCaXZnYWVCa3Zr?=
 =?utf-8?B?WXRVMkprWk90ZkdRMDRUTEN4ZUgrUXpRK0JZOXNzbFh1aGpIdVJkOVFVRHJu?=
 =?utf-8?B?TThZdDJqZUpQZTRsaU1qUmg4VzJoZ3NqazRRSjB4ZlJrZkpzYXNLV0c0TXRl?=
 =?utf-8?B?SDVBaURWOWtHRXpXVjZ3cUdobGVtODVnenNoZWtpWlRXZU5DN2RZSCtERUth?=
 =?utf-8?B?dzc4Zk0xMWpWVnVXUEdOS0JTMEl2Y3JLOTROZzByM3dDTkllbm5Xd2NzZkR0?=
 =?utf-8?B?di9XLytsTEU2c3oyZUhKOEZzVHRybGdnc2ZNNGRaaTNIbEJLMmdtSVZTbmo5?=
 =?utf-8?B?Kys1TkxzRCtlZmg1T2pDZy8vR24vTmRFVXFaQjBHV1VCR0Jqd2pIa0tPNUdB?=
 =?utf-8?B?anFUUFNhZ3JWYkJ1OUNMRmx1ZWZpRmJFVkI0UTFxTE13UEIyazZ0dTR4TEZt?=
 =?utf-8?B?WHFxaDIwRVFUcFRpWVlQN2QzYy9BOFpqUXVmbUZ2b1RlclZReFZiMVVJVUR3?=
 =?utf-8?B?djQ2QXlYazFOQ3dRWUNSMUtyRFNjMVZWNnJPTXRlSEN0MGlaQjFDNmY0ZWxx?=
 =?utf-8?B?QlFMVW5qWkFmRWpUSFpPYzNJemx0S3hLc0ZHNWtxeXBjb21MM1dzZjV2VWJo?=
 =?utf-8?B?cnIwVjdjNE1TVVlTajZMVEx0R2VpZG9VT2padmtjTTlSY3c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:19.1227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000fef38-8930-4fb3-cd0c-08dcf49dce9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Set powergating state by vcn instance in idle_work_handler() and
ring_begin_use() functions for vcn with multiple instances.

v2: Add instance parameter to amdgpu_device_ip_set_powergating_state(),
instead of creating new function.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c              | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c              |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                |  4 ++--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                  |  6 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c           |  8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c |  6 ++++--
 .../amd/pm/powerplay/hwmgr/smu7_clockpowergating.c   | 12 ++++++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c  | 12 ++++++++----
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c    |  6 ++++--
 22 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2e2c6a556cc8..03ae6f614969 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -357,7 +357,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 					   enum amd_clockgating_state state);
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state);
+					   enum amd_powergating_state state,
+					   int inst);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 065463b5d6a9..7a44ceeb7ec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2177,7 +2177,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
  */
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state)
+					   enum amd_powergating_state state,
+					   int inst)
 {
 	struct amdgpu_device *adev = dev;
 	int i, r = 0;
@@ -2187,6 +2188,9 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 			continue;
 		if (adev->ip_blocks[i].version->type != block_type)
 			continue;
+		if (block_type == AMD_IP_BLOCK_TYPE_VCN &&
+				adev->ip_blocks[i].instance != inst)
+			continue;
 		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..78fd1ff28a57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -119,7 +119,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 
 	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 	else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
 }
@@ -133,7 +133,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 31fd30dcd593..09844953a1fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1277,7 +1277,7 @@ static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
 			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 			/* shutdown the UVD block */
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_GATE);
+							       AMD_PG_STATE_GATE, 0);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_GATE);
 		}
@@ -1303,7 +1303,7 @@ void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_UNGATE);
+							       AMD_PG_STATE_UNGATE, 0);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 74fdbf71d95b..a061fb8a2fcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -344,7 +344,7 @@ static void amdgpu_vce_idle_work_handler(struct work_struct *work)
 		} else {
 			amdgpu_asic_set_vce_clocks(adev, 0, 0);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_GATE);
+							       AMD_PG_STATE_GATE, 0);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_GATE);
 		}
@@ -378,7 +378,7 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_UNGATE);
+							       AMD_PG_STATE_UNGATE, 0);
 
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 3d2d2a0d98c8..efd6c9eb3502 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -416,8 +416,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
 
 	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev,
+			AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_GATE, inst);
+
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 											false);
 		if (r)
@@ -442,8 +443,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+
+	amdgpu_device_ip_set_powergating_state(adev,
+		AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_UNGATE, ring->me);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 0a884215f59b..cbc0347a8d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -330,7 +330,7 @@ static void vpe_idle_work_handler(struct work_struct *work)
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
 
 	if (fences == 0)
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
 	else
 		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
@@ -406,7 +406,7 @@ static int vpe_hw_init(struct amdgpu_ip_block *ip_block)
 
 	/* Power on VPE */
 	ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
-						     AMD_PG_STATE_UNGATE);
+						     AMD_PG_STATE_UNGATE, 0);
 	if (ret)
 		return ret;
 
@@ -429,7 +429,7 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
 	vpe_ring_stop(vpe);
 
 	/* Power off VPE */
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
 
 	return 0;
 }
@@ -845,7 +845,7 @@ static void vpe_ring_begin_use(struct amdgpu_ring *ring)
 		uint32_t context_notify;
 
 		/* Power on VPE */
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE, 0);
 
 		/* Indicates that a job from a new context has been submitted. */
 		context_notify = RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.context_indicator));
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5830e799c0a3..0986f7a83401 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -735,7 +735,7 @@ static int uvd_v3_1_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index f93079e09215..565632478c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -249,7 +249,7 @@ static int uvd_v4_2_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 050a0f309390..ce7f205899f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -247,7 +247,7 @@ static int uvd_v5_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index d9d036ee51fb..ccf8dde8cd71 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -571,7 +571,7 @@ static int uvd_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 53249d4ff8ec..c93eb5122bd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -639,7 +639,7 @@ static int uvd_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index c633b7ff2943..4b4d295802a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -512,7 +512,7 @@ static int vce_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index f8bddcd19b68..fc7d80c2a841 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -523,7 +523,7 @@ static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 335bda64ff5b..e7b6f8cc8b74 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -589,7 +589,7 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f07a5a8393c0..8b860db34584 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1861,7 +1861,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-			       AMD_PG_STATE_GATE);
+			       AMD_PG_STATE_GATE, 0);
 	} else {
 		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -1891,7 +1891,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-			       AMD_PG_STATE_UNGATE);
+			       AMD_PG_STATE_UNGATE, 0);
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5a9006bfc3cd..d4c264814b61 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1026,7 +1026,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 		/* enter UMD Pstate */
 		amdgpu_device_ip_set_powergating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE,
+						       0);
 		amdgpu_device_ip_set_clockgating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
 						       AMD_CG_STATE_UNGATE);
@@ -1038,7 +1039,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 						       AMD_CG_STATE_GATE);
 		amdgpu_device_ip_set_powergating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE,
+						       0);
 	}
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 67a8e22b1126..e54be4b386f2 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1675,7 +1675,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 	if (gate) {
 		/* stop the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		kv_update_uvd_dpm(adev, gate);
 		if (pi->caps_uvd_pg)
 			/* power off the UVD block */
@@ -1688,7 +1688,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 		kv_update_uvd_dpm(adev, gate);
 
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	}
 }
 
@@ -1702,7 +1702,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 	if (gate) {
 		/* stop the VCE block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		kv_enable_vce_dpm(adev, false);
 		if (pi->caps_vce_pg) /* power off the VCE block */
 			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
@@ -1712,7 +1712,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 		kv_enable_vce_dpm(adev, true);
 		/* re-init the VCE block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index a8c732e07006..41dbf043f59b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1407,7 +1407,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCN,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_PowerDownVcn, 0, NULL);
 		smu10_data->vcn_power_gated = true;
@@ -1416,7 +1417,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
 						PPSMC_MSG_PowerUpVcn, 0, NULL);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCN,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu10_data->vcn_power_gated = false;
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
index f2bda3bcbbde..b496b77153e9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
@@ -120,7 +120,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_UVD,
 				AMD_CG_STATE_GATE);
@@ -133,7 +134,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu7_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -148,7 +150,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_VCE,
 				AMD_CG_STATE_GATE);
@@ -161,7 +164,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu7_update_vce_dpm(hwmgr, false);
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 7e1197420873..2ccce2bc3b4a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1985,7 +1985,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
 						AMD_CG_STATE_GATE);
@@ -1998,7 +1999,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 						AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu8_dpm_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -2017,7 +2019,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_GATE);
+					AMD_PG_STATE_GATE,
+					0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
 					AMD_CG_STATE_GATE);
@@ -2032,7 +2035,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 					AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_UNGATE);
+					AMD_PG_STATE_UNGATE,
+					0);
 		smu8_dpm_update_vce_dpm(hwmgr);
 		smu8_enable_disable_vce_dpm(hwmgr, true);
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index baf251fe5d82..64ef8c8398ff 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3715,11 +3715,13 @@ static void vega20_power_gate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 	} else {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
 	}
 
-- 
2.34.1

