Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A37CED265
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 10:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0513610E480;
	Tue, 18 Nov 2025 10:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v+rKWsxy";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6087110E47A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 10:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ9mYNfOT4AUp8NUHVvTRHAaZDBiMFvqqutgdLF4UM65BW0ssjqFzrN/CkS/1Hm8mB0dRzDv5KNHHK54U8b49Q041qdQrjcPC1o0zVXR89of2ZmTK4TJQR9MO7rmmx8vZfkX+E3xBzvL7pweL304bvQuglFAoLTCRz6qtBC925LVCNKjo5RVbdXOqG9b8Bpyeuhww4w2qJVPClmUy5FoXQjDhb7ynXbvajpzi3O/e8Mek25WtJ+zbPwfmJRdPlqRZsHs3rJsW4uEyJ0b5bbqgXt2DeyMIjYvcHQxYzjKqNtxoEgmcki7qIeJoek6Vmjbti0FUJUyp9WDAdnYicm1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9oZN9JE1MiKzFd7sILwh97G1ayuyz40qeHJaRDJJY0=;
 b=d+Ki/211y9P0VHlRMu08+tTjDbRxoLS1w/2D8rk2K4zIxBboY7QrBgpoCcuGPGDLJHJPZr31cn66xUAjxBdsWBquQSJmT398n+H0wvFyxWT22wzh8CA+94Qc0n0d1Qi5xjrlUXGAVa7UEmodkwdnpI6psVjmgaxjmJ9YhBuxdpCZT3R3vOSWe9lMumEh9NCOn1ktA2H9Q74+bxCEJCP9YNFq7c7h9vZ/scIarQgMGZzaJvR3mucgUbIqNlFPQZUgu1jeQQu5QTTs4W9iEvP8PH/nq/TFK0Gk9LyZFSDf+pfrPrFcvTdkdZME0NvsLKT/Amq28xgH1V4gKHW1Y42K+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9oZN9JE1MiKzFd7sILwh97G1ayuyz40qeHJaRDJJY0=;
 b=v+rKWsxykrgmQQWOH8EuMSefqsLcZQ8uWUnqfaVR8L/G4O4CoioL9mf7ZmINgrVYyPdM0neObwaDw4dZqj9wRX3u1yAihk6MpxHQkxj+NDQnbJEpC9ulY9cgZu1ZJFxq27tGlWWHkD7ZZVP83LEkx+P9UZN7vpoq0mYWJQ/1sIY=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:07:16 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::dd) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 10:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 10:07:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 02:07:15 -0800
Received: from shikangserver.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 18 Nov 2025 02:07:14 -0800
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Shikang Fan <shikang.fan@amd.com>
Subject: [PATCH] drm/amdgpu: Add sriov vf check for VCN per queue reset
 support.
Date: Tue, 18 Nov 2025 18:06:57 +0800
Message-ID: <20251118100657.1222595-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3dc77e-7074-40b9-2855-08de268a4052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yCuiSE7goTZ9jOAtUoQ5v6xyp4CNoRpx+aV7zWOBdjtTIll/9aUHTWLTr7LZ?=
 =?us-ascii?Q?wWHakrnjQWWpRgwRrb0cvofIaQI2MlvaDeQ4TLUyy0xfmFnmmRG4WAU3bwbV?=
 =?us-ascii?Q?mfueGQM6EFAkw7U08zNRlZOGC4rxum2CxhXIEQmm0640SD3e0J4rxXFhGMzc?=
 =?us-ascii?Q?H4UC6Od+UOEfXGS1A7wcaRp97a5fxeag1RqnBUOrJ0nlJY4CaLHjcrDWZdzu?=
 =?us-ascii?Q?rA0SeJrjFVmbApuN9hWUiZCiv+IOkReMGOerisZz8vIzNZrYTb+/aWwmUTuF?=
 =?us-ascii?Q?QH739DpJsBbQaHbe8/lGhnRwgw2ZRXV0YoJzF2R+mCd70WsjIKTRrhausJci?=
 =?us-ascii?Q?ym23+PnYnMFgxr/iFTCvZ8soa3Ga4mBeGAmRb09jZ09e7ziGjMd9UX7J68ny?=
 =?us-ascii?Q?0lBpnLw1tR7pxIKMFJcZlHeurH5gAmRS86VWPTyO4copHyzDNJ3fIJji9SEx?=
 =?us-ascii?Q?AaPM5f2wmbkvZ6K8e+8P6TpQPaGcd4l14aB5VNCTkO+c2r5NYRuO4D9HVu0C?=
 =?us-ascii?Q?3wbgd5zdr8zJ4P1pIwZHU2SHQb5fn+0aZsWVw4yINkgOJ8pLvjAai/kT/g+A?=
 =?us-ascii?Q?++1MbmSOoLsA30jzS3stI3FDqhsDLqOS/r4S8XcFgcoS0ROAVQD97XKDh4Sz?=
 =?us-ascii?Q?KP6hUZCQoitzI6L8uC8hj1t6uzSueQqJAqGLbMumK/0+RzcLJaH8tqzGt6wU?=
 =?us-ascii?Q?lnc63V/xwxuQT+6DRcYSqeNLoF4E+I75Z8StnP0MKDGJDMGPAdbzDbVy/Soe?=
 =?us-ascii?Q?Sezq/wEsEw9kyMf/hOxaeV9yh3mSSRKIMvVZfYo1R8T6+iVjUbJsIGCcy7X0?=
 =?us-ascii?Q?UoxgQvKJsAP5NV5IuvlhTYyJdFtkRrg2r4fm8C7qDRCDStJdiE/5f8bFQSql?=
 =?us-ascii?Q?QVBrqXkEIuxIloeZQjlS97YVy/jnCH2i/kiFSvNbMFl7grRL1tlQPDeWUywF?=
 =?us-ascii?Q?aqgaMkJV4NkWHvxVqBUGOuSs+4CK31ruq2Rj4znlDXVhs+H7+YL2PSAYvQwd?=
 =?us-ascii?Q?iIoHeE8DCTAhqN1JZxvIZSBVJ0j9p7Q1TrkL0aAQJtd7VeEQbvrGMh1E/fzk?=
 =?us-ascii?Q?NkF0REZ01N93F/Aw7b6jy9ZK4eATRhV/z64rgBoXRWoy+vJ+kz4ovTPt/W5r?=
 =?us-ascii?Q?mG142HNMNIK1qoFooQR61+I5CipI/cUL6tqeOCXe3k8liI1h5Na6EGosmQcW?=
 =?us-ascii?Q?L5GscaOqm9nVw+fmxGWK1k/7mfqJL9OpRaep/UEf/+F50ybWTZDMDa1+zges?=
 =?us-ascii?Q?iOo5swxG9L/81C/qAycLoPTd+TozI9YwL9FQdWBC2hSzBiAr432/XsdVz9Ha?=
 =?us-ascii?Q?Ca12tq+Etg1eNTIphMtOfp+ojhWqqS7ACQgtoNKEMIi8mirEiHFZuLq8ikx/?=
 =?us-ascii?Q?u+qKKYH3B7lYYkBtj3rlz1E8b4KrlSOwESGvk57Ylc6rcXHjENh2kHmg3HUn?=
 =?us-ascii?Q?Qf4hM4tyfKwXCbmjcVuigkQCyrv/uoxl8ffqOC59jzE+7+kr3R46UFTAtmU/?=
 =?us-ascii?Q?MtEoDmmQAUnpeQXASRUhfxY/uyMokgQvvKC+2bacd0VCuiiyLLqSYxdq/w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:07:15.8819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3dc77e-7074-40b9-2855-08de268a4052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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

Add SRIOV check when setting VCN ring's supported reset mask.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index eacf4e93ba2f..cb7123ec1a5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -141,7 +141,7 @@ static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
-	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+	if (amdgpu_dpm_reset_vcn_is_supported(adev) && !amdgpu_sriov_vf(adev))
 		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 714350cabf2f..8bd457dea4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -122,7 +122,9 @@ static int vcn_v5_0_1_late_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 	case IP_VERSION(13, 0, 12):
-		if ((adev->psp.sos.fw_version >= 0x00450025) && amdgpu_dpm_reset_vcn_is_supported(adev))
+		if ((adev->psp.sos.fw_version >= 0x00450025) &&
+			amdgpu_dpm_reset_vcn_is_supported(adev) &&
+			!amdgpu_sriov_vf(adev))
 			adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
-- 
2.34.1

