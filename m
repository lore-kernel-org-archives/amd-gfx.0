Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B13AC71149
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 06:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABD210E9A4;
	Fri, 13 Jan 2023 06:25:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A492410E9A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+Cl4kZDSFGSo5kO/fZwhlh8Idb6nQeFgbFhAoIkNjmug6SvD+fvDRcHeOjqqsZYPsggKnubeCHInY8icuF/udtk+NaGKYzTPDqOKt3IonHPvWmq06nolio6lKzQBJajbeKhXxiyyFGGCT5FFQ92LZRdSM4U51b1Ih1YGX0wzqczVtBY0Le/lvmFrMA3/DGBgW3CvMYJwehl4Xjs9v/eCDABtlLRSg1ZHEud3IMFVWrfBvdRmsm7YZ1h9C3Ud9ADFWCfgPx4exGR5nkIcjeQgynCwdXlXOa7zCEOWKeBdWXPUjAptHTZpi0sJ8Lq+7fo7/59kKD0n84GGzAfzYSBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmhWLpou6dsFY47HR3seOHVxcw3qTsGGw1Oeqt/P2gc=;
 b=hIkj4jYClxsxPAwZ4FpgO6nyvZo+B8dCJUKBRTUlTNT/8kb2LRtvcBk82ATCSJlguWEBVFl0y4p/DwxOApOjTbOaB4LwPFeYNG52AzbKmcPHnERtizz2kPHFfiWlRjYoTHn0ffHqM2dC1/pjvQm3i73MzGAsQccV6v0zID79+m1m3xYgMPHYAV08xYdqbdy41YJMM0TOaYlB0IGr/jo1omxAQhZiNxxFTM/33OgxOl64cRjWp5FIQR7P9/o9Jf9jegVwMqL6RuUaTT3cD8VYpFct3szTuizJGiP7w3T6M6JbyX1/qJQXs3bbdFQwOD5RzCdsVDwZ2D5KuKy/jlN0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmhWLpou6dsFY47HR3seOHVxcw3qTsGGw1Oeqt/P2gc=;
 b=RBqs6cprXCZm7YdT2S73hVi2VUsuYDlue2vnA7+HapFXa1knre+RCXPtrimHljiVR69Tr5nfAUxF9vRL5XBphKWoDWzILYdbLDAWdT4J03oTLD3kxCa2UasjHpRlJGtqebiTMNApM/JQ/8+yFeJSdmx8SUGmNtHOaWDIKzXVhM8=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 06:25:11 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::ac) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 06:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 06:25:10 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:25:07 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: Perform gpu reset after gfx finishes
 processing ras poison consumption on gfx_v11_0_3
Date: Fri, 13 Jan 2023 14:23:58 +0800
Message-ID: <20230113062358.1727355-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113062358.1727355-1-YiPeng.Chai@amd.com>
References: <20230113062358.1727355-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|MN2PR12MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 081eb58d-8d4e-485b-a914-08daf52eec45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sT+44urAxBL+CdJ7pxJlDoc4sGTQUeaSaonk3huZGsGO7hmRXTrtSLO0KOzXGm5RvGs29mfWpYhXoIyHXFqWg6RgPnbmVfLianSLbq3ry3QL9CkDuGo24SaJX6PM+iwo9HWVlMf1qeZk3ufIA0yIxp2ekzllCflrAVDWvCkQUdUY+0XIHsvALrODLbOI6RBJCpa9ic4X+LSkyBHkK47lQBJL2oaMpFhktZYNTez83WWlthndMK2wjTiyQUI1qFMtxjPYuNFGGQ/UA0wF0wVfPYxkPMQqZt70F+OQR/r9MnrX0aKedWgX6Y10xeolI1WZdKyk8WKA1nQ2hMabY/J+q5Y6E8v2Ejrtyr2D+Xbq84oJLvImcs7aob59WxgQMd6mkXFk7UrAGeVi9llKDzszGwHwsg/pAbEtHBmUufyc2Hb+W9OkKGomi4fN70q1+1zesDzOW0Id1sIX8/hA2+ISzgtQSUGltoM6FmrA9wUqWNRotVo4qDkG9KKSuZtM3Ez9P+IdATdoujy1i9il3UCvJL/LL9dX8xbfsNyZd6tOGkO/qU7qkV1y/48f5xCX2uipsTmeFp5De+PaLkEZ2w17lIxzq32YhkIki97tO7JDSa/OrLy/PYbcgSJWoJqpaiV/9Vyvr6Xlk7+Rl6DN4ZVDPvlmrE8Tw5rqZbVpNP13njbPe1x3CdYtJ2zRF039Tz2w6ijsbwFe9KCEoIUBTlupcyw+1nQuUSO8eLoh6pDqQUg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(83380400001)(41300700001)(426003)(47076005)(81166007)(2906002)(82740400003)(82310400005)(36756003)(356005)(40460700003)(40480700001)(86362001)(186003)(478600001)(26005)(7696005)(36860700001)(16526019)(8676002)(336012)(6916009)(4326008)(316002)(1076003)(70586007)(2616005)(54906003)(70206006)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:25:10.6854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081eb58d-8d4e-485b-a914-08daf52eec45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking.Zhang@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform gpu reset after gfx finishes processing
ras poison consumption on gfx_v11_0_3.

V2:
 Move gfx poison consumption handler from hw_ops to ip
 function level.

V3:
 Adjust the calling position of amdgpu_gfx_poison_consumation_handler.

V4:
   Since gfx v11_0_3 does not have .hw_ops instance, the .hw_ops null
 pointer check in amdgpu_ras_interrupt_poison_consumption_handler
 needs to be adjusted.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 13 +++++++++++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 09c42c00e43c..caf7fd3adcbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -731,6 +731,15 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
+						struct amdgpu_iv_entry *entry)
+{
+	if (adev->gfx.ras && adev->gfx.ras->poison_consumption_handler)
+		return adev->gfx.ras->poison_consumption_handler(adev, entry);
+
+	return 0;
+}
+
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 0b39fe3cd624..86ec9d0d12c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -213,6 +213,8 @@ struct amdgpu_gfx_ras {
 	int (*rlc_gc_fed_irq)(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
+	int (*poison_consumption_handler)(struct amdgpu_device *adev,
+						struct amdgpu_iv_entry *entry);
 };
 
 struct amdgpu_gfx_funcs {
@@ -437,4 +439,6 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
 int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
+						struct amdgpu_iv_entry *entry);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d06beb884a16..0a95d1c1e7ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1620,14 +1620,14 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	struct amdgpu_ras_block_object *block_obj =
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
 
-	if (!block_obj || !block_obj->hw_ops)
+	if (!block_obj)
 		return;
 
 	/* both query_poison_status and handle_poison_consumption are optional,
 	 * but at least one of them should be implemented if we need poison
 	 * consumption handler
 	 */
-	if (block_obj->hw_ops->query_poison_status) {
+	if (block_obj->hw_ops && block_obj->hw_ops->query_poison_status) {
 		poison_stat = block_obj->hw_ops->query_poison_status(adev);
 		if (!poison_stat) {
 			/* Not poison consumption interrupt, no need to handle it */
@@ -1641,7 +1641,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	if (!adev->gmc.xgmi.connected_to_cpu)
 		amdgpu_umc_poison_handler(adev, false);
 
-	if (block_obj->hw_ops->handle_poison_consumption)
+	if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumption)
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
 
 	/* gpu reset is fallback for failed and default cases */
@@ -1649,6 +1649,8 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
 				block_obj->ras_comm.name);
 		amdgpu_ras_reset_gpu(adev);
+	} else {
+		amdgpu_gfx_poison_consumption_handler(adev, entry);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index a18e09de31dd..b07a72ca25d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -70,6 +70,19 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry)
+{
+	/* Workaround: when vmid and pasid are both zero, trigger gpu reset in KGD. */
+	if (entry && (entry->client_id == SOC21_IH_CLIENTID_GFX) &&
+	    (entry->src_id == GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT) &&
+	     !entry->vmid && !entry->pasid)
+		amdgpu_ras_reset_gpu(adev);
+
+	return 0;
+}
+
 struct amdgpu_gfx_ras gfx_v11_0_3_ras = {
 	.rlc_gc_fed_irq = gfx_v11_0_3_rlc_gc_fed_irq,
+	.poison_consumption_handler = gfx_v11_0_3_poison_consumption_handler,
 };
-- 
2.25.1

