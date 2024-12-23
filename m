Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DBDE7718B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 14:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F362F10E267;
	Mon, 23 Dec 2024 14:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iipFqhfp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B45810E267
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 14:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpYc81bYJSG06lFQiquw/KabZLejhtsPtu4gWKPvR73s7DkQg4m4ngEi08+DV8AC+c5oHNaxyXxfVoyUHuBqGknmvViWHyUE9/XKAbCujf1kno5zL1KoYadcMJ3/ZMQL6mYOpJs7I7CQm4KIu2Py4pjzsOjikz/KWtpLr1wcLd9hSmi+VZxP5Vv8/VXboed/O216PT42UyiSlZkeIXSMPZltKWyIS5BNRR6BL38BH3iCaoRNOoYpIzxypKhVx3jJinRqvihuKsSVBqmAcQjn5rVVBjBmlpqOCgeDF6i3aTV4mJlGJTPjCv2V73lZrLBykYni/wXHRVyPXb9Yewf5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6Y7diUuYYOjaEbLYmCXr2XAE4GwjT3lw7i5bwc1/I8=;
 b=WonuU1LdY1lqW7Jbc66I4I49pjIbGbgBIzQlEjrQ5KJ5M9EfwgMOPO7zjj61qId3uWjuoXdgNkHgAZGdFNMdz4YUTlQPM1ZzGff4iIE14wJ6JOlSq0H7195omX7oWLyFb0u8VTNOxcPo9ctmhyI5gXalU9au5Vrj8yWwAPLfdJsge+J3y0Men43+gj3yD3HIY5JnlWLwJLcXbiEwxAErzzmbdoAQR006DNBgOED3pnWAZa2u/r4hB+6qFllqIGL3wdOo9ktSv9FfEUii5WmvqQRSkc9OrCUtMJC5mNRYvv9TzjDfub2O4jbY4Jvdv3c85wl49S/kdmazxmiJ2CrCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6Y7diUuYYOjaEbLYmCXr2XAE4GwjT3lw7i5bwc1/I8=;
 b=iipFqhfpogWbUry/FhcQFId7eU5QG4U8bSlAPyc7kZeWoVd5reVD+D9xmtjOM++FybouSg/ZJnSZxYp81z7bz0oRsI8GdG8+R2Oh/QgjRY/r4BW0/45gKdnLbYAXHxMN2KRveTnS1Q1LKWVHKmFpt7t3j51+spZs6mYMKW7LtN4=
Received: from MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 14:29:50 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::e4) by MN2PR22CA0007.outlook.office365.com
 (2603:10b6:208:238::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.19 via Frontend Transport; Mon,
 23 Dec 2024 14:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 14:29:49 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Dec
 2024 08:29:49 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiang Liu <gerry@linux.alibaba.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] amdgpu: tear down ttm range manager for doorbell in
 amdgpu_ttm_fini()
Date: Mon, 23 Dec 2024 09:29:39 -0500
Message-ID: <20241223142939.819712-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 37612a6f-2694-4427-ec90-08dd235e4200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TpRSnaITru1DrSRnU1tval8IzRKZOd4XdB0g29osXwnnz3NXMRTXs6x/84yP?=
 =?us-ascii?Q?CN2BvX6S4LtQHv871oJErWdx0+0WWwP5BDM7M/K+lzor7GKYsA3mUGPcrQBL?=
 =?us-ascii?Q?1/XDgvyUoJX7MeUKAAosSP5c85irw115YVccsL3Jjn0d9jNiZV9FMak1AfI3?=
 =?us-ascii?Q?m8s8fSEQj70Q4w0EGq03iytzKD6xiAIRPP07wPxhAoYe9bzcJ749jTyDZBGD?=
 =?us-ascii?Q?JbNwoLuJL/sPBIJLOtUSZXPPGZpD/m1BbYZyvQuyMdK/dftM2hIiyGV/nmBg?=
 =?us-ascii?Q?j6W/DQJrk0i/XKTzIFRQWf5Km+9t7FWXDSOv7aWBCabYYHfpLD+Id1qH+PkV?=
 =?us-ascii?Q?uqF8j+iatL0dWBFJAhTuHUzD3OnKJw6+ElviHeQW95IC7z5f3vBHznWFOLFz?=
 =?us-ascii?Q?g10tv1sbs2vD9tBkYzK0WeStO5NxEw5c88ChJ6cI9DG8eq/KbgBvPmvAZ54b?=
 =?us-ascii?Q?bFFOt4xrfSUVLnE2G9GNLdEcQI7W6q91hTTWehT745PyzwYnqA9aGH0mSYgw?=
 =?us-ascii?Q?SoGRibP1hMwRrZXfX5HbfP1JONvj8CKlexMPiRHWeLV4KQvIfMr68Ge+Gt6u?=
 =?us-ascii?Q?BcdfVhxwoiFj8MxKPQHrkdv4qTAIWIsiY8YRWS37zJC1i8m8Fpc1ZszuK0QF?=
 =?us-ascii?Q?ZO9q3zfAYuOTz01oKFW+DLfYpMKhSGFtbheuHxMVZjRK7+Dj7Qz5TSl9KHbd?=
 =?us-ascii?Q?bUuGvKfQCVWHJmSI5a29ezXfYantVB89CKIEwRh2gd3JMswDmI70YWWqm5+C?=
 =?us-ascii?Q?gEEI+u+TXYhpnDkgvs89ZuOVRmYMzl6WWAm4dzjwEya636ijwsFA8eW6Ljj0?=
 =?us-ascii?Q?6LKN3HFl+TX/OB0oyHWLjrmA6m5sCJLNpB0CLe/+FcolRLIjl5bde+ohQ+Yq?=
 =?us-ascii?Q?VfRYuE0eRfn+hVJ/6+Fb+Gh7ioPvApMyMrayTX54VKZ+cgqVZRTjx4L9zznr?=
 =?us-ascii?Q?YC1L4s7hqnh6e2pWiMsRs6ftQHEEQEk3mzOlQrpu6ajAEhJcvmlnK7+jKqzj?=
 =?us-ascii?Q?GTK5oXYGv4pUbMiLJ92iCzSKjqHUTMMjB5eFKLf3O8EFEt9gN9S26Fnc5LeV?=
 =?us-ascii?Q?r22Jkeo0s3CR/JehRxc51oIm9CJdldozB1r0S5S6YvhmAe/66P1L5MgKkwZ3?=
 =?us-ascii?Q?zrxorDALhjMepBPObCNKeu4bMGe2Xc9zemairb0+qL6xbeRlBPngb+wj9sIb?=
 =?us-ascii?Q?FnX2jsRnHjM0OZlAQeyI4hk+dW6Nu1mYwZn0lZkxHybG+HvDifwFUPMI9T0G?=
 =?us-ascii?Q?9sYKqMPHT28fRvTjpZl1yV6zmeaD+Uphd1scQ/lU8ASjdHTWB9W/PeGa3aj1?=
 =?us-ascii?Q?W7vKjSGvxOQcSOe6LkgnsVapcDOitWWmmp6/491Pbh2F1H7SHACrN+pjA/o0?=
 =?us-ascii?Q?/tiOaB9MhjbTWOtL/RCfXtu4ZIFvmKXFNahgbrK11WVCfieqQ+PetQdqMKNl?=
 =?us-ascii?Q?aAj4sHFzMPIofAWdoelUVPUNflBkgPkvNjbULw6U30iq8B2aWjNsFILUdJP+?=
 =?us-ascii?Q?rpdNRypias1Rpkk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 14:29:49.7108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37612a6f-2694-4427-ec90-08dd235e4200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

From: Jiang Liu <gerry@linux.alibaba.com>

Tear down ttm range manager for doorbell in function amdgpu_ttm_fini(),
to avoid memory leakage.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9ff6cfacfd34..e6fc89440210 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2066,6 +2066,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	DRM_INFO("amdgpu: ttm finalized\n");
-- 
2.43.0

