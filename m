Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DD2C02198
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 03:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D555410E9D2;
	Thu, 13 Feb 2025 03:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ynnuh2C9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DFDA10E9D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 03:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Qr0cLKyOgA5TxDn3VbFrri1tRQwzIiGByDr5lLHqRxDqbw4WoLUl4fTFBqmBGDIVYHfpw3nWlqTozOufwsQRHujzHuaC39DEpi8xh/yYJGhN2G5ItJIBpDQbbZzy7UL2aGF2EWxqAeKO2rmUSuVzSap1k7I8WMA2tJecQEAnLF+8mSWQ3/u7aOBCxCdcyoJo0hTRN1yP89hrUyrWmS8D4FUo646xLXpfmqeWlScbYgEcMaibkm9BpwRSTrFxwE5n59mms1P0tT8FiT6dF7hGUHpqoR6U2GvqPixeDNCQVC2btiL5MGyoHpBC6paCainUDsII2zbhZNIHIgNSoytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B+CtOI5Qp23OSmlqLGfdwTnAWOqn1xEH+GgKrG33DY=;
 b=cOz4riNqG1EJxA0SYr6FrYGhZACabKeQIFZbCtpx9Bjtk2iYabbAQpu15s48Y490Z9Y1dyZahxjIb1YChTIt5R29tJjU5mle56/M6JmQxP8h4mB2qJDoibW1D8ApU/2yq+T7JxEn+hOahy/W9I0uDiBLjesz5X6AfmsmRZg8b20VJo5McQdg7EUN/5VX3X9ySC/xi/LQshaLjr9/BOz3PlbnBI82ap56v4jNEQliQzH5Ho7btLns9SVeyPhZffnE58b/2VmhN6acPkpliK+Ynx5i3GiV/oeO+8R7f8aqZWA+QZiTMx8izIo9upYpahL6GwCIfpYS5ftAsouQu+0/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B+CtOI5Qp23OSmlqLGfdwTnAWOqn1xEH+GgKrG33DY=;
 b=Ynnuh2C9F1rhGdS+fwdyFkhI8I2B5GGBF7f5DPlKVwWIIti3ffrXRgU7hGqE+G4Y6VB35TzEvat6xYbtYuA9ObIQo2FXuHywvR8X8ZnU5f/p+HQjiXrXgPV9RbkLLGadgHTWc8iJo6fEFCc73pepPwV3ADK0MvYBZrUBMnZ4lmQ=
Received: from CH0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:610:e4::9)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 03:07:57 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::64) by CH0PR03CA0184.outlook.office365.com
 (2603:10b6:610:e4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 03:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 03:07:57 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 21:05:50 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 5/6] drm/amdgpu: Add ring reset callback for JPEG2_5_0
Date: Thu, 13 Feb 2025 08:24:07 +0530
Message-ID: <20250213025408.2402828-6-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: e15268d0-2286-43b9-e02f-08dd4bdb9da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clFNNXlzNnVCNTdDai9FUGpXZzA3cWhqYWFBdFhueFJpcWJ5aEFNMGJaQzVG?=
 =?utf-8?B?b1BLMFRQQ2ZNanc2dkdXZ2J0TTJ1bHJlanlQa2NlL3pZZHlvVnZsVVVWWUd0?=
 =?utf-8?B?NDZxYnZHdGRvWEZ1a1BhcGd2QzBkd29qOUIwYVZDWlNFa3AxVklCaHpsa2lT?=
 =?utf-8?B?K240Q2U3dzB1TkdQYXpwYXl4QWxIaER1MTZJQllVN29INEVZVFNlNmJoUDBj?=
 =?utf-8?B?cmNuUW5OQ3BHYkVxcS82UGorOHhwUFQwaE9oRC9qRGI5cTlYVURCWUtHVDU4?=
 =?utf-8?B?Vks1V2VFVVZsMzcrclRMdUhqNElmRHFaTGxTTFBkaDYrOHVZRU1XZHpnZFRy?=
 =?utf-8?B?MEFtYmtaaFRkZzFDZ1VFQThKNkYzRnVXYjdWaDQ0dm4vTUQrNWsyZGVQLzVj?=
 =?utf-8?B?NXhtQThLbDhReDNkcGNaV05MWVQyL015RUt2dzNFQ1dLN2FjVENheDNMQWE2?=
 =?utf-8?B?R2RRTWtldE55TFdFdFhCV2JhRzk2OEdEeVArc3Jvdk5EWFpZNnl1cytGWE1S?=
 =?utf-8?B?ckt0SlcrMXJ0Q21CaDFSdTMrdDc1UXA1MFZoYWVBTHh0TzdlcEVUWkV4ZGJj?=
 =?utf-8?B?VTBzUEhJUzl4ZGZzOEpPVUVPNkRxd2VhUzVrRVdTQnpBM1J2UUdOdkJuT3Vy?=
 =?utf-8?B?NjE4ODNXR282eE8vOGUxSnZwL2dMeTRIN3BxNnNsem9ZODAxZCtqR1lNQkhY?=
 =?utf-8?B?N1lnTUxJOXZhU0hsVTVxOVhMUlNoa2ZWQlBRN3VqNlR2a3ZPODZDVitHUlRj?=
 =?utf-8?B?ZTR2ZGZjY1h1VG16b3NLY3dPS1pUblErSkhFWlh6bXNBeGRQZFpYU1EyR3Bu?=
 =?utf-8?B?Y29EdjRkSk1jY1Noak0zQ3hRbm1LS1RtRk1YZ0JpeVBMQ3ZHUUIrOWQwSEVt?=
 =?utf-8?B?TVZNajltNEN6S2VkT2l5OGFWek9BZHAxM0JULzNqKzlSdlNjTEJuUmVIVFJC?=
 =?utf-8?B?VWxDQXFXSzlBV2VKL2tnMUdVdktDNVczVkpRZ3B2T0dxMWgvMHhJZmxaTnBs?=
 =?utf-8?B?aG5WTWFoS0I2ZTZ5d2kvc2x0MUlDU2xyM0poRlVHZGhFMndCZ1k5amVjajFC?=
 =?utf-8?B?Vi9LUEhBc25BSjFJQVRSbUFwbWhhYlVsc0txaTJiN0c3Ylh1ektOcXRyVEIv?=
 =?utf-8?B?eTNIbFdRUnRWb3lUSUZEUXJiblA1NzVYbUZraUFDeUxGS2JnZzlBSVVOUjV0?=
 =?utf-8?B?eDg4bnBTVGhEbDY3R3A3bkxPY1ZIVkZiMXc4MUFFaUxocEhxcE1NMGZBVmhY?=
 =?utf-8?B?amc2WFRwQTZMSExaUlZwUGlVd2tWRlNXSHdGNXR1bmZGck4yeGFsZjZCMWRN?=
 =?utf-8?B?OTZPRnBBM3AveDR0MWkyY0pYNS9iV3ZDSmR1SFl5aVhUcHFEaWZUSzQ4K1NK?=
 =?utf-8?B?VUt4SnAvK3g3T3lpZmRqV3Z0RjY0NEM1WUxZZ3Zwb0hBdG1VR0ZuN1FPeGlo?=
 =?utf-8?B?OUhyaENmYjVVTVluYzREV3ZqN1Z1cVZVRWdWY1BVSnVsVWYzY1p4UEltSkpC?=
 =?utf-8?B?MS9pZ3dKcXpMUGkrMWFINDdMZ2NlUXpnejJuNlVkdWQzd1dHUDZPVHo5VEZS?=
 =?utf-8?B?NkhIYzRCektaVWJXSTEyMXlaeHAxQzV5L0ZmdnZnQXRsSmdwTlYyUTJYOUR0?=
 =?utf-8?B?ajNwSVJVc3hCNU4zVjZVWktJZ21ibzNGQ1JrMEZVbG9rcjFmTUFXOXZxWmVt?=
 =?utf-8?B?VzZRSFM0Rk9ENEkwUnhJNE1ySDdNZWlyNG9tVXBwRmVuLy90c1R5WUZhdG5H?=
 =?utf-8?B?ZnBhMXJnQzIxczhTeEszZEZsN3JNMkR5WE5PdFpJbEJWT0kzMTZONmNKK1di?=
 =?utf-8?B?bXh6UEhUS0gvamtWQlExZWpiQjAwWDVHNG1lZ1BkWUo2c2h3d082eGtqTDlj?=
 =?utf-8?B?bXpYZG5vK3ZTaXk0VHlVdkNMbWlQMjhTR2Zwa2NhemQwcXphaTlmMkJvTVBj?=
 =?utf-8?B?Sm9sMzMwNTVCdHJnclJEUDBCbGFtWnlDODI0ZXRZc3p1NVptK3QzbS8zQzIz?=
 =?utf-8?Q?clTga8wahXEFI3G29lBs/0R/PcwuIQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:07:57.0552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15268d0-2286-43b9-e02f-08dd4bdb9da8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

Add ring reset function callback for JPEG2_5_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 0490b672d8d3..0a2c1dee2430 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -167,7 +167,10 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return 0;
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+
+	return r;
 }
 
 /**
@@ -186,6 +189,8 @@ static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -638,6 +643,13 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	jpeg_v2_5_stop_inst(ring->adev, ring->me);
+	jpeg_v2_5_start_inst(ring->adev, ring->me);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.name = "jpeg_v2_5",
 	.early_init = jpeg_v2_5_early_init,
@@ -700,6 +712,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_5_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
@@ -730,6 +743,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_5_ring_reset,
 };
 
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

