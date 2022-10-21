Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BC4C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9893C10E614;
	Fri, 21 Oct 2022 07:37:06 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D911310E614
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 07:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el8Lloe+0KSixHMh6RvkMZi//Tsar2E/YqPODUIi2XlDDrIMRqFRYJBfzRLuWCpqlM2h9zzxFb5cSXcwsPtlPt2zcvcMzNEJle33lGw5MQxnRhrBLRghZDPHz1lF0Cxv80AKwi7rfrJwWiyp7MUnRdaiY/2weO6bBIom56gf/qI21lzfsQdaXcn6m7+nuayGI+LlEMMGHR/l0xafwxWlCP0ukzhh1sZXLN5x5tU8lIxgR2fX9B/JVu1Z8O6EEqfuSDGXXjJyNeX61KPsvg4zt+9veE7TlRK9zlqTKOU2XvjrgpzvrsCEtIdDcg9AKof68Hucklc450xpwHcWD47Grw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ypa7DBZ7OYfL+Fo3r/lXcVqnzCNyHlzglzGPD3iCnU=;
 b=Z1M+DHHYO0PWV8VrRqB9PNAu55yj+QsPXZRwZbBuWY5Eha5nvvJrWnmGZsA/Z1uVi+qoHkbWE2k+C4vo/Z0XO0tlKsRx4l+/LsaJY16XEpwF2JIxY1WtK7xAPMQB9EMUDd4yI40CEiMX6C5jheYOqKNh+hgKwyLQpEJ+OiVKjYsFLd+sSmAy36gotbeIjZoH/1gJ8Fr//d+yauS0VL36KrqaN6sAeeMc/eTe9XFMUXJW8LlbGjMqj/1JjRbg6YLk/iUKej5pj7p4uZw08GZdjhx8UA/w/E+gFzx8tijLE6uAmGDoUeWX85Gl/wTDpTBj+gzAr5cbZHHg4cjyInkbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ypa7DBZ7OYfL+Fo3r/lXcVqnzCNyHlzglzGPD3iCnU=;
 b=BNNfbfq+40rnVhvARJ1GTVAbD0R5SeMtVC1f8ZPIwjlJ8cSXeK2BRmWoqDZCbfMcIXwlATF8vXwNY6wUs0o5J8rcozvYnre8TakhZb2zZTKsl03Lcb7j2Mircf7pUd5y0yj9S60wQozdF79naEhl6EPz8jTfMi8hA9KM7U32+v0=
Received: from BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::20)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 07:36:37 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::ef) by BN9P221CA0015.outlook.office365.com
 (2603:10b6:408:10a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Fri, 21 Oct 2022 07:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 07:36:37 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 02:36:20 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for UMC
 poison handler
Date: Fri, 21 Oct 2022 15:36:05 +0800
Message-ID: <20221021073605.20352-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021073605.20352-1-tao.zhou1@amd.com>
References: <20221021073605.20352-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 367c2e2c-86c4-4a17-afd3-08dab336fcc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXrQXwFtLRuDdP/ny38Y+2PIbH15MizecJbrweL2wqn/VKDqA0rYmg7P4xx39FmAmGjRVuahcdVDTIdnjVL4vyBPuj19L2X7YFMpvoNKL3ya2dqLBnFMoznYzjhOJaPlDaiEz88vORf7H3FcTxhj1L+WQMN5qg//DIaXJLoon7a0l2T5wVs+zsJ9fVD0IRTA+s1v2rHTKu3ZXFjfQ8UTL3rudytTNbNKf4vlrHHE62HAF42vPMPK1J65/ON0VzXg4khBBhAy6auKuTbeLUWzV4U1Mo6f0Ykffj88uRxIkxRfeeeXsCR30wFSDPj+fJvzyu5z6DJvDqd+Aanf77vrKOFQ1AFVH6vyWTN1VASvhizzwE/Jo4h34EGfsI7HTSw2RiBJ/Q1TmekPdIybQtpAaCF2jKoRAjaJobgNZvpTIMvu9Jn+1INoTUu7l1SpxVPJpS2Fd8v9m8T3yQv36mee60z24t/3L64vAwcMJ+IBNKbGKTDKfyM2WHnwWOLCrkmsM/8ai8iOlWgMEZuQGZCe4oiF6UaGETdyl3rwqOooenasQFDyO7LJtTteUcsBXfid0+Nm+SpUoA3TWaQkeNfk2bn6C7WZppcADMj1CXAB0CCywao7etVPzVLRGb8zS5z1Lvg4/DL70hoBDtD4I0cG616FEO3yHs2XErQj2zA0hodJmdgUDNboLgYSZCVelcXI64oRzyP2p17UCaCX583LvzY3fbmE0qIH0TyZR54apfIf7aPOoheVsSzkukedPmV4LwZI0La7bM6bjMy6f0BHnRzTpQU+13Jp9/3Pinvr8x9NbPZuZltHGmDitMx/oMCD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(2906002)(40460700003)(47076005)(6666004)(41300700001)(82740400003)(26005)(426003)(1076003)(478600001)(110136005)(16526019)(186003)(36756003)(2616005)(6636002)(316002)(81166007)(83380400001)(86362001)(8936002)(356005)(336012)(5660300002)(70206006)(70586007)(82310400005)(8676002)(7696005)(4326008)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:36:37.6585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367c2e2c-86c4-4a17-afd3-08dab336fcc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code more simple.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    | 13 +++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h    |  4 +---
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0561812aa0a4..37db39ba8718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -753,9 +753,7 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
 
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bool reset)
 {
-	struct ras_err_data err_data = {0, 0, 0, NULL};
-
-	amdgpu_umc_poison_handler(adev, &err_data, reset);
+	amdgpu_umc_poison_handler(adev, reset);
 }
 
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 28463b47ce33..693bce07eb46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1561,7 +1561,6 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 {
 	bool poison_stat = false;
 	struct amdgpu_device *adev = obj->adev;
-	struct ras_err_data err_data = {0, 0, 0, NULL};
 	struct amdgpu_ras_block_object *block_obj =
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
 
@@ -1584,7 +1583,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	}
 
 	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_poison_handler(adev, &err_data, false);
+		amdgpu_umc_poison_handler(adev, false);
 
 	if (block_obj->hw_ops->handle_poison_consumption)
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 758942150c09..f76c19fc0392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -165,25 +165,22 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	return AMDGPU_RAS_SUCCESS;
 }
 
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-		void *ras_error_status,
-		bool reset)
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
 
 	if (!adev->gmc.xgmi.connected_to_cpu) {
-		struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+		struct ras_err_data err_data = {0, 0, 0, NULL};
 		struct ras_common_if head = {
 			.block = AMDGPU_RAS_BLOCK__UMC,
 		};
 		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
 
-		ret =
-			amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+		ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
 
 		if (ret == AMDGPU_RAS_SUCCESS && obj) {
-			obj->err_data.ue_count += err_data->ue_count;
-			obj->err_data.ce_count += err_data->ce_count;
+			obj->err_data.ue_count += err_data.ue_count;
+			obj->err_data.ce_count += err_data.ce_count;
 		}
 	} else if (reset) {
 		/* MCA poison handler is only responsible for GPU reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 659a10de29c9..a6951160f13a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -83,9 +83,7 @@ struct amdgpu_umc {
 };
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-		void *ras_error_status,
-		bool reset);
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
-- 
2.35.1

