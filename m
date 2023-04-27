Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F230FC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EDC10E348;
	Thu, 27 Apr 2023 15:27:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E239E10E2F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKG2ZxU9b6iAxRtAY3LgIv4M+I6B87pTXlvIx9jXKW0CViJD6SXAWrY5lr5mL0D9Q/kO00EqeLSXIi1Z52QtoKnsicn0L8RH1FcAKv2mGqMeqWfIB+lrjYXDdhQcPv8iNS0NieLSieDJb1xwqBX+kLoTGo1E9dTSKoRTUCObmCNBVDB/p4FPSFHPV7hzQ5/7GkjnSAG7REIWOg5Dt69CFVQKq2Qqqk6DlK6m8qXDr3Yp9UwBX7Rbk+iUvFZTOnA+PE7dmhPl+LsKxKHqj4wXgzv17i8eiLwUKjWpzRBNi/EY8l04B8ukJ3zy9WHJOwwxSjlD3jDhUhXU4pQUkb0N4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVSmqldU2wCFPxOlh4MCWAe1aJYaivQYIcSHfbfWtOw=;
 b=UnG4SmCpxrtQ8E2204eXGJTuVBlXFfQBuDLBuAHItto8VZ9gGUDuig1sZx0VJwRemYuN/tQs9D/uVDWMHOV3Kzv7JJPdqJqwrN/mElJEK4LEw8cYTxvfwDmc8G0YFrNyTkMUyqQd8JWqfaLLNm1KQ1Ghi0kBgfl9opWQELxfeEAyVPhNjvwYQKEriVrB4NSPkWAok0MXJlBSxoo5slg6DUK3UIcPjCE3/WdZqttJBMmRsitpPb4Dmlnk+yxPqc9BybU3fV8XxRQHEsBTj/7BHYCzCLRUpZSzSFgwZ568K9zqEq899esfmRz59iLae+bWroUDkbEDQ65A1sfmNWPUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVSmqldU2wCFPxOlh4MCWAe1aJYaivQYIcSHfbfWtOw=;
 b=WNfFc3Wl7qII4LdOOk99b/buJfo6wbdjKY5fTD4KLHFBKvPXlT+phwKS0Uatt2Pl2XFFEWKfyKmXYhpQFC56XOfwNZRGamihTSG6KGN47aFSr9FWjSTqjl5qkHGZK4wFwS+vGAe9Zhvpa9ubbnViFSvuL3DSaSl4jGIpWeGUZMw=
Received: from BN9PR03CA0466.namprd03.prod.outlook.com (2603:10b6:408:139::21)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 15:27:33 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::2f) by BN9PR03CA0466.outlook.office365.com
 (2603:10b6:408:139::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 15:27:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amdgpu: add [en/dis]able_kgq() functions
Date: Thu, 27 Apr 2023 11:27:00 -0400
Message-ID: <20230427152709.7612-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: f5202df8-d265-4728-fa3b-08db4733ebd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53HK8d2HB4Q9x+buq/QnZ0103fULLyFXHkVspTWGIgTQyBMJ5X6pPFLWiR6vgr7wSPESZlMqw2BVn3eJzzV/zn0L79k5YYFskQrrVvFkRIYEw94zUG9psto5mu3kPoEJSECNb4qiu0Bstf/pSdEa5W/qcUb23cHkYNZnzNJ0wUYDwHrfdxogCV9giSyXijQ98SfvIRLVLQVn5JAZIBVcgHw7kXzNAyqYIITPcPGQQYT2ShVNVJQ+7x1/I6++5MDjTt/7qQgqVJC9FwgsBBqJ17J8AcmxXsxz9FEMDYNbIyAO4/8ifK1LmDIH56QnfkVL26uAlBk+BuPvdu2X72Zm6su3+ik8qzYjxz0WH8HlSBPljWJwutgwlnycNhaZkN4Ic/FaxI3euT/dZo12CO8W69Kef8fazCkCJ1qNyWXK6SAsvLxKWCMv81pjtrYM7lMypEUDoKmzf/opj1oKAvQf/KlNotHg+AyLrkqHU5HjYwKhagZDTC+wcH1Liqz8qLkfmCLN+r2OLlIb6c2wpKxMaQqTGUPIP3Dm5ODIaBcp164Pj9UgItrgG030NF7+hKMY0Wn+GPx93zGVxRk4N4fm4ZLstPUCq0rnznYuFGfcLBS4MsQsffE3Wms4NCtqL3lF56X1BW8unNCKa/zS8ucuG1K3yky2H++NCg4Dh++/KKR4bQoqvrnAeQq1sf9vcqQkAtiwNDQVsh9BxSShDJPQC7XjciWv7mII49ffqp51QMI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(6666004)(36756003)(47076005)(186003)(83380400001)(426003)(336012)(40480700001)(2906002)(1076003)(16526019)(26005)(82310400005)(54906003)(478600001)(2616005)(36860700001)(316002)(82740400003)(4326008)(356005)(70586007)(6916009)(81166007)(70206006)(86362001)(8676002)(5660300002)(40460700003)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:32.8424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5202df8-d265-4728-fa3b-08db4733ebd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To replace the IP specific variants which are largely
duplicate.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 68 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 60bb4bba1994..0560568b3925 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -518,6 +518,39 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	int i, r = 0;
+	int j;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock(&kiq->ring_lock);
+	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
+		if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
+						adev->gfx.num_gfx_rings)) {
+			spin_unlock(&kiq->ring_lock);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_gfx_rings;
+			kiq->pmf->kiq_unmap_queues(kiq_ring,
+						   &adev->gfx.gfx_ring[i],
+						   PREEMPT_QUEUES, 0, 0);
+		}
+	}
+
+	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
+		r = amdgpu_ring_test_helper(kiq_ring);
+	spin_unlock(&kiq->ring_lock);
+
+	return r;
+}
+
 int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 					int queue_bit)
 {
@@ -589,6 +622,41 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	int r, i, j;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
+		return -EINVAL;
+
+	spin_lock(&kiq->ring_lock);
+	/* No need to map kcq on the slave */
+	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
+		r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
+						adev->gfx.num_gfx_rings);
+		if (r) {
+			DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+			spin_unlock(&adev->gfx.kiq[0].ring_lock);
+			return r;
+		}
+
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_gfx_rings;
+			kiq->pmf->kiq_map_queues(kiq_ring,
+						 &adev->gfx.gfx_ring[i]);
+		}
+	}
+
+	r = amdgpu_ring_test_helper(kiq_ring);
+	spin_unlock(&kiq->ring_lock);
+	if (r)
+		DRM_ERROR("KCQ enable failed\n");
+
+	return r;
+}
+
 /* amdgpu_gfx_off_ctrl - Handle gfx off feature enable/disable
  *
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f1a2ce7b6aca..2755f00ac19a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -433,6 +433,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id);
+int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id);
+int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id);
 
 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev);
 void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev);
-- 
2.40.0

