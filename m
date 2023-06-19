Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2162DEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 13:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8FD10E1FE;
	Mon, 19 Jun 2023 13:50:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6CB10E1FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 13:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrQFA34GDNMcqHaGvmBBIa9593J8W2GMhx78WHu90vHU10/UoJW+uKRqibouOHGFA3x46eJzG4OMNDgwAdYa14Ha1p20Pdn9xvUQ3jx/Bmfh38WwUjBxVgLCCtt/rSLTeaaLlpUzR6sQC89IOD1MoQAdInoa1oay0dM1c9wFs4fdAtOxD95MbvF7BZdMxbmuQcIRnScKfVcQ76PensusS0lbKgxl4pq3bxu7J0SsPRQSKqgl5UAcZQtHcfrKjQjEldas8zQbwGkGHH2TILfO4ytrAodmof60sonC7mK8DRl9qSNLKGm4ngLIfYPeIgkru3UKecZbyeeCtE6Mk/E8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkAFUxUAQOk+Bzmh6mNDp/JxcbEpSveiFX3/Bzh7Z4Y=;
 b=AEBBVkCbUtGkPr7j/O953OdPYma7twj+c2JWeOzXw1XVbalUClkNEPmHWbc2Rmnv86VGnwAjIGihgXZOPRST7yjEhvM0yhZmWZAY9IjiPa4NYaWtZF8ZWjXpicOSFeu4fWIzy4aRTAw31Oz6VTHHXDfzwfilU/kghS/D3GnmOKbYfzO3EnnOZ9sKsFpXtXEgxn8PiuLLXPy4zslwV/yJxCCYXD7d1dVhXmImfqoqqCECfI+0xR+dJT43MYl5FLThfmvbdr6d44f7iKQv0L1Tbng8nO0QZWRMtlQhkPUTkYufvMpDpa9msN9xM93+C/zp4MzGMi/q0zrA36u0qPo/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkAFUxUAQOk+Bzmh6mNDp/JxcbEpSveiFX3/Bzh7Z4Y=;
 b=qiOln7z6+qIXuA/XRj2ltW11xMEJUHhpSRugL/gOBfugoqfurQEAqfrPeU3MQZUuJNNAjzr8VxD/dGBUagtkV5wwV9ZnoGx2kOcSddDg+y9/gvTss3YXQG9KdiXIwV/20eamPrSNduaVITMcm8lDVxYbhkDb6YH1Gsa6kGgsMUw=
Received: from DM6PR12CA0009.namprd12.prod.outlook.com (2603:10b6:5:1c0::22)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 13:49:58 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::7a) by DM6PR12CA0009.outlook.office365.com
 (2603:10b6:5:1c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 13:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.36 via Frontend Transport; Mon, 19 Jun 2023 13:49:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 08:49:57 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 19 Jun 2023 08:49:55 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Remove redundant poison consumption
 handler function
Date: Mon, 19 Jun 2023 21:49:53 +0800
Message-ID: <20230619134953.180252-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 9875fe3f-e920-4a87-d9ce-08db70cc1232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMPNvCZpTk/svxFCmIv2L4jcjFD/cxO6RdSCHV5YLFyFGSLPc7SrFIEFUrm2X0aLTp8NsZfKsRAcA2V7zfhq+u/MnrFqVac+EI5yjtyV9PD77uotAoaa/aSc9tg/7UiRxRR7y/SLd4qrIEMmM1iPzW96L3M8gMlcyVedJgLMsUEmO/HUra7AsJV8/1CbApVD1vQXWYDKjLOB9zBDqaxTvUQevIx/ZITExwKReqnKF4il/V1RwEnyPeoMlob8F7ic1AQJugvnq3WriICXoJw7tzb+dgvEZNqpTt+ME2RKVFdi7M0gf9PS12j1g35olHVIQVkDQYh+Fxit7SkFBvcLRq7Qxc2nS/7ZCH0QSthtg4h1bO1B0spEn4XV3DEUYajI0PS6Diti7VFdmKgKM0TGoCrOB7TuAMgSkYdnM5gXQIRdU2NdtOmwiUiosPmuIv1QAybKX75G0R2t+uuKfDR5DFN/JZyy07PadleHJizdFQUQ9j8V1eBP38VItrPFQRRqnQMOgWCzWBjSTj7NJgMtpTocbxR7XbnjQugtstHQqMBY5HkyaNxcb7JzgGaLz9bJZdgCzAzR3w7THf/mC19u0M3yAvOfEL4YB8b345Wo7VMnFi6+4VT/gFA/pE8POoT3o6fo7j/y8Ru9Ba+372CVgz3TZkHkCbAj8HLlCMBm5Vwz1ZCxtuD2stmHOMLB6Psp//us1vBFw1vF7rQFCa1gcFcYQJY06Nap6quhwDih+TP8GY26QV9sbA5dIWZA+L0bEdfXFwGtsofvbt2cnA7iAX7wJBaL+7NbuVcyHlEdut8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(186003)(40460700003)(26005)(1076003)(82740400003)(36860700001)(40480700001)(2616005)(47076005)(81166007)(356005)(336012)(426003)(83380400001)(82310400005)(478600001)(4326008)(6636002)(41300700001)(70206006)(70586007)(36756003)(8676002)(316002)(110136005)(8936002)(7696005)(86362001)(2906002)(5660300002)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:49:58.3081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9875fe3f-e920-4a87-d9ce-08db70cc1232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function callback handle_poison_consumption and callback
function poison_consumption_handler are almost same to handle
poison consumption, remove poison_consumption_handler.

Changed from V1:
	Add handle poison consumption function for VCN2.6, VCN4.0,
	JPEG2.6 and JPEG4.0, return false when handle VCN/JPEGP poison
	consumption.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  9 +++++++++
 9 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a33d4bc34cee..c15dbdb2e0f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -840,15 +840,6 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
-						struct amdgpu_iv_entry *entry)
-{
-	if (adev->gfx.ras && adev->gfx.ras->poison_consumption_handler)
-		return adev->gfx.ras->poison_consumption_handler(adev, entry);
-
-	return 0;
-}
-
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d0c3f2955821..95b80bc8cdb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -273,8 +273,6 @@ struct amdgpu_gfx_ras {
 	int (*rlc_gc_fed_irq)(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
-	int (*poison_consumption_handler)(struct amdgpu_device *adev,
-						struct amdgpu_iv_entry *entry);
 };
 
 struct amdgpu_gfx_shadow_info {
@@ -538,8 +536,6 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
 int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev);
-int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
-						struct amdgpu_iv_entry *entry);
 
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5b6525d8dace..9ce7c7537751 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1668,7 +1668,7 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
 static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
-	bool poison_stat = false;
+	bool poison_stat = true;
 	struct amdgpu_device *adev = obj->adev;
 	struct amdgpu_ras_block_object *block_obj =
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
@@ -1694,15 +1694,13 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	amdgpu_umc_poison_handler(adev, false);
 
 	if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumption)
-		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
+		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev, entry);
 
 	/* gpu reset is fallback for failed and default cases */
-	if (poison_stat) {
+	if (poison_stat != true) {
 		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
 				block_obj->ras_comm.name);
 		amdgpu_ras_reset_gpu(adev);
-	} else {
-		amdgpu_gfx_poison_consumption_handler(adev, entry);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 46bf1889a9d7..03f3b3774b85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -564,7 +564,8 @@ struct amdgpu_ras_block_hw_ops {
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 	void (*reset_ras_error_status)(struct amdgpu_device *adev);
 	bool (*query_poison_status)(struct amdgpu_device *adev);
-	bool (*handle_poison_consumption)(struct amdgpu_device *adev);
+	bool (*handle_poison_consumption)(struct amdgpu_device *adev,
+			struct amdgpu_iv_entry *entry);
 };
 
 /* work flow
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 26d6286d86c9..5b7eac547a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -78,7 +78,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
+static bool gfx_v11_0_3_handle_poison_consumption(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	/* Workaround: when vmid and pasid are both zero, trigger gpu reset in KGD. */
@@ -99,10 +99,16 @@ static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
 		amdgpu_ras_reset_gpu(adev);
 	}
 
-	return 0;
+	return true;
 }
 
+struct amdgpu_ras_block_hw_ops gfx_v11_0_3_ras_ops = {
+	.handle_poison_consumption = gfx_v11_0_3_handle_poison_consumption,
+};
+
 struct amdgpu_gfx_ras gfx_v11_0_3_ras = {
+	.ras_block = {
+		.hw_ops = &gfx_v11_0_3_ras_ops,
+	},
 	.rlc_gc_fed_irq = gfx_v11_0_3_rlc_gc_fed_irq,
-	.poison_consumption_handler = gfx_v11_0_3_poison_consumption_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index aadb74de52bc..3d60610a9c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -809,8 +809,17 @@ static bool jpeg_v2_6_query_ras_poison_status(struct amdgpu_device *adev)
 	return !!poison_stat;
 }
 
+static bool jpeg_v2_6_handle_poison_consumption(struct amdgpu_device *adev,
+						struct amdgpu_iv_entry *entry)
+{
+	/* TODO: reset IP engine instead of reset GPU */
+
+	return false;
+}
+
 const struct amdgpu_ras_block_hw_ops jpeg_v2_6_ras_hw_ops = {
 	.query_poison_status = jpeg_v2_6_query_ras_poison_status,
+	.handle_poison_consumption = jpeg_v2_6_handle_poison_consumption,
 };
 
 static struct amdgpu_jpeg_ras jpeg_v2_6_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index a707d407fbd0..328e3de14e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -818,8 +818,17 @@ static bool jpeg_v4_0_query_ras_poison_status(struct amdgpu_device *adev)
 	return !!poison_stat;
 }
 
+static bool jpeg_v4_0_handle_poison_consumption(struct amdgpu_device *adev,
+						struct amdgpu_iv_entry *entry)
+{
+	/* TODO: reset IP engine instead of reset GPU */
+
+	return false;
+}
+
 const struct amdgpu_ras_block_hw_ops jpeg_v4_0_ras_hw_ops = {
 	.query_poison_status = jpeg_v4_0_query_ras_poison_status,
+	.handle_poison_consumption = jpeg_v4_0_handle_poison_consumption,
 };
 
 static struct amdgpu_jpeg_ras jpeg_v4_0_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index bb1875f926f1..e6dbea441caa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1974,8 +1974,17 @@ static bool vcn_v2_6_query_poison_status(struct amdgpu_device *adev)
 	return !!poison_stat;
 }
 
+static bool vcn_v2_6_handle_poison_consumption(struct amdgpu_device *adev,
+						struct amdgpu_iv_entry *entry)
+{
+	/* TODO: reset IP engine instead of reset GPU */
+
+	return false;
+}
+
 const struct amdgpu_ras_block_hw_ops vcn_v2_6_ras_hw_ops = {
 	.query_poison_status = vcn_v2_6_query_poison_status,
+	.handle_poison_consumption = vcn_v2_6_handle_poison_consumption,
 };
 
 static struct amdgpu_vcn_ras vcn_v2_6_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b48bb5212488..eb8625a6df92 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2134,8 +2134,17 @@ static bool vcn_v4_0_query_ras_poison_status(struct amdgpu_device *adev)
 	return !!poison_stat;
 }
 
+static bool vcn_v4_0_handle_poison_consumption(struct amdgpu_device *adev,
+						struct amdgpu_iv_entry *entry)
+{
+	/* TODO: reset IP engine instead of reset GPU */
+
+	return false;
+}
+
 const struct amdgpu_ras_block_hw_ops vcn_v4_0_ras_hw_ops = {
 	.query_poison_status = vcn_v4_0_query_ras_poison_status,
+	.handle_poison_consumption = vcn_v4_0_handle_poison_consumption,
 };
 
 static struct amdgpu_vcn_ras vcn_v4_0_ras = {
-- 
2.25.1

