Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCE1C25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 04:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F8210E00A;
	Fri, 10 May 2024 04:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hymGOz7d";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F40310E00A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 04:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIQZUhKzO6lCDPwfiRS7zbnvB/fbhfzbex9gXu3Ilr0sjfuv6AwZ66RcDgihQvZZbzCaU6YTZasrCaOYUFm0orgsILd5UgFCITSDoU9VQddAWDPBsc5rsoP720iaupeAL6HPdNyZGAA8PJPd8igeWgWGRgZ1gz0pR5JA5c7Y28NDKt3UH4S92wG8SbOwDeepugijYuk55IcSwRliOpXyI6aPON69Ea+8Pf6hZgtaHTsA6d7CcCVwpOGj1nIbxL8Cwfm1d1mwgMjittVe/Es7lgCnmKZNB1UuT4GYvncpIzO8K0rAOfEFNvbuxzfLIW/MCdE6DZuQNgCBKi9PUhtxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w4VJromiKpWUcl+Vddsv8x3wRXd9Xzm4kQTF5xB7D4=;
 b=FcFIStmnKH2fOqWOC3/BMrWDsif+5G7Ul1A5eeia3iz6j2lPACgjTwJdnuWjaBO1q7u604j4xOmnAyBv5v0k+f7sp6BxJkSA+uB0Fu9+cQf6/h6dhndSE162sQ8qEhPwpOnclElb2WdwQD/SxL+rGt3/1IkfLY6Xsgf3PooU5oj0YNWLoZcJYNCR4TL4CsPobkYoMqAp1+sUxw9THTfkimQqauToId5a+RrD6BXUCFlH5//A+dA+dyhgQ8oiFOlGSh6ztyt3cDGIzs1NkWly5awwjaab7ZjoBMyCR18cTw2TC8ArXH1MVFkhOjhc7B66q4tLdou1u8csH/UON//BWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w4VJromiKpWUcl+Vddsv8x3wRXd9Xzm4kQTF5xB7D4=;
 b=hymGOz7dIFEIRdDbuDmOW4fJtpecDQFncSfqNy7TMHtw6ISAwZbbiZnIdcPflYcyKJuKsc1TPWtrqqcfTzXQEWiAa3ISfJybaicD0zw6iUPNHilQKZSmBBb1ur2zioVUQbuQopGgmGah6N2GHly77QW2UMWCt9UfvizcYR3qNSk=
Received: from DM6PR13CA0050.namprd13.prod.outlook.com (2603:10b6:5:134::27)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Fri, 10 May
 2024 04:56:20 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::bf) by DM6PR13CA0050.outlook.office365.com
 (2603:10b6:5:134::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.17 via Frontend
 Transport; Fri, 10 May 2024 04:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 04:56:19 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 23:56:19 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Sreekant Somasekharan
 <sreekant.somasekharan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 1/2] drm/amdkfd: Remove bo NULL check in
 gmc_v12_0_get_vm_pte() function
Date: Fri, 10 May 2024 00:55:40 -0400
Message-ID: <20240510045541.533908-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: d3047b3f-9042-4287-184c-08dc70ad885d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?petdXzNkzKzt40u36ReF8SytMtcwUYuC5Fzf3DD2Rw9pKrCGNWon6NgeCNYb?=
 =?us-ascii?Q?C9QxUMG3e32TL9s2yOmW+GkErGMwYcbNctWqCcgZLTcNQ0FlLHTTjzFf+o3B?=
 =?us-ascii?Q?5Wu5r1Q0p9JDW5f4QJuzlpRmJNz5r1+1Abni9+F4lWA5KV4Xdu4EAu1zXqDB?=
 =?us-ascii?Q?sFzYjlA8P4HmroajeifuhrR+2ttZQzAWo3J260u4lMecCuPMCgNuQM2ZdaH8?=
 =?us-ascii?Q?0HjYH4BSyCh/o7FpqhKBlgEzxzGoMP+FEsGtNKY0KpLV3GZF/m2saxoSTTCC?=
 =?us-ascii?Q?exAKEnZ+jAu/XkjobP3e5oh9jAfXh1wW1I5Kkw+sMU6KktDHvxZUQbBvjo6F?=
 =?us-ascii?Q?uISIEpuhEqh62R6Ewmkzoo4CWHr57C0/SMwP4xj8knIfVEGYo7/Y4guT4Eyj?=
 =?us-ascii?Q?UT0t1T1qhs4+voqxECUJo2/UTqUu2tA7c3/rZsV5i9pTvbIOE6pEcqQnRDuf?=
 =?us-ascii?Q?DNt2VlixItWiSISkO4h5rMtFOFT2K9tbB6iM7jAQmJhhYFAdt+MsfYtqWL6U?=
 =?us-ascii?Q?kzCJG5M15gonB+j8ne0LYyld4EkvJvpyM7FDdvARhSMv+0P4Qyjv4dD3/yn+?=
 =?us-ascii?Q?Jhkph3D9oP/XUxK5FD7km9L/rq67+tsgfwszDOrZ0pW1OtcEYdj1nnoiElOi?=
 =?us-ascii?Q?2OHFsetKG9HNLHNM24xJY4h9+6LnExdOccTfhhU7BVv5qi9AvVIQxT7TLuVW?=
 =?us-ascii?Q?NTLjCHj5LhTDkFqs96ZvJyqSo/Ts9NAesWoKLsKqZzd7s+anLv2/r301FhUQ?=
 =?us-ascii?Q?iHlNHin62tLtbISnqgvF88woD4M1mNnI/zNyFE/4QADUAYlGGEEo1BZEV6d3?=
 =?us-ascii?Q?o8leL/eyTrbXkj1geygdIoJcLKTcylIw6Z9SoDTVTXXVpcWlOfHD+v/2sIEu?=
 =?us-ascii?Q?v/WdfKUQlfJ2RFLBHt4M05zN1HYLJFbUcAjBU1tFdVXVxw1gL8TVLTni1p01?=
 =?us-ascii?Q?AjCRDF+jSrPXBpMpxWRKhZ1FSlPXzI6KYQZkbV0sq34fi2Llbksc3byOMV9D?=
 =?us-ascii?Q?jXS0Jqyoy3JYf7as9NNKU1F6XjEFe2hJWUoYeKuGaC/UlrAp9N6afhzJG9S5?=
 =?us-ascii?Q?zsUPMupmTQSw8pP2MPsHMash3SIQ02YBTSITeSbBmojKKH/dWCL7ArOfDHbS?=
 =?us-ascii?Q?CNx08Aysd6A6pHsmwpjoQcTaRuD3WnHsnEmBuocgmBtmRf5ZQsmksZIM8x2f?=
 =?us-ascii?Q?1az40H57YYVvHckPLIKeTlI+SqTn2G0vmaou8ILTkmx+ButnEuZ1Jk7UDD/L?=
 =?us-ascii?Q?M6RnGpmB05pM8GrI6ETn5kLwoxfwVDHftS+QJsqLQETvOWV4iRpAsc+VF5pn?=
 =?us-ascii?Q?JBVy2+l0OvXm1OtkfTi2Ehjc6Kkm194PXKyRgHV/jJ9+V1XdiGu+bD504Eaj?=
 =?us-ascii?Q?TyZBqgY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 04:56:19.8285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3047b3f-9042-4287-184c-08dc70ad885d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
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

Remove bo NULL check in amdgpu/gmc_v12_0.c:gmc_v12_0_get_vm_pte() function
to fix smatch warning:

'drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c:518 gmc_v12_0_get_vm_pte()
warn: variable dereferenced before check 'bo' (see line 500)'

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 5dcd55d390d8..df0363ad1a51 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -511,16 +511,16 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
 			 AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
 
-	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+	if (bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
 		*flags |= AMDGPU_PTE_DCC;
 
 	/* WA for HW bug */
-	if ((bo && is_system) || ((bo_adev != adev) && coherent))
+	if (is_system || ((bo_adev != adev) && coherent))
 		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
 
 }
-- 
2.34.1

