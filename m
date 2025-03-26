Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB2DC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 13:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E40D10E6D1;
	Wed, 26 Mar 2025 13:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ePoZ8hez";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCFD10E6D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 13:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgFp7QA9Am7LkaJ7POMGmgurRtU7nQCWWLvdYE2hlQSgAnAw+ANn099j+DlbLAuHRT0g5eQfGfVA4V5WuzW5jOSM91DZCS7AO73Bkjp2nGkUM29pfGidrDsbiIuS00TVPnelS85kcqGey3DlOl/VBHdupgtgA9nmIPje+8ptiLh3doD9Zfe6b4cIKMz+nQxKWmS521ERiC3x5X9zQNnhl1v1kGjEQvZeqGOS9+U63t/cwK4xH8xmjroKbq5/AURU1OT3XZ2+4Pcy5J/s9ySDNAaobYZBPpXHIW8TCdPdiwUv9K3nb+d8hAauE1AFrmgaYPwZWgyuFYvES00JuzSSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUv8DXdYGagFWw887tymRCcCdtm6jo/jhTQ2BDKXDkg=;
 b=ENpcixa1u7+NfHea2BuKsHptFZfZOKvzsiGRdRQqSBxEKGeBMLRt9iJg7iIAcPYEHpl6s0YuHakKMBV9gLz2Nr1QpmTQs5yDKhivYeweRCxBrzVtLdzyCUifwYgAGejLPZB2KIqsvRh6JjXNK/SCFV6SXOMKy3sShOwnTQ7x0fpz4SA3/jkmSDPk0mLo8ElmQvWQJ6O4jxG00gEz8GmL7ymvltWB5bkuwjt93NxDdNmlJtlsp1MYjffBCOGkn0wPLXDwIV2Zqi9ZQqKIyKfY4hMZvsbusAn8/LYKRaUB0+lHPhETE2CR/5fuY6czRugc9RgjwwOn34LKYyyC5KEv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUv8DXdYGagFWw887tymRCcCdtm6jo/jhTQ2BDKXDkg=;
 b=ePoZ8hezy6SALOYr+miM+ayd9/jOsIxZf9sHJN5mVEPYO9aZFK2InjuamVYQG99rcm0HnE3lmPcH4LbebzwvCaFbUzEti5BxjBvlWVIdNQiemT6+xJMErf/Rl0d+fZgiSP7tqgo/F3m2cR+Q3WAyep7oPdlAfJBuOXjKGW+MaXk=
Received: from CH2PR12CA0023.namprd12.prod.outlook.com (2603:10b6:610:57::33)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 13:43:15 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::c4) by CH2PR12CA0023.outlook.office365.com
 (2603:10b6:610:57::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 13:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 13:43:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 08:43:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: fix num_mec
Date: Wed, 26 Mar 2025 09:43:01 -0400
Message-ID: <20250326134301.1012270-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326134301.1012270-1-alexander.deucher@amd.com>
References: <20250326134301.1012270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: e45cacd6-f6b0-416d-0b11-08dd6c6c290d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wEJvbxw4qPY5ea0ETrnE7i2YJz7I6DI+KiTFw0xmPqciaStGPKSV34KsIYiR?=
 =?us-ascii?Q?MSk9hNHvuYp4kUQ5uSPj/TeMCJPCUIUpMLiX23sE0woSTmKBi5S6VSPaYSN3?=
 =?us-ascii?Q?/CUCVahN9oQwkeaK3dw71dCJGJRP+BfcEjGlsZV520xZpnaJMj/nyL2MT17B?=
 =?us-ascii?Q?CTubssh8ZN7DfhZGhuHCxbImRpAxhXkB2YupF3mW4LYkwOgKGATEhIYCgRhB?=
 =?us-ascii?Q?0+I8PiUhB+sT96Py4NPA/SAu4+Iz2/3XIxcS1XFU+RqjPz5xc0T2Fsmlsqi0?=
 =?us-ascii?Q?0dijtR7pBZkBQDxgwKRsaDKMz0WvojfiSyVOaGTEy6wdYF061VAESY+m/gI1?=
 =?us-ascii?Q?Qgml4fF348sz/Z2aj/JhbA56PrNj8wyIH4mWKim6H2rhK0bDmRr4kYzqcD+M?=
 =?us-ascii?Q?+VI/pir8o8VNwhM1rd+xs280QRLVLR8y6MxFqVO4n9CQ8G7z35T9mOV+99nB?=
 =?us-ascii?Q?tHTREJOJjucvOiF9nhjUWblmv+zOb/Pgvk4IURoXiprpMTeHvQ0SFeX3qbB/?=
 =?us-ascii?Q?L5+k5Awz4YyW+CCN53MMQYfANJc+ygB6oceEs78V9lS8HacMMtcZY+WJJRgS?=
 =?us-ascii?Q?gfVl9W3bT2aiCqqetRmuTTCr2WQyNIXqcPnIFbulWMtBeXyY08r6GecPgtCP?=
 =?us-ascii?Q?r/gno+KuxJRobTprPi649y9onqgehAyaZa935+FT0P2f1Mss2E/lkRA8PtdA?=
 =?us-ascii?Q?ecg8Pgf+dZ4wYSr6rKUKI5b3uva1XAxVOLhWXXHbLS9VdIExClKfae6/V6Xi?=
 =?us-ascii?Q?jXqLF/L6pToxHmRvfmE2jHcppM6p0p94/qlmeeUIZ8uVKEA3O+0PWG+tAoj0?=
 =?us-ascii?Q?5LpCtVQ6R0ObYb1U2jJ/gXMopzqEfOroWox2jntjkM2xKoe+xfaG4ZyUprTX?=
 =?us-ascii?Q?yHBejRb+iuoTudyLtKemTRq4bl4QUiSvB+anuTukTpoP/TkrZerl+hvw2FOo?=
 =?us-ascii?Q?TuP9x3FN723QlAtTOLkfySLxR1i8RGn+lTY4NZSC9ihdWaVs4CUTglAcoDou?=
 =?us-ascii?Q?0y/HmvOFGgZ0NY7T1+yls4sohmqRJAoj9M0vm8eaTUAA9Ft929SO/tPFnePk?=
 =?us-ascii?Q?oXq/LyIteSTREKcYyLV9uVvCIUTrv+WfWdTK2PYAsDKvpNY9X0nPLN7jAiKP?=
 =?us-ascii?Q?dkcc5uGRsl8uq4xAFYzm5e4GD11uw3/zxIeF8NiQyICK4u0IErnMMt4N2gOD?=
 =?us-ascii?Q?m2nVJDHGsuB9BBfsMc11Zf23WMiGeF2agfj3/eXiZv/aqL4GeZPKLuU75NuH?=
 =?us-ascii?Q?XFpabihp8VLmGwTVitK7+5UYLqMfmesbeu6MxHoahxQAH7ordR5tcPJt3Oyv?=
 =?us-ascii?Q?Fhnv4dtvIDHMJz/IPHrk4j/yNhq4zsfIb0Y3L/kEbrI8wT3LybGbRyK19gbZ?=
 =?us-ascii?Q?J8WNGwtDggtTmJHt90DtH0/a6KWitYnTCFrADhWiaRdNQm67ccxN41T4xs7d?=
 =?us-ascii?Q?6d5uhbIOyJm+FMncEh1Cr3g4J5DUIC+E1h7Uv2NCE9VRqRilg+KDCx2rBHvH?=
 =?us-ascii?Q?Y6mR0+7PsH9RL7PE2Il6wmGkXVo62XJstp1Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:43:15.6685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45cacd6-f6b0-416d-0b11-08dd6c6c290d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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

GC12 only has 1 mec.

Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 85dc6d8f0571c..8ad52d6845f11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1369,7 +1369,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-- 
2.49.0

