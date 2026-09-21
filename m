Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDB2C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DBB10E57E;
	Mon, 21 Sep 2026 07:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JMm1MAZh";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DF310E54E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w18483VyFTJ/CW6BGwwM7FBXO24Pic/0GPIm7lDEsKl40Gt0aFiefCn0479i7z3cNU7a4YpfCvL841cQY94DNo05j8FPQJPvQpa1o4H641NGNLPUOwtvUWhGgyuzqF03IBgwbwjvcHUHgg8wpGL5tyUp4mBWIM0XKmr76dDOQLghJckxCyI9vvwmRE2eLrP+CWLWSDQfZNNSbwxwyw6UlAt+KR/pxI6Jmg9x3u0o9F9qA7jgr+iS9HuWmEKoPX/9DTcn+0llg3hHDtF5TAqEIXVMDReqhzHSqT9GnBUV2PGTLwUVl5bM3kN1Zz7h8WrbdPkSZuwH/XDJEiu9V6rZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIvALKssc270ykFv+DPy8EN0ybGOodP4mGeBG1AtWtg=;
 b=rktLVcK+Xbfz2ZRJrZHnBQSnbGvuW3RWDPcQRtwz2PjQnxsK9ieemU03bnjBQzKhTpaz5rd6C1F8qtf9lOUDdxD6k9k5/JGCcT3U2Zhz4ecL3+0Gf0LMQAWsv26Vx98k7A3LVMsg2psQBoMiA3OFO1YAtiw/KLDoIV/p7HN9kckgt/Q+qnmgTm7gjEozK2hlmeMaxgE5T6lmFNOe41gvFwg1PjIsCwOJ3cvZ2izvFtyUKaezPYNXPtTTFEgjj95G+SbRdiV0RBQn5QTrCNqwwZempAbN4HoHON+G5nVZja0AMVdZta5wOl57fIqFX5RviZQ6U7P6CTjjm2ffzwUsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIvALKssc270ykFv+DPy8EN0ybGOodP4mGeBG1AtWtg=;
 b=JMm1MAZh3n5RB8R/3DpXunZnMRdkl6rFUEUKOf/+tIJzseZ0jjkGPOxwVAFh55arXJL/roh0KrH0dqL8xu0figyrDqVBul7ogUlgEulmRYqQoTdHpZqVLLUuD160KdVFL6L34eWaBNK1cmj4vr9s0nKr2fCiqPhWUjaeYliHh/A=
Received: from BL1PR13CA0155.namprd13.prod.outlook.com (2603:10b6:208:2bd::10)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:54:15 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::5c) by BL1PR13CA0155.outlook.office365.com
 (2603:10b6:208:2bd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Mon,
 21 Sep 2026 07:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:54:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:54:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:54:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:54:04 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 17/21] drm/amdgpu/userq: preserve kernel rings during gfx pipe
 reset
Date: Mon, 21 Sep 2026 15:51:24 +0800
Message-ID: <20260921075326.2409021-17-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d779fb-db2c-44a7-6a55-08df17b587e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: KPVUEJyixDcoVb7FIUMIfWWY73VwNh4jQfnWHkfY1TNI43nUHn4zSHzjVdalNsqbCSl/c6VzEWI+2haKZpquNj9fYvAlmEuh48fDoh2BChU7PMRv0y9Apc5TtJ9rlj62CMyhrh0fT9cIjpv5gsqQRja/k46XHC1WSYL8s/MJh8Uj4irSEssqDcKGNIYSp+GIWtH5tTn5BXG2YRETsF0SYwr3X/Ih3ad0jrQGZj0UJ0+NxccjMPzYDdmiE4rycNwftCnpGzTswdXOf08wROkHOmrOTThzNuiTGoQfirVm6oN01At66oP6Kga91dIuPmB+a9e24YlhgZHKNcoouIpxfaxFw4xviPQewDC8Rpb0cBICJdPIJM6+eLC0Pn4BeoQd5zE33xxdGJYn8yb2bkrfkK5dlAPUFG0v5OSwZzeHG4MKLlOxdH0KjKb4/+/sQDiXJMtaZZOupge/05k8Mjed6+6T84cTQGIKkvYXjH7/AOsLNnrOlAEr3mzdxea4stI8j95in1RqDdUpuc+/TiQPFFCb/j6z2BW5x7xn/tzEqSpVB3sDCH6Rp4V79dlW0Bm+wdc2SVgKhA6q1EqAixtPn65tCkcL+0vRIEfcmkLdyFuVMnx3jgGdPvNtf4sQdjA3VMXPoosAhDFIIJoxZJppsWFBLpEaPAtksEtYnq3MSFawT391UdaZ+EqlEoHZf7CGoLx+/ag6zJf50319msRDHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yNaR8BqXaLNbCHCWT1nVGGLPWfkK36ZjOjIi9SSbimzVxMotNEGz1oRXDmPQ6Gz/khq5jwwxbtF/32P43an2NyD9/4vvvC5pVHcgSpLyzUJIQRPCPj7UCPbZCVKVwrTc/UFLXI/2N/nEooVqyuduktsXBeUF2R/heqraOld69AQfuYU2r2+D0wdqq0mJZwmes8OvQom8GLcus+ZG5P5r6cx93qIxt2Ea/UfVFSrvc7VsACx5Vo0U8qxrKRn2GNrWQmUFW9ohL9uR4OfblMFjVUvQc78P5dDbR8itT3qF1X21y49s78wl8SC7xVeX9eFDS8FT1ITUWzKXe3bp5rtK2vibbfzMvCCPFL36MUajUV7qQHFS91rVK7d5yHRyuYqnV2kMLC1cIWz/cFzASR3aS3K/FAZuTkRkhd11MwZwzyGjGXrZMawpUgNb2tlOb63P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:54:14.5084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d779fb-db2c-44a7-6a55-08df17b587e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594
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

Route GFX user queue resets through amdgpu_gfx_reset_mes_gfx() when
HQD detection and PER_PIPE are available, preserving collateral kernel
rings across a pipe reset.

If the HQD cannot be located, use MES packet reset and protect kernel
rings on all GFX pipes.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 948813042e98..1b06a4618125 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -240,6 +240,12 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
 		return 0;
 
+	/* A GFX pipe reset also affects the kernel rings on that pipe. */
+	if (queue->queue_type == AMDGPU_HW_IP_GFX &&
+	    adev->gfx.funcs->detect_hung_queue &&
+	    amdgpu_gfx_me_pipe_reset_supported(adev))
+		return amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+
 	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
 	queue_input.queue_type = queue->queue_type;
-- 
2.49.0

