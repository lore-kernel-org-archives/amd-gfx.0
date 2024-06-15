Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1031C27C4F
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Jun 2024 12:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C7210E1BD;
	Sat, 15 Jun 2024 12:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NtD+VFLx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79EB810E1D2
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jun 2024 12:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPxwb7arrX/z6ocnx8hvInnOPK8HLYExbUBuHNcC/qNrqg3fpkKiVnsHOWoIWNkCgbfymRa5EUXh8AtKmRlO8KhE5c1oENJdAYAxizvLhL5hOdb8GXT87RYcsZHePr0qMX7M6PNPaayRFlzI3qhUX7frT4+/hLCBFCu5laUP0Bpnp29E0ycjuxezWRbq1bZJWOwdo3j+/l+S6mAKCwSXnKQE0s8tyvHkhoFHcPb0Eh4dgLusUHZ63ZpqW3+tTc36mzW9S6KK03U8Sra6BqIwaIMMY4ZC0IFEmxoRMca91FuyGDcKncjQms+EbLyKKcY3iIQrBK8Bl/4yv8KLkWNp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZC8YNiOYlG5HNmY+IIlyA3725129anh8InbqpD6daE=;
 b=BV5QDSD9DNefaUP9CawXcR/8YWIl667I56FnuIS1LMqooIgnwIf+xChfB9lsPqQ4fa8o2WDxGgSALfHhrPOOVeYjCQ4/3Y3eaOQmpCHQBVEqh8QlqUXTRqkdxV+IqDHdLNU9iXj1typGgPI1mxy0Jo4OtHtvgqnRJ/ptKzFYxaylgFaPRzrQh1Emfoaufaac13dFcs59rhl6kPSsjiO25IvJVyP4/iMuzQ7khVxzXPMow7AKd/sk0ghim1ar0UkP8iFydWQRs4RNo6nFIxnQwK6BK7nYGF8UgpWjW9ipZtotf9zqYesrto0TjtzlMoIuAvs7L3siMSOS3CJOrvloyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZC8YNiOYlG5HNmY+IIlyA3725129anh8InbqpD6daE=;
 b=NtD+VFLxJTe6O0xkaTFwzTyt8oTJDCO2Qi9g9TmA0L9aM6QdA0cp+g8MqPeCq5D5brmp8zW+U4FeOxIZVgMDKmnopRz+KDDt8lIwau351jagmZtBbojRAi5m3Qo4A+qI7rxDWWwcsqH41WXmhI7oRRM3uH54HaXUnXpawVMUoV8=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Sat, 15 Jun
 2024 12:33:41 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::54) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Sat, 15 Jun 2024 12:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 12:33:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Jun 2024 07:33:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add NULL check for imu.funcs in
 gfx_v11_0_rlc_backdoor_autoload_enable
Date: Sat, 15 Jun 2024 18:03:22 +0530
Message-ID: <20240615123322.2683117-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: d96098d4-31a3-4bfa-225b-08dc8d376346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTN4Qng3K2lzUDVSdzRaa1M1dzFHa1VFVlpHYkxRTWxOQ2ZXZ1JVN0k5MWtB?=
 =?utf-8?B?TjRmR0xsQkpXb205RzRsY01xKzNpNXBESDJpckhZWGVxUGRLRUlyMTc3ZFkr?=
 =?utf-8?B?ZXBRUU9JQkpEMHl5bWl4NlRtL1c4VHJBMFFDNTR6TnpiWmdTdlA4VzQwcEZr?=
 =?utf-8?B?cXVPYWJIa2ZEVyt4Ny9ldiszNEMyN0I4QnVDZVMzTlRkTTROM3FGYUhBSTZF?=
 =?utf-8?B?ZzhEM2lFWUxCcDlFLzg1ekRZdkVlbTJlUUpVWDF5RGtnWFRTUCsycVNlSVVT?=
 =?utf-8?B?eVdqTTJlMHVQbi9pT2x6VU0rOWRnZzZqUlhCRjhGL0dRajdxcHZuYVNETzE2?=
 =?utf-8?B?MFJuVlpjMFhnQldBbkZHckFNeEtmUDhMVzRrUyszWll3ZGNHZTFoS1VlZDFr?=
 =?utf-8?B?b3hmMWFIdStDZUdEbFNLam1HSVFvZVZqYnlXeEhLSXE5QzJSZ3lNeFBSUEFX?=
 =?utf-8?B?THVNQlIwcGZpSmVLbDJoYWNtajRCZEtYSi91Um9ZWTE5amF4VHk5RmwzWXZU?=
 =?utf-8?B?UjJYanZlQVJqWFlZYUduNWdXTHVoV1VlZ1Z4b3JxUGlwWG53VzAxbnh0cFdO?=
 =?utf-8?B?Q3ZxZ3V3VVZPTXpOUllMYlpJZFcvdXBKZ2RkbVE2R2VOUUhHS0VhWGNCTHln?=
 =?utf-8?B?MVptYUp3RTVONzdnUW1aSXpZTTZYL2lsSkFGYTM4U05FNmNkbEVuR2pUK1BU?=
 =?utf-8?B?YXVmOVE5SkhlMlMvaUdPK1I5ajhSSEZjQ1E2a1Q0L0ZCazBPVHIram9KVHNS?=
 =?utf-8?B?K0huWVVLOXp3aFF1VldBK0p3cEw5VFJTeU1VM0hjd0MzdVcrRVdLVTY1ZXFo?=
 =?utf-8?B?cTFXYlpab3plbDBXVStuOVhXcVBZZ3llZUppRXM4dW1UQXUwdy9jKzFYTnR4?=
 =?utf-8?B?clRQS09mZng1OTJpUnRUZmZ3UjRRYWl1cGs2enZVcENDeCtSU000eTNLR1Mv?=
 =?utf-8?B?R1RZbFpRS0V5Z2hyejJqbkR0UXJRRHVLZkpCQXU2YUYxUnE3ZjhJTGpkU2lx?=
 =?utf-8?B?TVpvV2lCRTUvUUJvV2M0a2Z4RzdBVVBlU2ZFVHkyRE5hM2xJL0tYQU14djhH?=
 =?utf-8?B?QnQxRjBZTFB5dlVzRE5Gc1h5M21nUTZ3NWhuOUJEazZQcStzcWJ0L3dycmJ0?=
 =?utf-8?B?c0ZNYTM1cUU0b1JBbnhTYk41UFp6UUNtM3BYS1R4YkkxbmlubUJDUytldzM0?=
 =?utf-8?B?SHcrM2huK3FYZHVtWVpiQUNKWFM5Smo3RTlSSlZSVTMxTStDUDllMHMwa2hF?=
 =?utf-8?B?L0VzcGhJVDBvM1M5Q2NJWmpFMUpoK1VRL3kvaTNXSnBGYUxmU3BrNlVSQnV2?=
 =?utf-8?B?RHpSaEVXV0E2L2haaDlvNXRqWnYwWjlLV0s3TFV4QUJpeGVCT0w0cU9TSC9K?=
 =?utf-8?B?anpzTm1LY1NyQ0VIWUJyeWhLVXVwWFBvY1BDQlo0SDU1aEJReTUxOFhRYWFP?=
 =?utf-8?B?emEyVXg4bSthOXlMY1p0YU8rdXdMcmltZjhxQ1N3TkpBbDdLc1YwTVpMempu?=
 =?utf-8?B?RStDN051RXJRRGdJT3pvbGFDcGM3VmhtaXVBZk0zVmtyd0grK1U1RFJmb1hC?=
 =?utf-8?B?Q3B3ZUJPOHBJWVF4dXRaRlJVaTdjUUxqNjI4REE1ZW9FSkFnZzVIcUJTbG5Y?=
 =?utf-8?B?c3hvWVkvbTJYT0dmV01wTFB4WkJSekw4L0pYODczRE16VzNsZTRXQ2NYTGpx?=
 =?utf-8?B?a241V0cxQ3ZidWNHRjJvbDNRcnJTMXhlRkliNmh1d21zQ0xURnBVMzRjUURX?=
 =?utf-8?B?M3o5VXlZV2FKLyt5VUx0d2xHYVhzNFg2cHdzaGdBQ1N5TFpEYUJ5QkxTYW1P?=
 =?utf-8?B?WTdlbEFBT1FIMFRJNTBlVkliMDE3WlBZTHF2Rk5qdlZQUzJpSHE1ZHVPZlVo?=
 =?utf-8?B?cVZDcU1KQzhvNDZlcWhnaXl6cjUvQjAwUXR2TjFQSmoxNmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 12:33:40.5682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96098d4-31a3-4bfa-225b-08dc8d376346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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

This commit adds a null check for `adev->gfx.imu.funcs` in the
`gfx_v11_0_rlc_backdoor_autoload_enable` function. This prevents
potential null pointer dereferences when calling the `load_microcode`,
`setup_imu`, and `start_imu` functions.

Previously, if `adev->gfx.imu.funcs` was null, it could lead to a null
pointer dereference. With this change, these function calls are   only
made if `adev->gfx.imu.funcs` is not null.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4503 gfx_v11_0_hw_init()
error: we previously assumed 'adev->gfx.imu.funcs' could be null (see line 4497)

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
    4491 static int gfx_v11_0_hw_init(void *handle)
    4492 {
    4493         int r;
    4494         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
    4495
    4496         if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
    4497                 if (adev->gfx.imu.funcs) {
                             ^^^^^^^^^^^^^^^^^^^ Check for NULL

    4498                         /* RLC autoload sequence 1: Program rlc ram */
    4499                         if (adev->gfx.imu.funcs->program_rlc_ram)
    4500                                 adev->gfx.imu.funcs->program_rlc_ram(adev);
    4501                 }
    4502                 /* rlc autoload firmware */
--> 4503                 r = gfx_v11_0_rlc_backdoor_autoload_enable(adev);
                                                                    ^^^^ Unchecked dereference inside the function.
    4505                         return r;
    4506         } else {

Fixes: 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2a510351dfce..4af4567ba197 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1459,14 +1459,16 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 
 	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_BOOTLOADER_SIZE, rlc_g_size);
 
-	/* RLC autoload sequence 3: load IMU fw */
-	if (adev->gfx.imu.funcs->load_microcode)
-		adev->gfx.imu.funcs->load_microcode(adev);
-	/* RLC autoload sequence 4 init IMU fw */
-	if (adev->gfx.imu.funcs->setup_imu)
-		adev->gfx.imu.funcs->setup_imu(adev);
-	if (adev->gfx.imu.funcs->start_imu)
-		adev->gfx.imu.funcs->start_imu(adev);
+	if (adev->gfx.imu.funcs) {
+		/* RLC autoload sequence 3: load IMU fw */
+		if (adev->gfx.imu.funcs->load_microcode)
+			adev->gfx.imu.funcs->load_microcode(adev);
+		/* RLC autoload sequence 4 init IMU fw */
+		if (adev->gfx.imu.funcs->setup_imu)
+			adev->gfx.imu.funcs->setup_imu(adev);
+		if (adev->gfx.imu.funcs->start_imu)
+			adev->gfx.imu.funcs->start_imu(adev);
+	}
 
 	/* RLC autoload sequence 5 disable gpa mode */
 	gfx_v11_0_disable_gpa_mode(adev);
-- 
2.34.1

