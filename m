Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94306C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 15:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA7910E327;
	Wed, 12 Feb 2025 15:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fixPKuPL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2C610E327
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 15:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLs0BEAMUnsgjOOdEypfBiV8he0zY2D0Uv9WY/Fm1hSeUguvhvK0y34rD4TJTrTvw4HpphLyA4+iHyxvBdK3VBMGe/7wB58QveuDMieD+CBiA1PNJYRgyaEjg9YwBFygJ++bf1GCSPvDcotr1AVMEOCJrbYOE6XJp1pg0xNszJ85s14RXetyGiwJam/du2jH+V+IcZK+ZkGFgK6rDe+Ck9kkzh2Pcn4bvv/sCc6eRwr+kuQFYhkYtt/Qarze6Ie0AljsHh/5g+RT7siWJI0KeBZDwGTLKsXuvIEF4rMxgVNGi6Gp1i5HDyxZYbJIFWDvlEKBoVOkreVrEXXtFZwYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O3Y7nGA9mnu6rnsBSRAlfRtL2LUSdMU0HfvQmWhnkk=;
 b=ls56knfPZ/XoQixD9jA9e3lahH7q/lWgDsNakRx5x9w86sM50YCEhJfNdYqd9N98EvJ+wA4Dj7AWxRb2vLje3pYd3dIl93jz0J+rCVqUB2zq1wHw+K8RuZpGikC8Fb3OiDYfhOJtzBtYAb7pkLp1W7fr79wsB5weuKxUItpyeLvmFGIvWNuPcgXtIxL9t6ZJLT40tfoShgflRPCsTE0CV748uthwR4ZJsIBEvTh7Loayf3aLLoEY1D+dxBXB9VXDm/DDX+h/vgC32dYsgeN0Yz8B15jd6mKamNjRyjsIBZraENSe7IKgocdBhnxn3O+eiuGTnaiqO104c9+nN6g0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O3Y7nGA9mnu6rnsBSRAlfRtL2LUSdMU0HfvQmWhnkk=;
 b=fixPKuPLY+xVKDko2r7L3Rm94xMNNto3Q4mk9aTL417FCRFf8nE2sPoVHEkOrB60g+SGtRbZlI14U7cC4r5iT60fkvpEZ2fPDx5shz2ejKHFrZoCpTXd1K5a8fbsoz61prlIoFvGTYUnJRkL8588Sg/JWGySiTQtX/S5drCiV2Q=
Received: from SA0PR11CA0085.namprd11.prod.outlook.com (2603:10b6:806:d2::30)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 15:16:19 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::34) by SA0PR11CA0085.outlook.office365.com
 (2603:10b6:806:d2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 15:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 15:16:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 09:16:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sonny Jiang <sonjiang@amd.com>, 
 Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/vcn5.0.1: use correct dpm helper
Date: Wed, 12 Feb 2025 10:15:56 -0500
Message-ID: <20250212151559.2683916-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cfd6bf-ab77-455b-2ab2-08dd4b78334f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iiUfPqbY8S5BcMpJzKPXXMjT+Dz0BLWYRxuoQqkojjYHJIGX741mnb2uXa7u?=
 =?us-ascii?Q?Wpfs36z0og1gvYS0ntSTLa6p2FGbJWbqUHtXlmROLMUAYii/1Xsy+GQyGxRl?=
 =?us-ascii?Q?BYEJUsaMhA9EcOEecao8VXrdhUqVhAYFfolugCeQr/UgA7z5ZFsUNp3YxdLx?=
 =?us-ascii?Q?6/HKE3PyT3oUcBmutPqfPBUHKUR3dxgeuh1E0FwIVTORfHkzFFoa6HQ+2Zha?=
 =?us-ascii?Q?+yexu6utL4F18jzKoxmmWlP3Fbxdub/0UN3KK94HNGRIB2C3rQhBenN1+NcX?=
 =?us-ascii?Q?US2IsNVR5BJYv74dAbsHyhicjxTuM4gkadFPeSasKbusso7UG2vye2c7JYt7?=
 =?us-ascii?Q?BrnzXDj6XcXhPeaFcVukhyIh8NhmfH2TPm7lKXmVwib8G+eFEU6H7Po+r1+g?=
 =?us-ascii?Q?pqzLhdjJRaHA8srulhMSsFoPye1zfd90Up/BTjC92GHSZUHf5CpLRnft7I6Y?=
 =?us-ascii?Q?v11mCYrYW3nRhwHPobB6a08GgiddQwbdSkSv4HrBhDS5SmdWa8kscF+RKN71?=
 =?us-ascii?Q?cIswtx+0PsKpFMekD3SUz8uM/0W50f47ov4Adv9twPIOO9G30QwXYvJxcTcY?=
 =?us-ascii?Q?M/u5o1PA5rLG/3JOT6RYaA4YFxDmFxZ+YqvKjxWw+J/OEL36pY9duBpsE9Xp?=
 =?us-ascii?Q?v6/LMjJ4rQjSlFOjGN+jRQH5bbUNpnZnNxoepVbV+wkPcfXHJnnMBB28VGsn?=
 =?us-ascii?Q?ahDY3B8l06mBoWuoB8dhqKTo5zJM15gjYtoQbb0PAtgetoZgRJ7iT/SMZeVy?=
 =?us-ascii?Q?QKCIfMRHX52GPrmEgIpP3UurXfkToHRCcONZgn2q9+gDugNCM7dYXCMhVH0+?=
 =?us-ascii?Q?ZEoQZMCxN7BWwibxNvVMbKj7p81BwbJjrkLXUwiNTO5Z3jPSQJsYzfBXuEvd?=
 =?us-ascii?Q?EvR+f63MjjaKhDG3/D3wlvmdjqb2VboDcBKnLZ6yUI3997cSlaNwSHvy+UH2?=
 =?us-ascii?Q?CZ+8Sm0Hyj5TzALjsl4wqRIsnnF8MbG9jHr9s3Z86zSxszjthb83SoYOk4um?=
 =?us-ascii?Q?7Hx2ApkzY0XQYDkD7al+3PM4aXvJkfd+b6+z+ugmH6CPPXyjqr22nBk8+GF2?=
 =?us-ascii?Q?u6ZlOSuJirkfk7QC7BFjOA7FH/KDLFyRoJp0uSdG7ptsaYd+R1kb12Gvk48B?=
 =?us-ascii?Q?dFg2JgETg9J6KK/LgiEMNfd4CM7gxkgjpLKyQfMhVhzRiHI1cHZRohu8CbTF?=
 =?us-ascii?Q?Kk8sldplmBasd0e+b5I4mWK68oDvduWwCoNZiqN6JE0twrGKe042wf6pl66r?=
 =?us-ascii?Q?F6JLZ9tMGiFtX2JNxfMuS+YjJO3JRHHSOsaWnZa9PxvXgRXtig/JWT0AZlXa?=
 =?us-ascii?Q?JaRQC9jV6rNW8FWKe2ZAzTKU/WboQzLGPk5m6Y/BfnZ+b5WZ7fqrILbN/Dkk?=
 =?us-ascii?Q?DzI8u50oAJEgS6hnN0x/heo+wphglJcQe6LA6uB7498SPBG2c/mAFHdfXemW?=
 =?us-ascii?Q?rEfY1DguZJyUadpFiv6A99WWQcPtSSQe1NYIqLaID3zSnYIa8dzaGBsbOv5d?=
 =?us-ascii?Q?VRR48WnF1TfTSTk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:16:18.4682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cfd6bf-ab77-455b-2ab2-08dd4b78334f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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

The VCN and UVD helpers were split in
commit ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
However, this happened in parallel to the vcn 5.0.1
development so it was missed there.

Fixes: 346492f30ce3 ("drm/amdgpu: Add VCN_5_0_1 support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Sonny Jiang <sonjiang@amd.com>
Cc: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8b463c977d08f..8b0b3739a5377 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -575,8 +575,10 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r, vcn_inst;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
@@ -816,8 +818,10 @@ static int vcn_v5_0_1_stop(struct amdgpu_device *adev)
 		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
-- 
2.48.1

