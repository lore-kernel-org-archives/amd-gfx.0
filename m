Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4923BC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 19:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAD110F25F;
	Wed,  8 Jul 2026 19:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vuPdhkXf";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D996510F25C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 19:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnPg7KJdT3zSp4HBwaJ+33tpd2/T3PBs9/grJOXl6v4mGf8jIIoOHB86vOU2fFyzjL17rjv8zjbF6DLS2ow9ruPDRydHRaIk16Voh/f5b5Qv3Q0X8BdN9JAsG+v5JrHQhvshq7m4eOtP85s46ad797QGncQAullVd98uQH0nisoB6+Xs32IxT/d8SnZ1H6cf0OAANe1SnSMcXPv6R7zSKQko/bjjqLMqoMQQMcQU+e9pZXqm1NxCUuwX+PFyBscTwkrFZ6BYFJCLl9rUPhdYeFOZvVedtG9q8yer67WXyrU1Z9NCGNCYEjbgjU+nXzICpIHi8OdDQPA4UyT6fbW6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpQaePybtaxiDQ6GPUGTSWmpZgQKIgLREntIP9D/gxo=;
 b=QK1FODmK/q0SWyJodEka4sxIHbrcPQwLIbBvPjCmHr8hwo6offeKA43P+5S8EoKP1jW3n+CVyexwvfwCR7KeGvGMWkQV4IbJ2UoeaG7DBrUyFHVy9gRloJLQMMfYurB8mxLqE1IE7fmqIEnff/ZDaltxGcuekmNPWtUs9tE0f42DMWEulfoG62Mb2EtbQAMKhCzjH4Fg9eb+63Isn++shbp8j6QTKpkA+0kojkf2wNfy3Wd+2MUzBtPrpl5Ges/UsmgdNyBkIuk5+T9pKHa9H0r/WRzMdeA5yxUtkehXXmcr3Ti0ST6WbzYrDtHwGJWRQ7xN3DeEeSCRw9glfbZZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpQaePybtaxiDQ6GPUGTSWmpZgQKIgLREntIP9D/gxo=;
 b=vuPdhkXfr2ZlSJCb5QxMAtwJtxgYVS4n1uwssuRIW3yZcbnbM/3dXERqI/EhtcKk01V7F4PwvqIdrkTGrtjpZDrgCxTxyGkRYpuWx5UMEBGunkMIJJyj6h06RcFUtokrWH4uV3TEfhktjpCT7dphJYBpmOYMaOEVo8seiNhIWqI=
Received: from BN9PR03CA0914.namprd03.prod.outlook.com (2603:10b6:408:107::19)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:35:34 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::25) by BN9PR03CA0914.outlook.office365.com
 (2603:10b6:408:107::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 19:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:35:34 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 14:35:31 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Oz Tiram
 <oz@shift-computing.de>
Subject: [PATCH 5/5] drm/radeon: Validate VBIOS signature in VFCT path
Date: Wed, 8 Jul 2026 14:35:18 -0500
Message-ID: <20260708193518.702584-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3450d869-bb86-4587-30d3-08dedd28143c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gP+SjANp/2W7314STBXFL6N0x3UNYdEAqQvrvWUcEugGhJofHXas/mN2X3QCbZijxo6lVFfoWzq/aMcARswRU1D9HhkJJg2N5rH1jWNeHW8XC5aFvTWs9ZagUC1MIY0IGcaecyhA3A2JU16Qf+ZqybcIOmr3AH9eQjc838+tcPR8V+08cgVvVIXiyww4X4SEOjX2eQZXFO0RWnM9Ick9Jhpc+uKSjRRq7WJIE3zY3dIANgeNXMnn1cEh+WTSIOJSSyXMnz/lc6YUx0+U2HTp16Dq9ekZh2vc0jLPjZVrXxL3y3lk1sD4fgBiTlWrfMb8XmE6cnPrzcFcKVicc0TD3+60uIwY4XIs0nOm0qg6PdUq7Hhm2ZbcrofulsNsTmr5damARJ3y4sIel6MuyvFwGDmS+0Rskgl586kMhYCEKv4klOS075PHpXjchTeIwCiNNdO6AFqJnt8QWiDuWHyZ9fAo4/GCmSMoUeW+FnAKTdUcamdtv08R/ukZnPKNfsX+u4Z364jbkxErtstAS6hKDIiDZKZoME+Qbl2KKxVISbc1q22vIRUyA3ctwnkFWPEcabm7ozQX5r3Ny7hyXNdIZewWbzIZRLywu5o+tK1jYTUxo4RJd0llA3bWi4BAkVxB/rFUyFeE9mqMbRepmDqyWtC4G4dVXnbD2DbNZyzHTjdEWugEuvK/pBcKGB5q7y/rxqCP7C5PEtU4nGYXaC3mZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j2DOJM7Hlpt2d6UkcunJ/h1D6R+6fMxx7EAy5wKORq8it0z5ldNkF5bFMmRsNU4nTX0AjZee+9aLbjPlc2vpd/cPIzp3+DGdtinX7KSSbq2uAi/93GV4lI49vCqn1KtMYFHgs1olIHh1K6vXHZpMAurNbp4ggUrpw/BKnhoK8FpG3tv8vPJTe7RslJfG6NIZZ0TNHkY6Synld8TLwQeXG1nM6FwizTipyl12VQwuytEBhS+Zi7mubMcVxrG/xd1tLc8TnwJuPIANT2rHXIheTrRiunCfaCopvrwq8WXv7hIP9XcHNJ36IvHlvpC6JyZmuJGmVw6XSvyRdpCPH/DxnBxQBw8lIwR31gTegyUUFbOG7TEX0iGZGMGfuOpZO3dIgHMiX4r0z1EujLsts4pkatnGoURRdEqECB1AqFlg0ltxemZ/4X3lRRb7ck7evJXR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:35:34.0687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3450d869-bb86-4587-30d3-08dedd28143c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
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

The VFCT path accepted whatever kmemdup() returned without checking
that the copied image is a valid VBIOS. Every other radeon BIOS
fetch path verifies the 0x55 0xaa signature before trusting the
image; the VFCT path is the odd one out.

Check the signature after copying the image and reject it (freeing
the buffer) if it does not match, matching the amdgpu VFCT path
which validates via check_atom_bios().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Oz Tiram <oz@shift-computing.de>
 drivers/gpu/drm/radeon/radeon_bios.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index cc10880af096b..215e47c94d29e 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -676,9 +676,14 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 			rdev->bios = kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
-			if (rdev->bios)
-				r = true;
 
+			if (!rdev->bios ||
+			    rdev->bios[0] != 0x55 || rdev->bios[1] != 0xaa) {
+				kfree(rdev->bios);
+				rdev->bios = NULL;
+				goto out;
+			}
+			r = true;
 			goto out;
 		}
 	}
-- 
2.43.0

