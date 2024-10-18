Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0997D3E180
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 19:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7159510E386;
	Fri, 18 Oct 2024 19:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FhrPw0N0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DB610E386
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 19:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ManxNn0LsULPj3KYbANG7jCbH3Ds7ZDlDxV6X/Fxw0k0rZBPr6BSpoKuDSaWSTjDbCLO9PdltlHoldEbcMXoKkbuN1uECFN984EC2lzl54aIrqFgo5VjFit9T4n9qn2ihyDrDR7Ohkm/7eKaZCVpbWjNIgVsZlU/ztquPjPFHdMiRHrf6YBJkfiEjjWVeiiAszw0F99XfaPsa3rCFj/w0xxo/FmzMFEjUVCDrtJOHAZkP90XKR1uFR3JEDfwfa3v8AZUDBJkxnjDheOzxCWdKMneyrVDYQHZvO3EfId3RQ69Vf5Qeon1Fo8orMfU1lVGQStMz2U0NDx+Ac6iblFHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYZlGs19Y1HkGN7tPTCh++l6K141xGQQ7qwOEymm6Lw=;
 b=IgaXsH6UUvNFQbpuKdwa+7QfKsV4QLa0g9gm/8tGZJus5KVztDPLYATqR4elHu9/qYdPeRza9aBkCb/vaOgmFSvNHwkdhaCsv7CQQdxcsFeeZZ+phtnWq5kKb3wxRjT5ZEkqrW1VbRkBQHsH8Gmj3rui53qTO5T9SVchDoeYrTbF/7DknOTk9Vfi5AiI5DIJX9IOOjGPbwItz1XIYUouHTlCl9RUdJRGcijHkIpFdLub0Nt5hEFwwb/se3WvD1vAOElOqXYnIeppCn+VRMZ+jb1ey6r5qGzKrs78qvv6BZHuWfah+YtFO+HINqdPwe79gx5IW0DbaySrrH9ZuxYjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYZlGs19Y1HkGN7tPTCh++l6K141xGQQ7qwOEymm6Lw=;
 b=FhrPw0N0oUpRemf5ITgnm88SOthLkW5gAO2Oyli8d7Z2uvJuWOtWGoqRaHXiR7k5UhBand+bGj9Tpd7lqm4ZSCsGwDcIDu7lHstbyZ3PJYrgM9zuweVeYLCf/uMCGJPHaT4tg3bYjU1Y2dL4Wp4gD7VusLVawRl3i2Sulh8rvzg=
Received: from SN7PR04CA0099.namprd04.prod.outlook.com (2603:10b6:806:122::14)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 19:20:47 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::1a) by SN7PR04CA0099.outlook.office365.com
 (2603:10b6:806:122::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 19:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 19:20:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 14:20:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
Date: Fri, 18 Oct 2024 15:20:27 -0400
Message-ID: <20241018192027.622300-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: ef21008f-ff83-4c7e-495d-08dcefa9f7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yA1IJkeBumpN+r9hqx0uTIVwg9t4wVD8yPkOxeJfty5HTC3bgxUdWAiah0QS?=
 =?us-ascii?Q?nuQAbtO81c1iXN8X73zjxF3CgEvDVERGJcNkCoa3hqdjR38DhpV6IRB4vxZc?=
 =?us-ascii?Q?HgYob6m9SPiGYeE9CpX92B1L+Nm91GlX45V6lhwQBzeZNSZEyHc1Vq/b/w1K?=
 =?us-ascii?Q?dOOUPrGVFsDT2w4p7NFG9BfA1axNfice3l2kI5NspRoWlf+5Fon5sHjmsr0N?=
 =?us-ascii?Q?kXfMPU7rN6G2+afFHfAPoLqyLB4DwhRRZ6Z79mBHitzXyIBQKBHgJIkrdCFV?=
 =?us-ascii?Q?num1HZQc4HaiQVzb8I4g9zIFUAd33SgpuH1A69qC+b9/hvI6jgzYxfM7zSTI?=
 =?us-ascii?Q?cwXepJWHr0bKyDqrvTpSNcM4sS0yvEnerH8TVb4X9F83pL0zED7HmmO17DU1?=
 =?us-ascii?Q?mOaKpt3hsiGHbc+EZobBIXX8IlIEFYjUz/NHt8tURZQIhv7+CTva8PcioVQt?=
 =?us-ascii?Q?iVK36ZJSChGy63cUFbm5cxEW0jkib/IBgsC5pZ/BcKD9yv32+P52RSf7O9Z3?=
 =?us-ascii?Q?fISDAFayroKBCEH9GKdOxI8SlM8ufb9Gst0Ek52wWooLERCp5hE5Ulu33Lhw?=
 =?us-ascii?Q?hIlxsWnG2NkhQua5eTB55QHWrcCL3Of3L4U+ej6LACD/3Z9kddeudn2mh1mP?=
 =?us-ascii?Q?lzknyWOvkxphvyec2FxWEksQ/4rNIHhKp8sB7dpXmxgYbaZOoG/Fp2Q41/DP?=
 =?us-ascii?Q?2rHR5NM3X3BNPwsKVZWfS47xjqyT89NVABImF7VveCsJAsGnI4eiO65cA0Lw?=
 =?us-ascii?Q?joPyGImTbjzzLI4DCEtF5ja3nAWQN/1rOuw9CbjFCeZHjyV3v9M4QhviKsDh?=
 =?us-ascii?Q?1I4IqOtslnHgLlDKz2a8nAeZAItvjVzpezjRbdBNEpc6Do6XNK7G80Bg6svV?=
 =?us-ascii?Q?OtSzHXDpTTj9cam1SIwsIfG9lfoky7EyfEHV4oJev4nu9OwfiTnvuGJtp7Ai?=
 =?us-ascii?Q?+V8gUb05KGDleaBcTnV5C8c8T5QBV/1LYMUIs1CI12ll/3DpwILmGHJOWvXF?=
 =?us-ascii?Q?2eljfCntuX7shMtlMHFFxQ1466lpb+WsfAqiHbtec9RtjJ7CYiaYUJa637s0?=
 =?us-ascii?Q?RRcfCqCU/wCrUPY4hMqMskBFiwZGJ20sqa+I+3SMH1cL2tuJ4joXHXuJFUXG?=
 =?us-ascii?Q?iJNWOTwfQQSsiNUFxH39di5CvNl9mLSKNa27GXw+kB4Xl8xdvvo9H5JAe5Q0?=
 =?us-ascii?Q?o3Ut+5aVEJhuBfJgd/oOtbNKnkB1uDVcI1sIFXxtbSF0dAdWAORW0y5E+gqR?=
 =?us-ascii?Q?/6YiunbTOEgyqRUcVWcrEM9h1dMV1ZCXQeuXwH49+2sNKZKYj3pgPMtQhRVH?=
 =?us-ascii?Q?a5P5nbomzJ6ghqr6yoyZZzRCfY8enWkupViqrUafQBl8TcLn3Nc9Szwm3muQ?=
 =?us-ascii?Q?inSkhGcuez9irAJ7/dNMMH5ZWQOZ9EEXffOXSm5okyB3HbkWGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:20:46.4858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef21008f-ff83-4c7e-495d-08dcefa9f7cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
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

It does not support fullscreen 3D.

Fixes: 336568de918e ("drm/amdgpu/swsmu: default to fullscreen 3D profile for dGPUs")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index accc96a03bd9..4b816c7e94fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1267,7 +1267,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
-	if (smu->is_apu)
+	if (smu->is_apu ||
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1)))
 		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	else
 		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
-- 
2.46.2

