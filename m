Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE31FCB619
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C152810ED5B;
	Fri,  6 Mar 2026 15:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tbGxPsDO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B016410ED5B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C69U5LcUDiJNbSwNryl7BCOQUDciRSec1sZkYoT+JN7KC58WNl7onM265nxVGS0yAaB2bvXFTK2tTzIyx1n5O/R9Vs4n16HmRvpNHShguLJpy1ED1laSls/SvAwmXtR6Fs20MjFL0HkUXH4/RYaEgOEHPlq9nxS/Msp3Gja8axB7rnhVPOe/XFkca4l8lWqG7KNrPp/YBClf9VrDBZQY2Q9JbqpLXv79hWFZNm+Pgo1OVXIF6+I8GFO1bJ+f6/LsDfuA+EO+dPNX7ursCn1cjdvJrrCVSSvSzaTKe6ioSA6GTf3cVvajuKGdeIUfFela8tHMAw7vf+NEADNbgiHb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkjQCRyo+oG238kSS6j9LOxn0MC8OiDHceZPzAuQc8E=;
 b=nk276CiHZri8hSE5RL/jaClFP1+6AfIvTBBgJzJIiF0z3uZ254UEiQrcAY/84C/oOpXTxTjEt3nl6bi8RiC8CuE3iu4oUDZ0SHPidSdyltZYNQxU734l4q3Zbd5QENPfjJjpixvbM8lbBm3VY7MB2L/1yk0zuhcyPE7helVURA+RSwoFJQFu0lhuiz0Od8V+vT0yw2fueZwLu6BSnBXKSkNWdPioHovle1avkV3tK1+cZq8A0LL7M0jbgNOvn/SGA9rO6+gexCVgfckpd/18Z4t+GRyCZlMDgq/1XTmp4GqLD4AKsSh7MtkRCbSyxZ4isDKrRzr2ajvpSM8rlY+dKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkjQCRyo+oG238kSS6j9LOxn0MC8OiDHceZPzAuQc8E=;
 b=tbGxPsDOPV3AACzU2V/2QSFFZAU6Ozik14yLuCEY6n4PzznAYGKNQmFLBxJJTKvYEaL2ndL2Tf4bmBj6eFJZ6td/2HhaMwMJVGslt+9gfM4XQ2XnpFw9ibxO90yNSqPNyfKOHRjI82YpCv0pT4yhgwbSVm1SD94cBvznI4K8AuI=
Received: from BYAPR02CA0007.namprd02.prod.outlook.com (2603:10b6:a02:ee::20)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:40:21 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::c3) by BYAPR02CA0007.outlook.office365.com
 (2603:10b6:a02:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:19 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 07:40:19 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix DF NULL pointer issue for soc24
Date: Fri, 6 Mar 2026 10:40:00 -0500
Message-ID: <20260306154012.22525-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 1356503c-2fac-4f3f-aefd-08de7b96ac37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: TkmzupPWNzSgAMDsvY42G1xWtmiE2j71Be/FsU8i8eHgy9pZR6oCoefDIeCPZ7cxSpCq9gbYK66kTAo9lwMdM1nbcTZEPrWC+DUm8v+9Wi5qaBxYnJOkqfG04RlA9lJajsN6OZ6NnAfbGJBJmiMXj+lkubdH89VVN+ninApuUCB/kyo0D9y4L+pR45fI+CfqJ9ZHYeke+4Xp0KoOFX9LER7FX9mDqlgPTxO/sPTnfptpzHYCMOll5HdZyy0GA/nBIurzx7XMa67tyn7mI/LlWXBLWFZUZNDkq4WwTw76HjCzjXt6eaLGWt3W33XnQtas0Ky9wE20TuuCKgYAeA4nKqUdSrREgwSSPdeY/WQWAvQgvjd9mE+M+2lrDgNd5mdhkdjAzYPSSud6+aQcO17wPUh+sdZmo4wZ4oi6rYJqlTOt2F4e9OMAPBAeDjNVtSS/yFPwjOqXnYdTTSHnrRLkuL2WDhoORiWjht+vA2LvA6dyoH1VRtztc+moJhD4rMjnoXTbIT5pxZCV7m5siuvJ+gDwX+M0NsL1Pm0edGajUfxAkvETtBzrqRXEer0kMOzwtAMzrFNKHiWzLi1JIuj4V+DFWW1pWDpoYCfjHZto9uCqmrwDt/+SzqkTRRRus3a/8jhJGDZXihl0IE9rRoiqGVa60/ko/Hnk03G/U/AtzqvGd8EtACQ+hnLzzl7nZk0fbC6jYnxhQ+Hs7ncYkenizc4Gmp8W7QxPrcEp226DvFHp0vRk3XEtEX5V23LvBylabpHRbt2hFYqzbJPMGGzWOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yodIXA5iRvLatR8TgrVOGJYtBJLrgm2udHwgn9Ycm6wfWscDI83E1Dkr/vzspN5WxX7uZ+0AGLwzPcKpKJLIjmkGp/MG3FjX8PWGo8sNqatgfbBMEkFtZRYB6lfb15r5y09IipF8GSw61fx/plupDB00ja3I0A+4+cug7b2N9IKmK3Kikdhy8ogjhb3MZOOV0shD975aGT8FbJZ4MPHeKvpsw7ZWJXS274UwvN7AwVD8o1btgSqWUogRmti/PbKZw7uyFMPucrhNCL5zipkYE1SVC/godN1Ea8h9tQDYOSDkMjmwfpnacqjysi0wkf58IiLlxtkfnMdzkfZ2OrTApf6HeURk43/SewROnQVL+/rmtlSwbyDCRd76D5nCkS1WTalS+MAel7QU5Mh5Rko1c0SKDYRqncuF2aCXngPJwza9GN+F8r3mYiJlADIxUA14
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:19.6728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1356503c-2fac-4f3f-aefd-08de7b96ac37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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

If DF function not initialized, NULL pointer issue
will happen on soc24.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 308f32daa7802..d1adf19a51c45 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -478,7 +478,7 @@ static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->nbio.funcs->remap_hdp_registers)
 		adev->nbio.funcs->remap_hdp_registers(adev);
 
-	if (adev->df.funcs->hw_init)
+	if (adev->df.funcs && adev->df.funcs->hw_init)
 		adev->df.funcs->hw_init(adev);
 
 	/* enable the doorbell aperture */
-- 
2.53.0

