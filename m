Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0655C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 06:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1335310E4BE;
	Fri,  5 Jan 2024 06:05:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC4610E4BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 06:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2w9hXoP5NRU6TKeYBe4j0VLUolTW5db9iQjXk3hAqvJ5LIv6HhEqTvIbDprZmO2pSQ25Knddkj2zLzw8D0gP1gQEUVYheAPraR2dae+NVDV/2oJbzczth3t8JZROhDVpveCutJBTmfDKcE1UCD0AIz4OefgqHHxYG1uDZxER/Ps2PEMNIkOzVtZqydnjpZ45cXgkGh/09rdDcJTjWnIQVmdLiTwx19Gx8i0m+sgv9/otx9v1XmOH6WTkrszGx389bbAJXRcOL2Qu00W0svXoly0CUES2oEM7zipM2BVeoXDQOzd1HOPB8sKZxS3BKyXrsLV4QhEOXnDv8/P93W7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8amw13f3YvuD+AFRqjyAvkZWe+q8cgamx8f8C11/1A4=;
 b=hlU5z35rCBOBclSqt4uH5scSCrwmf8NGOHn9Sz0O2fbAdhQduwCz+s1YGhZ8LlCGBBGUzL9rByOI+2HlWEGsQ0vQv7TvJi3KXVYDMO+2uvD4fQiv5zGo6NlMsQE9r1zs7bhf4kKzePmZk5BAxpK2PLCDN7Y9inKP9lZ8uu6ogdjsJOscikh3pyLvWtTX87U92ZRYUWxTdHrcwwMkhT8dGO6J0pyk6A+0IhF4hkbjKtGMjFN1EU7qOnEpJ5d1R+w52Vnx1vY0hLP397BGPRfTmjVll+1tV1sdDrNASNYPi3sAtCJtOBU/iNyJyoG7UtL9YJqrHqKpnPntOJUc0YBNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8amw13f3YvuD+AFRqjyAvkZWe+q8cgamx8f8C11/1A4=;
 b=Mf6m23DRLOGUvfIX7IkS3WoHZizG9PoJOOwzUxCfDA5E4xdYK6KPjWQJO84rjiK4nk4LjoU7kh2bSdaLwnWu1lwdf1Ws57JSFCdLKH9dasfE90zdHDJfPGpjIug0cdXUZLHmf14JB8yvQxfVtbIaKXO4pQ3r0OMhb4A2RtcDOZA=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.16; Fri, 5 Jan 2024 06:05:43 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::66) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Fri, 5 Jan 2024 06:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 06:05:43 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 00:05:41 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix the warning info in mode1 reset
Date: Fri, 5 Jan 2024 14:05:25 +0800
Message-ID: <20240105060525.579292-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH0PR12MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 603ac332-b104-472d-3d85-08dc0db45a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k43Tel72t6WDtj5XthrmxAylXT2gxkTITJ85GwUHeAAM7iTbINMHTEBH3Vrgp10ZlW0GsM2Mv+DUjakeuAOORj315vuMMuwdkz3ZFNbjEgCCJibIG3jrddIeEd5EXJhrKoS1EgTv99Wp2aB+hqEkG1QQlcdH213hPdTqxz9e7b91/e9sLTlJfsbasjuEujX/GFZOOvNVrG6DKjD9+oF1bqgEBw9xE8+4s0+JEbfNIW1cgMvo1BAYL4g61yE356O8YykL8/LmpW31Mhcy0Mibswwj2e7oDTUEx4v7d8+53jN4nCn89zJAQVWTVj8QI+vZXJanuCK+8NhTksDiHhz7aSScw3l1zV+/JSbPVyZ6bSOMeAcv9d1xQj0dct+7heqtteXZVtTXTgu4+fzcPb6vvW+3frbvprw2ew14dA/tCVQmCQIMKM8b106kR83FihyAfokmtgPKIfLh7FZSgGA7ZfLf9Z8WMQ84wCMNvhmFN3yX4b+jiv3dFR9bzFKmsX6jwkTDFgclsVQdod0M98hAef6woHZNdpuBR3JdxGsO681ox/Urs603CUlT0enbFRbWGz5YkrJLYzZ9EQ5XVKsL0Z6IJbuKeA4l3/9qt9JloyaWx/V9NEXDMNt8S6Kunj0lGgNtIid6wWL5n0VIOaj5gWTfTy8J8dD0DeaiJf+E5SXOMcXI7lZ6zJH1HM6rCQwvTRo9wUV+U9GlzX/zsgRN/vFk+O+H+uT2YGSfx1zGr+7QaBJOQDmg45tt55hI21UGN4tixnpq2eQDcUIUxdYgJbL8a1X8TrP9WFQ9apIBCSAtakVYj18f7zDvf5iQ5RSC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230173577357003)(230273577357003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(46966006)(36840700001)(40470700004)(2616005)(336012)(16526019)(426003)(1076003)(26005)(7696005)(6666004)(86362001)(83380400001)(4326008)(316002)(54906003)(110136005)(8676002)(8936002)(2906002)(36756003)(5660300002)(478600001)(6636002)(70206006)(70586007)(82740400003)(81166007)(356005)(47076005)(36860700001)(41300700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 06:05:43.6650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603ac332-b104-472d-3d85-08dc0db45a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the warning info below during mode1 reset.
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000006]  ? show_regs+0x6e/0x80
[  +0.000011]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000005]  ? __warn+0x91/0x150
[  +0.000009]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000006]  ? report_bug+0x19d/0x1b0
[  +0.000013]  ? handle_bug+0x46/0x80
[  +0.000012]  ? exc_invalid_op+0x1d/0x80
[  +0.000011]  ? asm_exc_invalid_op+0x1f/0x30
[  +0.000014]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000007]  ? __flush_work.isra.0+0x208/0x390
[  +0.000007]  ? _prb_read_valid+0x216/0x290
[  +0.000008]  __cancel_work_timer+0x11d/0x1a0
[  +0.000007]  ? try_to_grab_pending+0xe8/0x190
[  +0.000012]  cancel_work_sync+0x14/0x20
[  +0.000008]  amddrm_sched_stop+0x3c/0x1d0 [amd_sched]
[  +0.000032]  amdgpu_device_gpu_recover+0x29a/0xe90 [amdgpu]

This warning info was printed after applying the patch
"drm/sched: Convert drm scheduler to use a work queue rather than kthread".
The root cause is that amdgpu driver tries to use the uninitialized
work_struct in the struct drm_gpu_scheduler

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

v2:
 - Rename the function to amdgpu_ring_sched_ready and move it to
amdgpu_ring.c (Alex)

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b1d5f42249f..d0d82e69b034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5700,7 +5700,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
@@ -5776,7 +5776,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
 			drm_sched_start(&ring->sched, true);
@@ -6265,7 +6265,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
 		drm_sched_start(&ring->sched, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 41266bc99345..9555d5532d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -636,7 +636,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
 		DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
 			      ring->name);
 
-	ring->sched.ready = !r;
+	if (!ring->no_scheduler)
+		ring->sched.ready = !r;
 	return r;
 }
 
@@ -719,3 +720,14 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring)
 	if (ring->is_sw_ring)
 		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_DE);
 }
+
+bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
+{
+	if (!ring)
+		return false;
+
+	if (ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
+		return false;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index bbb53720a018..fe1a61eb6e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -450,5 +450,5 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
-
+bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
 #endif
-- 
2.34.1

