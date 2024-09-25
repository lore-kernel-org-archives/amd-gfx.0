Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9B3CCF9E7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 18:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72FE10E2F3;
	Wed, 25 Sep 2024 18:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q00Lxorb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688D510E2F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 18:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp7rPC1peSCvOsupgU7TbAgzqysO7injd0WMxKikI3UiPWIBYBQf7ADA7YNRyDpi45bfoTN7smUl5ymIQ5hg9Gdy7Z7VWrcZDbtiuT21NEwbdWDWDNsU9Ss/mbaNqJwwTKYPYokbjPbnkA3vvj+X1hMd5ydQ7Q9f5MIowYWYqhKqAPuJvlxPuyXSN/dKoAbRP1jy8Wvng0e2I1Vx7keIcejRgh3tb0tjzlnp3NV1Ryc7iIN4D6x/WqK02guS1bBPyG9vYTuEiwvygPc91tk+FJj+SzaWygsmjvV5UfSmr9llNncH6zWXc9c3fLcHgGPy33azZLrmb9hLgDH8vnimLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RDEdbPH99Op8LH9qnSj7t8VfIkZR6mOzSH1QdBWY1U=;
 b=v/qy2Zvr1ARvBJnaJwCXGjOHv1ZEO7tpN0oik1vh9T5wwy85D0APwGj6/8MuaePykarVLLoANLnrqnLaP042u1i6aTf1PmcfN0cz+v5NN+p56FYQwFtAeYzZenb+UNQkuTApnCEjmIbMcpnx2vKQZC8Q/0vDHR1hixOIVZMyWkB6ZPUEiP9K3HESglhFV7KT5zRIGwebpnnS5I+Obzn4nrkx1qxcox/cfepQffJCZFmnnndeNjVb+rM0tHusWMO7UrggIy45u3yKvhhjtX8Z50r2ZhU7JBzclpIE2gDqWaphblo+XWm4qx7YjFjokfQ43EgX/mkJZaIbSQZZee8e0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RDEdbPH99Op8LH9qnSj7t8VfIkZR6mOzSH1QdBWY1U=;
 b=Q00LxorbjYxj2b1a2lQSy0UJClq+1oLm/GLP6rZYm+kq4jHzDQ4y75I3/FTTj4dBxLCK4jcRNPeUqa/yx7epinr5rWswbbmQiVhSoUBJ9TDnEqtc9FVcea2WS2lcGZ27jxsZBiPtb6oO7/+ccA/4LHGI7QeUD+zeIqqaIgDRyHw=
Received: from MN2PR19CA0049.namprd19.prod.outlook.com (2603:10b6:208:19b::26)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 18:20:28 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::39) by MN2PR19CA0049.outlook.office365.com
 (2603:10b6:208:19b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19 via Frontend
 Transport; Wed, 25 Sep 2024 18:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 18:20:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 13:20:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix vbios fetching for SR-IOV
Date: Wed, 25 Sep 2024 14:20:11 -0400
Message-ID: <20240925182011.1194698-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5958e0-90ec-45ce-be78-08dcdd8ebb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MLPQNXp+EThBbX6R0OtrRJcrPBux6UrvO465t4kV6K2NU0m4+YIs/kRJ+JU9?=
 =?us-ascii?Q?ffQyzUKjThb3u99tVSclm3j2gZZDRUJDzRWECgEGK+cxRzY3baSIN1XJJlp/?=
 =?us-ascii?Q?ZzROd/PLHPaiIaAlNY3xi3VothKsIZGd/MQICGw53g2OuPqAQbRU0uVFOl6r?=
 =?us-ascii?Q?rvrYeI7C1RaoDH5sgEiF4VQjsXx5H6rLNeskIwk0xyYbb91pJFud+8In0xRg?=
 =?us-ascii?Q?a3a/OAl9y7x8evv399Nx/kPJ14evsrCp06FVeR3vulLLGGNIPdKdagOH5UC9?=
 =?us-ascii?Q?XOzlz1Q4rYC52nAPHRAvBAc1bG/4peUWW+EphgLoRoLrEHXhBvdRpjyFoIp3?=
 =?us-ascii?Q?4BGAwvGBPdQx6RETqPkl9q2+HnhSy7rgzLW/VTcfoCDqsr+F7S64vO83w0A9?=
 =?us-ascii?Q?KKG2XMcL1jM4uxoQRz+mgJpiuwRi2ToKtGtl7iiRKOfMPb10RKIYLnmctiC4?=
 =?us-ascii?Q?8tYlmBr4tG8atJO70iEP8A6Ck6/V3o/IVWEwGAvKuOySC8EiGDY0OX+oGqn3?=
 =?us-ascii?Q?wTB3uYuT1A8LOGIH2toMPJutEFuHIoWQs6mo6wfxEZnS3IAdYmonXvl7IsgB?=
 =?us-ascii?Q?H9VymoiI351SBUJIb6jxYFljRw3jT5J//Ivd6lA0cDWA+CBBlOunCM13uoND?=
 =?us-ascii?Q?u5aSObjrbb4Wpp0AL3MXNQ5C+C2yN26szEolmjc07fnwS26oZpj9sqJukij/?=
 =?us-ascii?Q?gxmOozVM/tH8LkZ+TEU0aU3t716rbZ7/nEoEIuFL1t71LPte332t8dgg/Bqm?=
 =?us-ascii?Q?O3+SiTYRBhZkt1HPz+iABJh/ZrHg/P6UnWJBhLkAYgXfDT0KM8Hiwg5Wfa7C?=
 =?us-ascii?Q?aHXph/byD3Tw8xp/Nv96VEq+bTYL93Cz9C1FVVk8XcCdVouXpicpgdz+7mRE?=
 =?us-ascii?Q?5Bn4j4QaEMPO4gwY+p+o6Vn3xpqEUlsmmZ5cp3uxbrKomMT+1Z3NXz4aBRZ2?=
 =?us-ascii?Q?LTeW0PT3/cfduYK9InZ/6bU1Ct81FLC9BSExtfKfRHwcyVJ+i1ibJJvRStKi?=
 =?us-ascii?Q?7tSAVSiT3c0llhPqNIcEWEmAB4hv83PCdkGCFe+Z9IR/wioM8pNGSFNfQQl8?=
 =?us-ascii?Q?FO1qQSuRE1Nc1gANpAC564yy1vuhdyXoNUZkJ/3Z7iqucw9RZEYaj2WPwLRG?=
 =?us-ascii?Q?ZqGfhPzLfOvZD1e91UbnGO8KEDiqCpxlIQSo7qDvchW1112hqeGgMbpSNwsn?=
 =?us-ascii?Q?kvX3kntoj3rXzOcI2zgABI8zLjSO6YHQ61mj7LTXu6ngfRKLZ9u1F8NV0Jwe?=
 =?us-ascii?Q?QwARVsxAlkIPCSwuKA5xiQqZdfag8Flzi6V8UQxV7whc7sZrKLWwCeY4XCwg?=
 =?us-ascii?Q?hqZHTLrzAyNtsN+aUmzi/I7C6W/o4reZTxhVsOCSBn4wE5Xhs6oKNPJbOZzu?=
 =?us-ascii?Q?F6Cdcn87bAXXgkLPjB4einQCLGHm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 18:20:27.4746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5958e0-90ec-45ce-be78-08dcdd8ebb32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
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

SR-IOV fetches the vbios from VRAM in some cases.
Re-enable the VRAM path for dGPUs and rename the function
to make it clear that it is not IGP specific.

Fixes: 042658d17a54 ("drm/amdgpu: clean up vbios fetching code")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 46bf623919d7c..45affc02548c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -87,8 +87,9 @@ static bool check_atom_bios(uint8_t *bios, size_t size)
  * part of the system bios.  On boot, the system bios puts a
  * copy of the igp rom at the start of vram if a discrete card is
  * present.
+ * For SR-IOV, the vbios image is also put in VRAM in the VF.
  */
-static bool igp_read_bios_from_vram(struct amdgpu_device *adev)
+static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 {
 	uint8_t __iomem *bios;
 	resource_size_t vram_base;
@@ -414,7 +415,7 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device *adev)
 		goto success;
 	}
 
-	if (igp_read_bios_from_vram(adev)) {
+	if (amdgpu_read_bios_from_vram(adev)) {
 		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
 		goto success;
 	}
@@ -448,6 +449,12 @@ static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
 		goto success;
 	}
 
+	/* this is required for SR-IOV */
+	if (amdgpu_read_bios_from_vram(adev)) {
+		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
+		goto success;
+	}
+
 	if (amdgpu_read_platform_bios(adev)) {
 		dev_info(adev->dev, "Fetched VBIOS from platform\n");
 		goto success;
-- 
2.46.1

