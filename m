Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B1EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2D310E492;
	Thu,  6 Jul 2023 12:36:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDA610E429
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvLCSTIBwKzL40KNYGig6YO8DyUxnSCnsNGAqAbyVJClDgVaW9rOHkTyQINMUmtRrXLGSk878QO9Y1ZALFPt1QY6gNt6zlavx81WP7RQFUbQXO+zLrn+eVstJ22zN0iB/8FE12non41vFkFaIBQqSCSgXyab5EVNgkDntS2loI5kia9gPKtc7teDLFOloy0Frm4hXeS1RBlsvyFMDxJAIXshwA0C383Y1AtfrJWw0BFcdsVymBJOpio+3IzRR124I64B7vrDzkQ0PKwj/6TVeXQPVQSGYXaxfr6aEGjPFCO4TDrYfQqoeO3DikAYGwGWEAyM/LWb8NPUDp8w5oRfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLSCNjte0lZhPI4F06iuCMGagt2Zc/YUE/Rp6L1INOs=;
 b=kFNkFTA7dSCPxqxxaVRPSLjx4f6RDQPF6Q4BsJ1FIWZDetjfxsOFTuVb0OV9a+IVeAnikaJNwHIOu6wNtn+c1t1YzzlN0rKi/mR4TDQ3SyQwNcBNuPTzRR4fbjcOk4o+vL5TTOZhE8zxHqMtFnE1QMzVGIYjOhSuO1AFkDl0MbphqCUpcsyqPyLdA51ut8iRoDtQ9kP2BpKrLjc7vFKcVR1fDGbH/3A3KALwg8uV3o50bfEfMY4BemgHiIGsy2VsoKjtE6rZ7cm3bzhVDh3mhZMeh+UHbFrTmXHGUMNx9SjF6bhS5+0voKqme3W4CVdUvqA3xF7nuxFaH4VTplQ9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLSCNjte0lZhPI4F06iuCMGagt2Zc/YUE/Rp6L1INOs=;
 b=GhlXLcwvNNqK4VwWq2Rw1A1FKkRxPpRCvkjbdYG+z95+Ld7m8c+tNKjcmBV/Xwx+oNhntjFXji2qk/agJ5V7bsfuq+wKGJExiOn+AHeSi6I7Wibex5SpoM0ZPlN2uixML9RJOtHKgG0Air9wWQ0BYdd8kvwqSTUPG7Yta2EZxhc=
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by SJ0PR12MB5503.namprd12.prod.outlook.com (2603:10b6:a03:37f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 12:36:41 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::bf) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:40 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:38 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 09/10] drm/amdgpu: cleanup leftover queues
Date: Thu, 6 Jul 2023 14:36:01 +0200
Message-ID: <20230706123602.2331-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|SJ0PR12MB5503:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c161de9-cb44-47f4-bacb-08db7e1da5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wd7nfY9kNqpmRolKSJIWFCDfnBXQQpHNHq+So5jZKQkgenDI+JoqNkkT3QoPOkqUK+NILZl33vjPMcUD/Jg8zh6c7MVCuox8v4McxLCnVmS+bwuHt2TUHbwZIHMPPztSYW1AXWPJpcIOEtOBPI9S+LN5KMwdE7Em9cgAgIjRGyP0GPBaXaNYDElq3RZmWVIYCMXkewRXdmven7zQZaAD9CuIQw1mM0CmJbRrTBN/SMkqu/UKyUAuz13y3kAGPCkvtevojl4igEzD9w1QcAkP5eN2pC7eDAH0yvKt4HHSDWNUR+BXHahefjsHf+TBqBjZWo+TvGVBbM4PJwKwMroJ3EBU8JQYU+bEc0GjiqzTZ7w9XbEF//MEnMrY7zKlq8+kXFZguse+8zWO9cUWWr0/E5byuImdo5VX4tWRejDrfLVYon9LU74MxvfqnqYq5leQLu2vQeghzZfKoFol+UgWNk7jF/kHQeRok0+zKGh1wrp2EUOZ42PznCnBL3O559WssHpywCuR8HyAzltx/wKwYqRBzVfxY21rNOhLiJFapKNG27cOUdmn4cKKSU6HS12+goOFk00fq9sacak9qWC5Yfd/UI8Uy2vZDSpsPYvxiVPnsdFshywVR4u5+vkEYwtdjKfEWzD1nx9MWdvb4s93q4BTLGRWdXsz0MsW1PtcRGeOnrob0c8TmOtbztO0BbKG60WaTZYQVhyiV7GU3DG1P+RhnoulvM3+FIqTPXS23OIy4zDhpCqHDgX2qQw+xfgrDLMvIT33KvFm9rBPyT1fhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(41300700001)(2906002)(44832011)(8676002)(8936002)(82310400005)(36756003)(40480700001)(5660300002)(86362001)(186003)(2616005)(26005)(16526019)(478600001)(1076003)(6666004)(82740400003)(7696005)(316002)(70206006)(47076005)(54906003)(36860700001)(70586007)(4326008)(81166007)(6916009)(426003)(356005)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:40.6427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c161de9-cb44-47f4-bacb-08db7e1da5ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5503
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 61064266c4f8..6e32e2854a58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -57,12 +57,23 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	return index;
 }
 
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 int queue_id)
+{
+	const struct amdgpu_userq_funcs *uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
+
+	uq_funcs->mqd_destroy(uq_mgr, queue);
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+	kfree(queue);
+}
+
 static int
 amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -73,11 +84,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
-	uq_funcs->mqd_destroy(uq_mgr, queue);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
-	kfree(queue);
 
+	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
 }
@@ -193,8 +201,21 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	return 0;
 }
 
+static int amdgpu_userqueue_cleanup_residue(int queue_id, void *ptr, void *data)
+{
+	struct amdgpu_userq_mgr *uq_mgr = data;
+	struct amdgpu_usermode_queue *queue = ptr;
+
+	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
+	return 0;
+}
+
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	idr_for_each(&userq_mgr->userq_idr,
+		     amdgpu_userqueue_cleanup_residue,
+		     userq_mgr);
+
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
-- 
2.40.1

