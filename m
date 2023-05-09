Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63B6C7EE26
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E211A10E3F6;
	Tue,  9 May 2023 22:07:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87EF10E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1RzUwfdNBgOm65F1C+7bVBM1V59sskRwHHqV4+sYDAjFrKOjbuZaR/DfCZ21qgr5IZVVy6e/2zp0AyVjzcc1lS0EBsNKuLunbQZEWbbrO8Qb6Qkp5k0s/qXNaqmMZXcMf4ov+v7Wk0TZf+vXIePz6JYrHCcsBgtx4tAZMoMFmfEO1frzzZKLtnc0QXhJq161rJxlhQ3MK3LfNBGdYUlnGaDpZTjqhD9gmPpHQYZay27r1owlXFbtXy1c3sAIxI4VvkJ8hOkICcnwK6oYKPNb47mOXbfuzwThTY+Q7KN6Yf0KoOUZ4kjwGp8lxd12hjIHZ3kvH+vbZT3nsFql1dDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0ndBGaDWLFX6hAB28kx7J2U0mQK+QQiNQOfZwnsoTE=;
 b=jY1bEbpxBPeC9M1s92EQNaVhUopr6QM1PaLsDEs6LSP6Br2YpKeab0mdxcTIbpp1pPRNHbcEnDNCydHsPoZcUixYPLVZeDeRnAL5fFVjgEGzmDewnNLn4F4We5K1Md1fdtgVG7/gSfAdA5jO0UkMW5XilMxGoDIC+aS6Xtc6sDj+jTitWv0HcL0nzx6LH9T2QQwKm+HI1/Z4oIsoKK8iS3QTWyJR14nyMewdUu13/MOgX4FfVWvlwA4c1RYpOmPyMtjtJA+U1SQr3CEQWfxNPFpIAw3IXiSSvL08KcBb1HrOyfff0fM2cE4bcb0jQTQetsJ9coGdWCR1KCXuJ50x5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0ndBGaDWLFX6hAB28kx7J2U0mQK+QQiNQOfZwnsoTE=;
 b=1GjJ01epbPuCIGoPcNVp5ZeS8bgjY1qyi4dJU3JuCuJdmZt2z9X96uuRTFGtCez1Lu52RFz58Ohd1Emrh6mtutm3l3MqeMB9jNFXBrVBPHHbZbtDxeiwkzZNYvZakSGr+nKhIb8rvtoDVxY+HaE0+1AEVRWdYNtXw0esT04vCl4=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:07:28 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::b8) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 22:07:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/pm: Add ih for SMU v13.0.6 thermal throttling
Date: Tue, 9 May 2023 18:07:06 -0400
Message-ID: <20230509220714.475369-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|BN9PR12MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e3cfe4-530e-4ef4-87d5-08db50d9c785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKxrXJ+bc9HgRwXWZdPZbFCGhrlKOq/WFMtI0+9hFcZWQF/EQ0MIDNTX+jMaXiBmP4FOd96CiC5DUISVm+QIzaQoxnUjawSMHjeWz05r9tWRKN8IjoUaD6VR+H+yFD0ttCj9pFRqHP3I1rsCq8N029X2Pr7kslh85nj4J00/BUA8u4R6n0ju1AQYYcHL1UvkWEbtKR7lzKt/uIdeTGglGbCm4i2BueY5rerZDHd5MJn4EXmrBRniuy2FzOsUuwPBz3/KaJ+hDCHNmABbOpqYv07t32ExAXxG6itkWCaJhyUZAFdB8tGxaXslyjw0UAdE/24a/IU0o+LZzrk/ijjqzemnn/lKA+VHmhv/4buyGD0Zwpmozo1W9QDKsqEQca4zGfodzZGl9x4KQC9RCgOVF33VkN6/89zXFw9/gBslqDh12mmXQpbZOVrdW8jn7sVFpHqAhHQJ4/WDKoGme+KL1Cg8EU/sQh5eLMrMOyQ6O53R2sIzcu6TmaDrxeQleiL1JGMRRtuvW2Pg7PQ2ULNCYvymHpvrnAQhaKd2+JgORB4gvhsP0JXG4ceNBoWkNLTR1jGc+cxVGTxGE7Qt0SP1EPvJFjc1NrJ2GGRKe2LGiTcySKlwwUoLNg0jDHlGfZhDhY21gw8Dh+i5PJD4t6WEeNBk81st61FGvcvNAEbtO3t36pHjlbr93jn5oACOxn73fu2EH/HNAQwfF2aZt5SzQChNrebeWZuvEf7LF6hbU/o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(6916009)(478600001)(4326008)(70586007)(7696005)(70206006)(54906003)(316002)(86362001)(36756003)(336012)(83380400001)(1076003)(36860700001)(26005)(2616005)(426003)(8676002)(8936002)(356005)(41300700001)(2906002)(47076005)(40480700001)(82310400005)(5660300002)(82740400003)(81166007)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:28.8130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e3cfe4-530e-4ef4-87d5-08db50d9c785
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Asad kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad kamal <asad.kamal@amd.com>

Add interrupt handler for thermal throttler events from
PMFW on SMUv13.0.6

Signed-off-by: Asad kamal <asad.kamal@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 107 +++++++++++++++++-
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b08608caafd0..43a855de7e9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1297,6 +1297,109 @@ static int smu_v13_0_6_set_power_limit(struct smu_context *smu,
 	return smu_v13_0_set_power_limit(smu, limit_type, limit);
 }
 
+static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *source,
+				   struct amdgpu_iv_entry *entry)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t client_id = entry->client_id;
+	uint32_t src_id = entry->src_id;
+	/*
+	 * ctxid is used to distinguish different
+	 * events for SMCToHost interrupt
+	 */
+	uint32_t ctxid = entry->src_data[0];
+	uint32_t data;
+
+	if (client_id == SOC15_IH_CLIENTID_MP1) {
+		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
+			/* ACK SMUToHost interrupt */
+			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
+
+			switch (ctxid) {
+			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
+				/*
+				 * Increment the throttle interrupt counter
+				 */
+				atomic64_inc(&smu->throttle_int_counter);
+
+				if (!atomic_read(&adev->throttling_logging_enabled))
+					return 0;
+
+				if (__ratelimit(&adev->throttling_logging_rs))
+					schedule_work(&smu->throttling_logging_work);
+
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int smu_v13_0_6_set_irq_state(struct amdgpu_device *adev,
+			      struct amdgpu_irq_src *source,
+			      unsigned tyep,
+			      enum amdgpu_interrupt_state state)
+{
+	uint32_t val = 0;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		/* For MP1 SW irqs */
+		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
+		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		/* For MP1 SW irqs */
+		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
+		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT, val);
+
+		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
+		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs smu_v13_0_6_irq_funcs =
+{
+	.set = smu_v13_0_6_set_irq_state,
+	.process = smu_v13_0_6_irq_process,
+};
+
+int smu_v13_0_6_register_irq_handler(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_irq_src *irq_src = &smu->irq_source;
+	int ret = 0;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	irq_src->num_types = 1;
+	irq_src->funcs = &smu_v13_0_6_irq_funcs;
+
+	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				IH_INTERRUPT_ID_TO_DRIVER,
+				irq_src);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static int smu_v13_0_6_system_features_control(struct smu_context *smu,
 					       bool enable)
 {
@@ -2042,11 +2145,9 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.set_power_limit = smu_v13_0_6_set_power_limit,
 	.set_xgmi_pstate = smu_v13_0_set_xgmi_pstate,
-	/* TODO: Thermal limits unknown, skip these for now
-	.register_irq_handler = smu_v13_0_register_irq_handler,
+	.register_irq_handler = smu_v13_0_6_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
 	.disable_thermal_alert = smu_v13_0_disable_thermal_alert,
-	*/
 	.setup_pptable = smu_v13_0_6_setup_pptable,
 	.baco_is_support = smu_v13_0_6_is_baco_supported,
 	.get_dpm_ultimate_freq = smu_v13_0_6_get_dpm_ultimate_freq,
-- 
2.40.1

