Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E881AC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4A810EA65;
	Fri, 15 Dec 2023 16:00:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D1E10EA5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNvgRftfIeVbg+Ohj2mKCC4QQWA11k/fY0ZugJRv8dEhyHYlD7OOGHocYqgYKHd6voC9TzywlAI6Kk9vB8gr5ejr55xDppgrIp2Tc8asTdkaisPlOQewsc+H86A+9RwOFkUliSuS/p6mabfcqSQ0OBS8cn8vi9If7Jb+VU3R3fGPRCJ8XHffa4ToYL3wXaO6I2Ju+XZUUp3iQKxtwMPpzMZ1D6PQoei8mnZWgQGmIMWQf16VJtCx7NIqMZ+HmgALIPSAUuUie2zLWZOTrzakPDbb/YtTb+PputQ7Rd30PORjd2q1YfGjP/oisDvFOjkAlM/ML5DSpYlPRdJnEwadWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmlhLimzIk9uebLFrJB7EVqNgvOg1iCy3jLa2NPtDAI=;
 b=bau9GvvBZoCSTxu5KW+QGGsda9EODxrNOFzBFZ9hRp0x9Yc1FPzeK/+kzYZjzvVbH7/yCBLZPm+2b4bMXI2ayQ81411KtzMGgzq0AvZrxJRahZ5jEGZgjTz/VfiKY4bE12xouPCeqUG2mXeit2j/kAekR1aBLsQtE4u4BwDq2xcNTbRON6HbY4b9qBUyIeg5WxEyDzi17JYYGzhFu9G0bxrSWWOi32Qdg112wRcIgJnBhwV2e0lKeoLpd0tDVjSC8k+KAqXBo0CVski+YLD/AAyl0gB+Z3yavsliZJerBdZ+ycEdIfhsCh4pP+MmFgPuLlOwmmD9ldPf/Tic7aV/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmlhLimzIk9uebLFrJB7EVqNgvOg1iCy3jLa2NPtDAI=;
 b=dOg1TtSTuyIgk8N/MPlTZybEOU6gL3bFzwVRmum6v2DqWO9UMzfbXvYGAO8fjTYJFFOapR/cEstbtp4liOsmcouYvn+i1TWAeyv7tdmhbv5glWCzK4mTN91v4NxJoLIpWDT27zhX+Gj+dGi7W4MYxgWo9ViEawES6aoOC16+bIg=
Received: from SN1PR12CA0091.namprd12.prod.outlook.com (2603:10b6:802:21::26)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:00:44 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::99) by SN1PR12CA0091.outlook.office365.com
 (2603:10b6:802:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:39 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 10/24] drm/amdkfd: trigger pc sampling trap for gfx v9
Date: Fri, 15 Dec 2023 10:59:37 -0500
Message-ID: <20231215155951.811884-11-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM6PR12MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 2878c543-5ae6-45bc-3737-08dbfd86fe9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liZMOUfWiA1ivxWnMq1qWaF21ycP5qXU0aMT6O1FzLZoFA3R2EJ4oGwxKaPS1c6sZdrw/bBeIHJUlJ77bTvuHeR/maKJZbblL3TGn5+o8lCFoux0HzXiDPixMpgG7qGUcu2Oz3pjl8xtBa+wJTHz5aiI8xYbRm+eme+RYC4HKYg5dbYX5d4ACE2dqdmW1o8X2eO5rQ6Mh/943O9bYvycSijmvxfzOWY1+g9gv0wsq03rFKhLpFXALaEez7JGJUmngu2AB8TL/b/ibO7wg+WtTerJ43sVJrZtMflovHAcTTLBoReuPIAQR60KYY5hm5mcWl2faWUK7fdbq9rXI+Elo0Pcto+FOYpiAjVQWUz4QFpcM606RsWPIaHabuMw1EBMTjXZIXkJYVy4aTx3geI9oeDGJ7rZwyx+cmzirEJT6PdIp9HVoS720r/DoFg+QfoErRxgcM8FQsp4BsX3WVUAGRCm/9BgibgEE3kuK9fLirXmo32RaxR/SVgr3IE/2TomkMvY6/9XlAiIlHUszFlYiI7j5o6xlwQ2OUOTfbbSrqwS5miu2XOZZwJJvoWBILpk3V3FbahU8zaymKjm1IESxehAXVVDxttSrUDmdjVbZYz7ZshQvKC5kVlwUJrzPVZ2zUEaId4IwY0MwWM52wJOPAA/SvHP/i4Gd1d7fBJnCr64US5PShIqJbHqplJiH2LTgBRcPQ4AhKy9uqe8Wg+UX8wXJDlTRD7KpWcL8N9x2aCv+YeccbJv98K4PmfnuHwEDk/L4eowNr+zV0jsoq3/Vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(316002)(356005)(81166007)(82740400003)(36756003)(86362001)(26005)(47076005)(83380400001)(16526019)(2616005)(1076003)(336012)(426003)(478600001)(2906002)(54906003)(6916009)(70586007)(70206006)(7696005)(5660300002)(8936002)(8676002)(4326008)(41300700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:44.1593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2878c543-5ae6-45bc-3737-08dbfd86fe9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
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
index 5a35a8ca8922..7d8c0e13ac12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1144,6 +1144,42 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
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

