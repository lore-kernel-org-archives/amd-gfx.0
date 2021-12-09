Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33423C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3538A10E8C5;
	Thu,  9 Dec 2021 16:53:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D6010E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 08:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDdQyvjHGX9tmQP+cES+MjSUkFYaNmDCT09HHqBbq0rquEsukU0/DakwQPSkUCSxr7mqNldWGkVaIWx8daqpdecE2vp8E3S1ZaD8O+Nqq7UkXZMce9UGJa6v5T3VLz7Y5/vdLoTbl4iiwUWBXakVQ9Wuo78bdPlxBDDDTEGppqNlcjt8EDx2jKQ9pYmdZxeovk5q2s9bEvSWBLj3l2yHmd0aMsi2pX+b4T/4q/N9GslwEFitOfQcgCa8+3Eg0KlVh0lx+ogW5wwe/oWrzMnA47qDN4CsP6mfYaE01ye0MHN/J5T3MBUT4fH9TR3PBtGHm1iMp5y2/sczmuMxoQZo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7rJ0J4Z2GYcnPCeQQwym/zT+SQt0O405mEDuy8+8uc=;
 b=SwQoqdRCy9INzJ7hKtEM8OWmizZAJ8j7DuKyD7hEzhE3+NPhrKUpYp+ucstPfoy8JIMNY71LM2wNRIpu+/dVktt3tdCnskH4J1T3Ci0xLIBwE0g2/KeBmCNZi8XjJBvHldopdjiVbSRnftGC7Ofid1o848bFuo8NG7HXzjq0ARAC+Pk/DcO/TW5BzLU0xQw2EcVwbeMfHBD+Lzg30GICynpB1uZEZT4gcVW9nlBfdkMIdA8gdFYTKC8SpoeXYeeeR8sl3PxBmKYXESuvcbMLi5veliVuNF3DmcJleJBpmc0u9fZ3fSbrh6fDO1Kc9i09YP982QMHQNXrsxiVC9sCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7rJ0J4Z2GYcnPCeQQwym/zT+SQt0O405mEDuy8+8uc=;
 b=PpYfQmALNhl7B6kmUIwXSHfWMJK9iZhVxKRXrqW5AYcaIF6LCEsgA0UPOH3zu/osWiTbevhbm1JPVqUBuzNiRKcQB5hq43OjK40jrTiBXGfnAvkF5UkCohc/30NIdIbCSSPTJrXr3kL/wjXKVwMy+PwHr7x6Fij3e6uGCkH5pNs=
Received: from BN0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:408:141::12)
 by BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 9 Dec
 2021 08:27:02 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::90) by BN0PR07CA0001.outlook.office365.com
 (2603:10b6:408:141::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Thu, 9 Dec 2021 08:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 08:27:02 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 02:26:59 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <lijo.lazar@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: fix incorrect VCN revision in SRIOV
Date: Thu, 9 Dec 2021 16:26:39 +0800
Message-ID: <20211209082639.1296627-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 984f0260-88d8-4fdb-78f1-08d9baedacf4
X-MS-TrafficTypeDiagnostic: BY5PR12MB3844:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3844BAFB62B175BC6048161CE0709@BY5PR12MB3844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hP27rz1MSf9IcKEmEOC+j0cwFa31Dc09n3nnmz6Bg/yIRs3OOiD2Dtv8NvhpgfRVWZFZIbDpgo8doptdanyzyo1kSDkD74c/MSmBc/WDnbxyFBF5QaNBulWFz5zX7ChIHcg9PFA5iqO4nlKqt08bdVhWz7AIVEEKpPscbQvRKXXr1/hx/97kZdzEJJQEfxgs5HE+ZU1rcVpvudyTQZV7jhx9imslOFPq0JNAP+/+tCoTzODvEkdQsLpcx2Z1/hDSPzj1d/wiL5EVmA8qIQJ9N2KpU1QgvEP9BsS51CunNvbVBj5oDbUnYWCJK3cNCSjS9NgdK1wptSYRD8adS/UXosEN9tyRKDnZX6XCNzSIf4c6i2W9/URnPWhK0JpZlc22jn9lkE5D4avXLRIveY6n/7cA/iTzCOdVK2PHo/Lmg8Ep5ayAQ0vbe5l/B1X96V3AsQZNy630rb7Vb3WrO2R8td+5MSQjo2E4e1m6Z9BsqCDxvcaThX3tS9yWbDr/uAMmzUxhlucDHATww1W8pQv6H0Rb2rux7HIwW6B/VK4Erv4FIccr/UuNxxi2SuEvs1HrYnOBXfmiZSvGM7c8fXiV3mx/X9zZUC7c53EwTjc+oZKcUS86EwOiLjOt9PjytlBFH7TR/rO3mV7gLJU+FMvsIDasLPqFnEPkdL87osYhZk3OpTxnCfkh3rIBoRl9CFlWxpzqtC2ZltYDFRHiVZppJMOV68WYZ5hIcLnhdmed5CbDYRxfDgwSHdRPmH32+GkAyPXW8VJG5WstmRbk8s2zR4xYT0dhBaJQDXUHTW7aSAc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(16526019)(36860700001)(81166007)(336012)(36756003)(7696005)(6666004)(26005)(83380400001)(86362001)(110136005)(54906003)(356005)(70586007)(40460700001)(5660300002)(8676002)(2906002)(426003)(508600001)(316002)(70206006)(1076003)(2616005)(47076005)(8936002)(82310400004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:27:02.0729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984f0260-88d8-4fdb-78f1-08d9baedacf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3844
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
v3: modify VCN's revision in SR-IOV and bare-metal

Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 29 ++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 15 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  2 +-
 4 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 552031950518..f31bc0187394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -380,18 +380,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				  ip->revision);
 
 			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
-				if (amdgpu_sriov_vf(adev)) {
-					/* SR-IOV modifies each VCN’s revision (uint8)
-					 * Bit [5:0]: original revision value
-					 * Bit [7:6]: en/decode capability:
-					 *     0b00 : VCN function normally
-					 *     0b10 : encode is disabled
-					 *     0b01 : decode is disabled
-					 */
-					adev->vcn.sriov_config[adev->vcn.num_vcn_inst] =
-						(ip->revision & 0xc0) >> 6;
-					ip->revision &= ~0xc0;
-				}
+				/* Bit [5:0]: original revision value
+				 * Bit [7:6]: en/decode capability:
+				 *     0b00 : VCN function normally
+				 *     0b10 : encode is disabled
+				 *     0b01 : decode is disabled
+				 */
+				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+					ip->revision & 0xc0;
+				ip->revision &= ~0xc0;
 				adev->vcn.num_vcn_inst++;
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
@@ -485,14 +482,6 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
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

