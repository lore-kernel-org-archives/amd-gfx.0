Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB1C624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 13:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F7710E1D3;
	Mon, 31 Aug 2026 13:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w8AZ52IH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C2810E1D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 13:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC4QcmgniOgIDGlQbq5hAwp6R2SFMepOQvMzB/OxQTtdJs6OnPkTEl5CYX0GXr1OybJcxf8EMEmL0qwPd5SiCcl+GRt5aS+ust4jg31l+xfhj6UxGE7S1/FO80QL88zQLCq51wQ/Wn/PC0L1E5+R3YK7Cg5FEOmFMGPZRUHpRFvj9oLEd9L1ZMroGuDhgG7ngjYnurGjxuJLMym2zAMPGQGKHQSL5Yu8XkVfX0V/v9M3aEa+KvQnBaNBg3lP2q7R7LKmEf6ZYA6Z2AAC6Ynl6onThShqOJ47Z5lzfFZs0Vfw2hODdxH1zc5D5Fp5SK/DIhuPjvrllGPMlXhFNbxh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2tJWmNzqNR4FNq6YY9y0oA8KxdNquF9L6/yuLE7JYQ=;
 b=iSSvAYcyrQdvfX+g7zkZwa+6xP335rX7iM4JgyXraugcc6gONLxgENdXRf788e2XbIkyc3QZ+4rVOm2yxdLQEiZ6jrwwgmQiGWZvVCMqN25dPOx0eXqFi6/o//x5GpZeKwgVSzHy3Yjq9gByF796VSNPQhn6vUziauU7csGWinWupYpSDt+QRf+SFg0uAl1oDBCcFDmJOjbWHdaohe6PVYz6/aIduhNEMZyh3qHjdp9uATVZKpqhm6tyhlyH1A0W34GVe2p08wIUETTnYh5lirvuXTh53I1ohmj7Wi2Xi1JzahGzJ7Jxj3wXK4mQ6zM2Ng3bjyerub1l3j3TPJvYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2tJWmNzqNR4FNq6YY9y0oA8KxdNquF9L6/yuLE7JYQ=;
 b=w8AZ52IHUCYuvQu+6y4VWpz7cz8QoEzfZLCAaV2pvz3RPw+1K6lAiO+Qcs12IBfnyYLH0gA5EjPpzXV37A8b4pGCRwJfqTFezfKQC9rQTN3UMv2Ityw6jpWz7cDxMhKba8pm+NAQEDjaDRXRflpT34pjVmlFARfuPqm9+vu7ZPQ=
Received: from SN7PR04CA0175.namprd04.prod.outlook.com (2603:10b6:806:125::30)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:01:00 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::16) by SN7PR04CA0175.outlook.office365.com
 (2603:10b6:806:125::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 13:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 13:01:00 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 08:00:58 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdkfd: fix scope of mqd_mgr dereference in
 pqm_debugfs_mqds
Date: Mon, 31 Aug 2026 08:00:51 -0500
Message-ID: <20260831130051.2031435-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS5PPFF8845FFFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fabe748-bec1-48f4-839c-08df075fe7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|18002099003|56012099006|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: g2nRZuxg7l9TnjhupAqnPmwVFoBWVLJXPQlRg70IvQ65Tsx5u9Jc2LcSjH/+hvv2ObmwFYfAMpaG8Fr3AL9AU563RGFXc72FZmsRs74XNi10r5U3RMoFluMgzJd2s7HUBVfk2C5qbaDH3mtXEUIktdoX0Nb7SVQrbQe6Rk4n1E4faELcwVk4uqi0jQB+ecSccgQcqypMHxnZG2SblwVc/LllaVp3K8oPMVwf0NGmHID1GSZAcbnJ96cDGmabh2UFkHm+rYhLfx3qFpK9Uq/AF7rno0XlEnFMsFE5AIwd60haH4t80H+3YRoW286DdZWWcW/HfFcb0UNR+c42ZRQATddWaF/lvOEZ0CWkCkD6dM5+EUT4MEAhkLCoNaC/pzqbr0DBYbuF2mOQcImxjuqV8/Z6ChgllqCLUAtHQY/Ra/EX9P/0cFu7f1KNrC41LFbWIv2BuoYXH2kX2en8vJUTzdt+HtzxcMdIsxlfIKDVfz24rqkz09c72t2fFtiZ3TQgPkBc2cEd6msWXPx2Po96g/oV64v0TEkGXRv8FD+yRpbHtyMKaOr3IELxAIIszpQd03O/5g0+eA365+EUECw4rJ6gXCzDLhWA6Syr2SURlYfVbDL7yxrytDiU5afG5fqnDVDfROq3Dc5zG3NpALrkJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(18002099003)(56012099006)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fskxh8S5DLes6dsBouTes5BhujvprR7+pTC/VEoCh7HkkgenbJskmLoB6XMlle04oO7g6O6saLCN6Xg2sKq56Hj4Iwtp0/gNV9mka6OraGZMxQi6zhysgxZQWC+j3nPXePvEXtkbccpL90+u51C3RyTdEmswDkZdWyjOYEFCBzGKrNtDt67OoDRQxfmawTM+O1hleoZSrvweJwjKaE8uLOIeq3Jreu+Lfm+vM3MdmAd7eIZ7Bm0WAkNhmsHEGfzQO2WK/rg1huPN7tLVEV4KfFy8A/xFf9uqExWN6cxi34ludXiW0Dh6GZhSj89blZ/oWRGjSfKwTCu9X/HE/h0b5tGhjORwhc1dTJCaKoaNv9hGeYaadhFGXgYrOGhWfz8XXC4VXNSYywiCzaGYBc25XX7QTT6aPHndRs0sl+jLijkd5qbSy4EO37VZvo8b29A8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:01:00.2792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fabe748-bec1-48f4-839c-08df075fe7db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB
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

Reading /sys/kernel/debug/kfd/mqds while a process holds an active KFD
queue triggers a NULL pointer dereference because the for loop that
calls mqd_mgr->debugfs_show_mqd() is incorrectly placed outside the
if (pqn->q) block that initializes mqd_mgr.

The queue list can contain entries where pqn->q is NULL (kernel queues
where only pqn->kq is valid). In the original code:

  if (pqn->q) {
      ...
      mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
      size = mqd_mgr->mqd_stride(...);
  }

  for (xcc = 0; xcc < num_xccs; xcc++) {  // WRONG: outside if block
      mqd = q->mqd + size * xcc;
      r = mqd_mgr->debugfs_show_mqd(m, mqd);
  }

When iterating over a queue node where pqn->q is NULL:
1. The if (pqn->q) block is skipped
2. mqd_mgr remains uninitialized (NULL from declaration)
3. The for loop executes anyway
4. mqd_mgr->debugfs_show_mqd(m, mqd) dereferences NULL

The crash manifests as:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor instruction fetch in kernel mode
  RIP: 0010:0x0
  Call Trace:
   pqm_debugfs_mqds+0x10c/0x1d0 [amdgpu]
   kfd_debugfs_mqds_by_process+0x9b/0x110 [amdgpu]
   seq_read_iter+0x132/0x4b0
   ...

Fix by moving the for loop inside the if (pqn->q) block, so mqd_mgr
and related variables are only used when properly initialized.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5689
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 9e607098c3a09..fb2d8ad9c2c5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1170,13 +1170,13 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
 			size = mqd_mgr->mqd_stride(mqd_mgr,
 							&q->properties);
-		}
 
-		for (xcc = 0; xcc < num_xccs; xcc++) {
-			mqd = q->mqd + size * xcc;
-			r = mqd_mgr->debugfs_show_mqd(m, mqd);
-			if (r != 0)
-				break;
+			for (xcc = 0; xcc < num_xccs; xcc++) {
+				mqd = q->mqd + size * xcc;
+				r = mqd_mgr->debugfs_show_mqd(m, mqd);
+				if (r != 0)
+					break;
+			}
 		}
 	}
 
-- 
2.43.0

