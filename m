Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2840C28B30
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 08:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B8310E533;
	Tue, 11 Mar 2025 08:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="thJsIXPf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BE610E535
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 08:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcmrdxOzbX/sDKysNyceOJeuMdO+K69H/EyVKBqaxLJm3mB/C3UDbQXTE2CV4RkwAxGq5aCBgmfX+fGy6ltGq9qxGANF5EiX86XudkBYnkr1/y69BDKyLz/4PukLQGCWYDrNogjJN4QTPmehp7h/iBRtx1tfD+Eb+6NOGDytQZdSsIlzMo4M3QzzKOGnoAIRwfdkXCaI4hcEe/pwS9AXv+w4cCeZCVKtczLF9g5E3FI3xg55a9i/64lbkYWE7YsNolv0DdPsheEDf/YUqKf+WENWELgURNDpLJ/c5DyHVrlKcNNLlLu6W4yz3NlmlhfwuTQKIhbwDHIrYjthX/5mYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22MnXMvGRfkXiDbfdfntAR5l2VfVHqkCPik4UPZXdlE=;
 b=b/1W4LnXowaUpGbIlGvuJf9Rdjyc6LA42rLQQiezxQcnH7jol5/rTJMpIvjTeo+SjfolwmIU3LgKiZW5dkxMU28umAXwCpSWUBs744QBuoBfxqZgC6/LN88WX/iJWZxeIiD7+kqIJ9bfRS7hYmi2JQVAsFzen92YWuSf9DL3I3Fj5LinXJbQ7nK3RyxxVbhCBGi9JtdWPLg3GS5CVpjaxlqDHTn2AqnipUzaQCjKOgLfifhMEGzELnnqBtDHY1RNq4OCQ2FUa7djKE8IJVBBt8RHrcpnvbJleROhJ5DTb/7bmQkfG8T0FHNfnfs/6CL+WtiB5AJFi9gLOFvLBEUCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22MnXMvGRfkXiDbfdfntAR5l2VfVHqkCPik4UPZXdlE=;
 b=thJsIXPf3HJnp+uiUGPjM2cTjeoMrpwtc1PxL87c9ynL2QNWth+WJ6Vu7TMJnUn0AU9rxx5mOmy97uuMyJokEH2ybo5YJtLM4DBLy5LyVj5HcXMGAXBAg73Hx4XVfkBulq9f79SXugSVqOHR9R8iVv1QWdRfgN2Mfr5ImEVzw80=
Received: from BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:54:41 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::d3) by BYAPR02CA0045.outlook.office365.com
 (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 08:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 08:54:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 03:54:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 03:54:40 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 11 Mar 2025 03:54:38 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: shorten the gfx idle worker timeout
Date: Tue, 11 Mar 2025 16:54:35 +0800
Message-ID: <20250311085436.628620-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8926f7-3754-418d-0700-08dd607a5cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dlkvEoYl26QZv9mpW31JhlI1dJXaEyQXdBhLSDfmbF9QGQ7HvYE/978j66De?=
 =?us-ascii?Q?jL9E80cYhSNdM6wxZl3Fs9wtWa6Rlb7gceQydglJM4gz6CEfbjoQhcT4UkVU?=
 =?us-ascii?Q?IklkGVyG4pKyx09yZZpZsP2sopI/GGfono8Eet48htye83t8PIEmLfvVvEKu?=
 =?us-ascii?Q?5uyDhDgNJ2Hf0nAErcWE7VCA2PdoF6zoKwJoRmOviL2pYsY8PjYiK4+/lQ+N?=
 =?us-ascii?Q?/AuOwwYMwsAc0bLB/gFdZIKNqWzLw5DXRk1Is5K8g4lRRDQ2VbEjB06fJ4qr?=
 =?us-ascii?Q?fjCj3EyfxuONNzseeAKDGfTc6FHU9E98vtr8q0rbKuPUUYJ0EixEPiHPbDaJ?=
 =?us-ascii?Q?MqPOPTMXXcXGP8oC+tMculxZEIXAD6HPi4JrtEBqt6v0e7VH9aFs+Ywuqjfn?=
 =?us-ascii?Q?okrKUTcMSkwSXCGPnABka0mJo/nfxN6eTI1FUf18BCghUCY/QeJ8BDKaOOza?=
 =?us-ascii?Q?bu9zWOE8zpuk+otaIk5OChUxSpc8NvR81GDVG/gsadZBSDT2p+jOZfA/j+o8?=
 =?us-ascii?Q?6rC/DeUdHfuAUsswnKAt0a9hAE6jtAERJ832//y7rYi14g3rFvTY1U2YQ4/4?=
 =?us-ascii?Q?BVW+DrDdVsu4tbz80F+xf5Yp4GMOyiV5XnC7AtUJSYZzipqTWLQguDz+6qyb?=
 =?us-ascii?Q?nB0OkET3mzN2oOEKJ6+zoRaGn9hp8rnJjmuwH4ASz2TEJk5v/GbqcIXSF5Wi?=
 =?us-ascii?Q?FNeIrtJc/nzYTP1vdpsThY87NbdO1x24Q3pMO0s27+UTBBxoF6xMTUHoOKuq?=
 =?us-ascii?Q?8h+ofcKDmndpAl6niydV1UaoneOV/SZ5W39rG3F4wYN8cCWMCwrGIDE9r242?=
 =?us-ascii?Q?FIFT93tj2z2SX7QxUEOYI2phSGvrHvEs+1T9z4sctNglw3nmTk6d8xrlu2yj?=
 =?us-ascii?Q?QVBI+LdYt9cGavUm2mdx2qJgGc8uuOfEnlgwLMpx9SJy+XHDsRGZJukYPi5I?=
 =?us-ascii?Q?i4AZ2RF0cqEVpQu6I45LYIihjwwRbA4nb8prd+JhSzOT+ewxln1I508iwfVz?=
 =?us-ascii?Q?+gHEHu+e1NlfgTxT7WCav+vBEIJXhNsK7532I0rNkil8LnmbrLtO4U15RWeS?=
 =?us-ascii?Q?VCKMql5cN2oGPMCnq01xcwtR+NGF8b4+UxqrbSKtubi6XUyaiAu7I5eYUV8s?=
 =?us-ascii?Q?EfWCQ3DBCrJO7yjixXy48zvC61bRZigjOJCtAA2mi99c1Lz0+yjiI7lZwtUo?=
 =?us-ascii?Q?VUJIHx1xXBYAPCz1hzCI2Sr9hJnO9x2mSEvJL1prA7TAOqLNmOBtZPV7lXV4?=
 =?us-ascii?Q?WLniniExeSdf4cdviEPoK8RNSGjlo3YIWJ36Vcip7mcvJOWohBWx/M99cKuM?=
 =?us-ascii?Q?CV382hqxyPbp7Q8cYpneNcsYlZwvxQtQsW06G1EY7KUN6Jm6aANO5fUVa/k4?=
 =?us-ascii?Q?ibtRHhz2nAwf38tI9A6R1anri83cKB5I8S6C2onvs71nuCKc5Jdrql5kL2rI?=
 =?us-ascii?Q?ke/LstGYoBW7psmacr8ATZkWce3kfcAUjgCFo5gf4galq0mYRiEB/R2MZisM?=
 =?us-ascii?Q?tNdS5UwsTUYYFso=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:54:41.4828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8926f7-3754-418d-0700-08dd607a5cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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

Shorten the gfx idle worker timeout. This is to sync with
DAL when there is no activity on the screen. Original 1
second can not sync with DAL, so DAL can not apply MALL
when the workload type is not bootup default.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ddf4533614ba..b7b40edf4a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -58,7 +58,7 @@ enum amdgpu_gfx_pipe_priority {
 #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
 
 /* 1 second timeout */
-#define GFX_PROFILE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
+#define GFX_PROFILE_IDLE_TIMEOUT	msecs_to_jiffies(10)
 
 enum amdgpu_gfx_partition {
 	AMDGPU_SPX_PARTITION_MODE = 0,
-- 
2.34.1

