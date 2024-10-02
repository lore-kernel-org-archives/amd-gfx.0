Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44948CF3198
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 814EE10E686;
	Wed,  2 Oct 2024 04:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pBDSDNOn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B47210E68E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbkhfm71LXVv1yZa+NE/e9JlVYqnYWCpljZz5JQEx5RqB1ErqDiM9mkAErgSqAHHOi6i4aeQ9DVpACkx0ePeOP6Ql0concHDcE4tA6fKTqoWGD362XohS2SgGjpV+nJ/nL2xw0gFDS/5sB9y5lfnHYEjqjlwRGQuocKSFCgpkPDeg0dGDcFixu9D24W7/j5g5Qc6jL4/aZAu/m643oeMVrmMS97BecxJxARDS8l2a/Uc5xpPfUJVR6cOjHsO9qtxd/k+NLhBb7l81Y6LScB4eWWxEUGw9ocbVJQtUZXGe3Zf4phXYhsO+MwoGqzhhu/F92196DUXs+Nt4d3FYgdlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoi+OY5+8mPuZiylwuqjhXtY3BjlvoDpEqRc3kBz1Bs=;
 b=aB3tRIYoZOHreaD2Cpjpnx00hKpAurwU1zkUgrQWnvq6wUJDG3961LLgWbFP19S1xG1AipMdVxBcndwoEoSxMp7BU86ejJnJX3wrJ7izm3+62cSZ3rEwxuCq12dAYQwmv20asAkfOqYbRY9CRgC+fqLoclDYUMr8bRtZ42GC5yLZV66fjRMyOavJWvLg4Gh6U6X97eiFBbfcg6etmEJ/U6Qbe9lcAAxFBJ0nclyNs+ndhUwTDEQ718YolBVgl3Mh9HKCyYk91rQOnI29NxED9GCkWervSWaFO/EZYkGf7zAyPQ5hVaafD7Aq+g1/enSllD7xu89465ShDsffObMk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoi+OY5+8mPuZiylwuqjhXtY3BjlvoDpEqRc3kBz1Bs=;
 b=pBDSDNOnX+I9ERhpBeE2npr53uMkwvNM5V7x/YRxTLAGN5uCC8IWbi+iM4C5Z8336QV0kloa4Z8uA0OJasbYRzE/UjIlnK/WJ7M0D/a8PAdTwBE6ccG+ogQIhawZBVJ3WFUJd/LrchjONXFl7qdE6OM27GDnpmNSKq4Mnfr5Yvk=
Received: from SJ0PR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:334::23)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.27; Wed, 2 Oct 2024 04:38:56 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::b0) by SJ0PR05CA0108.outlook.office365.com
 (2603:10b6:a03:334::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:55 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:50 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 12/18] drm/amdgpu: power vcn 2_5 by instance
Date: Wed, 2 Oct 2024 00:36:21 -0400
Message-ID: <20241002043627.102414-13-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: b72dec07-9464-4883-0c03-08dce29c1ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|30052699003|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ty5Lwa9KEd7YTowNxuF/oST3CflBwp5ieJeiUXgz+qKnKLAjTpXwArKCcUwD?=
 =?us-ascii?Q?FpXe2Nhsr/IBNeTAgvszy4W80SDy53JZEicOUVH6KzTaty0WD3X1c210JTVh?=
 =?us-ascii?Q?u6nQI/uDx3hvMAk/hdpBJQbqP5WqMJPvjWigRVrecAoveR2rWFXwpYZh3IYp?=
 =?us-ascii?Q?W47cuMIqTSGmkH79psIKTkwfCsH/A2qUO2qBknFxSzoS+U5J3cAjUztIilVs?=
 =?us-ascii?Q?3LknCTMsBNFjEUA7CzieKH1FOOArV1MhkeGgtRxb5jK7TYIOaaEHyXJYDLFK?=
 =?us-ascii?Q?WSotBnSzD2xRVXLBV0tVBzG1yM60qpXZMSqeWPGlvXBLTTxUJcF2mZh5Ymqh?=
 =?us-ascii?Q?Guuj9V8cqkX4HMWYkefPFoCuy7dm7bzdCvJMAHmAtFAvicvGeit8Je6YbT2o?=
 =?us-ascii?Q?BM29jEpdiQoERDogHFpQOxBwmo9TgsQ1cBbUN5ubPozhAQsLDQdRg5n/NQQV?=
 =?us-ascii?Q?17Xkgtu3x+uX3BYlOuFbUr22NcsT+ZKV4XHHokhypqT3rBHtx4s/w28v+Jbc?=
 =?us-ascii?Q?bQgOTnczd4dQtv2idtGtSlk3+tFJ+1Pn1jdRcZfHKcNiMRQf2Bk7EMB+k20E?=
 =?us-ascii?Q?fozmSWsYKpLzSl3Fghl9Za94ZXJSG6CNNgC7haoMZblm7nBIZphw1m75uRdN?=
 =?us-ascii?Q?+YGpMC7a20k7ZE+9dC1p4+PBW3g4OugDhqx8BZ/yHrtem3msisQP+oWleYVY?=
 =?us-ascii?Q?9Bep5ka++Bqeu8OJxV5u0yxxVV+PPlCcjJ9wG6bsxbsFKKMZ1b4htGKVWt9r?=
 =?us-ascii?Q?juWgGwcuz3EliEsAnDjBQueb32XHGGe6GaPC6kMZy/QlKvo4vE0nKmqoj5O3?=
 =?us-ascii?Q?xvmKmQASZQvwQ83aTrAOaIdFVYVcw9fMWH4VFa/fJs3pKM3ZKPnrwAcS3F7d?=
 =?us-ascii?Q?xPmOqtq4arpRFLbLY4PIft7MVJhjb6ba+I2ol9Ce1inE0Ibjb/RavWE+54ZF?=
 =?us-ascii?Q?bcyR6F/URZAh1N955gti2JrhkSO9XNckRxXCyU7c5bC4d155NioN1dZr6xTN?=
 =?us-ascii?Q?c6S9XWEwjdgilM/pdNtNZYdZMj5pAfPYmTZtOCaY3ULB/MvRtasbwr8JVLQw?=
 =?us-ascii?Q?1V+zBEvBgwc3pYBvpk9cLWZGOe7fPsvG7njNw12+CVFVCzKFWfFZTXpet5qW?=
 =?us-ascii?Q?lX//nqYz/5ZaRQMgdbkDuTauW3LmReE4iSlXg0ByVAI3Bzjx7bj+5imv9TLj?=
 =?us-ascii?Q?X8UKY4SyjT0fCfQQyoUriAHNmZe6zDEGynlFmvZkHtS+Z1d6Oa3uq11z/MiI?=
 =?us-ascii?Q?lR78N46SputwDxqc0/f5kxDyIik+hoY7NF65O/KH3VkwpSICHCVeQsms6+um?=
 =?us-ascii?Q?xrMkNQb18H5d9w2Qw6/DUjf3GHnN/EZF+h7QZj9tYv7B5UBaQ+sZoQAEJXjV?=
 =?us-ascii?Q?rmJsT8PnCiuxbB1QEnByGxXxMlKN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(30052699003)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:55.6962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b72dec07-9464-4883-0c03-08dce29c1ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For vcn 2_5, add ip_block for each vcn instance during discovery stage.

And only powering on/off one of the vcn instance using the
instance value stored in ip_block, instead of powering on/off all
vcn instances. Modify the existing functions to use the instance value
in ip_block, and remove the original for loop for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 572 +++++++++---------
 2 files changed, 285 insertions(+), 291 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9f9a1867da72..6b9c974da0c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2278,6 +2278,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 
 static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 {
+	int i;
 	if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
 		switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
 		case IP_VERSION(7, 0, 0):
@@ -2321,7 +2322,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(2, 0, 3):
 			break;
 		case IP_VERSION(2, 5, 0):
-			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+				amdgpu_device_ip_block_add_instance(adev, &vcn_v2_5_ip_block, i);
 			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
 			break;
 		case IP_VERSION(2, 6, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index c69cd7f62f09..930c60616a43 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t *ptr;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-		/* VCN DEC TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[j].irq);
-		if (r)
-			return r;
-
-		/* VCN ENC TRAP */
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-				i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[j].irq);
-			if (r)
-				return r;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto sw_init;
+	/* VCN DEC TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
+	if (r)
+		return r;
 
-		/* VCN POISON TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
+	/* VCN ENC TRAP */
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
 		if (r)
 			return r;
 	}
 
+	/* VCN POISON TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+		VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
+	if (r)
+		return r;
+sw_init:
 	r = amdgpu_vcn_sw_init(adev);
 	if (r)
 		return r;
@@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
-		volatile struct amdgpu_fw_shared *fw_shared;
+	volatile struct amdgpu_fw_shared *fw_shared;
 
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
-		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
-
-		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
-		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
-		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
-		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
-		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
-
-		ring = &adev->vcn.inst[j].ring_dec;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
+	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
+	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
+
+	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
+	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
+	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
+	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
+	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
+
+	ring = &adev->vcn.inst[inst].ring_dec;
+	ring->use_doorbell = true;
+
+	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+			(amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
+
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
+		ring->vm_hub = AMDGPU_MMHUB1(0);
+	else
+		ring->vm_hub = AMDGPU_MMHUB0(0);
+
+	sprintf(ring->name, "vcn_dec_%d", inst);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
+				 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
+
+		ring = &adev->vcn.inst[inst].ring_enc[i];
 		ring->use_doorbell = true;
 
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
+				(amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i + 8*inst));
 
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+			IP_VERSION(2, 5, 0))
 			ring->vm_hub = AMDGPU_MMHUB1(0);
 		else
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 
-		sprintf(ring->name, "vcn_dec_%d", j);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
-				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
+		sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
+		r = amdgpu_ring_init(adev, ring, 512,
+					 &adev->vcn.inst[inst].irq, 0,
+					 hw_prio, NULL);
 		if (r)
 			return r;
-
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
-
-			ring = &adev->vcn.inst[j].ring_enc[i];
-			ring->use_doorbell = true;
-
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
-
-			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			    IP_VERSION(2, 5, 0))
-				ring->vm_hub = AMDGPU_MMHUB1(0);
-			else
-				ring->vm_hub = AMDGPU_MMHUB0(0);
-
-			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
-			r = amdgpu_ring_init(adev, ring, 512,
-					     &adev->vcn.inst[j].irq, 0,
-					     hw_prio, NULL);
-			if (r)
-				return r;
-		}
-
-		fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+done:
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1010,195 +1007,192 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v2_5_start(struct amdgpu_device *adev)
+static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int inst)
 {
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true, inst);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
-
-		/* disable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		/* set uvd status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v2_5_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
+		return r;
 	}
 
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* set uvd status busy */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return 0;
 
 	/*SW clock gating */
 	vcn_v2_5_disable_clock_gating(adev);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		tmp &= ~0xff;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
-			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
-			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
-			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
+		~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
+	tmp &= ~0xff;
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
+		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
+		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
+		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
+		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
 	vcn_v2_5_mc_resume(adev);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
 
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
+		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
+		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+		~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		for (k = 0; k < 10; ++k) {
-			uint32_t status;
-
-			for (j = 0; j < 100; ++j) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status & 2)
-					break;
-				if (amdgpu_emu_mode == 1)
-					msleep(500);
-				else
-					mdelay(10);
-			}
-			r = 0;
+	for (k = 0; k < 10; ++k) {
+		uint32_t status;
+
+		for (j = 0; j < 100; ++j) {
+			status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
 			if (status & 2)
 				break;
+			if (amdgpu_emu_mode == 1)
+				msleep(500);
+			else
+				mdelay(10);
+		}
+		r = 0;
+		if (status & 2)
+			break;
 
-			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
+		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__BLK_RST_MASK,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-			mdelay(10);
-			r = -1;
-		}
+		mdelay(10);
+		r = -1;
+	}
 
-		if (r) {
-			DRM_ERROR("VCN decode not responding, giving up!!!\n");
-			return r;
-		}
+	if (r) {
+		DRM_ERROR("VCN decode not responding, giving up!!!\n");
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK,
+		~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
+		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		ring = &adev->vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring->ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	ring = &adev->vcn.inst[inst].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
 
-		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
+	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
 
-		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-				lower_32_bits(ring->wptr));
-		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
+	ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
+			lower_32_bits(ring->wptr));
+	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
 
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
-
-		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &adev->vcn.inst[i].ring_enc[1];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
-	}
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
+
+	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &adev->vcn.inst[inst].ring_enc[1];
+	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 	return 0;
 }
@@ -1427,70 +1421,69 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v2_5_stop(struct amdgpu_device *adev)
+static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v2_5_stop_dpg_mode(adev, inst);
+		goto done;
+	}
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		/* block LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* block LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
+		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+		UVD_VCPU_CNTL__BLK_RST_MASK,
+		~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+		~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		vcn_v2_5_enable_clock_gating(adev);
+	/* clear status */
+	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
 
-		/* enable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
-			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-	}
+	vcn_v2_5_enable_clock_gating(adev);
 
+	/* enable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+done:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false, inst);
 
 	return 0;
 }
@@ -1829,23 +1822,22 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == adev->vcn.cur_state[i])
-			return 0;
+	if (state == adev->vcn.cur_state[inst])
+		return 0;
 
-		if (state == AMD_PG_STATE_GATE)
-			ret = vcn_v2_5_stop(adev);
-		else
-			ret = vcn_v2_5_start(adev);
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v2_5_stop(adev, inst);
+	else
+		ret = vcn_v2_5_start(adev, inst);
 
-		if (!ret)
-			adev->vcn.cur_state[i] = state;
-	}
+	if (!ret)
+		adev->vcn.cur_state[inst] = state;
 
 	return ret;
 }
-- 
2.34.1

