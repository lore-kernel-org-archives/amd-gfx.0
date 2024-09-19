Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E70CF395D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 16:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89A310E0A5;
	Thu, 19 Sep 2024 16:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nF7RKBLX";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4736710E731
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 16:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxD2R4OdAb2tbIbzQspMWWg7cynnUz8hPgy7Ni6ihApev+jCvZCfvSPg9DUo++9QL3n3ls1/EE8HeiJZDoWScj7lGCobCfS+TllmCz0HpnzgW1VXKbTdcsRPtpMzhAX3mK5eAjACA2yBjfwSxK+1BrgRVFoT6vk50E0g4+1jCz3pVCrWSI3OKOup5BOrjkji+juopevsGj4p8Bv0JLpSw2S9UA9YjXX8/xjJ4YCvX7NUxSYgX5aS6nO7ZwuPHUr5ndn/72BVHnRpHzL877JHRaG19dvP4ZXiJfYFamgif8kKXWuCrbhw5EDNRibAce4Mb1pTJTe38tHrTEjzAFnM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ5A7HojGkbmnGY0CNRXBKgcy1BM3VM1ZMT9i9rt1Fk=;
 b=Q0AEAG/AbzwuqWNGRv+mtgWdwPke2521S/2o7my5LNB78ExQGAxTJlS4LIdMwxdfJQVEcubxMq3jgblC6bq4mGG0eTGVSop0EdzD6UPD+hNq1EuiiKPUgoQAhP8gzT8+QrT1IwIQHDRPFPwN8GsB4h5qLkJtmypCwGV9WNx6dHmuFvdOXCEvFWH0KrOLotsv8ie3PBiZXjXFvXXneyechnAG3chMQpceET6ebzj1tgrB9fOWHPnIa6lzQa98+YK0So5ffHgSMybkgrQk1YaVrTAwhLzbVxtSHW/cemXeD+CyUia1tVriQmHTdUBSx6hK5GuuyuoZg+RefyjywASkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ5A7HojGkbmnGY0CNRXBKgcy1BM3VM1ZMT9i9rt1Fk=;
 b=nF7RKBLXQQlx5leU02T4oCxCa3knpsXYNRHch/AKbw7koyGip51EXgLpXXsjZSzD1fIQyWBDCAiY+AgWsNnxZYXtHFlkfjNNg0ecTkNe2+azcAL5hBCTm7IpdMbze6PpZG6M8FHrAdSrqSqveNxfui4nXquh7ZRGHStQP3ieU98=
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 16:47:15 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28 via Frontend
 Transport; Thu, 19 Sep 2024 16:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 16:47:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 11:47:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx9: set additional bits on CP halt
Date: Thu, 19 Sep 2024 12:46:59 -0400
Message-ID: <20240919164700.2579011-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bd8905-3975-442e-b0fb-08dcd8cab76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0HeatUrnB+G4GP+ps/8t2Q49Hm6rKdq/eYIbnpNj5EWiDAzSwjdHvrLe7C2o?=
 =?us-ascii?Q?abrt5dfNCEJpApBgwFzk5xH4hbxlMTQQWs9xTwpMxnCRpP9FuLv6FDOjIVQL?=
 =?us-ascii?Q?hhyIT7wUw+VTQFSGYH5R8KQ6JaBaNyK9/DvVwtTRDLiElO3vq4qSt/jGb78I?=
 =?us-ascii?Q?s+dv5FIXnYJqTCqMrcVex7bFhGx+3aZjvchoLN4ZEz1mctdYl7PZKwJska3/?=
 =?us-ascii?Q?FfiGX45vXIqYSs8fY/uda7BT5X6WBSYsk4Sg0JCEB4BUvFes1wEkzFRr1RNv?=
 =?us-ascii?Q?lYoNc1VigtejIa4llyVMGqCB2QdJNwO24oIy1Hs28VkiqFQoJ/8nPp5Qkc9N?=
 =?us-ascii?Q?SsrIxvHJLoDwDTgAwwTkYzpXUTdkOwGJEA32zK798KujYYBJhj2TgD5OJEKW?=
 =?us-ascii?Q?lS6xwbfT5jZE8moiz+GCByIc0BqdzJTezuV5zerb9P0Fl/JPTepZGBxcNtph?=
 =?us-ascii?Q?TBPjLqoYlbwdSz9fv0jVtTKxnNSUUBmyW2H6vmFqDNii4mPnPTu8jvWwCEre?=
 =?us-ascii?Q?5VxfywHlCZ2Y/eaDJ7pztTdvvbFi/chjgVLnFS0PBm2NL/SHJGx/rfQThEBJ?=
 =?us-ascii?Q?K8jrTy8TAAajf6RvDxD1dhgBRPcL+JFzp103cs0dH+Ioe2TG2DkQ0vrT6k4v?=
 =?us-ascii?Q?aWrH/B2HkvfCzn6lVViJ3UmMoY0N4b07vMOyRoFUuMpJNqhzO594ClgKXu28?=
 =?us-ascii?Q?5WM6+4A3SWFqrXtZsh6JK1uyEhjbZ5lrM3ws+3a+8u2R5yU7njlOWqeoJ+81?=
 =?us-ascii?Q?Tye0W4qkD0VtQAMla8JasW8P+S3PXBYeKBRSiw/mevnlBXgG7duk5ehTfvOy?=
 =?us-ascii?Q?ItyE87D8Mu8Wn/k5aN7Oyx3R+OVuFZdsdpm4xq36wr8AVNxN4hSs0aV4U+Kw?=
 =?us-ascii?Q?jP8qoQpHVH+NN5ayk3Hl2cKdO5lDpd6sSQfaF+HnOMpLZpHDxwbVPRtL2KTC?=
 =?us-ascii?Q?8tN6CL8HTtTXNGLCgrLFgYi9J8wEowEG87AHanl0y2IwRFIOF4698qXtU/QP?=
 =?us-ascii?Q?jt4elM/2Z+ZwdWPDqxJbiKVLV6WoxoR6yaGmQTouB6PZLrWhNndSHxy+85oi?=
 =?us-ascii?Q?SaAy7rN7o4tpFsCDvkUVEIAVuwYvz83kokz0UfZSkk1n3S+ik82kklvhj4jo?=
 =?us-ascii?Q?iKRoeEU8iy4eLVooNVw684dnlWTiOenbz28FQh0fbwpoSKcPb3s730xi9a/v?=
 =?us-ascii?Q?xKPn9f93NalipJ54IcimJUalg0sGo1VGsCUMqsxJCz8WsgkCBYB7b3DwEC5C?=
 =?us-ascii?Q?1+J2bjcc6COQWt/ragm2wJX7r6nb5ELaR8ngaG/fVZXlW+llXxcPiPkePrYD?=
 =?us-ascii?Q?hlo+dHRiuXF4/3z1TbTRIK+/Andfnc5MHYrOiJgNYTca4aNVDlO8uo1T2CiW?=
 =?us-ascii?Q?hNf6mYdDB/KJeycxcO/4hdXALnWQUyQp+h9gh0pFb0Uz4H/YdXYryFa183qB?=
 =?us-ascii?Q?uzf1DGysmTgIWeQWmYsDizKrPPSnqNQy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:47:15.0839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bd8905-3975-442e-b0fb-08dcd8cab76e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
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

Need to set the pipe reset and cache invalidation bits
on halt otherwise we can get stale state if the CP firmware
changes (e.g., on module unload and reload).

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 23f0573ae47b3..d4f19eb8ff6d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3184,6 +3184,15 @@ static void gfx_v9_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 {
 	u32 tmp = RREG32_SOC15(GC, 0, mmCP_ME_CNTL);
 
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_INVALIDATE_ICACHE, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_INVALIDATE_ICACHE, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_INVALIDATE_ICACHE, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_PIPE0_RESET, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_PIPE1_RESET, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE0_RESET, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE1_RESET, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE0_RESET, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE1_RESET, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
@@ -3393,7 +3402,15 @@ static void gfx_v9_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL, 0);
 	} else {
 		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL,
-			(CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK));
+				 (CP_MEC_CNTL__MEC_INVALIDATE_ICACHE_MASK |
+				  CP_MEC_CNTL__MEC_ME1_PIPE0_RESET_MASK |
+				  CP_MEC_CNTL__MEC_ME1_PIPE1_RESET_MASK |
+				  CP_MEC_CNTL__MEC_ME1_PIPE2_RESET_MASK |
+				  CP_MEC_CNTL__MEC_ME1_PIPE3_RESET_MASK |
+				  CP_MEC_CNTL__MEC_ME2_PIPE0_RESET_MASK |
+				  CP_MEC_CNTL__MEC_ME2_PIPE1_RESET_MASK |
+				  CP_MEC_CNTL__MEC_ME1_HALT_MASK |
+				  CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 		adev->gfx.kiq[0].ring.sched.ready = false;
 	}
 	udelay(50);
-- 
2.46.0

