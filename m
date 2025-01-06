Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E6EE77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE2310EA06;
	Mon,  6 Jan 2025 20:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NkLGiZR2";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2EE10EA06
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML1TDWyNbBQv7a58MB3B52mTGtLSCOi6Zf/sPx/jU0p5smERfVcxO0iucIqWqquMLDrlWW8OXMNFIfQ3XooDPc92Dd2C+WYFAuoPy/bWh62T2aNrH9TIvzWgvk0SvGwjahmUXxWR19xc2hGa5Rs+tKaDZHQWX82XDsz2auVcCf4jsXhl1l2028FU4vhrIprjpN2S2TNt37B7IZJ5N1/y57EibToAAh1lXLn5OT1NvPnHZU3zcZGKwO9w1cx0vjzORC5jQNoWSmNvzXJJ5/pMkHE6IOkhhj1XUfeE1xXHjLTV9e2Oa76VZVyIte1YbYLLqOZCBsuxQ8bL+Y6d/10WTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt9zuRQ0m19waCPFD5el7NcnBjZbATOznSODOVwWl14=;
 b=jWzi0YgBJGWVfyCDCeubpVAMrcqESkfCzMVJ5vHdO7NB5C90wAqd0F7Pzm/+CQT5T7qMBkupBxnk5D6AVTB8k695INAzxINPKzGLkqso3UBurWa8hLdj8KaX3QC5ZCXyzrY+0f0cCNd6Fa9Y5aES/YfpRl5ONgSLVfL1eGi0NbIP/Ufhr4gN/rRXaX/iH4VrcJYLrHLy6eA4FprEteMWlZ4c57+TFgRY7vbzvwLw6EaoITCFeSlcdFWTrplj4QAcfXLlWLJYX4uGP07qzvE+4tTGiRk6UH+Q557ZKU1mxLZiaX0/tp1kkaWcdNlTyFkBfoGJJG2gMY6mKm1Ju8jKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt9zuRQ0m19waCPFD5el7NcnBjZbATOznSODOVwWl14=;
 b=NkLGiZR2/oCxf+vXTSo8mvtaHtE5fRfkIJT+rfUQKXperYiYvH2cDfx1qPPtjQ9BfWqnINX3SEqbngLtG/s4lfsbICkXkyPSESDuRYo3XmdTzcwLTICwdZ9rvJZylwt0GsxdTtZ6OhkSAPGpTE70pdVTOx49xW/WDLPqxU7OUjY=
Received: from CH0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:610:33::19)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:33:32 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::78) by CH0PR08CA0014.outlook.office365.com
 (2603:10b6:610:33::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 20:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/10] drm/amdgpu/atombios: drop empty function
Date: Mon, 6 Jan 2025 15:33:08 -0500
Message-ID: <20250106203310.3349585-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b53cfd-d62b-4fd5-428a-08dd2e91623e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ebV90l0yQOrog16ICXIT7zcdGDtWO3zHUd9JhcKSO7vsstfkR+MKK9YOG/Cc?=
 =?us-ascii?Q?SvkbbMY38kMfy8l/rMeKfK2Mka2YkWOxxKAm8wli8UX82ZM7wSDY7A0ieZMo?=
 =?us-ascii?Q?D/OM6+Oj56y/CDiyTX8OMwoIpbtTd00qyAtK9DdGQdDwBGX2AaDl+n6maxYA?=
 =?us-ascii?Q?4ZncYfYkIpkwZuVepy7Al4WdgEDdJ5HwO60j6t1vaHXCujW9yhuMBbi/XbcE?=
 =?us-ascii?Q?l49YkZpHNFvFd3Jt8lrusXAsD+CxCIJbjPuuPPVdjwmCxQGQnPT6NZyf3ljU?=
 =?us-ascii?Q?dJqg+PQzeaeabO+5YG7OfJcw/l1GvVk1rwwW6hgMGOdM9G/L1zJkRYt3VRov?=
 =?us-ascii?Q?1IYSx2NftH+PvUTTMfepMTsrzgEacKhR8P6drluRh3nsYy6cLlyORryCxPRT?=
 =?us-ascii?Q?EiPSmbF6BHc7IOYglbuptpW8dwcCIP14l8WyRs2RwDMDW9UuIHAh6NZdfWXM?=
 =?us-ascii?Q?sSF84nzXGGcsozCH9zOP4lI22t3WIKsUC09TPWVeGAk/hPRuUNUpcNfjSax/?=
 =?us-ascii?Q?nfV+tohp7cK0Z5F8l3JwNDsSH7sLmL2YmAiYChQ2PbaaLZKdLS97wImQaH7s?=
 =?us-ascii?Q?Z1TyLa+APNE+tg8FzEB7mXd1PREQhHGMsTpFFW3Htx0kfi5yOYroVNWSjky3?=
 =?us-ascii?Q?HP5LpjsX8cJ2bOLDH1gSWyuPb6i9NAgIZervJwQYrTZaT4lFV3DwNWRRJpwz?=
 =?us-ascii?Q?xA0EArkV6a9qdmT0mn/fje1LfN//nbuGr89L3yAMEe6UzFW9KWWHR/kyo3aB?=
 =?us-ascii?Q?khL0SnfSdfaSQBidrDsJ/cFlI9uS9O1cpfohjni0p4VsehRqevlE1XTQILMA?=
 =?us-ascii?Q?eyxDCIkGtmSqj0s/4Q0nM3fbK6s4qDL4UmJmiAYayzoz0QVcy407M4Dv3Dwk?=
 =?us-ascii?Q?Qu39Xh4+r8Pws1DBT2Y1F1Y8PZOO2p/K//XWzG/KoAr7Ucy8Vdf16SfV8Gt7?=
 =?us-ascii?Q?tTvjGrjherLcfkNmWBLn7ZoVextdE5k4q4ex/BQAfDUzkMadNG4QHEpIGoo+?=
 =?us-ascii?Q?s6IrC6+aVU/11Elj4MV2FJ788L63sUT8g6cWZevyPJ/ep4/rD3Kli9wYLCRa?=
 =?us-ascii?Q?/IqfH/G/Xuf8NfeQnOfoNFuFvQTnjiJzVkBmBMWcWY81YyT2+QOpEUbFdqrI?=
 =?us-ascii?Q?3hd15FefHHv1gfZINpo4jb1QwTYjNRMf32XyOxGMsV2n1LX1QES9LIIvMWP4?=
 =?us-ascii?Q?xDkt5x83vIX3J+QXfjwvvNI6jDpgewOLsvR+cqCKA5Pf8WEpnb6nNo10WZVj?=
 =?us-ascii?Q?ZdZVJkDkGzUVV6j8HlGn28v0kqO6od9np+g3Gn8kyKbmOHazGFvEKaC1YJ04?=
 =?us-ascii?Q?n3X/zuPhdhSRbKvFURoyKTHe27gvw81jjhgi0l97BXLu5L4Zo8c0ugakrfQ4?=
 =?us-ascii?Q?6FdgqlJ3Bk+h4K+IMJu5bP8HZ2+BtqttQ86AQ9U1dLRVUGHdnqP4ylbJA4tt?=
 =?us-ascii?Q?MLoWR1AIL4Vb7rQ2OuYY2dvNcSY0BVCkC1ggTFv1OLn/9KvRgpn/ZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:30.9080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b53cfd-d62b-4fd5-428a-08dd2e91623e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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

This was leftover from when amdgpu was forked from radeon.
The function is empty so drop it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 093141ad6ed01..263242bd7c10c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -36,13 +36,6 @@
 #include "atombios_encoders.h"
 #include "bif/bif_4_1_d.h"
 
-static void amdgpu_atombios_lookup_i2c_gpio_quirks(struct amdgpu_device *adev,
-					  ATOM_GPIO_I2C_ASSIGMENT *gpio,
-					  u8 index)
-{
-
-}
-
 static struct amdgpu_i2c_bus_rec amdgpu_atombios_get_bus_rec_for_i2c_gpio(ATOM_GPIO_I2C_ASSIGMENT *gpio)
 {
 	struct amdgpu_i2c_bus_rec i2c;
@@ -108,9 +101,6 @@ struct amdgpu_i2c_bus_rec amdgpu_atombios_lookup_i2c_gpio(struct amdgpu_device *
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
-
-			amdgpu_atombios_lookup_i2c_gpio_quirks(adev, gpio, i);
-
 			if (gpio->sucI2cId.ucAccess == id) {
 				i2c = amdgpu_atombios_get_bus_rec_for_i2c_gpio(gpio);
 				break;
@@ -142,8 +132,6 @@ void amdgpu_atombios_i2c_init(struct amdgpu_device *adev)
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
-			amdgpu_atombios_lookup_i2c_gpio_quirks(adev, gpio, i);
-
 			i2c = amdgpu_atombios_get_bus_rec_for_i2c_gpio(gpio);
 
 			if (i2c.valid) {
-- 
2.47.1

