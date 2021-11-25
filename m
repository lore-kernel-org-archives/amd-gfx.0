Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A780C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB716E930;
	Thu, 25 Nov 2021 10:58:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39D4893DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dom7pTX2ahN4MDBL2ceWE/kWsYqa/aL6q1xfYYriO/jmHmdqYfmFxU+atmyVU5VAtm3rVjZhMJqF/4wGgAZfLdgvy5YJ90bmoQSIWshYvW4DY85u4XBq1imy0l+7kFt2FsMxLFu2FwINwmubdPcqKIJ/b6HEnnz1YNiwxVuuV8cAtiZQgsV2bbbhcpH0IRb1wAlZ21i2/bBfks4aXNaP8zVk1FIorHwJZqJaVpyGpRY7fvm2VkW/7Ni2ZjgqqpyEOixxzHU2zpfSmfMuyKMTJAJR1rYav6ACgDEhMVAHE0l0jagKOX8i+5h7oTG7ZTbr+3LWkjtRKNBHPmQKh+8dog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhCNPb3IDOKDPaFOcdQKpTfiTNYvIDVKF62L/Ey/3EM=;
 b=JgpCU0yoKnAvQUYp/WVdBAp0sxft9/jmC0MCuJtd7cC44hRFlRUfMUGXAu6zyJBmleh532uf/7v7koVUBJJ5sqfSvsTUVYVfZZcXTeuoOJ+uFTdP56gTmdFDeheBi+cittgX7g77WwqOBNTlDfpKyn++voVUV++FUIR5mrwpB1YBZsKYccfQbyjv24veCmXymrJtbTRCrAfCclc+rmZxJKMTywn+PSK5PWNzQj66M3SvOzJ4qO2Vh1IqyyXTC/0PCZQAHst9jZdWRamQtHmvpEl1Wd/7NfKKqxOhknuADeTfvUkKYqoaRoz2sN0B1POVf7qqhXdU+OM2o68Ny+ZFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhCNPb3IDOKDPaFOcdQKpTfiTNYvIDVKF62L/Ey/3EM=;
 b=g2YY7N8j5xLTCtHjHPL67kkU2o9Bs6G0eNqJPSCqdW9yfi+xl3Fy0tfxzLq02f1PZjeIdWHnjwGiyPkS7zwUKnNWqFnEacVwIxnYRF5Xp8JK/QWQ+AB/zOOjLiOIRkDi4IlgOvnRQLTprpRhrO6FVJlszeFaUYx1Au8dp1whpGs=
Received: from DM5PR1101CA0001.namprd11.prod.outlook.com (2603:10b6:4:4c::11)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 10:58:55 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::21) by DM5PR1101CA0001.outlook.office365.com
 (2603:10b6:4:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 10:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:58:54 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:53 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/9] drm/amdgpu: Modify mmhub block to fit for the unified ras
 function pointers.
Date: Thu, 25 Nov 2021 18:56:58 +0800
Message-ID: <20211125105701.15860-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125105701.15860-1-YiPeng.Chai@amd.com>
References: <20211125105701.15860-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1dc5728-87dc-4c80-182f-08d9b00292d8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-Microsoft-Antispam-PRVS: <SA0PR12MB442945A0CEF3BE435C0B9CF6FC629@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV2ePv1bjFA/CL6xtJFKobBlM2sSejmFj4lGSZJNYe9wToaNCGe8CpgYV/ziEyS2vnMWphjkw936Cuc6b1ioQpI1QmyGh8o42uf61S4cypkW0+CpT3WTfy338SvwtGHtWheOjl6tIViDT8SOrPXPmMZKewxaV53yl34fyTJcjkqIQlerYeTm3iT54j0l8ofoV4Crny3rUTcH77YpY0Gp1AaTsG443w1ikuLJmXub32RUMzk+9Or4HyUmWh2da5hcnbcHaRP9EJMnU0WVNRmN4qTXb401QrMsh2CtgZhpBr7H/h4AnDdTcnWq9pvIfVvHjLvGqMgHoj9KCp/W88BjxMCvenYceA9sETVvZY37PN84hbLkt8CF+9z4MVw4lcJ9v2vKNJQ7J0cYQW/GWKZT6WhVM0id0u7g7KREHC/igMQ9Y6fPsR283dtlO3ALt1wYVLTwsU+V8znyhhxG7eZn/Ba4e0EPmev3HW/G4ev+9qCXciPooJ64XUV/9EAIswZHkHC+W988sejUApnusTUPs34ODNLgjgJInQgQjDADx/qwL11qk+/M/3XDpKloY1cFrmNKFgovym9zonFx2L+AC8isfC6++xu51MNiJ+ULCmk0Z/6OB7U7n1Z92DV4QwwNqmjGCho5wonO9OHtauA+7S00XXOsEnqiNButqXq1mjKyMebN+SFZYdzKC2SY4h2KJqdEE+0yxnnQFyd8/OCLbHVC4T7pjZQWJJ90wyxxM59V5hcn1QX7s94K13+w9PGd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(508600001)(316002)(26005)(2616005)(2906002)(336012)(70586007)(83380400001)(70206006)(7696005)(36756003)(1076003)(186003)(16526019)(47076005)(36860700001)(356005)(81166007)(54906003)(86362001)(8936002)(4326008)(5660300002)(6916009)(8676002)(82310400004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:58:54.8835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dc5728-87dc-4c80-182f-08d9b00292d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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

Modify mmhub block ras funcions to fit for the unified ras function pointers.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h  |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 12 +++++++-----
 8 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 73ec46140d68..fcdd06bdb5d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3378,8 +3378,8 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 			goto fail;
 
 		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+		    adev->mmhub.ras_funcs->ops.reset_ras_error_count)
+			adev->mmhub.ras_funcs->ops.reset_ras_error_count(adev);
 	} else {
 
 		task_barrier_full(&hive->tb);
@@ -4704,8 +4704,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	if (!r && amdgpu_ras_intr_triggered()) {
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			if (tmp_adev->mmhub.ras_funcs &&
-			    tmp_adev->mmhub.ras_funcs->reset_ras_error_count)
-				tmp_adev->mmhub.ras_funcs->reset_ras_error_count(tmp_adev);
+			    tmp_adev->mmhub.ras_funcs->ops.reset_ras_error_count)
+				tmp_adev->mmhub.ras_funcs->ops.reset_ras_error_count(tmp_adev);
 		}
 
 		amdgpu_ras_intr_cleared();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 024342969267..7780effdf3ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -442,8 +442,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->mmhub.ras_funcs &&
-	    adev->mmhub.ras_funcs->ras_late_init) {
-		r = adev->mmhub.ras_funcs->ras_late_init(adev);
+	    adev->mmhub.ras_funcs->ops.ras_late_init) {
+		r = adev->mmhub.ras_funcs->ops.ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -496,8 +496,8 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 		adev->umc.ras_funcs->ras_fini(adev);
 
 	if (adev->mmhub.ras_funcs &&
-	    adev->mmhub.ras_funcs->ras_fini)
-		adev->mmhub.ras_funcs->ras_fini(adev);
+	    adev->mmhub.ras_funcs->ops.ras_fini)
+		adev->mmhub.ras_funcs->ops.ras_fini(adev);
 
 	if (adev->gmc.xgmi.ras_funcs &&
 	    adev->gmc.xgmi.ras_funcs->ops.ras_fini)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index b27fcbccce2b..ff7f28ef1d6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -20,15 +20,10 @@
  */
 #ifndef __AMDGPU_MMHUB_H__
 #define __AMDGPU_MMHUB_H__
+#include "amdgpu_ras.h"
 
 struct amdgpu_mmhub_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*query_ras_error_status)(struct amdgpu_device *adev);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
-	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+	struct amdgpu_ras_block_ops ops;
 };
 
 struct amdgpu_mmhub_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e7cd2de07665..2d9ef677a2ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -929,12 +929,12 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_count)
-			adev->mmhub.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->mmhub.ras_funcs->ops.query_ras_error_count)
+			adev->mmhub.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 
 		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_status)
-			adev->mmhub.ras_funcs->query_ras_error_status(adev);
+		    adev->mmhub.ras_funcs->ops.query_ras_error_status)
+			adev->mmhub.ras_funcs->ops.query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 		if (adev->nbio.ras_funcs &&
@@ -1027,12 +1027,12 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+		    adev->mmhub.ras_funcs->ops.reset_ras_error_count)
+			adev->mmhub.ras_funcs->ops.reset_ras_error_count(adev);
 
 		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_status)
-			adev->mmhub.ras_funcs->reset_ras_error_status(adev);
+		    adev->mmhub.ras_funcs->ops.reset_ras_error_status)
+			adev->mmhub.ras_funcs->ops.reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->reset_ras_error_count)
@@ -1739,8 +1739,8 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_status)
-			adev->mmhub.ras_funcs->query_ras_error_status(adev);
+		    adev->mmhub.ras_funcs->ops.query_ras_error_status)
+			adev->mmhub.ras_funcs->ops.query_ras_error_status(adev);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c40c669d49c3..4470049874c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1297,8 +1297,8 @@ static int gmc_v9_0_late_init(void *handle)
 
 	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
 		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+		    adev->mmhub.ras_funcs->ops.reset_ras_error_count)
+			adev->mmhub.ras_funcs->ops.reset_ras_error_count(adev);
 
 		if (adev->hdp.ras_funcs &&
 		    adev->hdp.ras_funcs->ops.reset_ras_error_count)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index b3bede1dc41d..3b7133fb0cf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -775,10 +775,12 @@ static void mmhub_v1_0_reset_ras_error_count(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_mmhub_ras_funcs mmhub_v1_0_ras_funcs = {
-	.ras_late_init = amdgpu_mmhub_ras_late_init,
-	.ras_fini = amdgpu_mmhub_ras_fini,
-	.query_ras_error_count = mmhub_v1_0_query_ras_error_count,
-	.reset_ras_error_count = mmhub_v1_0_reset_ras_error_count,
+	.ops = {
+		.ras_late_init = amdgpu_mmhub_ras_late_init,
+		.ras_fini = amdgpu_mmhub_ras_fini,
+		.query_ras_error_count = mmhub_v1_0_query_ras_error_count,
+		.reset_ras_error_count = mmhub_v1_0_reset_ras_error_count,
+	},
 };
 
 const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index f5f7181f9af5..841fba8b0e08 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1322,12 +1322,14 @@ static void mmhub_v1_7_reset_ras_error_status(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs = {
-	.ras_late_init = amdgpu_mmhub_ras_late_init,
-	.ras_fini = amdgpu_mmhub_ras_fini,
-	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
-	.reset_ras_error_count = mmhub_v1_7_reset_ras_error_count,
-	.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
-	.reset_ras_error_status = mmhub_v1_7_reset_ras_error_status,
+	.ops = {
+		.ras_late_init = amdgpu_mmhub_ras_late_init,
+		.ras_fini = amdgpu_mmhub_ras_fini,
+		.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
+		.reset_ras_error_count = mmhub_v1_7_reset_ras_error_count,
+		.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
+		.reset_ras_error_status = mmhub_v1_7_reset_ras_error_status,
+	},
 };
 
 const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ff49eeaf7882..1173190c4d8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1656,11 +1656,13 @@ static void mmhub_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_mmhub_ras_funcs mmhub_v9_4_ras_funcs = {
-	.ras_late_init = amdgpu_mmhub_ras_late_init,
-	.ras_fini = amdgpu_mmhub_ras_fini,
-	.query_ras_error_count = mmhub_v9_4_query_ras_error_count,
-	.reset_ras_error_count = mmhub_v9_4_reset_ras_error_count,
-	.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
+	.ops = {
+		.ras_late_init = amdgpu_mmhub_ras_late_init,
+		.ras_fini = amdgpu_mmhub_ras_fini,
+		.query_ras_error_count = mmhub_v9_4_query_ras_error_count,
+		.reset_ras_error_count = mmhub_v9_4_reset_ras_error_count,
+		.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
+	},
 };
 
 const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
-- 
2.25.1

