Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955E3C282D2
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B9FF10E05E;
	Tue,  4 Mar 2025 16:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4//gkHI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F1010E05E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 16:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKxxj6aKHkcSFEw4EsPPELV5pbeDMG14Qgkh6/4YNWHoz8c+a8me/TMgSbLPOegvgWCVzp/A0EcVlf4wrP8lvZD2QNYZk81ccbtkYksu8/SvmliCIK1wYsJbwrMUFNL5fLzjkpxnHx+vKDPxVBi7ULH5TqE+JBpeWu/NPnvMSrlh8yGAoVQS2ti+fVdxopOSGdFprs+UIVFrOc8QMgXCBgIMKnKDelxYZh/QFklh31PfVbTKiiRDAHm0PoaoayiRp1jmEOgwrSa8lMzahXWT8qONBOi8Xe5jSWF/XDKiqy/nw3zn7zJD9IhziLqs49xPWPVq4Tx0YYb0ejJvkWyMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0fqApPv6QL7xRk2p7UebJXAvRRQzfkHI8zdV70nPRA=;
 b=LSNWiNZNF13LcdlAxuXidwLWdieZwhD5/LpfAZXmpfoBuGZH+1ZRMTvHwEJC+ptINW6rRvoCe/tGcSRAsP0zOMDa48S0Q1MluKm91awe1nKab3aBV2+62bh+2yZMSeGZUW2cdsx9JsFCXhEYsQGZmj0L3jDi9JSr+3hv/wZexEc4qL1M3jECc6W8+8IwQOPH0c/sgao8zmKHPtR49+2rc6NyLgQaWVTBPuJN7pm06jLYJzzEHHJMmZ2PT3R5WkJY0q4kXsHnVEKfWvzYbUgvALfGvDuzggpKkNlidrl4Ej3AuYORNnQ2PFFBL2YOszoxCGfD9rsgAGW2/I2NsDaEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0fqApPv6QL7xRk2p7UebJXAvRRQzfkHI8zdV70nPRA=;
 b=V4//gkHI8eMFkvebjt3DjYlLdSp8cgEhLERDmyyi/Caxmo74G23E22kAshY9QqVurlkUxUT04kxHXyxSNO8oX7asZcSTGDnRuoSALfmW/K6xfF1r3+d+BnkNzqp8xxT9jjOUNw/3OO6Wqd6HgAMjHeiB0cT5/MkKjDftfQQZRe8=
Received: from MW4PR03CA0359.namprd03.prod.outlook.com (2603:10b6:303:dc::34)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 16:19:42 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::56) by MW4PR03CA0359.outlook.office365.com
 (2603:10b6:303:dc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 16:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:19:41 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 10:19:39 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <horace.chen@amd.com>, Victor Lu <victorchengchi.lu@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: Do not program AGP BAR regs under SRIOV in
 gfxhub_v1_0.c
Date: Tue, 4 Mar 2025 11:19:28 -0500
Message-ID: <20250304161930.6268-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2806d7e1-5c9f-4f18-7700-08dd5b385e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uoCNUy5JZVywnWBbNQymUWXp1La6LTtyA7iXGMbn+u51pJReN9y8jNubX0cS?=
 =?us-ascii?Q?QDC/35PiNsSBH1m61Cw9kqDcAiEVhnAP09KQ77Qkurcuf/KbaeombV/OERDi?=
 =?us-ascii?Q?C5DyB+bttLDnSTFJDLzBj9cRgwP3F2nejTj2Ft2jPZ1hiDTPdhkOBe1DyFFa?=
 =?us-ascii?Q?nPrRNOlOXW+RLRQ+OFLci/kCnhpURT9u+W/mq6js5a/zhGaH5dnoYJwHHsbu?=
 =?us-ascii?Q?1Sdb+1uOaFRnEhGj+MtF0qLvnOtIJUny3I0xBUVwOCnympB9P4jaXu3FGWDL?=
 =?us-ascii?Q?UuevInUQzAS8puO5e/hihYJxwst76GSVGuebdu75Xp2hjf0P5whDFEsHh//8?=
 =?us-ascii?Q?8ijGzC68nUdG8rLAQ88CaArokdOVEbAtLkgNygQ7BSsqEqziN4dW65gxyXwm?=
 =?us-ascii?Q?J7RNr/asQgX5yJGHVtxlUGPYaBF6J6okadDXvKsI6dXZy8If3DJe9m67q76w?=
 =?us-ascii?Q?FZZjXW0xNv4clbmjYN+5j4PQtoFmrkSmRI2BhABAqaa+E1ix/3OhtPaqxF8F?=
 =?us-ascii?Q?8D9+IGalHV2E3iCjxEbVLjCYeK/bde6VoPM0kyjPlns/E8Nvb3qpvQPxO3rU?=
 =?us-ascii?Q?NW8wcKnrcuRfolBEVRVcnangOibqNStaPOLjjtxgimI1d8ZREr2bbGOJSW9X?=
 =?us-ascii?Q?+XiMtTm59RTpfiffKjkakQa0Tthz6Sm0va5Ygv7tn/Yg6ZWEaTsFu9acYnNb?=
 =?us-ascii?Q?IUErBSgblZkur/6zdKYqu+PajM48G7hc35X2u7/7RzYgzZcrbgQuNmn5UIAc?=
 =?us-ascii?Q?gH+p0CNyNF5YW2Y7026JY+piJUbgWLG5V1erSz2bp3ghNx7LYmaMvKbUTRzf?=
 =?us-ascii?Q?qMtzNajqSqoXdJItdWGpVDVva0zAATXLUcpfoCvc6FmnNuPzpjx7FaDc0pZG?=
 =?us-ascii?Q?haxvPN37XOCjbpQWoXltk7MWL76aSVvuijumxxVHMSTh0sj2nQcgEghTCOBn?=
 =?us-ascii?Q?rI2oGe5bLrDMDhyaFJRb8XdGGaYsuWVADxjjUQDnw0bW2jJJI251I1a7N5S3?=
 =?us-ascii?Q?nP46aw2haC3K8Chmos3hbmlOMdXbXkyD0BWyzMICRzZ1k5df6Ht+/NTbahqg?=
 =?us-ascii?Q?x7aZ7kK1QNFSpyaWUbV4y72EgUpar8WC8z1Vxpq/ebO/hJiwlthgX5LWH7bZ?=
 =?us-ascii?Q?anKgRim/TlGsw3DaVyNLLDFczHJR+Vd55z80x3cVjumj1fEe33gyWnVXSjh/?=
 =?us-ascii?Q?KwWbvlS2Ok73iwF7eQA4MVNz/y5hY2xYwAdvjnKF+kW846l6EbQ54rY9WZp+?=
 =?us-ascii?Q?pbr2EAZibo95DhsdAy7UWDYeu1fLrd9ZEgEdFE1e0UeG/fccX3p93gO8I7+6?=
 =?us-ascii?Q?fJDvbJaD7v6OPFZ/duP5LjYs2GdpD9OS9JQz+zXT5qltAq3RQWE+NA9dyWS7?=
 =?us-ascii?Q?Ak8GEINFIFLP5EpUczktOCrJT2GuoW4Aiag8gYKoaes6dfubDc1DbsGKx24/?=
 =?us-ascii?Q?A72qWGFpYND3j7E0+BPC2TjLUZxb8f4NCWzatp8nM9XwDU5W/LhHh65GnQwJ?=
 =?us-ascii?Q?SDOvnp4oJ6Nu0DA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:19:41.4093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2806d7e1-5c9f-4f18-7700-08dd5b385e56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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

SRIOV VF does not have write access to AGP BAR regs.
Skip the writes to avoid a dmesg warning.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 0e3ddea7b8e0..a7bfc9f41d0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -92,12 +92,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.34.1

