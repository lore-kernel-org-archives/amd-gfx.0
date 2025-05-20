Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CA0C5479B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 04:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D8210E00A;
	Tue, 20 May 2025 04:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tcN1NoLC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2489E10E00A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 04:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj7M8uT91fR6QybNEWiFhqE98b1vqcp3TUBLWTvP4JusKrfPNFSRTRrxS2P/1SZpWsDyy9BtE0frOsJn4C2JYpKusan7WzL0nQC2TEe0yWQzomcB4PMNcy8UmTmXMZGP7ne+FbyhXl/8mDnIL5+QMuo9UPQho68B572AgudL+FMsj+TajJEK7ExexI2vvqlMntRirahEJ9JqhdoH++pN8GLwgju6eyT993g1fabem2C8ihTpw+IdFId7HHMAyB3NeLYSkhz/7C0RACzne0jbTSVmHhyYLUwIe8oUkBdOErQXoWBG+t64icQsRVJ0pPjOT0OfXm9gEBrOt7Gzf/XV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvtjbu9IlEMgAvwShSjtjJq2h0CqNnV5xt8yf1jntLY=;
 b=vO70BHQpfLtJuPglZLqj4c/SBoun8DY8bwv/XaMlwrpiZdYtw/q5h68H5AebxUUAqDOyKmEB7tgNow9925pGV9SZ7E8NJifHb5ZAxYB84UsHuepfvv/evOjlk6PO194ZR6JCySGs7TbSMGW3GDy4bYekWEC/YHVW6GW8LD026ZpknDus8se6NhEdoQOqnwQVSTM7WPlFEggZpBFDIDRrmdn/cf8mFmVzQErou6oECdrKCnWNcofFmcECCbS3mRUGGsoSClOBs+3jHPxYueuWRRXI827JDyvtv6d60YKF1K65Yl1iZj67JZuvBKaNXtSaDUFHThVxFPvVdBke56xjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvtjbu9IlEMgAvwShSjtjJq2h0CqNnV5xt8yf1jntLY=;
 b=tcN1NoLCFZ/setc+xT6UP4YMGtGeglrGb7lxDyXyqMtfQ87HcXzTyO1M31EcSdJuIVy+Pp/xPGjDvDeQvXM4wualdG7SYeH4y+s0jknCI2Ru3If+cD6hV//k67ddnOVegBJ9EXs0yNgA/8OorT/cCW+3MvUUnYxFWNV4UC9lTPE=
Received: from BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42) by
 CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 04:24:51 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::cf) by BYAPR01CA0065.outlook.office365.com
 (2603:10b6:a03:94::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Tue,
 20 May 2025 04:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 04:24:51 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 23:24:48 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Stanley.Yang@amd.com>, <Tao.Zhou1@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu: Enable RAS for vcn 5.0.1
Date: Tue, 20 May 2025 12:24:30 +0800
Message-ID: <20250520042430.1606672-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: a221901c-913a-498b-ecac-08dd975643a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/tjVYASvw3FIRv3ZB1mhPq/dC/03IjZo/RgvydkrRVMj7/6Zq8CYkz10W4Wz?=
 =?us-ascii?Q?3G/IpTDW3NqAUKJCR/+Myb1XJ0OfjQiKSnJE1eCSff5RxGsIUMLk8vOcSXf1?=
 =?us-ascii?Q?TE+HU9s9YV9VWdsK/SHwAVFG9teITjK21bTqXs7HW3OxGeUT+xTyjQn0io0V?=
 =?us-ascii?Q?4bR3OcsulBaPc9xREmev1/BrYXumlot0gdNpEe3zp4zxxLfyr5xeoGO60HP4?=
 =?us-ascii?Q?ddmBhjLAXS5qWmFqzPALkBRox6Gtjd2aTVnASarSJ5goOaCc7XDayMkeEKm0?=
 =?us-ascii?Q?aR06LYBABH54y4n6k0V/FU/UmrTgW1udZDcVGyfMasoxUJA6zHNoBORAiDMw?=
 =?us-ascii?Q?0YDFR8lcBmmUGOqPsjNaFOM2E1uooW92eqC8h8gdW+CzIMI627CrxiiXta6m?=
 =?us-ascii?Q?8IJ/uWzZxkRTkIYOWJqo4f7hKs4kfhbDT55JJ0LqpsMDzEdlnm+IM3Dfo8n1?=
 =?us-ascii?Q?KiHjxMz3ptp3lLzeuSq0OJMqzBgLl0Q+qT+SuAVZ0Evgn+fQo0cma2Y3qnAN?=
 =?us-ascii?Q?VEX+zBrXvVC+wXQxU84gwoUuhrYwoQ2q8QmMmQbk9jeq/tmr52SAPQOAIeEi?=
 =?us-ascii?Q?IjN6MwOjbdlk2BR7Ki3B38ADaebLxzScgKzHoK8v2qeHYPQ0+qHE5IrJ0QnV?=
 =?us-ascii?Q?K/6ERTLQXacYam7+lkeUHiTr806gJKCv/Dm15p1pzTJUK3kewQBmw0zZb1dx?=
 =?us-ascii?Q?vZS2p5jWl4K8ep6PMZP4R1VboJSB40v0Y6UUP67SEMaDzoIUW3MsPHZF3m2z?=
 =?us-ascii?Q?psmNqfPQq89AhO1OYaw/1wRXnYAp2VhDXzx48O28hvHI2Ft0pLOe0Q+WOsDL?=
 =?us-ascii?Q?rQ+SeVW395Wv6Jfc2N5Te4HFaxrrQpyDhFIQVBg1jb1sqOVQGupjdpKlPYpQ?=
 =?us-ascii?Q?cKhKjmC/871VaGAKLm4TB5hjXA3JjhFIqjG3Tzg/U983XJdlMgrI24J7C0Hh?=
 =?us-ascii?Q?FOKRrGxJVkpKXzVkd84oNsWH4LCmU3j6C2IVKQNQip+zfuEEwUVTYHU0N1Ap?=
 =?us-ascii?Q?HaPALy8p6uvENErxRw7Dl4Km0waY4TSwUN1cHnwLGh+cAtxusQWTP9hAqJjn?=
 =?us-ascii?Q?X3PGT9l3XBk181/pVsW2/5dCCVV34j8uu5EgidaDqJZfzlfIuHdS/SKQNiom?=
 =?us-ascii?Q?l6/WAkes4E+zJod3tUXJaRc4D0T7hGmYdpPsIFBnQ3vii5VWOG88Qb4UyPpM?=
 =?us-ascii?Q?iYZIAQ4TWz8zJEFNKNAvDe9W99QUIFulHN1TkhxidjBmAFimE5OYIRdF4uE1?=
 =?us-ascii?Q?h5fYAXBG7PVax06vc01LQ5PUvLfnM5DmD5lLE7Qj7HKK6TWlu44aTYHmQ2Ly?=
 =?us-ascii?Q?qKIIohCGWWPmIT16YrQcua9808/8XEAEopG3gU/AJk4u4nCK9Vld1bDE5Dvs?=
 =?us-ascii?Q?nCaDNnlyxfCpnUHNIL5bMhtTL3VM1ASZdjcRmkOkdcQllDSwUTlb0SNysBdd?=
 =?us-ascii?Q?gKMEo/lfx9/277QY/euGNAD4i4yemrwtK5N8jr7at3eAJLcGvPNoYto7gVMY?=
 =?us-ascii?Q?zjWwhrxOENxDqFNi3TcmpaKtZeXPfTvqlQE/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 04:24:51.3014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a221901c-913a-498b-ecac-08dd975643a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

Enable vcn ras posion processing and aca error logging

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
v2: query ras error count legacy callback removed

 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 165 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h |   7 +
 2 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 60ee6e02e6ac..b379d112d7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -44,7 +44,7 @@ static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
 static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
-
+static void vcn_v5_0_1_set_ras_funcs(struct amdgpu_device *adev);
 /**
  * vcn_v5_0_1_early_init - set function pointers and load microcode
  *
@@ -64,6 +64,7 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 
 	vcn_v5_0_1_set_unified_ring_funcs(adev);
 	vcn_v5_0_1_set_irq_funcs(adev);
+	vcn_v5_0_1_set_ras_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		adev->vcn.inst[i].set_pg_state = vcn_v5_0_1_set_pg_state;
@@ -111,6 +112,10 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	/* VCN POISON TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_5_0__SRCID_UVD_POISON, &adev->vcn.inst->ras_poison_irq);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		vcn_inst = GET_INST(VCN, i);
 
@@ -247,6 +252,9 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		amdgpu_irq_put(adev, &adev->vcn.inst->ras_poison_irq, 0);
+
 	return 0;
 }
 
@@ -1160,10 +1168,24 @@ static int vcn_v5_0_1_process_interrupt(struct amdgpu_device *adev, struct amdgp
 	return 0;
 }
 
+static int vcn_v5_0_1_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static const struct amdgpu_irq_src_funcs vcn_v5_0_1_irq_funcs = {
 	.process = vcn_v5_0_1_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs vcn_v5_0_1_ras_irq_funcs = {
+	.set = vcn_v5_0_1_set_ras_interrupt_state,
+	.process = amdgpu_vcn_process_poison_irq,
+};
+
+
 /**
  * vcn_v5_0_1_set_irq_funcs - set VCN block interrupt irq functions
  *
@@ -1177,7 +1199,12 @@ static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
 		adev->vcn.inst->irq.num_types++;
+
 	adev->vcn.inst->irq.funcs = &vcn_v5_0_1_irq_funcs;
+
+	adev->vcn.inst->ras_poison_irq.num_types = 1;
+	adev->vcn.inst->ras_poison_irq.funcs = &vcn_v5_0_1_ras_irq_funcs;
+
 }
 
 static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
@@ -1209,3 +1236,139 @@ const struct amdgpu_ip_block_version vcn_v5_0_1_ip_block = {
 	.rev = 1,
 	.funcs = &vcn_v5_0_1_ip_funcs,
 };
+
+static uint32_t vcn_v5_0_1_query_poison_by_instance(struct amdgpu_device *adev,
+			uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_VCN_V5_0_1_VCPU_VCODEC:
+		reg_value = RREG32_SOC15(VCN, instance, regUVD_RAS_VCPU_VCODEC_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
+		break;
+	default:
+		break;
+	}
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool vcn_v5_0_1_query_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst, sub;
+	uint32_t poison_stat = 0;
+
+	for (inst = 0; inst < adev->vcn.num_vcn_inst; inst++)
+		for (sub = 0; sub < AMDGPU_VCN_V5_0_1_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+			vcn_v5_0_1_query_poison_by_instance(adev, inst, sub);
+
+	return !!poison_stat;
+}
+
+static const struct amdgpu_ras_block_hw_ops vcn_v5_0_1_ras_hw_ops = {
+	.query_poison_status = vcn_v5_0_1_query_poison_status,
+};
+
+static int vcn_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
+				      enum aca_smu_type type, void *data)
+{
+	struct aca_bank_info info;
+	u64 misc0;
+	int ret;
+
+	ret = aca_bank_info_decode(bank, &info);
+	if (ret)
+		return ret;
+
+	misc0 = bank->regs[ACA_REG_IDX_MISC0];
+	switch (type) {
+	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
+		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
+						     1ULL);
+		break;
+	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
+						     ACA_REG__MISC0__ERRCNT(misc0));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/* reference to smu driver if header file */
+static int vcn_v5_0_1_err_codes[] = {
+	14, 15, /* VCN */
+};
+
+static bool vcn_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					 enum aca_smu_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	if (aca_bank_check_error_codes(handle->adev, bank,
+				       vcn_v5_0_1_err_codes,
+				       ARRAY_SIZE(vcn_v5_0_1_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops vcn_v5_0_1_aca_bank_ops = {
+	.aca_bank_parser = vcn_v5_0_1_aca_bank_parser,
+	.aca_bank_is_valid = vcn_v5_0_1_aca_bank_is_valid,
+};
+
+static const struct aca_info vcn_v5_0_1_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &vcn_v5_0_1_aca_bank_ops,
+};
+
+static int vcn_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
+				&vcn_v5_0_1_aca_info, NULL);
+	if (r)
+		goto late_fini;
+
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+
+	return r;
+}
+
+static struct amdgpu_vcn_ras vcn_v5_0_1_ras = {
+	.ras_block = {
+		.hw_ops = &vcn_v5_0_1_ras_hw_ops,
+		.ras_late_init = vcn_v5_0_1_ras_late_init,
+	},
+};
+
+static void vcn_v5_0_1_set_ras_funcs(struct amdgpu_device *adev)
+{
+	adev->vcn.ras = &vcn_v5_0_1_ras;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
index 8fd90bd10807..b72e4da68317 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
@@ -27,6 +27,13 @@
 #define regVCN_RRMT_CNTL                          0x0940
 #define regVCN_RRMT_CNTL_BASE_IDX                 1
 
+
+enum amdgpu_vcn_v5_0_1_sub_block {
+	AMDGPU_VCN_V5_0_1_VCPU_VCODEC = 0,
+
+	AMDGPU_VCN_V5_0_1_MAX_SUB_BLOCK,
+};
+
 extern const struct amdgpu_ip_block_version vcn_v5_0_1_ip_block;
 
 #endif /* __VCN_v5_0_1_H__ */
-- 
2.34.1

