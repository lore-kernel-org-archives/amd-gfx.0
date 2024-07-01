Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D89DC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 16:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C6C10E48F;
	Mon,  1 Jul 2024 16:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DaPMVoXB";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A9B10E48F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 16:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQWJKoHOnWMZzyNnmnXupDJSInukh78I+lD5rf+Pk5czsPXvSF9+YIWSHAGRjGkNS16IJGf56+AvCvvyAnEbM+t/8pGcKQzzSZh9RZ4YI9fUehn8JVr7T99bElO2bB5ggxYBVCXP7wcVsAvPe9BRfBBzGV68ryXf0KABadjGtiFKpHc2ZlyDZIr+8iize9O9kM2Wuv8epBMRmmcJnwuA1vx81cCDZ5SO+/Se9bxM8yiyiEEcBLGBDbVbT7BRBbaxaqBsenvtAUW+rcph5icaRxWI0UndmG3eTCVZa7LS8ykQKdCbcxNzSDwpFeinihsLOfm2Kg2ekBtLVk791re/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXA3RRx2T7EnWJe1X6YOEBMjr+FAzpcu+bvk5Lzn7jo=;
 b=E5GBg+ejTSwGy9Xm1QM01SQjKUTHtTBQJwexazrDTGNlXb10NFIUbF9jJ9uhelF/Gww/8bCfAzm8xUemhKUubcnsw16R0rZkKKMI5KAzdJqOfajlbmqNtNGZu4irjIOoG/2NazA8ZdSWCxHXlzw9/ZjBr8+uEUGjGzvVcDHhQtTTirrpLsqfdaXogYRzMLO0BfuhJPRdaOVldgoq6lF/rhiV3rf3LCrikesKvBHRGHm2XzgADy3D76lXi8L7UjTFdCRFobYfCUgpHix4a0ae1wQyC54xixjHx1qJWYS5TpNlJ4wL73WmjAfl59kZpPgAH8ek26GR2WweX0mCCQjn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXA3RRx2T7EnWJe1X6YOEBMjr+FAzpcu+bvk5Lzn7jo=;
 b=DaPMVoXBHsYaMJ4T4YaHKAHCGv8Ucr97a98pQxm5XMGCNsb4XC2W80ecsy9yJQa4YZClm802brcIY1tI/v9ohks1rkWwD7I9AbxJ5vE2NKNnI3PWhYQMwhMU3VvGf0LE3OUZ5UGKFBr2xn3KreLI+Rvr38psJSCV29+4gQHcEBE=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 16:55:38 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::5e) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 16:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:55:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 11:55:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jlayton@kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: silence UBSAN warning
Date: Mon, 1 Jul 2024 12:55:21 -0400
Message-ID: <20240701165521.1825864-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fc7721-ccef-478a-07d6-08dc99eea209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WJrvd9KhSVscXOjgYAyDEp8NMG4aupUWJvB5XqNCawzmWNNgKunpipNeCSjd?=
 =?us-ascii?Q?Vc2NLgUFQUs6KAPV7vP0gIAyoBJmWNxxia7aR4zgOHDT3bidz+3mBo+Beqc+?=
 =?us-ascii?Q?ti2NdreCaUQ/4M0fugZ5jV04Xg2zJcH3O1pBN/zbVym1zSi7ozM/l27aBcHq?=
 =?us-ascii?Q?3+JSCfydnpAOAglxlTy5i8bW/7jgdohkCv9nfLm+cqN0k4lkfvnEoB9swj+5?=
 =?us-ascii?Q?9vey67/LxmurTOH3N8qmOwFJ3dmdBYZKLMVBlQtCAbxVo/9ZKMe1C+cAJtAq?=
 =?us-ascii?Q?RNdim0bHrF/3xtPl7gzeMWhcBbcqmKpNiWtOR0w7Ym7Yj4oLb4NI2w5UERON?=
 =?us-ascii?Q?OOPXbt/tdyADBnp3+/j/GEJBHMbn0sV3tqXR++omjq7fFQ+JzUmQ9imEyvy7?=
 =?us-ascii?Q?fOQDmCgzPEIHH63YmMZyPsAhuluAa8g3c+SMMYSBdLlYiyAv3HyQfrGZKHVA?=
 =?us-ascii?Q?KQlq0PlkoV4Uj7aOuKqiXQBbwZrQ+KjhzzZK9CxMFbboAgs5kTFgzSSe7OGC?=
 =?us-ascii?Q?idwL70OvXCVPEgsmDnDEmMbmtYwv/tdELmuo71dUsN2pn7XlO9LzejGCWr9X?=
 =?us-ascii?Q?1fUJ89xCY5p4oLGvSzOXSUaE3v5CQVum3foJ59CdwKDrqhheImGIbawobfH9?=
 =?us-ascii?Q?3z6oyD7NT2W0ey3zaxsH2ZRDWOegUBtRZaIj0pbu8igXpewsb3vUY0Z/kKrJ?=
 =?us-ascii?Q?ygpZ6XJVTjbbXaaxXewBB7W2jpFDYFvu1u2Bz95bv4b0K4BPLZZfAzgasFeG?=
 =?us-ascii?Q?OCGwQ1nF7nMXXUE3zFQhuPWeNd/K9O936QgWImJt9vtXpvu86/lv2qMJuUf1?=
 =?us-ascii?Q?9lxauFgBY+B5PhYLoquHTzJKFlaL7rb+i/WIVk14OlMyPpHuzbyGMgxCEAyL?=
 =?us-ascii?Q?GDuCi+Ft4+4OBjpdbJ3ly3UCn9xELS04/pG+5RhT+/fIShfB9x37sRiqE7eL?=
 =?us-ascii?Q?YJ9oPqq2BejuhxQciQBPoeE3n/92bJh/c3QxMjwcf/ACSdjfVkiVQWEd14Y+?=
 =?us-ascii?Q?JL2yB/ZgHjb5rx7Ws5L8SQDz0LidVramTOo6XHBSOZ9iCu2pEgQx3MhxcA5U?=
 =?us-ascii?Q?5ap613PlHuLZ2yj+dQ+QahaLtlOs+GunoKNUWRI9TZxJhoR4wrIxc1aqS2Ta?=
 =?us-ascii?Q?fo7UCHFWTb+iW/nxzGVJBDnHEEgTnHILs4l97+mZ8yA6NJ/jwXTDvljPtyI/?=
 =?us-ascii?Q?BoKrwdkoyrfCaSZstTP7OJSyg/AJnvKyQU0aWbR/hjPBEwtDIdoziTS2YuZ0?=
 =?us-ascii?Q?/i7JyWzmhJfXy/OBdOWAOhsOstJ8D6p0kccE7jWYwqoOrnZ7VgSxwV3jEbBE?=
 =?us-ascii?Q?eaROznoXRG0bH2c/dzyXjae7DwlpbiddSGva7vHj84m9bV9A63eq8DPVVzZs?=
 =?us-ascii?Q?WYdcZ5vTHz3+u/FsZkvpRKQ/JxbG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:55:37.8441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fc7721-ccef-478a-07d6-08dc99eea209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

This is a variably sized array.

Link: https://lists.freedesktop.org/archives/amd-gfx/2024-June/110420.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 571691837200..09cbc3afd6d8 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -734,7 +734,7 @@ struct atom_gpio_pin_lut_v2_1
 {
   struct  atom_common_table_header  table_header;
   /*the real number of this included in the structure is calcualted by using the (whole structure size - the header size)/size of atom_gpio_pin_lut  */
-  struct  atom_gpio_pin_assignment  gpio_pin[8];
+  struct  atom_gpio_pin_assignment  gpio_pin[];
 };
 
 
-- 
2.45.2

