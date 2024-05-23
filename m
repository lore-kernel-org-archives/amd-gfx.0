Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AECEC25B79
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 14:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0C710E06D;
	Thu, 23 May 2024 14:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ludok+pu";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CD410E06D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 14:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5R0Kbvkr3Aj36WWQBRs534HVJgXI2oxHZviwMAt5nAHDW6u4MpXsXjy4A0FKV/pkBR7exsa7ZHTQoPXI6Egs4n83XlVLxWiwM7dOoqPZ/I5MgDPDIv1cHeQzrpxF/hPEgURopENvIhb4EaHaNbjIl85wr7TkbIumoS/6xwsRAADLKuXgkzUI4fTv1ubpGuvdPF6oR6sbXCP8QnEL/ycvQ4s3nbVmFPh6QYUtMjt8/8IvzwYqHTP+HZuEYw/1tE+CnTOW0niugTPVjR2t7E+QXAxJhFM8Mh21+meZiEwrm7jza5FYn4u61moT0oHxlB2cyv8jqoC+IP+YMpDGIr7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glsPHV1BiDyvznGsgGJ6aCmyt3PyzEGbaH7X7k28jYA=;
 b=m4F7pjPJeJGWa3sC0dPNNGC3NM0LnUKzgMZ6iTLUJHQ3BluUjv3py09cqGe44lYXRfjS6U+sQcPIBWNhFIdzIE82j34XkaEoQySpHQMBY3f0JMqLwiuaitbw+Koimexv5k/jnmZv3QEbgeC/cWsjCctyepHxmnPp/LCLcRmCkUh6RdBkYRSkkkQBhXz8n/Aqv/aFz1ahnaKPRMOvekI8pRv2l5GHfIe+tRMKacGjyGYxahYRP5G0khPaeAtMKWBxcsK0cOSSLrGVqhKBEP+edaJ/GHMasRwSiTVt/xYL0evIhB0Lht+5gCNK/uJr8TdWzi/fU2OQtAln/LxUBA8OZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glsPHV1BiDyvznGsgGJ6aCmyt3PyzEGbaH7X7k28jYA=;
 b=ludok+puT2Jo6Qq7g1pOJuDlC6tPDnZINgCDf/NHZGHJefkS2zO+eGTOiuZuEwL8+W7nWNkCFL1wPTDVuGcyUoz0hi5v4qGAsi4PrzG2qdFmVg7arLErI84aDsRvGJfFCDJwWjmmaRDISkwNgQbW7hnUwIt++1JqoVoyxaiGOv4=
Received: from CH2PR18CA0006.namprd18.prod.outlook.com (2603:10b6:610:4f::16)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 14:08:32 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::74) by CH2PR18CA0006.outlook.office365.com
 (2603:10b6:610:4f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 14:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 14:08:32 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 09:08:31 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Sync trap handler binary with source
Date: Thu, 23 May 2024 09:08:07 -0500
Message-ID: <20240523140809.1135226-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8664cd-4e1c-42d5-8c34-08dc7b31d42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?exmw9GZlJ+Vbe3dg8CadQbmhvIFixJ3oJVLEyB5LxtN9ZuCGdbLwXU1u+/WS?=
 =?us-ascii?Q?nI49E3hws21PdS8h7qx0NwmgK9ORxbD9WlGklTXVOAlxCW9nIuG+IBGj907V?=
 =?us-ascii?Q?DXoD7US+8W1qZzZAPZabMofypBIy6FrocIV7Fxa9Ca95ShUoHz8HRDqa672F?=
 =?us-ascii?Q?Kly3z/CtjN7DXf5M9udHhC3prGLhoJBWaRk7dJNOdt6qBbU5e4dX1NMPd4ON?=
 =?us-ascii?Q?dArqx1dNDkC9cwNYHxqB7pUhNMS3is3pVDxbdCbFWZPhXWZXpxVnmbTZIgdP?=
 =?us-ascii?Q?4moEU2rc8QhwKqYeqkiE5G279Nf6OtmWYsHTLwCmEiiKiSKVnN8SrP+h8oN7?=
 =?us-ascii?Q?ZKiURxexYTrM5/MOPpACev5XjX6mYIBFhqkVq8N1KUtVPy05Q3hpVNIyEDrf?=
 =?us-ascii?Q?zSb72SaEv0u1ipxMxkOHxknbYrclIoseeTwThqS8q5pUtEfF1vrIJSBUiT0H?=
 =?us-ascii?Q?rYR0ZL9TJufTuZ0ILQCutSMaduzjWZcMnyExrmtzJClQpHyauoMd64emJn1a?=
 =?us-ascii?Q?MVYhac0IWDBqyL9FB1ztIfN/cEmUldvHcQYUd+mDGBNMpAbR7V7ZxMMe8YW4?=
 =?us-ascii?Q?r9UpMLFVqO3ZlEZjhgj5qAvqTYrFJ1h+G2WKNIK+IB9mXW60+tw6veCAOY56?=
 =?us-ascii?Q?p7lG5KZ+hCZkKPnh3MEinJPHUz+b1CEe1JJg1XfEMdgFyVKP+yJS5tqss+ur?=
 =?us-ascii?Q?IcJaXKP9tPXFt8OFTRBJdsZhVpKZoStTnOaop2UKs2ZbD+aBDQM9A1ZRHHA4?=
 =?us-ascii?Q?+huTC3i7Ko4rH3Xx83lpssyA291h8bvHhnSWiqXGi84rz4AENGuPNb2DAWDY?=
 =?us-ascii?Q?gmQBJ8CbP/DLR4jV/rh0h6piybYVySAzhgKH599nTHl5Rj4/Kr43dbelCEC2?=
 =?us-ascii?Q?UsycsokZRAhXlBQin4dI0I71C+YnKlFCEtSwL8Pk8aiaA3SQ7YbWbwYub/aU?=
 =?us-ascii?Q?hlczFxLlzu2UKbRg5CQINo5rezF2RTd9LiW9cILo75pInO/roQn4KqLuDbiQ?=
 =?us-ascii?Q?DIVQnbd8QdkNPTM5Y7KslimeKi+/+FWgfain+lC5hrdmh2GKP5E2l5NgX3jm?=
 =?us-ascii?Q?jLUf77vqmRFoazRRgXsUKlBwAhWUNp6dhK6MNYUuMfLWJPKRhYjU7y2zCIfj?=
 =?us-ascii?Q?gpIEFvSC/qIe92t2JR9Qh9RVmHLx6uL2msP2OQziNQBJwXOzoWFDrXTzwTkM?=
 =?us-ascii?Q?2ubU4jrPJZOPFraYwVKn5Z5laqxNtdCfX7C2Qf/l3k2njzoLM6t7qOYFL6ib?=
 =?us-ascii?Q?Ytt0PRGpomrXyO1+VDcubQviN/A3eI8cXj7e1xRrSsUiiQ7WV1AQuRhCBD00?=
 =?us-ascii?Q?HNw/nYSD/e4EHQ16xwqZ6b5c07SrS9prtf5WWtN3e9VDFpm2p5U8mCq7M0Nr?=
 =?us-ascii?Q?jhzdLM/mlWV9+pnEYvCdFtEU7ozy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:08:32.2446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8664cd-4e1c-42d5-8c34-08dc7b31d42c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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

Source and binary have become mismatched during branch activity.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 57 ++++++++-----------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 73d3772cdb76..11d076eb770c 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -718,12 +718,12 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xf4051ebd, 0xfa000008,
 	0xbf8cc07f, 0x87ee6e6e,
 	0xbf840001, 0xbe80206e,
-	0x876eff6d, 0x01ff0000,
-	0xbf850005, 0x8878ff78,
-	0x00002000, 0x80ec886c,
-	0x82ed806d, 0xbf820005,
-	0x876eff6d, 0x01000000,
-	0xbf850002, 0x806c846c,
+	0x876eff6d, 0x00ff0000,
+	0xbf850008, 0x876eff6d,
+	0x01000000, 0xbf850007,
+	0x8878ff78, 0x00002000,
+	0x80ec886c, 0x82ed806d,
+	0xbf820002, 0x806c846c,
 	0x826d806d, 0x876dff6d,
 	0x0000ffff, 0x907a8977,
 	0x877bff7a, 0x003f8000,
@@ -1136,7 +1136,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xe0704000, 0x705d0000,
 	0x807c817c, 0x8070ff70,
 	0x00000080, 0xbf0a7b7c,
-	0xbf85fff8, 0xbf820144,
+	0xbf85fff8, 0xbf82013e,
 	0xbef4037e, 0x8775ff7f,
 	0x0000ffff, 0x8875ff75,
 	0x00040000, 0xbef60380,
@@ -1276,10 +1276,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x80788478, 0xbf8cc07f,
 	0xb9eef815, 0xbefc036f,
 	0xbefe0370, 0xbeff0371,
-	0x876f7bff, 0x000003ff,
-	0xb9ef4803, 0xb9f9f816,
-	0x876f7bff, 0xfffff800,
-	0x906f8b6f, 0xb9efa2c3,
+	0xb9f9f816, 0xb9fbf803,
 	0xb9f3f801, 0xb96e3a05,
 	0x806e816e, 0xbf0d9972,
 	0xbf850002, 0x8f6e896e,
@@ -2309,12 +2306,12 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xf4051ebd, 0xfa000008,
 	0xbf8cc07f, 0x87ee6e6e,
 	0xbf840001, 0xbe80206e,
-	0x876eff6d, 0x01ff0000,
-	0xbf850005, 0x8878ff78,
-	0x00002000, 0x80ec886c,
-	0x82ed806d, 0xbf820005,
-	0x876eff6d, 0x01000000,
-	0xbf850002, 0x806c846c,
+	0x876eff6d, 0x00ff0000,
+	0xbf850008, 0x876eff6d,
+	0x01000000, 0xbf850007,
+	0x8878ff78, 0x00002000,
+	0x80ec886c, 0x82ed806d,
+	0xbf820002, 0x806c846c,
 	0x826d806d, 0x876dff6d,
 	0x0000ffff, 0x87fe7e7e,
 	0x87ea6a6a, 0xb9f8f802,
@@ -2549,7 +2546,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x705d0000, 0x807c817c,
 	0x8070ff70, 0x00000080,
 	0xbf0a7b7c, 0xbf85fff8,
-	0xbf82013b, 0xbef4037e,
+	0xbf820135, 0xbef4037e,
 	0x8775ff7f, 0x0000ffff,
 	0x8875ff75, 0x00040000,
 	0xbef60380, 0xbef703ff,
@@ -2688,10 +2685,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xf0000000, 0x80788478,
 	0xbf8cc07f, 0xb9eef815,
 	0xbefc036f, 0xbefe0370,
-	0xbeff0371, 0x876f7bff,
-	0x000003ff, 0xb9ef4803,
-	0x876f7bff, 0xfffff800,
-	0x906f8b6f, 0xb9efa2c3,
+	0xbeff0371, 0xb9fbf803,
 	0xb9f3f801, 0xb96e3a05,
 	0x806e816e, 0xbf0d9972,
 	0xbf850002, 0x8f6e896e,
@@ -2749,11 +2743,11 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0xf8000008, 0xbf89fc07,
 	0x8bee6e6e, 0xbfa10001,
 	0xbe80486e, 0x8b6eff6d,
-	0x01ff0000, 0xbfa20005,
-	0x8c78ff78, 0x00002000,
-	0x80ec886c, 0x82ed806d,
-	0xbfa00005, 0x8b6eff6d,
-	0x01000000, 0xbfa20002,
+	0x00ff0000, 0xbfa20008,
+	0x8b6eff6d, 0x01000000,
+	0xbfa20007, 0x8c78ff78,
+	0x00002000, 0x80ec886c,
+	0x82ed806d, 0xbfa00002,
 	0x806c846c, 0x826d806d,
 	0x8b6dff6d, 0x0000ffff,
 	0x8bfe7e7e, 0x8bea6a6a,
@@ -2988,7 +2982,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0x701d0000, 0x807d817d,
 	0x8070ff70, 0x00000080,
 	0xbf0a7b7d, 0xbfa2fff8,
-	0xbfa00146, 0xbef4007e,
+	0xbfa00140, 0xbef4007e,
 	0x8b75ff7f, 0x0000ffff,
 	0x8c75ff75, 0x00040000,
 	0xbef60080, 0xbef700ff,
@@ -3130,10 +3124,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0xf0000000, 0x80788478,
 	0xbf89fc07, 0xb96ef815,
 	0xbefd006f, 0xbefe0070,
-	0xbeff0071, 0x8b6f7bff,
-	0x000003ff, 0xb96f4803,
-	0x8b6f7bff, 0xfffff800,
-	0x856f8b6f, 0xb96fa2c3,
+	0xbeff0071, 0xb97bf803,
 	0xb973f801, 0xb8ee3b05,
 	0x806e816e, 0xbf0d9972,
 	0xbfa20002, 0x846e896e,
@@ -4119,7 +4110,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x8b6dff6d, 0x0000ffff,
 	0x8bfe7e7e, 0x8bea6a6a,
 	0xb97af804, 0xbe804a6c,
-	0xbfb00000, 0xbf9f0000,
+	0xbfb10000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 };
-- 
2.34.1

