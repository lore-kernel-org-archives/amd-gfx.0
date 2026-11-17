Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F231606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1lTjvJGz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7BB10F975;
	Tue, 17 Nov 2026 21:58:08 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CA910F975
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 21:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzrCD+crJAJroo8RbFMkx7+KPz1kDVQXRIul+sER/3GLAXqpOkHHIYK1fjRoOgrua75hfGWJmDCXxKi3oPTuw2y+Riv+aF147xTQGYvGTMiF7OKskn4t2Ho0LD2pMluiRiQ6I3tVBEA0aVQvBoNyQGugG1zeRPP4O+OHihoeVAk/WWTPYTLmjiaGi4+Qq+JiZd9AR6Wkr8fJOivhWMxP7TvUCPm3ouvOMpCfmx8usBU4ygqX3mMVDxg4JdqRSsd9xRToX56qH693z4ZubN0Dtrv/OThOQ6wr75dlPYHeX+Q1rOUoYJh4muF6RNaPTm9VJ80gbe8nk6rfH0/X2nxrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0BHLKg8gzsBKBib1dIgp4BR98VKvisoo3B792bHCvc=;
 b=sMnAZWofbY2Xsy8zCeriJqaiGQY7nibKMbEdWsveZT+h7PvZhiN/bHbyQDKZCwDg+adVd0+6XWBWjc/NmDqcAclGjpaLr9nVLtb9k9avOz/nHAneK+pJlscUpFgM1/uOElISl7WdUS9oyWp2gNAwRVrcsIz+N1eXYyKkq3xumXzn/3ILpYN/w8JELfIT8KBm3u1GMdUJYBn+jE4mZQbYzxwKh7YLPHg1tFO1ACsEUZfqudKfHyijtCrTGdfBjv+SxxvrhlkE+Qpo1uDdfxrlSuG4n3Acb5WFqQEo96Hi6o4g6zpka6pn1YtFVH5Sb5X/9ZFVJUP1fvkm9ibkNN6gyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0BHLKg8gzsBKBib1dIgp4BR98VKvisoo3B792bHCvc=;
 b=1lTjvJGzeA7vdB0wbzVa8yFHYEcHW8tUKjkZjG6kuAr9bvFtcm88THG+VWp2sbnqV+9q523z3w93bjQXqH5z6cKRosQ9LiggB00UnACEGkVh9Ldb1d3eQbiFvh9krc132JUvkF6KfHNEtj/zB/u9Wq3TxasXT1V5H1WONPCmRLs=
Received: from CH0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:b0::10)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 21:57:57 +0000
Received: from CH01EPF000BE945.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::45) by CH0PR03CA0005.outlook.office365.com
 (2603:10b6:610:b0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 21:57:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE945.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:57:57 +0000
Received: from MKMFKUEHLIN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 15:57:57 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdkfd: Fix context ID cleanup after failures
Date: Tue, 17 Nov 2026 16:57:14 -0500
Message-ID: <20261117215714.50191-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE945:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 80812bea-fb2b-4691-3158-08df44f5d72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|56012099006|11063799006|261026121527099003|261026140227099003|10067099003|261021123027099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: VOiVGVjNvEflcVQ51XttyUuPDgRYPOH0PW1tChONywh5tVBl3LZ9Ak/hqYHvVsPK/Gn0kV3roW/1eGA7lx3aP6Rs2BnTnShsWvW8gq73rxhE64OhIgxeCoYW89/S/8mDDn0hpMcVABmUd8PT/pr8TcmLxSYrJbdg2D8Q/7gNgjLxnrH3zGcRFL+VKifMfhepAHZEABUsDdjPiSaJOqJ8Ys7ic0yoWuVbp0NkIIMExf3/3BVc2DnL/SpNWvo+fCPzXL9isRH3sw+dHyN/RfM9pw2gLEQyUB/bv3dc0cRV1lXlu1Dc4ZP7hPbWG3WBUwR/6Vzzls8h5f9tdBqKB615qMLRkTVM/kNNhg4xouQlJNEV7FE20Ly6T5a6tx9bretQHuaOlXSDXBpUyeb1rYVnD8da2bBR2udm+qN/6izaMLxuQh2iWyRARslIeTFyv0ck7r2pJe3rqhahhRPOMk8jgvfM5aSC8wXNLbDWMOVkICU9WLXo8FtbPksPAHcFZYd6lxeMNKZgkyZOfMzYIayuKdURj+IHgqh5AhZWaBi4WWHb3/WaYBvEouosvVUFSPQt1M/wYTWPvM3vHfKlBFYgmp3l2hteiPZA5MuKcuKF+zXpPTdEermBu802H0wwsh40UBQ4m4s/XcQHuvg5oEl9TEllJPtSKqFHwXnKGnc69RN4opTYqQ0r12+aQ4HWulldX+SjEYfiJ+rNYAqf5ozCGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(10067099003)(261021123027099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9KbIy3BY2hBbrQR5XCcT7L1QaUHtYxZS0bk1+IPBpnTWu9bIakxSb3C/ECflaTfU/q2ZoG2MG0wSg8uPJtymkSZByuBVOqb2W9O6oOr8GaWycnppb4P7V4IZ79xZFgt4zwQixIlnNKufbK1cxhNRD+C7BZducfbONqrAkjX2QcyOxo5lD3h+1PcZbiXujE/L4Rs+WqPDj8/13nDlkDcJei5rZgjMy0RB6yca5vj0pKPkmfXHOe7Kqy70cj4TEAqFjLg57VcFkMIPcWCv8H3mYCYUnT29Vgy9pg7YdcB+60zxbXXgFYs4w4qSD4H+wgJVfKVDWgK+LfYk2POavFqrsq3pRr+StvsxWA6Wt7zzOn2SXJuCGCo+t4TqY/alrxI/vy10mA9r8FbEzBGWW0skb+RngVtY4+r75NzxJ7Be9L6audISEgBB9wSCJYS3GRHK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:57:57.7101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80812bea-fb2b-4691-3158-08df44f5d72f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE945.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
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

If secondary context ID allocation fails, the context ID remains 0. Make
that distinguishable from a valid context ID to avoid double-freeing
context IDs.

Fixes: fac682a1d1af ("amdkfd: identify a secondary kfd process by its id")
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3292e616d36f..2c8716d45e3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1083,7 +1083,7 @@ struct kfd_process {
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 #define KFD_CONTEXT_ID_PRIMARY	0xFFFF
-#define KFD_CONTEXT_ID_MIN 0
+#define KFD_CONTEXT_ID_MIN 1
 
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ffd11576a0bb..d1b6b6305439 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -950,7 +950,8 @@ static void kfd_process_free_id(struct kfd_process *process)
 {
 	struct kfd_process *primary_process;
 
-	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
+	if (process->context_id == KFD_CONTEXT_ID_PRIMARY ||
+	    process->context_id < KFD_CONTEXT_ID_MIN)
 		return;
 
 	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
@@ -1790,7 +1791,6 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	return process;
 
 err_alloc_id:
-	kfd_process_free_id(process);
 err_register_notifier:
 	/*
 	 * The process is already in kfd_processes_table, so find_process()
-- 
2.43.0

