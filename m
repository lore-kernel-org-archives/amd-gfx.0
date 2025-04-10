Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAB6C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 14:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889B510E9DE;
	Thu, 10 Apr 2025 14:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HL/281ek";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414FE10E9DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 14:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2t5tR0MJfSiBR6nyInyQzBOFN27HKiH3coAgm9Grr63sdawX7W3xTQwfEZx11ssx94cj1ojTbuK1hPV/vn6nB6DJpe6vJh5vLVMgeYukpbnN3JB1NW7pRGP+h0STYHxEY+rBY/EaJrTMKBXO3Y1NsVRSDC39B2ZOOKpfuiqfD+3qmc4zi08ugz2gMJczfcNG2HwtC92hRE4EHoXKjZ8xpsESFhJqjxpw9SFhwJXQhcSbiSjyqyUVXPb+H80EA/4Yh911Hd/Ar+biaX5NkEu7tL4nmZ3pPzdybblBAtU+pK1tJ25IB58A/VgLacy2HYUgqiUiLTdJ26Ijs1Nzm9Eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzXyRQCp2cpJSPk641pVMphxN+fpO6ColP9Y8JhSYRU=;
 b=NxAq2WggHOKr+qgprf5UAdsUcfsSLfxILErG41AP+ZgyUZECwKqTdqhfdN64Q+scEj6uAHZVttQPKBGJHuW0sj1r/c2hDKePbXe6RwWCwLnWYZE3Je0pXkdyzoOGA2Om+ripuqXJlh14VrXfCTMtaBpCWty9qA20rC3wMCYCrFA9LhyhaVZ+bkBYkmjDAS1abEqyrnAQ/TA1eiT84UA7HdW1AHp8AKxXYvrzsvKnk8winKSJKVy22gYZCOXKQghldEeCcfY1Oaq/Dcjz9liP7eE+HoqPEdHUAKWIx7MsLbZUx9iTppw8RwFsGhdaj4K1j16pM7IBIG5+rv/ylO9+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzXyRQCp2cpJSPk641pVMphxN+fpO6ColP9Y8JhSYRU=;
 b=HL/281ekVFpBhKRMGbi+DTdxXl8jkOT+HuuZN4V9OjVylKOrp6sEzDxJu0SlOxqcWNTjJ4OllUIpiVwdlrGX7VFL8EdNkw9WbAmcsXt53PRLM9ISgBlAuAjOYyFAzSAdPnb0Z9lnUvP916XNoQu/X+i5nXQ2XHS6+XueXLxrOdg=
Received: from BN9PR03CA0889.namprd03.prod.outlook.com (2603:10b6:408:13c::24)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 14:58:12 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::e8) by BN9PR03CA0889.outlook.office365.com
 (2603:10b6:408:13c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 14:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 14:58:11 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 09:58:08 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <shashank.sharma@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check for usermode
 queue
Date: Thu, 10 Apr 2025 20:27:50 +0530
Message-ID: <20250410145750.51421-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3e1033-75a2-4f3a-ff6e-08dd78401d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ol/wBzaKJ5kHJf0Mne/NRr+sDJVrji22piAX1rsmNd9YdEOv89AJY01fLlyU?=
 =?us-ascii?Q?bElFq1qcaYy8NFo5Tz2PyTIHBxeQ8sgwF5KSTCLJncGJyyGQXbgUm/V5gW6f?=
 =?us-ascii?Q?CHxVEGSvoVZjCJz7zZ2fiRWzH34Vx59SskIwwNaszUhaQVkQ2UK4cBg5CxZh?=
 =?us-ascii?Q?BJkw9GO7ne5TLWMp2O5rwu+MaLpdazJfmOGRRo9FevDZLrA4aXxyDyPlV/He?=
 =?us-ascii?Q?Ah+g+OHMGWBnItWfgBY0cGlUmI8WUSUHWT/3RUUufcb7y/iMUHEYIQJUHgUv?=
 =?us-ascii?Q?MZZgSdQ3uWgehXUOCFLhIxOlQe4X333eSDAxokHaxUtzaZY/UpE4Lxb7Tx6t?=
 =?us-ascii?Q?Up611KQLf000kbpGBo3AqnQKZoPon0HNappZYL0XplLvjPLBplBi59XAAOXJ?=
 =?us-ascii?Q?ZI1/fvRGoJtf1kZTC7kABGd3OqtX1ayoZWa7kxk/OYYL/KHHytvy4Th9SA1d?=
 =?us-ascii?Q?S5A/bpdVbHbQq/HRTrpOX1m+Qnn66PRWpCrA30UIPpFp3iucWkoDUKkWPAiF?=
 =?us-ascii?Q?rof/1+ArlLDjUh28lRu6OOL3Kq5Spc7T9MpHHqCuiQ/MzGUT23wX8pIIv2GJ?=
 =?us-ascii?Q?vmu1bbXJdeoqVp5zktZFZixHYDMqzUgaO+z7NfUTB5K+Wba1j/EgdTPePgX/?=
 =?us-ascii?Q?3VGkjrSjIr39bI/RUU8cMus9EbCEMpkmBKcQe9t+9fRaZTasczNC08p1cXq5?=
 =?us-ascii?Q?wn/GCwlRb9TWdn5uqBX92TDY0SLo3IqMfzJ4uUOZ0dCq1FvEBJB+ZtVXWG25?=
 =?us-ascii?Q?RM53olhYtD/wilfeSnojepiIYqCsm4ftrRo431xlaiCPWaGxqRo6GPDTaYsi?=
 =?us-ascii?Q?fk6+z3nQr4DAhtUjau7nc8rsueOMU0zyD3pwr9SfoebbeMvScOfHFJQR59dx?=
 =?us-ascii?Q?tHgQF5JOVPHcxHqgfZU/cnvWlW8VaSQ/rvmaZNnspF5WTeXx4t3mVs2+dLU9?=
 =?us-ascii?Q?B3JJmwXrNlV34gCTjyNs035Ex6Hu1MhPmF5C6XlCCO6y2i4EnzNGZ4Pof4Us?=
 =?us-ascii?Q?6v6xVlwEuknYSfyqmBP8mNH7lwlXryvO/MY+kLZf0b7ZMUoRJttxbzjjPDuR?=
 =?us-ascii?Q?DUV7ljBYkKPqtUSso6N8rH3RWllR7FbceRqBUXKzmjJjVj2ySoKNQjy5jneY?=
 =?us-ascii?Q?luOEAoqieHw6oWw5uRUQMljw+7b7X4M6e4wew9EKX/UvmmFqHOFVl0ba6RmN?=
 =?us-ascii?Q?IP1EsxQn9xPWurEfW9hQOtBOb3gqvTMye9tTrknTE5FqX6fxtKDX2clfjmRj?=
 =?us-ascii?Q?YgiU5E8QKw7fzU68QVUQGSW28ambOdNklFMqE4Bj0puw4IiF7/wX1JqiYzzd?=
 =?us-ascii?Q?wC6nQVn7FsUFR4AE/kY3tAqRXspHtxuj+LEynQcqWhDi6CKKZqOaBjHKdTCb?=
 =?us-ascii?Q?7m+FXFD0kwXnSKGPifr68kmeP1ygLcxFEprjS7aqRw9PBLxfPS5+T80kuW91?=
 =?us-ascii?Q?RPqZLtja3Nka8PLq27gXYzkCIYiaJiWgTqvXTSsSiJrKsBCDKmkos1SPjN+P?=
 =?us-ascii?Q?cEdtZCsqToJMtfA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:58:11.7886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3e1033-75a2-4f3a-ff6e-08dd78401d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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

This patch is load usermode queue based on FW support for gfx12.
CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC = 3050, MES = 123]

v2: Addressed review comments from Alex
   - Just check the firmware versions directly.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3d87e445270e..3165fdfeca6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1418,7 +1418,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 0, 1):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (adev->gfx.me_fw_version  >= 2780 &&
+		    adev->gfx.pfp_fw_version >= 2840 &&
+		    adev->gfx.mec_fw_version >= 3050 &&
+		    adev->mes.fw_version[0] >= 123) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-- 
2.34.1

