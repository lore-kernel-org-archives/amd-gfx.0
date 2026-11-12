Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD06606A32D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yFY6eqjD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2775410EB16;
	Thu, 12 Nov 2026 13:44:10 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD7810E696
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 13:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1KmJ/vhmSQjyBKQ1KgYg/x0C3jdKq502nQsCUnW4kTzRkhaXo8OkzyxxHyP4gp1nFZNnxQ17oCsirc/Y61evV0Ec4WicDc0eyecYmT0cRqn7Y7mTdps6GShU1aIeYo6BN/1VPCoPmo1MgcJdSB42jl1ObVWUz+AQR7gOPZ37ggE4zpkYNFZU91BuJjGK+e8XiQogOubGAfgO6VbLvzIaqAUhaf81ro5eR0RrDuG+yzI8UULJBHR7TJEfToigLhtK4weXcMQkfT9ZXZXFPoLxZNaYcl9lXha7dp3rFfPxgPQ6Yh2rV5zPs+pTRE0dznqmHfoba98KLpqBgpDFGA25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwjz15FL8A2aK4GhpcKudcaHITV0aQa++CZ13bXGQyo=;
 b=nUPR2JdayURtBLADXefOEYfQSBloKJ2YaTDkgpWm9yNFq7LkB1RXYUS5JVQpRpTLBIPrZSVMoIW/PcCzDUXkqBy8bhNj3PTU1tz5CKc9qLPH9uZyUr7nQjvj75fDa4RaZROQMq5hu9xI284yvLiuMdISdmWBoQzGMtMveZdy8D5LomlBF8VFkIOal/Ve6hpyvBlTpbsCOBKZBXoG+Te9bzXY5P7Tf1y8YCWE3vjk2I1rDhnDQWVMVRa/ZAcA09SrIDcN65/TtQpcSiacOEnh9aNUik+Nl9dnLPVIls6/FiMBBX5JpG7EdgFsD8GyMXvnhVoxL/TXeB06fd8y+xf5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwjz15FL8A2aK4GhpcKudcaHITV0aQa++CZ13bXGQyo=;
 b=yFY6eqjDTQL550Pz8NqfFG24B6al+n9ipJV9efU0ZtuX6KWXIJoWzqHdcEqmGUqayWyIwYRtwCt7wWOkUkYTTmJAfK4N5lgUji+EJ2uPH7dNv/XH54EB234oKEff8UKLJCc11v0kEQYds1NU3SfyppLkdYzX10crenD+atTK11A=
Received: from CH2PR14CA0031.namprd14.prod.outlook.com (2603:10b6:610:56::11)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 13:43:52 +0000
Received: from CH7PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:56:cafe::63) by CH2PR14CA0031.outlook.office365.com
 (2603:10b6:610:56::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 13:43:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000015.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Thu, 12 Nov 2026 13:43:52 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 07:43:51 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix fault cleaner race condition
Date: Thu, 12 Nov 2026 08:43:40 -0500
Message-ID: <20261112134340.4122401-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112134340.4122401-1-kent.russell@amd.com>
References: <20261112134340.4122401-1-kent.russell@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000015:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: a878bff1-c8fa-4b98-3bfa-08df40c2fcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|11063799006|261009223027099003|5023799004|261102123227099003|261021123027099003|261021121427099003|261022075727099003|56012099006|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HaOOK+MWN37GyVNsB24HkFscxgmULEKdp7XlaTnz9q+BgpqdinIObutxafioEYR2BK/fNaLid0/YTTA7RTT2wf/ZW/8Vp6/Awfz8Irp9lN57nwIW4u2YSmuspvMqCi7vHmmXab3++5v6AXwZ3h8ltKf6u7chF3fEKbjh9+V8AJy5WFfeQZZarbwbu5wGeF/S+KOaYZdtBbcPuoWgSRr72epPtcXeng2BRVZrzJ2MVcjmpKWlVrnozsAHYm/+PghLR9NWFTozcZwHxVtsh72gXVzPQoe9xRXfEGmZdv5j2cbcHao5GB/y1A+4wdTT4XA6O7LFG5hcZSTfeK0T+2JSyLcZxX1AZVKMmBKteTyLzAe24gKHalzSm3zoc6oW+thwJ7A5GQlQsB+9Z/oBD/lpasZTKboTGhBgjd2wX+esA/amNXBetcl6Dj029smV//9XmLF43Lovjf+LmPjplHAfdHY/3K+Y3Qhqrwl6Q2H6iSrzNoaR/NsS8Ydfl8XTZo9yZJbIknqgCBBd8zneAjgqf7PfOLxXuR8rqaTNEPLJxW2URxxtEnFFi1UBWyikWnwRHdB02LnIt1vYdgqrTO7Zr7zK6BIYp96qigg/orJOQy15uoCBrvOoa1kiWX1N7dACCO5BmuT+Mrm49Nq5DzkE3oR4NTmF/xMktIORSLjFbct//IwI8p92Hg7mABVF2+LuhmYhkOs88rEl/GfFkGMamw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(261009223027099003)(5023799004)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(56012099006)(261026121527099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 75WxFzdUM5LgiYP/CqWxVwI6Zudx+O2viG+rvd/CDiWhbzKRioXxB12gwDrUra4DakoPEdyVM7h2EJdmYGT/0xV5arxpJIrsOY4LvSAUPAFpCPTDO60a3oEg0gkaD+AH9cvvI/Bf+64111iVLtEM0ICNqM+iVd97q+3CyJ3q9r3fsq+JtEsjNbYtZctPWYUMQ1R040zpKdh9etGGc0lPvE8DED4NTsAW8fgdRFXr5P45YdsCSLQNM8YOkv8QcLTKlRBVrhWULNasMz2yr2bq4SAblmuIlo06kEd+C9AFRPbPw8btAruaGkseFtswYOwGehQlX4PUq98KMMywXpUeqkDM4TYQd2nggZacGB8sxnSDXfBqMBBbScUO4s/6WSdKwCsghMSwlDaKy5dN/d88ibT0qdOOr0q96tzAgNw+aHldVFqpt3XHj+pIZDWavp71
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:43:52.0988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a878bff1-c8fa-4b98-3bfa-08df40c2fcf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
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

clean_process_queues_cpsch would exit early if the memory was evicted,
which would skip running the shader cleaner

Run the cleaner unconditionally, and track whether the fault was cleaned
with a new boolean in the qcd struct.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c       | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 86b70748617b..03d3a739d627 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1571,9 +1571,12 @@ static int clean_process_queues_cpsch(struct device_queue_manager *dqm,
 	int retval = 0;
 
 	dqm_lock(dqm);
-	if (qpd->evicted++ > 0) /* already evicted, do nothing */
+	if (qpd->fault_cleaned)
 		goto out;
 
+	qpd->evicted++;
+	qpd->fault_cleaned = true;
+
 	pdd = qpd_to_pdd(qpd);
 
 	/* The debugger creates processes that temporarily have not acquired
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 8dee8c43824d..0bd8e781adec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -418,7 +418,7 @@ static void gfx_9_clean_fault(uint16_t pasid)
 	if (!pdd)
 		return;
 
-	/* To Clean the GFX on the faulting device	 */
+	/* To clean the GFX fault state on the faulting device */
 	dqm = pdd->dev->dqm;
 	dqm->ops.clean_process_queues_cpsch(dqm, &pdd->qpd);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 581fb7ceba40..3292e616d36f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -695,6 +695,11 @@ struct qcm_process_device {
 	bool is_debug;
 	unsigned int evicted; /* eviction counter, 0=active */
 
+	/* Set after fault clean runs; never cleared.
+	 * Prevents redundant cleaning from pipelined interrupt workers.
+	 */
+	bool fault_cleaned;
+
 	/* This flag tells if we should reset all wavefronts on
 	 * process termination
 	 */
-- 
2.43.0

