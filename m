Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77234CD4851
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 12:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139E310E5FD;
	Thu, 14 May 2026 12:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o75TCGuT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC57E10E5FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 12:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjAKdsQP79ljPoPcoB96Uc+/d85absvJCPkUGh1sCAqZVOlCfQ0JqjZsIYD8m20eL4RCYoYfxLHdsTB5w+osb1dDnNeQS/3Yat4ZikkruvW/nmZ5O+votkBrgHuTjs3NlmPgJzKkxWQgEckjO6PJm4/TQAWn3sR06lHm8IGcCNVNQcSfiHhKdjzTIjaVesR06a8QVO6on98fxevhGWQK6eHDoPK+BKF2SL6yvnxv98jlQ86yQ9UARJmfgOH/EwxbI3TTjl+6MKN7f1itMXzvD/p9xN0l//5PMcusuFkl+/9ab0kWPbXybaEX4JraarA74MpKW6nVcPywL5oz9bpwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiFjVFZVWrQVIjKtmstHLhmG4WZqnA47LLZ+Qr+IUss=;
 b=Ut0mDhdqVYAgBsPrIUhkGFsarbfhN2UtlKgj62y1LkZKX3J9Bmi8bZPsPspvF7Dbxmv4REKT6LKpj6bpmOIR/4kYRoXLMzVJbmk3BplMoN+gE14hoVurUrNmMAhxPJxch19Z5y+tPQQ44lxtMIOMB3GZyNyKisij47x5O+hf+5fwZiya3BBldB2ZCMAPko2P+jxyo4XXF7PbQp3CEs8b7D7Ag5U6thR/lMw3E12M1P6PXjr5o5RmUj00pQQ0B6cXLAZS7wgFUazKoefuv6qfyhQwB9SaxxLyF5zbvwxOwcu+F/mReAculGWQ5vCDbFXhxhgvFTCJO//oS6wKm+sQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiFjVFZVWrQVIjKtmstHLhmG4WZqnA47LLZ+Qr+IUss=;
 b=o75TCGuTP8hXeOa4bgbdH6N2Y7AbfK4E5OOB+WmjIrKgRozsDXWXY2fuxVPxRzG7qij5WG/ZCgsRIiPKXsgeAo1tZM/k4oDwPjwK6fojrm5h+NGuYB8SRNpMXLm67T0htLxP96j1llNDCXA8/NNPmMr/LT5B3feT4UAp5/t8Dhw=
Received: from BLAPR03CA0153.namprd03.prod.outlook.com (2603:10b6:208:32f::19)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 12:43:03 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::8a) by BLAPR03CA0153.outlook.office365.com
 (2603:10b6:208:32f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 12:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 12:43:03 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 07:43:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Date: Thu, 14 May 2026 20:42:50 +0800
Message-ID: <20260514124250.3833711-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514124250.3833711-1-Prike.Liang@amd.com>
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 99380507-e326-4761-813e-08deb1b65703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: ODMxUsKYyxeI3czJXkVJuprO4vZP93wnh81PJLCOfH3um3FzKX0IHjWFT+Yfm9Nb8WRe2IMjShxxoyzR0ZSjR0PU2VAjzs6Xk8JinnSUh1xvHJIxDg8L7XBTb+w1V6jRPdgbJ1IQksPaR6M/NGjotg29yBBkYnLm4WHFvaH6/eNTdszug+3z4/IcLtE1aDrtQnyl4EudnlyzRXWMScpqsA11Ob938XOaNJ5xBbmiSrW+nF4ESHxPMVFiKacqdrBrZZkzhdjFJEGhpC+tsLP7RJPuC00EyviVaChboUbCcN7u24ye9hZ6ylsUTaiSSzJ1Oc44JoiiTxtWj1x+a68EhPHL4M+mD12DwQx5msm0y6Uft66luWXtzvoTZowYcJ4J+0v5f/6aczBoMuNl0YE9GS9UIdl67bF/l65yW0akoqrrzsVn6VB3qmofQ44RElMNMDnuXQPmhDt86BjySzb1mEDsMMjduGkZ/VQ4a4NGJZJi3qDHLi80pE1WoGUYeHivCT6etsXSujUZBax0c/ihS+G+xF5YQsKZ+zKrromfMUNPgYiojACLeNOKkqEAgu7G3c6Sh6p4A6SzInl8hwaPnLlYNJF+LJwgwvvAn4B5UEJJDpG1k6s9H8nKvTk1QMA+iCL208K+aonP5JSWejVCvvCKS5DSu+iKrC0sQn2rwLDyFzIgSYqvknZG1z4VW/YRWsC/iXK9p5ljOlA9wmvtZkOwL1FhDbQYdY3TMarm9FU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GSUtpZkANZzB1OUw3Xnip9JT3rCSqAsTOy88ODxbb1liOE+jdBjWyF64Z2PcLq8qEcItTSHsCatRZBenH4Kg+BNI/Ua3Ewv8YFX6mZ8as1myExmVRAqKNeD03pP/R62SMM2WYIcXfK3T9Q5ArEqnle0w3Dk02HdtO0oZOJBFf9EF0pU76UqlaJFMEDMcAK2gCLRseU6mWI8cg+VQyCrNQVEMafionVN8TjMx8ocYV1H3kYtqhMQHvFX6yQK2yUHIz/jKKuWWFZtYJcuI2WyjMboQoxSfB7hYin7gQ+1gQdbIPrhbqb7rSnCjUQOgHRQoShc1NHc8oLoqV0l0UkKoqBBbZ879yynWDe3iqQSpI+35QXywWNJMGCABoI8FCgah2+5P1SkYgqSYmnBliyTVtVWZ/OouxkJLeCBC51fXCNQl3WizgYpI5ZDl6ghsexJX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 12:43:03.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99380507-e326-4761-813e-08deb1b65703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

If the driver only preempts queues, there can still be inflight waves,
pending dispatch state, or resume/redispatch possibility tied to the
same queue. Then the VM/TTM side may proceed to move/unmap queue related
BOs during evicting the queue while shader TCP clients still need to
access them.

So for eviction, unmap is safer because it makes the queue nonrunnable
before memory backing is invalidated. Meanwhile, for a idle queue it's
more sutiable for unmapping it rather preempt and unmapping also safe more
processing time than preempt.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2e3edb6dd506..a63dfdfa4195 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1048,7 +1048,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 			continue;
 		}
 
-		r = amdgpu_userq_restore_helper(queue);
+		r = amdgpu_userq_map_helper(queue);
 		if (r)
 			ret = r;
 
@@ -1285,7 +1285,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-		r = amdgpu_userq_preempt_helper(queue);
+		r = amdgpu_userq_unmap_helper(queue);
 		if (r)
 			ret = r;
 	}
-- 
2.34.1

