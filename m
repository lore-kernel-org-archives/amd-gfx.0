Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8387C021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 17:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB3510EB62;
	Thu, 13 Feb 2025 17:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iK/LsS6U";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C05710EB62
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 17:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlEV3Gxsy9mQexBmNnrOgJn+ksMafkO1vGA8JwrXBqXp9we+iZrFUhLBHhS+NShHQ6nYuQ9+q3PXw24Pmrc2IADj1OANKuGmasdRXUO5DVESECNgeo/NDUZao9+3cZ7mBNI/V9ShBzu2Bw8xff5nrs/w275VZ+q+Q5nIp3332lO6o1/Pkpz9ETe/5e6eThnu+0bMJxEAtBGjGs60zKP/OTdr567c9YG2mLJV3RXXQsEuJaEeWhGHxkmrisAIk9Kis0Id0i9XaJkh5/Bxk6fYQRM3mSBBc4/YdQeQ6Bu+4LtZsnx+DLX2p/mqbv7pK7ybWz2jycZpNf9oHyiaJnUG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtl9tnTeGjuKVsWDNCMeWGZTyMMqC17sVyiQOdr23yQ=;
 b=GsCGFwrY1T6Qho8SWP3k3eTQyejmjPf5DLw5R4NUPCcHggK4aep+XzOqS55uZHZcOX3j87liDi9gm6jDLz2qi9Zh5rgN2G8YcF12661fuA7guBjuLvo8NAfPtIBERHNWEUzDCW8Y1voN+KHoCHPP5MRpTy24tS19VRmVt/GK+TGqnu1YHd5RAh/Gxnb/AWAbqMjQVRTvRwznaE6WxL1BhXWiO/KiPUCkXslOWMX/F4QD/kgt7/KcUaYXrbXpWDQ61etmJJbl5WSKUrq3aRZ6wbErfs28AvjMwQWCV5RnK+D9GEI9y6mLFisi5uHrYkXSDb4SP3S07AoayAmvZOOiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtl9tnTeGjuKVsWDNCMeWGZTyMMqC17sVyiQOdr23yQ=;
 b=iK/LsS6UKNmlKDlPiDTgqLhrNC/7RhiHrH+dOBF1TCDU+iWeJFiMQZ5qtfYU89aDKGwIQo02XGIVvRLrSZjKNgun3gldHRGT6vxzwRAHu1KwEi/vYT/VzZAcu6v3umsp/e/zOLoSsS83V/x4tN5Jq+//TwnWZPa0dneFiIwCtOg=
Received: from CH0PR03CA0424.namprd03.prod.outlook.com (2603:10b6:610:10e::21)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 17:50:27 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::82) by CH0PR03CA0424.outlook.office365.com
 (2603:10b6:610:10e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 17:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 17:50:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Feb 2025 11:50:25 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix crashes in enforce_isolation sysfs handling
 on non-supported systems
Date: Thu, 13 Feb 2025 23:20:12 +0530
Message-ID: <20250213175012.588986-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d14c3ca-10f0-4f2c-aa75-08dd4c56e657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHNuSkxvUVZFdTJ6d0RRaGRVeXR2NUxmYVlDeWZxRTk0TEc2d1RCUnZXbXpQ?=
 =?utf-8?B?dHN6ZW1BeXlvbDd6RW5ZNWFCMHlrSis1TVJhUnRqblJkcVNGWG9wL0Flenow?=
 =?utf-8?B?Vk9ESzBjY1BFR3RtWUx6ZzNPdzNJUHBGdGhscWF0TW5qU3BJaGwyNzd5K0J4?=
 =?utf-8?B?anJwNUc4eSs4S083c2tyblg1MUdDa0FUQ25kaHlYRDNWUHMrQktPZVlRcjJ5?=
 =?utf-8?B?ZThWTGQ2dmlGb21uOG8zcmlJRmdyb2dMNEg3UkJvM1NJd3pRWlNhRnNncG85?=
 =?utf-8?B?Sm05R2ZWN05oNmpwVEwxcURETWxNbEk1dE51SDZIS3FWM012UmdxQTRCNzFr?=
 =?utf-8?B?RGVvbzNSZklvRmVIYm1RTWVOcS84Rnlwc2E4dmtDdDRyVGJBZVBQaUJzL3RR?=
 =?utf-8?B?Yk41d1d6cHdlc2RqUFRnYlJtSFNBOHJkY0FXYm00ZlB6djFzRmREUEl2S0tx?=
 =?utf-8?B?UUtvQVMxQU1uMkxMc1FXYzZEVEgyWnNEeU5XTk5jditIMjVzeU5ITTNrVDVM?=
 =?utf-8?B?Y25HUm1HelNCV3duYk1LZG81U2MwcTRiK0RlOXowQ09oTmtFV0s1Q1A4dmUy?=
 =?utf-8?B?Qk5YdEkxNXJYM3FGcmdnblp1L2JTbUxXN25IRUdnamlGSFNLR21rV01zNEdr?=
 =?utf-8?B?dWpYem1yOVpIRTdyaHc2TFg2NmwxSGNRTVorT2NadjAzbmoxL28yOHpQLytn?=
 =?utf-8?B?Q1hhaXBqL3E5bml5c0dOdmZmU3hVdkZTNEY4QTFGSndHd0RBUG5rRGY4dGJy?=
 =?utf-8?B?RFJFaDlTVDhmcmhac2Q0YjBWbHM1RVlyb2Z6aEJsZHNjbzlNSDlraGpTMldj?=
 =?utf-8?B?NE9vQUQvQmdNcDdIQUtVSDNUOWwyajltc3pyT1NuRUE1cm1qUGZDVUk0MnFz?=
 =?utf-8?B?aHZqNnV1Q2lsRy9BZEJLNFhWNUw4VC9peVNtZjhsK1BGMVByNFp6Q1pjUUR3?=
 =?utf-8?B?YUt2aW10VktqTWVCZzZiTzM0MVpBaGp4WmM4aWxrUHBPMGl0ckRIKzZ3cVZ6?=
 =?utf-8?B?MHd2eE05bk15N2I0RWh6eGk0a3I2aHdlWGVnZ3R5SVRjMFc3eFRYM1pueCtS?=
 =?utf-8?B?WGpTTU9VNmRIVkp5dkVpbjhMM2x6VEthMWFkM0xUL0pxcHVQVzJVS2VxS1Q3?=
 =?utf-8?B?OU1kcElsZ2FHaGpPalJ1TlhVWDJWWFN4aWc2Y2hKNHo3c3kwU3Z1aVJUbmR5?=
 =?utf-8?B?YmRrUmRXSEZKaDR0Nk5FSlN6SS9kLzFLVUJ3VVZmRmdFSjI2UHdvR2NEem9i?=
 =?utf-8?B?Z1J5UHJJVFpicDNHczFJb1ZoakxlTFFNelBoRUhtSjcxWXlub1VPdnJEdmti?=
 =?utf-8?B?djA2WWp5Vm9RSWRUbjQ3dTZINkZWN1VlUUN5c0R6SlFLdFVFK3Q5cGFlc1BY?=
 =?utf-8?B?cGtvaTVDTHZYU01VbDViMTl5V1BjM0hndlBDdlRneGlBQXpkYk9IcmVlKzJo?=
 =?utf-8?B?Z0V4djZKenBycGFvRHNVWVYvNm9pclExSkVxamtNODZORTVCTnltc2Y3a0dE?=
 =?utf-8?B?S2ttVjM5Q2dJWVRvaGZ0T1BuTTBJcHUzRUNyQTRMaEtrSVJxNlRuTmJOaldW?=
 =?utf-8?B?cWhnWk9kVGE5c0FmM2RrZGVmQ3hldThYNk9GdnFiR0Rzb2M2Rklqd2hvRDFy?=
 =?utf-8?B?d25KUEFteWZUOXNPb2JNMjhNWW5BWHEyNktHMW5sQmhJMWc4SS9aYlFVNmg1?=
 =?utf-8?B?S3JRTTVPS2pWZXpCQ2NiWFoxOE9zWkdlV0tYZEg0bjhEcmE5MVFhbmVzcnEr?=
 =?utf-8?B?a29XNFh5dmg5VWc2MkJPbElEb0xtS0FaNGtOVTF3SENkT2pUbzNYNDNtNThK?=
 =?utf-8?B?YUN0RDd4ejJLK1pNRlRLVHh4U3B4aXlsbTBYdWM0V0ZaZ05HNzI3SGY1bGJq?=
 =?utf-8?B?REQ2dzZKSllJTDMvN2JsK29uREo1bFNvbkNNZWpiVjllOXJYZ3h6MGlna0ln?=
 =?utf-8?B?azdHWUFQWmRDd0Y3VHYyQXU1VEZZbVZraWVuNzRldkFtWmQvK1A4QnE4alBY?=
 =?utf-8?Q?8hSwG9ydU3AM05bbwSyGV4OLaXxXVc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:50:27.0788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d14c3ca-10f0-4f2c-aa75-08dd4c56e657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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

By adding these NULL pointer checks and improving error handling, we can
prevent crashes when the enforce_isolation sysfs file is accessed on
non-supported systems.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 27f5318c3a26..bf0bf6382b65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1777,20 +1777,27 @@ static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	if (!adev->gfx.enable_cleaner_shader)
+		return -EINVAL;
+
 	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
 	if (r)
 		return r;
-	if (adev->gfx.enable_cleaner_shader)
-		r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
 
-	return r;
+	r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
+	if (r)
+		return r;
+
+	return 0;
 }
 
 static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 {
+	if (!adev->gfx.enable_cleaner_shader)
+		return;
+
 	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
-	if (adev->gfx.enable_cleaner_shader)
-		device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
+	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
 }
 
 static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
-- 
2.34.1

