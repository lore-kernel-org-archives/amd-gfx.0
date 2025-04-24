Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB6DC369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 17:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924F910E0D2;
	Thu, 24 Apr 2025 17:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JYihp9kQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63C810E452
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 17:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBYaKVlR84JY+4WxlWax/XSldbLPDDwpoesv1E27Nnd9ZqLORZwxrSH3ONClN81wqFBtk5XCyWFlvlhIjM2kKn4JTBw7vd4uyx8BX6IEtujvH5pVw6C7oVpCQEn2/gWvQngzNoNpM77wOQDkC2ala4ugIlrKKH3w1cZytMeAf0ld4U6Bfm7UnL5SbPUdvE952GQWZrYjO2tn6udA/W39n5BOSvhvzUrV6GCQqlI2Jr7atI/2OHUuH2x18O6nhOZDhFnpG6AioocSdZc0hVUeB1neWlzIexV4lvQ6rAreQ8HjEMf1onCzuflbB6KHVMTTlaPuiNBq6yQxHe1d/zGywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUYAgLvhmeQfQi2AOShvHCf96v/BJo/QNO2b7cwDWoM=;
 b=Z4cBmZ3HltbTABQhX78FQAoGD1NIQQxIT1J48o76X8Cknq9tomlat+NH86mA14ym2QTsx6lAN/kDa1ztlepFqLTML0WVcmel4V5pKshu6IIQNQjtnUgBXosUSFOPSG1kxbbsn+Km7bW6u449tWqmz7DOANU1s2u9uPujpTFHKf0J2PN/3qVnWZ89nZB+eeM+t9H2QhKYpA8WGsTJxTe72RiBG3/sFUnnUvtZEbhCclvXUG3ApWhrA/e5pw1A2F7V1Y3D2mNEMGU1JkdCH5XqWfEPXEC4WQ2GyKOQqntIVNzxEWiRpl7LNNO2nUe1c0JeF4JH80MV/Db/GfLVl8rxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUYAgLvhmeQfQi2AOShvHCf96v/BJo/QNO2b7cwDWoM=;
 b=JYihp9kQTY5GaYQFeN/dF6XQuzAA3MozaCihn2Z20tVYtTVehmFo3Ex0yKWnpFaWgDkOvi8mgpnkuwYFIuDmaEsNhx298hRlZygnTBaBteVoPJfEWdD9ET5Soe8ggtkzBQTlIONRj62RSNG00y6vU9iQE9STEJ2n+00IRAiMuEw=
Received: from PH7PR17CA0064.namprd17.prod.outlook.com (2603:10b6:510:325::21)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 17:13:19 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:510:325:cafe::96) by PH7PR17CA0064.outlook.office365.com
 (2603:10b6:510:325::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 17:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 17:13:19 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 12:13:17 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH] drm/amdgpu: Add DPG pause for VCN v5.0.1
Date: Thu, 24 Apr 2025 13:13:00 -0400
Message-ID: <20250424171300.668773-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 289f5f71-8016-4d30-cf17-08dd83534f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wEe5s8iSIDRSoXlivXrKfxzDjy3lBcXJp6PSxSuKOwrxKsNVjDC/qZC6J8jr?=
 =?us-ascii?Q?zpkghazhCWURlPyViNmfWnDtgSDqhmHERPv9yJQ2SZ+WFzIxQTWC4Y9HCTip?=
 =?us-ascii?Q?g86wFFQzo5pWa7k4F8Xqhg+0k3r9T3iFnehKhr8T/VpOeVX2C5OvW4Sfqyqa?=
 =?us-ascii?Q?uY4IXQLNoZEp/21mmSH0cA/FCJD7USq1XAsiBeS/9JpAJfstb2SrNKEt90o5?=
 =?us-ascii?Q?XMkjcQz+xuwYhiTTe9wL29H3lgdHal1cOudDjsBwIU+CtA9kIqiPgogiVgrY?=
 =?us-ascii?Q?AFeETd7X5TizZkKZBuSfhIt7vR3LaJnKxEPvIta2Fh4/fU/p/klUM4yvTM8u?=
 =?us-ascii?Q?6BCqc8XAHsr4B4g5ar3UolrcBf2xz/6waGJlPNVVoxstyCVhJs4JdzAzE0+K?=
 =?us-ascii?Q?UIe+suzr5chlGeBOnaOSQronpe0JGAoqPR7zj0Tnddr8ddgJj0HDZkCTmMWi?=
 =?us-ascii?Q?aMdyWeB9M4FbHif+6oQFA+WONSeLmO941LdI+v4FytUS3lD4u/9RK2uuYWJS?=
 =?us-ascii?Q?0t+WunbXskSGAQCvdgAhl2YxxE30l9h8/jMwKJ1QCJqFD6dY6Vqu2jPVm8uC?=
 =?us-ascii?Q?ugNCFb3kdEknmUqYv6idH1M/rsR3L0995UqiCMnlpz2D9ksxNLsrjEWR1GGo?=
 =?us-ascii?Q?4IlnsbYc7Nowf0w3xRnIaAFu8INWWVcGqPb1dO3Z8twOpMw7fyQGZYjoNH0V?=
 =?us-ascii?Q?IuEyuwZqn65r+2WO+vxaLeFiLj1wlI9h0fzO0vKSMWemU0+vTzXjLn/kDC8y?=
 =?us-ascii?Q?mMCc3dVc25hAaKELAgBzZUR0z3fLnvfLkN4w3+T2/mQOYT3f0Ja+QLImgjNV?=
 =?us-ascii?Q?OB+b5JxPWz0I0fbVBusvQkrJGv8occStrK6HeqVzYZ0RxlCCMGMR6IL21i46?=
 =?us-ascii?Q?/eSfzusQA9stZTydMCiXXkZI/FzOFDuZg+2/JQ1TkGEAHqMNI7xveV1D/yqn?=
 =?us-ascii?Q?U86oCFR0sqy1vlkm8MdTk8q7E6MfPqV6Oi/ssvMNv2+RpMWToK3gHvN6wFWh?=
 =?us-ascii?Q?IpG5wqsHU3vPftRQgTAS9w75QiYQatxNH9rWzPpZpOMotm+13UCKeuzNR5nL?=
 =?us-ascii?Q?+h980JYZ8OXhPU+xmq5uxGttKWrV3sw4VZO50z+C30OqUIGtu78JDkx7sKyw?=
 =?us-ascii?Q?LjPmj/QL0G2vHhNNTnVzEOAnAbGo8l6/rTKPmhN4yUsBbz7wZy1+NBAIwnhy?=
 =?us-ascii?Q?FVt+qDipxG65rRJQD+EUM/5XCe6glvE+rb9LSpfWCXnUYVhr6An372UDSr5Y?=
 =?us-ascii?Q?ztyP8ia3+EIqZkfKSBhO7L/E0DGrJmeUABi/9sDiASHa3hjeLAQABVuSBark?=
 =?us-ascii?Q?e80oifDZRlgaJ2Kem57V901sxprpjubPWyHqd2wjMiQp6pKEYQIhJTZFglcX?=
 =?us-ascii?Q?+KrivR3d4trYpHjjZOEvbboN0u2WoHMas34WXBWOpt92ZCuxG8tbDeXkVwKu?=
 =?us-ascii?Q?30VPKIFFB4NWmiPrZZBEhSMNU5IsyYXQ5K7xKd0icdlLpSs6fWoPXWPpw5ui?=
 =?us-ascii?Q?e1p9Wvq1M4MLsmBx+BNSnEsz4qat8pNQ+hop?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 17:13:19.1321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289f5f71-8016-4d30-cf17-08dd83534f5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
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

For vcn5.0.1 only, enable DPG PAUSE to avoid DPG resets.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 4b2e6a033831..a115dd2c1d82 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -502,6 +502,53 @@ static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 }
 
+/**
+ * vcn_v5_0_1_pause_dpg_mode - VCN pause with dpg mode
+ *
+ * @vinst: VCN instance
+ * @new_state: pause state
+ *
+ * Pause dpg mode for VCN block
+ */
+static int vcn_v5_0_1_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	uint32_t reg_data = 0;
+	int vcn_inst;
+
+	vcn_inst = GET_INST(VCN, inst_idx);
+
+	/* pause/unpause if state is changed */
+	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
+		DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d %s\n",
+			adev->vcn.inst[inst_idx].pause_state.fw_based, new_state->fw_based,
+			new_state->fw_based ? "VCN_DPG_STATE__PAUSE" : "VCN_DPG_STATE__UNPAUSE");
+		reg_data = RREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE) &
+			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			/* pause DPG */
+			reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
+
+			/* wait for ACK */
+			SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_DPG_PAUSE,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+		} else {
+			/* unpause DPG, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
+		}
+		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
+	}
+
+	return 0;
+}
+
+
 /**
  * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
  *
@@ -518,6 +565,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared =
 		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
 	int vcn_inst;
 	uint32_t tmp;
 
@@ -582,6 +630,9 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	if (indirect)
 		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
 
+	/* Pause dpg */
+	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
 	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
@@ -775,9 +826,13 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	int inst_idx = vinst->inst;
 	uint32_t tmp;
 	int vcn_inst;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 
 	vcn_inst = GET_INST(VCN, inst_idx);
 
+	/* Unpause dpg */
+	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-- 
2.49.0

