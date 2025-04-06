Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A23C369A1
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 21:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C1E10E13F;
	Sun,  6 Apr 2025 21:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lr8ldh5M";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B2410E13F
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 21:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2XwqT93gUnCkFiV+e1hRUrT3zWr0k28uvetTn3GjdM1mnpixVdYsKMzHRSebQH5wnD/eaBy9AIXFcTgkffjyUC9iSlOj1wFCpyv0IIKxiMnhcUBx6Hx+bWZZavf6k0Fr4pogHnSJBBvuHxuNhz3/3u2dglMHmkGB/B6qLRH6l/O/OmuCykzaeLCs/q+zgbVhh5cZpe+fyECD7o2HyMcU+W/RPoE1ARJWrVrqU3c04IWJQUI+p2uCO5sZ1RE3mYt+t8tvcw0RQ2JwgwCCYFM2juHABRALqZ5DFJhu22r5/QAHbnR1p8xs/KK0rjX1+wPGRDCS8ShcBkWMlwxxCUqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htVL5MufsfZgUEHlGnZZJ+CeBmF50Z47fHni2P0alyY=;
 b=At5qEdboCvDrAYQV3aJFM8uIBf/gE1HPYeqSH9CtI3mTKhY49E7eyOl8Gnxg1JwIjV4ydzLSsuj5L/TvpN9sgokSQJaDvd08nPPjsryNJKam7lHs4Rg7xan4/MGG0BSbU2cHazthUxVtw0+axtiIkR48Rwt5R1YHiAoPBhMrt811j0mo2p+hnfEDerAjNde5QmvP7JWgIim3EJukdXjuBILTIX7aEDDob3utmGXr3W3+yegKxuVn76hYwXQZSDxNyZOv5h4xfkxGGQl92MovOfRxq4X017XaG1DhTQw7ukOO3ddULpUAptFTHwR+x3q61Ar7oDZiJvFJl1KUPDOpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htVL5MufsfZgUEHlGnZZJ+CeBmF50Z47fHni2P0alyY=;
 b=lr8ldh5MYqAdFZhFZdWOXPUgiLMFieftRZUO1DDaEqB2ByKcvu2ZZJSMLlKYZFd/hjkDkJVVR9vJAgqnxPbPxEMKIFKPm+Q07zzY3vjMwPCGjiWCD/sEIHcjFnoJdjXcf2+aIUGw08iIjoxHRifKap+hFIMMA2XJnFZZ95voDJA=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Sun, 6 Apr
 2025 21:37:08 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::e7) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Sun,
 6 Apr 2025 21:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Sun, 6 Apr 2025 21:37:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Apr
 2025 16:37:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: cancel gfx idle work in device suspend for s0ix
Date: Sun, 6 Apr 2025 17:36:47 -0400
Message-ID: <20250406213647.48382-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CH1PPFDAD84AB72:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd72aff-40d2-4f89-e84c-08dd75532e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wjCafG6Uku+8EnNLHWkahbcDzfuET5ZysN0skSeZ91+e6Yy/BQ6+wSoHecdB?=
 =?us-ascii?Q?rdw1w6fQFvTT3CtdxL7oqcfHhepk4hrQ8usYG2gXKEv72QUxg9KP20zbEd4W?=
 =?us-ascii?Q?kZle8i/z0u5CoT0fd1w8oeQOBpoH0MvDOJJa/qGcZZrlIC+F6/e1cI2AqwHi?=
 =?us-ascii?Q?q5CYeGJMaC62Ou36qU0wmVWDIU1y3XNN5MAW3iAD6BRg6eHEZ+7yzfvsLTBj?=
 =?us-ascii?Q?f2tMTzahTpsDL1CPGkiAgc3XG9guFL1JyefzQMANkhUUb1H+/qxN70qrWqRp?=
 =?us-ascii?Q?4xoz+hQPuzH4BXKgbJV/K3W3iXhxjRS4hsA41YAcDKJl+QXNL7en3GdhW/2c?=
 =?us-ascii?Q?rnG30Cf39Y7e66Q5ajJqZUzXw/+R2qOh9TYJ0vB5avbm0jDiEs4fPO4Kx7sR?=
 =?us-ascii?Q?Q0ukFV994iAyIuvbbG24ou9/qckikjIGfYqMO/NCbjoPiecW5vts091cLVSN?=
 =?us-ascii?Q?84/Rde7PZoT0ObcNMay/3v3+ni2+fC69eWLavg3yzMA5cLG1FirBJ286Ifjj?=
 =?us-ascii?Q?sccn5LK+mWYOcFbMTz70hKx+lLlAf9qxjbvonjfrFDdp+Nv8sfUhCJfhNRUB?=
 =?us-ascii?Q?2VvlOFTHCmw9deW8PsqjqrAw3sXFyTn4xKu5L2NJsiOzkIf6IoqyyFo8OlIY?=
 =?us-ascii?Q?dqQU+GuqNUF7rhbVpJdvPkBcrOEtGT0FN6J/VU8FN5UHbX1Eg4XD0RVR4E1Z?=
 =?us-ascii?Q?rNDdle2RZ90S0LojPNeYozw3hWo/Ri0+gTTcyhvEHq9lnFMenWKuH9zY6f7N?=
 =?us-ascii?Q?cfJnS61C3uHGBCckcT/hEVHoFPw7X6p3s8VooXaJnl047j8FA31XxMeFJO+6?=
 =?us-ascii?Q?inS/8bAmqpKt6CiujTwpQT11xOKHU5VyQXnTfhqcrl//fuYcgBjNNkVueomm?=
 =?us-ascii?Q?XfTDsegRY9R1EazU/tu3T/o3BHGbo3u717nUAKSkwgGBediDHhY4NUv0375B?=
 =?us-ascii?Q?zCgD7yhfaLWZCnlddEcANtY789R0FejYdkfjsgczWaTPpKN31KV/gMKHME3m?=
 =?us-ascii?Q?Yb5Nne0BXHP7uJNtAxl0IY4fQYLxf13edOduCckm2s2dwhjwJjdUrz4P1g0D?=
 =?us-ascii?Q?0/6eSS/2jNtveR7VL3jqz8cRK56kScPjzusLNsmnXSyIgi4VaxW1HAkxoNmW?=
 =?us-ascii?Q?KEzDOv9Ms0ZoW7irU6ghDkvzrONEw7S/NrUCADVSWrjkTwS6HaEOco7yzeIo?=
 =?us-ascii?Q?7zvuFdEXAFoW5Zue1Qpui9e2EpP+BZdPbx9QlunRweqEK0LiGLo2hEAdDx17?=
 =?us-ascii?Q?vCJJrw4GIMblYT0JlKu+hbeaxPWmLfUfZm9pJhS/EQTgTHkpQm2wk95KLt4f?=
 =?us-ascii?Q?KO6/k/9OKeWKOTWWs57EkrgG3yPO3Yv0J5wiUYUoolucu1MglVwJ7Eb/NaMO?=
 =?us-ascii?Q?dCd8aHlzHEG+HLVKx/TXo2aoHqRmjM6caQBf0tSa6oDxc+yN6/45g299kpFe?=
 =?us-ascii?Q?EfWuQXfyjsZREibPc3+gAKLiQhoIMV0gpFR8HHZvzHbKi0DCWFa3ibEeZPuO?=
 =?us-ascii?Q?S7B5eHRgKs33rYg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2025 21:37:07.2527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd72aff-40d2-4f89-e84c-08dd75532e2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDAD84AB72
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

This is normally handled in the gfx IP suspend callbacks, but
for S0ix, those are skipped because we don't want to touch
gfx.  So handle it in device suspend.

Fixes: b9467983b774 ("drm/amdgpu: add dynamic workload profile switching for gfx10")
Fixes: 963537ca2325 ("drm/amdgpu: add dynamic workload profile switching for gfx11")
Fixes: 5f95a1549555 ("drm/amdgpu: add dynamic workload profile switching for gfx12")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c2c2ca7922d5c..8a14caeb808dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3641,6 +3641,13 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			    adev, adev->ip_blocks[i].version->type))
 			continue;
 
+		/* Since we skip suspend for S0i3, we need to cancel the delayed
+		 * idle work here as the suspend callback never gets called.
+		 */
+		if (adev->in_s0ix &&
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX &&
+		    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0))
+			cancel_delayed_work_sync(&adev->gfx.idle_work);
 		/* skip suspend of gfx/mes and psp for S0ix
 		 * gfx is in gfxoff state, so on resume it will exit gfxoff just
 		 * like at runtime. PSP is also part of the always on hardware
-- 
2.49.0

