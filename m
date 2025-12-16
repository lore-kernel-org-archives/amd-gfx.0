Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C41D637BB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A8A10E8A6;
	Tue, 16 Dec 2025 21:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rAxeJ4Tm";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6413A10E89A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKG2BgZp4dLCzDaqvrYOigm3hPOBv4U4qO9YohJUTiUlu0u+IUmbmN4RBPlmqVk7eIfOxxZcQe+ZvjV64h2gHp0quVCDcSuAQinUtjESCwcAl6EGgAuREBhLGfW41WJpjo3x4cuRjyufRpNSZ5GOpxZa7N8nR1LaBTtxrk17KAT55IHdpHAotVsV25l9dlwu0EoDyPm7ZYyNJZSg48YhEqTlfZHQsIcyGzTgWIw9tBY5nDbW8dDFmBMijggxlwHVkVje/6JSPJQtbMFw7+mUDiNiTSFVUoFbxcAItzInLp1cBj/992hTe7MU50XkWfKulA4HACmnDpVxBY2URqsRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Xd+VlrIZruxJ2yLEgzxGQbX/ReUsGlk5VMTITjiyL4=;
 b=hxpcrgyGsLc2bMHE9TR1y5vjWxpdCpGJCF/c5CBneHCohAMuarE+AP3qKBPlx5Gmow1Ry5klgvySAo7vuN//bGoIM/TRaDVo1Iz0jtdN64nlHU8kd+T3A3PzOOTIHObK/Lw/NZFQFOiTXcmbUnf6AN5iT517kQkkCzvIMw9WahJ7A/cHUH1S1mU8UmP6NH/p5w44Rd85dwBjdR/qVD2cFviDYWR4W/6p3nJxC6KQ6My4ig7wQpxqmmARKfsawqfQMnwrCaTcg3/iFAVDjv7a7/Wo6coKxXcO7StKnReaeoJ9iewCa+hw9lA4sxlMFuQDy3yXJpfkcgiJymIvwq0rAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Xd+VlrIZruxJ2yLEgzxGQbX/ReUsGlk5VMTITjiyL4=;
 b=rAxeJ4TmtMr9omiHn3UVGq4P6xqOQJhhQ5zXcEKsWLYvzfDBftBlh1onwYD9Li2Z+I9zyk/DxdqUjSur7GR5Ow2q4BF1rZFcPtxO3taRx7zTnQow0gU7HQtxGvHv6vaPxR9R0eBz0cgOAjfKergXBXDyhxc6AsQAfC2j7d5nqFU=
Received: from MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::18)
 by BN7PPFD3499E3E3.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:04:11 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::fa) by MN0P223CA0029.outlook.office365.com
 (2603:10b6:208:52b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:10 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add back CWSR trap handler for GFX 12.1
Date: Tue, 16 Dec 2025 16:03:38 -0500
Message-ID: <20251216210349.1963466-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f3a908-98b8-4c96-330c-08de3ce6a906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NJQlFJG6ogLcoDMMkM83DBiID+E4XSm2Di08s7k2XNfsUPaB3P61xpVt7g2T?=
 =?us-ascii?Q?LG4mOnPrfMQmcnzxUaB2j1NWTp8tSSghFrWRZDgYEKxqkCBWKeMxWlvwKJn6?=
 =?us-ascii?Q?5pNtPWfGD6WmnG9JXoviP/3VXiavPHj9KKX1NNAk8zqRWJZ+QAq0GprXNBlG?=
 =?us-ascii?Q?KwbsEV69OmnwhAuP7j1pRdHWdyRKhiDNrc2GWj8ETe/PPdrDNlfdorFpXfnp?=
 =?us-ascii?Q?vkwr2JKsU/A02cAHF7FRnS0br6QyBhLq/E7DrUpIgLH/Ztf76Q4NqP2xv1YX?=
 =?us-ascii?Q?rgwlaUIn9uPCQM8CjjzKrbZI6Q6nG+fb2TVt4Oi+rbj0iB5fmyxm9zWFc35M?=
 =?us-ascii?Q?Rt0ECs2mkjnDnCikpc6PX16hjcrDaN3r8SyGT0Ndz71WjEY8gM4UqAfad867?=
 =?us-ascii?Q?vEphYQJYA+hj22mLUV5eUTQjcpZ5Ndqy4/MYNx5/fvcssi/lQYUnkLySB+wE?=
 =?us-ascii?Q?klKa+v0cuF8yX2DgEd3We1TWp6JaDLoFO45GA5U6FUl6ZK4ulePNao2v/BaN?=
 =?us-ascii?Q?xkLCF594JYEt1ue6pBcM3g0+NGojwgYeGR881QajpuYTWddhIxzCglDZul1Q?=
 =?us-ascii?Q?NB6OYWImo3H5gN/UCX2sXT39ZgKbjfzWvVB5KQPDXc1fGMiOJoqBr4jSdOFP?=
 =?us-ascii?Q?44PtY+eEvvHBecNChqI3wTdRdVMNdaMTJ8g8ticbmxiESfPb8hfxZ1QDBrLX?=
 =?us-ascii?Q?KuBreiWPbyQtaZIcfm23RzajMZXnCSuEAzAaBr6JUFbG09kihIzKu90TuTXo?=
 =?us-ascii?Q?MoG+vmST37WW0jFtBSkFMKvGbIF7H9NTGTO/uzoE6yXMXQAqARE7nq3ktRiP?=
 =?us-ascii?Q?pKSPJ1WxkMQaPPCc3lBLf5UCAuWWs1oKPyGi/VYFvg7VVp0PMXFSP/7H33Gd?=
 =?us-ascii?Q?Cgqlo4A8Bl8pp8+4/lZdk73zpayEC7KwfJurh6bJJAibCqNGDyhfce93y9TH?=
 =?us-ascii?Q?U481onKrb6NIktelD7s376ZhNLdXNGBLpG7SMMK+buKuwDJI9OrmGv/BHygF?=
 =?us-ascii?Q?HAjgrtHRE/XBlMg5V9zaGtnMMPxMmyvGSdTMTz7SUZm+NepG+zWrM7ZE5sZk?=
 =?us-ascii?Q?nZ7kF5v+lPNQ0pt264w6z/9qvawDvwXiyzRRZL9qj3LHzEtPyEirfVXZG+PI?=
 =?us-ascii?Q?5vZzUeuLdfZ0QyQuViBkyGKvBADeks/E91WOarIcEbcPDhZ/s/MXuAjaAe42?=
 =?us-ascii?Q?c6H4FYvCVwL5hFXwpKDpmL1MVzhIGNU8u4NIO2hW1GOHdqpzOck2MmeGyZWb?=
 =?us-ascii?Q?BTFrkl0zvTS1IWEKfQWTzNZr4Iyc0G1+V1fIfANFUW5zmxfq2zNVTHN4t2Nn?=
 =?us-ascii?Q?5mZ6g3Veq3J1U9smlwcDO6uDn7qgGTug2bYQYBhlBwL7chfKWiKDoruZQdZl?=
 =?us-ascii?Q?P9LIkf1GMNoXWV99TXPDw2EJR6uiEr/RrPomBVUG8E7/ZQvBi00UEgQztVZP?=
 =?us-ascii?Q?pHf0ectYevOipRo7/96x+FHith+pj0myQmk/agtqlwk/L6GShJFIYVHsL6+O?=
 =?us-ascii?Q?ZRPoUR8gafzX4hmnbEFJ8uOtsK4OEttAZsvST2u2I5IX/WOs/BjGyLr+XDYA?=
 =?us-ascii?Q?78l+ImYk53Q6r0vPHLo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:10.8655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f3a908-98b8-4c96-330c-08de3ce6a906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3
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

From: Mukul Joshi <mukul.joshi@amd.com>

CWSR Trap handler for GFX 12.1 was missed when merging changes
from 6.14 NPI branch to 6.16 NPI branch. This change adds back
the CWSR trap handler for GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 540 +++++++++++++
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 746 +++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   7 +-
 3 files changed, 997 insertions(+), 296 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index f98c735b2905f..5c6d533a59562 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4664,3 +4664,543 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 	0xbf8a0000, 0xbe801f6c,
 	0xbf9b0000, 0x00000000,
 };
+
+static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
+	0xbfa00001, 0xbfa002a2,
+	0xb0804009, 0xb8f8f804,
+	0x9178ff78, 0x00008c00,
+	0xb8fbf811, 0x8b6eff78,
+	0x00004000, 0xbfa10008,
+	0x8b6eff7b, 0x00000080,
+	0xbfa20018, 0x8b6ea07b,
+	0xbfa2004f, 0xbf830010,
+	0xb8fbf811, 0xbfa0fffb,
+	0x8b6eff7b, 0x00000bd0,
+	0xbfa20010, 0xb8eef812,
+	0x8b6f8f7b, 0xbfa10002,
+	0x8c6eff6e, 0x00000080,
+	0xb8eff813, 0x8b6e6e6f,
+	0xbfa20008, 0x8b6eff6d,
+	0xf0000000, 0xbfa20005,
+	0x8b6fff6f, 0x00000200,
+	0xbfa20002, 0x8b6ea07b,
+	0xbfa20039, 0x9177ff77,
+	0x007fc000, 0xb8fa04a1,
+	0x847a967a, 0x8c777a77,
+	0xb8fa0421, 0x847a957a,
+	0x8c777a77, 0xb8fa3021,
+	0x847a8e7a, 0x8c777a77,
+	0xb980f821, 0x00000000,
+	0xbefa4d82, 0xbf8a0000,
+	0x84fa887a, 0xbf0d987b,
+	0xbfa10002, 0x8c7bff7b,
+	0xfe000000, 0xf4601bbd,
+	0xf8000010, 0xbf8a0000,
+	0x846e976e, 0x9177ff77,
+	0x00800000, 0x8c776e77,
+	0xf4603bbd, 0xf8000000,
+	0xbf8a0000, 0xf4603ebd,
+	0xf8000008, 0xbf8a0000,
+	0x8bee6e6e, 0xbfa10001,
+	0xbe80486e, 0x8b6eff6d,
+	0xf0000000, 0xbfa20009,
+	0xb8eef811, 0x8b6eff6e,
+	0x00000080, 0xbfa20007,
+	0x8c78ff78, 0x00004000,
+	0x80ec886c, 0x82ed806d,
+	0xbfa00002, 0x806c846c,
+	0x826d806d, 0x8b6dff6d,
+	0x01ffffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0x85788978,
+	0xb9783244, 0xbe804a6c,
+	0xb8faf802, 0xbf0d987a,
+	0xbfa10001, 0xbfb00000,
+	0x8b6dff6d, 0x01ffffff,
+	0xbefa0080, 0xb97a0151,
+	0xbeee007e, 0xbeef007f,
+	0xbefe0180, 0xbefe4d84,
+	0xbf8a0000, 0x8b7aff7f,
+	0x04000000, 0x847a857a,
+	0x8c6d7a6d, 0x9177ff77,
+	0x007fc000, 0xb8fa04a1,
+	0x847a967a, 0x8c777a77,
+	0xb8fa0421, 0x847a957a,
+	0x8c777a77, 0xb8fa3021,
+	0x847a8e7a, 0x8c777a77,
+	0xb980f821, 0x00000000,
+	0xb8eff822, 0xb980f822,
+	0x00000000, 0xb8fa2b01,
+	0x847a997a, 0x8c6d7a6d,
+	0xb9802b01, 0x00000000,
+	0xbefa007e, 0x8b7bff7f,
+	0x01ffffff, 0xbefe00c1,
+	0xbeff00c1, 0xee0a407a,
+	0x000c0000, 0x00000000,
+	0x7e000280, 0xbefe007a,
+	0xbeff007b, 0xb8fb0742,
+	0x847b997b, 0xb8fa3b05,
+	0x807a817a, 0xbf0d997b,
+	0xbfa20002, 0x847a897a,
+	0xbfa00001, 0x847a8a7a,
+	0x8b7bff7f, 0x01ffffff,
+	0x807aff7a, 0x000001c0,
+	0x807a7e7a, 0x827b807b,
+	0xd7610000, 0x00010870,
+	0xd7610000, 0x00010a71,
+	0xd7610000, 0x00010c72,
+	0xd7610000, 0x00010e73,
+	0xd7610000, 0x00011074,
+	0xd7610000, 0x00011275,
+	0xd7610000, 0x00011476,
+	0xd7610000, 0x00011677,
+	0xd7610000, 0x00011a79,
+	0xd7610000, 0x00011c7e,
+	0xd7610000, 0x00011e7f,
+	0xbefe00ff, 0x00003fff,
+	0xbeff0080, 0xee0a407a,
+	0x000c0000, 0x00000000,
+	0xd760007a, 0x00011d00,
+	0xd760007b, 0x00011f00,
+	0xbefe007a, 0xbeff007b,
+	0xbef4007e, 0x8b75ff7f,
+	0x01ffffff, 0xbef1007d,
+	0xb8f30742, 0x84739973,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00002, 0xbeff00c1,
+	0xbfa0000a, 0xee0a4074,
+	0x008c0000, 0x00008000,
+	0xee0a4074, 0x010c0000,
+	0x00010000, 0xee0a4074,
+	0x018c0000, 0x00018000,
+	0xbfa00009, 0xee0a4074,
+	0x008c0000, 0x00010000,
+	0xee0a4074, 0x010c0000,
+	0x00020000, 0xee0a4074,
+	0x018c0000, 0x00030000,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0x8070ff70,
+	0x00000200, 0x7e000280,
+	0x7e020280, 0x7e040280,
+	0xbefd0080, 0xb8faf802,
+	0xbf0c8b7a, 0xbfa20003,
+	0xbe804fc2, 0xbf94fffe,
+	0xbfa10001, 0xbe804ec4,
+	0xbf94fffc, 0xb8faf804,
+	0x8b7aff7a, 0x0001000c,
+	0x9178ff78, 0x0001000c,
+	0x8c787a78, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xd7610002, 0x0000fa6c,
+	0x807d817d, 0x917aff6d,
+	0x80000000, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xd7610002, 0x0000fa6e,
+	0x807d817d, 0xbefa0080,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa78, 0x807d817d,
+	0xb8faf811, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xd7610002, 0x0000fa6f,
+	0x807d817d, 0xb8f1f801,
+	0x937aff6d, 0x00060019,
+	0x847a8c7a, 0x8c717a71,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f814,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f815,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f812,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f813,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8faf802,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xbefa50c1,
+	0xbfc70000, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xbefa4c88, 0xbfc70000,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xbefe00ff,
+	0x0000ffff, 0xbeff0080,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x010c0000,
+	0x00000000, 0xbefe00c1,
+	0x7e040280, 0xbefa5081,
+	0xbfc70000, 0xd7610002,
+	0x0001007a, 0xbefa5082,
+	0xbfc70000, 0xd7610002,
+	0x0001027a, 0xbefa5083,
+	0xbfc70000, 0xd7610002,
+	0x0001047a, 0xbefa5084,
+	0xbfc70000, 0xd7610002,
+	0x0001067a, 0xbefa5085,
+	0xbfc70000, 0xd7610002,
+	0x0001087a, 0xbefa5086,
+	0xbfc70000, 0xd7610002,
+	0x00010a7a, 0xbefa5087,
+	0xbfc70000, 0xd7610002,
+	0x00010c7a, 0xbefa5088,
+	0xbfc70000, 0xd7610002,
+	0x00010e7a, 0xbefa5089,
+	0xbfc70000, 0xd7610002,
+	0x0001107a, 0xbefa508a,
+	0xbfc70000, 0xd7610002,
+	0x0001127a, 0xbefa508b,
+	0xbfc70000, 0xd7610002,
+	0x0001147a, 0xbefa508c,
+	0xbfc70000, 0xd7610002,
+	0x0001167a, 0xbefa508d,
+	0xbfc70000, 0xd7610002,
+	0x0001187a, 0xbefa508e,
+	0xbfc70000, 0xd7610002,
+	0x00011a7a, 0xbefa508f,
+	0xbfc70000, 0xd7610002,
+	0x00011c7a, 0xbefa5090,
+	0xbfc70000, 0xd7610002,
+	0x00011e7a, 0xee0a4076,
+	0x010c0000, 0x00008000,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0xbef90080,
+	0xbefd0080, 0xbf800000,
+	0xbe804100, 0xbe824102,
+	0xbe844104, 0xbe864106,
+	0xbe884108, 0xbe8a410a,
+	0xbe8c410c, 0xbe8e410e,
+	0xd7610002, 0x0000f200,
+	0x80798179, 0xd7610002,
+	0x0000f201, 0x80798179,
+	0xd7610002, 0x0000f202,
+	0x80798179, 0xd7610002,
+	0x0000f203, 0x80798179,
+	0xd7610002, 0x0000f204,
+	0x80798179, 0xd7610002,
+	0x0000f205, 0x80798179,
+	0xd7610002, 0x0000f206,
+	0x80798179, 0xd7610002,
+	0x0000f207, 0x80798179,
+	0xd7610002, 0x0000f208,
+	0x80798179, 0xd7610002,
+	0x0000f209, 0x80798179,
+	0xd7610002, 0x0000f20a,
+	0x80798179, 0xd7610002,
+	0x0000f20b, 0x80798179,
+	0xd7610002, 0x0000f20c,
+	0x80798179, 0xd7610002,
+	0x0000f20d, 0x80798179,
+	0xd7610002, 0x0000f20e,
+	0x80798179, 0xd7610002,
+	0x0000f20f, 0x80798179,
+	0xbf06a079, 0xbfa10009,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x010c0000,
+	0x00000000, 0x8070ff70,
+	0x00000080, 0xbef90080,
+	0x7e040280, 0x807d907d,
+	0xbf0aff7d, 0x00000060,
+	0xbfa2ffb9, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
+	0x80798179, 0xd7610002,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
+	0x80798179, 0xd7610002,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
+	0x80798179, 0xd7610002,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
+	0x80798179, 0xd7610002,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
+	0x80798179, 0xd7610002,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
+	0x80798179, 0xbefe00ff,
+	0x0000ffff, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x010c0000, 0x00000000,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8fb4306, 0x8b7bc17b,
+	0xbfa10042, 0x8b7aff6d,
+	0x80000000, 0xbfa1003f,
+	0x847b8a7b, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0x8070ff70, 0x00000200,
+	0x8070ff70, 0x00000200,
+	0xd71f0000, 0x000100c1,
+	0xd7200000, 0x000200c1,
+	0x16000084, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa20015,
+	0xbe8300ff, 0x00000080,
+	0xbf800000, 0xbf800000,
+	0xbf800000, 0xd8d80000,
+	0x01000000, 0xbf8a0000,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x008c0000,
+	0x00000000, 0x807d037d,
+	0x80700370, 0xd5250000,
+	0x0001ff00, 0x00000080,
+	0xbf0a7b7d, 0xbfa2fff1,
+	0xbfa00014, 0xbe8300ff,
+	0x00000100, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf8a0000, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x008c0000, 0x00000000,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000100, 0xbf0a7b7d,
+	0xbfa2fff1, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20004,
+	0xbef000ff, 0x00000200,
+	0xbeff0080, 0xbfa00003,
+	0xbef000ff, 0x00000400,
+	0xbeff00c1, 0xb8fb3b05,
+	0x807b817b, 0x847b827b,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa2001b,
+	0xbefd0084, 0xbf0a7b7d,
+	0xbfa10032, 0x7e008700,
+	0x7e028701, 0x7e048702,
+	0x7e068703, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x000c0000, 0x00000000,
+	0xee0a4076, 0x008c0000,
+	0x00008000, 0xee0a4076,
+	0x010c0000, 0x00010000,
+	0xee0a4076, 0x018c0000,
+	0x00018000, 0x807d847d,
+	0x8070ff70, 0x00000200,
+	0xbf0a7b7d, 0xbfa2ffe9,
+	0xbfa0001a, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10017,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x000c0000,
+	0x00000000, 0xee0a4076,
+	0x008c0000, 0x00010000,
+	0xee0a4076, 0x010c0000,
+	0x00020000, 0xee0a4076,
+	0x018c0000, 0x00030000,
+	0x807d847d, 0x8070ff70,
+	0x00000400, 0xbf0a7b7d,
+	0xbfa2ffe9, 0xbfa00180,
+	0xbef4007e, 0x8b75ff7f,
+	0x01ffffff, 0xbef1007f,
+	0xb8f20742, 0x84729972,
+	0x8b6eff7f, 0x04000000,
+	0xbfa10044, 0xbefe00c1,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8ef4306,
+	0x8b6fc16f, 0xbfa10039,
+	0x846f8a6f, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0x8078ff78, 0x00000200,
+	0x8078ff78, 0x00000200,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbefd0080,
+	0xd71f0001, 0x000100c1,
+	0xd7200001, 0x000202c1,
+	0x30020282, 0xbfa20012,
+	0x80767874, 0x82778075,
+	0xee0a0076, 0x000c0000,
+	0x00000000, 0xbf8a0000,
+	0xd8340000, 0x00000001,
+	0xd5250001, 0x0001ff01,
+	0x00000080, 0x807dff7d,
+	0x00000080, 0x8078ff78,
+	0x00000080, 0xbf0a6f7d,
+	0xbfa2ffef, 0xbfa00011,
+	0x80767874, 0x82778075,
+	0xee0a0076, 0x000c0000,
+	0x00000000, 0xbf8a0000,
+	0xd8340000, 0x00000001,
+	0xd5250001, 0x0001ff01,
+	0x00000100, 0x807dff7d,
+	0x00000100, 0x8078ff78,
+	0x00000100, 0xbf0a6f7d,
+	0xbfa2ffef, 0xbef80080,
+	0xbefe00c1, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8ef3b05, 0x806f816f,
+	0x846f826f, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa2002c, 0xbeee0078,
+	0x8078ff78, 0x00000200,
+	0xbefd0084, 0x80767874,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00008000, 0xee0a0076,
+	0x000c0002, 0x00010000,
+	0xee0a0076, 0x000c0003,
+	0x00018000, 0xbf8a0000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000200, 0xbf0a6f7d,
+	0xbfa2ffe8, 0x80766e74,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00008000, 0xee0a0076,
+	0x000c0002, 0x00010000,
+	0xee0a0076, 0x000c0003,
+	0x00018000, 0xbf8a0000,
+	0xbfa0002d, 0xbeee0078,
+	0x8078ff78, 0x00000400,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10018, 0x80767874,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00010000, 0xee0a0076,
+	0x000c0002, 0x00020000,
+	0xee0a0076, 0x000c0003,
+	0x00030000, 0xbf8a0000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000400, 0xbf0a6f7d,
+	0xbfa2ffe8, 0x80766e74,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00010000, 0xee0a0076,
+	0x000c0002, 0x00020000,
+	0xee0a0076, 0x000c0003,
+	0x00030000, 0xbf8a0000,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0x8078ff78,
+	0x00000200, 0x80f8ff78,
+	0x00000060, 0x80767874,
+	0x82778075, 0xbefd00ff,
+	0x0000006c, 0xf460403b,
+	0xf8000000, 0xbf8a0000,
+	0x80fd847d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0x80f6a076, 0x82f78077,
+	0xf460603b, 0xf8000000,
+	0xbf8a0000, 0x80fd887d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0x80f6c076,
+	0x82f78077, 0xf460803b,
+	0xf8000000, 0xbf8a0000,
+	0x80fd907d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0xbe884308, 0xbe8a430a,
+	0xbe8c430c, 0xbe8e430e,
+	0xbf06807d, 0xbfa1ffef,
+	0xb980f801, 0x00000000,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0x8078ff78,
+	0x00000200, 0x80767874,
+	0x82778075, 0xbeff0071,
+	0xf4601bfb, 0xf8000000,
+	0xf4601b3b, 0xf8000004,
+	0xf4601b7b, 0xf8000008,
+	0xf4601c3b, 0xf800000c,
+	0xf4601c7b, 0xf8000010,
+	0xf4601ebb, 0xf8000014,
+	0xf4601efb, 0xf8000018,
+	0xf4601e7b, 0xf800001c,
+	0xf4601cfb, 0xf8000020,
+	0xf4601bbb, 0xf8000024,
+	0xbf8a0000, 0xb96ef814,
+	0xf4601bbb, 0xf8000028,
+	0xbf8a0000, 0xb96ef815,
+	0xf4601bbb, 0xf800002c,
+	0xbf8a0000, 0xb96ef812,
+	0xf4601bbb, 0xf8000030,
+	0xbf8a0000, 0xb96ef813,
+	0x8b6eff7f, 0x04000000,
+	0xbfa10022, 0xf4601bbb,
+	0xf8000038, 0xbf8a0000,
+	0xbf0d806e, 0xbfa1001d,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804ec1,
+	0x816ec16e, 0xbfa0fffb,
+	0xbef800ff, 0x00000080,
+	0xbefd0081, 0xf4601bbb,
+	0xf0000000, 0xbfc70000,
+	0x80788478, 0x937eff6e,
+	0x00070004, 0x847e907e,
+	0x8c7d7e7d, 0xbe80517d,
+	0x917dff7d, 0x007f0000,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804e7d,
+	0x816ec16e, 0xbfa0fffb,
+	0x807d817d, 0xbf08907d,
+	0xbfa1ffec, 0xf4601bbb,
+	0xf800003c, 0xbfc70000,
+	0xbf0d806e, 0xbfa1000c,
+	0xbf0d9a7f, 0xbfa10002,
+	0xbf068180, 0xbe804fc4,
+	0xbf94fffc, 0xbfa10006,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804ec3,
+	0x816ec16e, 0xbfa0fffb,
+	0xbefd006f, 0xbefe0070,
+	0xbeff0071, 0xb979f822,
+	0xb97b2011, 0x857b867b,
+	0xb97b0191, 0x857b827b,
+	0xb97bba11, 0xb973f801,
+	0xb8ee3b05, 0x806e816e,
+	0xbf0d9972, 0xbfa20002,
+	0x846e896e, 0xbfa00001,
+	0x846e8a6e, 0x806eff6e,
+	0x000001c0, 0x806e746e,
+	0x826f8075, 0xf4605c37,
+	0xf8000010, 0xf4605d37,
+	0xf8000020, 0xf4601e77,
+	0xf8000034, 0xbf8a0000,
+	0x856e9677, 0xb96e04a1,
+	0x856e9577, 0xb96e0421,
+	0x856e8e77, 0xb96e3021,
+	0x8b6dff6d, 0x01ffffff,
+	0x8bfe7e7e, 0x8bea6a6a,
+	0xb97af804, 0xb8eef802,
+	0xbf0c8b6e, 0xbfa20003,
+	0xbe804fc2, 0xbf94fffe,
+	0xbfa10001, 0xbe804ec4,
+	0xbf94fffc, 0x857a897a,
+	0xb97a0244, 0xbe804a6c,
+	0xb8eef802, 0xbf0c8b6e,
+	0xbfa20003, 0xbe804fc2,
+	0xbf94fffe, 0xbfa10001,
+	0xbe804ec4, 0xbf94fffc,
+	0xbfb10000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 07999b4649ded..a807e7557e93f 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -28,11 +28,27 @@
  */
 
 #define CHIP_GFX12 37
+#define CHIP_GC_12_0_3 38
+
+#define HAVE_XNACK (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define HAVE_57BIT_ADDRESS (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define HAVE_BANKED_VGPRS (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define NUM_NAMED_BARRIERS (ASIC_FAMILY == CHIP_GC_12_0_3 ? 0x10 : 0)
+#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY == CHIP_GC_12_0_3)
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
 #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
+#define WAVE32_ONLY (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >= CHIP_GC_12_0_3)
+
+#if HAVE_XNACK && !WAVE32_ONLY
+# error
+#endif
 
-var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK	= 0x4
+#define ADDRESS_HI32_NUM_BITS ((HAVE_57BIT_ADDRESS ? 57 : 48) - 32)
+#define ADDRESS_HI32_MASK ((1 << ADDRESS_HI32_NUM_BITS) - 1)
+
+var SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK	= 0x4 | (NUM_NAMED_BARRIERS ? 0x8 : 0) | (HAVE_CLUSTER_BARRIER ? 0x10000 : 0)
 var SQ_WAVE_STATE_PRIV_SCC_SHIFT		= 9
 var SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK		= 0xC00
 var SQ_WAVE_STATE_PRIV_HALT_MASK		= 0x4000
@@ -41,6 +57,7 @@ var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT		= 15
 var SQ_WAVE_STATUS_WAVE64_SHIFT			= 29
 var SQ_WAVE_STATUS_WAVE64_SIZE			= 1
 var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
+var SQ_WAVE_STATUS_IN_WG_SHIFT			= 11
 var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK	= SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
 var S_SAVE_PC_HI_TRAP_ID_MASK			= 0xF0000000
 
@@ -48,9 +65,12 @@ var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
-var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT	= 24
-var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE	= 4
+
+#if ASIC_FAMILY < CHIP_GC_12_0_3
 var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 9
+#else
+var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 10
+#endif
 
 var SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK	= 0xF
 var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK	= 0x10
@@ -83,13 +103,38 @@ var SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT		= 0
 var SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE		= 2
 
 var BARRIER_STATE_SIGNAL_OFFSET			= 16
+var BARRIER_STATE_MEMBER_OFFSET			= 4
+var BARRIER_STATE_MEMBER_SIZE			= 7
 var BARRIER_STATE_VALID_OFFSET			= 0
 
 var TTMP11_SCHED_MODE_SHIFT			= 26
 var TTMP11_SCHED_MODE_SIZE			= 2
 var TTMP11_SCHED_MODE_MASK			= 0xC000000
+
+var NAMED_BARRIERS_SR_OFFSET_FROM_HWREG		= 0x80
+var S_BARRIER_INIT_MEMBERCNT_MASK		= 0x7F0000
+var S_BARRIER_INIT_MEMBERCNT_SHIFT		= 0x10
+
+var SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT	= 18
+var SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE	= 1
+var SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT	= 16
+var SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE	= 1
+var SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT	= 0
+var SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE		= 7
+
+#if HAVE_BANKED_VGPRS
+var SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SHIFT	= 12
+var SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SIZE	= 6
+#endif
+
 var TTMP11_DEBUG_TRAP_ENABLED_SHIFT		= 23
 var TTMP11_DEBUG_TRAP_ENABLED_MASK		= 0x800000
+var TTMP11_FIRST_REPLAY_SHIFT			= 22
+var TTMP11_FIRST_REPLAY_MASK			= 0x400000
+var TTMP11_REPLAY_W64H_SHIFT			= 21
+var TTMP11_REPLAY_W64H_MASK			= 0x200000
+var TTMP11_FXPTR_SHIFT				= 14
+var TTMP11_FXPTR_MASK				= 0x1FC000
 
 // SQ_SEL_X/Y/Z/W, BUF_NUM_FORMAT_FLOAT, (0 for MUBUF stride[17:14]
 // when ADD_TID_ENABLE and BUF_DATA_FORMAT_32 for MTBUF), ADD_TID_ENABLE
@@ -101,6 +146,11 @@ var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 var S_SAVE_PC_HI_FIRST_WAVE_MASK		= 0x80000000
 var S_SAVE_PC_HI_FIRST_WAVE_SHIFT		= 31
 
+#if HAVE_BANKED_VGPRS
+var S_SAVE_PC_HI_DST_SRC0_SRC1_VGPR_MSB_SHIFT	= 25
+var S_SAVE_PC_HI_DST_SRC0_SRC1_VGPR_MSB_SIZE	= 6
+#endif
+
 var s_sgpr_save_num				= 108
 
 var s_save_spi_init_lo				= exec_lo
@@ -111,12 +161,12 @@ var s_save_exec_lo				= ttmp2
 var s_save_exec_hi				= ttmp3
 var s_save_state_priv				= ttmp12
 var s_save_excp_flag_priv			= ttmp15
-var s_save_xnack_mask				= s_save_excp_flag_priv
+var s_save_xnack_mask				= s_save_exec_hi
 var s_wave_size					= ttmp7
-var s_save_buf_rsrc0				= ttmp8
-var s_save_buf_rsrc1				= ttmp9
-var s_save_buf_rsrc2				= ttmp10
-var s_save_buf_rsrc3				= ttmp11
+var s_save_base_addr_lo				= ttmp8
+var s_save_base_addr_hi				= ttmp9
+var s_save_addr_lo				= ttmp10
+var s_save_addr_hi				= ttmp11
 var s_save_mem_offset				= ttmp4
 var s_save_alloc_size				= s_save_excp_flag_priv
 var s_save_tmp					= ttmp14
@@ -124,9 +174,6 @@ var s_save_m0					= ttmp5
 var s_save_ttmps_lo				= s_save_tmp
 var s_save_ttmps_hi				= s_save_excp_flag_priv
 
-var S_RESTORE_BUF_RSRC_WORD1_STRIDE		= S_SAVE_BUF_RSRC_WORD1_STRIDE
-var S_RESTORE_BUF_RSRC_WORD3_MISC		= S_SAVE_BUF_RSRC_WORD3_MISC
-
 var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
 var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 var S_WAVE_SIZE					= 25
@@ -147,15 +194,21 @@ var s_restore_exec_hi				= ttmp5
 var s_restore_state_priv			= ttmp14
 var s_restore_excp_flag_priv			= ttmp15
 var s_restore_xnack_mask			= ttmp13
-var s_restore_buf_rsrc0				= ttmp8
-var s_restore_buf_rsrc1				= ttmp9
-var s_restore_buf_rsrc2				= ttmp10
-var s_restore_buf_rsrc3				= ttmp11
+var s_restore_base_addr_lo			= ttmp8
+var s_restore_base_addr_hi			= ttmp9
+var s_restore_addr_lo				= ttmp10
+var s_restore_addr_hi				= ttmp11
 var s_restore_size				= ttmp6
 var s_restore_ttmps_lo				= s_restore_tmp
 var s_restore_ttmps_hi				= s_restore_alloc_size
 var s_restore_spi_init_hi_save			= s_restore_exec_hi
 
+#if SAVE_TTMPS_IN_SGPR_BLOCK
+var TTMP_SR_OFFSET_FROM_HWREG			= -0x40
+#else
+var TTMP_SR_OFFSET_FROM_HWREG			= 0x40
+#endif
+
 shader main
 	asic(DEFAULT)
 	type(CS)
@@ -245,6 +298,10 @@ L_CHECK_TRAP_ID:
 	s_cbranch_scc1	L_SAVE
 
 L_FETCH_2ND_TRAP:
+#if HAVE_XNACK
+	save_and_clear_xnack_state_priv(ttmp14)
+#endif
+
 	// Read second-level TBA/TMA from first-level TMA and jump if available.
 	// ttmp[2:5] and ttmp12 can be used (others hold SPI-initialized debug data)
 	// ttmp12 holds SQ_WAVE_STATUS
@@ -252,9 +309,9 @@ L_FETCH_2ND_TRAP:
 	s_wait_idle
 	s_lshl_b64	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
 
-	s_bitcmp1_b32	ttmp15, 0xF
+	s_bitcmp1_b32	ttmp15, (ADDRESS_HI32_NUM_BITS - 1)
 	s_cbranch_scc0	L_NO_SIGN_EXTEND_TMA
-	s_or_b32	ttmp15, ttmp15, 0xFFFF0000
+	s_or_b32	ttmp15, ttmp15, ~ADDRESS_HI32_MASK
 L_NO_SIGN_EXTEND_TMA:
 #if ASIC_FAMILY == CHIP_GFX12
 	// Move SCHED_MODE[1:0] from ttmp11 to unused bits in ttmp1[27:26] (return PC_HI).
@@ -303,13 +360,13 @@ L_TRAP_CASE:
 	s_addc_u32	ttmp1, ttmp1, 0x0
 
 L_EXIT_TRAP:
-	s_and_b32	ttmp1, ttmp1, 0xFFFF
+	s_and_b32	ttmp1, ttmp1, ADDRESS_HI32_MASK
 
 	// Restore SQ_WAVE_STATUS.
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
 
-	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
+	// STATE_PRIV.*BARRIER_COMPLETE may have changed since we read it.
 	// Only restore fields which the trap handler changes.
 	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
 
@@ -329,8 +386,7 @@ L_SAVE:
 	s_cbranch_scc0	L_HAVE_VGPRS
 	s_endpgm
 L_HAVE_VGPRS:
-
-	s_and_b32	s_save_pc_hi, s_save_pc_hi, 0x0000ffff			//pc[47:32]
+	s_and_b32	s_save_pc_hi, s_save_pc_hi, ADDRESS_HI32_MASK
 	s_mov_b32	s_save_tmp, 0
 	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
 
@@ -347,11 +403,25 @@ L_HAVE_VGPRS:
 	s_lshl_b32	s_save_tmp, s_save_tmp, (S_SAVE_PC_HI_FIRST_WAVE_SHIFT - S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT)
 	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
 
+#if HAVE_XNACK
+	save_and_clear_xnack_state_priv(s_save_tmp)
+	s_getreg_b32	s_save_xnack_mask, hwreg(HW_REG_WAVE_XNACK_MASK)
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_XNACK_MASK), 0
+#endif
+
+#if HAVE_BANKED_VGPRS
+	// Save and clear shader's DST/SRC0/SRC1 VGPR bank selection so we can use v[0-255].
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_MODE, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SHIFT, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SIZE)
+	s_lshl_b32	s_save_tmp, s_save_tmp, S_SAVE_PC_HI_DST_SRC0_SRC1_VGPR_MSB_SHIFT
+	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_MODE, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SHIFT, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SIZE), 0
+#endif
+
 	// Trap temporaries must be saved via VGPR but all VGPRs are in use.
 	// There is no ttmp space to hold the resource constant for VGPR save.
 	// Save v0 by itself since it requires only two SGPRs.
 	s_mov_b32	s_save_ttmps_lo, exec_lo
-	s_and_b32	s_save_ttmps_hi, exec_hi, 0xFFFF
+	s_and_b32	s_save_ttmps_hi, exec_hi, ADDRESS_HI32_MASK
 	s_mov_b32	exec_lo, 0xFFFFFFFF
 	s_mov_b32	exec_hi, 0xFFFFFFFF
 	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS
@@ -360,13 +430,13 @@ L_HAVE_VGPRS:
 	s_mov_b32	exec_hi, s_save_ttmps_hi
 
 	// Save trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
-	// ttmp SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)+0x40
+	// ttmp SR memory offset:
+	// - gfx12:   size(VGPR)+size(SGPR)+0x40
+	// - gfx12.5: size(VGPR)+size(SGPR)-0x40
 	get_wave_size2(s_save_ttmps_hi)
 	get_vgpr_size_bytes(s_save_ttmps_lo, s_save_ttmps_hi)
-	get_svgpr_size_bytes(s_save_ttmps_hi)
-	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, s_save_ttmps_hi
-	s_and_b32	s_save_ttmps_hi, s_save_spi_init_hi, 0xFFFF
-	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, get_sgpr_size_bytes()
+	s_and_b32	s_save_ttmps_hi, s_save_spi_init_hi, ADDRESS_HI32_MASK
+	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, (get_sgpr_size_bytes() + TTMP_SR_OFFSET_FROM_HWREG)
 	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, s_save_spi_init_lo
 	s_addc_u32	s_save_ttmps_hi, s_save_ttmps_hi, 0x0
 
@@ -381,27 +451,19 @@ L_HAVE_VGPRS:
 	v_writelane_b32	v0, ttmp13, 0xD
 	v_writelane_b32	v0, exec_lo, 0xE
 	v_writelane_b32	v0, exec_hi, 0xF
-	valu_sgpr_hazard()
 
 	s_mov_b32	exec_lo, 0x3FFF
 	s_mov_b32	exec_hi, 0x0
-	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] offset:0x40 scope:SCOPE_SYS
+	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS
 	v_readlane_b32	ttmp14, v0, 0xE
 	v_readlane_b32	ttmp15, v0, 0xF
 	s_mov_b32	exec_lo, ttmp14
 	s_mov_b32	exec_hi, ttmp15
 
-	/* setup Resource Contants */
-	s_mov_b32	s_save_buf_rsrc0, s_save_spi_init_lo			//base_addr_lo
-	s_and_b32	s_save_buf_rsrc1, s_save_spi_init_hi, 0x0000FFFF	//base_addr_hi
-	s_or_b32	s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE
-	s_mov_b32	s_save_buf_rsrc2, 0					//NUM_RECORDS initial value = 0 (in bytes) although not neccessarily inited
-	s_mov_b32	s_save_buf_rsrc3, S_SAVE_BUF_RSRC_WORD3_MISC
-
+	s_mov_b32	s_save_base_addr_lo, s_save_spi_init_lo
+	s_and_b32	s_save_base_addr_hi, s_save_spi_init_hi, ADDRESS_HI32_MASK
 	s_mov_b32	s_save_m0, m0
 
-	/* global mem offset */
-	s_mov_b32	s_save_mem_offset, 0x0
 	get_wave_size2(s_wave_size)
 
 	/* save first 4 VGPRs, needed for SGPR save */
@@ -416,102 +478,125 @@ L_ENABLE_SAVE_4VGPR_EXEC_HI:
 	s_mov_b32	exec_hi, 0xFFFFFFFF
 	s_branch	L_SAVE_4VGPR_WAVE64
 L_SAVE_4VGPR_WAVE32:
-	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	// VGPR Allocated in 4-GPR granularity
-
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128*2
-	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128*3
+	global_store_addtid_b32	v1, [s_save_base_addr_lo, s_save_base_addr_hi] scope:SCOPE_SYS offset:128
+	global_store_addtid_b32	v2, [s_save_base_addr_lo, s_save_base_addr_hi] scope:SCOPE_SYS offset:128*2
+	global_store_addtid_b32	v3, [s_save_base_addr_lo, s_save_base_addr_hi] scope:SCOPE_SYS offset:128*3
 	s_branch	L_SAVE_HWREG
 
 L_SAVE_4VGPR_WAVE64:
-	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	// VGPR Allocated in 4-GPR granularity
-
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256*2
-	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256*3
+	global_store_addtid_b32	v1, [s_save_base_addr_lo, s_save_base_addr_hi] scope:SCOPE_SYS offset:256
+	global_store_addtid_b32	v2, [s_save_base_addr_lo, s_save_base_addr_hi] scope:SCOPE_SYS offset:256*2
+	global_store_addtid_b32	v3, [s_save_base_addr_lo, s_save_base_addr_hi] scope:SCOPE_SYS offset:256*3
 
 	/* save HW registers */
 
 L_SAVE_HWREG:
-	// HWREG SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)
+	// HWREG SR memory offset : size(VGPR)+size(SGPR)
 	get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
-	get_svgpr_size_bytes(s_save_tmp)
-	s_add_u32	s_save_mem_offset, s_save_mem_offset, s_save_tmp
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, get_sgpr_size_bytes()
 
-	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	v_mov_b32	v0, 0x0							//Offset[31:0] from buffer resource
 	v_mov_b32	v1, 0x0							//Offset[63:32] from buffer resource
 	v_mov_b32	v2, 0x0							//Set of SGPRs for TCP store
+	s_mov_b32	m0, 0x0							//Next lane of v2 to write to
 
 	// Ensure no further changes to barrier or LDS state.
-	// STATE_PRIV.BARRIER_COMPLETE may change up to this point.
-	s_barrier_signal	-2
-	s_barrier_wait	-2
+	// STATE_PRIV.*BARRIER_COMPLETE may change up to this point.
+	wait_trap_barriers(s_save_tmp)
 
-	// Re-read final state of BARRIER_COMPLETE field for save.
+	// Re-read final state of *BARRIER_COMPLETE fields for save.
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATE_PRIV)
-	s_and_b32	s_save_tmp, s_save_tmp, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
-	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
+	s_and_b32	s_save_tmp, s_save_tmp, SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK
+	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK
 	s_or_b32	s_save_state_priv, s_save_state_priv, s_save_tmp
 
+	write_hwreg_to_v2(s_save_m0)
+	write_hwreg_to_v2(s_save_pc_lo)
 	s_andn2_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
-	v_writelane_b32	v2, s_save_m0, 0x0
-	v_writelane_b32	v2, s_save_pc_lo, 0x1
-	v_writelane_b32	v2, s_save_tmp, 0x2
-	v_writelane_b32	v2, s_save_exec_lo, 0x3
-	v_writelane_b32	v2, s_save_exec_hi, 0x4
-	v_writelane_b32	v2, s_save_state_priv, 0x5
-	v_writelane_b32	v2, s_save_xnack_mask, 0x7
-	valu_sgpr_hazard()
+	write_hwreg_to_v2(s_save_tmp)
+	write_hwreg_to_v2(s_save_exec_lo)
+#if WAVE32_ONLY
+	s_mov_b32	s_save_tmp, 0
+	write_hwreg_to_v2(s_save_tmp)
+#else
+	write_hwreg_to_v2(s_save_exec_hi)
+#endif
+	write_hwreg_to_v2(s_save_state_priv)
 
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
-	v_writelane_b32	v2, s_save_tmp, 0x6
+	write_hwreg_to_v2(s_save_tmp)
 
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_MODE)
-	v_writelane_b32	v2, s_save_tmp, 0x8
+#if HAVE_XNACK
+	write_hwreg_to_v2(s_save_xnack_mask)
+#else
+	s_mov_b32	s_save_tmp, 0
+	write_hwreg_to_v2(s_save_tmp)
+#endif
 
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
-	v_writelane_b32	v2, s_save_tmp, 0x9
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_MODE)
 
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
-	v_writelane_b32	v2, s_save_tmp, 0xA
+#if HAVE_BANKED_VGPRS
+	s_bfe_u32	s_save_tmp, s_save_pc_hi, (S_SAVE_PC_HI_DST_SRC0_SRC1_VGPR_MSB_SHIFT | (S_SAVE_PC_HI_DST_SRC0_SRC1_VGPR_MSB_SIZE << 0x10))
+	s_lshl_b32	s_save_tmp, s_save_tmp, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SHIFT
+	s_or_b32	s_save_m0, s_save_m0, s_save_tmp
+#endif
 
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
-	v_writelane_b32	v2, s_save_tmp, 0xB
+	write_hwreg_to_v2(s_save_m0)
 
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_TRAP_CTRL)
-	v_writelane_b32	v2, s_save_tmp, 0xC
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
+	write_hwreg_to_v2(s_save_m0)
+
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
+	write_hwreg_to_v2(s_save_m0)
+
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
+	write_hwreg_to_v2(s_save_m0)
+
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_TRAP_CTRL)
+	write_hwreg_to_v2(s_save_m0)
 
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
-	v_writelane_b32	v2, s_save_tmp, 0xD
+	write_hwreg_to_v2(s_save_tmp)
 
 	s_get_barrier_state s_save_tmp, -1
 	s_wait_kmcnt (0)
-	v_writelane_b32	v2, s_save_tmp, 0xE
-	valu_sgpr_hazard()
+	write_hwreg_to_v2(s_save_tmp)
+
+#if HAVE_CLUSTER_BARRIER
+	s_sendmsg_rtn_b32	s_save_tmp, sendmsg(MSG_RTN_GET_CLUSTER_BARRIER_STATE)
+	s_wait_kmcnt	0
+	write_hwreg_to_v2(s_save_tmp)
+#endif
 
 	// Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
 	s_mov_b32       exec_lo, 0xFFFF
 	s_mov_b32	exec_hi, 0x0
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_mem_offset
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0x0
+	global_store_addtid_b32	v2, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
 
 	// Write SGPRs with 32 VGPR lanes. This works in wave32 and wave64 mode.
 	s_mov_b32       exec_lo, 0xFFFFFFFF
 
+#if NUM_NAMED_BARRIERS
+	v_mov_b32	v2, 0
+
+	for var bar_idx = 0; bar_idx < NUM_NAMED_BARRIERS; bar_idx ++
+		s_get_barrier_state s_save_tmp, (bar_idx + 1)
+		s_wait_kmcnt	0
+		v_writelane_b32	v2, s_save_tmp, bar_idx
+	end
+
+	global_store_addtid_b32	v2, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:NAMED_BARRIERS_SR_OFFSET_FROM_HWREG
+#endif
+
 	/* save SGPRs */
 	// Save SGPR before LDS save, then the s0 to s4 can be used during LDS save...
 
-	// SGPR SR memory offset : size(VGPR)+size(SVGPR)
+	// SGPR SR memory offset : size(VGPR)
 	get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
-	get_svgpr_size_bytes(s_save_tmp)
-	s_add_u32	s_save_mem_offset, s_save_mem_offset, s_save_tmp
-	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
 
 	s_mov_b32	ttmp13, 0x0						//next VGPR lane to copy SGPR into
 
@@ -528,14 +613,14 @@ L_SAVE_SGPR_LOOP:
 	s_movrels_b64	s12, s12						//s12 = s[12+m0], s13 = s[13+m0]
 	s_movrels_b64	s14, s14						//s14 = s[14+m0], s15 = s[15+m0]
 
-	s_cmp_eq_u32	ttmp13, 0x0
-	s_cbranch_scc0	L_WRITE_V2_SECOND_HALF
-	write_16sgpr_to_v2(s0, 0x0)
-	s_branch	L_SAVE_SGPR_SKIP_TCP_STORE
-L_WRITE_V2_SECOND_HALF:
-	write_16sgpr_to_v2(s0, 0x10)
+	write_16sgpr_to_v2(s0)
 
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+	s_cmp_eq_u32	ttmp13, 0x20						//have 32 VGPR lanes filled?
+	s_cbranch_scc0	L_SAVE_SGPR_SKIP_TCP_STORE
+
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_mem_offset
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0x0
+	global_store_addtid_b32	v2, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 0x80
 	s_mov_b32	ttmp13, 0x0
 	v_mov_b32	v2, 0x0
@@ -554,7 +639,14 @@ L_SAVE_SGPR_SKIP_TCP_STORE:
 	s_movrels_b64	s10, s10						//s10 = s[10+m0], s11 = s[11+m0]
 	write_12sgpr_to_v2(s0)
 
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+#if SAVE_TTMPS_IN_SGPR_BLOCK
+	// Last 16 dwords of the SGPR block already contain the TTMPS.  Make
+	// sure to not override them.
+	s_mov_b32	exec_lo, 0xFFFF
+#endif
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_mem_offset
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0x0
+	global_store_addtid_b32	v2, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
 
 	/* save LDS */
 
@@ -580,18 +672,13 @@ L_SAVE_LDS_NORMAL:
 	// first wave do LDS save;
 
 	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
-	s_mov_b32	s_save_buf_rsrc2, s_save_alloc_size			//NUM_RECORDS in bytes
 
-	// LDS at offset: size(VGPR)+size(SVGPR)+SIZE(SGPR)+SIZE(HWREG)
+	// LDS at offset: size(VGPR)+SIZE(SGPR)+SIZE(HWREG)
 	//
 	get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
-	get_svgpr_size_bytes(s_save_tmp)
-	s_add_u32	s_save_mem_offset, s_save_mem_offset, s_save_tmp
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, get_sgpr_size_bytes()
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, get_hwreg_size_bytes()
 
-	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	//load 0~63*4(byte address) to vgpr v0
 	v_mbcnt_lo_u32_b32	v0, -1, 0
 	v_mbcnt_hi_u32_b32	v0, -1, v0
@@ -611,7 +698,9 @@ L_SAVE_LDS_W32:
 L_SAVE_LDS_LOOP_W32:
 	ds_read_b32	v1, v0
 	s_wait_idle
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_mem_offset
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0x0
+	global_store_addtid_b32	v1, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
 
 	s_add_u32	m0, m0, s3						//every buffer_store_lds does 128 bytes
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, s3
@@ -629,7 +718,9 @@ L_SAVE_LDS_W64:
 L_SAVE_LDS_LOOP_W64:
 	ds_read_b32	v1, v0
 	s_wait_idle
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_mem_offset
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0x0
+	global_store_addtid_b32	v1, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
 
 	s_add_u32	m0, m0, s3						//every buffer_store_lds does 256 bytes
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, s3
@@ -662,8 +753,6 @@ L_SAVE_VGPR_NORMAL:
 	s_cmp_eq_u32	m0, 1
 	s_cbranch_scc1	L_SAVE_VGPR_WAVE64
 
-	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	// VGPR Allocated in 4-GPR granularity
 
 	// VGPR store using dw burst
@@ -677,10 +766,12 @@ L_SAVE_VGPR_W32_LOOP:
 	v_movrels_b32	v2, v2							//v2 = v[2+m0]
 	v_movrels_b32	v3, v3							//v3 = v[3+m0]
 
-	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128*2
-	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128*3
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_mem_offset
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0x0
+	global_store_addtid_b32	v0, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
+	global_store_addtid_b32	v1, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:128
+	global_store_addtid_b32	v2, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:128*2
+	global_store_addtid_b32	v3, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:128*3
 
 	s_add_u32	m0, m0, 4						//next vgpr index
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 128*4		//every buffer_store_dword does 128 bytes
@@ -690,12 +781,10 @@ L_SAVE_VGPR_W32_LOOP:
 	s_branch	L_SAVE_VGPR_END
 
 L_SAVE_VGPR_WAVE64:
-	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	// VGPR store using dw burst
 	s_mov_b32	m0, 0x4							//VGPR initial index value =4
 	s_cmp_lt_u32	m0, s_save_alloc_size
-	s_cbranch_scc0	L_SAVE_SHARED_VGPR
+	s_cbranch_scc0	L_SAVE_VGPR_END
 
 L_SAVE_VGPR_W64_LOOP:
 	v_movrels_b32	v0, v0							//v0 = v[0+m0]
@@ -703,45 +792,24 @@ L_SAVE_VGPR_W64_LOOP:
 	v_movrels_b32	v2, v2							//v2 = v[2+m0]
 	v_movrels_b32	v3, v3							//v3 = v[3+m0]
 
-	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256*2
-	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256*3
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_mem_offset
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0x0
+	global_store_addtid_b32	v0, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
+	global_store_addtid_b32	v1, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:256
+	global_store_addtid_b32	v2, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:256*2
+	global_store_addtid_b32	v3, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:256*3
 
 	s_add_u32	m0, m0, 4						//next vgpr index
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 256*4		//every buffer_store_dword does 256 bytes
 	s_cmp_lt_u32	m0, s_save_alloc_size					//scc = (m0 < s_save_alloc_size) ? 1 : 0
 	s_cbranch_scc1	L_SAVE_VGPR_W64_LOOP					//VGPR save is complete?
 
-L_SAVE_SHARED_VGPR:
-	s_getreg_b32	s_save_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)
-	s_and_b32	s_save_alloc_size, s_save_alloc_size, 0xFFFFFFFF	//shared_vgpr_size is zero?
-	s_cbranch_scc0	L_SAVE_VGPR_END						//no shared_vgpr used? jump to L_SAVE_LDS
-	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, 3			//Number of SHARED_VGPRs = shared_vgpr_size * 8    (non-zero value)
-	//m0 now has the value of normal vgpr count, just add the m0 with shared_vgpr count to get the total count.
-	//save shared_vgpr will start from the index of m0
-	s_add_u32	s_save_alloc_size, s_save_alloc_size, m0
-	s_mov_b32	exec_lo, 0xFFFFFFFF
-	s_mov_b32	exec_hi, 0x00000000
-
-L_SAVE_SHARED_VGPR_WAVE64_LOOP:
-	v_movrels_b32	v0, v0							//v0 = v[0+m0]
-	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
-	s_add_u32	m0, m0, 1						//next vgpr index
-	s_add_u32	s_save_mem_offset, s_save_mem_offset, 128
-	s_cmp_lt_u32	m0, s_save_alloc_size					//scc = (m0 < s_save_alloc_size) ? 1 : 0
-	s_cbranch_scc1	L_SAVE_SHARED_VGPR_WAVE64_LOOP				//SHARED_VGPR save is complete?
-
 L_SAVE_VGPR_END:
 	s_branch	L_END_PGM
 
 L_RESTORE:
-	/* Setup Resource Contants */
-	s_mov_b32	s_restore_buf_rsrc0, s_restore_spi_init_lo		//base_addr_lo
-	s_and_b32	s_restore_buf_rsrc1, s_restore_spi_init_hi, 0x0000FFFF	//base_addr_hi
-	s_or_b32	s_restore_buf_rsrc1, s_restore_buf_rsrc1, S_RESTORE_BUF_RSRC_WORD1_STRIDE
-	s_mov_b32	s_restore_buf_rsrc2, 0					//NUM_RECORDS initial value = 0 (in bytes)
-	s_mov_b32	s_restore_buf_rsrc3, S_RESTORE_BUF_RSRC_WORD3_MISC
+	s_mov_b32	s_restore_base_addr_lo, s_restore_spi_init_lo
+	s_and_b32	s_restore_base_addr_hi, s_restore_spi_init_hi, ADDRESS_HI32_MASK
 
 	// Save s_restore_spi_init_hi for later use.
 	s_mov_b32 s_restore_spi_init_hi_save, s_restore_spi_init_hi
@@ -768,28 +836,31 @@ L_RESTORE_LDS_NORMAL:
 	s_and_b32	s_restore_alloc_size, s_restore_alloc_size, 0xFFFFFFFF	//lds_size is zero?
 	s_cbranch_scc0	L_RESTORE_VGPR						//no lds used? jump to L_RESTORE_VGPR
 	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
-	s_mov_b32	s_restore_buf_rsrc2, s_restore_alloc_size		//NUM_RECORDS in bytes
 
-	// LDS at offset: size(VGPR)+size(SVGPR)+SIZE(SGPR)+SIZE(HWREG)
+	// LDS at offset: size(VGPR)+SIZE(SGPR)+SIZE(HWREG)
 	//
 	get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
-	get_svgpr_size_bytes(s_restore_tmp)
-	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, get_sgpr_size_bytes()
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, get_hwreg_size_bytes()
 
-	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	s_lshr_b32	m0, s_restore_size, S_WAVE_SIZE
 	s_and_b32	m0, m0, 1
 	s_cmp_eq_u32	m0, 1
 	s_mov_b32	m0, 0x0
+
+	v_mbcnt_lo_u32_b32	v1, -1, 0
+	v_mbcnt_hi_u32_b32	v1, -1, v1
+	v_lshlrev_b32		v1, 2, v1					// 0, 4, 8, ... 124 (W32) or 252 (W64)
+
 	s_cbranch_scc1	L_RESTORE_LDS_LOOP_W64
 
 L_RESTORE_LDS_LOOP_W32:
-	buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_mem_offset
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
+	global_load_addtid_b32	v0, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS
 	s_wait_idle
-	ds_store_addtid_b32     v0
+	ds_store_b32	v1, v0
+	v_add_nc_u32	v1, v1, 128
 	s_add_u32	m0, m0, 128						// 128 DW
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128		//mem offset increased by 128DW
 	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc=(m0 < s_restore_alloc_size) ? 1 : 0
@@ -797,9 +868,12 @@ L_RESTORE_LDS_LOOP_W32:
 	s_branch	L_RESTORE_VGPR
 
 L_RESTORE_LDS_LOOP_W64:
-	buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_mem_offset
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
+	global_load_addtid_b32	v0, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS
 	s_wait_idle
-	ds_store_addtid_b32     v0
+	ds_store_b32	v1, v0
+	v_add_nc_u32	v1, v1, 256
 	s_add_u32	m0, m0, 256						// 256 DW
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 256		//mem offset increased by 256DW
 	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc=(m0 < s_restore_alloc_size) ? 1 : 0
@@ -828,20 +902,18 @@ L_RESTORE_VGPR_NORMAL:
 	s_cmp_eq_u32	m0, 1
 	s_cbranch_scc1	L_RESTORE_VGPR_WAVE64
 
-	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	// VGPR load using dw burst
 	s_mov_b32	s_restore_mem_offset_save, s_restore_mem_offset		// restore start with v1, v0 will be the last
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128*4
 	s_mov_b32	m0, 4							//VGPR initial index value = 4
-	s_cmp_lt_u32	m0, s_restore_alloc_size
-	s_cbranch_scc0	L_RESTORE_SGPR
 
 L_RESTORE_VGPR_WAVE32_LOOP:
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS
-	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:128
-	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:128*2
-	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:128*3
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_mem_offset
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
+	global_load_addtid_b32	v0, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS
+	global_load_addtid_b32	v1, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:128
+	global_load_addtid_b32	v2, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:128*2
+	global_load_addtid_b32	v3, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:128*3
 	s_wait_idle
 	v_movreld_b32	v0, v0							//v[0+m0] = v0
 	v_movreld_b32	v1, v1
@@ -853,29 +925,31 @@ L_RESTORE_VGPR_WAVE32_LOOP:
 	s_cbranch_scc1	L_RESTORE_VGPR_WAVE32_LOOP				//VGPR restore (except v0) is complete?
 
 	/* VGPR restore on v0 */
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS
-	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:128
-	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:128*2
-	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:128*3
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_mem_offset_save
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
+	global_load_addtid_b32	v0, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS
+	global_load_addtid_b32	v1, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:128
+	global_load_addtid_b32	v2, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:128*2
+	global_load_addtid_b32	v3, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:128*3
 	s_wait_idle
 
 	s_branch	L_RESTORE_SGPR
 
 L_RESTORE_VGPR_WAVE64:
-	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
-
 	// VGPR load using dw burst
 	s_mov_b32	s_restore_mem_offset_save, s_restore_mem_offset		// restore start with v4, v0 will be the last
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 256*4
 	s_mov_b32	m0, 4							//VGPR initial index value = 4
 	s_cmp_lt_u32	m0, s_restore_alloc_size
-	s_cbranch_scc0	L_RESTORE_SHARED_VGPR
+	s_cbranch_scc0	L_RESTORE_V0
 
 L_RESTORE_VGPR_WAVE64_LOOP:
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS
-	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:256
-	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:256*2
-	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:256*3
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_mem_offset
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
+	global_load_addtid_b32	v0, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS
+	global_load_addtid_b32	v1, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:256
+	global_load_addtid_b32	v2, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:256*2
+	global_load_addtid_b32	v3, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:256*3
 	s_wait_idle
 	v_movreld_b32	v0, v0							//v[0+m0] = v0
 	v_movreld_b32	v1, v1
@@ -886,50 +960,29 @@ L_RESTORE_VGPR_WAVE64_LOOP:
 	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc = (m0 < s_restore_alloc_size) ? 1 : 0
 	s_cbranch_scc1	L_RESTORE_VGPR_WAVE64_LOOP				//VGPR restore (except v0) is complete?
 
-L_RESTORE_SHARED_VGPR:
-	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)	//shared_vgpr_size
-	s_and_b32	s_restore_alloc_size, s_restore_alloc_size, 0xFFFFFFFF	//shared_vgpr_size is zero?
-	s_cbranch_scc0	L_RESTORE_V0						//no shared_vgpr used?
-	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, 3		//Number of SHARED_VGPRs = shared_vgpr_size * 8    (non-zero value)
-	//m0 now has the value of normal vgpr count, just add the m0 with shared_vgpr count to get the total count.
-	//restore shared_vgpr will start from the index of m0
-	s_add_u32	s_restore_alloc_size, s_restore_alloc_size, m0
-	s_mov_b32	exec_lo, 0xFFFFFFFF
-	s_mov_b32	exec_hi, 0x00000000
-L_RESTORE_SHARED_VGPR_WAVE64_LOOP:
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS
-	s_wait_idle
-	v_movreld_b32	v0, v0							//v[0+m0] = v0
-	s_add_u32	m0, m0, 1						//next vgpr index
-	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128
-	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc = (m0 < s_restore_alloc_size) ? 1 : 0
-	s_cbranch_scc1	L_RESTORE_SHARED_VGPR_WAVE64_LOOP			//VGPR restore (except v0) is complete?
-
-	s_mov_b32	exec_hi, 0xFFFFFFFF					//restore back exec_hi before restoring V0!!
-
 	/* VGPR restore on v0 */
 L_RESTORE_V0:
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS
-	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:256
-	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:256*2
-	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:256*3
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_mem_offset_save
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
+	global_load_addtid_b32	v0, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS
+	global_load_addtid_b32	v1, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:256
+	global_load_addtid_b32	v2, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:256*2
+	global_load_addtid_b32	v3, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:256*3
 	s_wait_idle
 
 	/* restore SGPRs */
 	//will be 2+8+16*6
-	// SGPR SR memory offset : size(VGPR)+size(SVGPR)
+	// SGPR SR memory offset : size(VGPR)
 L_RESTORE_SGPR:
 	get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
-	get_svgpr_size_bytes(s_restore_tmp)
-	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, get_sgpr_size_bytes()
-	s_sub_u32	s_restore_mem_offset, s_restore_mem_offset, 20*4	//s108~s127 is not saved
-
-	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+	s_sub_u32	s_restore_mem_offset, s_restore_mem_offset, 24*4	// s[104:107]
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_mem_offset
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
 
 	s_mov_b32	m0, s_sgpr_save_num
 
-	read_4sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_load_b128	s0, [s_restore_addr_lo, s_restore_addr_hi], 0x0 scope:SCOPE_SYS
 	s_wait_idle
 
 	s_sub_u32	m0, m0, 4						// Restore from S[0] to S[104]
@@ -938,7 +991,9 @@ L_RESTORE_SGPR:
 	s_movreld_b64	s0, s0							//s[0+m0] = s0
 	s_movreld_b64	s2, s2
 
-	read_8sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_sub_co_u32	s_restore_addr_lo, s_restore_addr_lo, 8*4		// s[96:103]
+	s_sub_co_ci_u32	s_restore_addr_hi, s_restore_addr_hi, 0
+	s_load_b256	s0, [s_restore_addr_lo, s_restore_addr_hi], 0x0 scope:SCOPE_SYS
 	s_wait_idle
 
 	s_sub_u32	m0, m0, 8						// Restore from S[0] to S[96]
@@ -950,7 +1005,9 @@ L_RESTORE_SGPR:
 	s_movreld_b64	s6, s6
 
  L_RESTORE_SGPR_LOOP:
-	read_16sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_sub_co_u32	s_restore_addr_lo, s_restore_addr_lo, 16*4		// s[0,16,32,48,64,80]
+	s_sub_co_ci_u32	s_restore_addr_hi, s_restore_addr_hi, 0
+	s_load_b512	s0, [s_restore_addr_lo, s_restore_addr_hi], 0x0 scope:SCOPE_SYS
 	s_wait_idle
 
 	s_sub_u32	m0, m0, 16						// Restore from S[n] to S[0]
@@ -974,76 +1031,117 @@ L_RESTORE_SGPR:
 
 	/* restore HW registers */
 L_RESTORE_HWREG:
-	// HWREG SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)
+	// HWREG SR memory offset : size(VGPR)+size(SGPR)
 	get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
-	get_svgpr_size_bytes(s_restore_tmp)
-	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, get_sgpr_size_bytes()
-
-	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_mem_offset
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
 
 	// Restore s_restore_spi_init_hi before the saved value gets clobbered.
 	s_mov_b32 s_restore_spi_init_hi, s_restore_spi_init_hi_save
 
-	read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_pc_hi, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_exec_lo, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_exec_hi, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_state_priv, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_excp_flag_priv, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_xnack_mask, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_mode, s_restore_buf_rsrc0, s_restore_mem_offset)
-	read_hwreg_from_mem(s_restore_flat_scratch, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_load_b32	s_restore_m0, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS
+	s_load_b32	s_restore_pc_lo, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x4
+	s_load_b32	s_restore_pc_hi, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x8
+	s_load_b32	s_restore_exec_lo, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0xC
+	s_load_b32	s_restore_exec_hi, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x10
+	s_load_b32	s_restore_state_priv, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x14
+	s_load_b32	s_restore_excp_flag_priv, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x18
+	s_load_b32	s_restore_xnack_mask, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x1C
+	s_load_b32	s_restore_mode, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x20
+	s_load_b32	s_restore_flat_scratch, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x24
 	s_wait_idle
 
 	s_setreg_b32	hwreg(HW_REG_WAVE_SCRATCH_BASE_LO), s_restore_flat_scratch
 
-	read_hwreg_from_mem(s_restore_flat_scratch, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_load_b32	s_restore_flat_scratch, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x28
 	s_wait_idle
 
 	s_setreg_b32	hwreg(HW_REG_WAVE_SCRATCH_BASE_HI), s_restore_flat_scratch
 
-	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x2C
 	s_wait_idle
 	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_USER), s_restore_tmp
 
-	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x30
 	s_wait_idle
 	s_setreg_b32	hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
 
-	// Only the first wave needs to restore the workgroup barrier.
+	// Only the first wave needs to restore group barriers.
 	s_and_b32	s_restore_tmp, s_restore_spi_init_hi, S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
-	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
+	s_cbranch_scc0	L_SKIP_GROUP_BARRIER_RESTORE
 
 	// Skip over WAVE_STATUS, since there is no state to restore from it
-	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 4
 
-	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x38
 	s_wait_idle
 
+	// Skip group barriers if wave is not part of a group.
 	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
-	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
+	s_cbranch_scc0	L_SKIP_GROUP_BARRIER_RESTORE
 
-	// extract the saved signal count from s_restore_tmp
-	s_lshr_b32	s_restore_tmp, s_restore_tmp, BARRIER_STATE_SIGNAL_OFFSET
+	// Restore workgroup barrier signal count.
+	restore_barrier_signal_count(-1)
 
-	// We need to call s_barrier_signal repeatedly to restore the signal
-	// count of the work group barrier.  The member count is already
-	// initialized with the number of waves in the work group.
-L_BARRIER_RESTORE_LOOP:
-	s_and_b32	s_restore_tmp, s_restore_tmp, s_restore_tmp
-	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
-	s_barrier_signal	-1
-	s_add_i32	s_restore_tmp, s_restore_tmp, -1
-	s_branch	L_BARRIER_RESTORE_LOOP
+#if NUM_NAMED_BARRIERS
+	s_mov_b32	s_restore_mem_offset, NAMED_BARRIERS_SR_OFFSET_FROM_HWREG
+	s_mov_b32	m0, 1
+
+L_RESTORE_NAMED_BARRIER_LOOP:
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], s_restore_mem_offset scope:SCOPE_SYS
+	s_wait_kmcnt	0
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 0x4
+
+	// Restore named barrier member count.
+	s_bfe_u32	exec_lo, s_restore_tmp, (BARRIER_STATE_MEMBER_OFFSET | (BARRIER_STATE_MEMBER_SIZE << 16))
+	s_lshl_b32	exec_lo, exec_lo, S_BARRIER_INIT_MEMBERCNT_SHIFT
+	s_or_b32	m0, m0, exec_lo
+	s_barrier_init	m0
+	s_andn2_b32	m0, m0, S_BARRIER_INIT_MEMBERCNT_MASK
 
-L_SKIP_BARRIER_RESTORE:
+	// Restore named barrier signal count.
+	restore_barrier_signal_count(m0)
+
+	s_add_u32	m0, m0, 1
+	s_cmp_gt_u32	m0, NUM_NAMED_BARRIERS
+	s_cbranch_scc0	L_RESTORE_NAMED_BARRIER_LOOP
+#endif
+
+L_SKIP_GROUP_BARRIER_RESTORE:
+#if HAVE_CLUSTER_BARRIER
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x3C
+	s_wait_kmcnt	0
+
+	// Skip cluster barrier restore if wave is not part of a cluster.
+	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
+	s_cbranch_scc0	L_SKIP_CLUSTER_BARRIER_RESTORE
+
+	// Only the first wave in the group signals the trap cluster barrier.
+	s_bitcmp1_b32	s_restore_spi_init_hi, S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT
+	s_cbranch_scc0	L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL
+
+	// Clear SCC: s_barrier_signal_isfirst -4 writes SCC=>1 but not SCC=>0.
+	s_cmp_eq_u32	0, 1
+	s_barrier_signal_isfirst	-4
+L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
+	s_barrier_wait	-4
+
+	// Only the first wave in the cluster restores the barrier.
+	s_cbranch_scc0	L_SKIP_CLUSTER_BARRIER_RESTORE
+
+	// Restore cluster barrier signal count.
+	restore_barrier_signal_count(-3)
+L_SKIP_CLUSTER_BARRIER_RESTORE:
+#endif
 
 	s_mov_b32	m0, s_restore_m0
 	s_mov_b32	exec_lo, s_restore_exec_lo
 	s_mov_b32	exec_hi, s_restore_exec_hi
 
+#if HAVE_XNACK
+	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_MASK), s_restore_xnack_mask
+#endif
+
 	// EXCP_FLAG_PRIV.SAVE_CONTEXT and HOST_TRAP may have changed.
 	// Only restore the other fields to avoid clobbering them.
 	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, 0, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE), s_restore_excp_flag_priv
@@ -1055,20 +1153,23 @@ L_SKIP_BARRIER_RESTORE:
 	s_setreg_b32	hwreg(HW_REG_WAVE_MODE), s_restore_mode
 
 	// Restore trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
-	// ttmp SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)+0x40
+	// ttmp SR memory offset :
+	// - gfx12:   size(VGPR)+size(SGPR)+0x40
+	// - gfx12.5: size(VGPR)+size(SGPR)-0x40
 	get_vgpr_size_bytes(s_restore_ttmps_lo, s_restore_size)
-	get_svgpr_size_bytes(s_restore_ttmps_hi)
-	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_ttmps_hi
-	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, get_sgpr_size_bytes()
-	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_buf_rsrc0
-	s_addc_u32	s_restore_ttmps_hi, s_restore_buf_rsrc1, 0x0
-	s_and_b32	s_restore_ttmps_hi, s_restore_ttmps_hi, 0xFFFF
-	s_load_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x50 scope:SCOPE_SYS
-	s_load_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x60 scope:SCOPE_SYS
-	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 scope:SCOPE_SYS
+	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, (get_sgpr_size_bytes() + TTMP_SR_OFFSET_FROM_HWREG)
+	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_base_addr_lo
+	s_addc_u32	s_restore_ttmps_hi, s_restore_base_addr_hi, 0x0
+	s_load_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x10 scope:SCOPE_SYS
+	s_load_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x20 scope:SCOPE_SYS
+	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x34 scope:SCOPE_SYS
 	s_wait_idle
 
-	s_and_b32	s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff		//pc[47:32] //Do it here in order not to affect STATUS
+#if HAVE_XNACK
+	restore_xnack_state_priv(s_restore_tmp)
+#endif
+
+	s_and_b32	s_restore_pc_hi, s_restore_pc_hi, ADDRESS_HI32_MASK	//Do it here in order not to affect STATUS
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
 
@@ -1077,56 +1178,47 @@ L_SKIP_BARRIER_RESTORE:
 
 	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
 
-	// Make barrier and LDS state visible to all waves in the group.
-	// STATE_PRIV.BARRIER_COMPLETE may change after this point.
-	s_barrier_signal	-2
-	s_barrier_wait	-2
+	// Make barrier and LDS state visible to all waves in the group/cluster.
+	// STATE_PRIV.*BARRIER_COMPLETE may change after this point.
+	wait_trap_barriers(s_restore_tmp)
+
+#if HAVE_CLUSTER_BARRIER
+	// SCC is changed by wait_trap_barriers, restore it separately.
+	s_lshr_b32	s_restore_state_priv, s_restore_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, 1), s_restore_state_priv
+#endif
 
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
-	// Make sure that no wave of the workgroup can exit the trap handler
-	// before the workgroup barrier state is saved.
-	s_barrier_signal	-2
-	s_barrier_wait	-2
+	// Make sure that no wave of the group/cluster can exit the trap handler
+	// before the group/cluster barrier state is saved.
+	wait_trap_barriers(s_restore_tmp)
+
 	s_endpgm_saved
 end
 
-function write_16sgpr_to_v2(s, lane_offset)
+function write_hwreg_to_v2(s)
+	// Copy into VGPR for later TCP store.
+	v_writelane_b32	v2, s, m0
+	s_add_u32	m0, m0, 0x1
+end
+
+
+function write_16sgpr_to_v2(s)
 	// Copy into VGPR for later TCP store.
 	for var sgpr_idx = 0; sgpr_idx < 16; sgpr_idx ++
-		v_writelane_b32	v2, s[sgpr_idx], sgpr_idx + lane_offset
+		v_writelane_b32	v2, s[sgpr_idx], ttmp13
+		s_add_u32	ttmp13, ttmp13, 0x1
 	end
-	valu_sgpr_hazard()
-	s_add_u32	ttmp13, ttmp13, 0x10
 end
 
 function write_12sgpr_to_v2(s)
 	// Copy into VGPR for later TCP store.
 	for var sgpr_idx = 0; sgpr_idx < 12; sgpr_idx ++
-		v_writelane_b32	v2, s[sgpr_idx], sgpr_idx
+		v_writelane_b32	v2, s[sgpr_idx], ttmp13
+		s_add_u32	ttmp13, ttmp13, 0x1
 	end
-	valu_sgpr_hazard()
-end
-
-function read_hwreg_from_mem(s, s_rsrc, s_mem_offset)
-	s_buffer_load_dword	s, s_rsrc, s_mem_offset scope:SCOPE_SYS
-	s_add_u32	s_mem_offset, s_mem_offset, 4
-end
-
-function read_16sgpr_from_mem(s, s_rsrc, s_mem_offset)
-	s_sub_u32	s_mem_offset, s_mem_offset, 4*16
-	s_buffer_load_dwordx16	s, s_rsrc, s_mem_offset scope:SCOPE_SYS
-end
-
-function read_8sgpr_from_mem(s, s_rsrc, s_mem_offset)
-	s_sub_u32	s_mem_offset, s_mem_offset, 4*8
-	s_buffer_load_dwordx8	s, s_rsrc, s_mem_offset scope:SCOPE_SYS
-end
-
-function read_4sgpr_from_mem(s, s_rsrc, s_mem_offset)
-	s_sub_u32	s_mem_offset, s_mem_offset, 4*4
-	s_buffer_load_dwordx4	s, s_rsrc, s_mem_offset scope:SCOPE_SYS
 end
 
 function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
@@ -1141,17 +1233,16 @@ L_ENABLE_SHIFT_W64:
 L_SHIFT_DONE:
 end
 
-function get_svgpr_size_bytes(s_svgpr_size_byte)
-	s_getreg_b32	s_svgpr_size_byte, hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)
-	s_lshl_b32	s_svgpr_size_byte, s_svgpr_size_byte, (3+7)
-end
-
 function get_sgpr_size_bytes
 	return 512
 end
 
 function get_hwreg_size_bytes
+#if ASIC_FAMILY >= CHIP_GC_12_0_3
+	return 512
+#else
 	return 128
+#endif
 end
 
 function get_wave_size2(s_reg)
@@ -1159,15 +1250,80 @@ function get_wave_size2(s_reg)
 	s_lshl_b32	s_reg, s_reg, S_WAVE_SIZE
 end
 
-function valu_sgpr_hazard
-#if HAVE_VALU_SGPR_HAZARD
-	for var rep = 0; rep < 8; rep ++
-		ds_nop
-	end
+#if HAVE_XNACK
+function save_and_clear_xnack_state_priv(s_tmp)
+	// Preserve and clear XNACK state before issuing further translations.
+	// Save XNACK_STATE_PRIV.{FIRST_REPLAY, REPLAY_W64H, FXPTR} into ttmp11[22:14].
+	s_andn2_b32	ttmp11, ttmp11, (TTMP11_FIRST_REPLAY_MASK | TTMP11_REPLAY_W64H_MASK | TTMP11_FXPTR_MASK)
+
+	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE)
+	s_lshl_b32	s_tmp, s_tmp, TTMP11_FIRST_REPLAY_SHIFT
+	s_or_b32	ttmp11, ttmp11, s_tmp
+
+	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE)
+	s_lshl_b32	s_tmp, s_tmp, TTMP11_REPLAY_W64H_SHIFT
+	s_or_b32	ttmp11, ttmp11, s_tmp
+
+	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE)
+	s_lshl_b32	s_tmp, s_tmp, TTMP11_FXPTR_SHIFT
+	s_or_b32	ttmp11, ttmp11, s_tmp
+
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV), 0
+end
+
+function restore_xnack_state_priv(s_tmp)
+	s_lshr_b32	s_tmp, ttmp11, TTMP11_FIRST_REPLAY_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE), s_tmp
+
+	s_lshr_b32	s_tmp, ttmp11, TTMP11_REPLAY_W64H_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE), s_tmp
+
+	s_lshr_b32	s_tmp, ttmp11, TTMP11_FXPTR_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE), s_tmp
+end
+#endif
+
+function wait_trap_barriers(s_tmp)
+#if HAVE_CLUSTER_BARRIER
+	// If not in a WG then wave cannot use s_barrier_signal_isfirst.
+	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp0_b32	s_tmp, SQ_WAVE_STATUS_IN_WG_SHIFT
+	s_cbranch_scc1	L_TRAP_CLUSTER_BARRIER_SIGNAL
+
+	s_barrier_signal_isfirst	-2
+	s_barrier_wait	-2
+
+	// Only the first wave in the group signals the trap cluster barrier.
+	s_cbranch_scc0	L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL
+
+L_TRAP_CLUSTER_BARRIER_SIGNAL:
+	s_barrier_signal	-4
+
+L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
+	s_barrier_wait	-4
+#else
+	s_barrier_signal	-2
+	s_barrier_wait	-2
 #endif
 end
 
+
 function restore_sched_mode(s_tmp)
 	s_bfe_u32	s_tmp, ttmp11, (TTMP11_SCHED_MODE_SHIFT | (TTMP11_SCHED_MODE_SIZE << 0x10))
 	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_tmp
+
+function restore_barrier_signal_count(barrier_id)
+	// extract the saved signal count from s_restore_tmp
+	s_lshr_b32	s_restore_tmp, s_restore_tmp, BARRIER_STATE_SIGNAL_OFFSET
+
+	// We need to call s_barrier_signal repeatedly to restore the signal count
+	// of the group/cluster barrier. The member count is already initialized.
+L_BARRIER_RESTORE_LOOP:
+	s_and_b32	s_restore_tmp, s_restore_tmp, s_restore_tmp
+	s_cbranch_scc0	L_BARRIER_RESTORE_DONE
+	s_barrier_signal	barrier_id
+	s_add_i32	s_restore_tmp, s_restore_tmp, -1
+	s_branch	L_BARRIER_RESTORE_LOOP
+
+L_BARRIER_RESTORE_DONE:
 end
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 91fe4832d5ab9..b1972053c44a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -539,11 +539,16 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
-		} else {
+		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(12, 1, 0)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex)
 					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx12_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_hex);
+		} else {
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex)
+					     > KFD_CWSR_TMA_OFFSET);
+			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_hex);
 		}
 
 		kfd->cwsr_enabled = true;
-- 
2.52.0

