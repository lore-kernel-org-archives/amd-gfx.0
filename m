Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A8EE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2024 06:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E58F10E046;
	Tue, 24 Dec 2024 06:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dLRyBgbA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573DA10E046
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2024 06:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcXxWjW74PJP6DiMjcZZsissChQSvJP3uO4SI/dzL9oYXfX8KJ4ijvKwJQ1fc6mpnlkf3B0qMgcOSok1BV7d3prg3f8WECgNjsuLqKekPfhoP14VLIjDjt4yKtY90uyN7HBhXfVAwuuv9OkWk3b90rYlV4QD5Ej5r3eYR/jBjXzVff+2oZbllFNtrkM8k1QUQfzq8cvIsBy05FkUHg7FR3EuovBv/FpHDn1asifEAlCmQ7ywqziWsowNL6zRzPJOADWnAAHfLYkaSIWmlVgthNn9i2a6rIRY8lIl0tRf4IdH6fLJkz3rA9ZeAk25thBHCcyR2nbPgqLtWNbKCQEotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoWRLgdko/9uhWuwGcm8+x8Yj7JVGHqvNBHYYdFQNhY=;
 b=OjGxi9cj5WKbONUsNxma1QQwf20/u6IFbRHQqgPazroVyIMsZE7oucqQJhLzek5Mj5R/vBABofGOsD8r5xAKaq20crftC/coiFPhmw0LsWHPF/0uodbqIHpIcb27l+9VdrQubtUYPD+wJ1vgpe1agOhz+jRwB1qfa2ATfI+Y8Y6kWVNNdwH1DEC0DF+9bw6FeIEW9bT7++DHE+9RSC/9jzrdIpWbRxWAUbjLTyQKq4VkzyC/LgzhoRoEzzwF2ol+V1nJVYewjR9MEf0S8PwL9CyP9fDN5Wdm60xKeaROlWW4oRxZ75YepYN0+pUJkUYi9Eh1Y39R/Z1WxHex+jfVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoWRLgdko/9uhWuwGcm8+x8Yj7JVGHqvNBHYYdFQNhY=;
 b=dLRyBgbAhEMVSuk3VEoO3XivqrbO4g+bfZjr6+nH2PPkJgzRrRviQCr6dql91+Iz1VARm4WaTOkkp0oZJv1vYI6bt4yuJVi273fG8Gi4NACEbkg3uxIiaLgIQcc/4YrS5VYE1eb++m1yvaAbAHOe2fUpHtlz6/dtPifnsvbTd5Y=
Received: from CH0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:610:b2::18)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 06:16:21 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::f5) by CH0PR13CA0043.outlook.office365.com
 (2603:10b6:610:b2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.10 via Frontend Transport; Tue,
 24 Dec 2024 06:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Tue, 24 Dec 2024 06:16:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Dec
 2024 00:16:18 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: reduce RLC safe mode request for gfx clock gating
Date: Tue, 24 Dec 2024 14:16:09 +0800
Message-ID: <20241224061609.1207220-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e589fb3-043e-4981-6a16-08dd23e27c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zfOjh77STzW72gmfqVv494CjXB93x9+3/D2ZawHPolgpIawlKmdILB36Qq0i?=
 =?us-ascii?Q?L6JKS23FugfUZTfImmu0nTbYNkY10DaXldDoUDYbdrlVNRt6ES/w46mbXC+Y?=
 =?us-ascii?Q?F7HCRHu+dizu6N87Wv4bPK8JWTjc07faJx6QEYlH1t9JGdBwlLYwFZq9mGpc?=
 =?us-ascii?Q?UPaNHT8/zJMiENDD8EnOIKZKXn9T7Tc0l1EuBt5w5S23SBsNzSO4mKF4M27E?=
 =?us-ascii?Q?N1qNZI+8CrIslxsiTjtyGTqWgaPjD1o0chqVZaOVGZMOwYO4j2VrgFfuCphZ?=
 =?us-ascii?Q?F3GGOSpsJH1lY2jEQjJs4Mx0NoLXgLtB8VRwMqkPdUu+9nfVRlqkicUTOsUF?=
 =?us-ascii?Q?LBuvnxSaqJFT0fuARgPiAWvtUwpAzj4sMukD+1P5n+MdknroXC6uiLyGxTO6?=
 =?us-ascii?Q?m4Tm6SuhbEIXyCWzouj8y4lt+GkQXSP4j5x8y/ZVYqii3hmiqNV+smin8cMY?=
 =?us-ascii?Q?K75JKeKWGH2Na+FA2c3OgrvxuGptoTrWs4xmJmhvvUlUtGY4Y+TJnPi9bEtf?=
 =?us-ascii?Q?USjwwoRzZT0YFoHXHay4OlGJJQJ8MNoiTNuXCyyI9Agz1H3DCD+lhy83fPkt?=
 =?us-ascii?Q?eB66X6f4nuzOCIRDGUSSoKSp+5R6Ezgy5n9UXuRlRfnUZS8hWzBNCW7bXSDA?=
 =?us-ascii?Q?ImSvPUBAFR73pG0dbo3luZ3vrP0R8imhhI2wO1Dxm3OPm5NMSlHFg0Jmo1Aj?=
 =?us-ascii?Q?NigTAE+GTDRRC53epXzGk+72rIFfkaqcKN3KIWGvLXcp05jBwKfeMvQ5oUam?=
 =?us-ascii?Q?zux8caUqyOoFAY9sWUO+bLiBe7I7CH4OXC0g1wQiMiy6QOjLF2fmoF3oFMRP?=
 =?us-ascii?Q?/J/mluG8hM+OWQwgmWOCDnikFGBGHD27lP38r2r6855p5OmVwenKyDfPRA3v?=
 =?us-ascii?Q?VtpM1Y2hpLMCR0sbtuS6drUWWjoKSJONuAPiZpygS2Q/Tji445NSmnGpfowz?=
 =?us-ascii?Q?n+FezXifIgxCuMXPVwvvvq6AsPVpg12w4sGSk4VkNre6tUzQ2y2lrlaODEb/?=
 =?us-ascii?Q?Ech83FnTn0/tcts9pFpmkW7cLv5kBk09dcZ1fEzZ8NCOencZp0VIt3h1t70s?=
 =?us-ascii?Q?PArfSSIYxRFlxNtSHK0FppZzoyLGtpq1nzzfsn9H9UPPTFKITC4Xm/J5Du9H?=
 =?us-ascii?Q?PKGCv6vFWugUr07LwCUgkkkeUKfLNIiiEqZLdxGxBbNys2W+LWpxAhiUbxpF?=
 =?us-ascii?Q?Tqkd5grgr3N+WIdje4WAn1RBQ5MMtoQIZFNpjs6t4uArENcQfpYIwpdToCE3?=
 =?us-ascii?Q?1LVqxS2v+iL6LHjASnwjzvhzXZwl85j/LWgl0vOtUlhN05TpOi5u+EC3VFgR?=
 =?us-ascii?Q?lZC9wvtFj5hx2K3wS8LtAacgKoLBJc18EoNiMkVy/i9VEfPr37eGzreaBws1?=
 =?us-ascii?Q?i7qVVG+dEEcVrq0GdNU4DrjATVsUPzHMjSbDOUidSgbYf0+XPJwiIMqxCkTl?=
 =?us-ascii?Q?bUbC8S9D+k+6OcR7awFiesSjGNE4tuyBO9w9HhRtf+u1L6vZMDnz6En9SBRE?=
 =?us-ascii?Q?WDhcFTQLN2FtTH4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 06:16:20.9153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e589fb3-043e-4981-6a16-08dd23e27c35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
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

The driver can only request one time for the power safe mode instead of
polling and disabling the power feature each time prior to program the
GFX clock gating control registers. This update will reduce the latency
on the GFX clock gating entry.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 ++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 ++------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index af73f85527b7..6a025438f9d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5639,8 +5639,6 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 {
 	uint32_t temp, data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
@@ -5734,8 +5732,6 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 		/* 7- wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
 		gfx_v8_0_wait_for_rlc_serdes(adev);
 	}
-
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
@@ -5745,8 +5741,6 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 
 	temp = data = RREG32(mmRLC_CGCG_CGLS_CTRL);
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		temp1 = data1 =	RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
 		data1 &= ~RLC_CGTT_MGCG_OVERRIDE__CGCG_MASK;
@@ -5827,12 +5821,12 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 	}
 
 	gfx_v8_0_wait_for_rlc_serdes(adev);
-
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 static int gfx_v8_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
 	if (enable) {
 		/* CGCG/CGLS should be enabled after MGCG/MGLS/TS(CG/LS)
 		 * ===  MGCG + MGLS + TS(CG/LS) ===
@@ -5846,6 +5840,8 @@ static int gfx_v8_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v8_0_update_coarse_grain_clock_gating(adev, enable);
 		gfx_v8_0_update_medium_grain_clock_gating(adev, enable);
 	}
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4b5006dc3d34..fa572b40989e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4964,8 +4964,6 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 {
 	uint32_t data, def;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
@@ -5030,8 +5028,6 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 			WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
 		}
 	}
-
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
@@ -5042,8 +5038,6 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 	if (!adev->gfx.num_gfx_rings)
 		return;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	/* Enable 3D CGCG/CGLS */
 	if (enable) {
 		/* write cmd to clear cgcg/cgls ov */
@@ -5085,8 +5079,6 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D, data);
 	}
-
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
@@ -5094,8 +5086,6 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 {
 	uint32_t def, data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -5137,13 +5127,12 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL, data);
 	}
-
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	if (enable) {
 		/* CGCG/CGLS should be enabled after MGCG/MGLS
 		 * ===  MGCG + MGLS ===
@@ -5163,6 +5152,7 @@ static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		/* ===  MGCG + MGLS === */
 		gfx_v9_0_update_medium_grain_clock_gating(adev, enable);
 	}
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return 0;
 }
 
-- 
2.34.1

