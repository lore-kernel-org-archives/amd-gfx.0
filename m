Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D927CCCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79EAF10E818;
	Wed, 29 Oct 2025 17:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkR7AJv2";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F6B10E817
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meyNw31z6htOjCmWiEgW30IMWNMB5i1fWCYzlH+d1bcym2yZ9WE3Od8JZNjZolOtfePvj6/ZNT9lyFi896TbArB5kZFtc2Qu/lx4fGEV6hORViWRfRNFVEgqTLBQpifrqjcP6z00Qy1cmehlXzgsDbEhVZzGgvtUsMPzaQZS7vrm7OmILNO/Hhoet5eQ1k3xjP2MY6wxFALA6E76VgSgAsviit+24jW/daevlXStmLUWR4XFWtGvO145/nA/p3qaJeONRr3MFIrf3AVVAefG/lJGvZepyQCwrU20JXXkhcp2xrTI63M5Lq//WerFcMX48YC2eONcYK8/tOK5rA7Sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvHlQjQcirrpVCUEMIOvbpCNbx5xBkXKE0AMjQMBDXA=;
 b=GbZ3XcOMkqPxbX0miyeCBuPpXIRZ21XKc3yFpO79QpwCqf6J22+hfkqYoVJlDzq/t01l6M1gnwJokFHUBtMw5xzLcmwcJoS16jcfxI9XXJh+70MKorMVV2lbGYwudje+hg/L6U8c9H/Sy1HjWlUswGgt0uYwLeGhLZ3KaSQLfNC4/jpwWV9yWlmYtaOih429dBczn6O3h5fxX4/3DnnemjsjNtDN0xu7fvtZ4/IwysjGjdq62xYVa7ZFVgyafbuTzyOlCkpDWjcFugf4fOpWOdc1rhoecEv6/VFY6wD09RS5n3zsWU/VE6fH3E+qcQ6PXi2rZhWSxbybjHjLg/A18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvHlQjQcirrpVCUEMIOvbpCNbx5xBkXKE0AMjQMBDXA=;
 b=MkR7AJv2nl6gyZV9TvjVZ9JpQObO2b2u9dfmH3+zWeuZhnJ/gARSCkElbz8tijG/5HXhsWGvPwGnZMVXi1epeVkw4SFCvolICMgp9BnNF0Yu/JTho7e5c6cIjBQc7r61Nd4SP+MCSqxAS3oMFvWl4s5iZVErludTmwWtMyGMsfg=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:56:17 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::f8) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 17:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:56:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:56:13 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Le Ma <Le.Ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: add support for psp 14.0.7
Date: Wed, 29 Oct 2025 13:55:53 -0400
Message-ID: <20251029175557.2862156-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175557.2862156-1-alexander.deucher@amd.com>
References: <20251029175557.2862156-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f771603-456b-40d9-2492-08de17147494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ouy+kw79DXbLjmBbXBjvDFs/4rGwIeBgW8eIVtFW7ETfhWI08YF/dxiSEIG+?=
 =?us-ascii?Q?cVazoqzNgR3RqUsuoFqUlFvqYOq7OihLELJq8OVaWGdfad5unYhFfVmvlIYe?=
 =?us-ascii?Q?rYVyCG2Q3X9eB5Ajz9OZXCDQ/xfrWTGrRjCVeC6wLLzYAxXGvgm+oquuycG6?=
 =?us-ascii?Q?PRz09oV/6xv6knbaNtFUIsqyT541Hhe1/7Kdcst9vhPa6UTBipwkevRh9EbW?=
 =?us-ascii?Q?6DipzcbhxefXth0ez1aN92d3ViB3TTCEwrL9q266m1LsZ99WjNZIagij6c8I?=
 =?us-ascii?Q?9GbpqrCEm8kVxX4rFSR3QKjoe9QhN2yiVcGDqUw+92GtG0/SLHHUdjlBeVPd?=
 =?us-ascii?Q?ZpfL0BgRqE7NtDz+7sq3SHFkX920vQcFVgh4wkyqgibkWLCV2Iu1mzBPffET?=
 =?us-ascii?Q?u95735cHrjm+uyCX7Ge0hxZ9qHMVRc3a83fc5XoCmLDXrcm8KRcg2vEvXKgY?=
 =?us-ascii?Q?BB/U/b70QjaFSSmRAw5zdGISmhNEYXqSnGA5Ue0mjYGyeiFS4+eNvwh3LfQP?=
 =?us-ascii?Q?h1o7dhP6D/f0sFd3QhCDEXb9r3cD6rvccDCW9nk9PJnvviwSNLH/pg3g1S09?=
 =?us-ascii?Q?UVPjaAz19kJ04o2x0GK99wXEYQFJ5QrLSXJYmb1sso3XYwkiDnoBgqbJC2Zi?=
 =?us-ascii?Q?beom2gaeqGYM4SQE4geffh43Nk3aRk6PFMhq34pXeLFdob1HPEaP5MgC+TNK?=
 =?us-ascii?Q?ufxqgOZEQAZQAaCI8JSRPZGDhMCwSvTK5p5NLZ8GNHf1wjeK7DRrp0CnIhs3?=
 =?us-ascii?Q?3mgZKyIDjJDSp/gJvvRXKe14PUpDnqNDsjQcvXujMvuqeOJCU8DsZEdWq2XZ?=
 =?us-ascii?Q?PrRNbOQes9j/bg7T0zajbbiGPFZh3yuTq24g83riYt9AXUaBnKOSw5Rbg8LW?=
 =?us-ascii?Q?1aSRlJzmX8nnUuwMpzAiL5fBSAUdUw9XpgQ3wxr5m0DVhjsSUl/IW53pwFxF?=
 =?us-ascii?Q?na7xDe+wcImxm1qvqqvQ3bpW2C/+fEHTPDUbUJHKJmPu2LOhaJZi6UWW2FQ6?=
 =?us-ascii?Q?ruLnYKB3uc9r9ULt51A9wCg5zdoHeUAlL0ZmDuufLs/BszTeA+9ky0aVHwk7?=
 =?us-ascii?Q?LPCCGSz0ffaq5MzAshVZjuHpHWRUx0/yHm/IjKTLgQMVUOESvAfTuEetmArc?=
 =?us-ascii?Q?mlgNWDRDYrO9En5AfaNi2LYuHf8SpMCpjfTWwOTlIBT0LC5oSmBHJJptRGHP?=
 =?us-ascii?Q?XC7ekVBRuODXsobjnMD1n/MqxDxJ9VYKry+LUKJwPoFxIAPnz4UppNv3hYa2?=
 =?us-ascii?Q?9nRHQy/0tf0hhCr/2ng6HXIg4M3PFpGm4oBi1k0Co4hRFNXFXeHq33r2frh+?=
 =?us-ascii?Q?yiQTpVBY/2ZG20oOEJO9JG+oWa5v+kW2Toi2LDrDvAuphLFdF4rPCYwyxRPz?=
 =?us-ascii?Q?uuBvIBhmbO9Ofu7VkbyvL5aY2SQ+4k3bXvw/F/dv5mmyUWrh65/u+lDOXuCz?=
 =?us-ascii?Q?OjNPXmYSnzbyhSXYZiJW9nAriovbvBqDrV52e5XLywCureTB7eK9fbM/ivj1?=
 =?us-ascii?Q?NoAVrvxvC0KMad1p1aI/Vr2sylWIVhnxl5DemR3QIAA61Z6YXMehtht0lCk9?=
 =?us-ascii?Q?n2n2DnYd8yltzQN1mCE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:56:15.5413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f771603-456b-40d9-2492-08de17147494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
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

From: Feifei Xu <Feifei.Xu@amd.com>

Add support for MP0 and MP1 14.0.7

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6208a49c9f23d..39d3b4ae82110 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -901,6 +901,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(14, 0, 7):
 		return true;
 	default:
 		return false;
@@ -3065,7 +3066,9 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
 			     IP_VERSION(11, 0, 11) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
-			     IP_VERSION(11, 0, 12)) &&
+			     IP_VERSION(11, 0, 12) ||
+			 amdgpu_ip_version(adev, MP0_HWIP, 0) ==
+			     IP_VERSION(14, 0, 7)) &&
 		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
-- 
2.51.0

