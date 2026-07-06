Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE0AC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D0D10EAA7;
	Mon,  6 Jul 2026 20:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wm2H26Ld";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E40910EAA7
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbOurOfWNbs1vg7x+m/nuHK18JoyfTHPeSJZ9lmVRe+OPd1/nczE82nRRWE0fw06q13WHEJy8bhHMp7wXDCgy7W+vBKLzCaYThK3n9dfKKe46LBcLj0PRDAy1rtQgg4L+lUQzuepSoRHAttDH6OV9W8u6syNKb8LNBIPEFoEs8Z8vrSs1c7tAM89J91QEIoyPZdiO6d2M2WAVFJlxFL2d345GA6cIoUHD/ptAY8wigLpNENAmdT2WoSHcVM1dboJE/Qr9h4DYtmQzyUvZe2squ0+UlMxQEQluBTHNjhqmfgmKeQ6uu+uB1edL7O3VMTtkbSd3WcllLPWNA6ISUU6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuVqPBUTSDx007V8QktnLEIh9bQmMPX9TkdDD8eLo5Y=;
 b=gQSStXKcUhUXSmAxOL9yhJFmOTw7FF3QLGuqY0anQIg+ZWIGtb3pKO1+/jSoezBLxuEc/YkeAYNkTGdhNmGoWb7Ff+H1Y7Y+Hs27jWMCp2sbYkFW3edFVd5sc1dRYsXLTjgjH+4+MyhxMdno6rHp5qBPFLOcD/vOZyD7NigkIiRmpwIYZ2eQ6A+icK00QTaqxcZ9ACaQBXoG94W4LwopLz2kPXoSw1P8bigsr+1vlPjXMmzf2hoHDJvdYM5iLZBziG2GV2a+/qMQ9SHRQ7rjAuLrJmaHSc44+ka9vI+VRY8uMIUKeXh1pzBhrtrlPX/3Hiu5YjYgZ7BVsB/y5bY4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuVqPBUTSDx007V8QktnLEIh9bQmMPX9TkdDD8eLo5Y=;
 b=Wm2H26Ld+9uX3QN4O9oqUrSNCVSCqVpnck73fMN+Jp2J4JWtSZVLHvbG0tg3xHsh1jjXrlIel2k4cDD9pcTNPmovoD/uSyfOcUrGqfPxuP/AQawxeZR8pylzjbQZMRb15jT1JRSnv+cHyr7Dgx26WfXcO5dbboW3K8BEzHPTJUc=
Received: from SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 20:06:11 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::3f) by SJ0PR05CA0088.outlook.office365.com
 (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 20:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 20:06:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 15:06:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu/gfx11: disallow gfxoff around GPU reset
Date: Mon, 6 Jul 2026 16:05:56 -0400
Message-ID: <20260706200600.15071-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706200600.15071-1-alexander.deucher@amd.com>
References: <20260706200600.15071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: afceec2d-2f3c-4a78-d198-08dedb9a05b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: roELNDjht7bvJxOkdBsoXRPYeL1fnLTZ5V2qN2YTxHu/F8lndxwQhVPzY/8Z6PyL1RbMljeExsjtaZp7OmmZnsWfoBLsmCK4w4QOOIoiVg36la3n1nH+GjAhxoMi9LNsfe55LpLRuk9zxAvUwF6bBLvyhgig8qRSuHct1utH1T5fCgWwrkA7odt9j30egRfAw5B/b/lObdwTgknViUoiihZC+xgYkOWaSokZ5uA8tOP0amMpLdtKU4V1XM940Dlxid8M51LKBovJlvifiCvy1SHgTljWIbOZcXu2Iqf9hRrN2UCsDFjILE0fJdob5pARK1JqXsknrrSU9xHgATuAibzn8VRoNrzUUPHnAE9GJ4mpmFfdnFZHQgTgibzifa6mWMZKHANoYCdhlNWaFxzgG7ZnOBOTTzCow9f7fXfUr9wtwIVzr4T7dILa6rfsXWpS+y5tZf8Vy7ISOczkcLMaPXxOyO/goMiCQ5H554Go6p/+J9gHoJp3CwJ9cHVjoQeF+ILmxTXt1+HQPxWYw8M0tszJKldP2H80pt4YgHzh+dC/PvNqiHte7cS24pDaLkfysZs+Rg6aHfbxk79KrUhG4HRxLPrISVvVcvyn6yK89bc/UNbMhl2VXiJpjEUvjyKZmaCygZPaAbxQZh0y4rxTSQrirOys7kvF7eH+OpUAeWC02hG+IDUOYEtUjqutHKV/TOmVz2th2ZJnS2n2ADQCVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 22NQcNvkxSTlB3FE8FuNGvGiwfOp29su42DzY7nBCsFqg+l16N9Y0ZFoh7gIHaTANr9mGhpC6VDFrsZX4j6GkQBMlcGbHPf8uBlXzflXPpPYUZ88EjJed6K9JTT9VmmQ0UZDrnB1tm/STzG+Nbg9Pbn+DVCD9/mhwySTTtFLeeZ74vxOeOcpkBtirqslxvFCd90WmE/XCCIeNTEzzgfUb3t+P448hNtTmoWHAd0M2suGq3T0sc2kTaaRXY5Jh1t3pp8rUj8T3bU80x03Np+6CdgI7TuAu8shSeSvVl1Jz9H8ROb9nI1VcOI1yKLKJog9omX5cdvf6h+fYFPMPqOhr+vAVc0dFu2rhEEDXyaF8ncjeJWu3jXn+quNe4+3Z0WMnJWBUwzA0bFmKNarrC+N+4ub2MmKocY+s+ONxM/sJZ3AB8uaokBBxgSIFZX8w4NW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:06:09.9545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afceec2d-2f3c-4a78-d198-08dedb9a05b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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

If gfx is hung, we shouldn't need this since gfx won't be
powered down, but we could potentially have a case where
a queue can be preempted, but due logic errors in the commands,
the fence never signals.  GFX could potentially go into
the off state.  Protect against that.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b2a3ceda99bc9..162f825cba84f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6862,8 +6862,14 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool use_mmio = adev->gfx.me.use_mmio_for_reset;
+	int r;
 
-	return amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
+	if (use_mmio)
+		amdgpu_gfx_off_ctrl(adev, false);
+	r = amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
+	if (use_mmio)
+		amdgpu_gfx_off_ctrl(adev, true);
+	return r;
 }
 
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
-- 
2.54.0

