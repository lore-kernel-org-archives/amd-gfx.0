Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C85C44536
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 14:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF3D10E1D0;
	Wed, 22 Jul 2026 14:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oto6y/tn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C4810E1D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 14:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkZ/hs3q5RbHVbPUPT/LyMwC4Ktk3hLdXw0dTfkaGF5qRN8di3d6QOjvinXN6WkdIuEauu84MRQiQtImhSe+SVqH8sBDHfB+tG8+xXXC/mUfvWfe/HYZDblEPnPUjCph0F/9cWDsjaOMoIFuGldyEvPwBYvPuaF9Ai/HTKulQkurmnHuHXNhYjsUzGACl0U4EmNp3fmlWIBsMoetuolrdCBF3oHwWhHCN6xh5OoizKZR0oB1w0FWzHP8Soa8etsFFTpb1sAlPv3d7650Ev9iJpH2fZGUAq+4jFBZJ1rhhUwVpFN+VTPzYam4jZoBXyBbVW/HaRrYZ9jHeJiR8Wq8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTCGN+RFq6BbhIBKG1YhNaooj7yHjOrIMyF2QxYUc28=;
 b=lGrIGLxKyK0WrTH5PEGcJCLcYOt3Svc8V3IftrcWXd6Evr8I6TPqlpvsaqaDlPFMVfkWMM+fAUFPiyOIP51fHnJYpJdZT2gLqIGifr3JE2ugglzlOGEf6r4JjqPS1StYB2P/n72u5X/yGlqxQa+P8Q+7CzsooDkFQTxIyN4Bd/oge/P0BpQCnlf3n7HXX/bIyASkHt2iQbgptO2eUuJozcwXGTNLZbp+MgYoYA553apxSNfr/1o5yRsAQw4NU2FI4IHkY57Bz6pEMz9fHCL5u7Pa14mIhlPpXmAK/z6obn3kgZZuP7Wj8qPEy3d/1T9vJdksue31vobTRIwxM6P82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTCGN+RFq6BbhIBKG1YhNaooj7yHjOrIMyF2QxYUc28=;
 b=oto6y/tnmVkNS8w1C8PBA73qDNMfoMffUDWdrsof1q0Wv4SX7pFgfFeZdk/xZsgnoQ1l2W0dbYQDg+lvO86yTEm2oJC8qJUDgHCpSymo4+l5mNxwU4FV20Boepwr+U9Ex+MZmaZsWr9H+8G+9DZOKVghMsZ2nayaL6CG8BbHqeM=
Received: from CH2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:610:53::25)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:13:19 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::57) by CH2PR17CA0015.outlook.office365.com
 (2603:10b6:610:53::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 14:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 14:13:13 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 09:13:06 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Alysa.Liu@amd.com>, <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdkfd: fix uint32_t overflow in EOP ring buffer size
 alignment
Date: Wed, 22 Jul 2026 10:12:18 -0400
Message-ID: <20260722141218.1615450-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fad9f5b-389c-4232-69d4-08dee7fb5e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 567ufu1eVbjxqQAfkFARNgLadjDlpssujXG9I2Lyg/ejyVWYLreAZ+ZpD01h5zzNF5aZg1kBTGdPxuCYamn9BTTQCQrH86lPtea+eY2qxzZYkKdqHnAmbPKDkuasNerb/vaolE7oTq2OfuRM8JuLQbfie3qdIXZ/trfZJeePDTNPWN6+iGpu8AoFa6EZYkdWYp4rd+pHV+EfFueUmrbWx512DcFNH6dUAdO6ZIp6eKSXe485rsieVYoW+56eCmHa1JH71gaGBgKxY3JUmeXfueYN5pf/lO1Ss+AzFSJeWnzucqLPwe0j381FUu44zd41+8rQysP3IpS3sydBEhwD2ZbCdPLftmSONMa31qImtDfO/HHPwQoH0qBrdxra5zeQyYMo41q7/UC7EcZEgZ9YCiAZ7SoM0gR6aq+qJi/fV8T0vh4BidKsUKmfPCWyTFideJbJu+B+i93bj0pp0chsYmM7s2HeehzQl66qvWQi/nJof0I1yfAgDtuu/WPe990noL2PRILRwlNn6Lcwk3bI9uaQE06zBSKrJLi8d42mwLFWVyDm6oPesC3ET+TFOdF8EbUydAk7xho+BK7Td++b5m2Gfb90tO7kxifeYuvdF+JTByJjisKgVcMhipLQ7TBfkSQ/+XXRs0vN9FtLEAiePyXCkg4yigpxzKHZWUl6BPCDnYMr/OO/yLC4QLDr+Ffo95KF+eFNfVvP8dZHGDCY/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HwdGsDKGqFs+Z//sABjehYsbhnJEuuKSAhGuf3xEZSELsp1VTe0yb2wFO9up6BdrmF1Q5Xd1mk8XLlxuoB18af3oolMr1ph/bG8EeD0AC0nn4OR97z7f7mX6a381E/E4hsn5bFHzN5WA2ztve0sLIdgR3W33HIALtTCZ0Le7OWBqXCW3RNZoJJPhxbLpPBHG3kZj6elZ+KLdsH5OuYlBqhK1///JrVRr/0ZCcOoCZiOwMQVXZWNz0+Q5gjI4eFfURu3rMBAuuYsbyUsrI8TS5O4CkKXou4rXsQ2ohKXM0os/9IeZtcveYMVqHULBa+YZ54PibRWm/uzPVClrjr6cjU2F4RwwKjz2KWk7QnTru9wkRXEOEgDXGLFcgZ+PDWLQz68Ij8hKZYSF/fEzKbxcr9/i1sNZJw24FJPxic2Lflh7YxEZ2TeQAdpL8JG8tbOC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:13:13.5345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fad9f5b-389c-4232-69d4-08dee7fb5e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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

eop_ring_buffer_size in struct queue_properties is a u32. In
kfd_queue_acquire_buffers() the expected EOP buffer size is computed as
ALIGN(eop_ring_buffer_size, PAGE_SIZE); ALIGN uses typeof(x), so the
addition is done in 32-bit. A user-supplied size of 0xFFFFF001 wraps to
0, causing kfd_queue_buffer_get() to skip its exact-size check (gated on
size != 0) and accept any BO mapped at the address. On GFX8/GFX9 the MQD
cp_hqd_eop_control is then programmed for an 8KB EOP ring backed by a 4KB
BO, so CP EOP writes can land past the buffer and fault the GPU.

Cast the operand to u64 so the alignment is computed in 64-bit; the size
check in kfd_queue_buffer_get() then rejects the oversized request.

Fixes: 42ea9cf2f16b ("drm/amdkfd: Relax size checking during queue buffer get")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 98a5512b701b..b249e7d1af48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -288,7 +288,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		}
 		err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
 					   &properties->eop_buf_bo,
-					   ALIGN(properties->eop_ring_buffer_size, PAGE_SIZE));
+					   ALIGN((u64)properties->eop_ring_buffer_size, PAGE_SIZE));
 		if (err)
 			goto out_err_unreserve;
 	}
-- 
2.34.1

