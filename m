Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC072C001B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C11710E9CE;
	Fri,  3 Nov 2023 13:12:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38E510E9C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZ2uATStKhfR1WCUiDDN6TolYklCZUqHfJetL1KuGYNwT0M6C91xAFDg0fmlB+BrA9yoeJro9BfyeSV0w/pDnWALucKL86sNm7qyKkV0N3WK/5IyT4FHswVoKuQ6QYdvMHOX7HlcgRwGzT3oyQaJxuZVvvVe+KjGuBSmCHP4bKLu0gmODu+beAaDpySkan81LAmrkbwZV5EIJ2qeWVz7S9M1ErphemFczW1GdNjIRbEUxcFNsZAOOEJNl3JsFd+ZK85UvSxU9tCfeeHYK5jamGpHZ28OMQ7QAYbZWgDFs/Dg0TrZL+9UsakyfNkI1Lo/uc4Kw/h4bvj7E0p/mvFOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STnGfuhXmQU1j9ZEpfbiraoaOOAkSlu8hs0Z6hMf/aQ=;
 b=XwHlNyVDzvUv/O1I04BBmWvP3jQHPbuTTQs9KIcuU1Pst2ic4ii5kaqQzPQ5/TpmuwdljBWeOqA9xyqpVmMcPpG6lGEJ4YFdMDsDurwZPnmDAy6tZdNZ3VpdNvuZ3PtKaFrsQ0s9ABIeG/gK+6GVyHXI+CswIxYXsOfoTwECrDBqfCm6EHCSHEmK/48/ljY5Jn2XOV/EEFqe8HPBnhH0tV9Eg4dERsjYvdhKKxKmu1K4+GLUDjQ3qoTuQE25wYlgo/qcz+phJdEfwPTlpsKSaOrbItgX4IYqhuuG0/2NroCXyg6t/my/xKdU+AOOnrg1UR78V4L3OZM9ofJaEF9Q/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STnGfuhXmQU1j9ZEpfbiraoaOOAkSlu8hs0Z6hMf/aQ=;
 b=exbMqLiijpxFZi2uYhvOuHz/zZL+/EHWyJJj6rhL7ctnNeS2eQGe/R4zMZ+jGu4pt9x50d+JZAAgCU8Nu2gS9T+Gon+mzjmN9xGDMmV5hgT2PmiEuNjwcw+bxM0wM5QAxhOE0JtrpdQpmyTtWw2MNiTsa1HJKCwTHvHVLM5r2yw=
Received: from DS7PR03CA0118.namprd03.prod.outlook.com (2603:10b6:5:3b7::33)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 13:12:08 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::75) by DS7PR03CA0118.outlook.office365.com
 (2603:10b6:5:3b7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:07 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:04 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/24] drm/amdgpu: add sq host trap status check
Date: Fri, 3 Nov 2023 09:11:28 -0400
Message-ID: <20231103131139.766920-14-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 510194b6-9fe4-4a7a-4f75-08dbdc6e7b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I13QJ0VTDDOr5QxOTSGLle88F/rkWi1TBmuIjaCTDgejmqZYzlrJ2eHHE1AZPYlnRCNn4dALd2oP+3ISw5hNWxEm3ZFrz49SRp9lMPZJ9KzijzmXOmYpF6ogfc45Lo0GMv8lPmREIWHn5FWx/3hGbOTfbYO91tfC0OdWrTyDuT/jCs7/oek2dkipPaL7SSXpDf4K9+PrRaPLzUaGyShfYlmgEnpIMq31ybuWqlapCM45n+1iqwaxC9MBiEUEpBytZtVHOo4vCduxfi+sq6mlfNqQ57m9pdkNZmBtTL/RywburqBhSoBMtr/S/sLAcBJ4RmIRPb7EUG91LSldqFnRIuKdbYgjHl0geqMM2CAngpvDvvIrWOBRI5dqAWPwe79Glettr/4ZWPzq0YKxdoiH1c/o3ET72HeTJB+WHWGejJkLRwpTOolXK7UJYq+jdsO/zfZLQ17PkWlQnq0NBj2wvu4bYTSFl05PtUzI1DbW2DW7/VXrKS8zoABo9rDn8boaEzkJci1TlwAopZZc0icubVDNI1d/w+/QSW9uokXHzB0TRBbeCQn8YTVVAULrq3UJcZyMxQWS7mhq5S5tIioNep3FdqYixC4drsEt8lCBYIuXmcP6jAMuEdc7rM6RDYtBnujToenW2KLHnKO60oqeVayB/lpDqUULmhVsOUjkYLdmnEuzHbciGljNPAVlEig9/jExoAZ3ShhouYLGZzJtmVeWmOIYKGDq2Aox9CGBVlgJez5jPWNy9QqZZk+LPtwoUyciDr2Llvoh0zluRH1yyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(2616005)(1076003)(82740400003)(16526019)(336012)(426003)(54906003)(6916009)(70586007)(70206006)(316002)(4326008)(8936002)(8676002)(6666004)(7696005)(478600001)(36860700001)(83380400001)(81166007)(47076005)(356005)(41300700001)(2906002)(26005)(86362001)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:07.9047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510194b6-9fe4-4a7a-4f75-08dbdc6e7b8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

Before fire a new host trap, check the host trap status.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 35 +++++++++++++++++++
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |  2 ++
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |  5 +++
 3 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 740d8a0c9252..2c5bbbb7e34e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1146,6 +1146,35 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
+static uint32_t kgd_aldebaran_get_hosttrap_status(struct amdgpu_device *adev)
+{
+	uint32_t sq_hosttrap_status;
+	int i, j;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
+		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff, 0);
+			sq_hosttrap_status = RREG32_SOC15(GC, 0, mmSQ_HOSTTRAP_STATUS);
+
+			if (sq_hosttrap_status & SQ_HOSTTRAP_STATUS__HTPENDING_OVERRIDE_MASK) {
+				WREG32_SOC15(GC, 0, mmSQ_HOSTTRAP_STATUS,
+					SQ_HOSTTRAP_STATUS__HTPENDING_OVERRIDE_MASK);
+				sq_hosttrap_status = 0x0;
+				continue;
+			}
+			if (sq_hosttrap_status)
+				goto out;
+		}
+	}
+
+out:
+	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return sq_hosttrap_status;
+}
+
 uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
 					    uint32_t vmid,
 					    uint32_t max_wave_slot,
@@ -1156,6 +1185,12 @@ uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
 {
 	if (method == KFD_IOCTL_PCS_METHOD_HOSTTRAP) {
 		uint32_t value = 0;
+		uint32_t sq_hosttrap_status;
+
+		sq_hosttrap_status = kgd_aldebaran_get_hosttrap_status(adev);
+		/* skip when last host trap request is still pending to complete */
+		if (sq_hosttrap_status)
+			return 0;
 
 		value = REG_SET_FIELD(value, SQ_CMD, CMD, SQ_IND_CMD_CMD_TRAP);
 		value = REG_SET_FIELD(value, SQ_CMD, MODE, SQ_IND_CMD_MODE_SINGLE);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
index 12d451e5475b..5b17d9066452 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
@@ -462,6 +462,8 @@
 #define mmSQ_IND_DATA_BASE_IDX                                                                         0
 #define mmSQ_CMD                                                                                       0x037b
 #define mmSQ_CMD_BASE_IDX                                                                              0
+#define mmSQ_HOSTTRAP_STATUS                                                                           0x0376
+#define mmSQ_HOSTTRAP_STATUS_BASE_IDX                                                                  0
 #define mmSQ_TIME_HI                                                                                   0x037c
 #define mmSQ_TIME_HI_BASE_IDX                                                                          0
 #define mmSQ_TIME_LO                                                                                   0x037d
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
index efc16ddf274a..3dfe4ab31421 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
@@ -2616,6 +2616,11 @@
 //SQ_CMD_TIMESTAMP
 #define SQ_CMD_TIMESTAMP__TIMESTAMP__SHIFT                                                                    0x0
 #define SQ_CMD_TIMESTAMP__TIMESTAMP_MASK                                                                      0x000000FFL
+//SQ_HOSTTRAP_STATUS
+#define SQ_HOSTTRAP_STATUS__HTPENDINGCOUNT__SHIFT                                                             0x0
+#define SQ_HOSTTRAP_STATUS__HTPENDING_OVERRIDE__SHIFT                                                         0x8
+#define SQ_HOSTTRAP_STATUS__HTPENDINGCOUNT_MASK                                                               0x000000FFL
+#define SQ_HOSTTRAP_STATUS__HTPENDING_OVERRIDE_MASK                                                           0x00000100L
 //SQ_IND_INDEX
 #define SQ_IND_INDEX__WAVE_ID__SHIFT                                                                          0x0
 #define SQ_IND_INDEX__SIMD_ID__SHIFT                                                                          0x4
-- 
2.25.1

