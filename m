Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8D3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809DB10E1B8;
	Thu,  9 Dec 2021 16:52:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4A489739
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWntdTZ/H5eIIuiOnl9i5dS6VX5qgyezU6ioKPDGf8BqlTmfb4gl9p3r8NSCuWHVUWZx6Xs1ueYbzQ3YeLZrQOp+RbvXnmaBoC4dH1uQXHqNbMkzEzmPbQKtfPcB7Vy+yM+YGibSuNUXyxwniDoeFWPOPfcMk0pKKAzigV1WWj3aAjQPDejTCzPoUML5JNpIC7qxmmnw0c6ImRZQ2diEXwl06L5r+I+FCjaxh/IGyYu7mKURXwqi5GQ3WgI+RjroGTRKzDTqCEjaJO9vU5wrdfJLFtd+Kh59HhLWVqkVHbo6MtHLEF6R+nHXlY50XPTduElaJ+dNmm765iKFnyauIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb9mHgJ+whW5ugjFlFBtyDEg+KfF04k2Bui6n3uH1YE=;
 b=oXccUobgrAympM/3jvhdtO3R/wBaFZgu1dZIQ+OZ+u2XyG16Mmp9OwlnjpI45FczST6oR/W3MflPmOF+dFV3vG88FCKKaM8jBFQkn6U/noDsBxhbaUDBHIpmm2HZ0lgJemcVmNAxHPp56jLdCzojUGEYKcxTXJjvtTbthF9GIoysaUe/OPyJoPhP61NAf5P8oCh41fw+swz1ZslA7WZ59cghbHaGQ/SLvz/8WpFWrC1XT46/OUplh0j5eQnrXkQXDsGz2EawCVsPcKA2yBFdowIi1cxYRMSzESLzs0r1fbl/B9CgVITSHCH8kuXue1mt7tgwOWKaSYUpyRJntRAJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb9mHgJ+whW5ugjFlFBtyDEg+KfF04k2Bui6n3uH1YE=;
 b=PruONIJ0ESo5eJ0jag9n9Fdgvuzj+qDM9UlyJWjwRug6OU/Bc9y5IsNhLsrrepidy9Wx5R3tpzjE0+KR24dkzAkTP7d+Q5sCYdzNLacxeFCwBK9BBT/h9XZXivn//zyKo41XVrTbNIXzPuxOrFInwXghunPrf5UzvUyjvesK6fE=
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 05:26:03 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::ce) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 05:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 05:26:03 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 23:26:01 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <lijo.lazar@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix incorrect VCN revision in SRIOV
Date: Thu, 9 Dec 2021 13:25:42 +0800
Message-ID: <20211209052542.1163521-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da85b5a-762a-41bf-d239-08d9bad464a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4944:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB494423A28B2A670FABBB5080E0709@DM6PR12MB4944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fs1MsTGhbpIIGm+bF1Q3oAJUp3zdRSlHsmlHtQfDQBpCaUm1ccs6gImMIV3ni0LpzZvRlPsA7q+xCPUmMuqhM0hwJc4Ko7vJguPRj8+xuLkOr2bzl5hoC7MO6he3ZnMajJkippqSYijWOsB9IuSo/UTXGAdc6LWlMKfwYOTbY/u0RWGC2UlngHCv+jMK2jiqYPnxFBvP3pK773ko4iRKjJP7LFOFTMVOb0BK4Gx9GQuig+lIqtdYE3I42k9hzoGHSnH1Va/iWiVfkXplj299dApXB0ZfHyc4VnP6/n17QV+BbSB9+P+uXZp++cFjq+MeJfB1V0IXgybxpyr698NGJuKhTimT5g178YK9gZFnMKlU8yxKDbnvhxWnWGFZivtx8Jw/5rQAXf74wZphtxjtOMzbxOWB6zjPzOrHBcKfChEU14N17STyceOPwJUn/F4gO5RbJr1imOk6c5O3iOQ4dbRK3tJka7tyw2RIcp888aFB8yp+zVGmCSf9uriijSThjHLbRCWXy8wYM/wSWMDx602rubdtcdUXZ4fPpsGXhhYgGduutLlUmbAfS4mDvh/iUHomeWZRcRaygYn7E/YHHC/xrXl3quYM5EZvLxfPvqoWXXbZzuGuCBBCqp3Q7bubbD9Le/uSz5inEOAxIsEd8Wm6wXIZoSwjoQ55Gjbe9z7qhuT31IAM5ikodr4E1FqreU9JX8hwTaoVLShW7DI4BqVCrWoKRADRU3Hqyr+ntnBuX+qR1YE767R2VwM3A1SG4HcdM3+VffM5ORoltKNuAME3UDGWlpmx0s9xr8bZqVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(110136005)(54906003)(83380400001)(81166007)(2906002)(2616005)(336012)(47076005)(40460700001)(426003)(356005)(8936002)(316002)(8676002)(26005)(82310400004)(70206006)(7696005)(70586007)(36860700001)(186003)(16526019)(5660300002)(36756003)(4326008)(508600001)(86362001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 05:26:03.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da85b5a-762a-41bf-d239-08d9bad464a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com
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

