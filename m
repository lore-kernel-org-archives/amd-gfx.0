Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC7BFF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7759510E7AF;
	Mon, 27 Apr 2026 15:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x7B7s9zx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE41810E7AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVRXQAnZb9wVfyGAy8EV3ArlU3bWG0yRia6jPfoR0b2HqvGJ54OwN8m25vICRw0+tFsU2maiUAvuS58PlmQIf/RKEfsNGg3T/ezc40siOAoFeVY1fg+xWvy7VxuH9t/aX+ifvdQsIkFx/ATymi453eL23+ucnUtMibPB86L/e9r9abnQtzcuXdB11iMmH0TsfBxbx7cdlRUqIDgS0al598ECUsKhtuuMcLRK/GZyJaIEM1yMMRHuoWcvF9kcSSIgwNi6A/FKQF5wBpoqEjxUcuFD52H0GaMffFY4vkke2i3sfz400bA1OjxK37CRViWXrCR6TjLNqxhPMhCSvdLEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT9cgKGa+qgJVr3Q3o5HDnGdJ4aBl9YjmQfqR5tSQyw=;
 b=afwXcpDryV+FV9FByq1rdtM3ydelUrY3IHjRR/HuBEkCrUvwmT1kRRip39UFo5I/73U3SucGJ59H6/0BzuS1c78pwtlpl9XuMA6SKynxf9FJbJ/T9M+vLh+40POODlDF2zGnW2XJCpvw7nFK/MV/Vc6NL369LibyMWzBCGB4XBt2VHKUR0ZWfjvmeXjxucqQBHqSTmN8ZSFpKMe1Uauc1V+TUj/gwgktZJnbu38o7hWiVOCNcaIkh2h8YhRR70LPsU9Uj732B9b1XFuqcRMBAUpK5rnapjgAeXF5JdS4BEUjyG6JPKLC1y1yuNLhQtinnK0Ghc7RYZ08A1HRweVBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT9cgKGa+qgJVr3Q3o5HDnGdJ4aBl9YjmQfqR5tSQyw=;
 b=x7B7s9zxsrXuRx5iG01G8/4CAwppcOhesiy+rMnN/+I1TObsIAvSIxW439OGBTp//RC7eJysOeu17E1Aul3U2dONr/ZHahVMfLBFnXQI6KZEYwHZkuzhb21iQTMyWstx2oeSUf50kfav3Q73jPxMQ44hl022//EyqCD6bDrmXMU=
Received: from MW4PR03CA0308.namprd03.prod.outlook.com (2603:10b6:303:dd::13)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:23:58 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com (2603:10b6:303:dd::4)
 by MW4PR03CA0308.outlook.office365.com (2603:10b6:303:dd::13) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21
 via Frontend Transport; Mon, 27 Apr 2026 15:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 15:23:58 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:23:56 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Leo.Liu@amd.com>, <Alexander.Deucher@amd.com>, <Ruijing.Dong@amd.com>,
 <Christian.Koenig@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/jpeg: set no_user_fence for JPEG v2-v5 rings
Date: Mon, 27 Apr 2026 11:22:48 -0400
Message-ID: <20260427152248.1349143-2-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427152248.1349143-1-yinjie.yao@amd.com>
References: <20260427152248.1349143-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fe1461-4b54-43e5-e3b3-08dea47100fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ljKCKmlTjzWMhPFuFnksDF9pgqqt/On0mfaCZymT7WLKP1u0iB+MYqFrcS7M6kceTDAL1AGij2XhZcc+20wnZPg3qP/tzRu3uyWPQ/UEa1VWg4bCKrMMXj69hINa+V/BX52GIO9kIm5vXZjJwbhiqzedXNxLSi2kY03OlaTZ1Sffd1Nxf33W/QxNteWCgpv1RjRrDRcId2xnnrq28fQF+73eA1R1PeqhUYKxmISrFcQFNJ4s7bvVSrGqriVqB3hNkUi5fhcVr1sqvHYJVIlwOHsjuX3OkCZRogVf/T3G51lBbH3GL46KxFi4dElZCm1kaWBztaD2aWusPzjy+UjErGt/EKt06fH30i/k3q/ecfcOGfu5mMID8WmWN4z9DN9QpVDdKgiRcwiMrMLz/+eQOk4WedFUUi5hPWIiup+XpA7fKqHs1t39o1dpGW+WS8PupNFHrEM0y8MucdFtUjD6V/k2d6NkZW9qA3nUmExK/5aLC4GOHR2uzr5KrTv1pkmAma6v9YBlkjOlOrkYhld/E+UBmZpes9jvJSfphzZdkAEyDbBiOk3mZIOvAbz8pGP2AlvQemxRW6Y7my4HhABleSUj3uI0TToEgqWiTpb5gCinU/4gZhidKGd+serkS8jKI/2Ze5Tv6vOIlI9hEh8vLDb5D7JWgAu+omapx8EuEa5l8J/yhaj4XfwopWMunp1/rax9/GXFta29bC1TkMM+HLECqOGV52jNn+0WbC3r9n0wXDON72aNwRiWljKA6VEo5tlynD1knTMW+/6gQStEiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gha4HOYTg5tzz6CLCsH2R3P18OP1bOmXDphlii19WcDLv5Xf7zHyE0o8mHeRChJEcdbHBZfiiTWfZeUzakFtE7+w/E3YZ1MwotPzJNyaUZQxPcNmcB2pOw094lj/VVveCDkgN+uzeWoAP+Z0Q9hSWAmRF8mSVTvZqItgEcHo9DkmddCCuMTQW55d6tv/dmeSfb1BF3I+s/XUW2MdM1Oj7oMA6lQOElQUpV/ATIugCrP7q9sGVm/HnjORS3QceT1O4tHARvbCg8OOzd9mI1GvU0gk82kyZge4WOJ11GkqtvbUARtu3/Ar2J05k1deHD3YYDPnTOC2JU7be/tdl5GpQ44HAaX5qKaW2uLhC1JSou8Z4n294uQWNrIUzobB1PID2AEqYd3GNjdHoFwIAM3W6HrC1uUT4BCdwEwFm63HdKE2PVZ1ZHEwkwGm7dlx0Lsk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:23:58.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fe1461-4b54-43e5-e3b3-08dea47100fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637
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

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 1 +
 10 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 9fe8d10ab270..cffb1e6bab35 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -802,6 +802,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_0_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index fe2b049afac3..5208312e7017 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -693,6 +693,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
@@ -724,6 +725,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 98f5e0622bc5..d0445df39d2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -594,6 +594,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 0bd83820dd20..6fd4238a8471 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -759,6 +759,7 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v4_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 82abe181c730..0c746580de11 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1219,6 +1219,7 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 54fd9c800c40..a43582b9c876 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -804,6 +804,7 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v4_0_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_5_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 46bf15dce2bd..72a4b2d0676f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -680,6 +680,7 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index edecbfe66c79..250316704dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -884,6 +884,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_0_1_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_1_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_1_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 285c459379c4..7a4ecea6b39a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -703,6 +703,7 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_0_2_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_0_2_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_2_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_2_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 1821dced936f..e7546816baba 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -661,6 +661,7 @@ static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_3_0_dec_ring_set_wptr,
-- 
2.43.0

