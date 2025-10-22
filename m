Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D646BCCF9E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 13:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E72310E786;
	Wed, 22 Oct 2025 13:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kz7E6XkL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7DB10E784
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 13:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pP6WhXDxVNsRXCwH4eirs6ZH5+w/Jr6CK6+ieVwUJuPGBxm4VHeUjyD/4ec3W4Tu2NiyXBqaLllF+oJ2c49x07ZD6vqE+NYu/KX++H0exZscu7n7892KsivyWzbVE+/H1b1Zy/BjzuvVkBiTHMj8Iqp56dveGN9Y7KLSczePIxf2X5SmzJm8bPMXEczKraqQYiXhyf9NQDCohZGzqS1u0UUf7OJfj8do64H5azKruVPRPLwzxt7GBO/QC8YYdMJxQdR0DSWgnPk40RpnOIa09UQn5/VyAYXeLAASzGfr4Zrt3skMj+1EIIr+pI7zIT92ArGnlAceLOhbI6nknSdLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K47MToKoNzMURJKoyIGPn3hsCy4Tbi/cCiKRiTm6zq4=;
 b=ifswDNk4CoNn/U/BoRXD+BuAo/8Xm0WU026wkebty/MULa5VmkuUtkIZqN8XRgFNUcl7oiZiYKSKVY5w2erZoiYzWiQqVgJwY68X6u53irHI1rcs5VGjzNsFrrlgKuxf2eZvjF56ojpqntGCoLYK/WQQRntUJIj55Rkiy2p+R4Yu/Kt2PfZppGDDFBn6MVcejcvbymr0C6Q7XFSNFnfVxS9FcpbMLxQCy4cHoufH+UQw7epN+bUQSuVdRQhc1OUV1lOakEvsnhPuDuoRZ76dHKskBSAdrAWqyotLCWf4Ww1aWw+ouZy916zwDKU6qYd/TqXBtOj2vJr1tfqHIfV8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K47MToKoNzMURJKoyIGPn3hsCy4Tbi/cCiKRiTm6zq4=;
 b=kz7E6XkLBHi2nuVL0u/r8xCD9wQvXDgQUKby7hEerBzQsX7lHBtTQdpL/BsaYqzgg7+BbxBcEGLSXYsMB6R5sZ/17Zz+tsy9DXvncTSP5OznPtIRBxfdKLH3HjKO/ckH+JtZfyfMJ7mbhlqWKELFAVyXb1j0RFuSA6JL5+Sawgs=
Received: from BYAPR11CA0093.namprd11.prod.outlook.com (2603:10b6:a03:f4::34)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:23:54 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::a6) by BYAPR11CA0093.outlook.office365.com
 (2603:10b6:a03:f4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 13:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 13:23:53 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 06:23:51 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: fix SPDX header on amd_cper.h
Date: Wed, 22 Oct 2025 09:23:32 -0400
Message-ID: <20251022132334.977886-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022132334.977886-1-alexander.deucher@amd.com>
References: <20251022132334.977886-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a08cdb-46b5-4575-289d-08de116e3f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YYJeCUPX5Mz+unuKMKSkAssgQoI/ImH8ihYqQ8Zynx4r/pfZb/q4xYFMg4Pc?=
 =?us-ascii?Q?5YTDMzDfQLnX+wSj7bVf1HQOFYES9nKT0KrQLz69rgXLe/Qp/rwG+j17M7Nt?=
 =?us-ascii?Q?7TwAsh0p/8khmTuDsOWbvFuIOKFWGD6eFRCFSy1OhArYgISGI1l/0WucHBaZ?=
 =?us-ascii?Q?rsPucVQrhBsYRn+sGjPsuA7J4ZIh0Oa9wsi46S4/xrynPWbYap6YhfKT0gRo?=
 =?us-ascii?Q?VDB1G3gEzUvvTDvWMiR6bbBjEkCHElimNYs2f4g2iajVtDmKz5AErqXsQvFK?=
 =?us-ascii?Q?IrjH9bzU8wBJ9cwBBkXEdqc75gk/vJaR/vP3pIZBxH0NSIUp8dLyfebqwgiT?=
 =?us-ascii?Q?NSuL6Wc0RMFYfRnuUAXRe7kjSWcKQCSEp/ilwrYspyMW0TYgd9Tc6SfP9goO?=
 =?us-ascii?Q?KHbGOEKIDv5aAfFqNYZY723MVMSuJH1tzO1YAENQVypBi3wgHcnw4y8BsPR2?=
 =?us-ascii?Q?YmP53z8UWz3vaB43d9EgsVNo/ZAo3nVsHXoCms2ocsk5LRlnxj3V2CfjENIb?=
 =?us-ascii?Q?5B8ekGKDt/cvcxKarXdxQMP79oMZp9oK4DXctlljNUIfSyv3fSd+igpYj8vJ?=
 =?us-ascii?Q?FKLoXjzIZ3dekAun0q3IQmgJq83vwLKWQ0zXmj0IICMP1R47tdUGfB4oQFaI?=
 =?us-ascii?Q?YDYaZgYDpLHy0ZrLxomdO4LkW3Xa5BlgALwGG/KrINkm3hhpuLxxWvOpatI9?=
 =?us-ascii?Q?NcrYc30GH39xEg88D6Km8gL0c/vBiZCEb5kn3bPr5JsX/LyoVjZCm7ynHnuT?=
 =?us-ascii?Q?SUyyTs/dj4mINOIBKsNfpfpY4JBNTXret7x/R47s4RuXVv3c01efvwT6USK3?=
 =?us-ascii?Q?vFK7E+i+854hw/mL6iQ7zo047Pizy5DDDnyeQWCC/JI2JPCtkNC0ds2LuiEY?=
 =?us-ascii?Q?xluq2VWMDtnW6FToUAWQTrlktbAstGzEvgenecuF1grNBkXjMt1NTnlYfzL8?=
 =?us-ascii?Q?cDkOSrz9cgIOQAACbsdhh5gtKfq7GCaz1XUufr2aqZwXSeNgEMWlF7KhF/Fz?=
 =?us-ascii?Q?FAlj7ouixw+Tbn/NtYchj5mJh8AL2nIjm00MSHVWrbK5gDFWAdg2cE5KVO7i?=
 =?us-ascii?Q?nCg/R8gY8cC9GnjdV+AZqaKAHjxw8+Kb3jT84dX3s2fIti4L4riYYfRNtoKY?=
 =?us-ascii?Q?H9Mv3BuKe4XzbjWBUSKDsT7oG1jWl59a/rg0vXU70zA9Vlli9olUsZYU1boS?=
 =?us-ascii?Q?YZWFzulFWgWDal1XL9RhZm7H6XTGWtoCJskXrFsExavjtaddlyUKmHfAtjYo?=
 =?us-ascii?Q?EdYX24O9tLItt/fk0w4TlUUNMdqtPZUb6uFmGFq9iHMNab6RQowamAFXJrxu?=
 =?us-ascii?Q?N3vwgklQuybL9gZWvv7cHP4JtkeEHD9zwKv+pIbFH7MZv36OXfaPSU64+rlJ?=
 =?us-ascii?Q?golGe/ci4KnQ5LyKGZbhXVC37JMVwrmJ7p+yu279eB+H3JeH/CgqdfE1XePV?=
 =?us-ascii?Q?Sju+bP1YvMVKPeHrOgBhtcsiu2GIdZ+pGwmj9Jk9TwSiDUCV2gFEhG5c+OIk?=
 =?us-ascii?Q?/72Fo0+Ei+ywe+BAtBsAOEJxip+0f4x54GYW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:23:53.3029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a08cdb-46b5-4575-289d-08de116e3f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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

This should be MIT.  The driver in general is MIT and
the license text at the top of the file is MIT so fix
it.

Fixes: 523b69c65445 ("drm/amd/include: Add amd cper header")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4654
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_cper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/amd_cper.h b/drivers/gpu/drm/amd/include/amd_cper.h
index 086869264425c..a252ee4c7874c 100644
--- a/drivers/gpu/drm/amd/include/amd_cper.h
+++ b/drivers/gpu/drm/amd/include/amd_cper.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2025 Advanced Micro Devices, Inc.
  *
-- 
2.51.0

