Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196CAC2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 07:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6B1613CB
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 07:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6B1613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E246E899;
	Thu, 17 Jun 2021 07:46:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7183B6E899
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 07:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mctqCbEDdhzd4dwi5At9GxYuXpYhit8O6YSOjaCy0lDqnAtCbW6tO9sYUYtYA7Z7CgcIQfsx3Bv0N26ZyqFfeifreB4y9zeLxbuooof03sLZFvMJJ18A8lybWfNuulz+1h4Ej0/IMrCvvmDJ6FpmE+SDo0N7hbBwLUJhBFjy6kY3SuP+WnnZ9AB/N4Rs4oEA6OqJdrmcwzV4s/SYx2iQ4TMsXrZw3ddNxTLdKTvUnQdr/mH2Sa+yekCrsp0XsBchBFjHymZBgEFz3hFjDpXeAnH+vYUDQTr3UCcFz0ThkX9ZLRUxQOnTMqJVn7hLC7zJuRn4lwj22TMcfLQ4os/BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEEZLnYzH6qsp2mNAsASk7iEOh120tzR+PPebSfZeGw=;
 b=Y6Nu750lj3ZeME+h3QsH36sV+0gI1iYGNVGcHfETj1nCmYczbtvvFUH86lVb5PD1chK8HFseBUiXzb39QNtaccQlyosOCmXIacjLaIHTcIr5LspOvuq8QB80sYTkPFUwJu7HoLpbvjXPOzU1pcwvGxLXv7Mirnf3TlpBxd+c/PvsJEssdlJ2uTsXQafVhh7nasQsPefrIn2vB7uUxc0v/iE0uR3riWo9/xQH4cHyNhv/12OrUoietuoIR6E1ZO+TCSnpdR0i9AElw97cgnGb+WoQkFOfEbeNexWWr/hKoV6wl6lvyF4cVpbwnQFpDG3rIL73YyOHxZEmN2jwmnLNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEEZLnYzH6qsp2mNAsASk7iEOh120tzR+PPebSfZeGw=;
 b=OJzJCcjJruSnAzLRI/U4MV909Zm2gA7VMdM5QZnM1MwogyEdWthQCBZs/vTVmuIoA0fByny36/pnZIJ9XQQOrzMvRendEFyYp4yXaWRIQjbBYMU2GwZhGtO5PZQNJqPwHLbhqYVHf7J5nTvWRoJwt6f2JY3WdbyVhHNW7S+njWU=
Received: from MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14) by
 DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15; Thu, 17 Jun 2021 07:46:13 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::7) by MWHPR10CA0004.outlook.office365.com
 (2603:10b6:301::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Thu, 17 Jun 2021 07:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 07:46:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 02:46:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 00:46:11 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 17 Jun 2021 02:46:10 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/amdgpu: Use IP discovery data to determine VCN
 enablement instead of MMSCH
Date: Thu, 17 Jun 2021 15:46:03 +0800
Message-ID: <20210617074603.11417-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a722e5-7e6e-47a2-43e3-08d93163fab4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB185014D2A8F647835F44D574F80E9@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUV5SP78rGBvJ4lW6uqvsqZU3JN56l9Gg6wg/9mIG7bxZ+hJ3UFTVDk34kV1xY5hX58I7F6CpM33Z2d0SSHHcMBtMK7EyolykUatS2ZmmLGTr0PllcaPTCtuKoTpCOsOxOw4o/S1NORd3c5SH3R2i6qMVinLH5jddYQOAjhlFpKBCfDlxNIOj26MgOEvgjxL5bUepZXLhutgRt6pw9gvxo7SUBlRsQV1JgAlIKR3jiNFCI9iJiXX0M79NJhtwivpiSMiXapxN4W5GflTtzLDiR26XLgblkWamx8meKz8MThJsRNDhnBoqUPBeyOFFIDSeORo8EjLk6lh5thSM5z3zeRyNdGSpoF2ck3WGqkaNq6WUvNVfNwqd2J/qqFmkrgMcUZlFewQjnMx4lxzSR8VtZzBA+L9m4yddCAXQh0EZqI1tA2/8B0Nle0Akz8g0WyM8fB1HNabT6TR5Ooi/o4PTsnBZG+cYx9j0gNbP9/jUSaX2aOjnQm+MKirH04eT97/D9SgvoNqM+Q8BxF7FDgycEaT2UOGr2rOOyvslb+wWHJoXYLMZCSb+5C58qFa2tJPCW5aUG+qRl4kbGu2wzcUyUjhuVV0iN7LMj+YXiTrTqxXO2VpR5aIQkE08cWbatmpSnbuRCN3qWZEIzI14D+Ihw1tTUTQtIeqauniKyC8+YLhxRm7vGpUH8wTS+WbPIvF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(36840700001)(46966006)(81166007)(478600001)(356005)(70206006)(83380400001)(7696005)(26005)(8936002)(6666004)(82310400003)(5660300002)(36860700001)(1076003)(70586007)(47076005)(4326008)(36756003)(336012)(2906002)(8676002)(2616005)(86362001)(54906003)(82740400003)(426003)(186003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 07:46:12.5687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a722e5-7e6e-47a2-43e3-08d93163fab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 53 +++++--------------
 5 files changed, 61 insertions(+), 39 deletions(-)

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
index 798b6b4d8f46..c3580de3ea9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -85,16 +85,18 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
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
 
 	} else {
 		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
 			u32 harvest;
-			int i;
 
 			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
 			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
@@ -149,7 +151,8 @@ static int vcn_v3_0_sw_init(void *handle)
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 
-		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
+		if ((adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) ||
+		    (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)) {
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
@@ -319,19 +322,17 @@ static int vcn_v3_0_hw_init(void *handle)
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
@@ -1298,8 +1299,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	uint32_t table_size;
 	uint32_t size, size_dw;
 
-	bool is_vcn_ready;
-
 	struct mmsch_v3_0_cmd_direct_write
 		direct_wt = { {0} };
 	struct mmsch_v3_0_cmd_direct_read_modify_write
@@ -1491,30 +1490,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
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
