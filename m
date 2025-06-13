Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E68C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB7E10EA7A;
	Fri, 13 Jun 2025 21:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BXM2Mj5G";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF25610EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOGXfH33OM676UPvU6XoscW6ajBYtW8mDLvT3AYdeZqrshiE4E8IlyWHYkhmlXPneg0TRc6M532UpLhV2t7iknyvVXfdmcFBw0NPdH98Z5+Mj8/7rt5hDrubUp4XfKB2+lXIHqvZZDL1G+1LjhtmlkW8IO6bIGE3ROlcnB+MeHP6vjPG7dpwvc0KgvZNdMoNW2dnOI/IDgRkV5F+GxtV8zelcSf4tSV0LtZZ39TJwaF/KY8g5o++hVFp24e4rs25m6KH03UnJa5Mt2phokb64Ypo9RHQNticn6Fw+Y/au8+S8pLYyDpeIjfXFCzvibQ6E3oOGH5khu9J9x1F2E2oTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFmHakvYUJp0JAUht1hz4LgUO6VsBH8s2ZLW7ft33bE=;
 b=qRTuJZfJPA/D+EpUlqREtSKZ6FVAcfL24AzCukLrafPbYdItfqwREexb9aubC2ChsoYytgbe7nUUznZWTPBUS632p3IA36HD6A2Io3fFFB7A0Mx4rY+VnQoVmA9xy6Uu69E1y+brb41xWeDHuhE7jGegD8jXwFqGeZ2UJLNVFMW1MeYU8Syv+K4WPSs0lu7E/CpbRsZaJnlOvU/Y5O8Vd5dwIK0u/3Gb+M5w+jLpIZhyHaXAa7sCuhEMB4UOULI13ViSlTjIiwL5zwGmvTXLhZum7b+d4auqtM4ogzsjRJLUJ1Up6ENJTGM4RSHp34IdtqOXESzpqb0x5aeLRicMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFmHakvYUJp0JAUht1hz4LgUO6VsBH8s2ZLW7ft33bE=;
 b=BXM2Mj5G84OMkhCGzOYEL0dTen4wwoUJgaL1PEfuxHgq8jmchkh1Jya+mFAGsApzJ1ZksmB1nZXoh7mr1iecKrVhKBRqpaWVvQWZlL9FmuNnvKvIcDLSMMkCPyExn8I+2E2Rmhz9obiGUKcmq4G3H3Lq5XuC/obpu+6+ykOPXoY=
Received: from CH5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:1f4::23)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 21:48:15 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::cc) by CH5PR04CA0023.outlook.office365.com
 (2603:10b6:610:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/27] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:40 -0400
Message-ID: <20250613214748.5889-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5494c6be-dbf9-47b1-4bca-08ddaac40020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0d6fzwflnXBajUUrqA7O8lrtyID40rW2Kup6AZifM4uDAUSAPp93K5PLc45V?=
 =?us-ascii?Q?/K38hUqk6LHVIcH3xVZkdIH8z/+sc2C1u1V4or+MdCa+PTTMTA9EEk6QTtZ0?=
 =?us-ascii?Q?mZcjCZH1Q8K9VFg2lqDQBjG2tQR8803NQyTfG0gk/ESaSQKOJC4QnMx1xzkH?=
 =?us-ascii?Q?fThOz9iGmZu7bndgFCpNo7iTLmprm7O8tdugLUwGezdniD3UpsYcoatEV7BO?=
 =?us-ascii?Q?Ukzi/u0uJWe6/+LFeyPnCHVupnYyaUkliULrG75QDI5p1ITUQQrMDYwNfmnh?=
 =?us-ascii?Q?//ri6aTYI0ACS7p7UqPkQidSw6IN4OC4k4wQwasS1Gh05tdIIv25M+0Hy81K?=
 =?us-ascii?Q?XAd6+yUW5zd6MxsZ6qcMk9xS/swql9WcWBt9in70pr1yoyv6YwWwrkT6qv2x?=
 =?us-ascii?Q?7V4gWtNonz286YMxqi72V68oKsWVBu/NXYZ7W2mFiWuB+TwdsHdMMeiiDUAZ?=
 =?us-ascii?Q?35d5w54PI4OyOAh7X9jBu4k1seggA8U/LvR36xA/vmIuzbMdqOMbu9SKiJ5F?=
 =?us-ascii?Q?CQjbskD5/th2APerxC/QHmyRnwD3Det1HCbJJQB08eutU/eeITkKFB41rSvY?=
 =?us-ascii?Q?nzpDx02ByHkZ51oP91/z6bwJ2SVdZvd5W9YnDuwqO1RXtR/vxDhTfRdaK/6u?=
 =?us-ascii?Q?P5vD9nenwnAxDGQDq5lmYLhjdVooYqw6yOda3gHBgAJ9LF2G4BYYhbVAHEwX?=
 =?us-ascii?Q?CzBdeQn3T83Qz5k0qjIokZVEnXB4d4IpB0F5pxJkwclThB0r01vEzAMyRTp4?=
 =?us-ascii?Q?JDKPrbuUPkNrvHZx0e6tef8WoYiAkAzhq/UumvLkdHtChvhL8Nfv4xOf+0x5?=
 =?us-ascii?Q?ivB3+vf2XtgiLSuukRJ4w9OSs0EHqVjhQW7vxY6Ui0XYaQhGZaru3f4naL+0?=
 =?us-ascii?Q?o77FTmJu7Iz1BSLG0GdQyoMFKZGS7JkRNyt3JJ8/lc7ZDr8/d+B9+q/W9arS?=
 =?us-ascii?Q?zo9np7Ox0dxlD0rW4IwCqUum1bj/geeY251TtNSYPpi8dCq0B50epZV4FD06?=
 =?us-ascii?Q?qyIJNQ0yADvUMgwvfQaUHYjumK8HZzcgwigOm0OZaSA/AZDVp9sgQLxCBbzQ?=
 =?us-ascii?Q?vL0cqJH1NjggkldZawuO0dc+I9rS8GuTcTaIb0CixdCXmDzObm2G+VQj9JVH?=
 =?us-ascii?Q?5gFjJPWsrtw46xlwuWtNRPKv4dLWny6xo5uMFdjkEwvKvMv9FsXHceO7Z2Zw?=
 =?us-ascii?Q?xV8craHxJHkfe//jx6AQgp4QNix5KzDvoMVgP6FBv749e3mRcM7wy921l+Ja?=
 =?us-ascii?Q?M5sQOFZoZ/oQh8Mye65Yb9c+xHUw+OEO2b45RHh478tEAEWVfgifkEfP3Cjw?=
 =?us-ascii?Q?Mpya9wRGEzR4ASOtxsCDV1QTZQAM0+VhqUf2SM+iC7I65ZW26LBJt9rU3u0N?=
 =?us-ascii?Q?sZMfqRHWiwq+pujDFGXOth9kUlsTDBttJoddRulTd1njpQTidK7WO46Lf8+n?=
 =?us-ascii?Q?2XZZlpdWsW4yTFEJupNVtEW0P1lZSHFh82ITVNTCMqmLkG11j/2Nvs5j13q/?=
 =?us-ascii?Q?wmIKmQGhjTBw6ZfU+F6dD7JOl/ueCTSMJkNC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:14.8334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5494c6be-dbf9-47b1-4bca-08ddaac40020
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b0f80f2a549c6..f63ac61f06e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -729,13 +729,21 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

