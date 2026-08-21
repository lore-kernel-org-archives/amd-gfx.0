Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0B8C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B0610F42A;
	Fri, 21 Aug 2026 19:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UiEWaAdu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACC610F428
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9u17tG7HdFQxAw03mdc190CNR5iYm89RfgK4dXL9mqWdtYPP0v+9SdgzxEq/7Q3IPUKDjEUB2EJvMWUU+Np0mu0q4YUX+qmGQZAk0d8BRn1IiSen9LWnXtIQmdek6vrBI9bYkw9xOxTsQc8dga2NIKqG2lcCiBXeo1VaW9ihvLcAZUcnrPHMu0f4wjBhxyOnPa7qhsYmqONA8T+94YDa+JDKZFx0o02TC/jG/mvS/RDJjrAvdMdUqXDydHpi3DYI8GzLZUbHKckFBjfe6VpErxyjFPbJdG0hHkPFohxRfNN3sRya6Ov/BC0vTfY4K601IXncNjRfMfuXzIDCYhjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLMazOPCje5IPHdUNcxfDOW4dTpf96rn6hKEGNWHTKk=;
 b=Gt2dxivhbimzVN7xkg6iqy0mQaa2zT8JytZKVAdi+Bg2Cu1BDieCL+YuXxaSQ76efPvQfXH/yRX+ETizJdhVSq8+f9ja9clW7q16pZ1mxDL91+SwPhPAYyZzSviWT+VzVkT9bSDFgCwu3Puu7Gdb6pJIBeBtcfl0oop19Xv+2SqO8NBmZg3ls0xuc91jW2KYfJwre5Uhdlff4XgwbWDRXcVfl1I8Y4JLzWRnw0XjUMqKGKQQuA3ANnrY7ujPiGOH5yEPiiBEzpwlkU7hlg8YqeXntcOfN4M4qWVy+au2608yxFG1yhTn9+5rH/i+S0mXSEEBGFwBlblWXjAunOQ+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLMazOPCje5IPHdUNcxfDOW4dTpf96rn6hKEGNWHTKk=;
 b=UiEWaAduUfAgZ22TgAMllh0PIqO/zzcT2EhWp2wJv8UA2ELpR5c1bqu9+kjGwotwpaSAuyEZfUHDTMvURRpADcrAKmRSx0GtUlYN6agMLVpaPJ930QxNOBddBkptgKypVxj41jCbxnJfXsq3cvgCOZSwiVrRnP7/F09a1MwftNI=
Received: from DS1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::7) by
 DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Fri, 21 Aug 2026 19:35:58 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::23) by DS1P222CA0002.outlook.office365.com
 (2603:10b6:8:454::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 67/95] drm/amdgpu: fix dma_buf leak in UALink exporter cleanup
Date: Fri, 21 Aug 2026 15:34:30 -0400
Message-ID: <20260821193458.808626-68-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c27fce1-6ede-46c4-369a-08deffbb6c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: tFznaSThxFzDX0nZEm+oD7AasX+ykNMTMpV0WEmPSKvNF+wSmRg7oJiu6V5QXcTN9akN89YOCCCGggit3KMPcoQfqccM5sQTiM7rRuOBLnBpO+mhFbfYZ3wXqOqeQcnBEl/Qollvtiqz7zgXjl8The5CSRmIRY0qMCGmj5EhNFRzlyfMUpYcMkp3TZDBaOZUeJ+SaMMUB4w6CXyLNpx1HM6war0fsCSsrS0k4uB+nwMcocQMirA7sCMWkk8PkpwDHZ7HIaoJexCQFAP8CBI+RFfAyFNA8Ko3OJCDWBhMKLLVfymabyujExo/O+d6KFrSJP/Lfd+6erlgxorufs1FClTKEBv9afP0DJsVB+oN5+XekRdcK+m2jsZRDgIKOh1bT7HvJWP2HQiGZ7fw7M5vib+VQZdGKFf6CxCnEdTNAJjUBAj3xtJWgnth6dHFi9OPSjZX+XLkb9QyfIdoEM/bg11OislVDxmjB2QnHwGAbhUYaS4aOqzOffzwR/vwfimD5piZCE1m3c/Uf26EGO99/p7g3SZfERTdlY+zkZojdwF9zjC1sguv/Sm+z8GxGcFr3PdkC9gJGT8gKZjjOQnBbzMOU+t8gk1oow1KgSXf8wvMibMl7hkVoy6G1eRlG7RDUFX+OH9IlCcOL1K5GVFrN5d32cCebJs3NJraW7ohDlAMUMaHlY4oJ588rV8DyxjQku0Jkh3rZ/JIYYIgs83Ljg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GNhXRVWnwm8MqTovHJ6TeOjcm+UrQ31DLE0lgTjzMbNSH5weKKRb1Vk+CgIPp+y636g85YX2pHIdmYzDd60w9Oe8Mivgowi6QG7+hiUmI5YbGHYEaiwZMOtBk1S1QNTRFXNwSHxXKGzd84IWEfZf0BRTVvDKCqrmHXXoYlW3BzkrrmyWeQCB6TVZm0XZTXs7Hv1zv8uX/czHoEzDQhxfwtBZj4xLvLccoSxSLLK3+PB+U0Qc5vcrXyihnxU9kzItGOLVshycY3CzfN3sMaj5cuMZYPpS96xdHr0UZ2sEPTX4tqRpp83Q2VgtQosjdZTtbe8IdqGkn8A3YjO7u29WiKzStreNM4PsnN+0Vg/XatzvCfs0TuclawGa+HVYod8g/gw71U2Lppa9bybRgIzis9wIXRbrpEiclLAHmWcwoVjCAFc2AGfdl3PCPU6ZTHlS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:57.6124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c27fce1-6ede-46c4-369a-08deffbb6c78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

From: Mukul Joshi <mukul.joshi@amd.com>

At export time the driver code always builds a dma_buf for the BO
which is then shared for local imports.
During cleanup, if there are no importers, which is true for local imports,
we never free the dma_buf thus causing the memory leak.

Fix by dropping the dma_buf reference in the no-importers branch as well.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 66ae6a0f1c53b..dd45c2e20be0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2220,6 +2220,12 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 	/* If there are no importers for this BO/handle */
 	if (bitmap_empty(exp_xa_node->importers_bitmap,
 			 AMDGPU_UALINK_ACCEL_MAX)) {
+		/* Release the dma_buf created at export time (used for the
+		 * local-import shortcut). The has-importers path below drops
+		 * it too; this branch must not skip it or the dma_buf and the
+		 * BO it pins are leaked.
+		 */
+		dma_buf_put(exp_xa_node->dmabuf);
 		/* Drop the BO reference so it can be freed. */
 		amdgpu_bo_unref(&bo);
 		exp_xa_node->bo = NULL;
-- 
2.55.0

