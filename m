Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367CCC10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13BC10E225;
	Thu,  7 Dec 2023 22:54:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E17310E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6XhUefrrbYSA3LKATnM2tEo0i+OSrRVVuwtDYGIVis+p/vo4CtdVjjLFoSp7CcshYul++V6ueIA6SjqJxE4yl7EE6ZzKrtK7AmomLzzbXoG60MAvq/uN24mPIkF1/YOT6kB6MLlxr/7lJt7GaCIyl70Zzl8KVjkvqRrsgEmrHAHcJhUGJMfoUoOF8jhcpPrXGkEVrTg3Z1T5gQwCGdsyFYP0Wh2zcqWc0wFJ+7W32hF/6D7bSv58AJm0l6D9XE0oY7T6TAogGnu5RNiOxwEwZd3L0cz6ecJgHzFXVY+pXhmawsxTuoaD3Lu+gtZL4Lhnlqa/3kea3r8GPldNTVNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yo1o0iUnE3fhPe5bSX8AtOU0Lyzj8VpNCYu+pRwhV8g=;
 b=PZIxOyreAtn37wFnKzzrSoNUYPvh8euGpZoeJioYjR+QYRy1BD8sgaph3Shqgejc/FUfdNES+KqVXC43jg5FQ/ZwpLMf9irTm+RMZFRNHOhwEHTr5+o4nlBgK6ZFoZzL9qSDFy1H4qPq3NvqSFT4+GHdvnO21WYwFA2hwTtfKm5b0fkVldYAmVo18IMdFxHMJpI4vA2z4bkF0s/4HLBiOBGyL5r1I5cL377FmKXOHGYDKllmZMmby+OQPIBrladLkcSFzlLh7mgmQIxhynopHgcXzlNyjlKXcs+DugjhuZOe9Qz/h6sRHkTz6LAHkny0l/McGW/OkohkBBnqxxDZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo1o0iUnE3fhPe5bSX8AtOU0Lyzj8VpNCYu+pRwhV8g=;
 b=GBF9BBgQlCTDKsGhs78tcwDNN0tiwUTfDzGnWNYQcZdurOzURuVGqAzu9zRilyB+ylrGXAid5P4EalZEl8/CnS/IFO9CEq8c2L7sVwGbgFjbPpe8PH2HFrmQdN9x+psiecMdBAVOkFQDxh/Xe+kIR5l86TWr+UmtGrceVhUu3sQ=
Received: from CH2PR20CA0025.namprd20.prod.outlook.com (2603:10b6:610:58::35)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:44 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::bf) by CH2PR20CA0025.outlook.office365.com
 (2603:10b6:610:58::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 14/23] drm/amdkfd: trigger pc sampling trap for arcturus
Date: Thu, 7 Dec 2023 17:54:13 -0500
Message-ID: <20231207225422.4057292-15-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3046a3-1382-4b88-2e9f-08dbf7778128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qfm+fFz3hq/VqGovUcrEy6uVODoLiHp2vZXSegfp5joU2oZB9ZezzfNZRUqfOPdUAAiMOcb74KuskTb6BFEF8WaWsd0feCgdu8QD/OY4JrnuXFSGlm4QYc0kJQyRM1uF3P4u1dLZuK9lAHV0sPEBYIr2zgC8+wJXykMDypOn5BTpDKycwnZvYKHc1HElpNHAukX5ZgGTD1/854gtbuFxOHDbiPDshJuLM/8GMB26GdoR+SeeDjsHt9C43KEVxAbvlzHaWh1j5lkm1bl6bijtzVGlwvgS3Rjruh1xieMGchmjoa0mSyUMXpZCx4Z/mpf4VCutgFsl4xzxPgdufv4uokFR74X6ECkBrPnw+tUBXbx4IteE8HE1gTCdyZmI2AMJDQ8WjPjGwq5nyWfc58Wj5aDEm28TMFdGNKVX/X92NEC+RG9ou7WzzDAhvCro4lHK5YaRj+WEtjNuJhZApwYvI6jHYAQbRwC7P7lKu2oZaaAT0grSwWe2pPqUS4bH0Nkx4dPYqLBo9xiczO9fEwjamY1uPAIqMuRb6aYJrjc4pO5fVQZBAjdbGkRbHg/tbcAMrV18IKPG1jpjnozBAzL0s67MWS7T3aTyVaVaRnAfPSgNSTO7FGo3i0w37NcLBajCQFOZNwMirwREl5NfrvvaEIu+/ReVcGqAMvbkeuJ25T8bhjmOllofXcHP/SJLpBkFEhdjzkRFoWBy5QNRncHtb3y6Ab6cLrju5R/tPQTznqlWRv522KpooHx2Fq+HhB1Dx+6CMJ+u/b/6XyWJxlwXMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(36756003)(5660300002)(2906002)(40460700003)(47076005)(82740400003)(356005)(81166007)(36860700001)(6666004)(7696005)(1076003)(16526019)(26005)(426003)(336012)(40480700001)(2616005)(83380400001)(478600001)(4326008)(8936002)(8676002)(86362001)(316002)(70586007)(70206006)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:44.2339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3046a3-1382-4b88-2e9f-08dbf7778128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

Implement trigger pc sampling trap for arcturus.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 0ba15dcbe4e1..10b362e072a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -390,6 +390,17 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+static uint32_t kgd_arcturus_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 10, 4,
+					target_simd, target_wave_slot, method);
+}
+
 const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -418,5 +429,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.trigger_pc_sample_trap = kgd_arcturus_trigger_pc_sample_trap
 };
-- 
2.25.1

