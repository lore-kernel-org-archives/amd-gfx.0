Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EB5C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 18:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C78710F06D;
	Thu, 17 Sep 2026 18:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0r2erbR";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBC410F06D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 18:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Srwdv7T/V8uFg0umK/nGEkgV/ZyKhdpfImhJBHkGMrTb5YG3C/exV7ewqoqUIwxYxhvtl8awyk/Pt2RwMoqd76K2cu1ZSIawHRE3nv3+wUOFRUjVz2+NR1jiYCKwYf80wA7c6FWx4eW9Xrv30PWPe1dS/ZmW+xrpOths55n+AyD893oozwOyres97eXYYOostq1T/LaaO+hY/mq+qlsI+twkacVE2zocWxhTQ+Fm9gXmfn1CRv6uU9MD3py8HROv+Ynu3fysLvLUH0N51KMMtdVwul15TltcnoYRagTFZl1ZnbsUbheKLJIuUcAR+epWQ1pNAf+2jQ02WuWiqQSMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9aPNaAYgPEvvZCOzyvqDT/OOfZi0dPTBQ4oBe5W5Rw=;
 b=w97D7F0z8FH8IfKXerlRAEvCDdccm4HmJkgpWxEr2SX/TWnTQUcgAv7OB73koYGn1LLO+JyLhT1yrJGzbdUs3Pq3K6bF32mV6Y74A4Ti5PO4oZ9gdanfWKZUEvfVx13KjOoIb7acQltWLAw9hHrKX8fFZKXQrUIScIC6U3AGwA2AxI5QmBqXBNoXpfZjix9Dza50mWj8W2LWGzpizvoQNbRZToaZMWWLhtMlIs9E6ZotB0q9SBIdJF022sOIW0+XYmo+g0dOHKMbxy7C1SjcS2CpTJv++YsTP2ncmppVYUHRDrAGoLdaMIIixli3fjC0Fo5VF36n8ll+H1FT6fgnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9aPNaAYgPEvvZCOzyvqDT/OOfZi0dPTBQ4oBe5W5Rw=;
 b=W0r2erbReuK9pcLQqKeMxoZDaUH67xGJ60UBI3MpZUo/gM4yS0eZ+VPdj+fRhjCE7rda36eqO9oVPR7pIJnjGSsXKn9oD6sP+/XZB++eLH3PzK0QFwr2c0x5xfn0Q0O9ljy8Fhp+p83Lb5e4XtRyY+NmF9EIphiQNY/enRcsz2w=
Received: from BN9PR03CA0778.namprd03.prod.outlook.com (2603:10b6:408:13a::33)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.14; Thu, 17 Sep
 2026 18:53:29 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::4f) by BN9PR03CA0778.outlook.office365.com
 (2603:10b6:408:13a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 18:53:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=temperror
 (sender IP is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Thu, 17 Sep 2026 18:53:28 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 13:53:27 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdgpu: specify cwsr_enable usage doc
Date: Thu, 17 Sep 2026 14:53:11 -0400
Message-ID: <20260917185311.195635-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: e4589837-a01f-4cb3-3b86-08df14ecf66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8Ks0K1rTnEESye+NgMqPwYZzMnTE9mqif3VYRWnPcme/clLm2uIa1Fhj1bHO9x54/FOkuHhKL91Y67KOUlqIz5iGzFK7nxUiB7jqAo/zJkBflz6r51qunUPJxLZMuvhngciW753zYl3CtBGmXtk+RcVDoVZHfZBoum6TSVZ0FQrTcAxZ+WZtNSCMD0Sb9Wx1GwGOo8IMT3Mp7SBndcdfak5Pu0qrd0fX3f6ZQkPyCOaa7BOU25EyzBQ0cDrIlKUlPOKyQHnmB+q2p3tpb2/f3lDv+WaN+g+bM5aA2fO9qyReELQVqcu3zIIW5XQwn9hEtzthn+Wu4trjWAkhD36bcmdSdBfLXn0K+O0MbeTbGtbXEryznC1kpdblPX8xLel64CSJgqvi8KD0b4r7VGANK8uz8HF3jnBjE1gIoE3/ObnfamdlQANvnekf/j0yQw9WDEIDXZjqTvQqtVU36pzoNRJpVYzi1aarmo0NmaD4X9aGTIzF59S2BrSiEi+cULVsit0Rs1WeMj5e88u7CnfWAkPyeAGLv8y6WQgDOUnXeCLKUeC4gN/b0e+bFVVR6eB+NmX8BRzzP379oGYb3cl5BxtXpe35Wp1AO9zoqETfTA6AznjmBP5EWpSsehIMTm4PjHzL/i43tcD/0WdU7+/GStsh7kUUEYt99nrmXc7Ygs9iBucLv+WhQY8tfSIljIOioJXxh5ktCoB6jLfUZloxag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +pLOZYkpe62OAIXNcfLog7V/IvBq9MATazxysLoZLxC32wDGhQifjMcqQzQ5zCt5cG+iEA+h+elDwT07f+6vUxbVUlhtiHeAterocxMu3iP7QSrZ6KFfbGIkAxmpECBVHzEml8kqpYIa/jCHBwFvJf9IPuEzeglxXJ2/hLf3SLg1IMyLhMK2InM70E2BK6J2523+XrBz9bO/PfDkl/izyaYVAjaHNK32e+B2y6UE9TEUa3y5DTkDbI3hh8qxDYDZrmI8TaPSENHswp7F4l72ullTDn+OZFZ9lR+y8WWKcQPQzjcY7FnyfBePR7WyJ5151BxBw8ndcaHszJCfGyqwW8RsG+LZ6OWFnPqH3n2OyIpDTLkxCbxhlVh+31Wo+UhLQVbE/0bgMAiS+apXr6V+SSMN5ZY+ILCNm2VqBvAuHAAm5zhyHtHhO8WqJ8yL450+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:53:28.8546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4589837-a01f-4cb3-3b86-08df14ecf66b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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

to prevent misunderstanding in cwsr off case.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c5e93cd3ee6..182142c9be8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -762,11 +762,11 @@ MODULE_PARM_DESC(hws_max_conc_proc,
  * DOC: cwsr_enable (int)
  * CWSR(compute wave store and resume) allows the GPU to preempt shader execution in
  * the middle of a compute wave. Default is 1 to enable this feature. Setting 0
- * disables it.
+ * disables it as only in non-HWS mode.
  */
 int cwsr_enable = 1;
 module_param(cwsr_enable, int, 0444);
-MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off, 1 = On (Default))");
+MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off (debugging only), 1 = On (Default))");
 
 /**
  * DOC: max_num_of_queues_per_device (int)
-- 
2.43.0

