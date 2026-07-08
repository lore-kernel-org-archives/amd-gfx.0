Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DC2C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 19:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABEB10F258;
	Wed,  8 Jul 2026 19:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IiVMKSFF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD43110F257
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 19:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXu2FbD9R/PK6HLsEHtPnARDt0K9vGJ3nQKFbQoOgBoKiY6ql/aTAdMXGIgu7K/Nigyjgv/rq2/Hd3yoIdw1MpyiCFB4IEeIOwbS952EnaMTbAsJLLnv/PAHj1Nj8NerjS1HwfKIAVeiBHBIEvERKrl6p2snza1DtfpJFso8Gt87B2Jnh1kKZcYkD5hsIxNK+tkgpy/zOiSvI0svgIz24xY3QaOFytX2uZkRIb1sCDUMFT7dchjCvVayCYm1FnEfPizWI1Tboy/sNthnh9T59SvFmHSeiso5SRoVpivmwOgrg8YyQnaIH4z40K4GYFx1DM6Va9OK77miWga7CtaSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgVyJQRPyuq8bFDHkknrd5JZWIrg4kVl9ktcCUw2KKQ=;
 b=BvQm0PV2k4nP6jI4o3vkR1XyUeRQgNgnQ4tieBVAzOmUnYU6ZlpGJJO8R6yoGmanNPwhpc1MI7YP4QhJ38WCGAyjNbvqepEhonj8Ipw8Be+K0e5+r4QGnlHsmKSDi3XfLmXP30gqR9Gn/AWrXVYW7yZxDT87awmxpGdVkrQ0RL7EiOmIlRrJ8l5K7RneEA+fXPatEJSfdFHxN+Okg6T9dJCoL+UPF8w5jUtSTJdXuW5R6wjtPECXU3LIOUDc+1usHTOG9SKVL9lJdWnGkAdJP6lONkq6l2aBD4gh4FbsaaPhHvS04yaiv2SsIgLydCJ3bzjSScMxLJivKroyV4WHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgVyJQRPyuq8bFDHkknrd5JZWIrg4kVl9ktcCUw2KKQ=;
 b=IiVMKSFF6sY1Jrrtfiz20gD18HSX2us0KHsAC56GQ/bgI3Zb/RaVXcGCom9lxUYp0Q+eD/E0gP1BgfbkvkZoiTzhXGb+T9vWYNuEslHj0m4A2MGaj9fpGaulWxzXE+3ECWOIrvmWGTR9zE/HpbGp/zITBMr4M4RXoVbJRcJ1ezQ=
Received: from BN9PR03CA0929.namprd03.prod.outlook.com (2603:10b6:408:107::34)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:35:33 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::25) by BN9PR03CA0929.outlook.office365.com
 (2603:10b6:408:107::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 19:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:35:33 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 14:35:30 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Oz Tiram
 <oz@shift-computing.de>
Subject: [PATCH 3/5] drm/radeon: Modernize VFCT error handling
Date: Wed, 8 Jul 2026 14:35:16 -0500
Message-ID: <20260708193518.702584-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708193518.702584-1-mario.limonciello@amd.com>
References: <20260708193518.702584-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 728af407-0f2f-48e8-674d-08dedd2813e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zyR+rmH0xnD6QsXhvXfNEAwxsVr6oA6FPmqoYMYFXQBDSejplrDfYzkhjWkaygUjS/Ev25kcNgpLBdygM1jxYSQbTxIYfxiAfqSTC7pb8yAEbyUYq8vVOilCfEcy542WepM2663q+QQRTVS+73KjlGjapSIGvOVyHuhcVEcyCA5dYTIyuULNegRf6ZsNDFtwxwXbV8fKeqE0VqTEjmI3L9Pef8KJOns2e0uqrD7j77FSR6ChswfPNlAHJmds4fLbdYxanApLhMwObOugr0d3ncng2uDINOY18b2v++E7UFsj+cwBn8tXIvpz1P9BK1OtduPlj1C7niP9UkAwJD27Xo6xReTn9u5Ah/aIIBulbu5738G+DzI1KtWonC3+vSzzaD/eqlhw7Q1QckMCqYGrlqhwtYY1KsHxmEHrB4maRJfP5389vSEiO6SOiElfivj+n7Dx628triJEV6u7FdWaqsUt5zIfPfOsyMt5hYGjpzrDgSRXq8/c07TPhIo9tkMp0llS27k8Lto9PxS+FAzI/dP3RkjXIBkVgVXZWwLXehSsT355Nqfcmy56k2zyQ3c7jB/Vx/H2zIZV7mm9Ufz6311Pdoez5uTT3UnZBkYvEUxn12sSRaO3AMyrUCJJQjfIVa9C4SF2Y/ObjrJq1q50rHlEXFcejR/DfgUsob4bGONrXWarTmi2vD5OHj/8eEqFciC6JMJkWorp9PSa8rzrlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lU7gZA13Y0gFCgQSLZtaNwitCo+V/W5wWP9QHsqxdL7NeHGVfLBVDeUSQl5rtB97pVqbDcIHzsbXjaBWKdI47d3W5A610wZD1/4+UH0NhUP48HQU2SGNF9AUv04qTlA8ygeHKbGl2FtZ2Np8Xb684s3+SHkx+XRv4LYyNHOEm30S93fnKnC8fkzoUKCbUZN2HpcJ0vqAMArEsZ+7ExbU9UeFo2RxLD+pzAJBhcTXMmqtgwY8Cfg2GIuyp4f7thUOZ+VPAW+ELAtjAK9bQb3lnINsGQv4PZgrnl1mkCDzMphbIQ67BggVVjNxk/fIV++EvqkZSqR3zHatIbM1fVBJEMpPitD+aiyno6tQCzviFBAjy+NkEDjPdu8wX6fBNuiV7lY2CTXQkO2Tn9dwz5U/0khTM8usqnO1cKOLqnJGqk+D1N096gg8G8FOlj43X044
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:35:33.4925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 728af407-0f2f-48e8-674d-08dedd2813e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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

Clean up radeon_acpi_vfct_bios() logging:

- Replace DRM_ERROR with dev_warn tied to the PCI device
- Use unsigned int rather than bare unsigned for the offset

A malformed or missing VFCT table is not fatal: radeon falls back
to the other BIOS fetch methods, so warn rather than error on these
paths.

The goto out label is retained: acpi_get_table() takes a reference on
the table (incrementing its validation_count and mapping it), which
must be released with a paired acpi_put_table() on every exit path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Oz Tiram <oz@shift-computing.de>
 drivers/gpu/drm/radeon/radeon_bios.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 3a8c5199a0fe7..c6df799c3cf4a 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -602,14 +602,14 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 	struct acpi_table_header *hdr;
 	acpi_size tbl_size;
 	UEFI_ACPI_VFCT *vfct;
-	unsigned offset;
+	unsigned int offset;
 	bool r = false;
 
 	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
 	tbl_size = hdr->length;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
-		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
+		dev_warn(&rdev->pdev->dev, "ACPI VFCT table present but broken (too short #1),skipping\n");
 		goto out;
 	}
 
@@ -622,13 +622,13 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 
 		offset += sizeof(VFCT_IMAGE_HEADER);
 		if (offset > tbl_size) {
-			DRM_ERROR("ACPI VFCT image header truncated\n");
+			dev_warn(&rdev->pdev->dev, "ACPI VFCT image header truncated,skipping\n");
 			goto out;
 		}
 
 		offset += vhdr->ImageLength;
 		if (offset > tbl_size) {
-			DRM_ERROR("ACPI VFCT image truncated\n");
+			dev_warn(&rdev->pdev->dev, "ACPI VFCT image truncated,skipping\n");
 			goto out;
 		}
 
@@ -648,7 +648,7 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 		}
 	}
 
-	DRM_ERROR("ACPI VFCT table present but broken (too short #2)\n");
+	dev_warn(&rdev->pdev->dev, "ACPI VFCT table present but broken (too short #2),skipping\n");
 
 out:
 	acpi_put_table(hdr);
-- 
2.43.0

