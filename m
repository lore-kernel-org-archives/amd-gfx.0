Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FA5C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523DF113948;
	Thu, 18 Apr 2024 03:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Rhjc9/X";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF035113947
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYuflWsa5Yk6+Jro/E7D60e8rCUq/2TT+glPweTkLKUbRJ0h+nRBnmvwYu3bDoYa3KXkOwXbamKACTHtzt8t/vQuA3mCu87UP7pKvkJI1vVYjjFEL4T/KJHkvSlM+uHRy5SuRs1Dh+FWR7NHGj2jYz+n5DkPuEb9WhYWyIsigHIjNzplRHRAtEDSEhlp/a/wYAwGab3xoUtjYynqhpe1FolYbV1sy6WOu9VLe6+QZgdOFAEcpGEKny5S0Vkwr1yGIXokLdiLyU/sTWTxqVa9cIkBsdiB5v6I2SVl2x1Td7NmXKQVb6tQJ6oWyKyOrqh5tTeIgnzGYd9LD8xNwZOosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRFJDXYGI8uwVYf6OepdG8WrETEy592AlNZkPZu+tgM=;
 b=WXWFo0eRpQSKTLIZGporMXCN5bTxfzIfZyhKE1W3R03P5SOuTrU0VCLoL5xfhLwp5Lid+rjEBIfV/MIjd4EG6dJa05/D4bYDZ+4bjXUfh2WY10/eDzHPzWtmnu9w4gUVmYJtBf1NQuDjL8W1IDPrEWJ/Ukw47g/q2zu23wL0dH65eHo0zPcyswRqXgRyowlSLVDFOj+vObvQMYfx7tY2lF0IwlzdeG/wURtlnWpNFD3dATJLYEognf4GstYhUJnYZZk94V4/YAWm6bgiUL+Keh8K/YZMcc+Yooqv43gszu8KvpMois0B+v7YkOW9VpvEK+ZG2ag20G7TVwsGJIILoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRFJDXYGI8uwVYf6OepdG8WrETEy592AlNZkPZu+tgM=;
 b=5Rhjc9/XeNOs3GiiOiK7NenlUkJivT8LU6r55/uA9fqzGfHJQA/ugUa/nbu6di1q9UlbrWZ4TDmMKFqhmX4fkMjaqmpjkH2enKNGytJyuGrcU3nyVz2l8W+nIA/4RJEsI3+qAqwBvuUidtcU/GLy/m0iiNwULRXRlLJs5WiP0WY=
Received: from MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 03:01:53 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::25) by MN2PR05CA0053.outlook.office365.com
 (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:53 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:50 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 08/15] drm/amdgpu: Add delay work to retire bad pages
Date: Thu, 18 Apr 2024 10:58:29 +0800
Message-ID: <20240418025836.170106-8-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: bafc4d7e-2604-45d6-d588-08dc5f53e666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JunuFc4RtXD+XSPdKvBgg06Hb0GTEo7z0Z2K5dXgc61SRN41HpieeeER4H7OZP/t8GqgzkGtaNW4pVtY0qOlcMD/Yoah2qhDuqAO02vFpVNbpg/JBqqtQGOPctL1MDoqJhHIHL2rW5NMNYetRsOKgryTG3xxkejrJWHVbQ8SooEZNhmECypImnHCZawDFa5fcXGLO5I7pvQIUaYfFNNnXadWi6I1SW9nzMezsmu+Mt99OMS4P04wgC1PDENdIl3x3D52cjN0fa+9SFX+8lPnAoObuTkni2gKnPWJVf/aV51Gs7srV2P06hVEBZyFF4gX4/cILEN1gGOWT3w+ApAIYmj1sKNhrBzIW/BcPH5kS2RMnZGg+hEur/SiwasZuy016JPxzvjwVosEZE7cY9ZAbX68wAr51mg/k7vZcO52k/pqF7WG9PWAjKazd1SxkxgA0tgmEpeTMRxXwQxXnlL9/bzVOUgLp0ahRIuYzITKyedOM1IqSiIwbgSLFWZFd5+4XejITdIaL9g9+Q+KYZDguLDO8A0bgoTIlmqmlqGpy0gp45UVV9CGthEJPjpxeOVh4IMSj6s2wklM9w8yGd/ea+ablcR3a5B0hhi31jZ5uMUCLpJodcYIC+7/rQm4PcZlIeUmOhRqAMdnsyQ06X8Ot8+Bx50AiZzHX8eRavf/meuyGcxMe2uUSiOb2TBaDnfjN79OCS2A6E63vIzmY4dpA2y9nOItPw2a993ca9cATkZsSboG3vfbnDkEexVm7BhS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:53.0316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafc4d7e-2604-45d6-d588-08dc5f53e666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
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

Add delay work to retire bad pages.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 36 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  3 +++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 702229abe7ee..c1f146d3e28d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 
 #define MAX_UMC_POISON_POLLING_TIME_ASYNC  100  //ms
 
+#define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -2766,6 +2768,30 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	ecc_log->de_updated = false;
 }
 
+static void amdgpu_ras_do_page_retirement(struct work_struct *work)
+{
+	struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
+					      page_retirement_dwork.work);
+	struct amdgpu_device *adev = con->adev;
+	struct ras_err_data err_data;
+
+	if (amdgpu_in_reset(adev) || atomic_read(&con->in_recovery))
+		return;
+
+	amdgpu_ras_error_data_init(&err_data);
+
+	amdgpu_umc_handle_bad_pages(adev, &err_data);
+
+	amdgpu_ras_error_data_fini(&err_data);
+
+	mutex_lock(&con->umc_ecc_log.lock);
+	if (radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
+				UMC_ECC_NEW_DETECTED_TAG))
+		schedule_delayed_work(&con->page_retirement_dwork,
+			msecs_to_jiffies(AMDGPU_RAS_RETIRE_PAGE_INTERVAL));
+	mutex_unlock(&con->umc_ecc_log.lock);
+}
+
 static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
 			enum amdgpu_ras_block ras_block, uint32_t timeout_ms)
 {
@@ -2804,7 +2830,12 @@ static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
 static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 					uint32_t timeout)
 {
-	amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC, timeout);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	int ret;
+
+	ret = amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC, timeout);
+	if (!ret)
+		schedule_delayed_work(&con->page_retirement_dwork, 0);
 }
 
 static int amdgpu_ras_page_retirement_thread(void *param)
@@ -2919,6 +2950,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "Failed to create umc_page_retirement thread!!!\n");
 	}
 
+	INIT_DELAYED_WORK(&con->page_retirement_dwork, amdgpu_ras_do_page_retirement);
 	amdgpu_ras_ecc_log_init(&con->umc_ecc_log);
 #ifdef CONFIG_X86_MCE_AMD
 #ifdef HAVE_SMCA_UMC_V2
@@ -2967,6 +2999,8 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 
 	cancel_work_sync(&con->recovery_work);
 
+	cancel_delayed_work_sync(&con->page_retirement_dwork);
+
 	amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);
 
 	mutex_lock(&con->recovery_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 634654cf2634..cb5a0f31d201 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -537,6 +537,7 @@ struct amdgpu_ras {
 	struct mutex page_rsv_lock;
 	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
 	struct ras_ecc_log_info  umc_ecc_log;
+	struct delayed_work page_retirement_dwork;
 
 	/* Fatal error detected flag */
 	atomic_t fed;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0f2d765c4e2d..2bd88218c20e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -89,7 +89,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
+void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index c83d24097c5c..2d08d076f7c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -133,4 +133,7 @@ int amdgpu_umc_build_pages_hash(struct amdgpu_device *adev,
 		uint64_t *pfns, int len, uint64_t *val);
 int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 		struct radix_tree_root *ecc_tree, struct ras_ecc_err *ecc_err);
+
+void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
+			void *ras_error_status);
 #endif
-- 
2.34.1

