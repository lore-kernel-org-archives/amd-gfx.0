Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01ADCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BF6112DC2;
	Mon,  1 Jun 2026 05:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hy2TpdDz";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98815112DB9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV1fL3AlJwoffWyUrzBNL7aG3VSDbbx46dbxQUphyXvpYczKFaYD7w5PuLDviUfOnNYqApBWFAKukMomFZuzGhuIo4Vd6P7yAuKfXIxDWUf3iWpXq38IW3I6OTrJ2xoO/w6cJND/LCF2ECg0cikCRavNPJZUz2XAZoThHIy3gAnwsHpgqrZKApiFNXBq2aGo+8ZBuH52cPNNxskK/rEkfsudR4iqsJDWRsVkRAOibDvMHkiNde+fz3iGX1ouvOBJ2pKU5KhawmaAqwBYLYBj+bbMkc3SIfc1lAudz6lIZPlDidTz3JOI6LmDhwf/5uj9EenkK0mS0/5sSO2ycLTkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eepoR3Oe3Jl2B7MU98wQ/yesHuEdYCBXABJy7PobPfU=;
 b=U758SIjt5VH3EpT7beFa0UpJumpq2IQK5Ytnzky5v7JgW5/xUSavWV2YLrPx4N6OM4qQOP7rdfAAQnMTyCyxR6LdbuhWLi76gnjFLztyKY/uFyWyJ1Gm4JOyDmudB6yJVFHZPqcnQb12E2+k8nP+LPMzGFt8ey25T+hXlsrrxH6Jo4jYbGFukVYnGnJc6BpTMPH7lQRBey/9uojnSoPsPTVHn/n2rmqxp3aez64rkW8mTdyVAGfWrY+x8iNGXtud9EffyGYNMxtBcjvcgKU/zNLvSz69AP9dRGWx4BaVqIE1QugKiMhl+MWDd0plnQgoOG4T//h03gBfaZZ2gAqg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eepoR3Oe3Jl2B7MU98wQ/yesHuEdYCBXABJy7PobPfU=;
 b=hy2TpdDzG+dGjPaNILGFb9ZwUdGPSjAaTpr6Ml90YvYbujCAhXuDmp0cpWSxDv7JZ7pyTEXJUfaiFM7WTCmpsQvLymlxoqUnKmBWTnOljbzDOV+mEuzOm/VZxlax9v2bfKYcW6ciImyJBERP/lA4vIPKB6sJcn6gOKdGH4ZxCL0=
Received: from BL1PR13CA0331.namprd13.prod.outlook.com (2603:10b6:208:2c6::6)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 05:52:05 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::8e) by BL1PR13CA0331.outlook.office365.com
 (2603:10b6:208:2c6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Mon, 1
 Jun 2026 05:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:52:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:51:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Michael Chen <michael.chen@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 11/42] drm/amdgpu/mes_v12_0: use mes schedule pipe for
 legacy queues on unified MES
Date: Mon, 1 Jun 2026 13:48:57 +0800
Message-ID: <20260601055034.3700921-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 04235395-9f22-48fb-5616-08debfa1e8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UKl1+1Fz11FsMjtnzPQw8qxvmBd0fFiVIInsaIR34+Oi9x3xHvmOvMlDymrEB4oanxHp2UNIqcqA15HNxquZ4gz0aSwcmVEyDdSwxAp86w1o6qllwOv1xd+MEjt3RpDmEc1GqYD1L8YmKsILFShaDgXp1xYf5oEZ3KGRxbIEaSDDc9Mf+8KqMeHyw+jmP96NDSB4D4jw3dyTPdw6uYc4Tm44XCrZApj8qg+ylP2nyAWnWx52yHCPdwBpMoZQqT0+JJHY9znDyzYL5euDoPHG3Ai8WWsE7WulPCmBEbLSzYVro0OHP1ftVy3uk8Z4M6AuRjMsUof/4mx795R67FQJoq4AaoKGvSv46fj9hBnJO5xVlJIa/QAEStmbjLpWlD9dtMNdR6dkRu9bTgvkgMNmGsGOuzNn+NL8cjw1lyPgJCgCWGEZZmR1tSuxYJPfwZW+JBSh2W/iN5YtiGJx+NNMgq4Ww7kkbaKoqiu7aNQsSZ6qHB9rpud5DQE2ppAgFQzBIt1v16JBg2RYBCw0cMYp4auSNlfUH9rrkEZRmc0Y9DMDtkMR0ur77jmMMIJA4vDWRThXNTlpbCimiuXQRcrkpoSgusOFxqX9W6/bOva2P38m7pqvw8kboDSY0dB0vIJ8HLWWhnpGz6LKLqm0y91DhPQVfqwa4ClGBUCOM0INqNGDQA0HBUzoPjPxfZS/30MN/IXr0F+fJKwBvV1K2OyiXf5vRfYyzoOykFGPHKhc3l4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wQksb8aLmLgI4zBiL7DcJGIbTM1cCMuVTbZ21XVXbur8wIfaOXDZRNgjBU2U3jz4eyEHc0mJM8rH6m8BkJTyC0p2IP9dUfKbODSSywq/cocNW2Wtpl1t4wdXaJWVOE4be+Pe1T24TaWXTDjrAGRNNbBYo7cvpCVvNU+PKCMdgH1YvhjHlyY6RUvg+8/x+TdY83oL/zTraasW0Wk6xXjraZY2GPrm0L7LeMR1Nvh2DEcJanIyrgcLyVZ6aNNvlkyghCoIja/690zRKvWo6ybFFpeJ+iRdeCzH0DQ8prjamwUzKI3XZpC1jZJYJOaAAl2gj1TGUwWTooYUTeVMy9tYtNZr+D1eS0GXEfjEx7If/MpWLDyZ/Z9r+fLbainP/U2Sid3EPMzcNKOa4yljVywr/PSjUHhWx16Zh+OLPZPq7Cv+fwgJID2T77fMC3zsWR7q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:52:05.1667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04235395-9f22-48fb-5616-08debfa1e8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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

when suspend_all_gangs is issued to pipe0 MES during system suspend or runtime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, leaving them in an inconsistent state after resume.

v3: fix the schedule pipe issue
v4: use schedule pipe for KQ resets

Reviewed-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 27 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 8d618df19285..36886c2d5c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -528,10 +528,15 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
@@ -567,10 +572,15 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; unmap all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
@@ -913,10 +923,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	}
 
-	if (input->is_kq)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
+	pipe = AMDGPU_MES_SCHED_PIPE;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-- 
2.49.0

