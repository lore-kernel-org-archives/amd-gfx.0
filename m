Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC1BC25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 15:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C4C10E4D5;
	Tue,  4 Jun 2024 15:58:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMJ++z43";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E2E10E4D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 15:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKwLdlEze2OfAXf1MFf37Sgqb7gBP+u36Rcqe6fgT2Wrd4/WW7oaPavh/hziX7m6aA0t/VlMLROEou4PWngSwAN6mvv59LBW2c1DWHS/gTPum9DU3fU/zusVP5tF6I+kPezm7WeD2CRPMnePkflKqHxWGzS7iaCmeGccwSJWv+sqrw/nQL0yZXoOmD8TeoMPlswU70Lto2GTFg94nC9ufR72Z4anqIqwxkM+oCTgfDoegN3u4ONs6Y+k42gmNaZvgXCrtwrMiOlqzosnkDZzR/mv93Q28k1nB1AXJO2BNXhkOS4VG/GuwcQwREmvEde59byLkrW28Z6pDGN00dNOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Gmhv6RNIslBWwn+oBXaQRxs5XokzbG4XhD+XmXLWlE=;
 b=lxazabqVzvXqMhVs+hKfKZi006Z3Kr26GAgcc7uJtbeElwL9uO3se8U7sJtaSvNbAlsgfdLHi9YyVGhWkyJEyae+1Ez3j2DsDKEuewIBOF5gYeApkiD3xfEAo63yQ9w6EJAAR1uBn24cInrX4ISE+6mordCDvkksMt8ZuQeqEiRlLL/1iEH+fSKta8mBk/3F+8SALF3HTB31CftRIpIBb0iPP5z2bRHPnC+XnO/Df96QG/U+p0DH3txiYJuxeUrP8Z0gT527BCtuo7pd88pXFQWehCotFlVSRAhA14zGA3/837doIzQfb0Hn+bBkHa5c2ZRbvDV9vPaLBL2bV/8Fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Gmhv6RNIslBWwn+oBXaQRxs5XokzbG4XhD+XmXLWlE=;
 b=jMJ++z43vK5+H8fxIoTknH2fw3mFHBMZdW3ynlcfYqe/xI7u2/f1hgNY3EwX1UmBvQytBnTDi3mI7q86sJGJGBx6MpCgblNY22BkDpaRRPMU6RKDTLuhlCHk3BA4LeZIr3ptQiKBdtHVKfgpmYrPAIy4wVO0IT9Pjny6bky9Few=
Received: from SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 15:58:51 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::50) by SJ0PR03CA0131.outlook.office365.com
 (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 15:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 15:58:50 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 10:58:48 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdgpu: add reset source in various cases
Date: Tue, 4 Jun 2024 11:58:19 -0400
Message-ID: <20240604155819.89855-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 5804d4eb-5a01-478a-2d16-08dc84af39ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KNFOivj6LBAfKl6wQ9IACw9SoGxCCK4RtLKy0oeVwnEeVsujw6++nJPMrZ0r?=
 =?us-ascii?Q?Dv0om7kaufdr0WP1OZGhZUa9sHhhQVQpCwsSDZALGwzg3kclXB1Nq2YuGUri?=
 =?us-ascii?Q?a2PZFjkrAHsn4ICakhwJ5rryE0DUCre5HOcHje3+nWQa44sMrCx8f180EW9P?=
 =?us-ascii?Q?QDBUYpB8xORJinPw3tx8wsG5uXI8hgcVH1Fq405MwIwUfNfSM+tZD9n2ZM5n?=
 =?us-ascii?Q?iq5ySBAOyRvb7dnGBoWMLec1h6FERiQi+6/rb2/T4F8ngQ24BFMDbWRyovXa?=
 =?us-ascii?Q?Yvmf+i6pPNOKltqo2rPLYVLSgNrWoq+Mnwh2RPba+8Q/3s+gHzwYpbCz4Oum?=
 =?us-ascii?Q?N5jPetNSTtLewrMrxt/s37QCryS64yDAGlUIwNZ6upgKSae0Vdm/rTdXl7BV?=
 =?us-ascii?Q?WepR7dHWuDslc/jMR8E2s4CmeNpHyHPlwP5S4mF8Ca0bDiIGX3rNZtlM+k2q?=
 =?us-ascii?Q?TBG8JAgyhsVm/NrXnKdtlgLC4LyDeVhv0M76hBPnL0PJRHhnfJ6HUN5bHEKj?=
 =?us-ascii?Q?mzjFX+tzWEut8+3WGHx24dDXTLCnDkhYC9CFSxW0CKiuOpQO0hkGR3RZN6Vi?=
 =?us-ascii?Q?em//0nLoqnbWizyppHyZQFFzdP2besQ3CRTX1dB8Y3ALhSRIzP3TGAf7YRXR?=
 =?us-ascii?Q?Ti8Dq2f/vYgOshulcM8KTGg7EQbFU48+BX7LlfBpi5kAqR/tIxFVyArAjza1?=
 =?us-ascii?Q?kMwgAm4hTKO4KVSICECqmWzLeRhR9VTW9ptP9RqBrIqRKANnssxrJc06JTGY?=
 =?us-ascii?Q?PSFF5q3mhDUdFHkX9fM95cPCs+KRFcHuzFf09o3mUAcaXZx1OQZNfO91WtUL?=
 =?us-ascii?Q?XdA7uA3IR+GP7IRSJqESSHJjemtlQvarBaTiXOiEKJB++9tCWmBr0OjQVwvo?=
 =?us-ascii?Q?9uB3d1VwS4VRHTElyY/g3lKgH7wAAyG4KXJRDiUqj/KST42va9U+Qkm/uLbw?=
 =?us-ascii?Q?oefY/y5anSCk3V9n1MJlDyWq8EAs5M4woJTbrUewGoUNzHSqv9fh2VPHAsP3?=
 =?us-ascii?Q?NcWLKFf+yf1xPS8ZyEvkaV5cct9SxN3UGwL9NH5yJy0FK/lVUxLsS+HyIKxI?=
 =?us-ascii?Q?4Vh1lHYmBcnwTEicct5ocfyed0cXWnmSh53OVBlYKvYnLY6n6LhnmFxXTqA/?=
 =?us-ascii?Q?cNP3bL+rSWqsTGfo3NJk0mlP4dKtCBcYkWgx99UHHKjp8fyQ90K5tkvL2sUc?=
 =?us-ascii?Q?IQmWQkpqB086jsOo0qQBeW3Ww4W+FvPp7wmmQOZ/w8x03LHE76A/MnXSb/OA?=
 =?us-ascii?Q?y//raUgtobHbFEwwaEFIblNPgiCBWCERxl/KeCZX/HP6nlMxcek2q93C4WJg?=
 =?us-ascii?Q?dcdK21i48Hd+lPQCURnyjMCCj5mRJOnLlaWvopCCjSRj92U3xg+7xoW0BLVT?=
 =?us-ascii?Q?ZCHRHP57dUGU6q0B6OYh1VnEeWK9s8NuKS+EQZqAs0Ivaw8aYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 15:58:50.5529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5804d4eb-5a01-478a-2d16-08dc84af39ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

To fullfill the reset event description.

Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 10832b470448..dff7033f2026 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -980,6 +980,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
 
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
+	reset_context.src = AMDGPU_RESET_SRC_USER;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e4742b65032d..cf0c4470ab9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -77,6 +77,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
+		reset_context.src = AMDGPU_RESET_SRC_JOB;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8dbfdb767f94..33f592ec8bde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2487,6 +2487,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
+		reset_context.src = AMDGPU_RESET_SRC_RAS;
 
 		/* Perform full reset in fatal error mode */
 		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
-- 
2.34.1

