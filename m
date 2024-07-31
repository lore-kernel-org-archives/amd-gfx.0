Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7992DC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 10:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B9E10E149;
	Wed, 31 Jul 2024 10:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B8TSuhO7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7408F10E149
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 10:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl6xN9vfg+ce3Ps8RVSFXZHMiL0V4oFBZFrhW3AkfSL25YN4X96prh/DKLaDQaThMuu3I20jReN9AXSereLqxAUPb0Cf3i1mSIDX+LKbp0PzTIFP0oOIB7FdiYwkk6uWXixNPPLVrE4xIkO+qpXZRO7/IkCbe9qZfCbBlXIbR1U0a/jB4Zxg6gxqVaLrmqj1WX2uXvELiCbUYdCwVt5hwCUo8fxmHVm6r5gqImouxmtu/KktxqcPdCfxWwNbP6W6IlrQk4VnGqWEQC2BFkA32bdhgnWElNh7Ij+7K+LHUFmj8P1kgmDcpBo73N9gdCnSgqSx5X4nOUAngoKYpVgVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIf6rodyQVXDnQhrKdZN68oq7xUtZa4ZARecG7xbLAc=;
 b=VR1Ri3yZ+Hpgc82ZFx5RUDS7YVZOd3+BwxIzor4SmYEmUYgmZV5TQ3vyO2TWsXqrSDFUDjiBuo/f9cPZHSGVU8F1ax6jH5/r67H1hrliLkbDPTaQUZQ1YkRJFPYRBxF/P10geSJBWf57uiHrmZ3j4Q2t5KOXPYC+pkndkUVqv4q5V5sA6G6MAKbMjTeicK8cTThCv2jN1AF8N/ILnv0c2K81X+zwGHf9NA7NHZMX52cNEKUtgQVWrxhH6lhCN7C5+Ex2BGovGiAubDfoO7qfIPMt08jsRwgzwc7Af7EQMKR1egMva6HWsDRUEdGNJw5L19i571u3HfGggYdvynR+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIf6rodyQVXDnQhrKdZN68oq7xUtZa4ZARecG7xbLAc=;
 b=B8TSuhO7NWB8CpvRK8w3p6rd4dQybtAwD7g6BukvDzEi3UwziAqKFUR8DjYcBDODrMpiC/n/S6ohM2BYLecu6+tSruJtbed0WyaC7ek8OwgyLUUoi+iqIWaOprX/MpvphYWb7hLgnRG9T60P4AsDq8hN2mWsfAMYsZ9tmmSyapg=
Received: from BN1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:408:e2::6)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 10:05:37 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::e0) by BN1PR13CA0001.outlook.office365.com
 (2603:10b6:408:e2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Wed, 31 Jul 2024 10:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 10:05:36 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 05:05:35 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: report bad status in GPU recovery
Date: Wed, 31 Jul 2024 18:05:26 +0800
Message-ID: <20240731100526.32903-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3a4531-022f-4ae3-030d-08dcb1485323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cZ9TzH5Q1cz6w2dEjehWU5IKLv9syfwmKdOjvuPuII1flxxe/F4/ZqlmUbBy?=
 =?us-ascii?Q?ctLC8H8oddn2eBoyABuWNE96mtgNCVDMQXQifiYI43awdBKhKdYXqjOj0TGJ?=
 =?us-ascii?Q?gc5ChEU9HlXLzmuX4+V/RzJsmUiVkyAt6I4YVbuG6j92YlfDujgSBJ9MLTr0?=
 =?us-ascii?Q?i1nOKk9xUNddeNBukMp9qbZeMU0dyP65AGZ7TuFdgS+KLD4bu5nWWOv2C/gx?=
 =?us-ascii?Q?kNuJ8F48ed1dAgNeQBZRtScqUrrMzGl36ANaCIkND01YkDxWdYdcOnPBMrEh?=
 =?us-ascii?Q?3cyrBT8H3Hf1c3m/7ne8bG9+VfhFEDhXAtLx4lEZysMyQClLg8ixr79rZNxu?=
 =?us-ascii?Q?LbJvFuEH2w9HiSLNee+F406MEa+41wHuU29/QDJemNKesrZKhFuy5v/2y5FV?=
 =?us-ascii?Q?Mqa9GkaVAaactc1aRRKNmNbeattEzf5Oy+FnSyQBXtQV9AaGdv+rHYP71r4l?=
 =?us-ascii?Q?lFkIoGoMVSUx0uHlBNgVKkZLzwIE5rkStl0iwXnT67pZNft0k2jJNHlSli03?=
 =?us-ascii?Q?95mSCuBxv+a6yUlEVwNmTSO/lO4dojYYxVhVRkPYPorEG3/jbHR5MnJL0O12?=
 =?us-ascii?Q?/8MMopyDh6J3W1fx5xM2b2+0h0oqsVYFAx0oaZAt8zFuNBqTzu9s7+Gaj1KF?=
 =?us-ascii?Q?qyUrABHA1NdqgGZ3J+QtQlV+nV6Rsw68DgyXS45GnO5F8fVmrc8ie1PhifEv?=
 =?us-ascii?Q?sD65zi9uQJejvs18DG1jY/ZOq8kczo16CrFZoZc2AgWbjVhJasMmFm3l4Mb6?=
 =?us-ascii?Q?SEua3PlS5bZmKllPGaGEON7sSmtkteKnA+xySiJUvRQ9iKDCgM2LSKuL8C8u?=
 =?us-ascii?Q?yKMDbaUHXKZjCTtcHJ+1D7PJYRR3sEtNFMvJ7EFH/obWiJlFnnlwi86nQOCp?=
 =?us-ascii?Q?QFH77bX9t37Rhii67hsQK/g+XPc9b0ZOhW2KAYV5+iMpn+yYn/7eS3s2jGM4?=
 =?us-ascii?Q?B0nBMpQIbXTJg1yk7KPaR7xteNW9Rnfd4sLAzkieEk1uJxxO34C3Hxlz7U/l?=
 =?us-ascii?Q?cWa2x2ba7ZeAV1kYw5+oq70vvneebiEjogGjZD2cw9SECgkp9usi5w/WDpr6?=
 =?us-ascii?Q?ei+RJt9lE/rRGMwbJ+rJeOSDybg6bAmPHOLyK3Xqn9rpT2zKal4vRpdg8WwT?=
 =?us-ascii?Q?iGvvo7UbSckKcqL6XuGF/N5T6/yxOGbahx4xU3Qy2M77pF9V4IPQTHonaVOl?=
 =?us-ascii?Q?4KKa5HDcjqxVNBjNldxjtJ71FanhOW3eIRCwiemDUGiX82K5xKx16B8/go+M?=
 =?us-ascii?Q?QHt3w+BxgQyAi/4RsRiJCoXmMEXQxhwky6IgWGQQ/zu1mrF5oSXoZtbInB58?=
 =?us-ascii?Q?kA22My7SBeLJZx9T+KUw2tzPwmwob8UfotJwpa6RTuy7e64wEzgYIHZ8PbYR?=
 =?us-ascii?Q?GRTSsAlDaLZ8LHF0zaqrULH4WYraYwj3oNkyIZyGi+WZbQlyozJtkK/Q0ski?=
 =?us-ascii?Q?xt7yEp+gQq5XjOYUMaBPCKmMqj7oUMXR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:05:36.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3a4531-022f-4ae3-030d-08dcb1485323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
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

Instead of printing GPU reset failed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 355c2478c4b6..b7c967779b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5933,8 +5933,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		tmp_adev->asic_reset_res = 0;
 
 		if (r) {
-			/* bad news, how to tell it to userspace ? */
-			dev_info(tmp_adev->dev, "GPU reset(%d) failed\n", atomic_read(&tmp_adev->gpu_reset_counter));
+			/* bad news, how to tell it to userspace ?
+			 * for ras error, we should report GPU bad status instead of
+			 * reset failure
+			 */
+			if (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev))
+				dev_info(tmp_adev->dev, "GPU reset(%d) failed\n",
+					atomic_read(&tmp_adev->gpu_reset_counter));
 			amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
 		} else {
 			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
-- 
2.34.1

