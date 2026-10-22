Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E71606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p0FBiH4L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5091123DE;
	Thu, 22 Oct 2026 08:21:06 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5901123E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye3J9A/oKBYa4NKddMtWEz980EmOvqm0qGkiB/SJCZ2VwhT/+lwRIRLFFRiScsH27gAgXGa+0VFEDEC8wS4WPVaUlkeZf9SLXxpPikb+Qeo2NqzBCJqFeR3HVwX9lAwPs/cVt9wl/2rXzwXRDRbBNbMS4T2WiCaRClPna+n3YW5E4DyQ56rJbtsXz6Zhb3BvPU+PTpTljcrzsaDGF1d+Hm4clJPGA4ZXpbRSIcTTb117MedK81OHQuc/nfQHxEzEmyKd2QOp3HZhrgF/f0/OT1gSZ5RCD14mHGCaXbPp0egByacuIu9197MCMAxuBX5g2FOIX1yNU0PDSeYWNq/bPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuOuv9veVqizeR7gMWrutt6Px8GhiNeuX/QlwLzuWW4=;
 b=gloCydjNSj2/W9fXjg2tSqLu++nvh6qRyhl9ZUrj3hYZuE+iQY8ffY/yNGBkRILO6sTSyiEA2T7RBfMfD0nPUBrjissyHrrzFfK1fsYh2h0yFQRQxR58dme0zUPTqvCY/SkciVgzVoB8KVzhVBJIwp+kDiJ16mo5yjOWNIrI2AK+XsQZYXTgp4gHThH789PsJ2crCLp9FhMS+yfuU5NfMvA81gCtIFvysly8dBxyeMtLg8Lo29TnzHLNXYKiwdpOLxobmO2gGVFYL9bI0C2N7rCO5dHj/v8Ya13C/BdlWOf3wbB06tmLjmYkMnpl6J6WoodxkQVvukMf9FvdENtLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuOuv9veVqizeR7gMWrutt6Px8GhiNeuX/QlwLzuWW4=;
 b=p0FBiH4LHtMuWe8klW3hdYwsWx6TKxEFTDOLgUgDLRZCwBXJWKZGonfuSgrHR/xdZiwSJOK/MDLFg1CS6ikihJcy0/HCr0Vd3tgeEIiHqgqRUMz5MDsYJjR30AChCtb+sbxyw/PZOPlQr1pJ5/v2joem5KXkwUDpcCusZGZtdD8=
Received: from BN1PR12CA0015.namprd12.prod.outlook.com (2603:10b6:408:e1::20)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 08:20:57 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::71) by BN1PR12CA0015.outlook.office365.com
 (2603:10b6:408:e1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:41 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:40 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 11/15] drm/amdgpu/userq: reset the gfx engine when a gfx
 user queue reset fails
Date: Thu, 22 Oct 2026 16:19:51 +0800
Message-ID: <20261022082011.331462-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: efce27ce-4097-49c5-5978-08df301565d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ekonV6vhZk4FiJ84edW/+WIdd8nSnl9vH8WecFYJNj04ynQU0meal20QyK1OPMxaqFPkvdWjj4ieii5KpPA6wLMXUy/GW06u06eEtPuuPxLhe7HATAG5lUXm0bSRFlsEmJkP+ZPgy/ORcXyYodORY6yZa4AmFwFyENzLXm/9tsh72iLBiLM0JMgn39iJzAmayjn3DpsxG4ZJddftIkhp2MFUV9TpOSFkOLQ1GcLkB9dibnlUfg72J9WsPCAcYxZhhG4lmOutii1rvIxXdqqcjwTIQqX3lan27YFeC5YzQJ/XW6OTrOMDM+akUR1mZN5uFO78V6/imoDR/AbWqu4sA/ssjiDUFPAO3dNE2grbu054Tc9ik5RWQ0v9HJbPUSMdVJLBHUr53DcXopjKyr/L4vML++ahLpK1OzMCSxnhEntkI/Dzbb8+DEF+mHGq67uFq5kRcVmU/864bx+nAj8/XRug+wVy2YXVH/wKYQXhzUdkyoGtmp4ns9KwvVQ1Zk6Uouu7ZBXS9XF9auohiyS1vI7EhsLboO0Lxtt6Xcc1mdTLf72LqC1bDEpkRMdHz3YhrDQZSk31jeLX7FG+9sX/VV10ry7tDg7tYzJrJEbw6PsBZIJiW1vF/zTMhRKfqKSFEqqgeE0vBUV49e8st3uMc4dGEghQ9zlyh/hjaC4RYQhnfvSEvS0tW6laHo9iPpCeLW1NZRdhiaaO2+Wb7MXOkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hvFNxoFnNv1q0Bpgjt617bz0dytc4gRCOib4rhMBWJE8dyFEBNLzvwHI+u7rZYJvZULWfUjS7CjgRJVgHfYdt3moEqHlnoE+9PPap/HX5uB9GPHMenLZVAWimf5dbG81RcklIVicrvbEGaPqP/rToTI3bPtr+WTiHRv+LAWOzMdtNm/m8z8sPT5iq/tagrs/Dmk/NSETdoZw9i0umsO32o3+WWWsmFyj//rQKWf9+MFQjc6Tj55At8Seqaytcxczv6URf7AgU7mgDBHXua33p/t7BUwuzVPmziXPhxTiZxE1qejm2EBOt3FJroH9LLKjWbWW0sshPfoddnOvpDKFAxNwAFXfym/h7SOs3e+KhK7sZNLJE74XqApK6nLsMNBBVQnP8fIMrY2hJ13oTxb4bS6idCEY3wT7AnJjwA4b0HUgRrtfj+en9qXqEhSUEqXJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:57.0663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efce27ce-4097-49c5-5978-08df301565d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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

When neither the queue nor the pipe reset recovered a gfx user queue,
fall back to a gfx engine reset before a full reset, as for the kernel
gfx queues.

The hung queue can't be unmapped before the reset: pass it to the engine
reset, which unmaps it once the reset cleared its HQD, and hangs it,
while the other gfx user queues keep their state.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..d9be93677ff3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -235,11 +235,19 @@ int mes_userq_reset_hw(struct amdgpu_usermode_queue *queue,
 	return 0;
 }
 
+/* The hung queue can't be unmapped now: the engine reset unmaps it after. */
+static int mes_userq_reset_gfx_engine(struct amdgpu_usermode_queue *queue)
+{
+	return amdgpu_gfx_reset_gfx_engine(queue->userq_mgr->adev, NULL, NULL,
+					   queue);
+}
+
 int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_reset_queue_input queue_input;
+	int r;
 
 	/* already reset by an earlier job's hang-detect; just signal and bail */
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
@@ -248,8 +256,12 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	/* A GFX pipe reset also affects the kernel rings on that pipe. */
 	if (queue->queue_type == AMDGPU_HW_IP_GFX &&
 	    adev->gfx.funcs->detect_hung_queue &&
-	    amdgpu_gfx_me_pipe_reset_supported(adev))
-		return amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+	    amdgpu_gfx_me_pipe_reset_supported(adev)) {
+		r = amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+		if (r && adev->gfx.funcs->reset_engine)
+			r = mes_userq_reset_gfx_engine(queue);
+		return r;
+	}
 
 	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
@@ -277,7 +289,11 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
-	return mes_userq_reset_hw(queue, &queue_input);
+	r = mes_userq_reset_hw(queue, &queue_input);
+	if (r && queue->queue_type == AMDGPU_HW_IP_GFX &&
+	    adev->gfx.funcs->reset_engine)
+		r = mes_userq_reset_gfx_engine(queue);
+	return r;
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
-- 
2.50.1

