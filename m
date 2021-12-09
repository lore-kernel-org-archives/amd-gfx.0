Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FB6C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C195110E414;
	Thu,  9 Dec 2021 16:52:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF0B6E5D3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+ACJtU3oROe25AO1tZU5hSqkj7i1EWTjB+F/qmh/V3e2rKTAcxLsTU2Pye3T8IScF0ul9AALKggfZQYGj9xDsdvTb05+DmEKncJUwo5VWsBW5xUe/KBP5CFOSbTqP2SSMPXh3haEm/ECqhbzSaCOOZ1gtn64FU0LPnj7sKHyK5oq8+dH0cxPsFvk7z0KMwGkAGDzem90D1OhFjGQyrdxZTy437bvo7qUeumAB4RLxuXmPQNEPtWOOQmKYB3YOxAuUnYfjZAyvedDG6Wp7Hi/6A+XsHWuMdRWWC/0nlWRfTr0eCbWfI4E3m2euxRh2Z5lTMcwCquB8MCcjogmsJERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb9mHgJ+whW5ugjFlFBtyDEg+KfF04k2Bui6n3uH1YE=;
 b=BLRJVSZNByt3HwnIjrpxn43YUVOoSP3b5QCuT5gNdmvRH4Z2M0h3SMWWN9NBi4nTjBqfnN9s5WtdqTztQrd+48vTPJJxH8BF+9Cy8Xjg2xcFRZw0XAZ4MOP9kOH5MRyEFlIez8IVB04TvC2O8ttm4ccQfs7NU5PlpeKaDPFoPjHVRz+ViZ9gr6xKBGLaSzX78D8m7JR4lVqG4oIkPqIyM/H1nHScyZwWUD4r6wEVi0N2dN8Y4t+aMxfW1vlBxQ5P1z2lOl2XEmtchh+o6aPQ2AY/2QwhttYE7qPT5XU4Ebn2bgMxi9C0x9X3b0MJAKqjyHxdIe0abRJpwVsm2+n7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb9mHgJ+whW5ugjFlFBtyDEg+KfF04k2Bui6n3uH1YE=;
 b=KHTGedtn7+UsyKtrVAR/L51Q1/u2NiNNP6gBjxkn/+uQoA/wby/VEQo73SKXyagZY/Ve8z0bnV9zA+9LaS2fad+FFvUR7ZwAaSPuV4xkbuseObD5SbkAkDmrgjsE1bLQjFJGuz5fIoRk6XJSoC2MDirrsCfM+eeI2zobIQHOKSM=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by MWHPR12MB1295.namprd12.prod.outlook.com (2603:10b6:300:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 05:18:52 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::5a) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend
 Transport; Thu, 9 Dec 2021 05:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 05:18:51 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 23:18:49 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <lijo.lazar@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix incorrect VCN revision in SRIOV
Date: Thu, 9 Dec 2021 13:18:22 +0800
Message-ID: <20211209051822.1163450-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f60c0508-e331-4666-75e6-08d9bad3637a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1295:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1295AD312C1EAC2972D4EAADE0709@MWHPR12MB1295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVBFf2lxaf48WlfHZTdTCSoRACnPmMs3AU/YVmUt98hNiYO5i5p6FF9YHZeGJAle4u/pYFayZ9yDxyyIfVKdhxZqhIMyOh0xySkyperMQX7y+0iuMGW8+4gRgWC7e5Y9h6NlGihpdnljWIOM11zDu8YDLW5hfbWypwh0+gk+kwTY3ht3kOhiPjzDM/w1xiuVcwQR1r5L/LoE+oF8dDjUEUUSSgN5d+/tzbO88N8E/KTi6eIZGjx4XStnR8PPel6ib96oEinDSwu7YABKRt0LLwAVwx0FWBRP090gxfQjBNvNTUnd2KzvxmZgC+mY0K4V4pU9ezcOcYkH4Vew6Z5Aaiy1Bl5LEK2P/gea625S+XNosGauzWtjE3wkz/Tgr7h54Zq0eb6l48Z0IEsedc+kFMvAb1V7Xntr2jrENb0nRbsmQhMVkNfGZg3g7QtCqAp03YSvgGqBO3XgewM79NAEeHVVPR2UA9CpCGZnKv6T0MzLZG+GzAQ/uv4ypsucG+WYCP2MS7JYw1Y+GMEj2l24niZzSVZk6txbtlvscvDHsASqxnvpz4SBPccEUPxgmbnSh/aQhNHezzeUaxTQjNznq2uspZWqvuvYE+NuEeTw2pxsI2egnP1xNRb2WYjZ/Pf/0C0lZa1CwVllj1z5EmITc/rk7o+rj0bpeY6Y3lH4vbJ6PPBwlZ16D+tfg9mkLrxfPDjlK+FSoqGWWr3WFI9WGme137NXfAUcsV32WLGTNUYZCbfX7kfu4KYOkBd13pBiNGMM/ITqLMP1QLqaIbw2ws7Il5z/KJRjDfhklKruuZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(2906002)(26005)(7696005)(110136005)(8936002)(82310400004)(40460700001)(36860700001)(316002)(83380400001)(81166007)(54906003)(4326008)(356005)(47076005)(336012)(186003)(2616005)(5660300002)(86362001)(36756003)(16526019)(6666004)(426003)(70586007)(70206006)(508600001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 05:18:51.7909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60c0508-e331-4666-75e6-08d9bad3637a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1295
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
Cc: alexdeucher@gmail.com, yuliang.shi@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Guest OS will setup VCN instance 1 which is disabled as an enabled instance and
execute initialization work on it, but this causes VCN ib ring test failure
on the disabled VCN instance during modprobe:

amdgpu 0000:00:08.0: amdgpu: ring vcn_enc_1.0 uses VM inv eng 5 on hub 1
amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on vcn_dec_0 (-110).
amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on vcn_enc_0.0 (-110).
[drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring test failed (-110).

v2: drop amdgpu_discovery_get_vcn_version and rename sriov_config to
vcn_config

Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 15 ++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  2 +-
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 552031950518..53ff1bbe8bd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -380,6 +380,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				  ip->revision);
 
 			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
+				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+					ip->revision & 0xc0;
+
 				if (amdgpu_sriov_vf(adev)) {
 					/* SR-IOV modifies each VCN’s revision (uint8)
 					 * Bit [5:0]: original revision value
@@ -388,8 +391,6 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 					 *     0b10 : encode is disabled
 					 *     0b01 : decode is disabled
 					 */
-					adev->vcn.sriov_config[adev->vcn.num_vcn_inst] =
-						(ip->revision & 0xc0) >> 6;
 					ip->revision &= ~0xc0;
 				}
 				adev->vcn.num_vcn_inst++;
@@ -485,14 +486,6 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
 	return -EINVAL;
 }
 
-
-int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
-				     int *major, int *minor, int *revision)
-{
-	return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
-					       vcn_instance, major, minor, revision);
-}
-
 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 0ea029e3b850..14537cec19db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -33,8 +33,6 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
 int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
                                     int *major, int *minor, int *revision);
 
-int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
-				     int *major, int *minor, int *revision);
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2658414c503d..38036cbf6203 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -284,20 +284,13 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
+	int vcn_config = adev->vcn.vcn_config[vcn_instance];
 
-	int major;
-	int minor;
-	int revision;
-
-	/* if cannot find IP data, then this VCN does not exist */
-	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
-		return true;
-
-	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
+	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
 		ret = true;
-	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
+	} else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK)) {
 		ret = true;
-	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
+	} else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
 		ret = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 938a5ead3f20..5d3728b027d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -235,7 +235,7 @@ struct amdgpu_vcn {
 
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
-	uint8_t			 sriov_config[AMDGPU_MAX_VCN_INSTANCES];
+	uint8_t			 vcn_config[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
 	struct mutex		 vcn_pg_lock;
 	struct mutex		vcn1_jpeg1_workaround;
-- 
2.25.1

