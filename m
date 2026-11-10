Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264D606A332
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gNYXq+Dy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE4C10F744;
	Tue, 10 Nov 2026 14:45:33 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D97210F744
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 14:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw3hl4XtZQCr5Opv+TJ8hIe9bAeXzM8tJMCeo5qsUbIDPPxIktTBq9s/g+HEAX7St97BO4JyymlNbxmXe87DVtZR27sP188HT3dHjdXbMeqqRnoAfQ47SFKrfugV/AT/buMypUZLeryIlavsbxeNbvw9q9p0V2VnzGI5PqA63F8tAdfIueCniW/w76H+Dbvk519XRUE2417gYI+mNJ+iZMmsasQtSvssRfmb5eDEnhYXiOdovl3ncQ8ize4MJiES/FlafTQdbBhMl/rKWtk7DfHGIBv2mnxpOr4Z2GBj0cx3oXL2FWpWH9Rv8G8d4VJ9kJD8JVihmQW9fMfMyuq1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLgTls4dzXV3u22PLXGqZJeABmEPiNwGNLAZcsLFqYU=;
 b=x5niSNYfNY2G99wFMksa6SKkV0lEkmuYJBWc4wJ7hH3BC9vX0ARuLHgFGYtCOXXlfdygBPOrj+k78JtsyLvRzjfj1jmXPSMUIbLwfpiGTbHLfCrKMeDr7Mycn02FqsyJxs8PZ6YVOZQ1ZsyK6JS7vXeOVEbtZbcln4nTJkbjczlV1ZrFnqTEuWMyMNjsQ/+Ru3I73LsNHg36EwMDesphtZFF19REpR4yYf87vftc14mwBvF1kke4ClkIuU+Ex7zu4Tnv+LIEETXkhsJITIuznOaZZRGKDDNW4UYLRYmQlPAgj1om47xYpsl+fjNSu3Yhrrr50b4GznpL7Csffh/R8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLgTls4dzXV3u22PLXGqZJeABmEPiNwGNLAZcsLFqYU=;
 b=gNYXq+DyexFFXSQAe3mHK0cO8XYLvMOuBccZGOr7EOPJCQyiVWbZbm7gyxfojc9Untt8NlITF0XVICKxpTm3Wm1YDwCG/9bidjJ0yK4G/N14XV1eomC7CQZoh5QVku5C1ypVsLqiEzZZmgBPwF5MqH1I0SNTZBELf5GBNVy8jUk=
Received: from CH0PR03CA0442.namprd03.prod.outlook.com (2603:10b6:610:10e::32)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:45:21 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::7) by CH0PR03CA0442.outlook.office365.com
 (2603:10b6:610:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 14:45:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 14:45:21 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 08:45:18 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Handle fault cleaner race condition
Date: Tue, 10 Nov 2026 09:45:06 -0500
Message-ID: <20261110144506.3946989-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110144506.3946989-1-kent.russell@amd.com>
References: <20261110144506.3946989-1-kent.russell@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bffd4f9-450f-490c-1551-08df3f393f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|10067099003|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J76VbLTyrWCZ1TNADHZJLySJPV4aVCJaygdGHIRfViD1AyDKVrXZfNrUlaTvPbj4mbFpYHCDqI/HpLCaDh4CgMUB9ZeaeszwdNvn9SNGX+Avw34kFYh539nubGGnMpdiLG6bov9hmGpeYVvfIWJHZ6baODwh+ruTFcrWbpNsnFeZ1mWLRuti79nqrMx751H4quT8nbYlCoPLRQPbiyVsFXXunJ91/f9vH8rGGC26M2OPgPAp57Z22LRIXs3NNj6cTd+hT5unCL0cq7EVQVFiutOrrwj6eWfiuMOER2NgVpjrDYktiX7x9JsV5IJ9vPPQE6i1AwD6Yp1cY9O2xFbhMySyAGhQeW/iczZCrHWdUNltNHuM8fLse6sOoP1kOROW7OXhpEP/MWK8I28U1FPi6n0fYxF+tN3ThCaGP6wpLvscoLxDQjzU+aNOZLOp+yy20YLGdtL9rbockznmh/du/MlHaOKUKvSDfpYULzSPRZO221GifNeBFVEhCZHdHkvigk6kAzDAViNh91xD1c+WyxVMOQNEs1okMopn79JSrTABN+Gqp0xMnvSSKf8cgrLQWGh7UZwpxpHc/TSOUxstOijoiQAHz+mj5DZhgY/Jv6R5tO6UP8dp91r0LHv2LOJVz+Ewl949RbzbK4yu3IZFNaFducTeKzH0K/8lsGq6PY5qvFtcBIReHrbN8wIvkwUdXBNUD1SA7me4LJYFXCNcuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(10067099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mWw7nFpxnWx++QHBDV7MHhMKeS6RDlehrLq9T1yW+K/bC6iGPrHOcqKHsYkICRsD18KoxAwdS7COtpvnEcLYFHrlshZIg628InsEUBUdutfiKISqLNNdj22F8lee9/RqIqTUzsm1VuIF0uqypBShAe5k2O5iVwmIXLjBuwMp3alcnMtTMSSQXFCN2kVeLNioemsJWuOBtPDnVNHKyRAqnPAuhQcSbUi0VBCjTnFFZiKIo6RLCBCmSM3pEfhJVgpLAdyfqf/Bq8X/0qVtDR25Gak7NdDL4IMlvXnlLuLG6JdpFqwWbr6ZcSipyy0LoGbpkq8/c3fPvx28cva5W+CbpHNwlOPTY8xGk2EIsIpJjHBNGB80QBNyS3967sS+S4nvaw6ewv1WKaFtX9bObRpibMsSL21c4CJK7Tty64f1Jqn+xaUXMbr5wICd+m9lV6Uh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:45:21.3562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bffd4f9-450f-490c-1551-08df3f393f18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
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

clean_process_queues_cpsch will exit early if the memory is evicted,
which means that we can miss running the shader cleaner if the memory
was evicted at the time. Run the cleaner when the memory is restored to
handle this condition

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 +++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 86b70748617b..a67db9d31cc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1571,8 +1571,11 @@ static int clean_process_queues_cpsch(struct device_queue_manager *dqm,
 	int retval = 0;
 
 	dqm_lock(dqm);
-	if (qpd->evicted++ > 0) /* already evicted, do nothing */
+	if (qpd->evicted++ > 0) {
+		/* Already evicted; defer fault clean to restore time */
+		qpd->fault_pending = true;
 		goto out;
+	}
 
 	pdd = qpd_to_pdd(qpd);
 
@@ -1763,6 +1766,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 			}
 		}
 	}
+
+	/* Handle deferred fault cleaning from racing clean_process_queues_cpsch */
+	if (qpd->fault_pending) {
+		qpd->fault_pending = false;
+		dqm->dev->kfd2kgd->hqd_gfx_clean_fault(dqm->dev->adev);
+	}
+
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		retval = execute_queues_cpsch(dqm,
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 158fa70a1a8e..5cd8f55f589c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -695,6 +695,11 @@ struct qcm_process_device {
 	bool is_debug;
 	unsigned int evicted; /* eviction counter, 0=active */
 
+	/* Set when fault cleaning was requested but skipped due to eviction.
+	 * Checked at restore time to ensure the fault is cleaned.
+	 */
+	bool fault_pending;
+
 	/* This flag tells if we should reset all wavefronts on
 	 * process termination
 	 */
-- 
2.43.0

