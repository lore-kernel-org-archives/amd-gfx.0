Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18026E7717F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 02:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD08810E101;
	Wed, 11 Dec 2024 02:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VJ6ePDJE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE7810E101
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 02:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0zGxr3w27dVHkSgSQlAqPp4WnsFy2UzWF7r+cvPK9wF+YKqW0IZ/M+EBXsjpGxXrNeaF9umcJcVJqY50AT9EGXCvEFAzwIov5D5GPukkeZmYGc4Bmpf/3yG7UOs6ppbDB9c5/pQjunTDTBNc/XVhSm8ET1HC2VW8z7Bazpin9wBKw6a4Z9upgYBdB2UCK1S0WJLFfd+GcqCYmxWdApqffCArrbwMlTgrkEZppGu3hCKxL1xCoos05n2rKhELS+YT4xSNhjaD251AMTbABIrUQDbt9nh2tTObY89dlZE6Ko3D14YccVSQXBV/l4UEzICnVE+0Naj031Uh2nLCRsiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c+VcfUHfDZXodWfPN/o6GgoqEQRt34K0TeQcu57Ets=;
 b=tBrR4RDgU6vw5RCU9vKJ2HQdTGBGZ8aYA5QOHFqrgQ97XKfpPQtCZy/dVqzipfXmGUKZGbYkK2Nl1vYmBmAL8MdXGOC5wM62hZY0O3J5pnZx0RnpDNnCizkeXAhujBviuoBazPuwHfDsa9E0mWbMtfl200fDYvhLAbCvFFG0QddBZE8ERyIuP2OaX/amsAOjBmyxjgEA2Y035Z54G040dnAR/MW8kbkZdEPTH+Sjw592Crng36syQmAHSiwObSxN7h5uJA+h/+JLvdqDk7ziuIRWeGuWw4GS8MSGLvKZYtsghLy/+ZT6EFdEH4eTLz0gsHNRYpuQCr6O4nHeGydICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c+VcfUHfDZXodWfPN/o6GgoqEQRt34K0TeQcu57Ets=;
 b=VJ6ePDJEGa1OXJMYQ711ejanr/lbnGHsbsaLTl8qPP0ZOtwhhGRIv4+BXf2MAvxOa65+PXU+KTO9OqosQRQxd4sklv7VDyp+dG+/dvH9A+32c6FME1OvASXCMy2+JPecbr1iMg96UP+o8XPns9402ZK65eKDiDNP9iktWRROv90=
Received: from BN9PR03CA0713.namprd03.prod.outlook.com (2603:10b6:408:ef::28)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 02:45:46 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::87) by BN9PR03CA0713.outlook.office365.com
 (2603:10b6:408:ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 02:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 11 Dec 2024 02:45:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 20:44:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Vijendar Mukunda
 <Vijendar.Mukunda@amd.com>, <ionut_n2001@yahoo.com>, Gabriel Marcano
 <gabemarcano@yahoo.com>
Subject: [PATCH] drm/amd: Update strapping for NBIO 2.5.0
Date: Tue, 10 Dec 2024 20:44:14 -0600
Message-ID: <20241211024414.7840-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 32997a28-0e76-423c-52c4-08dd198dea31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W++6qGS+h3PrQhr+1c8rTV0qQWNiqZbUGqeJINXX/XKf7YFROOeFuKMi31y0?=
 =?us-ascii?Q?gCTbXZTZjoSEK7ihw7t4gpdu787dkXwvM45cBouTcRXkczZMVIw3TKRByuuB?=
 =?us-ascii?Q?VWxuhJoxHUqfyqqDF1stTOneJoG/jqcl7Ry2ruL0wzgEDzyQI/Jo4vb6cKXM?=
 =?us-ascii?Q?5i6bvzLn3N8zv2y40XhOgs0g70czIF9b842/GfjfDxzdhW4hMGct3iI/d7Ky?=
 =?us-ascii?Q?LvoBwrUMWlU3xJX1pW9Ar5noWoClYzgPu5C3e0Ttv7sjr4MHVvcAOIM+9UQ7?=
 =?us-ascii?Q?M9U/lihsQnAbEGD83XkY9EpaEOIbLLex238+EAtuhTOwS054wBAb38M0LCh9?=
 =?us-ascii?Q?hr1AVRsX851DGerp4PggrVZjfqhyfdlFLjwTKzym5qfMPPK15PUlprXprVf2?=
 =?us-ascii?Q?1Q+mjPMrxqaIM099RoTbjByrPb+G6u8h70OvntuuX32x2F/SH/QRDNAv0xFW?=
 =?us-ascii?Q?eC2ywYr208JDjRywwL9HorSUl+Gvjhr3/S6Ga9iKwHWxoVDvnWog3p69b/xf?=
 =?us-ascii?Q?0f2zc43L3sNVb3jwO3M4haIP75budl+gnABdmKBKtj3FQuSczvjXe9cFDMkd?=
 =?us-ascii?Q?CHz9Q24vhmJGacCewkmWBLLB37HYijha60o5eo76BjzpW1C5epSF07QJYsD8?=
 =?us-ascii?Q?y2Ul4qaQ9B0PNE4+YZyoVAQXiVCRs6r8DsU6+XU8t4g0efXrmMARKo38sXEK?=
 =?us-ascii?Q?JcnGFIkXzleL7pEMQMjA/kx3uFguZzd3zMjkIcOyBdUDJlBmuqB5x3hChCke?=
 =?us-ascii?Q?e3n3Vd9d2x708x6lU5av0zUZVGHOKwWjBVqNhoO3fca/VzSJh1hEKBm5u/Ux?=
 =?us-ascii?Q?NMIXe2eLH26xMBq4BfZdPtiieYz6lHc+FFIN+spWqgQfO3qa+NIiCnftBOBS?=
 =?us-ascii?Q?KwWKuH9KIO1LIhHjMlrGnqm46BWVQ4/MouG4v6XQ+QmlhK/PlRjmilETdTdr?=
 =?us-ascii?Q?np7QuaepL1d9u4kNgKpmktPVpE8i4w5SyGo9X6SlmaKHLGt5Ufjxjc0kQGyE?=
 =?us-ascii?Q?CMCPAQEI3tbBMGVq/B5G4EkhkEz4fCcPxf8VU0AlUxwQZCYIXFzM9hwIRGBV?=
 =?us-ascii?Q?Mkqo13kwPMBZTGIxKxVvBH2WKZ/gMyKzbVTnsqw+ZeAmWrar3lZg1pYyaEY+?=
 =?us-ascii?Q?CewpVM4g4YMiHogB2BsTfgJox2t3FsKLyxNC6ugsHK3mywHjYZYFeTTb7mj2?=
 =?us-ascii?Q?QgvZLMWLX/uNlsOmtJTr2RlmNHqWwW9scd/sMkwxyPEz2GaptVztwU6drBgq?=
 =?us-ascii?Q?VruwAbrSMhk3S8Z+x1gD0Vd0efrwUe7JTmNoRx+1fYmrK4+KZWBSOCb/CtcL?=
 =?us-ascii?Q?1eru/BlikIIFHje5lGJufdKoyBHYzqDAllhXSVKk9gGqt7l5R4lGwPwV/Dbw?=
 =?us-ascii?Q?pdULM9IcNSuD3Jd5KYh108VLiJT78q/zpF+fYh0lGsNihuGItcx0od54V1V3?=
 =?us-ascii?Q?+APF+HB7+P9fgytEnxOG2ImT/E8QQyxU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 02:45:46.5881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32997a28-0e76-423c-52c4-08dd198dea31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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

This helps to avoid a spurious PME event on hotplug to Azalia.

Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reported-by: ionut_n2001@yahoo.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215884
Tested-by: Gabriel Marcano <gabemarcano@yahoo.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index b1b57dcc5a73..616b290c9381 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -271,8 +271,20 @@ const struct nbio_hdp_flush_reg nbio_v7_0_hdp_flush_reg = {
 	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__SDMA1_MASK,
 };
 
+#define regRCC_DEV0_EPF6_STRAP4                                                                         0xd304
+#define regRCC_DEV0_EPF6_STRAP4_BASE_IDX                                                                5
+
 static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
 {
+	uint32_t data;
+
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(2, 5, 0):
+		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF6_STRAP4) & ~BIT(23);
+		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF6_STRAP4, data);
+		break;
+	}
+
 }
 
 #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
-- 
2.34.1

