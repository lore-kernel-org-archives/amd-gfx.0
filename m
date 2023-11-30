Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0262DC4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 00:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A96510E69E;
	Thu, 30 Nov 2023 00:21:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73C310E69E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 00:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIm492tgu6te04sXpZEWrdvyy7uuWsv3qd2og0MZt2AtNotJWx87k0ph+Ss8l/+xLAQpH7JCyAkv0N2MnNTxw7HJp+4X3C0B4fBkSdajTnbjZLql8RDaYmrhqBa8TO2DIJftbN+Bl2Vvy4uCGixB+VaWB37hFVGrkgH4DHbuTG+SdPPLSgtyL2+Q+p1AaEmukm07MoOuhknYLpoHRuYyldLlZav521ongYmc1WEpq8AGdqcb93cLI3nakec9AnKXGYSJlX3cuEI4s+SOEf42Z2C9VP1SSk7LhpFs95J+BIEOie2v5QCMm5nwd6B+k2NqOnxp2MIn7etM2Ycw4gfAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USSoTbRnp3hrT6X6eekikLzaR+1cp3ec0Ow7FHqksLY=;
 b=MNcwlyU06ZdfjH/qUSk3qp68fTS20tyjUch858YX1Rhb4jM0RBubpJhf80rUoJP28/5kuqlQr+tv07C96bxLCMTEUjcKUTVLXhtvbiCrLdJsRSh5hDqAEwUaOx7jso9LGJAx+HPyzSuwhuCx0TyU4D0q8GHWzj9g2oPVzQCEOPJ82T6w4VOx4kbH4K+KVKA7thc1wzbgIfDsfK3uFRAUlwYW4QIt7PehvJaKfuTrWsP79jZcQYANpX+ttfIMCnLjXi2oaT+K+7a6R+BdDIn6I1r43/5T8RnbuY8vfpvkWI1UIEXbokXcJVmpv/dbDn7oHGsp0rWsBJdPdo2ye/mJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USSoTbRnp3hrT6X6eekikLzaR+1cp3ec0Ow7FHqksLY=;
 b=o6DmqHDqQeZI2UP8kI11VLEN4jcJBQ9jMUW845qCcXUcF/N6ycnGXXhZUsEK5dfDY9Zs+v8HiB4NU0AdnVJXn3Yil1Mt0aJKllXQBnW2yr+A64MPfzbhmDu6CM6ULgJXGjWkg/fP6PZXksgSt6pwU7owiMSlB+8WRAQWeb24P9Y=
Received: from MW4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:303:b6::18)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 00:20:56 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::44) by MW4PR03CA0073.outlook.office365.com
 (2603:10b6:303:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.30 via Frontend
 Transport; Thu, 30 Nov 2023 00:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 00:20:55 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 18:20:54 -0600
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/amdgpu: Move vcn4 fw_shared init to a single
 function
Date: Wed, 29 Nov 2023 19:20:20 -0500
Message-ID: <20231130002019.112719-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9a9eb7-3dc6-4bdb-a37a-08dbf13a3807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRPU/Fls1lWsA1Y3ZL2IqcywCTLR9bKaWcI9yzYv+dluCLuIFvHNu9bptc0gU5MQ5JtVLCiNR417hYVyYGSLfWyTenlNk7fsLjJDQon928f7gzhOsxt/3c6SFez9HvWGQ9uqo0P1HvU459jPzA2ilKp0bZsjoihJpy0YXcIXJsX4msnkAYgK/L7As5x9Ehyoq6nVtisv462I9QKS1IvpL0FuQU3LTXicl54ZyEsKKoGjWtaJmzA0LFOaTcqgBd/KXLENfdcGlhqtX6hDojsTOrTFF/Wzuvp/IinkhOB/9mwwwMAI4huQjMC+fyNEQpwSsefRPa90wPH7tXBAh+XdjIVdMlg6nZxvtcgObhRrPtKF7kzKnZkCExxbk3u8Xjdw+yoZOOoNUHBefkz6XTN/YnVQ+ZqFxmTRRTMA94JBO536j8NzlFv5bPKORzVjQJMbkdfCHgYvb4HbuKXZsU+tzlo2C8taCCslqcF0LfyrrjVmqhsA6K9rIqyicbgLrIaOZmbv9al1CfuLE1jCqsYzEavQvxMQwm1x6G8HaUW2buFeZTcequsroBWGPQEfR2hNSv8cOofqeFthFs4PaaQxRx/ZWV0db/ub+Sk7E0cYk/e1sIimQxNKeIfYFC7kIkty8AbL7DQxCDmMcW5egBxCoiQ8MrzIH7qyaPjTUc5Lcr5thqmDiL9kdiIwljk3KUOrYbZ2ftLHNUmaTKkTIF6WzG78SvRx7NlLd0T1omWSaiBjzPL/pigLrpq75wJ4j7356pZs4O+QGM3RTocm98NaVezR2bTxlUw4fPH8gurVzokY2sD1dZQf6cbHcFlX5obE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(356005)(40460700003)(81166007)(16526019)(26005)(1076003)(2616005)(70586007)(70206006)(54906003)(6916009)(2906002)(5660300002)(8676002)(4326008)(7696005)(8936002)(86362001)(44832011)(41300700001)(6666004)(316002)(36756003)(478600001)(82740400003)(426003)(336012)(40480700001)(202311291699003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 00:20:55.1916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9a9eb7-3dc6-4bdb-a37a-08dbf13a3807
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Move VCN4's fw_shared initialization to a separated function.
  This way, the function can be reused at different locations.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 45 ++++++++++++++++-----------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index bf07aa200030..54b03df63a51 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -100,6 +100,31 @@ static int vcn_v4_0_early_init(void *handle)
 	return amdgpu_vcn_early_init(adev);
 }
 
+static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
+{
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
+	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = 1;
+
+	fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
+	fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
+		AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
+
+	if (amdgpu_ip_version(adev, VCN_HWIP, 0) ==
+	    IP_VERSION(4, 0, 2)) {
+		fw_shared->present_flag_0 |= AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;
+		fw_shared->drm_key_wa.method =
+			AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING;
+	}
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
+
+	return 0;
+}
+
 /**
  * vcn_v4_0_sw_init - sw init for VCN block
  *
@@ -124,8 +149,6 @@ static int vcn_v4_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
@@ -161,23 +184,7 @@ static int vcn_v4_0_sw_init(void *handle)
 		if (r)
 			return r;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = 1;
-
-		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
-		fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
-			AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
-
-		if (amdgpu_ip_version(adev, VCN_HWIP, 0) ==
-		    IP_VERSION(4, 0, 2)) {
-			fw_shared->present_flag_0 |= AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;
-			fw_shared->drm_key_wa.method =
-				AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING;
-		}
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+		vcn_v4_0_fw_shared_init(adev, i);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
-- 
2.34.1

