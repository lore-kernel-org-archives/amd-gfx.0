Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6969CD3B7F8
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073A310E4AF;
	Mon,  8 Dec 2025 17:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MLBErxn5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C0210E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwRqJTjNZ9TrSQKNO2b7RsKn0oMe1RAK5rfLf6YDvGA/oE8dgS9Hfp3sTaAisy1w+GBKA/RCMHIzZ97ixUP6SivWLk7gf2u7e3Q0Z1EiKGz13MUwN/CtQTehCgkJ7t+7bbIGpggztZRF2wMUp8aeU8E6QmdhXGUvAPC4ri6koGdgxeNu+SqhJnc6ckVxh50R8k9D4r/w8Kkg9NMGiFqwPyBffAWOGtLm7btXNHgafXt8GqJOuyQr4YYLhIQhcf2kdOZ1rJ6/WvqG5dbmK+W1sfMYkRlu+mNvEXvyQl9o4jNOip3wfFmXYZ81xDWqvM/1Ep9cJgdIkAwqOhEsUZA8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyoR0L930tiozzxuSjvi3pKShCmyI1HdTTLYpi4/cFY=;
 b=XD7hyN1nh7cnOYRa7SubnSOrRZOzNTWK8wwTS7rPV+MVBjtcl1gEO5ZgWvYgf+HDlI4yv/w6tHP1IkuNKfa5Smpz+2c4Rk6eHTpxiFucMLrKlNk2RagysbNKBnCL14WhzhVMfll/b0zjgyiIlcIoKQViCeAWbJJpFQdPvvAomKW5rsap2hYb5f2f/yYjl+5ESCweRRq1oB26uDQJh5XshLSIV15pKuD4Ptg6BYF++NttnKo4Ho7bjjEPV4NlU31mzzBod+7yOsLLZNFzc81x+7XNnxA4qL3pSi5gwFMqp/I/uitmG8LREV26QSz46oihC3UYwBwNS50jgO8GLvNTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyoR0L930tiozzxuSjvi3pKShCmyI1HdTTLYpi4/cFY=;
 b=MLBErxn5k2g8GyqZ1S+BZzYzADAdk85RRJTHHjClqHKPn2GqlIuawAoZqMo4UEGOs+Z4cr9ejCGVho9C8jSJ2AN8BHlSpTMwRV4jeRL/C56rQaIcETo/nclKY99asY4OpmwZKeT+KppH9l1s1mTebiIHU7NQpolbCYghTgcYUuU=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:18:01 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::87) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:18:00 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: flush tlb properly for GMC v12.1 in early phase
Date: Mon, 8 Dec 2025 12:17:17 -0500
Message-ID: <20251208171720.153355-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: b784fb0e-73d0-4ba6-9d8b-08de367dbd27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8JdKIoAiiJyov8oy740Z64GRLRnThDD9F7FaVSWSXWkhW08yVGFH0LwahZOK?=
 =?us-ascii?Q?GdWL4TS9buI1GUdlJcpH1JPeL03+l+pgyFkljqs9eUgSMEewhBvOdn6KGNtR?=
 =?us-ascii?Q?2u4i6+A6VGiaS3s2Rz5msAcdOBSyh7blI7e5okbhOiEV2C6O+H1RHCPWiT2V?=
 =?us-ascii?Q?7yLk5LpXV7SzY1gxJH2kgwRlX64bYvRpYPrgnjMi+vnDSDQbMmGMzWf+0K+M?=
 =?us-ascii?Q?z8mq/WgizGAjsPj8TC9vM8fcCSb1cbVwZImdt7++xiegSaWXnQLsRR1yJfel?=
 =?us-ascii?Q?aT0kkNscO9ogHGHX8QB3sK9f9ux5LLDUgSP1Dqw4YyJDMy/Pt0VmiZqB40D8?=
 =?us-ascii?Q?aFRexHYeIZmZoIvGysfcUvXDyQBuIek9bYP1HWZPPJaYdrPUIJuAeM8W/9q8?=
 =?us-ascii?Q?sf9bxOoXhIg2CrABKXaQ6GKliukgk3nQnKg1z/6xzS903nvkpMkygh37Ldjw?=
 =?us-ascii?Q?9nzvWJwH3/YMIV5QnwdZRoxoHYK7xYPmKSgPW9ZwEKyLnUk1QZH+VCa7smuu?=
 =?us-ascii?Q?EZPI4qJ1J0HZL3yv7ORnzgVzoqTrr/sXJEi/zEBifN2kUpl2n/EApfkssrtc?=
 =?us-ascii?Q?S/fged2pZlwEDfobj+bRgBQrHf6twewpR+EnrQYWPPxmvA4vDZ3o6rN9Tfvd?=
 =?us-ascii?Q?lguZ8bQDcfe0OBseRdxiLQfc61lx4qj83AO7zJUH5bws6bgrAJrTtVTsIBok?=
 =?us-ascii?Q?ZIk1IP7TQ1Awty9Wcn5Vl45D3LqoR6SnakISSunGB6aYmVIeUTJ2xjqW3gk0?=
 =?us-ascii?Q?jac0tiU8N8ZrbQuf4wl5wJhsfyOQacJekB9xemnP/8YLXXpKkQ+hKN8vfhCM?=
 =?us-ascii?Q?VDiuGGTJ0k0OeL743Q6ZSUfgKHUoqupgPO3CmCsgzoMUape83GNTDDdz8lvP?=
 =?us-ascii?Q?BATrA0oU/yciPOPBzoGxokrWkwllqNQsGNR34Rl+zJe9MV6vgp18ScV3b/Kz?=
 =?us-ascii?Q?Y+tWe1fPrJX4BW0qR+P9YONHeHYG5Z4bIvggcT6V2sFKjMdIMgtWKdOyCV/u?=
 =?us-ascii?Q?EaDheu9t0TOCbHDTv76XCe61SDsGZe3pVlG+uzhXqGKou0tC/A1ARqgs5m1/?=
 =?us-ascii?Q?dwo+svjWBbi9bsb+ejC3oOIdskmsyLKYvUHu8QvLypHnfu8NBvpV7O0OLhWe?=
 =?us-ascii?Q?/YqWypMJuKCFbJtQnivMlUXbCvzLtdfNb8FcLhIeAMe7GLJTVOf//wIJEa2d?=
 =?us-ascii?Q?NxLCzNfyJVhtk/a8q6UwVtOxGcsTIQJfFyTcXowEy7Y/wANPwh2UAl9l5GCd?=
 =?us-ascii?Q?0bwx7EasLW3KmtKFiuoHKWZBVhdFHRokATKg5g7rqeaNDxIDUpQIfFiqZ3cq?=
 =?us-ascii?Q?9IvmJTUK7rqwZr9pv2M3Dltk4+KpNYErrFJJ7842fYj+WgIyyh/HgNKFhYQz?=
 =?us-ascii?Q?hjwfZ6M+kaoeaCylgn0kXQT9X0LzyPX66GDVBtD/j8x8DRh3Bl6VKf2yq0GK?=
 =?us-ascii?Q?RX8JK96llL8h+/6uENlHW2Vj5d1QIAq6Aj+bp63am9Ra6/EK+QQ5Nq5KbHtL?=
 =?us-ascii?Q?sTwAszymTZjWEx3YZwwajrLre/wAou+P69ETmBfgXoS347Lj73XxznvCFRlV?=
 =?us-ascii?Q?MEFZfhuoTPvQ8JUxOgM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:18:00.4165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b784fb0e-73d0-4ba6-9d8b-08de367dbd27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

From: Le Ma <le.ma@amd.com>

Flush tlb properly for GMC v12.1

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b93b2fbc4a12a..8abacfa150a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2486,7 +2486,7 @@ static int gfx_v12_1_cp_resume(struct amdgpu_device *adev)
 
 static int gfx_v12_1_gfxhub_enable(struct amdgpu_device *adev)
 {
-	int r;
+	int r, i;
 	bool value;
 
 	r = adev->gfxhub.funcs->gart_enable(adev);
@@ -2499,7 +2499,10 @@ static int gfx_v12_1_gfxhub_enable(struct amdgpu_device *adev)
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 	/* TODO investigate why TLB flush is needed,
 	 * are we missing a flush somewhere else? */
-	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
+		if (AMDGPU_IS_GFXHUB(i))
+			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(i), 0);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 90c5159a5a85b..e63ad5f18a8e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -974,7 +974,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 	value = amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS;
 
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v12_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
+	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
 	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
-- 
2.51.1

