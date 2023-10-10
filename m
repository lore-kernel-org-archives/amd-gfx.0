Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81CBCD691F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509E010E334;
	Tue, 10 Oct 2023 10:18:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5185910E332
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOdkaEXIedXWj07tZGbzBsiFgsvEP3Dx2H6Hwnxd9esS6K9/PTK/7R0FdvosoV49rjHPG1PzfDAcjI5kYV3xNhSmVt+1WO0Q+FAhjoZPlFKNN7DfBK4i6pLpF/V4WmK+QLFrottIJr/CPpQntXURwJWy6B4a7qD4OQZQF3WIb1zTpKXcxwhkMlcqyMY4y6tdhLWhJ33X2if2SHbpNEMUdOTiarVe2jcwWS88zSWurmlG8yp68qoXHvaUWC+TRjne+m2KLQ9kkqRkm3Ac85Vjtrrykn5PZezMGE/uurQA+qwYCTH5XsVBUC8gP784glIiPZgPebjhliZTvQ0l9xxZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DxXpco8Qlc3Tu0oG5iZe0h6pAxT/zekd+RX5QW2b/g=;
 b=RBwnCPJUYI4pmUif9H7Nray3ypDYuswaorAoCumYJHhoTcXDlwVSM4GvM5of1QIDzPzUTIgBqbU2efjKTjLsqa1dPgQFljjPBgRPCLUyQ9iGaM5K6Xq4tLWo61QoNe6hQeLKJyeDx0xvLKgP5+y3DJJSZiSWb2b9ZWBE90peKH0tTJkWKVHh62+Bg6vHHXRmpQpzq35RNQ0/RjrK4MEXb1C3LPNtUsQ7xc15s22K+GoVOho8r3NxtBx7OqwoDBBVvjwebFQCxp9gLSbqnh66BS61UpEDI+gEu49Mv2OQ1TB6Qo/DdZgnP6cwzZRCRJfiWIdBSlQ5ECQubevqopCiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DxXpco8Qlc3Tu0oG5iZe0h6pAxT/zekd+RX5QW2b/g=;
 b=VOgeXSmaZNef1L6cVE3SfG/4h7nKtPGduO1iev3BtOKpYRpZ5w0ykf2WcVV0oc8eCEDSI02GMm1bLg/ZpQLEazSPH80GYrCt5842NIbUCvQ81l7CvjNtrKVbD7qFN1o4rnENblYa11+3ersvQ/0oRaRGEsRFwKLj/EmZ4fYipEw=
Received: from PH0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::11)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Tue, 10 Oct
 2023 10:18:47 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::3f) by PH0P220CA0013.outlook.office365.com
 (2603:10b6:510:d3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:46 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:44 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 10/12] drm/amdgpu: cleanup leftover queues
Date: Tue, 10 Oct 2023 12:17:50 +0200
Message-ID: <20231010101752.1843-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f87a5e9-856f-431d-45d8-08dbc97a4a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOXlWDvyC8lKDVNVmkJFtK7pDy0vVvTkjPMWOw3uoxE9QBzKBVCbyxeUake6g9APjAA/Os2qpb8XxUbMrTg34bX1eCUAofo/NWybjU/NAleDVxWjweVim3kImZpnf69azUvlO7F7WUb9S8VBxT176br5vBN2KNO3i5gMtcc9P/nX+9vUp4Sv5pHikQhQYCrMN3sWy9vLlsP4yKRQ4e5pzugoNN85g+WH0M2PV8LE1//rL7RP8fIFKwotCizwFVyuaHVJZm5U80s53V02FlsMBNphGzRkI7qTvtTWs/rxn06NFBxV6nElEb7qQWCjirAH7u+pG8T//QeBOdUHdb0KaASd9YMbtCrPQVv+fakbxDOMr2dOZbHCEQKXS1dDNH6rYQUZpFF01ra9O2tVQ71kBGen/NqdMvQBUB96N5DMLO54dxzkltC5YYVX7gsrsoZwKaWYd2Ot/v2cUGK6A7F8mfJBtm6ejFnxgWJMvr/BwjJOFc3m+Nt7UxFaCTK8d9CaliIkG/S66Xy8NGedEkydipASMV28+ENbXeiPchSTM6epXqI4bZyV3dQ/O+wln2DW+lhkjVBKWiHAmvSMQLPVkREu96pBG8UP/GV4EX/4M0kRARiWJ/b3tTQmfFx7y7cR8N5j3uh2sR9UY5DEz/3+rBShQR10AbYIQiQZZFYEhl0aAFR+kzARyKSrwZ4PaStDzbZetebV6gxtm0THVvxRmwSymokM+JrGo1VFlPFZEH/3a47qXxZ38QG7bcUdosqu13sH1KE515twcjZsR9YR7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(46966006)(40470700004)(36840700001)(6916009)(70586007)(316002)(40460700003)(70206006)(54906003)(41300700001)(82740400003)(81166007)(7696005)(26005)(6666004)(16526019)(36756003)(83380400001)(47076005)(356005)(426003)(86362001)(336012)(478600001)(2616005)(36860700001)(40480700001)(44832011)(1076003)(2906002)(4326008)(8936002)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:46.7222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f87a5e9-856f-431d-45d8-08dbc97a4a01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds code to cleanup any leftover userqueues which
a user might have missed to destroy due to a crash or any other
programming error.

V7: Added Alex's R-B

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index ec49c10f7511..6bae014b248e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -26,6 +26,19 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
 
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 int queue_id)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
+
+	uq_funcs->mqd_destroy(uq_mgr, queue);
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+	kfree(queue);
+}
+
 static struct amdgpu_usermode_queue *
 amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
@@ -145,8 +158,6 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -158,13 +169,9 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 
-	uq_funcs = adev->userq_funcs[queue->queue_type];
-	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
-	kfree(queue);
-
+	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
 }
@@ -276,6 +283,12 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	uint32_t queue_id;
+	struct amdgpu_usermode_queue *queue;
+
+	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
+		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
-- 
2.42.0

