Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EB1CA5FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 14:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2CC10F6C6;
	Thu,  1 Oct 2026 14:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IqQE7eJN";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A94310F6C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 14:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHZnnb2orqxz+PDlZYomOZ4lcksQ/Wh0aqYVbhvlX10DbsZWlUujI/XHJ58AqLAIMG6ffJQ+OCxH2cUuwkItf96NmXQtoqrWZyGcvlooVTxVM9wtyRGcZAuAbN2JthsQdT0L2Pg7TvNzymrIANgZNsTZglVNMDjsgP+yov3Izm8PAujfxa+ICLJzEuDJ0gZtFss8qaieY/A2rAWEsJaZQRbxP3nxTHXOIvrK+rYY4QQBP1JJ65esfyduC3rxsV5kLbq/mX0byugJkr3KqYiJ5+fot40E6JwTleddERiG+yx5etGUy1KvFU8AyzQHl0+8VPjN3yLtrdqYdfT3c/6w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifa1QcSfynxNNVIhJmFm2VcRngXCDUFUqm5yTZ2DGko=;
 b=xxbwXaE5JSgYZio3s4euipPreIpnJ1duJuvwKvHdDi9+oiMpk/GLBDqYN9unS8JMJhL89smxgdR0wYZsLoM5ZJJARcKexTQb2+N/086Gi80nMofiJ3rVKQJUa4vXWESWGWB/gBCcqQ4Uws13kqf/4I/mUh6aUaKO10syNd3TlwTp1e5Z9yDAR6Yq18+YoUMM3rblhmkT+4+DGx88mx1GfRDoDzO+a+W421v0Sg3IJk98kWEkciof57oCoR2W+RTI5cFp38s0IuWL5GlNjn18/q/yeCZwNVcKkAeZKvjSXLLmRXu1C07qHtxg4Dmnknm41I49nwEbKX55ombpMaV7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifa1QcSfynxNNVIhJmFm2VcRngXCDUFUqm5yTZ2DGko=;
 b=IqQE7eJNh0oYznWPB91Cq0ERIpiWQXiJGlCic1uPTwWlIdYz+D8bUe+q59gZVe+b+nAzoztwnGBRqV7AwfG+Fyr/8/8suImOLjTvr6pLRIpFvfc3ThW08M0j363IV3ljwarQXOLN76TBIN0GX6u57pfcOkjVLqsKjDFW4VVqflM=
Received: from SJ0PR05CA0132.namprd05.prod.outlook.com (2603:10b6:a03:33d::17)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 14:03:19 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8b) by SJ0PR05CA0132.outlook.office365.com
 (2603:10b6:a03:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 14:03:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:03:19 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 09:03:18 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: Enable RPC on importer NPA mappings
Date: Thu, 1 Oct 2026 09:54:05 -0400
Message-ID: <20261001135406.4049406-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261001135406.4049406-1-Philip.Yang@amd.com>
References: <20261001135406.4049406-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dd3512-f779-4f24-b6c2-08df1fc4bf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GyccxNiNsDErJ1RY7KKNUptHNC1P0wlAJQwdQNGVrhQSc3eOlYwfNatxPOGSHtzHFDfisyoVNYN2FOSYZDtTEXGwJ7MphUL3r1ceiBqnYXP7oYQ4twwVMJK7iQTaNhSYfbAAcO8rQqn3FNa9S4chmZfQcJG0iTNm0oJW+1PLc0F0Hz4+mEEE6Duxx/vQuPyCEn24+otA6tRm4fE+LanI7SAXP+NDqZm+fea/zgG2USdTaKUg20QIctjODVKspEm3vgnWqat2iO9jWBydVdGoWZUZbezES6xd9b0xU7jAN45BIvZMglwJx6v+Acblrhtqxhez8zTNOvF2NbVh/z4dysi9vkdKi4M/WMQdSatnXX+OjnNVxr6iragG36CTnPqJyOw7CTKtRPrzG5p/aN0OOqvDraA8ldbZA8fO2O88EjB84PG8I/46NAb1CyFDVQPq3kwj2DTeKYDZ6V6eGfF9kY63/AmHkLMNgzzx6yxOe0HNss2y45f+y8D6uXocjhBgditnA9ti+4IHksozcoOn0h0KDQGKWjt59HweddhHjgGLBdu88p3TrOlCj83GBZpCXkBgCoUy+wxxZbJJ/oA99Z31DnFE17zrMV3Q5E/O19sbhb1D5TsJ5rCHbhIACVdNqfC8PZdg94E8W8zyF4lIizM21BjZVsWyN7Pt4XjSlYb2Tb/5vuWLye7gCzpM9hf8vmB8qnDan3LbCUE1QUlGuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WTFkwrgWJlwC3+1uYVFDdUI6ZaKCy9QT0zfrtIhzwoGBiggPCXB8Awq5jpo2FKCIrnPr+fKF7Ho6+t8nkoNwP+y8xy9Sf8BTQg3nYBYZyVlu52bQH/msNZrC+ZQoGJP25LdBNOBrKKwkikKtSyLzWkcwmesW4WXME0nRsfNF+wj3Iya13cCE82UmX7TG2l+DzYTTpM25traVn3y9YeKjXZ3IYq+9BZzyaumZS4l52l9sdpQzt1bIS+kL8aAHiu2zRoEsP0wh11dwJmXisbh9LggNBuv0POjKRl99rpgoAgeJRUJVflD3kIiOl6DRo9LymohVw+hKjy9DYtbhlHlDeJichPRpB8QcIsVNhytXrG3uvtUMu2l6bFkA7ZbDIe82+M/gkWThWm34Ytp7fLYQVYG7VAVs5kpKVL4Qoh3p5frQ+B7iKiUCbcFCd0SwopCb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:03:19.0192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dd3512-f779-4f24-b6c2-08df1fc4bf2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

On NPA mappings PTE.X is repurposed as the RPC (remote presence check)
enable bit. Set it for importer mappings, so the importer takes a page
fault once the exporter's NPA mapping is gone, instead of accessing a
stale mapping.

This runs after the generic AMDGPU_VM_PAGE_EXECUTABLE handling and
intentionally overrides the UAPI flag. The exporter and the remote
ring, wptr and doorbell mappings keep their own PTE.X handling.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index cee90dfa445c..8da63045b5a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -616,7 +616,9 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 		   AMDGPU_PTE_BUS_ATOMICS;
 	*flags &= ~AMDGPU_PTE_VALID;
 	*flags &= ~AMDGPU_PTE_SYSTEM;
-	*flags &= ~AMDGPU_PTE_EXECUTABLE;
+
+	/* PTE.X=1 turns on RPC (remote presence check), overrides vm_flags */
+	*flags |= AMDGPU_PTE_EXECUTABLE;
 }
 
 /*
-- 
2.50.1

