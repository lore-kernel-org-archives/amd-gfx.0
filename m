Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FB6CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FFF10E803;
	Wed, 29 Oct 2025 17:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RLUeu1IC";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0E110E811
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCiqyrgWHN7U5Yf7tubirLHTNDeJKIOTWvdvV3e9sENSHx0Qy0ZOcFkWp871PAY8AuvmHN2kiMcDOYcANG8hWPd72QTzCms3qHJ1MaO0V27H4qMPG15hgtghZoSnb3PUdnk+IMX8U2XxX7ycWjliyEyRNJ9wtBgo6xEY/inbXQIQgaPVI1viX50UXQwFbdKXewiaiTmNMEVJ4S+f2KAkH5/Fwr2SfN93ISUkdUSZvSjcm+VCZgTJnSePRjUMRaqY/U6qBOTDF6KO9U3/FYUgDH9cKpeBe8+3TO7MMQypwKmDuD0+XCDkIKR5MBvtPmV4jMlNa7w7RkGlfC6oWIisYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGbDQ3qjjNc2xnGK0RZrGgjEu7ncdsNIHyyE21cDXdk=;
 b=qRU1cZSJHR9LiV5aEHKkP3XXYaBYmFvyXNsvDS3B8BjxucACIGCFmI88WYmIwZWBPEyvIWcxbkVUPb7Uv4891bwmAeV0K84jvbypCKriC77kL6FU+ZnPsB1RTokdKZHu0brT3U4D4tuy+DGfr7UBiAzNngO279QlEvOfnFxOncq1lVostDMlrU8osixbfvfZ+WdJ538mDRcdynT3aG4dDY0YWNS6JDOLe0y7TSGehMMQNQD9P9TfS8mxOgfaDzpq/dwgHqYppGJxam8hxp/b2y1zWzO+nYd0Y/+lNkCf1BIrU+pcZMV0IEaQy9068BvHUaAP58igXEHE6n4E91ltwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGbDQ3qjjNc2xnGK0RZrGgjEu7ncdsNIHyyE21cDXdk=;
 b=RLUeu1ICHf7sLejqt3p6WzEBflQ3dgG0OKGsHyUpX0BV1ck1EW2B3Bo+3V/JyNPyZ3JdQfMesNj53+rMZrjX9mv1+S2vR30CE8dlZwmgzX3RM4emov3U86GM/eH5cgDFhPGhc5SxX5EifL+zhlpOOcg15gqo9Zvkzi+D+pMRzns=
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 17:52:05 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::76) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:52:03 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:58 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Verify dpm setting for enabling smu with direct
 fw loading
Date: Wed, 29 Oct 2025 13:51:34 -0400
Message-ID: <20251029175137.2861556-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: c82be568-cd4f-4719-12b3-08de1713de3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RVjWhrR36Wo0wDP0yXaxPYK53QDcNw9BzAn3KTGbrGGC5XHwlrg52VLy8IyH?=
 =?us-ascii?Q?fu9l81ZmXbu0+N7jQU0Kzm2/iCfxG711ZYqimtRuNYfjkF050Xjldbt0KIZ9?=
 =?us-ascii?Q?QplbujXMrtVzpbB817kdbYIugxSRAIMYWHMXWz3qCW9U9AHoFqxvhRHdfJHJ?=
 =?us-ascii?Q?Wcs7aqo08+EWSzd0Eoq30u34uf2pon4U78SgaPevjE8gVB+aW+PKj7AtV5FB?=
 =?us-ascii?Q?eP7/TC35MuO1zNWS7EfvuXPCK43ZHAPX7S6QTHUooTuMw+Y3f4uegvpMHIWq?=
 =?us-ascii?Q?dDy0vV9qWv+GZRCD4+CANN+kcnuoYMw+IfvzrAP+DKadGu92sBs8/Qp6q84S?=
 =?us-ascii?Q?SlLB1FvgoOuwjNZ9qdDyPeA1094KBFAayvF37pgKV3DO0hAemg06zIHYKyfO?=
 =?us-ascii?Q?z6OvgqsZ8IQrbzOi+rgJLCQAAf40Uo8vsZjcFBdRAVbVqv9UkWo2kyl5/2tZ?=
 =?us-ascii?Q?zuyvirF6fSWumpSBWHsTc8dQrJH/wysmoHWROHgetGugyz46520OoL377nTg?=
 =?us-ascii?Q?lU6xEoxrTnTnATTIfB67tN4bLJUM7OiiUyERD/EArGBmGM6wJHxvSXCQ7/tg?=
 =?us-ascii?Q?ak5Yn2u3MIrdKUImiLaJfeX6J/CqAFP2zW5mjP3aK77ov9kFWh1tBMyZuNkT?=
 =?us-ascii?Q?6HFpPhBUDCPqNB/qwppdgsFaVc4a4P3U0vDKALj/YQYr1MxfxFHe8RN4UmO+?=
 =?us-ascii?Q?l7M+FZwm7tj4tjzLMdcRsnanq7WH6gFXCuc2OXoz/pxDW+ni9ba1dphpcd+K?=
 =?us-ascii?Q?M++SlQV8STfW0tS0/7se2epHlbswy7eNzApQSESTVxdTh2l3JYWAKEd40T5J?=
 =?us-ascii?Q?p7/WAwAiBJ0xiFqpxi9AX09UAl3vfM/j30EjzUuO2KOqYDfn4DT/tgaVPCGy?=
 =?us-ascii?Q?GVvNOjBiMjsdp3L4sxA6TGX0m6Zja8Cx47TVDDv2gkXJhtAKKY0slOOYLiGU?=
 =?us-ascii?Q?JwzFYBC1dgIDolODznUx4pg1+WtTm0+LvYXFvfxI2soWg621D9dDAONAGZxB?=
 =?us-ascii?Q?SOL8GYDHg2fED/1sCBF8q/Spuv5caijWyTSjrtE9hjBHCF2OeWfVyojC5mcY?=
 =?us-ascii?Q?H28UQovmUcBcDGxvsfc96nlmYF27Csz81qmrHjJqCvhzNIPHfcsMB/fNGkTT?=
 =?us-ascii?Q?nAPwFLysPyRQOLAYP0rDceKgPRx3wnesXWdzL3nQVHBTIMI2IHuGI1f0aSG2?=
 =?us-ascii?Q?nCpq0Pn+JfXNJ5kpeJE+OsYvNNWkyuTitlgc14mwpjhy612E4Fskgih7BTHN?=
 =?us-ascii?Q?Qg9rtritr5F1NTGj5h3zeIjQZLCnhVyEkWQFX+v9SVbGtzAfSDtO8KmJ92p0?=
 =?us-ascii?Q?lvp2/O3Y7vqJbx61atltjwUj0ghV0g/HQnPMFtSX/LTJD9YNOOO2M7Kv4dyj?=
 =?us-ascii?Q?fntQDPpESYEpRwMBRRw2RBKb45EB72NlrrhBapGgGxS9eNVXN0JPDhI5qiSg?=
 =?us-ascii?Q?aOiXR2tleXlv9+jbpZSBHDDbCglNHUk0S6ollJdeptGwAresp98hYWAVfYuO?=
 =?us-ascii?Q?mPwYoenEbMiRYRtbkIi23AUzvRakbknTEIcyJacBBd1y6xbH3S3rKHPfz2vI?=
 =?us-ascii?Q?gHiaj+jJQx+CdQE+rII=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:52:03.3269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82be568-cd4f-4719-12b3-08de1713de3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Ensure that amdgpu_dpm kernel module parameter is set to 1
when enabling smu with direct firmware loading

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 87588d0c8a13b..9799e645b6bcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3213,8 +3213,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		return r;
 
 	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-	     !amdgpu_sriov_vf(adev)) ||
-	    (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO && amdgpu_dpm == 1)) {
+	     !amdgpu_sriov_vf(adev) &&
+	     amdgpu_dpm == 1) ||
+	    (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO &&
+	     amdgpu_dpm == 1)) {
 		r = amdgpu_discovery_set_smu_ip_blocks(adev);
 		if (r)
 			return r;
-- 
2.51.0

