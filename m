Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F360AE77186
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6ED10E9D4;
	Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pW4rCwDy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D210610E9F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEKJ+UQHQsFwZdBTtoQCCuIfW4WyLr8MS8Vic6pIR08PhFsxSEyDtIuOUfbhVnF/hGDiYO+l0dcXIHOFngN0YZPPPrPRJdezrhwngtX8ubxYrx82hffgPsakaHM4z8At7EChA+r0941ImZCQ1/Bq10IAjvVTL5vqajyacw+JcnkcaiMDfMReyPhFL4e09hI1Il6kQN5Wb1HhnLyiVl8w4WVVKA3okoQD0nqp6u53vGpRCGKtHrVkJtwyDvgwVS9yWF2X47w++lgwvy0uEWSRcmmoH54bLu/Wcpl35oaae3HwD8CmRZBnE5rnUOZ2rU17g36XpQ5OaWQnSPUi6uBMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2XMt1i4z6UlPcAZa5c6zLIqaiZbEirFA2VlAhZdLOs=;
 b=lnQZ7RxCkyzknMLIFGo4YOMwdYba9nAIzj5+zDa45V9w+BftcSlnH0axTMoSqwx+hoxgJ17IdqievEj8U5io7LY6F0egEAOLP6TdBJTFGFc1KbzX9w/HYu64yTAG/41OjcAVvYAYnokfm/Mtvh4cAXeroKkXVNBCotsWdvHNpUUBSwwTh/RJM2MhY6wJLkJy5Eb5Wy87ln7pEJdwHMZHuylEZ5jmvI5ntcltZva/qFAsTgYP44K39feQtG0HnxrSCKN8hgx/sYhZYQXHsUHWkT3hn4/Zg8XDwtQRRlDiIuvPJuCidAj3UXnfo1heQrhZWcWTDmU7UCnSebNlPg05Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2XMt1i4z6UlPcAZa5c6zLIqaiZbEirFA2VlAhZdLOs=;
 b=pW4rCwDyIqUeMuJoka4DWhvzYo+LmuwZ3TDoQnW5RCvwDDUMJUBCDtBizzEHvIRGgoSbK3CBRiWX81R8Ur3tvTBzTmQq7pttux1X6hfOCfDHI3zrX4mRhCFkCGVYthtWvBJ/OFqlcldgwocPbNk/lcVyhUErasKxLE3sKs2TfiE=
Received: from MN2PR01CA0016.prod.exchangelabs.com (2603:10b6:208:10c::29) by
 MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 22:54:19 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::68) by MN2PR01CA0016.outlook.office365.com
 (2603:10b6:208:10c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 22:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 46/48] drm/amdgpu: use new helper to get num instances for UVD
Date: Tue, 10 Dec 2024 17:53:35 -0500
Message-ID: <20241210225337.75394-47-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 45eb50c7-9511-4515-9887-08dd196d94c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sI0KQB1Uq2fAzjwZK6mFkLKSiY7p+PLay5s454fqlPnp+5KQczzzElckH/Ur?=
 =?us-ascii?Q?HpEyHW0NsB9rYLe/8Ro4ekuV/ILjhry6u/3eXW0H9AL5KWC3ry3/6NYhdSl7?=
 =?us-ascii?Q?XAjahJZYsoUXXgNTf8T1NyRs8kTdTj1EeRF2h9YDXt1a60qvBAV0kFr+b3GN?=
 =?us-ascii?Q?UdY3Ual9Js9OojPaElsjg0qUekMvmaki15cMWtGVfl5HZpzYbA47r+aDtkb+?=
 =?us-ascii?Q?wDLQgh6YAchKymRMOxUc2Er5vkNnTPU+/UVL0k2Yul9myCraFirwfGsTWjbI?=
 =?us-ascii?Q?unFVcLCBtQRcUWQ7GYzr7AO/7NtbXPI61mCB7hZj8WQBxXL4IbfHVNnJ5lL6?=
 =?us-ascii?Q?Q2370C1Q0rQ3svz6p7rf/1kNBZ3rUOqjYe1d3a+JnDkJjgk8yOQ3E8f7vT3V?=
 =?us-ascii?Q?ILJ4ciOidMFli+PGY1m78ZRcwkSThqOEiDmvwGbxPNh7X83Jjzdhzw4zSa6x?=
 =?us-ascii?Q?VJk+UQkxcNC2jT3y/LbrwD/KatJ4axJ2zkVNp37pO3+tmLH3M+weK9DiK8AX?=
 =?us-ascii?Q?YRu97tj1l4MJ85H6KrQcvCUYGGuORGqx7jeTowhszQIA7mEEFtu6igxVpYk4?=
 =?us-ascii?Q?/TRE9O0Nul8ALiFcJPo6h836zz5SSwEQOx7Whs6mgLsiFt3MHHZR1sizWZB4?=
 =?us-ascii?Q?8l1SOsDAUNHOTyN7dP4wHHoaUsmHqgfXcMVMWrOhOrPGs2KvVLVb7J3Lr58m?=
 =?us-ascii?Q?JNZYcu0pAoQIGWmGmdj/lyT+V/w2oEs/+ngHfr0d//0Ws2g/s3eQv8KKCei3?=
 =?us-ascii?Q?jsQKtNYAzFvomvtCjz8ARGzKEwm4boFN54DqKiTMLqTpTXyc51tXRiRQgkSK?=
 =?us-ascii?Q?5oBGe8xiVh9BqSzQetPUOetN0HqxSaKFHAzLt3lO/5Ss2YbIZvMRTDzW7jK0?=
 =?us-ascii?Q?L/FRgudFmMBfEqMyeqzkx+Upp19gd7uKulj9jiqTs5AH8ess2BztajSLKv04?=
 =?us-ascii?Q?iorF7wAo9xO5JSbmZP9HgV9UttHtPGpWIGBhvy7l/mdakc5o/GJYRssOMdJN?=
 =?us-ascii?Q?vr4yaRQ1p7EGoiuLUATiOQSHbG1AiBHgqITGBRzNtOzkYfgqJpHjc6rkU9uY?=
 =?us-ascii?Q?wWwvywhOUh5OXsvVMCQzMHj8a7JheWliNhj1JOIshFxRgzKRAttdw7vGZQHZ?=
 =?us-ascii?Q?dxSrpmn4iA99SRjxmN/iPnLG5amofDVcyc+D+sPWGwyaF1CdneVaj/jxlxga?=
 =?us-ascii?Q?BtSy+QmBHsSxO1RTzptg/2tf/naxjOYeXCKjzrQVP/su9X5/ADqv+NK+5oez?=
 =?us-ascii?Q?hsipFov5n8D9NbDQIC5GeasbFh7MZSsyzJDnN9Ac/PnfEvmlnKJXMsWx/LcJ?=
 =?us-ascii?Q?mgN63ptEuZc4VGpKhzgKpNvtr/6If4DJHrF4Mw9k4BXoENOFzZo91XcPgsCq?=
 =?us-ascii?Q?Oy+VFzQGjfNwWgLZESq1DcsbNbJL7OD5/oMQXNDGJJbOSWiv0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:19.3764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45eb50c7-9511-4515-9887-08dd196d94c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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

Use the helper for all non-UVD code which queries the number
of UVD instances.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e1e0f80b23606..4f6f617066955 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -432,7 +432,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_HW_IP_UVD:
 		type = AMD_IP_BLOCK_TYPE_UVD;
-		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
+		num_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_UVD);
+		for (i = 0; i < num_inst; i++) {
 			if (adev->uvd.harvest_config & (1 << i))
 				continue;
 
@@ -452,7 +453,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_HW_IP_UVD_ENC:
 		type = AMD_IP_BLOCK_TYPE_UVD;
-		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
+		num_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_UVD);
+		for (i = 0; i < num_inst; i++) {
 			if (adev->uvd.harvest_config & (1 << i))
 				continue;
 
@@ -692,7 +694,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			count = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 			break;
 		case AMD_IP_BLOCK_TYPE_UVD:
-			count = adev->uvd.num_uvd_inst;
+			count = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_UVD);
 			break;
 		/* For all other IP block types not listed in the switch statement
 		 * the ip status is valid here and the instance count is one.
-- 
2.47.1

