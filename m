Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8304C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C9E10F243;
	Fri, 29 Apr 2022 17:47:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C1F10F1C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFk8khTSAUWGoDRPG6uerSRH6ng0V4ZfcUkCFxEop9pf/YhonlSKKu9ewTimBtMSD3dXYqaWkgVdvpMkk6f2YsbH7OE3gc/013oMx8li5oe7Kzo/uB78FcOUjlULq7sp741IPRn3mKJ6RyqgDCa7E9CKbKjvKUx2eobIJgu4LkFVUCZ7uuNnviAARIhzuiWPW+KhmWVCtzVhtwtaBAipID6tcLEPRK0F+R6UqnH+gZtyimDQlKWKZ5cuii+CnRDm6M2q4n24hJ57NbQtLnIMCElZ5TSXYrbzk6yzKgsy/P7SlHJHpQQCVR68KFrZpB8fW79PCBCbf5Iju6faq6oTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEqdR0VIwZpk8s1+iOtcB2UAyRbNppQotnMWFYWTl7s=;
 b=ZeWJ/kFbjMsLZIOOnwSjTwG6j4mVsZ5T8QDxyj6NqefloeCKFjd81zR6ZEw/R/Or/zHovVV/FP5FeMEYCcM7HFdp3EF1kZ936M2WdkKHpBtxZt/yrlKygq4QVeeYem7OOa4L7mZz+TECi2H33UAhZtL4RaTpSfNbpqGkZ9hjozwX5NDoab9DRpRrkvYXYjN81Oze1y1pKgu8y3DcrcTnIUE8JVqONc/bY20LQloFpkxaRYWOZ1tCOPoU1nAuhjj/bYSiT7xN5nqnRJeptYvAHs1tlAYG1q4kffXI/fJAfOhLiKQbavfrB18HEy6kjWJPw8AeADAgcrFWAliAbbnxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEqdR0VIwZpk8s1+iOtcB2UAyRbNppQotnMWFYWTl7s=;
 b=aBYKVY709MigIaV7p7ZG8RYN2y/nj/I/QVOI1W/czlYzuiQllwLnC671HPakHe5SEii8PdWRkgn0cEtUjJ9Auz4/7U/xu/CIDdOjJ7OFjzs19kvaFrACSCQvj23ecMboaJFdT85kMhBx8JXASwU9xy0YwuVifB9ApvhUe14HjSc=
Received: from DM6PR12CA0006.namprd12.prod.outlook.com (2603:10b6:5:1c0::19)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:46:48 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::f4) by DM6PR12CA0006.outlook.office365.com
 (2603:10b6:5:1c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/73] drm/amdgpu: update mes process/gang/queue definitions
Date: Fri, 29 Apr 2022 13:45:28 -0400
Message-ID: <20220429174624.459475-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f665ece-88b1-4bef-6c33-08da2a083bc7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4113:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41134289027580AA6C9FA2DFF7FC9@BY5PR12MB4113.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3J0J3uloiihrL3Am42C80U7+fv1oWjvsuXcQxGKGCaUtNNmHY1fQnUZvc+7FZXAPsQZ2lMR5mOvhLjP7SKJ3y4fAllAvrJuZigatd6PLeYCO8LX5jpg0lDPle/2vB3yKZi4rqyBYj4BwXOb3kwCq1tKGxAnEP8XwZq7xnIRICDp+PaEd6jgKmMLDKMZ5wjDDB4IQoolFHVRTMDDnCplse4quUmA01hV0IQWeLCeRlzCiD2/q9wxMtggSs1FdYZAnk6hNk2/j3ZhZnofM2vaI62p81VOrdNIbihRBf3W7UyMN0BiUj7uM0atK2Pi4LAA3eUOFuA/0WKxqcsa6edqs1ZQpPvOWfY/owhM8mQ5wHI0BYNpCJ7PZbkkkq+zvgDdprc6X22W0ta2eFAPoU9h/+Pg1e/m+TqOz3bcXAyqZyP8fdzqpgQLx0ZZ+S7/9jl9RrSqjwiAmAdPEHBnsRMeuJUWon2nkpoT5yQbbKOQrQAd65x/K7SZT8G7IWVdFoV0lxgdZJz6Cqhd1jcMcNypBBLNE6uweQYDkbx9bK9A4xL0dcvLgM1yR4nW/47DgYASPo38TETgJ7kWdnzWa8us+yCgY1oPagRVX+SumbKPgSktiDtKN1b4r5xQAbiRQGisiaf7ecNniZkOrMmk6gPsd7zJf5UpMUFdMMx2P4WX9NZSbDvlaKkdPBB2Fw2bbZgIxW1GFbW2HRubuP27Q0RuC+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(8936002)(508600001)(8676002)(6916009)(54906003)(316002)(36860700001)(70206006)(70586007)(83380400001)(16526019)(15650500001)(66574015)(47076005)(36756003)(186003)(336012)(40460700003)(81166007)(2616005)(2906002)(1076003)(426003)(86362001)(5660300002)(7696005)(6666004)(26005)(82310400005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:47.6439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f665ece-88b1-4bef-6c33-08da2a083bc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Update the definitions of MES process/gang/queue.

v2: add missing includes

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 7334982ea702..52483d7ce843 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -24,6 +24,10 @@
 #ifndef __AMDGPU_MES_H__
 #define __AMDGPU_MES_H__
 
+#include "amdgpu_irq.h"
+#include "kgd_kfd_interface.h"
+#include "amdgpu_gfx.h"
+
 #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
 #define AMDGPU_MES_MAX_GFX_PIPES            2
 #define AMDGPU_MES_MAX_SDMA_PIPES           2
@@ -37,11 +41,23 @@ enum amdgpu_mes_priority_level {
 	AMDGPU_MES_PRIORITY_NUM_LEVELS
 };
 
+#define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
+#define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
+
 struct amdgpu_mes_funcs;
 
 struct amdgpu_mes {
 	struct amdgpu_device            *adev;
 
+	struct mutex                    mutex;
+
+	struct idr                      pasid_idr;
+	struct idr                      gang_id_idr;
+	struct idr                      queue_id_idr;
+	struct ida                      doorbell_ida;
+
+	spinlock_t                      queue_id_lock;
+
 	uint32_t                        total_max_queue;
 	uint32_t                        doorbell_id_offset;
 	uint32_t                        max_doorbell_slices;
@@ -90,6 +106,48 @@ struct amdgpu_mes {
 	const struct amdgpu_mes_funcs   *funcs;
 };
 
+struct amdgpu_mes_process {
+	int			pasid;
+	struct			amdgpu_vm *vm;
+	uint64_t		pd_gpu_addr;
+	struct amdgpu_bo 	*proc_ctx_bo;
+	uint64_t 		proc_ctx_gpu_addr;
+	void 			*proc_ctx_cpu_ptr;
+	uint64_t 		process_quantum;
+	struct 			list_head gang_list;
+	uint32_t 		doorbell_index;
+	unsigned long 		*doorbell_bitmap;
+	struct mutex		doorbell_lock;
+};
+
+struct amdgpu_mes_gang {
+	int 				gang_id;
+	int 				priority;
+	int 				inprocess_gang_priority;
+	int 				global_priority_level;
+	struct list_head 		list;
+	struct amdgpu_mes_process 	*process;
+	struct amdgpu_bo 		*gang_ctx_bo;
+	uint64_t 			gang_ctx_gpu_addr;
+	void 				*gang_ctx_cpu_ptr;
+	uint64_t 			gang_quantum;
+	struct list_head 		queue_list;
+};
+
+struct amdgpu_mes_queue {
+	struct list_head 		list;
+	struct amdgpu_mes_gang 		*gang;
+	int 				queue_id;
+	uint64_t 			doorbell_off;
+	struct amdgpu_bo		*mqd_obj;
+	void				*mqd_cpu_ptr;
+	uint64_t 			mqd_gpu_addr;
+	uint64_t 			wptr_gpu_addr;
+	int 				queue_type;
+	int 				paging;
+	struct amdgpu_ring 		*ring;
+};
+
 struct mes_add_queue_input {
 	uint32_t	process_id;
 	uint64_t	page_table_base_addr;
-- 
2.35.1

