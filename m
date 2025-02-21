Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9079CC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6E410E49A;
	Fri, 21 Feb 2025 13:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KvKvbG8M";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13B410E49A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 13:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnosrwCqMOiDuSbk7Q/yf9iXCgspejXnLqW6Qk97GrxxOF2p5SYJDHUdMYhqVNrGEU/oRyI9r0VsLTxORGH+hVQWhiKtwcx7l+t+KM0JJTTTOz19gFq4A+veL0hVXhemGZX/K5Vz0n0UEkpYsIouRYooua8JYUTJ6AKIvKKWrwPgGfoQAmeC9pIIX4pfAKbwNKavieA2gn9rYG5ZzSrG8f6tbGqMsTS8MdnvT1PqMOQaY3cqHXlC7kdmdzlGjJXBtu4/7pm8FrNTeGood6FZ8SRPGfnlnEd6fA0V9zvrd5dEl5hRwtpiwG6t4dGZ+U+pCBmceQbJVMtOMvCQffgOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh2pRVDx8gxzsH8oQZ69df0hhSS6O3GejqKG8veGRRc=;
 b=WvC0ru6BpWLV4WhWn6d4xDIHaIHv5ybGLHjwXASYqMjyXdPRPHAik3J5tRPthxiMg9AIE10QVcja3rUWAR2rCiHDHCl1J86ZNCV5bKceY0DQqrmb6UPiA93ayQIsDIR2tp2mTx2lhOerpJhgVmhIgpfKhFum7/gHwY6mAdho4x0A3tXPdKxZXMdk5ZBlikZ3zrzV6GyA+b7aQArKyx7heaIbA2S9lQOXb9MLAX+xOltXPZoX2xCiwaRsAYpNYCZOQuMBMENtdRI2yllvAZ6sSdWo9iM1w8k5KdaVrbifhrp/VLIa7qcXiGakTNfCkwZp3qzLwQQsYWJsP7oJJTd8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh2pRVDx8gxzsH8oQZ69df0hhSS6O3GejqKG8veGRRc=;
 b=KvKvbG8MZVVQJr7Eq6TN85DLYWSTt6NChd9AyDLqjV7hPb9TvOmFld3Eq4gaLLHWHaKOdDdaeRnfEPPzLEg0oOy2EPTr39j1JLCNW0klQNttOGoQILaEts1f6+UxR1wLnNr1WyQ58rNTSqs8/ly5ZYniYwGcxs8veWl859cZsdA=
Received: from DS2PEPF00004560.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50e) by SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 13:18:27 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:2c:400:0:1005:0:a) by DS2PEPF00004560.outlook.office365.com
 (2603:10b6:f:fc00::50e) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.10 via Frontend Transport; Fri,
 21 Feb 2025 13:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 13:18:27 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 07:18:11 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1] drm/amdgpu: init return value in amdgpu_ttm_clear_buffer
Date: Fri, 21 Feb 2025 14:17:34 +0100
Message-ID: <20250221131734.37754-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: f164723b-a808-4db7-ec8b-08dd527a3a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OZojCBOEs8UyTRQzCEMFCwYCCbk7GOIOOzb1a5HJGUK9kF1MDQTBX7uK/wXC?=
 =?us-ascii?Q?VxmNI8PBL9WTsHQUuUMHyYBKzi75BvEMd685z7aBlFyacgAC3hWj3+oP87wp?=
 =?us-ascii?Q?g6bshvXt6bEQZbavsIUALLOLfgvdpqEqRWSInrAGBrulrs15usY+b2mTpPSv?=
 =?us-ascii?Q?nkF4UCKMi5oIbS4mAmL8QSD37HUo3wjZjZqdvEcmjkljAE6YoklRXhgADRrk?=
 =?us-ascii?Q?8yDsas/uel+ueTLvtnbm7VHZOcFvft50aMxH6jXdqG5dqFEvg3Fv8nirwJIf?=
 =?us-ascii?Q?3933kYVSOXgXTeUWz0k+omAJTPPoww1l/0Kqgsqam9ZK1W1pKIvplP4xuZ9C?=
 =?us-ascii?Q?ue14mGuqcWsPh/Y+ZI/ycaa9mzzc3w+bFDsTdwrWsrfYk7yLlfHFNLvx5ArU?=
 =?us-ascii?Q?OT0xELBi13hjBlCD1qIkNxF6Ho5bKh7zr5SPqVPtlU7y3rLcwnna79N4E/Zr?=
 =?us-ascii?Q?OrpbNHAMDYA5Ni1IEL804eorODtErN3LT8iXo+BniTBfg0eL/7wikf4eMZ3t?=
 =?us-ascii?Q?odKlZbSS5YxEvY8qJ/bZuveq7e3DP1i/pJGjBl7Rj7loKLyam+1EGE9+JF43?=
 =?us-ascii?Q?xk8vBcSHzX/yaqoNbZBAFrQ3YPVChDmxBtpX2KePsYqzWiA90JcbxHbTA9a9?=
 =?us-ascii?Q?dXuZdGt1viyDCQCteguPXQzzPdmahblYQKZbRPFGc0UCK3yZqXYj69wDTyZg?=
 =?us-ascii?Q?O3F43vqNOezpkfbujrEKpZmReKoQEn0kETZhJG9Qdp7izM7cwSw65YH5+0xW?=
 =?us-ascii?Q?deFz2eQOh1OY3nsNcz2puH8hIyYnv1WZpJu6ZNLEjkqXGCPtNgSHGLP1mn6C?=
 =?us-ascii?Q?Ae+Gi4cConazuaUxaJVB79AHeH5Ja26buZ/4QMTmUdmD+ZEN9p/jbMT0Y8O8?=
 =?us-ascii?Q?HPxj66Kw6Mfv3ZlSSC0NFdwFGdLafGprq3mNsAVv95jLkn/tekpGTzoO1elR?=
 =?us-ascii?Q?eQtZ8/bFXe3BR0Zvy1i565tdNTfohDVdAEEUaDOAYV2rnWPWmonxnt6IBXkI?=
 =?us-ascii?Q?tVnCQBdHNei5nc1hN/OfQYNFD2Vhb2Pxb8MLaYnD/IAN7vKAO5ZanskZUZED?=
 =?us-ascii?Q?uVAjpnIpnvJ0AXtQ3a+rT32cHtuliA3SDucmeXC4rFXvQYyF0izpodvhwIPp?=
 =?us-ascii?Q?kX6STSgxHsQ40YzW/xd/FnGWF+cgpomJBMK1nIN0FuAKCKQjyreVz4KkTKRl?=
 =?us-ascii?Q?TEld8iK5LXhDNttW4MZDUfFgFKE6Eb45SkZPyUJsxkkYcvNtk0E/51iO6x1+?=
 =?us-ascii?Q?nQDNgko/BptB2RJlvfUbDpjMm9rxx01cdSpka4NpB6tx/bV5OlHhLA5+8s79?=
 =?us-ascii?Q?V4CltmfSXDhIwd0FidrbQi07PWfAq5UWH/blTyf4zW7hzSM4/3LVxjhdhoqx?=
 =?us-ascii?Q?q3owDawvApt3XvXGLjS6ai/T2W8G6jmYxgmivRpK9S09FmsNMIqhGkLoin2n?=
 =?us-ascii?Q?tUh8qA/wBRfhv88u05yn1tqs2Hj2jG1Op/INJyXOPPKwry2/rboplaSNi5wK?=
 =?us-ascii?Q?Z67OzH4oSv66a8U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:18:27.4110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f164723b-a808-4db7-ec8b-08dd527a3a69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
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

Otherwise an uninitialized value can be returned if
amdgpu_res_cleared returns true for all regions.

Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a30985c8f539..e8d7c23f22c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2295,7 +2295,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct amdgpu_res_cursor cursor;
 	u64 addr;
-	int r;
+	int r = 0;
 
 	if (!adev->mman.buffer_funcs_enabled)
 		return -EINVAL;
-- 
2.43.0

