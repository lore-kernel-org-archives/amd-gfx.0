Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EA1C2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95DA310E87D;
	Wed, 21 May 2025 15:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uUFiIpUg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0799310E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWKDjayWjYZe82IxKdPDkLm/AQMe3ZRhL9YOjT6QRlyAmjQEo8lD7iWilOeEE+14zcVUDdRlejXS497Bv0n5/fz+UNbyyrsqzE6aA4MGhGCiT3Hp8HfGIw8X/F+se7Kkw3KSw7MMOir3EBBVQkG/KUJzgzVsXFZz8cdEzZ4cIsmVbbCZLl9sNgxDpVRDdUZAz/RN3OeK1333p6Pt+8oG1WZIG/6zJQCzYgLbzexmhqNPo96ISJquPyGJL6YnQ5k26+2I+ZWjfP5OlmfawVu0qGUDP+CzqlVC56ruNXqNgAkWy2Qy7+O7kROtUWKZqESfxLjeOmnoaZQ8dCtyd4vw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFMUMBtCDrSwUtiMcErMBV1YE/Z1I2bmTkkKkrQhOXQ=;
 b=FNEg+fTyoPWOjYiOAk1tnZcJQzS6vDvXUICasTLhB+9w+sCKgVnlVBqh+BSqoXmfbEXkFEvDvi66A5GGoaIlM7rtfdYGi1OsYcTxKrjz1+Y8Al/dXuBAWJuhr/nviowaJx8WjSSIWJOa4PhawMdGaD2IUwUCSKTij7vW/ShuvQ4JqZHt5Rslv86z250jcvdYmUZfm4lVJRAtlzc5lwoddA87JNPWoTSthHCB/OBS9EJ3W5NkqI+E60R5E1Wol9bWBESRFiDgOroXrUSB//x1eBxmSOLe7BU8WSry5TmnFBLeW7DQ+1ikmFyVKltx8Qc+qwcxc2mWDOEssfoyzavjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFMUMBtCDrSwUtiMcErMBV1YE/Z1I2bmTkkKkrQhOXQ=;
 b=uUFiIpUgAVOzQkNw9fA2n8KaxQfbEbj6M3b4zWqUn2/CE+N+1ONVdDvcBNGmlEnlJhHwEpQ4urX6sf24Yf9r0BJyCJJdR/5bDgl+0n5+TC/JTNJcKeM0BKD8xHOmSxKijBjMUUz/V+5yJQqTxoeGsVGg11qG++nVz1fxbevu3N8=
Received: from PH8PR21CA0012.namprd21.prod.outlook.com (2603:10b6:510:2ce::6)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 15:29:40 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::1e) by PH8PR21CA0012.outlook.office365.com
 (2603:10b6:510:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.4 via Frontend Transport; Wed,
 21 May 2025 15:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: rework queue reset scheduler interaction
Date: Wed, 21 May 2025 11:29:15 -0400
Message-ID: <20250521152923.401945-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c508956-9957-4479-694b-08dd987c4db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1RWc0xkU1ROelNrbVMxUU5pUE9La0ZvTmQzNmZrRW5CQ3NYYzkzQkxmTTlR?=
 =?utf-8?B?M3hOYWpUa3BkUTZmcnM4YlhlVFJvZ2lQR3ZRRWp1WVhlQ2o2Y2M2a2I3c0kr?=
 =?utf-8?B?andSdzFpYWhGcjZPdUQxWmJxdklXWnFqK1d3dEJxZFpPZGdlNDRCbHRhbWE0?=
 =?utf-8?B?UHp2N3p6WlJHOUZLNlo0ZGN0dWhuY1V3VXlaZWRFeHhkNSttZ3Y2MEVDQkxm?=
 =?utf-8?B?dEZtR1M0YWtReUdPVVk0Skc3anIwOHRocHJyWVRMNWJOZWllVjE3bGNEa1l6?=
 =?utf-8?B?ME8xSmpiVUJEaUROczJENDJnUmZxM0xxVTVrdk1JRUxZYUE4WVpjaE5MQ0ZU?=
 =?utf-8?B?a1lXSC9uampVZlViSlhxeFBRak5iYnJPa25XMGlnRDY2RWNIVDZrUGwxTlB5?=
 =?utf-8?B?OGJTN3QvdWowZ1VidFVyQ2FBR3ViRXp5dGYrMDZHNktOV1VBSE1wVS85SGdy?=
 =?utf-8?B?L3hsbERtYXF4bHQxQXdIWlR0T3docWJpaGdqZTNhb241bzBpWkpSOFRROVpa?=
 =?utf-8?B?K3FsR3ZPZzU2YkN1Zjl3eUJhK1Z3TityKyswY1hSQWsvZnFMYVpyM2ZPNkNx?=
 =?utf-8?B?U2tvS0JpVUlYdEhsTHpKWC9vZisrOWh0ZURHVzVPRm5CV2QzcjlEdVBweldE?=
 =?utf-8?B?cWZTWGpSRG13SW8vVGRPNEt2dEprR3c4VUpXNUpZQjJldlhwclNWUzIwT2pl?=
 =?utf-8?B?dkhDaVk0YlQxWlFSNkVaT3h5ZzNFbWNFMkp2N3hQT2ZJOE9zWHNYaE1ZekFs?=
 =?utf-8?B?VkNkWFZmSUxXc1FoWlRybC81WlRpRENOeWk5QllBbWwyVGFRQzZIME4zTnFZ?=
 =?utf-8?B?R1lBMG9KUER3eEhWZHpTeDAxanlRaXBpb3hQOEJ1bDJzWjR6V3lMVHhHc1VT?=
 =?utf-8?B?Ry9lZlMvS2JDY1lURmRtSGx0UENPTmZhb2tYdzhxbGNMNTlDZzVOblNIUTFX?=
 =?utf-8?B?UDRJMFowcllCbTQvK0VmN2xCOVdRTW1jSFpUQlBrc1dFSWdUMWZ2UmRtUVFt?=
 =?utf-8?B?WU1SalcycFlzZDhBcWZtWUJPUHZIZWRtM1YrbEVaLzkzUVhXeDRBdXlNYnhs?=
 =?utf-8?B?UVl5SU54SHJYWnhlWUE3NmVpOUY1MVo2bUlQUjNJb096OFRsQVh2aUl2MWN1?=
 =?utf-8?B?Rm90ZGhZUytJK0FUeHM2QTVoNGVxb3JhV2crWDI5WXZ5K1luVFpnSG92VGRT?=
 =?utf-8?B?Mk9GQkZKaHdGNlMxN1liQmc0Qm9XbitaQUVyZjAwR3ZadHBTSGc3aDRrdlcw?=
 =?utf-8?B?QTlTMi82NmtSZVRuZndwc3FSak1wcy9sVC93NGVRYW9OOWgvZDhpZ2NNaGJa?=
 =?utf-8?B?YjJhaUpuUmNZRWxxMnRDUlVuZ3NjTFVPdkhsYk9yd0tlYkVoZWNsczZRdkdS?=
 =?utf-8?B?Qm95d1JpZlFsYVA5a3Blakg5Z2F0SEJsbThQOTJNZmVTcTErYWNPcmZQNGY3?=
 =?utf-8?B?N1F5S1ZKTXdPNy85MXZWZWxWWlJ4M2JaVndCVmZXS2xLdjlKRzdTRFFoVEp1?=
 =?utf-8?B?MTlVWUVaVUM1MjVMelMxUk80RllhODhiZDR2V2RzL1VxbUhHVWc4WGd1MFpj?=
 =?utf-8?B?Ulhkb041VUgzK3VpU2luRU5YakdMeVBVakVrRCtvN294RGVqVjRrSGNvUzY0?=
 =?utf-8?B?Z1JOZjRWdlJGSjlLQU1HTFZFZW1ZajNqU2tTeUMvakQ1Z3luM1FGaU9FL2FV?=
 =?utf-8?B?UmxhK1ppY2RSVzE4enNJcHlDT1QzSUhBVFVWNWtac2JZbXc3MWNNMjNRa20v?=
 =?utf-8?B?QjM4MGNkNDRFQ0JDK0xsdWkvT3pCeHN5cHZsVGs2M21wbS9Tc0w2UVNibkpk?=
 =?utf-8?B?MFQxRCsvK3hCMm1INUxqVUpZVlJoVjRvbFdEMnUxTGFsNWtlQlJ1NXJKazh1?=
 =?utf-8?B?RHluOWZ5YktncWcwN1pJMElNQmQ0S3d6Rm5zOXNGMkNNbTJ2bklRclhpQ3JE?=
 =?utf-8?B?VG54VmNVNWxYNmZtRlJta01sQTdVcWZyVWZMZmJFenlzVFhhODFSQWxabnVa?=
 =?utf-8?B?UlMwKzEvQXhEZFc1TFJUTldsejlHTGxqa1hxUDZVOGFGbHg0WmVmUkFlOG1Z?=
 =?utf-8?Q?duDIJg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:40.2824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c508956-9957-4479-694b-08dd987c4db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Stopping the scheduler for queue reset is generally a good idea because
it prevents any worker from touching the ring buffer.

But using amdgpu_fence_driver_force_completion() before restarting it was
a really bad idea because it marked fences as failed while the work was
potentially still running.

Stop doing that and cleanup the comment a bit.

v2: keep amdgpu_fence_driver_force_completion() for non-gfx rings

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 +++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index acb21fc8b3ce5..e57401ef85140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		bool is_guilty;
 
-		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
-		/* stop the scheduler, but don't mess with the
-		 * bad job yet because if ring reset fails
-		 * we'll fall back to full GPU reset.
+		dev_err(adev->dev, "Starting %s ring reset\n",
+			s_job->sched->name);
+
+		/*
+		 * Stop the scheduler to prevent anybody else from touching the
+		 * ring buffer.
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
@@ -157,19 +159,19 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
 			if (is_guilty) {
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				amdgpu_fence_driver_force_completion(ring);
+				if (ring->funcs->type != AMDGPU_RING_TYPE_GFX)
+					amdgpu_fence_driver_force_completion(ring);
 			}
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_start(&ring->sched, 0);
-			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+			drm_sched_wqueue_start(&ring->sched);
+			dev_err(adev->dev, "Ring %s reset succeeded\n",
+				ring->sched.name);
+			drm_dev_wedged_event(adev_to_drm(adev),
+					     DRM_WEDGE_RECOVERY_NONE);
 			goto exit;
 		}
-		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
+		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-- 
2.49.0

