Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A36AC98304
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 20:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F142810EE6B;
	Tue, 22 Sep 2026 20:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w/oVRrei";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C4F10EE6B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 20:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQejfKh3UyQgwEFOLIAvuhgqU05RorGgLpOFp7AixwOrykCKuqCyTj7eaCddzN9GWDmraXAKg6nrl6LvTCGY/rpph3qkRwDPTh8RfehJQ9aLHVqTJA2fqUbQtLgdUzuN0W10fyFUCnm4YH26+lzMiKd9wCdnnmkoOIxm7dW00WuW4a+UQDSo5Cz1DGyufLikJlBI+SiGhoW936nc1PBbTIEFRCtOlPKepPj97vDUIkwe2VZE5/QBz5UU4AaGOZA6fXbMD2EYsV1iHZkCqV1KxKx1wd0qqTuMhc1t3eB/uPnS06cbZ/n3zVXCSvskWi5MZ31UX7ph+6vd4CCARq35Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X2RPzvrcckVVHnldwJFGYLAjlLAgSGwjsTb4wo+HGY=;
 b=EYnYVoY+tc1elK+0/PjCrDrEeQDYQ7sVhhKJ3COzlPWCCi3d28yzhrc3rnKbeRKa9AGg6MryyGS2lE/cy9qGZlqosjAUXEJV5WTmLXTGwGTmf+u072DjYKUaoQQUwl5jnmmDLFWLcz9//GTLd2tBnNPiV87SP729OwCUnfFUi1LzMNEMcm7PA+SNf42zk6c/mKGNC5Np2Nw48iECT/KIQ8OSvkxjoYHUDfUVqsnJuU1qicH3B3NA4ZYwWvc+XU4W92OLxutdzyIylz/x7lkixOzwgz18O4KVovRDSJNtaDo6yL1ybYcI9vU3UneBB32MRDlWJlfXRE10HvbpOnPQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X2RPzvrcckVVHnldwJFGYLAjlLAgSGwjsTb4wo+HGY=;
 b=w/oVRrei0gBZGtwE6EYDyiWIpJ40MdGrUjrSnM8LqxsN97pOLg3ffbJB1/255Qwt9779gXe3W/Ob73HfMPR5mIefFBHNF9PeBD986MUBJw8n+oRxp7yXpYz1pFWZWjKqrnHcufxgTlBOkx5qfY6s2ZJMjhgDVKJQETx5KklfeYw=
Received: from BN9PR03CA0397.namprd03.prod.outlook.com (2603:10b6:408:111::12)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 20:56:07 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::9d) by BN9PR03CA0397.outlook.office365.com
 (2603:10b6:408:111::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 20:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 20:56:07 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 15:56:06 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: re-check connection state before sending
 NPA-REVOKE
Date: Tue, 22 Sep 2026 16:55:24 -0400
Message-ID: <20260922205524.1269092-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdb53be-ccff-4724-160f-08df18ebec66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 62hzJMtdGDCgV/AwwXcfA0xzlBc4MBS+eO72Y2tM5pBZpLY4zDP7F4DiDDaEMGH/qcLCyGpbjId1t8AyzcUJWnal64QuG99Vw38SY9IOaFFkSqVgeJdEsctN+brFVe+fRHDgaQY7znxDQTgi0ERRxzngH13UqbdtZ6Ow5g43mU8sly9FnAOpmFoNBWdqrEAMzCRz6wHIpSjAu0L+PNCpzbL0qa/m51cSJ8q3Q97jXe+Zn7+AlyHgraL0GrgHrUcGzms53sk1DKOac9+7ugqAoMbReqsgaHOhY1lmRHRDqLBPBGU6bCCd+rUzPGKEy+a+StE27oC2EGOn6CSXSc2Bir6EVyz2iSJDDuDmSCKkuNYaxcaOITE0wCqbbDTM/g416pV3SZ0+UnpYRMZbLV6Vx50cLvGrnaVkdA4OLN5muF6A2JGwvn3+g14CshRWpdPUL5LiKKZGA6cH3wnDPtm3ZBlJEsV6fkWi9a7FIaqmnDqvKPUWTK1WaNhf8TvdwF/qf5T16zcSPtRJqZInlO+FNVziOPIcqzcYlEWDWzK1zkHMeJv4K5hBwpZMqY5dr65VcORNsaH3Q+d86Rz4MAIjFv9lz6Kn2z4tX/TZAQEbemmoe25cOWmdigHM3VoUBXGlGK0WNo6r8Htj1YElgXQvNYFyUBji59HuXgLE3HQDXBFad60VAixRWmA/diCy+7NGUr2RtLGmWKHT1W6TbpptUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YGCSLTHcy24TVlYG8BzPoCkxrMnyqu6a3xBvUgmlk/HCaut0aQ1x3lm6CDKq2eAuDN8YmMSMBbxUzyOMvJmehWu6V6AZBg6y+oc3oNeOVTWt4pKESscPpV9+CDuQjyxVXADEZlxcsVSldjg2In4ZeatVKevOxYhBWtx0QZ+Mb3M7nuG7KCQ0K6wpILHuVYqi9HN6dmHUo0gfD+Tkx7gVvcEWArdgZ176zDZ2YZWvad48iNDJb+BQUNZg1JypavIKVYyf7cAe7bJZ1Y5uYse/D5n4+UQHcHXQcMLBUqmWs7UgYGQ1uHY3voQESH1e/WKXQliRmJNlYYAuZnr5CdeKjiH0uCy3rpoVdgP+Y6niuWUCWjFxLdpN7y1OyN2hMwqQS3LZVidAlYi0lPBa/j29HwQT9WVTwPq4nd8o6uA85IL3FEJ3kfpL64RoeB+S+uBd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:56:07.1925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdb53be-ccff-4724-160f-08df18ebec66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
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

The export cleanup worker checks amdgpu_ualink_check_conn_ready() once
when building npa_release_bitmap, but not again in the send loop. Cleanup
workers run concurrently on the unbounded NPA WQ (one per exported
handle), so when a peer's egress dies many workers have already snapshot
the connection as ESTABLISHED and all issue an LSDMA copy to the dead
peer, flooding the log with repeated NPA-REVOKE send failures.

Re-check the connection immediately before each send, as the tlb
shootdown, force_retry_rpcs and unmap_all_npa_addr loops already do, so
once the first worker marks a peer NOT_READY the rest skip it.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 453315377f80..afb47a6f7c30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2956,6 +2956,24 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 	 */
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 				 AMDGPU_UALINK_ACCEL_MAX) {
+		imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+
+		/* Re-check the connection right before the send. Many cleanup
+		 * workers run concurrently on the unbounded NPA WQ (one per
+		 * exported handle), and they all snapshot the connection as
+		 * ESTABLISHED in the build loop above before any of them fails.
+		 * Once a peer's egress dies, the first failing worker flips it
+		 * to NOT_READY; without this re-check every other in-flight
+		 * worker would still issue an LSDMA PIO copy to the same dead
+		 * peer and log a fresh "NPA-REVOKE send failed" storm.
+		 */
+		if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id,
+					imp_entry->generation_count)) {
+			clear_bit(remote_acc_id,
+				  exp_xa_node->npa_release_bitmap);
+			continue;
+		}
+
 		dev_dbg(adev->dev,
 			"EXP-CLEANUP: Sending NPA-REVOKE to remote:%u\n",
 			remote_acc_id);
@@ -2966,7 +2984,6 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 				remote_acc_id);
 			clear_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
 
-			imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
 			amdgpu_ualink_handle_connection_reset(adev, remote_acc_id,
 						AMDGPU_UALINK_CONN_NOT_READY,
 						imp_entry->generation_count);
-- 
2.55.0

