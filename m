Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179ACC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 14:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC7C61076
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 14:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDC7C61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AE76E8DC;
	Fri,  5 Nov 2021 14:09:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93B26E8DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 14:09:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzmb+8twBdM7cYqFyPIeUA10QxDd+memJu71I6e6ual7PsHZeaOWezDTdPsfq/6XEh7aq+HVXr/vO1ibNfqdILe3YNPto58bMjnDjo250b1m+tQk4RcSDz9mTD039Xf8YCOobKhZsibP+I5kacixA8dpG3FSxGxiSeEz0n7aRFwkSjftPzU8BSZJEbxq373sXt13e4ZqhqdaOquFtOWm3lQXJq1qK/7E+pbBI5faGjv1xrseWoKXqw2PQjlZ8kAsbyfUO+r+aAE8cunIE53+iuo7/87VR1Ce3kMVTTd0Udd0rnFEMJoZkTGhMzYVLu2N54HmIF+sf/1UQIRCjl4gDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jS9SL2XRdol7Ju8MeNKYhOy/iPnydGGqYWbum8Qr14=;
 b=OMQwQy/WY+UZbbs+zFxd1VVxeJJMEvjTAMKbCCilQvgj5T4LPRK//xq26ghxFlWx7ELfx7Sz1UNVYVeJvFRlQLzvwBroQl/eKGn4Sj5l7g0c5TRPv4dUahz2f4zCxGiMumhKmnueWSg6iqhxE/HCfBcqzQad0KRmV6+UtGId9vDLjCqM77ICs9VbTLbo8sZXadobrrEy24jMH1gQGud2edh6H0yiWjMY2Kb4pcblj+Oy8fYL/uYeAB2lPaDo0vWfEe9vwIjIWkpcCq2eupfPV9P1BWQe4UHbRrXXE36EEPpBQ0B2R3YFg251rWESNiRoNHfbzJ+iOL2SIH4A9hZqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jS9SL2XRdol7Ju8MeNKYhOy/iPnydGGqYWbum8Qr14=;
 b=sl7+U0D6sM0DSvVngOayiwp2s9fszZMzHyj50wrop53tlxt8STHQk5yZnWx19M4pGcuZ+5FLuTDsGNSdbOEPtnid8QVYT8dQYtK5wdxpmBxECULbPLxSZKq81SeNmdaghdh2stiGS9f9lD6fHlyr3KDJoran/zpETsOcZliacUw=
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Fri, 5 Nov
 2021 14:09:36 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::a3) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 14:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 14:09:35 +0000
Received: from linux.fritz.box.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 09:09:33 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 3/3] drm/amdgpu: enable HIQ in amdgpu without kfd
Date: Fri, 5 Nov 2021 15:09:12 +0100
Message-ID: <20211105140912.3638-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105140912.3638-1-nirmoy.das@amd.com>
References: <20211105140912.3638-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0ae1eda-1cad-43a6-7a93-08d9a065e5ea
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-Microsoft-Antispam-PRVS: <DM6PR12MB312965497BB99619970B2EDF8B8E9@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwgzSCORn+YhZnUEv3kbDNw2YWq7msnH9iPpBfGdBuRMWCt2B8OgD53KrgYNJ5GoQMOowQD9Uwnwo4XmO0qMgm7ms2NXGbq+iZkY4WlSAfTq/8tOFIH2Ma4ai7XUV/1eDwItAZTR7PsgnHWXncIGRwD5/AA7HZFV7tqm9wYEleSMOsvz9Fe1TfGKKFSxLWbUODx4pRR89cg4cwJ1tOyDAJgmxb/wkyGdIt31kLoJwTkrqPd+YXiDwQKlletTWJGUj6GKv5o9GO0Y89r/M97A9n6mjwBQiCPmSCK//6gGBnfFx71tDAguYqq+prtspvnXrz1MyGmdEjuEtPxJuEMvCHzO9STyTmMduY7l4e5EhFHlcjtz8OUAAT7xTIp17aVlD5gcxy7Mu32D3Vvo114VVo8b/TOZxiX1lRtKvI38y291QzmEnmNytRDRun9OLPLI2Y+xFElXhebmg4A/EWb29U7uh6j07er6WILa+ivtyE7iU8B9YTxxm2Oa68mkpGVMFQmZyPYMX/D7d2U+VIhApdtjGgcYA66JZkGmfK6w7fs6GdEemqw9/odkcX/vTZMWp4r1lXfMXQrKVmZy1+j3lOsCKgaZrjPaBCgbyNP4tDh6xvSoT9AEwX5FZZtvTMeS72VTn1X61+2hDO6m4iT2NREnSMVtNBR3GqIFA4c9Kno//ZVR0Ba5r3nyEx2L3rnCPEJQ0plqaUZenxb28VRlxdBbszGNEYge5YVc3dPx9JY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(70586007)(8676002)(6916009)(5660300002)(1076003)(86362001)(2906002)(2616005)(54906003)(70206006)(8936002)(36756003)(83380400001)(6666004)(4326008)(26005)(336012)(356005)(36860700001)(47076005)(316002)(186003)(16526019)(44832011)(426003)(81166007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 14:09:35.7567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ae1eda-1cad-43a6-7a93-08d9a065e5ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is a HW bug which prevents CP to read secure buffers
with HIQ being configured and mapped using KIQ. KFD already
does this for amdgpu but when kfd is not enabled amdgpu
should that for itself.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 77 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 80 +++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 053a1119ebfe..837f76550242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -519,7 +519,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 					    AMDGPU_GEM_DOMAIN_VRAM, &ring->mqd_obj,
 					    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 		if (r) {
-			dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
+			dev_warn(adev->dev, "failed to create KIQ ring mqd ob (%d)", r);
 			return r;
 		}
 
@@ -569,6 +569,18 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		}
 	}
 
+	/* create MQD for HIQ */
+	ring = &adev->gfx.hiq.ring;
+	if (!ring->mqd_obj) {
+		r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_VRAM, &ring->mqd_obj,
+					    &ring->mqd_gpu_addr, &ring->mqd_ptr);
+		if (r) {
+			dev_warn(adev->dev, "failed to create HIQ ring mqd ob (%d)", r);
+			return r;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 538130c453a6..9532f013128f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4794,6 +4794,7 @@ static int gfx_v10_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id = 0;
 	struct amdgpu_kiq *kiq;
+	struct amdgpu_hiq *hiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
@@ -4923,6 +4924,18 @@ static int gfx_v10_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	if (!adev->kfd.dev) {
+		r = amdgpu_gfx_hiq_init(adev, GFX10_MEC_HPD_SIZE);
+		if (r) {
+			DRM_ERROR("Failed to init HIQ BOs!\n");
+			return r;
+		}
+
+		hiq = &adev->gfx.hiq;
+		r = amdgpu_gfx_hiq_init_ring(adev, &hiq->ring, &hiq->irq);
+		if (r)
+			return r;
+	}
 	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mqd));
 	if (r)
 		return r;
@@ -7215,6 +7228,54 @@ static int gfx_v10_0_kcq_resume(struct amdgpu_device *adev)
 	return r;
 }
 
+static int gfx_v10_0_hiq_init_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct v10_compute_mqd *mqd = ring->mqd_ptr;
+
+
+	if (amdgpu_in_reset(adev)) {
+		/* reset ring buffer */
+		ring->wptr = 0;
+		amdgpu_ring_clear_ring(ring);
+
+	} else {
+		memset((void *)mqd, 0, sizeof(*mqd));
+		mutex_lock(&adev->srbm_mutex);
+		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v10_0_compute_mqd_init(ring);
+		nv_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	return 0;
+}
+
+static int gfx_v10_0_hiq_resume(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	int r;
+
+	ring = &adev->gfx.hiq.ring;
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0))
+		return r;
+
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (unlikely(r != 0))
+		return r;
+
+	gfx_v10_0_hiq_init_queue(ring);
+	amdgpu_bo_kunmap(ring->mqd_obj);
+	ring->mqd_ptr = NULL;
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	ring->sched.ready = true;
+
+	amdgpu_gfx_enable_hiq(adev);
+	return 0;
+}
+
 static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -7252,6 +7313,12 @@ static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
+	if (!adev->kfd.dev) {
+		r = gfx_v10_0_hiq_resume(adev);
+		if (r)
+			return r;
+	}
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 		ring = &adev->gfx.gfx_ring[i];
 		r = amdgpu_ring_test_helper(ring);
@@ -7557,6 +7624,11 @@ static int gfx_v10_0_hw_fini(void *handle)
 #endif
 		if (amdgpu_gfx_disable_kcq(adev))
 			DRM_ERROR("KCQ disable failed\n");
+
+		if (!adev->kfd.dev) {
+			if (amdgpu_gfx_disable_hiq(adev))
+				DRM_ERROR("HIQ disable failed\n");
+		}
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -9470,11 +9542,16 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
 };
 
+static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_hiq = {
+	.type = AMDGPU_RING_TYPE_HIQ,
+};
+
 static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
 	adev->gfx.kiq.ring.funcs = &gfx_v10_0_ring_funcs_kiq;
+	adev->gfx.hiq.ring.funcs = &gfx_v10_0_ring_funcs_hiq;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		adev->gfx.gfx_ring[i].funcs = &gfx_v10_0_ring_funcs_gfx;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2b29e42bde62..9653ea8743d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2309,6 +2309,7 @@ static int gfx_v9_0_sw_init(void *handle)
 	int i, j, k, r, ring_id;
 	struct amdgpu_ring *ring;
 	struct amdgpu_kiq *kiq;
+	struct amdgpu_hiq *hiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
@@ -2428,6 +2429,19 @@ static int gfx_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	if (!adev->kfd.dev) {
+		r = amdgpu_gfx_hiq_init(adev, GFX9_MEC_HPD_SIZE);
+		if (r) {
+			DRM_ERROR("Failed to init HIQ BOs!\n");
+			return r;
+		}
+
+		hiq = &adev->gfx.hiq;
+		r = amdgpu_gfx_hiq_init_ring(adev, &hiq->ring, &hiq->irq);
+		if (r)
+			return r;
+	}
+
 	/* create MQD for all compute queues as wel as KIQ for SRIOV case */
 	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v9_mqd_allocation));
 	if (r)
@@ -3911,6 +3925,56 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
 	return r;
 }
 
+static int gfx_v9_0_hiq_init_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct v9_mqd *mqd = ring->mqd_ptr;
+
+
+	if (amdgpu_in_reset(adev)) {
+		/* reset ring buffer */
+		ring->wptr = 0;
+		amdgpu_ring_clear_ring(ring);
+
+	} else {
+		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
+		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
+		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
+		mutex_lock(&adev->srbm_mutex);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v9_0_mqd_init(ring);
+		soc15_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	return 0;
+}
+
+static int gfx_v9_0_hiq_resume(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	int r;
+
+	ring = &adev->gfx.hiq.ring;
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0))
+		return r;
+
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (unlikely(r != 0))
+		return r;
+
+	gfx_v9_0_hiq_init_queue(ring);
+	amdgpu_bo_kunmap(ring->mqd_obj);
+	ring->mqd_ptr = NULL;
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	ring->sched.ready = true;
+
+	amdgpu_gfx_enable_hiq(adev);
+	return 0;
+}
+
 static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -3946,6 +4010,12 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	if (!adev->kfd.dev) {
+		r = gfx_v9_0_hiq_resume(adev);
+		if (r)
+			return r;
+	}
+
 	if (adev->gfx.num_gfx_rings) {
 		ring = &adev->gfx.gfx_ring[0];
 		r = amdgpu_ring_test_helper(ring);
@@ -4027,6 +4097,11 @@ static int gfx_v9_0_hw_fini(void *handle)
 		/* disable KCQ to avoid CPC touch memory not valid anymore */
 		amdgpu_gfx_disable_kcq(adev);
 
+	if (!adev->kfd.dev) {
+		if (amdgpu_gfx_disable_hiq(adev))
+			DRM_ERROR("HIQ disable failed");
+	}
+
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v9_0_cp_gfx_enable(adev, false);
 		/* must disable polling for SRIOV when hw finished, otherwise
@@ -6986,11 +7061,16 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 };
 
+static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_hiq = {
+	.type = AMDGPU_RING_TYPE_HIQ,
+};
+
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
 	adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
+	adev->gfx.hiq.ring.funcs = &gfx_v9_0_ring_funcs_hiq;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
-- 
2.31.1

