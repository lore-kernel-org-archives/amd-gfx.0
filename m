Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF86606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G3g9ygEU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838D610E042;
	Thu, 26 Nov 2026 20:37:44 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232B910E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 20:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcw5LZwgkfTWKI49RPMjT5dCvbYjkOmQVvn80KKCiHUiwfyfpCrEQsqaFPK1yi8z0iA+sYvVMcHSH1wVl7s2eoWOkVtOTrDo6LEfAg8CnHW9KPv8rB3bmTtfZdgmxm9MHg178wuJ8VaAwApi7gUcdqUS1VpD/m+PQKPZVav9D2Y9bbTNL70hznNzcVQhBOTLi/gctzsClLIxkKci+jGoxRpYEiSAXH1DBlLh8NOspkbLzpBaBCTK5yMb4Z6KiZLScXTnQd/4TQVCZ0o6X7EFvFxLoqkUhSTB9cPIrhTZ9aqiqS221GaVyqHxNI2GvU7qAwbKUTPpc+zsuA+Hqk0d2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUHHt4R3f1KWqVHAtN1zWEZSNcLKs9lqEtZOuzwaVkE=;
 b=g5RpT6OS1FxmazZUNOzACg6m3DphK4mZdta9qKeuqQ6t37gdSZ/iZQOodmQGHUb8bex7dKC1o5BHy1/MLfLrIiss5bvd56fLDirzLWEObwh9ZGslt1p/1s7kef5mZz/jgxjS6gLBB94y8e9fxLkqMlZig+RKoAlXv4HBwLmRvNRkRwRzYzw8iYi71bigcNzBdFetkt/CXivGi71jhra1eznFj7qUfW6AbWYy2FG6Zg9y5WyUsimvogFyaibnBcEFcmPyMbl7MhPVcAGBw+Zh/3zu49yrXRPhBCU+TiEVCczdfui88I7pvhahdrUycL9j6o2jQsKhohjjDMu0BiVbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUHHt4R3f1KWqVHAtN1zWEZSNcLKs9lqEtZOuzwaVkE=;
 b=G3g9ygEUmu22LzYfTbiEbaZRPmeODiyjOQAh1elDFN7OctWrmnuoYONXunVfzoo50q14lStW9McoTY8D6pfgKCRfJc2s7blYN6NKf4K7vqHxkXU91SqU69NFsLPEeSK1Ik+E//oLgHHaC+EEr7RGkVAclE540B0Qw1i9bStjH1M=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by DS2PR12MB517653.namprd12.prod.outlook.com (2603:10b6:8:70a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 20:36:52 +0000
Received: from MW3PEPF00001652.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::a2) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 20:36:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001652.mail.protection.outlook.com (10.167.249.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 26 Nov 2026 20:36:51 +0000
Received: from MKMSJIANG01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 14:36:50 -0600
From: <shichao.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, Shichao Jiang <Shichao.Jiang@amd.com>
Subject: [PATCH] drm/amdgpu: increase AI mailbox message poll timeout
Date: Thu, 26 Nov 2026 15:35:48 -0500
Message-ID: <20261126203548.10279-1-shichao.jiang@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001652:EE_|DS2PR12MB517653:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d812fbb-1f01-4726-8a17-08df4bfd00b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|261009223027099003|18002099003|261022105027099003|56012099006|11063799006|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261026140227099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: czImPZOR+/oYNoTLVYNiTY5SWDEySNEl95cejIqCJqtjPnbPAy1yfJhhX3azdGhr/jFIth9A9jDmDUO0qTGriaLcHnGJrhVuxSsnw8P+I/KuDY3mDilUmziJ9zkjYGO2WTmjkwGeOvhPzlE7Gj/6ejRc/KmKeqhv9iCqmL4ZaAKiP5FKZu6APsFSnS0o7NTfIGvoJSmMrW+GWIYO5Cy9MRk+epkYe1PbMfpo6wXpd+ivbYzWIFRLqaOaUSbelBEHdgv1B1lgcV8tMtVCqLwMH1pt03/v/1p0PfOl33rRELO+e5jfyA9+4wR6hrDXt/fAFtGLg1max449i/c5n2h9xKzzmSY9s61i0ubeB1YZFLyj6Fb9b8uAv6dKyv3buW5Hqd3IARvhJgxUb8XUGntaJMqoDNJvnoJL+vbQ6YZQw8aOgI558s/eUY4/NiT3QfZLz4SlgXu1bRRIonDnxdwcRtK9jzSUgj5lgtodrbalwDIugpf83pFWqSeOxB4eKO9fMmVyQZ9IJCEsCD0V4fb4bhcw7v/qLXGZxIf01IDw6NtiOzJMRBKrp2Ug0l9gnYjb/ykEMtsrAGz+6b10wkFY2hlIcQSST78OCVaznf/IWH8KO9V1zZv9feHmAZruuyUJw4GhhvxsKHau+ozdKiKGb5H2LNttrPA0YN5+naVmvCGmkSq/CK38Fd9ZtfN1+InrnnZAxMyyUnzC3NhYsiTAzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(261009223027099003)(18002099003)(261022105027099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SzLWM9Nii8AlseV7JJwsUxybQvYAkJhkHhE7Wa7+A++VMS9eeVqiSm2OjCtl/c4dqoauzgZr3bP1+q5zeY40EDdrmSzTT/aABgjySyohDqOAfcmXYWIENzRpN4Q7uHgWaNGX41ZG//V5a3jOb44YhHRYXb9s7fXy7r7IO+zkq/XzkNfAi67+WDiK2MRILrKqiPZ6rznYe9YiWOTGLsJJga7gdlaTv+6k7dQIiyvWdlZd7elMvwWXHmy0z+G7sLQQEScsx+180Cts/i/IxfUmoNZp3vAfD2BVh9HHf26i1IEFW5XdPHi43j1g4AzIX/fbw3et2Bfqk7Q0qhy4BM33VctFIhpmmdQ16bhmlPn8mkwxpMhgKwFA9mAZtdBzRRlRIJnD1STD4KxB5hURO7fEh5Q2x2FytYZl+Q6TsgC4/JfCYGmMfQOPHCbLMhDZNRLr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 20:36:51.9175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d812fbb-1f01-4726-8a17-08df4bfd00b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001652.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB517653
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shichao Jiang <Shichao.Jiang@amd.com>

The AI_MAILBOX_POLL_MSG_TIMEDOUT of 6000ms is no longer sufficient, with a WGR taking just slightly too long on MI200. Increase to 7000ms.

Signed-off-by: Shichao Jiang <Shichao.Jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 874b9f8f9804..9c03e4915ded 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -25,7 +25,7 @@
 #define __MXGPU_AI_H__
 
 #define AI_MAILBOX_POLL_ACK_TIMEDOUT	500
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT	6000
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT	7000
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT	10000
 #define AI_MAILBOX_POLL_MSG_REP_MAX	11
 
-- 
2.43.0

