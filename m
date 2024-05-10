Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B65C25B5F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 14:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A407910E35C;
	Fri, 10 May 2024 14:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NLITf0N0";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E53510E35C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 14:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM5o9nJhWS0PVzqiGqo/NoKQNIS+zda23dkIUEVLKIfIaPeTd1v5BakTkLWHckGfUTCIJQblJXRSWlUK3T48XhzfPYJIS5hsSKAKKw0UJUEI4a9ypg/9NPRcklfv+FEWCTELjO8ikg3iy+MLsPCKAGexVYgdzFwp+C3eBKmPIxICzETwAMBNt5fJN8JnQFw1iqSaOo9tPLN00ON/YT0MkAPgcg/EG3QE+fgGuxomxKb5MQk7krvY8/rQEJQiH+ZnTQmEtdSiQ1cTwgQod0aak4EQZbBXM+nMKMsDPdQdSe0pt7wpSn8aRuwba03sLA5KO/C9hzAC0hsl4Y9Zp4JVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLg0rRyIGV7t+5hv35/PBvzt1d8/YTT8JOobxSr3F30=;
 b=AgouXxpAfENW9VDoey95ZUbLcB5jzPIKgKRH91fb1AEYe1uBBPz1VB6qrDin11S3zg0x/dA+La6uveNmCKVb/b8jzGlYdKQ7e0GV5GUfTj6hhnQJeJzIJONSy+VPmWydcJU5zoQr4L35BqfvW7iNuX7hpUIvRWEivO3BFDihvohcjVsAX0sef25ytyqqncZFB2PHv18Okozaqmoa8Pb8a+Yn6x7VWSXLkyOoBtxZwxMexlGR9zX+df6FgACqO1F0vtcPilZ0M6XFksVDQWfh9V312ep4P/yJQ/52lm1K4UCd52CNhgLpHpWdjAbsqxo3nJOj6l+uKeQMO8+rxy3ZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLg0rRyIGV7t+5hv35/PBvzt1d8/YTT8JOobxSr3F30=;
 b=NLITf0N075fArQ28Ezlw6Nfnu60CoQ0L56KG6wEUqICW87waRDadjY75nQ/UirqFuU93HR+2ZkmBQhi3ln286QZJsU58vWxsGnr07d4WOUlh+bPG/7Gox43zWn/nLnYkDj6FXatro0dwLf0BkYN8pPSdlbNk1IzWPbI2+BVpUUk=
Received: from PH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::22)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:06:32 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::24) by PH0P220CA0004.outlook.office365.com
 (2603:10b6:510:d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 14:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 14:06:32 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 09:06:31 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Sreekant Somasekharan
 <sreekant.somasekharan@amd.com>
Subject: [PATCH v2] drm/amdkfd: Check correct memory types for is_system
 variable
Date: Fri, 10 May 2024 10:06:11 -0400
Message-ID: <20240510140611.536886-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b72ad8-cecc-45aa-809f-08dc70fa654c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T+oW6tI9xTsJPF2wXnQVf2vxmlQa3pP0VfdPXlb4M1Vu6zHZfnGE7XtZ4em4?=
 =?us-ascii?Q?YiDBxPHEjvrNVI3lAjE1n7Sp0nkqsvhdIqhYGiKM6LBgCLscu4Pa8HS4xQ/x?=
 =?us-ascii?Q?K6R8VttQbBT77NsovI3JCnTvro3A5syIPQiMuKWJ45/ZkRcKhph43aHxAnA8?=
 =?us-ascii?Q?cQaGRFM7hvhysJ7K2VhgJSRezCv+haC3h+O5IcicHbjxv9O1LN5ysXACfFHI?=
 =?us-ascii?Q?0yoEKD+SWryzZoRDsYMkxZfSYFDEFMNzOyDkSwljlk7Ni2KwnELtRuZjAFl1?=
 =?us-ascii?Q?YE55IYSFVy9Ps5FkbivXwc2SlZPTF9Tit7ICPC576x+bsLDqg7RkWCojt/8d?=
 =?us-ascii?Q?8sAuRIjj04hwaPYtYXak8E4uUUJPp+6Mw1DT6RWLUZz+R3aTrQra7eJEAovt?=
 =?us-ascii?Q?BAlJxcJ/ENwal67DFEbh6ASYJXTS7HkVjUPV8PNQR9eDShaVG31tDJYnlGZV?=
 =?us-ascii?Q?XKctEfVD1aUkQJp+aDAI/kye2v+bNrE2ujDfadMuk1FPZyqpgTvN9hrP4c6r?=
 =?us-ascii?Q?LJXx1Z27D6zN1PmYO3/9UEPfa2v+1qQ1JHS9r1wCZXvOigZdccx5x4UyezIv?=
 =?us-ascii?Q?Ym2jQVzAASGHXvMYtJrGBkLCDUvismoW1Gb9SRhAny/NPuxImilrOMsFOSB7?=
 =?us-ascii?Q?3t+bF8xvRdXN06og67b9IQOiFiOk/dbq4ii8495r4TO5CigHeh4n4GqIr+rL?=
 =?us-ascii?Q?wRRBLerPDUn0DNIQlIn716YhNsblVl6Xm6PIOYmQtM2+RrR90eBBuyGRyhg6?=
 =?us-ascii?Q?YW+vIlgYTCbMAEduKH/YhAovqDuLdoSIlW36/or2F+Z1E5A0XK606tjaWwyY?=
 =?us-ascii?Q?QUVHIe2MSGDSxsm0az/22nRouWvHecy3w2za3m4laRfvSpvcbf5oZKuAmAnM?=
 =?us-ascii?Q?kULUX3rLLPOW2IMCNvCGxpUJHDy8O3UKowKMGmgXh6yF8gyekqzqgYmhelzt?=
 =?us-ascii?Q?4r5UE4dknn6LiAO0ELIeTt5UxRq5ndEjjUQIAd6DLkOQ1oC2vIz9HOCYVgu5?=
 =?us-ascii?Q?ns8vcafEFoK1CqG93gTnYLjPob4po+OOVPqX8rGY0PCn31POqyEs97T4EvuH?=
 =?us-ascii?Q?IA/XWfVP+zw56w8Kg9YAWJvKADW5oucTeWYOxe1F34vsOf5WQtHem0IlbKuE?=
 =?us-ascii?Q?TLZRwfoFwqrr51TPv0Grxzl3Bg0gIKML63/FgnF7Z/I6VquW7Vyle1LJ0hXi?=
 =?us-ascii?Q?nE/iy/B11raU6wYr6gty2iNqXDZiOHMLGjA1iB6LN+DOa0dMjyXbf6XK+ASZ?=
 =?us-ascii?Q?2RGsOJCt5FHyD2m1/vxR1YIZebeX1tzd04pLV/wTKD6f6vIkZzJFbAK011aO?=
 =?us-ascii?Q?IHIxChIM30VUqsNb4eTm64u3g3sJHa1iBJ+I8ggWNh17k5uYS0e0zjdzyt7d?=
 =?us-ascii?Q?8uOh4c+r1aPXBG8lww3LoNBhlFkH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:06:32.2633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b72ad8-cecc-45aa-809f-08dc70fa654c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

To catch GPU mapping of system memory, TTM_PL_TT and AMDGPU_PL_PREEMPT
must be checked.

'Fixes: 3b01ca1b860d ("drm/amdkfd: mark GFX12 system and peer
GPU memory mappings as MTYPE_NC")'
Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index df0363ad1a51..6eb370609d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -495,7 +495,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
-	bool is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
+	bool is_system = (bo->tbo.resource->mem_type == TTM_PL_TT) ||
+		(bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
 
 
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
-- 
2.34.1

