Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DF4C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5528110EA35;
	Wed, 26 Apr 2023 21:22:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E0210EA29
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlAvQI2SfE8PZN4o9v3yRtWzSu5uc0R5JF66Gw5UVb5Rv7DUJdj6968AYl8ISRJy3xx9oa7vjkA/gFqJ/jvlrd9j13hcCxEl3oRqTw9Dmfb4BA+ZD8FnrXPaEzby/FeBuC9Kq0nb7UGiVqUi5DxMGsP65oWHLqlY8Ja6dUgBHfU4+URnG1ZtvC1I0DrApvFaC2a7wtm+7g9zkUnpX6V9ggEYOtQDVNgheBdWu7DggL1b7PYOSI/YbRramtQn5AGWtIqxFh/bti6R1sfIneEDgnWJA7mFoVw2KGdvwUQSxmHL6LI7ZVUjOTqWSWH25Ivx5nzZNssTeHU2IUzjFOv6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVSmqldU2wCFPxOlh4MCWAe1aJYaivQYIcSHfbfWtOw=;
 b=Q+7F+9uAPk1oWl+PYc0ownhurBkimSyUggN56Du+8JZUWwPpCgmZLJOOc2I909jTpsxtPfiHVk3ZxqnbfGKvdtpEXW8tp3O9/gd7y39P8zIHgHPCDtM7Y7d+7YYmqu1KPaZi7WhVjMb8HKGIp6Evh9OydKRnsSJOw/Zz5Z+hrdr+XpXP8fTT/NLgf9/qG8jMcpHddwOYDtIrbyPNeQ0cEHstUBYy8FOOJlznFgugmQf2+uvm0+KSBUJ+fQSh2WXBpN8LZTsEehszQyYsjizXNXzqZ3FWhZEGpUEmYc3jgYKcX4fwGRoWtgNnX9b2CkZbSd44WciCFSAuApY3wvuFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVSmqldU2wCFPxOlh4MCWAe1aJYaivQYIcSHfbfWtOw=;
 b=Twlsx7BAOhOj3POTePB2LKqL/8JP4pVjw4xlqiX7VBaZqdPfZgJBkx5V0EBJMEuWT36/kmhdeoSSEuiA6wtN2556xGZwSOlf7nOEAkkQS6p1svTk8semgAgYh3gcJh/iwxAOplq72lR9GWQLOT09Z9Y3L6OSK8QGyield6LTEiU=
Received: from DS7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::21) by
 SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 26 Apr
 2023 21:22:01 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::5a) by DS7P222CA0028.outlook.office365.com
 (2603:10b6:8:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amdgpu: add [en/dis]able_kgq() functions
Date: Wed, 26 Apr 2023 17:21:34 -0400
Message-ID: <20230426212143.7696-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: f0df8b10-890b-4406-f01d-08db469c4663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWwjcCJqLY4dzBIEcrLgJi3581BamTVPhuyEQQdY1IiYXVn1XYZb7GfEsv35C+cRljP++ZXNz+/sVfQW6yvACgfbglrj+YDVT7MK/i1IkIT9Jb0eWvo68Kyh6jlMzIPQILD/tI1ObT6i9cZfVVfjmPAoFulmkutk3RQyRm4eLszcR4ErNoOvXYF6XItYKouV1FZJSsqytjsOfbZD4rLdW3SdXqPK1Y5l6GRqi1n1g41hxkqizi98sW8lTnVJEjyjMd0n83Dfd7fGlsUtn0RhHDY0pGQpwBFimsYjnOyEkkCstvGIEWCwkzugL6VitpgEaj7Yx6YK198axvM08oK/+VGdUXV/tOlFkpcQ3KqAI6uaK3wBZRGlnf+5wDvIS3RYmzVFuy3yXcK0WezzniaD3OPfG9fxILvdHsj7HiDYKMFiubtSrCKErBHlrt5OFSvDyzs6Pu9lzk1gDJx8aHRo92ol9nsT/1vGoToA2sZZaYgtGEw/AEp7370etPlwTYw8v+/eI92YB8+Oz66hVleYcI7uUB3KG0FkLXWMiUbH0dn0DOO+qBUm1agvVC9hbwum02xhySiefSUtkFg2dd1z1E6dg5yGCOpkXxUHkmwlTDBUoloSX64dV/ZsEWEIhTX+hiQgfzV8Kzas1TwiUp9tyb3PnIy8N41DxQ03+IDNiOcj91kbAh8fDD1uo6xAT/C9OG2/BLmOJ8s3zaDfmbtq0YMUaXfBwPjvEeWfmxcynqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(8936002)(8676002)(5660300002)(36756003)(82310400005)(86362001)(40480700001)(7696005)(6666004)(26005)(54906003)(1076003)(478600001)(36860700001)(2616005)(83380400001)(47076005)(336012)(426003)(186003)(70206006)(16526019)(316002)(82740400003)(356005)(70586007)(6916009)(4326008)(41300700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:01.2073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0df8b10-890b-4406-f01d-08db469c4663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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

