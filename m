Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BBAC4829B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953DD11256F;
	Tue,  6 Feb 2024 15:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yUvrQme6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F4A112610
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCqPb47/Z3j9q7gnD3/VwQlXCOMPtLjl3Omu3bNkjqQqCOweDDz6HkxeW7UthrA0wxlmlFlODosAyidtE+R11qylSxzaCxker/p8pW5EZ3gOYhyzvQRc422pqQGcw6OBz1PM/hkwL91BKLhyIvyR7x2w6ScvUkCLQYRrGi4XU+UDRRj09R+MT3GwVRzXKiY5Yg1Z8rs/yFdnkUUefho5UUkiTtImMpXS1OIM4sQngolvaSbKUW6OgLw2X8L63s7y2XXyxm72ZtflcYGv373ybckJIbAXbu21LOrFkrxrJkm/QW37z1E1K7JowwqxU+PfAAbNZXH4hDiylV5PFDOjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDGl9xNGO/7pCATkr/ZY9X4l7Njo22Wt8Lc43zXkny8=;
 b=aramTLZBmq6DrnnCTQN8Xh1iwnDgdX3ThF63j9PPDQAAr9n/4neV5cKwMkuoAubP5UZ8LL/y7jMWlpx9RRPWLMnMJAFUsSOFSTygm1/hjQgInxWAp6+HsP4ALb+BV0OTkP6cHFOLakFrrE5SJYFG/zYlVdwNngL6zQQ04l8p+mnDxNg5i67lO+GA7peFRuEbT0wEcqt7f8Lj7lNq9V7vffZ2MlnlUM0MpzjqMKh0f3su3R2FkTwJ/ujNyZPgtRqB0gNiaCti0xl2x12DyNwK7mBhnRXb/pqWYLNzrJ8zxG7hp3B77c/Q348vgMO3nPANwfDO8MrfttKzB974lY0x5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDGl9xNGO/7pCATkr/ZY9X4l7Njo22Wt8Lc43zXkny8=;
 b=yUvrQme6TxhMCLDe7rey8Lfbxdx/DwZQ+wwoz4izh8s7c6bRPL19F0q2S5eQK6e8yGVMXnjZJoKRCxR9ZIzfw7pXWDqC99NXnl0GupdNIrT9PkaA/oDDMDwxZWUc399vQ/Xvxzgg+lBTPIXTHPC2XOh1E57m8gbCsaUtMZK9RiE=
Received: from BY3PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:217::33)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 15:59:42 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::f0) by BY3PR04CA0028.outlook.office365.com
 (2603:10b6:a03:217::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:42 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:37 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 13/24] drm/amdgpu: add sq host trap status check
Date: Tue, 6 Feb 2024 10:59:09 -0500
Message-ID: <20240206155920.3171418-14-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f03f265-adbf-4768-6e2c-08dc272ca180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1W/oloe4e6ydB5O7Dp3Wfe3rBcXjq81wQRLLhfX6we8zXVBnKbsrlPaXBQZfQM/kHy0uAvo2T2/0nVbz4yqL46gIbbcoA3axz5ZVFpiHGQeb5XKyhiz5B7J3uusOnBaggM39Gyjj2lVGQRRRNVsQDOdvxUhKQjE4jX/IOw5InEMD8L9QIdJLVeSFkrhjeUPBn+l7NeOq+1KyDeBwQAhCSektYfD75SdvbPblgB+vTNSJBdASVWIPslxbg6VDmf0zF3hvnqCmXSJSJlDg7p/oMqISA8jBvHKEn5Wd7xqTVjrIAdfBML5UBFRt1cpwxn6myJnsue1dRyg60PigWLSwFtCV6t/Ggl2z34WrtsuCZpU9WsjPVkTd78kzsluCibjqnsC8SaSESCxZIVl/AiPZoJkQexduTBbsKFtlYd9DdCe+c8Bon2EC+IIqsxbZ6IIUKhCVBHmPECiClxKJpH8hAXxT2/1PajYy992M+x6K/c35unxYi8sZGWCDsA274vmNLuWdaSP+qQh2JAd7rfd9l+yR5KutOUgqf13qqLoX2QYSoTr2yTA4mYfL/XAEonf0WHQdZpfAJ4wPAkJ1wtZlEMsdDYzBmpNLN3ENApMIMrcTtt82xg0uS8aASnSXnbqbZ6b297/zP7TMGeksCGvzw31RBN0ToaoLO8+GcY/JTcyFJ3yWM2UlrvbZkWmHkpj1sC6jMi90WYQLJYml8NbAZvIXoATdFbRTWCN7WxuMfNi95/XEdb70R7aRVr9lbQaggNzuR96o8gJ3aSUqd+UWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(26005)(336012)(47076005)(426003)(1076003)(8676002)(2616005)(16526019)(8936002)(5660300002)(4326008)(2906002)(6916009)(54906003)(316002)(36756003)(70206006)(70586007)(41300700001)(86362001)(40480700001)(478600001)(81166007)(40460700003)(36860700001)(83380400001)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:42.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f03f265-adbf-4768-6e2c-08dc272ca180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

Before fire a new host trap, check the host trap status.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 35 +++++++++++++++++++
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |  2 ++
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |  5 +++
 3 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index adfe5e5585e5..43edd62df5fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1144,6 +1144,35 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
+static uint32_t kgd_aldebaran_get_hosttrap_status(struct amdgpu_device *adev)
+{
+	uint32_t sq_hosttrap_status = 0x0;
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
@@ -1154,6 +1183,12 @@ uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
 {
 	if (method == KFD_IOCTL_PCS_METHOD_HOSTTRAP) {
 		uint32_t value = 0;
+		uint32_t sq_hosttrap_status = 0x0;
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

