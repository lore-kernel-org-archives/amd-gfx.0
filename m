Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD45D778AE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 19:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73D810EBB5;
	Fri, 23 Jan 2026 19:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TRmyA8EF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29BB10EBB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 19:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR/N7lXICuq59g2GH5vIdN4jOtZi1vZCzt9e9V9V9u5hQm3wwHDT/wnjDWuFMTWh8hPMJI1QBFFebMGCyOs3EXiNI2iVor3cr/BEEEW49vpcPT0Ilje2Oaa0VuEQ2tpBGAXY6PHrSLu/jGb4TYJhdZVjFWsvR7fKnwuUbq33T/rzTphHu28BYBbLsIBq9QdNkwYA/NK71pFd/eqLbFjW0REN7f+jF0xS3E8SrwjBvELrzoMhTyv5MQ/J+/9uBtb+vaRC2epEZdp+xH70qM9/U1DgHHnOoAmjRGUOA2FyD1Rvz+9hggzV6Qoj2n5NK48m/lGG7tKwF5KwuuyWpVY0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPdznd1Gm2kvPeH72rB6zAG6ZlV3wQvgSSxr241RdGk=;
 b=gfLza83YcR7YiBhuXcPwRfOOEtGsE5PIxt9eOxQKTrMD5TBNpo0p58i5RsOUZ+YfS2gsC1pDuu8+1814uH+tbZuZKShrsaXUQnILBfODf4en5y6ZaYdLiN/HA+0ZeHuovptZuEm50r61bJzcm9LyrODZDxwsatHZLulVtfqE/j0RIU1bZgjUD6B8UkItHHrLwr8stS6EQWO67TYHuwsZz0JxdN0KrHbD1UbQTVOvtBRT/fZc02GCtzsOfqYX4egNZaqHHoWge0cZZagRato8hBVQCaLFvIIK4Ix2EoIWnv/9g/9C8E+nXcW9Wr9U1jr0QHt98Zp13pyPLyH7WcA6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPdznd1Gm2kvPeH72rB6zAG6ZlV3wQvgSSxr241RdGk=;
 b=TRmyA8EFDUpgy/8RgIrRwuaMZy+ehOTvPg74xkhofVaQ36XLr2VouAdEsNFfeIFXZ8gPL0dKmCJikI0iAci/GDfo+lwGxEPLkCywQCVcSEmYCoFLFhFVQn0RsiwjJSFumqmMvlMHSW5CUR2DcEy9dElp1WNVJdN9uxIIdFdqSGg=
Received: from DM6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:5:80::25) by
 LV2PR12MB999074.namprd12.prod.outlook.com (2603:10b6:408:351::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 19:15:09 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:80:cafe::e4) by DM6PR08CA0012.outlook.office365.com
 (2603:10b6:5:80::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 19:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Fri, 23 Jan 2026 19:15:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 13:15:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 11:15:07 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 13:15:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/soc21: fix xclk for APUs
Date: Fri, 23 Jan 2026 14:15:00 -0500
Message-ID: <20260123191500.18619-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|LV2PR12MB999074:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c3896c-01f2-4c20-0dce-08de5ab3b8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uAK89X3mWkmJvJxdQxJlJmYEGCo1GuIIeKyUlBGi0NTrgdE18M9s86UFr5xP?=
 =?us-ascii?Q?uNQWfyrODeXu0FWPR5UnwM1rybcVlPFHn8QHb7v8TxJg6N7p1VYtRSziwwUP?=
 =?us-ascii?Q?/+A68MltZb7CBWQRwRVbcZxMyaN6BXmIU2iBOhGG+uHBiWHwK4/zNM0S7mOc?=
 =?us-ascii?Q?WabeiWgFYOoH26YOiV3kPBmtnitx8Q9sNul4aC4vvwqS3FSzhdGu6Ree/77d?=
 =?us-ascii?Q?z6TDBkJAIkbJaGf7SYqWtn4I1GC6JxZGpJW4GdU30MMLfMkq4R/NbqJtH1C6?=
 =?us-ascii?Q?yCb1qSYjIVarS7jJLS7FZ+gBNzC8SkjBgqRlgkU9Bj720Ds87+f3r/oRnZ6H?=
 =?us-ascii?Q?yyscGr2kjO5RwZTOKK7okF6vaPFFefwgokswsxD8AM2cZdGHbmo5b3j0LNSI?=
 =?us-ascii?Q?9ouzF43rZ0FmuOeHEwGo2tpXnwCW7UogXjjXsVtzDmqVx6f62ZXFYRA9rPMd?=
 =?us-ascii?Q?Xu7f9AjNoBV5B8tUhLYpbI8pd4x2Ep1AO4qDsu2lC6klVM4Ca96LjXnLmo7i?=
 =?us-ascii?Q?brSM2PAjXgAXoenb8SOrdAIz9cjjoU5QmPd7SqSecQFU+xQSWCBEK2z2CEyZ?=
 =?us-ascii?Q?apxGXzbd0PdaMhAiNzYVsKvjktzJxmEy5MTXTsKQT1BT7oHD46qPWU0nC/Bf?=
 =?us-ascii?Q?hNC+OjD28qNg0yq7rGG+rzWDzzzmiC9eQo+m3cfTQFwSze0uzgXfJC3sLfB2?=
 =?us-ascii?Q?YfzILAhVCOA4ko85FPgiVyj8MO27mJwI6LU3HjJiPxsHsxAGIoF2+kCIJO6P?=
 =?us-ascii?Q?KWKEwj707cN95NJKlFIrSNba+pq/Z4c1kGnGYXrC685n5FSR18/qphS9eRae?=
 =?us-ascii?Q?TZPc3LzP53KqONT67WOAy1gprK4jJf3Nr2eBGTduI2p3kCGpwSpGV8Xq9zep?=
 =?us-ascii?Q?80t4TuVA9D/GsEqKEUdQ1HwsQ8R81MpVhySvb3JehjnJ2GpDtC4T8+jaCLLk?=
 =?us-ascii?Q?snP1Dao06U67WLku3Rs7a7IZOyrO8ul+V+/IrgdOqEEf9gNjKsCUyyuZh36Y?=
 =?us-ascii?Q?vDmxu59dz30fAK+oV3aTbZ7N0DDKzdpLdMM/bSpGbwiFsOEd50T9wTaIrOm7?=
 =?us-ascii?Q?4hhHKVL3K4GTKpgj8mnjrn1x2+zZjHtEUQqZdntewLnn/Y0nmOEMTi5BP4jH?=
 =?us-ascii?Q?nMTd5w52XqpXqbW1+NUbjmJCW6eDAZDciBbhTlWrl5mq4IoGVWPwSx/7Qqg0?=
 =?us-ascii?Q?lAWBHifWdM6sdhlZ6ArfMV4KJIGWTulqmcw8/sofwOBKimjcDt5l4dBz446W?=
 =?us-ascii?Q?+8PQzRodh9BJZV6k8isZEO03jI5dtodCGYHohSyKfpJKPKXC67EKBpMFeEdV?=
 =?us-ascii?Q?OJ/htZCpbSa48YvGF3PU3demf1Bu96wMYyiBqU+BpBGIp/8WYgzzpTCe4nk6?=
 =?us-ascii?Q?yyfsZUydlkej1NK/ICLI9l9iJm7kYnut1d3PdqTu+9ry5hkn22MylboZE69c?=
 =?us-ascii?Q?ArOwyPxEAWJSuMXtHIzsOoX7KqF+o6lWzRofUrTc4fPB3Xcs7m06P2222l60?=
 =?us-ascii?Q?abqhn/khLR9eYx0VXc1/CrdWr1kMoitLuUw8avpBF/nxgAyKshW+c+bh0zWn?=
 =?us-ascii?Q?FG6KYVcrTCbWVq2D5lzGtcBRdzGdYgEDlryXlNhu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 19:15:08.1085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c3896c-01f2-4c20-0dce-08de5ab3b8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999074
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

The reference clock is supposed to be 100Mhz, but it
appears to actually be slightly lower (99.81Mhz).

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/14451
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 2da733b45c21a..d9cc649d81ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -256,7 +256,13 @@ static u32 soc21_get_config_memsize(struct amdgpu_device *adev)
 
 static u32 soc21_get_xclk(struct amdgpu_device *adev)
 {
-	return adev->clock.spll.reference_freq;
+	u32 reference_clock = adev->clock.spll.reference_freq;
+
+	/* reference clock is actually 99.81 Mhz rather than 100 Mhz */
+	if ((adev->flags & AMD_IS_APU) && reference_clock == 10000)
+		return 9981;
+
+	return reference_clock;
 }
 
 
-- 
2.52.0

