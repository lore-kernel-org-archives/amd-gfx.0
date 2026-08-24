Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E5AC61DB6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079DC10E86A;
	Mon, 24 Aug 2026 22:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z+o+Q0Pr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3884C10E594
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tc8dOictVg/r7F+6JqlOnJD7XfPhH/gOVH+d6shuHzproms03la3qAHyB1ONSuVdbPNCqjP1yqpcVKBczJlnwgE6aCRmXFtdgZ+DjCWPWTKp5lLmt4MwHpcy5P/S35AWD0gmY5JIYSR4h5PPmKAo3JgDHjTsKyzKuAShZt5Eg3t1ygHL4B4V/n3WIAjNk0tuTtWj5tXH0HvapdUneAavFW8HAqbUSHfLHQVvEvfP5YMirFbk8eWmUaixvyu8I6/FZUyC5gCA+e2ClMjT9LnPfNhdaPcg6guglthd1e7oSPayH3o0QrTO0svnP+z5lzrhpKUsKcqNRFYfy+TUY088yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaBMAvoeWl2rOWMMZhy/PpaEL4j3LewJvlYyeHwyPlY=;
 b=NEbgkeHUuPiQ2rI2QfZ2lgm/ZkDaNyGAva/3gm0D8stMGDQge/bQgDnT+yr8Y0oK/lirhJFqRZl3Gk6z0G7C/4YsdhglLYnkY3zmzapVt0UhtoQeWnwXSljSmScMlCcHH0qsN8bAyCOAaG7XYxHN/UbJePV7BsrZAmgVEjvVujzyBPW9gta1mbyRMjIKDCdX2A3ijA42cwfia8PyymtFhxXsUKug53P5AbX9vFIAa134gfg+ctEC3Jq4yPHWHiE7FEnrZy6vjmpkEFgjG69aTOwFUEUzNwOpn/TLi5Ugi59NseSQPQKYsot66XMrErfUs93HDF+sCNG6y+4qXj2sjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaBMAvoeWl2rOWMMZhy/PpaEL4j3LewJvlYyeHwyPlY=;
 b=Z+o+Q0PrCY1QWXwBAhvxpy3aP95lNuIAaLd0pjtHHnwjYIS7gwBDZf7aCylfEhcWDlwhvrdoykAJVKvBW2lZQxz80TIBS9MCqjPCl6IeUgcR4lFW/JUgMjFr7gcejNiqJZ8Wls2r45uJAtBR3+VltKmrqb+Qxg0Lpga0kFHzGGc=
Received: from DS1PR03CA0025.namprd03.prod.outlook.com (2603:10b6:8:233::18)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:07 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:233:cafe::2f) by DS1PR03CA0025.outlook.office365.com
 (2603:10b6:8:233::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/30] drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
Date: Mon, 24 Aug 2026 18:13:24 -0400
Message-ID: <20260824221352.1793542-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: b96d5c30-6c5c-4092-5064-08df022d0390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bwnzHO45up2yEdzRNiMsRnCwoEMQGunZDkgxY/2nuSnKLoKxTuTS65h9qTe/NXm+F2Bi9CE+qkuu5WQK7jb6VePBnrn/NdKc5QksD7Fs1Fyi44FEHZDR5haFL+28TscTp+i3WZ0pE6/yEE5cWv2lfHChdWwgPiQegB8oLxFPyiwBo7Mlw9KACdJIJuX7uZN3ER8Ws9mwBzbedIG/CkW3y3FbLe84YTPYGixTicn1Z/nXGKZrsgE+8Yn0O/I3MhkDgsOt20hsWCQWVBogM6s+p8f/bgqz9MWSDm94wlM0PYc3ssDzQ0mftIJQ2KNWF53N7Hr6X5Xl5wBfA3O11Vk1GMdpRm4CNE3G11NptHAi0bzMBQpFoHA7ldG0r1vkBIhY88GT7go08msqQK+BEfjqID8csxdvOqX62Fa3q8n4WST1i6K6hI8zg/92U99lmiOti/Qrf+N2MPEalKGd0ps0ydMEguZpDUF8QI3SBujtwB2GdN0AAeFxKOYgV8YJ+VFYgPkbmrtWlqTtQwCuVX6QJm+OFVcmgsELzxlsCmxmI+V9kX8FrnkY4AZGDvD2//YrWcxkbYQ/lSzh0nV+cN0TgsgBmPAHxyHPxEAbAgKRh3Mth16dS+GkrC+WILhSa7DUrgmYtHymG2R97vlpB43qkLQ7D8sJZYbr3sPbo3Rft/5y98mx772NavoUiFUmXVvMRyd2aiuWetbo8Y7yog8nHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qjVWull1TwJnpwiwX2QuNR/VwI3j6ktCpA7jYmGvE6yc11l0zqUFNWDykTpRlFo3cu1a5MMyuV3dCXLftqSq8lKh9hA9R1wdD0LWVW9/pSeucsq3c2uVDLAe7TZ6BoY4XF6juORBne4k/5fgVUf5CkIJlk5XkVAvE6oBO/WzDKdOs/MZRAx+niZvL6eyE7EApw7P++aLnMliArcBQG2JLniESHjaPR58v/21uWYlNjbqTJzkDlOBzFRJYWPqxDmPpbtBBLtrekI8kTSi0psuBxuabf67RahHKcx9gR+cjp+g23MbfbhQTqObGz8NWWFwA2/dZ/c+caaVBEvJkpjPJ+kIDyrDRXZyAdaiLC4itBYSiIU2V1RiIun5Fq4hTr/bRyc2zc9mq058bM+yswsPtczPRBWuCzbDAe1IGGSkNJkg2IzVPuWYJDKMT73D0HY0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:06.6119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96d5c30-6c5c-4092-5064-08df022d0390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 75a552782c979..8d88651b18ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -265,6 +265,10 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -313,6 +317,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (i >= adev->usec_timeout)
 		dev_err(adev->dev, "Timeout waiting for VM flush hub: %d!\n",
 			vmhub);
-- 
2.55.0

