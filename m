Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF1EC61D85
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 18:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1906A10E556;
	Tue, 21 Nov 2023 18:12:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56EE110E556
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 18:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMHuSBM1uk5BXcypdrts/p9iKMP1a4a8ODv6I4gQzrb3Dsmd3XKgKo9Wr5EytyeG0fhaw6wvJ1VR8oJSg0mbeOSl4NvLPucptdPcEwQDPc6Lb78UoDimaXK7xt9DtlPkCBJDjRePkxi2kwxFoQWXBz3qoozTjrzWTQEA96KDO3GlpvLyxi3wzBFpQ6+Prt8U8SPxv4LRwFOafjckfi9WmkiMWkHl3i4PO2L47FsCpzUGIHVaUmJqd9zaoG4rHqSbiTB2TjNe8n8K3I3pOHbSc29+NX7rpGTnEE8fPXk+9rgv5MhtvP+A6GSMkkJ6J1F7aED0M4dRT4O3R8zod/UlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssQ4Yr7Ver3oTpMBl/KrUoFjnDijHLncadph/ptPiV0=;
 b=m5PKCAcJQ8oere/aNeBo61JjkMxhQYJWQdsNgdPLq10fZ2lVHhNN33OcqGMoS+uPoyg1R7tYMvo/EjJNs6cWeW1PJIXlv2Ij3B3KuJsKRn6L33UthGX0HpcwyBnGClcn++nFSwa7DftiCCaZJmwIu/2DCcYpIuBYDn7QfyGPUq9Y1UX0NGGN6iAmRhdhLzrSXM8EFV5uMCZle2UrohZcrTyU809M/JReVzT+hxbs4YODuNvlQRVU7dLmO8h5kQ8fMXIwmURu+59QkePTvOHNZKf6BrNtR0wf9sSqQm+FsD3+s/Ntjm4SlPYpqriM/lWTlADebQmmC4ZkOQL/TRbgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssQ4Yr7Ver3oTpMBl/KrUoFjnDijHLncadph/ptPiV0=;
 b=raxiX3k2GDf0SFfMx/PwfirsciSzrgp4HbjrwOAlQh8miYQHaBaw6KbUYH24Z2KeQBfW3ddvrL/sSFy1IU0vlMyQ4TjIkCLhdmY4/AIo/1w0lUPjsYoEjuHmeJljFUQsXg0EMUVcpaEGKVfPf76YUhh9JxPYAi6vw8mfIJwf7sQ=
Received: from PH7PR17CA0029.namprd17.prod.outlook.com (2603:10b6:510:323::23)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 18:12:06 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::d9) by PH7PR17CA0029.outlook.office365.com
 (2603:10b6:510:323::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 18:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 18:12:06 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 12:12:03 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] dma-buf: Correct the documentation of name and exp_name
 symbols
Date: Tue, 21 Nov 2023 12:11:52 -0600
Message-ID: <20231121181152.33213-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 5801e590-23ab-4a0e-8ffa-08dbeabd5ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDgdEEUEphaUsLoUP9XXhfODYqUz9ve30yR8OG2j511FHnVQkNdCPrnlm83OgQFy/qyq3zTokUSnfYnC5iW46ZlMgu1GHbSOaRBaqg8JSmpU5p1Svizuuh3hPdqcxSfcru+CaS2SUwTotgaTalPnFGkayhkXkA+avgNq9/tAYQJk8yedyRhKfcK+yyvSoEBRxp2HNiVxz1dgqo/cRTAGz9pZoMngeBZH535vOYgPMv+KpWcrFBicp2lfyDnr/YqALrvpV1e02FUfijNubCjBjq9lv/JkvDL+w9WsrWWTFjfYP649m2ssppv95Rm38zCfGkuaDwjRKL+/uDQ+wJnW1r4EKbLiTjx/vX3KEL0h7ejLAENbg69zldDiEHhrnAVyKv+JY444BhtCDMW5OJOdAnFiStl+gWmi2WbjqQ/rsDREROunelsn9LYD9L37vQCUxmK6CqfrhWta3a+AzbB/atAAQlpHIvTZESw5JFe6quXeDtqiIcGI5wYziEcdUvwdur5k/O9YJQiJ5TJmLVMr8BdnnEIceVX7gdtla7E14o4B9mTAsTYRQc/uR60qgrpbO4DHetxGkUL2pDITQDob6kPcqKZ44HMnC77APTISWkPRsOVrlcb2/uqmwvYe66NgnXuBOkbw6L6DQjIg7+fByEY9AuOZxZoV9HpXgVwE40HsDl2FTTRh/mG275Cl4JKvfwQ16j1E2zTNhuqqwGS8f7LEHvIhlzQEJXVEMIfGrwvMs/n67eSOsx8BcQMV9b0cDp1nfjCxnA1z7pqNLOJbpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(81166007)(478600001)(356005)(47076005)(336012)(82740400003)(426003)(16526019)(26005)(2616005)(36860700001)(40480700001)(7696005)(1076003)(83380400001)(6666004)(70586007)(6916009)(70206006)(316002)(86362001)(5660300002)(2906002)(41300700001)(8936002)(40460700003)(8676002)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 18:12:06.2418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5801e590-23ab-4a0e-8ffa-08dbeabd5ec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the documentation of struct dma_buf members name and exp_name
as to how these members are to be used and accessed.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 include/linux/dma-buf.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 3f31baa3293f..8ff4add71f88 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -343,16 +343,19 @@ struct dma_buf {
 	/**
 	 * @exp_name:
 	 *
-	 * Name of the exporter; useful for debugging. See the
-	 * DMA_BUF_SET_NAME IOCTL.
+	 * Name of the exporter; useful for debugging. Must not be NULL
 	 */
 	const char *exp_name;
 
 	/**
 	 * @name:
 	 *
-	 * Userspace-provided name; useful for accounting and debugging,
-	 * protected by dma_resv_lock() on @resv and @name_lock for read access.
+	 * Userspace-provided name. Default value is NULL. If not NULL,
+	 * length cannot be longer than DMA_BUF_NAME_LEN, including NIL
+	 * char. Useful for accounting and debugging. Read/Write accesses
+	 * are protected by @name_lock
+	 *
+	 * See the IOCTLs DMA_BUF_SET_NAME or DMA_BUF_SET_NAME_A/B
 	 */
 	const char *name;
 
-- 
2.34.1

