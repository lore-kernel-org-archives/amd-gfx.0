Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9C3C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAED410E700;
	Wed,  8 Nov 2023 04:17:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FC010E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+jQsaeIgvGu6AUCajSsyqWQdHQAtPzyNN5MigzBdeiEspo3mRtl0qGyCCfykxtBYQv/hY6joNHQXOBZUkzMqzU6skTFob/bQ+QFZ6NaQIVxlYyJLWKCWUk/WX/PatK1OsmTdCIo0t94xMApJCwLVQEygsEV8IP8cFgHvfmjfX2CjQveR9+OEbb1CA2pDdFJDtjyp9zP4kcyGrfwh7xljEoYX6nJaZ1D+sya3+u0+uzpNMtdQtVZJJlWx8mFXkkg2/skmJi587hK57nW8BxJN4/ak9dXj/RtEFFvTVI+5zwhgt5dWEJWMguh7+xU2P33wJsPTRzoLmSeNCP0wfvbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cou5Warx0G0zg/E8F1wUJctLhZWcySxYOqpDuB8EopY=;
 b=Q4holRhVlC01yzFfnEAdnFqvmL1SkWv7FoB/4pJHij07L9Z8vr69LKXg1NLbeIyHBUeeE2exshFjXBJVoATQgc0JiKrhfinH00W1IsjnDg+S6VtXje3b9fmyudP5LUqA2+7aVHBDSB+6hDHIOPtGCygZhpjmDZL54f4T6dgWUtCfz+ai42VtXuvmyG+m2qj5F0NZUYkh5hHwKbmJmeCMg8u55CtCf+S1qMG/9sEpG5nm0N5qNTtjiRUJkm9MTGhl3RBaF+mM2h5pekD+7Gdzv8pAWM0NG14CU9XzBEnevdjPMpQq/SH5I36Y4Z4mGEx1DY+TND/tRU4iFIRPSen4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cou5Warx0G0zg/E8F1wUJctLhZWcySxYOqpDuB8EopY=;
 b=2/pfPAkBCqhxr7EmXDf7kmrmifENt0DpVzAGiVZzLnU/yxPpQZU2NzGXwSU1I3Ou0gq3cEriO/6nwiQ0tT81pL6WV3CUhBdp6HBHbuwFVyBppf6jXCLX9VWat7p9tWO0RxOXVw3jg7VwWGA7UCi6Ip//ubXtj475iPICghQj+y0=
Received: from DS7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::12) by
 IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 04:17:32 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::4f) by DS7P222CA0019.outlook.office365.com
 (2603:10b6:8:2e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Wed, 8 Nov 2023 04:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:17:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:17:29 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: add amdgpu_reg_state.h
Date: Wed, 8 Nov 2023 09:47:00 +0530
Message-ID: <20231108041705.528194-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: b63dacaf-49a0-45a3-e675-08dbe011a0a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOH0je99WeP2CIr9daHoSqUrsjQ2ZHYft0jxDsvsCcx6lVAqmDmZOXFusTaGnl9rnE8mcz+FDLJXQjypXIRRDj6QWy+G94w9tc8RuFVXGc6uUMwJUcCtycZyZnMVPJWNvvUjeSg9jYiOiMrQOOY35b0vQS8+0Z9cBeViK+i879/WOKKEOQ7DP7i595EcbuUjkblIACI6QAjUMKo8R0QS11R93woR9b1vWQVVvPuWFvTLRuZ6EoqHeIvr51YAFEP4otBpA2/Y9uhXoNq9mOVzmwoXwlMMwnYmQvDis3jNkrNxYNond5RTMbPw63RYTlhceFdd/cbjOxOJQ3xC/Xgz0HD2VlEFT0oQa6QLrxf8AAwgyXBHWuuymMh8dnkQYiiQPAgSa8KA/WqyRtrhArc3SLdY8l5gJlGwtUDLuYt2iXylfHhp3zdcS0f/Qn4C+rqmTKdYx838ufs7BecTasyLXRL3X2/H7hCqZIYxh/gmxZQ4uSGEaqIATdPWBRIA3PeWn8mhjBJQAcrNmnF0zHs7NKQhZ3NHIufJpwkXzOBM7pxAQurjvvxkp+JTIsMBqGRfZ6YAgwJckzy2fhS3OFjr6XxlsxiQl7kyYltC3Ifist5jt76Sl99tCyGSAJPAJKQk6dcCTqsjbh5+sFc3nTJKM9TeeIcCHd1SUn8xZLIAfrgs7HH5N4P+PqqKtDjlqXbah9K9gQivk+baSXGjtjSr2hOhWNeawNr+LXj86ixg2KaWRKwSDey+3xPohGI3evjR91KTXwAtHGUxUnzbJRvZMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(66899024)(36756003)(40480700001)(16526019)(8936002)(83380400001)(5660300002)(336012)(4326008)(316002)(8676002)(26005)(70206006)(1076003)(54906003)(6916009)(36860700001)(70586007)(478600001)(44832011)(41300700001)(47076005)(6666004)(7696005)(2616005)(2906002)(81166007)(426003)(82740400003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:17:31.6306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63dacaf-49a0-45a3-e675-08dbe011a0a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This header defines the reg state structures exposed via
sysfs for umr debugging.

v2: add content type

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +
 .../gpu/drm/amd/include/amdgpu_reg_state.h    | 139 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_reg_state.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 969d8ba8b8dc..f621fb99190f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -111,6 +111,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
+#include "amdgpu_reg_state.h"
 
 #define MAX_GPU_INSTANCE		64
 
@@ -587,6 +588,10 @@ struct amdgpu_asic_funcs {
 				  const struct amdgpu_video_codecs **codecs);
 	/* encode "> 32bits" smn addressing */
 	u64 (*encode_ext_smn_addressing)(int ext_id);
+
+	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
+				enum amdgpu_reg_state reg_state, void *buf,
+				size_t max_size);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
new file mode 100644
index 000000000000..e1ca38676663
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
@@ -0,0 +1,139 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_REG_STATE_H__
+#define __AMDGPU_REG_STATE_H__
+
+enum amdgpu_reg_state {
+	AMDGPU_REG_STATE_TYPE_INVALID	= 0,
+	AMDGPU_REG_STATE_TYPE_XGMI	= 1,
+	AMDGPU_REG_STATE_TYPE_WAFL	= 2,
+	AMDGPU_REG_STATE_TYPE_PCIE	= 3,
+	AMDGPU_REG_STATE_TYPE_USR	= 4,
+	AMDGPU_REG_STATE_TYPE_USR_1	= 5
+};
+
+struct amdgpu_reg_state_header {
+	uint16_t		structure_size;
+	uint8_t			format_revision;
+	uint8_t			content_revision;
+	uint8_t			state_type;
+	uint8_t			num_instances;
+	uint16_t		pad;
+};
+
+enum amdgpu_reg_inst_state {
+	AMDGPU_INST_S_OK,
+	AMDGPU_INST_S_EDISABLED,
+	AMDGPU_INST_S_EACCESS,
+};
+
+struct amdgpu_smn_reg_data {
+	uint64_t addr;
+	uint32_t value;
+	uint32_t pad;
+};
+
+struct amdgpu_reg_inst_header {
+	uint16_t	instance;
+	uint16_t	state;
+	uint16_t	num_smn_regs;
+	uint16_t	pad;
+};
+
+
+struct amdgpu_regs_xgmi_v1_0 {
+	struct amdgpu_reg_inst_header	inst_header;
+
+	struct amdgpu_smn_reg_data	smn_reg_values[];
+};
+
+struct amdgpu_reg_state_xgmi_v1_0 {
+	/* common_header.state_type must be AMDGPU_REG_STATE_TYPE_XGMI */
+	struct amdgpu_reg_state_header	common_header;
+
+	struct amdgpu_regs_xgmi_v1_0	xgmi_state_regs[];
+};
+
+struct amdgpu_regs_wafl_v1_0 {
+	struct amdgpu_reg_inst_header	inst_header;
+
+	struct amdgpu_smn_reg_data	smn_reg_values[];
+};
+
+struct amdgpu_reg_state_wafl_v1_0 {
+	/* common_header.state_type must be AMDGPU_REG_STATE_TYPE_WAFL */
+	struct amdgpu_reg_state_header	common_header;
+
+	struct amdgpu_regs_wafl_v1_0	wafl_state_regs[];
+};
+
+struct amdgpu_regs_pcie_v1_0 {
+	struct amdgpu_reg_inst_header	inst_header;
+
+	uint16_t			device_status;
+	uint16_t			link_status;
+	uint32_t			sub_bus_number_latency;
+	uint32_t			pcie_corr_err_status;
+	uint32_t			pcie_uncorr_err_status;
+
+	struct amdgpu_smn_reg_data	smn_reg_values[];
+};
+
+struct amdgpu_reg_state_pcie_v1_0 {
+	/* common_header.state_type must be AMDGPU_REG_STATE_TYPE_PCIE */
+	struct amdgpu_reg_state_header	common_header;
+
+	struct amdgpu_regs_pcie_v1_0	pci_state_regs[];
+};
+
+struct amdgpu_regs_usr_v1_0 {
+	struct amdgpu_reg_inst_header	inst_header;
+
+	struct amdgpu_smn_reg_data	smn_reg_values[];
+};
+
+struct amdgpu_reg_state_usr_v1_0 {
+	/* common_header.state_type must be AMDGPU_REG_STATE_TYPE_USR */
+	struct amdgpu_reg_state_header	common_header;
+
+	struct amdgpu_regs_usr_v1_0	usr_state_regs[];
+};
+
+static inline size_t amdgpu_reginst_size(uint16_t num_inst, size_t inst_size,
+					 uint16_t num_regs)
+{
+	return num_inst *
+	       (inst_size + num_regs * sizeof(struct amdgpu_smn_reg_data));
+}
+
+#define amdgpu_asic_get_reg_state_supported(adev) \
+	((adev)->asic_funcs->get_reg_state ? 1 : 0)
+
+#define amdgpu_asic_get_reg_state(adev, state, buf, size)                  \
+	((adev)->asic_funcs->get_reg_state ?                               \
+		 (adev)->asic_funcs->get_reg_state((adev), (state), (buf), \
+						   (size)) :               \
+		 0)
+
+#endif
-- 
2.25.1

