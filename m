Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B646C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D826F10F213;
	Mon, 21 Feb 2022 10:17:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8457110F1F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT3+KfM9fg+pJEs85VeRQcw0JyGvQdmL/sxbyGWQdKf+YramTBzvHVaSlt6a82eB0TOGXydnQJSf2gLdPV01twuKmJb8+eNLF9QMJ6z2Hb0sSHxO5u98KDyzB3OR09e40mxlA4hRfAmJgvtIxfTl8dwRIDU5oNLxnijT1lYpLgqPR1eOoy7jBe1mrL/SkpztlWNlEzM0EROXp+/yPe47mPWIUHO/O44mcteukOUKWoqfmH1RHKktOFZE9bF+8WxUkIbEgJHv7vBTNNsC9gq7AVcLeF+xAo8kj3/HlzVOtzxCwHu6QyGj3lWXs59PzzrVE9vyveJzDWuymSvZloP1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Umny61S3kOPNzMyio48PZ7cICznxykOdUArzBq6H+/k=;
 b=bDzMVgzvKaDjGXNa1Rz3VIDpeFv+/E380+FPZv3wq00kCwYdjI2XIjcZo4o7Ibd5eufaYrlysRNJTPZSUjT20ttRyvRDjQ0SgjHtfR/DSHaFJgbOLGNBm7O4fRh3AJEu/5XMN+gm5y1VTj+NNWsVT/CJqGLmqQlk4cwqTlCDMUUuhZJUpMNOa5T/I1Lev1r41MGUH2dMXxIxYp38agtuuS8k9nwYLHEWHUb+tLU4zuDQBFiaXP+2R4SzG7o9rX7O4zpWwL80Kx/9INwedNWdUxSMH6jjX0eDESWKet0S6rylLgIcw1euo1b2r1YRQsjNFWQZr/paUKwHXrt7XsaunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umny61S3kOPNzMyio48PZ7cICznxykOdUArzBq6H+/k=;
 b=eFVXjZjRhUj1BIRWTk086VNAZ3MYB3/ylW1fNCxOG/9VUXQQr1XwlBvoPCOThJUB2uSOTKIjfx2AQocLUr314+i96wOsgZoxVfVVG7i98GZLYLJEGUjxdVyTRkz6mOoMvV7/eVnPDu6XOVh94QMit0bwAhx2VkltsdAD1REXHAY=
Received: from DM5PR07CA0047.namprd07.prod.outlook.com (2603:10b6:3:16::33) by
 DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Mon, 21 Feb 2022 10:17:00 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::3f) by DM5PR07CA0047.outlook.office365.com
 (2603:10b6:3:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:00 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:16:57 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amdgpu: centrally calls the .ras_fini function of
 all ras blocks
Date: Mon, 21 Feb 2022 18:16:11 +0800
Message-ID: <20220221101620.3269611-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3db360f-d1b0-4d79-c816-08d9f5234c59
X-MS-TrafficTypeDiagnostic: DM5PR12MB1787:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1787811028CAC55FD8E54C71FC3A9@DM5PR12MB1787.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oErdxpWEoVXxj3DVA08gWSyuDzGEIWL4ELQ9UusR2sBR4HJkAmLjA87LVVoVXeOEvO+5jZnHh5/BaQeAC7RKxobeZzKwTxN6Ill1jB3JmvHMgehGYNPeEEjkMe2SkrklT02jkObN6MoN0h112qdPyqfpc+2ZNkqKFLVEmhySNgWd9MV0f7IY/Hczd4Bot1DgWGOyQCcuY4MwxAlUrw6ezSoT1g1AGOX0vSzTnAUEq1nYJQ9vca9jy27X0hizmdpk6YxVFcXps0FADYlto6NJhuGXmKDxPVBJvNE4gEGd9yGgnlzdEPUNxxXlCKn7w6xPWDfNlyVxtAXAS0WW/2uLTOtQPKmetPZMXb0Rh9zgpCwBQchkPfkRTMqYAsZImskGdwnK9I9Ir0E/uc/tZYr2MhFjNaMSWmC3rYrrpVZWe3SAek+cgkZZcVYtRIJyBlT6KogQgoG56xuMUH6MAiUC1kLsTGZCc1+B3LrLVvmXMg1msqMIYmw8Rj7gaQtIeWAHU7SKu+0S71ql63SLDFe3nZUnvoESCPM/N7kvCuXuauCgQOp/xA2hC+MB42UjzHfGTBzkfRBS6PdoTr3VIAr1Rfqq9BEX+P5DkGzCSiG5/PIAD5hjllUDRwGIWYGc1DXYDh5BSBfzCFOMUStQsEIHl5OuEhKOHx/Y5ygEJ88hcDEdmV1WZPvLqZuKF9vEiMcME2WDWzsrWqd9ut2ApbPI7R4hyb2jH5xzT4tfokXINrVOP7oRua+IRG9ix4AQvxNrUljbmDQuUwnT+57uxln2oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(70206006)(2906002)(6666004)(8676002)(4326008)(7696005)(81166007)(8936002)(508600001)(356005)(82310400004)(36860700001)(86362001)(316002)(5660300002)(2616005)(16526019)(426003)(336012)(1076003)(36756003)(186003)(26005)(40460700003)(83380400001)(47076005)(54906003)(6916009)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:00.2154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3db360f-d1b0-4d79-c816-08d9f5234c59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1787
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

centrally calls the .ras_fini function of all ras blocks.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c  |  4 ----
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  3 ---
 5 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4823c42e0e02..ab75e189bc0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -454,17 +454,7 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 {
-	if (adev->umc.ras && adev->umc.ras->ras_block.ras_fini)
-		adev->umc.ras->ras_block.ras_fini(adev, adev->umc.ras_if);
 
-	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_fini)
-		adev->mmhub.ras->ras_block.ras_fini(adev, adev->mmhub.ras_if);
-
-	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
-		adev->gmc.xgmi.ras->ras_block.ras_fini(adev, adev->gmc.xgmi.ras_if);
-
-	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_fini)
-		adev->hdp.ras->ras_block.ras_fini(adev, adev->hdp.ras_if);
 }
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5874df3c9ca..846f51b0c013 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2572,11 +2572,27 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 int amdgpu_ras_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_block_list *ras_node, *tmp;
+	struct amdgpu_ras_block_object *obj;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	if (!adev->ras_enabled || !con)
 		return 0;
 
+
+	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
+
+		if (ras_node->ras_obj) {
+			obj = ras_node->ras_obj;
+			if (amdgpu_ras_is_supported(adev, obj->ras_comm.block) &&
+				obj->ras_fini)
+				obj->ras_fini(adev, &obj->ras_comm);
+		}
+
+		/* Clear ras blocks from ras_list and free ras block list node */
+		list_del(&ras_node->node);
+		kfree(ras_node);
+	}
+
 	amdgpu_ras_fs_fini(adev);
 	amdgpu_ras_interrupt_remove_all(adev);
 
@@ -2590,12 +2606,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	amdgpu_ras_set_context(adev, NULL);
 	kfree(con);
 
-	/* Clear ras blocks from ras_list and free ras block list node */
-	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
-		list_del(&ras_node->node);
-		kfree(ras_node);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e8446967a4d4..dc6e6fe6c978 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2432,9 +2432,6 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_fini)
-		adev->gfx.ras->ras_block.ras_fini(adev, adev->gfx.ras_if);
-
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 222d25a0413a..d1d40bbb2892 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1995,10 +1995,6 @@ static int sdma_v4_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
-		adev->sdma.ras->ras_block.ras_fini)
-		adev->sdma.ras->ras_block.ras_fini(adev, adev->sdma.ras_if);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 		if (adev->sdma.has_page_queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0631ebd39db1..496c4a6e23ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1214,9 +1214,6 @@ static int soc15_common_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_fini)
-		adev->nbio.ras->ras_block.ras_fini(adev, adev->nbio.ras_if);
-
 	if (adev->df.funcs &&
 	    adev->df.funcs->sw_fini)
 		adev->df.funcs->sw_fini(adev);
-- 
2.25.1

