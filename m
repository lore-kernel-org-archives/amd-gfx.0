Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387C6C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 22:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEAB10E522;
	Mon, 26 Sep 2022 22:35:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FD210E522
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 22:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7k2tRR0H8K/X22k5WFSg8FF7FDuybwEtgiycGs2Kbzi6HX3UJQNwhoMqgsgFVwZenAuLhi9QHRfRUVYZs6vank1NCsuhalgB5+vFK9WM9q/6jchqXK1mfgBt4G5+cGBrfq7VFUO4Pl17QM8vxoWr+Xj4J0kWV7KDMgnClGeox8GkBiz4xBeoyQyB3E9APv/r7AwXLt6pAE0mSgXqsFp53xXHlZSFyD7E4bQ9Q/kcLPJBa7eGFnznfzkAr6Q2n+I2eObphgORTFbr6A6iqYwxhyBg2fTfwOlQwXTEMc+5JO9maj7dmqSNPXMddkse1rHijABX/Pl5hZOF2z95vn4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJaFa3XFDYcWDLn8EnraDxMkTkelR1+Ft0skLMPcb+k=;
 b=Ux80pOUDlcGXAWnoqCGqz60rX/HEJum/NCkE/n6BdavGgbSJXD22krmVcp1Oe86RXqmJuK2MjZyfWW3hZGTIepOw+rJA56nZwfVR+GEKM/584RoMfr2yGBk8WeAa2AZkrzvD3ktHRcChgBMdnoRI3xu+VJqKhuBBW3VKXlb0sIzwYwybhYOeePpvcPnV5VCxvlktGu7OzDQzjwINegNZkBHTkTswepRS0l5Qixfb5cf4sKmYUMftddraSQ7fL/Z9AYpjDEbYCaU6+0VrD0kBC67KN64cMa9VoNVSzG1gzdsvsalI751EMPkgwLkRiy8m4xR5nbTdzQ/5AaJCJaO//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJaFa3XFDYcWDLn8EnraDxMkTkelR1+Ft0skLMPcb+k=;
 b=0kD9tyebFhY6STv+eLFceXrexwN5y/AaBDNgckaZ3Ch4R8+HPkkDux0fJcu2ioug7pJ6QGvuHH20oeLX5SKkEc6bPwxZUE5xHiI/twIBN/+OJwy4TXOSVaHhuJkQTbI0THTbZO3sCHBIF3jBCEZuzz14g/V9b61SmfdzLE5kTxY=
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 22:35:52 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::94) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 26 Sep 2022 22:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 22:35:51 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 17:35:49 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Date: Mon, 26 Sep 2022 18:35:31 -0400
Message-ID: <20220926223531.956693-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|BN9PR12MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 34993e1d-6e54-4afb-6616-08daa00f77a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lw8FHsx2WcW0Ra13qZe8P5UbDOtaWn04wRWW6ZUYWA/BmPkmzP1z990+RNRqSGsdYl9vMHtSEjZqPtunpfpjEeM0GnKBU0weYNh31byzUo3vibNzorq/VmejUCRb8/g4T4dUqAtaoTA5pObCuANYCFYTwzLx/mvo0dNMv/R95gFUinMaUsa0J1MkfErY9hS47gt0gJ28ry0X0bCr/ja0yw8VHD28Z197U3UGZg6iuJyvK3Mi6VXCMiOhXSbqXTcvnHXAoESMPU8+E7eayINpheJZqo77dZgMINgVcfZx1Mi6no7qhdi+uILtabdc6Du0SKFTr18t049mKv+4vZGq/rNxlhpPSLc7CKhlw+lrHLVXQejdsGTsAkufMbMph7c1/OOn4j7t+EQY1CoeX3mA9zitzIdr6wAK4qxz7l/vdmlCRM5W5BoG2ybYSPIR7ivZ7MKpABi8D3t7k1mWbZJGnGSR+yGi0GAtEeOSC62xMA95VdPo7QvfD2x6eDEY8sItjjio6Gh3zZEn7EbWSqMtVEX+Iui3czFDvXoRJ+TFVEaWZI2fvNYLCmMf9Dct6NjdAdAxTVsCek9eoSvGYVSamV9GvCQNHKq92avGeYGbfaCiV9NlA9ByILt412fQH9tzj8DYRT67mXDU8J0nC+21lC9e9JMExbQyMiDa0cHr8G002ML1BCdORweq5ZsDZF0g7+zF0iJMWiAC6Ca6u7OWUguSjos7hJl+mxRmrhSAPptVcoEPllipQgAh/SInfob1DmtF0u1bCwq2yDud84LHeAoFv6cGptz7ljfLZ+J0SRVqORIkDnGiUchxuhBEURG6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(426003)(316002)(54906003)(6916009)(478600001)(83380400001)(70586007)(70206006)(4326008)(8676002)(41300700001)(7696005)(5660300002)(6666004)(36756003)(36860700001)(26005)(2906002)(2616005)(8936002)(1076003)(186003)(16526019)(336012)(47076005)(82310400005)(356005)(40460700003)(81166007)(82740400003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 22:35:51.7534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34993e1d-6e54-4afb-6616-08daa00f77a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
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
Cc: Ellis Michael <ellis@ellismichael.com>, graham.sider@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was fixed in initialize_cpsch before, but not in initialize_nocpsch.
Factor sdma bitmap initialization into a helper function to apply the
correct implementation in both cases without duplicating it.

v2: Added a range check

Reported-by: Ellis Michael <ellis@ellismichael.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 45 +++++++++----------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 007a3db69df1..ecb4c3abc629 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1242,6 +1242,24 @@ static void init_interrupts(struct device_queue_manager *dqm)
 			dqm->dev->kfd2kgd->init_interrupts(dqm->dev->adev, i);
 }
 
+static void init_sdma_bitmaps(struct device_queue_manager *dqm)
+{
+	unsigned int num_sdma_queues =
+		min_t(unsigned int, sizeof(dqm->sdma_bitmap)*8,
+		      get_num_sdma_queues(dqm));
+	unsigned int num_xgmi_sdma_queues =
+		min_t(unsigned int, sizeof(dqm->xgmi_sdma_bitmap)*8,
+		      get_num_xgmi_sdma_queues(dqm));
+
+	if (num_sdma_queues)
+		dqm->sdma_bitmap = GENMASK_ULL(num_sdma_queues-1, 0);
+	if (num_xgmi_sdma_queues)
+		dqm->xgmi_sdma_bitmap = GENMASK_ULL(num_xgmi_sdma_queues-1, 0);
+
+	dqm->sdma_bitmap &= ~get_reserved_sdma_queues_bitmap(dqm);
+	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
+}
+
 static int initialize_nocpsch(struct device_queue_manager *dqm)
 {
 	int pipe, queue;
@@ -1270,11 +1288,7 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
 
 	memset(dqm->vmid_pasid, 0, sizeof(dqm->vmid_pasid));
 
-	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
-	dqm->sdma_bitmap &= ~(get_reserved_sdma_queues_bitmap(dqm));
-	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
-
-	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
+	init_sdma_bitmaps(dqm);
 
 	return 0;
 }
@@ -1452,9 +1466,6 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 
 static int initialize_cpsch(struct device_queue_manager *dqm)
 {
-	uint64_t num_sdma_queues;
-	uint64_t num_xgmi_sdma_queues;
-
 	pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
 
 	mutex_init(&dqm->lock_hidden);
@@ -1463,24 +1474,10 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	dqm->active_cp_queue_count = 0;
 	dqm->gws_queue_count = 0;
 	dqm->active_runlist = false;
-
-	num_sdma_queues = get_num_sdma_queues(dqm);
-	if (num_sdma_queues >= BITS_PER_TYPE(dqm->sdma_bitmap))
-		dqm->sdma_bitmap = ULLONG_MAX;
-	else
-		dqm->sdma_bitmap = (BIT_ULL(num_sdma_queues) - 1);
-
-	dqm->sdma_bitmap &= ~(get_reserved_sdma_queues_bitmap(dqm));
-	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
-
-	num_xgmi_sdma_queues = get_num_xgmi_sdma_queues(dqm);
-	if (num_xgmi_sdma_queues >= BITS_PER_TYPE(dqm->xgmi_sdma_bitmap))
-		dqm->xgmi_sdma_bitmap = ULLONG_MAX;
-	else
-		dqm->xgmi_sdma_bitmap = (BIT_ULL(num_xgmi_sdma_queues) - 1);
-
 	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
 
+	init_sdma_bitmaps(dqm);
+
 	return 0;
 }
 
-- 
2.32.0

