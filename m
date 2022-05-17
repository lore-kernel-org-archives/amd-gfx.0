Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ECCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB21F11372A;
	Tue, 17 May 2022 19:21:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7605211372A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvKIYNuxYLlnvudkNqrx8qWJU6GGR93OjdkVMi+AejQxIgNcf+lo73HTbshe2XL2GCz+w7xnfgeSJw8tFrSlOHhzsiJyZN/sNuczhfkmZGaal/VFvYu0Lm5UmFeNiSQ8kIS3mZdAaeMdUZJYSZqaVPDuikDekPfWAI6CgnxQOxOiMfEE4ISW0avzsEWn/pfUS/cm6Qfcl+LW6hcuqRk2TLmg8mm77SiwCkpQaYIfkXdmeWKNCb+1ACtEtQXZqbBViQG7Xh5hbJuuSzsnln0NPZ25IGuJbl2pmW2bbNZK9zGPIrT9wzFseBvYJoeri85rIkxgu0HjAvoov100/6HWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QSdXUydWAR69wQ/15KNUD+7ifmubmKpYZFrrzY34vM=;
 b=ScQ+hMOZn5oB9XAqusld9IphB859ZILo7Op2Wh6QnDRr/3Er+s2AF8JA07lPt2bMZLJPaUcJCwV7ApcJ7j00rgSqC4/KuM1zWD4gduf4Z80P3rhPhez/r/eXM+tPWktGjbZkmZers5cKitlXKVtL7yOojDsBptuyzYJNj1sRC9U0LQbAMb9o15oG+AJik0VhVRsKqvPUs6YXUX1rKAQC2rhMmnV8IQt3l0TxWO4uY3brK/XXJncfcuaN1tN1Ltzeg9FusXfmJj38YZ+Pz6P03EBVjaxeTdojDA3/ThSs+BnMDCTW9YjyPHRT5vND+o+nmtHiSAoSclLo/dhHHO5mRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QSdXUydWAR69wQ/15KNUD+7ifmubmKpYZFrrzY34vM=;
 b=ebb8tQNIBYWZA0t+IoXtyAh7rnXmqjLB8Kq6+pMJo2OONIbF/pQ6OQ/BTprJ5UW7+OjwRwPvrUd00UWrODKikCnvhnGKH2MG+s3g/nzfezd+746w8S6cfipzKIo9c40iktCw8p43S+puRmkzqFAdPhDs5zQ7RBXq3P7JvoycwwU=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by BN6PR12MB1857.namprd12.prod.outlook.com (2603:10b6:404:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 19:21:28 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::c9) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 19:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:21:27 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:21:26 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/7] drm/amdgpu: Switch to delayed work from work_struct.
Date: Tue, 17 May 2022 15:20:57 -0400
Message-ID: <20220517192102.238176-3-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2820da1-d853-4c78-9507-08da383a70a8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1857:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1857C44E4517AA00A73A31F0EACE9@BN6PR12MB1857.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CryHcx5CZYyoS4ixqB9LPq/iA2aJT05LL3UxaawJsne6ZlxtecfXkvRVPmPeonCuRwaTVU36xm632AJUgp3MEjEuTJZu6yfkkDN/SyBGVCPm/J4EYKo0OuruKQDJdLktgMYxaY5VJdc+wTHDUnFhDVy8FwtTPGGSSMSuJjeXdE1YjS9PTiMzhUBXDA+QTYhQwTOkJo0eNDj89FmU4oHx+TfZgnueJVUu0sBzOfNzce8YTt9hGsAK1vl8bmIlvqPcZwKdR1CxBMbQGJKUM1H51Ghgam8ThMebecRtWwWaAZlzJzPM14wjq6omE7+xBTmOsK+FCQRecPtQ79297bEwE0q/zbWAOqc3zVRIqn772vifcysTwxmqp6jg1D1I2DZ9w3NwY6SUQvk0WmUHTGOvh9lmdZXZd5nY7g1D6vI/hya/duZadkTY+n+DMXk5mjhEGr5tuizKzvuXm181MHdeLCVAm/37QUIwod2pL1guR74AaiwC7tw50BMcxQX4E9l44IalxajCUNhT24LJk3ZgFhc2uDky0Dp/R1AFNNMIX1LO0JQc56Qwu3gcZF8+eG/cAliQvU/QPkJ2qrD4f/TJgkLtIR9iaCpVgr6drwfQfbOW3ig7iW3GeR/TmRcC3XCgLq3v3/G2kNSEcqEkDAIBkgz+wFVt1iK8A5rNt1boVyPiWNd7ua4z/qHjYOmEfs62b9cZJ0v3VZrTS7b0u6Xj1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(6666004)(2906002)(83380400001)(426003)(336012)(47076005)(356005)(16526019)(186003)(1076003)(82310400005)(316002)(6916009)(86362001)(36860700001)(8676002)(4326008)(36756003)(2616005)(40460700003)(44832011)(5660300002)(508600001)(70206006)(70586007)(8936002)(26005)(54906003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:21:27.3982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2820da1-d853-4c78-9507-08da383a70a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1857
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to be able to non blocking cancel pending reset works
from within GPU reset. Currently kernel API allows this only
for delayed_work and not for work_struct. Switch to delayed
work and queue it with delay 0 which is equal to queueing work
struct.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3948e7db6ad7..ea41edf52a6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5309,7 +5309,7 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 }
 
 struct amdgpu_recover_work_struct {
-	struct work_struct base;
+	struct delayed_work base;
 	struct amdgpu_device *adev;
 	struct amdgpu_job *job;
 	int ret;
@@ -5317,7 +5317,7 @@ struct amdgpu_recover_work_struct {
 
 static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
 {
-	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
+	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base.work);
 
 	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
 }
@@ -5329,12 +5329,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 {
 	struct amdgpu_recover_work_struct work = {.adev = adev, .job = job};
 
-	INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
+	INIT_DELAYED_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
 
 	if (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base))
 		return -EAGAIN;
 
-	flush_work(&work.base);
+	flush_delayed_work(&work.base);
 
 	return atomic_read(&adev->reset_domain->reset_res);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 9e55a5d7a825..fee9376d495a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -114,9 +114,9 @@ static inline void amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
 }
 
 static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *domain,
-						struct work_struct *work)
+						struct delayed_work *work)
 {
-	return queue_work(domain->wq, work);
+	return queue_delayed_work(domain->wq, work, 0);
 }
 
 void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 239f232f9c02..b53b7a794459 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -230,7 +230,7 @@ struct amdgpu_virt {
 	uint32_t			reg_val_offs;
 	struct amdgpu_irq_src		ack_irq;
 	struct amdgpu_irq_src		rcv_irq;
-	struct work_struct		flr_work;
+	struct delayed_work		flr_work;
 	struct amdgpu_mm_table		mm_table;
 	const struct amdgpu_virt_ops	*ops;
 	struct amdgpu_vf_error_buffer	vf_errors;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index b81acf59870c..aa5f6d6ea1e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -251,7 +251,7 @@ static int xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
 
 static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
 
@@ -380,7 +380,7 @@ int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
+	INIT_DELAYED_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 22c10b97ea81..dd9f6b6f62f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -275,7 +275,7 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
 
 static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
 
@@ -407,7 +407,7 @@ int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
+	INIT_DELAYED_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 7b63d30b9b79..b11831da1b13 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -512,7 +512,7 @@ static int xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
 
 static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	/* wait until RCV_MSG become 3 */
@@ -610,7 +610,7 @@ int xgpu_vi_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
+	INIT_DELAYED_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
 
 	return 0;
 }
-- 
2.25.1

