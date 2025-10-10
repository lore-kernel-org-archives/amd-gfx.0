Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75114CCD18A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 14:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D42010EC08;
	Fri, 10 Oct 2025 14:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mDKt4saq";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7738C10EC08
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 14:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjMtSEl6rJN8AHwN7165UeuHn6pYuEUrqObLBRzeQuM3wgu9vKSNT6CZQi5iSNVxEwTzBxYUWx65kCtXuIkeW5/mQJcGY+jwQbScZsE7XnBZ/JTG74GrwJtziAcuc6yHkDhBJjcqsySIIXDOJJFPSQrr1Z/NW9PpdQUaJ958QVQVpa8ISY/kaO1Js66slSq28SIBQ/ClcL4HMXBh9BefYEZOtSsErE+TIxrehXAZzdQzKeapgVz7wcaRP49nlE/VvVPehWGEA2q+gk/tMv7lysEAwRD8HHaXbN9UBaJbxamcraKTwpVPLU3Wmrhzsl0uRP1rIup4SFPirrdCIxi84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdOvxIVqx9MxvHfSP/KeS1ocVncVYblsWbH/DnZv2uU=;
 b=eVzvwr+XIh+PsP+T7Fi01bw7VFFRmvEk4iQojGIEUvkzINuFmLZiu5gKQGBUqt9v4FpfOVg/NDsNFXuz+DS7iAihUQkJSlofd8hJ32pVu0GvT07z67S3Sevqv/ElapwJ8iMVMH6ftIsqXOZzCtXDBadPIT5DDZMIYdatrNQNc3WOL7v11nAyMGI70rUfmhvC4p3Je7t73IkyBmEoCZJaJhNSjl/UV4I0bJ4AtdSQcufXQj9RjP3HeOjfd3+IZ77pZxCc8ru/gMJROpBAktPgmaE8hBEZMOIXZ1H8/a//H9pi9OvFklRgfml8AJq4fRSGYUzwNMEk54BBdwWvcIUnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdOvxIVqx9MxvHfSP/KeS1ocVncVYblsWbH/DnZv2uU=;
 b=mDKt4saqUPNOQCqQtHm5ZMdE/YKv+rTxRqQDV9PA1DPu1N4Wr2edsSHojRhRq9pwzZ0RWy/mBN38lrzte43a8nymiQ+TvfYk+sTS6mS92To54+AN++gytP6VkzE/cDOj8vpuvucdSo1JTRw/UmyMNlcvlcgCfQQXeA+KLQnkp14=
Received: from BL1P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::17)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:02:23 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::81) by BL1P221CA0039.outlook.office365.com
 (2603:10b6:208:5b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 14:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 14:02:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 07:02:21 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Reserve discovery TMR only if needed
Date: Fri, 10 Oct 2025 19:32:01 +0530
Message-ID: <20251010140201.3492361-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251010140201.3492361-1-lijo.lazar@amd.com>
References: <20251010140201.3492361-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 8554e812-af44-4634-0fda-08de0805a25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jj11ZLDqBReNNWM3tIhfhleExwFWCTawgU5I5Ehj9xaHCgzALIqX+FicRuE2?=
 =?us-ascii?Q?TCTycgzxkQcImFT1sXLiT1mQKP64G3dDs1XEE1YIsQdDND9GOTjxHNv9GwmS?=
 =?us-ascii?Q?KlX2eJ/5idOVlt3802vKJ6QmWu3GtxH4W5GCOK0ngCx8yUjj60wurLEYil+r?=
 =?us-ascii?Q?f7KhYSF6gf+raPmQOceHPPUpTWLW692LCUe8JHoUoQboEorVmSehVVMwN+Tx?=
 =?us-ascii?Q?xII1wrVu9dSJFm3uCCkcGgx//q5tIb70k4CuqVuI7a/+OrMuFZfU/Zli7fls?=
 =?us-ascii?Q?UD1Gr7Btjh1M3fGrJvUIisZ1L28Qypsd4JdIncgCPpHfC+Oe2u5zmYEHNmGw?=
 =?us-ascii?Q?GZyhQEVw3DOCGoZWTuhfKd08wIEyQFK/InX7fODNDq9/Iy7EBTNIK7wpb4H9?=
 =?us-ascii?Q?xulRxlGY6rVmPDdRMDKdOnhtkDmRL/iaI59z058DburtnMe+mqi3SDXoodnI?=
 =?us-ascii?Q?2SSML5taFvbxAVCdkDXnwg9v4OYhT2PNBu4XqWNoZXO8RoQepbhJwR+lg50+?=
 =?us-ascii?Q?GknXl6JO184hdV6buVPeogxrNSryaPxDTOZYECVpkvvKipk0bdI7PyHHf2Jb?=
 =?us-ascii?Q?NxKt9NonKYjB58dFI343jPdqrEIutT7xZOXvUbqB2dHrd3JIhQmOoT300EDe?=
 =?us-ascii?Q?RzavVMCCNum2CcuKsvRStiSr+rgqW8gEaFPKZwkxjUFvvp/eTPiNWU90Zwj1?=
 =?us-ascii?Q?fTk6bw8+Z9jipQ+kzQDubeMZ39kfOCdajW9bNdNrmv0ZBUkkH+Q2u+W5RNlL?=
 =?us-ascii?Q?uD4PPBZFjS7/Ojn6vaOuoXd6Pg6vori0AYkSB2R3K9uaEnTFnlpjU9Xrllsg?=
 =?us-ascii?Q?SC5LfSzk9uey55s38Dm3zJ22mDptW5PGvkNnDIUgrqnsMbj9PNBCL6tg/p75?=
 =?us-ascii?Q?Gl7ikbggJetcaLCGHPPJYHp5mvx5FYpgVrF9uyJlg/Brjxv6gcwsRQH6L2Ju?=
 =?us-ascii?Q?Ip7VCUX4+DXWFcI0+6KgdQ2vXoft+5At58PCNXPz2iq18kUqDyYT7EjZ4IDA?=
 =?us-ascii?Q?9qelrqqo1VC3JXC1r6xrhwXs7sCXO66ipXP8z2HA6We7kCFKtO4WDZD+MI/k?=
 =?us-ascii?Q?s+C+i1qqCwRIjUAUUwzJsTFP8gKr7nx+REApnrD49RA0p0eFH6PmGyRjF8kR?=
 =?us-ascii?Q?Ockqx97cYAYNDgrRPo4/6gSSWu6OH+RkdvIIUN7GvqU5cye1lgFmzDCZD0LV?=
 =?us-ascii?Q?tWqrk00Xm13wowY8Nui7wSlEqw2FgPIuIkz0eRGHTWmVoCcj23R1oPbFk2jy?=
 =?us-ascii?Q?wtBscCf2G3NC1FMwO3lCPd08XWq0zPynYtBpOiTbSlk8cai9AHAGYLjX5uYp?=
 =?us-ascii?Q?+wVeHzySNPvHb1IpTZFcKJc1lfCJitrRYdByBcfpbWviR54ZQ7N3qkaIwghJ?=
 =?us-ascii?Q?AVoMJ7eyjcNWj+VoQULvzAd1ySVKH9W2hYglObqaMHzLyKV/kdX39w6INvND?=
 =?us-ascii?Q?uVSaW41nBUskFE33ytMXACbgLA6+aU20J/gmOhnVSKpIPThp4peD/hY02Pqh?=
 =?us-ascii?Q?w6Lyl7cAXAXkybN7ofOTmXrnWfPwrdXe5WuAYv8cakJ8p41Bu+KYCekjzTZO?=
 =?us-ascii?Q?YTe6Fbi0toTYebwxZ/o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:02:22.4759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8554e812-af44-4634-0fda-08de0805a25f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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

For legacy SOCs, discovery binary is sideloaded. Instead of checking for
binary blob, use a flag to determine if discovery region needs to be
reserved.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 22 ++++++++-----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index bd324385e18a..d110e1ddf473 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -299,11 +299,16 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	else
 		vram_size <<= 20;
 
+	/*
+	 * If in VRAM, discovery TMR is marked for reservation. If it is in system mem,
+	 * then it is not required to be reserved.
+	 */
 	if (sz_valid) {
 		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
 					  adev->discovery.discovery_tmr_size,
 					  false);
+		adev->discovery.reserve_tmr = true;
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
@@ -420,8 +425,11 @@ static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
 
 static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
 {
-	if (amdgpu_discovery == 2)
+	if (amdgpu_discovery == 2) {
+		/* Assume there is valid discovery TMR in VRAM even if binary is sideloaded */
+		adev->discovery.reserve_tmr = true;
 		return "amdgpu/ip_discovery.bin";
+	}
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 842cb59cea6d..2a00bac6442e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -32,6 +32,7 @@ struct amdgpu_discovery_info {
 	struct ip_discovery_top *ip_top;
 	uint32_t discovery_tmr_size;
 	uint8_t *discovery_bin;
+	bool reserve_tmr;
 };
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 73336291984a..d0a7379255e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1767,18 +1767,14 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	if (!adev->gmc.is_app_apu) {
-		ret = amdgpu_bo_create_kernel_at(
-			adev, adev->gmc.real_vram_size - reserve_size,
-			reserve_size, &adev->mman.fw_reserved_memory, NULL);
-		if (ret) {
-			dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
-			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
-					      NULL, NULL);
-			return ret;
-		}
-	} else {
-		DRM_DEBUG_DRIVER("backdoor fw loading path for PSP TMR, no reservation needed\n");
+	ret = amdgpu_bo_create_kernel_at(
+		adev, adev->gmc.real_vram_size - reserve_size, reserve_size,
+		&adev->mman.fw_reserved_memory, NULL);
+	if (ret) {
+		dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
+		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
+				      NULL);
+		return ret;
 	}
 
 	return 0;
@@ -1955,7 +1951,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * If IP discovery enabled, a block of memory should be
 	 * reserved for IP discovey.
 	 */
-	if (adev->discovery.discovery_bin) {
+	if (adev->discovery.reserve_tmr) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
-- 
2.49.0

