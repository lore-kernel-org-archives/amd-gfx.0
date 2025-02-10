Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72CCC0219E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 21:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7399F10E3D7;
	Mon, 10 Feb 2025 21:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5sKf2fmu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BB610E3D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 21:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7oSWCDfoG34GLxDXgkz5Hy8nKm+ihP2aRjQMhigcjGrrjbJFyvy+DMfBrTBndmkSfZoZ6JIE8Ov8YwqfPAZuh1KptKcA+iEFW5xmFVpf2zFivPKu9tZCAA0I2k/6fYZtkNbg4MgZqUuGLtXi9rhclIy1WwI7uB7BfTAD8wLHHFhyyTuZT4WlZRzouYI2GQu/cPz6TES63D77vlJ1Ng+iFDq5Jsj7sKDL1ct0pt0AKXi1pZbdmj1U7NYC84AvcJyCwUIp5QHR1PKgbkYARi95DbTRQTQp9Dqwj4hw0wHqXLqa+uesqi5ckcuXYml0DeDGhFAesmSaqu1RcN7ATw9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWLzwUC5xRXd/YvJFZQDojlBO6QGm/xYEZqPy6p22X0=;
 b=DsuM63ssVTJmaPLcptqzAUiZOwqmz3I01Y0FCzOxmBiHvDYW9W6G714iF2rPLc4PLFqHAsLJqM3w75RMarmKxUyEfMnPrb7OCqn8quiXN2AxV+a5A7RpkiYunkbyqXB0c8oeW2GAV7z8lILiYRX3tg7u9w4T9dCDsRmzWzZTtLR6cYUEgykkFuD4xZP2qZSJbcOby8QiyYmJjvNyGW4x1EmeAZ4PC2pFk3BI1tdTcUf1n44uuORN5mP+sZxOCdL4LCNDcfF1kZylaH14b3wJQG5qyrv2RmKIznxw7vdq/6ZX/9K/DvqZotbVC0NP6gLrNe8Tc9UGGjDMIcKxGgWEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWLzwUC5xRXd/YvJFZQDojlBO6QGm/xYEZqPy6p22X0=;
 b=5sKf2fmuXoAto5/vgN7IaXcjXPDfXmUNoCf6iT/+2aUf1LobinkZrsTf6V529K6679cU/mlbwOEuA0K4/3w3T47foeuvOFlT5NO2g2qVt/WZRSzAV6Q7WDUZJlx7XgDktOCkQn8KwREVHQCyDThYjA8idyVGVcBx8d7/uH0Etig=
Received: from CH5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:1f1::20)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 21:19:25 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::3b) by CH5PR03CA0010.outlook.office365.com
 (2603:10b6:610:1f1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 21:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 21:19:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 15:19:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Srinivasan
 Shanmugam" <srinivasan.shanmugam@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes: Add cleaner shader fence address handling
 in MES for GFX12
Date: Mon, 10 Feb 2025 16:19:04 -0500
Message-ID: <20250210211904.281317-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210211904.281317-1-alexander.deucher@amd.com>
References: <20250210211904.281317-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: ff10459b-5159-4cad-447b-08dd4a18986c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWRXK1lrYk5ubFhjQW1qSUVFZTdTankzNXEyMnBVbGR4azFpUlNOWmk5T3lk?=
 =?utf-8?B?bFFlbVZ1MkdCMHYxWWxwcUdwOGZTNG8vOG5TY2dYaSs2cnk1elpwN3JsbER3?=
 =?utf-8?B?NHJhbmpPS25hSkNQaHJZdkFkSjU2cFI0U2NocHFrL1dIMmV3V3FTWGQrZFJv?=
 =?utf-8?B?OWFEK0hPMzhGSDBjcHdGdGFMUWk0UGhHTzQwWEI5bGpGdjVac2h2enZobVRM?=
 =?utf-8?B?YWQ2UVJ0VHUxS2c2ZFVYdnVudmxKa0psUWNPbmFuQ3dKZ1JyNXcxdVNrM01j?=
 =?utf-8?B?dU42UFhjRUlEOFZ1a29ndVdTVythaE1RQzhqbkI0V2UyRmYvYUp0Wmk3cWtj?=
 =?utf-8?B?clNMcjRFVW1zaldiY1F6WmJNY0x1dTVMRXpwdHJyZU9XS3dLK3U5VExBcWpG?=
 =?utf-8?B?SWc5RXQwdW1jMHFheGtIcUM3RUpZRzlxSFFBKzYvNlpsQ2hIOUJRNnpQT08x?=
 =?utf-8?B?YVc5MGk0dlk0VTRYUHdqeFE2VDNTVmZjSmpHdDFsU0d5MnFKcWJPSVJyQ2dz?=
 =?utf-8?B?Q2RNSUtMRDNzK2RidFNaTDd0Nmp3eEVtUmlqNy9zNDlpQVNBZkZpNm1mb3lx?=
 =?utf-8?B?Z2xTRk1ORmNBNUhLRXorY0RjU1liOUszeloyNDVGUkxhSCtkRis4NFBhOFR4?=
 =?utf-8?B?L1ZKVkJmeTRSSEdnS1FqSis2SDZOM2hrUjR1bVVBNFNHWkJQYk9kMklSSUdE?=
 =?utf-8?B?VmJjSUJLaG1OY3NhWDhOYkFZaHNlZEtzRm1ycDBMN0FlczJyb3h2Q1ByUGhR?=
 =?utf-8?B?NVhMemJtZzlpSWFuR0RaUlVPY1l2MmpCZCtsZEIraERsSktkUElXNUxXaUJv?=
 =?utf-8?B?ZVFvZ2M2QlJzMzMvNCthV0dCSkxEQVlpa2REM3BVNkYwZ2RFM1I3TU1YZW5P?=
 =?utf-8?B?MnltUDZOMkNnSUNSbkdVa21hOFB6dk5MSjJaSGI2RzgrbFlHaHBFVkszdWdn?=
 =?utf-8?B?RVFsb3FPWTdKZE5QL2pkYk1kRjlmM0lyd20wN2p3TmpTYUI1MEI0YkVJd1J5?=
 =?utf-8?B?eWUybHVLdzJIem5ST216S2RHdCtmdEwrS1VLRzZJelI1Z1I3RTdRT0NNM3A1?=
 =?utf-8?B?dzdvOVA3aW9PNWhCRjhxZnhTbHRzZW15em9MbmdXZGdwQ2ZTaU51a1FKK01F?=
 =?utf-8?B?OTY4bFh6ckNzdmJ2WEV1QjFaY2g5aisrNGthYUd4MVBrTjRqUFZVNU5MNTRD?=
 =?utf-8?B?L3dmM3dHUXZyd2EyM1pTLzBLOXlJTzI3QzJYRzJaZ0RHYTV0YjVQS1hORzhR?=
 =?utf-8?B?RnVCeFZBK3JwQUNub1JmR3lWclZsY3BLa0RobWloM2NJdjVvblhEdnNyQjQ5?=
 =?utf-8?B?a2Y4ZWhTVzMyNjNNNE9MQjhOc3VYeFExYVZRMkxZZHJ3MjIrQVFaR2V6VTlU?=
 =?utf-8?B?UGJZTTNQMmVMU0IrOXU0TUJyTlhWTlRrWTZ0RHhkMHpVYWd1TExYRlQ3UU0r?=
 =?utf-8?B?RkNPT0dua2tUbW5xU1RudEFCZ0E0OXZZZU94OEVET242TEtZbGVqTkJzREV1?=
 =?utf-8?B?UmNHcDNRODEwazZZeTlyMm01MXE0dTAwZVR1QVhLWnlsQnJoUXBOcDViWDIz?=
 =?utf-8?B?RjZmeWRjcWFEMkJtNjVxK3JUb3lZTTdnSmVEZmtPTENzY0w4SFNHcW1UU0Ra?=
 =?utf-8?B?WkpqNGNyNkxTSDJxWms1MkZMemFWUzM1VG9KQnFlbWxSQlJ3VTdBZGw4K2wz?=
 =?utf-8?B?UlozVitZZ2Z5MHd0Z2o2U0NkY2oranU4Z1VTeHhZdDFtTjB4TGs2bWlBa1Qz?=
 =?utf-8?B?eGszSXUydGs2OExVRmltRndGS1czdzd0YTJZZUk2bzJkK3lROTRTRUFQV2Fi?=
 =?utf-8?B?VnVQK0kzcVVCalA0RjhZd21wRjJ5NGNoZ1RBaEQxWnN0K0U0UkZyL2NQRHhT?=
 =?utf-8?B?bTB1VDhIbmZDVEFLVkhLanlDU3lBVEVIUGMyd3hBVVFKVWpFZ1llbFhpNkhN?=
 =?utf-8?B?ODF4Sk1JQTc1dE4xZFNXKzYra0dFeHdxNEg1UnFNL3NISDdpT3dOYVh1SytB?=
 =?utf-8?Q?7iy+UxcoVYLix14Jzad6Zi5H4wei/E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 21:19:25.2443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff10459b-5159-4cad-447b-08dd4a18986c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
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

This commit introduces enhancements to the handling of the cleaner
shader fence in the AMDGPU MES driver:

- The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
  KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
  that requests are handled in a controlled manner and avoiding the
  race conditions.
- The CP (Compute Processor) firmware has been updated to use a private
  bus for accessing specific registers, avoiding unnecessary operations
  that could lead to issues in VF (Virtual Function) mode.
- The cleaner shader fence memory address is now set correctly in the
  `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
  the cleaner shader execution.

Cc: Christian König <christian.koenig@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index dcbc31279f29b..8dbab3834d82d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,6 +678,9 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 
 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 {
+	unsigned int alloc_size = AMDGPU_GPU_PAGE_SIZE;
+	int ret = 0;
+	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;
 
 	memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt));
@@ -687,6 +690,19 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 0xa;
 
+	ret = amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM,
+				&mes->resource_1,
+				&mes->resource_1_gpu_addr,
+				&mes->resource_1_addr);
+	if (ret) {
+		dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", ret);
+		return ret;
+	}
+
+	mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =
+		mes->resource_1_gpu_addr;
+
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
@@ -1770,6 +1786,12 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (adev->enable_uni_mes)
+		amdgpu_bo_free_kernel(&adev->mes.resource_1,
+				      &adev->mes.resource_1_gpu_addr,
+				      &adev->mes.resource_1_addr);
 	return 0;
 }
 
-- 
2.48.1

