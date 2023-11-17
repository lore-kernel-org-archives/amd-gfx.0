Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84731C54E76
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 02:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3289210E713;
	Fri, 17 Nov 2023 02:11:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741C510E70F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 02:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE3Vh2vJEqONKidKCSz6t9kZTfnAuUkalBDbqIs176nCWvX8Ly8DjQyLD8xUtV2IKvLuauPMVOTQUWvkKkapCkYLRtqeYiTOJVa2LRaJsf37K2Z5vrp8Z5BgtFG+hl1aIGwIaFdz78fWIH5FFCUXqQImyR8xXU5AMTR+lahh4inw2Md0dsSNO4ZSuEKviB8NyjMwzANrLaQUWAF4zrEPCBLGCrje3Jb82o9yUzKh+juLpBSLPscY74l3KeiPq55riCS/8YMYsczu0q96L7YcvBUxXOcl+8FfapQyACLsdbkLHQbBX9DIlE2VqKIDrgXgmH0tMuFRDLZZ7dzagPXEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1nEdOzAVd3z03GLGmCTEKq/mjBQSqJFlhDbXeDW8n4=;
 b=MWIOpzEdpp9Qo29LNVG/pbEL99vk6gPhYafJW/PnrPQbnpDnBHNrcDh6OjDLETUdgxUDqTkJS2qCwbeeD3yLoTdvAoZeEBuJ6nUntzam0T1Re/sQuf9mfzW3425pBuNykFb78t84QWkhRyUauaN9JuOzmp/92T8XXX0v37TS7jAjQM5Rduwu9vOuJ8D7Yj6nFg7rMFmfS4ozm7AJvFtYFYlWq4ehkDMCxNGOm7coq1vmFItXBzyLJntOrpAChKU9XI0pOUkRyvknQMb7g3LycBVzAXhuKpopg/haN7BnTznaWr8It6bvcGxNbj132L8TLUYRR6gNPP2QUUXrElueXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1nEdOzAVd3z03GLGmCTEKq/mjBQSqJFlhDbXeDW8n4=;
 b=kqJj7zvIK2Wrfx2GUHFFcSJSU8JOJAcGWkcGkpFP4BhUHTwp3Y1yL/iGrImIAdUBelrUEQGZyKBywIS9ld8pNYvDgX+1r4JucPfiZqohgNYpQjuxUv7j2StahMa1bqdqpjbM842NY4b+V7dEN5Mgc0ebAl2Oc2yd8pTLF0Qevas=
Received: from CY8PR19CA0042.namprd19.prod.outlook.com (2603:10b6:930:6::7) by
 CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20; Fri, 17 Nov 2023 02:11:29 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::6d) by CY8PR19CA0042.outlook.office365.com
 (2603:10b6:930:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 02:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Fri, 17 Nov 2023 02:11:29 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 20:11:26 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/6] drm/amdgpu: update lsdma headers
Date: Fri, 17 Nov 2023 10:09:43 +0800
Message-ID: <20231117020946.2912865-4-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231117020946.2912865-1-yifan1.zhang@amd.com>
References: <20231117020946.2912865-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c914c9-0310-413f-9f45-08dbe71282c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOJ1/tAR9+jz1NSD9Cbi9bm4iSeYtTl/9gLYgSO5+qHFgcFmrXQrklFOqxgV9w3q6DehkdXSx9yeffdvVJ2gmoWJom7Xs0w3oFnztOSEQ+FrXTfOKVSvJVXlc/sAHgzsilaZUiHjJKBMhv3v8mzINgt62YiI/gSQvlPjcnVzqz2QXuNIgOMrs4DsNjzdHCbVOX//sHklajloxJxhNuZYICdoTA/yX50PozC44MKlP8vNQYhMG7hN6tVjaiQoBLnIG3X4QqhBdck9NHCs1qe+/abOS5auRn3ZDxMpAwmcMdcTexQaFWs1teEZ2+/6eexJR5UgYR8kSEBGZP59s4dPQMDWR7qPX5chdoTqKQXa9rzT/s7t5dUnr3w80iTq6EHq6ZmpP+Bio//E0c6aSsFFxPWQrkkHa0xNbedIFaLTEgWpjwpXuusGHUukrBDZidDWolscuwNHzIAWDsfk+VPcDnTcjGcDOg7scYG3dgvGOTemWU/j1u/AckU73wsuFnz/twTD28S6V7SKKsIngh+mJ3INP9+6U7I/UnVEtyGUjnz1fjcWZJOiPI2mc/lsTPgS9tbFDfoS1SHTaFSQ/M+BLXoLAOn2HTrI0y86RL6cbXX9ID2uLEXhI/sSLjuz9phKzQWGj75TRZMNw22Tq6AEQuMj2pPbcG4HmFFhtnhKbDOkhA4JTUi6cJLvOJytQWvSIvCcH0jL9pghJhhjhZXZkZBpJzojh7jFt6TZDAQSsqSSor3XaYnveZTsBxDrDwW1doLI00gnAFS4ExeDqGETLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(356005)(36860700001)(81166007)(2906002)(47076005)(86362001)(5660300002)(15650500001)(336012)(426003)(16526019)(82740400003)(83380400001)(1076003)(26005)(2616005)(7696005)(41300700001)(36756003)(4326008)(478600001)(6666004)(70586007)(8676002)(6916009)(8936002)(54906003)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:11:29.1733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c914c9-0310-413f-9f45-08dbe71282c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 christian.koenig@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update lsdma headers.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h    | 2 ++
 .../drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
index af560359e340..977997d27c32 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
@@ -57,6 +57,8 @@
 #define regLSDMA_HBM_PAGE_CONFIG_BASE_IDX                                                               0
 #define regLSDMA_UCODE_CHECKSUM                                                                         0x0029
 #define regLSDMA_UCODE_CHECKSUM_BASE_IDX                                                                0
+#define regLSDMA_F32_CNTL                                                                               0x002a
+#define regLSDMA_F32_CNTL_BASE_IDX                                                                      0
 #define regLSDMA_FREEZE                                                                                 0x002b
 #define regLSDMA_FREEZE_BASE_IDX                                                                        0
 #define regLSDMA_PF_PIO_STATUS                                                                          0x002c
diff --git a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
index d1324239b751..d0d3a1c90ecc 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
@@ -216,6 +216,11 @@
 //LSDMA_UCODE_CHECKSUM
 #define LSDMA_UCODE_CHECKSUM__DATA__SHIFT                                                                     0x0
 #define LSDMA_UCODE_CHECKSUM__DATA_MASK                                                                       0xFFFFFFFFL
+//LSDMA_F32_CNTL
+#define LSDMA_F32_CNTL__HALT__SHIFT                                                                           0x0
+#define LSDMA_F32_CNTL__RESET__SHIFT                                                                          0x8
+#define LSDMA_F32_CNTL__HALT_MASK                                                                             0x00000001L
+#define LSDMA_F32_CNTL__RESET_MASK                                                                            0x00000100L
 //LSDMA_FREEZE
 #define LSDMA_FREEZE__PREEMPT__SHIFT                                                                          0x0
 #define LSDMA_FREEZE__FREEZE__SHIFT                                                                           0x4
@@ -1034,6 +1039,7 @@
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                    0xc
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                               0xd
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                     0x10
+#define LSDMA_QUEUE0_RB_CNTL__RB_PRIV__SHIFT                                                                  0x17
 #define LSDMA_QUEUE0_RB_CNTL__RB_VMID__SHIFT                                                                  0x18
 #define LSDMA_QUEUE0_RB_CNTL__RB_ENABLE_MASK                                                                  0x00000001L
 #define LSDMA_QUEUE0_RB_CNTL__RB_SIZE_MASK                                                                    0x0000003EL
@@ -1041,6 +1047,7 @@
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                      0x00001000L
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                 0x00002000L
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                       0x001F0000L
+#define LSDMA_QUEUE0_RB_CNTL__RB_PRIV_MASK                                                                    0x00800000L
 #define LSDMA_QUEUE0_RB_CNTL__RB_VMID_MASK                                                                    0x0F000000L
 //LSDMA_QUEUE0_RB_BASE
 #define LSDMA_QUEUE0_RB_BASE__ADDR__SHIFT                                                                     0x0
-- 
2.37.3

