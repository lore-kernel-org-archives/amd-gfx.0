Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB3BC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8269E10E228;
	Thu,  7 Dec 2023 22:54:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F67610E225
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duqSz7A8+NJRBh/TPNYANIr/YlERe/vGL1gzaflsCkfPXEWZ9iykXnH2+yqTDtPD+R6s2yxYf4KiaylqFnF/zrz+YFyO5in13nSqQizhh4nlkv+xdezCOXSzY4gmGzASoGot8/fXjyVrlsDdwAfsLDTEC8u7r3FHC0+Xd6/PbknhZmkm/8Gkn2UlC/EmF9BO3rOt2s4ujsOyjsrd+1IMWLz5XEWolC/Q548klvqWZS5JSQBQt4ZMqWKbdGkh6GBsar2x0UVwWht6txQbahfmKRbWNADsegNqfprnENooN+Frtp+rL2gEGOKsi4SKfJsYqXF+i09Ui4W0TZvsMSi6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDGl9xNGO/7pCATkr/ZY9X4l7Njo22Wt8Lc43zXkny8=;
 b=JoPfaZJ+Hyn2/wUhIVjk3WUIEYZN1STjCIOxx1A5wStpzSJvDSspT0fHaZLywtu7S6oI2kSVoUMQNthWt+HM5MApNdoOHiINR3NV0uFElJduZD3ENsJi2/+W4YWWr7un5WEVzyhrX/1UcM1xXTNQ3g8w67xzHEs2t37g088l99QCLeiHvsECWoTw+norVgQtpAye8f2eHajmOmW04CHdV4jD9Ht647yMZZZxvZ3JdNGns1RKz0jRnojNj4uhdff6K2tT7xKgBY0NX5fGx8ybTwNjItTZ6gtC6kNCG1C8SXX4Ry/VMg5NY0PozKdy+IMZZkT5Y/J6ZGHKK58APzYvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDGl9xNGO/7pCATkr/ZY9X4l7Njo22Wt8Lc43zXkny8=;
 b=F3uSCMN8ZOehboitns0LRz4J7SCCJmvEoyFBDFwk5lbrz+7SPC0z9eVjbpayHyD3ffFt3akH4C8Y+k7gbTigASmqCPsiqKnNitwOZ9hG3P13fwB+4cYOrh5XgRbmmHNqJqSzDUiJZf5f9quoZI5X9qEBhBAuutCCvnj4qzqLM5o=
Received: from CH2PR20CA0003.namprd20.prod.outlook.com (2603:10b6:610:58::13)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:43 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::99) by CH2PR20CA0003.outlook.office365.com
 (2603:10b6:610:58::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 13/23] drm/amdgpu: add sq host trap status check
Date: Thu, 7 Dec 2023 17:54:12 -0500
Message-ID: <20231207225422.4057292-14-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b3aa97-ef2c-4d08-9557-08dbf77780cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRc048R0SpF88Bn7N9T/rCKy4Kgq+l3Hp1psMze6huUtqoLTud7+qgMf7MEoaj7huA+CsAytkvRQmG8fW6aAsRA+QrHXes4a+JrruONVMcf6iBmJmcSy9TuyzFTrKlbI1pM5E+Lgg3wCsyNS5U38lY7RslfsCWVFik67ShjmbR24A9RXi79tTq4jKsePh5dkLekxJIhvJv1Cyh0niWAggwbTBtzv34fSdN4HMRZIaswVWXt3npDSXk3pCKwVvCK2MVYfG4PcBu/g2L7ayzZv6AiTfCcbOwGX0SuoMeqQGHR+GDlm6f8nV9OnhZBIgsQNSiBHWUQ9V3MgvCX0xLVbuhV2JOQN7drMk7q7hRIVbI84QqB9Cmwng30/ObJD3Q5MDkUj/1iDHawLbP76vrVy0Mxv8QFUAklsAPneeouhPnKosGnSf29iIYb8+yS4tTDcX5wqeeFaJ7VMVYSpHD6Bk9ZEY0ZtEljccns4eQZrZEOrN72zKWHi/7Xhb0pon3MvoXsw/gTbgHX8hlUBVgS/6+RlQvRSGuLrw/CHAiIvxqlJBdZD/AKVElhw+0v+mW4p/4Y079WWlIGQz06T2SJwks1DjUmHsjIwsU5xUlgOvI5kqFVlXXcaULZLGS595LCmDFg+3rLTxlisGWcs2k+GshMA5K/sqll8Y8LHqzjHtjUL8FmVTLa3bg2Bg41r11M1VAksQtV5EcUah1ABwEniELcIbVKGY/H7AwiqmGcu+6G11RyIlD86dhLHV7yi6lZyH3Mbwk8mvqBnKi2NSkMn4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(8936002)(8676002)(4326008)(5660300002)(316002)(54906003)(70206006)(70586007)(40460700003)(47076005)(36860700001)(6916009)(2616005)(1076003)(7696005)(36756003)(26005)(336012)(41300700001)(16526019)(6666004)(478600001)(82740400003)(83380400001)(356005)(81166007)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:43.6401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b3aa97-ef2c-4d08-9557-08dbf77780cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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

