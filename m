Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8926FEB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 06:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A1610E656;
	Fri, 11 Aug 2023 06:02:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C916510E656
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb/uE6Zgot4W7L40ojlKJhPlYdhjBL79G7PEgbj2e4BWCXA/wJmtamJoqQ8c1y2lJRqX1iDpovB3peuWmQWo0nBXEKpSs9UUDYarAoBzWZiIwC/+tuhiNxU4RYtf2sO9p1fu/obxQ6Kcft9sCZAyoOrukjlgP7kbgJtuzPT0ozsNy2tZmz2HvTF/WzA9PavxVoGYl/pnCODZBfOFiiuzM8JIdSnGnzW1sRVT+JLoN+Xby2rKr0KbBaKs5z/FpisjI8w1akShRe2AJN31roa5dnluSxyF1qujIfn9lUPNAVVn3+z7xypfDOkQs+8DhtfZkVxlCJqNq+xfvMvXD1EFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58vR7up1TOScSt2AHWNqQDurG33+OFzA2dtVC1zAqVI=;
 b=k/c2ye6MYb9nxxnCLf5zNmvQIAUwxLW6m1/2t1K4+ZtdzH9aDLPkaVDQekU0G4JeGdKqKQ46/PT7uMVXfu6fEsjEZ40036emRt8rgTsyNrGVylyOmCd3SifwdBfNHSY6HvuuTuSU2SoIb/E9p5HecDIyWt2CKFJUGJJRKJxi7M7Fc3Stx1xrUkEcIxnDE3y7xXM3zunHKDxCT3KNOb6ioP+YNKsXQE90sISvnEUdbj6Wgg1B0K908Rm6BUuBEbbDJy0ud93Owsd+U9OwL5N4Jtsi50T5O5RytfRFFJY8ES3Z0CueSog+xtGCQc31jYjL320ztEsGKnCpH7Op8esrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58vR7up1TOScSt2AHWNqQDurG33+OFzA2dtVC1zAqVI=;
 b=43ssW7Mfy+UKnMBJRyDUTORquQU0AnwAGkjRsW6bVAhPTODwvSdKk6pE9+p4Jik96th2UfA3fBlMLHvv1t2Iv+aYsfxaMJqKc+dNQiGUhlvgXI11oAqkKEa6ON8Zue3vvpSUFqZrbm6ghjEcGxt9l3JYaYcukCYWVCGhrodb6Oo=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:02:54 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::bb) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 06:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 06:02:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 01:02:51 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: Add work pool to reset domain
Date: Fri, 11 Aug 2023 11:32:30 +0530
Message-ID: <20230811060234.663789-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811060234.663789-1-lijo.lazar@amd.com>
References: <20230811060234.663789-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7ffc39-b747-423b-1bbf-08db9a309a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 753KNgqPlkOIOKewdHrWtqx2MFRJiePt531F04pNX49gqy1KKSPwH5Yn+xuA3+W0IQSBjdEfmoKW0fCLOs+0TzRHGQD29WgZkpHRQtCUNyVdrpHe2UjlUqhN8yWz69FwLJBehbHu2vQQuCFW6ftX/O+TNibbrmwl1drGZEViY8+/DoPudZb/NWVMvg5QWtXfgqwq9Mp7pmkwYkHXS1Ve7UXwfjgnGH+PV+oREfwpHs1n5hKYq/9Q/EmbyFbsjJUThmWxc6jPdaQCykbsamk1cPziRrENqfmSDhQl/OVF9WxeFAgT2pHyzuZ0hOZ2nTba8PrPljnGUXKFmL/Dm3WNz8w1oHOQ/0OFhknVdXSZcNhaacVPPq4VzDbL6OCyHQrOOSS1dbLnZyl5oT2OUQcQYz5b7lza+Rwsc0B2mqPXvPdZwXXMZq/L5RcHXXfWlkjHBxqTeB0ehWtHcKpPmAoBb6Fs/X+AnCM/Pj8/Fy3aDwxh4iTneNaUEJ9MMGfFtC13hgFKdQ2z0hLC/QeaLmwcJ7+o9xUTpLPMTFCK3tF5EJSrfETU3h9abMIiNCuKG+S/T5hNWlActHtbC8GMklxUHkhgIP6qNlfgljBL3iISbeHHaEme9/RV3CQmDeq+qQYu5j1kFalj69H35wiO5uWj4SEv0lXibzfLpksua3YJ2JaAhoMir+UokcIbSLxk8KZk2qY4rj0KKm1wUFpgc/21P69aSucBfrFD8J56RTyS06//HSCPt5YNd6pRBR9H9WtvZJa8ZFuYD1cM17h/wV3IEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(186006)(1800799006)(82310400008)(46966006)(40470700004)(36840700001)(2616005)(83380400001)(40480700001)(41300700001)(426003)(5660300002)(6666004)(40460700003)(16526019)(1076003)(316002)(36756003)(26005)(44832011)(336012)(8676002)(54906003)(8936002)(86362001)(7696005)(2906002)(356005)(478600001)(82740400003)(81166007)(6916009)(4326008)(70206006)(70586007)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:02:54.1615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7ffc39-b747-423b-1bbf-08db9a309a72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a work pool to reset domain. The work pool will be used to schedule
any task in the reset domain. If on successful reset of the domain
indicated by a flag in reset context, all work that are queued will be
drained. Their work handlers won't be executed.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 104 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  22 +++++
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 02d874799c16..713362a60c9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -117,6 +117,51 @@ void amdgpu_reset_destroy_reset_domain(struct kref *ref)
 	kvfree(reset_domain);
 }
 
+static void amdgpu_reset_domain_cancel_all_work(struct work_struct *work)
+{
+	struct amdgpu_reset_domain *reset_domain =
+		container_of(work, struct amdgpu_reset_domain, clear);
+	int i;
+
+	for (i = 0; i < AMDGPU_MAX_RESET_WORK; ++i)
+		if (atomic_cmpxchg(&reset_domain->work[i].in_use, 1, 0))
+			cancel_work(&reset_domain->work[i].work);
+
+	drain_workqueue(reset_domain->wq);
+	reset_domain->drain = false;
+}
+
+static void amdgpu_reset_work_handler(struct work_struct *work)
+{
+	struct amdgpu_reset_work *reset_work =
+		container_of(work, struct amdgpu_reset_work, work);
+
+	/* Don't do anything if reset domain is in drain mode */
+	if (reset_work->domain->drain)
+		return;
+
+	reset_work->handler(&reset_work->context);
+	if (reset_work->context.flags & (1U << AMDGPU_RESET_CANCEL_ALL)) {
+		reset_work->domain->drain = true;
+		schedule_work(&reset_work->domain->clear);
+	}
+
+	atomic_set(&reset_work->in_use, 0);
+}
+
+static void
+amdgpu_reset_init_work_pool(struct amdgpu_reset_domain *reset_domain)
+{
+	int i;
+
+	for (i = 0; i < AMDGPU_MAX_RESET_WORK; ++i) {
+		INIT_WORK(&reset_domain->work[i].work,
+			  amdgpu_reset_work_handler);
+		atomic_set(&reset_domain->work[i].in_use, 0);
+		reset_domain->work[i].domain = reset_domain;
+	}
+}
+
 struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_domain_type type,
 							     char *wq_name)
 {
@@ -139,6 +184,8 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
 
 	}
 
+	INIT_WORK(&reset_domain->clear, amdgpu_reset_domain_cancel_all_work);
+	amdgpu_reset_init_work_pool(reset_domain);
 	atomic_set(&reset_domain->in_gpu_reset, 0);
 	atomic_set(&reset_domain->reset_res, 0);
 	init_rwsem(&reset_domain->sem);
@@ -152,12 +199,67 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 	down_write(&reset_domain->sem);
 }
 
-
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 {
 	atomic_set(&reset_domain->in_gpu_reset, 0);
 	up_write(&reset_domain->sem);
 }
 
+static int
+amdgpu_reset_domain_get_work(struct amdgpu_reset_domain *reset_domain,
+			     struct amdgpu_reset_work **reset_work)
+{
+	int i;
 
+	if (!reset_work)
+		return -EINVAL;
+
+	*reset_work = NULL;
+	for (i = 0; i < AMDGPU_MAX_RESET_WORK; ++i) {
+		if (!atomic_cmpxchg(&reset_domain->work[i].in_use, 0, 1)) {
+			*reset_work = &reset_domain->work[i];
+			return 0;
+		}
+	}
+	/* All resources occupied */
+
+	return -EBUSY;
+}
+
+static void amdgpu_reset_init_work(struct amdgpu_reset_work *reset_work,
+				   struct amdgpu_reset_context *reset_context,
+				   amdgpu_reset_work_func_t reset_work_handler)
+{
+	memcpy(&reset_work->context, reset_context, sizeof(*reset_context));
+	reset_work->handler = reset_work_handler;
+}
+
+int amdgpu_reset_schedule_work(struct amdgpu_device *adev,
+			       struct amdgpu_reset_context *reset_context,
+			       amdgpu_reset_work_func_t reset_work_handler)
+{
+	struct amdgpu_reset_work *reset_work;
+	int ret;
+
+	if (!reset_context || !reset_context->reset_req_dev ||
+	    !reset_work_handler)
+		return -EINVAL;
+
+	ret = amdgpu_reset_domain_get_work(adev->reset_domain, &reset_work);
+
+	if (ret)
+		return ret;
+
+	if (!ret) {
+		amdgpu_reset_init_work(reset_work, reset_context,
+				       reset_work_handler);
+
+		queue_work(adev->reset_domain->wq, &reset_work->work);
+
+		if (reset_context->flags & (1U << AMDGPU_RESET_SCHEDULE_NOW))
+			flush_work(&reset_work->work);
+	}
+
+	return ret;
+}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 471d789b33a5..d1393050d3ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -27,12 +27,16 @@
 #include "amdgpu.h"
 
 #define AMDGPU_RESET_MAX_HANDLERS 5
+#define AMDGPU_MAX_RESET_WORK 5
 
 enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
 	AMDGPU_RESET_FOR_DEVICE_REMOVE = 2,
+	AMDGPU_RESET_XCP = 3,
+	AMDGPU_RESET_SCHEDULE_NOW = 4,
+	AMDGPU_RESET_CANCEL_ALL = 5,
 };
 
 struct amdgpu_reset_context {
@@ -80,13 +84,28 @@ enum amdgpu_reset_domain_type {
 	XGMI_HIVE
 };
 
+typedef void (*amdgpu_reset_work_func_t)(
+	struct amdgpu_reset_context *reset_context);
+
+struct amdgpu_reset_work {
+	struct work_struct work;
+	struct amdgpu_reset_context context;
+	struct amdgpu_reset_domain *domain;
+	atomic_t in_use;
+
+	amdgpu_reset_work_func_t handler;
+};
+
 struct amdgpu_reset_domain {
 	struct kref refcount;
 	struct workqueue_struct *wq;
 	enum amdgpu_reset_domain_type type;
+	struct amdgpu_reset_work work[AMDGPU_MAX_RESET_WORK];
+	struct work_struct clear;
 	struct rw_semaphore sem;
 	atomic_t in_gpu_reset;
 	atomic_t reset_res;
+	bool drain;
 };
 
 
@@ -129,6 +148,9 @@ static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
 void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
+int amdgpu_reset_schedule_work(struct amdgpu_device *adev,
+			       struct amdgpu_reset_context *reset_context,
+			       amdgpu_reset_work_func_t handler);
 
 #define for_each_handler(i, handler, reset_ctl)                  \
 	for (i = 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
-- 
2.25.1

