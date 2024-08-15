Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F9CC531DD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5883F10E336;
	Thu, 15 Aug 2024 00:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="axZR81PQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0AF10E326
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAJeK61bxGl/mkde8MkTRzxBR+ZTchjwXrZYaYNEQZZPe42V9Nd4mhvJGdKGzNQBSDAVMMVfQUQO7hUHt4MzBG29Fd/UnHHfjUSCO4PTXep+0t3ZoAEVzrDxusmwY/MhVn3MiZIMlp9dxGONg83c8mtfF1pqANcX3ayg71T/kwzsvPdTODTn2MfUvhvFTc9QoEEILhyOIaSvZ9heZ1YKUWDQBj59vvL9brlY6xE/mJPly3AWeCM/6PDPVA3bXR3+jaCtk1C+xLP0XUChaPqxI3WWHuqyeNIGcf0qmMpzQ/W0cjAwsS8N23GZ8YqJi32fx4Tl6wf/WbceSwlM9AI5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxTqGEWJLFz+Nrs83m0778peBfDGze6NS2mpIyr3hjo=;
 b=f2FC1ptgkRdGWzD05I5SDl/bzsyKNNoBEngqGwEAZGHPJ7gy9Bhk6d61Kqk61KjxFFa9/QM3LiJJKjHgF3H3gwyBhCnkoxGwyztH8qy5SM2VyTttLVTokxRpCFUvZXKrCk2inbx6bUZGtn0QVNJpF5RFltWyU8rFTb1sMIZu+NTj1yyBCsviISM7aV108mmBOW5ZBcC0YIUfglUBF9kkaCFeqpGiRggb+g9bi1u1veduPi/oB82FBcp4g78TY1cxBA/iUtTh5LP37Wx4APga1mh9seoJdTI9KjEVlYZcr/D70Teku1MO0M6WkQ+MThtFHkbMhiwLTqUvhGugEWR5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxTqGEWJLFz+Nrs83m0778peBfDGze6NS2mpIyr3hjo=;
 b=axZR81PQJgTnK0AA52lXd+EAXc8/CVVBUstVe/F7AwHO8oppos5KdF8ayJTkJKA7JoswMB90LCTopSWeqcis50/kRVe9+jAoPXG00Yt/oHAUSS0Uo9qrCy5ND0wzmXhvxvoWkNY1LMVa80QjZP/3cU8nsxVVEZqsjnwSmvZO/lE=
Received: from BL0PR0102CA0018.prod.exchangelabs.com (2603:10b6:207:18::31) by
 SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 00:05:20 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::a6) by BL0PR0102CA0018.outlook.office365.com
 (2603:10b6:207:18::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 04/17] drm/amdgpu: Make enforce_isolation setting per GPU
Date: Wed, 14 Aug 2024 20:04:48 -0400
Message-ID: <20240815000501.1845226-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: c019393a-5c28-46ea-9aca-08dcbcbdf3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWJuOEZQRDVxL241MG9JbS9OVzJ5b0JYdjZXcW9aZTJsbTNtbjBvNWFPc2Vh?=
 =?utf-8?B?alZLbkVLTlZxQUNaUk1tTC9TRHlEWUR0YUtTVEFBcHZwRkcvNVdvQkFiZnh6?=
 =?utf-8?B?UGhlSzV1MWloZHpIUlJ1M01FMlNpd0ozMnJSMk4yQ1VrbUczWmltb3FqTFEw?=
 =?utf-8?B?R3ZlYlZwS2VBQUN6NDlVeFVTZ215b1lKNWlGS2xZNFNrTVdmbVo1cDd6cElW?=
 =?utf-8?B?Rkw3STk5RjBsOURvMHZpRyt2TlhEOEZJOFdNRVorZGFMYllJOFVWVGg0em5l?=
 =?utf-8?B?T1M1c0ZoV2NwNjJ2TVZEUmdSVDhteUdDODZMbjlFakdUb0I1WFNqV0pNNS8z?=
 =?utf-8?B?WXdDeFhRQjdQVDQ3NnFhTXhIWjgzOVU1WnJXWUJkUGxGRDU0QW51U1IzakZH?=
 =?utf-8?B?RnNOTGdUMlVRK0tBbFY5SjRoczVjTnR3UGtWSzVTNDMxbFNIOU9sc0oxMUVZ?=
 =?utf-8?B?TkVDNW9MYi8wRDRaUUJXUjNoUzVpakxmM00vaC9lL3EzUDc3STdVM1F3QmhX?=
 =?utf-8?B?TEhsdGxYS0EzVERzWnd3aDY5RU4wVWE3S29ncksvaEpHdUJ4ZnhyaHhWVWx4?=
 =?utf-8?B?TnE1Z01zRnRuOGFLbmV4RGR0Z3ZPRVh4T0lZUlVsa1VuUm5hQlppRmhCVXda?=
 =?utf-8?B?Y0wzSzFRNzExOGM2eXdDR3F5TGdaMk5Ob0Z5OW56M2RsYkdtSGVoWGVUa0Rm?=
 =?utf-8?B?MjczU1hkbWRwa28vQzMvQVErSnJPNDdDQ0ZpN1RNWWZGVHBnWTJtTk1WdUg3?=
 =?utf-8?B?TDN5RFZabTgyeTRTSDE5NjhKSTJsd2Z5eEdwTk1YQlRmeFZrQzVqRit0c0FZ?=
 =?utf-8?B?ekdVUUIxMjY1Njk2bzU5T1Uvckc4RjZZTjRMUEZGY0JMd0xqTzRMUVphN3o0?=
 =?utf-8?B?WjVaWE5ORzRKM2J2dW9DaXBSN25sSEZ6enhTTktaMnY2SkliclBMeVZnV3ZQ?=
 =?utf-8?B?Q2FOTlZPdk9kYWdtRDZ1YllTdVBkZUZDOStNUFdOZXJscldGeURqN3lNUnZK?=
 =?utf-8?B?ZE5GWVY1alpxN1NzNWhWcHBsb1ZyUENtekpKMFBGQ2JkY1pIaUhwd254enM3?=
 =?utf-8?B?b0F2N0tKQU5mSjJnTHdiV1MvZWxDQkpTN2M4VWhyRzlkbVlWRUZDQkhSaC9E?=
 =?utf-8?B?UmxYSjF4eFJGWms3OEVLbDZVbDRyaHRNZVJGWGFKcElGVHhCM1VIUDFhWkVB?=
 =?utf-8?B?Slg4eS8xSmVSODFGTzRHL0l4UE51aUY3OFdLQXoxTE01VEhmSldwbThuaUxM?=
 =?utf-8?B?UVMwSXg2YTRWcUcxOGZJeXBPTWhQMWZ1VHdvZHVDdWxaZ1R6bkNRbUNJSWhz?=
 =?utf-8?B?V2s3cEZHRHNJNkxoM3E2a3lHMlpsY2xmaGxsZTBKZHRDemVJL3lzajFuMjFz?=
 =?utf-8?B?UHhsSWZZUEZQblV6M2RkN3FjZTZZc3BYeTlIN1VVWVluVk95SXJZenRBWFdI?=
 =?utf-8?B?bU5LL0drdXBwVWxMRlNpSUV5T1FqVjhLUHJaVDRTYVRKNWZWMVhVRTdOZk9o?=
 =?utf-8?B?SnoyNjZBcVByRS95bXh3U2xNMk9iaXdUZWJ1RkU4Y2R4c2JidGI2bXA0UFpt?=
 =?utf-8?B?L252NldiVmhCWFA1dTJxUXYwaE8wd1dvUHY2eVFmbnNkYlhpR3gxZkpzenMw?=
 =?utf-8?B?ODVKcC82Z3NnWXhVUmdFRUloMnNZdkk2djJYZ3JXb0FkOG9PRmxVSi9EalRT?=
 =?utf-8?B?WWw3VHJ3ZFlER3VPUnZPWTc2YnpjWkU0SUtBR3hSekZIamF2WXhmRlRpUjJK?=
 =?utf-8?B?K2xPcFJTRHFSd2NKcmpmZVpHSDBjNyt2ZXg1Z3J0RDRybVVRRjMvald4ZHpG?=
 =?utf-8?B?a3g4Z24xNktBT2dUWmF6VEF3Z3Z4RXVxazRvL210SWsvRnp6MmRmZ0trMGxJ?=
 =?utf-8?B?a2dMMnJLRnN1NlpqdTRnTXlEY0FSdFZpNERHajh4d0MwYVBFbmt0a2F4WTZJ?=
 =?utf-8?Q?JoJ/NWApkI0FRwv+6Vt54Obbl+Dvb+4D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:20.3862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c019393a-5c28-46ea-9aca-08dcbcbdf3c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit makes enforce_isolation setting to be per GPU and per
partition by adding the enforce_isolation array to the adev structure.
The adev variable is set based on the global enforce_isolation module
parameter during device initialization.

In amdgpu_ids.c, the adev->enforce_isolation value for the current GPU
is used to determine whether to enforce isolation between graphics and
compute processes on that GPU.

In amdgpu_ids.c, the adev->enforce_isolation value for the current GPU
and partition is used to determine whether to enforce isolation between
graphics and compute processes on that GPU and partition.

This allows the enforce_isolation setting to be controlled individually
for each GPU and each partition, which is useful in a system with
multiple GPUs and partitions where different isolation settings might be
desired for different GPUs and partitions.

v2: fix loop in amdgpu_vmid_mgr_init() (Alex)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 17 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    |  3 ++-
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f3980b40f2ce..ae3e827da5ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1162,6 +1162,8 @@ struct amdgpu_device {
 	bool                            debug_disable_soft_recovery;
 	bool                            debug_use_vram_fw_buf;
 	bool                            debug_enable_ras_aca;
+
+	bool				enforce_isolation[MAX_XCP];
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 78b3c067fea7..5d5ba1e3d90f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1110,7 +1110,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			struct drm_gpu_scheduler *sched = entity->rq->sched;
 			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
 
-			if (amdgpu_vmid_uses_reserved(vm, ring->vm_hub))
+			if (amdgpu_vmid_uses_reserved(adev, vm, ring->vm_hub))
 				return -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a6b8d0ba4758..95953c028ca5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1916,6 +1916,8 @@ static int amdgpu_device_init_apu_flags(struct amdgpu_device *adev)
  */
 static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 {
+	int i;
+
 	if (amdgpu_sched_jobs < 4) {
 		dev_warn(adev->dev, "sched jobs (%d) must be at least 4\n",
 			 amdgpu_sched_jobs);
@@ -1970,6 +1972,9 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	adev->firmware.load_type = amdgpu_ucode_get_load_type(adev, amdgpu_fw_load_type);
 
+	for (i = 0; i < MAX_XCP; i++)
+		adev->enforce_isolation[i] = !!enforce_isolation;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 6608eeb61e5a..92d27d32de41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -424,7 +424,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	if (r || !idle)
 		goto error;
 
-	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
+	if (amdgpu_vmid_uses_reserved(adev, vm, vmhub)) {
 		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
 		if (r || !id)
 			goto error;
@@ -476,15 +476,19 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 
 /*
  * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
+ * @adev: amdgpu_device pointer
  * @vm: the VM to check
  * @vmhub: the VMHUB which will be used
  *
  * Returns: True if the VM will use a reserved VMID.
  */
-bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
+bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm, unsigned int vmhub)
 {
 	return vm->reserved_vmid[vmhub] ||
-		(enforce_isolation && AMDGPU_IS_GFXHUB(vmhub));
+		(adev->enforce_isolation[(vm->root.bo->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
+					 vm->root.bo->xcp_id : 0] &&
+		 AMDGPU_IS_GFXHUB(vmhub));
 }
 
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
@@ -600,9 +604,10 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 		}
 	}
 	/* alloc a default reserved vmid to enforce isolation */
-	if (enforce_isolation)
-		amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
-
+	for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
+		if (adev->enforce_isolation[i])
+			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 240fa6751260..4012fb2dd08a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -78,7 +78,8 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
-bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
+bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm, unsigned int vmhub);
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
 				unsigned vmhub);
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
-- 
2.46.0

