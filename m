Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907B9C982F0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8BC10E44F;
	Mon, 21 Sep 2026 20:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gkTQgHcH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6A210E91B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps2o/UeQ2QKTHwlgvSeOI2b0GnNhWbSKUhL6dALBgk7ylYqmjGXDjRNbgKyJEJJG/Ck+Ciw+1GzJZ2WQZU/aMro5+JtpiIlCLuu1JymABohhH8eBga++IFDuZZLf8aOWJlHY+lO6GYz4jyZccHO5KjhoL4gc60EHvSR+BEos0quty4bGbZggAaqJGmpvNB49j9iEphf8e63aQM36hfi6LmfEttU/QvUPDDQsM06+7VCwr0Dx7EebIlXrzjTXiAVC1sElGi6QVb3A3Kwsk5wgrWmTeXz1IVYH0yhtV5PrOJGv4mxhmOcPD1j9f02eLuoIP0xPzvfZSBCccKy2jw7jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8/PnC/CQmj+qYb6V0yzfQHiWCySsEpU4nGOiWAPvS8=;
 b=uUoMnU0ExGQY254y5cuHObfWK2FMGS75orPVyTdp7M6sBb/vjZedPv+4H1yglYcKEp1cLBsRM8RYXtNygzrVyC3oMMZQjMuHDHfYMI2P54DzRKat4ND/EM9yIdXeWYNQ0HXZZ2cLIp/lwTR9d2BHfTpbvGvwkgGfN3LPlMAxPX5k5FvBaS2//RjN4VjpA+0pQKhfWWfNv/1GF23n2fS53p/no8vYlhHyVGzaHkWdXjIHAZ6ZpqRWeaXs1f6TCqZVnEqqBYv7xITQUsUT3HBHBpm8RAyDuYl+LYYJKXwi3qzt2WwBC4Df+RV9Fwp50Jt7Gz1I1d2UoLfgifg9ypKl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8/PnC/CQmj+qYb6V0yzfQHiWCySsEpU4nGOiWAPvS8=;
 b=gkTQgHcHkuEdcPut7O2TJywNHcrh+vl9b2SM0KmFa5X525I3XMY+ylV/GybYxYv/LiEWi6mrc1DTZrTH20NSXcHKTHPnFFr6mTaOshPeeCjV8DE/O+mxoM4UzmpzSVQZVq58yr2R6eLDCBu8LVoft91mEXMeb+uKIX5cb9+VQTE=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.16; Mon, 21 Sep 2026 20:03:32 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:610:1ef:cafe::22) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:24 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:23 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 12/12] drm/amdgpu: bump KMS driver version to 3.65 for
 profiler UAPI
Date: Mon, 21 Sep 2026 16:03:13 -0400
Message-ID: <20260921200313.865829-12-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a46b2f-2441-4629-b850-08df181b6993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UzoPO1Rt1NaD7nhwj/kDtF5HAg1bNfbhiUZscT+JZ/FdnpkwACkZ+kqae4qZGSvLvlSMQ6jfw5k68a6ntKs/mUOSwt/LOw+hPeRIVGhLQEDesPLm/nQ+yA20y12rbftJg/+GsTpvoMAt2RCod5zdWAyvtMqDdGuzDrpL6vGUIEgbHtMDDyQ4YB+zWXGdrKkSoSUzanyu1RusNP37itto0WCt1JynfP6eAaCAkk6tHlmBv1u9Y9vQa1WGr6BJ2CzNd7VbXCSGt9/Av9gyt7tutVnxe5ppc2co8r7HdXoR1uzgCJZAKJClR58PrPSIg3GXULz1Yyxblr9vo1MD/hyBjbkUdf2nMsSaq1Wq5jU9rKy6VwiQphPCC157SeFpBUWSKhLY839QLvaACIonOeaKxOObeldXSL/eTYPG+N2Y0UayME75lzZCogmsfFSbR2NFuJoqPfMAT9GdMWg5U3LY0tL0DJwCrUkDegMDop9nJJa8KnYwuGt4qVeKjb+YMGyOyVemXxbN1tURB81GP878a6jKzHAwvH4P0Th01zyA43oOSuydYeyEMiCQ6Mf01dXe79TRY9CSOe9T3wz28GyaHjzFgJoCits+xfv82kx5ECXdptmfpFBnx1HDCbL6aENheQPNEzr2hDVkie7NmqS8hKMXHESLp6tMo6ac0z0j63qXnUBxzpmJK2HATo+jrGCD/U5XBF/IURxn6ew5Ft8H8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ddq1YHx7LPiAuz4gcknIiKRP7u+RA9a4NYgKl2goC28usd+zpi2uXsYA3cdevRwqvUgF2033wrFecucVEy5rJHBwBCs9Sg9DOsmif6lnuDXKb0u0Ufrijw63HVhqbQza54aF0xWKh7wycXJEKeEzn4zY/L335nIXQSQwSTe7rAUR4dc7IbsKc6kZHG/rVapEh6y5mzlLx4VpAzS/0TRxnDfbdccGU2vnqpC0XEeAj8abvXD09dDG3bH4qCRP7XBrDkv1uRmcUcHJswuDlUa63mlpwRsoLeuDs0b4+i9dg45RBy5fcs3gfrj4lrOGUmoJaNwCerKXbpLRlp5jOQhF1ALfg/GTaGPk4XI+3pryYj1loTTrW+cHiMCxRU41h47xK9YLzW083lMY4+gXf2429Se+dFF112AeeyGv70gR3Mu1lvNxCMTDxATAGrBxeNHP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:32.3939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a46b2f-2441-4629-b850-08df181b6993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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

Advertise the AMDGPU_PROFILER ioctl and profiler/SPM UAPI by bumping
KMS_DRIVER_MINOR to 65.

The bump is deferred to the end of the series, after every SPM operation
is fully implemented, so that a 3.65.0 driver reliably indicates a
working profiler/SPM interface rather than a stubbed one. This keeps the
version a dependable capability signal if the series is bisected or only
partially applied.

Register the profiler ioctl here rather than with the infrastructure
patch, so the ABI only becomes reachable once every SPM operation is
implemented.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03bbf101bf23..7607b1e1776c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -127,9 +127,10 @@
  * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
  * - 3.64.0 - Userq IP support query
+ * - 3.65.0 - Add AMDGPU_PROFILER ioctl and profiler UAPI structs
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	64
+#define KMS_DRIVER_MINOR	65
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
@@ -3112,6 +3113,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
-- 
2.34.1

