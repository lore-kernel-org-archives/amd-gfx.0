Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC961C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69ED910E71A;
	Mon, 27 Mar 2023 19:36:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45E910E714
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4bvVERRcaOJiQpAJkb81vgJzt4wsvHdjswu1WcctHbc4QVDhWaOOrql4dNHkdmsythYq5qFvQZHVwYYCxWGA/j2POD5wJX9HsNW1M/P+583VgZeyWQbnSnmGWeZ2XJU0XTW3h/aGCVBbAmNpLKPBrnElDDnqXo8Ex4enwDcJqEond+xwIii0A5v8IyUVjEEtDjmE/gaGljfSz0lnEUA/ItTd6FKguLb5kXgFe0Egdvpk3NGTPhZMwmW4xB4vvzDTx7Zrm2Fa7StPSAByfUZdqD7rA8LlgaCR0yOAOf6Etf12uS5/qpCzOagdUYAAKoxuqRqplclbuNSL5Y7J9p+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDehrDGsX/PtjP3lxpB94uHC5th2n53f3aM1yVXuHhY=;
 b=aGN1LaqdrKus1Xq8+i8BXWVwbPHqBtkA0ipw2ceto60xu/8BMDL0zmndpTjZ1q8+VLXOyOhfl1ebjpm4PFWGuWMj8oxD2V2ykYPs8i8V/l0RYVAatBhbvl+Z4JByLw7Dj7Zdg4s9EVnM03XG3EflJ5JxOF+jg1gGFgwrPa6VJMxG6TNQXXE2eyej4T3EqIWLDJoHrb/ylqvIK/VxzUDZxgYginsv7ca+OwVu8ltoLeYCEJQG1GmYNASTbYb1ixiQLe2oGlHIu0UMO4IyICKhRYWP2Go9K5GjS1BiuBgPp8iIMnYI3ThTsktF+s+WWrPHy/3wxxjXnapQktGf+Yc/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDehrDGsX/PtjP3lxpB94uHC5th2n53f3aM1yVXuHhY=;
 b=uaRN8vSP1W7kQyv1mXwHm1IQPIUQD8FwzwUaDJ7rRL2UUWHnCghY20sqeWoTYZ1Ix4/RgcO0bjWe23WJBOCWexI0SHpGu6VjOmokoQC+pFsIIhlMfSuZkWQ9r8DXvlEnsMAzDHw7k29J29UuF5PD1R9hrakloGwEjio87FLKlFM=
Received: from BN8PR15CA0051.namprd15.prod.outlook.com (2603:10b6:408:80::28)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:21 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::f2) by BN8PR15CA0051.outlook.office365.com
 (2603:10b6:408:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/28] drm/amdgpu: convert gfx.kiq to array type (v3)
Date: Mon, 27 Mar 2023 15:35:37 -0400
Message-ID: <20230327193602.7901-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 42960283-0721-4d8f-7c5b-08db2efa8b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8EinVqn1ykC/1c6u4dyVkHWRrFVb8hxx26p+/41b+PAOQMu2SA24IkatJH3cdi9Km2Wga3lrN7AbUHQgGqPTw5a2mn0dqdiYDzlUJ/ihK0QkqLvkKPHJX9FLTSJTf/h+hH1r7Lx28WDUfKxA7NPkklkPJdlnQsNbC4tTc29TH+zKRT1NJw4HrZhuVSsZDUF8ypLgb3RF3I2jYdjpYf0NCuz2Im/Zp+jH8ypPxNgRnsgvTXUQAGOWMR/lqHzc6WXpeaMfZG+JTzw/5MZgfYosPS4EYWdk+axDAE+IwdGVew6IssVWHWrGsrmH/AevRDyD8xAf1er34HStyPyXixAQhNsCPKrnqc2ZWccSDDT48hUj0XeFJwfe1dP9NX8RFMMRvfvlNZ2q/iBdXwmeNhZucyU3O3wz9mWkxIfsSDANCfDzCbwtP9ybwCliscVNg/aHBBdocXkV/gmYZObe3sDqBVTCHEIUQfiAlc+TDm8kgi/sv0PH7GtXzip4pfBRxxtXLIY/kJEWCipVPZ/3SSCrKnv9yImBREo/54tkfAJbXqAbaI2F5QotaSaSLXk58joML7ZyB9JOzdZdlIQuLY4ahLFHR3HQOCf5fJ7BHpvYJ/HZAaHwzOnWkn3GpcEDGCC4p9exrxLYvBW9P+5PRA42bQGJ3kseA6y+xCyQBXXQLVU8Tcc33Liazp9p70qwp8rhDjk9SWcLL0b8tmxdoIQe+SRSxdeqtDtqY5Ityyl0lA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(8676002)(70206006)(4326008)(36860700001)(6916009)(70586007)(316002)(5660300002)(8936002)(82740400003)(186003)(41300700001)(54906003)(81166007)(30864003)(16526019)(1076003)(47076005)(7696005)(2616005)(426003)(26005)(336012)(83380400001)(6666004)(478600001)(40480700001)(86362001)(356005)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:21.4435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42960283-0721-4d8f-7c5b-08db2efa8b2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

v1: more kiq instances are a available in SOC (Le)
v2: squash commits to avoid breaking the build (Le)
v3: make the conversion for gfx/mec v11_0 (Hawking)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  6 ++--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  6 ++--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  6 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 34 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 32 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 26 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 24 ++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 12 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        | 12 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 12 +++----
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        | 22 ++++++------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 24 ++++++-------
 16 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 9378fc79e9ea..f599e1e74fcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -288,7 +288,7 @@ static int kgd_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    uint32_t doorbell_off)
 {
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	struct v10_compute_mqd *m;
 	uint32_t mec, pipe;
 	int r;
@@ -303,7 +303,7 @@ static int kgd_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	spin_lock(&adev->gfx.kiq[0].ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
@@ -330,7 +330,7 @@ static int kgd_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 	amdgpu_ring_commit(kiq_ring);
 
 out_unlock:
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	spin_unlock(&adev->gfx.kiq[0].ring_lock);
 	release_queue(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index ba21ec6b35e0..5c4152ae44da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -275,7 +275,7 @@ static int hiq_mqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    uint32_t doorbell_off)
 {
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	struct v10_compute_mqd *m;
 	uint32_t mec, pipe;
 	int r;
@@ -290,7 +290,7 @@ static int hiq_mqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	spin_lock(&adev->gfx.kiq[0].ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
@@ -317,7 +317,7 @@ static int hiq_mqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
 	amdgpu_ring_commit(kiq_ring);
 
 out_unlock:
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	spin_unlock(&adev->gfx.kiq[0].ring_lock);
 	release_queue(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 7e80caa05060..5cdb7289d35b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -260,7 +260,7 @@ static int hiq_mqd_load_v11(struct amdgpu_device *adev, void *mqd,
 			      uint32_t pipe_id, uint32_t queue_id,
 			      uint32_t doorbell_off)
 {
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	struct v11_compute_mqd *m;
 	uint32_t mec, pipe;
 	int r;
@@ -275,7 +275,7 @@ static int hiq_mqd_load_v11(struct amdgpu_device *adev, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	spin_lock(&adev->gfx.kiq[0].ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
@@ -302,7 +302,7 @@ static int hiq_mqd_load_v11(struct amdgpu_device *adev, void *mqd,
 	amdgpu_ring_commit(kiq_ring);
 
 out_unlock:
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	spin_unlock(&adev->gfx.kiq[0].ring_lock);
 	release_queue(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e92b93557c13..bc944ae4fd5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -300,7 +300,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    uint32_t doorbell_off)
 {
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	struct v9_mqd *m;
 	uint32_t mec, pipe;
 	int r;
@@ -315,7 +315,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	spin_lock(&adev->gfx.kiq[0].ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
@@ -342,7 +342,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 	amdgpu_ring_commit(kiq_ring);
 
 out_unlock:
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	spin_unlock(&adev->gfx.kiq[0].ring_lock);
 	release_queue(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9d3a0542c996..9b6071df1fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -296,7 +296,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring,
 			     struct amdgpu_irq_src *irq)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	int r = 0;
 
 	spin_lock_init(&kiq->ring_lock);
@@ -329,7 +329,7 @@ void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)
 
 void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 
 	amdgpu_bo_free_kernel(&kiq->eop_obj, &kiq->eop_gpu_addr, NULL);
 }
@@ -339,7 +339,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 {
 	int r;
 	u32 *hpd;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 
 	r = amdgpu_bo_create_kernel(adev, hpd_size, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT, &kiq->eop_obj,
@@ -368,7 +368,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	int r, i;
 
 	/* create MQD for KIQ */
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
 		/* originaly the KIQ MQD is put in GTT domain, but for SRIOV VRAM domain is a must
 		 * otherwise hypervisor trigger SAVE_VF fail after driver unloaded which mean MQD
@@ -458,7 +458,7 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev)
 				      &ring->mqd_ptr);
 	}
 
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 	kfree(adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
 	amdgpu_bo_free_kernel(&ring->mqd_obj,
 			      &ring->mqd_gpu_addr,
@@ -467,17 +467,17 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev)
 
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i, r = 0;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	spin_lock(&adev->gfx.kiq[0].ring_lock);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
 					adev->gfx.num_compute_rings)) {
-		spin_unlock(&adev->gfx.kiq.ring_lock);
+		spin_unlock(&adev->gfx.kiq[0].ring_lock);
 		return -ENOMEM;
 	}
 
@@ -485,9 +485,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
 
-	if (adev->gfx.kiq.ring.sched.ready && !adev->job_hang)
+	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	spin_unlock(&adev->gfx.kiq[0].ring_lock);
 
 	return r;
 }
@@ -507,8 +507,8 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	uint64_t queue_mask = 0;
 	int r, i;
 
@@ -532,13 +532,13 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 							kiq_ring->queue);
-	spin_lock(&adev->gfx.kiq.ring_lock);
+	spin_lock(&adev->gfx.kiq[0].ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
 					adev->gfx.num_compute_rings +
 					kiq->pmf->set_resources_size);
 	if (r) {
 		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		spin_unlock(&adev->gfx.kiq.ring_lock);
+		spin_unlock(&adev->gfx.kiq[0].ring_lock);
 		return r;
 	}
 
@@ -550,7 +550,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
 
 	r = amdgpu_ring_test_helper(kiq_ring);
-	spin_unlock(&adev->gfx.kiq.ring_lock);
+	spin_unlock(&adev->gfx.kiq[0].ring_lock);
 	if (r)
 		DRM_ERROR("KCQ enable failed\n");
 
@@ -788,7 +788,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	signed long r, cnt = 0;
 	unsigned long flags;
 	uint32_t seq, reg_val_offs = 0, value = 0;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	if (amdgpu_device_skip_hw_access(adev))
@@ -856,7 +856,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	signed long r, cnt = 0;
 	unsigned long flags;
 	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_wreg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index bfabea76d166..c742b4a36979 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -296,7 +296,7 @@ struct amdgpu_gfx {
 	struct amdgpu_ce		ce;
 	struct amdgpu_me		me;
 	struct amdgpu_mec		mec;
-	struct amdgpu_kiq		kiq;
+	struct amdgpu_kiq		kiq[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_imu		imu;
 	bool				rs64_enable; /* firmware format */
 	const struct firmware		*me_fw;	/* ME firmware */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f2e2cbaa7fde..9dd474262c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -74,7 +74,7 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t reg1,
 					uint32_t ref, uint32_t mask)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *ring = &kiq->ring;
 	signed long r, cnt = 0;
 	unsigned long flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f5b5ce1051a2..d4e7de8fd9da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3568,7 +3568,7 @@ static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 	struct amdgpu_device *adev = kiq_ring->adev;
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
-	if (adev->enable_mes && !adev->gfx.kiq.ring.sched.ready) {
+	if (adev->enable_mes && !adev->gfx.kiq[0].ring.sched.ready) {
 		amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_addr, seq);
 		return;
 	}
@@ -3636,7 +3636,7 @@ static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs = {
 
 static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 {
-	adev->gfx.kiq.pmf = &gfx_v10_0_kiq_pm4_funcs;
+	adev->gfx.kiq[0].pmf = &gfx_v10_0_kiq_pm4_funcs;
 }
 
 static void gfx_v10_0_init_spm_golden_registers(struct amdgpu_device *adev)
@@ -4550,7 +4550,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	/* KIQ event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
 			      GFX_10_1__SRCID__CP_IB2_INTERRUPT_PKT,
-			      &adev->gfx.kiq.irq);
+			      &adev->gfx.kiq[0].irq);
 	if (r)
 		return r;
 
@@ -4635,7 +4635,7 @@ static int gfx_v10_0_sw_init(void *handle)
 			return r;
 		}
 
-		kiq = &adev->gfx.kiq;
+		kiq = &adev->gfx.kiq[0];
 		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
 		if (r)
 			return r;
@@ -4693,7 +4693,7 @@ static int gfx_v10_0_sw_fini(void *handle)
 	amdgpu_gfx_mqd_sw_fini(adev);
 
 	if (!adev->enable_mes_kiq) {
-		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring);
+		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
 		amdgpu_gfx_kiq_fini(adev);
 	}
 
@@ -6214,7 +6214,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 			break;
 		}
-		adev->gfx.kiq.ring.sched.ready = false;
+		adev->gfx.kiq[0].ring.sched.ready = false;
 	}
 	udelay(50);
 }
@@ -6524,8 +6524,8 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 #ifndef BRING_UP_DEBUG
 static int gfx_v10_0_kiq_enable_kgq(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	int r, i;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
@@ -6885,7 +6885,7 @@ static int gfx_v10_0_kiq_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	int r;
 
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0))
@@ -7243,7 +7243,7 @@ static int gfx_v10_0_hw_init(void *handle)
 #ifndef BRING_UP_DEBUG
 static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i;
 
@@ -8640,7 +8640,7 @@ static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 
@@ -9148,7 +9148,7 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 					     enum amdgpu_interrupt_state state)
 {
 	uint32_t tmp, target;
-	struct amdgpu_ring *ring = &(adev->gfx.kiq.ring);
+	struct amdgpu_ring *ring = &(adev->gfx.kiq[0].ring);
 
 	if (ring->me == 1)
 		target = SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE0_INT_CNTL);
@@ -9192,7 +9192,7 @@ static int gfx_v10_0_kiq_irq(struct amdgpu_device *adev,
 			     struct amdgpu_iv_entry *entry)
 {
 	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring = &(adev->gfx.kiq.ring);
+	struct amdgpu_ring *ring = &(adev->gfx.kiq[0].ring);
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
@@ -9369,7 +9369,7 @@ static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
-	adev->gfx.kiq.ring.funcs = &gfx_v10_0_ring_funcs_kiq;
+	adev->gfx.kiq[0].ring.funcs = &gfx_v10_0_ring_funcs_kiq;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		adev->gfx.gfx_ring[i].funcs = &gfx_v10_0_ring_funcs_gfx;
@@ -9403,8 +9403,8 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev->gfx.eop_irq.funcs = &gfx_v10_0_eop_irq_funcs;
 
-	adev->gfx.kiq.irq.num_types = AMDGPU_CP_KIQ_IRQ_LAST;
-	adev->gfx.kiq.irq.funcs = &gfx_v10_0_kiq_irq_funcs;
+	adev->gfx.kiq[0].irq.num_types = AMDGPU_CP_KIQ_IRQ_LAST;
+	adev->gfx.kiq[0].irq.funcs = &gfx_v10_0_kiq_irq_funcs;
 
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v10_0_priv_reg_irq_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c3b15d878bb7..2eb2c65e37b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -192,7 +192,7 @@ static void gfx11_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 	struct amdgpu_device *adev = kiq_ring->adev;
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
-	if (adev->enable_mes && !adev->gfx.kiq.ring.sched.ready) {
+	if (adev->enable_mes && !adev->gfx.kiq[0].ring.sched.ready) {
 		amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_addr, seq);
 		return;
 	}
@@ -260,7 +260,7 @@ static const struct kiq_pm4_funcs gfx_v11_0_kiq_pm4_funcs = {
 
 static void gfx_v11_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 {
-	adev->gfx.kiq.pmf = &gfx_v11_0_kiq_pm4_funcs;
+	adev->gfx.kiq[0].pmf = &gfx_v11_0_kiq_pm4_funcs;
 }
 
 static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
@@ -1395,7 +1395,7 @@ static int gfx_v11_0_sw_init(void *handle)
 			return r;
 		}
 
-		kiq = &adev->gfx.kiq;
+		kiq = &adev->gfx.kiq[0];
 		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
 		if (r)
 			return r;
@@ -1466,7 +1466,7 @@ static int gfx_v11_0_sw_fini(void *handle)
 	amdgpu_gfx_mqd_sw_fini(adev);
 
 	if (!adev->enable_mes_kiq) {
-		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring);
+		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
 		amdgpu_gfx_kiq_fini(adev);
 	}
 
@@ -3337,7 +3337,7 @@ static void gfx_v11_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, data);
 	}
 
-	adev->gfx.kiq.ring.sched.ready = enable;
+	adev->gfx.kiq[0].ring.sched.ready = enable;
 
 	udelay(50);
 }
@@ -3732,8 +3732,8 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 #ifndef BRING_UP_DEBUG
 static int gfx_v11_0_kiq_enable_kgq(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	int r, i;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
@@ -4108,7 +4108,7 @@ static int gfx_v11_0_kiq_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	int r;
 
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0))
@@ -4417,7 +4417,7 @@ static int gfx_v11_0_hw_init(void *handle)
 #ifndef BRING_UP_DEBUG
 static int gfx_v11_0_kiq_disable_kgq(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i, r = 0;
 
@@ -4432,7 +4432,7 @@ static int gfx_v11_0_kiq_disable_kgq(struct amdgpu_device *adev)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
 					   PREEMPT_QUEUES, 0, 0);
 
-	if (adev->gfx.kiq.ring.sched.ready)
+	if (adev->gfx.kiq[0].ring.sched.ready)
 		r = amdgpu_ring_test_helper(kiq_ring);
 
 	return r;
@@ -5609,7 +5609,7 @@ static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 
@@ -6107,7 +6107,7 @@ static int gfx_v11_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 					     enum amdgpu_interrupt_state state)
 {
 	uint32_t tmp, target;
-	struct amdgpu_ring *ring = &(adev->gfx.kiq.ring);
+	struct amdgpu_ring *ring = &(adev->gfx.kiq[0].ring);
 
 	target = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
 	target += ring->pipe;
@@ -6304,7 +6304,7 @@ static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
-	adev->gfx.kiq.ring.funcs = &gfx_v11_0_ring_funcs_kiq;
+	adev->gfx.kiq[0].ring.funcs = &gfx_v11_0_ring_funcs_kiq;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		adev->gfx.gfx_ring[i].funcs = &gfx_v11_0_ring_funcs_gfx;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b1f2684d854a..ed04bad8543d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -2021,7 +2021,7 @@ static int gfx_v8_0_sw_init(void *handle)
 		return r;
 	}
 
-	kiq = &adev->gfx.kiq;
+	kiq = &adev->gfx.kiq[0];
 	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
 	if (r)
 		return r;
@@ -2051,7 +2051,7 @@ static int gfx_v8_0_sw_fini(void *handle)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
 	amdgpu_gfx_mqd_sw_fini(adev);
-	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring);
+	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
 	amdgpu_gfx_kiq_fini(adev);
 
 	gfx_v8_0_mec_fini(adev);
@@ -4292,7 +4292,7 @@ static void gfx_v8_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		WREG32(mmCP_MEC_CNTL, 0);
 	} else {
 		WREG32(mmCP_MEC_CNTL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK));
-		adev->gfx.kiq.ring.sched.ready = false;
+		adev->gfx.kiq[0].ring.sched.ready = false;
 	}
 	udelay(50);
 }
@@ -4314,7 +4314,7 @@ static void gfx_v8_0_kiq_setting(struct amdgpu_ring *ring)
 
 static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	uint64_t queue_mask = 0;
 	int r, i;
 
@@ -4678,7 +4678,7 @@ static int gfx_v8_0_kiq_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	int r;
 
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0))
@@ -4741,7 +4741,7 @@ static int gfx_v8_0_cp_test_all_rings(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
@@ -4808,7 +4808,7 @@ static int gfx_v8_0_hw_init(void *handle)
 static int gfx_v8_0_kcq_disable(struct amdgpu_device *adev)
 {
 	int r, i;
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 
 	r = amdgpu_ring_alloc(kiq_ring, 6 * adev->gfx.num_compute_rings);
 	if (r)
@@ -7001,7 +7001,7 @@ static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
-	adev->gfx.kiq.ring.funcs = &gfx_v8_0_ring_funcs_kiq;
+	adev->gfx.kiq[0].ring.funcs = &gfx_v8_0_ring_funcs_kiq;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		adev->gfx.gfx_ring[i].funcs = &gfx_v8_0_ring_funcs_gfx;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ac0f53888dcf..e5944619b87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -888,7 +888,7 @@ static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
 
 static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 {
-	adev->gfx.kiq.pmf = &gfx_v9_0_kiq_pm4_funcs;
+	adev->gfx.kiq[0].pmf = &gfx_v9_0_kiq_pm4_funcs;
 }
 
 static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
@@ -2164,7 +2164,7 @@ static int gfx_v9_0_sw_init(void *handle)
 		return r;
 	}
 
-	kiq = &adev->gfx.kiq;
+	kiq = &adev->gfx.kiq[0];
 	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
 	if (r)
 		return r;
@@ -2206,7 +2206,7 @@ static int gfx_v9_0_sw_fini(void *handle)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
 	amdgpu_gfx_mqd_sw_fini(adev);
-	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring);
+	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
 	amdgpu_gfx_kiq_fini(adev);
 
 	gfx_v9_0_mec_fini(adev);
@@ -3145,7 +3145,7 @@ static void gfx_v9_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 	} else {
 		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL,
 			(CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK));
-		adev->gfx.kiq.ring.sched.ready = false;
+		adev->gfx.kiq[0].ring.sched.ready = false;
 	}
 	udelay(50);
 }
@@ -3600,7 +3600,7 @@ static int gfx_v9_0_kiq_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	int r;
 
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0))
@@ -3779,10 +3779,10 @@ static int gfx_v9_0_hw_fini(void *handle)
 	 */
 	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, adev->gfx.kiq.ring.me,
-				adev->gfx.kiq.ring.pipe,
-				adev->gfx.kiq.ring.queue, 0);
-		gfx_v9_0_kiq_fini_register(&adev->gfx.kiq.ring);
+		soc15_grbm_select(adev, adev->gfx.kiq[0].ring.me,
+				adev->gfx.kiq[0].ring.pipe,
+				adev->gfx.kiq[0].ring.queue, 0);
+		gfx_v9_0_kiq_fini_register(&adev->gfx.kiq[0].ring);
 		soc15_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	}
@@ -3903,7 +3903,7 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	unsigned long flags;
 	uint32_t seq, reg_val_offs = 0;
 	uint64_t value = 0;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_rreg);
@@ -5345,7 +5345,7 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 
@@ -6924,7 +6924,7 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
-	adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
+	adev->gfx.kiq[0].ring.funcs = &gfx_v9_0_ring_funcs_kiq;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7d6f4a68f416..23d4081eca00 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -343,7 +343,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* For SRIOV run time, driver shouldn't access the register through MMIO
 	 * Directly use kiq to do the vm invalidation instead
 	 */
-	if (adev->gfx.kiq.ring.sched.ready && !adev->enable_mes &&
+	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
 	    down_read_trylock(&adev->reset_domain->sem)) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
@@ -428,11 +428,11 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried_pasid;
 	bool ret;
 	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
-		spin_lock(&adev->gfx.kiq.ring_lock);
+		spin_lock(&adev->gfx.kiq[0].ring_lock);
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
@@ -440,12 +440,12 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 		if (r) {
 			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq.ring_lock);
+			spin_unlock(&adev->gfx.kiq[0].ring_lock);
 			return -ETIME;
 		}
 
 		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq.ring_lock);
+		spin_unlock(&adev->gfx.kiq[0].ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index d809f2ed5600..3828ca95899f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -291,7 +291,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* For SRIOV run time, driver shouldn't access the register through MMIO
 	 * Directly use kiq to do the vm invalidation instead
 	 */
-	if ((adev->gfx.kiq.ring.sched.ready || adev->mes.ring.sched.ready) &&
+	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
@@ -329,11 +329,11 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
-		spin_lock(&adev->gfx.kiq.ring_lock);
+		spin_lock(&adev->gfx.kiq[0].ring_lock);
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
@@ -341,12 +341,12 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 		if (r) {
 			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq.ring_lock);
+			spin_unlock(&adev->gfx.kiq[0].ring_lock);
 			return -ETIME;
 		}
 
 		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq.ring_lock);
+		spin_unlock(&adev->gfx.kiq[0].ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 327ef9d51cfb..478dd534acad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -807,7 +807,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
 	 */
-	if (adev->gfx.kiq.ring.sched.ready &&
+	if (adev->gfx.kiq[0].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
 	    down_read_trylock(&adev->reset_domain->sem)) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
@@ -917,8 +917,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried_pasid;
 	bool ret;
 	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 
 	if (amdgpu_in_reset(adev))
 		return -EIO;
@@ -938,7 +938,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (vega20_xgmi_wa)
 			ndw += kiq->pmf->invalidate_tlbs_size;
 
-		spin_lock(&adev->gfx.kiq.ring_lock);
+		spin_lock(&adev->gfx.kiq[0].ring_lock);
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, ndw);
 		if (vega20_xgmi_wa)
@@ -949,13 +949,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 		if (r) {
 			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq.ring_lock);
+			spin_unlock(&adev->gfx.kiq[0].ring_lock);
 			up_read(&adev->reset_domain->sem);
 			return -ETIME;
 		}
 
 		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq.ring_lock);
+		spin_unlock(&adev->gfx.kiq[0].ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 2e2062636d5f..0599f8a6813e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -797,8 +797,8 @@ static void mes_v10_1_queue_init_register(struct amdgpu_ring *ring)
 
 static int mes_v10_1_kiq_enable_queue(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	int r;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
@@ -863,9 +863,9 @@ static int mes_v10_1_kiq_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
 
-	spin_lock_init(&adev->gfx.kiq.ring_lock);
+	spin_lock_init(&adev->gfx.kiq[0].ring_lock);
 
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 
 	ring->me = 3;
 	ring->pipe = 1;
@@ -891,7 +891,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring;
 
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
-		ring = &adev->gfx.kiq.ring;
+		ring = &adev->gfx.kiq[0].ring;
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
 		ring = &adev->mes.ring;
 	else
@@ -974,15 +974,15 @@ static int mes_v10_1_sw_fini(void *handle)
 		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	}
 
-	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,
-			      &adev->gfx.kiq.ring.mqd_gpu_addr,
-			      &adev->gfx.kiq.ring.mqd_ptr);
+	amdgpu_bo_free_kernel(&adev->gfx.kiq[0].ring.mqd_obj,
+			      &adev->gfx.kiq[0].ring.mqd_gpu_addr,
+			      &adev->gfx.kiq[0].ring.mqd_ptr);
 
 	amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
 			      &adev->mes.ring.mqd_gpu_addr,
 			      &adev->mes.ring.mqd_ptr);
 
-	amdgpu_ring_fini(&adev->gfx.kiq.ring);
+	amdgpu_ring_fini(&adev->gfx.kiq[0].ring);
 	amdgpu_ring_fini(&adev->mes.ring);
 
 	amdgpu_mes_fini(adev);
@@ -1038,7 +1038,7 @@ static int mes_v10_1_kiq_hw_init(struct amdgpu_device *adev)
 
 	mes_v10_1_enable(adev, true);
 
-	mes_v10_1_kiq_setting(&adev->gfx.kiq.ring);
+	mes_v10_1_kiq_setting(&adev->gfx.kiq[0].ring);
 
 	r = mes_v10_1_queue_init(adev);
 	if (r)
@@ -1090,7 +1090,7 @@ static int mes_v10_1_hw_init(void *handle)
 	 * MES uses KIQ ring exclusively so driver cannot access KIQ ring
 	 * with MES enabled.
 	 */
-	adev->gfx.kiq.ring.sched.ready = false;
+	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring.sched.ready = true;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5826eac270d7..d5272e650368 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -859,8 +859,8 @@ static void mes_v11_0_queue_init_register(struct amdgpu_ring *ring)
 
 static int mes_v11_0_kiq_enable_queue(struct amdgpu_device *adev)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	int r;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
@@ -889,7 +889,7 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 	int r;
 
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
-		ring = &adev->gfx.kiq.ring;
+		ring = &adev->gfx.kiq[0].ring;
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
 		ring = &adev->mes.ring;
 	else
@@ -956,9 +956,9 @@ static int mes_v11_0_kiq_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
 
-	spin_lock_init(&adev->gfx.kiq.ring_lock);
+	spin_lock_init(&adev->gfx.kiq[0].ring_lock);
 
-	ring = &adev->gfx.kiq.ring;
+	ring = &adev->gfx.kiq[0].ring;
 
 	ring->me = 3;
 	ring->pipe = 1;
@@ -984,7 +984,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring;
 
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
-		ring = &adev->gfx.kiq.ring;
+		ring = &adev->gfx.kiq[0].ring;
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
 		ring = &adev->mes.ring;
 	else
@@ -1069,15 +1069,15 @@ static int mes_v11_0_sw_fini(void *handle)
 		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	}
 
-	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,
-			      &adev->gfx.kiq.ring.mqd_gpu_addr,
-			      &adev->gfx.kiq.ring.mqd_ptr);
+	amdgpu_bo_free_kernel(&adev->gfx.kiq[0].ring.mqd_obj,
+			      &adev->gfx.kiq[0].ring.mqd_gpu_addr,
+			      &adev->gfx.kiq[0].ring.mqd_ptr);
 
 	amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
 			      &adev->mes.ring.mqd_gpu_addr,
 			      &adev->mes.ring.mqd_ptr);
 
-	amdgpu_ring_fini(&adev->gfx.kiq.ring);
+	amdgpu_ring_fini(&adev->gfx.kiq[0].ring);
 	amdgpu_ring_fini(&adev->mes.ring);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
@@ -1161,7 +1161,7 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 
 	mes_v11_0_enable(adev, true);
 
-	mes_v11_0_kiq_setting(&adev->gfx.kiq.ring);
+	mes_v11_0_kiq_setting(&adev->gfx.kiq[0].ring);
 
 	r = mes_v11_0_queue_init(adev, AMDGPU_MES_KIQ_PIPE);
 	if (r)
@@ -1224,7 +1224,7 @@ static int mes_v11_0_hw_init(void *handle)
 	 * MES uses KIQ ring exclusively so driver cannot access KIQ ring
 	 * with MES enabled.
 	 */
-	adev->gfx.kiq.ring.sched.ready = false;
+	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring.sched.ready = true;
 
 	return 0;
-- 
2.39.2

