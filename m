Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC2CCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E181510E201;
	Wed, 29 Oct 2025 17:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cjDc3Cge";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528CE10E201
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpcY7S4gyikZa+HI43i9DZrZXEkXtEngNRCiIi1AAlK3Zo5qZ/K9R4m1eX1xno3F9SBbuexiw8S3q3GXOcTDF1/10S9hSIaHdQ+IDxSi/LeyWvpnUYz9Xx3dxIksYbEz3fsYkJ6UxElzcKT40SS3hFHlpBfvlcf0y2pXVBXc/eE6brFga3N44ORlu/48lm16KAuwolRTXu5ekmfV2ia54gFYecYPeXmcvV53LAZBxH6oU/4N68e2OcdOtpTkw8f/eFJgjTxpi2ClYZZVKVTHvqw2BzgXFZhwYhPJFbN4f+k1vqTuUwbEGnTYVrGso4r8cJ4GHpTpI0iwbYA3lOhvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4WrGpMVZHQnhUa7+KNytQ6SnftAZq0rm5WvjULYrTg=;
 b=PWG5OElZm7HHxrIyfiJV9zDLzsnhpcuhINsiWYGxOnGgpM4Li8wu0ET5dSq/aVcaIjIEaScsfw//gS+bi7bihGOu6Ofx+KoTWAgaoVxr8Q74dEhMx/swc4buuFsMETDXq8f3INuG1oe4TPTZFES2B/3W8HgECcIpSz8R4plGIqzp+7mKSJHHLTLM6b3vwWzYwKPrImbDAa+9gb9dKCCcHm0ylNxuftl78nYAUyOm9eurc4w/6u2SiACBay3sbmQji/Ew2KHLblb4Z9iyhDJjFtbcVuUIGFBXXLOjYOnk+5auOmC1EIFVLpo0wYuDl4hW//djJcBaWXYZU71DMqqGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4WrGpMVZHQnhUa7+KNytQ6SnftAZq0rm5WvjULYrTg=;
 b=cjDc3CgeYfYCzp0mW3AofTNGjYbqZ8f+ZISBta8Eyh8aYXTiQJm0cv7Ibb90p87KElvxa1Qko3FUsAJWU9uK1X+/lx0DQCOSt3gQJx6o11dS79TUPwhb6x1LcagrmD+GgMDtyPeFpsWPsP51lX+XeN4U9NpzIXECyLZ1nx+Rzp8=
Received: from MN0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::32)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:49:55 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::67) by MN0P220CA0003.outlook.office365.com
 (2603:10b6:208:52e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:49:54 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:49:53 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: fix NULL pointer issue buffer funcs
Date: Wed, 29 Oct 2025 13:49:37 -0400
Message-ID: <20251029174939.2861192-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8945e3-65ee-4acc-529d-08de17139165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6XaKpV1IdM1R5JWoDhxFqCb49W93QYBBqyoaCZQXy/Dz4vvDm1/wPm2sgewe?=
 =?us-ascii?Q?fmC0qBB/mfiUGWl4jBfe0e7Vk+oArBTifcndyF3T8JOoOSG+GSt5/B1OBFP+?=
 =?us-ascii?Q?RcQm14usSD70UciT5Xfq4MvIPtYPMZSNvyYxKaZTSIOqVhOGVvxUI9syMw/Z?=
 =?us-ascii?Q?TotNUUV9N0ovvk88jcX33TEerGcKurY7s9s+xF5MNJsBW4ckFprn6H7GmA+X?=
 =?us-ascii?Q?4UpRhMMAW/zfO4tBUh9lrMHkQD2sIwcOZnVff1zfy+SIFGkeXHuhTGFN19oE?=
 =?us-ascii?Q?T8LAPttuCOqerF6XFU9u1m9k4ZCgAGS8opN5kI60cDdyPPMBT7MRvDmub/mP?=
 =?us-ascii?Q?2EyeaeOgUvx3/lWV3Yt97OpqmMpMuQhWB89n6021U7uwk2Px6ItiplZ1LnOR?=
 =?us-ascii?Q?iVAcqsDpUExurlDFf7xw9X6rMHMvqGMoqIFjo0vcvgzgyi1fGQmbhX2fK1bD?=
 =?us-ascii?Q?BupmulT3MGgxSrdVa4qIh03zcZDdqjy3oM5h8NURXopMYCnyRxFMfh/yIlh4?=
 =?us-ascii?Q?D5gstqgAeEfm8cIWqjZ5ahEsJuCXf6czytl3Qs/1KoL/bdaKOjJxHB5ia8b1?=
 =?us-ascii?Q?5qKBc0ATvuMJHBw4FXbClc9pKYgv/mBugNAQ72uBjs2zEAL3GTr2uytDK2fJ?=
 =?us-ascii?Q?QRwUfbWDYTIlYqfewTPM9eIcAV7v5XpQ8q0WStdGgO67i/NVPhtNVxXKGlYN?=
 =?us-ascii?Q?jyx7mRwLxfES0DnA7LmrGsRL9gSgD2UITZsgrYFaEs4Qd4l6/3RHxZ9+r3OD?=
 =?us-ascii?Q?19e9DMwLKQr+4jPKzWa7Y0rrSL1ZD51B02z61YQilvMTLXKLfPwYd3kvtwql?=
 =?us-ascii?Q?GNHP0PDxxRoR6kfQ3W9CXxpBXnjFFDaD7HXMxkN7/1fXj1dGTpr6xmZn4+cY?=
 =?us-ascii?Q?GoIEC9ae9wcKjv/HsPXoLDp6q7YxnHwvNR3OU2SgIr0cup4HtiH6lNZGef+C?=
 =?us-ascii?Q?00/929LXJ3b8ODXHnVuNXDu0+FHMo57semjp9oSZGnh1R7Fy7VMGcIHIt5vl?=
 =?us-ascii?Q?K76qKwBoxfsoxNvBXyy+QlputX+0UG8NLLwYXZyt3sdKZVTLuZYyBAQ+319I?=
 =?us-ascii?Q?nPmu80tmmSnyEJ9pXMeOxcYiIR838sTpR9JIhelJI9NFjj0QqSBPa5R0FTJ9?=
 =?us-ascii?Q?2yjeV67pRHeLpHmNw2QAkK1jkLV1OMmXiEMMup7rwxdcvPep4OVID/eG2B9S?=
 =?us-ascii?Q?xR9TKE8X+/Tiks96CIOjmOXfBK97aHegojUM3o+gphCKvmNAFutPkxycsxlV?=
 =?us-ascii?Q?nCmSSZI1fuQJF/ftYT86DAC3ADHuvAqOqdb/xri6YapzgCb45i6pb+t+PuK1?=
 =?us-ascii?Q?jAbq1XbIyHKc634zJL/frtV/VFLna8t6/zcdNZ5oJsUqTa5H2AMaB7P16bX+?=
 =?us-ascii?Q?9vMupJQbRaSjIVONgwaXDIxLQdwg09rfAWf7x4ERoPER8kjra+DY/AbFeFbg?=
 =?us-ascii?Q?mC+wia8lAAtd15s85N0Ign9wuI8+kw+oO8iXA1ms26V51t4E0/aLo9IxGRVm?=
 =?us-ascii?Q?OoSD3mgzHw2RzivHI0uP7pfs8LZRajr9QEpedh+UUK1ld4jw1Jf/hUyIB6Le?=
 =?us-ascii?Q?cyDwWMmo+MQVsqMxPGU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:49:54.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8945e3-65ee-4acc-529d-08de17139165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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

From: Likun Gao <Likun.Gao@amd.com>

If SDMA block not enabled, buffer_funcs will not initialize,
fix the null pointer issue if buffer_funcs not initialized.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 962380af4ee9f..7ad8ef78abd7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3303,7 +3303,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	if (adev->mman.buffer_funcs_ring->sched.ready)
+	if (adev->mman.buffer_funcs_ring &&
+	    adev->mman.buffer_funcs_ring->sched.ready)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
 	/* Don't init kfd if whole hive need to be reset during init */
-- 
2.51.0

