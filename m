Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD1AC46CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9FF10EA6C;
	Fri, 15 Dec 2023 16:00:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4AC10EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csfQL55Zujvr+vtCiAKyVIEkvKzjPU4OgxZxriC7JVvQ7EDqA9uJvO+9dJTCYWJEWVGw+3wP3bNbdS6uXxCftMsPHgo/VzhBmIrU0MpTvqCv0u1VQDazpaRqawGjsAEN09FdNFrUPnDptv1xdDW8n297cvLx4pv8mWpiGrI4mxtJ7HfERoBjnIYOt5654W3NKnl68u690jjpgnYFKlyL2ARVckpIGNu3gJqUvgIf/zAsMtUzT37JHy27L87IiGcGwsfcYTQZBPOgpYJ6XJxKQpMQS4eGoHRZQ6x3eTbPI2g6MKa1C5/TMxMVAWe18CuhepgnCbbRbv3pe881o/KQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDGl9xNGO/7pCATkr/ZY9X4l7Njo22Wt8Lc43zXkny8=;
 b=U/d33uicy37tXkP3h9nQqFhLgy3w4WmfrLG/nFLf7WxKhFsFwhHJlODiTWxeLxAF2n8zU/MYR3kEJIHagi8wnNnbq42GrQp0MKpVHc5FQu4FhAjnj896xq46vVJjEFItfkmUiLZVQQLdPsgjInFbqqmzNBssmV+0hytGlEBrb+t6+kqnwjnc2LOscZapa2kyMNdP6Wvca36T+QwI4ebikQgUkv4Co7oMbMJsD0jQE+lqoFgVcTKTUJeApfBZcYaPkFsYDZkihSd9W8vUxH/dTdfuyUKwli7fAPJrnglOBbrDGJcpX7xH/UxDOXsaiTSneqZSFv7ZFTWaaMQ8+r2zEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDGl9xNGO/7pCATkr/ZY9X4l7Njo22Wt8Lc43zXkny8=;
 b=oxuz4d7+tBps1rG7FGs3OQk16ylC4f0/bJ/sfZ4pEts7EiQlsG0mJ7I8lGx5l67o/YRhaYMp9HGdI6ZVRNGgRqy95Y0YE4xqYwHQ2HRW08WN+mHBFHr7GkrLVSlxAG059oB3EIGQFwdeHx+cMFznHlm7RhlMEgsDr/0ngK03kaA=
Received: from SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::35)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:00:45 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::e0) by SA9P223CA0030.outlook.office365.com
 (2603:10b6:806:26::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:41 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 13/24] drm/amdgpu: add sq host trap status check
Date: Fri, 15 Dec 2023 10:59:40 -0500
Message-ID: <20231215155951.811884-14-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d8b610-7786-4338-bf46-08dbfd86ff16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WU/i7PrQl5UOke9rklSkrQRMM2nopUCL7eMZBjqY/hhwGKtxgSbNQtC+GfyMwNTgX3eEd/qs9Lfwdj4dep1mSVHA8fyl4WFFH0BPd+slqOPDefbYi08BHMzLGVLIl10PMgauU7ODqpI3AivyA6crNw6qDVcHzEkJqQcNYGoEhvkXQr1xoeLrURdStrPz/28GG8MVsLyOgILLJbgeCEAftS6LbEsDrPARfKkbxJyoN36Ugi21QmAPup2mSPUK82FtT0i3lVMPJMc4VQ0qYyK9wtliAXmZqD9Ku6ta235yKSTb4zTJJ1ZfbXE+2ywex86EUdbjMqSwK0k57heozRmz6eHZVAQ2M+djPM8xAvKudWO4fIM8E1kcShAv0ttAo/e8aZRvFL+/TIe9JxoTgCs9fXA8g9jjkrx0fIg6hdV68T4XDGRz+Palm25u0qZImvLhtjz8KxOe3s35vcA++lYt05qo3dP+u97FSoSoCMSgKWZ68Ji3s28c1dNvtCzWyOrV1EqFhi1sqxdYrqWjv1WmnGk4awjggktMDuvuxHooPyk6Y6H52qisTZImReukO87jrdGU2SU1WLYp3SjeAJa9MmKUMcihftRpscZ+aMxB0lEZfJDY/Qm2K8i2QlrCk5keYoJcKnqHj0qHF00OP7aIrrAYu8itTlMTyqJ9Ruk/bygKR7TvcjxQgq7wh4yDPHtYOyKAe3gkN0U/EgoRlRTcXMq7xxRLfaHo5Z+Pt5Nta5rUfdj4VkjwLP2AZv22gE5K+AtKjicscprCdZe1amc9Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(36756003)(5660300002)(83380400001)(336012)(426003)(16526019)(1076003)(7696005)(26005)(2616005)(478600001)(6916009)(54906003)(70206006)(70586007)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:44.9714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d8b610-7786-4338-bf46-08dbfd86ff16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

