Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BCDC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 07:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409F410F427;
	Mon, 18 Mar 2024 07:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uW+KctW/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E59610F427
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 07:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrI6E7crmu7q2zggdsr4YikAXTbxnjENEOoVARZ/xLvBr4ruYLnebOKfflVtr6yof4mdssRkBw6lMLtwPA1/i2mkLj4qJ8WkpDfK+ooLpPLCzANBIpGrkvwfSMlovkDvEEDS3JpV+kVDHn2OoNBJwz5lWHVhsIGn84SCQrE7olBp++dvsWBKPkRnoKKfQ7ilUvGfA666YdNo41AgjMcDB4MdN2spe/mK93uxszeeTVDDQwtW8oq6HQdb1XlVOuN1ItUEEvvag6CgEU0HHGHXEpttk08BGk2DIpAFLyp8hgUSRclM3PccsgG398Zyek8Qezmp3i7XIkQ3ne0J0874Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN/NktmIIVZBbL5pPJ/k1u948vuOyIRLWEu91i4KAVE=;
 b=m00crbPMsmWNUqlbL7FafImdyeBOVZIbhYet0su5n8xvjIIRCBfLaaS2uM6lExWrh0bMMjFz5hUSSJ4p/PyYtsieMUMAhisK8bc+0tXXslnaKcZ/SVsuNqPMFrN9JzUs19RWzwB9VLfYlQClJXovoimHEyCvVGVumvWhaT20AGrOHcx0n380XfIbZHSYbs1w6fauQf4h/vXTFIC8rIEHK6q4TQVaL+ugQD6n1y1nsD6WNJK7WX2RSL2sTX/rKQQBO/OPB1ks41tyLOmvLIiDDGrrSAO9U4wKBY90YeStiJiwjQS5847OOYoW3xEvz4LubOkGu1PgWTI3xNNBtjit6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN/NktmIIVZBbL5pPJ/k1u948vuOyIRLWEu91i4KAVE=;
 b=uW+KctW/+i6105fttGzigNafZxZQdQsy/jqamJjhI8ijHPjvFneKZ2RzU+CpYMohWOQ+Bo2RsWha+qTZWXLQqN8oLFlMxmKe60PH7w7fObb7qojIK5jUUJlluXaHgppZzyqR0Pv0rVOe2t3Mo16Nvy8G9WKglZh8cT7A+/yPrYI=
Received: from MN2PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:160::39)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:26:34 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::4) by MN2PR13CA0026.outlook.office365.com
 (2603:10b6:208:160::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 18 Mar 2024 07:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 07:26:33 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 02:26:32 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add utcl2 RAS poison query for mmhub
Date: Mon, 18 Mar 2024 15:26:21 +0800
Message-ID: <20240318072623.352614-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be90e0c-cf06-4049-41c1-08dc471cbd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMo/8zQipICNQoDUVzSiCol2agVMBdqm2GeqHZsB59s1U0Uv7O2NGzx7XnRcqTcFCy1+0C8wBLnEpzcDFcD3PT47I/SKo8YMwTtLtNu3a5psP8XduXq16hjuc9bucfKcMyJllog+HOvHNOB2DBD3g4G8rwmB895uauc/3xfk3m9lHvcJ7wzktZSJwGQc5Pbmes0fhBph13mInDK825btIcq2405aBXTdBA5pxsgwlLnV/cwzOiwEnLV7Z2gqNosYD3d5vbvv5HXwlxlvmjT9fphe7tcYV/+N5lU9VJgvuGv14YM6bibgsgBmN+Gjs2eNl3tkvoKypt0lO/bdwQKa/Id4gvbYMVAtXpAmG4NS+r4h5r9QgPPQEYFZCjmqywnshUvO35f8ILEXJD/LQyH6E9C5uIh6et8NCk8g7vsz2vVDMa5Q8IHltiIJD7x3EUb43uMRUf+GXT4t/q9z1IJTgcdKTsqvsglpy6QqBJJ0eTRXJeh+aAEn5CHNcfXhNiZY56NXKw75d/Z6EjrlFLpbEZqAhgCMVCDFnhRnnXlH/HCCWp6L4DoKmnOqm0eAoNxzMj9s1QddwxR9IkdEFe/13mH9L8RRxHfvW4WdVlW3WCFu81/g6QpTCqWVqigzFdnaMxTE9TFrPQy80Zs00RqPGRw57/6GCLPCljYqm63tVnZBWKQqOJHRzIL2uHnAvVx+1ad/3t5+sD8BPpzb7hQ5MppgNeiSH5nI8rodmRj2TQnlb8OvFZF/xz1jkmr/cLAD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:26:33.7840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be90e0c-cf06-4049-41c1-08dc471cbd2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
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

Add it for mmhub v1.8.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 1ca9d4ed8063..95d676ee207f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -63,6 +63,8 @@ struct amdgpu_mmhub_funcs {
 				uint64_t page_table_base);
 	void (*update_power_gating)(struct amdgpu_device *adev,
                                 bool enable);
+	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev,
+				int hub_inst);
 };
 
 struct amdgpu_mmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index c0fc44cdd658..b7aa05dbef86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -559,6 +559,20 @@ static void mmhub_v1_8_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 
 }
 
+static bool mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
+				int hub_inst)
+{
+	u32 fed, status;
+
+	status = RREG32_SOC15(MMHUB, hub_inst, regVM_L2_PROTECTION_FAULT_STATUS);
+	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+	/* reset page fault status */
+	WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
+			regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+
+	return fed;
+}
+
 const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
 	.get_fb_location = mmhub_v1_8_get_fb_location,
 	.init = mmhub_v1_8_init,
@@ -568,6 +582,7 @@ const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
 	.setup_vm_pt_regs = mmhub_v1_8_setup_vm_pt_regs,
 	.set_clockgating = mmhub_v1_8_set_clockgating,
 	.get_clockgating = mmhub_v1_8_get_clockgating,
+	.query_utcl2_poison_status = mmhub_v1_8_query_utcl2_poison_status,
 };
 
 static const struct amdgpu_ras_err_status_reg_entry mmhub_v1_8_ce_reg_list[] = {
-- 
2.34.1

