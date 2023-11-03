Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3576EC001B5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEA710E9C7;
	Fri,  3 Nov 2023 13:12:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEC910E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzPGUGRD6Ms6inxMPUy9wPjhvsGbXJ9vDfd32QOlPiTLmLMXXM64EpQmhdoxyJLwznSK3qsjUYabGHfB3EZm+heqUVct14r24Y+/NAR8spS5qo7Ixw8zqAP5LYOuMDkpkkk9FGJRvs7imzw4EfliQsMIgzMBg70kfka7YbNo5K2m95lCdXeAggBWnwM/UqQVSGvNdM7b2pnpjXMYxtZKhcGtE2mbmk05UOTVo9DBFPv92ZGV5gXNzO10qadwm25/3o4BH3Wq4dMC4PYARWLhuL6RHlr2pSN/oYMKueWRkHHCHwvgt8z/D3HLTUx2O9klOPeqQGG0hep1N+yqNv3i6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kusQtxDUJOdSgZWq8C7DKx0fRuiJo22juYrH2R57DKo=;
 b=nsVdKuPJk/TSu2kjTyXl4PZxxI7Sbkp21Vwm0mygwqU2WClG5EjwkdXS0/AJGKTVpgojo3HJWGeGpGP9T9zAa4dYccrWxy7rhj2NeF2s9V/MfOXqHstLfN6/CoYBdrXik1RrDRAUgEptkVi0q6DQkvT2kSR7KMQ4S8E/hzS1Zz+2hZSBwUvTOM7CARSUI+1dRqwWqvNLAFZcOS6A0xMST3xSYZ/tQBCyLQjwtTCFmsNoNaUvMyHcSAhgcHsDGt8ZRKxCTZvfzNXl4pf4Tpo0ITicuXZ/EZ9hwU+AwLOKPX1KniLBqJ6bWifDbpYAXejfjqRcT4WZxnbHZcqGvaXzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kusQtxDUJOdSgZWq8C7DKx0fRuiJo22juYrH2R57DKo=;
 b=P/YhoTcOwvJvu/ope5PWZxqrV4KVvbnLUPfKCGxiJgzdLQ2XbinYUFbXpDBmzDgc1z0Beqp98d4JdSQssoAjsSPZqXPtgLg++LojzHEn4RXX2KOIPFn56JNbLy91NBQ+JKjbJzAObU0rr4ewVyHN1bF/BzlaltdsPTqeXP0fPIs=
Received: from DS7PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:3b7::16)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:05 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::1a) by DS7PR03CA0101.outlook.office365.com
 (2603:10b6:5:3b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:05 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:02 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/24] drm/amdkfd: trigger pc sampling trap for gfx v9
Date: Fri, 3 Nov 2023 09:11:25 -0400
Message-ID: <20231103131139.766920-11-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DM4PR12MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: 8687dc9d-c6b0-49ef-723a-08dbdc6e7a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HO2Wjqe8rw7qoloEkKVv7tIVqbq3+QpEFbRSLEUn+KSdzQJP9LT0pPMMXfNMsgNiGReR3h4+88dp2hguB7IddfMyttwKRPrGGnYh+/DPXqCtgf5P/W/oNgKZheucwaTvCFXrez2SykdN9+16bW3Z4rRewYOd/2l5blgcWBv4e5oHsmt6Yaj+TGZ4yXJcOWJXNuZqJzbgOgW+woG6t06rklfb11QgA0bGUR9Dspa/j9cCYkGS/+53QtFQcVT/eHFnTaTJaM1nWskw1zXa79rpEdYZbYN8Fz4MwS+TYND6jiU/DSurhEF8MM78RyZWQPPiYMWWobwcwtuHPBudgdgc5FE5nRiuJpmv9CGKWWLzC31MY05J6m+5HJKcRP9QwjT0FKrtHzmaHPu2QawRb/t7SD2WLviBwqMPFCktbPLheaL0equMtf2nlnij14qqarR/LlrbEO10wtyxNIzpWCsg1hZOQCuCJHFtuaZbqAmeIipv+aSaidCjWR/tXWBD8Cfcf7ZzpIQGidxV30sygKhIO1KX1gu3Dv92EVnJoCfyy6r0Tavr/xesE4cmDIEzddNlv6gjyBS36OvFND9i9+vEl5Hi+nE+qCk+kB/zi1A76mCjPdviXQ173Cnet048j9uFuGjZrUlfRzQ92sj1IgC3sPeSpQnuJRYgRRmQ5HAqzvKL7q1N8JA/iYXe1/V7S7pEut4+zQklFInskBSia9NXwud4iHPRNJq0qEVRPitli9bxw1AN7C5N5PwhpX14UjfFd66bNNbBcF8edEuPYjmThQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(16526019)(2616005)(26005)(1076003)(478600001)(336012)(7696005)(6666004)(47076005)(36860700001)(83380400001)(5660300002)(41300700001)(70586007)(70206006)(54906003)(2906002)(8936002)(316002)(6916009)(4326008)(8676002)(36756003)(82740400003)(356005)(81166007)(40480700001)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:05.7954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687dc9d-c6b0-49ef-723a-08dbdc6e7a49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 35 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  7 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51011e8ee90d..723fef2d45d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1146,6 +1146,41 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
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

