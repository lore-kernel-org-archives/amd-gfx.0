Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F814CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 12:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D99410E0D4;
	Wed, 22 Oct 2025 12:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FlVx9Qic";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B2210E0D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 12:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3PEwhOayIb0z67louSNht3ZmE28mzCOo8nsmXI1ODyK3JBiEJDRc/n/2lelBXVqNN8RzQrXE5YwN3vQQJEwFeTlF4LNoBWe80fLMBhf+jr6PzbNIV4yel93yzC1FslHi+Wr550dvqjgkmNOTh3DO15znmqglP6dWtlKP8g5O/sTgUDtK1ImNumO/qjy/qg2A+T36j7t+zfLEdiZx2iw+QL7aKFaGT2Yy+El0WrPQ0DRyroTXRnX1skz0VAUWWa4mnaQb4X8OdKGqX0s1h8bsRoR8OFCKcrBwXGkLYWOMTB536DkE+o9tHAGLIrJf1m9qj3AagYqU03lq9Ncxl1k8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFaCoucmknq5OiOHq6UKZCOC4JBjUAWOkajqnRqtat8=;
 b=Oxb4NjRtFADB3tLntY/vnfsFnONd1Sa4UTLYxzxW6D5U9bFRbTITWm7z1HPeY6bNH+ApUyd22DJtvNarCOfo6YC30qD+X2GYqf4ORmnzD3A9ytdrtLTFOvBfs8Qo8+mESpV6kz1XpNXuBS8W0RjfluHaSYvu8cQBUh4LSbpHOAWCzC0Eki2Kd3H/3m2GECExCBlQ8b3ygzvJvnU8tyJoiF+OgE5UDUdyMs8nOXgzlNRxpyuBdjsuh/pOLQfmExFfxQYJUG454rjOGiPGUWfsSnAAkwOor2D4GREbYWZBxTXzL2CNnbasRgkbJeqDQ5xholWwNgUZusPczjHpUSwTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFaCoucmknq5OiOHq6UKZCOC4JBjUAWOkajqnRqtat8=;
 b=FlVx9Qic34eclNZqSOG7v3VnFiga3J8FPWgFaN/AWvR3ftTp8FixZTDhzkRz9cyjRSFIS6JGQ8W6c3m8nRn1aLQ988N+EKgqoUQf8QfqdIvat7VrCCuClWKLr0TOrWl4c7+SaKAofFZfIb+9roLHwONJ8UxH4cXI3Q8OWMzQmh8=
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:20:25 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::ee) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Wed,
 22 Oct 2025 12:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 12:20:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 05:20:22 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Make SR-IOV critical region checks overflow-safe
Date: Wed, 22 Oct 2025 17:50:09 +0530
Message-ID: <20251022122009.237253-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 0644d253-8d71-45bc-1afe-08de1165610f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHQ4UkNjOSt0aFR3MWx2SHY0MFF4VURNODBFRUtJTkxxNmh5OE1ZY0E1SmpR?=
 =?utf-8?B?Q3oxVVdyYW1ZT0FCc0FoMGUxcHRFWExrUzZuZ3FkVllHNXZBY0RQNlJLcUwv?=
 =?utf-8?B?MVZHSGxjeVZRK0xheHZPWWxtakVIaW1jdExvMStJdmhPWHp6ZThuNWkya0Nh?=
 =?utf-8?B?RGhma0tYSmd2aXFuSDUrcitudERpL253U0l6d2JPUDB0dUpaL1ZsODM1STcw?=
 =?utf-8?B?c21IMlF4L0wyMVZvWGloL3RBUUs5OUI2dk96Y1MxQXVCTmZjcmI4VElENXlk?=
 =?utf-8?B?bzhsYlJTTGhLSmR2eitmSk56Sm5qV3VWaWNCNlNDZTBFdG1sams4UFp2dGNo?=
 =?utf-8?B?ZEhQMzBtd25vcE5QRHhpWGppZ256N2w4ZmI2amJWWE5MSHBlUnZJU1U2eVJH?=
 =?utf-8?B?R29XZGk2UU90amlvT1NDWFh5ak92VXhwQTJRKzR3a3prVjQ2Y0FCb1NORzBG?=
 =?utf-8?B?MUN1VXVvbWxaaXlRb1hNYWtXTGI1dEF3SXJGSldWditGbXlDSzVLSU1nY1FG?=
 =?utf-8?B?RTR5eEJNSHRYTlg4cFFtRDd4Q1ZzOER3VDNWN21KbjVIclFkM0t5RHB5Zm9o?=
 =?utf-8?B?eHUyRjBwVVJiQXdpSGxlZU15V2xHVTlweDFMVEliTWRBZVJLUEhtSklvUFQy?=
 =?utf-8?B?cFFmOXJlYXk3ZUdwRkdrS3FvVm0xakgya3p6eHJJMGVBNEFocFg2Q2pkbHpJ?=
 =?utf-8?B?L2xYeU95bkIvVStSQTB3ZmNVQmpWOVFLMkpOUldMUXp5ZnRlc0Q4Q0MxeGZ3?=
 =?utf-8?B?Q09iZFMvZnlLbFhVMjlrSklxQW4vS2g3ejRmMGJxY254WG1DenM0dTRmWi90?=
 =?utf-8?B?QW5oV0ZNb0xNM0toVFNoNTE3NGxpNm1pUTVMdEVuTGVJZlh5T0tRaFVub05h?=
 =?utf-8?B?czFlelFxSGZaYUQ3dDNweEdBSm9NL0svQlpqYUljbDVENWxFR3ZOM3BYU3hm?=
 =?utf-8?B?OC9wZTdabWp6eFp0T0JreGRGSDk5djlKTEVxdEt5Vm9SUlMySDdRNDl4L3NW?=
 =?utf-8?B?UlgvY0x6dmNycmQva3ozNmoxazdwVTd5LzAyTG1sY0gyUENvSmFzdzlHOEY5?=
 =?utf-8?B?aFl1OFhRSXNoWFE0RmRZMFJoL3ZkMjN5SjhzeVE1WXRFN3QwbWozZ2JSVXAr?=
 =?utf-8?B?UFk3ZGY2eml5cFJmNUVtWjZOWjE4V2ZxdEZEN3dBOEdsdmlkTDJDc1o5M2J4?=
 =?utf-8?B?VklqVks2ZFVQSmZ0QTB1U0RnUzJLOUFPMUdML1Y3U2d6c0IxVGNwdktJM3pJ?=
 =?utf-8?B?RjZPVzMxOXA5VjVtZVN6U3JJTjFERE5uODlJaHFOY00vUlFmenBFR0puL1ZO?=
 =?utf-8?B?NkZVbGluajY4RVZqWGcxMVRrc0J4UEJCeG1VUXd1aHNmdHlhMTJ0WnNhVGo1?=
 =?utf-8?B?VnpPUXV4elZqbktNeGtLbHBvbW14cU1LaTFsZ2Z4WStHdmc4bUJPSWc5dmox?=
 =?utf-8?B?SEdKTlNnZ2VmY2djeHNSNmt5QXJwazNYQ3FGMU41UkJKZklhNC9peXBKL05n?=
 =?utf-8?B?WTRUelM3b05xS2JFaVpGUi8zbnlycllzYTRtRTQ2azhKVjFFdE9jSDJqWThL?=
 =?utf-8?B?eklScUo4RXg1NDBURVBZOVI0dzJuTXpCUHNYOStOVVhDRVVNWXJPeXZjVkVY?=
 =?utf-8?B?alZITUwyazRkNEJ6NW5NMHhGVlE4Y1J2WGVrd3NSdXc5YXlBMTZIT08rdkNO?=
 =?utf-8?B?VDU0RkVQbFVaSlJmaU4zWDNiWTdEUVpOazVDeXFSNVowOGFMcFA0VjRxQU1r?=
 =?utf-8?B?YVkyZ05RN2t1c1I3OCs4RjZoTGFlckw0bitBeDRZbHMzWkxKZWhldWMzZ0Y4?=
 =?utf-8?B?MXNBNlYyVzI4Z1ZhZHdtNWZ0ZkZDNXp4LzAveUE2a0RDYzFWNDhxUStRZUVM?=
 =?utf-8?B?a1NQN0EzVDZaTmpGc3krdTFLQktRL09RMVEvNStTb2sySkVuQVRBM3p4OE5t?=
 =?utf-8?B?djhjeWRaLzd0SExGYU5sK1lLa2VOL2RUZmlPT24xa1RTZ3dxb3I5cEdPOTFx?=
 =?utf-8?B?cW5ndVljYlJueXgrVFNWNzdTQkxBbThVTmVZL1craTJaQW5maHk1Skx4VHFa?=
 =?utf-8?B?NnVXSU9hUWdNRVVsTGg1aEJmazJidSs0N3FSOUhiRUp5ZjY3R2MxSzU1MWFO?=
 =?utf-8?Q?5AzQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:20:24.9599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0644d253-8d71-45bc-1afe-08de1165610f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
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

The function amdgpu_virt_init_critical_region() contained an invalid
check for a negative init_hdr_offset value:

    if (init_hdr_offset < 0)

Since init_hdr_offset is an unsigned 32-bit integer, this condition can
never be true and triggers a Smatch warning:

    warn: unsigned 'init_hdr_offset' is never less than zero

In addition, the subsequent bounds check: if ((init_hdr_offset +
init_hdr_size) > vram_size) was vulnerable to integer overflow when
adding the two unsigned values.  Thus, by promoting offset and size to
64-bit and using check_add_overflow() to safely validate the sum against
VRAM size.

Fixes: a5d4d72eee03 ("drm/amdgpu: Introduce SRIOV critical regions v2 during VF init")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ellen Pan <yunru.pan@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 66e9cd103597..45f2ad083338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -937,9 +937,10 @@ static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
-	uint32_t init_hdr_offset = adev->virt.init_data_header.offset;
-	uint32_t init_hdr_size = adev->virt.init_data_header.size_kb << 10;
-	uint64_t vram_size;
+	u64 init_hdr_offset = adev->virt.init_data_header.offset;
+	u64 init_hdr_size = (u64)adev->virt.init_data_header.size_kb << 10; /* KB → bytes */
+	u64 vram_size;
+	u64 end;
 	int r = 0;
 	uint8_t checksum = 0;
 
@@ -957,7 +958,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		return -EINVAL;
 	vram_size <<= 20;
 
-	if ((init_hdr_offset + init_hdr_size) > vram_size) {
+	if (check_add_overflow(init_hdr_offset, init_hdr_size, &end) || end > vram_size) {
 		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
 		return -EINVAL;
 	}
-- 
2.34.1

