Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59630C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00986E51D;
	Thu, 25 Nov 2021 10:58:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38896E51D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krYN+qwUFCBLBFMY8l2giDbrXSjxAGOKu2fbLN/GJYNQd0vCv2fnWeaI6D1afvoqmXclkDP6H7Ozamtr5Y1I/5t675s8/yrppUEc51ULunwsAzovCCC1Z1vC9m+zRp+mZlVZ2GlovYh1h0+asK8MXGM7EEngSX9ZtRecuYXm2AcfSNI+zqqFpZ1Xsg7lO6alvHwG11KVF6QXU0drIE7VO1dU+VlZG9Odr+w9PfLvBy4SDVZyWCY9VQSrngJ+kAxC6ZIKMiHUDKoPDEUKnk4QWRt7em+YWugEAptXtJmUCLNTx+1nNgdMhOQPIZPB95cUOFpKXSnFQysRAsGRHlYW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VmnZ+C1bL8X+590qnmrIgXHH/w5hLMB42fdmOBZEXw=;
 b=MPIm/7ZFUp6fETEAlSrl/khVh/QAfb5EfVaGY9v+54bkPUihzE10IRpxrSYAvcNMeIQsBrR5Z8c2NAOX4pOJmZcYrIGJrxk6gG7RuW0f0gy43KMWn1n8XzE1plK2LTTm6mSuHZ9C6givvGzGgwrcGf4byTFt5JDDtkyZg4JGE/YQo5XCNCnKkIYVZKFCLYL2ANOxz8uBX4Mq6FB9vq3XFR35Etdcq5MB0G7KXSPrSfeK+vFQFYPG+h5IitFgSjZgURetvQGjQ6Jn5+oeAhzM33ekl87T/NR5NWnlgEfVAmGkMipiCRp/HnAbtWeZmf64I6aBe0kHBaVL+HOJBjPjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VmnZ+C1bL8X+590qnmrIgXHH/w5hLMB42fdmOBZEXw=;
 b=01zN8FHh/sD5bIm0OA0jDXfuQmv51H9uHYif8Nc2aeLP/VhyOGQ1fTuGYbhDTJNYWDhvgZR9bOQqR/HRxYqhNgAeX3/5f1ltO1PngRo3diLH16C2xEG45wu3muRxVPPoi0iynoucCeLP5KldKkSWH9ity+diQwALvA7zyVwwIYc=
Received: from DM5PR12CA0058.namprd12.prod.outlook.com (2603:10b6:3:103::20)
 by MN2PR12MB3888.namprd12.prod.outlook.com (2603:10b6:208:162::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 10:58:20 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::d7) by DM5PR12CA0058.outlook.office365.com
 (2603:10b6:3:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Thu, 25 Nov 2021 10:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:58:19 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:18 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/9] drm/amdgpu:Define the unified ras function pointers of
 each IP block
Date: Thu, 25 Nov 2021 18:56:53 +0800
Message-ID: <20211125105701.15860-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce934e8c-dbf3-4eb2-ee9d-08d9b0027de5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3888:
X-Microsoft-Antispam-PRVS: <MN2PR12MB388865D46786BFFAD30E8B63FC629@MN2PR12MB3888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Roo6qqHhFVWBZvTIKVwsDRNZNIGrZRWOhHXcYbUp5Ydpl/j9h2cHJ6IXT6It5K0+UgYJ8cyD1DfqOvysXvI0fHHUQqpyktzJtEG9+GdaSxqdScSMObkwaiJ5F6/97Pee6i9DBrlnyBBVrByBnoBoUPOWT2D7RVTYkubSynRpUSlA8TnbSbCCrogbaz/oRcyR3x1IgBQM0umaS5OONacMqXjg5zmZmePQhFXHwN5zrO7Sf4DkzE0KkxWJ/gGhdBOIZ9dz3k3+gi2BSnsyUPNKXwJK4AkKhDCh35AGgredfNLpM4hE6T48MCXvLASY2jj7xo6B2ifkaVL1lyiP4DwZUbfuNr777emnB3QT0N9b1uRFr2b+K1nNDXhRq4PtWNdfRvUvH3FJj+Ng50+ujpTd9Y9N6XvWrehD8vxoGNtW3+ckbqmdBoMYe8akjO3ovqyMLchs/bcYmYghl/mim725nox3VbFA6p9NQ44vXmeUSJhV2juI/AnSIir2z7FaIUd26Fd1yqy+eOoAjXtjUYd88szkWirqDMAA2pdvVGG1n9OyALNhi08UUkx3aMvpMZWuqzAWLiWJZVPLFtHqQ6b+7CpbsSPk0dwHzfKP1SWm18pYriEIZtZPZQk92inX3w3Oc+F5JyEFyn9+TRczbElFmowXQ5zJ909f/OvOZPKB7f51zmeG/6cAnI5iGFzUudBGfX/8p33amNegNkDFPIlULhaSQja8pwmuurlt54RrYy4wRq/Jf65W5FHzVZV4CUA0JYvFrzOzqva7BrSnjSkLTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(4326008)(70206006)(8676002)(6916009)(8936002)(86362001)(16526019)(186003)(7696005)(70586007)(1076003)(508600001)(6666004)(2616005)(336012)(5660300002)(83380400001)(54906003)(81166007)(316002)(36756003)(47076005)(82310400004)(26005)(2906002)(426003)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:58:19.7420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce934e8c-dbf3-4eb2-ee9d-08d9b0027de5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3888
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
Cc: yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define an unified ras function pointers for each ip block to adapt.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 20 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 36 ++++++++++++-------------
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 90f0db3b4f65..dc6c8130e2d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2739,3 +2739,23 @@ static void amdgpu_register_bad_pages_mca_notifier(void)
         }
 }
 #endif
+
+/* check if ras is supported on block, say, sdma, gfx */
+int amdgpu_ras_is_supported(struct amdgpu_device *adev,
+		unsigned int block)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (block >= AMDGPU_RAS_BLOCK_COUNT)
+		return 0;
+	return ras && (adev->ras_enabled & (1 << block));
+}
+
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
+		schedule_work(&ras->recovery_work);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index cdd0010a5389..4b7da40dd837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -469,6 +469,19 @@ struct ras_debug_if {
 	};
 	int op;
 };
+
+struct amdgpu_ras_block_ops {
+	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
+	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
+	void  (*query_ras_error_count)(struct amdgpu_device *adev,void *ras_error_status);
+	void (*query_ras_error_status)(struct amdgpu_device *adev);
+	bool  (*query_ras_poison_mode)(struct amdgpu_device *adev);
+	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+};
+
 /* work flow
  * vbios
  * 1: ras feature enable (enabled by default)
@@ -486,16 +499,6 @@ struct ras_debug_if {
 #define amdgpu_ras_get_context(adev)		((adev)->psp.ras_context.ras)
 #define amdgpu_ras_set_context(adev, ras_con)	((adev)->psp.ras_context.ras = (ras_con))
 
-/* check if ras is supported on block, say, sdma, gfx */
-static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
-		unsigned int block)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (block >= AMDGPU_RAS_BLOCK_COUNT)
-		return 0;
-	return ras && (adev->ras_enabled & (1 << block));
-}
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
 
@@ -512,15 +515,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
 
-static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
-		schedule_work(&ras->recovery_work);
-	return 0;
-}
-
 static inline enum ta_ras_block
 amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 	switch (block) {
@@ -652,4 +646,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block);
 
 bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
 
+int amdgpu_ras_is_supported(struct amdgpu_device *adev,	unsigned int block);
+
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

