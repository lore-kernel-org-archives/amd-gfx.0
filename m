Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0325C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 12:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DDC810E3BB;
	Mon,  6 Feb 2023 12:58:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4B610E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 12:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuR84EFlL7fGx/F1PSpUI3dD7K6clWAgubS4sK0v13NyFCakD4HifWV6s3zT0rkj/NvGE+NkhzgUspwVwK+dzFUKUCMpfiv9BHpAnvavtnDb0x6kDIc33KvkO8fSHes9PugTmnsEXMdOjB5+zOSZN1zqP9ORKmSsaGXVfVkzqoH5sgiq9359a5z5Z7ZphxCKUW6XKb2JU4+Y2IpxPDOVO/rDVkdrPdlctxk73gH/5yAV034IvgrPtBBjCIfa6ud1XdcS1fPjZZzTwf+VxhAyPcJP34AfSsnhJPfBEqMb8WsZQ0sfPKDh6eajWELnvmLM56DpIPSS6na3KKRfUur6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8cuFJPJeALN041799wTd1hvwy3Dg/IH8hwRbu0f608=;
 b=NW79lhQHMtlGOUsjiNPRy9jJFz28y1r40gYMMYYo7wOV2Oo7t4qYkMFhiSwDQGUF1pbPLghELQ/4MebKJRT6JCLUIVo+gsnZD3Y/b80TbqBED7dNG0QyWFbS1Y7LJ78pJyko/jgAKQ8Fsf8MXO2wp2b9YiAGW16NPTMLgLDfKE1fyQXC8pFQlKW6BJy9dxMquvT7dtNWyFM6zm/MES32pXDTikSC/dc2JJGMAdq8Uw4vtPEC/Jaz64NMoYeTbDHDvKW2Vn7j7bYFW89qZ/eICAOxP/nL42SMfksnc1WO3F5IvMycNpLVrddWSrbQZcmZPrGTaFulg8OIyUrwkZr2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8cuFJPJeALN041799wTd1hvwy3Dg/IH8hwRbu0f608=;
 b=SBhO2hBmAp5Ey21vk++zzyAa3L+nEwm3ay2+l9TBQtp5hliy0Yht5nyzXnFfanZB0BiOTNXeL/G1P6hSYoGngR1h5diHxvh0TPQ5Nv5fpAjpJ4EvaAEVwsp/RK+Racq3m9BOEdTuBRO9sPHlMlTFtMUnM/Q9cbb1PnW+ZBIhDJU=
Received: from MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::9)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 12:58:46 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::e2) by MW4P220CA0004.outlook.office365.com
 (2603:10b6:303:115::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 12:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.32 via Frontend Transport; Mon, 6 Feb 2023 12:58:46 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 06:58:36 -0600
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: To fix sdma page fault issue for GC 11.x
Date: Mon, 6 Feb 2023 20:58:12 +0800
Message-ID: <20230206125812.1554992-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 15773e1f-7d1d-473d-7fe2-08db0841e251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9arWIQvwpxghgmtQVdd/wFagIvyTH5T0Ndfi0mYj299AaOcxJtIsAHwYA8MOTbdeEOdszJe8jPizjU9d2y+r8bLMP0hk29q95zuCu/Fye4I/NHHiq/xR6QebpSPbev5L4DRZqRO5eXjbQrX5R9DZlxrKFe12bRc0f+91TkejrJzghTxCKEEaC4HF4gX3uo6KdRAYbJyvfypkgYP+PRCl2h7M9g302qcUgUpUxVS6qEX9XWZFSw9pO4axuGeuMFnZBRXzkBAiF/JOk9euus67eaBIBeyNsp3k0V+h+GvkrlNY3VnZYGSYXopWMubbIDWX6HdeiCuQS9Vhb2ThAV1SRupfiTJfDCJQDMoCn+HgmQSB876LJT1T0/+argqT5srvQ1ajYbE+zaF7evaTIO1b34GJri5j0MUwvEVtAbk5RMLMdsDQLLnFPTKMTwSdHRQSFRQl+/mto8Dr+4OopiaqjVq14TnCqUu/ucpMfJl0vftVOHNuCtD2CBw7lsBjqfkWxzQznLgna0zTyLdxfeYcelf+Hgxf7gPb0p/LYCy0n2YSSjgeDi8p2IGy50pGaWVnI3iAr3OYWMdKE5mWt3IMr1ikf3WjD67v63JXhfQEnhe4x3fC+VN9H9NzFHNxflzjS9VhYwqv3q7i0Lv1FS+ipGXuV4bhR84UnZPxQPF9ec9ILh+sTrYzWOeyROjgqkLFVgTsKAjfchGRNg1CeESsOCIwgD30XXI+7b00GknoZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(40460700003)(6916009)(1076003)(6666004)(40480700001)(478600001)(2616005)(16526019)(8676002)(186003)(26005)(4326008)(70586007)(70206006)(316002)(7696005)(54906003)(36756003)(82740400003)(356005)(86362001)(426003)(47076005)(83380400001)(36860700001)(336012)(5660300002)(41300700001)(8936002)(2906002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 12:58:46.4539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15773e1f-7d1d-473d-7fe2-08db0841e251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com, Felix.Kuehling@amd.com,
 Ruili Ji <ruiliji2@amd.com>, Aaron.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

For the MQD memory, KMD would always allocate 4K memory,
and mes scheduler would write to the end of MQD for unmap flag.

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 12 +++++++++--
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c06ada0844ba..d682e6921438 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2244,10 +2244,22 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	int retval;
 	struct kfd_dev *dev = dqm->dev;
 	struct kfd_mem_obj *mem_obj = &dqm->hiq_sdma_mqd;
-	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
-		get_num_all_sdma_engines(dqm) *
-		dev->device_info.num_sdma_queues_per_engine +
-		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
+	uint32_t size;
+	/*
+	 * MES write to areas beyond MQD size. So allocate
+	 * 1 PAGE_SIZE memory for MQD is MES is enabled.
+	 */
+	if (dev->shared_resources.enable_mes) {
+		size = PAGE_SIZE *
+			get_num_all_sdma_engines(dqm) *
+			dev->device_info.num_sdma_queues_per_engine +
+			dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
+	} else {
+		size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
+			get_num_all_sdma_engines(dqm) *
+			dev->device_info.num_sdma_queues_per_engine +
+			dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
+	}
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
 		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 623ccd227b7d..ea176a515898 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -66,15 +66,23 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_dev *dev,
 {
 	struct kfd_mem_obj *mqd_mem_obj = NULL;
 	uint64_t offset;
+	uint32_t size;
 
 	mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
 	if (!mqd_mem_obj)
 		return NULL;
+	/*
+	 * MES write to areas beyond MQD size. So allocate
+	 * 1 PAGE_SIZE memory for MQD is MES is enabled.
+	 */
+	if (dev->shared_resources.enable_mes)
+		size = PAGE_SIZE;
+	else
+		size = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
 
 	offset = (q->sdma_engine_id *
 		dev->device_info.num_sdma_queues_per_engine +
-		q->sdma_queue_id) *
-		dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
+		q->sdma_queue_id) * size;
 
 	offset += dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
 
-- 
2.25.1

