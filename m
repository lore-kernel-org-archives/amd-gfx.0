Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33674D3748A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 19:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA54610E29D;
	Fri,  5 Dec 2025 19:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pgDH2P12";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E8410E29D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 19:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqUeFNeXfPGa+HTznGTd6Rvm6VMqWav0vbrJJHXKxo/KgaUvQGDK/rkdkvkS8KAzUoACTySg2tnPRFihSbmbsONbdkCaRjfa+QzkJZm3XMk/mbanBfxJmDwW4UvF3KaH6QH6XSpxZRrARR+JKipftmv6aIIFISZ9tHP7EL1/DnktU3KBqaDualmiPPQXTezEEOma6E4C1bFNJ7jXH9hxp0usHgWFeClTiFJws1xMyfwAfQ/+n/YZYPKRsKKm5CdKH/Ak5dEdX/JqP4BaRnOh+dLeNY/EZHjdC99zc/en1n6hJk9F4L+w+oBe5xX9HUXL8rz38RL2hBmKoJT3XnCFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+P7rpvV/9WnB9HBin5FqyzZiK4r9U8wnhRACPd7WcI=;
 b=Q/8eTAJDouO+xca4mAQgXEqQu+B657FQCUZ3Xzwu33nXdcAHVbxjJxkh3RxB4GokED0gCOu7MIam+COaiyg3ufYpbd0Lsmw7MSGeMO6Q1KElvPTq/Xfcz0braITJDOkkwHzegjV3BenuuwiiKLF3h2ZOUWUw83v/ixjSovHQwgoQMbkXAS5QX3jOYBaflhzSx6o81TrftBMG78IrdI1DfitfZYCQZ3CxVQPk86uFdpXkiGyU0Bcz+69nJGMFDXOpDCceA5YIUNMY1w+jVzoe3UGm+uiPtiaLSCFltQ9JiMcqIwCdn3Nzl+enxLSkuBBYiZR+o3nGk+z4OCkX4ArHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+P7rpvV/9WnB9HBin5FqyzZiK4r9U8wnhRACPd7WcI=;
 b=pgDH2P12HpAmslBUcX/WowkLWxdHdFVAFQ3zkgDB49u4VeyIV16odGZwNJKUrsW6kZ63FrjwcYuMmdh5BYG//I8PGQLfMTDbSM464OVTCl2tzseTC03Khqdyic7rGMNR1WtReD6HepTI7rUZn5eF3CF8LvpklOehmTq5Kdh2t6Q=
Received: from PH7P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::22)
 by LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 19:31:37 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::96) by PH7P220CA0044.outlook.office365.com
 (2603:10b6:510:32b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 19:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 19:31:36 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 13:31:35 -0600
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Felix.Kuehling@amd.com>, Sunday Clement
 <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix Null Pointer Derefernce
Date: Fri, 5 Dec 2025 14:31:10 -0500
Message-ID: <20251205193110.1589151-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 8165ec29-a485-4ea3-1782-08de3434e7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hNyJsPgVVYKRS1WPhPpyBR+XSndeg4d4b6wK0Nfff19dGns2IYI+6Btwnjtq?=
 =?us-ascii?Q?aPQoYBaAIRTA5VkvpXhYaoAya66NUwzP/OE8HF/IJZbr4pUSropv5Kwmtmz3?=
 =?us-ascii?Q?mVY3g2q7i7nMrpwo6Ea3aMJP1uyUMYtzqWt+WTnEkX4gpyXKVDdHkxFzCsPt?=
 =?us-ascii?Q?RC1EZ8kjswpRLcnOGri4+ItTedADQzMnFKoef+IVXODSneDd2eqhbF8dd6YY?=
 =?us-ascii?Q?bRf8X4+YAjuKDAU1iP/Eo0YfZeHtMFivw7Qcx/3ePhd5xgqMJphEOUn+5e44?=
 =?us-ascii?Q?wOCZCt4AXaG8dWh3PWuz0rn9GAQCiQpH8x1IFjSLUeUkb/HYbaS7RR44B5iQ?=
 =?us-ascii?Q?VJcg6iHhHWypIWC7jaxUJ4izR8uzXpuV6AdZ2lOf+k2pZ3qGdhMD7uJVCACx?=
 =?us-ascii?Q?XdlfwRDS00Muccj8/IjFDQSuFy6g8wF7IGVBm+Kzj27dlwxgHmyIe0OhAdtN?=
 =?us-ascii?Q?BqaGRu2lvby5nBttzfY6s4eUoYlqRh+Vn3+ryVZHo6bUYblDEwctXGyJawCH?=
 =?us-ascii?Q?UXQNrgRzYoC+uLCNuX6TeXRNL9NrDCL4OgLU4VzGhel8zij5NcPDHVGc5CLT?=
 =?us-ascii?Q?VqOUXr+0d5vJRMFHATLVO24FP5JKnJuD7+VFet9uuDV/gyuMeKdMBwtdmSql?=
 =?us-ascii?Q?Flz+xS3agC3BnGKcWt8QdWFiYdL/ji2LLFgFJtoKvzgvacWcvMxNFICXQdgE?=
 =?us-ascii?Q?Fy8OYZAPhZZVrRawPFAk83S1d47TZBdb3dQnFacAN58Mm2U8rYWnVTHgm87T?=
 =?us-ascii?Q?9B8Hh3Xryld0NeMcOjSHyWCvaxpbNk98WauIErfc/da7yfQgQt0cLjUPN9YW?=
 =?us-ascii?Q?bl8K3xNwB6oVeos0spG2iM3TuAbpTeSWGEN5rOlLBTYndRvVWmgVV+qu1C7O?=
 =?us-ascii?Q?clfJgxjhq03KCmdfCNTaN0O/p6WnVQJtqGnR1T1TGLd35gkeKEArwgbxzVTi?=
 =?us-ascii?Q?OxPwoMQo1S7etIvnRwSL1lmkoAD8nYsNZCi04M+tXUAVisEKNeVUG3uXxD0d?=
 =?us-ascii?Q?+aKkED0k+4+B7unh/082+xiseSJ87+QQhKP0u1L9+dU4UE/OvkUSd5R6YgAJ?=
 =?us-ascii?Q?zs8JErC0CKrzu1o2na06mR1FnieN1tn5Eu9ceO6An4HjPjEZox2hm4XCuvf+?=
 =?us-ascii?Q?V9fi6wshT3LGLAVilF6eJmFcJqClNSNC3Cxj8gagy43VIu57uXLkLdKtOcEQ?=
 =?us-ascii?Q?xIgUTQ2o0IxKQMD4sR9fbn/8fdeL1wgVREY0k6lPqr1/+JIt+yXUKKejgvg9?=
 =?us-ascii?Q?+YEWiGMjGW1ptqq0LN1rHPh8oqspsb1FBvoe8jMBu6tNJn/jVAnU37RSHMwZ?=
 =?us-ascii?Q?pCBhFUggDh54kh9XsScpW3lr6P7DKg54m+L4gG6ZzzC6AC7sUASU1UpJyomT?=
 =?us-ascii?Q?Ny24ACC5Q3zXcmB1xHjXOlGLFMoOoLyemhFnPQvV+35MsUWBueDBcbRCAcuG?=
 =?us-ascii?Q?tljggVQlWnpj/AUbnq61Iw0euOSfcrJENJ0GeEkT56VD1ubHLgRfcxaM5+Xn?=
 =?us-ascii?Q?dXjSoYhLUB+/rq3QljnZ2hV+MzE9nBSt3K1vn98Z3P+ijGmRwIk7QJZkbJLU?=
 =?us-ascii?Q?/A3184b0JT+Yt55ZwK4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 19:31:36.2159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8165ec29-a485-4ea3-1782-08de3434e7a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828
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

It doesn't really makes sense to dereference the kfd_process pointer
then check if its null right after, the order of the instructions has
been changed to address this and properly check for a null pointer.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 041237861107..d581213b9422 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3158,11 +3158,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 	struct kfd_process *process;
 	int ret;
 
-	/* Each FD owns only one kfd_process */
-	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
+	if (!filep->private_data || !p)
 		return -EINVAL;
 
-	if (!filep->private_data || !p)
+	/* Each FD owns only one kfd_process */
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
 		return -EINVAL;
 
 	mutex_lock(&kfd_processes_mutex);
-- 
2.43.0

