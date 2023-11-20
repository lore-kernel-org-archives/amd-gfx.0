Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF8BC2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 16:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4A810E3F8;
	Mon, 20 Nov 2023 16:06:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1097F10E3F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 16:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9T/s3F7IFXhXyGhrXqQLFsVbr6eF+rwrtrKCovSjD1EfLWou0ICd2LuI1cnN7SkJXbsn+hR7d0K2R5JzBR9/X0RfQixGAB4MW8bm0GKuICsIvpMrk/XjNL+aUsaXx0EkDAbU/lNu1YZr21++UkgWIw66DYvTxNhrWECHKFobZz4rWxk0HuKXQM8h7ffVqrJ/i/RAEic2nqzC/1DT0IP2QC98ExLWRM9l6lHk13GCyn/wR2oNZ6jX9kZIFt3CTkuFJxVuUxmcmefkJGKUDyAUdpUWrJMDqZ3DwMl7x3h9Se3r6xeDT/FMrEGrqhMa1s04k1wDfOJOCd/Y8PrxNt+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saO8BKni/huhkE7c8pTZ6OrP7s1JnmfE7L95cBHYbis=;
 b=VlXEekDYrgo2zMqmVBwb1xtDxqeTrT0ndF45/DOfXL11ZTMF3xizlTHg2jizcC+FdQalampymdbwqd0fNBe/uxQAvfu5DSvNTL5tUVMhxFlQ0Mt5qf/HI+Gi+jX2G8XK65VCPkAyqk10/TFvKHFbIOe0Fwk6+88VaXyfJB20q9Uq27MVklNe46UOFcCNNvVm5iz82OaLpGvff57SHJMHJXFjLGPK+x0IkG33G1CaHV9xCrvhEyuicijaQWMlP8M0oU2DW5KXTg/VqW1H+ehTuqI/AArI62qaRI8Gt9QTzOCfNlrPu2N9iw4Lw4z1bw+uWxXwcNlSDtrdcQTezs/mJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saO8BKni/huhkE7c8pTZ6OrP7s1JnmfE7L95cBHYbis=;
 b=ldvu+06uitONIKhT1ObGJYGhxE4CHdwyvXXis/mBxq7HHAIAWJdnK25MfUWzeAgwtypGyIotayMl2YWMGNMCzDm6NJpGiV+0mwh2136ri04L28q5M1TYriwZs/q16FrwDkv9SfZo8Mu+uF6O0N61EQaSkhBZUFwanXpgwT2OXqo=
Received: from DM6PR06CA0074.namprd06.prod.outlook.com (2603:10b6:5:336::7) by
 BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 16:06:03 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::16) by DM6PR06CA0074.outlook.office365.com
 (2603:10b6:5:336::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Mon, 20 Nov 2023 16:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 16:06:02 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 10:06:00 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/24] drm/amdkfd: trigger pc sampling trap for gfx v9
Date: Mon, 20 Nov 2023 11:05:46 -0500
Message-ID: <20231120160546.2533951-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-11-James.Zhu@amd.com>
References: <20231103131139.766920-11-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|BN9PR12MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b2e9bb-936e-45a5-c9c6-08dbe9e29827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubKuB2/MIl748OzySTHsx9bK75s8XIpaQA/qSgfQj90w2jYTLGedIdZdh7+MzW/WM3TDZmvyWFAuNHYah7EpD23tiACqim79whEq18H0xGvl4/ktrER+uat6OZlxKsS9wZHChERQAig79QAYtqgC/WKazMNDd+We1LV6NXdgytAGoYEIVtxDv8tJ+5kUgCCTZC3fzGC7l7F7noFyyKD5vek/b1Ak5V9t3hrFR74/stN6KmvZdDDlbzqzIymo7X+og8eV/XCFAC6vuo3bPAK/j0oVgVtpTaC2CWeUCfRffzTiXGY724uXiqj6AXXoUwIwLAFdvgz0ScHB2v57vtK17g4hb/lSMtfALK3dhUvMygQe6LAS3PFr6XmQwj0T5UkyTcnITUEPOLw6/83MrX/2gfkgGLu9bfHIxzvxZCFtsIAkfpuI7U/DzkjhhlNJyl6Qb1CbpvFRvuiiPrOlAa+Mf0NFTUWiCAnY++Pu+TBjj1G5eYzaFgSqJ96XfjIXSAzAZtAteeX7+T0LzMQIracPZd1hxdMKpgpD2aPoG8At1ITAkUg2+GuyDlzgfHqTUlsJeWXwrKt5w6pnv+U+qlciqdMH1iuQcQ/esrK+xsHOnBx23ICO7wD65OnqqDjS1hCwbLyRTxErpnN1Yk0OVbrORKAxt1VIocX4gRCHRefnl3fHWsrPchGxQlx0zHQb11TFNNhMH+z0fmLi6D8AEnvWoM9dkBXsKxPODMlh00EDdoczsOhrrPRNLpql7IjhXbSI/ftbELe6XOsrexTqGfntRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(2906002)(47076005)(54906003)(70586007)(81166007)(316002)(70206006)(36860700001)(356005)(6916009)(7696005)(6666004)(478600001)(83380400001)(426003)(1076003)(2616005)(26005)(336012)(16526019)(5660300002)(82740400003)(36756003)(86362001)(8936002)(8676002)(4326008)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:06:02.6432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2e9bb-936e-45a5-c9c6-08dbe9e29827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement trigger pc sampling trap for gfx v9.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 36 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  7 ++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51011e8ee90d..5e1330888860 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1146,6 +1146,42 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
+uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t max_wave_slot,
+					    uint32_t max_simd,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	if (method == KFD_IOCTL_PCS_METHOD_HOSTTRAP) {
+		uint32_t value = 0;
+
+		value = REG_SET_FIELD(value, SQ_CMD, CMD, SQ_IND_CMD_CMD_TRAP);
+		value = REG_SET_FIELD(value, SQ_CMD, MODE, SQ_IND_CMD_MODE_SINGLE);
+
+		/* select *target_simd */
+		value = REG_SET_FIELD(value, SQ_CMD, SIMD_ID, *target_simd);
+		/* select *target_wave_slot */
+		value = REG_SET_FIELD(value, SQ_CMD, WAVE_ID, (*target_wave_slot)++);
+
+		mutex_lock(&adev->grbm_idx_mutex);
+		amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0);
+		WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+		mutex_unlock(&adev->grbm_idx_mutex);
+
+		*target_wave_slot %= max_wave_slot;
+		if (!(*target_wave_slot)) {
+			(*target_simd)++;
+			*target_simd %= max_simd;
+		}
+	} else {
+		pr_debug("PC Sampling method %d not supported.", method);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index ce424615f59b..b47b926891a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -101,3 +101,10 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
+uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t max_wave_slot,
+					    uint32_t max_simd,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method);
-- 
2.25.1

