Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78F5C2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 16:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D7010E432;
	Mon, 20 Nov 2023 16:16:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B34C10E089
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 16:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeqVQD/r+VCl8lK1xz9lgTXGk1Aep/RTrQe3yuWOGqhDwjOM8orw8B3n+ffejLrrlMIi0NauG4Jmjkiz6fISoI/ST7NHZ71uiUlrMJF0xgYOoGFs6wRh+V1PsIwJR83Gs6wkSXdGZDRKrzpPt4pliXrlXUIGpxhXLjjjIuuW1E5oiD0aA1byYfliI0UO/Z/I7T8vwV4fIFObuAyMsmeN+nOO2UpCSByQ3u71FIw1YUC5AsdNyZnpeE8nOu7AU3jRzLrE9VWjvTmNm93hVW2G1TPl4xdBEhqmdIqYxIKkApRouqKKA89RYIwH/utmnHNf560v8wmWKxIWmsx9IkniAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Shu29LmOvuXJwnHV/MA1kgA1/T53TBz7sXprzidDs2o=;
 b=DdMfJ1YhNxl9E/qtUK4ndh2W7XH8yTbWGCC8edc3YR31+0UXsqxkg0faWfWM6YuxyiCcfRdN75/BEglF46v9zZPXmHb5EZAKXCukPW9TB7uPKtLcJVhJ95O5cMcVfFR7mlajT3qLJ+2XAckbIsv5Vis8ewitEq+pDGwSlfdae/jhbP5Ji0KlqAlI/MIsdRk8kUGM0/CUoXtTwL5K7wAyXq5AFVWOAnoUMD3RVHlEKiGQYvOUaDyDbg0u8uEhZryKDu3R9sIl6ROnhzhIsnxuk/hDDd1RJLptlEzn45J5ZlGCPqEZYAwwrLtSlW2deCkvRj4KiaKIjuQmpYIlXMwf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shu29LmOvuXJwnHV/MA1kgA1/T53TBz7sXprzidDs2o=;
 b=3JsCTnDcmGOvaLX9PK79idl3fH4aU2CHqTGSb5TmKq49hl4w6Rc3zT/hwlZLbGWHFG/3srrCPtXGWVukFp6eUDkEqNyFlkVpTYOb3njec6Og1vYQNUaQV1SDsjoqRq607qbOJ34IE1AmzTIo4Zr0lwfokqAZIYXIteUH/Xz2ClI=
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:16:26 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::c4) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 16:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 16:16:25 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 10:16:24 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 13/24] drm/amdgpu: add sq host trap status check
Date: Mon, 20 Nov 2023 11:16:15 -0500
Message-ID: <20231120161615.2544829-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-14-James.Zhu@amd.com>
References: <20231103131139.766920-14-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ee24a9-dcc5-40e3-337d-08dbe9e40b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GSAKXAeniTW0vxFxe1fHxPRBcj/05SAoffK0NEN3p5RtcoEJrwuP5kBTf1/UCz+TLZo3aznZ1sJPs68g8SGddPGysTKwhXwkudHpmJ0ZnFDDFyRKbVoIKGDSck8DsIOXI34c/Mopgc2Zzi5iImJUC2OCpbIaCmXq+NE6kfHj8U7qAvpOZKobA7hOH9sXm7hdAMNSVgN785w8JoClW4bsAGY4/syioMtqINpRaPV3+Zg24D7ghj6cyBVPhRG5r6kKnIoJ9eFyKTu6IH109CqeXimB3UvGE729GAO7seKUVgLtXnRT3LGZezU5PVdJqRPQlK85MRBbtnVSiqLG90YhGojdw760NjhtBDAROouK+sFdw1yu/0FnLARlMuNwJfHLXQhSFl6ZRS5f9RQKjkOQ0Jo3/0d0CpJxpAFCJAd/4rpN2Kss4/aZlibUNSWgifJDTxJKZyMdfT0E3MHZp+EeSi0n2FNQw+sAN8qe1umHV+HEXt+yaXWX3gzfGg/+1clkBiLDOrj8eguETNggG1B3mcz5nZnpM2Gu/DAkne7gP/pSwt1vRzscnLxYDEliS8+8iCq7De0j0mxS4UvvrAi2pjPB6SKS8Yh3tnAOn4vn1u6IKmIEC6TerzQUrJFTuGn2cr4Dv3iF2SC0eV3NVcYNQ1MAIfn+X1jpuXgKGi6qonBnVUaMJSLLhOhB6zFTqiM4yJUDiQHgBD7IwAdUxL2S2+LNOsqkvZsN2FDxsfJcQqoIlCjGxgu7RGTyri2bbxi3wASWlqGKXwweVbsDrf5NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(54906003)(70206006)(70586007)(36756003)(82740400003)(81166007)(356005)(86362001)(36860700001)(336012)(83380400001)(16526019)(26005)(1076003)(7696005)(2616005)(6666004)(2906002)(426003)(6916009)(316002)(478600001)(8676002)(4326008)(5660300002)(47076005)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:16:25.7183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ee24a9-dcc5-40e3-337d-08dbe9e40b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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
index 423611904eaf..89157130e476 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1146,6 +1146,35 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
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
@@ -1156,6 +1185,12 @@ uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
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

