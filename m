Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25241D59D64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2024 23:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EA310E120;
	Mon, 25 Nov 2024 23:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yz5kI/jp";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2C110E120
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2024 23:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7Fi12tlB0xVbtOXUXlcaC3LFrAs9lEHBoqk8cG632HL09tTUK51rClGYAyibTTyxFNSQ1M3TxGjN/sq8sVUt7aglk/O45Nwq6ekfVYsJBQvDYnoTEyrFCcB9YjP2kAjqWw9vshtT9LrYywrSaxM8bks65J20D4XHRa9/2Reocx1LF3kz/n8h/gfGNmNpm1u+aPpGFYOvClzoxKjc+CXQ9rxjFtz6xmG2uDo+6lC92r1kCyxLc7Zdp7YBtwnQD+uiV/zEnhaGJ3DcM/4jv14Trpakfy/U6O7bEFXXRwl9YWlZ885j2GrfhoSkWjKE3WwTM71sjpCiFxlZy4J3NgFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svIbyAid2gZHgylAGdA9IhGIiMFUyT1siDD69VoYxdE=;
 b=SCpABbs74YCdEfSK5u6i88t67YUGz/lK49gkW970hYWb5f6bI7K3V0QO+k1JAiYuTgG2BTiUI6p1IqqPBXn8lwgdtn7CSooUwrIpYuT2lzAZmVD1MDUArMfhooUc9/1S15sIr0iW/eOSvyXD3T5XeOYXmWvE7Vjc/Chlr0HWdYXpG+iHPXOh7mHsjktO5kafAyXvLdt2lkE38jEsQlmzBmFJUqG2mdi9AkOditzY6voVTH4VtV77JlhMSYFSuUF/nC4UoYcH00BoNRhraivrhkReLDvlBDp3g2pAdaUbsuY2r8vJNG+QDtiSbSHKucvm0mGo0k5q4GtDBkH3J7P+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svIbyAid2gZHgylAGdA9IhGIiMFUyT1siDD69VoYxdE=;
 b=yz5kI/jp++LH4tFYi54Zq9JVr9eH9mu06SVfZ8AeibNySxT0y2NhfRMKP0/r8aZRf3jldbzl6Eg7PQL1Xev26idFoOyH6O83jfhHYdvl0NME4uazMnoMDE79MnClp6AuhskNdZRtc0aUKOP41hW0BCM+X5LU+06EeOg7bvlKdUg=
Received: from CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::12)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 23:01:37 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::bf) by CH5P220CA0008.outlook.office365.com
 (2603:10b6:610:1ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend Transport; Mon,
 25 Nov 2024 23:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Mon, 25 Nov 2024 23:01:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 17:01:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: rework resume handling for display
Date: Mon, 25 Nov 2024 18:01:20 -0500
Message-ID: <20241125230120.2744294-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff2f89b-37cb-455a-762a-08dd0da51da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?biMIE3k3Tef3kyVl2sNcau9M68NX/j7uUgmbKr9+TH0LN5znJsI4W+4b4FnM?=
 =?us-ascii?Q?p7bzQnb7jP1c83kWBmGHm3VeS3K5VDL6miYPlkGKADDliNj0Gqt8b2xiV4n9?=
 =?us-ascii?Q?FF53zOWXX8H2BzN+QUYgd4mh5hjI9icjVw8sYxBBv/LwYF23BhGKtcKXPd19?=
 =?us-ascii?Q?yY+H5qlbSCLD1d8Bej7m+66zXxrpMn+N8csgz6+bXXh7HuYFavQ27TECPihV?=
 =?us-ascii?Q?ZpCo/Mzdr6qW4WMlgSEQwjpGHdIdZUPx3PEjfBZCgsgXAAF8chguJn+Y9em1?=
 =?us-ascii?Q?Veciq0//0cQkgCgjpFEjP62/FOvsQwzeidkWdfRmF+JbnISZwK+LG3Wcx4UF?=
 =?us-ascii?Q?DXZTOrw+QxyGiRaY2yW64RoWL1TJnSvt4pCud92crfKZpGkedCiz5FNjc/ob?=
 =?us-ascii?Q?hI5oFd1KVyPyAgBpTkD5bOXTluKcrIjkc8cw6p2oAcQlJ8w5pKZwktJgT4Po?=
 =?us-ascii?Q?EEOIeTDm4ivpRH6kJZrlkGEX51v0/dV5pvMml/GBZjb4HUKVB009+ox/TNKQ?=
 =?us-ascii?Q?M3zxlQU0nhcjErq8HO104bDoA8Ttv/IsCyeZjLDL14VVHyM89HGiPCd7bCLl?=
 =?us-ascii?Q?94CsPljdMdYSdfqUI1wD8Bfqw6jc01C5sslHg6fg8iG9Jy8N+FuFo2TpCslN?=
 =?us-ascii?Q?I9VmQNw9+Lx8vm4fEKMey287ONSw6mzI4yz8G4+phts1KxZVm/Ra0SVnSzp4?=
 =?us-ascii?Q?6CAI6mjoweDXULaCLQXgfboINQIwaWGj4eBAXy8IY+0HX2mjqSwu2l55ltkm?=
 =?us-ascii?Q?MkgWS9c71J/OcyDKFtX8iqs2JWLY6C2PmD+z5g8R3JX20G+mgxoAoLlBHjop?=
 =?us-ascii?Q?K/v3r8T6Usz6+qKZtmImDe2u+LRGR2JXLf0boAe8Bn3AURosHsbn8+CL0hgM?=
 =?us-ascii?Q?qLdoezeFqZSiydrDG+qtM9JbUCgwS2r3RyKmSWQULurnPXbUdm3zAC4fBWyO?=
 =?us-ascii?Q?XrN/5O9TT/xnfpftTJLwMDFxCXqFeBq0v1SDxAsjil8pEGcMWdpbEDrFDEAo?=
 =?us-ascii?Q?hOgA+Nfy7X716d9TAvAeuMm6jqf2JfuMSCV7xXUKd53SeZ4ueZSIf35/lWPw?=
 =?us-ascii?Q?4lDP0+lCKwbKU8mApeX6b25M3YRl9nWY+a0dek9mWjTCKQ8Kwm81YAYnEnVE?=
 =?us-ascii?Q?f0m1px6hAd/mpDecYvDlfyFzNt1DRF513uNnxYZrNkdJQaBDRc4inOSTh0++?=
 =?us-ascii?Q?Iz/XXvJPoSm7qCCOWJ4fyTmg6h8WI8DpVLdzjeuyPmVOoQ/Tn6ZyWUMGya7f?=
 =?us-ascii?Q?OWR8MdhJ9wJdN2zXZ6TCkiFUkEAmOGERjTFtkqb+ckjR2lThatsDhsp8jV1q?=
 =?us-ascii?Q?Exq5fZ5DfDRTVntQxwp1vjW+wY81MZfFKSbM853+wFNjqWJQ5TmbimltPJCO?=
 =?us-ascii?Q?L8u5oSsKGI4L85KteHtJwszqRTontyt3iUaIAazxY+VFZkY16oT8/gkFliDQ?=
 =?us-ascii?Q?sgasz12dGYIfB5olien+W2a0SFHfcUI+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 23:01:37.3688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff2f89b-37cb-455a-762a-08dd0da51da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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

Split resume into a 3rd step to handle displays when DCC is
enabled on DCN 4.0.1.  Move display after the buffer funcs
have been re-enabled so that the GPU will do the move and
properly set the DCC metadata for DCN.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1aa9366931f5..a05eec8659f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3800,7 +3800,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
- * First resume function for hardware IPs.  The list of all the hardware
+ * Second resume function for hardware IPs.  The list of all the hardware
  * IPs that make up the asic is walked and the resume callbacks are run for
  * all blocks except COMMON, GMC, and IH.  resume puts the hardware into a
  * functional state after a suspend and updates the software state as
@@ -3818,6 +3818,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
 		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
@@ -3828,6 +3829,36 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Third resume function for hardware IPs.  The list of all the hardware
+ * IPs that make up the asic is walked and the resume callbacks are run for
+ * all DCE.  resume puts the hardware into a functional state after a suspend
+ * and updates the software state as necessary.  This function is also used
+ * for restoring the GPU after a GPU reset.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
+			continue;
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
+			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_ip_resume - run resume for hardware IPs
  *
@@ -3857,6 +3888,11 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 	if (adev->mman.buffer_funcs_ring->sched.ready)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
+	if (r)
+		return r;
+
+	r = amdgpu_device_ip_resume_phase3(adev);
+
 	return r;
 }
 
@@ -5519,6 +5555,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
 					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 
+				r = amdgpu_device_ip_resume_phase3(tmp_adev);
+				if (r)
+					goto out;
+
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 
-- 
2.47.0

