Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB152606E452
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0UC5Idgc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6071810F6B3;
	Tue, 10 Nov 2026 13:05:18 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16A910F6B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1BHuMH2FI5arPps51FfRTuh0cBdxphjOvl3uSgohNOBN6tFine2LqmhxHqMlQKsilzXwNIRpjtDBK1xJeimpuQtKl2WYvOcDbDojl4lcC8qSor7BpDyqW3eQBFW6OInekGJPYS+QzWt49KuozKRQf9pstNtCftsyBkPz6lVauvx/pc7WfTIuUymlSLfm81gbyS3mk+ogOVG1JS1A+KtJ/YaR8JA7hXZc60gqNbAJZELIh02q+i9c1d2UNsbdjGClhDhaalUj0RhVRy16/1J7Jzrwo9Km5Me0Q1cLlAo5SpLm9ViP+q0S8WsIbqSbGtRC3CKM6P4uxySSLj+FDKUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9eaMCLrxXRxE3qycTDfK/d4D1Ug/P10ptCapqIEqCA=;
 b=jHtHPRudLB1hqq55em5+FG7ER6jZq3O5GbPM8ckl+mCEXNEpfGkHaJ/98ZVjaZizVTKTIaB+3R6xjNcwkLsSNS2VKqJJ/l90K6vIij/1BQp2E2Tsbwe3LlGE+L3wlf8ldxL9g/6FprmTB49F7tdW+nrVSPRgJHS2qTnk4yj8mSSuKtv6F7rkuWlS5L52VorOd08e1b1NFxbjOq+odfW3sE+CjaBzCvJ6L1axtKzwVcNbTF+ZEkIsgObFm3w3/1CgWNCQTcOTCa/Us17X+2NLsc3HMb+c0dSdCapjxVwsMD71SW4DaAcXiRkw89ZWOhbA9uLAYdssH+/U9c+Lt/kx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9eaMCLrxXRxE3qycTDfK/d4D1Ug/P10ptCapqIEqCA=;
 b=0UC5IdgcQC2jvm5u5lEKLqVeURkmo7jB1VniwQ/jxofjrMGdxtTIMKd1WmO6QF6hD3Fi5nh4bJLw+fpyQpARM6YZaq18U+96y0kstCTtsqB3e/bQJJ/eMJnSeAIbQMOh8KO7MeN0te3DsgydlA1eHSucvzSLIQwWL59zpRStXaw=
Received: from PH7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::31)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:05:03 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::1a) by PH7P222CA0029.outlook.office365.com
 (2603:10b6:510:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 13:05:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 13:05:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 07:05:00 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 4/6] drm/amdkfd: pass the gang context slot when resetting a
 hung MES queue
Date: Tue, 10 Nov 2026 21:04:38 +0800
Message-ID: <20261110130440.474374-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110130440.474374-1-Prike.Liang@amd.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 528e4d11-0ba9-45ca-d036-08df3f2b3bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003|261009223027099003|261102123227099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: g9vpQNqDvHgBGLTkVBa2wF40jaqsxx4rJs9q1jbLdW5VK0i4EZ/YYmX07Zsj2dcUqCNy6sZPCRywj5QVIEpg/5Jp6xQYrMJyDX8gv1Vq5LiIeviXkDQ5EJo7u7SNm1UHabbKDQCmhPOP0rjbZinViaIckK4w2hVfiKRWfm4supSx8SjbQuWZCbFn0la53wkYiV0qczLjmeMMJWGm8t2EtNFQiCYPoxTowRaXPmBb+/9zPR4/sl2z9cjH9RJ1eQU9AYktzW6rRiNle1A5znv3/cfYvIbROIkkNEAsLin12ae71G0jOkvMys6KVusuXAaLEZHgevPoJC7FuEDsm4c+RNtXuUWJXbMk2Iggh0OwfXG0AJOm6rMqlBMpmQhi69uL2ro3QQyYPGECG4lat/AlDIFfcOH0wFfn7yejBe4rOWKtuomwFTfa6zdIlYHd5yZfm5ekjbdN3bAXChJFtJxsGjyXhgJcAb2+/46NqIMUduNajMy3TVkjBo70eTJmcJsRjarGpM8uzZPOkH1Hc6XO5F3l47Mr8aRqA1NU4Xn7q6LmyC7QyAx5mz/LE/xdbUrW6O2s6pIeEhrc4Zz4R7HDYySSukVucVGaJaW1dMG3GqN/y8XjLEdVgSl82P+dtBKANh5260dYnAer0/+atc4qsS7wFp4vpC3tapY9bioodywHhvLPI8vk1vxTrTkIewZj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T4iFzdzP85sL7xHvpmtYv3JU+OGsWJvJ7ca/W636WyWKlGc+/MbP6i4c/+JIxNGyr0lR6vwNWbJY86jSEPTLnBaVEW0enunHl1mow7doFGlWNk5voVs81jqnx/ZrdkG4FRL82sdUOURpRPIzBrA9Rx8C/7HZeweRtfjKYPLx9YoT1g9pJttOydB2CQALStBxPgZ0Mqp/dT2UEMGCXp6M4xqpjKPJ+pJOaCPOJBvDcT4ai1wt3ea638tkecqvJ1zRtMJYF3JeFLb2gekbprMQAV0Je5yzLwyY8fJe8VD+0OiDsXveOsnnNJ7dCij+2DqK4kzDXL83EFgmHHvlEK0MM3uXlRLENMCJEBPpjCygifyt3L/ExvuZms9J1YrAmq7piJaP6Ujo1DfufjNj578pGPshUYl/ZUxAjnr5NM9VM5XJ8Fd7FA7iY+HbePyopxdO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:05:02.8153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528e4d11-0ba9-45ca-d036-08df3f2b3bc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

reset_queues_mes() describes the hung queue to
amdgpu_gfx_reset_mes_compute() with a remove queue input that lacks the
queue's gang context slot. If MES finds no hung queue,
amdgpu_gfx_reset_mes_compute() removes this queue with
remove_hw_queue(), and in MES RS64 mode MES then removes the gang in
slot 0 instead of the queue's.

Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 86b70748617b..878159275841 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -479,6 +479,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
+	queue_input.gang_context_array_index = q->gang_ctx_array_index;
 	queue_input.queue_type = convert_to_amdgpu_ring_type(q->properties.type);
 	queue_input.remove_queue_after_reset = false;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
-- 
2.34.1

