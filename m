Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A91C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F20D10EC21;
	Wed, 29 Mar 2023 20:10:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBB710EC11
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBE/NOmasx9z3Jx4ooFoATTtAz6y6b7G6+zbjNny+DHnzlheYTH9QGqRLTSbCLSVZy03VNeG2MXxu7cL6gPrLPtBRKcKhPbcWIcKrZUu1WPX9VzDUgMIY3x7iiRAG6FuZ9965IZmeRQd+bQKQgYLCMMoxgB/hLPR7N1gCFNypU5PX84LhbbCwd/6X4q83jTeMY4R2IZV2BDqMIPjsaopreRr8D6iBGFIMXLzNSEHur90SAW7nBIgs3MpeKbqUX6fGzJX5NKbwlV+TwWHIZRlrHo7VEDWXV+8zpws3f8zJ3yhGgpaY4cpAIgmza09Jvbr//mXUIhnqQModl2DGIceXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0NNPjBoCqD8FdMAOcyvFgXQgkZC3vtQ0+JTlyaqBiM=;
 b=nKsLAsrahYvVy9Z/x0I7kSOrChjVIDnsz1neQr14IcmfoqsCj19zzuKwFoq0SJDzd2jMjxcHhBLKifxAa+hRRpK4RMCG4f6rh+jWWVQOiXT2A0xJbhEh/X/THhNOUUEuvOqdoSyQkZYOxV0f8BVaHrzwPpMLz4tN5DG6p4HHjs55XfI51zC4Xu0vwnkRopBgMaSm2ECYSpTw383rv0wmI+a1kfxINVnqunS5HzdGz3t+4+Q6jYsKyjOUxcCWyX9xrYkIoL3HL2vrdZ3EqwSLbIb0zIXluiiddrp6MpfIjfgRhmUt+cw82/a4CZt8dyz/ZJK3GASXFDQihDytKdSxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0NNPjBoCqD8FdMAOcyvFgXQgkZC3vtQ0+JTlyaqBiM=;
 b=DjmKPhy/sAooYp4TIW8DdJ9pVYs+B1d0Z59yJSJ0LEHOUJLi9ocYN758snELaNvWv0e6I+SmXj/cbUxavzZVorlRU7Mgt/DznM6rpkcZkR0oZyKUMJdGdJKVJoL6i6Aih24MMgaR9Aj2iNxfwSfV4CXJct/WZ3FvJ3KbNbIH2Js=
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:09:55 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::b5) by DS7PR06CA0012.outlook.office365.com
 (2603:10b6:8:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amdkfd: Add device repartition support
Date: Wed, 29 Mar 2023 16:09:24 -0400
Message-ID: <20230329200930.1982035-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 28491b7e-614f-47f8-9459-08db30919032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akyv6ZgHOhBd/xwpoLsgYFRp/LvxvS4hm5rdtRiLXP0RjlyjMJC6zyjJdHDHjr1zv0ymfBD7tpQ1NLDtYy+4+EYvoDyqqVk3skRmVfXPd81c+dP5pJprEgAs1l4Cd72PFp1E01Ydahw42X3tSLTdG5DjikGIuPK0+eIWN6mLxZud8bpOilNyn/fgFbf+RZ/re7bHGxiUdwGboiZSF1ftZJx8SgbMEE2TGEVRDqTSIC4ah0IOg5eI1woxxrSdkhlilNlgr/pucVyfTaNTpEZfHBhmBO/j9dmbmNHDk/Hwg0cQ5iVTGPXJuTj2g4X4AKgvHkkb2SXBLLKRJxRH0r5j5jgBORz2Wg3LQevsBjCAJBSwbteLZa3Zi99wFMuNzjIsr8sb6YR3JkWZFMOeFK/nVNyrCm6wqmkoeQhAT3gncoG1CDlWcBlAK8nlFQ9IltghhmyJMQtoFpyZiQxZMrJ9tau3uIrJid6MPRe3mWGqAFMUI7b+msENnFI+H3wzeCAfqR6VHakY0c7HKNQ6BSLX3NdIg2hnVY5uh7RS9tIG55T21treP6t0K+QKV1jgBMnVJ9FKotRXijZhP6ANSDqm8VESW9eCPZz8PGwPPpQotyohMvJRAqgYRDT1NiIlkf4x/QFG2z7neaVetJojEtv7IVA7dchU/VyoJkq23srclHdxPt1a8HCgB0xVAkJTL3wY+90ywnQ0eQOo3s5yJfeUuJNcTT56MkNxBmMk7eCatZo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(316002)(70206006)(36756003)(70586007)(186003)(40480700001)(26005)(16526019)(1076003)(40460700003)(6666004)(82740400003)(36860700001)(2616005)(336012)(47076005)(83380400001)(426003)(478600001)(356005)(81166007)(7696005)(82310400005)(5660300002)(2906002)(41300700001)(4326008)(6916009)(8676002)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:54.9901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28491b7e-614f-47f8-9459-08db30919032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

GFX9.4.3 will support dynamic repartitioning of the GPU through sysfs.
Add device repartitioning support in KFD to repartition GPU from one
mode to other.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 22 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  5 +----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 21 +++++++++++++++++++++
 5 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0f641bb30870..992af8b100cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -772,3 +772,13 @@ bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
 	else
 		return false;
 }
+
+int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev)
+{
+	return kgd2kfd_check_and_lock_kfd();
+}
+
+void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
+{
+	kgd2kfd_unlock_kfd();
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index df07e212c21e..9cc28fe32cdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -151,6 +151,8 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);
+int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
+void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);
 int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 				enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
@@ -373,6 +375,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask);
+int kgd2kfd_check_and_lock_kfd(void);
+void kgd2kfd_unlock_kfd(void);
 #else
 static inline int kgd2kfd_init(void)
 {
@@ -438,5 +442,14 @@ static inline
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 {
 }
+
+static int kgd2kfd_check_and_lock_kfd(void)
+{
+	return 0;
+}
+
+static void kgd2kfd_unlock_kfd(void)
+{
+}
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2a781d3dcc05..a98c38a75504 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1155,10 +1155,30 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 		return -EINVAL;
 	}
 
+	if (!adev->kfd.init_complete)
+		return -EPERM;
+
 	mutex_lock(&adev->gfx.partition_mutex);
 
-	ret = adev->gfx.funcs->switch_partition_mode(adev, mode);
+	if (mode == adev->gfx.funcs->query_partition_mode(adev))
+		goto out;
+
+	ret = amdgpu_amdkfd_check_and_lock_kfd(adev);
+	if (ret)
+		goto out;
+
+	amdgpu_amdkfd_device_fini_sw(adev);
+
+	adev->gfx.funcs->switch_partition_mode(adev, mode);
+
+	amdgpu_amdkfd_device_probe(adev);
+	amdgpu_amdkfd_device_init(adev);
+	/* If KFD init failed, return failure */
+	if (!adev->kfd.init_complete)
+		ret = -EIO;
 
+	amdgpu_amdkfd_unlock_kfd(adev);
+out:
 	mutex_unlock(&adev->gfx.partition_mutex);
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d248c4f2e2c4..df9756df7941 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -680,7 +680,7 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 static enum amdgpu_gfx_partition
 gfx_v9_4_3_query_compute_partition(struct amdgpu_device *adev)
 {
-	enum amdgpu_gfx_partition mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+	enum amdgpu_gfx_partition mode = adev->gfx.partition_mode;
 
 	if (adev->nbio.funcs->get_compute_partition_mode)
 		mode = adev->nbio.funcs->get_compute_partition_mode(adev);
@@ -694,9 +694,6 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 	u32 tmp = 0;
 	int num_xcc_per_partition, i, num_xcc;
 
-	if (mode == adev->gfx.partition_mode)
-		return mode;
-
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7aa4f4ee7752..02a87650412d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1348,6 +1348,27 @@ unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_node *node)
 		kfd_get_num_sdma_engines(node);
 }
 
+int kgd2kfd_check_and_lock_kfd(void)
+{
+	mutex_lock(&kfd_processes_mutex);
+	if (!hash_empty(kfd_processes_table) || kfd_is_locked()) {
+		mutex_unlock(&kfd_processes_mutex);
+		return -EBUSY;
+	}
+
+	++kfd_locked;
+	mutex_unlock(&kfd_processes_mutex);
+
+	return 0;
+}
+
+void kgd2kfd_unlock_kfd(void)
+{
+	mutex_lock(&kfd_processes_mutex);
+	--kfd_locked;
+	mutex_unlock(&kfd_processes_mutex);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
-- 
2.39.2

