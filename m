Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308A9EFCE4E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02ED10EAC8;
	Wed,  4 Mar 2026 22:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYqqA/W9";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E47710EAC8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWLYLWdyg29tesTN15EUmDBRaDe4TVl+MSbSbg8Ka5vbxzbmrOqFQxGtJ08JJvg0cbqICADKSslcxYYZN3+DNT2j4DHvYQuhTEXH1/u2tsrPjjtI8Mf3x/S3g/Eoluc4Za04iR/EioZnOOo8U/vVbNuWwrHiLcnr6LgMM9ghBcYhgpmQiSsKnty9X1ZWKe2YvQHG8FrpTclVBajQxWVw9LGDXaERxpyIn0riuzxp7zdsTxj+o1goV7lLdjufYc3CHfRUUKYcWgUgYNKQSdc0y+I8p2GUriTxpK7q4Vm2HX0QdZQ0QWa6hL5ISbrcTaBP4sxBy/y8ftuf01b263DRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMst8PZrfyEewO6cR9xVd6bVxT+f5hOp5E13jbIom1U=;
 b=ZBPzPVyuUUuoz95XleDEIHy2dVzdWL2KKXTWOPGgJ/Rse5eBIihzrUCwZcEgzoQCgnI1AcUMmtgOLgcEZ24t55USVv9zYK1139lYMQRk5KFNzjtOjVrvMWRqC4oWnJdknIvdWcchiTbfKTjV3EEBRuobSOsAUIQc0P+GxNll2IzI66t8tpKPZ62q9xehI3gKoYNVz9RbPLO2VoUqTnyLJ7EMfxQiIZPON1d1bYHmtAYVDOdB9R1I10GCCb5UC0vs/i9YdqViRiYSBVoUuN24BPmt58eFrucvoh7IZQVtKaN/2CNRSkKjPVqMX9fcjl6hbqrL2W3P8ZI51ahFAFrGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMst8PZrfyEewO6cR9xVd6bVxT+f5hOp5E13jbIom1U=;
 b=RYqqA/W9eB/UTH+TPdYRu2rXitMIJJVgi2ooMfiNJg+ycvnW+NPThGmPqbo7g4cetRUq8zvsA0S/5J22ccpQ4KP4/NVJ04Yr1jaU9Jp1Ajie/sTHoAq8q9BWtlrrjY0ucfp9RmgjQX0ZM0FRNseHau6jrMT25l0+V0IDoYuGt6w=
Received: from MN0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::15)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:27:45 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::76) by MN0P221CA0005.outlook.office365.com
 (2603:10b6:208:52a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Wed,
 4 Mar 2026 22:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:27:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:27:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 14:27:44 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 16:27:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/mmhub3.0.2: add bounds checking for cid
Date: Wed, 4 Mar 2026 17:27:29 -0500
Message-ID: <20260304222732.2403409-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222732.2403409-1-alexander.deucher@amd.com>
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be4c531-228b-4736-ee09-08de7a3d4212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: F05wISrxfyoxh2Lv7Q0rmMBhLDR2VqXO+dhoQiIU0r5Bx3NmOE2AkjKdsto9LEPm8xsVbdPJg4jDVcHOixwUmgyD4+if2tS1zQOc9IyVFlNCDkQ670+n6NLXN6fMJ09yOpPo75cJl8myJKr00Ik61X21Zy1XbNhagu78bJvm/ab7K7TPIOGFDg9U3Vi9poJzkWYNhj7hn1/7LxpxpNCi/PF3FRjFNrLhGw7If9G/vyvTcu/Mv5EpidrVpDj2gbnwnGYliC49r9usFMUaAsJwXrlGsWQ9BHTcGMje0c5a/GNTTLsTKsdoRDVBYqUIn2Ym5Gzcs9niOf811BsAA0MiFwwNtw6w7YoOIOY5z1vcHJUnQ/ImGHxR3lugVpE4jZTXZNJVUZrZm4Gs33A6iXE0BA/SqKpOk49c053o5fpXcaS5jt83wdnf+IzJQ8hgNIybTgynUmUfDdkE00cABQKNbo/puxSqZwPyssv3MtJ6h0/VMvuUBcRrjizWICkaoVrqGJ/XfJPBmWXTPYIpbbMSEyUcVlxgLnRR2OomGbVAtdkhYGc/PjfO70VBTxhbz05TKBk3mu5cvNjcpgOemyLu9rmVPfMC24325eOVF00DLrfnp58I1F4gEtSwh/F9O1C3kzddYmNpmT1tprAvoD5iq4+JB+YtlMCLWGUb4WhaMrDktZJ5meHwo7yaEq8XFlBVg+yAMArry6kmoJ807jNIPKkMRm2TzO2pu7cTcO+9yurZcLMzuhjOSQm7N374UUyf+TtRvROCVMj8zTBghcP4MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UjDV2hgYm+j0cjmKnQEBnYKIIvdxw31p4kC548nJjjIzP2XgfDsLAUckQ9NU6iYc3WhgdDeFJYwF//pSjuHL9ESeao1ruwUwB7q9u07t1BT9v4Qmrz6XqaXkAP2VdRo8YaqzDWTgE0j7Y2DXryqZewSkrogYGyK1XMnIOgIVLDEl7qhXdronOKj7v7Z2TChtL7TTmkHcawDjH3QgHT5+O0XAdNeIHcKcJoJs/7S8gufyZTNvroUhIVVgnKtrnM7AEnV5XAyoYfRjI8HYOhJEederqBtvIVrMCB9q1yEkHV9lzx/ZZ10m4iYMWz+RrYgTJ7wfOxFSbl0B2tB7oVp7nAC0TNg8/0jG68CmwVqelyP5LKtW4+ixnKy+QZpD4j/DIf+HkO2QWU2ZSEk9LiDbBLcHItAsVqEAcf7jn2T87AXJSDOF7xFMiq0GA4YzSa1S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:27:45.2863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be4c531-228b-4736-ee09-08de7a3d4212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E
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

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index f0f182f033b98..e1f07f2a18527 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -108,7 +108,8 @@ mmhub_v3_0_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 
-	mmhub_cid = mmhub_client_ids_v3_0_2[cid][rw];
+	mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_0_2) ?
+		mmhub_client_ids_v3_0_2[cid][rw] : NULL;
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
-- 
2.53.0

