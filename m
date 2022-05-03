Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4678DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F30F10EA37;
	Tue,  3 May 2022 20:09:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C59B910EA21
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9erahB7Qf/XS0RIYKZkD5ufemc6nHGxk6s+TNrOJcBeQs1ljZ6LuhOpffy1IkgvmpGLcxzJmBIXv41SygECcxphbvG+JO1sSDLfr6RysmgLnU4USB1puXQCFMW6R5fnNEK9IbXTEQrJ8i2vkoIlTTcn6040J1xsTHjMCKdQHBcOdpJDn4XCyZZG1vyJ4sU2sypGUsIhUhB2PqpUqu0vSOpQFgD9369tou50sujMJRzI4IZxSgvg8poj/kjRJ4d0QOkVYgGIrFlGZ/qPJpWNTSvQ9y+4e+YQhgLbR62Llj/QBpM7yIx/2zx3dV2MMCm+N50Mzy5PQfmYa+cN4vTusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1KGkngoV6ZycLjy7YE+JTpjaVA2hiYCHELQThOXvKo=;
 b=dMhVM40QVNhCDfzPui1q47RnzN3IfUXpqogqWyD8sXJRcGfNd9O0xjWm3iCKwETEouJ7rShSoEcJTy3WlE3XrHQ9RmYzr39u/jFheBxWJeSUfZ+9j02Qw6lo9me+xDgr/Y9Nytoyy2ZgJ5e2e7KVnIgLBjTvBwzlQ6bP7KcT4Dmbp9mK/0hHsoMhQidiD3mNmhFQO8ED7LgA4Sw3JKQ/Bw9hmovTa8QXAI/Hc+YKH9U0EsBmYjLCuYIOJRupH8aUfwV9oWRUctVDPUnZiavc2lfgegYpseKrx8OyWLRzIrZET1RDNXhHuF2xGIzasqn2+BZWvSz9qx+TeajiHs0UEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1KGkngoV6ZycLjy7YE+JTpjaVA2hiYCHELQThOXvKo=;
 b=BV5nJg6lzQJOcwLqV4Ca6YnNGp9capCkfbutU8vwyeWA08YJ9CxPSoJpyeU3EvxfKADdAhjRziKnObkUd6ogw8E8CLL0wpDUzzF8N0XBXO4vuaB53WKNp4OmpQM5ecZxEn1Hf+P5LM1TfeszAAAeDWj2BHT1sMiL+pYRBcSyn2A=
Received: from DM6PR07CA0070.namprd07.prod.outlook.com (2603:10b6:5:74::47) by
 BN6PR12MB1633.namprd12.prod.outlook.com (2603:10b6:405:5::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:09:18 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::fe) by DM6PR07CA0070.outlook.office365.com
 (2603:10b6:5:74::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 20:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable MGCG and LS for MMHUB 3.0
Date: Tue, 3 May 2022 16:08:44 -0400
Message-ID: <20220503200855.1163186-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e0aceaa-c19a-42d7-030a-08da2d40ce1f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1633:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16337E30266BC227D321DC46F7C09@BN6PR12MB1633.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYq8vTYjkfTNb/z0YXXuCONalt6TFsfU3vuSjbr6FLZHkdfwD+o8JSiHbfJZRi8oeslbVllIsFrPnzkZpySY1pmmkZyZHLAex/qqwm9Fylvb5v1OiC3NxHuCVNAejBgiGuAU9Wvd6jn8/jsdWWmAtuE9l8BPxhNrsSqQh0TUCwvbLSpRSvjbgwQ2/ieTcGP2KN7QNCyM0WtfQ3kBZ4q+wh5Fob7f4sAWlEVXAVMt7FigPYaEkDm/8nX83RKtUdw3mzHPDOiFVxEAjzomoVUL53EUh1iC+ptTgZ8l4UYPYtqhjX3O7iplywmrP14v/cOwUJMOAj2yWImYmvtRoUwndigPsPb/5OAnf8QPze71GetHFNxyJXZbUHPvsPEb7Oa3CMBqT51qORc4KOZhbdLHt/i2SeeAjiUBEawT5HzhdBxAkTEate0xTI80n9EYvfvyk+++Q1/g5KNFFwlJIthktm075YTMWXPWOHWzCDiHMO/3PstewOLWi1S1uvvfN/d/TWC4l2x2y6bSyKwac+2uid2sSt13ZorWvd4BlQ2JYlIQ7I1f/sE4tAUn+qFgNR8A3tnL1Zu/YY8AGD4LtWJVQv1RHThgfMljHlBa41ZIrU2pEm4jtZH2mQw5uebApRSO6fQBgpIS/Du3iH6DQKbEho0oEw1WeZ+bZ+/ekqHx4bdFLaTVW76C+I2kEzU8yn5oDpNQVoib9Q3Lp4rdcstyOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(5660300002)(2906002)(83380400001)(86362001)(6666004)(356005)(40460700003)(316002)(36756003)(81166007)(82310400005)(36860700001)(6916009)(336012)(7696005)(47076005)(426003)(16526019)(2616005)(186003)(26005)(8936002)(8676002)(4326008)(70586007)(70206006)(1076003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:18.4548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0aceaa-c19a-42d7-030a-08da2d40ce1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1633
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable MMHUB 3.0 MGCG and LS features.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c | 96 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/soc21.c      |  4 +-
 2 files changed, 92 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 08a85a0cd334..682d7842aea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -538,13 +538,78 @@ static u64 mmhub_v3_0_get_mc_fb_offset(struct amdgpu_device *adev)
 static void mmhub_v3_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 							bool enable)
 {
-	//TODO
+	uint32_t def, data;
+#if 0
+	uint32_t def1, data1, def2 = 0, data2 = 0;
+#endif
+
+	def  = data  = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+#if 0
+	def1 = data1 = RREG32_SOC15(MMHUB, 0, regDAGB0_CNTL_MISC2);
+	def2 = data2 = RREG32_SOC15(MMHUB, 0, regDAGB1_CNTL_MISC2);
+#endif
+
+	if (enable) {
+		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
+#if 0
+		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+
+		data2 &= ~(DAGB1_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+#endif
+	} else {
+		data &= ~MM_ATC_L2_MISC_CG__ENABLE_MASK;
+#if 0
+		data1 |= (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+
+		data2 |= (DAGB1_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+#endif
+	}
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG, data);
+#if 0
+	if (def1 != data1)
+		WREG32_SOC15(MMHUB, 0, regDAGB0_CNTL_MISC2, data1);
+
+	if (def2 != data2)
+		WREG32_SOC15(MMHUB, 0, regDAGB1_CNTL_MISC2, data2);
+#endif
 }
 
 static void mmhub_v3_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
 						       bool enable)
 {
-	//TODO
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+
+	if (enable)
+		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+	else
+		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG, data);
 }
 
 static int mmhub_v3_0_set_clockgating(struct amdgpu_device *adev,
@@ -553,16 +618,33 @@ static int mmhub_v3_0_set_clockgating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	mmhub_v3_0_update_medium_grain_clock_gating(adev,
-			state == AMD_CG_STATE_GATE);
-	mmhub_v3_0_update_medium_grain_light_sleep(adev,
-			state == AMD_CG_STATE_GATE);
+	if (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)
+		mmhub_v3_0_update_medium_grain_clock_gating(adev,
+				state == AMD_CG_STATE_GATE);
+
+	if (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)
+		mmhub_v3_0_update_medium_grain_light_sleep(adev,
+				state == AMD_CG_STATE_GATE);
+
 	return 0;
 }
 
 static void mmhub_v3_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
-	//TODO
+	int data;
+
+	if (amdgpu_sriov_vf(adev))
+		*flags = 0;
+
+	data = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+
+	/* AMD_CG_SUPPORT_MC_MGCG */
+	if (data & MM_ATC_L2_MISC_CG__ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_MGCG;
+
+	/* AMD_CG_SUPPORT_MC_LS */
+	if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_LS;
 }
 
 const struct amdgpu_mmhub_funcs mmhub_v3_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 815b9cc8f9ff..2497e2f8b118 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -535,7 +535,9 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG |
 			AMD_CG_SUPPORT_ATHUB_MGCG |
-			AMD_CG_SUPPORT_ATHUB_LS;
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.35.1

