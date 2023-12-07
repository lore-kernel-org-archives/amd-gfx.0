Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120FEC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE87710E0DE;
	Thu,  7 Dec 2023 22:54:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A9110E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvcm6S9lu2GCiY6ZqA3prHfUZhmLDSr6MhymRQwPuGCotaRfLSUYt8fLp3/YhFfdg+BvVcSJ8yEhPLJmvcMYbudIdyOwP4sIwPp9uc3RMxIfwqsMaPJwF8qiheiBoBw71LZbM+Ir8LxJfiP/Lu7BPTSvHjt96kOdr34yYIpCNhF6ZIgR2io8y5jC9BotOZuN7jQ4z+0vJips8IHNqfSQnVuVZ/ccoSuKgZyL2GVF03/SjDafl+rGYxdic8snW4xsUT+d1uhXb1hfJHIKpNxYvnWdpGSXNnZR93/8+n04VvaLHb9x8XGTCp9WJsZYW90C64Ur6v5VFkwQzzfnN/jqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmlhLimzIk9uebLFrJB7EVqNgvOg1iCy3jLa2NPtDAI=;
 b=L+cjkQApGk3Y8ArWBugvtqieF6aG/NKGWYtskC198whI7swYK+4LnRvBD9ojYAxFz2iv3M7qkN+eWH//m6SiwXVUvAe6udMpINRGrXWvefxH/GaBT0T9UqPf+DwjKhybrSIWB097XBme3Aa6TgUCPYZz2JT4ASTMuctoi8APG/DOMlDswWY73m+jDkNBInToPiMO76aFiVTyp7dKf7mlzqtoHtUd3PaLVv5SyTgSDwwW0hsMq4QoymasCMQVzLvcuVyYfWN24rEaxS4Ebt5L8lf2ocLBzBY73WgI6mpTjWWFKgEk+5KT5d+iRkwR/aeoI1KKMonyVfIHxkGIKzEK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmlhLimzIk9uebLFrJB7EVqNgvOg1iCy3jLa2NPtDAI=;
 b=x1dpuvnAj5DgFRxlg33lavAc4YUpQrxhKnYe4UHl+RHVQcHGEJu9qzYu4EnE4r2xwwpBcbF7Uxjen6q34e6nKmOP/Cg0ziv+wCIv8GSMB7xlWynmDAFuoIpI62NAhyMQ5QFkdWnNdvOC4RhoiU062ogyylzkIALWQa+KZs4qJ3E=
Received: from CH2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:610:58::15)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:42 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::42) by CH2PR20CA0005.outlook.office365.com
 (2603:10b6:610:58::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:41 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:40 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/23] drm/amdkfd: trigger pc sampling trap for gfx v9
Date: Thu, 7 Dec 2023 17:54:09 -0500
Message-ID: <20231207225422.4057292-11-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: ee07672e-12b6-4b64-048e-08dbf7777fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vrdcvcw9CUe24192OhoJEXVWFp4CC3hKJlV4KL7hFFQfgOYVudNIvEnWZN8ayjRKEmn1Vb0MqaJrsZnCEHEVXMKWnaTMeXy8FANsft8tkARjTDp5zGSJH/qI3oENW+ZKHcMuOqsq/RtzlJjQAgB68kXcAasZmYlJgl9Ez2AjEI/Hz3XxG5UVD4Lq16i/emVqQIiYsSwdbtB7SdpSQocHwKPdmv/yOoGTMtvBN9bdjnezDLvpMMM/MolXS2EA607CzCUQ1SLwasWVktkOWJQ8VLvqs3S+ifJNjVHv1Z6s6lENMZx2TWQuqNU2G2oktqZqnOzPgF3NzpUHCN63t4QU2kzCGC5gHcFGxOO85NfHqysTDzfpuW+X21RpgPiEduqeAB9RdA94oD5/q+GFM+oL4ttbAdVNPI/Akp/ALV2iqj9qBnJZv8x88OAimjrp6PXNYVZKmAxwy9OAs3AFIdcnzpH6l0KwoLtH1Q24PiPZmEfEr9Y6Fzx9CT23PkAztQRHg41nJ4B/mvLJGUuP0l31KB2KCgw6iapTqf4T9B4/9wpfK9m+vUnHFjHHO5ngDN9/8rB38VkIf68ZZ90ICo4eyIrcw+y6kbcxY3bqvXCkBo6qDNqXw2MMemT2zSY5uxLJOh0vxstA85jVhGIABX0bjhxlOCfmYjtsEd3QWBncHw0I+6wAoSlqe7T/Jh3KEE/LPl56zj+chN56XoMo8CKY2VwW4Y5ZmT4t26SkI0QSO8BuCL5rvSoe1EeyDqn+/8GLKo7Kbf+MMF/p1FkWOBbywg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(426003)(7696005)(83380400001)(82740400003)(16526019)(336012)(26005)(478600001)(6666004)(1076003)(40480700001)(2616005)(8676002)(54906003)(8936002)(70206006)(70586007)(6916009)(316002)(4326008)(36860700001)(81166007)(356005)(47076005)(5660300002)(40460700003)(2906002)(41300700001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:41.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee07672e-12b6-4b64-048e-08dbf7777fb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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

