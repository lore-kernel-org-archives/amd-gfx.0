Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EFCC678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 07:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57A910E0E3;
	Mon,  6 Mar 2023 07:25:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7144E10E0E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 07:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l30v/sDf6LADuIXm+ZlRvZBbtSUZwHAdS5GH/6nwTU/fKJyCwhnyVsT+CPCHPKID7Utq1AlUhR/9XLFa72YuuWcYF30V2btTIotAWEBSIXDGsZeJNFnRRzZd0CBDQJSfh9bnOmHeiq+chQkPHFxzfG1QzcpXOQkb1A1dXw/xoffgkEX4CfxGSqFDKVuJ3KAccRGtUYUV7WCLcP0QtbkkMKLJEEtECbvSiMhNwBEYEz54DVxrjBB9I2pDRLlrw/KkT6yo7MAaPVBStGWNpXUFBah4lubc/0KYCEdfz0HuFhdizkPnoh9Uw03hBN4GwcWbkt9xGn2cTICCzSeZT+6TPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtqjL4ZW5B9uXKLtSwhM/Y8fNKICIx7zvpCzcAL7cnE=;
 b=P3dYulAg5U/2SwWwQANc1Zr4GMgCLS8hHJmtIjAMXePRJNuhvBmuaxWI2UQbtmINWe8zDZpyN4GDUVJXHQtb7yDMoXjKf+GJS6XfE8vrhKd2q6TmiKMTcTTtqWrSTH+kI+cTxEK9Q+L04bJyqHxazMHfPrYUqtm3yWOK8DSeR4i1+S2Krvk4u/v0R91GoT1/3Z7M/kVZxuhOLN9CxI964uiCoXsoBfcvUA+AcqxhooO/ptiC8BvYqMzlmXHDNgf5GwwYOeOQEbujRR+2/+2ZQ9dg2kTzonMUg0KdcV33edslUejypY3+cWVpjL7Ftz5GzPDTbBHwe8qdwqMTjO/ccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtqjL4ZW5B9uXKLtSwhM/Y8fNKICIx7zvpCzcAL7cnE=;
 b=2t/fuTC4bRU3YdZFQn5Q1yrHplQvAaSNEvuHjkofLI+i9Jv0aJekcQkyTOLVzjx6R6hqXPdCj63EnryEXVYdwEkeblKw/qoWwcoG2zgt6vJf4CcTV5l7UZrylf0RNiHWILUUmndhDcmiGheGnTxLI+rLw+pF58LwtGOOHzojsTM=
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 07:25:36 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::e6) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 07:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 07:25:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 01:25:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 01:25:34 -0600
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 6 Mar 2023 01:25:33 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Init MMVM_CONTEXTS_DISABLE in gmc11 golden
 setting under SRIOV
Date: Mon, 6 Mar 2023 15:25:00 +0800
Message-ID: <20230306072459.2334191-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|CH0PR12MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e85bf48-5756-4df7-aad5-08db1e13fa71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioTif+/BHVvrT8HQj0GOGvuYDC3OkUyl0Zif7opXHPCt3L0rSJhDEhFz1rXAfd2sQtkZR74ciUKfbB+NYqYVVvwr6L04nbhrYv7oHlkk0UNenRroNgZQCBEolpy8kmcPrGuRxdF2fqd/Ob3sje5ak2d2yXFPv33LjWSr4oB4LwwtBF8PPuvhY48mgCQ5P0wspO/hQcQXK6Zuhs8n9Cc4aFwkPfgq7K9hQV7mcrjSb5o3VS7LRJjDdrkv0ir5QvQyiywp4YEYmi0L2DyR6Ri7B/T5g4jmyDJaTOH/HZANPC4+IC0qPT/XmENMzfm40UtdLJts6M9gfHrD2luWOlbJ69XD79F5ofO4jYQNh689NtUMq7E6xLcR9oTkMpTTkJ1Z/HaynmSyYWEu7/vNhmhGToq80PaIBtultuIgQJccKsnJfdT/DS1yequHMTAdREAMCoB3c1AEBHw1AcW6jiEPYIF4/OnQBbA4o1m/THgLLNqXHo7J03CVy5lhwCt6Am92JIQ09R13CSACcQd4GVI5/ZvxB5yz9UqR8BnXx9Dnk6gongDObY9lecvkA1eNuuuvp8a4ptOInG2/E8Ur8FuYmcPggKSIdV4GtnnEg5Rzbdyl/8gCuMeIhF8WIIsvd1z5Pg82Gso4+E2UG3sWaY+lrCNFHvPwOHUvmtuUdtVCMnEnNIMLC5RJhmQJgpaqIfN0xtX9TPhlM0Iod1JrJR8BKvSppMEE29JwHD+1KOVNRYlsr08brO1eQkCTYhtZ1iQj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(82740400003)(36860700001)(83380400001)(426003)(47076005)(36756003)(478600001)(110136005)(54906003)(356005)(316002)(6636002)(81166007)(40460700003)(7696005)(336012)(2616005)(6666004)(1076003)(26005)(186003)(5660300002)(70206006)(70586007)(41300700001)(8936002)(2906002)(8676002)(86362001)(40480700001)(4326008)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 07:25:35.6616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e85bf48-5756-4df7-aad5-08db1e13fa71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
If disable the mmhub vm contexts(set MMVM_CONTEXTS_DISABLE to 0xffff),
driver loading failed on vf due to fence fallback timer expired on all rings.
FLR cannot reset MMVM_CONTEXTS_DISABLE.
So this vf can not be recovered anymore unless trigger a whole gpu reset.

[How]
Under SRIOV, init MMVM_CONTEXTS_DISABLE in gmc11 golden register setting.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0305b660cd17..fad3034b35ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -104,6 +104,8 @@ struct amdgpu_vmhub {
 	uint32_t	vm_cntx_cntl_vm_fault;
 	uint32_t	vm_l2_bank_select_reserved_cid2;
 
+	uint32_t	vm_contexts_disable;
+
 	const struct amdgpu_vmhub_funcs *vmhub_funcs;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 0a31a341aa43..7481f2f2804c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -875,6 +875,12 @@ static int gmc_v11_0_sw_fini(void *handle)
 
 static void gmc_v11_0_init_golden_registers(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev)) {
+		struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+
+		WREG32(hub->vm_contexts_disable, 0);
+		return;
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 164948c50ac3..17a792616979 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -517,6 +517,9 @@ static void mmhub_v3_0_init(struct amdgpu_device *adev)
 	hub->vm_l2_bank_select_reserved_cid2 =
 		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_BANK_SELECT_RESERVED_CID2);
 
+	hub->vm_contexts_disable =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_CONTEXTS_DISABLE);
+
 	hub->vmhub_funcs = &mmhub_v3_0_vmhub_funcs;
 }
 
-- 
2.25.1

