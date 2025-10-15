Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15915CCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 21:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB63D10E188;
	Wed, 15 Oct 2025 21:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMW0+GuW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C814510E16D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 21:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcDETg4C7PyvfVN/jA+6ov6ANKT4BThympoxomL1foxtgbY27ulUCkW+UFLmUSIUmZt/85oGiePoX5IDTp7NhAFBnuHVRCmOhU9rNNjiFlNMVdTrJ3SxJOa5vep9g8LTJo2zAvsTc6eUAWWGiX9zD/yqrAWOpTbhAzqJIgce50qbRmD8cw9RCrFF61nQpxLCaEksM1vA2O1W6RYP71vxjwd65Ob0eVY6jrmudu9tixsAafXHNHvi7yzeelp1f/g3kCEBPbOQComYxkyFwrFBoSqlczYV7H/qaLWdzui4xvBwOJZItnwPNZbKm0FjYVbASNCy1nPh2ETTYHJJKo5n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUkREzxOePP1kg/rVUiWTHnDjwVr/ySxTvjDrxIsJLk=;
 b=r6hZ2VzpvQ3RHRagfX2QMPJ9NAAFypaM7rpH2nxjbsgkP+fIO6hZitHU9LoMOMK8GaiOaCAkOwHuwsGlRviZeXdDZKwOND/ML3yJmcYHS++wWYhNIjhJs/nuzbw/6NustLVXFV1T0GLs9wOgKUa7UL8Lj214fhCJ7y65CxYKt9ZBi1IGmjZtmdDVHFDNugHDU64fWdDu59lbb6RDmk3z3Eu0JZYUY75hjCwj+cFz1OxUFbSRHfinkIrat5NXcvRBG7DvSirVn29DY2KfvR6r0+q669yBwg4xN1GjixSG8gvFUeTsKV3uldkkNwrZUQ2lUkU9koAi5JKJ675gZiY3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUkREzxOePP1kg/rVUiWTHnDjwVr/ySxTvjDrxIsJLk=;
 b=EMW0+GuW2tWfg1d2pbNinWFMkW+9DusQU5uqJoBXnY3Zrvs6kshyqXn4MFx7uBlKnTX3a77vmAE6URzG8ZwpLhj0wnC/Aozdbi5GVQEZvcFfroWmv6B7+CUU8VkPhD7p97ZZk5o8e09AJZK19KwoW9maa30sQIVITYxryDJeobA=
Received: from BN0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:141::6)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 21:49:02 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::1c) by BN0PR07CA0023.outlook.office365.com
 (2603:10b6:408:141::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 21:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 21:49:02 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Oct 2025 14:49:01 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v5 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic critical
 region in SRIOV
Date: Wed, 15 Oct 2025 16:48:46 -0500
Message-ID: <20251015214848.11580-3-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015214848.11580-1-yunru.pan@amd.com>
References: <20251015214848.11580-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: f63023ba-27c7-4428-485f-08de0c34a7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7AjuS35LW33KjYiMa622ebEn0y92ozb7ffXEc/1Hr6lox3x3/pnsGsydX+W?=
 =?us-ascii?Q?lhaBAayu/hOYtGGBm4etvRBM2D+s6ASXm/iWOwNNWtqNlTz6XHWsXkc5kQWf?=
 =?us-ascii?Q?glnLZKsj/f6Gw/53gxgpH7n/re0Ia+B9gAfxrWfJw4IEyO/T+nmmZ4MIwIAt?=
 =?us-ascii?Q?j9FHuUX2Z/8OiCf9c1ztCPukI1jzMITlq1ygegHhnGPqpU4DYpslFJ8v3QYR?=
 =?us-ascii?Q?XFFb9YbBoIAi/dUYed1bsiohY2teef1Rx6bGZNfg2MKLyXmHaxhRUUnoXm/c?=
 =?us-ascii?Q?X9EkTJZ1FqU0D6b2kkfSmBaY5JtEfHMVPnOE2EaVAz90vkes9ssM1qBNW2iV?=
 =?us-ascii?Q?twkwP4So074mNo4C6Lvoysd6iB5E1BSvo+DlGLIEMUfHJeVIR7kDjC5i/eWU?=
 =?us-ascii?Q?z3slqYQ5qvxuHPw55eyMTCwmAepc6mBbgxMu9DTKguZcc2Xc0fhsL+YK9RXr?=
 =?us-ascii?Q?xCVOdXZ9+veSibzGrUPWZC/QinaXQOCfsuz+95uHNqP251EO8TmlN7jCdw/C?=
 =?us-ascii?Q?Ypvjt0MtQ16DfjNe0f/l539zFs32/kzOSq9+lOTqg9bvoo+WWUWximfeOoY3?=
 =?us-ascii?Q?B9QOFI/lYUaXBVtGESVncEw+OYaGSNm2xib9hwRxlr10WKonIaBvBAu7YO9k?=
 =?us-ascii?Q?qPoQUhPbgFWbfXqqSUnxD+oFQH8c8eg09dG9wX6ces1peo8RtZCc/CjH+XFu?=
 =?us-ascii?Q?QJhLyLSXM+nK2ivoGKT8+yIVfXP4NXXxBa9m+7waZxrnxZBQDKgx1lTyoCln?=
 =?us-ascii?Q?Z8bb18QVCI5X1SjeUASKriSdKMTsIMLKgbVTvYcPxx/1SEahXbeWm++DN08D?=
 =?us-ascii?Q?Gz8vPf6LobQSEA+j13mzwAAIhYaxIfTCuTS44pbCyEcMOZPTxW86HieszbGa?=
 =?us-ascii?Q?RcJFslYFzj2+VpZI7DLNMT1bsQCsjHmJgzKgAZ6VH2pVt4KkpnJ9hyJI1dVe?=
 =?us-ascii?Q?xsr18bNl3gJTzxoZXoCAKUPq4fL6MIfSoLL7uT3gRrGW6O/E18TPej6eVGjU?=
 =?us-ascii?Q?jlVU2TVFaqg5O1aIRZhHvQgiuh4BpVJQlQ/mU6Jp5qGsP5+zZBo66VySd8hm?=
 =?us-ascii?Q?/dX0Br299YHDSGJQdLRs5QgfUbT7tBvTdEj8/nx3ijx4GWPSanl9SQol/H1I?=
 =?us-ascii?Q?G26qRBJJcBcm8pUq/YQ11HmpP3Vel2VfO43asSKcMErCkyJnweS0VNUPJg7I?=
 =?us-ascii?Q?239MI/IJt4/SrzFVhayU7Vyykk8ObMOFgHbKmjs0wm346tiqQqxPTm+6xImO?=
 =?us-ascii?Q?uFDYHxfYp8l24lI1h7CqKsnjVLtt2yrYTKEvYLZ+pYHIR9x0RFR30qt0O6Gq?=
 =?us-ascii?Q?ZfmzguaRBLDZCuhgHgLS3C2AhnJ2+On4hMzV/tHg4p8Nl3jTZqnutKGBM632?=
 =?us-ascii?Q?+ihjdZAC1E6yXiCsNOMXpO/jGtn562KpA3REIleUfE7N4IgQwkpEgWQeSxjr?=
 =?us-ascii?Q?VVhQQXRFKni/ZD2AwOJtL/6C4OgtFL9V3dL75OUfSxXsoSELfhZKnawAE3wi?=
 =?us-ascii?Q?JQFjP16AH0I3VAgMuO0uhQbMLRsrbkgP/lfuzUrJtWhjjnERoqISVU5tFdz5?=
 =?us-ascii?Q?9NclEpErH5EusKiLIj0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:49:02.7228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63023ba-27c7-4428-485f-08de0c34a7e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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

- During guest driver init, asa VFs receive PF msg to
	init dynamic critical region(v2), VFs reuse fw_vram_usage_*
	 from ttm to store critical region tables in a 5MB chunk.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 ++++++
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index c7d32fb216e4..636385c80f64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -181,19 +181,22 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 	u8 frev, crev;
 	int usage_bytes = 0;
 
-	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
-		if (frev == 2 && crev == 1) {
-			fw_usage_v2_1 =
-				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
-			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
-					fw_usage_v2_1,
-					&usage_bytes);
-		} else if (frev >= 2 && crev >= 2) {
-			fw_usage_v2_2 =
-				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
-			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
-					fw_usage_v2_2,
-					&usage_bytes);
+	/* Skip atomfirmware allocation for SRIOV VFs when dynamic crit regn is enabled */
+	if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled)) {
+		if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
+			if (frev == 2 && crev == 1) {
+				fw_usage_v2_1 =
+					(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
+				amdgpu_atomfirmware_allocate_fb_v2_1(adev,
+						fw_usage_v2_1,
+						&usage_bytes);
+			} else if (frev >= 2 && crev >= 2) {
+				fw_usage_v2_2 =
+					(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
+				amdgpu_atomfirmware_allocate_fb_v2_2(adev,
+						fw_usage_v2_2,
+						&usage_bytes);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7583da3d9ab0..e226c3aff7d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1939,17 +1939,17 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 
 	/*
-	 *The reserved vram for driver must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
+	 * The reserved VRAM for the driver must be pinned to a specific
+	 * location in VRAM, so reserve it early.
 	 */
 	r = amdgpu_ttm_drv_reserve_vram_init(adev);
 	if (r)
 		return r;
 
 	/*
-	 * only NAVI10 and onwards ASIC support for IP discovery.
-	 * If IP discovery enabled, a block of memory should be
-	 * reserved for IP discovey.
+	 * only NAVI10 and later ASICs support IP discovery.
+	 * If IP discovery is enabled, a block of memory should be
+	 * reserved for it.
 	 */
 	if (adev->discovery.reserve_tmr) {
 		r = amdgpu_ttm_reserve_tmr(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 805ecc69a8b5..12659990abe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -999,6 +999,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		goto out;
 	}
 
+	/* reserved memory starts from crit region base offset with the size of 5MB */
+	adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
+	adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
+	dev_info(adev->dev,
+		"critical region v%d requested to reserve memory start at %08x with %d KB.\n",
+			init_data_hdr->version,
+			adev->mman.fw_vram_usage_start_offset,
+			adev->mman.fw_vram_usage_size >> 10);
+
 	adev->virt.is_dynamic_crit_regn_enabled = true;
 
 out:
-- 
2.34.1

