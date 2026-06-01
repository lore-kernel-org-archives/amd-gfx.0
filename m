Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEF3CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDBD112DB5;
	Mon,  1 Jun 2026 05:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ncZOtMnt";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58022112DB5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei9hnF+X8YkzWhr6sTR4TCdH2nOk5OEHkDRZly4nifWSfoI+pn/QGrT12X3dAq1FSwOZLShz4KyVjBtTUQ7y9E2ihGxHaGdgrDBK/cXo6hPvbbZ7T6OVGR6XtigMddOE9V4IBAJKqjcPp//2Y8CMZIrmK8+vB354n/uMHILccaB+DhDmVwkGJvTGoiui3zWzrq/j4Qd3pAgu3pS8CCZ+dDONfHxjDHidHIj5GCGeAxDxZNhD/J6r+cumY1oiWEI1MG6M9h/QJDXfDzduAyswugU5jaQAfTO6/lXJ+U2Lwx50KxFaRYZGgdktJEa8OIWr+uqn/Tz71155ZgAwYwQQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRUOsV1FnhMnYaHugLRZuFXSJ7MQiQderAdB25kVdAc=;
 b=Fds38OEoP5zxEvf5KfuhqiMITbCI2++MQue5xqSufM2DQ2bcepNgT2DELLBVNN5n2DUKpU1niaonGh/NRFQEzwcFeemde1y0pb4syDsbJs1zycmZ7uL31hPiHLYOIJCl2hIB3H5WdoNcCD9P3vE+dPkpWVcKVrOCtWQhiXtGP2rphKd8HQU8+4GX4d+J99PGoBgv/3Y49AgfOftEMsqcwi2hDBXBnEg4NNyrGXW7n9m+klbcAH5Aqe2HJdWRY/CWnq/rZPOyNxYxa9FvfRC9ziq01SfwIfG7SWQWD+GDyd3N0o/76YVWBgO258AL5wZ3LaqkFu8vZ9qhXY8QMsFX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRUOsV1FnhMnYaHugLRZuFXSJ7MQiQderAdB25kVdAc=;
 b=ncZOtMnthpK13fDSMp+BgaEOGQCndvUlKa/bSTFAg/KvTr8lep/A5K1bl09DdWLzT50i+9CWtxniBswxl6BXQiecIYqeNkSOO7sNTB4d7FMCkLSKdngPDCke0LCep5j2Na5VGRdwFyiO83fY0f597pbPKFkdEBZVtgc+PV+kTNw=
Received: from MN2PR22CA0028.namprd22.prod.outlook.com (2603:10b6:208:238::33)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 05:50:42 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::4c) by MN2PR22CA0028.outlook.office365.com
 (2603:10b6:208:238::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 05:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:50:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:50:41 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:50:34 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 01/42] drm/amdkfd: always resume_all after suspend_all
Date: Mon, 1 Jun 2026 13:48:47 +0800
Message-ID: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9c2827-d806-4a50-8a86-08debfa1b72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: z/ATGTgly+3ceUAW6DDcfvyye6lie9eO2qWZ9gl5vI/IJkubGzvtunw8EcPcDc95uOQjek8zCIkAW+0OoWneiRgE3Gc1UdXqzUY2pIoj5IjyyAGNQVcAYuS7zdKHrGP5cVLq4OAFc3n7Q3EXMw/8N8eKO+p+mhPOf061GQaGQNDHIUNKWtcYtx3zL9PuWqaRGalZDn1FDoJMm2kzMJTsq0fhJkfEsBAPFjstMI1HCnIi953YQi1JMOMDnAcX3YFLqhXhlvAcKTwZpONaorvvZvInSi7cGtTWpm2kN+YetNQS3qJlfNSTvw1oHSFMka6HWDxvVkaoTSxLmov9nb3omiQ5DUJ0iMKB5koiLigdnS6n8pekS/zN8SJXNmygt1NDYp2VIJhLxJFSFdzkuSo8e2ov3i1H9yI6+Pd31+WBmjAB9lde0wOYrVn1Ix1RGWq9Xbs2aWZX15Ad0a+hsk5myi9hWHMnUzSDgcMEb9MuNFhK5Q13TsGBEboQEM6w7UXJJP2eYAEdjcf8vN8rIR12CHzOjJTmdsfem+q6LbR7GmEnvY6TH5fhIAjGgOpusYMEa6E6x4ylL2XWnvQBTylqRWTHeQ0211rQl8ifxUYSC56Yk827A2fRM3KNZGl71ooAvo/CEIh8hACwWI9W2g4NukAlm2MOpjGfxYpYfzq5/UXZ6fk9UoczAuIXVl1B0z6N4KcXC0Lkm4V3825q6uuaOhb4eJsg9LJPPOBrfbHMuNY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2AHYYJ0Cr/UYDGJcp4ckx2bpgB3KM+iInnmD8ph8Ny6TxcXQjFaIPjFkVQFMPE08iTNZVhmCD2CR/BqIz69iUGKjkg3YbMIeN2QPTX4Ff5vo9zz9TQB1jzkiOgI3BXXB/AH1eS+SHQ/WrE8d3NX5PVZmmsRmVzuDEKCHeAxZ2ufLBHfxGNYVuC7Po9R/WBOMBhN3JzMMY2lZX2QcuCxjDkNoEVhsWCdD4llc2OJzLBMtShUNMRc+iX7NVe9EZwX2V44svEhcvp+K7ELOjXlLrl7g7mgVh4KlRAzWyFK03m/ITpG6TAQeUcn9bJ0d+m5EVWMknA0oyxri9Li+4BFM1Yo0Ox1ENo0hcsxYEjiKzErnZ60vhngLpafDzCRcicU2hkz4TIedvhPgPydHVzuh4saUYArDpZbsnfFnalkKu6oKPGYka0PE3xEz2/vv8bhz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:50:41.6495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9c2827-d806-4a50-8a86-08debfa1b72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
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

From: Alex Deucher <alexander.deucher@amd.com>

Need to restore any good queues even if the suspend_all
failed for some.  Always run remove_queue as that will
schedule a GPU reset is removing the queue fails.

v2: move resume_all after remove

Fixes: eb067d65c33e ("drm/amdkfd: Update BadOpcode Interrupt handling with MES")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c351f7cff055..08006ce8126c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3258,32 +3258,24 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
-				ret = suspend_all_queues_mes(dqm);
-				if (ret) {
-					dev_err(dev, "Suspending all queues failed");
-					goto out;
-				}
+				/* suspend all queues will save any good queues and mark the rest as bad */
+				suspend_all_queues_mes(dqm);
 
 				q->properties.is_evicted = true;
 				q->properties.is_active = false;
 				decrement_queue_count(dqm, qpd, q);
 
+				/* this will remove the bad queue and sched a GPU reset if needed */
 				ret = remove_queue_mes(dqm, q, qpd);
-				if (ret) {
-					dev_err(dev, "Removing bad queue failed");
-					goto out;
-				}
-
-				ret = resume_all_queues_mes(dqm);
 				if (ret)
-					dev_err(dev, "Resuming all queues failed");
-
+					dev_err(dev, "Removing bad queue failed");
+				/* resume the good queues */
+				resume_all_queues_mes(dqm);
 				break;
 			}
 		}
 	}
 
-out:
 	dqm_unlock(dqm);
 	kfd_unref_process(p);
 	return ret;
-- 
2.49.0

