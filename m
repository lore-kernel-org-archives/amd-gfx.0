Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F3FC5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5407410F74B;
	Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L3WKFIj8";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABEB10F742
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP+i4y9NekUO0q7y1ePD6MXsCdxztZQxqe2bQyYToKpf7AUbXTPrvYqnPC7lt6Oq5eEMVeIcG2ltXCbVWCUkmAK8ZpG1bYfBhPcaV7O/KZe/4wEH0RkCo6nXuo5XzbPojcFvc+yHvPWghwQsPtVgFuVCEvxlThVau3OsOamDblCC5dsI64iyJrUxpISoSLCpLZdw/A3zjrAo7wtScE56XhRITTw6UcpY4vx+Kz1efsSsS6/7acq3GR/nBYqhF9+nBuicg98SMv7xXZVoJCntn7diytnzCeJYyff16aT/uNKGDcUZElUEYPVG+7I7o69kYwS2jWP2noPrJ85hKjqnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf03GOXN7bUpI9JYjqbNPRAYdtpnatDlNXhPWddfrRI=;
 b=J1qBD0jyfx05kgxfqBH6Xsx0/VuUFthRJTYHlp5CbAehtmQNSHcsgspKF8uxQaeaKwuHRlnv5sT0jLeTxFcVc8Y5kAvl/1+5Oys5nbdRee+Y+bRzWxx3PInZhgD1QXFFNZfppBRXbWx399RucsaWfBPH/k724mt7oQnjO60m+I0ajzxNebi0PfVKLobP4Qims2RBWIfeaTTDj9lgdBznUvNQYeSlY/bAbPM6YxZUNAXpeYz/KWvEx/Gp2sDd+tyOQJZpBnaz+zCrMUfMgIGUcLkKFCol7imqvsACFfSKCLyiVkOIn+GWoHp9B9GRy6n7iW/PwzIkkXHwJ8wZx/vIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf03GOXN7bUpI9JYjqbNPRAYdtpnatDlNXhPWddfrRI=;
 b=L3WKFIj8pnu7qMPCVzqinj0Pt+FreEsgFx1UbbmWoZwwYcQgAduT1TrorSY4AnIjcE7R+89PQ+fOryiN1SootOUBbeBMIc47Cie1U9A7WSc/PRIi4qNitiGYj8d/W3WxR083FCSGGiwJDgxBAgHG7b3INJrieEHUoH+2EdGdzRw=
Received: from BN9PR03CA0591.namprd03.prod.outlook.com (2603:10b6:408:10d::26)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 21:04:00 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::78) by BN9PR03CA0591.outlook.office365.com
 (2603:10b6:408:10d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:04:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 099/109] drm/amd/ras: allow waking RAS processing without an
 event
Date: Fri, 14 Aug 2026 17:02:36 -0400
Message-ID: <20260814210246.3067612-100-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 00278571-1af2-491e-480e-08defa479029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: QTlLAAttBjfQU8YCdkHsFbh1R1tfbnJ0aNPBc/7qEJzvb56mF+txHryrQrbnIom1ZJxQ4iIMie4j0RmYB8b9R+89kOkvDU7rb3kUKCSi+pLsiVF4w73M+RhT/Pw+NDrCSqGEu7yn6SQmXEhj+YliT8CK6o46ZBedh1QuCnRdF9iHHfVjDIHexYnktyP4XhO0cvOdeeXp1xnbVk47GQnEUl++zF6PLpI1Iv//m6agZ0ien0/O/Ur0KknSTkG3r/OJsCexFllrgtWklHqIwCCaf569L6lQWPsn24mZbOuVCQZWXy9BnbpxHjXJ7hCyi9ZSMfUQ1VJqaVQ86cBUdaDsenrQMAu5T85syk/NQaA//GZz/i5AcnlpakFmy0xM+XXa3kQgSuJrWf7dFDnbkS6/CkidDhqqgSWKTfMvQWbC84L2xrX4hyDvMzg05GW4n5gJ6Fxlk+4OxMc/GkblKBG1XV7nSSKuSX5/yG2H04W0xagFm4qj3flXOjcubXVbLdpKwUqwWyKOKHHoNAzb77bal1kNto9YE+7JaDLgWJxDpNZiYgJTFrtDe8r6RSa5Njk3JsAVEMJ74PWfqikZS0L5n7JuzO6G2PoFX9qqFYz6a4uTomleFh/WlI+0c3tsppSb1V5sm71MJxBe+9/7+fHeHSBRgOVI0S+BGJoXsOkYIYj+mP9ClbontrDvEUouO2/rwFvPxYwHiTYKbmSixALHAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nHcv3UnG7T11jXxqHPW0eshXcqsCsFGiY9E5bNB3kbAILigIGL/HczFs+OoUFdeStwKFmluEtETAZv6NkhtjUhwbIRFDha6/r3kmA1iYfZ5EckuLM94joW+XBmfhi7Kkf4z/+MgCYh7Jyo9uZRkOgn069SVa+j947x4ibWnl3v8fs1lCJlRWpmI7+qx1RLLMZxaBPnL5yDOj/UjDVfSEm/M6T0cIKq6u46jQdRd1S+fXCoR5fInZDOYw0pYqnsM2kZ8AH1S+htMnMQ5WC9g9ew41zCVsOTa9Wt7c9TSDtYFNLyCj/rI7ivvzI6pRF1+SEh7pFrbP15dzkaqCPli0sZPUCbUM8cDghFShmQw9B6c1lBntk609dmPWcw1txk/r3LDhvyn8UcZ5kwEEU6yUD5PbaCPcpxCxhH23HitR1268RUKtCj91nGEkCXIk8Hc7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:00.1032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00278571-1af2-491e-480e-08defa479029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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

From: Xiang Liu <xiang.liu@amd.com>

GPU MCE handling queues bank data directly in the MCE FIFO and only
needs to wake the RAS processing thread. Requiring a separate event
request prevents this path from scheduling processing when no event
object is available.

Permit a NULL request to skip event queue insertion while still
incrementing the interrupt request count and waking the processing
thread.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_process.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_process.c b/drivers/gpu/drm/amd/ras/core/ras_process.c
index 395d10c94b195..f313f2021f243 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_process.c
@@ -311,13 +311,16 @@ static int ras_process_add_non_umc_interrupt_req(struct ras_core_context *ras_co
 	struct ras_process *ras_proc = &ras_core->ras_proc;
 	int ret;
 
-	ret = ras_process_put_event(ras_core, req);
-	if (!ret) {
-		atomic_inc(&ras_proc->ras_interrupt_req);
-		wake_up(&ras_proc->ras_process_wq);
+	if (req) {
+		ret = ras_process_put_event(ras_core, req);
+		if (ret)
+			return ret;
 	}
 
-	return ret;
+	atomic_inc(&ras_proc->ras_interrupt_req);
+	wake_up(&ras_proc->ras_process_wq);
+
+	return 0;
 }
 
 int ras_process_add_interrupt_req(struct ras_core_context *ras_core,
-- 
2.55.0

