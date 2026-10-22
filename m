Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4A606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PwISVXWp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518971122A5;
	Thu, 22 Oct 2026 01:48:01 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522081122C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 01:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a94naMkyl7DL4/pn2UxpjTH02OA88NQAT0pcIgjIPgFbwiPCKSc4W1s76O5ovkEv9ybFmJqfsZmFvFIcuOklcqycWuuh9NGgxp/YWhEYzWyoez7nwzQJ7xsK0UZbS8eGgMdjoAdA0k7PCd/jqnGb5pQEIG1bh7XDR4AScmLR3bzvTyWN3m0ORdtm9Dm0DZUQWcRAnyt6dRgMr+LkfKmRBReBT54CxSbuLQ9SCIQfIgTIBxuF9TNCInfrsYz9rElKJ2B7wxRM4s07k4ERRwgZiQFY472BMQsk8e4mu0XB9lnb+hsaUqHhExrpQ85QsOEDZgL7zVdtqe8PWcDbMEEC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIg2IUGNT6bheKH9jlwDphGpoLZCi+Y07dOtIfVTLYo=;
 b=CbxYdwGCPZSetYJJHoQ1GOZuWV6pcXKPzcsRSVwcWQSUzxAVxSN8zjuP/Qe2JGAGG+Yge6ugZm1GyIrjhuSTztJbmM9/iHttQlsDg5twnxibKCvOsv4yA7yiOoqwkblPj8TxYigvvvayM8A9F9pcaN0DbVn/I6ahxbPiQW7XKhg0XlBjkdb0l1qS79MjfNa1ULfn8MRNvl/BesRaMYBQR4rltxtnnbr1lBKPQgbFQELvjMBiR/OfShAQ1Lqp/FnS/G0ZDxJSfqusjDKLcZbmyGFUU4tUZGAUg8Pb0+Ela6K5zU1vzgAbr7a4RCkxCzLnb+Ti1YJwDyCqhnn6VcuT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIg2IUGNT6bheKH9jlwDphGpoLZCi+Y07dOtIfVTLYo=;
 b=PwISVXWp0mTo4hA3y0Ac6LOxVLH2mD8V7XdetUi2/t6HUR0RcTEyOKt/P8jANodkEypC8zvQ6N1yCGxxf4m8ZHdOHSBhVgtOt1/EL9W9NGm33yPo5+7Q5uD0fRm3suxvmHPgs5Frj/mFi9vRnzsmoBKBL0UHWSZTGVcpRDgRv3s=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 22 Oct
 2026 01:47:50 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::9c) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 22 Oct 2026 01:47:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 01:47:50 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 20:47:49 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <alexander.deucher@amd.com>, Amber Lin
 <amber.lin@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add debug messages for MES queue reset
Date: Wed, 21 Oct 2026 21:47:21 -0400
Message-ID: <20261022014728.84081-2-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022014728.84081-1-amber.lin@amd.com>
References: <20261022014728.84081-1-amber.lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 488ebeab-ce84-4b56-9fbb-08df2fde7b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|22082099003|261021123027099003|10067099003|18002099003|11063799006|261021121427099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: CK/60azwQTXmTwu0/J1GLcaq5a9kGeNUWdNDIwulEDOUyhy6hMObw5PbKy1McoQjqrCjeUb7rLHGhZgOXT18W98BJbDYZz/+YNaLTE/kBIzERUiMz6EN6nYZTDnkoez4eIPabHFRnIibRpJyDiGrGwOGIbaSgeeAkh4kvSf3Qupm/rDW9WEjlNQW9SddcsWciAnaumy9ujRzPNtGHmBM2XHgPTd4gy19DGyj7cnfI6QAFL3Ga0xsqohIV58CwyCA5gZ6upHoOiCVcLi7i4+7VUjYDf5vcs/Fk/0JAERWsIm1fMimN8L0zn0n2XukcsPTet8p+eAmEE9n6ib16FZzKvB6iyAbe7BLl9Yc0eL41oIwfNEJgqx2wcFe7EMAzwN0b+BceSx+arsOmsVgIsmD9wwXuwzQJqp2O6yVMDS5JtuWPsN0QTnPpupew/hcTpbayoai+ttMKARkd18IS9Pkkq88elbTCKVw/97mLnFEgj3iQaRyysr+zgpTKWN4czuYNbE6cz6MSpQ46NCjbwLpq7cty58Lxp1RuQ0RHL/TjU13g7bAZdGRCPAxGxgWHyNp9l0+3kwUgLQNklGa2EjWUEeRlFkJgfYYnF6PgEVl5W4l/WDRuIH2ex1J4f9dhcq4jQ1FK28r77EpT1CoHSdohj1Faz2Re8VkG5EFkgSlw2UTQxCAZ8y3FMgxAiIc7J20IX/BafX/+BzbszmeCd+IOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(22082099003)(261021123027099003)(10067099003)(18002099003)(11063799006)(261021121427099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HguJKap+0r+JW2BBHq6G5Z16ZoElS65hC0+dgsF67CiiwCtgMF1563++LlLr+pOwMNzmpdTG14IJqi+QesZJ5tlK7iFXUBWMO96thdVW1ufRwZ9s63vmFmeUzh+XioGWo6FmZTcxcbqHVEDk6i542aYa0FjMJfitVYoE4wIKHk0DnrVvLZLADGIi+OIujSBn7IJDpjXIlz+A3ASGC8Gn6AfCUviQa3EesAZb2DsRs5MDSDYArOIeSAaWPCe3Y02IEF8hpzGKcSnUW3bF42xzqKIrkKrWGPil5Gu6M0sa8+9N4mgjJJBRvOU4I4ffXQImP8bW8xn7040bqHt62UmPlC5KhY6wJFgX2UEWp0lFDiuqZ3pR/J+ZGrtmp09BZQkwzPzJriqGJbCZBTnWbwuUsz4yWCQHjCO5bSnKg5UP+oFuprhNkuI2SEaBN8AYBbzn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 01:47:50.2888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488ebeab-ce84-4b56-9fbb-08df2fde7b0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
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

This patch adds debug messages to collect some MES queue reset data.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0ae6e990c310..0c1c8ae822d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2495,15 +2495,21 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	 */
 	r = amdgpu_mes_suspend(adev, 0);
 	/* if suspend all success, it should no hang queue */
-	if (!r)
+	if (!r) {
+		dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", xcc_id);
 		/* always reset the KCQ/userq since we need to signal the fence
 		 * and we could be stuck in a loop which is preemptable.
 		 */
 		goto fence_reset;
+	}
 	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
 						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, 0);
-	if (r)
+	if (r) {
+		dev_dbg(adev->dev, "MES fails on detecting hung queues\n");
 		goto out;
+	}
+	dev_dbg(adev->dev, "Detected %d hung queues\n", num_hung);
+
 	if (hung_queue_count)
 		*hung_queue_count = num_hung;
 
@@ -2530,6 +2536,8 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		pipe = hqd_info[i].pipe_index;
 		queue = hqd_info[i].queue_index;
 		queue_type = hqd_info[i].queue_type;
+		dev_dbg(adev->dev, "Hung queue: queue_id %d at pipe %d type %d\n",
+					queue, pipe, queue_type);
 
 		/* reset any KCQs */
 		r = amdgpu_gfx_reset_mes_kcq(adev, ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2ff1816adfc4..58766b27e150 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -557,6 +557,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 	for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
 		/* Finding hung queues where db_array[i] is a valid doorbell */
 		if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
+			dev_dbg(adev->dev, "MES: hung queue doorbell 0x%x\n", db_array[i]);
 			hung_db_array[i] = db_array[i];
 			*hung_db_num += 1;
 		}
-- 
2.43.0

