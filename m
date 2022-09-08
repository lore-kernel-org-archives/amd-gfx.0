Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A23ECAAD5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 08:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8367710E9AC;
	Thu,  8 Sep 2022 08:44:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FBC10E9A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 08:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSN2t8/h1uCJafhGMWKaiRtSHERJGuVVXRqWlZJrFZ/xlUxmX8urBhxZl+fi/oU6IfBBiCB/xeWZLAr6sptw+HFMg7SwzJWTVb92kIGqLmR5/g1QqwVGeAEGOI4VCuJnKENfgIlSz27jM8fI50dtDHKEtbc7UyYuzCmYrSDRBDE0m9gmpOy5gznF1Dc4ZCFnrX42RgelYd03N+5GgI8BH1GBCoZbrarpA7gr4pUd8CV2MLIqii9Lj42+xXUAWQFCoiDKx4X6lsm3l3EsE2fiXMwi3yaZbb1konlexHkBDpv3kl/VX7xjk3PeKAKjuN7fUNusqIQCyB2Big6c0Xk/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMfKshkEh9b6h/4C4wwp5D1c3/MNpDMWig2UAUbQ7DM=;
 b=EIwWbgExqm2PuPNtQ1PpDjvP+H78pPK9YADk49NBy+FDlW1yLV9TF21lj1PQ85v0dGLjxuomoZriRajO4PaPO5so6GSOk0DUI/5mknrtsC2W7GVKZ01K8Lt2DbjtlRq9x2WVPYNlViXEHQehoEQni2qP1zqia55WUYpjyB+0/CebZAbC3Sk25hDDHdHMyNyi7tT+cVH8ltU+lOukM2SWxuaZVgSS6gsEKEoaEzAyAiyMMkV9up2yFbdgcdY8F3EejQoQ6H9MHNryv8lVVHkjHra/I8FUOEMuwUeYCmigW3oIOX5OEkpq6mwGec/ri8wxN34UE8Q8SrHxmqKIcMV4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMfKshkEh9b6h/4C4wwp5D1c3/MNpDMWig2UAUbQ7DM=;
 b=ccSefodFWQTQb7DIjX23FuFwuKmY9lk48yF/73z3tdBEW3gmsmauTZqDtqH6j3p5PF/M9TpuGIEA2ktPIfP2MkSsRkSKwT70RJbJ8sJRKt30saxg+IUTwCBAHjxQKfEAMXus5mzZDizMZxd7lsiTIrUmwqaCZsPb3q+yw73mz/U=
Received: from BN9PR03CA0108.namprd03.prod.outlook.com (2603:10b6:408:fd::23)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 08:43:53 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::8a) by BN9PR03CA0108.outlook.office365.com
 (2603:10b6:408:fd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 08:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 08:43:52 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 03:43:50 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 2/3] drm/amdgpu: Fixed psp fence and memory issues when
 removing amdgpu device
Date: Thu, 8 Sep 2022 16:42:35 +0800
Message-ID: <20220908084236.110566-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908084236.110566-1-YiPeng.Chai@amd.com>
References: <20220908084236.110566-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ef7934-a204-4898-d746-08da9176421f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcA4xKDzbeon3MnttYBzJnGgnT6BwCBamMhSoEtwL8kIGGslufKaSJtpV4uM7xbKSAKV5OpmEY97al62QtyY4yn5Um780eqvChjis1YCLL4q3PJMfRfqCkniOpW9Hiw5r+V6XE/wfVYyv1zt2TBVD1VuVFmrfrWLxYjLsu4bDbC5pVWtrasGzdpic1ZqLlSu4/WW+P3tIzibOsXZZln2BZJP9kQGwfbriTu6YM1Yhifn41lAlUsxxPv0xIac33GP2xPOTaInVaN8ZtNYmRDR0AzOlnitFgylZOY0CazDbZK4qVT7K4MtBtQCdRa+3OD2aET3ZeYLfa161soWK7UViU8bbBr3PQu4eSSO0dJKqrAF9r6K3ymfE8v1z18UIrf9N6412aNG89eXNNmLZNRg7Vj75WYmZQL+dfwZnEdnqm8dcd67P7lEYJI1T/+snRpOpu6x+9fgCAwbN5SE5het9dOxeexpKjnGSJVNs1kO3ske8O9Z434bAvA95QXB9BEfZlOmlujnXp+/45M3fHili9W5POmQMnSrWcD8NfcLd9iUsXe5ViudnTysx7IQBP6AHwi6IH2yjAEWCi8mcOpsExDKKx9YvgDUwN0mLcecyMCXStB4boqyauA0shte2sYQYYnkj5b/bCR/WDDr8+z/0V2ORm21VmPEhqQvczr0rClqD771R6iHBqrZPwPBHZpPVgL5KXxj2biYJCt6wwYqmo21KmatmG0I9tNSnwWjCXsHjWv14iVZsDHPa8Tu0DOq/fcDUJei3jMjfnKIQ58aWe0WEzYwXA350Vhic/jUmvOrz/G8ICwnegBDqS5kiRb8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(40470700004)(36840700001)(8936002)(2906002)(40460700003)(316002)(36860700001)(81166007)(70586007)(70206006)(82310400005)(54906003)(4326008)(6916009)(8676002)(356005)(82740400003)(83380400001)(2616005)(47076005)(426003)(1076003)(5660300002)(40480700001)(16526019)(26005)(336012)(478600001)(41300700001)(6666004)(186003)(7696005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 08:43:52.7116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ef7934-a204-4898-d746-08da9176421f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>,
 KevinYang.Wang@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V3:
Fixed psp fence and memory issues for the asic
using smu v13_0_2 when removing amdgpu device.

[Why]:
1. psp_suspend->psp_free_shared_bufs->
       psp_ta_free_shared_buf->
           amdgpu_bo_free_kernel->
             ...->amdgpu_bo_release_notify->
                    amdgpu_fill_buffer
   psp will free vram memory used by psp when psp_suspend
   is called. But for the asic using smu v13_0_2, because
   psp_suspend is called before adev->shutdown is set to
   true when removing the first hive device, amdgpu fill_buffer
   will be called, which will cause fence issues when evicting
   all vram resources in amdgpu vram mgr_fini.
2. Since psp_hw_fini is not called after calling psp_suspend
   and psp_suspend only calls psp_ring_stop, the psp ring memory
   will not be released when amdgpu device is removed.

[How]:
1. Set shutdown to true before calling amdgpu_device_gpu_recover,
   then amdgpu_fill_buffer will not be called when psp_suspend is
   called.
2. Free psp ring memory in psp_sw_fini.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2614b881128..6df748599688 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5183,8 +5183,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 */
 	INIT_LIST_HEAD(&device_list);
 	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
-		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			list_add_tail(&tmp_adev->reset_list, &device_list);
+			if (gpu_reset_for_dev_remove && adev->shutdown)
+				tmp_adev->shutdown = true;
+		}
 		if (!list_is_first(&adev->reset_list, &device_list))
 			list_rotate_to_front(&adev->reset_list, &device_list);
 		device_list_handle = &device_list;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8933f8f63d13..77dd5a631efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2206,6 +2206,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		if (need_to_reset_gpu) {
 			struct amdgpu_reset_context reset_context;
 
+			adev->shutdown = true;
 			memset(&reset_context, 0, sizeof(reset_context));
 			reset_context.method = AMD_RESET_METHOD_NONE;
 			reset_context.reset_req_dev = adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 28ca0a94b8a5..0646992c816d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -508,6 +508,11 @@ static int psp_sw_fini(void *handle)
 	kfree(cmd);
 	cmd = NULL;
 
+	if (psp->km_ring.ring_mem)
+		amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+				&psp->km_ring.ring_mem_mc_addr,
+				(void **)&psp->km_ring.ring_mem);
+
 	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
 			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
-- 
2.25.1

