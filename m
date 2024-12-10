Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DE0E77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C25210E9FF;
	Tue, 10 Dec 2024 22:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="noBsKtlc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763F310E9ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pw74d4ayE12K2r5GFd/FzJF6P2cXID3ZVKHn43J7zvHceqsCLJX8xfxnUkNl7gJ6TXo6wbFF07Zr5+PRG78Xr4oSpUayy7Kk5iz6ioFYsaOLfFDST1He7vO6ljqf3b2PDXT0V0a00FdgAf1EJJe+16Jz63sscK606q3iE4SZzqVdTnKhsDxNtcnHh/9yglZGHVbauMprszjn/vfE6374NMtz3zS7ik0Te/Zvd2CLdc9nlM1Qfy+xTFqpd6G54kO4pWc5LTBQDCvmTvFtB5OJUvWR1m3F3vbl5gpvOCHrgKJieDK6ZwfbIMCIevfcpiWD1J1uekVTkh6ozmaBQgUFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5c/24EFVmvFIjHLKoYCPDSXQEAlNTzZfgZRp4cU11g=;
 b=dyhGeIigT0+ef0CZ7g8CsSCDcTDRJuz/XWsiH+chTrM/J18yBV2VBkgXqZxu/OH17nfo56DoOhta1TNMareWTt5ZxAuDYmrZ5sPfBFeOl1bAdKW6O1YJ50hS+n7Rg1C+ZoA0SAj81W385jxpTccZ7akYZM8mAEJ+a7BnYBJg9AtdXbOZC8dgNZTFSYO1cHo4BqlK3qylYXX1l+XJ9krGVg2CZHXdnf7K3JSW71c6rUpwyAZcyYxQEO258dK4Q+HL1olONkUfJGx6rFXDwDZUxfn9ieorX1uMxeQbMnAujI2cOz6uWTCnS8DTOQyMc9iIMw+GzfLKXFK/hOoo7ImaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5c/24EFVmvFIjHLKoYCPDSXQEAlNTzZfgZRp4cU11g=;
 b=noBsKtlcSan44SJKMjXRToTfewgNtrnKPhfR1ltEOLUwZHEs90QFWl0Z3S1/+X6CPcqyeTX1souuO4Hcap/gqT0uI1xNEHaqw9Nk1NkNl9PslYjMwhRy9w7cBG8D3dz9heVVIwcDWWG/g2w6BYJx5Bni2jZUpdb7XKYrlGWpge8=
Received: from MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31) by
 CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:54:16 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::36) by MN2PR01CA0018.outlook.office365.com
 (2603:10b6:208:10c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Tue,
 10 Dec 2024 22:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/48] drm/amdgpu/vcn2.5: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:25 -0500
Message-ID: <20241210225337.75394-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ba25d5-e213-4ba6-d6f7-08dd196d92d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4xGI1/Gj21V1k+nDx9bhYj1zZCqM/X1zvxI03t/DBHgGvMjebY+/CO7JjsGj?=
 =?us-ascii?Q?8vsNRvmbGtScCSfzqyhNSw8Zv4tsJS6IfqAadT3e6UnRErrb5KqCTQIkaDyT?=
 =?us-ascii?Q?vhStCbtOwfNv/Oqzqh69DSvyddTOmaQeOuHHBn29I8+o3/HrlkvjL2170+5Y?=
 =?us-ascii?Q?XR9ioC9Nj481z/txpXFKCK2UwlGZw1bhnG79Etwi+Tig2LzZKq5ccTAt0Hnq?=
 =?us-ascii?Q?bqqENWm6Aj27oyTlGt9b2hbG1hsKUzmKicfiy6WIKrw2sDHyJ2aDzHBg8BmW?=
 =?us-ascii?Q?03MAJ4gfKvjqdaraOUewXCd/STvt+MFNeabmRQzbCPBMVXaFM9CzQV2eb+o/?=
 =?us-ascii?Q?+zwAnBNRM69Wna70L5qhacJ++i4axZitTuc/zhIUPk73zco6F5Iob5VjxOQc?=
 =?us-ascii?Q?nQtSBWZUSw94Jpaq3eyi4yZQGUk8VXsxvAVDTZ4206kAVvX3xf6KIYF+iSq4?=
 =?us-ascii?Q?utCDVUWgAW9jVk/uWIpO89y99TENz6jWDEFB+CVKQ7N/V14bS0hn2mQEc4lj?=
 =?us-ascii?Q?fGi9wHw+7uqroimOGqEjVY4CpCniP425mIDDO0dXgPLN9t5YTj1UfxHfMrNw?=
 =?us-ascii?Q?zMYD0dYHFh1NWCGNrRqToqlK1dwhVIFLGaOlCt2YfkWux+ElyLifalEn1p6U?=
 =?us-ascii?Q?UmFVLI2eeN5yuSzXzOr7q0DMtzMa+nDiww9jIlL9EnFRRDazjb3q9lM8YIXX?=
 =?us-ascii?Q?oSxfiWgVOwNnlYOAD8uUoIKRVOL9R9xfoPL5Xvbu3q0JMtc5p2G82s80OlGR?=
 =?us-ascii?Q?u1vpKew2Rd9Q/34NM5ScpC5J6msrOhF4ecVBqRXlWuovFfYaTAZR0rFfoAmD?=
 =?us-ascii?Q?XtO6e8d8V3NSrZhtzx7AxpirsEIj7jFIU33U9UkrLLBkn3geb2NIXHL61MiP?=
 =?us-ascii?Q?XP1UlEzsLkhaQwD7U8a4u/XErVWawyYkdaNWj6eY8sEJJCKHjKMOSrR+CaEJ?=
 =?us-ascii?Q?qbRkhm/s1OpLiV++v1qL1bYgZAPMKb1FRGQnKSEHZXAuSOXZaB/OZzkyOPBr?=
 =?us-ascii?Q?hVSBD0PWmtdHUxkk25C96ODAcgDi85bxnAVqkGtmb98laglxX85B8W68AkHw?=
 =?us-ascii?Q?TtkgiTOb4EY9hGucOP4f0HuBWw3HcWrIK/LpRiRqddKRFXd4O5nSvlgEddrK?=
 =?us-ascii?Q?ZYhGlSayR72ucsnXcEXaPbvSPDaCM6AK/rRINajlyC9eX40JCoA7LKM0lYIT?=
 =?us-ascii?Q?00/KV4nErkIP17QSa48V036Oi4y0yWkthAQDuX2fs8MLvLs8229/1PymLuSU?=
 =?us-ascii?Q?a+btsyx0I1MkhFg46os1n8N0nOcG21pof5oksL16ZCMo1eKKHtSfYGNix9+O?=
 =?us-ascii?Q?D7K68wqsHILAP59Mp0spxkuhMwYwh+OUrl19Vb3JosmFVcVp33MqvrTgV8No?=
 =?us-ascii?Q?CaB+1m/zQgcYXgt9yBJkAjhU35JAuNbpFmTiSETKHIa4MtBgwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:16.1733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ba25d5-e213-4ba6-d6f7-08dd196d92d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index f5889d1bd0d4c..9229b6dadbe32 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -97,8 +97,6 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
@@ -1870,21 +1868,6 @@ static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 static int vcn_v2_5_set_interrupt_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -2037,7 +2020,7 @@ static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
 	.is_idle = vcn_v2_5_is_idle,
 	.wait_for_idle = vcn_v2_5_wait_for_idle,
 	.set_clockgating_state = vcn_v2_5_set_clockgating_state,
-	.set_powergating_state = vcn_v2_5_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v2_5_dump_ip_state,
 	.print_ip_state = vcn_v2_5_print_ip_state,
 };
@@ -2054,7 +2037,7 @@ static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
         .is_idle = vcn_v2_5_is_idle,
         .wait_for_idle = vcn_v2_5_wait_for_idle,
         .set_clockgating_state = vcn_v2_5_set_clockgating_state,
-        .set_powergating_state = vcn_v2_5_set_powergating_state,
+        .set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v2_5_dump_ip_state,
 	.print_ip_state = vcn_v2_5_print_ip_state,
 };
-- 
2.47.1

