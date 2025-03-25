Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB43C3600B
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 14:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F5A10E57A;
	Tue, 25 Mar 2025 14:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f7IzpgOJ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D71B10E57A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 14:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOQojdVzNnSQeCPfE+Im8dU+OiPupZ8aRczC4cig2PTboAqtMWcbgGzNzi7fRHpIoXZxzbwLekTWzpdQZ1MCYhp2Lfd9mJ4jKG231B2HwQwNCYygX071aGUglv3wc0ujwg8vLMhXFV9ns3My7rKo4S7kvvQsfMYE/1iZvcUlUVUlw32GXfrQ2qlHygcFNugzEpg9UCVlwJWQqakuhMSsX3Krah7l1J4q6TpRNuT0cY6QxcuMcigoPv6GeIUmT9qI4GRKYCIyvKv9HhgCzqIs/o4IjojyrQGSEvzYUC8ZGYvS2RFSEmq2eHAQZuVj6UX6hNa2fvymsvr02UDHCLReLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCedruYfEViDXVhtDeNfSpfZS3mqmPi6YL6KOX95YUA=;
 b=FTzE6nwFn9BnnW80/6H+Fch3UjPy1gA4t+XbcRO4Kx2G7Jw5FZ7gdwYUMQqp5i9r03L4Dj4cpWnLU+u6KhzloL0URtpo+HI219gg8mllmY/G6Usst7xvk+0ReZxAf/Z+z5SYjE42CvR9Ne0T407VYZZOqHrCtjeumYAQRRdI+4RTS5c1EQBnHj2i0KPOgkZgq5vwrB7VJQtB1YXMqdU5ox752alqHFv/pIbgNy/n7ktjPLyhu/tE9vwH+597C55wC5HdSivw+bqW1lT6iy/ULqDFu0/24fiHoPLTD2ZMGUma80DhRty4rm5muwHDzqDwuXuBPa0BhshQr2cI/zm7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCedruYfEViDXVhtDeNfSpfZS3mqmPi6YL6KOX95YUA=;
 b=f7IzpgOJnEuC7f0dBDBxEcteQa0VwLrpshfleEH7tgvigCtbAQ/y0pA2BMqDe6DnijBm3d9hMacjmkaihMFbh+ge6xnfs9epm1ex+VqFPwESOXC0uCdjtUb1RwPKaRQrCiYmAqJIZGZZVMG/RVe+u9gygX0ILW7mync9Yy9JNXM=
Received: from CH0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:610:11a::25)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 14:14:31 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::85) by CH0PR03CA0334.outlook.office365.com
 (2603:10b6:610:11a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 14:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 14:14:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 09:14:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop some dead code
Date: Tue, 25 Mar 2025 10:14:15 -0400
Message-ID: <20250325141415.424864-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dc46c5-4739-4498-461b-08dd6ba75b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C6AzVPqNgrg+8VblVnTozdGHFqRswJHoJVcddMryqMLx2l6zxptPFjASOKR3?=
 =?us-ascii?Q?jkjQxuY6AQj5isvV+gwTaqs0NL9gRMn2g7+i/khTg6gI41V6Z2TZENVW+MUL?=
 =?us-ascii?Q?TG4CEzsfvlESBcm34orVxkVLnwb42TVKDcvG/2m8lQTDSt+JrbVy7PTVxUiT?=
 =?us-ascii?Q?xf/kK1R8x26zlSHOfTJyBtmUNrqhx+ltK7nnW30IwhdVxF4ADkzK5OVtcNq6?=
 =?us-ascii?Q?yl7hy/Ui0nlgvi7OOwg9dByfZexg87kT7aJln5d4mhu0VQoi225eoHyvzfMv?=
 =?us-ascii?Q?uqeSKqIorkMqQTIrTNZlbKuvQHGp2741sPC7UdFV2A+fhIaJFFlQJelj8tId?=
 =?us-ascii?Q?5btwcnCYQg9BDozYHw49x6co08M7KW8XNOR+nDinYd15gWAwT6BE3ceDxImt?=
 =?us-ascii?Q?AbKcUOCVsrjyUg6bqvgXQS2tRRQMlGQgOhTZ267vM4mBL1LItPivJYhDeslr?=
 =?us-ascii?Q?VW+qt1aihuaAnncq5wEwdMxRkYQonALLJYt4Ki3rrkmE1OhnbdT2EcDin8WB?=
 =?us-ascii?Q?yXGtdi45gUw2iW5kCLKgzATw5X1O7jCgnckROgfciYVIyFA5a4RitNNsMlXV?=
 =?us-ascii?Q?dv0hINzJaTuMuunOKwpwWpBGq4XBiXgfMYxjbF+nWhMcbEyTaQWcPasjncsr?=
 =?us-ascii?Q?3HDlHYc81asKRCljAECDVNtGKqnr/yr28OOHxN44g/knILbjckRrJFEEAKym?=
 =?us-ascii?Q?d2elieeG1qnUIfJf+maQD6powroeaBm9Q64S4kCqME6v0khrsOaG8ygzae6X?=
 =?us-ascii?Q?m4C6ZQOlInFaK7CbDwMPoZWSF14DrXdmzx20uogKk+0VE5BYkQQg8rmHYFOh?=
 =?us-ascii?Q?wYIPpwTaCR+lzdmAHReeimHRTk8TgB0NUjYOP4mx1ZXWcvrYLwQum+nLVcwx?=
 =?us-ascii?Q?8+0aVWiSNmKbDioggonFvChhzrGuiVg8Yp5/0WcH+bfdC1WdT+2PT72wwboU?=
 =?us-ascii?Q?fGBx6zAZ0eQPfxCcphUla7gGjoagp8VtTbjeAknmMtAKWvI1A93J9JUkG/dn?=
 =?us-ascii?Q?1FCZdMrYc46pZ99Fsg+IHhD/fgZBN8PeCiyyaRFt2ixdgM0FaQ/kjK50jjcz?=
 =?us-ascii?Q?Uk3dq8I9dzdt/aMFwMe4jZP5oZROT8ygZGR/n/tE5VucIec1JZQSPkhMNnLw?=
 =?us-ascii?Q?RfuDH29od3OiUKN6aoS/dpoSgINKWX7KX+trl6jA1ombV1EUt1zDQOEiYQPA?=
 =?us-ascii?Q?aIe9lZMUae9x1h7w7JKhtYR97Dv3++oWx78jBKZA7cJ1dgN2aLIxt8Qq9P1l?=
 =?us-ascii?Q?LmcfFPSWCtNnG1Bu19zcdvOZI/2F2ownFc6nBsj9g1goJfflJ9+48C1GO697?=
 =?us-ascii?Q?4g3g5cnsZ3l5+Yn5vwZFKRMt28Ld7WHYzH3x5ni3qIcHDAOc645Fp1mgH3dq?=
 =?us-ascii?Q?PY/j3yuRjgt9C2OLvLCaFxCpuiyn/O9JQDMm+oO6HacHcCgj57PQeokGSZEq?=
 =?us-ascii?Q?AKAApPbpgQ64FEu6HS1Nvvr3aICyRo7XoO/Xct+2TXQJm9V6H+db8Ar4HYs3?=
 =?us-ascii?Q?0+v8yB3u8t+UGc0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:14:29.6269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dc46c5-4739-4498-461b-08dd6ba75b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
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

Drop the cgs smu firmware code for SI, it's not used.
The smu firmware fetching for SI is done in si_dpm.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 61 -------------------------
 1 file changed, 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 525e53c94f4f5..004a6a9d6b9fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -252,67 +252,6 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 
 		if (!adev->pm.fw) {
 			switch (adev->asic_type) {
-			case CHIP_TAHITI:
-				strscpy(fw_name, "radeon/tahiti_smc.bin");
-				break;
-			case CHIP_PITCAIRN:
-				if ((adev->pdev->revision == 0x81) &&
-				    ((adev->pdev->device == 0x6810) ||
-				    (adev->pdev->device == 0x6811))) {
-					info->is_kicker = true;
-					strscpy(fw_name, "radeon/pitcairn_k_smc.bin");
-				} else {
-					strscpy(fw_name, "radeon/pitcairn_smc.bin");
-				}
-				break;
-			case CHIP_VERDE:
-				if (((adev->pdev->device == 0x6820) &&
-					((adev->pdev->revision == 0x81) ||
-					(adev->pdev->revision == 0x83))) ||
-				    ((adev->pdev->device == 0x6821) &&
-					((adev->pdev->revision == 0x83) ||
-					(adev->pdev->revision == 0x87))) ||
-				    ((adev->pdev->revision == 0x87) &&
-					((adev->pdev->device == 0x6823) ||
-					(adev->pdev->device == 0x682b)))) {
-					info->is_kicker = true;
-					strscpy(fw_name, "radeon/verde_k_smc.bin");
-				} else {
-					strscpy(fw_name, "radeon/verde_smc.bin");
-				}
-				break;
-			case CHIP_OLAND:
-				if (((adev->pdev->revision == 0x81) &&
-					((adev->pdev->device == 0x6600) ||
-					(adev->pdev->device == 0x6604) ||
-					(adev->pdev->device == 0x6605) ||
-					(adev->pdev->device == 0x6610))) ||
-				    ((adev->pdev->revision == 0x83) &&
-					(adev->pdev->device == 0x6610))) {
-					info->is_kicker = true;
-					strscpy(fw_name, "radeon/oland_k_smc.bin");
-				} else {
-					strscpy(fw_name, "radeon/oland_smc.bin");
-				}
-				break;
-			case CHIP_HAINAN:
-				if (((adev->pdev->revision == 0x81) &&
-					(adev->pdev->device == 0x6660)) ||
-				    ((adev->pdev->revision == 0x83) &&
-					((adev->pdev->device == 0x6660) ||
-					(adev->pdev->device == 0x6663) ||
-					(adev->pdev->device == 0x6665) ||
-					 (adev->pdev->device == 0x6667)))) {
-					info->is_kicker = true;
-					strscpy(fw_name, "radeon/hainan_k_smc.bin");
-				} else if ((adev->pdev->revision == 0xc3) &&
-					 (adev->pdev->device == 0x6665)) {
-					info->is_kicker = true;
-					strscpy(fw_name, "radeon/banks_k_2_smc.bin");
-				} else {
-					strscpy(fw_name, "radeon/hainan_smc.bin");
-				}
-				break;
 			case CHIP_BONAIRE:
 				if ((adev->pdev->revision == 0x80) ||
 					(adev->pdev->revision == 0x81) ||
-- 
2.49.0

