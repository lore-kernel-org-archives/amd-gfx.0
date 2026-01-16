Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9A8C98301
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 20:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A5810E936;
	Fri, 16 Jan 2026 20:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xp/RfCZ/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7864B10E935
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 20:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSmbcCVifMikrq7yO2ccaxQ5eRXqqUrQAN9i2dUQLs69eF2VNd/P7gQGkqMZeeByHWRIzKaBt16PMOJsbOg3ifILLPJGDZrp28lvFL30as9b0WH4/ZEwbeAaFhcKpo4kc8nD4XUM3o1H+/2gP9XA2mqsUfcI7fqOUFAFCbVPKtWm22WgRUa9ojcLwY05jTfLcHO6Ya844Q04wDR6xclbaCeEVIWLceNL+0VbqaqWucHIe5yDX8Uj9829Jul4SxWhjoBQfqfJ2gENY64QtkBYcWI58eF2hJbD5HoYOPrGQqSWY7g4cs1S0GC0JKThLxVXUvpwqIVsbXp4DzHUEbTCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kmZ2sIZdsEhsAypyEdGCc2+taZrICCxaq+PmBjf/po=;
 b=sbgXCwX4NBImeOSdCudMHnrdfcp+BiOW7ZyX1Z7pX0tPkfkZkxz9WO5kBDS9cYc3Wii51wLqY3q3M+vxjMxsOnwJUXtansbw2r6E3zuZiKzWVDTRcWI0xKpTg6fNzqywVs2DB43e6hXiSgqhig/xB+tghH8G8soeORxXpBpBnTnObon2Phq5A2G1mAD1fjUMEqT985xwil3AGjwt34qWYqnulDIFeiPA6rb5lSUfVP+wPT2/EeyaCBXJyVVjk23LjFvVBFz+wx5M/C6GRb2OaiFFn4vEnankFaHxtnou07sV+RuBZA9KxJCL2Wf8I+lokxjNRFKdiXOe/gCG4uywwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kmZ2sIZdsEhsAypyEdGCc2+taZrICCxaq+PmBjf/po=;
 b=xp/RfCZ/8Na7Wiry2ioO/qfBitdWEYczj2gxsDuBkGWrqHpmOVWqDnReoqrIRgdCft6tYKDXj993FYKTi5N0G7YTpEECg3MBZ+fWEs30vOYXUfcWZFrjTg3j5mnbgGIzqaBa8IEeKbpv5E7RS5f+0cO0sw9I6SgIecB1lAy5ZO4=
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 20:40:19 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::7b) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 20:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 20:40:18 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 14:40:17 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 Vladimir Indic <vladimir.indic@amd.com>
Subject: [PATCH 4/5] drm/amdkfd: gfx12.1 trap handler support for expert
 scheduling mode
Date: Fri, 16 Jan 2026 14:39:31 -0600
Message-ID: <20260116203932.988704-5-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116203932.988704-1-jay.cornwall@amd.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 9283e3dd-1891-4ae8-4c12-08de553f7647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zBAWIE2VX1/s5rFRn5xw3ya+48kRFSPRY3kq7RXnlnp4tyDFJBePSx2Xs7iI?=
 =?us-ascii?Q?cYDpjRfYNtXjMqjxNDUVOPbi6IaV52eB/blof7xZufYgJ5A14tGF2/XzONqL?=
 =?us-ascii?Q?mIuG6ZHJnhi67fAAmPPdUW5b2HC3gdKjINy3k2rwyLAheqDQa0merusX0X/I?=
 =?us-ascii?Q?12dOa0FgN9hqAmulzhDEnF1GFPCQ+w1f3gIZQasgD9M/4HnTGnvklLD6pnB3?=
 =?us-ascii?Q?SDxPN0kTjBUn6Gw+JtH3Pn7wFCHxgN1dXII3U00G/w8fBhSok8zDtekLfOYN?=
 =?us-ascii?Q?CXFC9fSyskUXbSI3QPmzO5hF4r2H4xOAizrgrEC7evvfXu6QlZUMjcUpQICl?=
 =?us-ascii?Q?F1MgNy6Hq0CAgfHEAIcE4B5qE+jjvQjSEzGmB8EzFe6IFKUwjuf0slacxJl5?=
 =?us-ascii?Q?X7yeFy0nIg5aVXPZD6XpaeOVH2ndhei9noqXyDtFtuja6vSp5pHblnA94Rai?=
 =?us-ascii?Q?zZMB7pl8Vxn2NasL26xjR5gvEl0LT/JbmX+59SE67NaikkFwlTa1M7in6vkI?=
 =?us-ascii?Q?TFheMenpeY8uUFImD890aAUIPSQTu+ohOAvQt0U1Shm9lSqNZyncyJkLkBW0?=
 =?us-ascii?Q?irgtoCca9CoTg8yUIsj9FVtAu3Em1q+8KE09ZrtdrQ8oKzvvGjNBCpria50F?=
 =?us-ascii?Q?LGKiPuwW2IIuYTHANRN5JrAkgQ5p7nj7Ndj0ONpnAIUoHJc/iRCgUrUsVYmV?=
 =?us-ascii?Q?yngZBZdxJw5JTeNMk8O6OTcr6JhWgZKierjz0e9+J7eq0+tMUZnjwT/KcJJW?=
 =?us-ascii?Q?5xOYLg6JaZK4H/xEW+IWjMY3L9gpJuZypHTjh6odsbVxJ7RNIhpWivAbf/bA?=
 =?us-ascii?Q?Nl4pGfkwI1c2J4Z+wNb4/kdlHsvQHhJaOV2e1Nz7PIshg8SBQ0rjQCjChi6V?=
 =?us-ascii?Q?x0SmXRFwTagPYWmkNw/7y0iSdCE8E8l9oE+UFX0qPm8uB6qrRmeBqX8zV9hY?=
 =?us-ascii?Q?6eiPd7+g4Xh+Ax5kvhwyDXKlPvuZELHzoM1C/JDlrZR6daCGXZWL1FOcljNA?=
 =?us-ascii?Q?zm4Y7c0tvClC85/C2x3BAWmEq2Er9Goq4Ji3NjoEv9QTYXcM9BL70VnGuQ/1?=
 =?us-ascii?Q?2BO0UFM5NN2Lhppwd+MAdmQfH1wo1EmrFnWN1gdTCjH9h9ahRMdAvnFGKdxj?=
 =?us-ascii?Q?B32htqjoUOR3xHJpChTtUiAyDzgRCCFdVa/JBSQJgbF0+Jj0eYB5FGwBtaep?=
 =?us-ascii?Q?r+dJU3uZ1ASLMcVtPMPE3RF16/mSaKlmftMUan7gC5ZQEuoFDB/l49DSWMQj?=
 =?us-ascii?Q?sPCQG92Kuu6KK3Mi7s+Lw84kfaDu8rW5ka7ZU2+Izf19pTE+SuFU89WbguIY?=
 =?us-ascii?Q?ZbzKzgd4Yw5h18RQlwmE2SLL6BbKHrsI3seu3v/7+FQEaUFmpCg1ArLlVh9r?=
 =?us-ascii?Q?Oa3o/2P5YBCkidmBbEknu2bi1dVNV8p8fOB8OTeEoPjQoBmMzdgsNiqN6p+p?=
 =?us-ascii?Q?2pW7sF0uaXVSpiQYpFzIAe93NBzrtS4tuPPjm1hdzgkL0WX8fffrvqheQCQY?=
 =?us-ascii?Q?aMCcpEd6UNIn47en0UH5ejPNn216OmgGQ+b2VAOdSwT4zUU4ompnhDjxFoi+?=
 =?us-ascii?Q?T8AmgRw1e6B0u0JqepSSWZhPO1IkD7/zK+l187TiWn9/2zeX9rOHny+ADywq?=
 =?us-ascii?Q?H1A+GVKNoWieuyFnzz/EVVQ+wMJqRw0Sx9zCj/j/rQ67eXGp0P/1nF8XDRM7?=
 =?us-ascii?Q?MH4wQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 20:40:18.8433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9283e3dd-1891-4ae8-4c12-08de553f7647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
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

- Leave DEP_MODE unchanged as it is ignored in the trap handler
- Save/restore SCHED_MODE (gfx12.0 saves in ttmp11)

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 372 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  32 +-
 2 files changed, 214 insertions(+), 190 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index d86bccc49e3f..9bb7fb6a83ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4587,18 +4587,14 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
-	0xbfa00001, 0xbfa003b4,
-	0xb0804009, 0xb8eef81a,
-	0xbf880000, 0xb980081a,
-	0x00000000, 0xb8f8f804,
-	0x9177ff77, 0x0c000000,
-	0x846e9a6e, 0x8c776e77,
+	0xbfa00001, 0xbfa003ac,
+	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
 	0x00004000, 0xbfa10008,
 	0x8b6eff7b, 0x00000080,
 	0xbfa20018, 0x8b6ea07b,
-	0xbfa200d4, 0xbf830010,
+	0xbfa200d1, 0xbf830010,
 	0xb8fbf811, 0xbfa0fffb,
 	0x8b6eff7b, 0x00000bd0,
 	0xbfa20010, 0xb8eef812,
@@ -4609,7 +4605,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xf0000000, 0xbfa20005,
 	0x8b6fff6f, 0x00000200,
 	0xbfa20002, 0x8b6ea07b,
-	0xbfa200be, 0x9177ff77,
+	0xbfa200bb, 0x9177ff77,
 	0x007fc000, 0xb8fa04a1,
 	0x847a967a, 0x8c777a77,
 	0xb8fa0421, 0x847a957a,
@@ -4702,189 +4698,189 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xb97a0421, 0x857a8e77,
 	0xb97a3021, 0x8bfe7e7e,
 	0x8bea6a6a, 0x85788978,
-	0x936eff77, 0x0002001a,
-	0xb96ef81a, 0xb9783244,
-	0xbe804a6c, 0xb8faf802,
-	0xbf0d987a, 0xbfa10001,
-	0xbfb00000, 0x8b6dff6d,
-	0x01ffffff, 0xbefa0080,
-	0xb97a0151, 0x9177ff77,
-	0x007fc000, 0xb8fa04a1,
-	0x847a967a, 0x8c777a77,
-	0xb8fa0421, 0x847a957a,
-	0x8c777a77, 0xb8fa3021,
-	0x847a8e7a, 0x8c777a77,
-	0xb980f821, 0x00000000,
-	0xbf0d847b, 0xbfa20078,
-	0xf4003eb6, 0xf8000000,
-	0xbfc70000, 0xf4003bb6,
-	0xf8000008, 0x8b76ff7a,
-	0x80000000, 0xbfa20027,
-	0x9376ff7a, 0x00060019,
-	0x81f9a376, 0xbf0b8179,
-	0xbfa20068, 0x81f9ac76,
-	0xbf0b8179, 0xbfa20062,
-	0x81f9b776, 0xbf0b8179,
-	0xbfa2005f, 0x8b76ff7a,
-	0x000001ff, 0xbf06ff76,
-	0x000000fe, 0xbfa2005d,
-	0xbf06ff76, 0x000000ff,
-	0xbfa20057, 0xbf06ff76,
-	0x000000fa, 0xbfa20054,
-	0x81f9ff76, 0x000000e9,
-	0xbf0b8179, 0xbfa20050,
-	0x8b76ff7b, 0xffff0000,
-	0xbf06ff76, 0xbf860000,
-	0xbfa10051, 0x9376ff7b,
-	0x0002000e, 0x8b79ff7b,
-	0x00003f00, 0x85798679,
-	0x8c767976, 0xb9763b01,
-	0xbfa00049, 0x8b76ff7a,
-	0xfc000000, 0xbf06ff76,
-	0xd4000000, 0xbfa20013,
-	0xbf06ff76, 0xc8000000,
-	0xbfa20027, 0x8b76ff7a,
-	0xff000000, 0xbf06ff76,
-	0xcf000000, 0xbfa20039,
-	0x8b79ff7a, 0xffff0000,
-	0xbf06ff79, 0xcc350000,
-	0xbfa20037, 0xbf06ff79,
-	0xcc3a0000, 0xbfa20034,
-	0xbf06ff76, 0xcc000000,
-	0xbfa10031, 0x8b76ff7b,
-	0x000001ff, 0xbf06ff76,
-	0x000000ff, 0xbfa20029,
-	0xbf06ff76, 0x000000fa,
-	0xbfa20026, 0x81f6ff76,
-	0x000000e9, 0xbf0b8176,
-	0xbfa20022, 0x8b76ff7b,
-	0x0003fe00, 0xbf06ff76,
-	0x0001fe00, 0xbfa2001d,
-	0x8b76ff7b, 0x07fc0000,
-	0xbf06ff76, 0x03fc0000,
-	0xbfa20018, 0xbfa00014,
-	0x9376ff7a, 0x00040016,
-	0x81f68176, 0xbf0b8176,
-	0xbfa20012, 0x9376ff7a,
-	0x00050011, 0x81f68176,
-	0xbf0b8176, 0xbfa2000d,
+	0xb9783244, 0xbe804a6c,
+	0xb8faf802, 0xbf0d987a,
+	0xbfa10001, 0xbfb00000,
+	0x8b6dff6d, 0x01ffffff,
+	0xbefa0080, 0xb97a0151,
+	0x9177ff77, 0x007fc000,
+	0xb8fa04a1, 0x847a967a,
+	0x8c777a77, 0xb8fa0421,
+	0x847a957a, 0x8c777a77,
+	0xb8fa3021, 0x847a8e7a,
+	0x8c777a77, 0xb980f821,
+	0x00000000, 0xbf0d847b,
+	0xbfa20078, 0xf4003eb6,
+	0xf8000000, 0xbfc70000,
+	0xf4003bb6, 0xf8000008,
+	0x8b76ff7a, 0x80000000,
+	0xbfa20027, 0x9376ff7a,
+	0x00060019, 0x81f9a376,
+	0xbf0b8179, 0xbfa20068,
+	0x81f9ac76, 0xbf0b8179,
+	0xbfa20062, 0x81f9b776,
+	0xbf0b8179, 0xbfa2005f,
 	0x8b76ff7a, 0x000001ff,
+	0xbf06ff76, 0x000000fe,
+	0xbfa2005d, 0xbf06ff76,
+	0x000000ff, 0xbfa20057,
+	0xbf06ff76, 0x000000fa,
+	0xbfa20054, 0x81f9ff76,
+	0x000000e9, 0xbf0b8179,
+	0xbfa20050, 0x8b76ff7b,
+	0xffff0000, 0xbf06ff76,
+	0xbf860000, 0xbfa10051,
+	0x9376ff7b, 0x0002000e,
+	0x8b79ff7b, 0x00003f00,
+	0x85798679, 0x8c767976,
+	0xb9763b01, 0xbfa00049,
+	0x8b76ff7a, 0xfc000000,
+	0xbf06ff76, 0xd4000000,
+	0xbfa20013, 0xbf06ff76,
+	0xc8000000, 0xbfa20027,
+	0x8b76ff7a, 0xff000000,
+	0xbf06ff76, 0xcf000000,
+	0xbfa20039, 0x8b79ff7a,
+	0xffff0000, 0xbf06ff79,
+	0xcc350000, 0xbfa20037,
+	0xbf06ff79, 0xcc3a0000,
+	0xbfa20034, 0xbf06ff76,
+	0xcc000000, 0xbfa10031,
+	0x8b76ff7b, 0x000001ff,
 	0xbf06ff76, 0x000000ff,
-	0xbfa20008, 0x8b76ff7b,
+	0xbfa20029, 0xbf06ff76,
+	0x000000fa, 0xbfa20026,
+	0x81f6ff76, 0x000000e9,
+	0xbf0b8176, 0xbfa20022,
+	0x8b76ff7b, 0x0003fe00,
+	0xbf06ff76, 0x0001fe00,
+	0xbfa2001d, 0x8b76ff7b,
+	0x07fc0000, 0xbf06ff76,
+	0x03fc0000, 0xbfa20018,
+	0xbfa00014, 0x9376ff7a,
+	0x00040016, 0x81f68176,
+	0xbf0b8176, 0xbfa20012,
+	0x9376ff7a, 0x00050011,
+	0x81f68176, 0xbf0b8176,
+	0xbfa2000d, 0x8b76ff7a,
 	0x000001ff, 0xbf06ff76,
-	0x000000ff, 0xbfa20003,
-	0xbfc70000, 0xbefb006e,
-	0xbfa0ffad, 0xbfc70000,
-	0xbefb006f, 0xbfa0ffaa,
-	0xbfc70000, 0xbeee007e,
-	0xbeef007f, 0xbefe0180,
-	0xbefe4d84, 0xbf8a0000,
-	0x8b7aff7f, 0x04000000,
-	0x847a857a, 0x8c6d7a6d,
-	0xb8eff822, 0xb980f822,
-	0x00000000, 0xb8fa2b01,
-	0x847a997a, 0x8c6d7a6d,
-	0xbefa0080, 0xb97a2b01,
-	0xbefa007e, 0x8b7bff7f,
-	0x01ffffff, 0xbefe00c1,
-	0xbeff00c1, 0xee0a407a,
-	0x000c0000, 0x00000000,
-	0x7e000280, 0xbefe007a,
-	0xbeff007b, 0xb8fb0742,
-	0x847b997b, 0xb8fa3b05,
-	0x807a817a, 0xbf0d997b,
-	0xbfa20002, 0x847a897a,
-	0xbfa00001, 0x847a8a7a,
+	0x000000ff, 0xbfa20008,
+	0x8b76ff7b, 0x000001ff,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20003, 0xbfc70000,
+	0xbefb006e, 0xbfa0ffad,
+	0xbfc70000, 0xbefb006f,
+	0xbfa0ffaa, 0xbfc70000,
+	0xbeee007e, 0xbeef007f,
+	0xbefe0180, 0xbefe4d84,
+	0xbf8a0000, 0x8b7aff7f,
+	0x04000000, 0x847a857a,
+	0x8c6d7a6d, 0xb8eff822,
+	0xb980f822, 0x00000000,
+	0xb8fa2b01, 0x847a997a,
+	0x8c6d7a6d, 0xbefa0080,
+	0xb97a2b01, 0xbefa007e,
 	0x8b7bff7f, 0x01ffffff,
-	0x807aff7a, 0x000001c0,
-	0x807a7e7a, 0x827b807b,
-	0xd7610000, 0x00010870,
-	0xd7610000, 0x00010a71,
-	0xd7610000, 0x00010c72,
-	0xd7610000, 0x00010e73,
-	0xd7610000, 0x00011074,
-	0xd7610000, 0x00011275,
-	0xd7610000, 0x00011476,
-	0xd7610000, 0x00011677,
-	0xd7610000, 0x00011a79,
-	0xd7610000, 0x00011c7e,
-	0xd7610000, 0x00011e7f,
-	0xbefe00ff, 0x00003fff,
-	0xbeff0080, 0xee0a407a,
-	0x000c0000, 0x00000000,
-	0xd760007a, 0x00011d00,
-	0xd760007b, 0x00011f00,
+	0xbefe00c1, 0xbeff00c1,
+	0xee0a407a, 0x000c0000,
+	0x00000000, 0x7e000280,
 	0xbefe007a, 0xbeff007b,
-	0xbef4007e, 0x8b75ff7f,
-	0x01ffffff, 0xbef1007d,
-	0xb8f30742, 0x84739973,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00002, 0xbeff00c1,
-	0xbfa0000a, 0xee0a4074,
-	0x008c0000, 0x00008000,
-	0xee0a4074, 0x010c0000,
+	0xb8fb0742, 0x847b997b,
+	0xb8fa3b05, 0x807a817a,
+	0xbf0d997b, 0xbfa20002,
+	0x847a897a, 0xbfa00001,
+	0x847a8a7a, 0x8b7bff7f,
+	0x01ffffff, 0x807aff7a,
+	0x000001c0, 0x807a7e7a,
+	0x827b807b, 0xd7610000,
+	0x00010870, 0xd7610000,
+	0x00010a71, 0xd7610000,
+	0x00010c72, 0xd7610000,
+	0x00010e73, 0xd7610000,
+	0x00011074, 0xd7610000,
+	0x00011275, 0xd7610000,
+	0x00011476, 0xd7610000,
+	0x00011677, 0xd7610000,
+	0x00011a79, 0xd7610000,
+	0x00011c7e, 0xd7610000,
+	0x00011e7f, 0xbefe00ff,
+	0x00003fff, 0xbeff0080,
+	0xee0a407a, 0x000c0000,
+	0x00000000, 0xd760007a,
+	0x00011d00, 0xd760007b,
+	0x00011f00, 0xbefe007a,
+	0xbeff007b, 0xbef4007e,
+	0x8b75ff7f, 0x01ffffff,
+	0xbef1007d, 0xb8f30742,
+	0x84739973, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00002,
+	0xbeff00c1, 0xbfa0000a,
+	0xee0a4074, 0x008c0000,
+	0x00008000, 0xee0a4074,
+	0x010c0000, 0x00010000,
+	0xee0a4074, 0x018c0000,
+	0x00018000, 0xbfa00009,
+	0xee0a4074, 0x008c0000,
 	0x00010000, 0xee0a4074,
-	0x018c0000, 0x00018000,
-	0xbfa00009, 0xee0a4074,
-	0x008c0000, 0x00010000,
-	0xee0a4074, 0x010c0000,
-	0x00020000, 0xee0a4074,
-	0x018c0000, 0x00030000,
-	0xb8f03b05, 0x80708170,
-	0xbf0d9973, 0xbfa20002,
-	0x84708970, 0xbfa00001,
-	0x84708a70, 0x8070ff70,
-	0x00000200, 0x7e000280,
-	0x7e020280, 0x7e040280,
-	0xbefd0080, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8faf802, 0xbf0c8b7a,
-	0xbfa20003, 0xbe804fc2,
-	0xbf94fffe, 0xbfa10001,
-	0xbe804ec4, 0xbf94fffc,
-	0xbefa4c88, 0xbfc70000,
-	0xbf0c807a, 0xbfa20006,
-	0x9371ff7a, 0x00070004,
-	0x937aff7a, 0x00070010,
-	0xbf06717a, 0xbfa2fff6,
-	0xb8faf804, 0x8b7aff7a,
-	0x0001000c, 0x9178ff78,
-	0x0001000c, 0x8c787a78,
-	0xd7610002, 0x0000fa6c,
-	0x807d817d, 0x917aff6d,
-	0x80000000, 0xd7610002,
+	0x010c0000, 0x00020000,
+	0xee0a4074, 0x018c0000,
+	0x00030000, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0x8070ff70, 0x00000200,
+	0x7e000280, 0x7e020280,
+	0x7e040280, 0xbefd0080,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8faf802,
+	0xbf0c8b7a, 0xbfa20003,
+	0xbe804fc2, 0xbf94fffe,
+	0xbfa10001, 0xbe804ec4,
+	0xbf94fffc, 0xbefa4c88,
+	0xbfc70000, 0xbf0c807a,
+	0xbfa20006, 0x9371ff7a,
+	0x00070004, 0x937aff7a,
+	0x00070010, 0xbf06717a,
+	0xbfa2fff6, 0xb8faf804,
+	0x8b7aff7a, 0x0001000c,
+	0x9178ff78, 0x0001000c,
+	0x8c787a78, 0xd7610002,
+	0x0000fa6c, 0x807d817d,
+	0x917aff6d, 0x80000000,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa6e, 0x807d817d,
+	0xbefa0080, 0xd7610002,
 	0x0000fa7a, 0x807d817d,
-	0xd7610002, 0x0000fa6e,
-	0x807d817d, 0xbefa0080,
+	0xd7610002, 0x0000fa78,
+	0x807d817d, 0xb8faf811,
 	0xd7610002, 0x0000fa7a,
 	0x807d817d, 0xd7610002,
-	0x0000fa78, 0x807d817d,
-	0xb8faf811, 0xd7610002,
+	0x0000fa6f, 0x807d817d,
+	0xb8f1f801, 0x937aff6d,
+	0x00060019, 0x847a8c7a,
+	0x8c717a71, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f814, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f815, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f812, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f813, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8faf802, 0xd7610002,
 	0x0000fa7a, 0x807d817d,
-	0xd7610002, 0x0000fa6f,
-	0x807d817d, 0xb8f1f801,
-	0x937aff6d, 0x00060019,
-	0x847a8c7a, 0x8c717a71,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f814,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f815,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f812,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f813,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8faf802,
+	0xbefa50c1, 0xbfc70000,
 	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xbefa50c1,
+	0x807d817d, 0xbefa4c88,
 	0xbfc70000, 0xd7610002,
 	0x0000fa7a, 0x807d817d,
-	0xbefa4c88, 0xbfc70000,
-	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xbefe00ff,
-	0x0000ffff, 0xbeff0080,
+	0xb8faf81a, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xbefe00c1, 0xbeff0080,
 	0x80767074, 0x82778075,
 	0xee0a4076, 0x010c0000,
 	0x00000000, 0xbefe00c1,
@@ -5061,7 +5057,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x018c0000, 0x00030000,
 	0x807d847d, 0x8070ff70,
 	0x00000400, 0xbf0a7b7d,
-	0xbfa2ffe9, 0xbfa00183,
+	0xbfa2ffe9, 0xbfa00184,
 	0xbef4007e, 0x8b75ff7f,
 	0x01ffffff, 0xbef1007f,
 	0xb8f20742, 0x84729972,
@@ -5229,6 +5225,8 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x856e906e, 0x8b6e6e6e,
 	0xbfa10003, 0xbe804ec3,
 	0x816ec16e, 0xbfa0fffb,
+	0xf4601bbb, 0xf8000040,
+	0xbfc70000, 0xb96ef81a,
 	0xbefd006f, 0xbefe0070,
 	0xbeff0071, 0xb979f822,
 	0xb97b2011, 0x857b867b,
@@ -5248,19 +5246,17 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x856e8e77, 0xb96e3021,
 	0x8b6dff6d, 0x01ffffff,
 	0x8bfe7e7e, 0x8bea6a6a,
-	0x936eff77, 0x0002001a,
-	0xb96ef81a, 0xb97af804,
+	0xb97af804, 0xb8eef802,
+	0xbf0c8b6e, 0xbfa20003,
+	0xbe804fc2, 0xbf94fffe,
+	0xbfa10001, 0xbe804ec4,
+	0xbf94fffc, 0x857a897a,
+	0xb97a0244, 0xbe804a6c,
 	0xb8eef802, 0xbf0c8b6e,
 	0xbfa20003, 0xbe804fc2,
 	0xbf94fffe, 0xbfa10001,
 	0xbe804ec4, 0xbf94fffc,
-	0x857a897a, 0xb97a0244,
-	0xbe804a6c, 0xb8eef802,
-	0xbf0c8b6e, 0xbfa20003,
-	0xbe804fc2, 0xbf94fffe,
-	0xbfa10001, 0xbe804ec4,
-	0xbf94fffc, 0xbfb10000,
+	0xbfb10000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index ace2a9f2ac73..ccc61f60ceb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -36,6 +36,7 @@
 #define NUM_NAMED_BARRIERS (ASIC_FAMILY == CHIP_GC_12_0_3 ? 0x10 : 0)
 #define HAVE_CLUSTER_BARRIER (ASIC_FAMILY == CHIP_GC_12_0_3)
 #define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY == CHIP_GFX12)
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
 #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
@@ -110,9 +111,11 @@ var BARRIER_STATE_MEMBER_OFFSET			= 4
 var BARRIER_STATE_MEMBER_SIZE			= 7
 var BARRIER_STATE_VALID_OFFSET			= 0
 
+#if RELAXED_SCHEDULING_IN_TRAP
 var TTMP11_SCHED_MODE_SHIFT			= 26
 var TTMP11_SCHED_MODE_SIZE			= 2
 var TTMP11_SCHED_MODE_MASK			= 0xC000000
+#endif
 
 var NAMED_BARRIERS_SR_OFFSET_FROM_HWREG		= 0x80
 var S_BARRIER_INIT_MEMBERCNT_MASK		= 0x7F0000
@@ -223,18 +226,22 @@ L_JUMP_TO_RESTORE:
 	s_branch	L_RESTORE
 
 L_SKIP_RESTORE:
+#if RELAXED_SCHEDULING_IN_TRAP
 	// Assume most relaxed scheduling mode is set. Save and revert to normal mode.
 	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_SCHED_MODE)
 	s_wait_alu	0
 	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_SCHED_MODE, \
 		SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), 0
+#endif
 
 	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
 
+#if RELAXED_SCHEDULING_IN_TRAP
 	// Save SCHED_MODE[1:0] into ttmp11[27:26].
 	s_andn2_b32	ttmp11, ttmp11, TTMP11_SCHED_MODE_MASK
 	s_lshl_b32	ttmp2, ttmp2, TTMP11_SCHED_MODE_SHIFT
 	s_or_b32	ttmp11, ttmp11, ttmp2
+#endif
 
 	// Clear SPI_PRIO: do not save with elevated priority.
 	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
@@ -316,7 +323,7 @@ L_FETCH_2ND_TRAP:
 	s_cbranch_scc0	L_NO_SIGN_EXTEND_TMA
 	s_or_b32	ttmp15, ttmp15, ~ADDRESS_HI32_MASK
 L_NO_SIGN_EXTEND_TMA:
-#if ASIC_FAMILY == CHIP_GFX12
+#if RELAXED_SCHEDULING_IN_TRAP
 	// Move SCHED_MODE[1:0] from ttmp11 to unused bits in ttmp1[27:26] (return PC_HI).
 	// The second-level trap will restore from ttmp1 for backwards compatibility.
 	s_and_b32	ttmp2, ttmp11, TTMP11_SCHED_MODE_MASK
@@ -382,8 +389,10 @@ L_EXIT_TRAP:
 	// Only restore fields which the trap handler changes.
 	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
 
+#if RELAXED_SCHEDULING_IN_TRAP
 	// Assume relaxed scheduling mode after this point.
 	restore_sched_mode(ttmp2)
+#endif
 
 	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
 		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
@@ -591,8 +600,18 @@ L_SAVE_HWREG:
 	write_hwreg_to_v2(s_save_tmp)
 #endif
 
+#if ASIC_FAMILY >= CHIP_GC_12_0_3
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCHED_MODE)
+	write_hwreg_to_v2(s_save_tmp)
+#endif
+
+#if ! SAVE_TTMPS_IN_SGPR_BLOCK
 	// Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
 	s_mov_b32       exec_lo, 0xFFFF
+#else
+	// All 128 bytes are available for HWREGs.
+	s_mov_b32       exec_lo, 0xFFFFFFFF
+#endif
 	s_mov_b32	exec_hi, 0x0
 	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_mem_offset
 	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0x0
@@ -1155,6 +1174,12 @@ L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
 L_SKIP_CLUSTER_BARRIER_RESTORE:
 #endif
 
+#if ASIC_FAMILY >= CHIP_GC_12_0_3
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x40
+	s_wait_kmcnt	0
+	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp
+#endif
+
 	s_mov_b32	m0, s_restore_m0
 	s_mov_b32	exec_lo, s_restore_exec_lo
 	s_mov_b32	exec_hi, s_restore_exec_hi
@@ -1194,8 +1219,10 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
 
+#if RELAXED_SCHEDULING_IN_TRAP
 	// Assume relaxed scheduling mode after this point.
 	restore_sched_mode(s_restore_tmp)
+#endif
 
 	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
 
@@ -1347,11 +1374,12 @@ L_NOT_IN_CLUSTER:
 #endif
 end
 
-
+#if RELAXED_SCHEDULING_IN_TRAP
 function restore_sched_mode(s_tmp)
 	s_bfe_u32	s_tmp, ttmp11, (TTMP11_SCHED_MODE_SHIFT | (TTMP11_SCHED_MODE_SIZE << 0x10))
 	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_tmp
 end
+#endif
 
 function restore_barrier_signal_count(barrier_id)
 	// extract the saved signal count from s_restore_tmp
-- 
2.34.1

