Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA2DC48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 07:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798186101A
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 07:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798186101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3579E6E20A;
	Tue, 15 Jun 2021 07:46:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CA76E212
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 07:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah+KxZ0LDR2BEEJ0qMLiCrQt48YDIzion9+bcm6yl9OmUhsrLZThFsO2G9UEOE6eVRqz895MPFgbu1+xt8F2t8bAH/+a2wwLE17moQayM20lG4q03hSppgdvhOXfxQm1xghVnC7dIi69N2Mbg04vLdm/i4NPYCO+5fNHTIYowxjeLWZ/RFjWzaIXp8gKAOJWeZe0RVUFg5KiYKg1rnC4YwjuTVv5zePBeFwN+q5GxnegWvp+NgzKz0heF/OnpU86Gxl8p8rt7Av1zXsBZOdwA2Z9QSL/G6U1wIFKTXxu63WLGyh7kgTRA43GXHNebNZhlikpUrmqBs5aMbo5uwtoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCDxTh5j7SE/P6IuUXoj9CzuDQp+Zv2UXtEdl4ihazA=;
 b=WVtcoaRxNDHfEXoZFTePYe+jPV3KfLQAg2iopCapt+FTbird+ArJYjPlT+r9GNPFLhK1CmK5x8zBXmZwwf66RVJyFcnLHUhJH4AwxxpifJ1t62//6e0E87L25GysqT9rD22Ib6jYgBmOPaFiaFSVXz1PeeNUCluJtQPpgsPP8VD9sju4hDKPkz3H6SNSzevxxN/0decbZrOjRg1fC/nyFlVK0AtvrieFNAxC919hxhAUCpOUrldbpPLoy3UHHV7zKX96y3lHY4g7rJ+Wh2V4rGYTXWBY32S3TFdYrLiGfJVj/1dWqCrZJWbBBo38QpTgjZm6oqf3OH7MP969TtYhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCDxTh5j7SE/P6IuUXoj9CzuDQp+Zv2UXtEdl4ihazA=;
 b=11yv53vDN52a7jXqsoLMODZgt+Y9SaRyypIAXE+IJGtPbT+OfventQx8vZOyEpipDT0slNnSCWYHro7d80u2VMgH5jSLhfVl3xoMdX+ChlJ4fyP6xhVujS03vU3NJaahYjrva9gd8aR0QLouoHpqcF9jBskwc+Xpca9XWgWH7Rg=
Received: from DS7PR03CA0261.namprd03.prod.outlook.com (2603:10b6:5:3b3::26)
 by BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 07:46:41 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::5c) by DS7PR03CA0261.outlook.office365.com
 (2603:10b6:5:3b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 15 Jun 2021 07:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 07:46:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 15 Jun
 2021 02:46:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 15 Jun
 2021 02:46:40 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Tue, 15 Jun 2021 02:46:39 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/amdgpu: Use IP discovery data to determine VCN
 enablement instead of MMSCH
Date: Tue, 15 Jun 2021 15:46:32 +0800
Message-ID: <20210615074632.31507-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43dd2938-aea1-47a5-e77f-08d92fd1b6dc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB36406ABDD373D9B4F1BDC7C7F8309@BYAPR12MB3640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6FkrFUi4vWNAdFDBD1kMjauIMoCs88pMXoArVfI25uaClOfdOlLsTN59V57dgldhQBtz1RJXpCXT8sj18fq9I5jMR3PYTZspGAwtKpUkyfpr6mjxOHS8555cfVWSRFD3+OR2VLZT/DR/EdRM/QV0VAOsjf/9wEQCIpliToqg27B1e8+4br+Xs6BSEdDhJpvt7BkvcS3YIjTRXp/dao1cer9maOkU20vn1eGYo3E0hllEDPOs2qs2RoWW1X3P3pMlxE7yOVSfrqAfPx0nOFSAZ1k7MjvzZlVBqWBSVSWVC6OqZee6APvZKBUTxUHavXKuBW35QFUzi/5+nrWtNo/D5cU5YSD8fJ33XbSTX9JYzaolG45bXPwCvNaRgP+MBk4CXeg7ghAjp9AUprIhdB6olYQAZJERz9ntVGIbl3tnjmGb88uIe4eXQY/hpxBUGFBFQzmjoN+7O5aFy8OWdxtz8b9RprFUv5o0QKca8OUnqLXDFoMUyFZflHm+oQ3kWhC6ZMSvY6p12K4AJHmzXru7LVstfUuKrOr0ihWIZJoJZv44d0/vpiGsEQmJ3HQuHyT6StWyOh07iec8Tze9QEk3Kmx085P9qgP4cpHBTBX60JvnHg5zB8Zw7iLtUIiAd1y1l8JPmYpDT2/Qv3Ke6nv24+DI2TT73MAedH9aCqRE3aglgVB/c8MrWZ6NZCb9Xnr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(186003)(81166007)(36756003)(8676002)(426003)(1076003)(2616005)(36860700001)(26005)(2906002)(336012)(8936002)(6916009)(356005)(82740400003)(6666004)(70586007)(478600001)(82310400003)(7696005)(83380400001)(316002)(70206006)(5660300002)(47076005)(4326008)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 07:46:40.9698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dd2938-aea1-47a5-e77f-08d92fd1b6dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3640
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bokun Zhang <Bokun.Zhang@amd.com>

In the past, we use MMSCH to determine whether a VCN is enabled or not.
This is not reliable since after a FLR, MMSCH may report junk data.

It is better to use IP discovery data.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 23 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       | 13 +++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 52 +++++--------------
 5 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f949ed8bfd9e..e02405a24fe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -373,6 +373,14 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
 	return -EINVAL;
 }
 
+
+int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
+				     int *major, int *minor, int *revision)
+{
+	return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
+					       vcn_instance, major, minor, revision);
+}
+
 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 02e340cd3a38..48e6b88cfdfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -32,6 +32,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
 int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
                                     int *major, int *minor, int *revision);
+
+int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
+				     int *major, int *minor, int *revision);
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9492b505e69b..84b025405578 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -287,6 +287,29 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
+bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
+{
+	bool ret = false;
+
+	int major;
+	int minor;
+	int revision;
+
+	/* if cannot find IP data, then this VCN does not exist */
+	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
+		return true;
+
+	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
+		ret = true;
+	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
+		ret = true;
+	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
+		ret = true;
+	}
+
+	return ret;
+}
+
 int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
 	unsigned size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bc76cab67697..d74c62b49795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -280,6 +280,16 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t pad[30];
 };
 
+#define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
+#define VCN_BLOCK_DECODE_DISABLE_MASK 0x40
+#define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
+
+enum vcn_ring_type {
+	VCN_ENCODE_RING,
+	VCN_DECODE_RING,
+	VCN_UNIFIED_RING,
+};
+
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
@@ -287,6 +297,9 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
 
+bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
+				enum vcn_ring_type type, uint32_t vcn_instance);
+
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ce3c794c176f..a79ae86bc752 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -85,9 +85,12 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v3_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
+		for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
+			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
+				adev->vcn.num_vcn_inst++;
 		adev->vcn.harvest_config = 0;
 		adev->vcn.num_enc_rings = 1;
 
@@ -99,7 +102,6 @@ static int vcn_v3_0_early_init(void *handle)
 	} else {
 		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
 			u32 harvest;
-			int i;
 
 			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
 			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
@@ -154,7 +156,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 
-		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
+		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
@@ -324,19 +326,17 @@ static int vcn_v3_0_hw_init(void *handle)
 				continue;
 
 			ring = &adev->vcn.inst[i].ring_dec;
-			if (ring->sched.ready) {
-				ring->wptr = 0;
-				ring->wptr_old = 0;
-				vcn_v3_0_dec_ring_set_wptr(ring);
-			}
+			ring->wptr = 0;
+			ring->wptr_old = 0;
+			vcn_v3_0_dec_ring_set_wptr(ring);
+			ring->sched.ready = true;
 
 			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
-				if (ring->sched.ready) {
-					ring->wptr = 0;
-					ring->wptr_old = 0;
-					vcn_v3_0_enc_ring_set_wptr(ring);
-				}
+				ring->wptr = 0;
+				ring->wptr_old = 0;
+				vcn_v3_0_enc_ring_set_wptr(ring);
+				ring->sched.ready = true;
 			}
 		}
 	} else {
@@ -1303,8 +1303,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	uint32_t table_size;
 	uint32_t size, size_dw;
 
-	bool is_vcn_ready;
-
 	struct mmsch_v3_0_cmd_direct_write
 		direct_wt = { {0} };
 	struct mmsch_v3_0_cmd_direct_read_modify_write
@@ -1496,30 +1494,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		}
 	}
 
-	/* 6, check each VCN's init_status
-	 * if it remains as 0, then this VCN is not assigned to current VF
-	 * do not start ring for this VCN
-	 */
-	size = sizeof(struct mmsch_v3_0_init_header);
-	table_loc = (uint32_t *)table->cpu_addr;
-	memcpy(&header, (void *)table_loc, size);
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		is_vcn_ready = (header.inst[i].init_status == 1);
-		if (!is_vcn_ready)
-			DRM_INFO("VCN(%d) engine is disabled by hypervisor\n", i);
-
-		ring = &adev->vcn.inst[i].ring_dec;
-		ring->sched.ready = is_vcn_ready;
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			ring = &adev->vcn.inst[i].ring_enc[j];
-			ring->sched.ready = is_vcn_ready;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
