Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F44C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FFA11A8D7;
	Fri, 26 Apr 2024 18:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkfmFo2+";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E12D11A713
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7qf/MioaNxkK0UfNet3XPA7AYel02YF6KY6Ogmvd+UswAIonzNOzA8h4ttD8aceGfjs3KiXaXBVKoYD3d0blCWk58fYel4QVMoltr152cR0co1xGY+u2bUmIaARUM0RTJeXFiEL3pN2aPKwNi3lgSfVFD5GCuDOyzEHWYhz/yl6w8NjpYtl+TtGgWEaPNSths55D8nR114O/lM/9O21eUrzwbPqABX6Ng+dvuPPlw+QqmlqwVNYwFHCIF0hzozRPTnKlq4SdcCpfUyyex1TjmsCwbnO4AZr01PbVMcC4f1FPVznupDxke2IliBMJ9mjB50P/w4L3u0HQsSqxc06qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1i1HtrBDr/XM80+mt9KroP2AXcd3w1BAiB/hvvByNA=;
 b=JTjtS8BT79Q9Lq0w9qk0qf6OoTPwi0EKw0/LwPU9fh0sYHPhEfGcB8xnNckvPfrL3QXOqYM0bIDj8p31iD0HZSNsrY/UYUTcdo+xGzrDlqdyIskdMUWRqys1q4fMc4PXRHvEik+r2sCiVlcPvSYfrUghhyR19Nzi9/juT38MDl4r82+IJwRq0fyAWQTSiUxuQqK73sYVeHBWg7k28FFkV+YPGwZHLnWewVOLlGJPauu9TGjFZ5qwK4jbkvDEFbpP9tyzdcU8/qVLr9R+B2GdEIDNQhUR47sH8kabG3F/YG7c/+Oq4XdHPtrrPp7qiNmsikwoIKyfDf/+XSlAUiAXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1i1HtrBDr/XM80+mt9KroP2AXcd3w1BAiB/hvvByNA=;
 b=bkfmFo2+tvHJPZwMBQPXdw62FUDE5/LKj44z3L0pdmNsD/UutZdE5Nmde/LYN2zAeB0LX0669McM/w5D/UH1mlGouBA0JknObUFbP5/bOXtOnZUBWG93mRc+fCkXX/XvkMB8jk52R+ZA2p+71ICstthVkY7ZoB7D+9/MIuo9i5A=
Received: from MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 18:50:38 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::c0) by MW4PR03CA0051.outlook.office365.com
 (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 18:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:50:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:50:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: provide more ucode name shown via id
Date: Fri, 26 Apr 2024 14:50:16 -0400
Message-ID: <20240426185017.660146-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426185017.660146-1-alexander.deucher@amd.com>
References: <20240426185017.660146-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 2205af59-1e94-49fa-0e15-08dc6621c3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2sW9H77jlUchA7zMm+ydYWMSNLFtSGP4oVyPK0vk9S8vsp5bBOELbpLAuvj5?=
 =?us-ascii?Q?7FpyOUsp/BVS1e+9g3B1l/rVMYnwNxT5Dt8pRXgDC/pVU6ZhcEP6O2zgH/3P?=
 =?us-ascii?Q?BsGrIAoKXXGXTWZb0XDv64ztZy0TFayemP/0KgffwtYk+3INfL3+QF7YN+kE?=
 =?us-ascii?Q?aE49WkZeC6C1Ob9hbYyJw3c6ryEEGlwmAiYW3ccAKgVWupSvEEHMblPC1v7n?=
 =?us-ascii?Q?3MVBokIug9kZ2TkI1YfDSFPuoDW31nHyEFjAdTYBMV/wOULt91KhqtCTmhdn?=
 =?us-ascii?Q?304D1Y1lsHJ7Bvmix525vkxpEpQVzXcEDk7oe4NpEDEYXHtEFavHD2bHgB8c?=
 =?us-ascii?Q?DmHUr2wUSKEJ/+srk9o9yol7V6Cgwf2vuSEQSyP+2RXYZ8jGvVPvGeRs+c/p?=
 =?us-ascii?Q?cKo7+FhqTjBCw7byXGTRA+lAZDYxj2i+a+xf+YsdY/9Ojzk/Q/HHtB4W+8/n?=
 =?us-ascii?Q?uOoBl+xPioEO96LbXpCt9v/PqHvZB8QwTivEPHluJ4RZbKf+G6H0/xtVtPAn?=
 =?us-ascii?Q?7tdcK1VKdR/9/2EFXT1hjfXBaSWBGAAkAfbgkNJINH51HHXsPpC3Ybeswmng?=
 =?us-ascii?Q?uAB8Q5Q35SBcCKw7sBCubWL65QPlYY/NhYli+wXLFHbFQ79MvpaMXq9o0DqC?=
 =?us-ascii?Q?aCydJ87A6Coo+eK2+7cQcP3MDW3dlc6685d29bxRsUJ7/0ku7FG66IuK35mH?=
 =?us-ascii?Q?Ti7kLEn9SK0rHyvPnTJSWI56d8bEEzTHGHosrXrM38Mus8sabjEEJjLFpTWZ?=
 =?us-ascii?Q?USUCCzNFk2k2u9QK+zh2qcdkIZ8GW7kmT4wafs7crJHy80nB0l4bqbxp84b2?=
 =?us-ascii?Q?TmD2dPjzcgzmwLu8G5ZTgqKIaqy9E1IhKj3zDRIWP2Yc0a7eZw2+ov6S8Hwg?=
 =?us-ascii?Q?poQrBSUPXOxVlBCFrp480sbHykKBj686FzClb//aZ7PyxV3Z7iZ85e8+lv6z?=
 =?us-ascii?Q?OkT69MeW0pr4xCSJmd/25+DAjvLW4pgulxgYB5KSPppiOJw8i4mGVOcl9LFu?=
 =?us-ascii?Q?Wz6gFouGtflMmb72+CIsC/COnS2khDzXENDy8SAps3zOjze53eey0Zenh6/H?=
 =?us-ascii?Q?XIInZQY6/u5cKfDFrjJCmpKqh/1F7IqyQIw2ZrVNkCqcICtGZMvhqff4WylU?=
 =?us-ascii?Q?ZpgP66MT9dpZP/XPCHwjNlCWyKTtr+H0EvMUkFOHTwsjCgpLMfwCDGh5nc2+?=
 =?us-ascii?Q?Z5pE+2DdUWVxOuGBInfXtM5EJ/9tIhxhtQNeOZvP6h9ZbqwHRD25+EZ9l1tq?=
 =?us-ascii?Q?NaOc43YpsJ2AI0jYj1d10qgmTmNOS4Qtjm3PWF+EnjFTbMbKfQbhhiDcs3ap?=
 =?us-ascii?Q?uPNeYlyoZEwnSeKFvx9jI0Mal4G7YTKjfOPet+t6OUVc2E984mYL4GPdBzbb?=
 =?us-ascii?Q?CwuHUbe6LU2YFvzzAbuI8jWYLIfC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:50:38.2136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2205af59-1e94-49fa-0e15-08dc6621c3c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933
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

From: Likun Gao <Likun.Gao@amd.com>

Provide some lost ucode name shown via firmware ID.

v2: fix whitespace (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index f7e69f5e6d73..75ece8a2f96b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -688,6 +688,30 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "UMSCH_MM_CMD_BUFFER";
 	case AMDGPU_UCODE_ID_JPEG_RAM:
 		return "JPEG";
+	case AMDGPU_UCODE_ID_SDMA_RS64:
+		return "RS64_SDMA";
+	case AMDGPU_UCODE_ID_CP_RS64_PFP:
+		return "RS64_PFP";
+	case AMDGPU_UCODE_ID_CP_RS64_ME:
+		return "RS64_ME";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC:
+		return "RS64_MEC";
+	case AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK:
+		return "RS64_PFP_P0_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK:
+		return "RS64_PFP_P1_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK:
+		return "RS64_ME_P0_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_ME_P1_STACK:
+		return "RS64_ME_P1_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK:
+		return "RS64_MEC_P0_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK:
+		return "RS64_MEC_P1_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK:
+		return "RS64_MEC_P2_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
+		return "RS64_MEC_P3_STACK";
 	default:
 		return "UNKNOWN UCODE";
 	}
-- 
2.44.0

