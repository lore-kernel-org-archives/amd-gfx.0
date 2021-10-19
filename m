Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E5C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA7760F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCA7760F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D740E6EAC1;
	Tue, 19 Oct 2021 21:15:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037E76E97D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONtmd/pT5TAeNnv+eiPPWfdYV0aiUu1KMOnNf7tQKt48DIC4NTIbcTLImKPn4arJN5bQSaXwBNxxL/DhTehsOG7qOhso7jDNWRvcdS9V3U12dz/GrJzQeToQ3zWL+ZI360gQPQosaiV7MSF351gAOiZbuVDWor/BbzEWasshvOe9hd0yxRVgYgVTSbAmUSodwh9mibia0zVV0aqDd1JIdXWoSRLkV3NxB+5TKNM5VdwidT7TPusuDkrio5wm0uTGaIfTUAiiluMWngnL1KwIXp/AZpZIcDL8NK1JOfvXf5uqiEjnL02RFqaSp90v7vqVvf85b5QavPDWGSThbxRhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0G6WkVN3YdaYDirTHWqFklNtlRtiVBC2zBhL2g7pw0=;
 b=TZWf19ak+ShUP7fbi5kfQlkn/+1vjJvJwsYSYUJaLN4Dvft1o4kxhpDgwYzWYvF/TmSRmzIrbJ0fNgnqdSR9ivhouEnis5yKYxLndAx2sVovqzX11zeG8lQYTj+wKdyNi9WL+k7wuvrMxG5owCaegZdxxmo5THInizyLZIR0482uHSMbCuNC8CMUCoGhDTMLgISPCz15oyoEVUO58V7ZsmgijjzuhpsiN7KG+hTWXzgd3LbAmxYJBU9LmoZC39WfqZlryIRQQUZHxxGeMo8IO34ZjQ44evji9KG0Oq19Wwsi8NOX5bbVl5AQxFiyWzJ28FBUUNEgz8e050/pRHwiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0G6WkVN3YdaYDirTHWqFklNtlRtiVBC2zBhL2g7pw0=;
 b=toi1ye7jJi4pVybi3wyEQMcwNLibrAv3YDiTFopkx7NN0VVnX4RGQ17CgQc2FEZCwExjOxPT4l/I0qleH3TTLm9amA05sEmH1QKfyKeqRQISGQMXWZUr6zzAls9DZGCGm2v7KGyt7HChqIF+pNNOH++WzGXMoTLksQRSTJuKUlk=
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 21:15:03 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::15) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Tue, 19 Oct 2021 21:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:15:03 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:15:00 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 12/13] drm/amdkfd: replace/remove remaining kgd_dev references
Date: Tue, 19 Oct 2021 17:13:33 -0400
Message-ID: <20211019211334.1552825-12-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019211334.1552825-1-Graham.Sider@amd.com>
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ced8ced-5210-48dc-6982-08d993458475
X-MS-TrafficTypeDiagnostic: DM6PR12MB3097:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30977EB6B34EAE81B1D2E5838ABD9@DM6PR12MB3097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BF0idjreHLL2FqlefVe0pW9NJHiC8CubyDq3lCwmdMX22rWMVjJRN8msL/ztpc5tU2QlRrlH0+1ILYw8vqNM4Gy5My9PUynu0f7nKNUF/gBUum65edfGp/Orpbcz0LgnxKwZiacoLWUmd0V/q8Bo2HzZZfHbTPLn+qZ+c7pVLGCBzrAnEhcauePlbLaupjOzEbK6fhO+c+hb7YXTl/8UwHK5dZOt9J5czrbEIvCHNxiPByZf9O3dwrU/ckp1OSogd52tuY5kMDM4C0eWVphjyhsXBPN74jI4OrggcRVGHO9QrxvIFA71aFmzipEaTsJ/EFY1RP1WDHfx/Ytd32iIFsjj0jqxaL5aJO564Qiw9CusHQNh5q/B0P8bQ+ITc3r/tBImEHA1UrJ3JzGqsKcWenLEMwXKkY4Q0jCsylHoNp6qVZwWTk2NPS97q1xNRsUeW8A5sn+wByGFmClsZGSx2zLq3HYCyVHZg2fLAZ9W3tF/nX/J3Vi47itx7c8ks6WvntMpsx7mx1JftZaZYx9Vxxj9HQ8ZxWXsyJ27e2D7dpA5P0D/cP6U9TzkZfIbyD/vX+ZwStF8IEbz5PNz3QVJLBDynPHCAK7ew5qrBAH+jzDGz4zCoVmS4aPlmlhZbmXTJzpyGE8BorfssEjIYlvkaCBvV7dRTV7wMpdWIVuh18YlIeigbIsYxRT9x8862cU96lSiBrSZWLc+EUTj4XfxvJMahNV1y5F1umvM9dDlfA4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(86362001)(82310400003)(356005)(81166007)(47076005)(83380400001)(54906003)(316002)(426003)(508600001)(30864003)(36756003)(7696005)(6666004)(4326008)(2616005)(336012)(8676002)(26005)(70586007)(70206006)(8936002)(6916009)(186003)(1076003)(16526019)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:15:03.3519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ced8ced-5210-48dc-6982-08d993458475
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  5 ---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  5 ---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  5 ---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  5 ---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  5 ---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  5 ---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  5 +--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 43 +++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 12 +++---
 14 files changed, 31 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index c2b8d970195b..abe93b3ff765 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -57,11 +57,6 @@
 		(*dump)[i++][1] = RREG32(addr);		\
 	} while (0)
 
-static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
-{
-	return (struct amdgpu_device *)kgd;
-}
-
 static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 {
 	return (struct v9_sdma_mqd *)mqd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 5f274b7c4121..7b7f4b2764c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -39,11 +39,6 @@ enum hqd_dequeue_request_type {
 	SAVE_WAVES
 };
 
-static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
-{
-	return (struct amdgpu_device *)kgd;
-}
-
 static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 980430974aca..1f37d3574001 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -38,11 +38,6 @@ enum hqd_dequeue_request_type {
 	SAVE_WAVES
 };
 
-static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
-{
-	return (struct amdgpu_device *)kgd;
-}
-
 static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index e31b03495db4..36528dad7684 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -82,11 +82,6 @@ union TCP_WATCH_CNTL_BITS {
 	float f32All;
 };
 
-static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
-{
-	return (struct amdgpu_device *)kgd;
-}
-
 static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 9a30a4f4f098..52832cd69a93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -39,11 +39,6 @@ enum hqd_dequeue_request_type {
 	RESET_WAVES
 };
 
-static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
-{
-	return (struct amdgpu_device *)kgd;
-}
-
 static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index d7b31adcfd80..ddfe7aff919d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -46,11 +46,6 @@ enum hqd_dequeue_request_type {
 	SAVE_WAVES
 };
 
-static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
-{
-	return (struct amdgpu_device *)kgd;
-}
-
 static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 7143550becb0..1dc6cb7446e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1963,8 +1963,6 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 			struct crat_subtype_iolink *sub_type_hdr,
 			uint32_t proximity_domain)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kdev->kgd;
-
 	*avail_size -= sizeof(struct crat_subtype_iolink);
 	if (*avail_size < 0)
 		return -ENOMEM;
@@ -1981,7 +1979,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	/* Fill in IOLINK subtype.
 	 * TODO: Fill-in other fields of iolink subtype
 	 */
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (kdev->adev->gmc.xgmi.connected_to_cpu) {
 		/*
 		 * with host gpu xgmi link, host can access gpu memory whether
 		 * or not pcie bar type is large, so always create bidirectional
@@ -1990,7 +1988,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
 		sub_type_hdr->num_hops_xgmi = 1;
-		if (adev->asic_type == CHIP_ALDEBARAN) {
+		if (kdev->adev->asic_type == CHIP_ALDEBARAN) {
 			sub_type_hdr->minimum_bandwidth_mbs =
 					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
 							kdev->adev, NULL, true);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 00c726123207..402891a02a01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1031,7 +1031,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	kfd_cwsr_init(kfd);
 
-	svm_migrate_init((struct amdgpu_device *)kfd->kgd);
+	svm_migrate_init(kfd->adev);
 
 	if(kgd2kfd_resume_iommu(kfd))
 		goto device_iommu_error;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 330fbbb15d83..f7d09e0a706f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1131,7 +1131,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 
 		res.queue_mask |= 1ull
 			<< amdgpu_queue_mask_bit_to_set_resource_bit(
-				(struct amdgpu_device *)dqm->dev->kgd, i);
+				dqm->dev->adev, i);
 	}
 	res.gws_mask = ~0ull;
 	res.oac_mask = res.gds_heap_base = res.gds_heap_size = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 499db2099775..1fbc28c34c4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -876,7 +876,7 @@ struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
-int kfd_process_gpuid_from_kgd(struct kfd_process *p,
+int kfd_process_gpuid_from_adev(struct kfd_process *p,
 			       struct amdgpu_device *adev, uint32_t *gpuid,
 			       uint32_t *gpuidx);
 static inline int kfd_process_gpuid_from_gpuidx(struct kfd_process *p,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 3db9433f7aa5..6e2f52dba16c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1724,14 +1724,13 @@ int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id)
 }
 
 int
-kfd_process_gpuid_from_kgd(struct kfd_process *p, struct amdgpu_device *adev,
+kfd_process_gpuid_from_adev(struct kfd_process *p, struct amdgpu_device *adev,
 			   uint32_t *gpuid, uint32_t *gpuidx)
 {
-	struct kgd_dev *kgd = (struct kgd_dev *)adev;
 	int i;
 
 	for (i = 0; i < p->n_pdds; i++)
-		if (p->pdds[i] && p->pdds[i]->dev->kgd == kgd) {
+		if (p->pdds[i] && p->pdds[i]->dev->adev == adev) {
 			*gpuid = p->pdds[i]->dev->id;
 			*gpuidx = i;
 			return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index ed4bc5f844ce..deae12dc777d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -207,7 +207,6 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint64_t throttle_bitmask)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
 	/*
 	 * ThermalThrottle msg = throttle_bitmask(8):
 	 * 			 thermal_interrupt_count(16):
@@ -223,14 +222,13 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
-		       atomic64_read(&adev->smu.throttle_int_counter));
+		       atomic64_read(&dev->adev->smu.throttle_int_counter));
 
 	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
 	struct amdgpu_task_info task_info;
 	/* VmFault msg = (hex)uint32_pid(8) + :(1) + task name(16) = 25 */
 	/* 1 byte event + 1 byte space + 25 bytes msg + 1 byte \n +
@@ -243,7 +241,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 		return;
 
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, pasid, &task_info);
+	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
 	/* Report VM faults from user applications, not retry from kernel */
 	if (!task_info.pid)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5b67b14fd8be..9a46ba190ea7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -193,7 +193,6 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
 		struct kfd_process_device *pdd;
-		struct amdgpu_device *adev;
 
 		pr_debug("mapping to gpu idx 0x%x\n", gpuidx);
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
@@ -201,9 +200,8 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 			pr_debug("failed to find device idx %d\n", gpuidx);
 			return -EINVAL;
 		}
-		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-		r = svm_range_dma_map_dev(adev, prange, offset, npages,
+		r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, npages,
 					  hmm_pfns, gpuidx);
 		if (r)
 			break;
@@ -581,7 +579,7 @@ svm_range_get_adev_by_id(struct svm_range *prange, uint32_t gpu_id)
 		return NULL;
 	}
 
-	return (struct amdgpu_device *)pdd->dev->kgd;
+	return pdd->dev->adev;
 }
 
 struct kfd_process_device *
@@ -593,7 +591,7 @@ svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 
-	r = kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpu_idx);
+	r = kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpu_idx);
 	if (r) {
 		pr_debug("failed to get device id by adev %p\n", adev);
 		return NULL;
@@ -1255,7 +1253,6 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev;
-	struct amdgpu_device *adev;
 	struct kfd_process *p;
 	struct dma_fence *fence = NULL;
 	uint32_t gpuidx;
@@ -1274,19 +1271,18 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			pr_debug("failed to find device idx %d\n", gpuidx);
 			return -EINVAL;
 		}
-		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
 		pdd = kfd_bind_process_to_device(pdd->dev, p);
 		if (IS_ERR(pdd))
 			return -EINVAL;
 
-		if (bo_adev && adev != bo_adev &&
-		    !amdgpu_xgmi_same_hive(adev, bo_adev)) {
+		if (bo_adev && pdd->dev->adev != bo_adev &&
+		    !amdgpu_xgmi_same_hive(pdd->dev->adev, bo_adev)) {
 			pr_debug("cannot map to device idx %d\n", gpuidx);
 			continue;
 		}
 
-		r = svm_range_map_to_gpu(adev, drm_priv_to_vm(pdd->drm_priv),
+		r = svm_range_map_to_gpu(pdd->dev->adev, drm_priv_to_vm(pdd->drm_priv),
 					 prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
 					 bo_adev, wait ? &fence : NULL);
@@ -1320,7 +1316,6 @@ struct svm_validate_context {
 static int svm_range_reserve_bos(struct svm_validate_context *ctx)
 {
 	struct kfd_process_device *pdd;
-	struct amdgpu_device *adev;
 	struct amdgpu_vm *vm;
 	uint32_t gpuidx;
 	int r;
@@ -1332,7 +1327,6 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
 			pr_debug("failed to find device idx %d\n", gpuidx);
 			return -EINVAL;
 		}
-		adev = (struct amdgpu_device *)pdd->dev->kgd;
 		vm = drm_priv_to_vm(pdd->drm_priv);
 
 		ctx->tv[gpuidx].bo = &vm->root.bo->tbo;
@@ -1354,9 +1348,9 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
 			r = -EINVAL;
 			goto unreserve_out;
 		}
-		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-		r = amdgpu_vm_validate_pt_bos(adev, drm_priv_to_vm(pdd->drm_priv),
+		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
+					      drm_priv_to_vm(pdd->drm_priv),
 					      svm_range_bo_validate, NULL);
 		if (r) {
 			pr_debug("failed %d validate pt bos\n", r);
@@ -1379,12 +1373,10 @@ static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
 static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
 {
 	struct kfd_process_device *pdd;
-	struct amdgpu_device *adev;
 
 	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
-	adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-	return SVM_ADEV_PGMAP_OWNER(adev);
+	return SVM_ADEV_PGMAP_OWNER(pdd->dev->adev);
 }
 
 /*
@@ -1962,7 +1954,6 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
 static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
-	struct amdgpu_device *adev;
 	struct kfd_process *p;
 	uint32_t i;
 
@@ -1974,9 +1965,9 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 			continue;
 
 		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
-		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-		amdgpu_ih_wait_on_checkpoint_process(adev, &adev->irq.ih1);
+		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
+						     &pdd->dev->adev->irq.ih1);
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
 }
@@ -2283,7 +2274,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 
-	r = kfd_process_gpuid_from_kgd(p, adev, &gpuid, gpuidx);
+	r = kfd_process_gpuid_from_adev(p, adev, &gpuid, gpuidx);
 	if (r < 0) {
 		pr_debug("failed to get gpuid from kgd\n");
 		return -1;
@@ -2443,7 +2434,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
 		return NULL;
 	}
-	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
+	if (kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx)) {
 		pr_debug("failed to get gpuid from kgd\n");
 		svm_range_free(prange);
 		return NULL;
@@ -2507,7 +2498,7 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 		uint32_t gpuid;
 		int r;
 
-		r = kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx);
+		r = kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx);
 		if (r < 0)
 			return;
 	}
@@ -2915,7 +2906,6 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 	uint32_t best_loc = prange->prefetch_loc;
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev;
-	struct amdgpu_device *adev;
 	struct kfd_process *p;
 	uint32_t gpuidx;
 
@@ -2943,12 +2933,11 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 			pr_debug("failed to get device by idx 0x%x\n", gpuidx);
 			continue;
 		}
-		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-		if (adev == bo_adev)
+		if (pdd->dev->adev == bo_adev)
 			continue;
 
-		if (!amdgpu_xgmi_same_hive(adev, bo_adev)) {
+		if (!amdgpu_xgmi_same_hive(pdd->dev->adev, bo_adev)) {
 			best_loc = 0;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 31610b4a3e2e..8364d6614836 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1286,7 +1286,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	void *crat_image = NULL;
 	size_t image_size = 0;
 	int proximity_domain;
-	struct amdgpu_device *adev;
 
 	INIT_LIST_HEAD(&temp_topology_device_list);
 
@@ -1477,16 +1476,17 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	/* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
 	dev->node_props.capability |=
-		((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
+		((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
 		HSA_CAP_SRAM_EDCSUPPORTED : 0;
-	dev->node_props.capability |= ((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
+	dev->node_props.capability |=
+		((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
 		HSA_CAP_MEM_EDCSUPPORTED : 0;
 
-	if (adev->asic_type != CHIP_VEGA10)
-		dev->node_props.capability |= (adev->ras_enabled != 0) ?
+	if (dev->gpu->adev->asic_type != CHIP_VEGA10)
+		dev->node_props.capability |= (dev->gpu->adev->ras_enabled != 0) ?
 			HSA_CAP_RASEVENTNOTIFY : 0;
 
-	if (KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev))
+	if (KFD_IS_SVM_API_SUPPORTED(dev->gpu->adev->kfd.dev))
 		dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
 
 	kfd_debug_print_topology();
-- 
2.25.1

