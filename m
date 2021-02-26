Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5E264EDC
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5E264EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A851D6E455;
	Fri, 26 Feb 2021 22:46:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5776E455
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpIMoxCGQGeuIDcWmqd2m5+zRUwcShNb/qDmlQw8TzdI2zVqzLUhCNZoMxxyC+wffnqjzugfptep2uJ76dR8UwWVT1tYvj8zb9r7tBxqpejWLd6m5g+37+33DdzeawCVq6TOHMEWFrabVH6hcw9hsMLF9Ejoy0A0tAK4BFk+3CYvlI1OBmILB3p5LxzKyq/7czQohEPiLdaZcOqJ3Gc8FogvWvlFiP0uYSOP0Ke9OKs00/ZIO1GeO0cwsu4CDLN2ZcqeiV2RGHuhU2PY5pU59mRacfth/sQm5+SjHgaqYAsMkU+7GX1PLwBP6dbay8mOIDpNpXvRIeit7vR3cB3sSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhSM8OV4NCqPZ8bV4klLMC3NXd+O9P2nQBM6Zrh9kR4=;
 b=NQW42mfxvBc4E3i/+y7LnG3F66xlqTsBRt6glRI22M65OIZYQRgoTlBkJ9iUYCSu/or54lzHKB3jrQ+kpYxWnw2cpfzRNs/HBlgGlGpI9UPzaH5fwwfn08SUTriKRl67vngNvyIy2snN9JCFhbRQBmVPnBdTQc/RPrzrivJeJ47W26jd1REKTzJjolEU3xNMeNaMLGcMGJ7tp0WKx8zkDmnpOQyyxJzrcGE9DrEm6KU+0mtwh0FSgA6s8uGgWoyRKfHaJyMhu6J5LFi42xupPGW6fE/sfPxLYigS9NmLcA34oBurs1j7bvkRygJKQp6X4OCnMRZcwz1G9z3khkeQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhSM8OV4NCqPZ8bV4klLMC3NXd+O9P2nQBM6Zrh9kR4=;
 b=RERFfFWCPFeI8ZZwlzAZW7Q4naBuhkrQlJf3UV5uJF+2tHA6OHZ/pWfevqC8sFjaL9Y4g0IvcE5jjn0SPSW3Ek7iOIuNGhI/k/fYiAzMNRzv5uTgGTGVEy0hr/G32TLZeGMSjVpGuUzybtp5RJi1suO1tYY/Mp5Dm5ZIzRnf6jc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4754.namprd12.prod.outlook.com (2603:10b6:208:8e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 22:46:08 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.030; Fri, 26 Feb 2021
 22:46:08 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Use a new capability bit for SRAM ECC
Date: Fri, 26 Feb 2021 17:45:34 -0500
Message-Id: <20210226224534.14377-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::19) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30 via Frontend Transport; Fri, 26 Feb 2021 22:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 630e11ab-f6e6-479b-2461-08d8daa84ee0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4754:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4754C40BB660B5B069DA7853929D9@BL0PR12MB4754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLN7Oa32tKkU+GP/doNzHIf8XEWMOZAnxM5RD2TTDMWRYnXcBkhOxo2iEzKyOPASZYSqlY0OVuDWPp7y6RkflXuSXcH1MLjp/U/4mTyebA1DQoYYc9PJu6KkRUOuGrWQS3GDhjNYrmsM/ak+66szCReryUpLa1N4sHTPjdfb+OeJkK6DNhUd57dvKvPCa0YkvCYuihBoYEvECqJX5hML1cBIApQWNW8XWQoLvKiAr4ziK9JvM7LEMZHudc5Dg65awkHT/Hilt+U1GonZVsPMSWaQsXDbHJ4h9iEncjQ8gNTjb57VG8vHJYLiqEKbfSlo7Yrz137o3uuVuTLYcB4pn5QD465fiUuw1DkEsnelJCNOl76UPfVF6PmTJgWsM1LS+g5oZOAIJYyjb6Myhy394+jdHWLcHf2S0iVyKYVUbXeCH44xgfXo+nt59iZu82K4ICmlPvUWvhA+wSe+46usosNLKt+5jp8iI/LckxkcYvJyogNg9ScW6AdTE5KfuLN57MFYlwyrhXDVDfC9UPQTiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(83380400001)(2616005)(956004)(6486002)(316002)(2906002)(16526019)(8676002)(66556008)(66476007)(66946007)(186003)(86362001)(478600001)(26005)(8936002)(36756003)(6916009)(1076003)(7696005)(6666004)(52116002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?daZ3tDdNjpTB/bQnHFNzqFdgfjL1SnMxqpwZOiek19nrX+xEWuoxo/t4j2V7?=
 =?us-ascii?Q?QIPjc7aH4yxIWzUHGmEEOxiPKScD4Z9w7SeOr+QchsfLiV0pS/VL1EU9WcUv?=
 =?us-ascii?Q?kysqR9hlb4sgoSQKy5YiiCTaozbemNylCpnC8ZxR2YHkoEjRPkb5uLSROXKu?=
 =?us-ascii?Q?vBoZZldX98+7hl0jPz59ubmkAIa+mMHdi13kdpbWrIeiHyzt3Qs5826F3Q7b?=
 =?us-ascii?Q?mDxZkRjnHxojUFrYQRckH1bqn+Q+ST0yGYX1CJfjoVdNYZM0fEdWhR7/0o2A?=
 =?us-ascii?Q?EacbbvdIN4TKFdfx6IHqYRAZvf9gQxSHJtV08MPgQoiVEB5AHPIhcg/nq4IK?=
 =?us-ascii?Q?0ObcyJNNuapO1+Q2an1UL75HUNmBp6NiWRbb0YPZxUx67vHTLrklp0ZYpZ7t?=
 =?us-ascii?Q?PYyJNScEa821Epyt5F1A4FQPU+DfZJlEtqRkEDvzffC3uVLm0GDbkipOBCje?=
 =?us-ascii?Q?xHSMR9hU0nDouFf8SABugIU1mkLSDUYpaR6jTDOYu9bCGt72aHE8etAI6nzT?=
 =?us-ascii?Q?Vn5JD5bVnuxPQobsReE5n4o5fXEYZ6IKGZmJTsnwCRlPJa0p9FUdnO6adixx?=
 =?us-ascii?Q?+6zFALRx2BGgQectSRbX61EZsY1YSvEpbSbvb/w7JZzmlQg9MncEJW2XUUWz?=
 =?us-ascii?Q?9T0t9Tj1EAnQpYykKMu0MKkcS4y6XuTXftesOicK0NPZWWN/MglT8Ob9LiiJ?=
 =?us-ascii?Q?kn3RCXBtqA5CR5cSyiTuLRYu7lXyjvho5XHbOH3vCeSAKQ9xC6k3VqH3GHtx?=
 =?us-ascii?Q?muT87z2AyBAU/y9f4yaaKU4wRwN9zy2pCnevefcdYmqd+EHhta+iIre5Vx8h?=
 =?us-ascii?Q?SsBHvwS1932kOsfe98tb2MiCs0o9DUoBVDuxVvD/53weLhyc3jQWBan+gbIz?=
 =?us-ascii?Q?r7rCjDCzoNaw4SHihE9fqMA9lALDxS8BblWvP3MXvzo82mckkdHNMbt9a4yb?=
 =?us-ascii?Q?You1VTl1KlVCP2D1HVDDnrq2P9EUO8PmfHBu9449yDmSnzyKyvTborJgD9bU?=
 =?us-ascii?Q?L7+DnlBwZz2suTxOSxOfENCAn+susItH9Hgpv+yCHg1bvn8gsNQLU9Sf3N7K?=
 =?us-ascii?Q?dEKxW2ob+W6FtRqZBD6Cz5blZC0D1YANuia6vApoW/Ko6lLGGl/BvFVo6tHA?=
 =?us-ascii?Q?f/tPcoe+T6lNOy8tJRkcwJvBVjfPCzsoCumeIH/vHoHE3RP3uJjJ4izUyM0a?=
 =?us-ascii?Q?5z1sjL3Zb5pWPbh3tM/2F7vXfrcOnZwk7jUr3rATs/HSySEH5m/lWoqpgYIm?=
 =?us-ascii?Q?KQnIOoPkDZiFmpolszATnbwmaGsIuK7lKGBolVcjpQ9X0LyKOfjgv0H0Cf5+?=
 =?us-ascii?Q?qA5OzEx/TEjrBw7hXDoMsxhk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630e11ab-f6e6-479b-2461-08d8daa84ee0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:46:08.6494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBvU4iKjm4XWpMYUX+QRJX7P0GS+eX8dceAH7u8SEwZiHshAXPIePKFe2yRZDyuKnQ4wh1AJDtOM9bogBpZPNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4754
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Existing, buggy user mode breaks when SRAM ECC is correctly reported as
"enabled". To avoid breaking existing user mode, deprecate that bit and
leave it as 0. Define a new bit to report the actual SRAM ECC mode that
new, correct user mode can use in the future.

Fixes: 7ec177bdcfc1 ("drm/amdkfd: fix set kfd node ras properties value")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 416fd910e12e..b8b68087bd7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -47,13 +47,14 @@
 #define HSA_CAP_DOORBELL_TYPE_2_0		0x2
 #define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
 
-#define HSA_CAP_SRAM_EDCSUPPORTED		0x00080000
+#define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000 /* Old buggy user mode depends on this being 0 */
 #define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
 #define HSA_CAP_RASEVENTNOTIFY			0x00200000
 #define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
 #define HSA_CAP_ASIC_REVISION_SHIFT		22
+#define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
 
-#define HSA_CAP_RESERVED			0xfc078000
+#define HSA_CAP_RESERVED			0xf80f8000
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
