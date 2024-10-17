Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069ABD2F7F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 06:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F95B10E7A5;
	Thu, 17 Oct 2024 06:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HLlta7Lh";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45AF10E7A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 06:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq02xlobQGuFhFLjIV4qnu3umij4KqFPHpTGUhypanZBEjtr4XUO/7eumFbmbcuoaZxWOibN5Ntg6iNm56g93n1Chameto2MoNbq0xscPYGhGK59pG1C05DPdwTM9vAimF16/bB92Y37o0j7YCWTXC9IPhXgSQF/aFx1gdnngmwyzY6PgPRXyXeLrluw6MlzlKu+DlVykcP5KovFCUkU7LCuu5ed3qEQj3xmW7Uh5/2NhRYEep/JnqOcUjDUfDG0lHhmsUikgTV4FKrrxBuiks10Q9KsbXeIbiTuv5BCfn8V++/0v+m1g+ThOZt8znwvW0P9cx2kteDrGYajBwz+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbsyeXxUNJKrlRLToZ3YaAeLjweEdLGR/N76czygtCE=;
 b=cxHR2bEwsjEeT7nvdG9YCdngLHBIQJzgIjoKOy+lsOeyNT41hSV3QwFrOLevhu3+S5niG/YNiQwaG23RAYQ+f0D0lZ5Kk2oqBtuzUHupuPPLilGXjz9R+G+rpqinvvBYNhlf+xjr2QJXUHYB7rzs8a0k70x+HOu9wWW+i8mfj3wZFyrcVp/YdFn7Riq4PFBsa6C/WQNh6g3Nz6TKcZcJfO7rNJepDkwIFnuP5jj/e2HgjHLbfLSS+iU8k03/9S+gw8T1KR3WAxeGfV0Wfsa10EJo2IxZWutsIB2MjQEGgFGTnYY5/jLlf3dKiLBjNbzQhqj2NUGUuVImOaBUAN/S6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbsyeXxUNJKrlRLToZ3YaAeLjweEdLGR/N76czygtCE=;
 b=HLlta7LhwOuJpunvqFBcBDbxq6t73rh+jnIMe7ymwKY6OSICQwgaTALZ8jirP/BY9fsPWt++JfKTpKXccuR8oSBic+DqizSXY6i0JnW/NjkwNxWFk59ZrLk80y+g45WDyt/qqcXFTfOPYPhO3mClywLBNKsYUj2eBXnJgQffKDY=
Received: from PH8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:510:2cf::25)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 06:56:35 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ea) by PH8PR07CA0027.outlook.office365.com
 (2603:10b6:510:2cf::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 06:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 06:56:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 01:56:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 2/3] drm/amd/display: Add hpd_source index check for dcn10
 link encoder setup
Date: Thu, 17 Oct 2024 12:26:13 +0530
Message-ID: <20241017065614.3502792-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017065614.3502792-1-srinivasan.shanmugam@amd.com>
References: <20241017065614.3502792-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9216c1-943a-4686-44b5-08dcee78d6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nEGMZcKhD6ZWWKI7EL6NSUDJPfV/gF/dnKD4QJ3payWpzDjKFfmg7xf6zVPp?=
 =?us-ascii?Q?tfNnQWzwkNrnyIRbIYH/INDfEL9Nkh/O9zRCUDLc61PCyYrdi1Ss+LgEbtK8?=
 =?us-ascii?Q?5/29UU+Ss+4hZraymAbDIIBOZ+QTK4tP3O06Oe3grNV8KszUCoCaUDtzjo36?=
 =?us-ascii?Q?ja9QWzFOda4mmd/FMGoOCFME4TBhNAxfEsqinwUvm1QsJ+SwfPxf0MOq/mA7?=
 =?us-ascii?Q?rDzWUlcQoPzCyhjToromQ6cWMxqpD6A92uecJn2w8/cFHAuFXv/7PzfqL4jH?=
 =?us-ascii?Q?NURCt6GbhpNnG76ryNAlpu4xTEepzZXPYpRymYX1XROdMNdAdru+owwvNlIT?=
 =?us-ascii?Q?52MkvQ/STr0FRnwJ0ww8yRKeZJNATzko66QxViZwktC2Va629lexea1iRCep?=
 =?us-ascii?Q?G+gwpC1KjGxl6UFMKV379KuQgRAkHDx9Nv671WR1Sz/B64trR9NPTgymgNtb?=
 =?us-ascii?Q?ABuZx2NA3r8nFlIfRbh5oXLblm1JvePS6RifxBy4+yUlBgd4Ku2x5cNm83t4?=
 =?us-ascii?Q?B/sVehFEEKo3ZRM4DSnI21j3Id/O5q+P9qCirSHPe7E/uuzh3+py6wBkOcRQ?=
 =?us-ascii?Q?fIVVQ3F8FmbSmFGZmW2ovYANayOUOA8YgWBcAoSUoY7t8uR5SF0B4Z0OWVP4?=
 =?us-ascii?Q?JL+65BFQzld4iRVQXuT3JR7geTMabX+O1iX3Vnm+T7GGonK028pKl7atPNZo?=
 =?us-ascii?Q?ebVYO00zjYM2f8pgGekpa3BvGekcCrKmifWzqmL71m7/1tM+Rc9oJ4kOJfyN?=
 =?us-ascii?Q?1JX5YwlF4CJZ8nyv6uHT99yJZb7A3VeNmwuqK/CsE4iXSXZD9gnbCG+amn/L?=
 =?us-ascii?Q?Xbgezb67kMlAiJDtLX/PPfE3qfHUJ7GyypRwteDpQuFukkYLOBc9pVLnSZg7?=
 =?us-ascii?Q?CatLFixr45LhlMJhNaDZKjQfrSAHdHe+dVXfHI8iwyU8bu4yrYDqk1ycm4pz?=
 =?us-ascii?Q?/2Tj4OturBuLzppsTFu23a1gYRa1qYQ7RX6cCjIsE05YvuNGUKW9Pm6EF86E?=
 =?us-ascii?Q?vpYHcexb7HBj7Q7dW8pwkokEklDzwa7wp7IILnLMniV2vCYxuTeGOyAJJOEs?=
 =?us-ascii?Q?7kdxvKLUF07WuJwQoZoNhKKRexjGs1oe3gCtHW2HPv9Q5ZL/ARt4sYo5xRdB?=
 =?us-ascii?Q?gpHOWcJrC7betvuRQutg5bP7mgI+diXP8XMFyd10OwVhS/XaqXU8/ZP/QChN?=
 =?us-ascii?Q?gxaUgQ/ubRHv06wsQMlZiO2RtzQDTWHwjoLv+IvYH/PYrmXqDsh/zrpSWvA1?=
 =?us-ascii?Q?E+5e4asiQzzKjxOZhqSVML881iOkV7gUBYhPJ6rjUmNZp8AQNDE1sK21w8cN?=
 =?us-ascii?Q?r5JHvN9DX8rzfUxEwmlNEd/JiHof4ZOr7y9Kl4Xc1vBDB89VplRkSxp5cpHQ?=
 =?us-ascii?Q?Fyfx1unb5g4Pb2JQeQbXMtB75wzc4kKFUsoVr9J0Y3tPxfhcuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:56:34.8104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9216c1-943a-4686-44b5-08dcee78d6fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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

This patch adds a boundary check for the hpd_source index during the
link encoder creation process for all dcn10 ip. The check ensures that the
index is within the valid range of the link_enc_hpd_regs array to
prevent out-of-bounds access.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 563c5eec83ff..05d6d41ef9d3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -751,7 +751,7 @@ static struct link_encoder *dcn10_link_encoder_create(
 		kzalloc(sizeof(struct dcn10_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc10)
+	if (!enc10 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.34.1

