Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56238C44503
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 14:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D912810E4E1;
	Tue,  7 Jul 2026 14:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qcvMELGL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A14B10E4DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 14:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMsW6KyW1kRKfew3cYQfSoGs+3BVleARTiVcX3TQj07lcHjzhJr1Yyaouslnl5Qdw4km8uoCLqh6ZI5+4cA/Z/aBq2iSj6ODZ87c9AEKbqaRmeF1O6SX29GDVRFGw+/jAXeWJ7zEDXFam3v69vE34kyo46m5ET9bUWQmdEabu8A8ItJygXZgBlSNusLdnqVqEj3G37b9P6GZTfaHPnGnxCWy5KabeRx7rTzf6/OI1TZHfMCeIY9Wv0RROvx+Hucl5LjJvr+Br1O7Y1LdUvIt4PanWetniuVPGkAL4Fcyeml74k0PeqTV7l0XSyj2mWZVZHbOiwfeASSQl7a9otepgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlkP9m81W/sFu+gLHItO2dgDCrcC0FLaP2yqT4gfiTU=;
 b=niljJngTq/MwC84+ndXELqPUa49D8N55R2DB+x+zDsOThMp6rMaC0RL/mPoeVk5Ef6ezrlSLQFjUkcp7EzCeYfX8Mt/YXF7gJd503VXJ5SiFku2r2PfENifAh3dlrTXVsv7i4sJ2RbT1DQ2SDIgNf9F9pQ29/Vn2Sjx5FzZV7+omki7FgMOr8gb2QXZSKlJedEbrYoaAyk/8zneEwoKQtDC5RIXh6BJVCGBMP04r5IusUGdRI8A7EpJ3m+TjhL+SdMqE889UJNtMvD8+I1tJgMsIDDOnS+N1Oq0Js1yqE6kBHEI138OvAKSpXgourp8LNOHEUrT7pua6MV/F3BdjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlkP9m81W/sFu+gLHItO2dgDCrcC0FLaP2yqT4gfiTU=;
 b=qcvMELGLrbNzty5mZvpD6Bh4fAIyWqjv4YYN6JvWdgz5C9hbPeLEKeJIchyaQtTWGghLMZrUq9WSjCzP3RUY8ayCrnxJwzG3n3N49dfbQJja4H0MxMlTIjNVBizw93O7wXAuL5f/QsVDnoU9yorh1wc6tdfqm0s1vB22snXoObw=
Received: from BYAPR21CA0022.namprd21.prod.outlook.com (2603:10b6:a03:114::32)
 by DSWPR12MB999128.namprd12.prod.outlook.com (2603:10b6:8:36c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 14:34:32 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::9d) by BYAPR21CA0022.outlook.office365.com
 (2603:10b6:a03:114::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.2 via Frontend Transport; Tue, 7
 Jul 2026 14:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 14:34:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 07:34:31 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 09:34:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: disallow gfxoff around gfx/compute/sdma UQ
 reset
Date: Tue, 7 Jul 2026 10:34:19 -0400
Message-ID: <20260707143420.2104857-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707143420.2104857-1-alexander.deucher@amd.com>
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DSWPR12MB999128:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1104e4-6ad5-4b10-4d82-08dedc34dc36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|3023799007|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: xBzu+KvkrjDlsqJr8z9X1kn0Qc6zhYp/3JsTOrMbpsTk5x5pSKjXaDtD5LU2BrFCAj7d0xeWSG++F4yldGnHYEh42USgXew0MNhra23BaWLcXZMA6yeA5DQYJ2FKwR9huP3nfCxuuj2o3m1Z8W8C7hSYGan3L17RhEITJ7ziW7ocTGs5NBfLBf95W2lhhxnaKGbH2K71CRT7pHFZtiFo9CVRL+dn75JcL3513A22gxGHZaFMxTVU6bMP2+TQracOYYfli2mr9ag+VigsWQJIwKAy93ADt8YVKZYWqg22UfI+f8EaFoReYqCCDXKsDryVi0vTY47h8x8ibqUiMX4KKXv3iQYSB2qaPeF2bVZ6Etu/2zUfyWUN3uD3HRBE7BU7/QO7yHPWXc3Sr0FUKUSTxFpfDlUZ9Vi+jfQ8bCpoPHOwWbiBR5fjV9M2OAbonW+EdKfGHbcZ1w8mRr/Z8H7rw4Gritxq55GrN4j1t5VTMDmkkgUGkPeCY9rNKw49OrVuzcR1f3202FNhdb8l/rrGeVTMIJqF3FsM4s8Di4xntzR2FjpXy/Z667hoSqE8YhTHZAtg/dmnij04NlqtQllfYcqwQRoKuwj5cRanvAzZxjs5qp0kEdYGQqJYjI6LImV0W3fsmtJoBM5YnPHdYYBtmSv0uX4E3Le/6M8T6J6rUQlswySTAB/ae7/96w+prK7inprXbzB6IMsy6atrCPLK9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(3023799007)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 57QSUUuLVM2zOAW3yRpuBBforpxrUc6g5J5HyM+Tbq1hGMVz6HVIBPGAFOJRNN4Mxj37fgltqrC/y2DH+a0sY3OiujHcbSb8fNH6VHihw5iWBo6Nzn8pqECMnGXaRFzjZABqc7E6fgKWs++NdKlUnNVPQL+Nunpfwtj1hesM+n1RRqmbBuY0/ktrFqZ0Xtkd9nQPlHaJyLynxpnUqLeavPVHP4GTwZbirafYimfpGn7cYFAuG9yGFO4qkAGdmD2RVHO/Ivzqhc6Nq/eoBXNhK99gHNN2qhdNBuZ7DYFDxxUFnW7CYpJJi2c2JshH//CsljR1UKKQFGawb4oe7cdqzfGIYs4kHF01mPRPTzOuctTl+PU6UIT6jQh+QaoePE3fQ2ZNAJh8yhp5rgfJvYoD7rzOVjhlHiPw4JZ7Ku9Rn66dms3imTwRWVw/t7gFk2di
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:34:32.3042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1104e4-6ad5-4b10-4d82-08dedc34dc36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999128
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

If the engine is hung, we shouldn't need this since it won't be
powered down, but we could potentially have a case where
a queue can be preempted, but due to logic errors in the commands,
the fence never signals.  The engine could potentially go into
the off state.  Protect against that.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aa5cc5642e87b..cfdee25a152b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -141,11 +141,19 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
 		int r;
 
+		if (queue->queue_type == AMDGPU_HW_IP_GFX ||
+		    queue->queue_type == AMDGPU_HW_IP_COMPUTE ||
+		    queue->queue_type == AMDGPU_HW_IP_DMA)
+			amdgpu_gfx_off_ctrl(adev, false);
 		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
 			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL,
 							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
+		if (queue->queue_type == AMDGPU_HW_IP_GFX ||
+		    queue->queue_type == AMDGPU_HW_IP_COMPUTE ||
+		    queue->queue_type == AMDGPU_HW_IP_DMA)
+			amdgpu_gfx_off_ctrl(adev, true);
 		if (r)
 			gpu_reset = true;
 	} else {
-- 
2.55.0

